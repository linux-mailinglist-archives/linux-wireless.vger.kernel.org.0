Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083BD1CB169
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEHOI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:08:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726736AbgEHOI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:08:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jX3fn-000WXw-RJ; Fri, 08 May 2020 17:08:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  8 May 2020 17:07:59 +0300
Message-Id: <iwlwifi.20200508170402.64465f9dd241.Ie04ae55f33954636a39c98e7ae1e739c0507435b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508140802.558267-1-luca@coelho.fi>
References: <20200508140802.558267-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/11] iwlwifi: move txq-specific from trans_pcie to common trans
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We don't want to have txq code in the PCIe transport code, so move all
the relevant elements to a new iwl_txq structure and store it in
iwl_trans.

spatch

@ replace_pcie @
struct iwl_trans_pcie *trans_pcie;
@@

(
-trans_pcie->queue_stopped
+trans->txqs.queue_stopped
|
-trans_pcie->queue_used
+trans->txqs.queue_used
|
-trans_pcie->txq
+trans->txqs.txq
|
-trans_pcie->txq
+trans->txqs.txq
|
-trans_pcie->cmd_queue
+trans->txqs.cmd.q_id
|
-trans_pcie->cmd_fifo
+trans->txqs.cmd.fifo
|
-trans_pcie->cmd_q_wdg_timeout
+trans->txqs.cmd.wdg_timeout
)

// clean all new unused variables
@ depends on replace_pcie @
type T;
identifier i;
expression E;
@@
- T i = E;
 ... when != i

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  21 ++++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   6 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  14 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   6 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  11 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  35 +++---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  70 +++++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 112 +++++++++---------
 9 files changed, 138 insertions(+), 139 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 57361b27351e..a301e2484cdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -902,6 +902,25 @@ struct iwl_txq {
 
 	bool overflow_tx;
 };
