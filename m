Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A327AA199
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjIUVEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjIUVDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27184F0A
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D388C4AF6B;
        Thu, 21 Sep 2023 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293059;
        bh=brhvxX8rxgGrtJ970/RHm2LI5ZOg6nIGl1PPh3bD1SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxzgF0VyfGWdQ3i5FVSizpMVIfdKjvkxH8RToTkALuaGXLGqXDebvgUfca7EAThX9
         KQRRM/MiNk+JWdMFYjfW1OJ2IcJL0C65lqTPvNRjNCxTwS0tQunPx44H4JEc77Qu16
         x4EMDx1rQvLSaOB+mzi/MyVvnvKFn1Gw+Bu93cVU1t2zRm6MM7RLqp+0b6fG3B44lh
         PUnpeKXzk++9Y3RLRLoyjxpL1oVP6xy5fFiuS5EZSNuFBbYlUwBCEuuS0S2prO+tQI
         nfdjMW8fp5wy4Z2QmY+091axfBmCpyYXla6INyDbyfHKDt/sx7uE5iJOWEw4KWRHQW
         EiOLeSJx1j8Lg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 9/9] wifi: mt76: mt7996: add wed rx support
Date:   Thu, 21 Sep 2023 12:43:38 +0200
Message-ID: <9ba57d99ed64a3a4a8b030f26d0b8945479a5a8f.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Similar to MT7915, enable Wireless Ethernet Ditpatcher for MT7996
to offload traffic received from the WLAN nic and transmitted on the
LAN one

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 148 +++++++++----
 drivers/net/wireless/mediatek/mt76/dma.h      |  12 ++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  58 ++++-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 198 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 127 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  41 +++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  60 ++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  55 +++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  60 +++++-
 10 files changed, 687 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 15923e1540d4..dd20271fc637 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -189,7 +189,10 @@ static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	Q_WRITE(q, desc_base, q->desc_dma);
-	Q_WRITE(q, ring_size, q->ndesc);
+	if (q->flags & MT_QFLAG_WED_RRO_EN)
+		Q_WRITE(q, ring_size, MT_DMA_RRO_EN | q->ndesc);
+	else
+		Q_WRITE(q, ring_size, q->ndesc);
 	q->head = Q_READ(q, dma_idx);
 	q->tail = q->head;
 }
