Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD646B9D86
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCNRv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCNRvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF29F214
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816272; x=1710352272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8wWMRGZjEwPTKXiRFADjrdMIez0yemQIuQeW5jNPXE=;
  b=A3S1/L7vx7f40BdPzIQuMu9OgxXeBdYZxagsvL7IdNGo7CA5hB8oIUBw
   9sSRoRBbNA7Uasi2mb80zpBIzCRREv4tnjR1prYSG9w3ihpLEK5Lrieyg
   3rZ3Q0CbNSPc5mOWRx1Zrv2vsty3i+Kh6QltSWVCFRgQtWt0gG+V2pUmw
   fDuZyM3YL+uCvYcXr+GYW/OZjToLiV5MAMuoGetWsB+PCjmiWecsj/c00
   ETki5Big2ZqoFnwZIkaYqPUk/6SENtoVgW/8qpB4ZLVdTzv/U/7iFDAjh
   r192dPsA7tzdOLLdaFE3sArJsx5RfpkFIpZksuUp3RTWVY/1e6DLncT8a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149543"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200498"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200498"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/22] wifi: iwlwifi: mvm: Refactor MAC_CONTEXT_CMD sending flow
Date:   Tue, 14 Mar 2023 19:49:17 +0200
Message-Id: <20230314194113.3ab62700db4e.I2e353b308667c215aa456c160e0d90de2b9b85cc@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Refactor MAC_CONTEXT_CMD sending flow:

1. As the new MLD API is introduced, there are some common fields in
both the old and new APIs. The MAC_CONTEXT_CMD of the non-MLD API
has common fields with the link and mac commands of the new MLD API.
Put this common parts in functions so it can be used later by the
new MLD API.

2. Use iwl_mvm_mac_ctxt_send_cmd when removing a mac instead of
implementing the same functionality once again.

3. Change the debug print when sending the command to be more specific,
so it will be easy to distinguish later if the old or new mac command
was sent.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 320 +++++++++++-------
 1 file changed, 197 insertions(+), 123 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 422550e31bc6..a30385b85a60 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -396,15 +396,45 @@ static void iwl_mvm_ack_rates(struct iwl_mvm *mvm,
 	*ofdm_rates = ofdm;
 }
 
