Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5890D76
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfHQGwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 02:52:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36298 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbfHQGwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:19 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hysZU-0006XT-SX; Sat, 17 Aug 2019 09:52:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 17 Aug 2019 09:51:45 +0300
Message-Id: <20190817065200.9701-8-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190817065200.9701-1-luca@coelho.fi>
References: <20190817065200.9701-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 07/22] iwlwifi: dbg: move debug recording stop from trans to op mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The op mode should stop the debug recording and not the transport layer.
Rename iwl_fwrt_stop_device into iwl_fw_dbg_stop_sync and move the debug
stop recording to it.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c          | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h          | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c          | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         | 3 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      | 3 ---
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index dfb0c50df94c..9ccaecc10474 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2862,7 +2862,7 @@ void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_apply_point);
 
-void iwl_fwrt_stop_device(struct iwl_fw_runtime *fwrt)
+void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 {
 	int i;
 
@@ -2870,9 +2870,9 @@ void iwl_fwrt_stop_device(struct iwl_fw_runtime *fwrt)
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
 		iwl_fw_dbg_collect_sync(fwrt, i);
 
-	iwl_trans_stop_device(fwrt->trans);
+	iwl_fw_dbg_stop_recording(fwrt->trans, NULL);
 }
-IWL_EXPORT_SYMBOL(iwl_fwrt_stop_device);
+IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_sync);
 
 void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index d6b012459b04..5582a11f7c89 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -373,7 +373,7 @@ static inline void iwl_fw_resume_timestamp(struct iwl_fw_runtime *fwrt) {}
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_apply_point apply_point);
 
-void iwl_fwrt_stop_device(struct iwl_fw_runtime *fwrt);
+void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt);
 
 static inline void iwl_fw_lmac1_set_alive_err_table(struct iwl_trans *trans,
 						    u32 lmac_error_event_table)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a57fc6198a72..ed6453b2fc79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1140,6 +1140,7 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 		return ret;
 	}
 
+	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	/*
 	 * Stop and start the transport without entering low power
 	 * mode. This will save the state of other components on the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a14701c8933b..e5703aa7935e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2037,7 +2037,8 @@ static inline void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 	lockdep_assert_held(&mvm->mutex);
 	iwl_fw_cancel_timestamp(&mvm->fwrt);
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
-	iwl_fwrt_stop_device(&mvm->fwrt);
+	iwl_fw_dbg_stop_sync(&mvm->fwrt);
+	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
 	iwl_fw_dump_conf_clear(&mvm->fwrt);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 8d17e68577fd..104b7cc75248 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -147,9 +147,6 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
 
 	trans_pcie->is_down = true;
 
-	/* Stop dbgc before stopping device */
-	iwl_fw_dbg_stop_recording(trans, NULL);
-
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f5df5b370d78..a6deb61a3ab4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1242,9 +1242,6 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool low_power)
 
 	trans_pcie->is_down = true;
 
-	/* Stop dbgc before stopping device */
-	iwl_fw_dbg_stop_recording(trans, NULL);
-
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
 
-- 
2.23.0.rc1

