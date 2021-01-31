Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CD309BF5
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhAaLdb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 06:33:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42896 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231470AbhAaLbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:31:24 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY3-004131-F0; Sun, 31 Jan 2021 13:05:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:31 +0200
Message-Id: <iwlwifi.20210131125922.d206ac428823.Ia19339efb09f9d80143f0d0e398a158180754cfa@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: pcie: Disable softirqs during Rx queue init
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When Rx queues are configured during module init, NAPI is enabled
while the Rx queue lock is held. However, since softirqs are not
disabled, it is possible that and IRQ would fire and call
iwl_pcie_rx_handle() which would also try to acquire the Rx lock.

Prevent this by disabling softirqs during Rx queue configuration,
as part of module init flow.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 36 ++++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index e3e53419b526..407809c7e958 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -301,7 +301,7 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
 	if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 		return;
 
-	spin_lock(&rxq->lock);
+	spin_lock_bh(&rxq->lock);
 	while ((iwl_rxq_space(rxq) > 0) && (rxq->free_count)) {
 		__le32 *bd = (__le32 *)rxq->bd;
 		/* The overwritten rxb must be a used one */
@@ -320,14 +320,14 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
 		rxq->write = (rxq->write + 1) & RX_QUEUE_MASK;
 		rxq->free_count--;
 	}
-	spin_unlock(&rxq->lock);
+	spin_unlock_bh(&rxq->lock);
 
 	/* If we've added more space for the firmware to place data, tell it.
 	 * Increment device's write pointer in multiples of 8. */
 	if (rxq->write_actual != (rxq->write & ~0x7)) {
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 		iwl_pcie_rxq_inc_wr_ptr(trans, rxq);
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 	}
 }
 
@@ -433,28 +433,28 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 	while (1) {
 		unsigned int offset;
 
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 		if (list_empty(&rxq->rx_used)) {
-			spin_unlock(&rxq->lock);
+			spin_unlock_bh(&rxq->lock);
 			return;
 		}
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 
 		page = iwl_pcie_rx_alloc_page(trans, &offset, priority);
 		if (!page)
 			return;
 
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 
 		if (list_empty(&rxq->rx_used)) {
-			spin_unlock(&rxq->lock);
+			spin_unlock_bh(&rxq->lock);
 			__free_pages(page, trans_pcie->rx_page_order);
 			return;
 		}
 		rxb = list_first_entry(&rxq->rx_used, struct iwl_rx_mem_buffer,
 				       list);
 		list_del(&rxb->list);
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 
 		BUG_ON(rxb->page);
 		rxb->page = page;
@@ -466,19 +466,19 @@ void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 				     DMA_FROM_DEVICE);
 		if (dma_mapping_error(trans->dev, rxb->page_dma)) {
 			rxb->page = NULL;
-			spin_lock(&rxq->lock);
+			spin_lock_bh(&rxq->lock);
 			list_add(&rxb->list, &rxq->rx_used);
-			spin_unlock(&rxq->lock);
+			spin_unlock_bh(&rxq->lock);
 			__free_pages(page, trans_pcie->rx_page_order);
 			return;
 		}
 
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 
 		list_add_tail(&rxb->list, &rxq->rx_free);
 		rxq->free_count++;
 
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 	}
 }
 
@@ -1112,7 +1112,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	for (i = 0; i < trans->num_rx_queues; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
-		spin_lock(&rxq->lock);
+		spin_lock_bh(&rxq->lock);
 		/*
 		 * Set read write pointer to reflect that we have processed
 		 * and used all buffers, but have not restocked the Rx queue
@@ -1148,7 +1148,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 			napi_enable(&rxq->napi);
 		}
 
-		spin_unlock(&rxq->lock);
+		spin_unlock_bh(&rxq->lock);
 	}
 
 	/* move the pool to the default queue and allocator ownerships */
@@ -1190,9 +1190,9 @@ int iwl_pcie_rx_init(struct iwl_trans *trans)
 
 	iwl_pcie_rxq_restock(trans, trans_pcie->rxq);
 
-	spin_lock(&trans_pcie->rxq->lock);
+	spin_lock_bh(&trans_pcie->rxq->lock);
 	iwl_pcie_rxq_inc_wr_ptr(trans, trans_pcie->rxq);
-	spin_unlock(&trans_pcie->rxq->lock);
+	spin_unlock_bh(&trans_pcie->rxq->lock);
 
 	return 0;
 }
-- 
2.29.2

