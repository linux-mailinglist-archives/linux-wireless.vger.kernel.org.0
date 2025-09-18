Return-Path: <linux-wireless+bounces-27029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EAB4430D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7BD5A5E8C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851591C5486;
	Thu,  4 Sep 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om1y5tKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D292D6630
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003939; cv=none; b=ZIouPBLCMyaxnODCIjQQXI2PBJlQAzYg/SjQZFTFfLUQGW4joxsUylppw0C/J9iYW4v/Szsi+lgivq7KEnSbgHqyWBMJ3emJl8f5VpwDLDiQg/HRcPrHeh3CjFbPCXn/eRyuMvdUnXSn505vYU4JI926ZbhYC9D7c2ARy3nK3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003939; c=relaxed/simple;
	bh=85lDLPRwk2vjHwHCPAWFpHnZiO56S61waCUaV9plQBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUQyMpuEDAdLsyebsMHIxwXjo9wgVCVWYdDRJFPM/7rOpAOQ1Dkwwa9S2gf+6riuAJLVj1iABElJ2WUa8yjOzz5SnOw+A2iIO6k8vuF6n02OriZ4l5Zk11eCrBiviq3GIZK+zbXMb64CCX4XyzHLI8W76GRA/tRS2ytC48RJvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om1y5tKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC3DC4CEF0;
	Thu,  4 Sep 2025 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003937;
	bh=85lDLPRwk2vjHwHCPAWFpHnZiO56S61waCUaV9plQBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=om1y5tKaH4IonzaKuOieTJ3uSFlqRezNiMosbq1XTrZjQUGq0Edu/ue7R0P257MAA
	 ia/G88k1c7jhVzhivikpYijE4frCsu7ydy3e8+jXA++yH2/p1pHjb2nYpnsUdHPZ+7
	 9SpiUIaqkCdMH7OM+nkEyVYuTHbtPG1vn1SVy69UfMhOqhUuCc0Nu2+ss7vz3JFHNn
	 OvrxkinpkFE20T6XVrKuvyRgg5+J46FVgg3jXKKvtQSMiz1u8QnH1HGGLcUXcKL7JL
	 zFtM5Waxd1uuNFmIt5qlw24H+QcMWSLzz9+bXEUg9/zKbIyohX8pWcwZsSSxPYLkDr
	 Rc11JBdZhsrqA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:38:09 +0200
Subject: [PATCH mt76 v4 15/15] wifi: mt76: mt7996: Add SW path for HW-RRO
 v3.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-15-2cd91e7229d6@kernel.org>
References: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
In-Reply-To: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Introduce HW-RRO v3.1 support to be reused when Wireless Ethernet
Dispatcher (WED) is not available. HW-RRO v3.1 is supported by
MT7992 chipset.

Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           |  86 +++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  16 ++
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  73 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 176 +++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  23 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   9 ++
 9 files changed, 295 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index d305cdf254eb217c7bbb64eb44e6a3266eb00274..40501d398d6601d7071f138eeb4cf10aecb67b8c 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -185,6 +185,35 @@ mt76_free_pending_rxwi(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_pending_rxwi);
 
+static void
+mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	if (!mt76_queue_is_wed_rro(q))
+		return;
+
+	q->magic_cnt = 0;
+	if (mt76_queue_is_wed_rro_ind(q)) {
+		struct mt76_wed_rro_desc *rro_desc;
+		int i;
+
+		rro_desc = (struct mt76_wed_rro_desc *)q->desc;
+		for (i = 0; i < q->ndesc; i++) {
+			struct mt76_wed_rro_ind *cmd;
+
+			cmd = (struct mt76_wed_rro_ind *)&rro_desc[i];
+			cmd->magic_cnt = MT_DMA_WED_IND_CMD_CNT - 1;
+		}
+	} else if (mt76_queue_is_wed_rro_rxdmad_c(q)) {
+		struct mt76_rro_rxdmad_c *dmad = (void *)q->desc;
+		u32 data3 = FIELD_PREP(RRO_DATA3_MAGIC_CNT_MASK,
+				       MT_DMA_MAGIC_CNT - 1);
+		int i;
+
+		for (i = 0; i < q->ndesc; i++)
+			dmad[i].data3 = cpu_to_le32(data3);
+	}
+}
+
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
@@ -203,7 +232,8 @@ void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q || !q->ndesc)
 		return;
 
