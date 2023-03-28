Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C76CB8DD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjC1H7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjC1H7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F7136
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990368; x=1711526368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=te7f9MUBa+dZ5TNKmqLklDxUA0vrWkvmgYj4gKA32Zs=;
  b=K7czYxEDWzXPsYTBziKLaHMFiMYbOEsor9y7hp06fIj+CktOV2w/szeg
   5UlvyU466VvH2P3Wu4KiVol8RYpEtYESQaaiA7iPYJsqFV7rx3JvaDB7R
   Wcdd0JKs7lomyIraEdigk9TgXJhAC2DfmtdMyqLXWyNu28CtLHSVxWtfB
   P+psPOyvTdBUDN0w05p1iS2SWngJ7xtIKr2+PMhA4UvpfK4mFcE+XjWiP
   TM2mrfj+1BnHnBtgsQvNwXRMcWOHrSoGM7kb58sl9kD3dhFQJ3KraEqMF
   PypFF3QpauaJR2Ta8RMyo720+uzhDEe81B88kzAx/n/yDZtYqGfmt/bEf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958025"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045099"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045099"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/31] wifi: iwlwifi: mvm: vif preparation for MLO
Date:   Tue, 28 Mar 2023 10:58:41 +0300
Message-Id: <20230328104948.4896576f0a9f.Ifaf0187c96b9fe52b24bd629331165831a877691@changeid>
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

In MLO, some fields of iwl_mvm_vif should be defined in the
context of a link. Define a separate structure for these fields and
add a deflink object to hold it as part of iwl_mvm_vif. Non-MLO legacy
code will use only deflink object while MLO related code will use the
corresponding link from the link array.

It follows the strategy applied in mac80211 for introducing MLO
changes.

The below spatch takes care of updating all driver code to access
fields separated into MLD specific data structure via deflink (need
to convert all references to the fields listed in var to deflink.var
and also to take care of calls like iwl_mvm_vif_from_mac80211(vif)->field).

  @iwl_mld_vif@
  struct iwl_mvm_vif *v;
  struct ieee80211_vif *vv;
  identifier fn;
  identifier var = {bssid, ap_sta_id, bcast_sta, mcast_sta,
                    beacon_stats, smps_requests, probe_resp_data,
		    he_ru_2mhz_block, cab_queue, phy_ctxt,
                    queue_params};
  @@

  (
    v->
  -    var
  +    deflink.var
  |
    fn(vv)->
  -    var
  +    deflink.var
  )

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/binding.c  |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  29 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  39 ++---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  14 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   6 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  14 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  28 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 138 ++++++++++--------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  12 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  19 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  21 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 121 ++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  22 +--
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  26 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  78 +++++-----
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  31 ++--
 23 files changed, 355 insertions(+), 308 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
index 0aac306304cb..ef50ccabcc73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2012-2014, 2020 Intel Corporation
  * Copyright (C) 2016 Intel Deutschland GmbH
+ * Copyright (C) 2022 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "fw-api.h"
@@ -75,7 +76,7 @@ static void iwl_mvm_iface_iterator(void *_data, u8 *mac,
 	if (vif == data->ignore_vif)
 		return;
 
-	if (mvmvif->phy_ctxt != data->phyctxt)
+	if (mvmvif->deflink.phy_ctxt != data->phyctxt)
 		return;
 
 	if (WARN_ON_ONCE(data->idx >= MAX_MACS_IN_BINDING))
@@ -132,7 +133,7 @@ int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
 	/*
@@ -142,7 +143,8 @@ int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (iwl_mvm_sf_update(mvm, vif, false))
 		return -EINVAL;
 
-	return iwl_mvm_binding_update(mvm, vif, mvmvif->phy_ctxt, true);
+	return iwl_mvm_binding_update(mvm, vif, mvmvif->deflink.phy_ctxt,
+				      true);
 }
 
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -150,10 +152,11 @@ int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
-	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
-	ret = iwl_mvm_binding_update(mvm, vif, mvmvif->phy_ctxt, false);
+	ret = iwl_mvm_binding_update(mvm, vif, mvmvif->deflink.phy_ctxt,
+				     false);
 
 	if (!ret)
 		if (iwl_mvm_sf_update(mvm, vif, true))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index ee3c8a786199..73ef1da3ccac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -292,7 +292,8 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 			/* ... relax constraints and disable rssi events */
 			iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_BT_COEX,
 					    smps_mode);
-			iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id,
+			iwl_mvm_bt_coex_reduced_txp(mvm,
+						    mvmvif->deflink.ap_sta_id,
 						    false);
 			iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
 		}
@@ -314,8 +315,8 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (!vif->cfg.assoc)
 		smps_mode = IEEE80211_SMPS_AUTOMATIC;
 
-	if (mvmvif->phy_ctxt &&
-	    (mvm->last_bt_notif.rrc_status & BIT(mvmvif->phy_ctxt->id)))
+	if (mvmvif->deflink.phy_ctxt &&
+	    (mvm->last_bt_notif.rrc_status & BIT(mvmvif->deflink.phy_ctxt->id)))
 		smps_mode = IEEE80211_SMPS_AUTOMATIC;
 
 	IWL_DEBUG_COEX(data->mvm,
@@ -384,7 +385,8 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT ||
 	    mvm->cfg->bt_shared_single_ant || !vif->cfg.assoc ||
 	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF) {
-		iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id, false);
+		iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
+					    false);
 		iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
 		return;
 	}
@@ -396,10 +398,12 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	if (!ave_rssi)
 		ave_rssi = -100;
 	if (ave_rssi > -IWL_MVM_BT_COEX_EN_RED_TXP_THRESH) {
-		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id, true))
+		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
+						true))
 			IWL_ERR(mvm, "Couldn't send BT_CONFIG cmd\n");
 	} else if (ave_rssi < -IWL_MVM_BT_COEX_DIS_RED_TXP_THRESH) {
-		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id, false))
+		if (iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->deflink.ap_sta_id,
+						false))
 			IWL_ERR(mvm, "Couldn't send BT_CONFIG cmd\n");
 	}
 
@@ -521,7 +525,7 @@ void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * Rssi update while not associated - can happen since the statistics
 	 * are handled asynchronously
 	 */
-	if (mvmvif->ap_sta_id == IWL_MVM_INVALID_STA)
+	if (mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA)
 		return;
 
 	/* No BT - reports should be disabled */
@@ -537,10 +541,13 @@ void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 */
 	if (rssi_event == RSSI_EVENT_LOW || mvm->cfg->bt_shared_single_ant ||
 	    iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT)
-		ret = iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id,
+		ret = iwl_mvm_bt_coex_reduced_txp(mvm,
+						  mvmvif->deflink.ap_sta_id,
 						  false);
 	else
-		ret = iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id, true);
+		ret = iwl_mvm_bt_coex_reduced_txp(mvm,
+						  mvmvif->deflink.ap_sta_id,
+						  true);
 
 	if (ret)
 		IWL_ERR(mvm, "couldn't send BT_CONFIG HCMD upon RSSI event\n");
@@ -554,7 +561,7 @@ u16 iwl_mvm_coex_agg_time_limit(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
-	struct iwl_mvm_phy_ctxt *phy_ctxt = mvmvif->phy_ctxt;
+	struct iwl_mvm_phy_ctxt *phy_ctxt = mvmvif->deflink.phy_ctxt;
 	enum iwl_bt_coex_lut_type lut_type;
 
 	if (mvm->last_bt_notif.ttc_status & BIT(phy_ctxt->id))
@@ -578,7 +585,7 @@ bool iwl_mvm_bt_coex_is_mimo_allowed(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
-	struct iwl_mvm_phy_ctxt *phy_ctxt = mvmvif->phy_ctxt;
+	struct iwl_mvm_phy_ctxt *phy_ctxt = mvmvif->deflink.phy_ctxt;
 	enum iwl_bt_coex_lut_type lut_type;
 
 	if (mvm->last_bt_notif.ttc_status & BIT(phy_ctxt->id))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c5ad34b063df..40adf789c8fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -470,7 +470,7 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
 			data.rsc->mcast_key_id_map[i] =
 				IWL_MCAST_KEY_MAP_INVALID;
-		data.rsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+		data.rsc->sta_id = cpu_to_le32(mvmvif->deflink.ap_sta_id);
 
 		ieee80211_iter_keys(mvm->hw, vif,
 				    iwl_mvm_wowlan_get_rsc_v5_data,
@@ -493,7 +493,8 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 
 		if (ver == 4) {
 			size = sizeof(*data.rsc_tsc);
-			data.rsc_tsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+			data.rsc_tsc->sta_id =
+				cpu_to_le32(mvmvif->deflink.ap_sta_id);
 		} else {
 			/* ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN */
 			size = sizeof(data.rsc_tsc->params);
@@ -691,7 +692,7 @@ static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
 
 	pattern_cmd->n_patterns = wowlan->n_patterns;
 	if (ver >= 3)
-		pattern_cmd->sta_id = mvmvif->ap_sta_id;
+		pattern_cmd->sta_id = mvmvif->deflink.ap_sta_id;
 
 	for (i = 0; i < wowlan->n_patterns; i++) {
 		int mask_len = DIV_ROUND_UP(wowlan->patterns[i].pattern_len, 8);
@@ -732,7 +733,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	/* add back the PHY */
-	if (WARN_ON(!mvmvif->phy_ctxt))
+	if (WARN_ON(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -746,7 +747,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	chains_dynamic = ctx->rx_chains_dynamic;
 	rcu_read_unlock();
 
-	ret = iwl_mvm_phy_ctxt_add(mvm, mvmvif->phy_ctxt, &chandef,
+	ret = iwl_mvm_phy_ctxt_add(mvm, mvmvif->deflink.phy_ctxt, &chandef,
 				   chains_static, chains_dynamic);
 	if (ret)
 		return ret;
@@ -763,12 +764,12 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	/* add back binding - XXX refactor? */
 	binding_cmd.id_and_color =
-		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->phy_ctxt->id,
-						mvmvif->phy_ctxt->color));
+		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->deflink.phy_ctxt->id,
+						mvmvif->deflink.phy_ctxt->color));
 	binding_cmd.action = cpu_to_le32(FW_CTXT_ACTION_ADD);
 	binding_cmd.phy =
-		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->phy_ctxt->id,
-						mvmvif->phy_ctxt->color));
+		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->deflink.phy_ctxt->id,
+						mvmvif->deflink.phy_ctxt->color));
 	binding_cmd.macs[0] = cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
 							      mvmvif->color));
 	for (i = 1; i < MAX_MACS_IN_BINDING; i++)
