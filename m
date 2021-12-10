Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2246FD7B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhLJJQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50896 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239100AbhLJJQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:30 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxW-001FED-8y; Fri, 10 Dec 2021 11:12:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:39 +0200
Message-Id: <iwlwifi.20211210110539.c727a975b434.Ie5ad3fd974b700f1b90867b2b52ef7607799e8fe@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/10] iwlwifi: dump RCM error tables
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's another set of error tables on newer (Bz) hardware,
support finding and dumping those error tables if present.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 68 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 10 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 6c794f885d47..b90f1e9ce691 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -294,6 +294,72 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 			table.sw_status[i], i);
 }
 
+/*
+ * RCM error struct.
+ * Note: This structure is read from the device with IO accesses,
+ * and the reading already does the endian conversion. As it is
+ * read with u32-sized accesses, any members with a different size
+ * need to be ordered correctly though!
+ */
+struct iwl_rcm_error_event_table {
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
+	u32 frame_hw_status;
+	u32 mbx_lmac_to_rcm_req;
+	u32 mbx_rcm_to_lmac_req;
+	u32 mh_ctl;
+	u32 mh_addr1_lo;
+	u32 mh_info;
+	u32 mh_err;
+	u32 reserved[3];
+} __packed; /* RCM_LOG_ERROR_TABLE_API_S_VER_1 */
+
+static void iwl_fwrt_dump_rcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_rcm_error_event_table table = {};
+	u32 base = fwrt->trans->dbg.rcm_error_event_table[idx];
+	u32 flag = idx ? IWL_ERROR_EVENT_TABLE_RCM2 :
+			 IWL_ERROR_EVENT_TABLE_RCM1;
+
+	if (!base || !(fwrt->trans->dbg.error_event_table_tlv_status & flag))
+		return;
+
+	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
+
+	IWL_ERR(fwrt, "RCM%d status:\n", idx + 1);
+	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
+	IWL_ERR(fwrt, "0x%08X | rcm branchlink2\n", table.blink2);
+	IWL_ERR(fwrt, "0x%08X | rcm interruptlink1\n", table.ilink1);
+	IWL_ERR(fwrt, "0x%08X | rcm interruptlink2\n", table.ilink2);
+	IWL_ERR(fwrt, "0x%08X | rcm data1\n", table.data1);
+	IWL_ERR(fwrt, "0x%08X | rcm data2\n", table.data2);
+	IWL_ERR(fwrt, "0x%08X | rcm data3\n", table.data3);
+	IWL_ERR(fwrt, "0x%08X | rcm log PC\n", table.logpc);
+	IWL_ERR(fwrt, "0x%08X | rcm frame pointer\n", table.frame_pointer);
+	IWL_ERR(fwrt, "0x%08X | rcm stack pointer\n", table.stack_pointer);
+	IWL_ERR(fwrt, "0x%08X | rcm msg ID\n", table.msgid);
+	IWL_ERR(fwrt, "0x%08X | rcm ISR status\n", table.isr);
+	IWL_ERR(fwrt, "0x%08X | frame HW status\n", table.frame_hw_status);
+	IWL_ERR(fwrt, "0x%08X | LMAC-to-RCM request mbox\n",
+		table.mbx_lmac_to_rcm_req);
+	IWL_ERR(fwrt, "0x%08X | RCM-to-LMAC request mbox\n",
+		table.mbx_rcm_to_lmac_req);
+	IWL_ERR(fwrt, "0x%08X | MAC header control\n", table.mh_ctl);
+	IWL_ERR(fwrt, "0x%08X | MAC header addr1 low\n", table.mh_addr1_lo);
+	IWL_ERR(fwrt, "0x%08X | MAC header info\n", table.mh_info);
+	IWL_ERR(fwrt, "0x%08X | MAC header error\n", table.mh_err);
+}
+
 static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_trans *trans = fwrt->trans;
@@ -376,7 +442,9 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 		iwl_fwrt_dump_lmac_error_log(fwrt, 1);
 	iwl_fwrt_dump_umac_error_log(fwrt);
 	iwl_fwrt_dump_tcm_error_log(fwrt, 0);
+	iwl_fwrt_dump_rcm_error_log(fwrt, 0);
 	iwl_fwrt_dump_tcm_error_log(fwrt, 1);
+	iwl_fwrt_dump_rcm_error_log(fwrt, 1);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 7d5c7deaae47..9652da2b8125 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -631,6 +631,16 @@ static void iwl_parse_dbg_tlv_assert_tables(struct iwl_drv *drv,
 		drv->trans->dbg.error_event_table_tlv_status |=
 			IWL_ERROR_EVENT_TABLE_TCM2;
 		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_RCM_1_ERROR_TABLE:
+		drv->trans->dbg.rcm_error_event_table[0] = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_RCM1;
+		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_RCM_2_ERROR_TABLE:
+		drv->trans->dbg.rcm_error_event_table[1] = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_RCM2;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3720801df118..b8428dc3b6d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -195,6 +195,8 @@ enum iwl_error_event_table_status {
 	IWL_ERROR_EVENT_TABLE_UMAC = BIT(2),
 	IWL_ERROR_EVENT_TABLE_TCM1 = BIT(3),
 	IWL_ERROR_EVENT_TABLE_TCM2 = BIT(4),
+	IWL_ERROR_EVENT_TABLE_RCM1 = BIT(5),
+	IWL_ERROR_EVENT_TABLE_RCM2 = BIT(6),
 };
 
 /**
@@ -730,6 +732,7 @@ struct iwl_self_init_dram {
  * @lmac_error_event_table: addrs of lmacs error tables
  * @umac_error_event_table: addr of umac error table
  * @tcm_error_event_table: address(es) of TCM error table(s)
+ * @rcm_error_event_table: address(es) of RCM error table(s)
  * @error_event_table_tlv_status: bitmap that indicates what error table
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
  * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
@@ -757,6 +760,7 @@ struct iwl_trans_debug {
 	u32 lmac_error_event_table[2];
 	u32 umac_error_event_table;
 	u32 tcm_error_event_table[2];
+	u32 rcm_error_event_table[2];
 	unsigned int error_event_table_tlv_status;
 
 	enum iwl_ini_cfg_state internal_ini_cfg;
-- 
2.34.1

