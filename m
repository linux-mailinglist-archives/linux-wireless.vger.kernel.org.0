Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323231ADADF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgDQKVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56582 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729022AbgDQKVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO87-000Kba-Uk; Fri, 17 Apr 2020 13:21:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:36 +0300
Message-Id: <iwlwifi.20200417131727.5be6a1923cbe.I10701236b03f66328041f2a38f5f0f22a26fd40b@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/10] iwlwifi: dbg: support multiple dumps in legacy dump flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Support multiple debug data collection triggers in legacy flow.
Utilize the already existing Yoyo infra so the change is rather simple.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 97 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 11 ---
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 14 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 -
 4 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 14ac7153a3e7..8daa83cdc72c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -818,7 +818,8 @@ static void iwl_dump_paging(struct iwl_fw_runtime *fwrt,
 
 static struct iwl_fw_error_dump_file *
 iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
-		       struct iwl_fw_dump_ptrs *fw_error_dump)
+		       struct iwl_fw_dump_ptrs *fw_error_dump,
+		       struct iwl_fwrt_dump_data *data)
 {
 	struct iwl_fw_error_dump_file *dump_file;
 	struct iwl_fw_error_dump_data *dump_data;
@@ -900,15 +901,15 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	}
 
 	/* If we only want a monitor dump, reset the file length */
-	if (fwrt->dump.monitor_only) {
+	if (data->monitor_only) {
 		file_len = sizeof(*dump_file) + sizeof(*dump_data) * 2 +
 			   sizeof(*dump_info) + sizeof(*dump_smem_cfg);
 	}
 
 	if (iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_ERROR_INFO) &&
-	    fwrt->dump.desc)
+	    data->desc)
 		file_len += sizeof(*dump_data) + sizeof(*dump_trig) +
-			    fwrt->dump.desc->len;
+			data->desc->len;
 
 	dump_file = vzalloc(file_len);
 	if (!dump_file)
@@ -984,19 +985,19 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 		iwl_read_radio_regs(fwrt, &dump_data);
 
 	if (iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_ERROR_INFO) &&
-	    fwrt->dump.desc) {
+	    data->desc) {
 		dump_data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_ERROR_INFO);
 		dump_data->len = cpu_to_le32(sizeof(*dump_trig) +
-					     fwrt->dump.desc->len);
+					     data->desc->len);
 		dump_trig = (void *)dump_data->data;
-		memcpy(dump_trig, &fwrt->dump.desc->trig_desc,
-		       sizeof(*dump_trig) + fwrt->dump.desc->len);
+		memcpy(dump_trig, &data->desc->trig_desc,
+		       sizeof(*dump_trig) + data->desc->len);
 
 		dump_data = iwl_fw_error_next_data(dump_data);
 	}
 
 	/* In case we only want monitor dump, skip to dump trasport data */
-	if (fwrt->dump.monitor_only)
+	if (data->monitor_only)
 		goto out;
 
 	if (iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_MEM)) {
@@ -2172,7 +2173,21 @@ static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
 	return le32_to_cpu(hdr->file_len);
 }
 
-static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
+static inline void iwl_fw_free_dump_desc(struct iwl_fw_runtime *fwrt,
+					 const struct iwl_fw_dump_desc **desc)
+{
+	if (desc && *desc != &iwl_dump_desc_assert)
+		kfree(*desc);
+
+	*desc = NULL;
+	fwrt->dump.lmac_err_id[0] = 0;
+	if (fwrt->smem_cfg.num_lmacs > 1)
+		fwrt->dump.lmac_err_id[1] = 0;
+	fwrt->dump.umac_err_id = 0;
+}
+
+static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt,
+			      struct iwl_fwrt_dump_data *dump_data)
 {
 	struct iwl_fw_dump_ptrs fw_error_dump = {};
 	struct iwl_fw_error_dump_file *dump_file;
@@ -2180,11 +2195,11 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 	u32 file_len;
 	u32 dump_mask = fwrt->fw->dbg.dump_mask;
 
-	dump_file = iwl_fw_error_dump_file(fwrt, &fw_error_dump);
+	dump_file = iwl_fw_error_dump_file(fwrt, &fw_error_dump, dump_data);
 	if (!dump_file)
-		goto out;
+		return;
 
-	if (fwrt->dump.monitor_only)
+	if (dump_data->monitor_only)
 		dump_mask &= IWL_FW_ERROR_DUMP_FW_MONITOR;
 
 	fw_error_dump.trans_ptr = iwl_trans_dump_data(fwrt->trans, dump_mask);
@@ -2213,9 +2228,6 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 	}
 	vfree(fw_error_dump.fwrt_ptr);
 	vfree(fw_error_dump.trans_ptr);
-
-out:
-	iwl_fw_free_dump_desc(fwrt);
 }
 
 static void iwl_dump_ini_list_free(struct list_head *list)
@@ -2244,7 +2256,7 @@ static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt,
 	u32 file_len = iwl_dump_ini_file_gen(fwrt, dump_data, &dump_list);
 
 	if (!file_len)
-		goto out;
+		return;
 
 	sg_dump_data = alloc_sgtable(file_len);
 	if (sg_dump_data) {
@@ -2261,9 +2273,6 @@ static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt,
 			       GFP_KERNEL);
 	}
 	iwl_dump_ini_list_free(&dump_list);