@@ -791,7 +792,8 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	ret = iwl_mvm_sta_send_to_fw(mvm, ap_sta, false, 0);
 	if (ret)
 		return ret;
-	rcu_assign_pointer(mvm->fw_id_to_mac_id[mvmvif->ap_sta_id], ap_sta);
+	rcu_assign_pointer(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id],
+			   ap_sta);
 
 	ret = iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 	if (ret)
@@ -800,8 +802,8 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	/* and some quota */
 	quota = iwl_mvm_quota_cmd_get_quota(mvm, &quota_cmd, 0);
 	quota->id_and_color =
-		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->phy_ctxt->id,
-						mvmvif->phy_ctxt->color));
+		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->deflink.phy_ctxt->id,
+						mvmvif->deflink.phy_ctxt->color));
 	quota->quota = cpu_to_le32(IWL_MVM_MAX_QUOTA);
 	quota->max_duration = cpu_to_le32(IWL_MVM_MAX_QUOTA);
 
@@ -1027,7 +1029,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		if (ver == 2) {
 			size = sizeof(tkip_data.tkip);
 			tkip_data.tkip.sta_id =
-				cpu_to_le32(mvmvif->ap_sta_id);
+				cpu_to_le32(mvmvif->deflink.ap_sta_id);
 		} else if (ver == 1 || ver == IWL_FW_CMD_VER_UNKNOWN) {
 			size = sizeof(struct iwl_wowlan_tkip_params_cmd_ver_1);
 		} else {
@@ -1076,7 +1078,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		kek_kck_cmd.kek_len = cpu_to_le16(mvmvif->rekey_data.kek_len);
 		kek_kck_cmd.replay_ctr = mvmvif->rekey_data.replay_ctr;
 		kek_kck_cmd.akm = cpu_to_le32(mvmvif->rekey_data.akm);
-		kek_kck_cmd.sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+		kek_kck_cmd.sta_id = cpu_to_le32(mvmvif->deflink.ap_sta_id);
 
 		if (cmd_ver == 4) {
 			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v4);
@@ -1269,7 +1271,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (mvmvif->ap_sta_id == IWL_MVM_INVALID_STA) {
+	if (mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA) {
 		/* if we're not associated, this must be netdetect */
 		if (!wowlan->nd_config) {
 			ret = 1;
@@ -1285,10 +1287,10 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	} else {
 		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
 
-		wowlan_config_cmd.sta_id = mvmvif->ap_sta_id;
+		wowlan_config_cmd.sta_id = mvmvif->deflink.ap_sta_id;
 
 		ap_sta = rcu_dereference_protected(
-			mvm->fw_id_to_mac_id[mvmvif->ap_sta_id],
+			mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id],
 			lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(ap_sta)) {
 			ret = -EINVAL;
@@ -2575,7 +2577,8 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 	/* if FW uses status notification, status shouldn't be NULL here */
 	if (!d3_data->status) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		u8 sta_id = mvm->net_detect ? IWL_MVM_INVALID_STA : mvmvif->ap_sta_id;
+		u8 sta_id = mvm->net_detect ? IWL_MVM_INVALID_STA :
+					      mvmvif->deflink.ap_sta_id;
 
 		d3_data->status = iwl_mvm_send_wowlan_get_status(mvm, sta_id);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 3779ac040ba0..3613b1fdc5d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -179,7 +179,7 @@ static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
 
 	mutex_lock(&mvm->mutex);
 
-	ap_sta_id = mvmvif->ap_sta_id;
+	ap_sta_id = mvmvif->deflink.ap_sta_id;
 
 	switch (ieee80211_vif_type_p2p(vif)) {
 	case NL80211_IFTYPE_ADHOC:
@@ -211,14 +211,14 @@ static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
 	pos += scnprintf(buf+pos, bufsz-pos, "Load: %d\n",
 			 mvm->tcm.result.load[mvmvif->id]);
 	pos += scnprintf(buf+pos, bufsz-pos, "QoS:\n");
-	for (i = 0; i < ARRAY_SIZE(mvmvif->queue_params); i++)
+	for (i = 0; i < ARRAY_SIZE(mvmvif->deflink.queue_params); i++)
 		pos += scnprintf(buf+pos, bufsz-pos,
 				 "\t%d: txop:%d - cw_min:%d - cw_max = %d - aifs = %d upasd = %d\n",
-				 i, mvmvif->queue_params[i].txop,
-				 mvmvif->queue_params[i].cw_min,
-				 mvmvif->queue_params[i].cw_max,
-				 mvmvif->queue_params[i].aifs,
-				 mvmvif->queue_params[i].uapsd);
+				 i, mvmvif->deflink.queue_params[i].txop,
+				 mvmvif->deflink.queue_params[i].cw_min,
+				 mvmvif->deflink.queue_params[i].cw_max,
+				 mvmvif->deflink.queue_params[i].aifs,
+				 mvmvif->deflink.queue_params[i].uapsd);
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    ap_sta_id != IWL_MVM_INVALID_STA) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 05f3136b1c43..379da4bec5dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -73,7 +73,7 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta;
 
 		rcu_read_lock();
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->ap_sta_id]);
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id]);
 		if (!IS_ERR_OR_NULL(sta) && sta->mfp)
 			expected_tk_len = 0;
 		rcu_read_unlock();
@@ -510,13 +510,13 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		rcu_read_lock();
 
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->ap_sta_id]);
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id]);
 		if (sta->mfp && (peer->ftm.trigger_based || peer->ftm.non_trigger_based))
 			FTM_PUT_FLAG(PMF);
 
 		rcu_read_unlock();
 
-		target->sta_id = mvmvif->ap_sta_id;
+		target->sta_id = mvmvif->deflink.ap_sta_id;
 	} else {
 		target->sta_id = IWL_MVM_INVALID_STA;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index e862d1b43f21..c37d793d6a4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -119,7 +119,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO |
 				    IWL_TOF_RESPONDER_CMD_VALID_BSSID |
 				    IWL_TOF_RESPONDER_CMD_VALID_STA_ID),
-		.sta_id = mvmvif->bcast_sta.sta_id,
+		.sta_id = mvmvif->deflink.bcast_sta.sta_id,
 	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 6);
 	int err;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 2688cb49c951..21e45f89c5f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -25,7 +25,7 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_link_config_cmd cmd = {};
 
-	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
 	/* Update SF - Disable if needed. if this fails, SF might still be on
@@ -34,9 +34,9 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (iwl_mvm_sf_update(mvm, vif, false))
 		return -EINVAL;
 
-	cmd.link_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+	cmd.link_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
-	cmd.phy_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+	cmd.phy_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
 
 	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
 
@@ -47,7 +47,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 u32 changes, bool active)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->phy_ctxt;
+	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->deflink.phy_ctxt;
 	struct iwl_link_config_cmd cmd = {};
 	u32 ht_flag, flags = 0, flags_mask = 0;
 
@@ -136,7 +136,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.frame_time_rts_th = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
 
 	/* Block 26-tone RU OFDMA transmissions */
-	if (mvmvif->he_ru_2mhz_block) {
+	if (mvmvif->deflink.he_ru_2mhz_block) {
 		flags |= LINK_FLG_RU_2MHZ_BLOCK;
 		flags_mask |= LINK_FLG_RU_2MHZ_BLOCK;
 	}
@@ -161,10 +161,10 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
-	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
-	cmd.link_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+	cmd.link_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
 	if (!ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 4d7ad91c53d4..10dc1fdbdeb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -293,15 +293,15 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		 * For TVQM this will be overwritten later with the FW assigned
 		 * queue value (when queue is enabled).
 		 */
-		mvmvif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 	}
 
-	mvmvif->bcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->mcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.bcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.mcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
 
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++)
-		mvmvif->smps_requests[i] = IEEE80211_SMPS_AUTOMATIC;
+		mvmvif->deflink.smps_requests[i] = IEEE80211_SMPS_AUTOMATIC;
 
 	return 0;
 
@@ -469,12 +469,12 @@ void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		u8 ucode_ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
 		ac[ucode_ac].cw_min =
-			cpu_to_le16(mvmvif->queue_params[i].cw_min);
+			cpu_to_le16(mvmvif->deflink.queue_params[i].cw_min);
 		ac[ucode_ac].cw_max =
-			cpu_to_le16(mvmvif->queue_params[i].cw_max);
+			cpu_to_le16(mvmvif->deflink.queue_params[i].cw_max);
 		ac[ucode_ac].edca_txop =
-			cpu_to_le16(mvmvif->queue_params[i].txop * 32);
-		ac[ucode_ac].aifsn = mvmvif->queue_params[i].aifs;
+			cpu_to_le16(mvmvif->deflink.queue_params[i].txop * 32);
+		ac[ucode_ac].aifsn = mvmvif->deflink.queue_params[i].aifs;
 		ac[ucode_ac].fifos_mask = BIT(txf);
 	}
 
