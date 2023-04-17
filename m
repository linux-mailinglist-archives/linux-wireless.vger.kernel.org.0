Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E736E42D0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDQImZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDQImY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC044C02
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720939; x=1713256939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90VGnngkjSUx9KhhqGxtBpKAkKuOxNHPndKHeW+Lboo=;
  b=eCfKBTnnP+ropm3RTdmHtbBtgrIW1N/01BiiG/+ow5990B/Y9Yg5RdDx
   bUf35SMJ63ZprIzMsvasyM+kpoQ+79ezIkL7ivLTqSDYuLW6v7P/AVDCL
   dgzPUwJSWipWyYfOGB7L6mNiRkjbYMkGl+7Pm0oKS6OGiNyrwLfh15mOZ
   146QlA1tjS3VK/RQb37a9Ni3VDgRqhnh11I9TmnmCjYlyS6wBYE1ab/+1
   1BqM6M/1YGV7o9znJSUs28VDbtjXnbTiABUEb7QUgs7ETJ9dn9rZ06Z5c
   My4GSTx6szTjGSuEgax+pb/lLYoIPLayNUr4xWpeA+eTrYD1Sygms2LW2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634443"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634443"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173897"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173897"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: add MLO support to SF - use sta pointer
Date:   Mon, 17 Apr 2023 11:41:32 +0300
Message-Id: <20230417113648.40cef48c0592.I8dd666d603d6e1854033e5369c70e78d9303d236@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For MLO support, use the pointer to the peer MLD instead of the default
link station id, since the default link is only used for non-MLO cases.
Using the default link sta id is meaningless for MLO. Also remove the
rcu protected section since we now avoid the lookup based on sta id.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c | 29 ++++++---------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 7c5f41e40e7a..98f330fcf678 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -8,7 +8,7 @@
 /* For counting bound interfaces */
 struct iwl_mvm_active_iface_iterator_data {
 	struct ieee80211_vif *ignore_vif;
-	u8 sta_vif_ap_sta_id;
+	struct ieee80211_sta *sta_vif_ap_sta;
 	enum iwl_sf_state sta_vif_state;
 	u32 num_active_macs;
 };
@@ -30,7 +30,7 @@ static void iwl_mvm_bound_iface_iterator(void *_data, u8 *mac,
 	data->num_active_macs++;
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		data->sta_vif_ap_sta_id = mvmvif->deflink.ap_sta_id;
+		data->sta_vif_ap_sta = mvmvif->ap_sta;
 		if (vif->cfg.assoc)
 			data->sta_vif_state = SF_FULL_ON;
 		else
@@ -172,13 +172,12 @@ static void iwl_mvm_fill_sf_command(struct iwl_mvm *mvm,
 	}
 }
 
-static int iwl_mvm_sf_config(struct iwl_mvm *mvm, u8 sta_id,
+static int iwl_mvm_sf_config(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			     enum iwl_sf_state new_state)
 {
 	struct iwl_sf_cfg_cmd sf_cmd = {
 		.state = cpu_to_le32(new_state),
 	};
-	struct ieee80211_sta *sta;
 	int ret = 0;
 
 	if (mvm->cfg->disable_dummy_notification)
@@ -196,20 +195,12 @@ static int iwl_mvm_sf_config(struct iwl_mvm *mvm, u8 sta_id,
 		iwl_mvm_fill_sf_command(mvm, &sf_cmd, NULL);
 		break;
 	case SF_FULL_ON:
-		if (sta_id == IWL_MVM_INVALID_STA) {
+		if (!sta) {
 			IWL_ERR(mvm,
 				"No station: Cannot switch SF to FULL_ON\n");
 			return -EINVAL;
 		}
-		rcu_read_lock();
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
-		if (IS_ERR_OR_NULL(sta)) {
-			IWL_ERR(mvm, "Invalid station id\n");
-			rcu_read_unlock();
-			return -EINVAL;
-		}
 		iwl_mvm_fill_sf_command(mvm, &sf_cmd, sta);
-		rcu_read_unlock();
 		break;
 	case SF_INIT_OFF:
 		iwl_mvm_fill_sf_command(mvm, &sf_cmd, NULL);
@@ -237,13 +228,12 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 		      bool remove_vif)
 {
 	enum iwl_sf_state new_state;
-	u8 sta_id = IWL_MVM_INVALID_STA;
 	struct iwl_mvm_vif *mvmvif = NULL;
 	struct iwl_mvm_active_iface_iterator_data data = {
 		.ignore_vif = changed_vif,
 		.sta_vif_state = SF_UNINIT,
-		.sta_vif_ap_sta_id = IWL_MVM_INVALID_STA,
 	};
+	struct ieee80211_sta *sta = NULL;
 
 	/*
 	 * Ignore the call if we are in HW Restart flow, or if the handled
@@ -273,7 +263,7 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 			 * and we filled the relevant data during iteration
 			 */
 			new_state = data.sta_vif_state;
-			sta_id = data.sta_vif_ap_sta_id;
+			sta = data.sta_vif_ap_sta;
 		} else {
 			if (WARN_ON(!changed_vif))
 				return -EINVAL;
@@ -282,7 +272,7 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 			} else if (changed_vif->cfg.assoc &&
 				   changed_vif->bss_conf.dtim_period) {
 				mvmvif = iwl_mvm_vif_from_mac80211(changed_vif);
-				sta_id = mvmvif->deflink.ap_sta_id;
+				sta = mvmvif->ap_sta;
 				new_state = SF_FULL_ON;
 			} else {
 				new_state = SF_INIT_OFF;
@@ -294,8 +284,5 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 		new_state = SF_UNINIT;
 	}
 
-	/* For MLO it's ok to use deflink->sta_id as it's needed only to get
-	 * a pointer to mac80211 sta
-	 */
-	return iwl_mvm_sf_config(mvm, sta_id, new_state);
+	return iwl_mvm_sf_config(mvm, sta, new_state);
 }
-- 
2.38.1