@@ -198,14 +201,16 @@ static void
 __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 		       bool reset_idx)
 {
-	int i;
-
 	if (!q || !q->ndesc)
 		return;
 
-	/* clear descriptors */
-	for (i = 0; i < q->ndesc; i++)
-		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	if (!mt76_queue_is_wed_rro_ind(q)) {
+		int i;
+
+		/* clear descriptors */
+		for (i = 0; i < q->ndesc; i++)
+			q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	}
 
 	if (reset_idx) {
 		Q_WRITE(q, cpu_idx, 0);
@@ -224,13 +229,22 @@ static int
 mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		    struct mt76_queue_buf *buf, void *data)
 {
-	struct mt76_desc *desc = &q->desc[q->head];
 	struct mt76_queue_entry *entry = &q->entry[q->head];
 	struct mt76_txwi_cache *txwi = NULL;
+	struct mt76_desc *desc;
 	u32 buf1 = 0, ctrl;
 	int idx = q->head;
 	int rx_token;
 
+	if (mt76_queue_is_wed_rro_ind(q)) {
+		struct mt76_wed_rro_desc *rro_desc;
+
+		rro_desc = (struct mt76_wed_rro_desc *)q->desc;
+		data = &rro_desc[q->head];
+		goto done;
+	}
+
+	desc = &q->desc[q->head];
 	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
 
 	if (mt76_queue_is_wed_rx(q)) {
@@ -253,6 +267,7 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
 	WRITE_ONCE(desc->info, 0);
 
+done:
 	entry->dma_addr[0] = buf->addr;
 	entry->dma_len[0] = buf->len;
 	entry->txwi = txwi;
@@ -401,10 +416,14 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 {
 	struct mt76_queue_entry *e = &q->entry[idx];
 	struct mt76_desc *desc = &q->desc[idx];
-	void *buf;
+	void *buf = e->buf;
+	u32 ctrl;
+
+	if (mt76_queue_is_wed_rro_ind(q))
+		goto done;
 
+	ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 	if (len) {
-		u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		*len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctrl);
 		*more = !(ctrl & MT_DMA_CTL_LAST_SEC0);
 	}
@@ -412,6 +431,12 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (info)
 		*info = le32_to_cpu(desc->info);
 
+	if (drop) {
+		*drop = !!(ctrl & (MT_DMA_CTL_TO_HOST_A | MT_DMA_CTL_DROP));
+		if (ctrl & MT_DMA_CTL_VER_MASK)
+			*drop = !!(ctrl & MT_DMA_CTL_PN_CHK_FAIL);
+	}
+
 	if (mt76_queue_is_wed_rx(q)) {
 		u32 buf1 = le32_to_cpu(desc->buf1);
 		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
@@ -429,23 +454,16 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 		t->ptr = NULL;
 
 		mt76_put_rxwi(dev, t);
-
-		if (drop) {
-			u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
-
-			*drop = !!(ctrl & (MT_DMA_CTL_TO_HOST_A |
-					   MT_DMA_CTL_DROP));
-
+		if (drop)
 			*drop |= !!(buf1 & MT_DMA_CTL_WO_DROP);
-		}
 	} else {
-		buf = e->buf;
-		e->buf = NULL;
 		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
 				SKB_WITH_OVERHEAD(q->buf_size),
 				page_pool_get_dma_dir(q->page_pool));
 	}
 
+done:
+	e->buf = NULL;
 	return buf;
 }
 
@@ -459,11 +477,16 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	if (!q->queued)
 		return NULL;
 
-	if (flush)
-		q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
-	else if (!(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
+	if (mt76_queue_is_wed_rro_data(q))
 		return NULL;
 
+	if (!mt76_queue_is_wed_rro_ind(q)) {
+		if (flush)
+			q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+		else if (!(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
+			return NULL;
+	}
+
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
 
@@ -615,11 +638,14 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
+		struct mt76_queue_buf qbuf = {};
 		enum dma_data_direction dir;
-		struct mt76_queue_buf qbuf;
 		dma_addr_t addr;
 		int offset;
-		void *buf;
+		void *buf = NULL;
+
+		if (mt76_queue_is_wed_rro_ind(q))
+			goto done;
 
 		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
 		if (!buf)
@@ -630,6 +656,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
 
 		qbuf.addr = addr + q->buf_offset;
+done:
 		qbuf.len = len - q->buf_offset;
 		qbuf.skip_unmap = false;
 		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
@@ -639,7 +666,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 		frames++;
 	}
 
-	if (frames)
+	if (frames || mt76_queue_is_wed_rx(q))
 		mt76_dma_kick_queue(dev, q);
 
 	spin_unlock_bh(&q->lock);
@@ -650,8 +677,8 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	int ret, type, ring;
-	u8 flags;
+	int ret = 0, type, ring;
+	u16 flags;
 
 	if (!q || !q->ndesc)
 		return -EINVAL;
@@ -678,7 +705,6 @@ int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 		q->flags = 0;
 		mt76_dma_queue_reset(dev, q);
 		mt76_dma_rx_fill(dev, q, false);
-		q->flags = flags;
 
 		ret = mtk_wed_device_txfree_ring_setup(q->wed, q->regs);
 		if (!ret)
@@ -690,9 +716,31 @@ int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 		if (!ret)
 			q->wed_regs = q->wed->rx_ring[ring].reg_base;
 		break;
+	case MT76_WED_RRO_Q_DATA:
+		q->flags &= ~MT_QFLAG_WED;
+		__mt76_dma_queue_reset(dev, q, false);
+		mtk_wed_device_rro_rx_ring_setup(q->wed, ring, q->regs);
+		q->head = q->ndesc - 1;
+		q->queued = q->head;
+		break;
+	case MT76_WED_RRO_Q_MSDU_PG:
+		q->flags &= ~MT_QFLAG_WED;
+		__mt76_dma_queue_reset(dev, q, false);
+		mtk_wed_device_msdu_pg_rx_ring_setup(q->wed, ring, q->regs);
+		q->head = q->ndesc - 1;
+		q->queued = q->head;
+		break;
+	case MT76_WED_RRO_Q_IND:
+		q->flags &= ~MT_QFLAG_WED;
+		mt76_dma_queue_reset(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+		mtk_wed_device_ind_rx_ring_setup(q->wed, q->regs);
+		break;
 	default:
 		ret = -EINVAL;
+		break;
 	}
+	q->flags = flags;
 
 	return ret;
 #else
@@ -716,11 +764,26 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->buf_size = bufsize;
 	q->hw_idx = idx;
 
-	size = q->ndesc * sizeof(struct mt76_desc);
-	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
+	size = mt76_queue_is_wed_rro_ind(q) ? sizeof(struct mt76_wed_rro_desc)
+					    : sizeof(struct mt76_desc);
+	q->desc = dmam_alloc_coherent(dev->dma_dev, q->ndesc * size,
+				      &q->desc_dma, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
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
+	}
+
 	size = q->ndesc * sizeof(*q->entry);
 	q->entry = devm_kzalloc(dev->dev, size, GFP_KERNEL);
 	if (!q->entry)
@@ -734,8 +797,13 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
-	if (!mt76_queue_is_wed_tx_free(q))
-		mt76_dma_queue_reset(dev, q);
+	if (mtk_wed_device_active(&dev->mmio.wed)) {
+		if ((mtk_wed_get_rx_capa(&dev->mmio.wed) && mt76_queue_is_wed_rro(q)) ||
+		    mt76_queue_is_wed_tx_free(q))
+			return 0;
+	}
+
+	mt76_dma_queue_reset(dev, q);
 
 	return 0;
 }
@@ -756,7 +824,8 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		mt76_put_page_pool_buf(buf, false);
+		if (!mt76_queue_is_wed_rro(q))
+			mt76_put_page_pool_buf(buf, false);
 	} while (1);
 
 	if (q->rx_head) {
@@ -771,13 +840,16 @@ static void
 mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 {
 	struct mt76_queue *q = &dev->q_rx[qid];
-	int i;
 
 	if (!q->ndesc)
 		return;
 
-	for (i = 0; i < q->ndesc; i++)
-		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	if (!mt76_queue_is_wed_rro_ind(q)) {
+		int i;
+
+		for (i = 0; i < q->ndesc; i++)
+			q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	}
 
 	mt76_dma_rx_cleanup(dev, q);
 
@@ -989,6 +1061,10 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    mt76_queue_is_wed_rro(q))
+			continue;
+
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 1b090d78cd05..22b79d58093b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -25,6 +25,13 @@
 #define MT_DMA_PPE_ENTRY		GENMASK(30, 16)
 #define MT_DMA_INFO_PPE_VLD		BIT(31)
 
+#define MT_DMA_CTL_PN_CHK_FAIL		BIT(13)
+#define MT_DMA_CTL_VER_MASK		BIT(7)
+
+#define MT_DMA_RRO_EN		BIT(13)
+
+#define MT_DMA_WED_IND_CMD_CNT		8
+
 #define MT_DMA_HDR_LEN			4
 #define MT_RX_INFO_LEN			4
 #define MT_FCE_INFO_LEN			4
@@ -37,6 +44,11 @@ struct mt76_desc {
 	__le32 info;
 } __packed __aligned(4);
 
+struct mt76_wed_rro_desc {
+	__le32 buf0;
+	__le32 buf1;
+} __packed __aligned(4);
+
 enum mt76_qsel {
 	MT_QSEL_MGMT,
 	MT_QSEL_HCCA,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 02aceaded9fa..1013a6ff16b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -31,13 +31,20 @@
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
 #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
 #define MT_QFLAG_WED		BIT(5)
+#define MT_QFLAG_WED_RRO	BIT(6)
+#define MT_QFLAG_WED_RRO_EN	BIT(7)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
 				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
+#define __MT_WED_RRO_Q(_type, _n)	(MT_QFLAG_WED_RRO | __MT_WED_Q(_type, _n))
+
 #define MT_WED_Q_TX(_n)		__MT_WED_Q(MT76_WED_Q_TX, _n)
 #define MT_WED_Q_RX(_n)		__MT_WED_Q(MT76_WED_Q_RX, _n)
 #define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
+#define MT_WED_RRO_Q_DATA(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_DATA, _n)
+#define MT_WED_RRO_Q_MSDU_PG(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_MSDU_PG, _n)
+#define MT_WED_RRO_Q_IND	__MT_WED_RRO_Q(MT76_WED_RRO_Q_IND, 0)
 
 struct mt76_dev;
 struct mt76_phy;
@@ -59,6 +66,9 @@ enum mt76_wed_type {
 	MT76_WED_Q_TX,
 	MT76_WED_Q_TXFREE,
 	MT76_WED_Q_RX,
+	MT76_WED_RRO_Q_DATA,
+	MT76_WED_RRO_Q_MSDU_PG,
+	MT76_WED_RRO_Q_IND,
 };
 
 struct mt76_bus_ops {
@@ -194,6 +204,7 @@ struct mt76_queue {
 	spinlock_t lock;
 	spinlock_t cleanup_lock;
 	struct mt76_queue_entry *entry;
+	struct mt76_rro_desc *rro_desc;
 	struct mt76_desc *desc;
 
 	u16 first;
@@ -207,7 +218,7 @@ struct mt76_queue {
 
 	u8 buf_offset;
 	u8 hw_idx;
-	u8 flags;
+	u16 flags;
 
 	struct mtk_wed_device *wed;
 	u32 wed_regs;
@@ -364,6 +375,17 @@ struct mt76_txq {
 	bool aggr;
 };
 
+struct mt76_wed_rro_ind {
+	u32 se_id	: 12;
+	u32 rsv		: 4;
+	u32 start_sn	: 12;
+	u32 ind_reason	: 4;
+	u32 ind_cnt	: 13;
+	u32 win_sz	: 3;
+	u32 rsv2	: 13;
+	u32 magic_cnt	: 3;
+};
+
 struct mt76_txwi_cache {
 	struct list_head list;
 	dma_addr_t dma_addr;
@@ -1574,10 +1596,32 @@ static inline bool mt76_queue_is_wed_tx_free(struct mt76_queue *q)
 	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_TXFREE;
 }
 
+static inline bool mt76_queue_is_wed_rro(struct mt76_queue *q)
+{
+	return q->flags & MT_QFLAG_WED_RRO;
+}
+
+static inline bool mt76_queue_is_wed_rro_ind(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_IND;
+}
+
+static inline bool mt76_queue_is_wed_rro_data(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       (FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_DATA ||
+		FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_MSDU_PG);
+}
+
 static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 {
-	return (q->flags & MT_QFLAG_WED) &&
-	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
+	if (!(q->flags & MT_QFLAG_WED))
+		return false;
+
+	return FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX ||
+	       mt76_queue_is_wed_rro_ind(q) || mt76_queue_is_wed_rro_data(q);
+
 }
 
 struct mt76_txwi_cache *
@@ -1617,10 +1661,14 @@ static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
 static inline int
 mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 {
-	int token;
+	int token, start = 0;
+
+	if (mtk_wed_device_active(&dev->mmio.wed))
+		start = dev->mmio.wed.wlan.nbuf;
 
 	spin_lock_bh(&dev->token_lock);
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
+	token = idr_alloc(&dev->token, *ptxwi, start, start + dev->token_size,
+			  GFP_ATOMIC);
 	spin_unlock_bh(&dev->token_lock);
 
 	return token;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 72912f376bc9..2221d22ccffb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -65,6 +65,29 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 	RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
 	RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI, MT7996_RXQ_MCU_WA_TRI);
 
+	if (dev->has_rro) {
+		/* band0 */
+		RXQ_CONFIG(MT_RXQ_RRO_BAND0, WFDMA0, MT_INT_RX_DONE_RRO_BAND0,
+			   MT7996_RXQ_RRO_BAND0);
+		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND0, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND0,
+			   MT7996_RXQ_MSDU_PG_BAND0);
+		RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0, MT_INT_RX_TXFREE_MAIN,
+			   MT7996_RXQ_TXFREE0);
+		/* band1 */
+		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND1, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND1,
+			   MT7996_RXQ_MSDU_PG_BAND1);
+		/* band2 */
+		RXQ_CONFIG(MT_RXQ_RRO_BAND2, WFDMA0, MT_INT_RX_DONE_RRO_BAND2,
+			   MT7996_RXQ_RRO_BAND2);
+		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND2, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND2,
+			   MT7996_RXQ_MSDU_PG_BAND2);
+		RXQ_CONFIG(MT_RXQ_TXFREE_BAND2, WFDMA0, MT_INT_RX_TXFREE_TRI,
+			   MT7996_RXQ_TXFREE2);
+
+		RXQ_CONFIG(MT_RXQ_RRO_IND, WFDMA0, MT_INT_RX_DONE_RRO_IND,
+			   MT7996_RXQ_RRO_IND);
+	}
+
 	/* data tx queue */
 	TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
 	TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
@@ -93,6 +116,24 @@ static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x1a0, 0x10));
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2) + ofs, PREFETCH(0x2a0, 0x10));
 
