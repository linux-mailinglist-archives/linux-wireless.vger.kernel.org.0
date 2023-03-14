Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B036B9D85
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCNRv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCNRvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C8B4234
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816270; x=1710352270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3NPFHfwdQWJFjZVYouh5gmPU+KyhL/wQROcog3CMAc=;
  b=KhLcT+TJBfLjU4bVRZlV965UMN68ydD9ALMHehYQzBLnqh/DSeDQ00b7
   fdw3jbKl9tz9R23HoAqagwyfSICqsRsaQJzOQjTrhSlaJmtpq77t6OUW1
   6Gu+vEZ0JHfK+6rRftgTrVjTL9K7DmydfEQky/f5r6f0beoZjhSCHVpgD
   Mp4N7A6OTDIzjCSaokkETjZMbYPgeFonfLAIxV+MHc+aO6Y3V4TO6zrOP
   Begsl+0gTehsFzPIhYpPoAXB3MITvrYotNnLOSHbT3lSXxZFVmteV5xkK
   KuC4N9i0H7tpOuzqu8xDoSXNXrRNZpzoAWUFydF6OSV94M7+dbtNAu/SR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149551"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149551"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200517"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200517"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/22] wifi: iwlwifi: mvm: add support for the new LINK command
Date:   Tue, 14 Mar 2023 19:49:19 +0200
Message-Id: <20230314194113.d7808329effb.I13bea2db206b78540bc866bc3ab755ad5be78c53@changeid>
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

As a part of the new MLD FW API changes, we have a new LINK command
to add/remove/configure a link.
Add structures and enum definitions, along with the functions that
sends this command (i.e. add, remove and change mac ctxt).
These functions will be in used in the next patches.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 179 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 175 +++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  26 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  20 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 7 files changed, 390 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/link.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index f12b2a25cd3d..301f34f13523 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -37,6 +37,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @MAC_CONFIG_CMD: &struct iwl_mac_config_cmd
 	 */
 	MAC_CONFIG_CMD = 0x8,
+	/**
+	 * @LINK_CONFIG_CMD: &struct iwl_link_config_cmd
+	 */
+	LINK_CONFIG_CMD = 0x9,
 	/**
 	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
 	 */
@@ -287,4 +291,179 @@ struct iwl_mac_config_cmd {
 	};
 } __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_1 */
 
