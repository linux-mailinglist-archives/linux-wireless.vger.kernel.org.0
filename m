Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE90090D77
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfHQGwU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 02:52:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36304 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbfHQGwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:19 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hysZV-0006XT-Kk; Sat, 17 Aug 2019 09:52:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 17 Aug 2019 09:51:46 +0300
Message-Id: <20190817065200.9701-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190817065200.9701-1-luca@coelho.fi>
References: <20190817065200.9701-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 08/22] iwlwifi: dbg: support debug recording suspend resume command
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Support the new DBGC_SUSPEND_RESUME command to change the recording state.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 30 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 99 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  9 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 6 files changed, 87 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 988584973aba..b627c31d06ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -80,6 +80,13 @@ enum iwl_debug_cmds {
 	 * &struct iwl_dbg_mem_access_rsp
 	 */
 	UMAC_RD_WR = 0x1,
+	/**
+	 * @DBGC_SUSPEND_RESUME:
+	 * DBGC suspend/resume commad. Uses a single dword as data:
+	 * 0 - resume DBGC recording
+	 * 1 - suspend DBGC recording
+	 */
+	DBGC_SUSPEND_RESUME = 0x7,
 	/**
 	 * @MFU_ASSERT_DUMP_NTF:
 	 * &struct iwl_mfu_assert_dump_notif
@@ -102,6 +109,16 @@ enum {
 	FW_ERR_FATAL = 0xFF
 };
 
+/** enum iwl_dbg_suspend_resume_cmds - dbgc suspend resume operations
+ * dbgc suspend resume command operations
+ * @DBGC_RESUME_CMD: resume dbgc recording
+ * @DBGC_SUSPEND_CMD: stop dbgc recording
+ */
+enum iwl_dbg_suspend_resume_cmds {
+	DBGC_RESUME_CMD,
+	DBGC_SUSPEND_CMD,
+};
+
 /**
  * struct iwl_error_resp - FW error indication
  * ( REPLY_ERROR = 0x2 )
@@ -380,4 +397,13 @@ struct iwl_ldbg_config_cmd {
 	}; /* LDBG_CFG_BODY_API_U_VER_2 (partially) */
 } __packed; /* LDBG_CFG_CMD_API_S_VER_2 */
 
+/**
+ * struct iwl_dbg_suspend_resume_cmd - dbgc suspend resume command
+ * @operation: suspend or resume operation, uses
+ *	&enum iwl_dbg_suspend_resume_cmds
+ */
+struct iwl_dbg_suspend_resume_cmd {
+	__le32 operation;
+} __packed;
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 9ccaecc10474..34f4cda3b090 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2372,7 +2372,10 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
-	iwl_fw_dbg_stop_recording(fwrt->trans, &params);
+	if (iwl_fw_dbg_stop_restart_recording(fwrt, &params, true)) {
+		IWL_ERR(fwrt, "Failed to stop DBGC recording, aborting dump\n");
+		goto out;
+	}
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
 	if (fwrt->trans->dbg.ini_valid)
@@ -2381,7 +2384,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		iwl_fw_error_dump(fwrt);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection done\n");
 
-	iwl_fw_dbg_restart_recording(fwrt, &params);
+	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
 out:
 	clear_bit(wk_idx, &fwrt->dump.active_wks);
@@ -2870,7 +2873,7 @@ void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
 		iwl_fw_dbg_collect_sync(fwrt, i);
 
-	iwl_fw_dbg_stop_recording(fwrt->trans, NULL);
+	iwl_fw_dbg_stop_restart_recording(fwrt, NULL, true);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_sync);
 
@@ -2938,8 +2941,24 @@ void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_error_print_fseq_regs);
 
-static void _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
-				       struct iwl_fw_dbg_params *params)
+static int iwl_fw_dbg_suspend_resume_hcmd(struct iwl_trans *trans, bool suspend)
+{
+	struct iwl_dbg_suspend_resume_cmd cmd = {
+		.operation = suspend ?
+			cpu_to_le32(DBGC_SUSPEND_CMD) :
+			cpu_to_le32(DBGC_RESUME_CMD),
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DEBUG_GROUP, DBGC_SUSPEND_RESUME),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+
+	return iwl_trans_send_cmd(trans, &hcmd);
+}
+
+static void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
+				      struct iwl_fw_dbg_params *params)
 {
 	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
@@ -2957,37 +2976,13 @@ static void _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 	 */
 	usleep_range(700, 1000);
 	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	trans->dbg.rec_on = false;
-#endif
-}
-
-void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
-			       struct iwl_fw_dbg_params *params)
-{
-	/* if the FW crashed or not debug monitor cfg was given, there is
-	 * no point in stopping
-	 */
-	if (test_bit(STATUS_FW_ERROR, &trans->status) ||
-	    (!trans->dbg.dest_tlv &&
-	     trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
-		return;
-
-	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
-		IWL_ERR(trans,
-			"WRT: unsupported device family %d for debug stop recording\n",
-			trans->cfg->device_family);
-		return;
-	}
-	_iwl_fw_dbg_stop_recording(trans, params);
 }
-IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_recording);
 