-static void iwl_mvm_mac_ctxt_set_ht_flags(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif,
-					 struct iwl_mac_ctx_cmd *cmd)
+static void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       __le32 *cck_rates, __le32 *ofdm_rates)
+{
+	struct ieee80211_chanctx_conf *chanctx;
+	u8 cck_ack_rates, ofdm_ack_rates;
+
+	rcu_read_lock();
+	chanctx = rcu_dereference(vif->bss_conf.chanctx_conf);
+	iwl_mvm_ack_rates(mvm, vif, chanctx ? chanctx->def.chan->band
+					    : NL80211_BAND_2GHZ,
+			  &cck_ack_rates, &ofdm_ack_rates);
+	rcu_read_unlock();
+
+	*cck_rates = cpu_to_le32((u32)cck_ack_rates);
+	*ofdm_rates = cpu_to_le32((u32)ofdm_ack_rates);
+}
+
+static void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    __le32 *protection_flags,
+					    u32 ht_flag,
+					    u32 tgg_flag)
 {
 	/* for both sta and ap, ht_operation_mode hold the protection_mode */
 	u8 protection_mode = vif->bss_conf.ht_operation_mode &
 				 IEEE80211_HT_OP_MODE_PROTECTION;
-	/* The fw does not distinguish between ht and fat */
-	u32 ht_flag = MAC_PROT_FLG_HT_PROT | MAC_PROT_FLG_FAT_PROT;
+	bool ht_enabled = !!(vif->bss_conf.ht_operation_mode &
+			     IEEE80211_HT_OP_MODE_PROTECTION);
+
+	if (vif->bss_conf.use_cts_prot)
+		*protection_flags |= cpu_to_le32(tgg_flag);
+
+	IWL_DEBUG_RATE(mvm, "use_cts_prot %d, ht_operation_mode %d\n",
+		       vif->bss_conf.use_cts_prot,
+		       vif->bss_conf.ht_operation_mode);
+
+	if (!ht_enabled)
+		return;
 
 	IWL_DEBUG_RATE(mvm, "protection mode set to %d\n", protection_mode);
 	/*
@@ -416,12 +446,12 @@ static void iwl_mvm_mac_ctxt_set_ht_flags(struct iwl_mvm *mvm,
 		break;
 	case IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER:
 	case IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED:
-		cmd->protection_flags |= cpu_to_le32(ht_flag);
+		*protection_flags |= cpu_to_le32(ht_flag);
 		break;
 	case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
 		/* Protect when channel wider than 20MHz */
 		if (vif->bss_conf.chandef.width > NL80211_CHAN_WIDTH_20)
-			cmd->protection_flags |= cpu_to_le32(ht_flag);
+			*protection_flags |= cpu_to_le32(ht_flag);
 		break;
 	default:
 		IWL_ERR(mvm, "Illegal protection mode %d\n",
@@ -430,6 +460,34 @@ static void iwl_mvm_mac_ctxt_set_ht_flags(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct iwl_ac_qos *ac, __le32 *qos_flags)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int i;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		u8 txf = iwl_mvm_mac_ac_to_tx_fifo(mvm, i);
+		u8 ucode_ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
+
+		ac[ucode_ac].cw_min =
+			cpu_to_le16(mvmvif->queue_params[i].cw_min);
+		ac[ucode_ac].cw_max =
+			cpu_to_le16(mvmvif->queue_params[i].cw_max);
+		ac[ucode_ac].edca_txop =
+			cpu_to_le16(mvmvif->queue_params[i].txop * 32);
+		ac[ucode_ac].aifsn = mvmvif->queue_params[i].aifs;
+		ac[ucode_ac].fifos_mask = BIT(txf);
+	}
+
+	if (vif->bss_conf.qos)
+		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
+
+	if (vif->bss_conf.chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
+		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
+}
+
 static int iwl_mvm_get_mac_type(struct ieee80211_vif *vif)
 {
 	u32 mac_type = FW_MAC_TYPE_BSS_STA;
@@ -456,7 +514,6 @@ static int iwl_mvm_get_mac_type(struct ieee80211_vif *vif)
 	default:
 		WARN_ON_ONCE(1);
 	}
-
 	return mac_type;
 }
 
@@ -467,12 +524,8 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 					u32 action)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_chanctx_conf *chanctx;
-	bool ht_enabled = !!(vif->bss_conf.ht_operation_mode &
-			     IEEE80211_HT_OP_MODE_PROTECTION);
-	u8 cck_ack_rates, ofdm_ack_rates;
 	const u8 *bssid = bssid_override ?: vif->bss_conf.bssid;
-	int i;
+	u32 ht_flag;
 
 	cmd->id_and_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
 							    mvmvif->color));
@@ -488,15 +541,8 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	else
 		eth_broadcast_addr(cmd->bssid_addr);
 
-	rcu_read_lock();
-	chanctx = rcu_dereference(vif->bss_conf.chanctx_conf);
-	iwl_mvm_ack_rates(mvm, vif, chanctx ? chanctx->def.chan->band
-					    : NL80211_BAND_2GHZ,
-			  &cck_ack_rates, &ofdm_ack_rates);
-	rcu_read_unlock();
-
-	cmd->cck_rates = cpu_to_le32((u32)cck_ack_rates);
-	cmd->ofdm_rates = cpu_to_le32((u32)ofdm_ack_rates);
+	iwl_mvm_set_fw_basic_rates(mvm, vif, &cmd->cck_rates,
+				   &cmd->ofdm_rates);
 
 	cmd->cck_short_preamble =
 		cpu_to_le32(vif->bss_conf.use_short_preamble ?
@@ -507,33 +553,12 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	cmd->filter_flags = 0;
 
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		u8 txf = iwl_mvm_mac_ac_to_tx_fifo(mvm, i);
-		u8 ucode_ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
-
-		cmd->ac[ucode_ac].cw_min =
-			cpu_to_le16(mvmvif->queue_params[i].cw_min);
-		cmd->ac[ucode_ac].cw_max =
-			cpu_to_le16(mvmvif->queue_params[i].cw_max);
-		cmd->ac[ucode_ac].edca_txop =
-			cpu_to_le16(mvmvif->queue_params[i].txop * 32);
-		cmd->ac[ucode_ac].aifsn = mvmvif->queue_params[i].aifs;
-		cmd->ac[ucode_ac].fifos_mask = BIT(txf);
-	}
-
-	if (vif->bss_conf.qos)
-		cmd->qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
+	iwl_mvm_set_fw_qos_params(mvm, vif, &cmd->ac[0], &cmd->qos_flags);
 
