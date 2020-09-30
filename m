Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09B27EEE2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgI3QUO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53432 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730627AbgI3QUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepq-002MPc-9C; Wed, 30 Sep 2020 19:20:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:52 +0300
Message-Id: <iwlwifi.20200930191738.8d33e791ec8c.Ica35125ed640aa3aa1ecc38fb5e8f1600caa8df6@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: pcie: make iwl_pcie_txq_update_byte_cnt_tbl bus independent
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

To avoid duplicating code we need to call iwl_pcie_txq_update_byte_cnt_tbl
function from non bus independent code so make it bus independent.

Used spatch rule

@r1@
struct iwl_trans_pcie *trans_pcie;
@@
(
-trans_pcie->scd_bc_tbls
+trans->txqs.scd_bc_tbls
|
-iwl_pcie_txq_update_byte_cnt_tbl
+iwl_txq_gen1_update_byte_cnt_tbl
|
-iwl_pcie_txq_inval_byte_cnt_tbl
+iwl_txq_gen1_inval_byte_cnt_tbl
|
-iwl_pcie_tfd_unmap
+iwl_txq_gen1_tfd_unmap
|
-iwl_pcie_tfd_tb_get_addr
+iwl_txq_gen1_tfd_tb_get_addr
|
-iwl_pcie_tfd_tb_get_len
+iwl_txq_gen1_tfd_tb_get_len
|
-iwl_pcie_tfd_get_num_tbs
+iwl_txq_gen1_tfd_get_num_tbs
)

