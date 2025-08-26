Return-Path: <linux-wireless+bounces-26619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC7B357B0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899001B65BB9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02028371;
	Tue, 26 Aug 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="a7ctN7Dn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BF9460
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198446; cv=none; b=dCWCEQoC2W1VsoQkY6FaaX/3DeGhPV0asVxck2M2Dxyg3J9Wj+XJmSxarT66armmUpUNPTvaVqe7JQctd1mgVCbzzOqpt5IGQNtZydBVAdQGmwyYk/WRce5zPNk0v0dBrd5+t7kEgdZPXov9s3e4xGWHiIruhZ7W5MhWS16unyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198446; c=relaxed/simple;
	bh=JW4Era4Z0hBjyoUPnGADZ2jD5brlIS2uR7xd6oFvj8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZOoJBvB1ioa9t2Af4weCSUEdJMVyeXzl+iu/S4mc7onRkL3Yj0N9mhrkn/QfeEm3/I+FNvWlkIE8KPdXQh6gUNz0kml1Did5KpSI/TcKEqrqbXhhJbIxaibXHKL9PoyiEDD+O1rYpSYWuM9dNWdDe17qnos2z9ZE0xsiw7rN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=a7ctN7Dn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8s1fgD1262242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198441; bh=yL2OqWrsw6jhoL5Fm1lB6EcKMSJ7PF1yabk0+XSl6V4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=a7ctN7DnUHu83zI0geABD2Rk71CbbfzR0gwOnJAvZLqik8dYzBptu/fzudoyKRIrE
	 rsihXplD6+jyCQnf1JLT6Ff72XSCbsx7TNgXFzmQkQ8yY/i5NgA1cB4Llw9y88CVV1
	 azwU1Gga1Ds+BxgRLxTA48BUpAPrGmC7mqYsLlF7PJfVbQ9W5kgiPJGLUsw7OyXAiH
	 YPMjYMG2i7Fl+sPpR4WZerB7OPXRcruAKIJOIKzXv2hHiFknX0TXE+qGqFr/gzMFxa
	 dopLyof4BcOJjh7He63OLQCA+MYWEJpag/cVvQyG8GapHyuAVSESKQx4VcNeTDvv1l
	 8eIOGYHe3NhtQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8s1fgD1262242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:54:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:54:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:54:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: pci: define TX/RX buffer descriptor pool
Date: Tue, 26 Aug 2025 16:52:58 +0800
Message-ID: <20250826085258.28308-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826085152.28164-1-pkshih@realtek.com>
References: <20250826085152.28164-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Buffer descriptor (BD) is a helper of DMA for each ring. The new hardware
design expects a continual memory across all rings, so allocate a pool
and assign to each ring rather than allocate a buffer for a ring
individually.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 115 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/pci.h |   8 ++
 2 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index d4677df35861..d4f78396dfde 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3249,15 +3249,6 @@ static void rtw89_pci_free_tx_ring(struct rtw89_dev *rtwdev,
 				   struct pci_dev *pdev,
 				   struct rtw89_pci_tx_ring *tx_ring)
 {
-	int ring_sz;
-	u8 *head;
-	dma_addr_t dma;
-
-	head = tx_ring->bd_ring.head;
-	dma = tx_ring->bd_ring.dma;
-	ring_sz = tx_ring->bd_ring.desc_size * tx_ring->bd_ring.len;
-	dma_free_coherent(&pdev->dev, ring_sz, head, dma);
-
 	tx_ring->bd_ring.head = NULL;
 }
 
@@ -3265,6 +3256,7 @@ static void rtw89_pci_free_tx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_dma_pool *bd_pool = &rtwpci->tx.bd_pool;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_pci_tx_ring *tx_ring;
 	int i;
@@ -3276,6 +3268,8 @@ static void rtw89_pci_free_tx_rings(struct rtw89_dev *rtwdev,
 		rtw89_pci_free_tx_wd_ring(rtwdev, pdev, tx_ring);
 		rtw89_pci_free_tx_ring(rtwdev, pdev, tx_ring);
 	}