-	if (!mt76_queue_is_wed_rro_ind(q)) {
+	if (!mt76_queue_is_wed_rro_ind(q) &&
+	    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
 		int i;
 
 		/* clear descriptors */
@@ -211,8 +241,12 @@ void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 			q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 	}
 
+	mt76_dma_queue_magic_cnt_init(dev, q);
 	if (reset_idx) {
-		Q_WRITE(q, cpu_idx, 0);
+		if (mt76_queue_is_emi(q))
+			*q->emi_cpu_idx = 0;
+		else
+			Q_WRITE(q, cpu_idx, 0);
 		Q_WRITE(q, dma_idx, 0);
 	}
 	mt76_dma_sync_idx(dev, q);
@@ -235,6 +269,9 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		rro_desc = (struct mt76_wed_rro_desc *)q->desc;
 		data = &rro_desc[q->head];
 		goto done;
+	} else if (mt76_queue_is_wed_rro_rxdmad_c(q)) {
+		data = &q->desc[q->head];
+		goto done;
 	}
 
 	desc = &q->desc[q->head];
@@ -384,7 +421,10 @@ static void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	wmb();
-	Q_WRITE(q, cpu_idx, q->head);
+	if (mt76_queue_is_emi(q))
+		*q->emi_cpu_idx = cpu_to_le16(q->head);
+	else
+		Q_WRITE(q, cpu_idx, q->head);
 }
 
 static void
@@ -552,6 +592,21 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 
 		if (q->tail == q->ndesc - 1)
 			q->magic_cnt = (q->magic_cnt + 1) % MT_DMA_WED_IND_CMD_CNT;
+	} else if (mt76_queue_is_wed_rro_rxdmad_c(q)) {
+		struct mt76_rro_rxdmad_c *dmad;
+		u16 magic_cnt;
+
+		if (flush)
+			goto done;
+
+		dmad = q->entry[idx].buf;
+		magic_cnt = FIELD_GET(RRO_DATA3_MAGIC_CNT_MASK,
+				      le32_to_cpu(dmad->data3));
+		if (magic_cnt != q->magic_cnt)
+			return NULL;
+
+		if (q->tail == q->ndesc - 1)
+			q->magic_cnt = (q->magic_cnt + 1) % MT_DMA_MAGIC_CNT;
 	} else {
 		if (flush)
 			q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
@@ -713,7 +768,8 @@ mt76_dma_rx_fill_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		void *buf = NULL;
 		int offset;
 
-		if (mt76_queue_is_wed_rro_ind(q))
+		if (mt76_queue_is_wed_rro_ind(q) ||
+		    mt76_queue_is_wed_rro_rxdmad_c(q))
 			goto done;
 
 		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
@@ -772,19 +828,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
-	if (mt76_queue_is_wed_rro_ind(q)) {
-		struct mt76_wed_rro_desc *rro_desc;
-		int i;
-
-		rro_desc = (struct mt76_wed_rro_desc *)q->desc;
-		for (i = 0; i < q->ndesc; i++) {
-			struct mt76_wed_rro_ind *cmd;
-
-			cmd = (struct mt76_wed_rro_ind *)&rro_desc[i];
-			cmd->magic_cnt = MT_DMA_WED_IND_CMD_CNT - 1;
-		}
-	}
-
+	mt76_dma_queue_magic_cnt_init(dev, q);
 	size = q->ndesc * sizeof(*q->entry);
 	q->entry = devm_kzalloc(dev->dev, size, GFP_KERNEL);
 	if (!q->entry)
@@ -804,7 +848,10 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 			return 0;
 	}
 
-	mt76_dma_queue_reset(dev, q, true);
+	/* HW specific driver is supposed to reset brand-new EMI queues since
+	 * it needs to set cpu index pointer.
+	 */
+	mt76_dma_queue_reset(dev, q, !mt76_queue_is_emi(q));
 
 	return 0;
 }
@@ -847,7 +894,8 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	if (!q->ndesc)
 		return;
 
