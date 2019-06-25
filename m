Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEE5286F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfFYJpD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54620 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727099AbfFYJpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0a-0007Nv-ME; Tue, 25 Jun 2019 12:45:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 06/12] iwlwifi: dbg_ini: add consecutive trigger firing support
Date:   Tue, 25 Jun 2019 12:44:46 +0300
Message-Id: <20190625094452.19034-7-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

When a dump trigger is fired, the driver sets IWL_FWRT_STATUS_DUMPING and
aborts any consecutive dump collection.
To allow consecutive triggers firing, use 5 dump workers and allocate
them upon incoming dump collection requests.

This functionality is needed since in ini debug mode each trigger may
have entirely different memory regions to collect unlike the legacy
mode in which all the triggers dump the same memory regions.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 76 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 19 +++--
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  7 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 15 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 16 ++--
 6 files changed, 84 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 8e2cf7141f0a..030889e3a10f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1912,18 +1912,18 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 }
 
 static struct iwl_fw_error_dump_file *
-iwl_fw_error_ini_dump_file(struct iwl_fw_runtime *fwrt)
+iwl_fw_error_ini_dump_file(struct iwl_fw_runtime *fwrt,
+			   enum iwl_fw_ini_trigger_id trig_id)
 {
 	int size;
 	struct iwl_fw_error_dump_data *dump_data;
 	struct iwl_fw_error_dump_file *dump_file;
 	struct iwl_fw_ini_trigger *trigger;
-	enum iwl_fw_ini_trigger_id id = fwrt->dump.ini_trig_id;
 
-	if (!iwl_fw_ini_trigger_on(fwrt, id))
+	if (!iwl_fw_ini_trigger_on(fwrt, trig_id))
 		return NULL;
 
-	trigger = fwrt->dump.active_trigs[id].trig;
+	trigger = fwrt->dump.active_trigs[trig_id].trig;
 
 	size = iwl_fw_ini_get_trigger_len(fwrt, trigger);
 	if (!size)
@@ -1988,16 +1988,16 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 
 out:
 	iwl_fw_free_dump_desc(fwrt);
-	clear_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status);
 }
 
-static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt)
+static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 {
+	enum iwl_fw_ini_trigger_id trig_id = fwrt->dump.wks[wk_idx].ini_trig_id;
 	struct iwl_fw_error_dump_file *dump_file;
 	struct scatterlist *sg_dump_data;
 	u32 file_len;
 
-	dump_file = iwl_fw_error_ini_dump_file(fwrt);
+	dump_file = iwl_fw_error_ini_dump_file(fwrt, trig_id);
 	if (!dump_file)
 		goto out;
 
@@ -2012,8 +2012,7 @@ static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt)
 	}
 	vfree(dump_file);
 out:
-	fwrt->dump.ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
-	clear_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status);
+	fwrt->dump.wks[wk_idx].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
 }
 
 const struct iwl_fw_dump_desc iwl_dump_desc_assert = {
@@ -2039,7 +2038,10 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 		return ret;
 	}
 
-	if (test_and_set_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status))
+	/* use wks[0] since dump flow prior to ini does not need to support
+	 * consecutive triggers collection
+	 */
+	if (test_and_set_bit(fwrt->dump.wks[0].idx, &fwrt->dump.active_wks))
 		return -EBUSY;
 
 	if (WARN_ON(fwrt->dump.desc))
@@ -2051,7 +2053,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	fwrt->dump.desc = desc;
 	fwrt->dump.monitor_only = monitor_only;
 
-	schedule_delayed_work(&fwrt->dump.wk, usecs_to_jiffies(delay));
+	schedule_delayed_work(&fwrt->dump.wks[0].wk, usecs_to_jiffies(delay));
 
 	return 0;
 }
@@ -2130,13 +2132,11 @@ int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_active_triggers *active;
 	u32 occur, delay;
+	unsigned long idx;
 
 	if (WARN_ON(!iwl_fw_ini_trigger_on(fwrt, id)))
 		return -EINVAL;
 
-	if (test_and_set_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status))
-		return -EBUSY;
-
 	if (!iwl_fw_ini_trigger_on(fwrt, id)) {
 		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
 			 id);
@@ -2157,14 +2157,24 @@ int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 		return 0;
 	}
 
-	if (test_and_set_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status))
+	/* Check there is an available worker.
+	 * ffz return value is undefined if no zero exists,
+	 * so check against ~0UL first.
+	 */
+	if (fwrt->dump.active_wks == ~0UL)
 		return -EBUSY;
 
-	fwrt->dump.ini_trig_id = id;
+	idx = ffz(fwrt->dump.active_wks);
+
+	if (idx >= IWL_FW_RUNTIME_DUMP_WK_NUM ||
+	    test_and_set_bit(fwrt->dump.wks[idx].idx, &fwrt->dump.active_wks))
+		return -EBUSY;
+
+	fwrt->dump.wks[idx].ini_trig_id = id;
 
 	IWL_WARN(fwrt, "WRT: collecting data: ini trigger %d fired.\n", id);
 
