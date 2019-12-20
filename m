Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF686127B4C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLTMvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54078 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbfLTMvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkn-0007lx-Op; Fri, 20 Dec 2019 14:51:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:20 +0200
Message-Id: <20191220125124.1315679-8-luca@coelho.fi>
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
Subject: [PATCH 07/11] iwlwifi: pcie: map only used part of RX buffers
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't need to map *everything* of the RX buffers, we won't use
that much, map only the part we're going to use. This save some
IOMMU space (if applicable and it can deal with that) and also
prepares a bit for mapping partial pages for 2K buffers later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 18 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/internal.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 13 ++++++-------
 .../net/wireless/intel/iwlwifi/pcie/trans.c    |  4 +++-
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8cadad7364ac..872cda2be0f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -358,6 +358,24 @@ iwl_trans_get_rb_size_order(enum iwl_amsdu_size rb_size)
 	}
 }
 
+static inline int
+iwl_trans_get_rb_size(enum iwl_amsdu_size rb_size)
+{
+	switch (rb_size) {
+	case IWL_AMSDU_2K:
+		return 2 * 1024;
+	case IWL_AMSDU_4K:
+		return 4 * 1024;
+	case IWL_AMSDU_8K:
+		return 8 * 1024;
+	case IWL_AMSDU_12K:
+		return 12 * 1024;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
 struct iwl_hcmd_names {
 	u8 cmd_id;
 	const char *const cmd_name;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index c45df9a48559..c7d094cf1e4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -491,6 +491,7 @@ struct cont_rec {
  * @sw_csum_tx: if true, then the transport will compute the csum of the TXed
  *	frame.
  * @rx_page_order: page order for receive buffer size
+ * @rx_buf_bytes: RX buffer (RB) size in bytes
  * @reg_lock: protect hw register access
  * @mutex: to protect stop_device / start_fw / start_hw
  * @cmd_in_flight: true when we have a host command in flight
@@ -581,6 +582,7 @@ struct iwl_trans_pcie {
 	bool sw_csum_tx;
 	bool pcie_dbg_dumped_once;
 	u32 rx_page_order;
+	u32 rx_buf_bytes;
 
 	/*protect hw register */
 	spinlock_t reg_lock;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index f03d3cfb50da..20f93386fc4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -485,7 +485,7 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 		/* Get physical address of the RB */
 		rxb->page_dma =
 			dma_map_page(trans->dev, page, 0,
-				     PAGE_SIZE << trans_pcie->rx_page_order,
+				     trans_pcie->rx_buf_bytes,
 				     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 			rxb->page = NULL;
@@ -514,8 +514,7 @@ void iwl_pcie_free_rbs_pool(struct iwl_trans *trans)
 		if (!trans_pcie->rx_pool[i].page)
 			continue;
 		dma_unmap_page(trans->dev, trans_pcie->rx_pool[i].page_dma,
-			       PAGE_SIZE << trans_pcie->rx_page_order,
-			       DMA_FROM_DEVICE);
+			       trans_pcie->rx_buf_bytes, DMA_FROM_DEVICE);
 		__free_pages(trans_pcie->rx_pool[i].page,
 			     trans_pcie->rx_page_order);
 		trans_pcie->rx_pool[i].page = NULL;
@@ -575,8 +574,8 @@ static void iwl_pcie_rx_allocator(struct iwl_trans *trans)
 
 			/* Get physical address of the RB */
 			rxb->page_dma = dma_map_page(trans->dev, page, 0,
-					PAGE_SIZE << trans_pcie->rx_page_order,
-					DMA_FROM_DEVICE);
+						     trans_pcie->rx_buf_bytes,
+						     DMA_FROM_DEVICE);
 			if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 				rxb->page = NULL;
 				__free_pages(page, trans_pcie->rx_page_order);
@@ -1248,7 +1247,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans_pcie->txq[trans_pcie->cmd_queue];
 	bool page_stolen = false;
-	int max_len = PAGE_SIZE << trans_pcie->rx_page_order;
+	int max_len = trans_pcie->rx_buf_bytes;
 	u32 offset = 0;
 
 	if (WARN_ON(!rxb))
@@ -1369,7 +1368,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 	if (rxb->page != NULL) {
 		rxb->page_dma =
 			dma_map_page(trans->dev, rxb->page, 0,
-				     PAGE_SIZE << trans_pcie->rx_page_order,
+				     trans_pcie->rx_buf_bytes,
 				     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 			/*
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index af9bc6b64542..d7617eb52c02 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1915,6 +1915,8 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans_pcie->rx_buf_size = trans_cfg->rx_buf_size;
 	trans_pcie->rx_page_order =
 		iwl_trans_get_rb_size_order(trans_pcie->rx_buf_size);
+	trans_pcie->rx_buf_bytes =
+		iwl_trans_get_rb_size(trans_pcie->rx_buf_size);
 
 	trans_pcie->bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
@@ -2933,7 +2935,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 				   int allocated_rb_nums)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int max_len = PAGE_SIZE << trans_pcie->rx_page_order;
+	int max_len = trans_pcie->rx_buf_bytes;
 	/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 	struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 	u32 i, r, j, rb_len = 0;
-- 
2.24.0