-	if (vif->bss_conf.use_cts_prot)
-		cmd->protection_flags |= cpu_to_le32(MAC_PROT_FLG_TGG_PROTECT);
-
-	IWL_DEBUG_RATE(mvm, "use_cts_prot %d, ht_operation_mode %d\n",
-		       vif->bss_conf.use_cts_prot,
-		       vif->bss_conf.ht_operation_mode);
-	if (vif->bss_conf.chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
-		cmd->qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
-	if (ht_enabled)
-		iwl_mvm_mac_ctxt_set_ht_flags(mvm, vif, cmd);
+	/* The fw does not distinguish between ht and fat */
+	ht_flag = MAC_PROT_FLG_HT_PROT | MAC_PROT_FLG_FAT_PROT;
+	iwl_mvm_set_fw_protection_flags(mvm, vif, &cmd->protection_flags,
+					ht_flag, MAC_PROT_FLG_TGG_PROTECT);
 }
 
 static int iwl_mvm_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
@@ -542,11 +567,76 @@ static int iwl_mvm_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
 	int ret = iwl_mvm_send_cmd_pdu(mvm, MAC_CONTEXT_CMD, 0,
 				       sizeof(*cmd), cmd);
 	if (ret)
-		IWL_ERR(mvm, "Failed to send MAC context (action:%d): %d\n",
+		IWL_ERR(mvm, "Failed to send MAC_CONTEXT_CMD (action:%d): %d\n",
 			le32_to_cpu(cmd->action), ret);
 	return ret;
 }
 
+static void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     __le64 *dtim_tsf, __le32 *dtim_time,
+				     __le32 *assoc_beacon_arrive_time)
+{
+	u32 dtim_offs;
+
+	/*
+	 * The DTIM count counts down, so when it is N that means N
+	 * more beacon intervals happen until the DTIM TBTT. Therefore
+	 * add this to the current time. If that ends up being in the
+	 * future, the firmware will handle it.
+	 *
+	 * Also note that the system_timestamp (which we get here as
+	 * "sync_device_ts") and TSF timestamp aren't at exactly the
+	 * same offset in the frame -- the TSF is at the first symbol
+	 * of the TSF, the system timestamp is at signal acquisition
+	 * time. This means there's an offset between them of at most
+	 * a few hundred microseconds (24 * 8 bits + PLCP time gives
+	 * 384us in the longest case), this is currently not relevant
+	 * as the firmware wakes up around 2ms before the TBTT.
+	 */
+	dtim_offs = vif->bss_conf.sync_dtim_count *
+			vif->bss_conf.beacon_int;
+	/* convert TU to usecs */
+	dtim_offs *= 1024;
+
+	*dtim_tsf =
+		cpu_to_le64(vif->bss_conf.sync_tsf + dtim_offs);
+	*dtim_time =
+		cpu_to_le32(vif->bss_conf.sync_device_ts + dtim_offs);
+	*assoc_beacon_arrive_time =
+		cpu_to_le32(vif->bss_conf.sync_device_ts);
+
+	IWL_DEBUG_INFO(mvm, "DTIM TBTT is 0x%llx/0x%x, offset %d\n",
+		       le64_to_cpu(*dtim_tsf),
+		       le32_to_cpu(*dtim_time),
+		       dtim_offs);
+}
+
+static __le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
+							   struct ieee80211_vif *vif)
+{
+	struct ieee80211_p2p_noa_attr *noa =
+		&vif->bss_conf.p2p_noa_attr;
+
+	return cpu_to_le32(noa->oppps_ctwindow &
+			IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
+}
+
+static __le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
+						      struct ieee80211_vif *vif)
+{
+	__le32 twt_policy = cpu_to_le32(0);
+
+	if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
+		twt_policy |= cpu_to_le32(TWT_SUPPORTED);
+	if (vif->bss_conf.twt_protected)
+		twt_policy |= cpu_to_le32(PROTECTED_TWT_SUPPORTED);
+	if (vif->bss_conf.twt_broadcast)
+		twt_policy |= cpu_to_le32(BROADCAST_TWT_SUPPORTED);
+
+	return twt_policy;
+}
+
 static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    u32 action, bool force_assoc_off,
