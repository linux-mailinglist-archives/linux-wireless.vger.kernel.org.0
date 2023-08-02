Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA876D36E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHBQLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjHBQK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:10:56 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF51BF0
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:10:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 84D6746C8B;
        Wed,  2 Aug 2023 19:10:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oAVvXtADYmI0-Y7exofcZ;
        Wed, 02 Aug 2023 19:10:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690992652;
        bh=LXhU8Qa+k/Yq5aWbAP5KPliK5m6NhCvhRdtwAxUDCCM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=QznKOpv1XLtasHAC+nIoemVPPiiO/8dOS76UqY/T1zBsg7l6V0pBt8sTMwTIx/SDh
         DoUqtwWP69hwfnh88BGQf5I8oIOP6psEYaWgvbBWcNhCZpjpuv3r8yqtctM59b8UoG
         biav60W3hab2OBo7No2MLcjEnB+nhQCgzZAuZQQc=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mwifiex: avoid indirection in PCIE buffer descriptor management
Date:   Wed,  2 Aug 2023 19:09:34 +0300
Message-ID: <20230802161049.89326-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802161049.89326-1-dmantipov@yandex.ru>
References: <20230802161049.89326-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify PCIE TX, RX, and event buffer descriptor management by avoiding
an extra indirection via 'txbd_ring', 'rxbd_ring', and 'evtbd_ring'
pointer arrays. After defining rings as unions, these sets of descriptors
may be treated as a convenient C arrays in both PCIE and PFU cases, which
allows a substantial simplification of the ring initialization and cleanup
routines.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 148 +++++++-------------
 drivers/net/wireless/marvell/mwifiex/pcie.h |  20 ++-
 2 files changed, 61 insertions(+), 107 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 4c7c17fd2387..ad3422d751cf 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -748,25 +748,9 @@ static int mwifiex_pcie_enable_host_int(struct mwifiex_adapter *adapter)
 static int mwifiex_init_txq_ring(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
-	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
-	struct mwifiex_pcie_buf_desc *desc;
-	struct mwifiex_pfu_buf_desc *desc2;
-	int i;
 
-	for (i = 0; i < MWIFIEX_MAX_TXRX_BD; i++) {
-		card->tx_buf_list[i] = NULL;
-		if (reg->pfu_enabled) {
-			card->txbd_ring[i] = (void *)card->txbd_ring_vbase +
-					     (sizeof(*desc2) * i);
-			desc2 = card->txbd_ring[i];
-			memset(desc2, 0, sizeof(*desc2));
-		} else {
-			card->txbd_ring[i] = (void *)card->txbd_ring_vbase +
-					     (sizeof(*desc) * i);
-			desc = card->txbd_ring[i];
-			memset(desc, 0, sizeof(*desc));
-		}
-	}
+	memset(card->tx_buf_list, 0, sizeof(card->tx_buf_list));
+	memset(card->txbd_ring.vbase, 0, card->txbd_ring_size);
 
 	return 0;
 }
@@ -811,18 +795,14 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 
 		card->rx_buf_list[i] = skb;
 		if (reg->pfu_enabled) {
-			card->rxbd_ring[i] = (void *)card->rxbd_ring_vbase +
-					     (sizeof(*desc2) * i);
-			desc2 = card->rxbd_ring[i];
+			desc2 = &card->rxbd_ring.pfu[i];
 			desc2->paddr = buf_pa;
 			desc2->len = (u16)skb->len;
 			desc2->frag_len = (u16)skb->len;
 			desc2->flags = reg->ring_flag_eop | reg->ring_flag_sop;
 			desc2->offset = 0;
 		} else {
-			card->rxbd_ring[i] = (void *)(card->rxbd_ring_vbase +
-					     (sizeof(*desc) * i));
-			desc = card->rxbd_ring[i];
+			desc = &card->rxbd_ring.pcie[i];
 			desc->paddr = buf_pa;
 			desc->len = (u16)skb->len;
 			desc->flags = 0;
@@ -868,9 +848,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 			    (u32)((u64)buf_pa >> 32));
 
 		card->evt_buf_list[i] = skb;
-		card->evtbd_ring[i] = (void *)(card->evtbd_ring_vbase +
-				      (sizeof(*desc) * i));
-		desc = card->evtbd_ring[i];
+		desc = &card->evtbd_ring.evt[i];
 		desc->paddr = buf_pa;
 		desc->len = (u16)skb->len;
 		desc->flags = 0;
