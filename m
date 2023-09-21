Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F67AA17C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjIUVDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjIUVCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63B7EA39
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEC4C36AEE;
        Thu, 21 Sep 2023 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293043;
        bh=DYVOEi5xVZo8aLe1A7iq0Anonq1a7Z/3pm3PIcGtfq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUe3CNsZ8U8QVPMdObNYUvIgJagin7e3Lvhrx8h05FmvbDfD908wrmhf8NxxeOLJF
         Q9Up/ff5GdoJzcQ029+rFBD9Fke/vwAccb7Ig0x22T61n8NLiTD2QLJ+ySZP4cjHEL
         x0BOf+LzreaSo558PUlhJalpjlGGik1wVicsPl1eLFDkaL4+1M4nbfl0lGkNvFObcA
         Z9DOPMAN36hzzAoDLhst28oZBbkaaoYoViD96heEQyp3ZWiF2HOleAJAs7BlKmbvlM
         OgB+PF6LAWqSxFjO1e5DNDou3PNmLFmzh+6KTL8u9A5CzvaO9IdB3F6kvWZwHyEVio
         p6MpuBfqMBN0w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 5/9] wifi: mt76: introduce wed pointer in mt76_queue
Date:   Thu, 21 Sep 2023 12:43:34 +0200
Message-ID: <35d29fc66f8e737f6daa7f40747aaae3b0e19d9c.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mtk_wed_device pointer in mt76_queue structure in order to
configure WED chip.
Get rid of dev parameter in Q_READ and Q_WRITE macros.
Introduce wed parameter to the following routine signatures:
- mt76_init_queue
- mt76_init_tx_queue

This is a preliminary patch to introduce WED support for mt7996 since
mt7996 runs two separate WED chips.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 49 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 ++--
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  9 ++--
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 16 ++++--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  3 +-
 13 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f62b6af4316b..80f46d988dc9 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -9,11 +9,11 @@
 
 #if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
 
-#define Q_READ(_dev, _q, _field) ({					\
+#define Q_READ(_q, _field) ({						\
 	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
 	u32 _val;							\
 	if ((_q)->flags & MT_QFLAG_WED)					\
-		_val = mtk_wed_device_reg_read(&(_dev)->mmio.wed,	\
+		_val = mtk_wed_device_reg_read((_q)->wed,		\
 					       ((_q)->wed_regs +	\
 					        _offset));		\
 	else								\
@@ -21,10 +21,10 @@
 	_val;								\
 })
 
-#define Q_WRITE(_dev, _q, _field, _val)	do {				\
+#define Q_WRITE(_q, _field, _val)	do {				\
 	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
 	if ((_q)->flags & MT_QFLAG_WED)					\
-		mtk_wed_device_reg_write(&(_dev)->mmio.wed,		\
+		mtk_wed_device_reg_write((_q)->wed,			\
 					 ((_q)->wed_regs + _offset),	\
 					 _val);				\
 	else								\
@@ -33,8 +33,8 @@
 
 #else
 
-#define Q_READ(_dev, _q, _field)	readl(&(_q)->regs->_field)
-#define Q_WRITE(_dev, _q, _field, _val)	writel(_val, &(_q)->regs->_field)
+#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
+#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)
 
 #endif
 
@@ -188,9 +188,9 @@ EXPORT_SYMBOL_GPL(mt76_free_pending_rxwi);
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	Q_WRITE(dev, q, desc_base, q->desc_dma);
-	Q_WRITE(dev, q, ring_size, q->ndesc);
-	q->head = Q_READ(dev, q, dma_idx);
+	Q_WRITE(q, desc_base, q->desc_dma);
+	Q_WRITE(q, ring_size, q->ndesc);
+	q->head = Q_READ(q, dma_idx);
 	q->tail = q->head;
 }
 
@@ -206,8 +206,8 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 	for (i = 0; i < q->ndesc; i++)
 		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 
