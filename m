Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC48546FD7A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhLJJQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50890 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234141AbhLJJQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:29 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxV-001FED-BK; Fri, 10 Dec 2021 11:12:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:38 +0200
Message-Id: <iwlwifi.20211210110539.887cba319301.Ifdc3f617f7e0e3e39c90e8c208e60f11b3bb9404@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/10] iwlwifi: dump both TCM error tables if present
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There can be two TCMs in a given device, dump both of the
error tables if present.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c   | 15 ++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c   |  9 +++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  7 ++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index b0f9a2cb2a93..6c794f885d47 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -259,21 +259,21 @@ struct iwl_tcm_error_event_table {
 	u32 reserved[4];
 } __packed; /* TCM_LOG_ERROR_TABLE_API_S_VER_1 */
 
-static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt)
+static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 {
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_tcm_error_event_table table = {};
-	u32 base = fwrt->trans->dbg.tcm_error_event_table;
+	u32 base = fwrt->trans->dbg.tcm_error_event_table[idx];
 	int i;
+	u32 flag = idx ? IWL_ERROR_EVENT_TABLE_TCM2 :
+			 IWL_ERROR_EVENT_TABLE_TCM1;
 
-	if (!base ||
-	    !(fwrt->trans->dbg.error_event_table_tlv_status &
-	      IWL_ERROR_EVENT_TABLE_TCM))
+	if (!base || !(fwrt->trans->dbg.error_event_table_tlv_status & flag))
 		return;
 
 	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
 
-	IWL_ERR(fwrt, "TCM status:\n");
+	IWL_ERR(fwrt, "TCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
 	IWL_ERR(fwrt, "0x%08X | tcm branchlink2\n", table.blink2);
 	IWL_ERR(fwrt, "0x%08X | tcm interruptlink1\n", table.ilink1);
@@ -375,7 +375,8 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	if (fwrt->trans->dbg.lmac_error_event_table[1])
 		iwl_fwrt_dump_lmac_error_log(fwrt, 1);
 	iwl_fwrt_dump_umac_error_log(fwrt);
-	iwl_fwrt_dump_tcm_error_log(fwrt);
+	iwl_fwrt_dump_tcm_error_log(fwrt, 0);
+	iwl_fwrt_dump_tcm_error_log(fwrt, 1);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index e8550fe3b39c..7d5c7deaae47 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -622,9 +622,14 @@ static void iwl_parse_dbg_tlv_assert_tables(struct iwl_drv *drv,
 			IWL_ERROR_EVENT_TABLE_LMAC2;
 		break;
 	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_TCM_1_ERROR_TABLE:
-		drv->trans->dbg.tcm_error_event_table = addr;
+		drv->trans->dbg.tcm_error_event_table[0] = addr;
 		drv->trans->dbg.error_event_table_tlv_status |=
-			IWL_ERROR_EVENT_TABLE_TCM;
+			IWL_ERROR_EVENT_TABLE_TCM1;
+		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_TCM_2_ERROR_TABLE:
+		drv->trans->dbg.tcm_error_event_table[1] = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_TCM2;
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index e7c6e7bc5277..3720801df118 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -193,7 +193,8 @@ enum iwl_error_event_table_status {
 	IWL_ERROR_EVENT_TABLE_LMAC1 = BIT(0),
 	IWL_ERROR_EVENT_TABLE_LMAC2 = BIT(1),
 	IWL_ERROR_EVENT_TABLE_UMAC = BIT(2),
-	IWL_ERROR_EVENT_TABLE_TCM = BIT(3),
+	IWL_ERROR_EVENT_TABLE_TCM1 = BIT(3),
+	IWL_ERROR_EVENT_TABLE_TCM2 = BIT(4),
 };
 
 /**
@@ -728,7 +729,7 @@ struct iwl_self_init_dram {
  * @trigger_tlv: array of pointers to triggers TLVs for debug
  * @lmac_error_event_table: addrs of lmacs error tables
  * @umac_error_event_table: addr of umac error table
- * @tcm_error_event_table: address of TCM error table
+ * @tcm_error_event_table: address(es) of TCM error table(s)
  * @error_event_table_tlv_status: bitmap that indicates what error table
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
  * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
@@ -755,7 +756,7 @@ struct iwl_trans_debug {
 
 	u32 lmac_error_event_table[2];
 	u32 umac_error_event_table;
-	u32 tcm_error_event_table;
+	u32 tcm_error_event_table[2];
 	unsigned int error_event_table_tlv_status;
 
 	enum iwl_ini_cfg_state internal_ini_cfg;
-- 
2.34.1