@@ -944,7 +944,7 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 
 	/* Set up TX command fields */
 	tx->len = cpu_to_le16((u16)beacon->len);
-	tx->sta_id = mvmvif->bcast_sta.sta_id;
+	tx->sta_id = mvmvif->deflink.bcast_sta.sta_id;
 	tx->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
 	tx_flags = TX_CMD_FLG_SEQ_CTL | TX_CMD_FLG_TSF;
 	tx_flags |=
@@ -1214,7 +1214,7 @@ static void iwl_mvm_mac_ctxt_cmd_fill_ap(struct iwl_mvm *mvm,
 
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_STA_TYPE))
-		ctxt_ap->mcast_qid = cpu_to_le32(mvmvif->cab_queue);
+		ctxt_ap->mcast_qid = cpu_to_le32(mvmvif->deflink.cab_queue);
 
 	/*
 	 * Only set the beacon time when the MAC is being added, when we
@@ -1663,9 +1663,9 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 	    sizeof(struct ieee80211_p2p_noa_desc) + 2)
 		new_data->noa_len -= sizeof(struct ieee80211_p2p_noa_desc);
 
-	old_data = rcu_dereference_protected(mvmvif->probe_resp_data,
-					lockdep_is_held(&mvmvif->mvm->mutex));
-	rcu_assign_pointer(mvmvif->probe_resp_data, new_data);
+	old_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
+					     lockdep_is_held(&mvmvif->mvm->mutex));
+	rcu_assign_pointer(mvmvif->deflink.probe_resp_data, new_data);
 
 	if (old_data)
 		kfree_rcu(old_data, rcu_head);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 33582f4eea91..163515db6828 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -736,7 +736,7 @@ static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	    !offchannel) {
 		struct iwl_mvm_vif *mvmvif =
 			iwl_mvm_vif_from_mac80211(info->control.vif);
-		u8 ap_sta_id = READ_ONCE(mvmvif->ap_sta_id);
+		u8 ap_sta_id = READ_ONCE(mvmvif->deflink.ap_sta_id);
 
 		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
 			/* mac80211 holds rcu read lock */
@@ -921,7 +921,7 @@ static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
-		if (iwl_mvm_vif_from_mac80211(vif)->ap_sta_id ==
+		if (iwl_mvm_vif_from_mac80211(vif)->deflink.ap_sta_id ==
 				iwl_mvm_sta_from_mac80211(sta)->sta_id) {
 			struct iwl_mvm_vif *mvmvif;
 			u16 macid = iwl_mvm_vif_from_mac80211(vif)->id;
@@ -987,15 +987,16 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	mvmvif->uploaded = false;
-	mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
 
 	spin_lock_bh(&mvm->time_event_lock);
 	iwl_mvm_te_clear_data(mvm, &mvmvif->time_event_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	mvmvif->phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
 	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
-	memset(&mvmvif->probe_resp_data, 0, sizeof(mvmvif->probe_resp_data));
+	memset(&mvmvif->deflink.probe_resp_data, 0,
+	       sizeof(mvmvif->deflink.probe_resp_data));
 }
 
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
@@ -1330,7 +1331,7 @@ static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 
 		mvmvif->csa_bcn_pending = false;
 		mvmsta = iwl_mvm_sta_from_staid_protected(mvm,
-							  mvmvif->ap_sta_id);
+							  mvmvif->deflink.ap_sta_id);
 
 		if (WARN_ON(!mvmsta)) {
 			ret = -EIO;
@@ -1447,7 +1448,10 @@ bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 
 	mvmvif->mvm = mvm;
-	RCU_INIT_POINTER(mvmvif->probe_resp_data, NULL);
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
+
+	/* the first link always points to the default one */
+	mvmvif->link[0] = &mvmvif->deflink;
 
 	/*
 	 * Not much to do here. The stack will not allow interface
@@ -1457,8 +1461,8 @@ bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 
 	/* make sure that beacon statistics don't go backwards with FW reset */
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		mvmvif->beacon_stats.accu_num_beacons +=
-			mvmvif->beacon_stats.num_beacons;
+		mvmvif->deflink.beacon_stats.accu_num_beacons +=
+			mvmvif->deflink.beacon_stats.num_beacons;
 
 	/* Allocate resources for the MAC context, and add it to the fw  */
 	*ret = iwl_mvm_mac_ctxt_init(mvm, vif);
@@ -1485,6 +1489,7 @@ bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 	}
 
 	mvmvif->features |= hw->netdev_features;
+
 	return false;
 }
 
@@ -1506,7 +1511,8 @@ static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
 	 * Only queue for this station is the mcast queue,
 	 * which shouldn't be in TFD mask anyway
 	 */
-	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->mcast_sta, 0, vif->type,
+	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->deflink.mcast_sta, 0,
+					vif->type,
 					IWL_STA_MULTICAST);
 }
 
@@ -1550,13 +1556,13 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 
-		mvmvif->phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
-		if (!mvmvif->phy_ctxt) {
+		mvmvif->deflink.phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
+		if (!mvmvif->deflink.phy_ctxt) {
 			ret = -ENOSPC;
 			goto out_free_bf;
 		}
 
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->phy_ctxt);
+		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
 		ret = iwl_mvm_binding_add_vif(mvm, vif);
 		if (ret)
 			goto out_unref_phy;
@@ -1600,7 +1606,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
  out_unbind:
 	iwl_mvm_binding_remove_vif(mvm, vif);
  out_unref_phy:
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
  out_free_bf:
 	if (mvm->bf_allowed_vif == mvmvif) {
 		mvm->bf_allowed_vif = NULL;
@@ -1608,7 +1614,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
 	}
  out_remove_mac:
-	mvmvif->phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
  out_unlock:
 	mutex_unlock(&mvm->mutex);
@@ -1653,9 +1659,9 @@ bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
 		mvm->csme_vif = NULL;
 	}
 
-	probe_data = rcu_dereference_protected(mvmvif->probe_resp_data,
+	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
 					       lockdep_is_held(&mvm->mutex));
-	RCU_INIT_POINTER(mvmvif->probe_resp_data, NULL);
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 	if (probe_data)
 		kfree_rcu(probe_data, rcu_head);
 
@@ -1702,8 +1708,8 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = NULL;
 		iwl_mvm_rm_p2p_bcast_sta(mvm, vif);
 		iwl_mvm_binding_remove_vif(mvm, vif);
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
-		mvmvif->phy_ctxt = NULL;
+		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+		mvmvif->deflink.phy_ctxt = NULL;
 	}
 
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
@@ -1716,7 +1722,7 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 out:
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->mcast_sta);
+		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->deflink.mcast_sta);
 		iwl_mvm_dealloc_bcast_sta(mvm, vif);
 	}
 
@@ -2207,10 +2213,10 @@ bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
-			&mvmvif->queue_params[i].mu_edca_param_rec;
+			&mvmvif->deflink.queue_params[i].mu_edca_param_rec;
 		u8 ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
-		if (!mvmvif->queue_params[i].mu_edca) {
+		if (!mvmvif->deflink.queue_params[i].mu_edca) {
 			mu_edca_enabled = false;
 			break;
 		}
@@ -2335,7 +2341,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	flags = 0;
 
 	/* Block 26-tone RU OFDMA transmissions */
-	if (mvmvif->he_ru_2mhz_block)
+	if (mvmvif->deflink.he_ru_2mhz_block)
 		flags |= STA_CTXT_HE_RU_2MHZ_BLOCK;
 
 	/* HTC flags */
@@ -2474,7 +2480,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		     !iwlwifi_mod_params.disable_11ax) ||
 		    (vif->bss_conf.eht_support &&
 		     !iwlwifi_mod_params.disable_11be))
-			iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
+			iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->deflink.ap_sta_id);
 
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
 	}
@@ -2486,7 +2492,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	      !iwlwifi_mod_params.disable_11ax) ||
 	     (vif->bss_conf.eht_support &&
 	      !iwlwifi_mod_params.disable_11be)))
-		iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
+		iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->deflink.ap_sta_id);
 
 	/*
 	 * If we're not associated yet, take the (new) BSSID before associating
@@ -2495,22 +2501,22 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	 * branch for disassociation below.
 	 */
 	if (changes & BSS_CHANGED_BSSID && !mvmvif->associated)
-		memcpy(mvmvif->bssid, bss_conf->bssid, ETH_ALEN);
+		memcpy(mvmvif->deflink.bssid, bss_conf->bssid, ETH_ALEN);
 
-	ret = iwl_mvm_mac_ctxt_changed(mvm, vif, false, mvmvif->bssid);
+	ret = iwl_mvm_mac_ctxt_changed(mvm, vif, false, mvmvif->deflink.bssid);
 	if (ret)
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
 	/* after sending it once, adopt mac80211 data */
-	memcpy(mvmvif->bssid, bss_conf->bssid, ETH_ALEN);
+	memcpy(mvmvif->deflink.bssid, bss_conf->bssid, ETH_ALEN);
 	mvmvif->associated = vif->cfg.assoc;
 
 	if (changes & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
 			/* clear statistics to get clean beacon counter */
 			iwl_mvm_request_statistics(mvm, true);
-			memset(&mvmvif->beacon_stats, 0,
-			       sizeof(mvmvif->beacon_stats));
+			memset(&mvmvif->deflink.beacon_stats, 0,
+			       sizeof(mvmvif->deflink.beacon_stats));
 
 			/* add quota for this interface */
 			ret = iwl_mvm_update_quotas(mvm, true, NULL);
@@ -2567,7 +2573,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 						    IWL_MVM_SMPS_REQ_PROT,
 						    IEEE80211_SMPS_DYNAMIC);
 			}