-
-out:
-	iwl_fw_error_dump_data_free(dump_data);
 }
 
 const struct iwl_fw_dump_desc iwl_dump_desc_assert = {
@@ -2278,27 +2287,40 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 			    bool monitor_only,
 			    unsigned int delay)
 {
+	struct iwl_fwrt_wk_data *wk_data;
+	unsigned long idx;
+
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
-		iwl_fw_free_dump_desc(fwrt);
+		iwl_fw_free_dump_desc(fwrt, &desc);
 		return 0;
 	}
 
-	/* use wks[0] since dump flow prior to ini does not need to support
-	 * consecutive triggers collection
+	/*
+	 * Check there is an available worker.
+	 * ffz return value is undefined if no zero exists,
+	 * so check against ~0UL first.
 	 */
-	if (test_and_set_bit(fwrt->dump.wks[0].idx, &fwrt->dump.active_wks))
+	if (fwrt->dump.active_wks == ~0UL)
 		return -EBUSY;
 
-	if (WARN_ON(fwrt->dump.desc))
-		iwl_fw_free_dump_desc(fwrt);
+	idx = ffz(fwrt->dump.active_wks);
+
+	if (idx >= IWL_FW_RUNTIME_DUMP_WK_NUM ||
+	    test_and_set_bit(fwrt->dump.wks[idx].idx, &fwrt->dump.active_wks))
+		return -EBUSY;
+
+	wk_data = &fwrt->dump.wks[idx];
+
+	if (WARN_ON(wk_data->dump_data.desc))
+		iwl_fw_free_dump_desc(fwrt, &wk_data->dump_data.desc);
+
+	wk_data->dump_data.desc = desc;
+	wk_data->dump_data.monitor_only = monitor_only;
 
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	fwrt->dump.desc = desc;
-	fwrt->dump.monitor_only = monitor_only;
-
-	schedule_delayed_work(&fwrt->dump.wks[0].wk, usecs_to_jiffies(delay));
+	schedule_delayed_work(&wk_data->wk, usecs_to_jiffies(delay));
 
 	return 0;
 }
@@ -2504,14 +2526,14 @@ IWL_EXPORT_SYMBOL(iwl_fw_start_dbg_conf);
 static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 {
 	struct iwl_fw_dbg_params params = {0};
+	struct iwl_fwrt_dump_data *dump_data =
+		&fwrt->dump.wks[wk_idx].dump_data;
 
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
-	if (fwrt->ops && fwrt->ops->fw_running &&
-	    !fwrt->ops->fw_running(fwrt->ops_ctx)) {
-		IWL_ERR(fwrt, "Firmware not running - cannot dump error\n");
-		iwl_fw_free_dump_desc(fwrt);
+	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
+		IWL_ERR(fwrt, "Device is not enabled - cannot dump error\n");
 		goto out;
 	}
 
@@ -2527,12 +2549,17 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	if (iwl_trans_dbg_ini_valid(fwrt->trans))
 		iwl_fw_error_ini_dump(fwrt, &fwrt->dump.wks[wk_idx].dump_data);
 	else
-		iwl_fw_error_dump(fwrt);
+		iwl_fw_error_dump(fwrt, &fwrt->dump.wks[wk_idx].dump_data);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection done\n");
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
 out:
+	if (iwl_trans_dbg_ini_valid(fwrt->trans))
+		iwl_fw_error_dump_data_free(dump_data);
+	else
+		iwl_fw_free_dump_desc(fwrt, &dump_data->desc);
+
 	clear_bit(wk_idx, &fwrt->dump.active_wks);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 9d3513213f5f..11558df36b94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -98,17 +98,6 @@ struct iwl_fw_dbg_params {
 
 extern const struct iwl_fw_dump_desc iwl_dump_desc_assert;
 
-static inline void iwl_fw_free_dump_desc(struct iwl_fw_runtime *fwrt)
-{
-	if (fwrt->dump.desc != &iwl_dump_desc_assert)
-		kfree(fwrt->dump.desc);
-	fwrt->dump.desc = NULL;
-	fwrt->dump.lmac_err_id[0] = 0;
-	if (fwrt->smem_cfg.num_lmacs > 1)
-		fwrt->dump.lmac_err_id[1] = 0;
-	fwrt->dump.umac_err_id = 0;
-}
-
 int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 			    const struct iwl_fw_dump_desc *desc,
 			    bool monitor_only, unsigned int delay);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index da0d90e2b537..9906d9b9bdd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -98,8 +98,16 @@ struct iwl_fwrt_shared_mem_cfg {
  * @fw_pkt: packet received from FW
  */
 struct iwl_fwrt_dump_data {
-	struct iwl_fw_ini_trigger_tlv *trig;
-	struct iwl_rx_packet *fw_pkt;
+	union {
+		struct {
+			struct iwl_fw_ini_trigger_tlv *trig;
+			struct iwl_rx_packet *fw_pkt;
+		};
+		struct {
+			const struct iwl_fw_dump_desc *desc;
+			bool monitor_only;
+		};
+	};
 };
 
 /**
@@ -162,8 +170,6 @@ struct iwl_fw_runtime {
 
 	/* debug */
 	struct {
-		const struct iwl_fw_dump_desc *desc;
-		bool monitor_only;
 		struct iwl_fwrt_wk_data wks[IWL_FW_RUNTIME_DUMP_WK_NUM];
 		unsigned long active_wks;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7aa1350b093e..853ba7b8bf3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1264,7 +1264,6 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
 	cancel_delayed_work_sync(&mvm->scan_timeout_dwork);
-	iwl_fw_free_dump_desc(&mvm->fwrt);
 
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mac_stop(mvm);
-- 
2.25.1

