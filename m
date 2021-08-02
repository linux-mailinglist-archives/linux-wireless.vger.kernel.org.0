Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441363DDAC7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhHBOVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:21:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50890 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234486AbhHBOVJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:21:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYda-001xoA-8a; Mon, 02 Aug 2021 17:09:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:39 +0300
Message-Id: <iwlwifi.20210802170640.481b6642f0fc.I7c9c958408a285e3d19aceed2a5a3341cfc08382@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: prepare for synchronous error dumps
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In some cases it may be necessary to synchronously create
a firmware error report, add the necessary infrastructure
for this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 97 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  7 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 25 ++---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  | 24 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 16 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 10 files changed, 113 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index c01523f64bfc..cc7b69fd14d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014, 2018 - 2020  Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2018 - 2021  Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
  *
  * Portions of this file are derived from the ipw3945 project, as well
@@ -1950,7 +1950,7 @@ static void iwlagn_fw_error(struct iwl_priv *priv, bool ondemand)
 	}
 }
 
-static void iwl_nic_error(struct iwl_op_mode *op_mode)
+static void iwl_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
 	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index df7c55e06f54..70e0a3089876 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2530,51 +2530,6 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
-int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
-			   struct iwl_fwrt_dump_data *dump_data)
-{
-	struct iwl_fw_ini_trigger_tlv *trig = dump_data->trig;
-	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trig->time_point);
-	u32 occur, delay;
-	unsigned long idx;
-
-	if (!iwl_fw_ini_trigger_on(fwrt, trig)) {
-		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
-			 tp_id);
-		return -EINVAL;
-	}
-
-	delay = le32_to_cpu(trig->dump_delay);
-	occur = le32_to_cpu(trig->occurrences);
-	if (!occur)
-		return 0;
-
-	trig->occurrences = cpu_to_le32(--occur);
-
-	/* Check there is an available worker.
-	 * ffz return value is undefined if no zero exists,
-	 * so check against ~0UL first.
-	 */
-	if (fwrt->dump.active_wks == ~0UL)
-		return -EBUSY;
-
-	idx = ffz(fwrt->dump.active_wks);
-
-	if (idx >= IWL_FW_RUNTIME_DUMP_WK_NUM ||
-	    test_and_set_bit(fwrt->dump.wks[idx].idx, &fwrt->dump.active_wks))
-		return -EBUSY;
-
-	fwrt->dump.wks[idx].dump_data = *dump_data;
-
-	IWL_WARN(fwrt,
-		 "WRT: Collecting data: ini trigger %d fired (delay=%dms).\n",
-		 tp_id, (u32)(delay / USEC_PER_MSEC));
-
-	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
-
-	return 0;
-}
-
 int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
 			    struct iwl_fw_dbg_trigger_tlv *trigger,
 			    const char *fmt, ...)
@@ -2703,6 +2658,58 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	clear_bit(wk_idx, &fwrt->dump.active_wks);
 }
 
+int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
+			   struct iwl_fwrt_dump_data *dump_data,
+			   bool sync)
+{
+	struct iwl_fw_ini_trigger_tlv *trig = dump_data->trig;
+	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trig->time_point);
+	u32 occur, delay;
+	unsigned long idx;
+
+	if (!iwl_fw_ini_trigger_on(fwrt, trig)) {
+		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
+			 tp_id);
+		return -EINVAL;
+	}
+
+	delay = le32_to_cpu(trig->dump_delay);
+	occur = le32_to_cpu(trig->occurrences);
+	if (!occur)
+		return 0;
+
+	trig->occurrences = cpu_to_le32(--occur);
+
+	/* Check there is an available worker.
+	 * ffz return value is undefined if no zero exists,
+	 * so check against ~0UL first.
+	 */
+	if (fwrt->dump.active_wks == ~0UL)
+		return -EBUSY;
+
+	idx = ffz(fwrt->dump.active_wks);
+
+	if (idx >= IWL_FW_RUNTIME_DUMP_WK_NUM ||
+	    test_and_set_bit(fwrt->dump.wks[idx].idx, &fwrt->dump.active_wks))
+		return -EBUSY;
+
+	fwrt->dump.wks[idx].dump_data = *dump_data;
+
+	if (sync)
+		delay = 0;
+
+	IWL_WARN(fwrt,
+		 "WRT: Collecting data: ini trigger %d fired (delay=%dms).\n",
+		 tp_id, (u32)(delay / USEC_PER_MSEC));
+
+	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
+
+	if (sync)
+		iwl_fw_dbg_collect_sync(fwrt, idx);
+
+	return 0;
+}
+
 void iwl_fw_error_dump_wk(struct work_struct *work)
 {
 	struct iwl_fwrt_wk_data *wks =
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index c0e84ef84f5d..8c3c890066b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -46,7 +46,8 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 int iwl_fw_dbg_error_collect(struct iwl_fw_runtime *fwrt,
 			     enum iwl_fw_dbg_trigger trig_type);
 int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
-			   struct iwl_fwrt_dump_data *dump_data);
+			   struct iwl_fwrt_dump_data *dump_data,
+			   bool sync);
 int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 		       enum iwl_fw_dbg_trigger trig, const char *str,
 		       size_t len, struct iwl_fw_dbg_trigger_tlv *trigger);
