Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B42F91E4
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbhAQLMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728275AbhAQLLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xG-003sZv-33; Sun, 17 Jan 2021 13:10:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:34 +0200
Message-Id: <iwlwifi.20210117130510.a5951ac4fc06.I9c84a147288fcfb1b019572c6758f2d92949f5d7@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] iwlwifi: pcie: properly implement NAPI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Instead of pretending to have NAPI and then relying entirely on
interrupts anyway, properly implement NAPI and schedule the poll
when we get an interrupt, re-enabling the interrupt only after
the poll completed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 224 ++++++++++++------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   8 +-
 5 files changed, 171 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a528d3d99c5a..f4281b51248b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -418,8 +418,7 @@ IWL_TRANS_GET_PCIE_TRANS(struct iwl_trans *trans)
 	return (void *)trans->trans_specific;
 }
 
-static inline void iwl_pcie_clear_irq(struct iwl_trans *trans,
-				      struct msix_entry *entry)
+static inline void iwl_pcie_clear_irq(struct iwl_trans *trans, int queue)
 {
 	/*
 	 * Before sending the interrupt the HW disables it to prevent
@@ -429,7 +428,7 @@ static inline void iwl_pcie_clear_irq(struct iwl_trans *trans,
 	 * write 1 clear (W1C) register, meaning that it's being clear
 	 * by writing 1 to the bit.
 	 */
-	iwl_write32(trans, CSR_MSIX_AUTOMASK_ST_AD, BIT(entry->entry));
+	iwl_write32(trans, CSR_MSIX_AUTOMASK_ST_AD, BIT(queue));
 }
 
 static inline struct iwl_trans *
@@ -462,7 +461,6 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans);
 void iwl_pcie_rx_free(struct iwl_trans *trans);
 void iwl_pcie_free_rbs_pool(struct iwl_trans *trans);
 void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq);
-int iwl_pcie_dummy_napi_poll(struct napi_struct *napi, int budget);
 void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 			    struct iwl_rxq *rxq);
 
@@ -569,9 +567,9 @@ static inline void iwl_disable_interrupts(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	_iwl_disable_interrupts(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 }
 
 static inline void _iwl_enable_interrupts(struct iwl_trans *trans)
@@ -601,9 +599,9 @@ static inline void iwl_enable_interrupts(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	_iwl_enable_interrupts(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 }
 static inline void iwl_enable_hw_int_msk_msix(struct iwl_trans *trans, u32 msk)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 37bbd9a07f36..f7b0a35dcf98 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -207,10 +207,10 @@ static void iwl_pcie_rxq_check_wrptr(struct iwl_trans *trans)
 
 		if (!rxq->need_update)
 			continue;
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 		iwl_pcie_rxq_inc_wr_ptr(trans, rxq);
 		rxq->need_update = false;
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 	}
 }
 
@@ -255,7 +255,7 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
 	if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 		return;
 
-	spin_lock(&rxq->lock);
+	spin_lock_bh(&rxq->lock);
 	while (rxq->free_count) {
 		/* Get next free Rx buffer, remove from free list */
 		rxb = list_first_entry(&rxq->rx_free, struct iwl_rx_mem_buffer,
@@ -269,16 +269,16 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
 		rxq->write = (rxq->write + 1) & (rxq->queue_size - 1);
 		rxq->free_count--;
 	}
-	spin_unlock(&rxq->lock);
+	spin_unlock_bh(&rxq->lock);
 
 	/*
 	 * If we've added more space for the firmware to place data, tell it.
 	 * Increment device's write pointer in multiples of 8.
 	 */
 	if (rxq->write_actual != (rxq->write & ~0x7)) {
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 		iwl_pcie_rxq_inc_wr_ptr(trans, rxq);
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 	}
 }
 
@@ -514,10 +514,10 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 	IWL_DEBUG_TPT(trans, "Pending allocation requests = %d\n", pending);
 
 	/* If we were scheduled - there is at least one request */
