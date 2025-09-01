Return-Path: <linux-wireless+bounces-26910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B93B3F033
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC04850F3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B10274FD7;
	Mon,  1 Sep 2025 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jznuhBX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41415272E54
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760334; cv=none; b=koK7KCNXCwiRhcnuOK9KYhH45oyNNBpyOOcAH15grJPEPXvWfxcBz8Vnahk5VoSvsFs0RLgbAMBlsqyiDnvPmR74upfiA0r8q4n2zbQE8/ERUn6V6BJVA4RlU2ANsgVLN8eDtb6rLwA6DdZXPJA1ePXFXrkQsWt33YJcDZRNmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760334; c=relaxed/simple;
	bh=GKGnZqnAsDrxctqLT2iibvMfR3HDHyGeBZd2bm5SILg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9nITpv9gzALsfiWB/qV5OZxRfKgf/BGRvF0v6UqUZfaYNdRHOG0qC8hpHrJiJKaFt7oZjzNeWBa1c4LAkqRZFWIUN3XuDJxjRs2TkWPnp00XEwJL8eNKwx5DEZNVHsi48b+zj2OFlBWKMJ4pJYY/rWoYgzotBT/yRGgRqckD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jznuhBX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7809FC4CEF0;
	Mon,  1 Sep 2025 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760333;
	bh=GKGnZqnAsDrxctqLT2iibvMfR3HDHyGeBZd2bm5SILg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jznuhBX1dkOJpt1F9xGlyccwVtg3gdpEo4DMREP0vZeMDJQaqJn836NoNWQRwLztG
	 fzCPRUrrHQnKmdnwGCBf5uhrDRsS6j47emqY7cgBtcBJ7WZde6ren1/xVvex3Ibx6x
	 Rn7K02AOrwXSBQK4B7QZ0ruxxVl1gfcW9+DrHjPoYxkXztQGZG1q0O30VWQ5joVG/2
	 nXSLNo8MdTEjsCWDgloomJO/EsER+rokduDWF8Iee+PBmOKvfiJ1jJNG/kv8U7w02d
	 KVF/gNiStJZ/ePPXTrl5vLfMJAjYr3Uf37F15seqGzOK2TfCI8F75Y7EKaySXVaCxu
	 Kf0SnEu750xhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 22:58:08 +0200
Subject: [PATCH mt76 v2 12/14] wifi: mt76: mt7996: Decouple RRO logic from
 WED support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-rro-rework-v2-12-1f95086b51d1@kernel.org>
References: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
In-Reply-To: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
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