+
+	dma_free_coherent(&pdev->dev, bd_pool->size, bd_pool->head, bd_pool->dma);
 }
 
 static void rtw89_pci_free_rx_ring(struct rtw89_dev *rtwdev,
@@ -3286,8 +3280,6 @@ static void rtw89_pci_free_rx_ring(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	dma_addr_t dma;
 	u32 buf_sz;
-	u8 *head;
-	int ring_sz = rx_ring->bd_ring.desc_size * rx_ring->bd_ring.len;
 	int i;
 
 	buf_sz = rx_ring->buf_sz;
@@ -3303,10 +3295,6 @@ static void rtw89_pci_free_rx_ring(struct rtw89_dev *rtwdev,
 		rx_ring->buf[i] = NULL;
 	}
 
-	head = rx_ring->bd_ring.head;
-	dma = rx_ring->bd_ring.dma;
-	dma_free_coherent(&pdev->dev, ring_sz, head, dma);
-
 	rx_ring->bd_ring.head = NULL;
 }
 
@@ -3314,6 +3302,7 @@ static void rtw89_pci_free_rx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_dma_pool *bd_pool = &rtwpci->rx.bd_pool;
 	struct rtw89_pci_rx_ring *rx_ring;
 	int i;
 
@@ -3321,6 +3310,8 @@ static void rtw89_pci_free_rx_rings(struct rtw89_dev *rtwdev,
 		rx_ring = &rtwpci->rx.rings[i];
 		rtw89_pci_free_rx_ring(rtwdev, pdev, rx_ring);
 	}
+
+	dma_free_coherent(&pdev->dev, bd_pool->size, bd_pool->head, bd_pool->dma);
 }
 
 static void rtw89_pci_free_trx_rings(struct rtw89_dev *rtwdev,
@@ -3412,12 +3403,10 @@ static int rtw89_pci_alloc_tx_ring(struct rtw89_dev *rtwdev,
 				   struct pci_dev *pdev,
 				   struct rtw89_pci_tx_ring *tx_ring,
 				   u32 desc_size, u32 len,
-				   enum rtw89_tx_channel txch)
+				   enum rtw89_tx_channel txch,
+				   void *head, dma_addr_t dma)
 {
 	const struct rtw89_pci_ch_dma_addr *txch_addr;
-	int ring_sz = desc_size * len;
-	u8 *head;
-	dma_addr_t dma;
 	int ret;
 
 	ret = rtw89_pci_alloc_tx_wd_ring(rtwdev, pdev, tx_ring, txch);
@@ -3432,12 +3421,6 @@ static int rtw89_pci_alloc_tx_ring(struct rtw89_dev *rtwdev,
 		goto err_free_wd_ring;
 	}
 
-	head = dma_alloc_coherent(&pdev->dev, ring_sz, &dma, GFP_KERNEL);
-	if (!head) {
-		ret = -ENOMEM;
-		goto err_free_wd_ring;
-	}
-
 	INIT_LIST_HEAD(&tx_ring->busy_pages);
 	tx_ring->bd_ring.head = head;
 	tx_ring->bd_ring.dma = dma;
@@ -3460,25 +3443,48 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_dma_pool *bd_pool = &rtwpci->tx.bd_pool;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_pci_tx_ring *tx_ring;
+	u32 i, tx_allocated;
+	dma_addr_t dma;
 	u32 desc_size;
+	u32 ring_sz;
+	u32 pool_sz;
+	u32 ch_num;
+	void *head;
 	u32 len;
-	u32 i, tx_allocated;
 	int ret;
 
+	BUILD_BUG_ON(RTW89_PCI_TXBD_NUM_MAX % 16);
+
+	desc_size = sizeof(struct rtw89_pci_tx_bd_32);
+	len = RTW89_PCI_TXBD_NUM_MAX;
+	ch_num = RTW89_TXCH_NUM - hweight32(info->tx_dma_ch_mask);
+	ring_sz = desc_size * len;
+	pool_sz = ring_sz * ch_num;
+
+	head = dma_alloc_coherent(&pdev->dev, pool_sz, &dma, GFP_KERNEL);
+	if (!head)
+		return -ENOMEM;
+
+	bd_pool->head = head;
+	bd_pool->dma = dma;
+	bd_pool->size = pool_sz;
+
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
 		if (info->tx_dma_ch_mask & BIT(i))
 			continue;
 		tx_ring = &rtwpci->tx.rings[i];
-		desc_size = sizeof(struct rtw89_pci_tx_bd_32);
-		len = RTW89_PCI_TXBD_NUM_MAX;
 		ret = rtw89_pci_alloc_tx_ring(rtwdev, pdev, tx_ring,
-					      desc_size, len, i);
+					      desc_size, len, i, head, dma);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to alloc tx ring %d\n", i);
 			goto err_free;
 		}
+
+		head += ring_sz;
+		dma += ring_sz;
 	}
 
 	return 0;
@@ -3490,20 +3496,20 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 		rtw89_pci_free_tx_ring(rtwdev, pdev, tx_ring);
 	}
 