/* clean all new unused variables */
@ depends on r1@
type T;
identifier i;
expression E;
@@
- T i = E;
 ... when != i

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |  18 --
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 196 ++----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 154 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  42 ++++
 6 files changed, 215 insertions(+), 200 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index c3053fa3ff73..45a9df0d42ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -918,6 +918,7 @@ struct iwl_txq {
  * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
  * @queue_used - bit mask of used queues
  * @queue_stopped - bit mask of stopped queues
+ * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
  */
 struct iwl_trans_txqs {
 	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
@@ -941,6 +942,8 @@ struct iwl_trans_txqs {
 		u16 size;
 		u8 addr_size;
 	} tfd;
+
+	struct iwl_dma_ptr scd_bc_tbls;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 1e6b988953ad..033f845a89dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -338,7 +338,6 @@ struct cont_rec {
  *	count for allocating and freeing the memory.
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
- * @scd_bc_tbls: pointer to the byte count table of the scheduler
  * @kw: keep warm address
  * @pci_dev: basic pci-network driver stuff
  * @hw_base: pci hardware address support
@@ -409,7 +408,6 @@ struct iwl_trans_pcie {
 	struct mutex mutex;
 	u32 inta_mask;
 	u32 scd_base_addr;
-	struct iwl_dma_ptr scd_bc_tbls;
 	struct iwl_dma_ptr kw;
 
 	struct iwl_txq *txq_memory;
@@ -555,22 +553,6 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 
-static inline u16 iwl_pcie_tfd_tb_get_len(struct iwl_trans *trans, void *_tfd,
-					  u8 idx)
-{
-	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
-		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
-
-		return le16_to_cpu(tb->tb_len);
-	} else {
-		struct iwl_tfd *tfd = _tfd;
-		struct iwl_tfd_tb *tb = &tfd->tbs[idx];
-
-		return le16_to_cpu(tb->hi_n_len) >> 4;
-	}
-}
-
 /*****************************************************
 * Error handling
 ******************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 61f91bd9050b..4ee8b5dd2512 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2954,7 +2954,7 @@ static u32 iwl_trans_pcie_get_cmdlen(struct iwl_trans *trans, void *tfd)
 	int i;
 
 	for (i = 0; i < trans->txqs.tfd.max_tbs; i++)
-		cmdlen += iwl_pcie_tfd_tb_get_len(trans, tfd, i);
+		cmdlen += iwl_txq_gen1_tfd_tb_get_len(trans, tfd, i);
 
 	return cmdlen;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9eee4a0e7668..8c89e4a2f7f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -77,9 +77,6 @@
 #include "internal.h"
 #include "fw/api/tx.h"
 
-#define IWL_TX_CRC_SIZE 4
-#define IWL_TX_DELIMITER_SIZE 4
-
 /*************** DMA-QUEUE-GENERAL-FUNCTIONS  *****
  * DMA services
  *
@@ -126,81 +123,6 @@ void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-/*
- * iwl_pcie_txq_update_byte_cnt_tbl - Set up entry in Tx byte-count array
- */
-static void iwl_pcie_txq_update_byte_cnt_tbl(struct iwl_trans *trans,
-					     struct iwl_txq *txq, u16 byte_cnt,
-					     int num_tbs)
-{
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl;
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int write_ptr = txq->write_ptr;
-	int txq_id = txq->id;
-	u8 sec_ctl = 0;
-	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
-	__le16 bc_ent;
-	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-	u8 sta_id = tx_cmd->sta_id;
-
-	scd_bc_tbl = trans_pcie->scd_bc_tbls.addr;
-
-	sec_ctl = tx_cmd->sec_ctl;
-
-	switch (sec_ctl & TX_CMD_SEC_MSK) {
-	case TX_CMD_SEC_CCM:
-		len += IEEE80211_CCMP_MIC_LEN;
-		break;
-	case TX_CMD_SEC_TKIP:
-		len += IEEE80211_TKIP_ICV_LEN;
-		break;
-	case TX_CMD_SEC_WEP:
-		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
-		break;
-	}
-	if (trans->txqs.bc_table_dword)
-		len = DIV_ROUND_UP(len, 4);
-
-	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-		return;
-
-	bc_ent = cpu_to_le16(len | (sta_id << 12));
-
-	scd_bc_tbl[txq_id].tfd_offset[write_ptr] = bc_ent;
-
-	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].
-			tfd_offset[TFD_QUEUE_SIZE_MAX + write_ptr] = bc_ent;
-}
-
-static void iwl_pcie_txq_inval_byte_cnt_tbl(struct iwl_trans *trans,
-					    struct iwl_txq *txq)
-{
-	struct iwl_trans_pcie *trans_pcie =
-		IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans_pcie->scd_bc_tbls.addr;
-	int txq_id = txq->id;
-	int read_ptr = txq->read_ptr;
-	u8 sta_id = 0;
-	__le16 bc_ent;
-	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-
-	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
-
-	if (txq_id != trans->txqs.cmd.q_id)
-		sta_id = tx_cmd->sta_id;
-
-	bc_ent = cpu_to_le16(1 | (sta_id << 12));
-
-	scd_bc_tbl[txq_id].tfd_offset[read_ptr] = bc_ent;
-
-	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].
-			tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] = bc_ent;
-}
-
 /*
  * iwl_pcie_txq_inc_wr_ptr - Send new write index to hardware
  */
@@ -267,35 +189,6 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	}
 }
 
-static inline dma_addr_t iwl_pcie_tfd_tb_get_addr(struct iwl_trans *trans,
-						  void *_tfd, u8 idx)
-{
-
-	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
-		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
-
-		return (dma_addr_t)(le64_to_cpu(tb->addr));
-	} else {
-		struct iwl_tfd *tfd = _tfd;
-		struct iwl_tfd_tb *tb = &tfd->tbs[idx];
-		dma_addr_t addr = get_unaligned_le32(&tb->lo);
-		dma_addr_t hi_len;
-
-		if (sizeof(dma_addr_t) <= sizeof(u32))
-			return addr;
-
-		hi_len = le16_to_cpu(tb->hi_n_len) & 0xF;
-
-		/*
-		 * shift by 16 twice to avoid warnings on 32-bit
-		 * (where this code never runs anyway due to the
-		 * if statement above)
-		 */
-		return addr | ((hi_len << 16) << 16);
-	}
-}
-
 static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
 				       u8 idx, dma_addr_t addr, u16 len)
 {
@@ -312,66 +205,6 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
 	tfd_fh->num_tbs = idx + 1;
 }
 