Decouple RRO logic from WED support in MT7996 driver in order to reuse
it when WED module is not available.

Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           | 54 ++++++++++++----
 drivers/net/wireless/mediatek/mt76/dma.h           |  7 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h          | 10 +--
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 73 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 60 +++++++++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 14 ++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 -
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  1 +
 8 files changed, 140 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 081a3f5d387864ad596fec93542797038eed26f1..fc30a8ea54ca6f736fd911de4ad471558e6c9577 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -224,9 +224,9 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 {
 	struct mt76_queue_entry *entry = &q->entry[q->head];
 	struct mt76_txwi_cache *txwi = NULL;
+	u32 buf1 = 0, ctrl, info = 0;
 	struct mt76_desc *desc;
 	int idx = q->head;
-	u32 buf1 = 0, ctrl;
 	int rx_token;
 
 	if (mt76_queue_is_wed_rro_ind(q)) {
@@ -243,7 +243,7 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	buf1 = FIELD_PREP(MT_DMA_CTL_SDP0_H, buf->addr >> 32);
 #endif
 
-	if (mt76_queue_is_wed_rx(q)) {
+	if (mt76_queue_is_wed_rx(q) || mt76_queue_is_wed_rro_data(q)) {
 		txwi = mt76_get_rxwi(dev);
 		if (!txwi)
 			return -ENOMEM;
@@ -260,10 +260,22 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		txwi->qid = q - dev->q_rx;
 	}
 
+	if (mt76_queue_is_wed_rro_msdu_pg(q) &&
+	    dev->drv->rx_rro_add_msdu_page) {
+		if (dev->drv->rx_rro_add_msdu_page(dev, q, buf->addr, data))
+			return -ENOMEM;
+	}
+
+	if (q->flags & MT_QFLAG_WED_RRO_EN) {
+		info |= FIELD_PREP(MT_DMA_MAGIC_MASK, q->magic_cnt);
+		if ((q->head + 1) == q->ndesc)
+			q->magic_cnt = (q->magic_cnt + 1) % MT_DMA_MAGIC_CNT;
+	}
+
 	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
 	WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
 	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
-	WRITE_ONCE(desc->info, 0);
+	WRITE_ONCE(desc->info, cpu_to_le32(info));
 
 done:
 	entry->dma_addr[0] = buf->addr;
@@ -424,7 +436,7 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	u32 ctrl, desc_info, buf1;
 	void *buf = e->buf;
 
-	if (mt76_queue_is_wed_rro_ind(q))
+	if (mt76_queue_is_wed_rro(q))
 		goto done;
 
 	ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
@@ -480,15 +492,27 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 		return NULL;
 
 	if (mt76_queue_is_wed_rro_data(q) || mt76_queue_is_wed_rro_msdu_pg(q))
-		return NULL;
+		goto done;
 
-	if (!mt76_queue_is_wed_rro_ind(q)) {
+	if (mt76_queue_is_wed_rro_ind(q)) {
+		struct mt76_wed_rro_ind *cmd;
+
+		if (flush)
+			goto done;
+
+		cmd = q->entry[idx].buf;
+		if (cmd->magic_cnt != q->magic_cnt)
+			return NULL;
+
+		if (q->tail == q->ndesc - 1)
+			q->magic_cnt = (q->magic_cnt + 1) % MT_DMA_WED_IND_CMD_CNT;
+	} else {
 		if (flush)
 			q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 		else if (!(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
 			return NULL;
 	}
-
+done:
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
 
@@ -837,8 +861,9 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 	bool allow_direct = !mt76_queue_is_wed_rx(q);
 	bool more;
 
-	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
-	    mt76_queue_is_wed_tx_free(q)) {
+	if ((q->flags & MT_QFLAG_WED_RRO_EN) ||
+	    (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
+	     mt76_queue_is_wed_tx_free(q))) {
 		dma_idx = Q_READ(q, dma_idx);
 		check_ddone = true;
 	}
@@ -860,6 +885,14 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		if (!data)
 			break;
 
+		if (mt76_queue_is_wed_rro_ind(q) && dev->drv->rx_rro_ind_process)
+			dev->drv->rx_rro_ind_process(dev, data);
+
+		if (mt76_queue_is_wed_rro(q)) {
+			done++;
+			continue;
+		}
+
 		if (drop)
 			goto free_frag;
 
@@ -978,8 +1011,7 @@ mt76_dma_init(struct mt76_dev *dev,
 	init_completion(&dev->mmio.wed_reset_complete);
 
 	mt76_for_each_q_rx(dev, i) {
-		if (mtk_wed_device_active(&dev->mmio.wed) &&
-		    mt76_queue_is_wed_rro(&dev->q_rx[i]))
+		if (mt76_queue_is_wed_rro(&dev->q_rx[i]))
 			continue;
 
 		mt76_dma_rx_queue_init(dev, i, poll);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 320d2cbbbd4559db146139a50e579b9b57282557..f53c2136858043d0f208d9d21304fae2058ac70f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -31,7 +31,12 @@
 #define MT_DMA_CTL_PN_CHK_FAIL		BIT(13)
 #define MT_DMA_CTL_VER_MASK		BIT(7)
 
-#define MT_DMA_RRO_EN		BIT(13)
+#define MT_DMA_SDP0			GENMASK(15, 0)
+#define MT_DMA_TOKEN_ID			GENMASK(31, 16)
+#define MT_DMA_MAGIC_MASK		GENMASK(31, 28)
+#define MT_DMA_RRO_EN			BIT(13)
+
+#define MT_DMA_MAGIC_CNT		16
 
 #define MT_DMA_WED_IND_CMD_CNT		8
 #define MT_DMA_WED_IND_REASON		GENMASK(15, 12)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8dcf593a0151310648043b5ac7528570c61aea0b..39e4641ae2cc5287a2c8c838c729bc7e85b68b9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -232,6 +232,7 @@ struct mt76_queue {
 
 	u8 buf_offset;
 	u16 flags;
+	u8 magic_cnt;
 
 	struct mtk_wed_device *wed;
 	u32 wed_regs;
@@ -1807,13 +1808,8 @@ static inline bool mt76_queue_is_wed_rro_msdu_pg(struct mt76_queue *q)
 
 static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 {
-	if (!(q->flags & MT_QFLAG_WED))
-		return false;
-
-	return FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX ||
-	       mt76_queue_is_wed_rro_ind(q) || mt76_queue_is_wed_rro_data(q) ||
-	       mt76_queue_is_wed_rro_msdu_pg(q);
-
+	return (q->flags & MT_QFLAG_WED) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
 }
 
 struct mt76_txwi_cache *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 2412767bfaa7e26cdce45b482fb56dea2add8280..9663029fa087c05d743db13ebf6b2e1383723b1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -325,7 +325,7 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 	}
 
 	if (mt7996_band_valid(dev, MT_BAND2))
-		irq_mask |= MT_INT_BAND2_RX_DONE;
+		irq_mask |= MT_INT_BAND2_RX_DONE | MT_INT_TX_RX_DONE_EXT;
 
 	if (mtk_wed_device_active(wed) && wed_reset) {
 		u32 wed_irq_mask = irq_mask;
@@ -482,7 +482,6 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 	mt7996_dma_start(dev, reset, true);
 }
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 int mt7996_dma_rro_init(struct mt7996_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
@@ -491,7 +490,9 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 
 	/* ind cmd */
 	mdev->q_rx[MT_RXQ_RRO_IND].flags = MT_WED_RRO_Q_IND;
-	mdev->q_rx[MT_RXQ_RRO_IND].wed = &mdev->mmio.wed;
+	if (mtk_wed_device_active(&mdev->mmio.wed) &&
+	    mtk_wed_get_rx_capa(&mdev->mmio.wed))
+		mdev->q_rx[MT_RXQ_RRO_IND].wed = &mdev->mmio.wed;
 	ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_RRO_IND],
 			       MT_RXQ_ID(MT_RXQ_RRO_IND),
 			       MT7996_RX_RING_SIZE,
@@ -502,7 +503,9 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 	/* rx msdu page queue for band0 */
 	mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].flags =
 		MT_WED_RRO_Q_MSDU_PG(0) | MT_QFLAG_WED_RRO_EN;
-	mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].wed = &mdev->mmio.wed;
+	if (mtk_wed_device_active(&mdev->mmio.wed) &&
+	    mtk_wed_get_rx_capa(&mdev->mmio.wed))
+		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].wed = &mdev->mmio.wed;
 	ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0],
 			       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND0),
 			       MT7996_RX_RING_SIZE,
@@ -515,7 +518,9 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		/* rx msdu page queue for band1 */
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].flags =
 			MT_WED_RRO_Q_MSDU_PG(1) | MT_QFLAG_WED_RRO_EN;
-		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].wed = &mdev->mmio.wed;
+		if (mtk_wed_device_active(&mdev->mmio.wed) &&
+		    mtk_wed_get_rx_capa(&mdev->mmio.wed))
+			mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].wed = &mdev->mmio.wed;
 		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1],
 				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND1),
 				       MT7996_RX_RING_SIZE,
