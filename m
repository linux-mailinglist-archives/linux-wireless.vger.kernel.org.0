Return-Path: <linux-wireless+bounces-483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEA806A20
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C317C1C20FD3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D842D7BB;
	Wed,  6 Dec 2023 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bh4SBAtu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E710F1
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852605; x=1733388605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xiIJJXcgv4DrAc4DjW5Qm/Tn8Ov1sfbMAq6KG7+dgCw=;
  b=Bh4SBAtu4y4T9EFzrQc8SiR4FqvuQzOzpJtns+w5faBxyXt8NbYFe36z
   BPCvPbysJUoNeW47vZUmgGX6D7Bz31l1Q+gZSKIriK0mv8M1EkR2swKew
   aQj6BBxRFJ9wOIlcX0zfcviMjTVh1j007WgY98aPXF90Z8+tZRvcVaAhe
   74oJh+pMZK+Iy9EZY8mY47x7vL4M8WmD4mjKmJxrBBggL7SHydfai3Iw6
   SP5zeHkM26nTwCAlXdOVY45ve+kSTwKUKo9MDyFeRNqqvJDoqrpeFFuFO
   RnKDwb5SOfEPB+lpNRhkNvVtaODC+7XpUViSMJP36gvwdSaKcf3hd0YV0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916587"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575419"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575419"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:03 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 10/13] wifi: iwlwifi: remove async command callback
Date: Thu,  7 Dec 2023 04:50:15 +0200
Message-Id: <20231207044813.2bd95e0570fc.I16486dbc82570d2f73a585872f5394698627310d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Johannes Berg <johannes.berg@intel.com>

There's only one user of this code, which is STA unblock
during sleep for uAPSD on really old devices. Instead of
having this all through the API with calls up and down,
just implemented a special-case CMD_BLOCK_TXQS flag for
this, it's only needed in the old gen1 transport.

While at it, fix a complain that lockdep would have, as
we lock the cmd queue and then the TXQs in the reclaim
by using spin_lock_nested(). We no longer need to disable
BHs in iwl_trans_pcie_block_txq_ptrs() since it's called
with them disabled already.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 11 ------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 ---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 23 ++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 13 -------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 27 ---------------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  5 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 34 +++++++++++++++++--
 8 files changed, 39 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index af5f9b210f22..3dc618a7c70f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -64,8 +64,6 @@ struct iwl_cfg;
  *	received on the RSS queue(s). The queue parameter indicates which of the
  *	RSS queues received this frame; it will always be non-zero.
  *	This method must not sleep.
- * @async_cb: called when an ASYNC command with CMD_WANT_ASYNC_CALLBACK set
- *	completes. Must be atomic.
  * @queue_full: notifies that a HW queue is full.
  *	Must be atomic and called with BH disabled.
  * @queue_not_full: notifies that a HW queue is not full any more.
@@ -96,8 +94,6 @@ struct iwl_op_mode_ops {
 		   struct iwl_rx_cmd_buffer *rxb);
 	void (*rx_rss)(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 		       struct iwl_rx_cmd_buffer *rxb, unsigned int queue);
-	void (*async_cb)(struct iwl_op_mode *op_mode,
-			 const struct iwl_device_cmd *cmd);
 	void (*queue_full)(struct iwl_op_mode *op_mode, int queue);
 	void (*queue_not_full)(struct iwl_op_mode *op_mode, int queue);
 	bool (*hw_rf_kill)(struct iwl_op_mode *op_mode, bool state);
@@ -147,13 +143,6 @@ static inline void iwl_op_mode_rx_rss(struct iwl_op_mode *op_mode,
 	op_mode->ops->rx_rss(op_mode, napi, rxb, queue);
 }
 
-static inline void iwl_op_mode_async_cb(struct iwl_op_mode *op_mode,
-					const struct iwl_device_cmd *cmd)
-{
-	if (op_mode->ops->async_cb)
-		op_mode->ops->async_cb(op_mode, cmd);
-}
-
 static inline void iwl_op_mode_queue_full(struct iwl_op_mode *op_mode,
 					  int queue)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 4bd759432d44..f95098c21c7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -172,10 +172,6 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		return -EIO;
 	}
 
