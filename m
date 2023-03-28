Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3346CB8E3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC1H7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC1H7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599D3C34
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990374; x=1711526374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFh6uI9OyaheCjq16eIKDp7EjqznevFLoRIcIYK2FLg=;
  b=j9HRyMl+5DN9dzNkME/EDvEIjQpqcShgNb2S6FsoiVu/1PoP6vu9L+f8
   txYDsL9w+RxRqLxfpv9iYhjzADsxJzx4hkL4f1jVgcdHh5rSxtnrMKf9t
   QQFKduMpbbOOFOexpqrWGGmhuSZ7Lh//jHkM2jXe3mn61AqiYe1nvHCbg
   JRFpHhHxc2lBeCogFQxnkQdwOEOYVuypH0SjB+yZx9CpZplK6+IIUFp+k
   GGBLR/WKThSm0gNkW1jYIc//5fesuacwuvaMK3GEeUQ8A0oWLNrQDCtq0
   QbBSjrGjQIbJ16Mq+AW0txRF8OvxuqFz47JvP90d8nGjqCFQpoExi8iH/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958063"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958063"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045116"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045116"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/31] wifi: iwlwifi: mvm: add sta handling flows for MLD mode
Date:   Tue, 28 Mar 2023 10:58:44 +0300
Message-Id: <20230328104948.b5548cfd8fe3.I70f9c8f3c95e18d5c9af0a5681e0830893509531@changeid>
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

In MLD mode we have a new STA cmd. As a result, it is also changes
the flows of adding/updating/removing and handling state of
a station. Add these flows.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  58 +++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  18 ++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 205 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  25 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  45 ++++
 6 files changed, 333 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 282c15e74f08..b730b605da74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2103,9 +2103,8 @@ static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
 }
 
 /* Set the pkt_ext field according to PPE Thresholds element */
-static int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
-				   struct ieee80211_sta *sta,
-				   struct iwl_he_pkt_ext_v2 *pkt_ext)
+int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			    struct iwl_he_pkt_ext_v2 *pkt_ext)
 {
 	u8 nominal_padding;
 	int i, ret = 0;
@@ -2250,7 +2249,7 @@ bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			       IEEE80211_HE_MAC_CAP2_ACK_EN));
 }
 
-static __le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta)
+__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta)
 {
 	u8 *mac_cap_info = &sta->deflink.he_cap.he_cap_elem.mac_cap_info[0];
 	__le32 htc_flags = 0;
@@ -3425,11 +3424,37 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 #endif
 }
 
+static int iwl_mvm_mac_ctxt_changed_wrapper(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    bool force_assoc_off)
+{
+	return iwl_mvm_mac_ctxt_changed(mvm, vif, force_assoc_off, NULL);
+}
+
 static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
 				 enum ieee80211_sta_state old_state,
 				 enum ieee80211_sta_state new_state)
