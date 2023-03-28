Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DD6CB8F7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjC1IAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjC1IAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FE4693
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990422; x=1711526422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjihX5ovF0YiC4sIpGuXnB/2rnGoy9+WgprtF2gy0ug=;
  b=fV2Zl0vmceetrlYmtanzkwPHN1zltScR5yks/Ygph8A32hILwXGex/FE
   olPv/tMHeb4pIrwqTE4G4Nqbjw0yS6M2lJonKYcUiS80SXzn1cdGO78xi
   Vwokqgw6J6cC24Bq+Wd/YP3dFsyF6agFt0sDZ1kbRKP/1u0d3j56lsISJ
   zzomk7J6gIzPbybBZX8frJgqJphhECuhLlvhdKJKfHIfYA4fzQH6ShblP
   n1KUhDF66T7Pyl+1+o5kK/DdmnLgHdb+txH7o3UiLVq2tKwcz9Cugo//9
   b81BaBRTMMU6Yf5e1YU+5oVepDfxyi4zXATOb1DFD9T2hwfj+oSeITsIr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958268"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958268"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045309"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045309"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 24/31] wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()
Date:   Tue, 28 Mar 2023 10:59:04 +0300
Message-Id: <20230328104949.7b238cae0895.Ieb87f204787fb1c7cb7562e1cbf54ef518d87123@changeid>
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

These are two new handlers for MLO. As the configurations done in
bss_info_changed() are now split into two separate flows, use MLO
specific implementation instead of common functions with the non-MLO
code.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 297 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 +
 4 files changed, 206 insertions(+), 100 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index bbaac2ba9079..320a3bc4e9c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -113,7 +113,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 					link_conf->dtim_period);
 
 	if (!link_conf->he_support || iwlwifi_mod_params.disable_11ax ||
-	    !vif->cfg.assoc) {
+	    (vif->type == NL80211_IFTYPE_STATION && !vif->cfg.assoc)) {
 		changes &= ~LINK_CONTEXT_MODIFY_HE_PARAMS;
 		goto send_cmd;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cff24bf7e799..b90b0a973cec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1888,8 +1888,7 @@ static void iwl_mvm_config_iface_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif)
+int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mu_group_mgmt_cmd cmd = {};
 
@@ -2523,6 +2522,9 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 		/* reset cqm events tracking */
 		mvmvif->bf_data.last_cqm_event = 0;
 		if (mvmvif->bf_data.bf_enabled) {
+			/* FIXME: need to update per link when FW API will
+			 * support it
+			 */
 			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
 			if (ret)
 				IWL_ERR(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index d02b3165f1d5..950f252c1a5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -454,37 +454,41 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 }
 
 static void
-iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     struct ieee80211_bss_conf *bss_conf,
-				     u64 changes)
+iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_bss_conf *link_conf,
+				      u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
+	bool has_he, has_eht;
 	u32 link_changes = 0;
-	bool has_he = vif->bss_conf.he_support &&
-			  !iwlwifi_mod_params.disable_11ax;
-	bool has_eht = vif->bss_conf.eht_support &&
-			  !iwlwifi_mod_params.disable_11be;
+	int ret;
+
+	if (WARN_ON_ONCE(!mvmvif->link[link_conf->link_id]))
+		return;
+
+	has_he = link_conf->he_support && !iwlwifi_mod_params.disable_11ax;
+	has_eht = link_conf->eht_support && !iwlwifi_mod_params.disable_11be;
 
-	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc &&
-	    (has_he || has_eht)) {
+	/* Update EDCA params */
+	if (changes & BSS_CHANGED_QOS && vif->cfg.assoc && link_conf->qos)
+		link_changes |= LINK_CONTEXT_MODIFY_QOS_PARAMS;
+
+	if (changes & BSS_CHANGED_ERP_SLOT)
+		link_changes |= LINK_CONTEXT_MODIFY_RATES_INFO;
+
+	if (vif->cfg.assoc && (has_he || has_eht)) {
 		IWL_DEBUG_MAC80211(mvm, "Associated in HE mode\n");
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 	}
 
-	/* Update MU EDCA params */
-	if (changes & BSS_CHANGED_QOS && vif->cfg.assoc &&
-	    (has_he || has_eht))
-		link_changes |= LINK_CONTEXT_MODIFY_QOS_PARAMS;
-
 	/* Update EHT Puncturing info */
 	if (changes & BSS_CHANGED_EHT_PUNCTURING && vif->cfg.assoc && has_eht)
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
 	if (link_changes) {
-		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-					   link_changes, true);
+		ret = iwl_mvm_link_changed(mvm, vif, link_conf, link_changes,
+					   true);
 		if (ret)
 			IWL_ERR(mvm, "failed to update link\n");
 	}
