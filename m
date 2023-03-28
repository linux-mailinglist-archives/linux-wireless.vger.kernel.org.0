Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5866CB8E5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjC1H7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjC1H7j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF04486
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990376; x=1711526376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YW4PfTKDu5wpHB+Xad39QaQNB3hEPAf0S2D0eJrOAU0=;
  b=XgAAREl2dul2XApftaPvEZQA/86/1RAKxEfcRmVnBDNCmudqlAJ6PAYM
   +/JqKk65UiXFeIbENnPa4s2sCPXMgxW1EA773OHOHZIAd5vbSBuQHl0ii
   uyCkPjDrEnbM7sVa0WuIOKSudE3HB5nNOXbN5zhZb8yDdSvBekWf4ewmy
   xIXzYqSpj/F6SE2AHo91ENrr4jcUJl+Y3Jqff8OAlqiRiz5iz0yuGuR/m
   q9dob72H48e4DkDKajqVXcruerz+bnRUAIgY2ufHV24pCFZ5KNsst7/L4
   /BMvgh5znIW42HOJw2cXOHZrwzqZa1+oYzOipSpw4ZNErCiYDWzZtJfXU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958070"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958070"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045120"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045120"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/31] wifi: iwlwifi: mvm: add some new MLD ops
Date:   Tue, 28 Mar 2023 10:58:45 +0300
Message-Id: <20230328104948.9c83c253d610.Ibf2006be9ece87896c17cb43dfe3654ac73d81ff@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add MLD version of bss_info_changed/switch_vif_chanctx/
config_iface_filter and conf_tx() callbacks.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 213 ++++++++++------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 227 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  11 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  73 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   2 +
 5 files changed, 446 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b730b605da74..dae5e1b7d1cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2433,9 +2433,8 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		IWL_ERR(mvm, "Failed to config FW to work HE!\n");
 }
 
-static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif,
-				  u32 duration_override)
+void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   u32 duration_override)
 {
 	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
 	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
@@ -2461,6 +2460,82 @@ static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
 					min_duration, 500, false);
 }
 
+/* Handle association common part to MLD and non-MLD modes */
+void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    u64 changes)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	/* The firmware tracks the MU-MIMO group on its own.
+	 * However, on HW restart we should restore this data.
+	 */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+	    (changes & BSS_CHANGED_MU_GROUPS) && vif->bss_conf.mu_mimo_owner) {
+		ret = iwl_mvm_update_mu_groups(mvm, vif);
+		if (ret)
+			IWL_ERR(mvm,
+				"failed to update VHT MU_MIMO groups\n");
+	}
+
+	iwl_mvm_recalc_multicast(mvm);
+
+	/* reset rssi values */
+	mvmvif->bf_data.ave_beacon_signal = 0;
+
+	iwl_mvm_bt_coex_vif_change(mvm);
+	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_TT,
+			    IEEE80211_SMPS_AUTOMATIC);
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_UMAC_SCAN))
+		iwl_mvm_config_scan(mvm);
+}
+
+/* Execute the common part for MLD and non-MLD modes */
+void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
+					     struct ieee80211_vif *vif,
+					     u64 changes)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	if (changes & BSS_CHANGED_BEACON_INFO) {
+		/* We received a beacon from the associated AP so
+		 * remove the session protection.
+		 */
+		iwl_mvm_stop_session_protection(mvm, vif);
+
+		iwl_mvm_sf_update(mvm, vif, false);
+		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+	}
+
+	if (changes & (BSS_CHANGED_PS | BSS_CHANGED_P2P_PS | BSS_CHANGED_QOS |
+		       /* Send power command on every beacon change,
+			* because we may have not enabled beacon abort yet.
+			*/
+		       BSS_CHANGED_BEACON_INFO)) {
+		ret = iwl_mvm_power_update_mac(mvm);
+		if (ret)
+			IWL_ERR(mvm, "failed to update power mode\n");
+	}
+
+	if (changes & BSS_CHANGED_CQM) {
+		IWL_DEBUG_MAC80211(mvm, "cqm info_changed\n");
+		/* reset cqm events tracking */
+		mvmvif->bf_data.last_cqm_event = 0;
+		if (mvmvif->bf_data.bf_enabled) {
+			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
+			if (ret)
+				IWL_ERR(mvm,
+					"failed to update CQM thresholds\n");
+		}
+	}
+
+	if (changes & BSS_CHANGED_BANDWIDTH)
+		iwl_mvm_apply_fw_smps_request(vif);
+}
+
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *bss_conf,
@@ -2623,67 +2698,10 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					vif->addr);
 		}
 