@@ -885,35 +863,20 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
-	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 	struct sk_buff *skb;
-	struct mwifiex_pcie_buf_desc *desc;
-	struct mwifiex_pfu_buf_desc *desc2;
 	int i;
 
 	for (i = 0; i < MWIFIEX_MAX_TXRX_BD; i++) {
-		if (reg->pfu_enabled) {
-			desc2 = card->txbd_ring[i];
-			if (card->tx_buf_list[i]) {
-				skb = card->tx_buf_list[i];
-				mwifiex_unmap_pci_memory(adapter, skb,
-							 DMA_TO_DEVICE);
-				dev_kfree_skb_any(skb);
-			}
-			memset(desc2, 0, sizeof(*desc2));
-		} else {
-			desc = card->txbd_ring[i];
-			if (card->tx_buf_list[i]) {
-				skb = card->tx_buf_list[i];
-				mwifiex_unmap_pci_memory(adapter, skb,
-							 DMA_TO_DEVICE);
-				dev_kfree_skb_any(skb);
-			}
-			memset(desc, 0, sizeof(*desc));
+		if (card->tx_buf_list[i]) {
+			skb = card->tx_buf_list[i];
+			card->tx_buf_list[i] = NULL;
+			mwifiex_unmap_pci_memory(adapter, skb,
+						 DMA_TO_DEVICE);
+			dev_kfree_skb_any(skb);
 		}
-		card->tx_buf_list[i] = NULL;
 	}
 
+	memset(card->txbd_ring.vbase, 0, card->txbd_ring_size);
 	atomic_set(&adapter->tx_hw_pending, 0);
 	return;
 }
@@ -924,35 +887,20 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
-	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
-	struct mwifiex_pcie_buf_desc *desc;
-	struct mwifiex_pfu_buf_desc *desc2;
 	struct sk_buff *skb;
 	int i;
 
 	for (i = 0; i < MWIFIEX_MAX_TXRX_BD; i++) {
-		if (reg->pfu_enabled) {
-			desc2 = card->rxbd_ring[i];
-			if (card->rx_buf_list[i]) {
-				skb = card->rx_buf_list[i];
-				mwifiex_unmap_pci_memory(adapter, skb,
-							 DMA_FROM_DEVICE);
-				dev_kfree_skb_any(skb);
-			}
-			memset(desc2, 0, sizeof(*desc2));
-		} else {
-			desc = card->rxbd_ring[i];
-			if (card->rx_buf_list[i]) {
-				skb = card->rx_buf_list[i];
-				mwifiex_unmap_pci_memory(adapter, skb,
-							 DMA_FROM_DEVICE);
-				dev_kfree_skb_any(skb);
-			}
-			memset(desc, 0, sizeof(*desc));
+		if (card->rx_buf_list[i]) {
+			skb = card->rx_buf_list[i];
+			card->rx_buf_list[i] = NULL;
+			mwifiex_unmap_pci_memory(adapter, skb,
+						 DMA_FROM_DEVICE);
+			dev_kfree_skb_any(skb);
 		}
-		card->rx_buf_list[i] = NULL;
 	}
 
+	memset(card->rxbd_ring.vbase, 0, card->rxbd_ring_size);
 	return;
 }
 
@@ -962,22 +910,20 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 static void mwifiex_cleanup_evt_ring(struct mwifiex_adapter *adapter)
 {
 	struct pcie_service_card *card = adapter->card;
-	struct mwifiex_evt_buf_desc *desc;
 	struct sk_buff *skb;
 	int i;
 
 	for (i = 0; i < MWIFIEX_MAX_EVT_BD; i++) {
-		desc = card->evtbd_ring[i];
 		if (card->evt_buf_list[i]) {
 			skb = card->evt_buf_list[i];
+			card->evt_buf_list[i] = NULL;
 			mwifiex_unmap_pci_memory(adapter, skb,
 						 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 		}
-		card->evt_buf_list[i] = NULL;
-		memset(desc, 0, sizeof(*desc));
 	}
 
+	memset(card->evtbd_ring.vbase, 0, card->evtbd_ring_size);
 	return;
 }
 
@@ -1012,11 +958,11 @@ static int mwifiex_pcie_create_txbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: txbd_ring: Allocating %d bytes\n",
 		    card->txbd_ring_size);
-	card->txbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+	card->txbd_ring.vbase = dma_alloc_coherent(&card->dev->dev,
 						   card->txbd_ring_size,
 						   &card->txbd_ring_pbase,
 						   GFP_KERNEL);