+/**
+ * enum iwl_link_ctx_modify_flags - indicate to the fw what fields are being
+ *	modified in &iwl_link_ctx_cfg_cmd
+ *
+ * @LINK_CONTEXT_MODIFY_ACTIVE: covers iwl_link_ctx_cfg_cmd::active
+ * @LINK_CONTEXT_MODIFY_RATES_INFO: covers iwl_link_ctx_cfg_cmd::cck_rates,
+ *	iwl_link_ctx_cfg_cmd::ofdm_rates,
+ *	iwl_link_ctx_cfg_cmd::cck_short_preamble,
+ *	iwl_link_ctx_cfg_cmd::short_slot
+ * @LINK_CONTEXT_MODIFY_PROTECT_FLAGS: covers
+ *	iwl_link_ctx_cfg_cmd::protection_flags
+ * @LINK_CONTEXT_MODIFY_QOS_PARAMS: covers iwl_link_ctx_cfg_cmd::qos_flags,
+ *	iwl_link_ctx_cfg_cmd::ac,
+ * @LINK_CONTEXT_MODIFY_BEACON_TIMING: covers iwl_link_ctx_cfg_cmd::bi,
+ *	iwl_link_ctx_cfg_cmd::dtim_interval,
+ *	iwl_link_ctx_cfg_cmd::dtim_time,
+ *	iwl_link_ctx_cfg_cmd::dtim_tsf,
+ *	iwl_link_ctx_cfg_cmd::assoc_beacon_arrive_time.
+ *	This flag can be set only once after assoc.
+ * @LINK_CONTEXT_MODIFY_HE_PARAMS: covers
+ *	iwl_link_ctx_cfg_cmd::htc_trig_based_pkt_ext
+ *	iwl_link_ctx_cfg_cmd::rand_alloc_ecwmin,
+ *	iwl_link_ctx_cfg_cmd::rand_alloc_ecwmax,
+ *	iwl_link_ctx_cfg_cmd::trig_based_txf,
+ *	iwl_link_ctx_cfg_cmd::bss_color,
+ *	iwl_link_ctx_cfg_cmd::ndp_fdbk_buff_th_exp,
+ *	iwl_link_ctx_cfg_cmd::ref_bssid_addr
+ *	iwl_link_ctx_cfg_cmd::bssid_index,
+ *	iwl_link_ctx_cfg_cmd::frame_time_rts_th.
+ *	This flag can be set any time.
+ * @LINK_CONTEXT_MODIFY_BSS_COLOR_DISABLE: covers
+ *	iwl_link_ctx_cfg_cmd::bss_color_disable
+ * @LINK_CONTEXT_MODIFY_EHT_PARAMS: covers iwl_link_ctx_cfg_cmd::puncture_mask.
+ *	This flag can be set only if the MAC that this link relates to has
+ *	eht_support set to true.
+ * @LINK_CONTEXT_MODIFY_ALL: set all above flags
+ */
+enum iwl_link_ctx_modify_flags {
+	LINK_CONTEXT_MODIFY_ACTIVE		= BIT(0),
+	LINK_CONTEXT_MODIFY_RATES_INFO		= BIT(1),
+	LINK_CONTEXT_MODIFY_PROTECT_FLAGS	= BIT(2),
+	LINK_CONTEXT_MODIFY_QOS_PARAMS		= BIT(3),
+	LINK_CONTEXT_MODIFY_BEACON_TIMING	= BIT(4),
+	LINK_CONTEXT_MODIFY_HE_PARAMS		= BIT(5),
+	LINK_CONTEXT_MODIFY_BSS_COLOR_DISABLE	= BIT(6),
+	LINK_CONTEXT_MODIFY_EHT_PARAMS		= BIT(7),
+	LINK_CONTEXT_MODIFY_ALL			= 0xff,
+}; /* LINK_CONTEXT_MODIFY_MASK_E_VER_1 */
+
+/**
+ * enum iwl_link_ctx_protection_flags - link protection flags
+ * @LINK_PROT_FLG_TGG_PROTECT: 11g protection when transmitting OFDM frames,
+ *	this will require CCK RTS/CTS2self.
+ *	RTS/CTS will protect full burst time.
+ * @LINK_PROT_FLG_HT_PROT: enable HT protection
+ * @LINK_PROT_FLG_FAT_PROT: protect 40 MHz transmissions
+ * @LINK_PROT_FLG_SELF_CTS_EN: allow CTS2self
+ */
+enum iwl_link_ctx_protection_flags {
+	LINK_PROT_FLG_TGG_PROTECT	= BIT(0),
+	LINK_PROT_FLG_HT_PROT		= BIT(1),
+	LINK_PROT_FLG_FAT_PROT		= BIT(2),
+	LINK_PROT_FLG_SELF_CTS_EN	= BIT(3),
+}; /* LINK_PROTECT_FLAGS_E_VER_1 */
+
+/**
+ * enum iwl_link_ctx_flags - link context flags
+ *
+ * @LINK_FLG_BSS_COLOR_DIS: BSS color disable, don't use the BSS
+ *	color for RX filter but use MAC header
+ *	enabled AGG, i.e. both BACK and non-BACK frames in a single AGG
+ * @LINK_FLG_MU_EDCA_CW: indicates that there is an element of MU EDCA
+ *	parameter set, i.e. the backoff counters for trig-based ACs
+ * @LINK_FLG_RU_2MHZ_BLOCK: indicates that 26-tone RU OFDMA transmission are
+ *      not allowed (as there are OBSS that might classify such transmissions as
+ *      radar pulses).
+ */
+enum iwl_link_ctx_flags {
+	LINK_FLG_BSS_COLOR_DIS		= BIT(0),
+	LINK_FLG_MU_EDCA_CW		= BIT(1),
+	LINK_FLG_RU_2MHZ_BLOCK		= BIT(2),
+}; /* LINK_CONTEXT_FLAG_E_VER_1 */
+
+/**
+ * struct iwl_link_config_cmd - command structure to configure the LINK context
+ *	in MLD API
+ * ( LINK_CONFIG_CMD =0x9 )
+ *
+ * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @link_id: the id of the link that this cmd configures
+ * @mac_id: interface ID. Relevant only if action is FW_CTXT_ACTION_ADD
+ * @phy_id: PHY index. Can be changed only if the link was inactive
+ *	(and stays inactive). If the link is active (or becomes active),
+ *	this field is ignored.
+ * @local_link_addr: the links MAC address. Can be changed only if the link was
+ *	inactive (and stays inactive). If the link is active
+ *	(or becomes active), this field is ignored.
+ * @reserved_for_local_link_addr: reserved
+ * @modify_mask: from &enum iwl_link_ctx_modify_flags, selects what to change.
+ *	Relevant only if action is FW_CTXT_ACTION_MODIFY
+ * @active: indicates whether the link is active or not
+ * @listen_lmac: indicates whether the link should be allocated on the Listen
+ *	Lmac or on the Main Lmac. Cannot be changed on an active Link.
+ *	Relevant only for eSR.
+ * @cck_rates: basic rates available for CCK
+ * @ofdm_rates: basic rates available for OFDM
+ * @cck_short_preamble: 1 for enabling short preamble, 0 otherwise
+ * @short_slot: 1 for enabling short slots, 0 otherwise
+ * @protection_flags: combination of &enum iwl_link_ctx_protection_flags
+ * @qos_flags: from &enum iwl_mac_qos_flags
+ * @ac: one iwl_mac_qos configuration for each AC
+ * @htc_trig_based_pkt_ext: default PE in 4us units
+ * @rand_alloc_ecwmin: random CWmin = 2**ECWmin-1
+ * @rand_alloc_ecwmax: random CWmax = 2**ECWmax-1
+ * @ndp_fdbk_buff_th_exp: set exponent for the NDP feedback buffered threshold
+ * @trig_based_txf: MU EDCA Parameter set for the trigger based traffic queues
+ * @dtim_time: DTIM arrival time in system time
+ * @dtim_tsf: DTIM arrival time in TSF
+ * @assoc_beacon_arrive_time: TSF of first beacon after association
+ * @bi: beacon interval in TU, applicable only when associated
+ * @dtim_interval: DTIM interval in TU.
+ *	Relevant only for GO, otherwise this is offloaded.
+ * @beacon_template: beacon template ID. For GO only
+ * @puncture_mask: puncture mask for EHT
+ * @frame_time_rts_th: HE duration RTS threshold, in units of 32us
+ * @flags: a combination from &enum iwl_link_ctx_flags
+ * @flags_mask: what of %flags have changed. Also &enum iwl_link_ctx_flags
+ * Below fields are for multi-bssid:
+ * @ref_bssid_addr: reference BSSID used by the AP
+ * @reserved_for_ref_bssid_addr: reserved
+ * @bssid_index: index of the associated VAP
+ * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
+ * @reserved: alignment
+ */
+struct iwl_link_config_cmd {
+	__le32 action;
+	__le32 link_id;
+	__le32 mac_id;
+	__le32 phy_id;
+	u8 local_link_addr[6];
+	__le16 reserved_for_local_link_addr;
+	__le32 modify_mask;
+	__le32 active;
+	__le32 listen_lmac;
+	__le32 cck_rates;
+	__le32 ofdm_rates;
+	__le32 cck_short_preamble;
+	__le32 short_slot;
+	__le32 protection_flags;
+	/* MAC_QOS_PARAM_API_S_VER_1 */
+	__le32 qos_flags;
+	struct iwl_ac_qos ac[AC_NUM + 1];
+	u8 htc_trig_based_pkt_ext;
+	u8 rand_alloc_ecwmin;
+	u8 rand_alloc_ecwmax;
+	u8 ndp_fdbk_buff_th_exp;
+	struct iwl_he_backoff_conf trig_based_txf[AC_NUM];
+	__le32 dtim_time;
+	__le64 dtim_tsf;
+	__le32 assoc_beacon_arrive_time;
+	__le32 bi;
+	__le32 dtim_interval;
+	__le32 beacon_template;
+	__le16 puncture_mask;
+	__le16 frame_time_rts_th;
+	__le32 flags;
+	__le32 flags_mask;
+	/* The below fields are for multi-bssid */
+	u8 ref_bssid_addr[6];
+	__le16 reserved_for_ref_bssid_addr;
+	u8 bssid_index;
+	u8 bss_color;
+	u8 reserved[2];
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index d71f0a99b7c4..ec6346c6c8e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -7,7 +7,7 @@ iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
-iwlmvm-y += mld-key.o mld-mac.o
+iwlmvm-y += mld-key.o mld-mac.o link.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
new file mode 100644
index 000000000000..2688cb49c951
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include "mvm.h"
+
+static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
+				 struct iwl_link_config_cmd *cmd,
+				 enum iwl_ctxt_action action)
+{
+	int ret;
+
+	cmd->action = cpu_to_le32(action);
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD), 0,
+				   sizeof(*cmd), cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to send LINK_CONFIG_CMD (action:%d): %d\n",
+			action, ret);
+	return ret;
+}
+
+int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_link_config_cmd cmd = {};
+
+	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+		return -EINVAL;
+
+	/* Update SF - Disable if needed. if this fails, SF might still be on
+	 * while many macs are bound, which is forbidden - so fail the binding.
+	 */
+	if (iwl_mvm_sf_update(mvm, vif, false))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+	cmd.mac_id = cpu_to_le32(mvmvif->id);
+	cmd.phy_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+
+	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
+
+	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
+}
+
+int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 u32 changes, bool active)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->phy_ctxt;
+	struct iwl_link_config_cmd cmd = {};
+	u32 ht_flag, flags = 0, flags_mask = 0;
+
+	if (!phyctxt)
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(phyctxt->id);
+
+	/* The phy_id, link address and listen_lmac can be modified only until
+	 * the link becomes active, otherwise they will be ignored.
+	 */
+	cmd.phy_id = cpu_to_le32(phyctxt->id);
+	cmd.mac_id = cpu_to_le32(mvmvif->id);
+
+	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
+
+	cmd.active = cpu_to_le32(active);
+
+	/* TODO: set a value to cmd.listen_lmac when system requiremens
+	 * will define it
+	 */
+
+	iwl_mvm_set_fw_basic_rates(mvm, vif, &cmd.cck_rates, &cmd.ofdm_rates);
+
+	cmd.cck_short_preamble = cpu_to_le32(vif->bss_conf.use_short_preamble);
+	cmd.short_slot = cpu_to_le32(vif->bss_conf.use_short_slot);
+
+	/* The fw does not distinguish between ht and fat */
+	ht_flag = LINK_PROT_FLG_HT_PROT | LINK_PROT_FLG_FAT_PROT;
+	iwl_mvm_set_fw_protection_flags(mvm, vif, &cmd.protection_flags,
+					ht_flag, LINK_PROT_FLG_TGG_PROTECT);
+
+	iwl_mvm_set_fw_qos_params(mvm, vif, &cmd.ac[0], &cmd.qos_flags);
+
+	/* We need the dtim_period to set the MAC as associated */
+	if (vif->cfg.assoc && vif->bss_conf.dtim_period)
+		iwl_mvm_set_fw_dtim_tbtt(mvm, vif, &cmd.dtim_tsf,
+					 &cmd.dtim_time,
+					 &cmd.assoc_beacon_arrive_time);
+	else
+		changes &= ~LINK_CONTEXT_MODIFY_BEACON_TIMING;
+
+	cmd.bi = cpu_to_le32(vif->bss_conf.beacon_int);
+	cmd.dtim_interval = cpu_to_le32(vif->bss_conf.beacon_int *
+					vif->bss_conf.dtim_period);
+
+	/* TODO: Assumes that the beacon id == mac context id */
+	cmd.beacon_template = cpu_to_le32(mvmvif->id);
+
+	if (!vif->bss_conf.he_support || iwlwifi_mod_params.disable_11ax ||
+	    !vif->cfg.assoc) {
+		changes &= ~LINK_CONTEXT_MODIFY_HE_PARAMS;
+		goto send_cmd;
+	}
+
+	cmd.htc_trig_based_pkt_ext = vif->bss_conf.htc_trig_based_pkt_ext;
+
+	if (vif->bss_conf.uora_exists) {
+		cmd.rand_alloc_ecwmin =
+			vif->bss_conf.uora_ocw_range & 0x7;
+		cmd.rand_alloc_ecwmax =
+			(vif->bss_conf.uora_ocw_range >> 3) & 0x7;
+	}
+
+	/* TODO  how to set ndp_fdbk_buff_th_exp? */
+
+	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif,
+					  &cmd.trig_based_txf[0])) {
+		flags |= LINK_FLG_MU_EDCA_CW;
+		flags_mask |= LINK_FLG_MU_EDCA_CW;
+	}
+
+	if (vif->bss_conf.eht_puncturing && !iwlwifi_mod_params.disable_11be)
+		cmd.puncture_mask = cpu_to_le16(vif->bss_conf.eht_puncturing);
+	else
+		/* This flag can be set only if the MAC has eht support */
+		changes &= ~LINK_CONTEXT_MODIFY_EHT_PARAMS;
+
+	cmd.bss_color = vif->bss_conf.he_bss_color.color;
+
+	if (!vif->bss_conf.he_bss_color.enabled) {
+		flags |= LINK_FLG_BSS_COLOR_DIS;
+		flags_mask |= LINK_FLG_BSS_COLOR_DIS;
+	}
+
+	cmd.frame_time_rts_th = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+
+	/* Block 26-tone RU OFDMA transmissions */
+	if (mvmvif->he_ru_2mhz_block) {
+		flags |= LINK_FLG_RU_2MHZ_BLOCK;
+		flags_mask |= LINK_FLG_RU_2MHZ_BLOCK;
+	}
+
+	if (vif->bss_conf.nontransmitted) {
+		ether_addr_copy(cmd.ref_bssid_addr,
+				vif->bss_conf.transmitter_bssid);
+		cmd.bssid_index = vif->bss_conf.bssid_index;
+	}
+
+send_cmd:
+	cmd.modify_mask = cpu_to_le32(changes);
+	cmd.flags = cpu_to_le32(flags);
+	cmd.flags_mask = cpu_to_le32(flags_mask);
+
+	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
+}
+
+int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_link_config_cmd cmd = {};
+	int ret;
+
+	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(mvmvif->phy_ctxt->id);
+	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
+
+	if (!ret)
+		if (iwl_mvm_sf_update(mvm, vif, true))
+			IWL_ERR(mvm, "Failed to update SF state\n");
+
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b21327ec4401..4d7ad91c53d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -396,9 +396,8 @@ static void iwl_mvm_ack_rates(struct iwl_mvm *mvm,
 	*ofdm_rates = ofdm;
 }
 