-	if (!mt76_queue_is_wed_rro_ind(q)) {
+	if (!mt76_queue_is_wed_rro_ind(q) &&
+	    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
 		int i;
 
 		for (i = 0; i < q->ndesc; i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4aabb8d1021a70f502a4afe25b14d2cc6d524aca..a78d663ee91d2be1b13d8ff94f7a0ed3f54cacd8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -33,6 +33,7 @@
 #define MT_QFLAG_WED		BIT(5)
 #define MT_QFLAG_WED_RRO	BIT(6)
 #define MT_QFLAG_WED_RRO_EN	BIT(7)
+#define MT_QFLAG_EMI_EN		BIT(8)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
@@ -75,6 +76,12 @@ enum mt76_wed_type {
 	MT76_WED_RRO_Q_RXDMAD_C,
 };
 
+enum mt76_hwrro_mode {
+	MT76_HWRRO_OFF,
+	MT76_HWRRO_V3,
+	MT76_HWRRO_V3_1,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
@@ -131,6 +138,7 @@ enum mt76_rxq_id {
 	MT_RXQ_TXFREE_BAND1,
 	MT_RXQ_TXFREE_BAND2,
 	MT_RXQ_RRO_IND,
+	MT_RXQ_RRO_RXDMAD_C,
 	__MT_RXQ_MAX
 };
 
@@ -236,6 +244,8 @@ struct mt76_queue {
 	u16 flags;
 	u8 magic_cnt;
 
+	__le16 *emi_cpu_idx;
+
 	struct mtk_wed_device *wed;
 	u32 wed_regs;
 
@@ -923,6 +933,7 @@ struct mt76_dev {
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
 	int tx_dma_idx[4];
+	enum mt76_hwrro_mode hwrro_mode;
 
 	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
@@ -1820,6 +1831,11 @@ static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
 }
 
+static inline bool mt76_queue_is_emi(struct mt76_queue *q)
+{
+	return q->flags & MT_QFLAG_EMI_EN;
+}
+
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 9663029fa087c05d743db13ebf6b2e1383723b1c..659015f93d3238ba3b3c3779f4baa8f4b46b22e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -83,12 +83,14 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 		break;
 	}
 
-	if (dev->has_rro) {
+	if (mt7996_has_hwrro(dev)) {
 		/* band0 */
 		RXQ_CONFIG(MT_RXQ_RRO_BAND0, WFDMA0, MT_INT_RX_DONE_RRO_BAND0,
 			   MT7996_RXQ_RRO_BAND0);
-		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND0, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND0,
-			   MT7996_RXQ_MSDU_PG_BAND0);
+		if (dev->mt76.hwrro_mode == MT76_HWRRO_V3)
+			RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND0, WFDMA0,
+				   MT_INT_RX_DONE_MSDU_PG_BAND0,
+				   MT7996_RXQ_MSDU_PG_BAND0);
 		if (is_mt7996(&dev->mt76)) {
 			RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0,
 				   MT_INT_RX_TXFREE_MAIN, MT7996_RXQ_TXFREE0);
@@ -111,8 +113,14 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 				   MT7996_RXQ_RRO_BAND1);
 		}
 
-		RXQ_CONFIG(MT_RXQ_RRO_IND, WFDMA0, MT_INT_RX_DONE_RRO_IND,
-			   MT7996_RXQ_RRO_IND);
+		if (dev->mt76.hwrro_mode == MT76_HWRRO_V3)
+			RXQ_CONFIG(MT_RXQ_RRO_IND, WFDMA0,
+				   MT_INT_RX_DONE_RRO_IND,
+				   MT7996_RXQ_RRO_IND);
+		else
+			RXQ_CONFIG(MT_RXQ_RRO_RXDMAD_C, WFDMA0,
+				   MT_INT_RX_DONE_RRO_RXDMAD_C,
+				   MT7996_RXQ_RRO_RXDMAD_C);
 	}
 
 	/* data tx queue */
@@ -196,11 +204,12 @@ static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 
 	/* Rx TxFreeDone From MAC Rings */
 	val = is_mt7996(&dev->mt76) ? 4 : 8;
-	if (is_mt7990(&dev->mt76) || (is_mt7996(&dev->mt76) && dev->has_rro))
+	if ((is_mt7996(&dev->mt76) && mt7996_has_hwrro(dev)) ||
+	    is_mt7990(&dev->mt76))
 		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND0) + ofs, PREFETCH(val));
 	if (is_mt7990(&dev->mt76) && dev->hif2)
 		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND1) + ofs, PREFETCH(val));
-	else if (is_mt7996(&dev->mt76) && dev->has_rro)
+	else if (is_mt7996(&dev->mt76) && mt7996_has_hwrro(dev))
 		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND2) + ofs, PREFETCH(val));
 
 	/* Rx Data Rings */
@@ -209,7 +218,7 @@ static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 	mt76_wr(dev, MT_RXQ_EXT_CTRL(queue) + ofs, PREFETCH(0x10));
 
 	/* Rx RRO Rings */