-	spin_lock(&rba->lock);
+	spin_lock_bh(&rba->lock);
 	/* swap out the rba->rbd_empty to a local list */
 	list_replace_init(&rba->rbd_empty, &local_empty);
-	spin_unlock(&rba->lock);
+	spin_unlock_bh(&rba->lock);
 
 	while (pending) {
 		int i;
@@ -577,21 +577,21 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 					      pending);
 		}
 
-		spin_lock(&rba->lock);
+		spin_lock_bh(&rba->lock);
 		/* add the allocated rbds to the allocator allocated list */
 		list_splice_tail(&local_allocated, &rba->rbd_allocated);
 		/* get more empty RBDs for current pending requests */
 		list_splice_tail_init(&rba->rbd_empty, &local_empty);
-		spin_unlock(&rba->lock);
+		spin_unlock_bh(&rba->lock);
 
 		atomic_inc(&rba->req_ready);
 
 	}
 
-	spin_lock(&rba->lock);
+	spin_lock_bh(&rba->lock);
 	/* return unused rbds to the allocator empty list */
 	list_splice_tail(&local_empty, &rba->rbd_empty);
-	spin_unlock(&rba->lock);
+	spin_unlock_bh(&rba->lock);
 
 	IWL_DEBUG_TPT(trans, "%s, exit.\n", __func__);
 }
@@ -1008,10 +1008,76 @@ void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq)
 	rxq->used_count = 0;
 }
 
-int iwl_pcie_dummy_napi_poll(struct napi_struct *napi, int budget)
+static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget);
+
+static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 {
-	WARN_ON(1);
-	return 0;
+	struct iwl_rxq *rxq = container_of(napi, struct iwl_rxq, napi);
+	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans *trans;
+	int ret;
+
+	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
+	trans = trans_pcie->trans;
+
+	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
+
+	if (ret < budget) {
+		spin_lock(&trans_pcie->irq_lock);
+		if (test_bit(STATUS_INT_ENABLED, &trans->status))
+			_iwl_enable_interrupts(trans);
+		spin_unlock(&trans_pcie->irq_lock);
+
+		napi_complete_done(&rxq->napi, ret);
+	}
+
+	return ret;
+}
+
+static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
+{
+	struct iwl_rxq *rxq = container_of(napi, struct iwl_rxq, napi);
+	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans *trans;
+	int ret;
+
+	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
+	trans = trans_pcie->trans;
+
+	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
+
+	if (ret < budget) {
+		spin_lock(&trans_pcie->irq_lock);
+		iwl_pcie_clear_irq(trans, rxq->id);
+		spin_unlock(&trans_pcie->irq_lock);
+
+		napi_complete_done(&rxq->napi, ret);
+	}
+
+	return ret;
+}
+
+static int iwl_pcie_napi_poll_msix_shared(struct napi_struct *napi, int budget)
+{
+	struct iwl_rxq *rxq = container_of(napi, struct iwl_rxq, napi);
+	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans *trans;
+	int ret;
+
+	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
+	trans = trans_pcie->trans;
+
+	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
+
+	if (ret < budget) {
+		spin_lock(&trans_pcie->irq_lock);
+		iwl_pcie_clear_irq(trans, 0);
+		spin_unlock(&trans_pcie->irq_lock);
+
+		napi_complete_done(&rxq->napi, ret);
+	}
+
+	return ret;
 }
 
 static int _iwl_pcie_rx_init(struct iwl_trans *trans)
@@ -1030,12 +1096,12 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 
 	cancel_work_sync(&rba->rx_alloc);
 
-	spin_lock(&rba->lock);
+	spin_lock_bh(&rba->lock);
 	atomic_set(&rba->req_pending, 0);
 	atomic_set(&rba->req_ready, 0);
 	INIT_LIST_HEAD(&rba->rbd_allocated);
 	INIT_LIST_HEAD(&rba->rbd_empty);
