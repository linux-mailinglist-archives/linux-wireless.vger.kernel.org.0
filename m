Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED95C4B138A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiBJQwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiBJQwh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:37 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A0122
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:37 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDc-000Bxy-0Q;
        Thu, 10 Feb 2022 18:22:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:30 +0200
Message-Id: <iwlwifi.20220210181930.acbf22ac2b66.I2bf38578c5ca1f7ffb2011a782f772db92fc4965@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 07/11] iwlwifi: support new queue allocation command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Newer firmware versions will support a new queue allocation
command, in order to deal with MLD where multiple stations
are used for a single queue. Add support for the new command.

This requires some refactoring of the queue allocation API,
which now gets
 - the station mask instead of the station ID
 - the flags without the "enable" flag, since that's no longer
   used in the new API

Additionally, this new API now requires that we remove queues
before removing a station, the firmware will no longer do that
internally. Also add support for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 56 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 15 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 23 ++++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 54 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  4 +-
 8 files changed, 142 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 99235baab85d..d268a9cba5ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -64,6 +64,13 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	RX_BAID_ALLOCATION_CONFIG_CMD = 0x16,
 
+	/**
+	 * @SCD_QUEUE_CONFIG_CMD: new scheduler queue allocation/config/removal
+	 *	command, uses &struct iwl_scd_queue_cfg_cmd and the response
+	 *	is (same as before) &struct iwl_tx_queue_cfg_rsp.
+	 */
+	SCD_QUEUE_CONFIG_CMD = 0x17,
+
 	/**
 	 * @MONITOR_NOTIF: Datapath monitoring notification, using
 	 *	&struct iwl_datapath_monitor_notif
@@ -334,4 +341,53 @@ struct iwl_rx_baid_cfg_resp {
 	__le32 baid;
 }; /* RX_BAID_ALLOCATION_RESPONSE_API_S_VER_1 */
 