-		/*
-		 * The firmware tracks the MU-MIMO group on its own.
-		 * However, on HW restart we should restore this data.
-		 */
-		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		    (changes & BSS_CHANGED_MU_GROUPS) && vif->bss_conf.mu_mimo_owner) {
-			ret = iwl_mvm_update_mu_groups(mvm, vif);
-			if (ret)
-				IWL_ERR(mvm,
-					"failed to update VHT MU_MIMO groups\n");
-		}
-
-		iwl_mvm_recalc_multicast(mvm);
-
-		/* reset rssi values */
-		mvmvif->bf_data.ave_beacon_signal = 0;
-
-		iwl_mvm_bt_coex_vif_change(mvm);
-		iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_TT,
-				    IEEE80211_SMPS_AUTOMATIC);
-		if (fw_has_capa(&mvm->fw->ucode_capa,
-				IWL_UCODE_TLV_CAPA_UMAC_SCAN))
-			iwl_mvm_config_scan(mvm);
-	}
-
-	if (changes & BSS_CHANGED_BEACON_INFO) {
-		/*
-		 * We received a beacon from the associated AP so
-		 * remove the session protection.
-		 */
-		iwl_mvm_stop_session_protection(mvm, vif);
-
-		iwl_mvm_sf_update(mvm, vif, false);
-		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 	}
 
-	if (changes & (BSS_CHANGED_PS | BSS_CHANGED_P2P_PS | BSS_CHANGED_QOS |
-		       /*
-			* Send power command on every beacon change,
-			* because we may have not enabled beacon abort yet.
-			*/
-		       BSS_CHANGED_BEACON_INFO)) {
-		ret = iwl_mvm_power_update_mac(mvm);
-		if (ret)
-			IWL_ERR(mvm, "failed to update power mode\n");
-	}
-
-	if (changes & BSS_CHANGED_CQM) {
-		IWL_DEBUG_MAC80211(mvm, "cqm info_changed\n");
-		/* reset cqm events tracking */
-		mvmvif->bf_data.last_cqm_event = 0;
-		if (mvmvif->bf_data.bf_enabled) {
-			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
-			if (ret)
-				IWL_ERR(mvm,
-					"failed to update CQM thresholds\n");
-		}
-	}
-
-	if (changes & BSS_CHANGED_BANDWIDTH)
-		iwl_mvm_apply_fw_smps_request(vif);
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, changes);
 }
 
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
@@ -2967,6 +2985,22 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
 				     u64 changes)
+{
+	struct iwl_mvm_bss_info_changed_ops callbacks = {
+		.bss_info_changed_sta = iwl_mvm_bss_info_changed_station,
+		.bss_info_changed_ap_ibss = iwl_mvm_bss_info_changed_ap_ibss,
+	};
+
+	iwl_mvm_bss_info_changed_common(hw, vif, bss_conf, &callbacks,
+					changes);
+}
+
+void
+iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf,
+				struct iwl_mvm_bss_info_changed_ops *callbacks,
+				u64 changes)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -2977,11 +3011,12 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		iwl_mvm_bss_info_changed_station(mvm, vif, bss_conf, changes);
+		callbacks->bss_info_changed_sta(mvm, vif, bss_conf, changes);
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_ADHOC:
-		iwl_mvm_bss_info_changed_ap_ibss(mvm, vif, bss_conf, changes);
+		callbacks->bss_info_changed_ap_ibss(mvm, vif, bss_conf,
+						    changes);
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		if (changes & BSS_CHANGED_MU_GROUPS)
@@ -4762,12 +4797,13 @@ static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 static int
 iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
-				struct ieee80211_vif_chanctx_switch *vifs)
+				struct ieee80211_vif_chanctx_switch *vifs,
+				struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	__iwl_mvm_unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
+	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
 	__iwl_mvm_remove_chanctx(mvm, vifs[0].old_ctx);
 
 	ret = __iwl_mvm_add_chanctx(mvm, vifs[0].new_ctx);
@@ -4776,7 +4812,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 		goto out_reassign;
 	}
 
-	ret = __iwl_mvm_assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
+	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
 					   true);
 	if (ret) {
 		IWL_ERR(mvm,
@@ -4799,8 +4835,8 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 		goto out_restart;
 	}
 
-	if (__iwl_mvm_assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
-					 true)) {
+	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
+				      true)) {
 		IWL_ERR(mvm, "failed to reassign old_ctx after failure.\n");
 		goto out_restart;
 	}