+
+/**
+ * struct iwl_trans_txqs - transport tx queues data
+ *
+ * @queue_used - bit mask of used queues
+ * @queue_stopped - bit mask of stopped queues
+ */
+struct iwl_trans_txqs {
+	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
+	unsigned long queue_stopped[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
+	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
+	struct {
+		u8 fifo;
+		u8 q_id;
+		unsigned int wdg_timeout;
+	} cmd;
+
+};
+
 /**
  * struct iwl_trans - transport common data
  *
@@ -935,6 +954,7 @@ struct iwl_txq {
  * @system_pm_mode: the system-wide power management mode in use.
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
+ * @iwl_trans_txqs: transport tx queues data.
  */
 struct iwl_trans {
 	const struct iwl_trans_ops *ops;
@@ -982,6 +1002,7 @@ struct iwl_trans {
 	enum iwl_plat_pm_mode system_pm_mode;
 
 	const char *name;
+	struct iwl_trans_txqs txqs;
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index dcd81ee1f773..1ab136600415 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -221,7 +221,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	ctxt_info_gen3->tr_idx_arr_size =
 		cpu_to_le16(IWL_NUM_OF_TRANSFER_RINGS);
 	ctxt_info_gen3->mtr_base_addr =
-		cpu_to_le64(trans_pcie->txq[trans_pcie->cmd_queue]->dma_addr);
+		cpu_to_le64(trans->txqs.txq[trans->txqs.cmd.q_id]->dma_addr);
 	ctxt_info_gen3->mcr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->used_bd_dma);
 	ctxt_info_gen3->mtr_size =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index b65405009d02..23abfbd096b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -263,7 +263,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	/* initialize TX command queue */
 	ctxt_info->hcmd_cfg.cmd_queue_addr =
-		cpu_to_le64(trans_pcie->txq[trans_pcie->cmd_queue]->dma_addr);
+		cpu_to_le64(trans->txqs.txq[trans->txqs.cmd.q_id]->dma_addr);
 	ctxt_info->hcmd_cfg.cmd_queue_size =
 		TFD_QUEUE_CB_SIZE(IWL_CMD_QUEUE_SIZE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3c6a119aede4..55808ba10d27 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -454,9 +454,6 @@ struct iwl_trans_pcie {
 	struct dma_pool *bc_pool;
 
 	struct iwl_txq *txq_memory;
-	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
-	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
-	unsigned long queue_stopped[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
 
 	/* PCI bus related data */
 	struct pci_dev *pci_dev;
@@ -470,10 +467,7 @@ struct iwl_trans_pcie {
 
 	u8 page_offs, dev_cmd_offs;
 
-	u8 cmd_queue;
 	u8 def_rx_queue;
-	u8 cmd_fifo;
-	unsigned int cmd_q_wdg_timeout;
 	u8 n_no_reclaim_cmds;
 	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
 	u8 max_tbs;
@@ -876,9 +870,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans);
 static inline void iwl_wake_queue(struct iwl_trans *trans,
 				  struct iwl_txq *txq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
-	if (test_and_clear_bit(txq->id, trans_pcie->queue_stopped)) {
+	if (test_and_clear_bit(txq->id, trans->txqs.queue_stopped)) {
 		IWL_DEBUG_TX_QUEUES(trans, "Wake hwq %d\n", txq->id);
 		iwl_op_mode_queue_not_full(trans->op_mode, txq->id);
 	}
@@ -887,9 +879,7 @@ static inline void iwl_wake_queue(struct iwl_trans *trans,
 static inline void iwl_stop_queue(struct iwl_trans *trans,
 				  struct iwl_txq *txq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
-	if (!test_and_set_bit(txq->id, trans_pcie->queue_stopped)) {
+	if (!test_and_set_bit(txq->id, trans->txqs.queue_stopped)) {
 		iwl_op_mode_queue_full(trans->op_mode, txq->id);
 		IWL_DEBUG_TX_QUEUES(trans, "Stop hwq %d\n", txq->id);
 	} else
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 72d1cf27e6a4..24cb1b1f21f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1284,7 +1284,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 				int i)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	bool page_stolen = false;
 	int max_len = trans_pcie->rx_buf_bytes;
 	u32 offset = 0;
@@ -1671,9 +1671,9 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	}
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		if (!trans_pcie->txq[i])
+		if (!trans->txqs.txq[i])
 			continue;
-		del_timer(&trans_pcie->txq[i]->stuck_timer);
+		del_timer(&trans->txqs.txq[i]->stuck_timer);
 	}
 
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 19a2c72081ab..97c9e9c87436 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -245,7 +245,7 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 		return -ENOMEM;
 
 	/* Allocate or reset and init all Tx and Command queues */
-	if (iwl_pcie_gen2_tx_init(trans, trans_pcie->cmd_queue, queue_size))
+	if (iwl_pcie_gen2_tx_init(trans, trans->txqs.cmd.q_id, queue_size))
 		return -ENOMEM;
 
 	/* enable shadow regs in HW */
@@ -262,8 +262,9 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	iwl_pcie_reset_ict(trans);
 
 	/* make sure all queue are not stopped/used */
-	memset(trans_pcie->queue_stopped, 0, sizeof(trans_pcie->queue_stopped));
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_stopped, 0,
+	       sizeof(trans->txqs.queue_stopped));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	/* now that we got alive we can free the fw image & the context info.
 	 * paging memory cannot be freed included since FW will still use it
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3bcbc2967c88..e5160d620868 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1904,9 +1904,9 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	trans_pcie->cmd_queue = trans_cfg->cmd_queue;
-	trans_pcie->cmd_fifo = trans_cfg->cmd_fifo;
-	trans_pcie->cmd_q_wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
+	trans->txqs.cmd.q_id = trans_cfg->cmd_queue;
+	trans->txqs.cmd.fifo = trans_cfg->cmd_fifo;
+	trans->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
 	if (WARN_ON(trans_cfg->n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
 		trans_pcie->n_no_reclaim_cmds = 0;
 	else
@@ -2199,11 +2199,10 @@ static void iwl_trans_pcie_freeze_txq_timer(struct iwl_trans *trans,
 					    unsigned long txqs,
 					    bool freeze)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int queue;
 
 	for_each_set_bit(queue, &txqs, BITS_PER_LONG) {
-		struct iwl_txq *txq = trans_pcie->txq[queue];
+		struct iwl_txq *txq = trans->txqs.txq[queue];
 		unsigned long now;
 
 		spin_lock_bh(&txq->lock);
@@ -2251,13 +2250,12 @@ static void iwl_trans_pcie_freeze_txq_timer(struct iwl_trans *trans,
 
 static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		struct iwl_txq *txq = trans_pcie->txq[i];
+		struct iwl_txq *txq = trans->txqs.txq[i];
 
-		if (i == trans_pcie->cmd_queue)
+		if (i == trans->txqs.cmd.q_id)
 			continue;
 
 		spin_lock_bh(&txq->lock);
@@ -2326,7 +2324,6 @@ static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 
 static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq;
 	unsigned long now = jiffies;
 	bool overflow_tx;
@@ -2336,11 +2333,11 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
-	if (!test_bit(txq_idx, trans_pcie->queue_used))
+	if (!test_bit(txq_idx, trans->txqs.queue_used))
 		return -EINVAL;
 
 	IWL_DEBUG_TX_QUEUES(trans, "Emptying queue %d...\n", txq_idx);
-	txq = trans_pcie->txq[txq_idx];
+	txq = trans->txqs.txq[txq_idx];
 
 	spin_lock_bh(&txq->lock);
 	overflow_tx = txq->overflow_tx ||
@@ -2388,7 +2385,6 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 
 static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int cnt;
 	int ret = 0;
 
@@ -2397,9 +2393,9 @@ static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 	     cnt < trans->trans_cfg->base_params->num_of_queues;
 	     cnt++) {
 
-		if (cnt == trans_pcie->cmd_queue)
+		if (cnt == trans->txqs.cmd.q_id)
 			continue;
-		if (!test_bit(cnt, trans_pcie->queue_used))
+		if (!test_bit(cnt, trans->txqs.queue_used))
 			continue;
 		if (!(BIT(cnt) & txq_bm))
 			continue;
@@ -2573,13 +2569,12 @@ static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
 	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
 	struct iwl_dbgfs_tx_queue_state *state = v;
 	struct iwl_trans *trans = priv->trans;
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[state->pos];
+	struct iwl_txq *txq = trans->txqs.txq[state->pos];
 
 	seq_printf(seq, "hwq %.3u: used=%d stopped=%d ",
 		   (unsigned int)state->pos,
-		   !!test_bit(state->pos, trans_pcie->queue_used),
-		   !!test_bit(state->pos, trans_pcie->queue_stopped));
+		   !!test_bit(state->pos, trans->txqs.queue_used),
+		   !!test_bit(state->pos, trans->txqs.queue_stopped));
 	if (txq)
 		seq_printf(seq,
 			   "read=%u write=%u need_update=%d frozen=%d n_window=%d ampdu=%d",
@@ -2589,7 +2584,7 @@ static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
 	else
 		seq_puts(seq, "(unallocated)");
 
-	if (state->pos == trans_pcie->cmd_queue)
+	if (state->pos == trans->txqs.cmd.q_id)
 		seq_puts(seq, " (HCMD)");
 	seq_puts(seq, "\n");
 
@@ -3265,7 +3260,7 @@ static struct iwl_trans_dump_data
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_fw_error_dump_data *data;
-	struct iwl_txq *cmdq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *cmdq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_fw_error_dump_txcmd *txcmd;
 	struct iwl_trans_dump_data *dump_data;
 	u32 len, num_rbs = 0, monitor_len = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index bb55563bba68..7fc7542535d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -64,7 +64,6 @@
  */
 void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int txq_id;
 
 	/*
@@ -72,12 +71,13 @@ void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans)
 	 * queues. This happens when we have an rfkill interrupt.
 	 * Since we stop Tx altogether - mark the queues as stopped.
 	 */
-	memset(trans_pcie->queue_stopped, 0, sizeof(trans_pcie->queue_stopped));
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_stopped, 0,
+	       sizeof(trans->txqs.queue_stopped));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < ARRAY_SIZE(trans_pcie->txq); txq_id++) {
-		if (!trans_pcie->txq[txq_id])
+	for (txq_id = 0; txq_id < ARRAY_SIZE(trans->txqs.txq); txq_id++) {
+		if (!trans->txqs.txq[txq_id])
 			continue;
 		iwl_pcie_gen2_txq_unmap(trans, txq_id);
 	}
@@ -716,7 +716,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_cmd_meta *out_meta;
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	u16 cmd_len;
 	int idx;
 	void *tfd;
@@ -725,7 +725,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      "queue %d out of range", txq_id))
 		return -EINVAL;
 
-	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->queue_used),
+	if (WARN_ONCE(!test_bit(txq_id, trans->txqs.queue_used),
 		      "TX on unused queue %d\n", txq_id))
 		return -EINVAL;
 
@@ -819,7 +819,7 @@ static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 				      struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	unsigned long flags;
@@ -931,7 +931,7 @@ static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		cpu_to_le16(cmd_size - sizeof(struct iwl_cmd_header_wide));
 	out_cmd->hdr_wide.reserved = 0;
 	out_cmd->hdr_wide.sequence =
-		cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->cmd_queue) |
+		cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
 					 INDEX_TO_SEQ(txq->write_ptr));
 
 	cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -979,7 +979,7 @@ static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		     "Sending command %s (%.2x.%.2x), seq: 0x%04X, %d bytes at %d[%d]:%d\n",
 		     iwl_get_cmd_string(trans, cmd->id), group_id,
 		     out_cmd->hdr.cmd, le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans_pcie->cmd_queue);
