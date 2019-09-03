Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E084A62BC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfICHiJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:38:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728043AbfICHiH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Nk-0004Cd-SL; Tue, 03 Sep 2019 10:37:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:13 +0300
Message-Id: <20190903073714.32278-21-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 20/21] iwlwifi: dbg_ini: remove periodic trigger
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Remove periodic trigger functionality.
After moving to the new API we will add periodic trigger functionality
that matches the new API.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 27 +------------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  6 ++---
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  2 --
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 -
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  6 +++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 7 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 310b85b508b3..5c8602de9168 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2381,7 +2381,7 @@ void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 {
 	int i;
 
-	del_timer(&fwrt->dump.periodic_trig);
+	iwl_dbg_tlv_del_timers(fwrt->trans);
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
 		iwl_fw_dbg_collect_sync(fwrt, i);
 
@@ -2389,31 +2389,6 @@ void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_sync);
 
-void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t)
-{
-	struct iwl_fw_runtime *fwrt;
-	enum iwl_fw_ini_trigger_id id = IWL_FW_TRIGGER_ID_PERIODIC_TRIGGER;
-	int ret;
-	typeof(fwrt->dump) *dump_ptr = container_of(t, typeof(fwrt->dump),
-						    periodic_trig);
-
-	fwrt = container_of(dump_ptr, typeof(*fwrt), dump);
-
-	ret = _iwl_fw_dbg_ini_collect(fwrt, id);
-	if (!ret || ret == -EBUSY) {
-		struct iwl_fw_ini_trigger *trig =
-			fwrt->dump.active_trigs[id].trig;
-		u32 occur = le32_to_cpu(trig->occurrences);
-		u32 collect_interval = le32_to_cpu(trig->trigger_data);
-
-		if (!occur)
-			return;
-
-		mod_timer(&fwrt->dump.periodic_trig,
-			  jiffies + msecs_to_jiffies(collect_interval));
-	}
-}
-
 #define FSEQ_REG(x) { .addr = (x), .str = #x, }
 
 void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index b2445bef908c..14181e6dc00d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -314,7 +314,7 @@ static inline void iwl_fw_flush_dumps(struct iwl_fw_runtime *fwrt)
 {
 	int i;
 
-	del_timer(&fwrt->dump.periodic_trig);
+	iwl_dbg_tlv_del_timers(fwrt->trans);
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
 		flush_delayed_work(&fwrt->dump.wks[i].wk);
 		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
@@ -325,7 +325,7 @@ static inline void iwl_fw_cancel_dumps(struct iwl_fw_runtime *fwrt)
 {
 	int i;
 
-	del_timer(&fwrt->dump.periodic_trig);
+	iwl_dbg_tlv_del_timers(fwrt->trans);
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
 		cancel_delayed_work_sync(&fwrt->dump.wks[i].wk);
 		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
@@ -400,8 +400,6 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 	}
 }
 
-void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t);
-
 void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt);
 
 static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index c16d6e126e3c..ba00d162ce72 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -81,8 +81,6 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 		INIT_DELAYED_WORK(&fwrt->dump.wks[i].wk, iwl_fw_error_dump_wk);
 	}
 	iwl_fwrt_dbgfs_register(fwrt, dbgfs_dir);
-	timer_setup(&fwrt->dump.periodic_trig,
-		    iwl_fw_dbg_periodic_trig_handler, 0);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_runtime_init);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 40b92509085d..8b8ab6d692b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -159,7 +159,6 @@ struct iwl_fw_runtime {
 		u32 umac_err_id;
 
 		struct iwl_txf_iter_data txf_iter_data;
-		struct timer_list periodic_trig;
 
 		u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
 		u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index db76b28eac40..3d7f8ff8ef58 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -151,6 +151,12 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	*cfg_state = IWL_INI_CFG_STATE_CORRUPTED;
 }
 
+void iwl_dbg_tlv_del_timers(struct iwl_trans *trans)
+{
+	/* will be used later */
+}
+IWL_EXPORT_SYMBOL(iwl_dbg_tlv_del_timers);
+
 void iwl_dbg_tlv_free(struct iwl_trans *trans)
 {
 	/* will be used again later */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index c7988b6a209a..e257ad358c94 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -92,5 +92,6 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data);
+void iwl_dbg_tlv_del_timers(struct iwl_trans *trans);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 35af56acc30b..3acbd5b7ab4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1239,7 +1239,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 {
 	iwl_abort_notification_waits(&mvm->notif_wait);
-	del_timer(&mvm->fwrt.dump.periodic_trig);
+	iwl_dbg_tlv_del_timers(mvm->trans);
 
 	/*
 	 * This is a bit racy, but worst case we tell mac80211 about
-- 
2.23.0.rc1