@@ -4819,14 +4855,15 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 
 static int
 iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
-				    struct ieee80211_vif_chanctx_switch *vifs)
+				    struct ieee80211_vif_chanctx_switch *vifs,
+				    struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	__iwl_mvm_unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
+	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
 
-	ret = __iwl_mvm_assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
+	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
 					   true);
 	if (ret) {
 		IWL_ERR(mvm,
@@ -4837,8 +4874,8 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 	goto out;
 
 out_reassign:
-	if (__iwl_mvm_assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
-					 true)) {
+	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
+				      true)) {
 		IWL_ERR(mvm, "failed to reassign old_ctx after failure.\n");
 		goto out_restart;
 	}
@@ -4855,10 +4892,13 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 	return ret;
 }
 
-static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
-				      struct ieee80211_vif_chanctx_switch *vifs,
-				      int n_vifs,
-				      enum ieee80211_chanctx_switch_mode mode)
+/* Execute the common part for both MLD and non-MLD modes */
+int
+iwl_mvm_switch_vif_chanctx_common(struct ieee80211_hw *hw,
+				  struct ieee80211_vif_chanctx_switch *vifs,
+				  int n_vifs,
+				  enum ieee80211_chanctx_switch_mode mode,
+				  struct iwl_mvm_switch_vif_chanctx_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -4869,10 +4909,10 @@ static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
 
 	switch (mode) {
 	case CHANCTX_SWMODE_SWAP_CONTEXTS:
-		ret = iwl_mvm_switch_vif_chanctx_swap(mvm, vifs);
+		ret = iwl_mvm_switch_vif_chanctx_swap(mvm, vifs, ops);
 		break;
 	case CHANCTX_SWMODE_REASSIGN_VIF:
-		ret = iwl_mvm_switch_vif_chanctx_reassign(mvm, vifs);
+		ret = iwl_mvm_switch_vif_chanctx_reassign(mvm, vifs, ops);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -4882,6 +4922,19 @@ static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
+				      struct ieee80211_vif_chanctx_switch *vifs,
+				      int n_vifs,
+				      enum ieee80211_chanctx_switch_mode mode)
+{
+	struct iwl_mvm_switch_vif_chanctx_ops ops = {
+		.__assign_vif_chanctx = __iwl_mvm_assign_vif_chanctx,
+		.__unassign_vif_chanctx = __iwl_mvm_unassign_vif_chanctx,
+	};
+
+	return iwl_mvm_switch_vif_chanctx_common(hw, vifs, n_vifs, mode, &ops);
+}
+
 static int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 36c87d755d5c..9d97098ab57c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -369,12 +369,239 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
+static void
+iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *bss_conf,
+				     u64 changes)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+	u32 link_changes = 0;
+	bool has_he = vif->bss_conf.he_support &&
+			  !iwlwifi_mod_params.disable_11ax;
+	bool has_eht = vif->bss_conf.eht_support &&
+			  !iwlwifi_mod_params.disable_11be;
+
+	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc &&
+	    (has_he || has_eht)) {
+		IWL_DEBUG_MAC80211(mvm, "Associated in HE mode\n");
+		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
+	}
+
+	/* Update MU EDCA params */
+	if (changes & BSS_CHANGED_QOS && vif->cfg.assoc &&
+	    (has_he || has_eht))
+		link_changes |= LINK_CONTEXT_MODIFY_QOS_PARAMS;
+
+	/* Update EHT Puncturing info */
+	if (changes & BSS_CHANGED_EHT_PUNCTURING && vif->cfg.assoc && has_eht)
+		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
+
+	if (link_changes) {
+		ret = iwl_mvm_link_changed(mvm, vif, link_changes, true);
+		if (ret)
+			IWL_ERR(mvm, "failed to update link\n");
+	}
+
+	ret = iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
+	if (ret)
+		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
+
+	memcpy(mvmvif->deflink.bssid, bss_conf->bssid, ETH_ALEN);
+	mvmvif->associated = vif->cfg.assoc;
+
+	if (changes & BSS_CHANGED_ASSOC) {
+		if (vif->cfg.assoc) {
+			/* clear statistics to get clean beacon counter */
+			iwl_mvm_request_statistics(mvm, true);
+			memset(&mvmvif->deflink.beacon_stats, 0,
+			       sizeof(mvmvif->deflink.beacon_stats));
+
+			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+				      &mvm->status) &&
+			    !vif->bss_conf.dtim_period) {
+				/* If we're not restarting and still haven't
+				 * heard a beacon (dtim period unknown) then
+				 * make sure we still have enough minimum time
+				 * remaining in the time event, since the auth
+				 * might actually have taken quite a while
+				 * (especially for SAE) and so the remaining
+				 * time could be small without us having heard
+				 * a beacon yet.
+				 */
+				iwl_mvm_protect_assoc(mvm, vif, 0);
+			}
+
+			iwl_mvm_sf_update(mvm, vif, false);
+			iwl_mvm_power_vif_assoc(mvm, vif);
+			if (vif->p2p) {
+				iwl_mvm_update_smps(mvm, vif,
+						    IWL_MVM_SMPS_REQ_PROT,
+						    IEEE80211_SMPS_DYNAMIC);
+			}
+		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+			iwl_mvm_mei_host_disassociated(mvm);
+			/* If update fails - SF might be running in associated
+			 * mode while disassociated - which is forbidden.
+			 */
+			ret = iwl_mvm_sf_update(mvm, vif, false);
+			WARN_ONCE(ret &&
+				  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+					    &mvm->status),
+				  "Failed to update SF upon disassociation\n");
+
+			/* If we get an assert during the connection (after the
+			 * station has been added, but before the vif is set
+			 * to associated), mac80211 will re-add the station and
+			 * then configure the vif. Since the vif is not
+			 * associated, we would remove the station here and
+			 * this would fail the recovery.
+			 */
+			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+				      &mvm->status)) {
+				/* first remove remaining keys */
+				iwl_mvm_sec_key_remove_ap(mvm, vif);
+
+				/* Remove AP station now that
+				 * the MAC is unassoc
+				 */
+				ret = iwl_mvm_mld_rm_sta_id(mvm, vif,
+							    mvmvif->deflink.ap_sta_id);
+				if (ret)
+					IWL_ERR(mvm,
+						"failed to remove AP station\n");
+
+				mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
+			}
+		}
+
+		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
+	}
+
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, changes);
+}
+
+static void
+iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *bss_conf,
+				     u64 changes)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u32 link_changes = LINK_CONTEXT_MODIFY_PROTECT_FLAGS |
+			   LINK_CONTEXT_MODIFY_QOS_PARAMS;
+
+	/* Changes will be applied when the AP/IBSS is started */
+	if (!mvmvif->ap_ibss_active)
+		return;
+
+	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT |
+		       BSS_CHANGED_BANDWIDTH | BSS_CHANGED_QOS) &&
+		       iwl_mvm_link_changed(mvm, vif, link_changes, true))
+		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
+
+	/* Need to send a new beacon template to the FW */
+	if (changes & BSS_CHANGED_BEACON &&
+	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif))
+		IWL_WARN(mvm, "Failed updating beacon data\n");
+
+	if (changes & BSS_CHANGED_FTM_RESPONDER) {
+		int ret = iwl_mvm_ftm_start_responder(mvm, vif);
+
+		if (ret)
+			IWL_WARN(mvm, "Failed to enable FTM responder (%d)\n",
+				 ret);
+	}
+}
+
+static void iwl_mvm_mld_bss_info_changed(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_bss_conf *bss_conf,
+					 u64 changes)
+{
+	struct iwl_mvm_bss_info_changed_ops callbacks = {
+		.bss_info_changed_sta = iwl_mvm_mld_bss_info_changed_station,
+		.bss_info_changed_ap_ibss =
+			iwl_mvm_mld_bss_info_changed_ap_ibss,
+	};
+
+	iwl_mvm_bss_info_changed_common(hw, vif, bss_conf, &callbacks,
+					changes);
+}
+
+static int
+iwl_mvm_mld_switch_vif_chanctx(struct ieee80211_hw *hw,
+			       struct ieee80211_vif_chanctx_switch *vifs,
+			       int n_vifs,
+			       enum ieee80211_chanctx_switch_mode mode)
+{
+	struct iwl_mvm_switch_vif_chanctx_ops ops = {
+		.__assign_vif_chanctx = __iwl_mvm_mld_assign_vif_chanctx,
+		.__unassign_vif_chanctx = __iwl_mvm_mld_unassign_vif_chanctx,
+	};
+
+	return iwl_mvm_switch_vif_chanctx_common(hw, vifs, n_vifs, mode, &ops);
+}
+
+static void iwl_mvm_mld_config_iface_filter(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    unsigned int filter_flags,
+					    unsigned int changed_flags)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	/* We support only filter for probe requests */
+	if (!(changed_flags & FIF_PROBE_REQ))
+		return;
+
+	/* Supported only for p2p client interfaces */
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc ||
+	    !vif->p2p)
+		return;
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
+	mutex_unlock(&mvm->mutex);
+}
+
+static int
+iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			unsigned int link_id, u16 ac,
+			const struct ieee80211_tx_queue_params *params)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	mvmvif->deflink.queue_params[ac] = *params;
+
+	/* No need to update right away, we'll get BSS_CHANGED_QOS
+	 * The exception is P2P_DEVICE interface which needs immediate update.
+	 */
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		int ret;
+
+		mutex_lock(&mvm->mutex);
+		ret = iwl_mvm_link_changed(mvm, vif,
+					   LINK_CONTEXT_MODIFY_QOS_PARAMS,
+					   true);
+		mutex_unlock(&mvm->mutex);
+		return ret;
+	}
+	return 0;
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
+	.config_iface_filter = iwl_mvm_mld_config_iface_filter,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
+	.switch_vif_chanctx = iwl_mvm_mld_switch_vif_chanctx,
 	.join_ibss = iwl_mvm_mld_start_ap_ibss,
 	.leave_ibss = iwl_mvm_mld_stop_ap_ibss,
 	.sta_state = iwl_mvm_mld_mac_sta_state,
