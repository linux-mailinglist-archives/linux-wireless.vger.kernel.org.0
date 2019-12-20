Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C6127B4D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLTMvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54090 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbfLTMvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHko-0007lx-Sc; Fri, 20 Dec 2019 14:51:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:21 +0200
Message-Id: <20191220125124.1315679-9-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 08/11] iwlwifi: pcie: use partial pages if applicable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we have only 2k RBs like on the latest (AX210) hardware, then
even on x86 where PAGE_SIZE is 4k we currently waste half of the
memory.

If this is the case, return partial pages from the allocator and
track the offset in each RBD (to be able to find the data in them
and remap them later.)

This might also address other platforms with larger PAGE_SIZE by
putting more RBs into a single large page.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    | 14 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 59 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 10 +++-
 3 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index c7d094cf1e4e..2ac730859eac 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -106,6 +106,8 @@ struct iwl_host_cmd;
  * @page: driver's pointer to the rxb page
  * @invalid: rxb is in driver ownership - not owned by HW
  * @vid: index of this rxb in the global table
+ * @offset: indicates which offset of the page (in bytes)
+ *	this buffer uses (if multiple RBs fit into one page)
  */
 struct iwl_rx_mem_buffer {
 	dma_addr_t page_dma;
@@ -113,6 +115,7 @@ struct iwl_rx_mem_buffer {
 	u16 vid;
 	bool invalid;
 	struct list_head list;
+	u32 offset;
 };
 
 /**
@@ -511,6 +514,11 @@ struct cont_rec {
  * @in_rescan: true if we have triggered a device rescan
  * @base_rb_stts: base virtual address of receive buffer status for all queues
  * @base_rb_stts_dma: base physical address of receive buffer status
+ * @supported_dma_mask: DMA mask to validate the actual address against,
+ *	will be DMA_BIT_MASK(11) or DMA_BIT_MASK(12) depending on the device
+ * @alloc_page_lock: spinlock for the page allocator
+ * @alloc_page: allocated page to still use parts of
+ * @alloc_page_used: how much of the allocated page was already used (bytes)
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -583,6 +591,12 @@ struct iwl_trans_pcie {
 	bool pcie_dbg_dumped_once;
 	u32 rx_page_order;
 	u32 rx_buf_bytes;
+	u32 supported_dma_mask;
+
+	/* allocator lock for the two values below */
+	spinlock_t alloc_page_lock;
+	struct page *alloc_page;
+	u32 alloc_page_used;
 
 	/*protect hw register */
 	spinlock_t reg_lock;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 20f93386fc4d..498a14ebac47 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -298,6 +298,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rx_mem_buffer *rxb;
 
 	/*
@@ -318,8 +319,8 @@ static void iwl_pcie_rxmq_restock(struct iwl_trans *trans,
 				       list);
 		list_del(&rxb->list);
 		rxb->invalid = false;
-		/* 12 first bits are expected to be empty */
-		WARN_ON(rxb->page_dma & DMA_BIT_MASK(12));
+		/* some low bits are expected to be unset (depending on hw) */
+		WARN_ON(rxb->page_dma & trans_pcie->supported_dma_mask);
 		/* Point to Rx buffer via next RBD in circular buffer */
 		iwl_pcie_restock_bd(trans, rxq, rxb);
 		rxq->write = (rxq->write + 1) & (rxq->queue_size - 1);
@@ -412,15 +413,34 @@ void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
  *
  */
 static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans,
-					   gfp_t priority)
+					   u32 *offset, gfp_t priority)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	unsigned int rbsize = iwl_trans_get_rb_size(trans_pcie->rx_buf_size);
+	unsigned int allocsize = PAGE_SIZE << trans_pcie->rx_page_order;
 	struct page *page;
 	gfp_t gfp_mask = priority;
 
 	if (trans_pcie->rx_page_order > 0)
 		gfp_mask |= __GFP_COMP;
 
+	if (trans_pcie->alloc_page) {
+		spin_lock_bh(&trans_pcie->alloc_page_lock);
+		/* recheck */
+		if (trans_pcie->alloc_page) {
+			*offset = trans_pcie->alloc_page_used;
+			page = trans_pcie->alloc_page;
+			trans_pcie->alloc_page_used += rbsize;
+			if (trans_pcie->alloc_page_used >= allocsize)
+				trans_pcie->alloc_page = NULL;
+			else
+				get_page(page);
+			spin_unlock_bh(&trans_pcie->alloc_page_lock);
+			return page;
+		}
+		spin_unlock_bh(&trans_pcie->alloc_page_lock);
+	}
+
 	/* Alloc a new receive buffer */
 	page = alloc_pages(gfp_mask, trans_pcie->rx_page_order);
 	if (!page) {
@@ -436,6 +456,18 @@ static struct page *iwl_pcie_rx_alloc_page(struct iwl_trans *trans,
 				 "Failed to alloc_pages\n");
 		return NULL;
 	}
