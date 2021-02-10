Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329D73166C5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBJMci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:32:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45084 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231925AbhBJMaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:30 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9ocd-0049Yg-Ta; Wed, 10 Feb 2021 14:29:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:20 +0200
Message-Id: <iwlwifi.20210210142629.8de8fe6f9fff.If040b056d0e8c771c65ac5c29230f939354a142b@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 05/12] iwlwifi: remove flags argument for nic_access
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we no longer save interrupts, we no longer need the flags
argument here, remove it throughout.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 10 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |  7 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 45 ++++++++----------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 46 +++++++------------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 13 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 10 ++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 31 +++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  5 +-
 8 files changed, 66 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 461af5831156..c01523f64bfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -406,7 +406,6 @@ static void iwl_print_cont_event_trace(struct iwl_priv *priv, u32 base,
 	u32 i;
 	u32 ptr;        /* SRAM byte address of log data */
 	u32 ev, time, data; /* event log data */
-	unsigned long reg_flags;
 
 	if (mode == 0)
 		ptr = base + (4 * sizeof(u32)) + (start_idx * 2 * sizeof(u32));
@@ -414,7 +413,7 @@ static void iwl_print_cont_event_trace(struct iwl_priv *priv, u32 base,
 		ptr = base + (4 * sizeof(u32)) + (start_idx * 3 * sizeof(u32));
 
 	/* Make sure device is powered up for SRAM reads */
-	if (!iwl_trans_grab_nic_access(priv->trans, &reg_flags))
+	if (!iwl_trans_grab_nic_access(priv->trans))
 		return;
 
 	/* Set starting address; reads will auto-increment */
@@ -446,7 +445,7 @@ static void iwl_print_cont_event_trace(struct iwl_priv *priv, u32 base,
 		}
 	}
 	/* Allow device to power down */
-	iwl_trans_release_nic_access(priv->trans, &reg_flags);
+	iwl_trans_release_nic_access(priv->trans);
 }
 
 static void iwl_continuous_event_trace(struct iwl_priv *priv)