+	if (dev->has_rro) {
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND0) + ofs,
+			PREFETCH(0x3a0, 0x10));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND2) + ofs,
+			PREFETCH(0x4a0, 0x10));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND0) + ofs,
+			PREFETCH(0x5a0, 0x4));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND1) + ofs,
+			PREFETCH(0x5e0, 0x4));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND2) + ofs,
+			PREFETCH(0x620, 0x4));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND0) + ofs,
+			PREFETCH(0x660, 0x4));
+		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND2) + ofs,
+			PREFETCH(0x6a0, 0x4));
+	}
+#undef PREFETCH
+
 	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT1 + ofs, WF_WFDMA0_GLO_CFG_EXT1_CALC_MODE);
 }
 
@@ -150,6 +191,7 @@ static void mt7996_dma_disable(struct mt7996_dev *dev, bool reset)
 
 void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 {
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 hif1_ofs = 0;
 	u32 irq_mask;
 
@@ -158,11 +200,16 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 
 	/* enable WFDMA Tx/Rx */
 	if (!reset) {
-		mt76_set(dev, MT_WFDMA0_GLO_CFG,
-			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+		if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed))
+			mt76_set(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO);
+		else
+			mt76_set(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
 		if (dev->hif2)
 			mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
@@ -184,12 +231,12 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 	if (dev->tbtc_support)
 		irq_mask |= MT_INT_BAND2_RX_DONE;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wed_reset) {
+	if (mtk_wed_device_active(wed) && wed_reset) {
 		u32 wed_irq_mask = irq_mask;
 
 		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
 		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
-		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
+		mtk_wed_device_start(wed, wed_irq_mask);
 	}
 
 	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
@@ -266,13 +313,85 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 		/* fix hardware limitation, pcie1's rx ring3 is not available
 		 * so, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
-		mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL,
-			 MT_WFDMA0_RX_INT_SEL_RING3);
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    dev->has_rro)
+			mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL + hif1_ofs,
+				 MT_WFDMA0_RX_INT_SEL_RING6);
+		else
+			mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL,
+				 MT_WFDMA0_RX_INT_SEL_RING3);
 	}
 
 	mt7996_dma_start(dev, reset, true);
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+int mt7996_dma_rro_init(struct mt7996_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 irq_mask;
+	int ret;
+
+	/* ind cmd */
+	mdev->q_rx[MT_RXQ_RRO_IND].flags = MT_WED_RRO_Q_IND;
+	mdev->q_rx[MT_RXQ_RRO_IND].wed = &mdev->mmio.wed;
+	ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_RRO_IND],
+			       MT_RXQ_ID(MT_RXQ_RRO_IND),
+			       MT7996_RX_RING_SIZE,
+			       0, MT_RXQ_RRO_IND_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* rx msdu page queue for band0 */
+	mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].flags =
+		MT_WED_RRO_Q_MSDU_PG(0) | MT_QFLAG_WED_RRO_EN;
+	mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].wed = &mdev->mmio.wed;
+	ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0],
+			       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND0),
+			       MT7996_RX_RING_SIZE,
+			       MT7996_RX_MSDU_PAGE_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND0));
+	if (ret)
+		return ret;
+
+	if (dev->dbdc_support) {
+		/* rx msdu page queue for band1 */
+		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].flags =
+			MT_WED_RRO_Q_MSDU_PG(1) | MT_QFLAG_WED_RRO_EN;
+		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].wed = &mdev->mmio.wed;
+		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1],
+				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND1),
+				       MT7996_RX_RING_SIZE,
+				       MT7996_RX_MSDU_PAGE_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND1));
+		if (ret)
+			return ret;
+	}
+
+	if (dev->tbtc_support) {
+		/* rx msdu page queue for band2 */
+		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].flags =
+			MT_WED_RRO_Q_MSDU_PG(2) | MT_QFLAG_WED_RRO_EN;
+		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].wed = &mdev->mmio.wed;
+		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2],
+				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND2),
+				       MT7996_RX_RING_SIZE,
+				       MT7996_RX_MSDU_PAGE_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND2));
+		if (ret)
+			return ret;
+	}
+
+	irq_mask = mdev->mmio.irqmask | MT_INT_RRO_RX_DONE |
+		   MT_INT_TX_DONE_BAND2;
+	mt76_wr(dev, MT_INT_MASK_CSR, irq_mask);
+	mtk_wed_device_start_hw_rro(&mdev->mmio.wed, irq_mask, false);
+	mt7996_irq_enable(dev, irq_mask);
+
+	return 0;
+}
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+
 int mt7996_dma_init(struct mt7996_dev *dev)
 {
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
@@ -356,7 +475,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	/* tx free notify event from WA for band0 */
-	if (mtk_wed_device_active(wed)) {
+	if (mtk_wed_device_active(wed) && !dev->has_rro) {
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
 	}
@@ -372,9 +491,6 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
 		/* rx data queue for band2 */
 		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs;
-		if (mtk_wed_device_active(wed))
-			rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2);
-
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2],
 				       MT_RXQ_ID(MT_RXQ_BAND2),
 				       MT7996_RX_RING_SIZE,