+
+	if (2 * rbsize <= allocsize) {
+		spin_lock_bh(&trans_pcie->alloc_page_lock);
+		if (!trans_pcie->alloc_page) {
+			get_page(page);
+			trans_pcie->alloc_page = page;
+			trans_pcie->alloc_page_used = rbsize;
+		}
+		spin_unlock_bh(&trans_pcie->alloc_page_lock);
+	}
+
+	*offset = 0;
 	return page;
 }
 
@@ -456,6 +488,8 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 	struct page *page;
 
 	while (1) {
+		unsigned int offset;
+
 		spin_lock(&rxq->lock);
 		if (list_empty(&rxq->rx_used)) {
 			spin_unlock(&rxq->lock);
@@ -463,8 +497,7 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 		}
 		spin_unlock(&rxq->lock);
 
-		/* Alloc a new receive buffer */
-		page = iwl_pcie_rx_alloc_page(trans, priority);
+		page = iwl_pcie_rx_alloc_page(trans, &offset, priority);
 		if (!page)
 			return;
 
@@ -482,9 +515,10 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 
 		BUG_ON(rxb->page);
 		rxb->page = page;
+		rxb->offset = offset;
 		/* Get physical address of the RB */
 		rxb->page_dma =
-			dma_map_page(trans->dev, page, 0,
+			dma_map_page(trans->dev, page, rxb->offset,
 				     trans_pcie->rx_buf_bytes,
 				     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
@@ -567,13 +601,15 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 			BUG_ON(rxb->page);
 
 			/* Alloc a new receive buffer */
-			page = iwl_pcie_rx_alloc_page(trans, gfp_mask);
+			page = iwl_pcie_rx_alloc_page(trans, &rxb->offset,
+						      gfp_mask);
 			if (!page)
 				continue;
 			rxb->page = page;
 
 			/* Get physical address of the RB */
-			rxb->page_dma = dma_map_page(trans->dev, page, 0,
+			rxb->page_dma = dma_map_page(trans->dev, page,
+						     rxb->offset,
 						     trans_pcie->rx_buf_bytes,
 						     DMA_FROM_DEVICE);
 			if (dma_mapping_error(trans->dev, rxb->page_dma)) {
@@ -1190,6 +1226,9 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 	kfree(trans_pcie->rx_pool);
 	kfree(trans_pcie->global_table);
 	kfree(trans_pcie->rxq);
+
+	if (trans_pcie->alloc_page)
+		__free_pages(trans_pcie->alloc_page, trans_pcie->rx_page_order);
 }
 
 static void iwl_pcie_rx_move_to_allocator(struct iwl_rxq *rxq,
@@ -1261,7 +1300,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		bool reclaim;
 		int index, cmd_index, len;
 		struct iwl_rx_cmd_buffer rxcb = {
-			._offset = offset,
+			._offset = rxb->offset + offset,
 			._rx_page_order = trans_pcie->rx_page_order,
 			._page = rxb->page,
 			._page_stolen = false,
@@ -1367,7 +1406,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 	 * rx_free list for reuse later. */
 	if (rxb->page != NULL) {
 		rxb->page_dma =
-			dma_map_page(trans->dev, rxb->page, 0,
+			dma_map_page(trans->dev, rxb->page, rxb->offset,
 				     trans_pcie->rx_buf_bytes,
 				     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d7617eb52c02..cb4915451792 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1917,6 +1917,9 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 		iwl_trans_get_rb_size_order(trans_pcie->rx_buf_size);
 	trans_pcie->rx_buf_bytes =
 		iwl_trans_get_rb_size(trans_pcie->rx_buf_size);
+	trans_pcie->supported_dma_mask = DMA_BIT_MASK(12);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
 
 	trans_pcie->bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
@@ -2961,9 +2964,9 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 		rb->index = cpu_to_le32(i);
 		memcpy(rb->data, page_address(rxb->page), max_len);
 		/* remap the page for the free benefit */
-		rxb->page_dma = dma_map_page(trans->dev, rxb->page, 0,
-						     max_len,
-						     DMA_FROM_DEVICE);
+		rxb->page_dma = dma_map_page(trans->dev, rxb->page,
+					     rxb->offset, max_len,
+					     DMA_FROM_DEVICE);
 
 		*data = iwl_fw_error_next_data(*data);
 	}
@@ -3454,6 +3457,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	trans_pcie->opmode_down = true;
 	spin_lock_init(&trans_pcie->irq_lock);
 	spin_lock_init(&trans_pcie->reg_lock);
+	spin_lock_init(&trans_pcie->alloc_page_lock);
 	mutex_init(&trans_pcie->mutex);
 	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
 
-- 
2.24.0