+{
+	struct iwl_mvm_sta_state_ops callbacks = {
+		.add_sta = iwl_mvm_add_sta,
+		.update_sta = iwl_mvm_update_sta,
+		.rm_sta = iwl_mvm_rm_sta,
+		.mac_ctxt_changed = iwl_mvm_mac_ctxt_changed_wrapper,
+	};
+
+	return iwl_mvm_mac_sta_state_common(hw, vif, sta, old_state, new_state,
+					    &callbacks);
+}
+
+/* Common part for MLD and non-MLD modes */
+int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 enum ieee80211_sta_state old_state,
+				 enum ieee80211_sta_state new_state,
+				 struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -3507,7 +3532,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		ret = iwl_mvm_add_sta(mvm, vif, sta);
+		ret = callbacks->add_sta(mvm, vif, sta);
 		if (sta->tdls && ret == 0) {
 			iwl_mvm_recalc_tdls_state(mvm, vif, true);
 			iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
@@ -3529,11 +3554,12 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		if (vif->type == NL80211_IFTYPE_AP) {
 			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
 			mvmvif->ap_assoc_sta_count++;
-			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-			if ((vif->bss_conf.he_support &&
+			callbacks->mac_ctxt_changed(mvm, vif, false);
+			if (!mvm->mld_api_is_used &&
+			    ((vif->bss_conf.he_support &&
 			     !iwlwifi_mod_params.disable_11ax) ||
 			    (vif->bss_conf.eht_support &&
-			     !iwlwifi_mod_params.disable_11be))
+			     !iwlwifi_mod_params.disable_11be)))
 				iwl_mvm_cfg_he_sta(mvm, vif,
 						   mvm_sta->deflink.sta_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
@@ -3543,13 +3569,19 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			if (sta->deflink.he_cap.has_he)
 				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
 
-			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+			callbacks->mac_ctxt_changed(mvm, vif, false);
+
+			if (mvm->mld_api_is_used)
+				iwl_mvm_link_changed(mvm, vif,
+						     LINK_CONTEXT_MODIFY_ALL &
+						     ~LINK_CONTEXT_MODIFY_ACTIVE,
+						     true);
 		}
 
 		iwl_mvm_rs_rate_init(mvm, sta,
 				     mvmvif->deflink.phy_ctxt->channel->band,
 				     false);
-		ret = iwl_mvm_update_sta(mvm, vif, sta);
+		ret = callbacks->update_sta(mvm, vif, sta);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ret = 0;
@@ -3567,7 +3599,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 
 			mvmvif->authorized = 1;
 
-			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+			callbacks->mac_ctxt_changed(mvm, vif, false);
 			iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 		}
 
@@ -3601,7 +3633,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		   new_state == IEEE80211_STA_AUTH) {
 		if (vif->type == NL80211_IFTYPE_AP) {
 			mvmvif->ap_assoc_sta_count--;
-			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+			callbacks->mac_ctxt_changed(mvm, vif, false);
 		} else if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			iwl_mvm_stop_session_protection(mvm, vif);
 		ret = 0;
@@ -3612,7 +3644,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		   new_state == IEEE80211_STA_NOTEXIST) {
 		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			iwl_mvm_stop_session_protection(mvm, vif);
-		ret = iwl_mvm_rm_sta(mvm, vif, sta);
+		ret = callbacks->rm_sta(mvm, vif, sta);
 		if (sta->tdls) {
 			iwl_mvm_recalc_tdls_state(mvm, vif, false);
 			iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index fe55efce8dd5..36c87d755d5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -352,6 +352,23 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     enum ieee80211_sta_state old_state,
+				     enum ieee80211_sta_state new_state)
+{
+	struct iwl_mvm_sta_state_ops callbacks = {
+		.add_sta = iwl_mvm_mld_add_sta,
+		.update_sta = iwl_mvm_mld_update_sta,
+		.rm_sta = iwl_mvm_mld_rm_sta,
+		.mac_ctxt_changed = iwl_mvm_mld_mac_ctxt_changed,
+	};
+
+	return iwl_mvm_mac_sta_state_common(hw, vif, sta, old_state, new_state,
+					    &callbacks);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
@@ -359,4 +376,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
 	.join_ibss = iwl_mvm_mld_start_ap_ibss,
 	.leave_ibss = iwl_mvm_mld_stop_ap_ibss,
+	.sta_state = iwl_mvm_mld_mac_sta_state,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index c063383247f9..0e9c87bc224c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022 Intel Corporation
  */
 #include "mvm.h"
+#include "time-sync.h"
 
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
 				    struct iwl_mvm_sta_cfg_cmd *cmd)
@@ -331,6 +332,210 @@ int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				      IWL_MAX_TID_COUNT, &mvm->snif_queue);
 }
 