+		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
@@ -1056,7 +1056,7 @@ static int iwl_pcie_gen2_send_hcmd_sync(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	int cmd_idx;
 	int ret;
 
@@ -1175,14 +1175,14 @@ int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	spin_lock_bh(&txq->lock);
 	while (txq->write_ptr != txq->read_ptr) {
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
 
-		if (txq_id != trans_pcie->cmd_queue) {
+		if (txq_id != trans->txqs.cmd.q_id) {
 			int idx = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
 			struct sk_buff *skb = txq->entries[idx].skb;
 
@@ -1240,7 +1240,6 @@ void iwl_pcie_gen2_txq_free_memory(struct iwl_trans *trans,
  */
 static void iwl_pcie_gen2_txq_free(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq;
 	int i;
 
@@ -1248,7 +1247,7 @@ static void iwl_pcie_gen2_txq_free(struct iwl_trans *trans, int txq_id)
 		      "queue %d out of range", txq_id))
 		return;
 
-	txq = trans_pcie->txq[txq_id];
+	txq = trans->txqs.txq[txq_id];
 
 	if (WARN_ON(!txq))
 		return;
@@ -1256,7 +1255,7 @@ static void iwl_pcie_gen2_txq_free(struct iwl_trans *trans, int txq_id)
 	iwl_pcie_gen2_txq_unmap(trans, txq_id);
 
 	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans_pcie->cmd_queue)
+	if (txq_id == trans->txqs.cmd.q_id)
 		for (i = 0; i < txq->n_window; i++) {
 			kzfree(txq->entries[i].cmd);
 			kzfree(txq->entries[i].free_buf);
@@ -1265,9 +1264,9 @@ static void iwl_pcie_gen2_txq_free(struct iwl_trans *trans, int txq_id)
 
 	iwl_pcie_gen2_txq_free_memory(trans, txq);
 
-	trans_pcie->txq[txq_id] = NULL;
+	trans->txqs.txq[txq_id] = NULL;
 
-	clear_bit(txq_id, trans_pcie->queue_used);
+	clear_bit(txq_id, trans->txqs.queue_used);
 }
 
 int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
@@ -1327,7 +1326,6 @@ int iwl_trans_pcie_txq_alloc_response(struct iwl_trans *trans,
 				      struct iwl_txq *txq,
 				      struct iwl_host_cmd *hcmd)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tx_queue_cfg_rsp *rsp;
 	int ret, qid;
 	u32 wr_ptr;
@@ -1342,20 +1340,20 @@ int iwl_trans_pcie_txq_alloc_response(struct iwl_trans *trans,
 	qid = le16_to_cpu(rsp->queue_number);
 	wr_ptr = le16_to_cpu(rsp->write_pointer);
 
-	if (qid >= ARRAY_SIZE(trans_pcie->txq)) {
+	if (qid >= ARRAY_SIZE(trans->txqs.txq)) {
 		WARN_ONCE(1, "queue index %d unsupported", qid);
 		ret = -EIO;
 		goto error_free_resp;
 	}
 
-	if (test_and_set_bit(qid, trans_pcie->queue_used)) {
+	if (test_and_set_bit(qid, trans->txqs.queue_used)) {
 		WARN_ONCE(1, "queue %d already used", qid);
 		ret = -EIO;
 		goto error_free_resp;
 	}
 
 	txq->id = qid;
-	trans_pcie->txq[qid] = txq;
+	trans->txqs.txq[qid] = txq;
 	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 
 	/* Place first TFD at index corresponding to start sequence number */
@@ -1413,8 +1411,6 @@ int iwl_trans_pcie_dyn_txq_alloc(struct iwl_trans *trans,
 
 void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
 	if (WARN(queue >= IWL_MAX_TVQM_QUEUES,
 		 "queue %d out of range", queue))
 		return;
@@ -1425,7 +1421,7 @@ void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue)
 	 * allow the op_mode to call txq_disable after it already called
 	 * stop_device.
 	 */
-	if (!test_and_clear_bit(queue, trans_pcie->queue_used)) {
+	if (!test_and_clear_bit(queue, trans->txqs.queue_used)) {
 		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
 			  "queue %d not used", queue);
 		return;
@@ -1433,22 +1429,21 @@ void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue)
 
 	iwl_pcie_gen2_txq_unmap(trans, queue);
 
-	iwl_pcie_gen2_txq_free_memory(trans, trans_pcie->txq[queue]);
-	trans_pcie->txq[queue] = NULL;
+	iwl_pcie_gen2_txq_free_memory(trans, trans->txqs.txq[queue]);
+	trans->txqs.txq[queue] = NULL;
 
 	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", queue);
 }
 
 void iwl_pcie_gen2_tx_free(struct iwl_trans *trans)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	/* Free all TX queues */
-	for (i = 0; i < ARRAY_SIZE(trans_pcie->txq); i++) {
-		if (!trans_pcie->txq[i])
+	for (i = 0; i < ARRAY_SIZE(trans->txqs.txq); i++) {
+		if (!trans->txqs.txq[i])
 			continue;
 
 		iwl_pcie_gen2_txq_free(trans, i);
@@ -1457,35 +1452,34 @@ void iwl_pcie_gen2_tx_free(struct iwl_trans *trans)
 
 int iwl_pcie_gen2_tx_init(struct iwl_trans *trans, int txq_id, int queue_size)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *queue;
 	int ret;
 
 	/* alloc and init the tx queue */
-	if (!trans_pcie->txq[txq_id]) {
+	if (!trans->txqs.txq[txq_id]) {
 		queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 		if (!queue) {
 			IWL_ERR(trans, "Not enough memory for tx queue\n");
 			return -ENOMEM;
 		}
-		trans_pcie->txq[txq_id] = queue;
+		trans->txqs.txq[txq_id] = queue;
 		ret = iwl_pcie_txq_alloc(trans, queue, queue_size, true);
 		if (ret) {
 			IWL_ERR(trans, "Tx %d queue init failed\n", txq_id);
 			goto error;
 		}
 	} else {
-		queue = trans_pcie->txq[txq_id];
+		queue = trans->txqs.txq[txq_id];
 	}
 
 	ret = iwl_pcie_txq_init(trans, queue, queue_size,
-				(txq_id == trans_pcie->cmd_queue));
+				(txq_id == trans->txqs.cmd.q_id));
 	if (ret) {
 		IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
 		goto error;
 	}
-	trans_pcie->txq[txq_id]->id = txq_id;
-	set_bit(txq_id, trans_pcie->queue_used);
+	trans->txqs.txq[txq_id]->id = txq_id;
+	set_bit(txq_id, trans->txqs.queue_used);
 
 	return 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 757cf4e9de33..5c6c3fa0d29f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -261,7 +261,7 @@ static void iwl_pcie_txq_inval_byte_cnt_tbl(struct iwl_trans *trans,
 
 	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
 
-	if (txq_id != trans_pcie->cmd_queue)
+	if (txq_id != trans->txqs.cmd.q_id)
 		sta_id = tx_cmd->sta_id;
 
 	bc_ent = cpu_to_le16(1 | (sta_id << 12));
@@ -279,7 +279,6 @@ static void iwl_pcie_txq_inval_byte_cnt_tbl(struct iwl_trans *trans,
 static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 				    struct iwl_txq *txq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 reg = 0;
 	int txq_id = txq->id;
 
@@ -292,7 +291,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 3. there is a chance that the NIC is asleep
 	 */
 	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
-	    txq_id != trans_pcie->cmd_queue &&
+	    txq_id != trans->txqs.cmd.q_id &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
 		 * wake up nic if it's powered down ...
@@ -323,13 +322,12 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 
 void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		struct iwl_txq *txq = trans_pcie->txq[i];
+		struct iwl_txq *txq = trans->txqs.txq[i];
 
-		if (!test_bit(i, trans_pcie->queue_used))
+		if (!test_bit(i, trans->txqs.queue_used))
 			continue;
 
 		spin_lock_bh(&txq->lock);
@@ -660,14 +658,14 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	spin_lock_bh(&txq->lock);
 	while (txq->write_ptr != txq->read_ptr) {
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
 
-		if (txq_id != trans_pcie->cmd_queue) {
+		if (txq_id != trans->txqs.cmd.q_id) {
 			struct sk_buff *skb = txq->entries[txq->read_ptr].skb;
 
 			if (WARN_ON_ONCE(!skb))
@@ -682,7 +680,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 			unsigned long flags;
 
 			spin_lock_irqsave(&trans_pcie->reg_lock, flags);
-			if (txq_id == trans_pcie->cmd_queue)
+			if (txq_id == trans->txqs.cmd.q_id)
 				iwl_pcie_clear_cmd_in_flight(trans);
 			spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
 		}
@@ -711,7 +709,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	struct device *dev = trans->dev;
 	int i;
 
@@ -721,7 +719,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	iwl_pcie_txq_unmap(trans, txq_id);
 
 	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans_pcie->cmd_queue)
+	if (txq_id == trans->txqs.cmd.q_id)
 		for (i = 0; i < txq->n_window; i++) {
 			kzfree(txq->entries[i].cmd);
 			kzfree(txq->entries[i].free_buf);
@@ -760,8 +758,9 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 				SCD_CONTEXT_MEM_LOWER_BOUND) / sizeof(u32);
 
 	/* make sure all queue are not stopped/used */
-	memset(trans_pcie->queue_stopped, 0, sizeof(trans_pcie->queue_stopped));
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_stopped, 0,
+	       sizeof(trans->txqs.queue_stopped));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	trans_pcie->scd_base_addr =
 		iwl_read_prph(trans, SCD_SRAM_BASE_ADDR);
@@ -783,9 +782,9 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 	if (trans->trans_cfg->base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
-	iwl_trans_ac_txq_enable(trans, trans_pcie->cmd_queue,
-				trans_pcie->cmd_fifo,
-				trans_pcie->cmd_q_wdg_timeout);
+	iwl_trans_ac_txq_enable(trans, trans->txqs.cmd.q_id,
+				trans->txqs.cmd.fifo,
+				trans->txqs.cmd.wdg_timeout);
 
 	/* Activate all Tx DMA/FIFO channels */
 	iwl_scd_activate_fifos(trans);
@@ -821,7 +820,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		struct iwl_txq *txq = trans_pcie->txq[txq_id];
+		struct iwl_txq *txq = trans->txqs.txq[txq_id];
 		if (trans->trans_cfg->use_tfh)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
@@ -897,8 +896,9 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 	 * queues. This happens when we have an rfkill interrupt.
 	 * Since we stop Tx altogether - mark the queues as stopped.
 	 */
-	memset(trans_pcie->queue_stopped, 0, sizeof(trans_pcie->queue_stopped));
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_stopped, 0,
+	       sizeof(trans->txqs.queue_stopped));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	/* This can happen: start_hw, stop_device */
 	if (!trans_pcie->txq_memory)
@@ -922,7 +922,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	int txq_id;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	memset(trans_pcie->queue_used, 0, sizeof(trans_pcie->queue_used));
+	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
 
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
@@ -930,7 +930,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 		     txq_id < trans->trans_cfg->base_params->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
-			trans_pcie->txq[txq_id] = NULL;
+			trans->txqs.txq[txq_id] = NULL;
 		}
 	}
 
@@ -991,7 +991,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
+		bool cmd_queue = (txq_id == trans->txqs.cmd.q_id);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -999,14 +999,14 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
 					  trans->cfg->min_256_ba_txq_size);
-		trans_pcie->txq[txq_id] = &trans_pcie->txq_memory[txq_id];
-		ret = iwl_pcie_txq_alloc(trans, trans_pcie->txq[txq_id],
+		trans->txqs.txq[txq_id] = &trans_pcie->txq_memory[txq_id];
+		ret = iwl_pcie_txq_alloc(trans, trans->txqs.txq[txq_id],
 					 slots_num, cmd_queue);
 		if (ret) {
 			IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
 			goto error;
 		}
-		trans_pcie->txq[txq_id]->id = txq_id;
+		trans->txqs.txq[txq_id]->id = txq_id;
 	}
 
 	return 0;
@@ -1045,7 +1045,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
+		bool cmd_queue = (txq_id == trans->txqs.cmd.q_id);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -1053,7 +1053,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
 					  trans->cfg->min_256_ba_txq_size);
-		ret = iwl_pcie_txq_init(trans, trans_pcie->txq[txq_id],
+		ret = iwl_pcie_txq_init(trans, trans->txqs.txq[txq_id],
 					slots_num, cmd_queue);
 		if (ret) {
 			IWL_ERR(trans, "Tx %d queue init failed\n", txq_id);
@@ -1067,7 +1067,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 		 * Circular buffer (TFD queue in DRAM) physical base address
 		 */
 		iwl_write_direct32(trans, FH_MEM_CBBC_QUEUE(trans, txq_id),
-				   trans_pcie->txq[txq_id]->dma_addr >> 8);
+				   trans->txqs.txq[txq_id]->dma_addr >> 8);
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
@@ -1112,18 +1112,18 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			    struct sk_buff_head *skbs)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int tfd_num = iwl_pcie_get_cmd_index(txq, ssn);
 	int read_ptr = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
 	int last_to_free;
 
 	/* This function is not meant to release cmd queue*/
-	if (WARN_ON(txq_id == trans_pcie->cmd_queue))
+	if (WARN_ON(txq_id == trans->txqs.cmd.q_id))
 		return;
 
 	spin_lock_bh(&txq->lock);
 
-	if (!test_bit(txq_id, trans_pcie->queue_used)) {
+	if (!test_bit(txq_id, trans->txqs.queue_used)) {
 		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
 				    txq_id, ssn);
 		goto out;
@@ -1175,7 +1175,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	iwl_pcie_txq_progress(txq);
 
 	if (iwl_queue_space(trans, txq) > txq->low_mark &&
-	    test_bit(txq_id, trans_pcie->queue_stopped)) {
+	    test_bit(txq_id, trans->txqs.queue_stopped)) {
 		struct sk_buff_head overflow_skbs;
 
 		__skb_queue_head_init(&overflow_skbs);
@@ -1228,8 +1228,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 /* Set wr_ptr of specific device and txq  */
 void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	spin_lock_bh(&txq->lock);
 
@@ -1289,7 +1288,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	unsigned long flags;
 	int nfreed = 0;
 	u16 r;
@@ -1301,7 +1300,7 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 
 	if (idx >= trans->trans_cfg->base_params->max_tfd_queue_size ||
 	    (!iwl_queue_used(txq, idx))) {
-		WARN_ONCE(test_bit(txq_id, trans_pcie->queue_used),
+		WARN_ONCE(test_bit(txq_id, trans->txqs.queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
 			  trans->trans_cfg->base_params->max_tfd_queue_size,
@@ -1363,11 +1362,11 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       unsigned int wdg_timeout)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int fifo = -1;
 	bool scd_bug = false;
 
-	if (test_and_set_bit(txq_id, trans_pcie->queue_used))
+	if (test_and_set_bit(txq_id, trans->txqs.queue_used))
 		WARN_ONCE(1, "queue %d already used - expect issues", txq_id);
 
 	txq->wd_timeout = msecs_to_jiffies(wdg_timeout);
@@ -1376,7 +1375,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		fifo = cfg->fifo;
 
 		/* Disable the scheduler prior configuring the cmd queue */
-		if (txq_id == trans_pcie->cmd_queue &&
+		if (txq_id == trans->txqs.cmd.q_id &&
 		    trans_pcie->scd_set_active)
 			iwl_scd_enable_set_active(trans, 0);
 
@@ -1384,7 +1383,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		iwl_scd_txq_set_inactive(trans, txq_id);
 
 		/* Set this queue as a chain-building queue unless it is CMD */
-		if (txq_id != trans_pcie->cmd_queue)
+		if (txq_id != trans->txqs.cmd.q_id)
 			iwl_scd_txq_set_chain(trans, txq_id);
 
 		if (cfg->aggregate) {
@@ -1454,7 +1453,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       SCD_QUEUE_STTS_REG_MSK);
 
 		/* enable the scheduler for this queue (only) */
-		if (txq_id == trans_pcie->cmd_queue &&
+		if (txq_id == trans->txqs.cmd.q_id &&
 		    trans_pcie->scd_set_active)
 			iwl_scd_enable_set_active(trans, BIT(txq_id));
 
@@ -1473,8 +1472,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
 					bool shared_mode)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	txq->ampdu = !shared_mode;
 }
@@ -1487,8 +1485,8 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 			SCD_TX_STTS_QUEUE_OFFSET(txq_id);
 	static const u32 zero_val[4] = {};
 
-	trans_pcie->txq[txq_id]->frozen_expiry_remainder = 0;
-	trans_pcie->txq[txq_id]->frozen = false;
+	trans->txqs.txq[txq_id]->frozen_expiry_remainder = 0;
+	trans->txqs.txq[txq_id]->frozen = false;
 
 	/*
 	 * Upon HW Rfkill - we stop the device, and then stop the queues
@@ -1496,7 +1494,7 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	 * allow the op_mode to call txq_disable after it already called
 	 * stop_device.
 	 */
-	if (!test_and_clear_bit(txq_id, trans_pcie->queue_used)) {
+	if (!test_and_clear_bit(txq_id, trans->txqs.queue_used)) {
 		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
 			  "queue %d not used", txq_id);
 		return;
@@ -1510,7 +1508,7 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	}
 
 	iwl_pcie_txq_unmap(trans, txq_id);
-	trans_pcie->txq[txq_id]->ampdu = false;
+	trans->txqs.txq[txq_id]->ampdu = false;
 
 	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", txq_id);
 }
@@ -1530,7 +1528,7 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 				 struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	unsigned long flags;
@@ -1656,7 +1654,7 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 				    sizeof(struct iwl_cmd_header_wide));
 		out_cmd->hdr_wide.reserved = 0;
 		out_cmd->hdr_wide.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->cmd_queue) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 
 		cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -1664,7 +1662,7 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	} else {
 		out_cmd->hdr.cmd = iwl_cmd_opcode(cmd->id);
 		out_cmd->hdr.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->cmd_queue) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 		out_cmd->hdr.group_id = 0;
 
@@ -1715,7 +1713,7 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		     iwl_get_cmd_string(trans, cmd->id),
 		     group_id, out_cmd->hdr.cmd,
 		     le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans_pcie->cmd_queue);
+		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
@@ -1815,14 +1813,14 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	struct iwl_device_cmd *cmd;
 	struct iwl_cmd_meta *meta;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 
 	/* If a Tx command is being handled and it isn't in the actual
 	 * command queue then there a command routing bug has been introduced
 	 * in the queue management code. */
-	if (WARN(txq_id != trans_pcie->cmd_queue,
+	if (WARN(txq_id != trans->txqs.cmd.q_id,
 		 "wrong command queue %d (should be %d), sequence 0x%X readp=%d writep=%d\n",
-		 txq_id, trans_pcie->cmd_queue, sequence, txq->read_ptr,
+		 txq_id, trans->txqs.cmd.q_id, sequence, txq->read_ptr,
 		 txq->write_ptr)) {
 		iwl_print_hex_error(trans, pkt, 32);
 		return;
@@ -1894,7 +1892,7 @@ static int iwl_pcie_send_hcmd_sync(struct iwl_trans *trans,
 				   struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	int cmd_idx;
 	int ret;
 
@@ -2332,9 +2330,9 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	u16 wifi_seq;
 	bool amsdu;
 
-	txq = trans_pcie->txq[txq_id];
+	txq = trans->txqs.txq[txq_id];
 
-	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->queue_used),
+	if (WARN_ONCE(!test_bit(txq_id, trans->txqs.queue_used),
 		      "TX on unused queue %d\n", txq_id))
 		return -EINVAL;
 
-- 
2.26.2

