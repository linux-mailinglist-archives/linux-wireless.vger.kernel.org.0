Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2249FACA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiA1Nen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37846 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348911AbiA1Nem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:42 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROf-0002DK-Rw;
        Fri, 28 Jan 2022 15:34:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:23 +0200
Message-Id: <iwlwifi.20220128153014.cc4f9d1a2e9b.Ieb023cd773ea22e819d1ef1c37ae857ecc1a839d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 03/13] iwlwifi: prefer WIDE_ID() over iwl_cmd_id()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The order of arguments for iwl_cmd_id() is confusing, and the
version is always 0 and thus a useless argument. Prefer the
WIDE_ID() macro (which needs to be a macro due to use in switch
cases etc.) over the iwl_cmd_id() function.

Obviously done with spatch:

  @@
  expression G, C;
  @@
  -iwl_cmd_id(C, G, 0)
  +WIDE_ID(G, C)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c     |  5 ++---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/init.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c    |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c    | 13 ++++++-------
 .../wireless/intel/iwlwifi/mvm/ftm-initiator.c  | 17 ++++++++---------
 .../wireless/intel/iwlwifi/mvm/ftm-responder.c  | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   |  3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c   |  9 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c | 17 +++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c  |  3 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    |  4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c    |  2 +-
 18 files changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index db0c41bbeb0e..895ea75b394f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- * Copyright(c) 2018, 2020 Intel Corporation
+ * Copyright(c) 2018, 2020-2021 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portionhelp of the ieee80211 subsystem header files.
@@ -1015,8 +1015,7 @@ void iwl_rx_dispatch(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 		/* No handling needed */
 		IWL_DEBUG_RX(priv, "No handler needed for %s, 0x%02x\n",
 			     iwl_get_cmd_string(priv->trans,
-						iwl_cmd_id(pkt->hdr.cmd,
-							   0, 0)),
+						WIDE_ID(0, pkt->hdr.cmd)),
 			     pkt->hdr.cmd);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index a152ce306475..43e997283db0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -150,7 +150,7 @@ static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_dbg_host_event_cfg_cmd event_cfg;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(HOST_EVENT_CFG, DEBUG_GROUP, 0),
+		.id = WIDE_ID(DEBUG_GROUP, HOST_EVENT_CFG),
 		.flags = CMD_ASYNC,
 		.data[0] = &event_cfg,
 		.len[0] = sizeof(event_cfg),
@@ -358,7 +358,7 @@ static int iwl_dbgfs_fw_info_seq_show(struct seq_file *seq, void *v)
 
 	ver = &fw->ucode_capa.cmd_versions[state->pos];
 
-	cmd_id = iwl_cmd_id(ver->cmd, ver->group, 0);
+	cmd_id = WIDE_ID(ver->group, ver->cmd);
 
 	seq_printf(seq, "  0x%04x:\n", cmd_id);
 	seq_printf(seq, "    name: %s\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 139ece879fab..a914f77aae30 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -58,7 +58,7 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_soc_configuration_cmd cmd = {};
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(SOC_CONFIGURATION_CMD, SYSTEM_GROUP, 0),
+		.id = WIDE_ID(SYSTEM_GROUP, SOC_CONFIGURATION_CMD),
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
 	};
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 58ca3849d1f3..89ec3693c6ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -243,7 +243,7 @@ static int iwl_send_paging_cmd(struct iwl_fw_runtime *fwrt,
 		.block_num = cpu_to_le32(fwrt->num_of_paging_blk),
 	};
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(FW_PAGING_BLOCK_CMD, IWL_ALWAYS_LONG_GROUP, 0),
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, FW_PAGING_BLOCK_CMD),
 		.len = { sizeof(paging_cmd), },
 		.data = { &paging_cmd, },
 	};
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index f2f1789f470d..3f1272014daf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -89,7 +89,7 @@ void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt)
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_EXTEND_SHARED_MEM_CFG))
-		cmd.id = iwl_cmd_id(SHARED_MEM_CFG_CMD, SYSTEM_GROUP, 0);
+		cmd.id = WIDE_ID(SYSTEM_GROUP, SHARED_MEM_CFG_CMD);
 	else
 		cmd.id = SHARED_MEM_CFG;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index fb4920b01dbb..d256652a6ce3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1661,7 +1661,7 @@ iwl_dbgfs_he_sniffer_params_write(struct iwl_mvm *mvm, char *buf,
 		.mvm = mvm,
 	};
 	u16 wait_cmds[] = {
-		iwl_cmd_id(HE_AIR_SNIFFER_CONFIG_CMD, DATA_PATH_GROUP, 0),
+		WIDE_ID(DATA_PATH_GROUP, HE_AIR_SNIFFER_CONFIG_CMD),
 	};
 	u32 aid;
 	int ret;