-	if (dev->has_rro) {
+	if (mt7996_has_hwrro(dev)) {
 		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_RRO_BAND0) + ofs, PREFETCH(0x10));
 		queue = is_mt7996(&dev->mt76) ? MT_RXQ_RRO_BAND2 : MT_RXQ_RRO_BAND1;
 		mt76_wr(dev, MT_RXQ_EXT_CTRL(queue) + ofs, PREFETCH(0x10));
@@ -465,7 +474,7 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 		 * so, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-		    dev->has_rro) {
+		    mt7996_has_hwrro(dev)) {
 			u32 intr = is_mt7996(&dev->mt76) ?
 				   MT_WFDMA0_RX_INT_SEL_RING6 :
 				   MT_WFDMA0_RX_INT_SEL_RING9 |
@@ -488,6 +497,30 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 	u32 irq_mask;
 	int ret;
 
+	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+		/* rxdmad_c */
+		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags = MT_WED_RRO_Q_RXDMAD_C;
+		if (mtk_wed_device_active(&mdev->mmio.wed))
+			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].wed = &mdev->mmio.wed;
+		else
+			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags |= MT_QFLAG_EMI_EN;
+		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C],
+				       MT_RXQ_ID(MT_RXQ_RRO_RXDMAD_C),
+				       MT7996_RX_RING_SIZE,
+				       MT7996_RX_BUF_SIZE,
+				       MT_RXQ_RRO_AP_RING_BASE);
+		if (ret)
+			return ret;
+
+		/* We need to set cpu idx pointer before resetting the EMI
+		 * queues.
+		 */
+		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].emi_cpu_idx =
+			&dev->wed_rro.emi_rings_cpu.ptr->ring[0].idx;
+		mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C], true);
+		goto start_hw_rro;
+	}
+
 	/* ind cmd */
 	mdev->q_rx[MT_RXQ_RRO_IND].flags = MT_WED_RRO_Q_IND;
 	if (mtk_wed_device_active(&mdev->mmio.wed) &&
@@ -546,6 +579,7 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			return ret;
 	}
 
+start_hw_rro:
 	if (mtk_wed_device_active(&mdev->mmio.wed)) {
 		irq_mask = mdev->mmio.irqmask |
 			   MT_INT_TX_DONE_BAND2;
@@ -567,9 +601,15 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		}
 
 		mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND0, mt76_dma_rx_poll);
-		mt76_queue_rx_init(dev, MT_RXQ_RRO_IND, mt76_dma_rx_poll);
-		mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
-				   mt76_dma_rx_poll);
+		if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+			mt76_queue_rx_init(dev, MT_RXQ_RRO_RXDMAD_C,
+					   mt76_dma_rx_poll);
+		} else {
+			mt76_queue_rx_init(dev, MT_RXQ_RRO_IND,
+					   mt76_dma_rx_poll);
+			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
+					   mt76_dma_rx_poll);
+		}
 		mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
 	}
 