-	spin_unlock(&rba->lock);
+	spin_unlock_bh(&rba->lock);
 
 	/* free all first - we might be reconfigured for a different size */
 	iwl_pcie_free_rbs_pool(trans);
@@ -1062,9 +1128,25 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
 
-		if (!rxq->napi.poll)
+		if (!rxq->napi.poll) {
+			int (*poll)(struct napi_struct *, int) = iwl_pcie_napi_poll;
+
+			if (trans_pcie->msix_enabled) {
+				poll = iwl_pcie_napi_poll_msix;
+
+				if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX &&
+				    i == 0)
+					poll = iwl_pcie_napi_poll_msix_shared;
+
+				if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS &&
+				    i == 1)
+					poll = iwl_pcie_napi_poll_msix_shared;
+			}
+
 			netif_napi_add(&trans_pcie->napi_dev, &rxq->napi,
-				       iwl_pcie_dummy_napi_poll, 64);
+				       poll, NAPI_POLL_WEIGHT);
+			napi_enable(&rxq->napi);
+		}
 
 		spin_unlock(&rxq->lock);
 	}
@@ -1163,8 +1245,10 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 
 		iwl_pcie_free_rxq_dma(trans, rxq);
 
-		if (rxq->napi.poll)
+		if (rxq->napi.poll) {
+			napi_disable(&rxq->napi);
 			netif_napi_del(&rxq->napi);
+		}
 	}
 	kfree(trans_pcie->rx_pool);
 	kfree(trans_pcie->global_table);
@@ -1417,16 +1501,15 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 /*
  * iwl_pcie_rx_handle - Main entry function for receiving responses from fw
  */
-static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
+static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct napi_struct *napi;
 	struct iwl_rxq *rxq;
-	u32 r, i, count = 0;
+	u32 r, i, count = 0, handled = 0;
 	bool emergency = false;
 
 	if (WARN_ON_ONCE(!trans_pcie->rxq || !trans_pcie->rxq[queue].bd))
-		return;
+		return budget;
 
 	rxq = &trans_pcie->rxq[queue];
 
@@ -1444,7 +1527,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	if (i == r)
 		IWL_DEBUG_RX(trans, "Q %d: HW = SW = %d\n", rxq->id, r);
 
-	while (i != r) {
+	while (i != r && ++handled < budget) {
 		struct iwl_rb_allocator *rba = &trans_pcie->rba;
 		struct iwl_rx_mem_buffer *rxb;
 		/* number of RBDs still waiting for page allocation */
@@ -1545,18 +1628,9 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	if (unlikely(emergency && count))
 		iwl_pcie_rxq_alloc_rbs(trans, GFP_ATOMIC, rxq);
 
-	napi = &rxq->napi;
-	if (napi->poll) {
-		napi_gro_flush(napi, false);
-
-		if (napi->rx_count) {
-			netif_receive_skb_list(&napi->rx_list);
-			INIT_LIST_HEAD(&napi->rx_list);
-			napi->rx_count = 0;
-		}
-	}
-
 	iwl_pcie_rxq_restock(trans, rxq);
+
+	return handled;
 }
 
 static struct iwl_trans_pcie *iwl_pcie_get_trans_pcie(struct msix_entry *entry)
@@ -1576,6 +1650,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
+	struct iwl_rxq *rxq = &trans_pcie->rxq[entry->entry];
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, false, 0, 0);
 
@@ -1585,11 +1660,12 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 
 	local_bh_disable();
-	iwl_pcie_rx_handle(trans, entry->entry);
+	if (napi_schedule_prep(&rxq->napi))
+		__napi_schedule(&rxq->napi);
+	else
+		iwl_pcie_clear_irq(trans, entry->entry);
 	local_bh_enable();
 