@@ -1694,7 +1693,6 @@ static int iwl_print_event_log(struct iwl_priv *priv, u32 start_idx,
 	u32 event_size; /* 2 u32s, or 3 u32s if timestamp recorded */
 	u32 ptr;        /* SRAM byte address of log data */
 	u32 ev, time, data; /* event log data */
-	unsigned long reg_flags;
 
 	struct iwl_trans *trans = priv->trans;
 
@@ -1718,7 +1716,7 @@ static int iwl_print_event_log(struct iwl_priv *priv, u32 start_idx,
 	ptr = base + EVENT_START_OFFSET + (start_idx * event_size);
 
 	/* Make sure device is powered up for SRAM reads */
-	if (!iwl_trans_grab_nic_access(trans, &reg_flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return pos;
 
 	/* Set starting address; reads will auto-increment */
@@ -1757,7 +1755,7 @@ static int iwl_print_event_log(struct iwl_priv *priv, u32 start_idx,
 	}
 
 	/* Allow device to power down */
-	iwl_trans_release_nic_access(trans, &reg_flags);
+	iwl_trans_release_nic_access(trans);
 	return pos;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
index 8181ba573110..2684a924ba57 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018, 2020 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -155,7 +155,6 @@ static void iwl_tt_check_exit_ct_kill(struct timer_list *t)
 	struct iwl_priv *priv = from_timer(priv, t,
 					   thermal_throttle.ct_kill_exit_tm);
 	struct iwl_tt_mgmt *tt = &priv->thermal_throttle;
-	unsigned long flags;
 
 	if (test_bit(STATUS_EXIT_PENDING, &priv->status))
 		return;
@@ -171,8 +170,8 @@ static void iwl_tt_check_exit_ct_kill(struct timer_list *t)
 			priv->thermal_throttle.ct_kill_toggle = true;
 		}
 		iwl_read32(priv->trans, CSR_UCODE_DRV_GP1);
-		if (iwl_trans_grab_nic_access(priv->trans, &flags))
-			iwl_trans_release_nic_access(priv->trans, &flags);
+		if (iwl_trans_grab_nic_access(priv->trans))
+			iwl_trans_release_nic_access(priv->trans);
 
 		/* Reschedule the ct_kill timer to occur in
 		 * CT_KILL_EXIT_DURATION seconds to ensure we get a
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e87329265876..811480eac5fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -33,12 +33,11 @@ static void iwl_read_radio_regs(struct iwl_fw_runtime *fwrt,
 				struct iwl_fw_error_dump_data **dump_data)
 {
 	u8 *pos = (void *)(*dump_data)->data;
-	unsigned long flags;
 	int i;
 
 	IWL_DEBUG_INFO(fwrt, "WRT radio registers dump\n");
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return;
 
 	(*dump_data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_RADIO_REG);
@@ -56,7 +55,7 @@ static void iwl_read_radio_regs(struct iwl_fw_runtime *fwrt,
 
 	*dump_data = iwl_fw_error_next_data(*dump_data);
 
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 }
 
 static void iwl_fwrt_dump_rxf(struct iwl_fw_runtime *fwrt,
@@ -172,11 +171,10 @@ static void iwl_fw_dump_rxf(struct iwl_fw_runtime *fwrt,
 			    struct iwl_fw_error_dump_data **dump_data)
 {
 	struct iwl_fwrt_shared_mem_cfg *cfg = &fwrt->smem_cfg;
-	unsigned long flags;
 
 	IWL_DEBUG_INFO(fwrt, "WRT RX FIFO dump\n");
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return;
 
 	if (iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_RXF)) {
@@ -194,7 +192,7 @@ static void iwl_fw_dump_rxf(struct iwl_fw_runtime *fwrt,
 					  LMAC2_PRPH_OFFSET, 2);
 	}
 
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 }
 
 static void iwl_fw_dump_txf(struct iwl_fw_runtime *fwrt,
@@ -204,12 +202,11 @@ static void iwl_fw_dump_txf(struct iwl_fw_runtime *fwrt,
 	struct iwl_fwrt_shared_mem_cfg *cfg = &fwrt->smem_cfg;
 	u32 *fifo_data;
 	u32 fifo_len;
-	unsigned long flags;
 	int i, j;
 
 	IWL_DEBUG_INFO(fwrt, "WRT TX FIFO dump\n");
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return;
 
 	if (iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_TXF)) {
@@ -299,7 +296,7 @@ static void iwl_fw_dump_txf(struct iwl_fw_runtime *fwrt,
 		}
 	}
 
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 }
 
 #define IWL8260_ICCM_OFFSET		0x44000 /* Only for B-step */
@@ -527,7 +524,6 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_fw_error_dump_data **data =
 		(struct iwl_fw_error_dump_data **)ptr;
-	unsigned long flags;
 	u32 i;
 
 	if (!data)
@@ -535,7 +531,7 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 
 	IWL_DEBUG_INFO(trans, "WRT PRPH dump\n");
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return;
 
 	for (i = 0; i < range_len; i++) {
@@ -558,7 +554,7 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 		*data = iwl_fw_error_next_data(*data);
 	}
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 }
 
 /*
@@ -1048,7 +1044,6 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 	u32 addr = le32_to_cpu(reg->addrs[idx]);
 	u32 dphy_state;
 	u32 dphy_addr;
-	unsigned long flags;
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
@@ -1060,7 +1055,7 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 	indirect_wr_addr += le32_to_cpu(reg->dev_addr.offset);
 	indirect_rd_addr += le32_to_cpu(reg->dev_addr.offset);
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return -EBUSY;
 
 	dphy_addr = (reg->dev_addr.offset) ? WFPM_LMAC2_PS_CTL_RW :
@@ -1082,7 +1077,7 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 		*val++ = cpu_to_le32(prph_val);
 	}
 
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -1297,13 +1292,12 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 	u32 registers_size = registers_num * sizeof(*reg_dump);
 	__le32 *data;
-	unsigned long flags;
 	int i;
 
 	if (!iwl_ini_txf_iter(fwrt, reg_data, idx))
 		return -EIO;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return -EBUSY;
 
 	range->fifo_hdr.fifo_num = cpu_to_le32(iter->fifo);
@@ -1345,7 +1339,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 		*data++ = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans, addr));
 
 out:
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -1429,14 +1423,13 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 	u32 registers_size = registers_num * sizeof(*reg_dump);
 	__le32 *data;
-	unsigned long flags;
 	int i;
 
 	iwl_ini_get_rxf_data(fwrt, reg_data, &rxf_data);
 	if (!rxf_data.size)
 		return -EIO;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
 		return -EBUSY;
 
 	range->fifo_hdr.fifo_num = cpu_to_le32(rxf_data.fifo_num);
@@ -1479,7 +1472,7 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 		*data++ = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans, addr));
 
 out:
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -1596,9 +1589,8 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
-	unsigned long flags;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags)) {
+	if (!iwl_trans_grab_nic_access(fwrt->trans)) {
 		IWL_ERR(fwrt, "Failed to get monitor header\n");
 		return NULL;
 	}
@@ -1615,7 +1607,7 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
 	data->cur_frag = iwl_get_mon_reg(fwrt, alloc_id,
 					 &addrs->cur_frag);
 
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	iwl_trans_release_nic_access(fwrt->trans);
 
 	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 
@@ -2762,7 +2754,6 @@ IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_sync);
 void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_trans *trans = fwrt->trans;
-	unsigned long flags;
 	int i;
 	struct {
 		u32 addr;
@@ -2782,7 +2773,7 @@ void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
 		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
 	};
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return;
 
 	IWL_ERR(fwrt, "Fseq Registers:\n");
@@ -2792,7 +2783,7 @@ void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
 			iwl_read_prph_no_grab(trans, fseq_regs[i].addr),
 			fseq_regs[i].str);
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_error_print_fseq_regs);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 7819a70bffa2..33d42e08d5b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -66,10 +66,10 @@ IWL_EXPORT_SYMBOL(iwl_poll_bit);
 u32 iwl_read_direct32(struct iwl_trans *trans, u32 reg)
 {
 	u32 value = 0x5a5a5a5a;
-	unsigned long flags;
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+
+	if (iwl_trans_grab_nic_access(trans)) {
 		value = iwl_read32(trans, reg);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 
 	return value;
@@ -78,22 +78,18 @@ IWL_EXPORT_SYMBOL(iwl_read_direct32);
 
 void iwl_write_direct32(struct iwl_trans *trans, u32 reg, u32 value)
 {
-	unsigned long flags;
-
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		iwl_write32(trans, reg, value);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_write_direct32);
 
 void iwl_write_direct64(struct iwl_trans *trans, u64 reg, u64 value)
 {
-	unsigned long flags;
-
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		iwl_write64(trans, reg, value);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_write_direct64);
@@ -139,12 +135,11 @@ IWL_EXPORT_SYMBOL(iwl_write_prph64_no_grab);
 
 u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs)
 {
-	unsigned long flags;
 	u32 val = 0x5a5a5a5a;
 
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		val = iwl_read_prph_no_grab(trans, ofs);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 	return val;
 }
@@ -152,12 +147,10 @@ IWL_EXPORT_SYMBOL(iwl_read_prph);
 
 void iwl_write_prph_delay(struct iwl_trans *trans, u32 ofs, u32 val, u32 delay_ms)
 {
-	unsigned long flags;
-
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		mdelay(delay_ms);
 		iwl_write_prph_no_grab(trans, ofs, val);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_write_prph_delay);
@@ -179,13 +172,11 @@ int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 
 void iwl_set_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask)
 {
-	unsigned long flags;
-
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		iwl_write_prph_no_grab(trans, ofs,
 				       iwl_read_prph_no_grab(trans, ofs) |
 				       mask);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_set_bits_prph);
@@ -193,26 +184,23 @@ IWL_EXPORT_SYMBOL(iwl_set_bits_prph);
 void iwl_set_bits_mask_prph(struct iwl_trans *trans, u32 ofs,
 			    u32 bits, u32 mask)
 {
-	unsigned long flags;
-
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		iwl_write_prph_no_grab(trans, ofs,
 				       (iwl_read_prph_no_grab(trans, ofs) &
 					mask) | bits);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_set_bits_mask_prph);
 
 void iwl_clear_bits_prph(struct iwl_trans *trans, u32 ofs, u32 mask)
 {
-	unsigned long flags;
 	u32 val;
 
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		val = iwl_read_prph_no_grab(trans, ofs);
 		iwl_write_prph_no_grab(trans, ofs, (val & ~mask));
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_clear_bits_prph);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 70caee03bd1b..4a5822c1be13 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -579,9 +579,8 @@ struct iwl_trans_ops {
 			  const struct iwl_trans_config *trans_cfg);
 	void (*set_pmi)(struct iwl_trans *trans, bool state);
 	void (*sw_reset)(struct iwl_trans *trans);
-	bool (*grab_nic_access)(struct iwl_trans *trans, unsigned long *flags);
-	void (*release_nic_access)(struct iwl_trans *trans,
-				   unsigned long *flags);
+	bool (*grab_nic_access)(struct iwl_trans *trans);
+	void (*release_nic_access)(struct iwl_trans *trans);
 	void (*set_bits_mask)(struct iwl_trans *trans, u32 reg, u32 mask,
 			      u32 value);
 
@@ -1368,14 +1367,14 @@ iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg, u32 mask, u32 value)
 	trans->ops->set_bits_mask(trans, reg, mask, value);
 }
 
-#define iwl_trans_grab_nic_access(trans, flags)	\
+#define iwl_trans_grab_nic_access(trans)		\
 	__cond_lock(nic_access,				\
-		    likely((trans)->ops->grab_nic_access(trans, flags)))
+		    likely((trans)->ops->grab_nic_access(trans)))
 
 static inline void __releases(nic_access)
-iwl_trans_release_nic_access(struct iwl_trans *trans, unsigned long *flags)
+iwl_trans_release_nic_access(struct iwl_trans *trans)
 {
-	trans->ops->release_nic_access(trans, flags);
+	trans->ops->release_nic_access(trans);
 	__release(nic_access);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 664481ca58c9..534fe62b8a30 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -847,7 +847,6 @@ static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 rb_size;
-	unsigned long flags;
 	const u32 rfdnlog = RX_QUEUE_SIZE_LOG; /* 256 RBDs */
 
 	switch (trans_pcie->rx_buf_size) {
@@ -865,7 +864,7 @@ static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 		rb_size = FH_RCSR_RX_CONFIG_REG_VAL_RB_SIZE_4K;
 	}
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return;
 
 	/* Stop Rx DMA */
@@ -902,7 +901,7 @@ static void iwl_pcie_rx_hw_init(struct iwl_trans *trans, struct iwl_rxq *rxq)
 		    (RX_RB_TIMEOUT << FH_RCSR_RX_CONFIG_REG_IRQ_RBTH_POS) |
 		    (rfdnlog << FH_RCSR_RX_CONFIG_RBDCB_SIZE_POS));
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 	/* Set interrupt coalescing timer to default (2048 usecs) */
 	iwl_write8(trans, CSR_INT_COALESCING, IWL_HOST_INT_TIMEOUT_DEF);
@@ -916,7 +915,6 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 rb_size, enabled = 0;
-	unsigned long flags;
 	int i;
 
 	switch (trans_pcie->rx_buf_size) {
@@ -937,7 +935,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 		rb_size = RFH_RXF_DMA_RB_SIZE_4K;
 	}
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return;
 
 	/* Stop Rx DMA */
@@ -995,7 +993,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 	/* Enable the relevant rx queues */
 	iwl_write_prph_no_grab(trans, RFH_RXF_RXQ_ACTIVE, enabled);
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 	/* Set interrupt coalescing timer to default (2048 usecs) */
 	iwl_write8(trans, CSR_INT_COALESCING, IWL_HOST_INT_TIMEOUT_DEF);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c9e0cca1f903..1bf4c37fe960 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -640,17 +640,16 @@ static int iwl_pcie_load_firmware_chunk(struct iwl_trans *trans,
 					u32 byte_cnt)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	unsigned long flags;
 	int ret;
 
 	trans_pcie->ucode_write_complete = false;
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return -EIO;
 
 	iwl_pcie_load_firmware_chunk_fh(trans, dst_addr, phy_addr,
 					byte_cnt);
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 	ret = wait_event_timeout(trans_pcie->ucode_write_waitq,
 				 trans_pcie->ucode_write_complete, 5 * HZ);
@@ -1974,8 +1973,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
-					   unsigned long *flags)
+static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2078,8 +2076,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 	return true;
 }
 