@@ -662,7 +702,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 
 	/* tx free notify event from WA for band0 */
 	if (mtk_wed_device_active(wed) &&
-	    ((is_mt7996(&dev->mt76) && !dev->has_rro) ||
+	    ((is_mt7996(&dev->mt76) && !mt7996_has_hwrro(dev)) ||
 	     (is_mt7992(&dev->mt76)))) {
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
@@ -718,7 +758,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		/* tx free notify event from WA for mt7996 band2
 		 * use pcie0's rx ring3, but, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
-		if (mtk_wed_device_active(wed_hif2) && !dev->has_rro) {
+		if (mtk_wed_device_active(wed_hif2) && !mt7996_has_hwrro(dev)) {
 			dev->mt76.q_rx[MT_RXQ_BAND2_WA].flags = MT_WED_Q_TXFREE;
 			dev->mt76.q_rx[MT_RXQ_BAND2_WA].wed = wed_hif2;
 		}
@@ -765,7 +805,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		}
 	}
 
-	if (dev->has_rro) {
+	if (mt7996_has_hwrro(dev)) {
 		/* rx rro data queue for band0 */
 		dev->mt76.q_rx[MT_RXQ_RRO_BAND0].flags =
 			MT_WED_RRO_Q_DATA(0) | MT_QFLAG_WED_RRO_EN;
@@ -887,7 +927,8 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 
 	mt76_tx_status_check(&dev->mt76, true);
 
-	if (dev->has_rro && !mtk_wed_device_active(&dev->mt76.mmio.wed))
+	if (mt7996_has_hwrro(dev) &&
+	    !mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mt7996_rro_msdu_page_map_free(dev);
 
 	/* reset wfsys */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 859c5c219872843bd61ccd0a099d638aaedf0fa2..8b127ac383611a7e91e182d379055ed4ab2c86de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -611,7 +611,7 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 	else
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 0);
 
-	if (dev->has_rro) {
+	if (mt7996_has_hwrro(dev)) {
 		u16 timeout;
 
 		timeout = mt76_rr(dev, MT_HW_REV) == MT_HW_REV1 ? 512 : 128;
@@ -764,59 +764,25 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 	msleep(20);
 }
 
-void mt7996_rro_hw_init(struct mt7996_dev *dev)
+static void mt7996_rro_hw_init_v3(struct mt7996_dev *dev)
 {
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
-	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
-	int i;
+	u32 session_id;
 
-	if (!dev->has_rro)
+	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1)
 		return;
 
-	INIT_LIST_HEAD(&dev->wed_rro.page_cache);
-	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.page_map); i++)
-		INIT_LIST_HEAD(&dev->wed_rro.page_map[i]);
-
-	if (is_mt7992(&dev->mt76)) {
-		/* Set emul 3.0 function */
-		mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
-			MT_RRO_3_0_EMU_CONF_EN_MASK);
-		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE0,
-			dev->wed_rro.addr_elem[0].phy_addr);
-	} else {
-		/* TODO: remove line after WM has set */
-		mt76_clear(dev, WF_RRO_AXI_MST_CFG,
-			   WF_RRO_AXI_MST_CFG_DIDX_OK);
-		/* setup BA bitmap cache address */
-		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE0,
-			dev->wed_rro.ba_bitmap[0].phy_addr);
-		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE1, 0);
-		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT0,
-			dev->wed_rro.ba_bitmap[1].phy_addr);
-		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT1, 0);
-
-		/* Setup Address element address */
-		for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
-			mt76_wr(dev, reg,
-				dev->wed_rro.addr_elem[i].phy_addr >> 4);
-			reg += 4;
-		}
-
-		/* Setup Address element address - separate address
-		 * segment mode
-		 */
-		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
-			MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
-	}
-
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
-		wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
+		wed->wlan.ind_cmd.win_size =
+			ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
 		if (is_mt7996(&dev->mt76))
-			wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
+			wed->wlan.ind_cmd.particular_sid =
+				MT7996_RRO_MAX_SESSION;
 		else
 			wed->wlan.ind_cmd.particular_sid = 1;
-		wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
+		wed->wlan.ind_cmd.particular_se_phys =
+			dev->wed_rro.session.phy_addr;
 		wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
 		wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
 	}
@@ -835,9 +801,50 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 	/* use max session idx + 1 as particular session id */
 	mt76_wr(dev, MT_RRO_PARTICULAR_CFG0, dev->wed_rro.session.phy_addr);
 
-	if (is_mt7992(&dev->mt76)) {
+	session_id = is_mt7996(&dev->mt76) ? MT7996_RRO_MAX_SESSION : 1;
+	mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
+		MT_RRO_PARTICULAR_CONFG_EN |
+		FIELD_PREP(MT_RRO_PARTICULAR_SID, session_id));
+}
+
+void mt7996_rro_hw_init(struct mt7996_dev *dev)
+{
+	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
+	int i;
+
+	if (!mt7996_has_hwrro(dev))
+		return;
+
+	INIT_LIST_HEAD(&dev->wed_rro.page_cache);
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.page_map); i++)
+		INIT_LIST_HEAD(&dev->wed_rro.page_map[i]);
+
+	if (!is_mt7996(&dev->mt76)) {
 		reg = MT_RRO_MSDU_PG_SEG_ADDR0;
 
+		if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+			mt76_clear(dev, MT_RRO_3_0_EMU_CONF,
+				   MT_RRO_3_0_EMU_CONF_EN_MASK);
+			mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
+				 MT_RRO_3_1_GLOBAL_CONFIG_RXDMAD_SEL);
+			if (!mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+				mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
+					 MT_RRO_3_1_GLOBAL_CONFIG_RX_DIDX_WR_EN |
+					 MT_RRO_3_1_GLOBAL_CONFIG_RX_CIDX_RD_EN);
+				mt76_wr(dev, MT_RRO_RX_RING_AP_CIDX_ADDR,
+					dev->wed_rro.emi_rings_cpu.phy_addr >> 4);
+				mt76_wr(dev, MT_RRO_RX_RING_AP_DIDX_ADDR,
+					dev->wed_rro.emi_rings_dma.phy_addr >> 4);
+			}
+		} else {
+			/* set emul 3.0 function */
+			mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
+				MT_RRO_3_0_EMU_CONF_EN_MASK);
+
+			mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE0,
+				dev->wed_rro.addr_elem[0].phy_addr);
+		}
+
 		mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
 			 MT_RRO_3_1_GLOBAL_CONFIG_INTERLEAVE_EN);
 
