Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241FB6CB8FC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjC1IAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjC1IAX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96FA423F
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990420; x=1711526420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hv7uk8gchG8/D62q5+A+uU+FDwAOHXgcoH9tL8l3bE=;
  b=AilvoXDjnIACU8z0jwL7eaNZDCz2P9op/5SOIxSVt2dG1nTFGYQhztjU
   VkcjGXv3NxMOTUcN6/JiMPwXHqNpTECMss52Ka/PFLAAatb0+BBokSNgz
   AJUwyuG/3dcBNu/3joIhMK6G5OObPqvXYSyrJvWAMqab3ooW3K9sI5pfz
   8bzwlRlYfDICc1xSxTbFkW3NJMOxYjRbJoJZo2ACk/1q+uz8xx9PtSxXr
   9KaQa1v1QW8/r8Tr3t1TaD3xMOtcOlwrHzAS3Y/nRDEuI53xtjhhDXIfj
   Iy3lSP/PS+As5xuXrIu+zAfmNc16fYJoQxSllehtnY/Iu1bDodgqtXBbI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958251"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045302"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045302"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 23/31] wifi: iwlwifi: mvm: add link_conf parameter for add/remove/change link
Date:   Tue, 28 Mar 2023 10:59:03 +0300
Message-Id: <20230328104949.374015eed2e3.Icbf15a18e2599b53f4fa1c92fe3db64b551b84b1@changeid>
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

Add link_conf parameter and change all the relevant calls accordingly.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 81 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 46 ++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 50 +++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 13 ++-
 5 files changed, 118 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index d8902e0ed2ae..bbaac2ba9079 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -20,11 +20,16 @@ static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 	return ret;
 }
 
-int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->deflink.phy_ctxt;
+	unsigned int link_id = link_conf->link_id;
 	struct iwl_link_config_cmd cmd = {};
+	struct iwl_mvm_phy_ctxt *phyctxt;
+
+	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+		return -EINVAL;
 
 	/* Update SF - Disable if needed. if this fails, SF might still be on
 	 * while many macs are bound, which is forbidden - so fail the binding.
@@ -32,82 +37,94 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (iwl_mvm_sf_update(mvm, vif, false))
 		return -EINVAL;
 
+	/* FIXME: add proper link id allocation */
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 	/* P2P-Device already has a valid PHY context during add */
+	phyctxt = mvmvif->link[link_id]->phy_ctxt;
 	if (phyctxt)
 		cmd.phy_id = cpu_to_le32(phyctxt->id);
 	else
 		cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 
-	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
+	memcpy(cmd.local_link_addr, link_conf->addr, ETH_ALEN);
 
-	if (vif->type == NL80211_IFTYPE_ADHOC && vif->bss_conf.bssid)
-		memcpy(cmd.ibss_bssid_addr, vif->bss_conf.bssid, ETH_ALEN);
+	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
+		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
 
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->deflink.phy_ctxt;
+	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_phy_ctxt *phyctxt;
 	struct iwl_link_config_cmd cmd = {};
 	u32 ht_flag, flags = 0, flags_mask = 0;
 
+	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+		return -EINVAL;
+
+	/* FIXME: add proper link id allocation */
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 
 	/* The phy_id, link address and listen_lmac can be modified only until
 	 * the link becomes active, otherwise they will be ignored.
 	 */
+	phyctxt = mvmvif->link[link_id]->phy_ctxt;
 	if (phyctxt)
 		cmd.phy_id = cpu_to_le32(phyctxt->id);
 	else
 		cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 
-	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
+	memcpy(cmd.local_link_addr, link_conf->addr, ETH_ALEN);
 
 	cmd.active = cpu_to_le32(active);
 
-	if (vif->type == NL80211_IFTYPE_ADHOC && vif->bss_conf.bssid)
-		memcpy(cmd.ibss_bssid_addr, vif->bss_conf.bssid, ETH_ALEN);
+	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
+		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
 	/* TODO: set a value to cmd.listen_lmac when system requiremens
 	 * will define it
 	 */
 
-	iwl_mvm_set_fw_basic_rates(mvm, vif, &cmd.cck_rates, &cmd.ofdm_rates);
+	iwl_mvm_set_fw_basic_rates(mvm, vif, link_conf,
+				   &cmd.cck_rates, &cmd.ofdm_rates);
 