-	iwl_pcie_clear_irq(trans, entry);
-
 	lock_map_release(&trans->sync_cmd_lockdep_map);
 
 	return IRQ_HANDLED;
@@ -1757,10 +1833,11 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
 	u32 inta = 0;
 	u32 handled = 0;
+	bool polling = false;
 
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 
 	/* dram interrupt table not set yet,
 	 * use legacy interrupt.
@@ -1797,7 +1874,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		 */
 		if (test_bit(STATUS_INT_ENABLED, &trans->status))
 			_iwl_enable_interrupts(trans);
-		spin_unlock(&trans_pcie->irq_lock);
+		spin_unlock_bh(&trans_pcie->irq_lock);
 		lock_map_release(&trans->sync_cmd_lockdep_map);
 		return IRQ_NONE;
 	}
@@ -1808,7 +1885,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		 * already raised an interrupt.
 		 */
 		IWL_WARN(trans, "HARDWARE GONE?? INTA == 0x%08x\n", inta);
-		spin_unlock(&trans_pcie->irq_lock);
+		spin_unlock_bh(&trans_pcie->irq_lock);
 		goto out;
 	}
 
@@ -1829,7 +1906,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		IWL_DEBUG_ISR(trans, "inta 0x%08x, enabled 0x%08x\n",
 			      inta, iwl_read32(trans, CSR_INT_MASK));
 
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	/* Now service all interrupt bits discovered above. */
 	if (inta & CSR_INT_BIT_HW_ERR) {
@@ -1949,7 +2026,10 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		isr_stats->rx++;
 
 		local_bh_disable();
-		iwl_pcie_rx_handle(trans, 0);
+		if (napi_schedule_prep(&trans_pcie->rxq[0].napi)) {
+			polling = true;
+			__napi_schedule(&trans_pcie->rxq[0].napi);
+		}
 		local_bh_enable();
 	}
 
@@ -1974,20 +2054,22 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 			 inta & ~trans_pcie->inta_mask);
 	}
 
-	spin_lock(&trans_pcie->irq_lock);
-	/* only Re-enable all interrupt if disabled by irq */
-	if (test_bit(STATUS_INT_ENABLED, &trans->status))
-		_iwl_enable_interrupts(trans);
-	/* we are loading the firmware, enable FH_TX interrupt only */
-	else if (handled & CSR_INT_BIT_FH_TX)
-		iwl_enable_fw_load_int(trans);
-	/* Re-enable RF_KILL if it occurred */
-	else if (handled & CSR_INT_BIT_RF_KILL)
-		iwl_enable_rfkill_int(trans);
-	/* Re-enable the ALIVE / Rx interrupt if it occurred */
-	else if (handled & (CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX))
-		iwl_enable_fw_load_int_ctx_info(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	if (!polling) {
+		spin_lock_bh(&trans_pcie->irq_lock);
+		/* only Re-enable all interrupt if disabled by irq */
+		if (test_bit(STATUS_INT_ENABLED, &trans->status))
+			_iwl_enable_interrupts(trans);
+		/* we are loading the firmware, enable FH_TX interrupt only */
+		else if (handled & CSR_INT_BIT_FH_TX)
+			iwl_enable_fw_load_int(trans);
+		/* Re-enable RF_KILL if it occurred */
+		else if (handled & CSR_INT_BIT_RF_KILL)
+			iwl_enable_rfkill_int(trans);
+		/* Re-enable the ALIVE / Rx interrupt if it occurred */
+		else if (handled & (CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX))
+			iwl_enable_fw_load_int_ctx_info(trans);
+		spin_unlock_bh(&trans_pcie->irq_lock);
+	}
 
 out:
 	lock_map_release(&trans->sync_cmd_lockdep_map);
@@ -2049,7 +2131,7 @@ void iwl_pcie_reset_ict(struct iwl_trans *trans)
 	if (!trans_pcie->ict_tbl)
 		return;
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	_iwl_disable_interrupts(trans);
 
 	memset(trans_pcie->ict_tbl, 0, ICT_SIZE);
@@ -2067,7 +2149,7 @@ void iwl_pcie_reset_ict(struct iwl_trans *trans)
 	trans_pcie->ict_index = 0;
 	iwl_write32(trans, CSR_INT, trans_pcie->inta_mask);
 	_iwl_enable_interrupts(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 }
 
 /* Device is going down disable ict interrupt usage */
@@ -2075,9 +2157,9 @@ void iwl_pcie_disable_ict(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	trans_pcie->use_ict = false;
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 }
 
 irqreturn_t iwl_pcie_isr(int irq, void *data)
@@ -2109,10 +2191,11 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	struct iwl_trans *trans = trans_pcie->trans;
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
 	u32 inta_fh, inta_hw;
+	bool polling = false;
 
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	inta_fh = iwl_read32(trans, CSR_MSIX_FH_INT_CAUSES_AD);
 	inta_hw = iwl_read32(trans, CSR_MSIX_HW_INT_CAUSES_AD);
 	/*
@@ -2120,7 +2203,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	 */
 	iwl_write32(trans, CSR_MSIX_FH_INT_CAUSES_AD, inta_fh);
 	iwl_write32(trans, CSR_MSIX_HW_INT_CAUSES_AD, inta_hw);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, true, inta_fh, inta_hw);
 