@@ -847,15 +854,35 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 				dev->wed_rro.msdu_pg[i].phy_addr >> 4);
 			reg += 4;
 		}
-		mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
-			MT_RRO_PARTICULAR_CONFG_EN |
-			FIELD_PREP(MT_RRO_PARTICULAR_SID, 1));
 	} else {
-		mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
-			MT_RRO_PARTICULAR_CONFG_EN |
-			FIELD_PREP(MT_RRO_PARTICULAR_SID,
-				   MT7996_RRO_MAX_SESSION));
+		/* TODO: remove line after WM has set */
+		mt76_clear(dev, WF_RRO_AXI_MST_CFG,
+			   WF_RRO_AXI_MST_CFG_DIDX_OK);
+
+		/* setup BA bitmap cache address */
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE0,
+			dev->wed_rro.ba_bitmap[0].phy_addr);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE1, 0);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT0,
+			dev->wed_rro.ba_bitmap[1].phy_addr);
+		mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT1, 0);
+
+		/* Setup Address element address */
+		for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
+			mt76_wr(dev, reg,
+				dev->wed_rro.addr_elem[i].phy_addr >> 4);
+			reg += 4;
+		}
+
+		/* Setup Address element address - separate address segment
+		 * mode.
+		 */
+		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
+			MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
 	}
+
+	mt7996_rro_hw_init_v3(dev);
+
 	/* interrupt enable */
 	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
 		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
@@ -867,18 +894,20 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 	void *ptr;
 	int i;
 
-	if (!dev->has_rro)
+	if (!mt7996_has_hwrro(dev))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
-		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
-					  MT7996_RRO_BA_BITMAP_CR_SIZE,
-					  &dev->wed_rro.ba_bitmap[i].phy_addr,
-					  GFP_KERNEL);
-		if (!ptr)
-			return -ENOMEM;
+	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3) {
+		for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
+			ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+						  MT7996_RRO_BA_BITMAP_CR_SIZE,
+						  &dev->wed_rro.ba_bitmap[i].phy_addr,
+						  GFP_KERNEL);
+			if (!ptr)
+				return -ENOMEM;
 
-		dev->wed_rro.ba_bitmap[i].ptr = ptr;
+			dev->wed_rro.ba_bitmap[i].ptr = ptr;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
@@ -926,6 +955,26 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		       MT7996_RRO_MSDU_PG_SIZE_PER_CR);
 	}
 
+	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+					  sizeof(dev->wed_rro.emi_rings_cpu.ptr),
+					  &dev->wed_rro.emi_rings_cpu.phy_addr,
+					  GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+
+		dev->wed_rro.emi_rings_cpu.ptr = ptr;
+
+		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+					  sizeof(dev->wed_rro.emi_rings_dma.ptr),
+					  &dev->wed_rro.emi_rings_dma.phy_addr,
+					  GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+
+		dev->wed_rro.emi_rings_dma.ptr = ptr;
+	}
+
 	ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
 				  MT7996_RRO_WINDOW_MAX_LEN * sizeof(*addr),
 				  &dev->wed_rro.session.phy_addr,
