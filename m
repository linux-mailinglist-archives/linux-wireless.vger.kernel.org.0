Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04C3A18E6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jun 2021 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFIPQD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Jun 2021 11:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhFIPQC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Jun 2021 11:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B841B60E0B;
        Wed,  9 Jun 2021 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251647;
        bh=F02YCRxZBTjIvd1BvzZ4xcAS4hUNYSlEeTxDGudoenA=;
        h=From:To:Cc:Subject:Date:From;
        b=VdYQPtGURvWT0Ekdy85+n7tzkpj32dyWlb2LVZ3V12OcRzvO2JMZHmPQXAZfcZrFV
         LMWjwr2xQu104G0rj2XH40Vt7tK5sUCaH7kuEW5bEA72PsPUPDC2+KVmCZlm7t4G37
         zcR5pDrZrgS0og4++2q6u97Xm8noEyuYB18O3p4IaOtt9jgXFAqcYm41QPAhBGs15G
         DoIhLJPagpNAskhGi/JIZEaQZ/ZXhRj2O6XofdARjtk42AVNRtVxjk2ObJ6S4Y7GlH
         KmhK9nENe2gzZP5t9KawymoQRbqRA2RfnU9ps4liokFJywv+OB8UuV/vbX6CU5uuYW
         uoh0r50PU0xQQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: reduce rx buffer size to 2048
Date:   Wed,  9 Jun 2021 17:13:58 +0200
Message-Id: <53e6938fa1b938a6c1753ed2bd3a5df4fb198482.1623251404.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce rx buffer size to 2048 for mt7921/mt7915/mt7615 since we
now support rx amsdu offload

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c |  9 ++-------
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c | 12 +++++-------
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c |  8 +++-----
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index b6184234cad2..00aefea1bf61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -222,14 +222,9 @@ void mt7615_dma_start(struct mt7615_dev *dev)
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int rx_ring_size = MT7615_RX_RING_SIZE;
-	int rx_buf_size = MT_RX_BUF_SIZE;
 	u32 mask;
 	int ret;
 
-	/* Increase buffer size to receive large VHT MPDUs */
-	if (dev->mphy.cap.has_5ghz)
-		rx_buf_size *= 2;
-
 	mt76_dma_attach(&dev->mt76);
 
 	mt76_wr(dev, MT_WPDMA_GLO_CFG,
@@ -270,7 +265,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	/* init rx queues */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU], 1,
-			       MT7615_RX_MCU_RING_SIZE, rx_buf_size,
+			       MT7615_RX_MCU_RING_SIZE, MT_RX_BUF_SIZE,
 			       MT_RX_RING_BASE);
 	if (ret)
 		return ret;
@@ -279,7 +274,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	    rx_ring_size /= 2;
 
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
-			       rx_ring_size, rx_buf_size, MT_RX_RING_BASE);
+			       rx_ring_size, MT_RX_BUF_SIZE, MT_RX_RING_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 69a7e3dce113..9182568f95c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -79,8 +79,6 @@ void mt7915_dma_prefetch(struct mt7915_dev *dev)
 
 int mt7915_dma_init(struct mt7915_dev *dev)
 {
-	/* Increase buffer size to receive large VHT/HE MPDUs */
-	int rx_buf_size = MT_RX_BUF_SIZE * 2;
 	u32 hif1_ofs = 0;
 	int ret;
 
@@ -144,28 +142,28 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	/* event from WM */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
 			       MT7915_RXQ_MCU_WM, MT7915_RX_MCU_RING_SIZE,
-			       rx_buf_size, MT_RX_EVENT_RING_BASE);
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* event from WA */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT7915_RXQ_MCU_WA, MT7915_RX_MCU_RING_SIZE,
-			       rx_buf_size, MT_RX_EVENT_RING_BASE);
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* rx data queue */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 			       MT7915_RXQ_BAND0, MT7915_RX_RING_SIZE,
-			       rx_buf_size, MT_RX_DATA_RING_BASE);
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
 	if (ret)
 		return ret;
 
 	if (dev->dbdc_support) {
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
 				       MT7915_RXQ_BAND1, MT7915_RX_RING_SIZE,
-				       rx_buf_size,
+				       MT_RX_BUF_SIZE,
 				       MT_RX_DATA_RING_BASE + hif1_ofs);
 		if (ret)
 			return ret;
@@ -174,7 +172,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
 				       MT7915_RXQ_MCU_WA_EXT,
 				       MT7915_RX_MCU_RING_SIZE,
-				       rx_buf_size,
+				       MT_RX_BUF_SIZE,
 				       MT_RX_EVENT_RING_BASE + hif1_ofs);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 5e745e9c2185..7d7d43a5422f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -380,9 +380,7 @@ int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
 
 int mt7921_dma_init(struct mt7921_dev *dev)
 {
-	/* Increase buffer size to receive large VHT/HE MPDUs */
 	struct mt76_bus_ops *bus_ops;
-	int rx_buf_size = MT_RX_BUF_SIZE * 2;
 	int ret;
 
 	dev->bus_ops = dev->mt76.bus;
@@ -430,7 +428,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
 			       MT7921_RXQ_MCU_WM,
 			       MT7921_RX_MCU_RING_SIZE,
-			       rx_buf_size, MT_RX_EVENT_RING_BASE);
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
 	if (ret)
 		return ret;
 
@@ -438,14 +436,14 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT7921_RXQ_MCU_WM,
 			       MT7921_RX_MCU_RING_SIZE,
-			       rx_buf_size, MT_WFDMA0(0x540));
+			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
 	if (ret)
 		return ret;
 
 	/* rx data */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
-			       rx_buf_size, MT_RX_DATA_RING_BASE);
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
 	if (ret)
 		return ret;
 
-- 
2.31.1