-	Q_WRITE(dev, q, cpu_idx, 0);
-	Q_WRITE(dev, q, dma_idx, 0);
+	Q_WRITE(q, cpu_idx, 0);
+	Q_WRITE(q, dma_idx, 0);
 	mt76_dma_sync_idx(dev, q);
 }
 
@@ -343,7 +343,7 @@ static void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	wmb();
-	Q_WRITE(dev, q, cpu_idx, q->head);
+	Q_WRITE(q, cpu_idx, q->head);
 }
 
 static void
@@ -359,7 +359,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 	if (flush)
 		last = -1;
 	else
-		last = Q_READ(dev, q, dma_idx);
+		last = Q_READ(q, dma_idx);
 
 	while (q->queued > 0 && q->tail != last) {
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
@@ -371,7 +371,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		}
 
 		if (!flush && q->tail == last)
-			last = Q_READ(dev, q, dma_idx);
+			last = Q_READ(q, dma_idx);
 	}
 	spin_unlock_bh(&q->cleanup_lock);
 
@@ -641,7 +641,6 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	struct mtk_wed_device *wed = &dev->mmio.wed;
 	int ret, type, ring;
 	u8 flags;
 
@@ -649,7 +648,7 @@ int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 		return -EINVAL;
 
 	flags = q->flags;
-	if (!mtk_wed_device_active(wed))
+	if (!q->wed || !mtk_wed_device_active(q->wed))
 		q->flags &= ~MT_QFLAG_WED;
 
 	if (!(q->flags & MT_QFLAG_WED))
@@ -660,9 +659,10 @@ int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 
 	switch (type) {
 	case MT76_WED_Q_TX:
-		ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs, reset);
+		ret = mtk_wed_device_tx_ring_setup(q->wed, ring, q->regs,
+						   reset);
 		if (!ret)
-			q->wed_regs = wed->tx_ring[ring].reg_base;
+			q->wed_regs = q->wed->tx_ring[ring].reg_base;
 		break;
 	case MT76_WED_Q_TXFREE:
 		/* WED txfree queue needs ring to be initialized before setup */
@@ -671,14 +671,15 @@ int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 		mt76_dma_rx_fill(dev, q, false);
 		q->flags = flags;
 
-		ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
+		ret = mtk_wed_device_txfree_ring_setup(q->wed, q->regs);
 		if (!ret)
-			q->wed_regs = wed->txfree_ring.reg_base;
+			q->wed_regs = q->wed->txfree_ring.reg_base;
 		break;
 	case MT76_WED_Q_RX:
-		ret = mtk_wed_device_rx_ring_setup(wed, ring, q->regs, reset);
+		ret = mtk_wed_device_rx_ring_setup(q->wed, ring, q->regs,
+						   reset);
 		if (!ret)
-			q->wed_regs = wed->rx_ring[ring].reg_base;
+			q->wed_regs = q->wed->rx_ring[ring].reg_base;
 		break;
 	default:
 		ret = -EINVAL;
@@ -817,7 +818,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 
 	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
 	    mt76_queue_is_wed_tx_free(q)) {
-		dma_idx = Q_READ(dev, q, dma_idx);
+		dma_idx = Q_READ(q, dma_idx);
 		check_ddone = true;
 	}
 
@@ -827,7 +828,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 
 		if (check_ddone) {
 			if (q->tail == dma_idx)
-				dma_idx = Q_READ(dev, q, dma_idx);
+				dma_idx = Q_READ(q, dma_idx);
 
 			if (q->tail == dma_idx)
 				break;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 15c4ca664b3a..6ee7be6eaab8 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1725,7 +1725,7 @@ EXPORT_SYMBOL_GPL(mt76_get_antenna);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-		int ring_base, u32 flags)
+		int ring_base, void *wed, u32 flags)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -1735,6 +1735,7 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		return ERR_PTR(-ENOMEM);
 
 	hwq->flags = flags;