@@ -949,7 +998,7 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 {
 	int i;
 
-	if (!dev->has_rro)
+	if (!mt7996_has_hwrro(dev))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
@@ -1660,7 +1709,8 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
 	mt7996_dma_cleanup(dev);
-	if (dev->has_rro && !mtk_wed_device_active(&dev->mt76.mmio.wed))
+	if (mt7996_has_hwrro(dev) &&
+	    !mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mt7996_rro_msdu_page_map_free(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 5d29aec07eb3198c239b42af8779690257481dca..d20c63bb246c22854768fb343429cc79ac6fd478 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2235,7 +2235,8 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	if (ret)
 		goto out;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && dev->has_rro) {
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    mt7996_has_hwrro(dev)) {
 		u32 wed_irq_mask = dev->mt76.mmio.irqmask |
 				   MT_INT_TX_DONE_BAND2;
 
@@ -2463,7 +2464,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	/* enable DMA Tx/Tx and interrupt */
 	mt7996_dma_start(dev, false, false);
 
-	if (!is_mt7996(&dev->mt76) && dev->has_rro)
+	if (!is_mt7996(&dev->mt76) && dev->mt76.hwrro_mode == MT76_HWRRO_V3)
 		mt76_wr(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 418d545020330b717082ac25dd0388ea4fff331e..922773689cd025b1a6b9aafa53ad7621263536c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -660,7 +660,7 @@ mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
 	struct mt7996_mcu_wed_rro_event *event = (void *)skb->data;
 
-	if (!dev->has_rro)
+	if (!mt7996_has_hwrro(dev))
 		return;
 
 	skb_pull(skb, sizeof(struct mt7996_mcu_rxd) + 4);
@@ -1183,7 +1183,7 @@ mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif_link *mvif,
 	ba->ba_en = enable << params->tid;
 	ba->amsdu = params->amsdu;
 	ba->tid = params->tid;
-	ba->ba_rdd_rro = !tx && enable && dev->has_rro;
+	ba->ba_rdd_rro = !tx && enable && mt7996_has_hwrro(dev);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 38c15b061dfffc512f99fe4c7d70dcfd92f14c6e..d14b626ee511566e465588d2b2f7b77bd859a6ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -464,7 +464,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	if (!wed_enable)
 		return 0;
 
-	dev->has_rro = true;
+	dev->mt76.hwrro_mode = is_mt7996(&dev->mt76) ? MT76_HWRRO_V3
+						     : MT76_HWRRO_V3_1;
 
 	hif1_ofs = dev->hif2 ? MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0) : 0;
 
@@ -490,7 +491,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.wpdma_tx = wed->wlan.phy_base + hif1_ofs +
 					     MT_TXQ_RING_BASE(0) +
 					     MT7996_TXQ_BAND2 * MT_RING_SIZE;
-		if (dev->has_rro) {
+		if (mt7996_has_hwrro(dev)) {
 			if (is_mt7996(&dev->mt76)) {
 				wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_EXT) - 1;
 				wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
@@ -517,7 +518,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.id = MT7996_DEVICE_ID_2;
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND2) - 1;
 	} else {
-		wed->wlan.hw_rro = dev->has_rro; /* default on */
+		wed->wlan.hw_rro = mt7996_has_hwrro(dev);
 		wed->wlan.wpdma_int = wed->wlan.phy_base + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = wed->wlan.phy_base + MT_INT_MASK_CSR;
 		wed->wlan.wpdma_tx = wed->wlan.phy_base + MT_TXQ_RING_BASE(0) +
@@ -570,7 +571,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND0) - 1;
 		wed->wlan.tx_tbit[1] = ffs(MT_INT_TX_DONE_BAND1) - 1;
 		if (is_mt7996(&dev->mt76)) {
-			if (dev->has_rro) {
+			if (mt7996_has_hwrro(dev)) {
 				wed->wlan.wpdma_txfree = wed->wlan.phy_base +
 							 MT_RXQ_RING_BASE(0) +
 							 MT7996_RXQ_TXFREE0 * MT_RING_SIZE;
@@ -609,7 +610,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	}
 
 	if (mtk_wed_device_attach(wed)) {
-		dev->has_rro = false;
+		dev->mt76.hwrro_mode = MT76_HWRRO_OFF;
 		return 0;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index a20416acbdb6c24a1c676fff15db56cd82b3445c..606d26a738327935b335a0c2a82ba99eb52d5b83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -193,6 +193,7 @@ enum mt7996_rxq_id {
 	MT7996_RXQ_TXFREE1 = 9,
 	MT7996_RXQ_TXFREE2 = 7,
 	MT7996_RXQ_RRO_IND = 0,
+	MT7996_RXQ_RRO_RXDMAD_C = 0,
 	MT7990_RXQ_TXFREE0 = 6,
 	MT7990_RXQ_TXFREE1 = 7,
 };
@@ -343,6 +344,14 @@ struct mt7996_msdu_page_info {
 	u32 owner		: 1;
 };
 
+#define MT7996_MAX_RRO_RRS_RING 4
+struct mt7996_rro_queue_regs_emi {
+	struct {
+		__le16 idx;
+		__le16 rsv;
+	} ring[MT7996_MAX_RRO_RRS_RING];
+};
+
 struct mt7996_phy {
 	struct mt76_phy *mt76;
 	struct mt7996_dev *dev;
@@ -437,7 +446,6 @@ struct mt7996_dev {
 
 	bool flash_mode:1;
 	bool has_eht:1;
-	bool has_rro:1;
 
 	struct {
 		struct {
@@ -456,6 +464,14 @@ struct mt7996_dev {
 			void *ptr;
 			dma_addr_t phy_addr;
 		} msdu_pg[MT7996_RRO_MSDU_PG_CR_CNT];
+		struct {
+			struct mt7996_rro_queue_regs_emi *ptr;
+			dma_addr_t phy_addr;
+		} emi_rings_cpu;
+		struct {
+			struct mt7996_rro_queue_regs_emi *ptr;
+			dma_addr_t phy_addr;
+		} emi_rings_dma;
 
 		struct work_struct work;
 		struct list_head poll_list;
@@ -736,6 +752,11 @@ int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled);
 
+static inline bool mt7996_has_hwrro(struct mt7996_dev *dev)
+{
+	return dev->mt76.hwrro_mode != MT76_HWRRO_OFF;
+}
+
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
 	return min(MT7996_MAX_INTERFACES * (1 + mt7996_band_valid(dev, MT_BAND1) +
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 9ca1490c2cf3a8acf753703f42547e1fe4f7d81c..0fa325f87fcd9d43e209e1035b638ea4207fdbd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -114,9 +114,14 @@ enum offs_rev {
 #define MT_RRO_3_0_EMU_CONF_EN_MASK		BIT(11)
 
 #define MT_RRO_3_1_GLOBAL_CONFIG		MT_RRO_TOP(0x604)
+#define MT_RRO_3_1_GLOBAL_CONFIG_RXDMAD_SEL	BIT(6)
+#define MT_RRO_3_1_GLOBAL_CONFIG_RX_CIDX_RD_EN	BIT(3)
+#define MT_RRO_3_1_GLOBAL_CONFIG_RX_DIDX_WR_EN	BIT(2)
 #define MT_RRO_3_1_GLOBAL_CONFIG_INTERLEAVE_EN	BIT(0)
 
 #define MT_RRO_MSDU_PG_SEG_ADDR0		MT_RRO_TOP(0x620)
+#define MT_RRO_RX_RING_AP_CIDX_ADDR		MT_RRO_TOP(0x6f0)
+#define MT_RRO_RX_RING_AP_DIDX_ADDR		MT_RRO_TOP(0x6f4)
 
 #define MT_RRO_ACK_SN_CTRL			MT_RRO_TOP(0x50)
 #define MT_RRO_ACK_SN_CTRL_SN_MASK		GENMASK(27, 16)
@@ -510,6 +515,8 @@ enum offs_rev {
 #define MT_RXQ_RING_BASE(q)			(MT_Q_BASE(__RXQ(q)) + 0x500)
 #define MT_RXQ_RRO_IND_RING_BASE		MT_RRO_TOP(0x40)
 
+#define MT_RXQ_RRO_AP_RING_BASE			MT_RRO_TOP(0x650)
+
 #define MT_MCUQ_EXT_CTRL(q)			(MT_Q_BASE(q) +	0x600 +	\
 						 MT_MCUQ_ID(q) * 0x4)
 #define MT_RXQ_EXT_CTRL(q)			(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
@@ -545,6 +552,7 @@ enum offs_rev {
 #define MT_INT_RX_DONE_RRO_BAND1		BIT(17)
 #define MT_INT_RX_DONE_RRO_BAND2		BIT(14)
 #define MT_INT_RX_DONE_RRO_IND			BIT(11)
+#define MT_INT_RX_DONE_RRO_RXDMAD_C		BIT(11)
 #define MT_INT_RX_DONE_MSDU_PG_BAND0		BIT(18)
 #define MT_INT_RX_DONE_MSDU_PG_BAND1		BIT(19)
 #define MT_INT_RX_DONE_MSDU_PG_BAND2		BIT(23)
@@ -573,6 +581,7 @@ enum offs_rev {
 						 MT_INT_RX(MT_RXQ_RRO_BAND1) |		\
 						 MT_INT_RX(MT_RXQ_RRO_BAND2) |		\
 						 MT_INT_RX(MT_RXQ_RRO_IND) |		\
+						 MT_INT_RX(MT_RXQ_RRO_RXDMAD_C) |	\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND0) |	\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND1) |	\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND2))

-- 
2.50.1