@@ -493,85 +497,139 @@ iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
 	if (ret)
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
-	memcpy(mvmvif->deflink.bssid, bss_conf->bssid, ETH_ALEN);
+	memcpy(mvmvif->link[link_conf->link_id]->bssid, link_conf->bssid,
+	       ETH_ALEN);
+
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, link_conf, changes);
+}
+
+static bool iwl_mvm_mld_vif_have_valid_ap_sta(struct iwl_mvm_vif *mvmvif)
+{
+	int i;
+
+	for_each_mvm_vif_valid_link(mvmvif, i) {
+		if (mvmvif->link[i]->ap_sta_id != IWL_MVM_INVALID_STA)
+			return true;
+	}
+
+	return false;
+}
+
+static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int i, ret;
+
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return;
+
+	iwl_mvm_sec_key_remove_ap(mvm, vif);
+
+	for_each_mvm_vif_valid_link(mvmvif, i) {
+		struct iwl_mvm_vif_link_info *link = mvmvif->link[i];
+
+		if (!link)
+			continue;
+
+		ret = iwl_mvm_mld_rm_sta_id(mvm, vif, link->ap_sta_id);
+		if (ret)
+			IWL_ERR(mvm, "failed to remove AP station\n");
+
+		link->ap_sta_id = IWL_MVM_INVALID_STA;
+	}
+}
+
+static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
+						struct ieee80211_vif *vif,
+						u64 changes)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	bool protect = false;
+	unsigned int i;
+	int ret;
+
+	ret = iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
+	if (ret)
+		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
+
 	mvmvif->associated = vif->cfg.assoc;
 
-	if (changes & BSS_CHANGED_ASSOC) {
-		if (vif->cfg.assoc) {
-			/* clear statistics to get clean beacon counter */
-			iwl_mvm_request_statistics(mvm, true);
-			memset(&mvmvif->deflink.beacon_stats, 0,
-			       sizeof(mvmvif->deflink.beacon_stats));
-
-			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-				      &mvm->status) &&
-			    !vif->bss_conf.dtim_period) {
-				/* If we're not restarting and still haven't
-				 * heard a beacon (dtim period unknown) then
-				 * make sure we still have enough minimum time
-				 * remaining in the time event, since the auth
-				 * might actually have taken quite a while
-				 * (especially for SAE) and so the remaining
-				 * time could be small without us having heard
-				 * a beacon yet.
-				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0);
-			}
+	if (!(changes & BSS_CHANGED_ASSOC))
+		return;
+
+	if (vif->cfg.assoc) {
+		/* clear statistics to get clean beacon counter */
+		iwl_mvm_request_statistics(mvm, true);
+		iwl_mvm_sf_update(mvm, vif, false);
+		iwl_mvm_power_vif_assoc(mvm, vif);
+
+		for_each_mvm_vif_valid_link(mvmvif, i) {
+			memset(&mvmvif->link[i]->beacon_stats, 0,
+			       sizeof(mvmvif->link[i]->beacon_stats));
 
-			iwl_mvm_sf_update(mvm, vif, false);
-			iwl_mvm_power_vif_assoc(mvm, vif);
 			if (vif->p2p) {
 				iwl_mvm_update_smps(mvm, vif,
 						    IWL_MVM_SMPS_REQ_PROT,
-						    IEEE80211_SMPS_DYNAMIC, 0);
+						    IEEE80211_SMPS_DYNAMIC, i);
 			}
-		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
-			iwl_mvm_mei_host_disassociated(mvm);
-			/* If update fails - SF might be running in associated
-			 * mode while disassociated - which is forbidden.
-			 */
-			ret = iwl_mvm_sf_update(mvm, vif, false);
-			WARN_ONCE(ret &&
-				  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-					    &mvm->status),
-				  "Failed to update SF upon disassociation\n");
-
-			/* If we get an assert during the connection (after the
-			 * station has been added, but before the vif is set
-			 * to associated), mac80211 will re-add the station and
-			 * then configure the vif. Since the vif is not
-			 * associated, we would remove the station here and
-			 * this would fail the recovery.
+
+			rcu_read_lock();
+			link_conf = rcu_dereference(vif->link_conf[i]);
+			if (link_conf && !link_conf->dtim_period)
+				protect = true;
+			rcu_read_unlock();
+		}
+
+		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+		    protect) {
+			/* If we're not restarting and still haven't
+			 * heard a beacon (dtim period unknown) then
+			 * make sure we still have enough minimum time
+			 * remaining in the time event, since the auth
+			 * might actually have taken quite a while
+			 * (especially for SAE) and so the remaining
+			 * time could be small without us having heard
+			 * a beacon yet.
 			 */
-			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-				      &mvm->status)) {
-				/* first remove remaining keys */
-				iwl_mvm_sec_key_remove_ap(mvm, vif);
-
-				/* Remove AP station now that
-				 * the MAC is unassoc
-				 */
-				ret = iwl_mvm_mld_rm_sta_id(mvm, vif,
-							    mvmvif->deflink.ap_sta_id);
-				if (ret)
-					IWL_ERR(mvm,
-						"failed to remove AP station\n");
-
-				mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
-			}
+			iwl_mvm_protect_assoc(mvm, vif, 0);
 		}
 