+/**
+ * enum iwl_scd_queue_cfg_operation - scheduler queue operation
+ * @IWL_SCD_QUEUE_ADD: allocate a new queue
+ * @IWL_SCD_QUEUE_REMOVE: remove a queue
+ * @IWL_SCD_QUEUE_MODIFY: modify a queue
+ */
+enum iwl_scd_queue_cfg_operation {
+	IWL_SCD_QUEUE_ADD = 0,
+	IWL_SCD_QUEUE_REMOVE = 1,
+	IWL_SCD_QUEUE_MODIFY = 2,
+};
+
+/**
+ * struct iwl_scd_queue_cfg_cmd - scheduler queue allocation command
+ * @operation: the operation, see &enum iwl_scd_queue_cfg_operation
+ * @u.add.sta_mask: station mask
+ * @u.add.tid: TID
+ * @u.add.reserved: reserved
+ * @u.add.flags: flags from &enum iwl_tx_queue_cfg_actions, except
+ *	%TX_QUEUE_CFG_ENABLE_QUEUE is not valid
+ * @u.add.cb_size: size code
+ * @u.add.bc_dram_addr: byte-count table IOVA
+ * @u.add.tfdq_dram_addr: TFD queue IOVA
+ * @u.remove.queue: queue ID for removal
+ * @u.modify.sta_mask: new station mask for modify
+ * @u.modify.queue: queue ID to modify
+ */
+struct iwl_scd_queue_cfg_cmd {
+	__le32 operation;
+	union {
+		struct {
+			__le32 sta_mask;
+			u8 tid;
+			u8 reserved[3];
+			__le32 flags;
+			__le32 cb_size;
+			__le64 bc_dram_addr;
+			__le64 tfdq_dram_addr;
+		} __packed add; /* TX_QUEUE_CFG_CMD_ADD_API_S_VER_1 */
+		struct {
+			__le32 queue;
+		} __packed remove; /* TX_QUEUE_CFG_CMD_REMOVE_API_S_VER_1 */
+		struct {
+			__le32 sta_mask;
+			__le32 queue;
+		} __packed modify; /* TX_QUEUE_CFG_CMD_MODIFY_API_S_VER_1 */
+	} __packed u; /* TX_QUEUE_CFG_CMD_OPERATION_API_U_VER_1 */
+} __packed; /* TX_QUEUE_CFG_CMD_API_S_VER_3 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 50342bf0a5d7..d659ccd065f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -406,6 +406,9 @@ struct iwl_dump_sanitize_ops {
  * @cb_data_offs: offset inside skb->cb to store transport data at, must have
  *	space for at least two pointers
  * @fw_reset_handshake: firmware supports reset flow handshake
+ * @queue_alloc_cmd_ver: queue allocation command version, set to 0
+ *	for using the older SCD_QUEUE_CFG, set to the version of
+ *	SCD_QUEUE_CONFIG_CMD otherwise.
  */
 struct iwl_trans_config {
 	struct iwl_op_mode *op_mode;
@@ -424,6 +427,7 @@ struct iwl_trans_config {
 
 	u8 cb_data_offs;
 	bool fw_reset_handshake;
+	u8 queue_alloc_cmd_ver;
 };
 
 struct iwl_trans_dump_data {
@@ -569,8 +573,8 @@ struct iwl_trans_ops {
 	void (*txq_disable)(struct iwl_trans *trans, int queue,
 			    bool configure_scd);
 	/* 22000 functions */
-	int (*txq_alloc)(struct iwl_trans *trans,
-			 __le16 flags, u8 sta_id, u8 tid,
+	int (*txq_alloc)(struct iwl_trans *trans, u32 flags,
+			 u32 sta_mask, u8 tid,
 			 int size, unsigned int queue_wdg_timeout);
 	void (*txq_free)(struct iwl_trans *trans, int queue);
 	int (*rxq_dma_data)(struct iwl_trans *trans, int queue,
@@ -928,6 +932,7 @@ struct iwl_txq {
  * @queue_used - bit mask of used queues
  * @queue_stopped - bit mask of stopped queues
  * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
+ * @queue_alloc_cmd_ver: queue allocation command version
  */
 struct iwl_trans_txqs {
 	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
@@ -953,6 +958,8 @@ struct iwl_trans_txqs {
 	} tfd;
 
 	struct iwl_dma_ptr scd_bc_tbls;
+
+	u8 queue_alloc_cmd_ver;
 };
 
 /**
@@ -1244,7 +1251,7 @@ iwl_trans_txq_free(struct iwl_trans *trans, int queue)
 
 static inline int
 iwl_trans_txq_alloc(struct iwl_trans *trans,
-		    __le16 flags, u8 sta_id, u8 tid,
+		    u32 flags, u32 sta_mask, u8 tid,
 		    int size, unsigned int wdg_timeout)
 {
 	might_sleep();
@@ -1257,7 +1264,7 @@ iwl_trans_txq_alloc(struct iwl_trans *trans,
 		return -EIO;
 	}
 
-	return trans->ops->txq_alloc(trans, flags, sta_id, tid,
+	return trans->ops->txq_alloc(trans, flags, sta_mask, tid,
 				     size, wdg_timeout);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b4c3a0dc9a39..ecfe322ebef2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1116,6 +1116,8 @@ struct iwl_mvm {
 
 	unsigned long last_6ghz_passive_scan_jiffies;
 	unsigned long last_reset_or_resume_time_jiffies;
+
+	bool sta_remove_requires_queue_remove;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0d187d4fa8c7..9d774f209b22 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -547,6 +547,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RFH_QUEUE_CONFIG_CMD),
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
+	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
 	HCMD_NAME(STA_PM_NOTIF),
@@ -1254,6 +1255,14 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.fw_reset_handshake = fw_has_capa(&mvm->fw->ucode_capa,
 						   IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
 
+	trans_cfg.queue_alloc_cmd_ver =
+		iwl_fw_lookup_cmd_ver(mvm->fw,
+				      WIDE_ID(DATA_PATH_GROUP,
+					      SCD_QUEUE_CONFIG_CMD),
+				      0);
+	mvm->sta_remove_requires_queue_remove =
+		trans_cfg.queue_alloc_cmd_ver > 0;
+
 	/* Configure transport layer */
 	iwl_trans_configure(mvm->trans, &trans_cfg);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 4cd3966182b8..03869bb7dcee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -325,11 +325,28 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	};
 	int ret;
 
+	lockdep_assert_held(&mvm->mutex);
+
 	if (iwl_mvm_has_new_tx_api(mvm)) {
+		if (mvm->sta_remove_requires_queue_remove) {
+			u32 cmd_id = WIDE_ID(DATA_PATH_GROUP,
+					     SCD_QUEUE_CONFIG_CMD);
+			struct iwl_scd_queue_cfg_cmd remove_cmd = {
+				.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
+				.u.remove.queue = cpu_to_le32(queue),
+			};
+
+			ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
+						   sizeof(remove_cmd),
+						   &remove_cmd);
+		} else {
+			ret = 0;
+		}
+
 		iwl_trans_txq_free(mvm->trans, queue);
 		*queueptr = IWL_MVM_INVALID_QUEUE;
 
-		return 0;
+		return ret;
 	}
 
 	if (WARN_ON(mvm->queue_info[queue].tid_bitmap == 0))
@@ -781,9 +798,7 @@ static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	size = rounddown_pow_of_two(size);
 
 	do {
-		__le16 enable = cpu_to_le16(TX_QUEUE_CFG_ENABLE_QUEUE);
-
-		queue = iwl_trans_txq_alloc(mvm->trans, enable, sta_id,
+		queue = iwl_trans_txq_alloc(mvm->trans, 0, BIT(sta_id),
 					    tid, size, timeout);
 
 		if (queue < 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cafc4d0e66b9..518700388fdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2007-2015, 2018-2020 Intel Corporation
+ * Copyright (C) 2007-2015, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1949,6 +1949,7 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
 	trans->txqs.page_offs = trans_cfg->cb_data_offs;
 	trans->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
+	trans->txqs.queue_alloc_cmd_ver = trans_cfg->queue_alloc_cmd_ver;
 
 	if (WARN_ON(trans_cfg->n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
 		trans_pcie->n_no_reclaim_cmds = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 047092ea34fb..42e631cc16e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -9,6 +9,7 @@
 #include "iwl-io.h"
 #include "fw/api/commands.h"
 #include "fw/api/tx.h"
+#include "fw/api/datapath.h"
 #include "queue/tx.h"
 #include "iwl-fh.h"
 #include "iwl-scd.h"
@@ -1185,19 +1186,15 @@ static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
 	return ret;
 }
 
-int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
-		      int size, unsigned int timeout)
+int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
+		      u8 tid, int size, unsigned int timeout)
 {
 	struct iwl_txq *txq;
-	struct iwl_tx_queue_cfg_cmd cmd = {
-		.flags = flags,
-		.sta_id = sta_id,
-		.tid = tid,
-	};
+	union {
+		struct iwl_tx_queue_cfg_cmd old;
+		struct iwl_scd_queue_cfg_cmd new;
+	} cmd;
 	struct iwl_host_cmd hcmd = {
-		.id = SCD_QUEUE_CFG,
-		.len = { sizeof(cmd) },
-		.data = { &cmd, },
 		.flags = CMD_WANT_SKB,
 	};
 	int ret;
@@ -1206,9 +1203,40 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
 	if (IS_ERR(txq))
 		return PTR_ERR(txq);
 
-	cmd.tfdq_addr = cpu_to_le64(txq->dma_addr);
-	cmd.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
-	cmd.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
+	if (trans->txqs.queue_alloc_cmd_ver == 0) {
+		memset(&cmd.old, 0, sizeof(cmd.old));
+		cmd.old.tfdq_addr = cpu_to_le64(txq->dma_addr);
+		cmd.old.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
+		cmd.old.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
+		cmd.old.flags = cpu_to_le16(flags | TX_QUEUE_CFG_ENABLE_QUEUE);
+		cmd.old.tid = tid;
+
+		if (hweight32(sta_mask) != 1) {
+			ret = -EINVAL;
+			goto error;
+		}
+		cmd.old.sta_id = ffs(sta_mask) - 1;
+
+		hcmd.id = SCD_QUEUE_CFG;
+		hcmd.len[0] = sizeof(cmd.old);
+		hcmd.data[0] = &cmd.old;
+	} else if (trans->txqs.queue_alloc_cmd_ver == 3) {
+		memset(&cmd.new, 0, sizeof(cmd.new));
+		cmd.new.operation = cpu_to_le32(IWL_SCD_QUEUE_ADD);
+		cmd.new.u.add.tfdq_dram_addr = cpu_to_le64(txq->dma_addr);
+		cmd.new.u.add.bc_dram_addr = cpu_to_le64(txq->bc_tbl.dma);
+		cmd.new.u.add.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
+		cmd.new.u.add.flags = cpu_to_le32(flags);
+		cmd.new.u.add.sta_mask = cpu_to_le32(sta_mask);
+		cmd.new.u.add.tid = tid;
+
+		hcmd.id = WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD);
+		hcmd.len[0] = sizeof(cmd.new);
+		hcmd.data[0] = &cmd.new;
+	} else {
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
 
 	ret = iwl_trans_send_cmd(trans, &hcmd);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 726dd001e65b..eca53bfd326d 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -112,8 +112,8 @@ void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
 			    struct iwl_cmd_meta *meta,
 			    struct iwl_tfh_tfd *tfd);
 
-int iwl_txq_dyn_alloc(struct iwl_trans *trans,
-		      __le16 flags, u8 sta_id, u8 tid,
+int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags,
+		      u32 sta_mask, u8 tid,
 		      int size, unsigned int timeout);
 
 int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
-- 
2.34.1

