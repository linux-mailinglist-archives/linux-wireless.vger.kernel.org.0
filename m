Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330BB3AAD23
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQHNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:13:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47936 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229580AbhFQHNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:13:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm99-001XeC-7X; Thu, 17 Jun 2021 10:09:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:51 +0300
Message-Id: <iwlwifi.20210617100544.b5c639f3866f.I4d5de1929be048085767f1234a1e07b517ab6a2d@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: pcie: remove TR/CR tail allocations
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The TR/CR tail data are meant to be per-queue-arrays, however,
we allocate them completely wrong (we have a separate allocation
per queue).

Looking at this more closely, it turns out that the hardware
never uses these - we have a separate free list per RX queue
and maintain a write pointer for that in a register, and the
RX itself is indicated in the RB status (rb_stts) DMA region.

Therefore, remove the TR/CR tail allocations completely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 28 +++++++--------
 .../wireless/intel/iwlwifi/pcie/internal.h    | 11 ------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 34 -------------------
 3 files changed, 14 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index cecc32e7dbe8..49560e508b5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -138,8 +138,15 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	/* Allocate prph information
 	 * currently we don't assign to the prph info anything, but it would get
-	 * assigned later */
-	prph_info = dma_alloc_coherent(trans->dev, sizeof(*prph_info),
+	 * assigned later
+	 *
+	 * We also use the second half of this page to give the device some
+	 * dummy TR/CR tail pointers - which shouldn't be necessary as we don't
+	 * use this, but the hardware still reads/writes there and we can't let
+	 * it go do that with a NULL pointer.
+	 */
+	BUILD_BUG_ON(sizeof(*prph_info) > PAGE_SIZE / 2);
+	prph_info = dma_alloc_coherent(trans->dev, PAGE_SIZE,
 				       &trans_pcie->prph_info_dma_addr,
 				       GFP_KERNEL);
 	if (!prph_info) {
@@ -166,13 +173,9 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	ctxt_info_gen3->cr_head_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->rb_stts_dma);
 	ctxt_info_gen3->tr_tail_idx_arr_base_addr =
-		cpu_to_le64(trans_pcie->rxq->tr_tail_dma);
+		cpu_to_le64(trans_pcie->prph_info_dma_addr + PAGE_SIZE / 2);
 	ctxt_info_gen3->cr_tail_idx_arr_base_addr =
-		cpu_to_le64(trans_pcie->rxq->cr_tail_dma);
-	ctxt_info_gen3->cr_idx_arr_size =
-		cpu_to_le16(IWL_NUM_OF_COMPLETION_RINGS);
-	ctxt_info_gen3->tr_idx_arr_size =
-		cpu_to_le16(IWL_NUM_OF_TRANSFER_RINGS);
+		cpu_to_le64(trans_pcie->prph_info_dma_addr + 3 * PAGE_SIZE / 4);
 	ctxt_info_gen3->mtr_base_addr =
 		cpu_to_le64(trans->txqs.txq[trans->txqs.cmd.q_id]->dma_addr);
 	ctxt_info_gen3->mcr_base_addr =
@@ -216,10 +219,8 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 			  trans_pcie->ctxt_info_dma_addr);
 	trans_pcie->ctxt_info_gen3 = NULL;
 err_free_prph_info:
-	dma_free_coherent(trans->dev,
-			  sizeof(*prph_info),
-			prph_info,
-			trans_pcie->prph_info_dma_addr);
+	dma_free_coherent(trans->dev, PAGE_SIZE, prph_info,
+			  trans_pcie->prph_info_dma_addr);
 
 err_free_prph_scratch:
 	dma_free_coherent(trans->dev,
@@ -251,8 +252,7 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
 	trans_pcie->prph_scratch_dma_addr = 0;
 	trans_pcie->prph_scratch = NULL;
 
-	dma_free_coherent(trans->dev, sizeof(*trans_pcie->prph_info),
-			  trans_pcie->prph_info,
+	dma_free_coherent(trans->dev, PAGE_SIZE, trans_pcie->prph_info,
 			  trans_pcie->prph_info_dma_addr);
 	trans_pcie->prph_info_dma_addr = 0;
 	trans_pcie->prph_info = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 1c740c382b9b..292b972a25db 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -111,10 +111,6 @@ struct iwl_rx_completion_desc {
  * @bd_dma: bus address of buffer of receive buffer descriptors (rbd)
  * @used_bd: driver's pointer to buffer of used receive buffer descriptors (rbd)
  * @used_bd_dma: physical address of buffer of used receive buffer descriptors (rbd)
- * @tr_tail: driver's pointer to the transmission ring tail buffer
- * @tr_tail_dma: physical address of the buffer for the transmission ring tail
- * @cr_tail: driver's pointer to the completion ring tail buffer
- * @cr_tail_dma: physical address of the buffer for the completion ring tail
  * @read: Shared index to newest available Rx buffer
  * @write: Shared index to oldest written Rx packet
  * @free_count: Number of pre-allocated buffers in rx_free
@@ -142,10 +138,6 @@ struct iwl_rxq {
 		struct iwl_rx_completion_desc *cd;
 	};
 	dma_addr_t used_bd_dma;
-	__le16 *tr_tail;
-	dma_addr_t tr_tail_dma;
-	__le16 *cr_tail;
-	dma_addr_t cr_tail_dma;
 	u32 read;
 	u32 write;
 	u32 free_count;
@@ -533,9 +525,6 @@ static inline void _iwl_disable_interrupts(struct iwl_trans *trans)
 	IWL_DEBUG_ISR(trans, "Disabled interrupts\n");
 }
 
-#define IWL_NUM_OF_COMPLETION_RINGS	31
-#define IWL_NUM_OF_TRANSFER_RINGS	527
-
 static inline int iwl_pcie_get_num_sections(const struct fw_img *fw,
 					    int start)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index fb8491412be4..4f6f4b2720f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -663,7 +663,6 @@ static int iwl_pcie_free_bd_size(struct iwl_trans *trans, bool use_rx_td)
 static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
-	struct device *dev = trans->dev;
 	bool use_rx_td = (trans->trans_cfg->device_family >=
 			  IWL_DEVICE_FAMILY_AX210);
 	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
@@ -685,21 +684,6 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  rxq->used_bd, rxq->used_bd_dma);
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
-
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		return;
-
-	if (rxq->tr_tail)
-		dma_free_coherent(dev, sizeof(__le16),
-				  rxq->tr_tail, rxq->tr_tail_dma);
-	rxq->tr_tail_dma = 0;
-	rxq->tr_tail = NULL;
-
-	if (rxq->cr_tail)
-		dma_free_coherent(dev, sizeof(__le16),
-				  rxq->cr_tail, rxq->cr_tail_dma);
-	rxq->cr_tail_dma = 0;
-	rxq->cr_tail = NULL;
 }
 
 static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
@@ -744,21 +728,6 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	rxq->rb_stts_dma =
 		trans_pcie->base_rb_stts_dma + rxq->id * rb_stts_size;
 
-	if (!use_rx_td)
-		return 0;
-
-	/* Allocate the driver's pointer to TR tail */
-	rxq->tr_tail = dma_alloc_coherent(dev, sizeof(__le16),
-					  &rxq->tr_tail_dma, GFP_KERNEL);
-	if (!rxq->tr_tail)
-		goto err;
-
-	/* Allocate the driver's pointer to CR tail */
-	rxq->cr_tail = dma_alloc_coherent(dev, sizeof(__le16),
-					  &rxq->cr_tail_dma, GFP_KERNEL);
-	if (!rxq->cr_tail)
-		goto err;
-
 	return 0;
 
 err:
@@ -1590,9 +1559,6 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
 out:
 	/* Backtrack one entry */
 	rxq->read = i;
-	/* update cr tail with the rxq read pointer */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		*rxq->cr_tail = cpu_to_le16(r);
 	spin_unlock(&rxq->lock);
 
 	/*
-- 
2.32.0