-static inline u8 iwl_pcie_tfd_get_num_tbs(struct iwl_trans *trans, void *_tfd)
-{
-	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
-
-		return le16_to_cpu(tfd->num_tbs) & 0x1f;
-	} else {
-		struct iwl_tfd *tfd = _tfd;
-
-		return tfd->num_tbs & 0x1f;
-	}
-}
-
-static void iwl_pcie_tfd_unmap(struct iwl_trans *trans,
-			       struct iwl_cmd_meta *meta,
-			       struct iwl_txq *txq, int index)
-{
-	int i, num_tbs;
-	void *tfd = iwl_txq_get_tfd(trans, txq, index);
-
-	/* Sanity check on number of chunks */
-	num_tbs = iwl_pcie_tfd_get_num_tbs(trans, tfd);
-
-	if (num_tbs > trans->txqs.tfd.max_tbs) {
-		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
-		/* @todo issue fatal error, it is quite serious situation */
-		return;
-	}
-
-	/* first TB is never freed - it's the bidirectional DMA data */
-
-	for (i = 1; i < num_tbs; i++) {
-		if (meta->tbs & BIT(i))
-			dma_unmap_page(trans->dev,
-				       iwl_pcie_tfd_tb_get_addr(trans, tfd, i),
-				       iwl_pcie_tfd_tb_get_len(trans, tfd, i),
-				       DMA_TO_DEVICE);
-		else
-			dma_unmap_single(trans->dev,
-					 iwl_pcie_tfd_tb_get_addr(trans, tfd,
-								  i),
-					 iwl_pcie_tfd_tb_get_len(trans, tfd,
-								 i),
-					 DMA_TO_DEVICE);
-	}
-
-	meta->tbs = 0;
-
-	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
-
-		tfd_fh->num_tbs = 0;
-	} else {
-		struct iwl_tfd *tfd_fh = (void *)tfd;
-
-		tfd_fh->num_tbs = 0;
-	}
-
-}
-
 /*
  * iwl_pcie_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
  * @trans - transport private data
@@ -394,7 +227,7 @@ void iwl_pcie_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	/* We have only q->n_window txq->entries, but we use
 	 * TFD_QUEUE_SIZE_MAX tfds
 	 */
-	iwl_pcie_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
+	iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
 
 	/* free SKB */
 	if (txq->entries) {
@@ -424,7 +257,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 	if (reset)
 		memset(tfd, 0, trans->txqs.tfd.size);
 
-	num_tbs = iwl_pcie_tfd_get_num_tbs(trans, tfd);
+	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);
 
 	/* Each TFD can point to a maximum max_tbs Tx buffers */
 	if (num_tbs >= trans->txqs.tfd.max_tbs) {
@@ -579,7 +412,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 			    NULL, clear_dwords);
 
 	iwl_write_prph(trans, SCD_DRAM_BASE_ADDR,
-		       trans_pcie->scd_bc_tbls.dma >> 10);
+		       trans->txqs.scd_bc_tbls.dma >> 10);
 
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
@@ -744,7 +577,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 
 	iwl_pcie_free_dma_ptr(trans, &trans_pcie->kw);
 