-		} else if (mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
+		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
 			iwl_mvm_mei_host_disassociated(mvm);
 			/*
 			 * If update fails - SF might be running in associated
@@ -2597,12 +2603,12 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				 * the MAC is unassoc
 				 */
 				ret = iwl_mvm_rm_sta_id(mvm, vif,
-							mvmvif->ap_sta_id);
+							mvmvif->deflink.ap_sta_id);
 				if (ret)
 					IWL_ERR(mvm,
 						"failed to remove AP station\n");
 
-				mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
+				mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
 			}
 
 			/* remove quota for this interface */
@@ -3305,7 +3311,7 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 	};
 
 	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR)) {
-		mvmvif->he_ru_2mhz_block = false;
+		mvmvif->deflink.he_ru_2mhz_block = false;
 		return;
 	}
 
@@ -3317,7 +3323,7 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 	 * If there is at least one AP on radar channel that cannot
 	 * tolerate 26-tone RU UL OFDMA transmissions using HE TB PPDU.
 	 */
-	mvmvif->he_ru_2mhz_block = !iter_data.tolerated;
+	mvmvif->deflink.he_ru_2mhz_block = !iter_data.tolerated;
 }
 
 static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
@@ -3434,7 +3440,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			   sta->addr, old_state, new_state);
 
 	/* this would be a mac80211 bug ... but don't crash */
-	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) ? 0 : -EINVAL;
 
 	/*
@@ -3532,14 +3538,15 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
 
-			mvmvif->he_ru_2mhz_block = false;
+			mvmvif->deflink.he_ru_2mhz_block = false;
 			if (sta->deflink.he_cap.has_he)
 				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
 
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 		}
 
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+		iwl_mvm_rs_rate_init(mvm, sta,
+				     mvmvif->deflink.phy_ctxt->channel->band,
 				     false);
 		ret = iwl_mvm_update_sta(mvm, vif, sta);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
@@ -3563,14 +3570,16 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 		}
 
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+		iwl_mvm_rs_rate_init(mvm, sta,
+				     mvmvif->deflink.phy_ctxt->channel->band,
 				     true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		/* once we move into assoc state, need to update rate scale to
 		 * disable using wide bandwidth
 		 */
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+		iwl_mvm_rs_rate_init(mvm, sta,
+				     mvmvif->deflink.phy_ctxt->channel->band,
 				     false);
 		if (!sta->tdls) {
 			/*
@@ -3650,7 +3659,8 @@ static void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw,
 	if (changed & (IEEE80211_RC_BW_CHANGED |
 		       IEEE80211_RC_SUPP_RATES_CHANGED |
 		       IEEE80211_RC_NSS_CHANGED))
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+		iwl_mvm_rs_rate_init(mvm, sta,
+				     mvmvif->deflink.phy_ctxt->channel->band,
 				     true);
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
@@ -3666,7 +3676,7 @@ static int iwl_mvm_mac_conf_tx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	mvmvif->queue_params[ac] = *params;
+	mvmvif->deflink.queue_params[ac] = *params;
 
 	/*
 	 * No need to update right away, we'll get BSS_CHANGED_QOS
@@ -4237,7 +4247,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		phy_ctxt = &mvm->phy_ctxts[i];
-		if (phy_ctxt->ref == 0 || mvmvif->phy_ctxt == phy_ctxt)
+		if (phy_ctxt->ref == 0 || mvmvif->deflink.phy_ctxt == phy_ctxt)
 			continue;
 
 		if (phy_ctxt->ref && channel == phy_ctxt->channel) {
@@ -4249,22 +4259,22 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 			if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
 				goto out_unlock;
 
-			iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+			iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
 
 			/* Bind the P2P_DEVICE to the current PHY Context */
-			mvmvif->phy_ctxt = phy_ctxt;
+			mvmvif->deflink.phy_ctxt = phy_ctxt;
 
 			ret = iwl_mvm_binding_add_vif(mvm, vif);
 			if (WARN(ret, "Failed binding P2P_DEVICE\n"))
 				goto out_unlock;
 
-			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->phy_ctxt);
+			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
 			goto schedule_time_event;
 		}
 	}
 
 	/* Need to update the PHY context only if the ROC channel changed */
-	if (channel == mvmvif->phy_ctxt->channel)
+	if (channel == mvmvif->deflink.phy_ctxt->channel)
 		goto schedule_time_event;
 
 	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
@@ -4278,14 +4288,14 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	band_change_removal =
 		fw_has_capa(&mvm->fw->ucode_capa,
 			    IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT) &&
-		mvmvif->phy_ctxt->channel->band != chandef.chan->band;
+		mvmvif->deflink.phy_ctxt->channel->band != chandef.chan->band;
 
-	if (mvmvif->phy_ctxt->ref == 1 && !band_change_removal) {
+	if (mvmvif->deflink.phy_ctxt->ref == 1 && !band_change_removal) {
 		/*
 		 * Change the PHY context configuration as it is currently
 		 * referenced only by the P2P Device MAC (and we can modify it)
 		 */
-		ret = iwl_mvm_phy_ctxt_changed(mvm, mvmvif->phy_ctxt,
+		ret = iwl_mvm_phy_ctxt_changed(mvm, mvmvif->deflink.phy_ctxt,
 					       &chandef, 1, 1);
 		if (ret)
 			goto out_unlock;
@@ -4313,16 +4323,16 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
 			goto out_unlock;
 
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
 
 		/* Bind the P2P_DEVICE to the new allocated PHY context */
-		mvmvif->phy_ctxt = phy_ctxt;
+		mvmvif->deflink.phy_ctxt = phy_ctxt;
 
 		ret = iwl_mvm_binding_add_vif(mvm, vif);
 		if (WARN(ret, "Failed binding P2P_DEVICE\n"))
 			goto out_unlock;
 
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->phy_ctxt);
+		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
 	}
 
 schedule_time_event:
@@ -4505,7 +4515,7 @@ bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	mvmvif->phy_ctxt = phy_ctxt;
+	mvmvif->deflink.phy_ctxt = phy_ctxt;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -4609,7 +4619,7 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_power_update_mac(mvm);
 out:
 	if (ret)
-		mvmvif->phy_ctxt = NULL;
+		mvmvif->deflink.phy_ctxt = NULL;
 	return ret;
 }
 
@@ -4641,7 +4651,8 @@ bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	lockdep_assert_held(&mvm->mutex);
-	iwl_mvm_remove_time_event(mvm, mvmvif, &mvmvif->time_event_data);
+	iwl_mvm_remove_time_event(mvm, mvmvif,
+				  &mvmvif->time_event_data);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_ADHOC:
@@ -4700,7 +4711,7 @@ static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD) &&
 	    switching_chanctx)
 		return;
-	mvmvif->phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
 	iwl_mvm_power_update_mac(mvm);
 }
 
@@ -5243,7 +5254,7 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 			continue;
 
 		/* make sure only TDLS peers or the AP are flushed */
-		WARN_ON(i != mvmvif->ap_sta_id && !sta->tdls);
+		WARN_ON(i != mvmvif->deflink.ap_sta_id && !sta->tdls);
 
 		if (drop) {
 			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
@@ -5480,18 +5491,19 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	if (mvmvif->ap_sta_id != mvmsta->sta_id)
+	if (mvmvif->deflink.ap_sta_id != mvmsta->sta_id)
 		goto unlock;
 
 	if (iwl_mvm_request_statistics(mvm, false))
 		goto unlock;
 
-	sinfo->rx_beacon = mvmvif->beacon_stats.num_beacons +
-			   mvmvif->beacon_stats.accu_num_beacons;
+	sinfo->rx_beacon = mvmvif->deflink.beacon_stats.num_beacons +
+			   mvmvif->deflink.beacon_stats.accu_num_beacons;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
-	if (mvmvif->beacon_stats.avg_signal) {
+	if (mvmvif->deflink.beacon_stats.avg_signal) {
 		/* firmware only reports a value after RXing a few beacons */
-		sinfo->rx_beacon_signal_avg = mvmvif->beacon_stats.avg_signal;
+		sinfo->rx_beacon_signal_avg =
+			mvmvif->deflink.beacon_stats.avg_signal;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
 	}
  unlock:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index e27c893502f7..4eaba89ba0c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -17,7 +17,7 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
-		return BIT(mvmvif->mcast_sta.sta_id);
+		return BIT(mvmvif->deflink.mcast_sta.sta_id);
 
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -26,8 +26,8 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA)
-		return BIT(mvmvif->ap_sta_id);
+	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA)
+		return BIT(mvmvif->deflink.ap_sta_id);
 
 	/* invalid */
 	return 0;
@@ -70,8 +70,8 @@ static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 
 	rcu_read_lock();
 	if (!sta && vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
-		u8 sta_id = mvmvif->ap_sta_id;
+	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+		u8 sta_id = mvmvif->deflink.ap_sta_id;
 
 		sta = rcu_dereference_check(mvm->fw_id_to_mac_id[sta_id],
 					    lockdep_is_held(&mvm->mutex));
@@ -214,7 +214,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION ||
-		    mvmvif->ap_sta_id == IWL_MVM_INVALID_STA))
+		    mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA))
 		return;
 
 	if (!sec_key_ver)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f800bf0b6d90..fe55efce8dd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -43,13 +43,13 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	 * MAC context is bound to it at this stage.
 	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-		mvmvif->phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
-		if (!mvmvif->phy_ctxt) {
+		mvmvif->deflink.phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
+		if (!mvmvif->deflink.phy_ctxt) {
 			ret = -ENOSPC;
 			goto out_free_bf;
 		}
 
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->phy_ctxt);
+		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
 		ret = iwl_mvm_add_link(mvm, vif);
 		if (ret)
 			goto out_unref_phy;