-	schedule_delayed_work(&fwrt->dump.wk, usecs_to_jiffies(delay));
+	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
 
 	return 0;
 }
@@ -2277,32 +2287,31 @@ IWL_EXPORT_SYMBOL(iwl_fw_start_dbg_conf);
 /* this function assumes dump_start was called beforehand and dump_end will be
  * called afterwards
  */
-void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt)
+static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 {
 	struct iwl_fw_dbg_params params = {0};
 
-	if (!test_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status))
+	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
 	if (fwrt->ops && fwrt->ops->fw_running &&
 	    !fwrt->ops->fw_running(fwrt->ops_ctx)) {
 		IWL_ERR(fwrt, "Firmware not running - cannot dump error\n");
 		iwl_fw_free_dump_desc(fwrt);
-		clear_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status);
-		return;
+		goto out;
 	}
 
 	/* there's no point in fw dump if the bus is dead */
 	if (test_bit(STATUS_TRANS_DEAD, &fwrt->trans->status)) {
 		IWL_ERR(fwrt, "Skip fw error dump since bus is dead\n");
-		return;
+		goto out;
 	}
 
 	iwl_fw_dbg_stop_recording(fwrt, &params);
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
 	if (fwrt->trans->ini_valid)
-		iwl_fw_error_ini_dump(fwrt);
+		iwl_fw_error_ini_dump(fwrt, wk_idx);
 	else
 		iwl_fw_error_dump(fwrt);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection done\n");
@@ -2314,19 +2323,27 @@ void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt)
 		udelay(500);
 		iwl_fw_dbg_restart_recording(fwrt, &params);
 	}
+
+out:
+	clear_bit(wk_idx, &fwrt->dump.active_wks);
 }
-IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect_sync);
 
 void iwl_fw_error_dump_wk(struct work_struct *work)
 {
-	struct iwl_fw_runtime *fwrt =
-		container_of(work, struct iwl_fw_runtime, dump.wk.work);
+	struct iwl_fw_runtime *fwrt;
+	typeof(fwrt->dump.wks[0]) *wks;
 
+	wks = container_of(work, typeof(fwrt->dump.wks[0]), wk.work);
+	fwrt = container_of(wks, struct iwl_fw_runtime, dump.wks[wks->idx]);
+
+	/* assumes the op mode mutex is locked in dump_start since
+	 * iwl_fw_dbg_collect_sync can't run in parallel
+	 */
 	if (fwrt->ops && fwrt->ops->dump_start &&
 	    fwrt->ops->dump_start(fwrt->ops_ctx))
 		return;
 
-	iwl_fw_dbg_collect_sync(fwrt);
+	iwl_fw_dbg_collect_sync(fwrt, wks->idx);
 
 	if (fwrt->ops && fwrt->ops->dump_end)
 		fwrt->ops->dump_end(fwrt->ops_ctx);
@@ -2723,8 +2740,11 @@ IWL_EXPORT_SYMBOL(iwl_fw_dbg_apply_point);
 
 void iwl_fwrt_stop_device(struct iwl_fw_runtime *fwrt)
 {
+	int i;
+
 	del_timer(&fwrt->dump.periodic_trig);
-	iwl_fw_dbg_collect_sync(fwrt);
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
+		iwl_fw_dbg_collect_sync(fwrt, i);
 
 	iwl_trans_stop_device(fwrt->trans);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 4a66d6f48d60..37d5171213c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -383,16 +383,26 @@ static inline bool iwl_fw_dbg_is_paging_enabled(struct iwl_fw_runtime *fwrt)
 
 void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt);
 
-static inline void iwl_fw_flush_dump(struct iwl_fw_runtime *fwrt)
+static inline void iwl_fw_flush_dumps(struct iwl_fw_runtime *fwrt)
 {
+	int i;
+
 	del_timer(&fwrt->dump.periodic_trig);
-	flush_delayed_work(&fwrt->dump.wk);
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
+		flush_delayed_work(&fwrt->dump.wks[i].wk);
+		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
+	}
 }
 