@@ -386,7 +502,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		/* tx free notify event from WA for band2
 		 * use pcie0's rx ring3, but, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
-		if (mtk_wed_device_active(wed_hif2)) {
+		if (mtk_wed_device_active(wed_hif2) && !dev->has_rro) {
 			dev->mt76.q_rx[MT_RXQ_BAND2_WA].flags = MT_WED_Q_TXFREE;
 			dev->mt76.q_rx[MT_RXQ_BAND2_WA].wed = wed_hif2;
 		}
@@ -400,6 +516,60 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 			return ret;
 	}
 
+	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed) &&
+	    dev->has_rro) {
+		/* rx rro data queue for band0 */
+		dev->mt76.q_rx[MT_RXQ_RRO_BAND0].flags =
+			MT_WED_RRO_Q_DATA(0) | MT_QFLAG_WED_RRO_EN;
+		dev->mt76.q_rx[MT_RXQ_RRO_BAND0].wed = wed;
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_RRO_BAND0],
+				       MT_RXQ_ID(MT_RXQ_RRO_BAND0),
+				       MT7996_RX_RING_SIZE,
+				       MT7996_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND0));
+		if (ret)
+			return ret;
+
+		/* tx free notify event from WA for band0 */
+		dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
+		dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0],
+				       MT_RXQ_ID(MT_RXQ_TXFREE_BAND0),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT7996_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND0));
+		if (ret)
+			return ret;
+
+		if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
+			/* rx rro data queue for band2 */
+			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].flags =
+				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
+			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].wed = wed;
+			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_RRO_BAND2],
+					       MT_RXQ_ID(MT_RXQ_RRO_BAND2),
+					       MT7996_RX_RING_SIZE,
+					       MT7996_RX_BUF_SIZE,
+					       MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND2) + hif1_ofs);
+			if (ret)
+				return ret;
+
+			/* tx free notify event from MAC for band2 */
+			if (mtk_wed_device_active(wed_hif2)) {
+				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND2].flags = MT_WED_Q_TXFREE;
+				dev->mt76.q_rx[MT_RXQ_TXFREE_BAND2].wed = wed_hif2;
+			}
+			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND2],
+					       MT_RXQ_ID(MT_RXQ_TXFREE_BAND2),
+					       MT7996_RX_MCU_RING_SIZE,
+					       MT7996_RX_BUF_SIZE,
+					       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND2) + hif1_ofs);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index de87493f8a7a..878e3856583a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -315,8 +315,13 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 
 	/* rro module init */
 	mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