@@ -97,7 +97,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
 	iwl_mvm_remove_link(mvm, vif);
  out_unref_phy:
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
  out_free_bf:
 	if (mvm->bf_allowed_vif == mvmvif) {
 		mvm->bf_allowed_vif = NULL;
@@ -105,7 +105,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
 	}
  out_remove_mac:
-	mvmvif->phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
+	mvmvif->link[0] = NULL;
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
  out_unlock:
 	mutex_unlock(&mvm->mutex);
@@ -129,8 +130,8 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
 				     false);
 		iwl_mvm_remove_link(mvm, vif);
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
-		mvmvif->phy_ctxt = NULL;
+		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+		mvmvif->deflink.phy_ctxt = NULL;
 	}
 
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
@@ -187,7 +188,7 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_power_update_mac(mvm);
 out:
 	if (ret)
-		mvmvif->phy_ctxt = NULL;
+		mvmvif->deflink.phy_ctxt = NULL;
 	return ret;
 }
 
@@ -230,7 +231,7 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 out:
 	if (switching_chanctx)
 		return;
-	mvmvif->phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
 	iwl_mvm_power_update_mac(mvm);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 51532b6379e2..b2a7fa09f900 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -147,7 +147,7 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
 int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *bsta = &mvmvif->bcast_sta;
+	struct iwl_mvm_int_sta *bsta = &mvmvif->deflink.bcast_sta;
 	static const u8 _baddr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 	const u8 *baddr = _baddr;
 	unsigned int wdg_timeout =
@@ -172,7 +172,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return iwl_mvm_mld_add_int_sta(mvm, bsta, queue,
 				       ieee80211_vif_type_p2p(vif),
 				       STATION_TYPE_BCAST_MGMT,
-				       mvmvif->phy_ctxt->id, baddr,
+				       mvmvif->deflink.phy_ctxt->id, baddr,
 				       IWL_MAX_TID_COUNT, &wdg_timeout);
 }
 
@@ -183,7 +183,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *msta = &mvmvif->mcast_sta;
+	struct iwl_mvm_int_sta *msta = &mvmvif->deflink.mcast_sta;
 	static const u8 _maddr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
 	const u8 *maddr = _maddr;
 	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif, false, false);
@@ -200,11 +200,11 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * changes in mac80211 layer.
 	 */
 	if (vif->type == NL80211_IFTYPE_ADHOC)
-		mvmvif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 
-	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvmvif->cab_queue,
+	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvmvif->deflink.cab_queue,
 				       vif->type, STATION_TYPE_MCAST,
-				       mvmvif->phy_ctxt->id, maddr, 0,
+				       mvmvif->deflink.phy_ctxt->id, maddr, 0,
 				       &timeout);
 }
 
@@ -219,7 +219,7 @@ int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	return iwl_mvm_mld_add_int_sta(mvm, &mvm->snif_sta, &mvm->snif_queue,
 				       vif->type, STATION_TYPE_BCAST_MGMT,
-				       mvmvif->phy_ctxt->id, NULL,
+				       mvmvif->deflink.phy_ctxt->id, NULL,
 				       IWL_MAX_TID_COUNT, NULL);
 }
 
@@ -305,7 +305,7 @@ int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		return -EINVAL;
 	}
 
-	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->bcast_sta, true,
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->deflink.bcast_sta, true,
 				      IWL_MAX_TID_COUNT, queueptr);
 }
 
@@ -318,8 +318,9 @@ int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->mcast_sta, true, 0,
-				      &mvmvif->cab_queue);
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->deflink.mcast_sta, true,
+				      0,
+				      &mvmvif->deflink.cab_queue);
 }
 
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cea94250d197..72056cccc77e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -280,12 +280,55 @@ struct iwl_probe_resp_data {
 	int noa_len;
 };
 