+/* send a cfg sta command to add/update a sta in firmware */
+static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			       struct ieee80211_vif *vif, u16 phy_id)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta_cfg_cmd cmd = {
+		.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id),
+		.link_id = cpu_to_le32(phy_id),
+		.station_type = cpu_to_le32(mvm_sta->sta_type),
+		.mfp = cpu_to_le32(sta->mfp),
+	};
+	u32 agg_size = 0, mpdu_dens = 0;
+
+	/* For now the link addr is the same as the mld addr */
+	if (vif->type == NL80211_IFTYPE_AP) {
+		memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
+		memcpy(&cmd.peer_link_address, sta->addr, ETH_ALEN);
+	} else if (vif->bss_conf.bssid) {
+		memcpy(&cmd.peer_mld_address, vif->bss_conf.bssid, ETH_ALEN);
+		memcpy(&cmd.peer_link_address, vif->bss_conf.bssid, ETH_ALEN);
+	}
+
+	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
+		cmd.assoc_id = cpu_to_le32(sta->aid);
+
+	switch (sta->deflink.rx_nss) {
+	case 1:
+		cmd.mimo = cpu_to_le32(0);
+		break;
+	case 2 ... 8:
+		cmd.mimo = cpu_to_le32(1);
+		break;
+	}
+
+	switch (sta->deflink.smps_mode) {
+	case IEEE80211_SMPS_AUTOMATIC:
+	case IEEE80211_SMPS_NUM_MODES:
+		WARN_ON(1);
+		break;
+	case IEEE80211_SMPS_STATIC:
+		/* override NSS */
+		cmd.mimo = cpu_to_le32(0);
+		break;
+	case IEEE80211_SMPS_DYNAMIC:
+		cmd.mimo_protection = cpu_to_le32(1);
+		break;
+	case IEEE80211_SMPS_OFF:
+		/* nothing */
+		break;
+	}
+
+	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(sta, &agg_size);
+	cmd.tx_ampdu_spacing = cpu_to_le32(mpdu_dens);
+	cmd.tx_ampdu_max_size = cpu_to_le32(agg_size);
+
+	if (sta->wme) {
+		cmd.sp_length =
+			cpu_to_le32(sta->max_sp ? sta->max_sp * 2 : 128);
+		cmd.uapsd_acs = cpu_to_le32(iwl_mvm_get_sta_uapsd_acs(sta));
+	}
+
+	if (sta->deflink.he_cap.has_he) {
+		cmd.trig_rnd_alloc =
+			cpu_to_le32(vif->bss_conf.uora_exists ? 1 : 0);
+
+		/* PPE Thresholds */
+		iwl_mvm_set_sta_pkt_ext(mvm, sta, &cmd.pkt_ext);
+
+		/* HTC flags */
+		cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta);
+
+		if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
+		    IEEE80211_HE_MAC_CAP2_ACK_EN)
+			cmd.ack_enabled = cpu_to_le32(1);
+	}
+
+	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
+}
+
+int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	int sta_id, ret = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		sta_id = iwl_mvm_find_free_sta_id(mvm,
+						  ieee80211_vif_type_p2p(vif));
+	else
+		sta_id = mvm_sta->deflink.sta_id;
+
+	if (sta_id == IWL_MVM_INVALID_STA)
+		return -ENOSPC;
+
+	spin_lock_init(&mvm_sta->lock);
+
+	/* if this is a HW restart re-alloc existing queues */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+		struct iwl_mvm_int_sta tmp_sta = {
+			.sta_id = sta_id,
+			.type = mvm_sta->sta_type,
+		};
+
+		/* First add an empty station since allocating
+		 * a queue requires a valid station
+		 */
+		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, &tmp_sta,
+						    vif->bss_conf.bssid,
+						    mvmvif->deflink.phy_ctxt->id);
+		if (ret)
+			return ret;
+
+		iwl_mvm_realloc_queues_after_restart(mvm, sta);
+	} else {
+		ret = iwl_mvm_sta_init(mvm, vif, sta, sta_id,
+				       STATION_TYPE_PEER);
+	}
+
+	ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, mvmvif->deflink.phy_ctxt->id);
+	if (ret)
+		return ret;
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		if (!sta->tdls) {
+			WARN_ON(mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA);
+			mvmvif->deflink.ap_sta_id = sta_id;
+		} else {
+			WARN_ON(mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA);
+		}
+	}
+
+	rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
+
+	return 0;
+}
+
+int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	return iwl_mvm_mld_cfg_sta(mvm, sta, vif, mvmvif->deflink.phy_ctxt->id);
+}
+
+static void iwl_mvm_mld_disable_sta_queues(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	int i;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	for (i = 0; i < ARRAY_SIZE(mvm_sta->tid_data); i++) {
+		if (mvm_sta->tid_data[i].txq_id == IWL_MVM_INVALID_QUEUE)
+			continue;
+
+		iwl_mvm_mld_disable_txq(mvm, sta, &mvm_sta->tid_data[i].txq_id,
+					i);
+		mvm_sta->tid_data[i].txq_id = IWL_MVM_INVALID_QUEUE;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct iwl_mvm_txq *mvmtxq =
+			iwl_mvm_txq_from_mac80211(sta->txq[i]);
+
+		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+	}
+}
+
+int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	kfree(mvm_sta->dup_data);
+
+	/* flush its queues here since we are freeing mvm_sta */
+	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
+	if (ret)
+		return ret;
+	ret = iwl_mvm_wait_sta_queues_empty(mvm, mvm_sta);
+	if (ret)
+		return ret;
+
+	iwl_mvm_mld_disable_sta_queues(mvm, vif, sta);
+
+	if (iwl_mvm_sta_del(mvm, vif, sta, &ret))
+		return ret;
+
+	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta->deflink.sta_id);
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id], NULL);
+
+	return ret;
+}
+
 static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
 					      struct ieee80211_sta *sta,
 					      bool disable)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 443f0b80b63e..24884e102673 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1573,6 +1573,13 @@ int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk);
 int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
 int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids);
 
