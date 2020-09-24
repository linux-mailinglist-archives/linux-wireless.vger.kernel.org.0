Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA4277286
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIXNhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52096 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728022AbgIXNhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDt-002IGj-Bi; Thu, 24 Sep 2020 16:23:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:36 +0300
Message-Id: <iwlwifi.20200924162105.a1a2ce2bce38.Ieada0fe087ebcc9bc84e22fc5abc9dba8914dd9f@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 4/7] iwlwifi: iwl-trans: move tfd to trans layer
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The tfd_* code is not directly related to the PCIe transport,
so move the structures it uses to the common iwl-trans.h header.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 12 +++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 ++++++++
 .../wireless/intel/iwlwifi/pcie/internal.h    | 12 +--------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 17 +++---------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 13 ++++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 26 ++++++++-----------
 6 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 105776b39792..a99e0c5af512 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -127,6 +127,18 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 		if (!trans->txqs.bc_pool)
 			return NULL;
 	}
+
+	if (trans->trans_cfg->use_tfh) {
+		trans->txqs.tfd.addr_size = 64;
+		trans->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
+		trans->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
+	} else {
+		trans->txqs.tfd.addr_size = 36;
+		trans->txqs.tfd.max_tbs = IWL_NUM_OF_TBS;
+		trans->txqs.tfd.size = sizeof(struct iwl_tfd);
+	}
+	trans->max_skb_frags = IWL_TRANS_MAX_FRAGS(trans);
+
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index dbcd89e9546b..868aa3b0f797 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -215,6 +215,12 @@ struct iwl_device_tx_cmd {
  */
 #define IWL_MAX_CMD_TBS_PER_TFD	2
 
+/* We need 2 entries for the TX command and header, and another one might
+ * be needed for potential data in the SKB's head. The remaining ones can
+ * be used for frags.
+ */
+#define IWL_TRANS_MAX_FRAGS(trans) ((trans)->txqs.tfd.max_tbs - 3)
+
 /**
  * enum iwl_hcmd_dataflag - flag for each one of the chunks of the command
  *
@@ -922,6 +928,11 @@ struct iwl_trans_txqs {
 		unsigned int wdg_timeout;
 	} cmd;
 
+	struct {
+		u8 max_tbs;
+		u16 size;
+		u8 addr_size;
+	} tfd;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 032e858ce7a3..9873b63301f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -80,12 +80,6 @@
 #include "iwl-op-mode.h"
 #include "iwl-drv.h"
 
-/* We need 2 entries for the TX command and header, and another one might
- * be needed for potential data in the SKB's head. The remaining ones can
- * be used for frags.
- */
-#define IWL_PCIE_MAX_FRAGS(x) (x->max_tbs - 3)
-
 /*
  * RX related structures and functions
  */
@@ -469,8 +463,6 @@ struct iwl_trans_pcie {
 	u8 def_rx_queue;
 	u8 n_no_reclaim_cmds;
 	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
-	u8 max_tbs;
-	u16 tfd_size;
 	u16 num_rx_bufs;
 
 	enum iwl_amsdu_size rx_buf_size;
@@ -807,12 +799,10 @@ static inline u16 iwl_pcie_get_cmd_index(const struct iwl_txq *q, u32 index)
 static inline void *iwl_pcie_get_tfd(struct iwl_trans *trans,
 				     struct iwl_txq *txq, int idx)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
 	if (trans->trans_cfg->use_tfh)
 		idx = iwl_pcie_get_cmd_index(txq, idx);
 
-	return txq->tfds + trans_pcie->tfd_size * idx;
+	return txq->tfds + trans->txqs.tfd.size * idx;
 }
 
 static inline const char *queue_name(struct device *dev,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 354ec140f448..994f17616159 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2989,11 +2989,10 @@ static void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
 
 static u32 iwl_trans_pcie_get_cmdlen(struct iwl_trans *trans, void *tfd)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 cmdlen = 0;
 	int i;
 
-	for (i = 0; i < trans_pcie->max_tbs; i++)
+	for (i = 0; i < trans->txqs.tfd.max_tbs; i++)
 		cmdlen += iwl_pcie_tfd_tb_get_len(trans, tfd, i);
 
 	return cmdlen;
@@ -3333,7 +3332,7 @@ static struct iwl_trans_dump_data
 	data = (void *)dump_data->data;
 
 	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_TXCMD) && cmdq) {
-		u16 tfd_size = trans_pcie->tfd_size;
+		u16 tfd_size = trans->txqs.tfd.size;
 
 		data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_TXCMD);
 		txcmd = (void *)data->data;