-	mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 3);
-	mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 1);
+	if (dev->has_rro) {
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 1);
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 0);
+	} else {
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_BYPASS_MODE, 3);
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_TXFREE_PATH, 1);
+	}
 
 	mt7996_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
 			  MCU_WA_PARAM_HW_PATH_HIF_VER,
@@ -470,6 +475,120 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 	msleep(20);
 }
 
+static int mt7996_wed_rro_init(struct mt7996_dev *dev)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
+	struct mt7996_wed_rro_addr *addr;
+	void *ptr;
+	int i;
+
+	if (!dev->has_rro)
+		return 0;
+
+	if (!mtk_wed_device_active(wed))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.ba_bitmap); i++) {
+		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+					  MT7996_RRO_BA_BITMAP_CR_SIZE,
+					  &dev->wed_rro.ba_bitmap[i].phy_addr,
+					  GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+
+		dev->wed_rro.ba_bitmap[i].ptr = ptr;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
+		int j;
+
+		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+				MT7996_RRO_WINDOW_MAX_SIZE * sizeof(*addr),
+				&dev->wed_rro.addr_elem[i].phy_addr,
+				GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+
+		dev->wed_rro.addr_elem[i].ptr = ptr;
+		memset(dev->wed_rro.addr_elem[i].ptr, 0,
+		       MT7996_RRO_WINDOW_MAX_SIZE * sizeof(*addr));
+
+		addr = dev->wed_rro.addr_elem[i].ptr;
+		for (j = 0; j < MT7996_RRO_WINDOW_MAX_SIZE; j++) {
+			addr->signature = 0xff;
+			addr++;
+		}
+
+		wed->wlan.ind_cmd.addr_elem_phys[i] =
+			dev->wed_rro.addr_elem[i].phy_addr;
+	}
+
+	ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
+				  MT7996_RRO_WINDOW_MAX_LEN * sizeof(*addr),
+				  &dev->wed_rro.session.phy_addr,
+				  GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	dev->wed_rro.session.ptr = ptr;
+	addr = dev->wed_rro.session.ptr;
+	for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
+		addr->signature = 0xff;
+		addr++;
+	}
+
+	/* rro hw init */
+	/* TODO: remove line after WM has set */
+	mt76_clear(dev, WF_RRO_AXI_MST_CFG, WF_RRO_AXI_MST_CFG_DIDX_OK);
+
+	/* setup BA bitmap cache address */
+	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE0,
+		dev->wed_rro.ba_bitmap[0].phy_addr);
+	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE1, 0);
+	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT0,
+		dev->wed_rro.ba_bitmap[1].phy_addr);
+	mt76_wr(dev, MT_RRO_BA_BITMAP_BASE_EXT1, 0);
+
+	/* setup Address element address */
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.addr_elem); i++) {
+		mt76_wr(dev, reg, dev->wed_rro.addr_elem[i].phy_addr >> 4);
+		reg += 4;
+	}
+
+	/* setup Address element address - separate address segment mode */
+	mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE1,
+		MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE);
+
+	wed->wlan.ind_cmd.win_size = ffs(MT7996_RRO_WINDOW_MAX_LEN) - 6;
+	wed->wlan.ind_cmd.particular_sid = MT7996_RRO_MAX_SESSION;
+	wed->wlan.ind_cmd.particular_se_phys = dev->wed_rro.session.phy_addr;
+	wed->wlan.ind_cmd.se_group_nums = MT7996_RRO_ADDR_ELEM_LEN;
+	wed->wlan.ind_cmd.ack_sn_addr = MT_RRO_ACK_SN_CTRL;
+
+	mt76_wr(dev, MT_RRO_IND_CMD_SIGNATURE_BASE0, 0x15010e00);
+	mt76_set(dev, MT_RRO_IND_CMD_SIGNATURE_BASE1,
+		 MT_RRO_IND_CMD_SIGNATURE_BASE1_EN);
+
+	/* particular session configure */
+	/* use max session idx + 1 as particular session id */
+	mt76_wr(dev, MT_RRO_PARTICULAR_CFG0, dev->wed_rro.session.phy_addr);
+	mt76_wr(dev, MT_RRO_PARTICULAR_CFG1,
+		MT_RRO_PARTICULAR_CONFG_EN |
+		FIELD_PREP(MT_RRO_PARTICULAR_SID, MT7996_RRO_MAX_SESSION));
+
+	/* interrupt enable */
+	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
+		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
+
+	/* rro ind cmd queue init */
+	return mt7996_dma_rro_init(dev);
+#else
+	return 0;
+#endif
+}
+
 static int mt7996_init_hardware(struct mt7996_dev *dev)
 {
 	int ret, idx;
@@ -491,6 +610,10 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7996_wed_rro_init(dev);
+	if (ret)
+		return ret;
+
 	ret = mt7996_eeprom_init(dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2ab93241e3d7..4fecef94b317 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -449,8 +449,36 @@ mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
 	return 0;
 }
 
+static void
+mt7996_wed_check_ppe(struct mt7996_dev *dev, struct mt76_queue *q,
+		     struct mt7996_sta *msta, struct sk_buff *skb,
+		     u32 info)
+{
+	struct ieee80211_vif *vif;
+	struct wireless_dev *wdev;
+
+	if (!msta || !msta->vif)
+		return;
+
+	if (!mt76_queue_is_wed_rx(q))
+		return;
+
+	if (!(info & MT_DMA_INFO_PPE_VLD))
+		return;
+
+	vif = container_of((void *)msta->vif, struct ieee80211_vif,
+			   drv_priv);
+	wdev = ieee80211_vif_to_wdev(vif);
+	skb->dev = wdev->netdev;
+
+	mtk_wed_device_ppe_check(&dev->mt76.mmio.wed, skb,
+				 FIELD_GET(MT_DMA_PPE_CPU_REASON, info),
+				 FIELD_GET(MT_DMA_PPE_ENTRY, info));
+}
+
 static int
-mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
+mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
+		   struct sk_buff *skb, u32 *info)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -475,7 +503,10 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	int idx;
+	u8 hw_aggr = false;
+	struct mt7996_sta *msta = NULL;
 