+	hwq->wed = wed;
 
 	err = dev->queue_ops->alloc(dev, hwq, idx, n_desc, 0, ring_base);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4ce3a0def8fb..61b8d082cd0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -199,6 +199,7 @@ struct mt76_queue {
 	u8 hw_idx;
 	u8 flags;
 
+	struct mtk_wed_device *wed;
 	u32 wed_regs;
 
 	dma_addr_t desc_dma;
@@ -1119,15 +1120,16 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-		int ring_base, u32 flags);
+		int ring_base, void *wed, u32 flags);
 u16 mt76_calculate_default_rate(struct mt76_phy *phy,
 				struct ieee80211_vif *vif, int rateidx);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
-				     int n_desc, int ring_base, u32 flags)
+				     int n_desc, int ring_base, void *wed,
+				     u32 flags)
 {
 	struct mt76_queue *q;
 
-	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base, flags);
+	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base, wed, flags);
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
@@ -1141,7 +1143,7 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 {
 	struct mt76_queue *q;
 
-	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base, 0);
+	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base, NULL, 0);
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 03ba11a61c90..7a2f5d38562b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -173,13 +173,14 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
-					 MT7603_TX_RING_SIZE, MT_TX_RING_BASE, 0);
+					 MT7603_TX_RING_SIZE, MT_TX_RING_BASE,
+					 NULL, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
-				 MT7603_PSD_RING_SIZE, MT_TX_RING_BASE, 0);
+				 MT7603_PSD_RING_SIZE, MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
@@ -189,12 +190,12 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		return ret;
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_BEACON, MT_TX_HW_QUEUE_BCN,
-				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, 0);
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_CAB, MT_TX_HW_QUEUE_BMC,
-				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, 0);
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 0ce01ccc5dce..e7135b2f1742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -26,14 +26,14 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
 					 MT7615_TX_RING_SIZE / 2,
-					 MT_TX_RING_BASE, 0);
+					 MT_TX_RING_BASE, NULL, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT7622_TXQ_MGMT,
 				 MT7615_TX_MGMT_RING_SIZE,
-				 MT_TX_RING_BASE, 0);
+				 MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
@@ -55,7 +55,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 		return mt7622_init_tx_queues_multi(dev);
 
 	ret = mt76_connac_init_tx_queues(&dev->mphy, 0, MT7615_TX_RING_SIZE,
-					 MT_TX_RING_BASE, 0);
+					 MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 1f29d8cd900c..e5ebde19af8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -391,7 +391,8 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 
 void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
-			       int ring_base, u32 flags);
+			       int ring_base, void *wed, u32 flags);
+
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 93402d2c2538..c7914643e9c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -256,11 +256,12 @@ void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
 EXPORT_SYMBOL_GPL(mt76_connac_txp_skb_unmap);
 
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
-			       int ring_base, u32 flags)
+			       int ring_base, void *wed, u32 flags)
 {
 	int i, err;
 
-	err = mt76_init_tx_queue(phy, 0, idx, n_desc, ring_base, flags);
+	err = mt76_init_tx_queue(phy, 0, idx, n_desc, ring_base,
+				 wed, flags);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 9b5e3fb7b0df..e5ad635d3c56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -199,13 +199,14 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, mt76_ac_to_hwq(i),
 					 MT76x02_TX_RING_SIZE,
-					 MT_TX_RING_BASE, 0);
+					 MT_TX_RING_BASE, NULL, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
-				 MT76x02_PSD_RING_SIZE, MT_TX_RING_BASE, 0);
+				 MT76x02_PSD_RING_SIZE, MT_TX_RING_BASE,
+				 NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 96b2c3802ac1..1bceeb5227b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -9,18 +9,20 @@ static int
 mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
 {
 	struct mt7915_dev *dev = phy->dev;
+	struct mtk_wed_device *wed = NULL;
 
-	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 		if (is_mt798x(&dev->mt76))
 			ring_base += MT_TXQ_ID(0) * MT_RING_SIZE;
 		else
 			ring_base = MT_WED_TX_RING_BASE;
 
 		idx -= MT_TXQ_ID(0);
+		wed = &dev->mt76.mmio.wed;
 	}
 
 	return mt76_connac_init_tx_queues(phy->mt76, idx, n_desc, ring_base,
-					  MT_WED_Q_TX(idx));
+					  wed, MT_WED_Q_TX(idx));
 }
 
 static int mt7915_poll_tx(struct napi_struct *napi, int budget)