-	if (!card->txbd_ring_vbase) {
+	if (!card->txbd_ring.vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate coherent memory (%d bytes) failed!\n",
 			    card->txbd_ring_size);
@@ -1025,7 +971,7 @@ static int mwifiex_pcie_create_txbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_dbg(adapter, DATA,
 		    "info: txbd_ring - base: %p, pbase: %#x:%x, len: %#x\n",
-		    card->txbd_ring_vbase, (u32)card->txbd_ring_pbase,
+		    card->txbd_ring.vbase, (u32)card->txbd_ring_pbase,
 		    (u32)((u64)card->txbd_ring_pbase >> 32),
 		    card->txbd_ring_size);
 
@@ -1039,14 +985,14 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_cleanup_txq_ring(adapter);
 
-	if (card->txbd_ring_vbase)
+	if (card->txbd_ring.vbase)
 		dma_free_coherent(&card->dev->dev, card->txbd_ring_size,
-				  card->txbd_ring_vbase,
+				  card->txbd_ring.vbase,
 				  card->txbd_ring_pbase);
 	card->txbd_ring_size = 0;
 	card->txbd_wrptr = 0;
 	card->txbd_rdptr = 0 | reg->tx_rollover_ind;
-	card->txbd_ring_vbase = NULL;
+	card->txbd_ring.vbase = NULL;
 	card->txbd_ring_pbase = 0;
 
 	return 0;
@@ -1079,11 +1025,11 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: rxbd_ring: Allocating %d bytes\n",
 		    card->rxbd_ring_size);
-	card->rxbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+	card->rxbd_ring.vbase = dma_alloc_coherent(&card->dev->dev,
 						   card->rxbd_ring_size,
 						   &card->rxbd_ring_pbase,
 						   GFP_KERNEL);
