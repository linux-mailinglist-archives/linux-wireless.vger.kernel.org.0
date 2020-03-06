Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E217BE10
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCFNQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 08:16:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:60940 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgCFNQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jACqM-0005yR-4b; Fri, 06 Mar 2020 15:16:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  6 Mar 2020 15:16:25 +0200
Message-Id: <iwlwifi.20200306151129.dcec37b2efd4.I8dcd190431d110a6a0e88095ce93591ccfb3d78d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306131627.503176-1-luca@coelho.fi>
References: <20200306131627.503176-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 5/7] iwlwifi: dbg: don't abort if sending DBGC_SUSPEND_RESUME fails
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If the firmware is in a bad state or not initialized fully, sending
the DBGC_SUSPEND_RESUME command fails but we can still collect logs.

Instead of aborting the entire dump process, simply ignore the error.
By removing the last callpoint that was checking the return value, we
can also convert the function to return void.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 576058330f2d ("iwlwifi: dbg: support debug recording suspend resume command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 15 +++++----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h |  6 +++---
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e60eb5cc847f..8796ab8f2a5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2490,10 +2490,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
-	if (iwl_fw_dbg_stop_restart_recording(fwrt, &params, true)) {
-		IWL_ERR(fwrt, "Failed to stop DBGC recording, aborting dump\n");
-		goto out;
-	}
+	iwl_fw_dbg_stop_restart_recording(fwrt, &params, true);
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection start\n");
 	if (iwl_trans_dbg_ini_valid(fwrt->trans))
@@ -2658,14 +2655,14 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 	return 0;
 }
 
-int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_dbg_params *params,
-				      bool stop)
+void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
+				       struct iwl_fw_dbg_params *params,
+				       bool stop)
 {
 	int ret = 0;
 
 	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
-		return 0;
+		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP))
@@ -2682,7 +2679,5 @@ int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 			iwl_fw_set_dbg_rec_on(fwrt);
 	}
 #endif
-
-	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_restart_recording);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 179f2905d56b..9d3513213f5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -239,9 +239,9 @@ _iwl_fw_dbg_trigger_simple_stop(struct iwl_fw_runtime *fwrt,
 	_iwl_fw_dbg_trigger_simple_stop((fwrt), (wdev),		\
 					iwl_fw_dbg_get_trigger((fwrt)->fw,\
 							       (trig)))
-int iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_dbg_params *params,
-				      bool stop);
+void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
+				       struct iwl_fw_dbg_params *params,
+				       bool stop);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
-- 
2.25.1