@@ -1696,8 +1696,9 @@ iwl_dbgfs_he_sniffer_params_write(struct iwl_mvm *mvm, char *buf,
 				   wait_cmds, ARRAY_SIZE(wait_cmds),
 				   iwl_mvm_sniffer_apply, &apply);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(HE_AIR_SNIFFER_CONFIG_CMD,
-						   DATA_PATH_GROUP, 0), 0,
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(DATA_PATH_GROUP, HE_AIR_SNIFFER_CONFIG_CMD),
+				   0,
 				   sizeof(he_mon_cmd), &he_mon_cmd);
 
 	/* no need to really wait, we already did anyway */
@@ -1914,8 +1915,7 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	hcmd.id = iwl_cmd_id(*ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR,
-			     DEBUG_GROUP, 0);
+	hcmd.id = WIDE_ID(DEBUG_GROUP, *ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
 	cmd.op = cpu_to_le32(DEBUG_MEM_OP_READ);
 
 	/* Take care of alignment of both the position and the length */
@@ -1969,8 +1969,7 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	hcmd.id = iwl_cmd_id(*ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR,
-			     DEBUG_GROUP, 0);
+	hcmd.id = WIDE_ID(DEBUG_GROUP, *ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
 
 	if (*ppos & 0x3 || count < 4) {
 		op = DEBUG_MEM_OP_WRITE_BYTES;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 628aee634b2a..5c1a89969c8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -548,7 +548,7 @@ static int iwl_mvm_ftm_start_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_tof_range_req_cmd_v5 cmd_v5;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd_v5,
 		.len[0] = sizeof(cmd_v5),
@@ -574,7 +574,7 @@ static int iwl_mvm_ftm_start_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_tof_range_req_cmd_v7 cmd_v7;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd_v7,
 		.len[0] = sizeof(cmd_v7),
@@ -604,7 +604,7 @@ static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_tof_range_req_cmd_v8 cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
@@ -630,7 +630,7 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_tof_range_req_cmd_v9 cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
@@ -728,7 +728,7 @@ static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
 {
 	struct iwl_tof_range_req_cmd_v11 cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
@@ -799,7 +799,7 @@ static int iwl_mvm_ftm_start_v12(struct iwl_mvm *mvm,
 {
 	struct iwl_tof_range_req_cmd_v12 cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
@@ -827,7 +827,7 @@ static int iwl_mvm_ftm_start_v13(struct iwl_mvm *mvm,
 {
 	struct iwl_tof_range_req_cmd_v13 cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
@@ -927,8 +927,7 @@ void iwl_mvm_ftm_abort(struct iwl_mvm *mvm, struct cfg80211_pmsr_request *req)
 
 	iwl_mvm_ftm_reset(mvm);
 
-	if (iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(TOF_RANGE_ABORT_CMD,
-						 LOCATION_GROUP, 0),
+	if (iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(LOCATION_GROUP, TOF_RANGE_ABORT_CMD),
 				 0, sizeof(cmd), &cmd))
 		IWL_ERR(mvm, "failed to abort FTM process\n");
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index bda6da7d988e..0b5f80f73c5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -161,8 +161,8 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	memcpy(cmd.bssid, vif->addr, ETH_ALEN);
 
-	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(TOF_RESPONDER_CONFIG_CMD,
-						    LOCATION_GROUP, 0),
+	return iwl_mvm_send_cmd_pdu(mvm,
+				    WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_CONFIG_CMD),
 				    0, cmd_size, &cmd);
 }
 
@@ -177,8 +177,7 @@ iwl_mvm_ftm_responder_dyn_cfg_v2(struct iwl_mvm *mvm,
 	};
 	u8 data[IWL_LCI_CIVIC_IE_MAX_SIZE] = {0};
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RESPONDER_DYN_CONFIG_CMD,
-				 LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
 		.data[1] = &data,
@@ -220,8 +219,7 @@ iwl_mvm_ftm_responder_dyn_cfg_v3(struct iwl_mvm *mvm,
 {
 	struct iwl_tof_responder_dyn_config_cmd cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = iwl_cmd_id(TOF_RESPONDER_DYN_CONFIG_CMD,
-				 LOCATION_GROUP, 0),
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
 		.data[0] = &cmd,
 		.len[0] = sizeof(cmd),
 		/* may not be able to DMA from stack */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6a2a8ed1429a..0bb288a17353 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -79,7 +79,7 @@ static int iwl_mvm_send_dqa_cmd(struct iwl_mvm *mvm)
 	struct iwl_dqa_enable_cmd dqa_cmd = {
 		.cmd_queue = cpu_to_le32(IWL_MVM_DQA_CMD_QUEUE),
 	};
-	u32 cmd_id = iwl_cmd_id(DQA_ENABLE_CMD, DATA_PATH_GROUP, 0);
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, DQA_ENABLE_CMD);
 	int ret;
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(dqa_cmd), &dqa_cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8ef572bcc2ab..0e06454c1404 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2328,8 +2328,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	sta_ctxt_cmd.flags = cpu_to_le32(flags);
 
-	if (iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(STA_HE_CTXT_CMD,
-						 DATA_PATH_GROUP, 0),
+	if (iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(DATA_PATH_GROUP, STA_HE_CTXT_CMD),
 				 0, size, &sta_ctxt_cmd))
 		IWL_ERR(mvm, "Failed to config FW to work HE!\n");
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
index 3d0166df2002..c862bd243b55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 66808c55aa0e..be42490d3ad5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -420,7 +420,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct ieee80211_hw *hw = mvm->hw;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
-	u32 cmd_id = iwl_cmd_id(TLC_MNG_CONFIG_CMD, DATA_PATH_GROUP, 0);
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
 	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 5f92a09db374..c0b7e451def1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1156,7 +1156,7 @@ static int iwl_mvm_legacy_config_scan(struct iwl_mvm *mvm)
 	void *cfg;
 	int ret, cmd_size;
 	struct iwl_host_cmd cmd = {
-		.id = iwl_cmd_id(SCAN_CFG_CMD, IWL_ALWAYS_LONG_GROUP, 0),
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_CFG_CMD),
 	};
 	enum iwl_mvm_scan_type type;
 	enum iwl_mvm_scan_type hb_type = IWL_SCAN_TYPE_NOT_SET;
@@ -1247,7 +1247,7 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 {
 	struct iwl_scan_config cfg;
 	struct iwl_host_cmd cmd = {
-		.id = iwl_cmd_id(SCAN_CFG_CMD, IWL_ALWAYS_LONG_GROUP, 0),
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_CFG_CMD),
 		.len[0] = sizeof(cfg),
 		.data[0] = &cfg,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
@@ -2588,7 +2588,7 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 	if (uid < 0)
 		return uid;
 
-	hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
+	hcmd->id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_REQ_UMAC);
 
 	scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
 					 SCAN_REQ_UMAC,
@@ -2922,8 +2922,7 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 	IWL_DEBUG_SCAN(mvm, "Sending scan abort, uid %u\n", uid);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   iwl_cmd_id(SCAN_ABORT_UMAC,
-					      IWL_ALWAYS_LONG_GROUP, 0),
+				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
 				   0, sizeof(cmd), &cmd);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5a4a8ffbfc02..6ced0c084ab9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4009,7 +4009,7 @@ void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 	int ret;
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   iwl_cmd_id(CANCEL_CHANNEL_SWITCH_CMD, MAC_CONF_GROUP, 0),
+				   WIDE_ID(MAC_CONF_GROUP, CANCEL_CHANNEL_SWITCH_CMD),
 				   CMD_ASYNC,
 				   sizeof(cancel_channel_switch_cmd),
 				   &cancel_channel_switch_cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index ab06dcda1462..49260a5f774b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -658,8 +658,8 @@ static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 	};
 	int ret;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
-						   MAC_CONF_GROUP, 0),
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 				   0, sizeof(cmd), &cmd);
 	if (ret)
 		IWL_ERR(mvm,
@@ -923,8 +923,8 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 	}
 
 	cmd.conf_id = cpu_to_le32(mvmvif->time_event_data.id);
-	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
-						    MAC_CONF_GROUP, 0),
+	return iwl_mvm_send_cmd_pdu(mvm,
+				    WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 				    0, sizeof(cmd), &cmd);
 }
 
