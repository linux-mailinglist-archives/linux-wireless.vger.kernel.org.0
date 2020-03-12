Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40DA182A96
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCLIJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:09:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59241 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLIJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:09:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02C88sBu006400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02C88sBu006400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 16:08:54 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Mar 2020 16:08:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 1/5] rtw88: don't hold all IRQs disabled for PS operations
Date:   Thu, 12 Mar 2020 16:08:48 +0800
Message-ID: <20200312080852.16684-2-yhchuang@realtek.com>
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

From: Brian Norris <briannorris@chromium.org>

This driver generally only needs to ensure that
(a) it doesn't try to process TX interrupts at the same time as
    power-save operations (and similar)
(b) the device interrupt gets disabled while we're still handling the
    last set of interrupts

For (a), all the operations (e.g., PS transitions, packet handling)
happens in non-atomic contexts (e.g., threaded IRQ).

For (b), we only need mutual exclusion for brief sections (i.e., while
we're actually manipulating the interrupt mask/status).

So, we can introduce a separate lock for handling (b), disabling IRQs
while we do it. For (a), we can demote the locking to BH only, now that
(b) (the only steps done in atomic context) and that has its own lock.

This helps reduce the amount of time this driver spends with IRQs off.
Notably, transitioning out of power-save modes can take >3 milliseconds,
and this transition is done under the protection of 'irq_lock'.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 54 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw88/pci.h |  4 +-
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 7c525bb0337d..b1f14d1fa2b3 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -382,6 +382,7 @@ static int rtw_pci_init(struct rtw_dev *rtwdev)
 	rtwpci->irq_mask[3] = IMR_H2CDOK |
 			      0;
 	spin_lock_init(&rtwpci->irq_lock);
+	spin_lock_init(&rtwpci->hwirq_lock);
 	ret = rtw_pci_init_trx_ring(rtwdev);
 
 	return ret;
@@ -472,19 +473,35 @@ static void rtw_pci_reset_trx_ring(struct rtw_dev *rtwdev)
 static void rtw_pci_enable_interrupt(struct rtw_dev *rtwdev,
 				     struct rtw_pci *rtwpci)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->hwirq_lock, flags);
+
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, rtwpci->irq_mask[0]);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, rtwpci->irq_mask[1]);
 	rtw_write32(rtwdev, RTK_PCI_HIMR3, rtwpci->irq_mask[3]);
 	rtwpci->irq_enabled = true;
+
+	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
 }
 
 static void rtw_pci_disable_interrupt(struct rtw_dev *rtwdev,
 				      struct rtw_pci *rtwpci)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->hwirq_lock, flags);
+
+	if (!rtwpci->irq_enabled)
+		goto out;
+
 	rtw_write32(rtwdev, RTK_PCI_HIMR0, 0);
 	rtw_write32(rtwdev, RTK_PCI_HIMR1, 0);
 	rtw_write32(rtwdev, RTK_PCI_HIMR3, 0);
 	rtwpci->irq_enabled = false;
+
+out:
+	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
 }
 
 static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
@@ -520,11 +537,10 @@ static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 static int rtw_pci_start(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	spin_lock_bh(&rtwpci->irq_lock);
 	rtw_pci_enable_interrupt(rtwdev, rtwpci);
-	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return 0;
 }
@@ -532,12 +548,11 @@ static int rtw_pci_start(struct rtw_dev *rtwdev)
 static void rtw_pci_stop(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	spin_lock_bh(&rtwpci->irq_lock);
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_dma_release(rtwdev, rtwpci);
-	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	spin_unlock_bh(&rtwpci->irq_lock);
 }
 
 static void rtw_pci_deep_ps_enter(struct rtw_dev *rtwdev)
@@ -590,9 +605,8 @@ static void rtw_pci_deep_ps_leave(struct rtw_dev *rtwdev)
 static void rtw_pci_deep_ps(struct rtw_dev *rtwdev, bool enter)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	spin_lock_bh(&rtwpci->irq_lock);
 
 	if (enter && !test_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags))
 		rtw_pci_deep_ps_enter(rtwdev);
@@ -600,7 +614,7 @@ static void rtw_pci_deep_ps(struct rtw_dev *rtwdev, bool enter)
 	if (!enter && test_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags))
 		rtw_pci_deep_ps_leave(rtwdev);
 
-	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	spin_unlock_bh(&rtwpci->irq_lock);
 }
 
 static u8 ac_to_hwq[] = {
@@ -683,7 +697,6 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 	u8 *pkt_desc;
 	struct rtw_pci_tx_buffer_desc *buf_desc;
 	u32 bd_idx;
-	unsigned long flags;
 
 	ring = &rtwpci->tx_rings[queue];
 
@@ -720,7 +733,7 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 	tx_data->dma = dma;
 	tx_data->sn = pkt_info->sn;
 
-	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	spin_lock_bh(&rtwpci->irq_lock);
 
 	rtw_pci_deep_ps_leave(rtwdev);
 	skb_queue_tail(&ring->queue, skb);
@@ -738,7 +751,7 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 		reg_bcn_work |= BIT_PCI_BCNQ_FLAG;
 		rtw_write8(rtwdev, RTK_PCI_TXBD_BCN_WORK, reg_bcn_work);
 	}
-	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return 0;
 }
@@ -961,6 +974,10 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
 				   struct rtw_pci *rtwpci, u32 *irq_status)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->hwirq_lock, flags);
+
 	irq_status[0] = rtw_read32(rtwdev, RTK_PCI_HISR0);
 	irq_status[1] = rtw_read32(rtwdev, RTK_PCI_HISR1);
 	irq_status[3] = rtw_read32(rtwdev, RTK_PCI_HISR3);
@@ -970,6 +987,8 @@ static void rtw_pci_irq_recognized(struct rtw_dev *rtwdev,
 	rtw_write32(rtwdev, RTK_PCI_HISR0, irq_status[0]);
 	rtw_write32(rtwdev, RTK_PCI_HISR1, irq_status[1]);
 	rtw_write32(rtwdev, RTK_PCI_HISR3, irq_status[3]);
+
+	spin_unlock_irqrestore(&rtwpci->hwirq_lock, flags);
 }
 
 static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
@@ -977,10 +996,6 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	struct rtw_dev *rtwdev = dev;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 
-	spin_lock(&rtwpci->irq_lock);
-	if (!rtwpci->irq_enabled)
-		goto out;
-
 	/* disable RTW PCI interrupt to avoid more interrupts before the end of
 	 * thread function
 	 *
@@ -990,8 +1005,6 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	 * a new HISR flag is set.
 	 */
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
-out:
-	spin_unlock(&rtwpci->irq_lock);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -1000,10 +1013,9 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 {
 	struct rtw_dev *rtwdev = dev;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	unsigned long flags;
 	u32 irq_status[4];
 
-	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	spin_lock_bh(&rtwpci->irq_lock);
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -1025,7 +1037,7 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 
 	/* all of the jobs for this interrupt have been done */
 	rtw_pci_enable_interrupt(rtwdev, rtwpci);
-	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+	spin_unlock_bh(&rtwpci->irq_lock);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index cd4fcd064cdb..b60a359febe6 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -198,7 +198,9 @@ struct rtw_pci_rx_ring {
 struct rtw_pci {
 	struct pci_dev *pdev;
 
-	/* used for pci interrupt */
+	/* Used for PCI interrupt. */
+	spinlock_t hwirq_lock;
+	/* Used for PCI TX queueing. */
 	spinlock_t irq_lock;
 	u32 irq_mask[4];
 	bool irq_enabled;
-- 
2.17.1