+	hw_aggr = status->aggr;
 	memset(status, 0, sizeof(*status));
 
 	band_idx = FIELD_GET(MT_RXD1_NORMAL_BAND_IDX, rxd1);
@@ -502,8 +533,6 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	status->wcid = mt7996_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		struct mt7996_sta *msta;
-
 		msta = container_of(status->wcid, struct mt7996_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->wcid.poll_list))
@@ -708,12 +737,14 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 		}
 	} else {
 		status->flag |= RX_FLAG_8023;
+		mt7996_wed_check_ppe(dev, &dev->mt76.q_rx[q], msta, skb,
+				     *info);
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
 
-	if (!status->wcid || !ieee80211_is_data_qos(fc))
+	if (!status->wcid || !ieee80211_is_data_qos(fc) || hw_aggr)
 		return 0;
 
 	status->aggr = unicast &&
@@ -1428,7 +1459,7 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_NORMAL:
-		if (!mt7996_mac_fill_rx(dev, skb)) {
+		if (!mt7996_mac_fill_rx(dev, q, skb, info)) {
 			mt76_rx(&dev->mt76, q, skb);
 			return;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 12bf4e5038b5..3ff70c6d4c17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -912,7 +912,7 @@ int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
 }
 
 static int
-mt7996_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif *mvif,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
@@ -921,7 +921,7 @@ mt7996_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, mvif, wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -935,8 +935,9 @@ mt7996_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 	ba->ba_en = enable << params->tid;
 	ba->amsdu = params->amsdu;
 	ba->tid = params->tid;
+	ba->ba_rdd_rro = !tx && enable && dev->has_rro;
 
-	return mt76_mcu_skb_send_msg(dev, skb,
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
 
@@ -951,8 +952,7 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	return mt7996_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
-				 enable, true);
+	return mt7996_mcu_sta_ba(dev, &mvif->mt76, params, enable, true);
 }
 
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
@@ -962,8 +962,7 @@ int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
 	struct mt7996_vif *mvif = msta->vif;
 
-	return mt7996_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
-				 enable, false);
+	return mt7996_mcu_sta_ba(dev, &mvif->mt76, params, enable, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index ae029ae9969d..c7b6d4bd2ded 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -207,6 +207,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	if (!wed_enable)
 		return 0;
 
+	dev->has_rro = true;
+
 	hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
 	if (hif2)
@@ -228,14 +230,27 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.wpdma_tx = wed->wlan.phy_base + hif1_ofs +
 					     MT_TXQ_RING_BASE(0) +
 					     MT7996_TXQ_BAND2 * MT_RING_SIZE;
-		wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
-					 MT_RXQ_RING_BASE(0) +
-					 MT7996_RXQ_MCU_WA_TRI * MT_RING_SIZE;
-		wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_TRI) - 1;
+		if (dev->has_rro) {
+			wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
+						 MT_RXQ_RING_BASE(0) +
+						 MT7996_RXQ_TXFREE2 * MT_RING_SIZE;
+			wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_EXT) - 1;
+		} else {
+			wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
+						 MT_RXQ_RING_BASE(0) +
+						 MT7996_RXQ_MCU_WA_TRI * MT_RING_SIZE;
+			wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_TRI) - 1;
+		}
+
+		wed->wlan.wpdma_rx_glo = wed->wlan.phy_base + hif1_ofs + MT_WFDMA0_GLO_CFG;
+		wed->wlan.wpdma_rx = wed->wlan.phy_base + hif1_ofs +
+				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
+				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
 
 		wed->wlan.id = 0x7991;
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND2) - 1;
 	} else {
+		wed->wlan.hw_rro = dev->has_rro; /* default on */
 		wed->wlan.wpdma_int = wed->wlan.phy_base + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = wed->wlan.phy_base + MT_INT_MASK_CSR;
 		wed->wlan.wpdma_tx = wed->wlan.phy_base + MT_TXQ_RING_BASE(0) +
@@ -247,6 +262,16 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
 				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
 
+		wed->wlan.wpdma_rx_rro[0] = wed->wlan.phy_base +
+					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND0) +
+					    MT7996_RXQ_RRO_BAND0 * MT_RING_SIZE;
+		wed->wlan.wpdma_rx_rro[1] = wed->wlan.phy_base + hif1_ofs +
+					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND2) +
+					    MT7996_RXQ_RRO_BAND2 * MT_RING_SIZE;
+		wed->wlan.wpdma_rx_pg = wed->wlan.phy_base +
+					MT_RXQ_RING_BASE(MT7996_RXQ_MSDU_PG_BAND0) +
+					MT7996_RXQ_MSDU_PG_BAND0 * MT_RING_SIZE;
+
 		wed->wlan.rx_nbuf = 65536;
 		wed->wlan.rx_npkt = dev->hif2 ? 32768 : 24576;
 		wed->wlan.rx_size = SKB_WITH_OVERHEAD(MT_RX_BUF_SIZE);
@@ -254,11 +279,25 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.rx_tbit[0] = ffs(MT_INT_RX_DONE_BAND0) - 1;
 		wed->wlan.rx_tbit[1] = ffs(MT_INT_RX_DONE_BAND2) - 1;
 