-		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
+		iwl_mvm_sf_update(mvm, vif, false);
+
+		/* FIXME: need to decide about misbehaving AP handling */
+		iwl_mvm_power_vif_assoc(mvm, vif);
+	} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
+		iwl_mvm_mei_host_disassociated(mvm);
+
+		/* If update fails - SF might be running in associated
+		 * mode while disassociated - which is forbidden.
+		 */
+		ret = iwl_mvm_sf_update(mvm, vif, false);
+		WARN_ONCE(ret &&
+			  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+				    &mvm->status),
+			  "Failed to update SF upon disassociation\n");
+
+		/* If we get an assert during the connection (after the
+		 * station has been added, but before the vif is set
+		 * to associated), mac80211 will re-add the station and
+		 * then configure the vif. Since the vif is not
+		 * associated, we would remove the station here and
+		 * this would fail the recovery.
+		 */
+		iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
 	}
 
-	iwl_mvm_bss_info_changed_station_common(mvm, vif, &vif->bss_conf, changes);
+	iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 }
 
 static void
-iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     struct ieee80211_bss_conf *bss_conf,
-				     u64 changes)
+iwl_mvm_mld_link_info_changed_ap_ibss(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_bss_conf *link_conf,
+				      u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 link_changes = LINK_CONTEXT_MODIFY_PROTECT_FLAGS |
@@ -581,17 +639,22 @@ iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 	if (!mvmvif->ap_ibss_active)
 		return;
 
+	if (link_conf->he_support)
+		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
+
 	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT |
-		       BSS_CHANGED_BANDWIDTH | BSS_CHANGED_QOS) &&
-		       iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+		       BSS_CHANGED_BANDWIDTH | BSS_CHANGED_QOS |
+		       BSS_CHANGED_HE_BSS_COLOR) &&
+		       iwl_mvm_link_changed(mvm, vif, link_conf,
 					    link_changes, true))
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
 	/* Need to send a new beacon template to the FW */
 	if (changes & BSS_CHANGED_BEACON &&
-	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, &vif->bss_conf))
+	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf))
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
+	/* FIXME: need to decide if we need FTM responder per link */
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
 		int ret = iwl_mvm_ftm_start_responder(mvm, vif);
 
@@ -601,19 +664,58 @@ iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_mld_bss_info_changed(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_bss_conf *bss_conf,
-					 u64 changes)
+static void iwl_mvm_mld_link_info_changed(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_bss_conf *link_conf,
+					  u64 changes)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	mutex_lock(&mvm->mutex);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		iwl_mvm_mld_link_info_changed_station(mvm, vif, link_conf,
+						      changes);
+		break;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_ADHOC:
+		iwl_mvm_mld_link_info_changed_ap_ibss(mvm, vif, link_conf,
+						      changes);
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (changes & BSS_CHANGED_MU_GROUPS)
+			iwl_mvm_update_mu_groups(mvm, vif);
+		break;
+	default:
+		/* shouldn't happen */
+		WARN_ON_ONCE(1);
+	}
+
+	if (changes & BSS_CHANGED_TXPOWER) {
+		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d dBm\n",
+				link_conf->txpower);
+		iwl_mvm_set_tx_power(mvm, vif, link_conf->txpower);
+	}
+
+	mutex_unlock(&mvm->mutex);
+}
+
+static void iwl_mvm_mld_vif_cfg_changed(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					u64 changes)
 {
-	struct iwl_mvm_bss_info_changed_ops callbacks = {
-		.bss_info_changed_sta = iwl_mvm_mld_bss_info_changed_station,
-		.bss_info_changed_ap_ibss =
-			iwl_mvm_mld_bss_info_changed_ap_ibss,
-	};
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	iwl_mvm_bss_info_changed_common(hw, vif, bss_conf, &callbacks,
-					changes);
+	mutex_lock(&mvm->mutex);
+
+	if (changes & BSS_CHANGED_IDLE && !vif->cfg.idle)
+		iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_SCHED, true);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		iwl_mvm_mld_vif_cfg_changed_station(mvm, vif, changes);
+
+	mutex_unlock(&mvm->mutex);
 }
 
 static int
@@ -735,7 +837,8 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.prepare_multicast = iwl_mvm_prepare_multicast,
 	.configure_filter = iwl_mvm_configure_filter,
 	.config_iface_filter = iwl_mvm_mld_config_iface_filter,
-	.bss_info_changed = iwl_mvm_mld_bss_info_changed,
+	.link_info_changed = iwl_mvm_mld_link_info_changed,
+	.vif_cfg_changed = iwl_mvm_mld_vif_cfg_changed,
 	.hw_scan = iwl_mvm_mac_hw_scan,
 	.cancel_hw_scan = iwl_mvm_mac_cancel_hw_scan,
 	.sta_pre_rcu_remove = iwl_mvm_sta_pre_rcu_remove,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 03710c0cb57d..03e035b12783 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2621,4 +2621,5 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_set_hw_timestamp *hwts);
+int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 #endif /* __IWL_MVM_H__ */
-- 
2.38.1

