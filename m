Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62472D4CB0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgLIVSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35620 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388102AbgLIVRu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pV-003Drx-G0; Wed, 09 Dec 2020 23:16:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:09 +0200
Message-Id: <iwlwifi.20201209231352.40723e92b6bf.I83cf71d9c6d989ec42f52b353f1d33f32540db59@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 05/47] iwlwifi: move reclaim flows to the queue file
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Reclaim flows are bus-independent TX functions so we move
it to the common place handling bus-independent tx operations

used spatch rule

@@
@@
(
-iwl_trans_pcie_freeze_txq_timer
+iwl_trans_txq_freeze_timer
|
-iwl_trans_pcie_set_q_ptrs
+iwl_trans_txq_set_q_ptrs
|
-iwl_pcie_txq_free_tfd
+iwl_txq_free_tfd
|
-iwl_pcie_txq_progress
+iwl_txq_progress
|
-iwl_trans_pcie_reclaim
+iwl_trans_txq_reclaim
)

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |   4 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  61 +----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 199 +-------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 248 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   7 +
 5 files changed, 261 insertions(+), 258 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index ff542d2f0054..acbf367aea4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -551,9 +551,6 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans);
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 			    struct iwl_rx_cmd_buffer *rxb);
-void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-			    struct sk_buff_head *skbs);
-void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 
 /*****************************************************
@@ -839,7 +836,6 @@ void iwl_pcie_synchronize_irqs(struct iwl_trans *trans);
 bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans);
 void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 				       bool was_in_rfkill);
-void iwl_pcie_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
 void iwl_pcie_apm_stop_master(struct iwl_trans *trans);
 void iwl_pcie_conf_msix_hw(struct iwl_trans_pcie *trans_pcie);
 int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8fd85ebf1b35..32b87d18b766 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2196,59 +2196,6 @@ static int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				     ofs, val);
 }
 
-static void iwl_trans_pcie_freeze_txq_timer(struct iwl_trans *trans,
-					    unsigned long txqs,
-					    bool freeze)
-{
-	int queue;
-
-	for_each_set_bit(queue, &txqs, BITS_PER_LONG) {
-		struct iwl_txq *txq = trans->txqs.txq[queue];
-		unsigned long now;
-
-		spin_lock_bh(&txq->lock);
-
-		now = jiffies;
-
-		if (txq->frozen == freeze)
-			goto next_queue;
-
-		IWL_DEBUG_TX_QUEUES(trans, "%s TXQ %d\n",
-				    freeze ? "Freezing" : "Waking", queue);
-
-		txq->frozen = freeze;
-
-		if (txq->read_ptr == txq->write_ptr)
-			goto next_queue;
-
-		if (freeze) {
-			if (unlikely(time_after(now,
-						txq->stuck_timer.expires))) {
-				/*
-				 * The timer should have fired, maybe it is
-				 * spinning right now on the lock.
-				 */
-				goto next_queue;
-			}
-			/* remember how long until the timer fires */
-			txq->frozen_expiry_remainder =
-				txq->stuck_timer.expires - now;
-			del_timer(&txq->stuck_timer);
-			goto next_queue;
-		}
-
-		/*
-		 * Wake a non-empty queue -> arm timer with the
-		 * remainder before it froze
-		 */
-		mod_timer(&txq->stuck_timer,
-			  now + txq->frozen_expiry_remainder);
-
-next_queue:
-		spin_unlock_bh(&txq->lock);
-	}
-}
-
 static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 {
 	int i;
@@ -3424,7 +3371,7 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 	.send_cmd = iwl_trans_pcie_send_hcmd,
 
 	.tx = iwl_trans_pcie_tx,
-	.reclaim = iwl_trans_pcie_reclaim,
+	.reclaim = iwl_txq_reclaim,
 
 	.txq_disable = iwl_trans_pcie_txq_disable,
 	.txq_enable = iwl_trans_pcie_txq_enable,
@@ -3433,7 +3380,7 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 
 	.wait_tx_queues_empty = iwl_trans_pcie_wait_txqs_empty,
 
-	.freeze_txq_timer = iwl_trans_pcie_freeze_txq_timer,
+	.freeze_txq_timer = iwl_trans_txq_freeze_timer,
 	.block_txq_ptrs = iwl_trans_pcie_block_txq_ptrs,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
@@ -3451,9 +3398,9 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.send_cmd = iwl_trans_pcie_gen2_send_hcmd,
 
 	.tx = iwl_txq_gen2_tx,
-	.reclaim = iwl_trans_pcie_reclaim,
+	.reclaim = iwl_txq_reclaim,
 
-	.set_q_ptrs = iwl_trans_pcie_set_q_ptrs,
+	.set_q_ptrs = iwl_txq_set_q_ptrs,
 
 	.txq_alloc = iwl_txq_dyn_alloc,
 	.txq_free = iwl_txq_dyn_free,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 966be5689d63..2beaf3c01552 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -205,47 +205,6 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
 	tfd_fh->num_tbs = idx + 1;
 }
 