@@ -567,11 +657,9 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	cmd.filter_flags |= cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
 
 	if (vif->p2p) {
-		struct ieee80211_p2p_noa_attr *noa =
-			&vif->bss_conf.p2p_noa_attr;
+		cmd.p2p_sta.ctwin =
+			iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(mvm, vif);
 
-		cmd.p2p_sta.ctwin = cpu_to_le32(noa->oppps_ctwindow &
-					IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
 		ctxt_sta = &cmd.p2p_sta.sta;
 	} else {
 		ctxt_sta = &cmd.sta;
@@ -581,39 +669,10 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	if (vif->cfg.assoc && vif->bss_conf.dtim_period &&
 	    !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		u32 dtim_offs;
 
-		/*
-		 * The DTIM count counts down, so when it is N that means N
-		 * more beacon intervals happen until the DTIM TBTT. Therefore
-		 * add this to the current time. If that ends up being in the
-		 * future, the firmware will handle it.
-		 *
-		 * Also note that the system_timestamp (which we get here as
-		 * "sync_device_ts") and TSF timestamp aren't at exactly the
-		 * same offset in the frame -- the TSF is at the first symbol
-		 * of the TSF, the system timestamp is at signal acquisition
-		 * time. This means there's an offset between them of at most
-		 * a few hundred microseconds (24 * 8 bits + PLCP time gives
-		 * 384us in the longest case), this is currently not relevant
-		 * as the firmware wakes up around 2ms before the TBTT.
-		 */
-		dtim_offs = vif->bss_conf.sync_dtim_count *
-				vif->bss_conf.beacon_int;
-		/* convert TU to usecs */
-		dtim_offs *= 1024;
-
-		ctxt_sta->dtim_tsf =
-			cpu_to_le64(vif->bss_conf.sync_tsf + dtim_offs);
-		ctxt_sta->dtim_time =
-			cpu_to_le32(vif->bss_conf.sync_device_ts + dtim_offs);
-		ctxt_sta->assoc_beacon_arrive_time =
-			cpu_to_le32(vif->bss_conf.sync_device_ts);
-
-		IWL_DEBUG_INFO(mvm, "DTIM TBTT is 0x%llx/0x%x, offset %d\n",
-			       le64_to_cpu(ctxt_sta->dtim_tsf),
-			       le32_to_cpu(ctxt_sta->dtim_time),
-			       dtim_offs);
+		iwl_mvm_set_fw_dtim_tbtt(mvm, vif, &ctxt_sta->dtim_tsf,
+					 &ctxt_sta->dtim_time,
+					 &ctxt_sta->assoc_beacon_arrive_time);
 
 		ctxt_sta->is_assoc = cpu_to_le32(1);
 
@@ -643,14 +702,8 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
-		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
-			ctxt_sta->data_policy |= cpu_to_le32(TWT_SUPPORTED);
-		if (vif->bss_conf.twt_protected)
-			ctxt_sta->data_policy |=
-				cpu_to_le32(PROTECTED_TWT_SUPPORTED);
-		if (vif->bss_conf.twt_broadcast)
-			ctxt_sta->data_policy |=
-				cpu_to_le32(BROADCAST_TWT_SUPPORTED);
+		ctxt_sta->data_policy |=
+			iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif);
 	}
 
 
@@ -732,20 +785,11 @@ static void iwl_mvm_go_iterator(void *_data, u8 *mac, struct ieee80211_vif *vif)
 		data->go_active = true;
 }
 