-	iwl_pcie_free_dma_ptr(trans, &trans_pcie->scd_bc_tbls);
+	iwl_pcie_free_dma_ptr(trans, &trans->txqs.scd_bc_tbls);
 }
 
 /*
@@ -770,7 +603,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 		goto error;
 	}
 
-	ret = iwl_pcie_alloc_dma_ptr(trans, &trans_pcie->scd_bc_tbls,
+	ret = iwl_pcie_alloc_dma_ptr(trans, &trans->txqs.scd_bc_tbls,
 				     bc_tbls_size);
 	if (ret) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
@@ -971,7 +804,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		txq->entries[read_ptr].skb = NULL;
 
 		if (!trans->trans_cfg->use_tfh)
-			iwl_pcie_txq_inval_byte_cnt_tbl(trans, txq);
+			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
 
 		iwl_pcie_txq_free_tfd(trans, txq);
 	}
@@ -1528,8 +1361,8 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 					   copy_size - tb0_size,
 					   DMA_TO_DEVICE);
 		if (dma_mapping_error(trans->dev, phys_addr)) {
-			iwl_pcie_tfd_unmap(trans, out_meta, txq,
-					   txq->write_ptr);
+			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,
+					       txq->write_ptr);
 			idx = -ENOMEM;
 			goto out;
 		}
@@ -1552,8 +1385,8 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		phys_addr = dma_map_single(trans->dev, (void *)data,
 					   cmdlen[i], DMA_TO_DEVICE);
 		if (dma_mapping_error(trans->dev, phys_addr)) {
-			iwl_pcie_tfd_unmap(trans, out_meta, txq,
-					   txq->write_ptr);
+			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,
+					       txq->write_ptr);
 			idx = -ENOMEM;
 			goto out;
 		}
@@ -1633,7 +1466,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	group_id = cmd->hdr.group_id;
 	cmd_id = iwl_cmd_id(cmd->hdr.cmd, group_id, 0);
 
-	iwl_pcie_tfd_unmap(trans, meta, txq, index);
+	iwl_txq_gen1_tfd_unmap(trans, meta, txq, index);
 
 	/* Input error checking is done when commands are added to queue. */
 	if (meta->flags & CMD_WANT_SKB) {
@@ -2241,8 +2074,9 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
 	/* Set up entry for this TFD in Tx byte-count array */
-	iwl_pcie_txq_update_byte_cnt_tbl(trans, txq, le16_to_cpu(tx_cmd->len),
-					 iwl_pcie_tfd_get_num_tbs(trans, tfd));
+	iwl_txq_gen1_update_byte_cnt_tbl(trans, txq, le16_to_cpu(tx_cmd->len),
+					 iwl_txq_gen1_tfd_get_num_tbs(trans,
+								      tfd));
 
 	wait_write_ptr = ieee80211_has_morefrags(fc);
 
@@ -2273,7 +2107,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	spin_unlock(&txq->lock);
 	return 0;
 out_err:
-	iwl_pcie_tfd_unmap(trans, out_meta, txq, txq->write_ptr);
+	iwl_txq_gen1_tfd_unmap(trans, out_meta, txq, txq->write_ptr);
 	spin_unlock(&txq->lock);
 	return -1;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index a6d03b75f5b7..af0b27a68d84 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1373,3 +1373,157 @@ int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size)
 	return ret;
 }
 