+/**
+ * struct iwl_mvm_vif_link_info - per link data in Virtual Interface
+ * @ap_sta_id: the sta_id of the AP - valid only if VIF type is STA
+ * @bssid: BSSID for this (client) interface
+ * @bcast_sta: station used for broadcast packets. Used by the following
+ *	vifs: P2P_DEVICE, GO and AP.
+ * @beacon_stats: beacon statistics, containing the # of received beacons,
+ *	# of received beacons accumulated over FW restart, and the current
+ *	average signal of beacons retrieved from the firmware
+ * @smps_requests: the SMPS requests of different parts of the driver,
+ *	combined on update to yield the overall request to mac80211.
+ * @probe_resp_data: data from FW notification to store NOA and CSA related
+ *	data to be inserted into probe response.
+ * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked
+ * @queue_params: QoS params for this MAC
+ */
+struct iwl_mvm_vif_link_info {
+	u8 bssid[ETH_ALEN];
+	u8 ap_sta_id;
+
+	struct iwl_mvm_int_sta bcast_sta;
+	struct iwl_mvm_int_sta mcast_sta;
+
+	struct {
+		u32 num_beacons, accu_num_beacons;
+		u8 avg_signal;
+	} beacon_stats;
+
+	enum ieee80211_smps_mode smps_requests[NUM_IWL_MVM_SMPS_REQ];
+	struct iwl_probe_resp_data __rcu *probe_resp_data;
+
+	bool he_ru_2mhz_block;
+
+	u16 cab_queue;
+	/* Assigned while mac80211 has the link in a channel context,
+	 * or, for P2P Device, while it exists.
+	 */
+	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	/* QoS data from mac80211, need to store this here
+	 * as mac80211 has a separate callback but we need
+	 * to have the data for the MAC context
+	 */
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
  * @id: between 0 and 3
  * @color: to solve races upon MAC addition and removal
- * @ap_sta_id: the sta_id of the AP - valid only if VIF type is STA
- * @bssid: BSSID for this (client) interface
  * @associated: indicates that we're currently associated, used only for
  *	managing the firmware state in iwl_mvm_bss_info_changed_station()
  * @ap_assoc_sta_count: count of stations associated to us - valid only
@@ -293,7 +336,7 @@ struct iwl_probe_resp_data {
  * @uploaded: indicates the MAC context has been added to the device
  * @ap_ibss_active: indicates that AP/IBSS is configured and that the interface
  *	should get quota etc.
- * @pm_enabled - Indicate if MAC power management is allowed
+ * @pm_enabled - indicate if MAC power management is allowed
  * @monitor_active: indicates that monitor context is configured, and that the
  *	interface should get quota etc.
  * @low_latency: bit flags for low latency
@@ -302,68 +345,31 @@ struct iwl_probe_resp_data {
  *	as a result from low_latency bit flags and takes force into account.
  * @authorized: indicates the AP station was set to authorized
  * @ps_disabled: indicates that this interface requires PS to be disabled
- * @queue_params: QoS params for this MAC
- * @bcast_sta: station used for broadcast packets. Used by the following
- *  vifs: P2P_DEVICE, GO and AP.
- * @beacon_skb: the skb used to hold the AP/GO beacon template
- * @smps_requests: the SMPS requests of different parts of the driver,
- *	combined on update to yield the overall request to mac80211.
- * @beacon_stats: beacon statistics, containing the # of received beacons,
- *	# of received beacons accumulated over FW restart, and the current
- *	average signal of beacons retrieved from the firmware
+ * @csa_countdown: indicates that CSA countdown may be started
  * @csa_failed: CSA failed to schedule time event, report an error later
+ * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
- * @probe_resp_data: data from FW notification to store NOA and CSA related
- *	data to be inserted into probe response.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
 	u16 id;
 	u16 color;
-	u8 ap_sta_id;
 
-	u8 bssid[ETH_ALEN];
 	bool associated;
 	u8 ap_assoc_sta_count;
-
-	u16 cab_queue;
-
 	bool uploaded;
 	bool ap_ibss_active;
 	bool pm_enabled;
 	bool monitor_active;
+
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
+
 	u8 authorized:1;
 	bool ps_disabled;
-	struct iwl_mvm_vif_bf_data bf_data;
-
-	struct {
-		u32 num_beacons, accu_num_beacons;
-		u8 avg_signal;
-	} beacon_stats;
 
 	u32 ap_beacon_time;
-
-	enum iwl_tsf_id tsf_id;
-
-	/*
-	 * QoS data from mac80211, need to store this here
-	 * as mac80211 has a separate callback but we need
-	 * to have the data for the MAC context
-	 */
-	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
-	struct iwl_mvm_time_event_data time_event_data;
-	struct iwl_mvm_time_event_data hs_time_event_data;
-
-	struct iwl_mvm_int_sta bcast_sta;
-	struct iwl_mvm_int_sta mcast_sta;
-
-	/*
-	 * Assigned while mac80211 has the interface in a channel context,
-	 * or, for P2P Device, while it exists.
-	 */
-	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	struct iwl_mvm_vif_bf_data bf_data;
 
 #ifdef CONFIG_PM
 	/* WoWLAN GTK rekey data */
@@ -399,40 +405,43 @@ struct iwl_mvm_vif {
 	int dbgfs_quota_min;
 #endif
 
-	enum ieee80211_smps_mode smps_requests[NUM_IWL_MVM_SMPS_REQ];
-
 	/* FW identified misbehaving AP */
 	u8 uapsd_misbehaving_bssid[ETH_ALEN];
-
 	struct delayed_work uapsd_nonagg_detected_wk;
 
-	/* Indicates that CSA countdown may be started */
 	bool csa_countdown;
 	bool csa_failed;
+	bool csa_bcn_pending;
 	u16 csa_target_freq;
 	u16 csa_count;
 	u16 csa_misbehave;
 	struct delayed_work csa_work;
 
-	/* Indicates that we are waiting for a beacon on a new channel */
-	bool csa_bcn_pending;
+	enum iwl_tsf_id tsf_id;
+
+	struct iwl_mvm_time_event_data time_event_data;
+	struct iwl_mvm_time_event_data hs_time_event_data;
 
 	/* TCP Checksum Offload */
 	netdev_features_t features;
 
-	struct iwl_probe_resp_data __rcu *probe_resp_data;
-
 	/* we can only have 2 GTK + 2 IGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[4];
 
-	/* 26-tone RU OFDMA transmissions should be blocked */
-	bool he_ru_2mhz_block;
-
 	struct {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
+
+	struct iwl_mvm_vif_link_info deflink;
+	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
+#define for_each_mvm_vif_valid_link(mvm_vif, link_id)			\
+	for (link_id = 0;						\
+	     link_id < ARRAY_SIZE((mvm_vif)->link);			\
+	     link_id++)							\
+		if ((mvm_vif)->link[link_id])
+
 static inline struct iwl_mvm_vif *
 iwl_mvm_vif_from_mac80211(struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 06f4203fb989..3ab6fb83a175 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -382,12 +382,12 @@ static void iwl_mvm_binding_iterator(void *_data, u8 *mac,
 	unsigned long *data = _data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (!mvmvif->phy_ctxt)
+	if (!mvmvif->deflink.phy_ctxt)
 		return;
 
 	if (vif->type == NL80211_IFTYPE_STATION ||
 	    vif->type == NL80211_IFTYPE_AP)
-		__set_bit(mvmvif->phy_ctxt->id, data);
+		__set_bit(mvmvif->deflink.phy_ctxt->id, data);
 }
 
 int iwl_mvm_phy_ctx_count(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index f5744162d0d8..6e2e3127843f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -150,7 +150,7 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 #endif
 
 	for (ac = IEEE80211_AC_VO; ac <= IEEE80211_AC_BK; ac++) {
-		if (!mvmvif->queue_params[ac].uapsd)
+		if (!mvmvif->deflink.queue_params[ac].uapsd)
 			continue;
 
 		if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
@@ -160,7 +160,7 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 		cmd->uapsd_ac_flags |= BIT(ac);
 
 		/* QNDP TID - the highest TID with no admission control */
-		if (!tid_found && !mvmvif->queue_params[ac].acm) {
+		if (!tid_found && !mvmvif->deflink.queue_params[ac].acm) {
 			tid_found = true;
 			switch (ac) {
 			case IEEE80211_AC_VO:
@@ -509,8 +509,9 @@ static void iwl_mvm_power_uapsd_misbehav_ap_iterator(void *_data, u8 *mac,
 	/* The ap_sta_id is not expected to change during current association
 	 * so no explicit protection is needed
 	 */
-	if (mvmvif->ap_sta_id == *ap_sta_id)
-		memcpy(mvmvif->uapsd_misbehaving_bssid, vif->bss_conf.bssid,
+	if (mvmvif->deflink.ap_sta_id == *ap_sta_id)
+		memcpy(mvmvif->uapsd_misbehaving_bssid,
+		       vif->bss_conf.bssid,
 		       ETH_ALEN);
 }
 
@@ -552,7 +553,8 @@ static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8* mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	bool *disable_ps = _data;
 
-	if (mvmvif->phy_ctxt && mvmvif->phy_ctxt->id < NUM_PHY_CTX)
+	if (mvmvif->deflink.phy_ctxt &&
+	    mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX)
 		*disable_ps |= mvmvif->ps_disabled;
 }
 
@@ -561,7 +563,7 @@ static void iwl_mvm_power_get_vifs_iterator(void *_data, u8 *mac,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_power_vifs *power_iterator = _data;
-	bool active = mvmvif->phy_ctxt && mvmvif->phy_ctxt->id < NUM_PHY_CTX;
+	bool active = mvmvif->deflink.phy_ctxt && mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX;
 
 	if (!mvmvif->uploaded)
 		return;
@@ -649,11 +651,11 @@ static void iwl_mvm_power_set_pm(struct iwl_mvm *mvm,
 	}
 
 	if (vifs->bss_active && vifs->p2p_active)
-		client_same_channel = (bss_mvmvif->phy_ctxt->id ==
-				       p2p_mvmvif->phy_ctxt->id);
+		client_same_channel = (bss_mvmvif->deflink.phy_ctxt->id ==
+				       p2p_mvmvif->deflink.phy_ctxt->id);
 	if (vifs->bss_active && vifs->ap_active)
-		ap_same_channel = (bss_mvmvif->phy_ctxt->id ==
-				   ap_mvmvif->phy_ctxt->id);
+		ap_same_channel = (bss_mvmvif->deflink.phy_ctxt->id ==
+				   ap_mvmvif->deflink.phy_ctxt->id);
 
 	/* clients are not stand alone: enable PM if DCM */
 	if (!(client_same_channel || ap_same_channel)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
index cea1a34f9130..aad2614af9ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
@@ -33,11 +33,11 @@ static void iwl_mvm_quota_iterator(void *_data, u8 *mac,
 	if (vif == data->disabled_vif)
 		return;
 
-	if (!mvmvif->phy_ctxt)
+	if (!mvmvif->deflink.phy_ctxt)
 		return;
 
 	/* currently, PHY ID == binding ID */
-	id = mvmvif->phy_ctxt->id;
+	id = mvmvif->deflink.phy_ctxt->id;
 
 	/* need at least one binding per PHY */
 	BUILD_BUG_ON(NUM_PHY_CTX > MAX_BINDINGS);
@@ -67,9 +67,10 @@ static void iwl_mvm_quota_iterator(void *_data, u8 *mac,
 	}
 
 	if (data->colors[id] < 0)
-		data->colors[id] = mvmvif->phy_ctxt->color;
+		data->colors[id] = mvmvif->deflink.phy_ctxt->color;
 	else
-		WARN_ON_ONCE(data->colors[id] != mvmvif->phy_ctxt->color);
+		WARN_ON_ONCE(data->colors[id] !=
+			     mvmvif->deflink.phy_ctxt->color);
 
 	data->n_interfaces[id]++;
 
@@ -99,7 +100,7 @@ static void iwl_mvm_adjust_quota_for_noa(struct iwl_mvm *mvm,
 	if (!mvmvif->ap_ibss_active)
 		return;
 
-	phy_id = mvmvif->phy_ctxt->id;
+	phy_id = mvmvif->deflink.phy_ctxt->id;
 	beacon_int = mvm->noa_vif->bss_conf.beacon_int;
 
 	for (i = 0; i < MAX_BINDINGS; i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d2ce414879aa..4105b79db467 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -237,11 +237,11 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 
 	if (mdata->opened_rx_ba_sessions ||
 	    mdata->uapsd_nonagg_detect.detected ||
-	    (!mvmvif->queue_params[IEEE80211_AC_VO].uapsd &&
-	     !mvmvif->queue_params[IEEE80211_AC_VI].uapsd &&
-	     !mvmvif->queue_params[IEEE80211_AC_BE].uapsd &&
-	     !mvmvif->queue_params[IEEE80211_AC_BK].uapsd) ||
-	    mvmsta->sta_id != mvmvif->ap_sta_id)
+	    (!mvmvif->deflink.queue_params[IEEE80211_AC_VO].uapsd &&
+	     !mvmvif->deflink.queue_params[IEEE80211_AC_VI].uapsd &&
+	     !mvmvif->deflink.queue_params[IEEE80211_AC_BE].uapsd &&
+	     !mvmvif->deflink.queue_params[IEEE80211_AC_BK].uapsd) ||
+	    mvmsta->sta_id != mvmvif->deflink.ap_sta_id)
 		return;
 
 	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
@@ -628,9 +628,9 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 	 * data copied into the "data" struct, but rather the data from
 	 * the notification directly.
 	 */
-	mvmvif->beacon_stats.num_beacons =
+	mvmvif->deflink.beacon_stats.num_beacons =
 		le32_to_cpu(data->beacon_counter[vif_id]);
-	mvmvif->beacon_stats.avg_signal =
+	mvmvif->deflink.beacon_stats.avg_signal =
 		-data->beacon_average_energy[vif_id];
 
 	if (mvmvif->id != id)
@@ -643,8 +643,8 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 	 * request to clear statistics
 	 */
 	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
-		mvmvif->beacon_stats.accu_num_beacons +=
-			mvmvif->beacon_stats.num_beacons;
+		mvmvif->deflink.beacon_stats.accu_num_beacons +=
+			mvmvif->deflink.beacon_stats.num_beacons;
 
 	iwl_mvm_update_vif_sig(vif, sig);
 }
@@ -666,17 +666,17 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 
 	mac_stats = &data->per_mac_stats[vif_id];
 
-	mvmvif->beacon_stats.num_beacons =
+	mvmvif->deflink.beacon_stats.num_beacons =
 		le32_to_cpu(mac_stats->beacon_counter);
-	mvmvif->beacon_stats.avg_signal =
+	mvmvif->deflink.beacon_stats.avg_signal =
 		-le32_to_cpu(mac_stats->beacon_average_energy);
 
 	/* make sure that beacon statistics don't go backwards with TCM
 	 * request to clear statistics
 	 */
 	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
-		mvmvif->beacon_stats.accu_num_beacons +=
-			mvmvif->beacon_stats.num_beacons;
+		mvmvif->deflink.beacon_stats.accu_num_beacons +=
+			mvmvif->deflink.beacon_stats.num_beacons;
 
 	sig = -le32_to_cpu(mac_stats->beacon_filter_average_energy);
 	iwl_mvm_update_vif_sig(vif, sig);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index acd8803dbcdd..975edc02e637 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -193,8 +193,9 @@ static void iwl_mvm_scan_iterator(void *_data, u8 *mac,
 	struct iwl_mvm_scan_iter_data *data = _data;
 	struct iwl_mvm_vif *curr_mvmvif;
 
-	if (vif->type != NL80211_IFTYPE_P2P_DEVICE && mvmvif->phy_ctxt &&
-	    mvmvif->phy_ctxt->id < NUM_PHY_CTX)
+	if (vif->type != NL80211_IFTYPE_P2P_DEVICE &&
+	    mvmvif->deflink.phy_ctxt &&
+	    mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX)
 		data->global_cnt += 1;
 
 	if (!data->current_vif || vif == data->current_vif)
@@ -203,8 +204,8 @@ static void iwl_mvm_scan_iterator(void *_data, u8 *mac,
 	curr_mvmvif = iwl_mvm_vif_from_mac80211(data->current_vif);
 
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
-	    mvmvif->phy_ctxt && curr_mvmvif->phy_ctxt &&
-	    mvmvif->phy_ctxt->id != curr_mvmvif->phy_ctxt->id)
+	    mvmvif->deflink.phy_ctxt && curr_mvmvif->deflink.phy_ctxt &&
+	    mvmvif->deflink.phy_ctxt->id != curr_mvmvif->deflink.phy_ctxt->id)
 		data->is_dcm_with_p2p_go = true;
 }
 
@@ -2677,9 +2678,9 @@ static void iwl_mvm_scan_respect_p2p_go_iter(void *_data, u8 *mac,
 		return;
 
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
-	    mvmvif->phy_ctxt->id < NUM_PHY_CTX &&
+	    mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX &&
 	    (data->band == NUM_NL80211_BANDS ||
-	     mvmvif->phy_ctxt->channel->band == data->band))
+	     mvmvif->deflink.phy_ctxt->channel->band == data->band))
 		data->p2p_go = true;
 }
 
@@ -2980,7 +2981,7 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 			.scan_start_tsf = mvm->scan_start,
 		};
 
-		memcpy(info.tsf_bssid, mvm->scan_vif->bssid, ETH_ALEN);
+		memcpy(info.tsf_bssid, mvm->scan_vif->deflink.bssid, ETH_ALEN);
 		ieee80211_scan_completed(mvm->hw, &info);
 		mvm->scan_vif = NULL;
 		cancel_delayed_work(&mvm->scan_timeout_dwork);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 1f4ac1e93cee..84b750d02848 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -23,14 +23,14 @@ static void iwl_mvm_bound_iface_iterator(void *_data, u8 *mac,
 	struct iwl_mvm_active_iface_iterator_data *data = _data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (vif == data->ignore_vif || !mvmvif->phy_ctxt ||
+	if (vif == data->ignore_vif || !mvmvif->deflink.phy_ctxt ||
 	    vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		return;
 
 	data->num_active_macs++;
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		data->sta_vif_ap_sta_id = mvmvif->ap_sta_id;
+		data->sta_vif_ap_sta_id = mvmvif->deflink.ap_sta_id;
 		if (vif->cfg.assoc)
 			data->sta_vif_state = SF_FULL_ON;
 		else
@@ -264,7 +264,7 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 			} else if (changed_vif->cfg.assoc &&
 				   changed_vif->bss_conf.dtim_period) {
 				mvmvif = iwl_mvm_vif_from_mac80211(changed_vif);
-				sta_id = mvmvif->ap_sta_id;
+				sta_id = mvmvif->deflink.ap_sta_id;
 				new_state = SF_FULL_ON;
 			} else {
 				new_state = SF_INIT_OFF;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ec843f1b0165..c3b81021898b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1785,10 +1785,10 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		if (!sta->tdls) {
-			WARN_ON(mvmvif->ap_sta_id != IWL_MVM_INVALID_STA);
-			mvmvif->ap_sta_id = sta_id;
+			WARN_ON(mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA);
+			mvmvif->deflink.ap_sta_id = sta_id;
 		} else {
-			WARN_ON(mvmvif->ap_sta_id == IWL_MVM_INVALID_STA);
+			WARN_ON(mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA);
 		}
 	}
 
@@ -1953,7 +1953,7 @@ static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->ap_sta_id == sta_id) {
+	    mvmvif->deflink.ap_sta_id == sta_id) {
 		/* if associated - we can't remove the AP STA now */
 		if (vif->cfg.assoc)
 			return true;
@@ -1962,7 +1962,7 @@ static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		iwl_mvm_sec_key_remove_ap(mvm, vif);
 
 		/* unassoc - go ahead - remove the AP STA now */
-		mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
+		mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
 	}
 
 	/*
@@ -2227,7 +2227,7 @@ void iwl_mvm_dealloc_snif_sta(struct iwl_mvm *mvm)
 int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *bsta = &mvmvif->bcast_sta;
+	struct iwl_mvm_int_sta *bsta = &mvmvif->deflink.bcast_sta;
 	static const u8 _baddr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 	const u8 *baddr = _baddr;
 	int queue;
@@ -2236,7 +2236,7 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = IWL_MVM_TX_FIFO_VO,
-		.sta_id = mvmvif->bcast_sta.sta_id,
+		.sta_id = mvmvif->deflink.bcast_sta.sta_id,
 		.tid = IWL_MAX_TID_COUNT,
 		.aggregate = false,
 		.frame_limit = IWL_FRAME_LIMIT,
@@ -2302,7 +2302,7 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true);
+	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta, true);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -2319,13 +2319,13 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 	}
 
 	queue = *queueptr;
-	iwl_mvm_disable_txq(mvm, NULL, mvmvif->bcast_sta.sta_id,
+	iwl_mvm_disable_txq(mvm, NULL, mvmvif->deflink.bcast_sta.sta_id,
 			    queueptr, IWL_MAX_TID_COUNT);
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return;
 
-	WARN_ON(!(mvmvif->bcast_sta.tfd_queue_msk & BIT(queue)));
-	mvmvif->bcast_sta.tfd_queue_msk &= ~BIT(queue);
+	WARN_ON(!(mvmvif->deflink.bcast_sta.tfd_queue_msk & BIT(queue)));
+	mvmvif->deflink.bcast_sta.tfd_queue_msk &= ~BIT(queue);
 }
 
 /* Send the FW a request to remove the station from it's internal data
@@ -2339,7 +2339,7 @@ int iwl_mvm_send_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	iwl_mvm_free_bcast_sta_queues(mvm, vif);
 
-	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->bcast_sta.sta_id);
+	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->deflink.bcast_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
 	return ret;
@@ -2351,7 +2351,7 @@ int iwl_mvm_alloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->bcast_sta, 0,
+	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->deflink.bcast_sta, 0,
 					ieee80211_vif_type_p2p(vif),
 					IWL_STA_GENERAL_PURPOSE);
 }
@@ -2366,7 +2366,7 @@ int iwl_mvm_alloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 int iwl_mvm_add_p2p_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *bsta = &mvmvif->bcast_sta;
+	struct iwl_mvm_int_sta *bsta = &mvmvif->deflink.bcast_sta;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -2387,7 +2387,7 @@ void iwl_mvm_dealloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	iwl_mvm_dealloc_int_sta(mvm, &mvmvif->bcast_sta);
+	iwl_mvm_dealloc_int_sta(mvm, &mvmvif->deflink.bcast_sta);
 }
 
 /*
@@ -2418,7 +2418,7 @@ int iwl_mvm_rm_p2p_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_int_sta *msta = &mvmvif->mcast_sta;
+	struct iwl_mvm_int_sta *msta = &mvmvif->deflink.mcast_sta;
 	static const u8 _maddr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
 	const u8 *maddr = _maddr;
 	struct iwl_trans_txq_scd_cfg cfg = {
@@ -2445,7 +2445,7 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * changes in mac80211 layer.
 	 */
 	if (vif->type == NL80211_IFTYPE_ADHOC)
-		mvmvif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 
 	/*
 	 * While in previous FWs we had to exclude cab queue from TFD queue
@@ -2453,9 +2453,10 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 */
 	if (!iwl_mvm_has_new_tx_api(mvm) &&
 	    fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_STA_TYPE)) {
-		iwl_mvm_enable_txq(mvm, NULL, mvmvif->cab_queue, 0, &cfg,
+		iwl_mvm_enable_txq(mvm, NULL, mvmvif->deflink.cab_queue, 0,
+				   &cfg,
 				   timeout);
-		msta->tfd_queue_msk |= BIT(mvmvif->cab_queue);
+		msta->tfd_queue_msk |= BIT(mvmvif->deflink.cab_queue);
 	}
 	ret = iwl_mvm_add_int_sta_common(mvm, msta, maddr,
 					 mvmvif->id, mvmvif->color);
@@ -2476,10 +2477,11 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			ret = queue;
 			goto err;
 		}
-		mvmvif->cab_queue = queue;
+		mvmvif->deflink.cab_queue = queue;
 	} else if (!fw_has_api(&mvm->fw->ucode_capa,
 			       IWL_UCODE_TLV_API_STA_TYPE))
-		iwl_mvm_enable_txq(mvm, NULL, mvmvif->cab_queue, 0, &cfg,
+		iwl_mvm_enable_txq(mvm, NULL, mvmvif->deflink.cab_queue, 0,
+				   &cfg,
 				   timeout);
 
 	return 0;
@@ -2552,12 +2554,12 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true);
+	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.mcast_sta, true);
 
-	iwl_mvm_disable_txq(mvm, NULL, mvmvif->mcast_sta.sta_id,
-			    &mvmvif->cab_queue, 0);
+	iwl_mvm_disable_txq(mvm, NULL, mvmvif->deflink.mcast_sta.sta_id,
+			    &mvmvif->deflink.cab_queue, 0);
 
-	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->mcast_sta.sta_id);
+	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->deflink.mcast_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
 
@@ -3383,8 +3385,8 @@ static struct iwl_mvm_sta *iwl_mvm_get_key_sta(struct iwl_mvm *mvm,
 	 * station ID, then use AP's station ID.
 	 */
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
-		u8 sta_id = mvmvif->ap_sta_id;
+	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+		u8 sta_id = mvmvif->deflink.ap_sta_id;
 
 		sta = rcu_dereference_check(mvm->fw_id_to_mac_id[sta_id],
 					    lockdep_is_held(&mvm->mutex));
@@ -3661,8 +3663,8 @@ static inline u8 *iwl_mvm_get_mac_addr(struct iwl_mvm *mvm,
 		return sta->addr;
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
-		u8 sta_id = mvmvif->ap_sta_id;
+	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+		u8 sta_id = mvmvif->deflink.ap_sta_id;
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
 						lockdep_is_held(&mvm->mutex));
 		return sta->addr;
@@ -3694,7 +3696,7 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 		   !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		sta_id = mvmvif->mcast_sta.sta_id;
+		sta_id = mvmvif->deflink.mcast_sta.sta_id;
 	} else {
 		IWL_ERR(mvm, "Failed to find station id\n");
 		return -EINVAL;
@@ -3759,7 +3761,7 @@ int iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 	} else {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		sta_id = mvmvif->mcast_sta.sta_id;
+		sta_id = mvmvif->deflink.mcast_sta.sta_id;
 	}
 
 	if (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
@@ -3834,7 +3836,7 @@ int iwl_mvm_remove_sta_key(struct iwl_mvm *mvm,
 	if (mvm_sta)
 		sta_id = mvm_sta->sta_id;
 	else if (!sta && vif->type == NL80211_IFTYPE_AP && mcast)
-		sta_id = iwl_mvm_vif_from_mac80211(vif)->mcast_sta.sta_id;
+		sta_id = iwl_mvm_vif_from_mac80211(vif)->deflink.mcast_sta.sta_id;
 
 
 	IWL_DEBUG_WEP(mvm, "mvm remove dynamic key: idx=%d sta=%d\n",
@@ -4113,17 +4115,19 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 		return;
 
 	/* Need to block/unblock also multicast station */
-	if (mvmvif->mcast_sta.sta_id != IWL_MVM_INVALID_STA)
+	if (mvmvif->deflink.mcast_sta.sta_id != IWL_MVM_INVALID_STA)
 		iwl_mvm_int_sta_modify_disable_tx(mvm, mvmvif,
-						  &mvmvif->mcast_sta, disable);
+						  &mvmvif->deflink.mcast_sta,
+						  disable);
 
 	/*
 	 * Only unblock the broadcast station (FW blocks it for immediate
 	 * quiet, not the driver)
 	 */
-	if (!disable && mvmvif->bcast_sta.sta_id != IWL_MVM_INVALID_STA)
+	if (!disable && mvmvif->deflink.bcast_sta.sta_id != IWL_MVM_INVALID_STA)
 		iwl_mvm_int_sta_modify_disable_tx(mvm, mvmvif,
-						  &mvmvif->bcast_sta, disable);
+						  &mvmvif->deflink.bcast_sta,
+						  disable);
 }
 
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -4133,7 +4137,7 @@ void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	rcu_read_lock();
 
-	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->ap_sta_id);
+	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->deflink.ap_sta_id);
 
 	if (mvmsta)
 		iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, true);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e403a240a82f..3b17dd998d19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -79,7 +79,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 
 		if (!WARN_ON(!mvm->p2p_device_vif)) {
 			mvmvif = iwl_mvm_vif_from_mac80211(mvm->p2p_device_vif);
-			iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true);
+			iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta,
+					  true);
 		}
 	}
 
