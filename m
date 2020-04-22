Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A841B35B5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDVDqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37002 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kBzA5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kBzA5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:11 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 5/8] rtw88: 8723d: 11N chips don't support H2C queue
Date:   Wed, 22 Apr 2020 11:46:04 +0800
Message-ID: <20200422034607.28747-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

H2C queue is used to send command to firmware. Since 8723D doesn't support
this queue, this commit check wlan_cpu flag to avoid to set H2C related
registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c |  6 +++-
 drivers/net/wireless/realtek/rtw88/pci.c | 35 ++++++++++++++++--------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index ac5d35153c8a..f4a504b350cf 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1016,7 +1016,8 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 
 	rtw_write8(rtwdev, REG_CR, 0);
 	rtw_write8(rtwdev, REG_CR, MAC_TRX_ENABLE);
-	rtw_write32(rtwdev, REG_H2CQ_CSR, BIT_H2CQ_FULL);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		rtw_write32(rtwdev, REG_H2CQ_CSR, BIT_H2CQ_FULL);
 
 	return 0;
 }
@@ -1135,6 +1136,9 @@ static int init_h2c(struct rtw_dev *rtwdev)
 	u32 h2cq_free;
 	u32 wp, rp;
 
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return 0;
+
 	h2cq_addr = fifo->rsvd_h2cq_addr << TX_PAGE_SIZE_SHIFT;
 	h2cq_size = RSVD_PG_H2CQ_NUM << TX_PAGE_SIZE_SHIFT;
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index b3e76b579af9..8a8d746d3349 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -411,12 +411,14 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_BCN].r.dma;
 	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_BCNQ, dma);
 
-	len = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.len;
-	dma = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.dma;
-	rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.rp = 0;
-	rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.wp = 0;
-	rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_H2CQ, len & TRX_BD_IDX_MASK);
-	rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_H2CQ, dma);
+	if (!rtw_chip_wcpu_11n(rtwdev)) {
+		len = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.len;
+		dma = rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.dma;
+		rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.rp = 0;
+		rtwpci->tx_rings[RTW_TX_QUEUE_H2C].r.wp = 0;
+		rtw_write16(rtwdev, RTK_PCI_TXBD_NUM_H2CQ, len & TRX_BD_IDX_MASK);
+		rtw_write32(rtwdev, RTK_PCI_TXBD_DESA_H2CQ, dma);
+	}
 
 	len = rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.len;
 	dma = rtwpci->tx_rings[RTW_TX_QUEUE_BK].r.dma;
@@ -471,8 +473,9 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, RTK_PCI_TXBD_RWPTR_CLR, 0xffffffff);
 
 	/* reset H2C Queue index in a single write */
-	rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR,
-			BIT_CLR_H2CQ_HOST_IDX | BIT_CLR_H2CQ_HW_IDX);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR,
+				BIT_CLR_H2CQ_HOST_IDX | BIT_CLR_H2CQ_HW_IDX);
 }
 
 static void rtw_pci_reset_trx_ring(struct rtw_dev *rtwdev)
@@ -489,7 +492,9 @@ static void rtw_pci_enable_interrupt(struct rtw_dev *rtwdev,
 
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, rtwpci->irq_mask[0]);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, rtwpci->irq_mask[1]);
-	rtw_write32(rtwdev, RTK_PCI_HIMR3, rtwpci->irq_mask[3]);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		rtw_write32(rtwdev, RTK_PCI_HIMR3, rtwpci->irq_mask[3]);
+
 	rtwpci->irq_enabled = true;
 
 	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
@@ -507,7 +512,9 @@ static void rtw_pci_disable_interrupt(struct rtw_dev *rtwdev,
 
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, 0);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, 0);
-	rtw_write32(rtwdev, RTK_PCI_HIMR3, 0);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		rtw_write32(rtwdev, RTK_PCI_HIMR3, 0);
+
 	rtwpci->irq_enabled = false;
 
 out:
@@ -1012,13 +1019,17 @@ static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
 
 	irq_status[0] = rtw_read32(rtwdev, RTK_PCI_HISR0);
 	irq_status[1] = rtw_read32(rtwdev, RTK_PCI_HISR1);
-	irq_status[3] = rtw_read32(rtwdev, RTK_PCI_HISR3);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		irq_status[3] = rtw_read32(rtwdev, RTK_PCI_HISR3);
+	else
+		irq_status[3] = 0;
 	irq_status[0] &= rtwpci->irq_mask[0];
 	irq_status[1] &= rtwpci->irq_mask[1];
 	irq_status[3] &= rtwpci->irq_mask[3];
 	rtw_write32(rtwdev, RTK_PCI_HISR0, irq_status[0]);
 	rtw_write32(rtwdev, RTK_PCI_HISR1, irq_status[1]);
-	rtw_write32(rtwdev, RTK_PCI_HISR3, irq_status[3]);
+	if (rtw_chip_wcpu_11ac(rtwdev))
+		rtw_write32(rtwdev, RTK_PCI_HISR3, irq_status[3]);
 
 	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
 }
-- 
2.17.1