-static void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif,
-				       __le32 *cck_rates, __le32 *ofdm_rates)
+void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				__le32 *cck_rates, __le32 *ofdm_rates)
 {
 	struct ieee80211_chanctx_conf *chanctx;
 	u8 cck_ack_rates, ofdm_ack_rates;
@@ -414,11 +413,10 @@ static void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm,
 	*ofdm_rates = cpu_to_le32((u32)ofdm_ack_rates);
 }
 
-static void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif,
-					    __le32 *protection_flags,
-					    u32 ht_flag,
-					    u32 tgg_flag)
+void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     __le32 *protection_flags, u32 ht_flag,
+				     u32 tgg_flag)
 {
 	/* for both sta and ap, ht_operation_mode hold the protection_mode */
 	u8 protection_mode = vif->bss_conf.ht_operation_mode &
@@ -460,9 +458,8 @@ static void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      struct iwl_ac_qos *ac, __le32 *qos_flags)
+void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct iwl_ac_qos *ac, __le32 *qos_flags)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int i;
@@ -572,10 +569,9 @@ static int iwl_mvm_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
 	return ret;
 }
 
-static void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     __le64 *dtim_tsf, __le32 *dtim_time,
-				     __le32 *assoc_beacon_arrive_time)
+void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      __le64 *dtim_tsf, __le32 *dtim_time,
+			      __le32 *assoc_beacon_arrive_time)
 {
 	u32 dtim_offs;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 210b134c735f..cf08cb834cc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2000,10 +2000,9 @@ static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
  * This function sets the MU EDCA parameters ans returns whether MU EDCA
  * is enabled or not
  */
-static bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
-					  struct iwl_mvm_vif *mvmvif,
-					  struct iwl_he_backoff_conf
-					  *trig_based_txf)
+bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
+				   struct iwl_mvm_vif *mvmvif,
+				   struct iwl_he_backoff_conf *trig_based_txf)
 {
 	int i;
 	/* Mark MU EDCA as enabled, unless none detected on some AC */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 72f429537572..fd32eea9459b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1640,6 +1640,20 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 
 /* MAC (virtual interface) programming */
 
+void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				__le32 *cck_rates, __le32 *ofdm_rates);
+void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     __le32 *protection_flags, u32 ht_flag,
+				  u32 tgg_flag);
+void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct iwl_ac_qos *ac, __le32 *qos_flags);
+bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
+				   struct iwl_mvm_vif *mvmvif,
+				   struct iwl_he_backoff_conf *trig_based_txf);
+void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			      __le64 *dtim_tsf, __le32 *dtim_time,
+			      __le32 *assoc_beacon_arrive_time);
 __le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
 					      struct ieee80211_vif *vif);
 void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
@@ -1702,6 +1716,12 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
+/* Links */
+int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 u32 changes, bool active);
+int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 69c390ff2745..c3767f62026a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -522,6 +522,7 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(CHANNEL_SWITCH_TIME_EVENT_CMD),
 	HCMD_NAME(SESSION_PROTECTION_CMD),
 	HCMD_NAME(MAC_CONFIG_CMD),
+	HCMD_NAME(LINK_CONFIG_CMD),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
-- 
2.38.1