@@ -1162,8 +1162,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
-	const u16 notif[] = { iwl_cmd_id(SESSION_PROTECTION_NOTIF,
-					 MAC_CONF_GROUP, 0) };
+	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color =
@@ -1201,8 +1200,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 
 	if (!wait_for_notif) {
 		if (iwl_mvm_send_cmd_pdu(mvm,
-					 iwl_cmd_id(SESSION_PROTECTION_CMD,
-						    MAC_CONF_GROUP, 0),
+					 WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 					 0, sizeof(cmd), &cmd)) {
 			IWL_ERR(mvm,
 				"Couldn't send the SESSION_PROTECTION_CMD\n");
@@ -1219,8 +1217,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 				   iwl_mvm_session_prot_notif, NULL);
 
 	if (iwl_mvm_send_cmd_pdu(mvm,
-				 iwl_cmd_id(SESSION_PROTECTION_CMD,
-					    MAC_CONF_GROUP, 0),
+				 WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 				 0, sizeof(cmd), &cmd)) {
 		IWL_ERR(mvm,
 			"Couldn't send the SESSION_PROTECTION_CMD\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 1f3e90e5dbd4..1affdafb07fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -480,8 +480,7 @@ void iwl_mvm_send_low_latency_cmd(struct iwl_mvm *mvm,
 		cmd.low_latency_tx = 1;
 	}
 
-	if (iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(LOW_LATENCY_CMD,
-						 MAC_CONF_GROUP, 0),
+	if (iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, LOW_LATENCY_CMD),
 				 0, sizeof(cmd), &cmd))
 		IWL_ERR(mvm, "Failed to send low latency command\n");
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 8247014278f3..9e488f21fde2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1307,9 +1307,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 			     "Q %d: cmd at offset %d: %s (%.2x.%2x, seq 0x%x)\n",
 			     rxq->id, offset,
 			     iwl_get_cmd_string(trans,
-						iwl_cmd_id(pkt->hdr.cmd,
-							   pkt->hdr.group_id,
-							   0)),
+						WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)),
 			     pkt->hdr.group_id, pkt->hdr.cmd,
 			     le16_to_cpu(pkt->hdr.sequence));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 4f6c187eed69..d54a8df280a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1201,7 +1201,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	cmd = txq->entries[cmd_index].cmd;
 	meta = &txq->entries[cmd_index].meta;
 	group_id = cmd->hdr.group_id;
-	cmd_id = iwl_cmd_id(cmd->hdr.cmd, group_id, 0);
+	cmd_id = WIDE_ID(group_id, cmd->hdr.cmd);
 
 	iwl_txq_gen1_tfd_unmap(trans, meta, txq, index);
 
-- 
2.34.1