-	cmd.cck_short_preamble = cpu_to_le32(vif->bss_conf.use_short_preamble);
-	cmd.short_slot = cpu_to_le32(vif->bss_conf.use_short_slot);
+	cmd.cck_short_preamble = cpu_to_le32(link_conf->use_short_preamble);
+	cmd.short_slot = cpu_to_le32(link_conf->use_short_slot);
 
 	/* The fw does not distinguish between ht and fat */
 	ht_flag = LINK_PROT_FLG_HT_PROT | LINK_PROT_FLG_FAT_PROT;
-	iwl_mvm_set_fw_protection_flags(mvm, vif, &cmd.protection_flags,
+	iwl_mvm_set_fw_protection_flags(mvm, vif, link_conf,
+					&cmd.protection_flags,
 					ht_flag, LINK_PROT_FLG_TGG_PROTECT);
 
-	iwl_mvm_set_fw_qos_params(mvm, vif, &cmd.ac[0], &cmd.qos_flags);
+	iwl_mvm_set_fw_qos_params(mvm, vif, link_conf, &cmd.ac[0],
+				  &cmd.qos_flags);
 
 
-	cmd.bi = cpu_to_le32(vif->bss_conf.beacon_int);
-	cmd.dtim_interval = cpu_to_le32(vif->bss_conf.beacon_int *
-					vif->bss_conf.dtim_period);
+	cmd.bi = cpu_to_le32(link_conf->beacon_int);
+	cmd.dtim_interval = cpu_to_le32(link_conf->beacon_int *
+					link_conf->dtim_period);
 
-	if (!vif->bss_conf.he_support || iwlwifi_mod_params.disable_11ax ||
+	if (!link_conf->he_support || iwlwifi_mod_params.disable_11ax ||
 	    !vif->cfg.assoc) {
 		changes &= ~LINK_CONTEXT_MODIFY_HE_PARAMS;
 		goto send_cmd;
 	}
 
-	cmd.htc_trig_based_pkt_ext = vif->bss_conf.htc_trig_based_pkt_ext;
+	cmd.htc_trig_based_pkt_ext = link_conf->htc_trig_based_pkt_ext;
 
-	if (vif->bss_conf.uora_exists) {
+	if (link_conf->uora_exists) {
 		cmd.rand_alloc_ecwmin =
-			vif->bss_conf.uora_ocw_range & 0x7;
+			link_conf->uora_ocw_range & 0x7;
 		cmd.rand_alloc_ecwmax =
-			(vif->bss_conf.uora_ocw_range >> 3) & 0x7;
+			(link_conf->uora_ocw_range >> 3) & 0x7;
 	}
 
 	/* TODO  how to set ndp_fdbk_buff_th_exp? */
@@ -118,20 +135,20 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		flags_mask |= LINK_FLG_MU_EDCA_CW;
 	}
 
-	if (vif->bss_conf.eht_puncturing && !iwlwifi_mod_params.disable_11be)
-		cmd.puncture_mask = cpu_to_le16(vif->bss_conf.eht_puncturing);
+	if (link_conf->eht_puncturing && !iwlwifi_mod_params.disable_11be)
+		cmd.puncture_mask = cpu_to_le16(link_conf->eht_puncturing);
 	else
 		/* This flag can be set only if the MAC has eht support */
 		changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
-	cmd.bss_color = vif->bss_conf.he_bss_color.color;
+	cmd.bss_color = link_conf->he_bss_color.color;
 
-	if (!vif->bss_conf.he_bss_color.enabled) {
+	if (!link_conf->he_bss_color.enabled) {
 		flags |= LINK_FLG_BSS_COLOR_DIS;
 		flags_mask |= LINK_FLG_BSS_COLOR_DIS;
 	}
 
-	cmd.frame_time_rts_th = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	cmd.frame_time_rts_th = cpu_to_le16(link_conf->frame_time_rts_th);
 
 	/* Block 26-tone RU OFDMA transmissions */
 	if (mvmvif->deflink.he_ru_2mhz_block) {
@@ -139,10 +156,10 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		flags_mask |= LINK_FLG_RU_2MHZ_BLOCK;
 	}
 
-	if (vif->bss_conf.nontransmitted) {
+	if (link_conf->nontransmitted) {
 		ether_addr_copy(cmd.ref_bssid_addr,
-				vif->bss_conf.transmitter_bssid);
-		cmd.bssid_index = vif->bss_conf.bssid_index;
+				link_conf->transmitter_bssid);
+		cmd.bssid_index = link_conf->bssid_index;
 	}
 
 send_cmd:
@@ -153,12 +170,14 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
 }
 
-int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
+	/* FIXME: add proper link id allocation */
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a06513989469..432b9cbcd8a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -397,16 +397,18 @@ static void iwl_mvm_ack_rates(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf,
 				__le32 *cck_rates, __le32 *ofdm_rates)
 {
 	struct ieee80211_chanctx_conf *chanctx;
-	u8 cck_ack_rates, ofdm_ack_rates;
+	u8 cck_ack_rates = 0, ofdm_ack_rates = 0;
 
 	rcu_read_lock();
-	chanctx = rcu_dereference(vif->bss_conf.chanctx_conf);
+	chanctx = rcu_dereference(link_conf->chanctx_conf);
 	iwl_mvm_ack_rates(mvm, vif, chanctx ? chanctx->def.chan->band
 					    : NL80211_BAND_2GHZ,
 			  &cck_ack_rates, &ofdm_ack_rates);
+
 	rcu_read_unlock();
 
 	*cck_rates = cpu_to_le32((u32)cck_ack_rates);
@@ -415,21 +417,22 @@ void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf,
 				     __le32 *protection_flags, u32 ht_flag,
 				     u32 tgg_flag)
 {
 	/* for both sta and ap, ht_operation_mode hold the protection_mode */
-	u8 protection_mode = vif->bss_conf.ht_operation_mode &
+	u8 protection_mode = link_conf->ht_operation_mode &
 				 IEEE80211_HT_OP_MODE_PROTECTION;
-	bool ht_enabled = !!(vif->bss_conf.ht_operation_mode &
+	bool ht_enabled = !!(link_conf->ht_operation_mode &
 			     IEEE80211_HT_OP_MODE_PROTECTION);
 
-	if (vif->bss_conf.use_cts_prot)
+	if (link_conf->use_cts_prot)
 		*protection_flags |= cpu_to_le32(tgg_flag);
 
 	IWL_DEBUG_RATE(mvm, "use_cts_prot %d, ht_operation_mode %d\n",
-		       vif->bss_conf.use_cts_prot,
-		       vif->bss_conf.ht_operation_mode);
+		       link_conf->use_cts_prot,
+		       link_conf->ht_operation_mode);
 
 	if (!ht_enabled)
 		return;
@@ -448,7 +451,7 @@ void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 		break;
 	case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
 		/* Protect when channel wider than 20MHz */
-		if (vif->bss_conf.chandef.width > NL80211_CHAN_WIDTH_20)
+		if (link_conf->chandef.width > NL80211_CHAN_WIDTH_20)
 			*protection_flags |= cpu_to_le32(ht_flag);
 		break;
 	default:
@@ -459,6 +462,7 @@ void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf,
 			       struct iwl_ac_qos *ac, __le32 *qos_flags)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -478,10 +482,10 @@ void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		ac[ucode_ac].fifos_mask = BIT(txf);
 	}
 
-	if (vif->bss_conf.qos)
+	if (link_conf->qos)
 		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
 
-	if (vif->bss_conf.chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
+	if (link_conf->chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
 		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
 }
 
@@ -538,7 +542,7 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	else
 		eth_broadcast_addr(cmd->bssid_addr);
 
-	iwl_mvm_set_fw_basic_rates(mvm, vif, &cmd->cck_rates,
+	iwl_mvm_set_fw_basic_rates(mvm, vif, &vif->bss_conf, &cmd->cck_rates,
 				   &cmd->ofdm_rates);
 
 	cmd->cck_short_preamble =
@@ -550,11 +554,13 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	cmd->filter_flags = 0;
 
-	iwl_mvm_set_fw_qos_params(mvm, vif, &cmd->ac[0], &cmd->qos_flags);
+	iwl_mvm_set_fw_qos_params(mvm, vif, &vif->bss_conf, &cmd->ac[0],
+				  &cmd->qos_flags);
 
 	/* The fw does not distinguish between ht and fat */
 	ht_flag = MAC_PROT_FLG_HT_PROT | MAC_PROT_FLG_FAT_PROT;
-	iwl_mvm_set_fw_protection_flags(mvm, vif, &cmd->protection_flags,
+	iwl_mvm_set_fw_protection_flags(mvm, vif, &vif->bss_conf,
+					&cmd->protection_flags,
 					ht_flag, MAC_PROT_FLG_TGG_PROTECT);
 }
 
@@ -570,6 +576,7 @@ static int iwl_mvm_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
 			      __le64 *dtim_tsf, __le32 *dtim_time,
 			      __le32 *assoc_beacon_arrive_time)
 {
@@ -590,17 +597,17 @@ void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * 384us in the longest case), this is currently not relevant
 	 * as the firmware wakes up around 2ms before the TBTT.
 	 */
-	dtim_offs = vif->bss_conf.sync_dtim_count *
-			vif->bss_conf.beacon_int;
+	dtim_offs = link_conf->sync_dtim_count *
+			link_conf->beacon_int;
 	/* convert TU to usecs */
 	dtim_offs *= 1024;
 
 	*dtim_tsf =
-		cpu_to_le64(vif->bss_conf.sync_tsf + dtim_offs);
+		cpu_to_le64(link_conf->sync_tsf + dtim_offs);
 	*dtim_time =
-		cpu_to_le32(vif->bss_conf.sync_device_ts + dtim_offs);
+		cpu_to_le32(link_conf->sync_device_ts + dtim_offs);
 	*assoc_beacon_arrive_time =
-		cpu_to_le32(vif->bss_conf.sync_device_ts);
+		cpu_to_le32(link_conf->sync_device_ts);
 
 	IWL_DEBUG_INFO(mvm, "DTIM TBTT is 0x%llx/0x%x, offset %d\n",
 		       le64_to_cpu(*dtim_tsf),
@@ -666,7 +673,8 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	    !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		iwl_mvm_set_fw_dtim_tbtt(mvm, vif, &ctxt_sta->dtim_tsf,
+		iwl_mvm_set_fw_dtim_tbtt(mvm, vif, &vif->bss_conf,
+					 &ctxt_sta->dtim_tsf,
 					 &ctxt_sta->dtim_time,
 					 &ctxt_sta->assoc_beacon_arrive_time);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ef3eb57b806a..cff24bf7e799 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3619,7 +3619,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 			callbacks->mac_ctxt_changed(mvm, vif, false);
 
 			if (mvm->mld_api_is_used)
-				iwl_mvm_link_changed(mvm, vif,
+				iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
 						     LINK_CONTEXT_MODIFY_ALL &
 						     ~LINK_CONTEXT_MODIFY_ACTIVE,
 						     true);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 80f1a1ccf16d..d02b3165f1d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -67,11 +67,13 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		}
 
 		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-		ret = iwl_mvm_add_link(mvm, vif);
+		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
 		if (ret)
 			goto out_unref_phy;
 
-		ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+					   LINK_CONTEXT_MODIFY_ACTIVE |
+					   LINK_CONTEXT_MODIFY_RATES_INFO,
 					   true);
 		if (ret)
 			goto out_remove_link;
@@ -85,7 +87,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		 */
 		mvm->p2p_device_vif = vif;
 	} else {
-		ret = iwl_mvm_add_link(mvm, vif);
+		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
 		if (ret)
 			goto out_free_bf;
 	}
@@ -117,8 +119,9 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
  out_remove_link:
 	/* Link needs to be deactivated before removal */
-	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif);
+	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+			     LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
  out_unref_phy:
 	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
  out_free_bf:
@@ -193,13 +196,13 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = NULL;
 		iwl_mvm_mld_rm_bcast_sta(mvm, vif);
 		/* Link needs to be deactivated before removal */
-		iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
-				     false);
-		iwl_mvm_remove_link(mvm, vif);
+		iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+				     LINK_CONTEXT_MODIFY_ACTIVE, false);
+		iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
 		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
 		mvmvif->deflink.phy_ctxt = NULL;
 	} else {
-		iwl_mvm_remove_link(mvm, vif);
+		iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
 	}
 
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
@@ -233,12 +236,13 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	}
 
 	/* send it first with phy context ID */
-	ret = iwl_mvm_link_changed(mvm, vif, 0, false);
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf, 0, false);
 	if (ret)
 		goto out;
 
 	/* then activate */
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE |
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+				   LINK_CONTEXT_MODIFY_ACTIVE |
 				   LINK_CONTEXT_MODIFY_RATES_INFO,
 				   true);
 	if (ret)
@@ -259,7 +263,8 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	return 0;
 
 deactivate:
-	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+			     LINK_CONTEXT_MODIFY_ACTIVE, false);
 out:
 	mvmvif->deflink.phy_ctxt = NULL;
 	iwl_mvm_power_update_mac(mvm);
@@ -303,7 +308,8 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+			     LINK_CONTEXT_MODIFY_ACTIVE, false);
 
 	if (switching_chanctx)
 		return;