-	if (WARN_ON((cmd->flags & CMD_WANT_ASYNC_CALLBACK) &&
-		    !(cmd->flags & CMD_ASYNC)))
-		return -EINVAL;
-
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 05e72a2125b3..ef7dc0a7b56c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -110,8 +110,7 @@ static inline u32 iwl_rx_packet_payload_len(const struct iwl_rx_packet *pkt)
  * @CMD_WANT_SKB: Not valid with CMD_ASYNC. The caller needs the buffer of
  *	the response. The caller needs to call iwl_free_resp when done.
  * @CMD_SEND_IN_RFKILL: Send the command even if the NIC is in RF-kill.
- * @CMD_WANT_ASYNC_CALLBACK: the op_mode's async callback function must be
- *	called after this command completes. Valid only with CMD_ASYNC.
+ * @CMD_BLOCK_TXQS: Block TXQs while the comment is executing.
  * @CMD_SEND_IN_D3: Allow the command to be sent in D3 mode, relevant to
  *	SUSPEND and RESUME commands. We are in D3 mode when we set
  *	trans->system_pm_mode to IWL_PLAT_PM_MODE_D3.
@@ -120,7 +119,7 @@ enum CMD_MODE {
 	CMD_ASYNC		= BIT(0),
 	CMD_WANT_SKB		= BIT(1),
 	CMD_SEND_IN_RFKILL	= BIT(2),
-	CMD_WANT_ASYNC_CALLBACK	= BIT(3),
+	CMD_BLOCK_TXQS		= BIT(3),
 	CMD_SEND_IN_D3          = BIT(4),
 };
 
@@ -534,11 +533,6 @@ struct iwl_pnvm_image {
  * @wait_txq_empty: wait until specific tx queue is empty. May sleep.
  * @freeze_txq_timer: prevents the timer of the queue from firing until the
  *	queue is set to awake. Must be atomic.
- * @block_txq_ptrs: stop updating the write pointers of the Tx queues. Note
- *	that the transport needs to refcount the calls since this function
- *	will be called several times with block = true, and then the queues
- *	need to be unblocked only after the same number of calls with
- *	block = false.
  * @write8: write a u8 to a register at offset ofs from the BAR
  * @write32: write a u32 to a register at offset ofs from the BAR
  * @read32: read a u32 register at offset ofs from the BAR
@@ -613,7 +607,6 @@ struct iwl_trans_ops {
 	int (*wait_txq_empty)(struct iwl_trans *trans, int queue);
 	void (*freeze_txq_timer)(struct iwl_trans *trans, unsigned long txqs,
 				 bool freeze);
-	void (*block_txq_ptrs)(struct iwl_trans *trans, bool block);
 
 	void (*write8)(struct iwl_trans *trans, u32 ofs, u8 val);
 	void (*write32)(struct iwl_trans *trans, u32 ofs, u32 val);
@@ -1407,18 +1400,6 @@ static inline void iwl_trans_freeze_txq_timer(struct iwl_trans *trans,
 		trans->ops->freeze_txq_timer(trans, txqs, freeze);
 }
 
-static inline void iwl_trans_block_txq_ptrs(struct iwl_trans *trans,
-					    bool block)
-{
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return;
-	}
-
-	if (trans->ops->block_txq_ptrs)
-		trans->ops->block_txq_ptrs(trans, block);
-}
-
 static inline int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans,
 						 u32 txqs)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1627b2f819db..adbbe19aeae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1703,18 +1703,6 @@ void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
 		iwl_mvm_rx_common(mvm, rxb, pkt);
 }
 