-static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
-					      unsigned long *flags)
+static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2109,7 +2106,6 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
 static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 				   void *buf, int dwords)
 {
-	unsigned long flags;
 	int offs = 0;
 	u32 *vals = buf;
 
@@ -2118,7 +2114,7 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 		unsigned long end = jiffies + HZ / 2;
 		bool resched = false;
 
-		if (iwl_trans_grab_nic_access(trans, &flags)) {
+		if (iwl_trans_grab_nic_access(trans)) {
 			iwl_write32(trans, HBUS_TARG_MEM_RADDR,
 				    addr + 4 * offs);
 
@@ -2132,7 +2128,7 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 					break;
 				}
 			}
-			iwl_trans_release_nic_access(trans, &flags);
+			iwl_trans_release_nic_access(trans);
 
 			if (resched)
 				cond_resched();
@@ -2147,16 +2143,15 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 static int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
 				    const void *buf, int dwords)
 {
-	unsigned long flags;
 	int offs, ret = 0;
 	const u32 *vals = buf;
 
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
+	if (iwl_trans_grab_nic_access(trans)) {
 		iwl_write32(trans, HBUS_TARG_MEM_WADDR, addr);
 		for (offs = 0; offs < dwords; offs++)
 			iwl_write32(trans, HBUS_TARG_MEM_WDAT,
 				    vals ? vals[offs] : 0);
-		iwl_trans_release_nic_access(trans, &flags);
+		iwl_trans_release_nic_access(trans);
 	} else {
 		ret = -EBUSY;
 	}
@@ -2952,11 +2947,10 @@ static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
 				       struct iwl_fw_error_dump_data **data)
 {
 	u32 fh_regs_len = FH_MEM_UPPER_BOUND - FH_MEM_LOWER_BOUND;
-	unsigned long flags;
 	__le32 *val;
 	int i;
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return 0;
 
 	(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FH_REGS);
@@ -2974,7 +2968,7 @@ static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
 			*val++ = cpu_to_le32(iwl_trans_pcie_read_prph(trans,
 								      i));
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 	*data = iwl_fw_error_next_data(*data);
 
@@ -2988,10 +2982,9 @@ iwl_trans_pci_dump_marbh_monitor(struct iwl_trans *trans,
 {
 	u32 buf_size_in_dwords = (monitor_len >> 2);
 	u32 *buffer = (u32 *)fw_mon_data->data;
-	unsigned long flags;
 	u32 i;
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		return 0;
 
 	iwl_write_umac_prph_no_grab(trans, MON_DMARB_RD_CTL_ADDR, 0x1);
@@ -3000,7 +2993,7 @@ iwl_trans_pci_dump_marbh_monitor(struct iwl_trans *trans,
 						       MON_DMARB_RD_DATA_ADDR);
 	iwl_write_umac_prph_no_grab(trans, MON_DMARB_RD_CTL_ADDR, 0x0);
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 	return monitor_len;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index e8acbfbf3ddc..381e8f90b6f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -392,13 +392,12 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	unsigned long flags;
 	int ch, ret;
 	u32 mask = 0;
 
 	spin_lock_bh(&trans_pcie->irq_lock);
 
-	if (!iwl_trans_grab_nic_access(trans, &flags))
+	if (!iwl_trans_grab_nic_access(trans))
 		goto out;
 
 	/* Stop each Tx DMA channel */
@@ -414,7 +413,7 @@ static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 			"Failing on timeout while stopping DMA channel %d [0x%08x]\n",
 			ch, iwl_read32(trans, FH_TSSR_TX_STATUS_REG));
 
-	iwl_trans_release_nic_access(trans, &flags);
+	iwl_trans_release_nic_access(trans);
 
 out:
 	spin_unlock_bh(&trans_pcie->irq_lock);
-- 
2.30.0