+/* Utils to extract sta related data */
+__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta);
+u8 iwl_mvm_get_sta_uapsd_acs(struct ieee80211_sta *sta);
+u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta, u32 *_agg_size);
+int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			    struct iwl_he_pkt_ext_v2 *pkt_ext);
+
 void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm);
 
 static inline void iwl_mvm_set_tx_cmd_ccmp(struct ieee80211_tx_info *info,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index d01c67e1ce2a..0ff66ffc5bee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -24,8 +24,7 @@ static inline int iwl_mvm_add_sta_cmd_size(struct iwl_mvm *mvm)
 		return sizeof(struct iwl_mvm_add_sta_cmd_v7);
 }
 
-static int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm,
-				    enum nl80211_iftype iftype)
+int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm, enum nl80211_iftype iftype)
 {
 	int sta_id;
 	u32 reserved_ids = 0;
@@ -52,8 +51,7 @@ static int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm,
 }
 
 /* Calculate the ampdu density and max size */
-static u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta,
-				      u32 *_agg_size)
+u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta, u32 *_agg_size)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	u32 agg_size = 0, mpdu_dens = 0;
@@ -97,7 +95,7 @@ static u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta,
 	return mpdu_dens;
 }
 
-static u8 iwl_mvm_get_sta_uapsd_acs(struct ieee80211_sta *sta)
+u8 iwl_mvm_get_sta_uapsd_acs(struct ieee80211_sta *sta)
 {
 	u8 uapsd_acs = 0;
 
@@ -1528,8 +1526,8 @@ static int iwl_mvm_reserve_sta_stream(struct iwl_mvm *mvm,
  *
  * Note that re-enabling aggregations isn't done in this function.
  */
-static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
-						 struct ieee80211_sta *sta)
+void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
+					  struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	unsigned int wdg =
@@ -1649,8 +1647,8 @@ static int iwl_mvm_add_int_sta_common(struct iwl_mvm *mvm,
 }
 
 /* Initialize driver data of a new sta */
-static int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, int sta_id, u8 sta_type)
+int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, int sta_id, u8 sta_type)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -1923,9 +1921,12 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 	return 0;
 }
 
-/* Execute the common part for both MLD and non-MLD modes */
-static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, int *ret)
+/* Execute the common part for both MLD and non-MLD modes.
+ * Returns if we're done with removing the station, either
+ * with error or success
+ */
+bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, int *ret)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index bfd44c489286..fa644928746a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -471,6 +471,9 @@ struct iwl_mvm_int_sta {
  */
 int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   bool update, unsigned int flags);
+int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm, enum nl80211_iftype iftype);
+int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, int sta_id, u8 sta_type);
 int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		    struct ieee80211_vif *vif,
 		    struct ieee80211_sta *sta);
@@ -482,8 +485,12 @@ static inline int iwl_mvm_update_sta(struct iwl_mvm *mvm,
 	return iwl_mvm_sta_send_to_fw(mvm, sta, true, 0);
 }
 
+void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
+					  struct ieee80211_sta *sta);
 int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 				  struct iwl_mvm_sta *mvm_sta);
+bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, int *ret);
 int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		   struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
@@ -578,6 +585,38 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 			    struct ieee80211_sta *sta,
 			    u8 sta_id, u8 tid, unsigned int timeout);
 
+/* Sta state */
+/**
+ * struct iwl_mvm_sta_state_ops - callbacks for the sta_state() ops
+ *
+ * Since the only difference between both MLD and
+ * non-MLD versions of sta_state() is these function calls,
+ * each version will send its specific function calls to
+ * %iwl_mvm_mac_sta_state_common().
+ *
+ * @add_sta: pointer to the function that adds a new sta
+ * @update_sta: pointer to the function that updates a sta
+ * @rm_sta: pointer to the functions that removes a sta
+ * @mac_ctxt_changed: pointer to the function that handles a change in mac ctxt
+ */
+struct iwl_mvm_sta_state_ops {
+	int (*add_sta)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+	int (*update_sta)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
+	int (*rm_sta)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta);
+	int (*mac_ctxt_changed)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				bool force_assoc_off);
+};
+
+int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 enum ieee80211_sta_state old_state,
+				 enum ieee80211_sta_state new_state,
+				 struct iwl_mvm_sta_state_ops *callbacks);
+
 /* New MLD STA related APIs */
 /* STA */
 int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
@@ -586,6 +625,12 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta);
+int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