@@ -529,7 +534,9 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		/* rx msdu page queue for band2 */
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].flags =
 			MT_WED_RRO_Q_MSDU_PG(2) | MT_QFLAG_WED_RRO_EN;
-		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].wed = &mdev->mmio.wed;
+		if (mtk_wed_device_active(&mdev->mmio.wed) &&
+		    mtk_wed_get_rx_capa(&mdev->mmio.wed))
+			mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].wed = &mdev->mmio.wed;
 		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2],
 				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND2),
 				       MT7996_RX_RING_SIZE,
@@ -539,15 +546,35 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			return ret;
 	}
 
-	irq_mask = mdev->mmio.irqmask | MT_INT_RRO_RX_DONE |
-		   MT_INT_TX_DONE_BAND2;
-	mt76_wr(dev, MT_INT_MASK_CSR, irq_mask);
-	mtk_wed_device_start_hw_rro(&mdev->mmio.wed, irq_mask, false);
-	mt7996_irq_enable(dev, irq_mask);
+	if (mtk_wed_device_active(&mdev->mmio.wed)) {
+		irq_mask = mdev->mmio.irqmask |
+			   MT_INT_TX_DONE_BAND2;
+
+		mt76_wr(dev, MT_INT_MASK_CSR, irq_mask);
+		mtk_wed_device_start_hw_rro(&mdev->mmio.wed, irq_mask, false);
+		mt7996_irq_enable(dev, irq_mask);
+	} else {
+		if (is_mt7996(&dev->mt76)) {
+			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND1,
+					   mt76_dma_rx_poll);
+			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND2,
+					   mt76_dma_rx_poll);
+			mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND2,
+					   mt76_dma_rx_poll);
+		} else {
+			mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND1,
+					   mt76_dma_rx_poll);
+		}
+
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND0, mt76_dma_rx_poll);
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_IND, mt76_dma_rx_poll);
+		mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
+				   mt76_dma_rx_poll);
+		mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
+	}
 
 	return 0;
 }