-static void _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
-					  struct iwl_fw_dbg_params *params)
+static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
+					struct iwl_fw_dbg_params *params)
 {
-	if (WARN_ON(!params))
-		return;
+	if (!params)
+		return -EIO;
 
 	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
@@ -2997,28 +2992,40 @@ static void _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 		iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, params->in_sample);
 		iwl_write_umac_prph(trans, DBGC_OUT_CTRL, params->out_ctrl);
 	}
+
+	return 0;
 }
 
-void iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
-				  struct iwl_fw_dbg_params *params)
+int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
+				      struct iwl_fw_dbg_params *params,
+				      bool stop)
 {
+	int ret = 0;
+
 	/* if the FW crashed or not debug monitor cfg was given, there is
-	 * no point in restarting
+	 * no point in changing the recording state
 	 */
 	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
 	    (!fwrt->trans->dbg.dest_tlv &&
 	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
-		return;
+		return 0;
 
-	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
-		IWL_ERR(fwrt,
-			"WRT: unsupported device family %d for debug restart recording\n",
-			fwrt->trans->cfg->device_family);
-		return;
-	}
-	_iwl_fw_dbg_restart_recording(fwrt->trans, params);
+	if (fw_has_capa(&fwrt->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP))
+		ret = iwl_fw_dbg_suspend_resume_hcmd(fwrt->trans, stop);
+	else if (stop)
+		iwl_fw_dbg_stop_recording(fwrt->trans, params);
+	else
+		ret = iwl_fw_dbg_restart_recording(fwrt->trans, params);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	iwl_fw_set_dbg_rec_on(fwrt);
+	if (!ret) {
+		if (stop)
+			fwrt->trans->dbg.rec_on = false;
+		else
+			iwl_fw_set_dbg_rec_on(fwrt);
+	}
 #endif
+
+	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_fw_dbg_restart_recording);
+IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_restart_recording);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 5582a11f7c89..461331703ea6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -262,12 +262,9 @@ _iwl_fw_dbg_trigger_simple_stop(struct iwl_fw_runtime *fwrt,
 	_iwl_fw_dbg_trigger_simple_stop((fwrt), (wdev),		\
 					iwl_fw_dbg_get_trigger((fwrt)->fw,\
 							       (trig)))
-
-void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
-			       struct iwl_fw_dbg_params *params);
-
-void iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
-				  struct iwl_fw_dbg_params *params);
+int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
+				      struct iwl_fw_dbg_params *params,
+				      bool stop);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 0c38e7392b61..ea2b3d77f848 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -465,6 +465,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_LED_CMD_SUPPORT		= (__force iwl_ucode_tlv_capa_t)88,
 	IWL_UCODE_TLV_CAPA_MCC_UPDATE_11AX_SUPPORT	= (__force iwl_ucode_tlv_capa_t)89,
 	IWL_UCODE_TLV_CAPA_CSI_REPORTING		= (__force iwl_ucode_tlv_capa_t)90,
+	IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP	= (__force iwl_ucode_tlv_capa_t)92,
 
 	/* set 3 */
 	IWL_UCODE_TLV_CAPA_MLME_OFFLOAD			= (__force iwl_ucode_tlv_capa_t)96,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cec40855a641..3a8a0c43cb6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1083,7 +1083,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	 * recording automatically.
 	 */
 	if (mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_9000)
-		iwl_fw_dbg_stop_recording(mvm->trans, NULL);
+		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
 	/* must be last -- this switches firmware state */
 	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 722e427d534c..bf0b9ee05c44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -465,6 +465,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_debug_names[] = {
+	HCMD_NAME(DBGC_SUSPEND_RESUME),
 	HCMD_NAME(MFU_ASSERT_DUMP_NTF),
 };
 
-- 
2.23.0.rc1

