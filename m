Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3337927938E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgIYVbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728662AbgIYVbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIy-002J1P-48; Sat, 26 Sep 2020 00:31:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:42 +0300
Message-Id: <iwlwifi.20200926002540.83b41765961f.Icd12bfb2a736ccf4cbe080973c746fb70a3c4a50@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/15] iwl-trans: move dev_cmd_offs, page_offs to a common trans header
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

dev_cmd_offs, page_offs field is not directly related to the PCIe
transport, so move the structures it uses to the common iwl-trans.h header.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++++
 .../net/wireless/intel/iwlwifi/pcie/internal.h    |  4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  9 +++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      | 15 +++++++--------
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 209ec3949679..868e137c51f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -914,6 +914,8 @@ struct iwl_txq {
  * struct iwl_trans_txqs - transport tx queues data
  *
  * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
+ * @page_offs: offset from skb->cb to mac header page pointer
+ * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
  * @queue_used - bit mask of used queues
  * @queue_stopped - bit mask of stopped queues
  */
@@ -924,6 +926,8 @@ struct iwl_trans_txqs {
 	struct dma_pool *bc_pool;
 	size_t bc_tbl_size;
 	bool bc_table_dword;
+	u8 page_offs;
+	u8 dev_cmd_offs;
 
 	struct {
 		u8 fifo;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index d58f8ade3d42..22b4731ef511 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -457,8 +457,6 @@ struct iwl_trans_pcie {
 	wait_queue_head_t wait_command_queue;
 	wait_queue_head_t sx_waitq;
 
-	u8 page_offs, dev_cmd_offs;
-
 	u8 def_rx_queue;
 	u8 n_no_reclaim_cmds;
 	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
@@ -962,7 +960,7 @@ int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
 			   struct iwl_dma_ptr *ptr, size_t size);
 void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr);
 void iwl_pcie_apply_destination(struct iwl_trans *trans);
-void iwl_pcie_free_tso_page(struct iwl_trans_pcie *trans_pcie,
+void iwl_pcie_free_tso_page(struct iwl_trans *trans,
 			    struct sk_buff *skb);
 #ifdef CONFIG_INET
 struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 29c5e71b5495..52e61df6206e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1911,6 +1911,9 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans->txqs.cmd.q_id = trans_cfg->cmd_queue;
 	trans->txqs.cmd.fifo = trans_cfg->cmd_fifo;
 	trans->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
+	trans->txqs.page_offs = trans_cfg->cb_data_offs;
+	trans->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
+
 	if (WARN_ON(trans_cfg->n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
 		trans_pcie->n_no_reclaim_cmds = 0;
 	else
@@ -1932,9 +1935,6 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
 	trans_pcie->sw_csum_tx = trans_cfg->sw_csum_tx;
 
-	trans_pcie->page_offs = trans_cfg->cb_data_offs;
-	trans_pcie->dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
-
 	trans->command_groups = trans_cfg->command_groups;
 	trans->command_groups_size = trans_cfg->command_groups_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 051bf37b4536..5ed7852289d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -253,11 +253,10 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 static struct page *get_workaround_page(struct iwl_trans *trans,
 					struct sk_buff *skb)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct page **page_ptr;
 	struct page *ret;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
 
 	ret = alloc_page(GFP_ATOMIC);
 	if (!ret)
@@ -711,7 +710,6 @@ struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			   struct iwl_device_tx_cmd *dev_cmd, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_cmd_meta *out_meta;
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	u16 cmd_len;
@@ -741,7 +739,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans_pcie->dev_cmd_offs);
+					       trans->txqs.dev_cmd_offs);
 
 			*dev_cmd_ptr = dev_cmd;
 			__skb_queue_tail(&txq->overflow_q, skb);
@@ -1171,7 +1169,6 @@ int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
  */
 void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	spin_lock_bh(&txq->lock);
@@ -1186,7 +1183,7 @@ void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id)
 			if (WARN_ON_ONCE(!skb))
 				continue;
 
-			iwl_pcie_free_tso_page(trans_pcie, skb);
+			iwl_pcie_free_tso_page(trans, skb);
 		}
 		iwl_pcie_gen2_free_tfd(trans, txq);
 		txq->read_ptr = iwl_queue_inc_wrap(trans, txq->read_ptr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index b9308700a2a1..e15939849a23 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -614,13 +614,13 @@ int iwl_pcie_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 	return 0;
 }
 
-void iwl_pcie_free_tso_page(struct iwl_trans_pcie *trans_pcie,
+void iwl_pcie_free_tso_page(struct iwl_trans *trans,
 			    struct sk_buff *skb)
 {
 	struct page **page_ptr;
 	struct page *next;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
 	next = *page_ptr;
 	*page_ptr = NULL;
 
@@ -668,7 +668,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 			if (WARN_ON_ONCE(!skb))
 				continue;
 
-			iwl_pcie_free_tso_page(trans_pcie, skb);
+			iwl_pcie_free_tso_page(trans, skb);
 		}
 		iwl_pcie_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_queue_inc_wrap(trans, txq->read_ptr);
@@ -1107,7 +1107,6 @@ static inline void iwl_pcie_txq_progress(struct iwl_txq *txq)
 void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			    struct sk_buff_head *skbs)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int tfd_num = iwl_pcie_get_cmd_index(txq, ssn);
 	int read_ptr = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
@@ -1156,7 +1155,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		if (WARN_ON_ONCE(!skb))
 			continue;
 
-		iwl_pcie_free_tso_page(trans_pcie, skb);
+		iwl_pcie_free_tso_page(trans, skb);
 
 		__skb_queue_tail(skbs, skb);
 
@@ -1200,7 +1199,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
-						 trans_pcie->dev_cmd_offs);
+						 trans->txqs.dev_cmd_offs);
 
 			/*
 			 * Note that we can very well be overflowing again.
@@ -2058,7 +2057,7 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
 	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->tso_hdr_page);
 	struct page **page_ptr;
 
-	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->page_offs);
+	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
 
 	if (WARN_ON(*page_ptr))
 		return NULL;
@@ -2369,7 +2368,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans_pcie->dev_cmd_offs);
+					       trans->txqs.dev_cmd_offs);
 
 			*dev_cmd_ptr = dev_cmd;
 			__skb_queue_tail(&txq->overflow_q, skb);
-- 
2.28.0