-#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
 
 int mt7996_dma_init(struct mt7996_dev *dev)
 {
@@ -738,12 +765,12 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		}
 	}
 
-	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed) &&
-	    dev->has_rro) {
+	if (dev->has_rro) {
 		/* rx rro data queue for band0 */
 		dev->mt76.q_rx[MT_RXQ_RRO_BAND0].flags =
 			MT_WED_RRO_Q_DATA(0) | MT_QFLAG_WED_RRO_EN;
-		dev->mt76.q_rx[MT_RXQ_RRO_BAND0].wed = wed;
+		if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed))
+			dev->mt76.q_rx[MT_RXQ_RRO_BAND0].wed = wed;
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_RRO_BAND0],
 				       MT_RXQ_ID(MT_RXQ_RRO_BAND0),
 				       MT7996_RX_RING_SIZE,
@@ -755,7 +782,9 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		if (is_mt7992(&dev->mt76)) {
 			dev->mt76.q_rx[MT_RXQ_RRO_BAND1].flags =
 				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
-			dev->mt76.q_rx[MT_RXQ_RRO_BAND1].wed = wed;
+			if (mtk_wed_device_active(wed) &&
+			    mtk_wed_get_rx_capa(wed))
+				dev->mt76.q_rx[MT_RXQ_RRO_BAND1].wed = wed;
 			ret = mt76_queue_alloc(dev,
 					       &dev->mt76.q_rx[MT_RXQ_RRO_BAND1],
 					       MT_RXQ_ID(MT_RXQ_RRO_BAND1),
@@ -765,9 +794,11 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 			if (ret)
 				return ret;
 		} else {
-			/* tx free notify event from WA for band0 */
-			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
-			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+			if (mtk_wed_device_active(wed)) {
+				/* tx free notify event from WA for band0 */
+				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
+				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+			}
 
 			ret = mt76_queue_alloc(dev,
 					       &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0],
@@ -783,7 +814,9 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 			/* rx rro data queue for band2 */
 			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].flags =
 				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
-			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].wed = wed;
+			if (mtk_wed_device_active(wed) &&
+			    mtk_wed_get_rx_capa(wed))
+				dev->mt76.q_rx[MT_RXQ_RRO_BAND2].wed = wed;
 			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_RRO_BAND2],
 					       MT_RXQ_ID(MT_RXQ_RRO_BAND2),
 					       MT7996_RX_RING_SIZE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 89907add122196f0016a295da49af4a911d9cf23..7a21b5843f49de9ad06a153d3900ab066cf5ef70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -766,7 +766,6 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 
 void mt7996_rro_hw_init(struct mt7996_dev *dev)
 {
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
 	int i;
@@ -809,18 +808,28 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 		mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
 			MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
 	}
-	wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
-	if (is_mt7996(&dev->mt76))
-		wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
-	else
-		wed->wlan.ind_cmd.particular_sid = 1;
-	wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
-	wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
-	wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
 
-	mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0x15010e00);
-	mt76_set(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1,
-		 MT_RRO_IND_CMD_SIGNATURE_BASE1_EN);
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
+		wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
+		if (is_mt7996(&dev->mt76))
+			wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
+		else
+			wed->wlan.ind_cmd.particular_sid = 1;
+		wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
+		wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
+		wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
+	}
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+
+	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
+		mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0x15010e00);
+		mt76_set(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1,
+			 MT_RRO_IND_CMD_SIGNATURE_BASE1_EN);
+	} else {
+		mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0);
+		mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1, 0);
+	}
 
 	/* particular session configure */
 	/* use max session idx + 1 as particular session id */