@@ -2146,14 +2229,20 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q0) {
 		local_bh_disable();
-		iwl_pcie_rx_handle(trans, 0);
+		if (napi_schedule_prep(&trans_pcie->rxq[0].napi)) {
+			polling = true;
+			__napi_schedule(&trans_pcie->rxq[0].napi);
+		}
 		local_bh_enable();
 	}
 
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q1) {
 		local_bh_disable();
-		iwl_pcie_rx_handle(trans, 1);
+		if (napi_schedule_prep(&trans_pcie->rxq[1].napi)) {
+			polling = true;
+			__napi_schedule(&trans_pcie->rxq[1].napi);
+		}
 		local_bh_enable();
 	}
 
@@ -2248,7 +2337,8 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		wake_up(&trans_pcie->fw_reset_waitq);
 	}
 
-	iwl_pcie_clear_irq(trans, entry);
+	if (!polling)
+		iwl_pcie_clear_irq(trans, entry->entry);
 
 	lock_map_release(&trans->sync_cmd_lockdep_map);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c602b815dcc2..70515550c91e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -213,9 +213,9 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 			       trans->cfg->min_txq_size);
 
 	/* TODO: most of the logic can be removed in A0 - but not in Z0 */
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	iwl_pcie_gen2_apm_init(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	iwl_op_mode_nic_config(trans->op_mode);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 285e0d586021..5e6dc194fe14 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -511,9 +511,9 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 	int ret;
 
 	/* nic_init */
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 	ret = iwl_pcie_apm_init(trans);
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 5dda0015522d..7d1785fb0e40 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -393,7 +393,7 @@ static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 	int ch, ret;
 	u32 mask = 0;
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 
 	if (!iwl_trans_grab_nic_access(trans, &flags))
 		goto out;
@@ -414,7 +414,7 @@ static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
 	iwl_trans_release_nic_access(trans, &flags);
 
 out:
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 }
 
 /*
@@ -571,7 +571,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 		alloc = true;
 	}
 
-	spin_lock(&trans_pcie->irq_lock);
+	spin_lock_bh(&trans_pcie->irq_lock);
 
 	/* Turn off all Tx DMA fifos */
 	iwl_scd_deactivate_fifos(trans);
@@ -580,7 +580,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	iwl_write_direct32(trans, FH_KW_MEM_ADDR_REG,
 			   trans_pcie->kw.dma >> 4);
 
-	spin_unlock(&trans_pcie->irq_lock);
+	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
-- 
2.29.2