+		wed->wlan.rro_rx_tbit[0] = ffs(MT_INT_RX_DONE_RRO_BAND0) - 1;
+		wed->wlan.rro_rx_tbit[1] = ffs(MT_INT_RX_DONE_RRO_BAND2) - 1;
+
+		wed->wlan.rx_pg_tbit[0] = ffs(MT_INT_RX_DONE_MSDU_PG_BAND0) - 1;
+		wed->wlan.rx_pg_tbit[1] = ffs(MT_INT_RX_DONE_MSDU_PG_BAND1) - 1;
+		wed->wlan.rx_pg_tbit[2] = ffs(MT_INT_RX_DONE_MSDU_PG_BAND2) - 1;
+
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND0) - 1;
 		wed->wlan.tx_tbit[1] = ffs(MT_INT_TX_DONE_BAND1) - 1;
-		wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_MAIN) - 1;
-		wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
-					  MT7996_RXQ_MCU_WA_MAIN * MT_RING_SIZE;
+		if (dev->has_rro) {
+			wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
+						 MT7996_RXQ_TXFREE0 * MT_RING_SIZE;
+			wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_MAIN) - 1;
+		} else {
+			wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_MAIN) - 1;
+			wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
+						  MT7996_RXQ_MCU_WA_MAIN * MT_RING_SIZE;
+		}
+		dev->mt76.rx_token_size = MT7996_TOKEN_SIZE + wed->wlan.rx_npkt;
 	}
 
 	wed->wlan.nbuf = MT7996_HW_TOKEN_SIZE;
@@ -273,8 +312,6 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
 
-	dev->mt76.rx_token_size += wed->wlan.rx_npkt;
-
 	if (mtk_wed_device_attach(wed))
 		return 0;
 
@@ -434,10 +471,9 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 irqreturn_t mt7996_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7996_dev *dev = dev_instance;
-	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	if (mtk_wed_device_active(wed))
-		mtk_wed_device_irq_set_mask(wed, 0);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mtk_wed_device_irq_set_mask(&dev->mt76.mmio.wed, 0);
 	else
 		mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 470a54139831..c541eaa4a4e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -50,6 +50,22 @@
 #define MT7996_BASIC_RATES_TBL		11
 #define MT7996_BEACON_RATES_TBL		25
 