@@ -170,7 +171,8 @@ static bool iwl_mvm_te_check_disconnect(struct iwl_mvm *mvm,
 		struct iwl_mvm_sta *mvmsta;
 
 		rcu_read_lock();
-		mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->ap_sta_id);
+		mvmsta = iwl_mvm_sta_from_staid_rcu(mvm,
+						    mvmvif->deflink.ap_sta_id);
 		if (!WARN_ON(!mvmsta))
 			iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, false);
 		rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6e2e0791d848..890fe93896ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -631,7 +631,7 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 
 		if (!ieee80211_has_order(fc) && !ieee80211_is_probe_req(fc) &&
 		    is_multicast_ether_addr(hdr->addr1))
-			return mvmvif->cab_queue;
+			return mvmvif->deflink.cab_queue;
 
 		WARN_ONCE(info->control.vif->type != NL80211_IFTYPE_ADHOC,
 			  "fc=0x%02x", le16_to_cpu(fc));
@@ -668,7 +668,7 @@ static void iwl_mvm_probe_resp_set_noa(struct iwl_mvm *mvm,
 
 	rcu_read_lock();
 
-	resp_data = rcu_dereference(mvmvif->probe_resp_data);
+	resp_data = rcu_dereference(mvmvif->deflink.probe_resp_data);
 	if (!resp_data)
 		goto out;
 
@@ -740,9 +740,9 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 		    info.control.vif->type == NL80211_IFTYPE_AP ||
 		    info.control.vif->type == NL80211_IFTYPE_ADHOC) {
 			if (!ieee80211_is_data(hdr->frame_control))
-				sta_id = mvmvif->bcast_sta.sta_id;
+				sta_id = mvmvif->deflink.bcast_sta.sta_id;
 			else
-				sta_id = mvmvif->mcast_sta.sta_id;
+				sta_id = mvmvif->deflink.mcast_sta.sta_id;
 
 			queue = iwl_mvm_get_ctrl_vif_queue(mvm, &info, hdr);
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 14b2de65bd84..c1f6dd8f7d10 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -294,13 +294,13 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	mvmvif->smps_requests[req_type] = smps_request;
+	mvmvif->deflink.smps_requests[req_type] = smps_request;
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
-		if (mvmvif->smps_requests[i] == IEEE80211_SMPS_STATIC) {
+		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_STATIC) {
 			smps_mode = IEEE80211_SMPS_STATIC;
 			break;
 		}
-		if (mvmvif->smps_requests[i] == IEEE80211_SMPS_DYNAMIC)
+		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_DYNAMIC)
 			smps_mode = IEEE80211_SMPS_DYNAMIC;
 	}
 
