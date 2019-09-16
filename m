Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B597B3505
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfIPHD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:03:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60334 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfIPHD6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:03:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73q95029967, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73q95029967
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:53 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:52 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 04/15] rtw88: pci: extract skbs free routine for trx rings
Date:   Mon, 16 Sep 2019 15:03:34 +0800
Message-ID: <1568617425-28062-5-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

These skbs free routines could be used when driver wants
to stop PCI bus, because some of the skbs remained in the
queue may not have been returned via DMA interrupt.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 36 +++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 9cc068a..3238161 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -90,16 +90,13 @@ static inline void *rtw_pci_get_tx_desc(struct rtw_pci_tx_ring *tx_ring, u8 idx)
 	return tx_ring->r.head + offset;
 }
 
-static void rtw_pci_free_tx_ring(struct rtw_dev *rtwdev,
-				 struct rtw_pci_tx_ring *tx_ring)
+static void rtw_pci_free_tx_ring_skbs(struct rtw_dev *rtwdev,
+				      struct rtw_pci_tx_ring *tx_ring)
 {
 	struct pci_dev *pdev = to_pci_dev(rtwdev->dev);
 	struct rtw_pci_tx_data *tx_data;
 	struct sk_buff *skb, *tmp;
 	dma_addr_t dma;
-	u8 *head = tx_ring->r.head;
-	u32 len = tx_ring->r.len;
-	int ring_sz = len * tx_ring->r.desc_size;
 
 	/* free every skb remained in tx list */
 	skb_queue_walk_safe(&tx_ring->queue, skb, tmp) {
@@ -110,21 +107,30 @@ static void rtw_pci_free_tx_ring(struct rtw_dev *rtwdev,
 		pci_unmap_single(pdev, dma, skb->len, PCI_DMA_TODEVICE);
 		dev_kfree_skb_any(skb);
 	}
+}
+
+static void rtw_pci_free_tx_ring(struct rtw_dev *rtwdev,
+				 struct rtw_pci_tx_ring *tx_ring)
+{
+	struct pci_dev *pdev = to_pci_dev(rtwdev->dev);
+	u8 *head = tx_ring->r.head;
+	u32 len = tx_ring->r.len;
+	int ring_sz = len * tx_ring->r.desc_size;
+
+	rtw_pci_free_tx_ring_skbs(rtwdev, tx_ring);
 
 	/* free the ring itself */
 	pci_free_consistent(pdev, ring_sz, head, tx_ring->r.dma);
 	tx_ring->r.head = NULL;
 }
 
-static void rtw_pci_free_rx_ring(struct rtw_dev *rtwdev,
-				 struct rtw_pci_rx_ring *rx_ring)
+static void rtw_pci_free_rx_ring_skbs(struct rtw_dev *rtwdev,
+				      struct rtw_pci_rx_ring *rx_ring)
 {
 	struct pci_dev *pdev = to_pci_dev(rtwdev->dev);
 	struct sk_buff *skb;
-	dma_addr_t dma;
-	u8 *head = rx_ring->r.head;
 	int buf_sz = RTK_PCI_RX_BUF_SIZE;
-	int ring_sz = rx_ring->r.desc_size * rx_ring->r.len;
+	dma_addr_t dma;
 	int i;
 
 	for (i = 0; i < rx_ring->r.len; i++) {
@@ -137,6 +143,16 @@ static void rtw_pci_free_rx_ring(struct rtw_dev *rtwdev,
 		dev_kfree_skb(skb);
 		rx_ring->buf[i] = NULL;
 	}
+}
+
+static void rtw_pci_free_rx_ring(struct rtw_dev *rtwdev,
+				 struct rtw_pci_rx_ring *rx_ring)
+{
+	struct pci_dev *pdev = to_pci_dev(rtwdev->dev);
+	u8 *head = rx_ring->r.head;
+	int ring_sz = rx_ring->r.desc_size * rx_ring->r.len;
+
+	rtw_pci_free_rx_ring_skbs(rtwdev, rx_ring);
 
 	pci_free_consistent(pdev, ring_sz, head, rx_ring->r.dma);
 }
-- 
2.7.4

