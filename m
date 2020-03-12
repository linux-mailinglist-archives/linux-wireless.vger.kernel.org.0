Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8545F182A97
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCLIJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59243 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLIJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88tVK006441, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88tVK006441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:55 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:55 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 4/5] rtw88: pci: define a mask for TX/RX BD indexes
Date:   Thu, 12 Mar 2020 16:08:51 +0800
Message-ID: <20200312080852.16684-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312080852.16684-1-yhchuang@realtek.com>
References: <20200312080852.16684-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add a macro TRX_BD_IDX_MASK for access the TX/RX BD indexes.

The hardware has only 12 bits for TX/RX BD indexes, we should not
initialize a TX/RX ring or access the TX/RX BD index with a length
that is larger than TRX_BD_IDX_MASK.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 32 ++++++++++++++++--------
 drivers/net/wireless/realtek/rtw88/pci.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index c0fd579d9551..812944a7b4bd 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -186,6 +186,11 @@ static int rtw_pci_init_tx_ring(struct rtw_dev *rtwdev,
 	dma_addr_t dma;
 	u8 *head;
 
+	if (len > TRX_BD_IDX_MASK) {
+		rtw_err(rtwdev, "len %d exceeds maximum TX entries\n", len);
+		return -EINVAL;
+	}
+
 	head = pci_zalloc_consistent(pdev, ring_sz, &dma);
 	if (!head) {
 		rtw_err(rtwdev, "failed to allocate tx ring\n");
@@ -259,6 +264,11 @@ static int rtw_pci_init_rx_ring(struct rtw_dev *rtwdev,
 	int i, allocated;
 	int ret = 0;
 
+	if (len > TRX_BD_IDX_MASK) {
+		rtw_err(rtwdev, "len %d exceeds maximum RX entries\n", len);
+		return -EINVAL;
+	}
+
 	head = pci_zalloc_consistent(pdev, ring_sz, &dma);
 	if (!head) {
 		rtw_err(rtwdev, "failed to allocate rx ring\n");
@@ -405,56 +415,56 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_H2CQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_H2CQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_H2CQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_BKQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_BKQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_BKQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_BE].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_BE].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_BE].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_BE].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_BEQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_BEQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_BEQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_VO].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_VO].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_VO].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_VO].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_VOQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_VOQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_VOQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_VI].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_VI].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_VI].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_VI].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_VIQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_VIQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_VIQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_MGMT].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_MGMT].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_MGMT].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_MGMT].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_MGMTQ, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_MGMTQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_MGMTQ, dma);
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_HI0].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_HI0].r.dma;
 	rtwpci->tx_rings[RTW_TX_QUEUE_HI0].r.rp = 0;
 	rtwpci->tx_rings[RTW_TX_QUEUE_HI0].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_HI0Q, len);
+	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_HI0Q, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_HI0Q, dma);
 
 	len = rtwpci->rx_rings[RTW_RX_QUEUE_MPDU].r.len;
 	dma = rtwpci->rx_rings[RTW_RX_QUEUE_MPDU].r.dma;
 	rtwpci->rx_rings[RTW_RX_QUEUE_MPDU].r.rp = 0;
 	rtwpci->rx_rings[RTW_RX_QUEUE_MPDU].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_RXBD_NUM_MPDUQ, len & 0xfff);
+	rtw_write16(rtwdev, RTK_PCI_RXBD_NUM_MPDUQ, len & TRX_BD_IDX_MASK);
 	rtw_write32(rtwdev, RTK_PCI_RXBD_DESA_MPDUQ, dma);
 
 	/* reset read/write point */
@@ -743,7 +753,7 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 		if (++ring->r.wp >= ring->r.len)
 			ring->r.wp = 0;
 		bd_idx = rtw_pci_tx_queue_idx_addr[queue];
-		rtw_write16(rtwdev, bd_idx, ring->r.wp & 0xfff);
+		rtw_write16(rtwdev, bd_idx, ring->r.wp & TRX_BD_IDX_MASK);
 	} else {
 		u32 reg_bcn_work;
 
@@ -821,7 +831,7 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 	bd_idx_addr = rtw_pci_tx_queue_idx_addr[hw_queue];
 	bd_idx = rtw_read32(rtwdev, bd_idx_addr);
 	cur_rp = bd_idx >> 16;
-	cur_rp &= 0xfff;
+	cur_rp &= TRX_BD_IDX_MASK;
 	if (cur_rp >= ring->r.rp)
 		count = cur_rp - ring->r.rp;
 	else
@@ -895,7 +905,7 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 
 	tmp = rtw_read32(rtwdev, RTK_PCI_RXBD_IDX_MPDUQ);
 	cur_wp = tmp >> 16;
-	cur_wp &= 0xfff;
+	cur_wp &= TRX_BD_IDX_MASK;
 	if (cur_wp >= ring->r.wp)
 		count = cur_wp - ring->r.wp;
 	else
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index b60a359febe6..67b5e2fe2b62 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -52,6 +52,8 @@
 #define RTK_PCI_TXBD_DESA_HI0Q	0x340
 #define RTK_PCI_RXBD_DESA_MPDUQ	0x338
 
+#define TRX_BD_IDX_MASK		GENMASK(11, 0)
+
 /* BCNQ is specialized for rsvd page, does not need to specify a number */
 #define RTK_PCI_TXBD_NUM_H2CQ	0x1328
 #define RTK_PCI_TXBD_NUM_MGMTQ	0x380
-- 
2.17.1

