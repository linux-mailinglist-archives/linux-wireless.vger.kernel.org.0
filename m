Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BED6CB8FF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjC1IAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjC1IAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBE469A
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990423; x=1711526423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VczzEgs+HMLpQ/Q6kED2oqtQkop9RrLcF2b+zjDOC88=;
  b=RDy2XPcjH1YG/+1mpBvwe2lJpFrR2ZAfKJLaHModhXoDwZk8lQgJD13i
   FRjSf4UrQRh2cWCDWDzZh82dzAahFgLWru4W2Ylih03cy5lX1tgAYN5Uc
   k0KKa1hpTn+9wxrkbGo0UqSZNjTZo44L2aTRg4idm+4soJLFdAbQ425q4
   m9f95dvhSDUUfCE3hq7GCVhXL/L7174hEt57rPJ/sfMpZqD46MWL/ovtu
   gkZf0Spa+WYARnJJKMhUcCFfbBBb0ldRRRqoKV81bAdhi6sP+cP/QcT4b
   Rmk2G63ngEeO2I90ZRyp8TdVlpEcsWzmiiI1+4fwQmBdMLseqKHeSdwLL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958274"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958274"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045320"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045320"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 25/31] wifi: iwlwifi: mvm: adjust internal stations to MLO
Date:   Tue, 28 Mar 2023 10:59:05 +0300
Message-Id: <20230328104949.25b013fd30de.I7f9f5906123acae05040cceec470c9acb07b9d42@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Internal stations are mcast/bcast and sniffer. They need some link
specific data like bss id/phy id. Add link_conf as a parameter.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 21 +++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 40 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  | 15 ++++---
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 950f252c1a5a..c81b92d2e8f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -78,7 +78,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		if (ret)
 			goto out_remove_link;
 
-		ret = iwl_mvm_mld_add_bcast_sta(mvm, vif);
+		ret = iwl_mvm_mld_add_bcast_sta(mvm, vif, &vif->bss_conf);
 		if (ret)
 			goto out_remove_link;
 
@@ -194,7 +194,9 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		mvm->p2p_device_vif = NULL;
-		iwl_mvm_mld_rm_bcast_sta(mvm, vif);
+
+		/* P2P device uses only one link */
+		iwl_mvm_mld_rm_bcast_sta(mvm, vif, &vif->bss_conf);
 		/* Link needs to be deactivated before removal */
 		iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
 				     LINK_CONTEXT_MODIFY_ACTIVE, false);
@@ -255,7 +257,8 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_power_update_mac(mvm);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
-		ret = iwl_mvm_mld_add_snif_sta(mvm, vif);
+		ret = iwl_mvm_mld_add_snif_sta(mvm, vif,
+					       &vif->bss_conf);
 		if (ret)
 			goto deactivate;
 	}
@@ -348,14 +351,14 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		goto out_unlock;
 
-	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif);
+	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif, link_conf);
 	if (ret)
 		goto out_unlock;
 
 	/* Send the bcast station. At this stage the TBTT and DTIM time
 	 * events are added and applied to the scheduler
 	 */
-	ret = iwl_mvm_mld_add_bcast_sta(mvm, vif);
+	ret = iwl_mvm_mld_add_bcast_sta(mvm, vif, link_conf);
 	if (ret)
 		goto out_rm_mcast;
 
@@ -379,9 +382,9 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 out_failed:
 	iwl_mvm_power_update_mac(mvm);
 	mvmvif->ap_ibss_active = false;
-	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
+	iwl_mvm_mld_rm_bcast_sta(mvm, vif, link_conf);
 out_rm_mcast:
-	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
+	iwl_mvm_mld_rm_mcast_sta(mvm, vif, link_conf);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
 	return ret;
@@ -416,8 +419,8 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 
 	iwl_mvm_ftm_responder_clear(mvm, vif);
 
-	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
-	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
+	iwl_mvm_mld_rm_bcast_sta(mvm, vif, link_conf);
+	iwl_mvm_mld_rm_mcast_sta(mvm, vif, link_conf);
 
 	iwl_mvm_power_update_mac(mvm);
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 1608ac371bb0..75d4585c0b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -166,10 +166,13 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
  * and send it to the FW.
  * Note that each P2P mac should have its own broadcast station.
  */
-int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *bsta = &mvmvif->deflink.bcast_sta;
+	struct iwl_mvm_vif_link_info *mvm_link =
+		mvmvif->link[link_conf->link_id];
+	struct iwl_mvm_int_sta *bsta = &mvm_link->bcast_sta;
 	static const u8 _baddr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 	const u8 *baddr = _baddr;
 	unsigned int wdg_timeout =
@@ -179,7 +182,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	lockdep_assert_held(&mvm->mutex);
 
 	if (vif->type == NL80211_IFTYPE_ADHOC)
-		baddr = vif->bss_conf.bssid;
+		baddr = link_conf->bssid;
 
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
@@ -202,10 +205,13 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
  * and send it to the FW.
  * Note that each AP/GO mac should have its own multicast station.
  */
-int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *msta = &mvmvif->deflink.mcast_sta;
+	struct iwl_mvm_vif_link_info *mvm_link =
+		mvmvif->link[link_conf->link_id];
+	struct iwl_mvm_int_sta *msta = &mvm_link->mcast_sta;
 	static const u8 _maddr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
 	const u8 *maddr = _maddr;
 	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif, false, false);
@@ -222,9 +228,9 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * changes in mac80211 layer.
 	 */
 	if (vif->type == NL80211_IFTYPE_ADHOC)
-		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+		mvm_link->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 
-	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvmvif->deflink.cab_queue,
+	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvm_link->cab_queue,
 				       vif->type, STATION_TYPE_MCAST,
 				       mvmvif->id, maddr, 0, &timeout);
 }
@@ -232,7 +238,8 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 /* Allocate a new station entry for the sniffer station to the given vif,
  * and send it to the FW.
  */
-int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -310,9 +317,11 @@ static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
 	return ret;
 }
 
-int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link = mvmvif->link[link_conf->link_id];
 	u16 *queueptr;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -331,22 +340,23 @@ int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		return -EINVAL;
 	}
 
-	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->deflink.bcast_sta, true,
-				      IWL_MAX_TID_COUNT, queueptr);
+	return iwl_mvm_mld_rm_int_sta(mvm, &link->bcast_sta,
+				      true, IWL_MAX_TID_COUNT, queueptr);
 }
 
 /* Send the FW a request to remove the station from it's internal data
  * structures, and in addition remove it from the local data structure.
  */
-int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link = mvmvif->link[link_conf->link_id];
 
 	lockdep_assert_held(&mvm->mutex);
 
-	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->deflink.mcast_sta, true,
-				      0,
-				      &mvmvif->deflink.cab_queue);
+	return iwl_mvm_mld_rm_int_sta(mvm, &link->mcast_sta, true, 0,
+				      &link->cab_queue);
 }
 
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 3a9002eeb5fb..7148263dddf8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -619,13 +619,18 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 
 /* New MLD STA related APIs */
 /* STA */
-int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf);
+int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf);
+int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id);
-int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mld_rm_aux_sta(struct iwl_mvm *mvm);
 int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
-- 
2.38.1