-static void iwl_mvm_async_cb(struct iwl_op_mode *op_mode,
-			     const struct iwl_device_cmd *cmd)
-{
-	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-
-	/*
-	 * For now, we only set the CMD_WANT_ASYNC_CALLBACK for ADD_STA
-	 * commands that need to block the Tx queues.
-	 */
-	iwl_trans_block_txq_ptrs(mvm->trans, false);
-}
-
 static int iwl_mvm_is_static_queue(struct iwl_mvm *mvm, int queue)
 {
 	return queue == mvm->aux_queue || queue == mvm->probe_queue ||
@@ -2024,7 +2012,6 @@ static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 
 #define IWL_MVM_COMMON_OPS					\
 	/* these could be differentiated */			\
-	.async_cb = iwl_mvm_async_cb,				\
 	.queue_full = iwl_mvm_stop_sw_queue,			\
 	.queue_not_full = iwl_mvm_wake_sw_queue,		\
 	.hw_rf_kill = iwl_mvm_set_hw_rfkill_state,		\
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index bba96a968890..49542b3cb76e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4111,10 +4111,8 @@ void iwl_mvm_sta_modify_sleep_tx_count(struct iwl_mvm *mvm,
 	}
 
 	/* block the Tx queues until the FW updated the sleep Tx count */
-	iwl_trans_block_txq_ptrs(mvm->trans, true);
-
 	ret = iwl_mvm_send_cmd_pdu(mvm, ADD_STA,
-				   CMD_ASYNC | CMD_WANT_ASYNC_CALLBACK,
+				   CMD_ASYNC | CMD_BLOCK_TXQS,
 				   iwl_mvm_add_sta_cmd_size(mvm), &cmd);
 	if (ret)
 		IWL_ERR(mvm, "Failed to send ADD_STA command (%d)\n", ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index eb77575f5b12..f39c436f0b6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2377,32 +2377,6 @@ static int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				     ofs, val);
 }
 
-static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
-{
-	int i;
-
-	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		struct iwl_txq *txq = trans->txqs.txq[i];
-
-		if (i == trans->txqs.cmd.q_id)
-			continue;
-
-		spin_lock_bh(&txq->lock);
-
-		if (!block && !(WARN_ON_ONCE(!txq->block))) {
-			txq->block--;
-			if (!txq->block) {
-				iwl_write32(trans, HBUS_TARG_WRPTR,
-					    txq->write_ptr | (i << 8));
-			}
-		} else if (block) {
-			txq->block++;
-		}
-
-		spin_unlock_bh(&txq->lock);
-	}
-}
-
 #define IWL_FLUSH_WAIT_MS	2000
 
 static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
@@ -3584,7 +3558,6 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 	.wait_tx_queues_empty = iwl_trans_pcie_wait_txqs_empty,
 
 	.freeze_txq_timer = iwl_trans_txq_freeze_timer,
-	.block_txq_ptrs = iwl_trans_pcie_block_txq_ptrs,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index c72a84d8bb4f..aabbef114bc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2020, 2023 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -42,6 +42,9 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	struct iwl_tfh_tfd *tfd;
 	unsigned long flags;
 
+	if (WARN_ON(cmd->flags & CMD_BLOCK_TXQS))
+		return -EINVAL;
+
 	copy_size = sizeof(struct iwl_cmd_header_wide);
 	cmd_size = sizeof(struct iwl_cmd_header_wide);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 2f39b639c43f..6c2b37e56c78 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -873,6 +873,33 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 
 /*************** HOST COMMAND QUEUE FUNCTIONS   *****/
 
+static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
+{
+	int i;
+
+	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
+		struct iwl_txq *txq = trans->txqs.txq[i];
+
+		if (i == trans->txqs.cmd.q_id)
+			continue;
+
+		/* we skip the command queue (obviously) so it's OK to nest */
+		spin_lock_nested(&txq->lock, 1);
+
+		if (!block && !(WARN_ON_ONCE(!txq->block))) {
+			txq->block--;
+			if (!txq->block) {
+				iwl_write32(trans, HBUS_TARG_WRPTR,
+					    txq->write_ptr | (i << 8));
+			}
+		} else if (block) {
+			txq->block++;
+		}
+
+		spin_unlock(&txq->lock);
+	}
+}
+
 /*
  * iwl_pcie_enqueue_hcmd - enqueue a uCode command
  * @priv: device private data point
@@ -1137,6 +1164,9 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		goto out;
 	}
 
+	if (cmd->flags & CMD_BLOCK_TXQS)
+		iwl_trans_pcie_block_txq_ptrs(trans, true);
+
 	/* Increment and update queue's write index */
 	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
 	iwl_pcie_txq_inc_wr_ptr(trans, txq);
@@ -1202,8 +1232,8 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 		meta->source->_rx_page_order = trans_pcie->rx_page_order;
 	}
 
-	if (meta->flags & CMD_WANT_ASYNC_CALLBACK)
-		iwl_op_mode_async_cb(trans->op_mode, cmd);
+	if (meta->flags & CMD_BLOCK_TXQS)
+		iwl_trans_pcie_block_txq_ptrs(trans, false);
 
 	iwl_pcie_cmdq_reclaim(trans, txq_id, index);
 
-- 
2.34.1


