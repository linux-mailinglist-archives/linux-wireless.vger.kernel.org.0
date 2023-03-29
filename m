Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87996CD288
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2HHH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjC2HHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FB2D57
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073592; x=1711609592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaHNMADn5Uhm+fexsyApr8UeuOnDbyeaz5caLmr/ZuQ=;
  b=WL/ppd/RKEksrDCxgT+I6L6OCq3Dv97Cw4DrhefMXD9oBNIlvWagwtZi
   i9/YRThzBlqQEq466mpMhzCAqrXonja09eIsOr32YhPclyW0GJQIGvCOs
   iaXqocLQ4TasdZAMyxieHTRgxxidV+B8u8GwhD0dBhhiioNZ4aiwmnYL9
   7INFUUk6DMpqfOnd3WS1JQXOfshiExic7gZTSC5o3uCwMQ6KQEqAe/qX5
   4OCa77wFhWHJGa0m3Rto4WcwMMvyUYeZ1ZcStRUw4NsmN6eS38mZj2ybb
   dXmhXDCnrGOBGmddEoGlKrWSAfkSEBvMbQQ6fZ7k232vZhvvXFcMOi3xV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450755"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111217"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111217"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/34] wifi: iwlwifi: mvm: coex: start handling multiple links
Date:   Wed, 29 Mar 2023 10:05:12 +0300
Message-Id: <20230329100039.fe813fd8de5d.I216236717876510e51e4c21c7fac7691925443f1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Iterate all the links here and check which ones are active,
then adjust them accordingly.

This is still wrong as far as the RSSI event is concerned
(calling iwl_mvm_bt_coex_enable_rssi_event) since we call
that now multiple times, which could overwrite the data;
we need to either make that per link or call it only once,
but need to sort out first what the firmware will be doing
for beacon filtering/beacon abort in MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 89 +++++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +
 2 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index daaa173aaed6..5a5b1128e75c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -257,33 +257,35 @@ static void iwl_mvm_bt_coex_tcm_based_ci(struct iwl_mvm *mvm,
 	swap(data->primary, data->secondary);
 }
 
-/* must be called under rcu_read_lock */
-static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
-				      struct ieee80211_vif *vif)
+static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct iwl_bt_iterator_data *data,
+				      unsigned int link_id)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_bt_iterator_data *data = _data;
-	struct iwl_mvm *mvm = data->mvm;
-	struct ieee80211_chanctx_conf *chanctx_conf;
 	/* default smps_mode is AUTOMATIC - only used for client modes */
 	enum ieee80211_smps_mode smps_mode = IEEE80211_SMPS_AUTOMATIC;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 bt_activity_grading, min_ag_for_static_smps;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct iwl_mvm_vif_link_info *link_info;
+	struct ieee80211_bss_conf *link_conf;
 	int ave_rssi;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	switch (vif->type) {
-	case NL80211_IFTYPE_STATION:
-		break;
-	case NL80211_IFTYPE_AP:
-		if (!mvmvif->ap_ibss_active)
-			return;
-		break;
-	default:
+	link_info = mvmvif->link[link_id];
+	if (!link_info)
 		return;
-	}
 
-	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
+	/* This can happen due to races: if we receive the notification
+	 * and have the mutex held, while mac80211 is stuck on our mutex
+	 * in the middle of removing the link.
+	 */
+	if (!link_conf)
+		return;
+
+	chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
 
 	/* If channel context is invalid or not on 2.4GHz .. */
 	if ((!chanctx_conf ||
@@ -291,10 +293,10 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		if (vif->type == NL80211_IFTYPE_STATION) {
 			/* ... relax constraints and disable rssi events */
 			iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_BT_COEX,
-					    smps_mode, 0);
-			iwl_mvm_bt_coex_reduced_txp(mvm,
-						    mvmvif->deflink.ap_sta_id,
+					    smps_mode, link_id);
+			iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id,
 						    false);
+			/* FIXME: should this be per link? */
 			iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
 		}
 		return;
@@ -315,17 +317,18 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (!vif->cfg.assoc)
 		smps_mode = IEEE80211_SMPS_AUTOMATIC;
 
-	if (mvmvif->deflink.phy_ctxt &&
-	    (mvm->last_bt_notif.rrc_status & BIT(mvmvif->deflink.phy_ctxt->id)))
+	if (link_info->phy_ctxt &&
+	    (mvm->last_bt_notif.rrc_status & BIT(link_info->phy_ctxt->id)))
 		smps_mode = IEEE80211_SMPS_AUTOMATIC;
 
 	IWL_DEBUG_COEX(data->mvm,
-		       "mac %d: bt_activity_grading %d smps_req %d\n",
-		       mvmvif->id, bt_activity_grading, smps_mode);
+		       "mac %d link %d: bt_activity_grading %d smps_req %d\n",
+		       mvmvif->id, link_info->fw_link_id,
+		       bt_activity_grading, smps_mode);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_BT_COEX,
-				    smps_mode, 0);
+				    smps_mode, link_id);
 
 	/* low latency is always primary */
 	if (iwl_mvm_vif_low_latency(mvmvif)) {
@@ -354,6 +357,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 			data->secondary = chanctx_conf;
 		}
 
+		/* FIXME: TCM load per interface? or need something per link? */
 		if (data->primary == chanctx_conf)
 			data->primary_load = mvm->tcm.result.load[mvmvif->id];
 		else if (data->secondary == chanctx_conf)
@@ -371,6 +375,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		/* if secondary is not NULL, it might be a GO */
 		data->secondary = chanctx_conf;
 
+	/* FIXME: TCM load per interface? or need something per link? */
 	if (data->primary == chanctx_conf)
 		data->primary_load = mvm->tcm.result.load[mvmvif->id];
 	else if (data->secondary == chanctx_conf)
@@ -385,8 +390,8 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT ||
 	    mvm->cfg->bt_shared_single_ant || !vif->cfg.assoc ||
 	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF) {
-		iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
-					    false);
+		iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id, false);
+		/* FIXME: should this be per link? */
 		iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
 		return;
 	}
@@ -398,11 +403,11 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (!ave_rssi)
 		ave_rssi = -100;
 	if (ave_rssi > -IWL_MVM_BT_COEX_EN_RED_TXP_THRESH) {
-		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
+		if (iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id,
 						true))
 			IWL_ERR(mvm, "Couldn't send BT_CONFIG cmd\n");
 	} else if (ave_rssi < -IWL_MVM_BT_COEX_DIS_RED_TXP_THRESH) {
-		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
+		if (iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id,
 						false))
 			IWL_ERR(mvm, "Couldn't send BT_CONFIG cmd\n");
 	}
@@ -411,6 +416,32 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, true, ave_rssi);
 }
 
+/* must be called under rcu_read_lock */
+static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_bt_iterator_data *data = _data;
+	struct iwl_mvm *mvm = data->mvm;
+	unsigned int link_id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		break;
+	case NL80211_IFTYPE_AP:
+		if (!mvmvif->ap_ibss_active)
+			return;
+		break;
+	default:
+		return;
+	}
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
+}
+
 static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 {
 	struct iwl_bt_iterator_data data = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index cf72b9377411..af31b09c3966 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -296,6 +296,10 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+		return;
+
 	mvmvif->link[link_id]->smps_requests[req_type] = smps_request;
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
 		if (mvmvif->link[link_id]->smps_requests[i] ==
-- 
2.38.1