-static inline void iwl_fw_cancel_dump(struct iwl_fw_runtime *fwrt)
+static inline void iwl_fw_cancel_dumps(struct iwl_fw_runtime *fwrt)
 {
+	int i;
+
 	del_timer(&fwrt->dump.periodic_trig);
-	cancel_delayed_work_sync(&fwrt->dump.wk);
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
+		cancel_delayed_work_sync(&fwrt->dump.wks[i].wk);
+		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
+	}
 }
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -431,7 +441,6 @@ static inline void iwl_fw_resume_timestamp(struct iwl_fw_runtime *fwrt) {}
 
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 
-void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt);
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_apply_point apply_point);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 4435c0ce3013..c16d6e126e3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -67,6 +67,8 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
 			struct dentry *dbgfs_dir)
 {
+	int i;
+
 	memset(fwrt, 0, sizeof(*fwrt));
 	fwrt->trans = trans;
 	fwrt->fw = fw;
@@ -74,7 +76,10 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 	fwrt->dump.conf = FW_DBG_INVALID;
 	fwrt->ops = ops;
 	fwrt->ops_ctx = ops_ctx;
-	INIT_DELAYED_WORK(&fwrt->dump.wk, iwl_fw_error_dump_wk);
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
+		fwrt->dump.wks[i].idx = i;
+		INIT_DELAYED_WORK(&fwrt->dump.wks[i].wk, iwl_fw_error_dump_wk);
+	}
 	iwl_fwrt_dbgfs_register(fwrt, dbgfs_dir);
 	timer_setup(&fwrt->dump.periodic_trig,
 		    iwl_fw_dbg_periodic_trig_handler, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index a6402a0b3854..e351ac7ae53b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -89,9 +89,7 @@ struct iwl_fwrt_shared_mem_cfg {
 	u32 internal_txfifo_size[TX_FIFO_INTERNAL_MAX_NUM];
 };
 
-enum iwl_fw_runtime_status {
-	IWL_FWRT_STATUS_DUMPING = 0,
-};
+#define IWL_FW_RUNTIME_DUMP_WK_NUM 5
 
 /**
  * struct iwl_fw_runtime - runtime data for firmware
@@ -100,7 +98,6 @@ enum iwl_fw_runtime_status {
  * @dev: device pointer
  * @ops: user ops
  * @ops_ctx: user ops context
- * @status: status flags
  * @fw_paging_db: paging database
  * @num_of_paging_blk: number of paging blocks
  * @num_of_pages_in_last_blk: number of pages in the last block
@@ -117,8 +114,6 @@ struct iwl_fw_runtime {
 	const struct iwl_fw_runtime_ops *ops;
 	void *ops_ctx;
 
-	unsigned long status;
-
 	/* Paging */
 	struct iwl_fw_paging fw_paging_db[NUM_OF_FW_PAGING_BLOCKS];
 	u16 num_of_paging_blk;
@@ -133,7 +128,12 @@ struct iwl_fw_runtime {
 	struct {
 		const struct iwl_fw_dump_desc *desc;
 		bool monitor_only;
-		struct delayed_work wk;
+		struct {
+			u8 idx;
+			enum iwl_fw_ini_trigger_id ini_trig_id;
+			struct delayed_work wk;
+		} wks[IWL_FW_RUNTIME_DUMP_WK_NUM];
+		unsigned long active_wks;
 
 		u8 conf;
 
@@ -145,7 +145,6 @@ struct iwl_fw_runtime {
 		u32 lmac_err_id[MAX_NUM_LMAC];
 		u32 umac_err_id;
 		void *fifo_iter;
-		enum iwl_fw_ini_trigger_id ini_trig_id;
 		struct timer_list periodic_trig;
 	} dump;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5c52469288be..5f7ed51c96ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1439,7 +1439,7 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	 */
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
-	iwl_fw_cancel_dump(&mvm->fwrt);
+	iwl_fw_cancel_dumps(&mvm->fwrt);
 	cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
 	cancel_delayed_work_sync(&mvm->scan_timeout_dwork);
 	iwl_fw_free_dump_desc(&mvm->fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index acd2fda12466..6514e045c901 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -564,24 +564,24 @@ static void iwl_mvm_tx_unblock_dwork(struct work_struct *work)
 static int iwl_mvm_fwrt_dump_start(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
-	int ret;
+	int ret = 0;
+
+	mutex_lock(&mvm->mutex);
 
 	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_FW_DBG_COLLECT);
 	if (ret)
-		return ret;
-
-	mutex_lock(&mvm->mutex);
+		mutex_unlock(&mvm->mutex);
 
-	return 0;
+	return ret;
 }
 
 static void iwl_mvm_fwrt_dump_end(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
 
-	mutex_unlock(&mvm->mutex);
-
 	iwl_mvm_unref(mvm, IWL_MVM_REF_FW_DBG_COLLECT);
+
+	mutex_unlock(&mvm->mutex);
 }
 
 static bool iwl_mvm_fwrt_fw_running(void *ctx)
@@ -880,7 +880,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	return op_mode;
 
  out_free:
-	iwl_fw_flush_dump(&mvm->fwrt);
+	iwl_fw_flush_dumps(&mvm->fwrt);
 	iwl_fw_runtime_free(&mvm->fwrt);
 
 	if (iwlmvm_mod_params.init_dbg)
-- 
2.20.1