+#define MT7996_RRO_MAX_SESSION		1024
+#define MT7996_RRO_WINDOW_MAX_LEN	1024
+#define MT7996_RRO_ADDR_ELEM_LEN	128
+#define MT7996_RRO_BA_BITMAP_LEN	2
+#define MT7996_RRO_BA_BITMAP_CR_SIZE	((MT7996_RRO_MAX_SESSION * 128) /	\
+					 MT7996_RRO_BA_BITMAP_LEN)
+#define MT7996_RRO_BA_BITMAP_SESSION_SIZE	(MT7996_RRO_MAX_SESSION /	\
+						 MT7996_RRO_ADDR_ELEM_LEN)
+#define MT7996_RRO_WINDOW_MAX_SIZE	(MT7996_RRO_WINDOW_MAX_LEN *		\
+					 MT7996_RRO_BA_BITMAP_SESSION_SIZE)
+
+#define MT7996_RX_BUF_SIZE		(1800 + \
+					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define MT7996_RX_MSDU_PAGE_SIZE	(128 + \
+					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 struct mt7996_vif;
 struct mt7996_sta;
 struct mt7996_dfs_pulse;
@@ -79,6 +95,16 @@ enum mt7996_rxq_id {
 	MT7996_RXQ_BAND0 = 4,
 	MT7996_RXQ_BAND1 = 4,/* unused */
 	MT7996_RXQ_BAND2 = 5,
+	MT7996_RXQ_RRO_BAND0 = 8,
+	MT7996_RXQ_RRO_BAND1 = 8,/* unused */
+	MT7996_RXQ_RRO_BAND2 = 6,
+	MT7996_RXQ_MSDU_PG_BAND0 = 10,
+	MT7996_RXQ_MSDU_PG_BAND1 = 11,
+	MT7996_RXQ_MSDU_PG_BAND2 = 12,
+	MT7996_RXQ_TXFREE0 = 9,
+	MT7996_RXQ_TXFREE1 = 9,
+	MT7996_RXQ_TXFREE2 = 7,
+	MT7996_RXQ_RRO_IND = 0,
 };
 
 struct mt7996_twt_flow {
@@ -148,6 +174,15 @@ struct mt7996_hif {
 	int irq;
 };
 
+struct mt7996_wed_rro_addr {
+	u32 head_low;
+	u32 head_high : 4;
+	u32 count: 11;
+	u32 oor: 1;
+	u32 rsv : 8;
+	u32 signature : 8;
+};
+
 struct mt7996_phy {
 	struct mt76_phy *mt76;
 	struct mt7996_dev *dev;
@@ -227,6 +262,22 @@ struct mt7996_dev {
 	bool tbtc_support:1;
 	bool flash_mode:1;
 	bool has_eht:1;
+	bool has_rro:1;
+
+	struct {
+		struct {
+			void *ptr;
+			dma_addr_t phy_addr;
+		} ba_bitmap[MT7996_RRO_BA_BITMAP_LEN];
+		struct {
+			void *ptr;
+			dma_addr_t phy_addr;
+		} addr_elem[MT7996_RRO_ADDR_ELEM_LEN];
+		struct {
+			void *ptr;
+			dma_addr_t phy_addr;
+		} session;
+	} wed_rro;
 
 	bool ibf;
 	u8 fw_debug_wm;
@@ -506,4 +557,8 @@ u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
 int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 #endif
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+int mt7996_dma_rro_init(struct mt7996_dev *dev);
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 04d6dc56c049..854390dcd86e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -39,6 +39,38 @@ enum base_rev {
 
 #define __BASE(_id, _band)			(dev->reg.base[(_id)].band_base[(_band)])
 
+/* RRO TOP */
+#define MT_RRO_TOP_BASE				0xA000
+#define MT_RRO_TOP(ofs)				(MT_RRO_TOP_BASE + (ofs))
+
+#define MT_RRO_BA_BITMAP_BASE0			MT_RRO_TOP(0x8)
+#define MT_RRO_BA_BITMAP_BASE1			MT_RRO_TOP(0xC)
+#define WF_RRO_AXI_MST_CFG			MT_RRO_TOP(0xB8)
+#define WF_RRO_AXI_MST_CFG_DIDX_OK		BIT(12)
+#define MT_RRO_ADDR_ARRAY_BASE1			MT_RRO_TOP(0x34)
+#define MT_RRO_ADDR_ARRAY_ELEM_ADDR_SEG_MODE	BIT(31)
+
+#define MT_RRO_IND_CMD_SIGNATURE_BASE0		MT_RRO_TOP(0x38)
+#define MT_RRO_IND_CMD_SIGNATURE_BASE1		MT_RRO_TOP(0x3C)
+#define MT_RRO_IND_CMD_0_CTRL0			MT_RRO_TOP(0x40)
+#define MT_RRO_IND_CMD_SIGNATURE_BASE1_EN	BIT(31)
+
+#define MT_RRO_PARTICULAR_CFG0			MT_RRO_TOP(0x5C)
+#define MT_RRO_PARTICULAR_CFG1			MT_RRO_TOP(0x60)
+#define MT_RRO_PARTICULAR_CONFG_EN		BIT(31)
+#define MT_RRO_PARTICULAR_SID			GENMASK(30, 16)
+
+#define MT_RRO_BA_BITMAP_BASE_EXT0		MT_RRO_TOP(0x70)
+#define MT_RRO_BA_BITMAP_BASE_EXT1		MT_RRO_TOP(0x74)
+#define MT_RRO_HOST_INT_ENA			MT_RRO_TOP(0x204)
+#define MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA   BIT(0)
+
+#define MT_RRO_ADDR_ELEM_SEG_ADDR0		MT_RRO_TOP(0x400)
+
+#define MT_RRO_ACK_SN_CTRL			MT_RRO_TOP(0x50)
+#define MT_RRO_ACK_SN_CTRL_SN_MASK		GENMASK(27, 16)
+#define MT_RRO_ACK_SN_CTRL_SESSION_MASK		GENMASK(11, 0)
+
 #define MT_MCU_INT_EVENT			0x2108
 #define MT_MCU_INT_EVENT_DMA_STOPPED		BIT(0)
 #define MT_MCU_INT_EVENT_DMA_INIT		BIT(1)
@@ -391,6 +423,7 @@ enum base_rev {
 #define MT_MCUQ_RING_BASE(q)			(MT_Q_BASE(q) + 0x300)
 #define MT_TXQ_RING_BASE(q)			(MT_Q_BASE(__TXQ(q)) + 0x300)
 #define MT_RXQ_RING_BASE(q)			(MT_Q_BASE(__RXQ(q)) + 0x500)
+#define MT_RXQ_RRO_IND_RING_BASE		MT_RRO_TOP(0x40)
 
 #define MT_MCUQ_EXT_CTRL(q)			(MT_Q_BASE(q) +	0x600 +	\
 						 MT_MCUQ_ID(q) * 0x4)
@@ -418,6 +451,14 @@ enum base_rev {
 #define MT_INT_MCU_CMD				BIT(29)
 #define MT_INT_RX_TXFREE_EXT			BIT(26)
 
+#define MT_INT_RX_DONE_RRO_BAND0		BIT(16)
+#define MT_INT_RX_DONE_RRO_BAND1		BIT(16)
+#define MT_INT_RX_DONE_RRO_BAND2		BIT(14)
+#define MT_INT_RX_DONE_RRO_IND			BIT(11)
+#define MT_INT_RX_DONE_MSDU_PG_BAND0		BIT(18)
+#define MT_INT_RX_DONE_MSDU_PG_BAND1		BIT(19)
+#define MT_INT_RX_DONE_MSDU_PG_BAND2		BIT(23)
+
 #define MT_INT_RX(q)				(dev->q_int_mask[__RXQ(q)])
 #define MT_INT_TX_MCU(q)			(dev->q_int_mask[(q)])
 
@@ -425,20 +466,31 @@ enum base_rev {
 						 MT_INT_RX(MT_RXQ_MCU_WA))
 
 #define MT_INT_BAND0_RX_DONE			(MT_INT_RX(MT_RXQ_MAIN) |	\
-						 MT_INT_RX(MT_RXQ_MAIN_WA))
+						 MT_INT_RX(MT_RXQ_MAIN_WA) |	\
+						 MT_INT_RX(MT_RXQ_TXFREE_BAND0))
 
 #define MT_INT_BAND1_RX_DONE			(MT_INT_RX(MT_RXQ_BAND1) |	\
 						 MT_INT_RX(MT_RXQ_BAND1_WA) |	\
-						 MT_INT_RX(MT_RXQ_MAIN_WA))
+						 MT_INT_RX(MT_RXQ_MAIN_WA) |	\
+						 MT_INT_RX(MT_RXQ_TXFREE_BAND0))
 
 #define MT_INT_BAND2_RX_DONE			(MT_INT_RX(MT_RXQ_BAND2) |	\
 						 MT_INT_RX(MT_RXQ_BAND2_WA) |	\
-						 MT_INT_RX(MT_RXQ_MAIN_WA))
+						 MT_INT_RX(MT_RXQ_MAIN_WA) |	\
+						 MT_INT_RX(MT_RXQ_TXFREE_BAND0))
+
+#define MT_INT_RRO_RX_DONE			(MT_INT_RX(MT_RXQ_RRO_BAND0) |		\
+						 MT_INT_RX(MT_RXQ_RRO_BAND1) |		\
+						 MT_INT_RX(MT_RXQ_RRO_BAND2) |		\
+						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND0) |	\
+						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND1) |	\
+						 MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND2))
 
 #define MT_INT_RX_DONE_ALL			(MT_INT_RX_DONE_MCU |		\
 						 MT_INT_BAND0_RX_DONE |		\
 						 MT_INT_BAND1_RX_DONE |		\
-						 MT_INT_BAND2_RX_DONE)
+						 MT_INT_BAND2_RX_DONE |		\
+						 MT_INT_RRO_RX_DONE)
 
 #define MT_INT_TX_DONE_FWDL			BIT(26)
 #define MT_INT_TX_DONE_MCU_WM			BIT(27)
-- 
2.41.0