+	.conf_tx = iwl_mvm_mld_mac_conf_tx,
+	.bss_info_changed = iwl_mvm_mld_bss_info_changed,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 0e9c87bc224c..16723d581a3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -536,6 +536,17 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
+int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			  u8 sta_id)
+{
+	int ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta_id], NULL);
+	return ret;
+}
+
 static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
 					      struct ieee80211_sta *sta,
 					      bool disable)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 24884e102673..2ea224acdea1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1789,6 +1789,48 @@ bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
 void iwl_mvm_stop_ap_ibss_common(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 
+/* BSS Info */
+/**
+ * struct iwl_mvm_bss_info_changed_ops - callbacks for the bss_info_changed()
+ *
+ * Since the only difference between both MLD and
+ * non-MLD versions of bss_info_changed() is these function calls,
+ * each version will send its specific function calls to
+ * %iwl_mvm_bss_info_changed_common().
+ *
+ * @bss_info_changed_sta: pointer to the function that handles changes
+ *	in bss_info in sta mode
+ * @bss_info_changed_ap_ibss: pointer to the function that handles changes
+ *	in bss_info in ap and ibss modes
+ */
+struct iwl_mvm_bss_info_changed_ops {
+	void (*bss_info_changed_sta)(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *bss_conf,
+				     u64 changes);
+	void (*bss_info_changed_ap_ibss)(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_bss_conf *bss_conf,
+					 u64 changes);
+};
+
+void
+iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf,
+				struct iwl_mvm_bss_info_changed_ops *callbacks,
+				u64 changes);
+void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
+					     struct ieee80211_vif *vif,
+					     u64 changes);
+void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    u64 changes);
+
+/*Session Protection */
+void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   u32 duration_override);
+
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
 {
@@ -2232,6 +2274,37 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
 
 /* Channel Context */
+/**
+ * struct iwl_mvm_switch_vif_chanctx_ops - callbacks for switch_vif_chanctx()
+ *
+ * Since the only difference between both MLD and
+ * non-MLD versions of switch_vif_chanctx() is these function calls,
+ * each version will send its specific function calls to
+ * %iwl_mvm_switch_vif_chanctx_common().
+ *
+ * @__assign_vif_chanctx: pointer to the function that assigns a chanctx to
+ *	a given vif
+ * @__unassign_vif_chanctx: pointer to the function that unassigns a chanctx to
+ *	a given vif
+ */
+struct iwl_mvm_switch_vif_chanctx_ops {
+	int (*__assign_vif_chanctx)(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_chanctx_conf *ctx,
+				    bool switching_chanctx);
+	void (*__unassign_vif_chanctx)(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_chanctx_conf *ctx,
+				       bool switching_chanctx);
+};
+
+int
+iwl_mvm_switch_vif_chanctx_common(struct ieee80211_hw *hw,
+				  struct ieee80211_vif_chanctx_switch *vifs,
+				  int n_vifs,
+				  enum ieee80211_chanctx_switch_mode mode,
+				  struct iwl_mvm_switch_vif_chanctx_ops *ops);
+
 bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_chanctx_conf *ctx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index fa644928746a..770516b20303 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -631,6 +631,8 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			  u8 sta_id);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