-/*
- * iwl_pcie_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
- * @trans - transport private data
- * @txq - tx queue
- * @dma_dir - the direction of the DMA mapping
- *
- * Does NOT advance any TFD circular buffer read/write indexes
- * Does NOT free the TFD itself (which is within circular buffer)
- */
-void iwl_pcie_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
-	 * idx is bounded by n_window
-	 */
-	int rd_ptr = txq->read_ptr;
-	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
-
-	lockdep_assert_held(&txq->lock);
-
-	/* We have only q->n_window txq->entries, but we use
-	 * TFD_QUEUE_SIZE_MAX tfds
-	 */
-	iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
-
-	/* free SKB */
-	if (txq->entries) {
-		struct sk_buff *skb;
-
-		skb = txq->entries[idx].skb;
-
-		/* Can be called from irqs-disabled context
-		 * If skb is not NULL, it means that the whole queue is being
-		 * freed and that the queue is not empty - free the skb
-		 */
-		if (skb) {
-			iwl_op_mode_free_skb(trans->op_mode, skb);
-			txq->entries[idx].skb = NULL;
-		}
-	}
-}
-
 static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 				  dma_addr_t addr, u16 len, bool reset)
 {
@@ -312,7 +271,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 
 			iwl_txq_free_tso_page(trans, skb);
 		}
-		iwl_pcie_txq_free_tfd(trans, txq);
+		iwl_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
 		if (txq->read_ptr == txq->write_ptr) {
@@ -721,160 +680,6 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	return ret;
 }
 
