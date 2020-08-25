Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E525251186
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHYF3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgHYF3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC16C06179A
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hNLhmCZzA3kMm0PWgKq3to15Weq3r58v6thDmcsSwMo=; b=FwhtFuQd1DpMpkN6jGbBmmsBC3
        ghpikmsyG3tFpIbA6WN2Gi/qPQDmFg9Vku5vDl0UC49DfgO7tfR+HDebQACLGZtHnnDe9fbQHp/ph
        dMmUoHb8LdJj/SF/KKNa41XEmlZinsgz60Em8/Z0NvmLcSZM1t/KPgqx2icsHlCScBV0=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWB-0006jr-UH
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] mt76: mt7915: significantly reduce interrupt load
Date:   Tue, 25 Aug 2020 07:29:05 +0200
Message-Id: <20200825052909.36955-5-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c  |  6 ++----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c  |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 10 +++++++++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 34e90bb08f0a..bdc694609c01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -84,8 +84,6 @@ mt7915_tx_cleanup(struct mt7915_dev *dev)
 {
 	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
 	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU_WA, false);
-	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
-	mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
 }
 
 static int mt7915_poll_tx(struct napi_struct *napi, int budget)
@@ -97,7 +95,7 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 	mt7915_tx_cleanup(dev);
 
 	if (napi_complete_done(napi, 0))
-		mt7915_irq_enable(dev, MT_INT_TX_DONE_ALL);
+		mt7915_irq_enable(dev, MT_INT_TX_DONE_MCU);
 
 	return 0;
 }
@@ -242,7 +240,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
 
 	/* enable interrupts for TX/RX rings */
-	mt7915_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+	mt7915_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_MCU |
 			  MT_INT_MCU_CMD);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9c920c9f4d2b..22d12dd3a608 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -874,6 +874,10 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta = NULL;
 	u8 i, count;
 
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
+	mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
+
 	/*
 	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
 	 * to the time ack is received or dropped by hw (air + hw queue time).
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 91bff101664b..fe62b4d853e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -41,12 +41,12 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
 	mask = intr & MT_INT_RX_DONE_ALL;
-	if (intr & MT_INT_TX_DONE_ALL)
-		mask |= MT_INT_TX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
 
 	mt7915_irq_disable(dev, mask);
 
-	if (intr & MT_INT_TX_DONE_ALL)
+	if (intr & MT_INT_TX_DONE_MCU)
 		napi_schedule(&dev->mt76.tx_napi);
 
 	if (intr & MT_INT_RX_DONE_DATA)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index e0989141d9da..4b97b47c6b31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -313,9 +313,17 @@
 #define MT_INT_RX_DONE_WA		BIT(1)
 #define MT_INT_RX_DONE(_n)		((_n) ? BIT((_n) - 1) : BIT(16))
 #define MT_INT_RX_DONE_ALL		(BIT(0) | BIT(1) | BIT(16))
-#define MT_INT_TX_DONE_ALL		(BIT(15) | GENMASK(27, 26) | BIT(30))
+#define MT_INT_TX_DONE_MCU_WA		BIT(15)
+#define MT_INT_TX_DONE_FWDL		BIT(26)
+#define MT_INT_TX_DONE_MCU_WM		BIT(27)
+#define MT_INT_TX_DONE_BAND0		BIT(30)
+#define MT_INT_TX_DONE_BAND1		BIT(31)
 #define MT_INT_MCU_CMD			BIT(29)
 
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WA |	\
+					 MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
-- 
2.28.0

