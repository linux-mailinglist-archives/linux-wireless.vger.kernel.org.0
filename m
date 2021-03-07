Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C33303E3
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhCGSVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 13:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhCGSVN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 13:21:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 519FA65187;
        Sun,  7 Mar 2021 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615141273;
        bh=L2C1A+vbNChkSaVAN+AJQNmVmzFOUWGPXNSLTXAoly8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCR9Fd8Tu+qCCPTyiOyZmm150mVwB8n+vznFfRlwpcjVBemBWBse+4IiJ/t1ZQfsD
         4dmGwiqzSPw+boqZiAN5nLZhRcDPq1NWvr7AGOmAoGZAWfZcKq+RvGbTN4Esbi93sj
         Wq0ENW4TK6mGclvAfksVKmUtBWSwaj/fhV9N6aUC8v6Kh6/pEzPNa4N3It4kSTFP5k
         kPtj8vHckF0QzxHDinkDf+W5aeiQxsD3BnQTPpJv5txOtw8K+ge3H/h67wwzrCgyVh
         a1s/Ac3DSmS66THr2PgUEZEzMhCFBDsT6swYSCVdrpOCeekCBIgooThUIxplXMsfYg
         oPehHkPApACdw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 5/7] mt76: dma: introduce mt76_dma_queue_reset routine
Date:   Sun,  7 Mar 2021 19:20:49 +0100
Message-Id: <36d656488ba44442c7a98adfed53469b49f5c629.1615140875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615140875.git.lorenzo@kernel.org>
References: <cover.1615140875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_dma_queue_reset utility routine to reset a given hw
queue. This is a preliminary patch to introduce mt7921 chip reset
support.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 46 ++++++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h |  3 ++
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 19098b852d0a..82711d69ec94 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -79,13 +79,38 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	local_bh_enable();
 }
 
+static void
+mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	writel(q->desc_dma, &q->regs->desc_base);
+	writel(q->ndesc, &q->regs->ring_size);
+	q->head = readl(&q->regs->dma_idx);
+	q->tail = q->head;
+}
+
+static void
+mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int i;
+
+	if (!q)
+		return;
+
+	/* clear descriptors */
+	for (i = 0; i < q->ndesc; i++)
+		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+
+	writel(0, &q->regs->cpu_idx);
+	writel(0, &q->regs->dma_idx);
+	mt76_dma_sync_idx(dev, q);
+}
+
 static int
 mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 		     int idx, int n_desc, int bufsize,
 		     u32 ring_base)
 {
 	int size;
-	int i;
 
 	spin_lock_init(&q->lock);
 	spin_lock_init(&q->cleanup_lock);
@@ -105,14 +130,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q->entry)
 		return -ENOMEM;
 
-	/* clear descriptors */
-	for (i = 0; i < q->ndesc; i++)
-		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
-
-	writel(q->desc_dma, &q->regs->desc_base);
-	writel(0, &q->regs->cpu_idx);
-	writel(0, &q->regs->dma_idx);
-	writel(q->ndesc, &q->regs->ring_size);
+	mt76_dma_queue_reset(dev, q);
 
 	return 0;
 }
@@ -201,15 +219,6 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	memset(e, 0, sizeof(*e));
 }
 
-static void
-mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
-{
-	writel(q->desc_dma, &q->regs->desc_base);
-	writel(q->ndesc, &q->regs->ring_size);
-	q->head = readl(&q->regs->dma_idx);
-	q->tail = q->head;
-}
-
 static void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
@@ -640,6 +649,7 @@ mt76_dma_init(struct mt76_dev *dev)
 static const struct mt76_queue_ops mt76_dma_ops = {
 	.init = mt76_dma_init,
 	.alloc = mt76_dma_alloc_queue,
+	.reset_q = mt76_dma_queue_reset,
 	.tx_queue_skb_raw = mt76_dma_tx_queue_skb_raw,
 	.tx_queue_skb = mt76_dma_tx_queue_skb,
 	.tx_cleanup = mt76_dma_tx_cleanup,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bbe6a70851c8..f306a9c71ebf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -192,6 +192,8 @@ struct mt76_queue_ops {
 			   bool flush);
 
 	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
+
+	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q);
 };
 
 enum mt76_wcid_flags {
@@ -794,6 +796,7 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_tx_cleanup(dev, ...)        (dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_reset(dev, ...)	(dev)->mt76.queue_ops->reset_q(&((dev)->mt76), __VA_ARGS__)
 
 #define mt76_for_each_q_rx(dev, i)	\
 	for (i = 0; i < ARRAY_SIZE((dev)->q_rx) && \
-- 
2.29.2