-static inline void iwl_pcie_txq_progress(struct iwl_txq *txq)
-{
-	lockdep_assert_held(&txq->lock);
-
-	if (!txq->wd_timeout)
-		return;
-
-	/*
-	 * station is asleep and we send data - that must
-	 * be uAPSD or PS-Poll. Don't rearm the timer.
-	 */
-	if (txq->frozen)
-		return;
-
-	/*
-	 * if empty delete timer, otherwise move timer forward
-	 * since we're making progress on this queue
-	 */
-	if (txq->read_ptr == txq->write_ptr)
-		del_timer(&txq->stuck_timer);
-	else
-		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
-}
-
-/* Frees buffers until index _not_ inclusive */
-void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-			    struct sk_buff_head *skbs)
-{
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-	int tfd_num = iwl_txq_get_cmd_index(txq, ssn);
-	int read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
-	int last_to_free;
-
-	/* This function is not meant to release cmd queue*/
-	if (WARN_ON(txq_id == trans->txqs.cmd.q_id))
-		return;
-
-	spin_lock_bh(&txq->lock);
-
-	if (!test_bit(txq_id, trans->txqs.queue_used)) {
-		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
-				    txq_id, ssn);
-		goto out;
-	}
-
-	if (read_ptr == tfd_num)
-		goto out;
-
-	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d -> %d (%d)\n",
-			   txq_id, txq->read_ptr, tfd_num, ssn);
-
-	/*Since we free until index _not_ inclusive, the one before index is
-	 * the last we will free. This one must be used */
-	last_to_free = iwl_txq_dec_wrap(trans, tfd_num);
-
-	if (!iwl_txq_used(txq, last_to_free)) {
-		IWL_ERR(trans,
-			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
-			__func__, txq_id, last_to_free,
-			trans->trans_cfg->base_params->max_tfd_queue_size,
-			txq->write_ptr, txq->read_ptr);
-		goto out;
-	}
-
-	if (WARN_ON(!skb_queue_empty(skbs)))
-		goto out;
-
-	for (;
-	     read_ptr != tfd_num;
-	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
-	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
-		struct sk_buff *skb = txq->entries[read_ptr].skb;
-
-		if (WARN_ON_ONCE(!skb))
-			continue;
-
-		iwl_txq_free_tso_page(trans, skb);
-
-		__skb_queue_tail(skbs, skb);
-
-		txq->entries[read_ptr].skb = NULL;
-
-		if (!trans->trans_cfg->use_tfh)
-			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
-
-		iwl_pcie_txq_free_tfd(trans, txq);
-	}
-
-	iwl_pcie_txq_progress(txq);
-
-	if (iwl_txq_space(trans, txq) > txq->low_mark &&
-	    test_bit(txq_id, trans->txqs.queue_stopped)) {
-		struct sk_buff_head overflow_skbs;
-
-		__skb_queue_head_init(&overflow_skbs);
-		skb_queue_splice_init(&txq->overflow_q, &overflow_skbs);
-
-		/*
-		 * We are going to transmit from the overflow queue.
-		 * Remember this state so that wait_for_txq_empty will know we
-		 * are adding more packets to the TFD queue. It cannot rely on
-		 * the state of &txq->overflow_q, as we just emptied it, but
-		 * haven't TXed the content yet.
-		 */
-		txq->overflow_tx = true;
-
-		/*
-		 * This is tricky: we are in reclaim path which is non
-		 * re-entrant, so noone will try to take the access the
-		 * txq data from that path. We stopped tx, so we can't
-		 * have tx as well. Bottom line, we can unlock and re-lock
-		 * later.
-		 */
-		spin_unlock_bh(&txq->lock);
-
-		while (!skb_queue_empty(&overflow_skbs)) {
-			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
-			struct iwl_device_tx_cmd *dev_cmd_ptr;
-
-			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
-						 trans->txqs.dev_cmd_offs);
-
-			/*
-			 * Note that we can very well be overflowing again.
-			 * In that case, iwl_txq_space will be small again
-			 * and we won't wake mac80211's queue.
-			 */
-			iwl_trans_tx(trans, skb, dev_cmd_ptr, txq_id);
-		}
-
-		if (iwl_txq_space(trans, txq) > txq->low_mark)
-			iwl_wake_queue(trans, txq);
-
-		spin_lock_bh(&txq->lock);
-		txq->overflow_tx = false;
-	}
-
-out:
-	spin_unlock_bh(&txq->lock);
-}
-
-/* Set wr_ptr of specific device and txq  */
-void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
-{
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-
-	spin_lock_bh(&txq->lock);
-
-	txq->write_ptr = ptr;
-	txq->read_ptr = txq->write_ptr;
-
-	spin_unlock_bh(&txq->lock);
-}
-
 static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 				      const struct iwl_host_cmd *cmd)
 {
@@ -962,7 +767,7 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 		spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
 	}
 
-	iwl_pcie_txq_progress(txq);
+	iwl_txq_progress(txq);
 }
 
 static int iwl_pcie_txq_set_ratid_map(struct iwl_trans *trans, u16 ra_tid,
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index c107851d345a..a41a39f7805c 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1523,3 +1523,251 @@ void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] =
 			bc_ent;
 }
