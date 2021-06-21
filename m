Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9323AE445
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFUHkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230071AbhFUHkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEVE-001aFa-QU; Mon, 21 Jun 2021 10:37:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:39 +0300
Message-Id: <iwlwifi.20210621103449.2d2149f6654f.Id831f8fbca59900ba7efc623ffca0ca938b664d3@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 8/9] iwlwifi: fw: dump TCM error table if present
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the TCM is present in the hardware (as advertised in the firmware
file TLV data), dump its error log table during firmware error dumps.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 60 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  5 ++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 11 ++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 +
 4 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 66f86d2a7cca..a1842205e86a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -271,6 +271,65 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 	IWL_ERR(fwrt, "0x%08X | flow_handler\n", table.flow_handler);
 }
 
+/*
+ * TCM error struct.
+ * Note: This structure is read from the device with IO accesses,
+ * and the reading already does the endian conversion. As it is
+ * read with u32-sized accesses, any members with a different size
+ * need to be ordered correctly though!
+ */
+struct iwl_tcm_error_event_table {
+	u32 valid;
+	u32 error_id;
+	u32 blink2;
+	u32 ilink1;
+	u32 ilink2;
+	u32 data1, data2, data3;
+	u32 logpc;
+	u32 frame_pointer;
+	u32 stack_pointer;
+	u32 msgid;
+	u32 isr;
+	u32 hw_status[5];
+	u32 sw_status[1];
+	u32 reserved[4];
+} __packed; /* TCM_LOG_ERROR_TABLE_API_S_VER_1 */
+
+static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_tcm_error_event_table table = {};
+	u32 base = fwrt->trans->dbg.tcm_error_event_table;
+	int i;
+
+	if (!base ||
+	    !(fwrt->trans->dbg.error_event_table_tlv_status &
+	      IWL_ERROR_EVENT_TABLE_TCM))
+		return;
+
+	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
+
+	IWL_ERR(fwrt, "TCM status:\n");
+	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
+	IWL_ERR(fwrt, "0x%08X | tcm branchlink2\n", table.blink2);
+	IWL_ERR(fwrt, "0x%08X | tcm interruptlink1\n", table.ilink1);
+	IWL_ERR(fwrt, "0x%08X | tcm interruptlink2\n", table.ilink2);
+	IWL_ERR(fwrt, "0x%08X | tcm data1\n", table.data1);
+	IWL_ERR(fwrt, "0x%08X | tcm data2\n", table.data2);
+	IWL_ERR(fwrt, "0x%08X | tcm data3\n", table.data3);
+	IWL_ERR(fwrt, "0x%08X | tcm log PC\n", table.logpc);
+	IWL_ERR(fwrt, "0x%08X | tcm frame pointer\n", table.frame_pointer);
+	IWL_ERR(fwrt, "0x%08X | tcm stack pointer\n", table.stack_pointer);
+	IWL_ERR(fwrt, "0x%08X | tcm msg ID\n", table.msgid);
+	IWL_ERR(fwrt, "0x%08X | tcm ISR status\n", table.isr);
+	for (i = 0; i < ARRAY_SIZE(table.hw_status); i++)
+		IWL_ERR(fwrt, "0x%08X | tcm HW status[%d]\n",
+			table.hw_status[i], i);
+	for (i = 0; i < ARRAY_SIZE(table.sw_status); i++)
+		IWL_ERR(fwrt, "0x%08X | tcm SW status[%d]\n",
+			table.sw_status[i], i);
+}
+
 static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_trans *trans = fwrt->trans;
@@ -352,6 +411,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	if (fwrt->trans->dbg.lmac_error_event_table[1])
 		iwl_fwrt_dump_lmac_error_log(fwrt, 1);
 	iwl_fwrt_dump_umac_error_log(fwrt);
+	iwl_fwrt_dump_tcm_error_log(fwrt);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 74e25a6ecc3d..9a8c7b7a0816 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -98,6 +98,7 @@ enum iwl_ucode_tlv_type {
 
 	IWL_UCODE_TLV_PNVM_VERSION		= 62,
 	IWL_UCODE_TLV_PNVM_SKU			= 64,
+	IWL_UCODE_TLV_TCM_DEBUG_ADDRS		= 65,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 
@@ -950,6 +951,10 @@ struct iwl_fw_cmd_version {
 	u8 notif_ver;
 } __packed;
 
+struct iwl_fw_tcm_error_addr {
+	__le32 addr;
+}; /* FW_TLV_TCM_ERROR_INFO_ADDRS_S */
+
 static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 					size_t fixed_size, size_t var_size)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 884750bf7840..977dce686bdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1117,6 +1117,17 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				IWL_ERROR_EVENT_TABLE_LMAC1;
 			break;
 			}
+		case IWL_UCODE_TLV_TCM_DEBUG_ADDRS: {
+			struct iwl_fw_tcm_error_addr *ptr = (void *)tlv_data;
+
+			if (tlv_len != sizeof(*ptr))
+				goto invalid_tlv_len;
+			drv->trans->dbg.tcm_error_event_table =
+				le32_to_cpu(ptr->addr) & ~FW_ADDR_CACHE_CONTROL;
+			drv->trans->dbg.error_event_table_tlv_status |=
+				IWL_ERROR_EVENT_TABLE_TCM;
+			break;
+			}
 		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
 		case IWL_UCODE_TLV_TYPE_HCMD:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 81868d92ef66..942c6f3f8d3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -193,6 +193,7 @@ enum iwl_error_event_table_status {
 	IWL_ERROR_EVENT_TABLE_LMAC1 = BIT(0),
 	IWL_ERROR_EVENT_TABLE_LMAC2 = BIT(1),
 	IWL_ERROR_EVENT_TABLE_UMAC = BIT(2),
+	IWL_ERROR_EVENT_TABLE_TCM = BIT(3),
 };
 
 /**
@@ -708,6 +709,7 @@ struct iwl_self_init_dram {
  * @trigger_tlv: array of pointers to triggers TLVs for debug
  * @lmac_error_event_table: addrs of lmacs error tables
  * @umac_error_event_table: addr of umac error table
+ * @tcm_error_event_table: address of TCM error table
  * @error_event_table_tlv_status: bitmap that indicates what error table
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
  * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
@@ -734,6 +736,7 @@ struct iwl_trans_debug {
 
 	u32 lmac_error_event_table[2];
 	u32 umac_error_event_table;
+	u32 tcm_error_event_table;
 	unsigned int error_event_table_tlv_status;
 
 	enum iwl_ini_cfg_state internal_ini_cfg;
-- 
2.32.0