@@ -284,7 +285,7 @@ static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 		trans->dbg.umac_error_event_table = umac_error_event_table;
 }
 
-static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
+static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt, bool sync)
 {
 	enum iwl_fw_ini_time_point tp_id;
 
@@ -300,7 +301,7 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 		tp_id = IWL_FW_INI_TIME_POINT_FW_ASSERT;
 	}
 
-	iwl_dbg_tlv_time_point(fwrt, tp_id, NULL);
+	_iwl_dbg_tlv_time_point(fwrt, tp_id, NULL, sync);
 }
 
 void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 0ddd255a8cc1..cc78fd23c922 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -683,7 +683,7 @@ static void iwl_dbg_tlv_periodic_trig_handler(struct timer_list *t)
 	};
 	int ret;
 
-	ret = iwl_fw_dbg_ini_collect(timer_node->fwrt, &dump_data);
+	ret = iwl_fw_dbg_ini_collect(timer_node->fwrt, &dump_data, false);
 	if (!ret || ret == -EBUSY) {
 		u32 occur = le32_to_cpu(dump_data.trig->occurrences);
 		u32 collect_interval = le32_to_cpu(dump_data.trig->data[0]);
@@ -927,7 +927,7 @@ static bool iwl_dbg_tlv_check_fw_pkt(struct iwl_fw_runtime *fwrt,
 }
 
 static int
-iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
+iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 		       struct list_head *active_trig_list,
 		       union iwl_dbg_tlv_tp_data *tp_data,
 		       bool (*data_check)(struct iwl_fw_runtime *fwrt,
@@ -946,7 +946,7 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
 		int ret, i;
 
 		if (!num_data) {
-			ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data);
+			ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data, sync);
 			if (ret)
 				return ret;
 		}
@@ -955,7 +955,7 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
 			if (!data_check ||
 			    data_check(fwrt, &dump_data, tp_data,
 				       le32_to_cpu(dump_data.trig->data[i]))) {
-				ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data);
+				ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data, sync);
 				if (ret)
 					return ret;
 
@@ -1043,9 +1043,10 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 	}
 }
 
-void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_time_point tp_id,
-			    union iwl_dbg_tlv_tp_data *tp_data)
+void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
+			     enum iwl_fw_ini_time_point tp_id,
+			     union iwl_dbg_tlv_tp_data *tp_data,
+			     bool sync)
 {
 	struct list_head *hcmd_list, *trig_list;
 
@@ -1060,12 +1061,12 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	switch (tp_id) {
 	case IWL_FW_INI_TIME_POINT_EARLY:
 		iwl_dbg_tlv_init_cfg(fwrt);
-		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
 		iwl_dbg_tlv_apply_buffers(fwrt);
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	case IWL_FW_INI_TIME_POINT_PERIODIC:
 		iwl_dbg_tlv_set_periodic_trigs(fwrt);
@@ -1075,13 +1076,13 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	case IWL_FW_INI_TIME_POINT_MISSED_BEACONS:
 	case IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFICATION:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data,
+		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data,
 				       iwl_dbg_tlv_check_fw_pkt);
 		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
-		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	}
 }
-IWL_EXPORT_SYMBOL(iwl_dbg_tlv_time_point);
+IWL_EXPORT_SYMBOL(_iwl_dbg_tlv_time_point);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 92c720527946..c12b1fd3f479 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
@@ -48,9 +48,25 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans);
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, const struct iwl_ucode_tlv *tlv,
 		       bool ext);
 void iwl_dbg_tlv_init(struct iwl_trans *trans);