@@ -492,7 +494,8 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	if (mtk_wed_device_active(&mdev->mmio.wed) && is_mt7915(mdev)) {
 		wa_rx_base = MT_WED_RX_RING_BASE;
 		wa_rx_idx = MT7915_RXQ_MCU_WA;
-		dev->mt76.q_rx[MT_RXQ_MCU_WA].flags = MT_WED_Q_TXFREE;
+		mdev->q_rx[MT_RXQ_MCU_WA].flags = MT_WED_Q_TXFREE;
+		mdev->q_rx[MT_RXQ_MCU_WA].wed = &mdev->mmio.wed;
 	} else {
 		wa_rx_base = MT_RXQ_RING_BASE(MT_RXQ_MCU_WA);
 		wa_rx_idx = MT_RXQ_ID(MT_RXQ_MCU_WA);
@@ -507,9 +510,10 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	if (!dev->phy.mt76->band_idx) {
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
-			dev->mt76.q_rx[MT_RXQ_MAIN].flags =
+			mdev->q_rx[MT_RXQ_MAIN].flags =
 				MT_WED_Q_RX(MT7915_RXQ_BAND0);
 			dev->mt76.rx_token_size += MT7915_RX_RING_SIZE;
+			mdev->q_rx[MT_RXQ_MAIN].wed = &mdev->mmio.wed;
 		}
 
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
@@ -528,6 +532,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 		if (mtk_wed_device_active(&mdev->mmio.wed)) {
 			mdev->q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
+			mdev->q_rx[MT_RXQ_MAIN_WA].wed = &mdev->mmio.wed;
 			if (is_mt7916(mdev)) {
 				wa_rx_base =  MT_WED_RX_RING_BASE;
 				wa_rx_idx = MT7915_RXQ_MCU_WA;
@@ -544,9 +549,10 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	if (dev->dbdc_support || dev->phy.mt76->band_idx) {
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
-			dev->mt76.q_rx[MT_RXQ_BAND1].flags =
+			mdev->q_rx[MT_RXQ_BAND1].flags =
 				MT_WED_Q_RX(MT7915_RXQ_BAND1);
 			dev->mt76.rx_token_size += MT7915_RX_RING_SIZE;
+			mdev->q_rx[MT_RXQ_BAND1].wed = &mdev->mmio.wed;
 		}
 
 		/* rx data queue for band1 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f04e7095e181..6f83c4c5fce2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -171,7 +171,7 @@ static int mt7921_dma_init(struct mt792x_dev *dev)
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
 					 MT7921_TX_RING_SIZE,
-					 MT_TX_RING_BASE, 0);
+					 MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 08ef75e24e1c..734f31ee40d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -218,7 +218,7 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7925_TXQ_BAND0,
 					 MT7925_TX_RING_SIZE,
-					 MT_TX_RING_BASE, 0);
+					 MT_TX_RING_BASE, NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 586e247a1e06..b33346360075 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -268,7 +268,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76,
 					 MT_TXQ_ID(dev->mphy.band_idx),
 					 MT7996_TX_RING_SIZE,
-					 MT_TXQ_RING_BASE(0), 0);
+					 MT_TXQ_RING_BASE(0), NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index e4bb22b84159..c87dcb6a7c41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -400,7 +400,8 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	ret = mt76_connac_init_tx_queues(phy->mt76,
 					 MT_TXQ_ID(band),
 					 MT7996_TX_RING_SIZE,
-					 MT_TXQ_RING_BASE(band) + hif1_ofs, 0);
+					 MT_TXQ_RING_BASE(band) + hif1_ofs,
+					 NULL, 0);
 	if (ret)
 		goto error;
 
-- 
2.41.0