@@ -850,13 +859,10 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 	/* interrupt enable */
 	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
 		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
-#endif
 }
 
 static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 {
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mt7996_wed_rro_addr *addr;
 	void *ptr;
 	int i;
@@ -864,9 +870,6 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 	if (!dev->has_rro)
 		return 0;
 
-	if (!mtk_wed_device_active(wed))
-		return 0;
-
 	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
 		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
 					  MT7996_RRO_BA_BITMAP_CR_SIZE,
@@ -898,8 +901,15 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 			addr++;
 		}
 
-		wed->wlan.ind_cmd.addr_elem_phys[i] =
-			dev->wed_rro.addr_elem[i].phy_addr;
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mtk_wed_get_rx_capa(&dev->mt76.mmio.wed)) {
+			struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+
+			wed->wlan.ind_cmd.addr_elem_phys[i] =
+				dev->wed_rro.addr_elem[i].phy_addr;
+		}
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.msdu_pg); i++) {
@@ -933,22 +943,15 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 	mt7996_rro_hw_init(dev);
 
 	return mt7996_dma_rro_init(dev);
-#else
-	return 0;
-#endif
 }
 
 static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 {
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	int i;
 
 	if (!dev->has_rro)
 		return;
 
-	if (!mtk_wed_device_active(&dev->mt76.mmio.wed))
-		return;
-
 	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
 		if (!dev->wed_rro.ba_bitmap[i].ptr)
 			continue;
@@ -988,12 +991,10 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 			   sizeof(struct mt7996_wed_rro_addr),
 			   dev->wed_rro.session.ptr,
 			   dev->wed_rro.session.phy_addr);
-#endif
 }
 
 static void mt7996_wed_rro_work(struct work_struct *work)
 {
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mt7996_dev *dev;
 	LIST_HEAD(list);
 
@@ -1036,7 +1037,6 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 out:
 		kfree(e);
 	}
-#endif
 }
 
 static int mt7996_variant_type_init(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 29a6d62301106a81fb9b006b6f05f677f87568df..b6046756c2dbc7558e1352ee5a78326eaf23cb3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2187,7 +2187,6 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && dev->has_rro) {
 		u32 wed_irq_mask = dev->mt76.mmio.irqmask |
-				   MT_INT_RRO_RX_DONE |
 				   MT_INT_TX_DONE_BAND2;
 
 		mt7996_rro_hw_init(dev);
@@ -2414,19 +2413,14 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	/* enable DMA Tx/Tx and interrupt */
 	mt7996_dma_start(dev, false, false);
 
+	if (!is_mt7996(&dev->mt76) && dev->has_rro)
+		mt76_wr(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
+
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
-		u32 wed_irq_mask = MT_INT_RRO_RX_DONE | MT_INT_TX_DONE_BAND2 |
+		u32 wed_irq_mask = MT_INT_TX_DONE_BAND2 |
 				   dev->mt76.mmio.irqmask;
 
-		if (mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-			wed_irq_mask &= ~MT_INT_RX_DONE_RRO_IND;
-
 		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
-
-		if (is_mt7992(&dev->mt76) && dev->has_rro)
-			mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
-				MT_RRO_3_0_EMU_CONF_EN_MASK);
-
 		mtk_wed_device_start_hw_rro(&dev->mt76.mmio.wed, wed_irq_mask,
 					    true);
 		mt7996_irq_enable(dev, wed_irq_mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0908ebcf65268e0eae862fad9f3c5d48493a78c7..a20416acbdb6c24a1c676fff15db56cd82b3445c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -858,8 +858,6 @@ u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
 int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 #endif
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 int mt7996_dma_rro_init(struct mt7996_dev *dev);
-#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index d239fa3f375f5e86f9cf650fda713a4e1e4b2f96..9ca1490c2cf3a8acf753703f42547e1fe4f7d81c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -572,6 +572,7 @@ enum offs_rev {
 #define MT_INT_RRO_RX_DONE			(MT_INT_RX(MT_RXQ_RRO_BAND0) |		\
 						 MT_INT_RX(MT_RXQ_RRO_BAND1) |		\
 						 MT_INT_RX(MT_RXQ_RRO_BAND2) |		\
+						 MT_INT_RX(MT_RXQ_RRO_IND) |		\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND0) |	\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND1) |	\
 						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND2))

-- 
2.50.1