-void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_time_point tp_id,
-			    union iwl_dbg_tlv_tp_data *tp_data);
+void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
+			     enum iwl_fw_ini_time_point tp_id,
+			     union iwl_dbg_tlv_tp_data *tp_data,
+			     bool sync);
+
+static inline void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
+					  enum iwl_fw_ini_time_point tp_id,
+					  union iwl_dbg_tlv_tp_data *tp_data)
+{
+	_iwl_dbg_tlv_time_point(fwrt, tp_id, tp_data, false);
+}
+
+static inline void iwl_dbg_tlv_time_point_sync(struct iwl_fw_runtime *fwrt,
+					       enum iwl_fw_ini_time_point tp_id,
+					       union iwl_dbg_tlv_tp_data *tp_data)
+{
+	_iwl_dbg_tlv_time_point(fwrt, tp_id, tp_data, true);
+}
+
 void iwl_dbg_tlv_del_timers(struct iwl_trans *trans);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 33d42e08d5b8..2a0be1fafdf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
 #include <linux/delay.h>
@@ -468,5 +468,5 @@ void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 	if (interrupts_enabled)
 		iwl_trans_interrupts(trans, true);
 
-	iwl_trans_fw_error(trans);
+	iwl_trans_fw_error(trans, false);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index cf9c64090014..af5f9b210f22 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -78,7 +78,7 @@ struct iwl_cfg;
  *	there are Tx packets pending in the transport layer.
  *	Must be atomic
  * @nic_error: error notification. Must be atomic and must be called with BH
- *	disabled.
+ *	disabled, unless the sync parameter is true.
  * @cmd_queue_full: Called when the command queue gets full. Must be atomic and
  *	called with BH disabled.
  * @nic_config: configure NIC, called before firmware is started.
@@ -102,7 +102,7 @@ struct iwl_op_mode_ops {
 	void (*queue_not_full)(struct iwl_op_mode *op_mode, int queue);
 	bool (*hw_rf_kill)(struct iwl_op_mode *op_mode, bool state);
 	void (*free_skb)(struct iwl_op_mode *op_mode, struct sk_buff *skb);
-	void (*nic_error)(struct iwl_op_mode *op_mode);
+	void (*nic_error)(struct iwl_op_mode *op_mode, bool sync);
 	void (*cmd_queue_full)(struct iwl_op_mode *op_mode);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
@@ -181,9 +181,9 @@ static inline void iwl_op_mode_free_skb(struct iwl_op_mode *op_mode,
 	op_mode->ops->free_skb(op_mode, skb);
 }
 
-static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode)
+static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
-	op_mode->ops->nic_error(op_mode);
+	op_mode->ops->nic_error(op_mode, sync);
 }
 
 static inline void iwl_op_mode_cmd_queue_full(struct iwl_op_mode *op_mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0199d7a5a648..2cbc9ecd688b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1385,14 +1385,14 @@ iwl_trans_release_nic_access(struct iwl_trans *trans)
 	__release(nic_access);
 }
 
-static inline void iwl_trans_fw_error(struct iwl_trans *trans)
+static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 {
 	if (WARN_ON_ONCE(!trans->op_mode))
 		return;
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode);
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1f43079f02af..880cf2042531 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1400,7 +1400,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 * can't recover this since we're already half suspended.
 	 */
 	if (!mvm->fw_restart && fw_error) {
-		iwl_fw_error_collect(&mvm->fwrt);
+		iwl_fw_error_collect(&mvm->fwrt, false);
 	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
 
@@ -1451,7 +1451,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 			}
 		}
 
-		iwl_fw_error_collect(&mvm->fwrt);
+		iwl_fw_error_collect(&mvm->fwrt, false);
 
 		if (fw_error && mvm->fw_restart > 0)
 			mvm->fw_restart--;
@@ -1459,13 +1459,23 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	}
 }
 
-static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode)
+static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
 	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status))
 		iwl_mvm_dump_nic_error_log(mvm);
 
+	if (sync) {
+		iwl_fw_error_collect(&mvm->fwrt, true);
+		/*
+		 * Currently, the only case for sync=true is during
+		 * shutdown, so just stop in this case. If/when that
+		 * changes, we need to be a bit smarter here.
+		 */
+		return;
+	}
+
 	/*
 	 * If the firmware crashes while we're already considering it
 	 * to be dead then don't ask for a restart, that cannot do
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index ff7ca3c57f34..54bfc01ab34c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1656,7 +1656,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
 	 * before we wake up the command caller, to ensure a proper cleanup. */
-	iwl_trans_fw_error(trans);
+	iwl_trans_fw_error(trans, false);
 
 	clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 	wake_up(&trans->wait_command_queue);
-- 
2.32.0

