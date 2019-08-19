Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B000694ADA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfHSQuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37010 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727540AbfHSQuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:19 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrJ-0007zi-05; Mon, 19 Aug 2019 19:50:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:49:51 +0300
Message-Id: <20190819165007.10181-7-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 06/22] iwlwifi: dbg: move monitor recording functionality from header file
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The recording functions are quite big to be inline and the driver should
expose only the stop and restart functions that are allowed to be used
rather then the internal helper functions. Move the functions from the
header file.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 85 ++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 89 +--------------------
 2 files changed, 89 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 4d81776f576d..dfb0c50df94c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2937,3 +2937,88 @@ void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
 	iwl_trans_release_nic_access(trans, &flags);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_error_print_fseq_regs);
+
+static void _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
+				       struct iwl_fw_dbg_params *params)
+{
+	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
+		return;
+	}
+
+	if (params) {
+		params->in_sample = iwl_read_umac_prph(trans, DBGC_IN_SAMPLE);
+		params->out_ctrl = iwl_read_umac_prph(trans, DBGC_OUT_CTRL);
+	}
+
+	iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, 0);
+	/* wait for the DBGC to finish writing the internal buffer to DRAM to
+	 * avoid halting the HW while writing
+	 */
+	usleep_range(700, 1000);
+	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	trans->dbg.rec_on = false;
+#endif
+}
+
+void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
+			       struct iwl_fw_dbg_params *params)
+{
+	/* if the FW crashed or not debug monitor cfg was given, there is
+	 * no point in stopping
+	 */
+	if (test_bit(STATUS_FW_ERROR, &trans->status) ||
+	    (!trans->dbg.dest_tlv &&
+	     trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+		return;
+
+	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+		IWL_ERR(trans,
+			"WRT: unsupported device family %d for debug stop recording\n",
+			trans->cfg->device_family);
+		return;
+	}
+	_iwl_fw_dbg_stop_recording(trans, params);
+}
+IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_recording);
+
+static void _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
+					  struct iwl_fw_dbg_params *params)
+{
+	if (WARN_ON(!params))
+		return;
+
+	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
+		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
+		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
+	} else {
+		iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, params->in_sample);
+		iwl_write_umac_prph(trans, DBGC_OUT_CTRL, params->out_ctrl);
+	}
+}
+
+void iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
+				  struct iwl_fw_dbg_params *params)
+{
+	/* if the FW crashed or not debug monitor cfg was given, there is
+	 * no point in restarting
+	 */
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
+	    (!fwrt->trans->dbg.dest_tlv &&
+	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+		return;
+
+	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+		IWL_ERR(fwrt,
+			"WRT: unsupported device family %d for debug restart recording\n",
+			fwrt->trans->cfg->device_family);
+		return;
+	}
+	_iwl_fw_dbg_restart_recording(fwrt->trans, params);
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	iwl_fw_set_dbg_rec_on(fwrt);
+#endif
+}
+IWL_EXPORT_SYMBOL(iwl_fw_dbg_restart_recording);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index a8459ac71b2c..d6b012459b04 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -263,68 +263,11 @@ _iwl_fw_dbg_trigger_simple_stop(struct iwl_fw_runtime *fwrt,
 					iwl_fw_dbg_get_trigger((fwrt)->fw,\
 							       (trig)))
 
-static inline void
-_iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
-			   struct iwl_fw_dbg_params *params)
-{
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
-		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
-		return;
-	}
+void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
+			       struct iwl_fw_dbg_params *params);
 
-	if (params) {
-		params->in_sample = iwl_read_umac_prph(trans, DBGC_IN_SAMPLE);
-		params->out_ctrl = iwl_read_umac_prph(trans, DBGC_OUT_CTRL);
-	}
-
-	iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, 0);
-	/* wait for the DBGC to finish writing the internal buffer to DRAM to
-	 * avoid halting the HW while writing
-	 */
-	usleep_range(700, 1000);
-	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	trans->dbg.rec_on = false;
-#endif
-}
-
-static inline void
-iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
-			  struct iwl_fw_dbg_params *params)
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
-}
-
-static inline void
-_iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
-			      struct iwl_fw_dbg_params *params)
-{
-	if (WARN_ON(!params))
-		return;
-
-	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
-		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
-		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
-		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
-	} else {
-		iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, params->in_sample);
-		iwl_write_umac_prph(trans, DBGC_OUT_CTRL, params->out_ctrl);
-	}
-}
+void iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
+				  struct iwl_fw_dbg_params *params);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
@@ -336,30 +279,6 @@ static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
 }
 #endif
 
-static inline void
-iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
-			     struct iwl_fw_dbg_params *params)
-{
-	/* if the FW crashed or not debug monitor cfg was given, there is
-	 * no point in restarting
-	 */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
-	    (!fwrt->trans->dbg.dest_tlv &&
-	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
-		return;
-
-	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
-		IWL_ERR(fwrt,
-			"WRT: unsupported device family %d for debug restart recording\n",
-			fwrt->trans->cfg->device_family);
-		return;
-	}
-	_iwl_fw_dbg_restart_recording(fwrt->trans, params);
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	iwl_fw_set_dbg_rec_on(fwrt);
-#endif
-}
-
 static inline void iwl_fw_dump_conf_clear(struct iwl_fw_runtime *fwrt)
 {
 	fwrt->dump.conf = FW_DBG_INVALID;
-- 
2.23.0.rc1