-static int iwl_mvm_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif,
-					   u32 action)
+static __le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
+						     struct ieee80211_vif *vif)
 {
-	struct iwl_mac_ctx_cmd cmd = {};
 	struct iwl_mvm_go_iterator_data data = {};
 
-	WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE);
-
-	iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
-
-	/* Override the filter flags to accept only probe requests */
-	cmd.filter_flags = cpu_to_le32(MAC_FILTER_IN_PROBE_REQUEST);
-
 	/*
 	 * This flag should be set to true when the P2P Device is
 	 * discoverable and there is at least another active P2P GO. Settings
@@ -758,7 +802,25 @@ static int iwl_mvm_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
 		mvm->hw, IEEE80211_IFACE_ITER_RESUME_ALL,
 		iwl_mvm_go_iterator, &data);
 
-	cmd.p2p_dev.is_disc_extended = cpu_to_le32(data.go_active ? 1 : 0);
+	return cpu_to_le32(data.go_active ? 1 : 0);
+}
+
+static int iwl_mvm_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   u32 action)
+{
+	struct iwl_mac_ctx_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE);
+
+	iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
+
+	cmd.p2p_dev.is_disc_extended =
+		iwl_mac_ctxt_p2p_dev_has_extended_disc(mvm, vif);
+
+	/* Override the filter flags to accept only probe requests */
+	cmd.filter_flags = cpu_to_le32(MAC_FILTER_IN_PROBE_REQUEST);
+
 	return iwl_mvm_mac_ctxt_send_cmd(mvm, &cmd);
 }
 
@@ -1102,6 +1164,30 @@ static void iwl_mvm_mac_ap_iterator(void *_data, u8 *mac,
 	data->beacon_int = vif->bss_conf.beacon_int;
 }
 
+/*
+ * Fill the filter flags for mac context of type AP or P2P GO.
+ */
+static void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
+						     struct iwl_mvm_vif *mvmvif,
+						     __le32 *filter_flags,
+						     int accept_probe_req_flag,
+						     int accept_beacon_flag)
+{
+	/*
+	 * in AP mode, pass probe requests and beacons from other APs
+	 * (needed for ht protection); when there're no any associated
+	 * station don't ask FW to pass beacons to prevent unnecessary
+	 * wake-ups.
+	 */
+	*filter_flags |= cpu_to_le32(accept_probe_req_flag);
+	if (mvmvif->ap_assoc_sta_count || !mvm->drop_bcn_ap_mode) {
+		*filter_flags |= cpu_to_le32(accept_beacon_flag);
+		IWL_DEBUG_HC(mvm, "Asking FW to pass beacons\n");
+	} else {
+		IWL_DEBUG_HC(mvm, "No need to receive beacons\n");
+	}
+}
+
 /*
  * Fill the specific data for mac context of type AP of P2P GO
  */
@@ -1121,19 +1207,10 @@ static void iwl_mvm_mac_ctxt_cmd_fill_ap(struct iwl_mvm *mvm,
 	/* in AP mode, the MCAST FIFO takes the EDCA params from VO */
 	cmd->ac[IWL_MVM_TX_FIFO_VO].fifos_mask |= BIT(IWL_MVM_TX_FIFO_MCAST);
 
-	/*
-	 * in AP mode, pass probe requests and beacons from other APs
-	 * (needed for ht protection); when there're no any associated
-	 * station don't ask FW to pass beacons to prevent unnecessary
-	 * wake-ups.
-	 */
-	cmd->filter_flags |= cpu_to_le32(MAC_FILTER_IN_PROBE_REQUEST);
-	if (mvmvif->ap_assoc_sta_count || !mvm->drop_bcn_ap_mode) {
-		cmd->filter_flags |= cpu_to_le32(MAC_FILTER_IN_BEACON);
-		IWL_DEBUG_HC(mvm, "Asking FW to pass beacons\n");
-	} else {
-		IWL_DEBUG_HC(mvm, "No need to receive beacons\n");
-	}
+	iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(mvm, mvmvif,
+						 &cmd->filter_flags,
+						 MAC_FILTER_IN_PROBE_REQUEST,
+						 MAC_FILTER_IN_BEACON);
 
 	ctxt_ap->bi = cpu_to_le32(vif->bss_conf.beacon_int);
 	ctxt_ap->dtim_interval = cpu_to_le32(vif->bss_conf.beacon_int *
@@ -1295,12 +1372,9 @@ int iwl_mvm_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 							   mvmvif->color));
 	cmd.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, MAC_CONTEXT_CMD, 0,
-				   sizeof(cmd), &cmd);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to remove MAC context: %d\n", ret);
+	ret = iwl_mvm_mac_ctxt_send_cmd(mvm, &cmd);
+	if (ret)
 		return ret;
-	}
 
 	mvmvif->uploaded = false;
 
-- 
2.38.1