@@ -3555,19 +3554,9 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->def_rx_queue = 0;
 
-	if (cfg_trans->use_tfh) {
-		addr_size = 64;
-		trans_pcie->max_tbs = IWL_TFH_NUM_TBS;
-		trans_pcie->tfd_size = sizeof(struct iwl_tfh_tfd);
-	} else {
-		addr_size = 36;
-		trans_pcie->max_tbs = IWL_NUM_OF_TBS;
-		trans_pcie->tfd_size = sizeof(struct iwl_tfd);
-	}
-	trans->max_skb_frags = IWL_PCIE_MAX_FRAGS(trans_pcie);
-
 	pci_set_master(pdev);
 
+	addr_size = trans->txqs.tfd.addr_size;
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(addr_size));
 	if (!ret)
 		ret = pci_set_consistent_dma_mask(pdev,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8b2275bf301c..328b48597770 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -158,13 +158,12 @@ static void iwl_pcie_gen2_tfd_unmap(struct iwl_trans *trans,
 				    struct iwl_cmd_meta *meta,
 				    struct iwl_tfh_tfd *tfd)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i, num_tbs;
 
 	/* Sanity check on number of chunks */
 	num_tbs = iwl_pcie_gen2_get_num_tbs(trans, tfd);
 
-	if (num_tbs > trans_pcie->max_tbs) {
+	if (num_tbs > trans->txqs.tfd.max_tbs) {
 		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
 		return;
 	}
@@ -219,7 +218,6 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 				struct iwl_tfh_tfd *tfd, dma_addr_t addr,
 				u16 len)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int idx = iwl_pcie_gen2_get_num_tbs(trans, tfd);
 	struct iwl_tfh_tb *tb;
 
@@ -239,9 +237,9 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 	tb = &tfd->tbs[idx];
 
 	/* Each TFD can point to a maximum max_tbs Tx buffers */
-	if (le16_to_cpu(tfd->num_tbs) >= trans_pcie->max_tbs) {
+	if (le16_to_cpu(tfd->num_tbs) >= trans->txqs.tfd.max_tbs) {
 		IWL_ERR(trans, "Error can not send more than %d chunks\n",
-			trans_pcie->max_tbs);
+			trans->txqs.tfd.max_tbs);
 		return -EINVAL;
 	}
 
@@ -730,7 +728,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		return -EINVAL;
 
 	if (skb_is_nonlinear(skb) &&
-	    skb_shinfo(skb)->nr_frags > IWL_PCIE_MAX_FRAGS(trans_pcie) &&
+	    skb_shinfo(skb)->nr_frags > IWL_TRANS_MAX_FRAGS(trans) &&
 	    __skb_linearize(skb))
 		return -ENOMEM;
 
@@ -1210,13 +1208,12 @@ void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id)
 void iwl_pcie_gen2_txq_free_memory(struct iwl_trans *trans,
 				   struct iwl_txq *txq)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct device *dev = trans->dev;
 
 	/* De-alloc circular buffer of TFDs */
 	if (txq->tfds) {
 		dma_free_coherent(dev,
-				  trans_pcie->tfd_size * txq->n_window,
+				  trans->txqs.tfd.size * txq->n_window,
 				  txq->tfds, txq->dma_addr);
 		dma_free_coherent(dev,
 				  sizeof(*txq->first_tb_bufs) * txq->n_window,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index eb396c06b7fb..63773d6f79b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -401,14 +401,13 @@ static void iwl_pcie_tfd_unmap(struct iwl_trans *trans,
 			       struct iwl_cmd_meta *meta,
 			       struct iwl_txq *txq, int index)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i, num_tbs;
 	void *tfd = iwl_pcie_get_tfd(trans, txq, index);
 
 	/* Sanity check on number of chunks */
 	num_tbs = iwl_pcie_tfd_get_num_tbs(trans, tfd);
 
-	if (num_tbs > trans_pcie->max_tbs) {
+	if (num_tbs > trans->txqs.tfd.max_tbs) {
 		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
 		/* @todo issue fatal error, it is quite serious situation */
 		return;
@@ -489,21 +488,20 @@ void iwl_pcie_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 				  dma_addr_t addr, u16 len, bool reset)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	void *tfd;
 	u32 num_tbs;
 
-	tfd = txq->tfds + trans_pcie->tfd_size * txq->write_ptr;
+	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
 
 	if (reset)
-		memset(tfd, 0, trans_pcie->tfd_size);
+		memset(tfd, 0, trans->txqs.tfd.size);
 
 	num_tbs = iwl_pcie_tfd_get_num_tbs(trans, tfd);
 
 	/* Each TFD can point to a maximum max_tbs Tx buffers */
-	if (num_tbs >= trans_pcie->max_tbs) {
+	if (num_tbs >= trans->txqs.tfd.max_tbs) {
 		IWL_ERR(trans, "Error can not send more than %d chunks\n",
-			trans_pcie->max_tbs);
+			trans->txqs.tfd.max_tbs);
 		return -EINVAL;
 	}
 
@@ -519,8 +517,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		       int slots_num, bool cmd_queue)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	size_t tfd_sz = trans_pcie->tfd_size *
+	size_t tfd_sz = trans->txqs.tfd.size *
 		trans->trans_cfg->base_params->max_tfd_queue_size;
 	size_t tb0_buf_sz;
 	int i;
@@ -529,7 +526,7 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		return -EINVAL;
 
 	if (trans->trans_cfg->use_tfh)
-		tfd_sz = trans_pcie->tfd_size * slots_num;
+		tfd_sz = trans->txqs.tfd.size * slots_num;
 
 	timer_setup(&txq->stuck_timer, iwl_pcie_txq_stuck_timer, 0);
 	txq->trans = trans;
@@ -708,7 +705,6 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
  */
 static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	struct device *dev = trans->dev;
 	int i;
@@ -728,7 +724,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	/* De-alloc circular buffer of TFDs */
 	if (txq->tfds) {
 		dma_free_coherent(dev,
-				  trans_pcie->tfd_size *
+				  trans->txqs.tfd.size *
 				  trans->trans_cfg->base_params->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
@@ -2143,7 +2139,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 
 	trace_iwlwifi_dev_tx(trans->dev, skb,
 			     iwl_pcie_get_tfd(trans, txq, txq->write_ptr),
-			     trans_pcie->tfd_size,
+			     trans->txqs.tfd.size,
 			     &dev_cmd->hdr, IWL_FIRST_TB_SIZE + tb1_len, 0);
 
 	ip_hdrlen = skb_transport_header(skb) - skb_network_header(skb);
@@ -2352,7 +2348,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	}
 
 	if (skb_is_nonlinear(skb) &&
-	    skb_shinfo(skb)->nr_frags > IWL_PCIE_MAX_FRAGS(trans_pcie) &&
+	    skb_shinfo(skb)->nr_frags > IWL_TRANS_MAX_FRAGS(trans) &&
 	    __skb_linearize(skb))
 		return -ENOMEM;
 
@@ -2454,7 +2450,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	trace_iwlwifi_dev_tx(trans->dev, skb,
 			     iwl_pcie_get_tfd(trans, txq,
 					      txq->write_ptr),
-			     trans_pcie->tfd_size,
+			     trans->txqs.tfd.size,
 			     &dev_cmd->hdr, IWL_FIRST_TB_SIZE + tb1_len,
 			     hdr_len);
 
-- 
2.28.0

