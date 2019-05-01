Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48550108C4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfEAOGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfEAOGf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:06:35 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D7A21743;
        Wed,  1 May 2019 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556719594;
        bh=6GX7v7/QsbdqdUMosA0N0lZ4+59+x84xLBID8hIHyrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI7tZfMSIKOj5W5cRHnLD/HHDggCWkyleJNr6Q+jENH7EIhFxfEXVC66Ugav09ZZ6
         KOnr61zPtP2iwdLpYXSAH0nI1xsHzM4Uwf5bhkoKqeXrW5QlSQMe+eIBxiyht9brP2
         k/J7VVfIosGwjpmki+hfEGWSw702C32kOz+Sl37k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 3/4] mt76: mt7615: use napi polling for tx cleanup
Date:   Wed,  1 May 2019 16:06:22 +0200
Message-Id: <488b198a0efdeebe3d7696f6e4169367c286f35c.1556718795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556718795.git.lorenzo@kernel.org>
References: <cover.1556718795.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows tx scheduling and tx cleanup to run concurrently

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 24 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 3ec6582afd8f..9c565c93988a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -93,18 +93,33 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 static void mt7615_tx_tasklet(unsigned long data)
 {
 	struct mt7615_dev *dev = (struct mt7615_dev *)data;
+
+	mt76_txq_schedule_all(&dev->mt76);
+}
+
+static int mt7615_poll_tx(struct napi_struct *napi, int budget)
+{
 	static const u8 queue_map[] = {
 		MT_TXQ_MCU,
 		MT_TXQ_BE
 	};
+	struct mt7615_dev *dev;
 	int i;
 
+	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
+
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++)
 		mt76_queue_tx_cleanup(dev, queue_map[i], false);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	if (napi_complete_done(napi, 0))
+		mt7615_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	mt7615_irq_enable(dev, MT_INT_TX_DONE_ALL);
+	for (i = 0; i < ARRAY_SIZE(queue_map); i++)
+		mt76_queue_tx_cleanup(dev, queue_map[i], false);
+
+	tasklet_schedule(&dev->mt76.tx_tasklet);
+
+	return 0;
 }
 
 int mt7615_dma_init(struct mt7615_dev *dev)
@@ -178,6 +193,10 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
+	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+			  mt7615_poll_tx, NAPI_POLL_WEIGHT);
+	napi_enable(&dev->mt76.tx_napi);
+
 	mt76_poll(dev, MT_WPDMA_GLO_CFG,
 		  MT_WPDMA_GLO_CFG_TX_DMA_BUSY |
 		  MT_WPDMA_GLO_CFG_RX_DMA_BUSY, 0, 1000);
@@ -201,5 +220,6 @@ void mt7615_dma_cleanup(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_SW_RESET);
 
 	tasklet_kill(&dev->mt76.tx_tasklet);
+	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 11122bd2d727..10a249e13a43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -49,7 +49,7 @@ irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 
 	if (intr & MT_INT_TX_DONE_ALL) {
 		mt7615_irq_disable(dev, MT_INT_TX_DONE_ALL);
-		tasklet_schedule(&dev->mt76.tx_tasklet);
+		napi_schedule(&dev->mt76.tx_napi);
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
-- 
2.20.1