@@ -337,7 +343,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		goto out_unlock;
 
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ALL,
+	ret = iwl_mvm_link_changed(mvm, vif, link_conf, LINK_CONTEXT_MODIFY_ALL,
 				   true);
 	if (ret)
 		goto out_unlock;
@@ -477,7 +483,8 @@ iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
 
 	if (link_changes) {
-		ret = iwl_mvm_link_changed(mvm, vif, link_changes, true);
+		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+					   link_changes, true);
 		if (ret)
 			IWL_ERR(mvm, "failed to update link\n");
 	}
@@ -576,7 +583,8 @@ iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 
 	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT |
 		       BSS_CHANGED_BANDWIDTH | BSS_CHANGED_QOS) &&
-		       iwl_mvm_link_changed(mvm, vif, link_changes, true))
+		       iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+					    link_changes, true))
 		IWL_ERR(mvm, "failed to update MAC %pM\n", vif->addr);
 
 	/* Need to send a new beacon template to the FW */
@@ -661,7 +669,7 @@ iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
 		int ret;
 
 		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_link_changed(mvm, vif,
+		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
 					   LINK_CONTEXT_MODIFY_QOS_PARAMS,
 					   true);
 		mutex_unlock(&mvm->mutex);
@@ -683,7 +691,8 @@ static int iwl_mvm_link_switch_phy_ctx(struct iwl_mvm *mvm,
 	 * inactive. Therefore, first deactivate the link, then change its
 	 * phy_ctx, and then activate it again.
 	 */
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+				   LINK_CONTEXT_MODIFY_ACTIVE, false);
 	if (WARN(ret, "Failed to deactivate link\n"))
 		return ret;
 
