Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D3251187
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHYF30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgHYF3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A2C061798
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oTlMHVJTCGDIdsFY9l+qPDvYKh3D2w670EcotbAbM7s=; b=WrwbczPTmatyBWHsDdMcNn9ZX1
        KAy0L7LHyBQ6HyzJJyBODPw0gPqKoBrrTLqhx8nSyEaRm9QTEbeArrHsWzoai4uHpblCx/zkSa4b4
        uVfAz7TOXfjtx5f4Nm1mRrNcVL+8qlEX05IuNUscHH0cfgevsMD+pdcCcwGMPM/VQTCY=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWC-0006jr-7w
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/9] mt76: mt7615: significantly reduce interrupt load
Date:   Tue, 25 Aug 2020 07:29:06 +0200
Message-Id: <20200825052909.36955-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7615 and newer, DMA completion only triggers unmap, but not free of queued
skbs, since pointers to packets are queued internally.
Because of that, there is no need to process the main data queue immediately
on DMA completion.
To improve performance, mask out the DMA data queue completion interrupt and
process the queue only when we receive a txfree event.
This brings the number of interrupts under load down to a small fraction.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 24 +++----------------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  8 +++++++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  8 +++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 ++++
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 3b375fdf31b8..abb83d4e7712 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -94,34 +94,16 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	return 0;
 }
 
-static void
-mt7615_tx_cleanup(struct mt7615_dev *dev)
-{
-	int i;
-
-	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
-	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
-	if (is_mt7615(&dev->mt76)) {
-		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
-	} else {
-		for (i = 0; i < IEEE80211_NUM_ACS; i++)
-			mt76_queue_tx_cleanup(dev, i, false);
-	}
-}
-
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7615_dev *dev;
 
 	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
 
-	mt7615_tx_cleanup(dev);
-
-	mt7615_pm_power_save_sched(dev);
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
 
 	if (napi_complete_done(napi, 0))
-		mt7615_irq_enable(dev, MT_INT_TX_DONE_ALL);
+		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
 
 	return 0;
 }
@@ -305,7 +287,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		 MT_WPDMA_GLO_CFG_RX_DMA_EN);
 
 	/* enable interrupts for TX/RX rings */
-	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | mt7615_tx_mcu_int_mask(dev) |
 			       MT_INT_MCU_CMD);
 
 	if (is_mt7622(&dev->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e4aeba17da67..9b8fbf26cd1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1424,6 +1424,14 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
 	u8 i, count;
 
+	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
+	if (is_mt7615(&dev->mt76)) {
+		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
+	} else {
+		for (i = 0; i < IEEE80211_NUM_ACS; i++)
+			mt76_queue_tx_cleanup(dev, i, false);
+	}
+
 	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
 	if (is_mt7615(&dev->mt76)) {
 		__le16 *token = &free->token[0];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 99ece641bdef..6de492a4cf02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -101,7 +101,7 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 static void mt7615_irq_tasklet(unsigned long data)
 {
 	struct mt7615_dev *dev = (struct mt7615_dev *)data;
-	u32 intr, mask = 0;
+	u32 intr, mask = 0, tx_mcu_mask = mt7615_tx_mcu_int_mask(dev);
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
@@ -112,11 +112,11 @@ static void mt7615_irq_tasklet(unsigned long data)
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
 	mask |= intr & MT_INT_RX_DONE_ALL;
-	if (intr & MT_INT_TX_DONE_ALL)
-		mask |= MT_INT_TX_DONE_ALL;
+	if (intr & tx_mcu_mask)
+		mask |= tx_mcu_mask;
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 
-	if (intr & MT_INT_TX_DONE_ALL)
+	if (intr & tx_mcu_mask)
 		napi_schedule(&dev->mt76.tx_napi);
 
 	if (intr & MT_INT_RX_DONE(0))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 7567485256f8..bcd09cc52ce8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -540,6 +540,11 @@ static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
 	return lmac_queue_map[ac];
 }
 
+static inline u32 mt7615_tx_mcu_int_mask(struct mt7615_dev *dev)
+{
+	return MT_INT_TX_DONE(dev->mt76.q_tx[MT_TXQ_MCU].q->hw_idx);
+}
+
 void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_roc_work(struct work_struct *work);
-- 
2.28.0