+
+/*
+ * iwl_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
+ * @trans - transport private data
+ * @txq - tx queue
+ * @dma_dir - the direction of the DMA mapping
+ *
+ * Does NOT advance any TFD circular buffer read/write indexes
+ * Does NOT free the TFD itself (which is within circular buffer)
+ */
+void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
+	 * idx is bounded by n_window
+	 */
+	int rd_ptr = txq->read_ptr;
+	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
+
+	lockdep_assert_held(&txq->lock);
+
+	/* We have only q->n_window txq->entries, but we use
+	 * TFD_QUEUE_SIZE_MAX tfds
+	 */
+	iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
+
+	/* free SKB */
+	if (txq->entries) {
+		struct sk_buff *skb;
+
+		skb = txq->entries[idx].skb;
+
+		/* Can be called from irqs-disabled context
+		 * If skb is not NULL, it means that the whole queue is being
+		 * freed and that the queue is not empty - free the skb
+		 */
+		if (skb) {
+			iwl_op_mode_free_skb(trans->op_mode, skb);
+			txq->entries[idx].skb = NULL;
+		}
+	}
+}
+
+void iwl_txq_progress(struct iwl_txq *txq)
+{
+	lockdep_assert_held(&txq->lock);
+
+	if (!txq->wd_timeout)
+		return;
+
+	/*
+	 * station is asleep and we send data - that must
+	 * be uAPSD or PS-Poll. Don't rearm the timer.
+	 */
+	if (txq->frozen)
+		return;
+
+	/*
+	 * if empty delete timer, otherwise move timer forward
+	 * since we're making progress on this queue
+	 */
+	if (txq->read_ptr == txq->write_ptr)
+		del_timer(&txq->stuck_timer);
+	else
+		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
+}
+
+/* Frees buffers until index _not_ inclusive */
+void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
+		     struct sk_buff_head *skbs)
+{
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	int tfd_num = iwl_txq_get_cmd_index(txq, ssn);
+	int read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+	int last_to_free;
+
+	/* This function is not meant to release cmd queue*/
+	if (WARN_ON(txq_id == trans->txqs.cmd.q_id))
+		return;
+
+	spin_lock_bh(&txq->lock);
+
+	if (!test_bit(txq_id, trans->txqs.queue_used)) {
+		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
+				    txq_id, ssn);
+		goto out;
+	}
+
+	if (read_ptr == tfd_num)
+		goto out;
+
+	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d -> %d (%d)\n",
+			   txq_id, txq->read_ptr, tfd_num, ssn);
+
+	/*Since we free until index _not_ inclusive, the one before index is
+	 * the last we will free. This one must be used */
+	last_to_free = iwl_txq_dec_wrap(trans, tfd_num);
+
+	if (!iwl_txq_used(txq, last_to_free)) {
+		IWL_ERR(trans,
+			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
+			__func__, txq_id, last_to_free,
+			trans->trans_cfg->base_params->max_tfd_queue_size,
+			txq->write_ptr, txq->read_ptr);
+		goto out;
+	}
+
+	if (WARN_ON(!skb_queue_empty(skbs)))
+		goto out;
+
+	for (;
+	     read_ptr != tfd_num;
+	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
+	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
+		struct sk_buff *skb = txq->entries[read_ptr].skb;
+
+		if (WARN_ON_ONCE(!skb))
+			continue;
+
+		iwl_txq_free_tso_page(trans, skb);
+
+		__skb_queue_tail(skbs, skb);
+
+		txq->entries[read_ptr].skb = NULL;
+
+		if (!trans->trans_cfg->use_tfh)
+			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
+
+		iwl_txq_free_tfd(trans, txq);
+	}
+
+	iwl_txq_progress(txq);
+
+	if (iwl_txq_space(trans, txq) > txq->low_mark &&
+	    test_bit(txq_id, trans->txqs.queue_stopped)) {
+		struct sk_buff_head overflow_skbs;
+
+		__skb_queue_head_init(&overflow_skbs);
+		skb_queue_splice_init(&txq->overflow_q, &overflow_skbs);
+
+		/*
+		 * We are going to transmit from the overflow queue.
+		 * Remember this state so that wait_for_txq_empty will know we
+		 * are adding more packets to the TFD queue. It cannot rely on
+		 * the state of &txq->overflow_q, as we just emptied it, but
+		 * haven't TXed the content yet.
+		 */
+		txq->overflow_tx = true;
+
+		/*
+		 * This is tricky: we are in reclaim path which is non
+		 * re-entrant, so noone will try to take the access the
+		 * txq data from that path. We stopped tx, so we can't
+		 * have tx as well. Bottom line, we can unlock and re-lock
+		 * later.
+		 */
+		spin_unlock_bh(&txq->lock);
+
+		while (!skb_queue_empty(&overflow_skbs)) {
+			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
+			struct iwl_device_tx_cmd *dev_cmd_ptr;
+
+			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
+						 trans->txqs.dev_cmd_offs);
+
+			/*
+			 * Note that we can very well be overflowing again.
+			 * In that case, iwl_txq_space will be small again
+			 * and we won't wake mac80211's queue.
+			 */
+			iwl_trans_tx(trans, skb, dev_cmd_ptr, txq_id);
+		}
+
+		if (iwl_txq_space(trans, txq) > txq->low_mark)
+			iwl_wake_queue(trans, txq);
+
+		spin_lock_bh(&txq->lock);
+		txq->overflow_tx = false;
+	}
+
+out:
+	spin_unlock_bh(&txq->lock);
+}
+
+/* Set wr_ptr of specific device and txq  */
+void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
+{
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+
+	spin_lock_bh(&txq->lock);
+
+	txq->write_ptr = ptr;
+	txq->read_ptr = txq->write_ptr;
+
+	spin_unlock_bh(&txq->lock);
+}
+
+void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
+				bool freeze)
+{
+	int queue;
+
+	for_each_set_bit(queue, &txqs, BITS_PER_LONG) {
+		struct iwl_txq *txq = trans->txqs.txq[queue];
+		unsigned long now;
+
+		spin_lock_bh(&txq->lock);
+
+		now = jiffies;
+
+		if (txq->frozen == freeze)
+			goto next_queue;
+
+		IWL_DEBUG_TX_QUEUES(trans, "%s TXQ %d\n",
+				    freeze ? "Freezing" : "Waking", queue);
+
+		txq->frozen = freeze;
+
+		if (txq->read_ptr == txq->write_ptr)
+			goto next_queue;
+
+		if (freeze) {
+			if (unlikely(time_after(now,
+						txq->stuck_timer.expires))) {
+				/*
+				 * The timer should have fired, maybe it is
+				 * spinning right now on the lock.
+				 */
+				goto next_queue;
+			}
+			/* remember how long until the timer fires */
+			txq->frozen_expiry_remainder =
+				txq->stuck_timer.expires - now;
+			del_timer(&txq->stuck_timer);
+			goto next_queue;
+		}
+
+		/*
+		 * Wake a non-empty queue -> arm timer with the
+		 * remainder before it froze
+		 */
+		mod_timer(&txq->stuck_timer,
+			  now + txq->frozen_expiry_remainder);
+
+next_queue:
+		spin_unlock_bh(&txq->lock);
+	}
+}
+
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index c67577dfa21d..6e333f4e53aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -227,4 +227,11 @@ void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 				      struct iwl_txq *txq, u16 byte_cnt,
 				      int num_tbs);
+void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
+		     struct sk_buff_head *skbs);
+void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
+void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
+				bool freeze);
+void iwl_txq_progress(struct iwl_txq *txq);
+void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
 #endif /* __iwl_trans_queue_tx_h__ */
-- 
2.29.2