+static inline dma_addr_t iwl_txq_gen1_tfd_tb_get_addr(struct iwl_trans *trans,
+						      void *_tfd, u8 idx)
+{
+	struct iwl_tfd *tfd;
+	struct iwl_tfd_tb *tb;
+	dma_addr_t addr;
+	dma_addr_t hi_len;
+
+	if (trans->trans_cfg->use_tfh) {
+		struct iwl_tfh_tfd *tfd = _tfd;
+		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
+
+		return (dma_addr_t)(le64_to_cpu(tb->addr));
+	}
+
+	tfd = _tfd;
+	tb = &tfd->tbs[idx];
+	addr = get_unaligned_le32(&tb->lo);
+
+	if (sizeof(dma_addr_t) <= sizeof(u32))
+		return addr;
+
+	hi_len = le16_to_cpu(tb->hi_n_len) & 0xF;
+
+	/*
+	 * shift by 16 twice to avoid warnings on 32-bit
+	 * (where this code never runs anyway due to the
+	 * if statement above)
+	 */
+	return addr | ((hi_len << 16) << 16);
+}
+
+void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
+			    struct iwl_cmd_meta *meta,
+			    struct iwl_txq *txq, int index)
+{
+	int i, num_tbs;
+	void *tfd = iwl_txq_get_tfd(trans, txq, index);
+
+	/* Sanity check on number of chunks */
+	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);
+
+	if (num_tbs > trans->txqs.tfd.max_tbs) {
+		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
+		/* @todo issue fatal error, it is quite serious situation */
+		return;
+	}
+
+	/* first TB is never freed - it's the bidirectional DMA data */
+
+	for (i = 1; i < num_tbs; i++) {
+		if (meta->tbs & BIT(i))
+			dma_unmap_page(trans->dev,
+				       iwl_txq_gen1_tfd_tb_get_addr(trans,
+								    tfd, i),
+				       iwl_txq_gen1_tfd_tb_get_len(trans,
+								   tfd, i),
+				       DMA_TO_DEVICE);
+		else
+			dma_unmap_single(trans->dev,
+					 iwl_txq_gen1_tfd_tb_get_addr(trans,
+								      tfd, i),
+					 iwl_txq_gen1_tfd_tb_get_len(trans,
+								     tfd, i),
+					 DMA_TO_DEVICE);
+	}
+
+	meta->tbs = 0;
+
+	if (trans->trans_cfg->use_tfh) {
+		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
+
+		tfd_fh->num_tbs = 0;
+	} else {
+		struct iwl_tfd *tfd_fh = (void *)tfd;
+
+		tfd_fh->num_tbs = 0;
+	}
+}
+
+#define IWL_TX_CRC_SIZE 4
+#define IWL_TX_DELIMITER_SIZE 4
+
+/*
+ * iwl_txq_gen1_update_byte_cnt_tbl - Set up entry in Tx byte-count array
+ */
+void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
+				      struct iwl_txq *txq, u16 byte_cnt,
+				      int num_tbs)
+{
+	struct iwlagn_scd_bc_tbl *scd_bc_tbl;
+	int write_ptr = txq->write_ptr;
+	int txq_id = txq->id;
+	u8 sec_ctl = 0;
+	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
+	__le16 bc_ent;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+	u8 sta_id = tx_cmd->sta_id;
+
+	scd_bc_tbl = trans->txqs.scd_bc_tbls.addr;
+
+	sec_ctl = tx_cmd->sec_ctl;
+
+	switch (sec_ctl & TX_CMD_SEC_MSK) {
+	case TX_CMD_SEC_CCM:
+		len += IEEE80211_CCMP_MIC_LEN;
+		break;
+	case TX_CMD_SEC_TKIP:
+		len += IEEE80211_TKIP_ICV_LEN;
+		break;
+	case TX_CMD_SEC_WEP:
+		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
+		break;
+	}
+	if (trans->txqs.bc_table_dword)
+		len = DIV_ROUND_UP(len, 4);
+
+	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
+		return;
+
+	bc_ent = cpu_to_le16(len | (sta_id << 12));
+
+	scd_bc_tbl[txq_id].tfd_offset[write_ptr] = bc_ent;
+
+	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
+		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + write_ptr] =
+			bc_ent;
+}
+
+void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
+				     struct iwl_txq *txq)
+{
+	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans->txqs.scd_bc_tbls.addr;
+	int txq_id = txq->id;
+	int read_ptr = txq->read_ptr;
+	u8 sta_id = 0;
+	__le16 bc_ent;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+
+	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
+
+	if (txq_id != trans->txqs.cmd.q_id)
+		sta_id = tx_cmd->sta_id;
+
+	bc_ent = cpu_to_le16(1 | (sta_id << 12));
+
+	scd_bc_tbl[txq_id].tfd_offset[read_ptr] = bc_ent;
+
+	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
+		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] =
+			bc_ent;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 4b08764d71bd..c67577dfa21d 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -185,4 +185,46 @@ int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size);
 struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
 				      struct sk_buff *skb);
 #endif
+static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_trans *trans,
+					      void *_tfd)
+{
+	struct iwl_tfd *tfd;
+
+	if (trans->trans_cfg->use_tfh) {
+		struct iwl_tfh_tfd *tfd = _tfd;
+
+		return le16_to_cpu(tfd->num_tbs) & 0x1f;
+	}
+
+	tfd = (struct iwl_tfd *)_tfd;
+	return tfd->num_tbs & 0x1f;
+}
+
+static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
+					      void *_tfd, u8 idx)
+{
+	struct iwl_tfd *tfd;
+	struct iwl_tfd_tb *tb;
+
+	if (trans->trans_cfg->use_tfh) {
+		struct iwl_tfh_tfd *tfd = _tfd;
+		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
+
+		return le16_to_cpu(tb->tb_len);
+	}
+
+	tfd = (struct iwl_tfd *)_tfd;
+	tb = &tfd->tbs[idx];
+
+	return le16_to_cpu(tb->hi_n_len) >> 4;
+}
+
+void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
+			    struct iwl_cmd_meta *meta,
+			    struct iwl_txq *txq, int index);
+void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
+				     struct iwl_txq *txq);
+void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
+				      struct iwl_txq *txq, u16 byte_cnt,
+				      int num_tbs);
 #endif /* __iwl_trans_queue_tx_h__ */
-- 
2.28.0