-	if (!card->rxbd_ring_vbase) {
+	if (!card->rxbd_ring.vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate coherent memory (%d bytes) failed!\n",
 			    card->rxbd_ring_size);
@@ -1092,7 +1038,7 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_dbg(adapter, DATA,
 		    "info: rxbd_ring - base: %p, pbase: %#x:%x, len: %#x\n",
-		    card->rxbd_ring_vbase, (u32)card->rxbd_ring_pbase,
+		    card->rxbd_ring.vbase, (u32)card->rxbd_ring_pbase,
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
@@ -1112,14 +1058,14 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_cleanup_rxq_ring(adapter);
 
-	if (card->rxbd_ring_vbase)
+	if (card->rxbd_ring.vbase)
 		dma_free_coherent(&card->dev->dev, card->rxbd_ring_size,
-				  card->rxbd_ring_vbase,
+				  card->rxbd_ring.vbase,
 				  card->rxbd_ring_pbase);
 	card->rxbd_ring_size = 0;
 	card->rxbd_wrptr = 0;
 	card->rxbd_rdptr = 0 | reg->rx_rollover_ind;
-	card->rxbd_ring_vbase = NULL;
+	card->rxbd_ring.vbase = NULL;
 	card->rxbd_ring_pbase = 0;
 
 	return 0;
@@ -1148,11 +1094,11 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: evtbd_ring: Allocating %d bytes\n",
 		    card->evtbd_ring_size);
-	card->evtbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+	card->evtbd_ring.vbase = dma_alloc_coherent(&card->dev->dev,
 						    card->evtbd_ring_size,
 						    &card->evtbd_ring_pbase,
 						    GFP_KERNEL);
-	if (!card->evtbd_ring_vbase) {
+	if (!card->evtbd_ring.vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate coherent memory (%d bytes) failed!\n",
 			    card->evtbd_ring_size);
@@ -1161,7 +1107,7 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_dbg(adapter, EVENT,
 		    "info: CMDRSP/EVT bd_ring - base: %p pbase: %#x:%x len: %#x\n",
-		    card->evtbd_ring_vbase, (u32)card->evtbd_ring_pbase,
+		    card->evtbd_ring.vbase, (u32)card->evtbd_ring_pbase,
 		    (u32)((u64)card->evtbd_ring_pbase >> 32),
 		    card->evtbd_ring_size);
 
@@ -1181,14 +1127,14 @@ static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter)
 
 	mwifiex_cleanup_evt_ring(adapter);
 
-	if (card->evtbd_ring_vbase)
+	if (card->evtbd_ring.vbase)
 		dma_free_coherent(&card->dev->dev, card->evtbd_ring_size,
-				  card->evtbd_ring_vbase,
+				  card->evtbd_ring.vbase,
 				  card->evtbd_ring_pbase);
 	card->evtbd_wrptr = 0;
 	card->evtbd_rdptr = 0 | reg->evt_rollover_ind;
 	card->evtbd_ring_size = 0;
-	card->evtbd_ring_vbase = NULL;
+	card->evtbd_ring.vbase = NULL;
 	card->evtbd_ring_pbase = 0;
 
 	return 0;
@@ -1377,10 +1323,10 @@ static int mwifiex_pcie_send_data_complete(struct mwifiex_adapter *adapter)
 		card->tx_buf_list[wrdoneidx] = NULL;
 
 		if (reg->pfu_enabled) {
-			desc2 = card->txbd_ring[wrdoneidx];
+			desc2 = &card->txbd_ring.pfu[wrdoneidx];
 			memset(desc2, 0, sizeof(*desc2));
 		} else {
-			desc = card->txbd_ring[wrdoneidx];
+			desc = &card->txbd_ring.pcie[wrdoneidx];
 			memset(desc, 0, sizeof(*desc));
 		}
 		switch (card->dev->device) {
@@ -1464,7 +1410,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 		atomic_inc(&adapter->tx_hw_pending);
 
 		if (reg->pfu_enabled) {
-			desc2 = card->txbd_ring[wrindx];
+			desc2 = &card->txbd_ring.pfu[wrindx];
 			desc2->paddr = buf_pa;
 			desc2->len = (u16)skb->len;
 			desc2->frag_len = (u16)skb->len;
@@ -1472,7 +1418,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 			desc2->flags = MWIFIEX_BD_FLAG_FIRST_DESC |
 					 MWIFIEX_BD_FLAG_LAST_DESC;
 		} else {
-			desc = card->txbd_ring[wrindx];
+			desc = &card->txbd_ring.pcie[wrindx];
 			desc->paddr = buf_pa;
 			desc->len = (u16)skb->len;
 			desc->flags = MWIFIEX_BD_FLAG_FIRST_DESC |
@@ -1648,14 +1594,14 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 		card->rx_buf_list[rd_index] = skb_tmp;
 
 		if (reg->pfu_enabled) {
-			desc2 = card->rxbd_ring[rd_index];
+			desc2 = &card->rxbd_ring.pfu[rd_index];
 			desc2->paddr = buf_pa;
 			desc2->len = skb_tmp->len;
 			desc2->frag_len = skb_tmp->len;
 			desc2->offset = 0;
 			desc2->flags = reg->ring_flag_sop | reg->ring_flag_eop;
 		} else {
-			desc = card->rxbd_ring[rd_index];
+			desc = &card->rxbd_ring.pcie[rd_index];
 			desc->paddr = buf_pa;
 			desc->len = skb_tmp->len;
 			desc->flags = 0;
@@ -2067,7 +2013,7 @@ static int mwifiex_pcie_process_event_ready(struct mwifiex_adapter *adapter)
 		/* Take the pointer and set it to event pointer in adapter
 		   and will return back after event handling callback */
 		card->evt_buf_list[rdptr] = NULL;
-		desc = card->evtbd_ring[rdptr];
+		desc = &card->evtbd_ring.evt[rdptr];
 		memset(desc, 0, sizeof(*desc));
 
 		event = get_unaligned_le32(
@@ -2145,7 +2091,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 					   DMA_FROM_DEVICE))
 			return -1;
 		card->evt_buf_list[rdptr] = skb;
-		desc = card->evtbd_ring[rdptr];
+		desc = &card->evtbd_ring.evt[rdptr];
 		desc->paddr = MWIFIEX_SKB_DMA_ADDR(skb);
 		desc->len = (u16)skb->len;
 		desc->flags = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.h b/drivers/net/wireless/marvell/mwifiex/pcie.h
index de901b3b59ad..67cef9d93260 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.h
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.h
@@ -194,25 +194,33 @@ struct pcie_service_card {
 	u32 txbd_wrptr;
 	u32 txbd_rdptr;
 	u32 txbd_ring_size;
-	u8 *txbd_ring_vbase;
 	dma_addr_t txbd_ring_pbase;
-	void *txbd_ring[MWIFIEX_MAX_TXRX_BD];
+	union {
+		struct mwifiex_pcie_buf_desc *pcie;
+		struct mwifiex_pfu_buf_desc *pfu;
+		void *vbase;
+	} txbd_ring;
 	struct sk_buff *tx_buf_list[MWIFIEX_MAX_TXRX_BD];
 
 	u32 rxbd_wrptr;
 	u32 rxbd_rdptr;
 	u32 rxbd_ring_size;
-	u8 *rxbd_ring_vbase;
 	dma_addr_t rxbd_ring_pbase;
-	void *rxbd_ring[MWIFIEX_MAX_TXRX_BD];
+	union {
+		struct mwifiex_pcie_buf_desc *pcie;
+		struct mwifiex_pfu_buf_desc *pfu;
+		void *vbase;
+	} rxbd_ring;
 	struct sk_buff *rx_buf_list[MWIFIEX_MAX_TXRX_BD];
 
 	u32 evtbd_wrptr;
 	u32 evtbd_rdptr;
 	u32 evtbd_ring_size;
-	u8 *evtbd_ring_vbase;
 	dma_addr_t evtbd_ring_pbase;
-	void *evtbd_ring[MWIFIEX_MAX_EVT_BD];
+	union {
+		struct mwifiex_evt_buf_desc *evt;
+		void *vbase;
+	} evtbd_ring;
 	struct sk_buff *evt_buf_list[MWIFIEX_MAX_EVT_BD];
 
 	struct sk_buff *cmd_buf;
-- 
2.41.0