@@ -691,11 +700,12 @@ static int iwl_mvm_link_switch_phy_ctx(struct iwl_mvm *mvm,
 
 	mvmvif->deflink.phy_ctxt = new_phy_ctxt;
 
-	ret = iwl_mvm_link_changed(mvm, vif, 0, false);
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf, 0, false);
 	if (WARN(ret, "Failed to deactivate link\n"))
 		return ret;
 
-	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, true);
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+				   LINK_CONTEXT_MODIFY_ACTIVE, true);
 	WARN(ret, "Failed binding P2P_DEVICE\n");
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d62341269744..03710c0cb57d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1721,17 +1721,21 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf,
 				__le32 *cck_rates, __le32 *ofdm_rates);
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf,
 				     __le32 *protection_flags, u32 ht_flag,
-				  u32 tgg_flag);
+				     u32 tgg_flag);
 void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf,
 			       struct iwl_ac_qos *ac, __le32 *qos_flags);
 bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
 				   struct iwl_mvm_vif *mvmvif,
 				   struct iwl_he_backoff_conf *trig_based_txf);
 void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
 			      __le64 *dtim_tsf, __le32 *dtim_time,
 			      __le32 *assoc_beacon_arrive_time);
 __le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
@@ -1799,10 +1803,13 @@ int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
 /* Links */
-int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active);
-int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link_conf);
 
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
-- 
2.38.1