@@ -392,12 +392,12 @@ static void iwl_mvm_diversity_iter(void *_data, u8 *mac,
 	struct iwl_mvm_diversity_iter_data *data = _data;
 	int i;
 
-	if (mvmvif->phy_ctxt != data->ctxt)
+	if (mvmvif->deflink.phy_ctxt != data->ctxt)
 		return;
 
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
-		if (mvmvif->smps_requests[i] == IEEE80211_SMPS_STATIC ||
-		    mvmvif->smps_requests[i] == IEEE80211_SMPS_DYNAMIC) {
+		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_STATIC ||
+		    mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_DYNAMIC) {
 			data->result = false;
 			break;
 		}
@@ -495,10 +495,10 @@ static void iwl_mvm_ll_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 	if (iwl_mvm_vif_low_latency(mvmvif)) {
 		result->result = true;
 
-		if (!mvmvif->phy_ctxt)
+		if (!mvmvif->deflink.phy_ctxt)
 			return;
 
-		band = mvmvif->phy_ctxt->channel->band;
+		band = mvmvif->deflink.phy_ctxt->channel->band;
 		result->result_per_band[band] = true;
 	}
 }
@@ -819,10 +819,10 @@ static void iwl_mvm_uapsd_agg_disconnect(struct iwl_mvm *mvm,
 	if (!vif->cfg.assoc)
 		return;
 
-	if (!mvmvif->queue_params[IEEE80211_AC_VO].uapsd &&
-	    !mvmvif->queue_params[IEEE80211_AC_VI].uapsd &&
-	    !mvmvif->queue_params[IEEE80211_AC_BE].uapsd &&
-	    !mvmvif->queue_params[IEEE80211_AC_BK].uapsd)
+	if (!mvmvif->deflink.queue_params[IEEE80211_AC_VO].uapsd &&
+	    !mvmvif->deflink.queue_params[IEEE80211_AC_VI].uapsd &&
+	    !mvmvif->deflink.queue_params[IEEE80211_AC_BE].uapsd &&
+	    !mvmvif->deflink.queue_params[IEEE80211_AC_BK].uapsd)
 		return;
 
 	if (mvm->tcm.data[mvmvif->id].uapsd_nonagg_detect.detected)
@@ -831,7 +831,8 @@ static void iwl_mvm_uapsd_agg_disconnect(struct iwl_mvm *mvm,
 	mvm->tcm.data[mvmvif->id].uapsd_nonagg_detect.detected = true;
 	IWL_INFO(mvm,
 		 "detected AP should do aggregation but isn't, likely due to U-APSD\n");
-	schedule_delayed_work(&mvmvif->uapsd_nonagg_detected_wk, 15 * HZ);
+	schedule_delayed_work(&mvmvif->uapsd_nonagg_detected_wk,
+			      15 * HZ);
 }
 
 static void iwl_mvm_check_uapsd_agg_expected_tpt(struct iwl_mvm *mvm,
@@ -883,10 +884,10 @@ static void iwl_mvm_tcm_iterator(void *_data, u8 *mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 *band = _data;
 
-	if (!mvmvif->phy_ctxt)
+	if (!mvmvif->deflink.phy_ctxt)
 		return;
 
-	band[mvmvif->id] = mvmvif->phy_ctxt->channel->band;
+	band[mvmvif->id] = mvmvif->deflink.phy_ctxt->channel->band;
 }
 
 static unsigned long iwl_mvm_calc_tcm_stats(struct iwl_mvm *mvm,
-- 
2.38.1