+	dma_free_coherent(&pdev->dev, bd_pool->size, bd_pool->head, bd_pool->dma);
+
 	return ret;
 }
 
 static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 				   struct pci_dev *pdev,
 				   struct rtw89_pci_rx_ring *rx_ring,
-				   u32 desc_size, u32 len, u32 rxch)
+				   u32 desc_size, u32 len, u32 rxch,
+				   void *head, dma_addr_t dma)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	const struct rtw89_pci_ch_dma_addr *rxch_addr;
 	struct sk_buff *skb;
-	u8 *head;
-	dma_addr_t dma;
-	int ring_sz = desc_size * len;
 	int buf_sz = RTW89_PCI_RX_BUF_SIZE;
 	int i, allocated;
 	int ret;
@@ -3514,12 +3520,6 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	head = dma_alloc_coherent(&pdev->dev, ring_sz, &dma, GFP_KERNEL);
-	if (!head) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	rx_ring->bd_ring.head = head;
 	rx_ring->bd_ring.dma = dma;
 	rx_ring->bd_ring.len = len;
@@ -3568,12 +3568,8 @@ static int rtw89_pci_alloc_rx_ring(struct rtw89_dev *rtwdev,
 		rx_ring->buf[i] = NULL;
 	}
 
-	head = rx_ring->bd_ring.head;
-	dma = rx_ring->bd_ring.dma;
-	dma_free_coherent(&pdev->dev, ring_sz, head, dma);
-
 	rx_ring->bd_ring.head = NULL;
-err:
+
 	return ret;
 }
 
@@ -3581,22 +3577,43 @@ static int rtw89_pci_alloc_rx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_dma_pool *bd_pool = &rtwpci->rx.bd_pool;
 	struct rtw89_pci_rx_ring *rx_ring;
+	int i, rx_allocated;
+	dma_addr_t dma;
 	u32 desc_size;
+	u32 ring_sz;
+	u32 pool_sz;
+	void *head;
 	u32 len;
-	int i, rx_allocated;
 	int ret;
 
+	desc_size = sizeof(struct rtw89_pci_rx_bd_32);
+	len = RTW89_PCI_RXBD_NUM_MAX;
+	ring_sz = desc_size * len;
+	pool_sz = ring_sz * RTW89_RXCH_NUM;
+
+	head = dma_alloc_coherent(&pdev->dev, pool_sz, &dma, GFP_KERNEL);
+	if (!head)
+		return -ENOMEM;
+
+	bd_pool->head = head;
+	bd_pool->dma = dma;
+	bd_pool->size = pool_sz;
+
 	for (i = 0; i < RTW89_RXCH_NUM; i++) {
 		rx_ring = &rtwpci->rx.rings[i];
-		desc_size = sizeof(struct rtw89_pci_rx_bd_32);
-		len = RTW89_PCI_RXBD_NUM_MAX;
+
 		ret = rtw89_pci_alloc_rx_ring(rtwdev, pdev, rx_ring,
-					      desc_size, len, i);
+					      desc_size, len, i,
+					      head, dma);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to alloc rx ring %d\n", i);
 			goto err_free;
 		}
+
+		head += ring_sz;
+		dma += ring_sz;
 	}
 
 	return 0;
@@ -3608,6 +3625,8 @@ static int rtw89_pci_alloc_rx_rings(struct rtw89_dev *rtwdev,
 		rtw89_pci_free_rx_ring(rtwdev, pdev, rx_ring);
 	}
 
+	dma_free_coherent(&pdev->dev, bd_pool->size, bd_pool->head, bd_pool->dma);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 3156b4f9ebfc..f00d717b668b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1495,6 +1495,12 @@ struct rtw89_pci_dma_ring {
 	u32 rp; /* hw idx */
 };
 
+struct rtw89_pci_dma_pool {
+	void *head;
+	dma_addr_t dma;
+	u32 size;
+};
+
 struct rtw89_pci_tx_wd_ring {
 	void *head;
 	dma_addr_t dma;
@@ -1526,6 +1532,7 @@ struct rtw89_pci_tx_ring {
 
 struct rtw89_pci_tx_rings {
 	struct rtw89_pci_tx_ring rings[RTW89_TXCH_NUM];
+	struct rtw89_pci_dma_pool bd_pool;
 };
 
 struct rtw89_pci_rx_ring {
@@ -1539,6 +1546,7 @@ struct rtw89_pci_rx_ring {
 
 struct rtw89_pci_rx_rings {
 	struct rtw89_pci_rx_ring rings[RTW89_RXCH_NUM];
+	struct rtw89_pci_dma_pool bd_pool;
 };
 
 struct rtw89_pci_isrs {
-- 
2.25.1


