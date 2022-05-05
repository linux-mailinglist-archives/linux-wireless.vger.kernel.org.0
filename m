Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEC51BE3D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358450AbiEELmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358259AbiEELl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 07:41:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A30517F0
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fB8FEjFX4BBqsGBPAaIztjMEBuxjBwr309owGKhcDkQ=; b=axiU4egFUzKcWtK0SgrRBZL4hW
        aWYtv12DSdeTRi88wOMjhtYf7i5e//j3gR1zgNLNtgIXedOnaRS9Yis0RFqT/VXaxOwiNA66VavpN
        GfniImBbVhLODOBuP9cK4fMyMG+h4GIEdZTWlr2Z49Y4yYkLrISmRuoc3Qym3w+uSCvM=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmZo9-0007Ts-Oq
        for linux-wireless@vger.kernel.org; Thu, 05 May 2022 13:38:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7915: add Wireless Ethernet Dispatch support
Date:   Thu,  5 May 2022 13:37:29 +0200
Message-Id: <20220505113729.50380-4-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113729.50380-1-nbd@nbd.name>
References: <20220505113729.50380-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is used to support hardware flow offloading from Ethernet to WLAN

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 160 ++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mac80211.c |   4 +-
 drivers/net/wireless/mediatek/mt76/mmio.c     |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  30 +++-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  43 ++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 129 +++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |   2 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  36 ++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  29 +++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  96 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  17 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  16 +-
 18 files changed, 502 insertions(+), 94 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 83787fc01e4e..30de8be4aac1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -7,9 +7,36 @@
 #include "mt76.h"
 #include "dma.h"
 
-#define Q_READ(_dev, _q, _field)		readl(&(_q)->regs->_field)
-#define Q_WRITE(_dev, _q, _field, _val)		writel(_val, &(_q)->regs->_field)
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+
+#define Q_READ(_dev, _q, _field) ({					\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	u32 _val;							\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		_val = mtk_wed_device_reg_read(&(_dev)->mmio.wed,	\
+					       ((_q)->wed_regs +	\
+					        _offset));		\
+	else								\
+		_val = readl(&(_q)->regs->_field);			\
+	_val;								\
+})
+
+#define Q_WRITE(_dev, _q, _field, _val)	do {				\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		mtk_wed_device_reg_write(&(_dev)->mmio.wed,		\
+					 ((_q)->wed_regs + _offset),	\
+					 _val);				\
+	else								\
+		writel(_val, &(_q)->regs->_field);			\
+} while (0)
+
+#else
+
+#define Q_READ(_dev, _q, _field)	readl(&(_q)->regs->_field)
+#define Q_WRITE(_dev, _q, _field, _val)	writel(_val, &(_q)->regs->_field)
 
+#endif
 
 static struct mt76_txwi_cache *
 mt76_alloc_txwi(struct mt76_dev *dev)
@@ -111,36 +138,6 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 	mt76_dma_sync_idx(dev, q);
 }
 
-static int
-mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
-		     int idx, int n_desc, int bufsize,
-		     u32 ring_base)
-{
-	int size;
-
-	spin_lock_init(&q->lock);
-	spin_lock_init(&q->cleanup_lock);
-
-	q->regs = dev->mmio.regs + ring_base + idx * MT_RING_SIZE;
-	q->ndesc = n_desc;
-	q->buf_size = bufsize;
-	q->hw_idx = idx;
-
-	size = q->ndesc * sizeof(struct mt76_desc);
-	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
-	if (!q->desc)
-		return -ENOMEM;
-
-	size = q->ndesc * sizeof(*q->entry);
-	q->entry = devm_kzalloc(dev->dev, size, GFP_KERNEL);
-	if (!q->entry)
-		return -ENOMEM;
-
-	mt76_dma_queue_reset(dev, q);
-
-	return 0;
-}
-
 static int
 mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		 struct mt76_queue_buf *buf, int nbufs, u32 info,
@@ -486,6 +483,85 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 	return frames;
 }
 
+static int
+mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mmio.wed;
+	int ret, type, ring;
+	u8 flags = q->flags;
+
+	if (!mtk_wed_device_active(wed))
+		q->flags &= ~MT_QFLAG_WED;
+
+	if (!(q->flags & MT_QFLAG_WED))
+		return 0;
+
+	type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
+	ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
+
+	switch (type) {
+	case MT76_WED_Q_TX:
+		ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs);
+		if (!ret)
+			q->wed_regs = wed->tx_ring[ring].reg_base;
+		break;
+	case MT76_WED_Q_TXFREE:
+		/* WED txfree queue needs ring to be initialized before setup */
+		q->flags = 0;
+		mt76_dma_queue_reset(dev, q);
+		mt76_dma_rx_fill(dev, q);
+		q->flags = flags;
+
+		ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
+		if (!ret)
+			q->wed_regs = wed->txfree_ring.reg_base;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+#else
+	return 0;
+#endif
+}
+
+static int
+mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
+		     int idx, int n_desc, int bufsize,
+		     u32 ring_base)
+{
+	int ret, size;
+
+	spin_lock_init(&q->lock);
+	spin_lock_init(&q->cleanup_lock);
+
+	q->regs = dev->mmio.regs + ring_base + idx * MT_RING_SIZE;
+	q->ndesc = n_desc;
+	q->buf_size = bufsize;
+	q->hw_idx = idx;
+
+	size = q->ndesc * sizeof(struct mt76_desc);
+	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
+	if (!q->desc)
+		return -ENOMEM;
+
+	size = q->ndesc * sizeof(*q->entry);
+	q->entry = devm_kzalloc(dev->dev, size, GFP_KERNEL);
+	if (!q->entry)
+		return -ENOMEM;
+
+	ret = mt76_dma_wed_setup(dev, q);
+	if (ret)
+		return ret;
+
+	if (q->flags != MT_WED_Q_TXFREE)
+		mt76_dma_queue_reset(dev, q);
+
+	return 0;
+}
+
 static void
 mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 {
@@ -567,14 +643,29 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 static int
 mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 {
-	int len, data_len, done = 0;
+	int len, data_len, done = 0, dma_idx;
 	struct sk_buff *skb;
 	unsigned char *data;
+	bool check_ddone = false;
 	bool more;
 
+	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
+	    q->flags == MT_WED_Q_TXFREE) {
+		dma_idx = Q_READ(dev, q, dma_idx);
+		check_ddone = true;
+	}
+
 	while (done < budget) {
 		u32 info;
 
+		if (check_ddone) {
+			if (q->tail == dma_idx)
+				dma_idx = Q_READ(dev, q, dma_idx);
+
+			if (q->tail == dma_idx)
+				break;
+		}
+
 		data = mt76_dma_dequeue(dev, q, false, &len, &info, &more);
 		if (!data)
 			break;
@@ -715,5 +806,8 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	}
 
 	mt76_free_pending_txwi(dev);
+
+	if (mtk_wed_device_active(&dev->mmio.wed))
+		mtk_wed_device_detach(&dev->mmio.wed);
 }
 EXPORT_SYMBOL_GPL(mt76_dma_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9056d09d6c33..18b5de55334c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1582,7 +1582,7 @@ EXPORT_SYMBOL_GPL(mt76_get_antenna);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-		int ring_base)
+		int ring_base, u32 flags)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -1591,6 +1591,8 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 	if (!hwq)
 		return ERR_PTR(-ENOMEM);
 
+	hwq->flags = flags;
+
 	err = dev->queue_ops->alloc(dev, hwq, idx, n_desc, 0, ring_base);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 26353b6bce97..86e3d2ac4d0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -73,8 +73,13 @@ void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr,
 	spin_lock_irqsave(&dev->mmio.irq_lock, flags);
 	dev->mmio.irqmask &= ~clear;
 	dev->mmio.irqmask |= set;
-	if (addr)
-		mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
+	if (addr) {
+		if (mtk_wed_device_active(&dev->mmio.wed))
+			mtk_wed_device_irq_set_mask(&dev->mmio.wed,
+						    dev->mmio.irqmask);
+		else
+			mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
+	}
 	spin_unlock_irqrestore(&dev->mmio.irq_lock, flags);
 }
 EXPORT_SYMBOL_GPL(mt76_set_irq_mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index dce86846e648..dc0f1b0aa34a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -13,6 +13,7 @@
 #include <linux/leds.h>
 #include <linux/usb.h>
 #include <linux/average.h>
+#include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
 #include "util.h"
 #include "testmode.h"
@@ -26,6 +27,16 @@
 
 #define MT76_TOKEN_FREE_THR	64
 
+#define MT_QFLAG_WED_RING	GENMASK(1, 0)
+#define MT_QFLAG_WED_TYPE	GENMASK(3, 2)
+#define MT_QFLAG_WED		BIT(4)
+
+#define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
+				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
+				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
+#define MT_WED_Q_TX(_n)		__MT_WED_Q(MT76_WED_Q_TX, _n)
+#define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
+
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
@@ -42,6 +53,11 @@ enum mt76_bus_type {
 	MT76_BUS_SDIO,
 };
 
+enum mt76_wed_type {
+	MT76_WED_Q_TX,
+	MT76_WED_Q_TXFREE,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
@@ -170,6 +186,9 @@ struct mt76_queue {
 	u8 buf_offset;
 	u8 hw_idx;
 	u8 qid;
+	u8 flags;
+
+	u32 wed_regs;
 
 	dma_addr_t desc_dma;
 	struct sk_buff *rx_head;
@@ -537,6 +556,8 @@ struct mt76_mmio {
 	void __iomem *regs;
 	spinlock_t irq_lock;
 	u32 irqmask;
+
+	struct mtk_wed_device wed;
 };
 
 struct mt76_rx_status {
@@ -719,6 +740,7 @@ struct mt76_dev {
 
 	spinlock_t token_lock;
 	struct idr token;
+	u16 wed_token_count;
 	u16 token_count;
 	u16 token_size;
 
@@ -944,14 +966,14 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-		int ring_base);
+		int ring_base, u32 flags);
 u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
-				     int n_desc, int ring_base)
+				     int n_desc, int ring_base, u32 flags)
 {
 	struct mt76_queue *q;
 
-	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base);
+	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base, flags);
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
@@ -966,7 +988,7 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 {
 	struct mt76_queue *q;
 
-	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base);
+	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base, 0);
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 37b092e3ea51..590cff9dcfb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -173,13 +173,13 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
-					 MT7603_TX_RING_SIZE, MT_TX_RING_BASE);
+					 MT7603_TX_RING_SIZE, MT_TX_RING_BASE, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
-				 MT7603_PSD_RING_SIZE, MT_TX_RING_BASE);
+				 MT7603_PSD_RING_SIZE, MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
@@ -189,12 +189,12 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		return ret;
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_BEACON, MT_TX_HW_QUEUE_BCN,
-				 MT_MCU_RING_SIZE, MT_TX_RING_BASE);
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_CAB, MT_TX_HW_QUEUE_BMC,
-				 MT_MCU_RING_SIZE, MT_TX_RING_BASE);
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 00aefea1bf61..3a79a2d4f288 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -26,14 +26,14 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
 					 MT7615_TX_RING_SIZE / 2,
-					 MT_TX_RING_BASE);
+					 MT_TX_RING_BASE, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT7622_TXQ_MGMT,
 				 MT7615_TX_MGMT_RING_SIZE,
-				 MT_TX_RING_BASE);
+				 MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
@@ -55,7 +55,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 		return mt7622_init_tx_queues_multi(dev);
 
 	ret = mt76_init_tx_queue(&dev->mphy, 0, 0, MT7615_TX_RING_SIZE,
-				 MT_TX_RING_BASE);
+				 MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 8bcd8afa0d3a..0fa3c7c39529 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -191,13 +191,13 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, mt76_ac_to_hwq(i),
 					 MT76x02_TX_RING_SIZE,
-					 MT_TX_RING_BASE);
+					 MT_TX_RING_BASE, 0);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
-				 MT76x02_PSD_RING_SIZE, MT_TX_RING_BASE);
+				 MT76x02_PSD_RING_SIZE, MT_TX_RING_BASE, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 66a312a9c008..c2d655cd7672 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -8,9 +8,16 @@
 static int
 mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
 {
+	struct mt7915_dev *dev = phy->dev;
 	int i, err;
 
-	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, ring_base);
+	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+		ring_base = MT_WED_TX_RING_BASE;
+		idx -= MT_TXQ_ID(0);
+	}
+
+	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, ring_base,
+				 MT_WED_Q_TX(idx));
 	if (err < 0)
 		return err;
 
@@ -319,6 +326,14 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 	if (dev->dbdc_support || dev->phy.band_idx)
 		irq_mask |= MT_INT_BAND1_RX_DONE;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		u32 wed_irq_mask = irq_mask;
+
+		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
+		mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
+		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
+	}
+
 	mt7915_irq_enable(dev, irq_mask);
 
 	return 0;
@@ -327,6 +342,7 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 {
 	struct mt76_dev *mdev = &dev->mt76;
+	u32 wa_rx_base, wa_rx_idx;
 	u32 hif1_ofs = 0;
 	int ret;
 
@@ -339,6 +355,17 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	mt7915_dma_disable(dev, true);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		mt76_set(dev, MT_WFDMA_HOST_CONFIG, MT_WFDMA_HOST_CONFIG_WED);
+
+		mt76_wr(dev, MT_WFDMA_WED_RING_CONTROL,
+			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX0, 18) |
+			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX1, 19) |
+			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_RX1, 1));
+	} else {
+		mt76_clear(dev, MT_WFDMA_HOST_CONFIG, MT_WFDMA_HOST_CONFIG_WED);
+	}
+
 	/* init tx queue */
 	ret = mt7915_init_tx_queues(&dev->phy,
 				    MT_TXQ_ID(dev->phy.band_idx),
@@ -390,11 +417,17 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 		return ret;
 
 	/* event from WA */
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		wa_rx_base = MT_WED_RX_RING_BASE;
+		wa_rx_idx = MT7915_RXQ_MCU_WA;
+		dev->mt76.q_rx[MT_RXQ_MCU_WA].flags = MT_WED_Q_TXFREE;
+	} else {
+		wa_rx_base = MT_RXQ_RING_BASE(MT_RXQ_MCU_WA);
+		wa_rx_idx = MT_RXQ_ID(MT_RXQ_MCU_WA);
+	}
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
-			       MT_RXQ_ID(MT_RXQ_MCU_WA),
-			       MT7915_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE,
-			       MT_RXQ_RING_BASE(MT_RXQ_MCU_WA));
+			       wa_rx_idx, MT7915_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, wa_rx_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 98defd796e1d..944ba29bef3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1348,6 +1348,29 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
+u32 mt7915_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
+{
+	struct mt7915_txp *txp = ptr + MT_TXD_SIZE;
+	__le32 *txwi = ptr;
+	u32 val;
+
+	memset(ptr, 0, MT_TXD_SIZE + sizeof(*txp));
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CT);
+	txwi[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3);
+	txwi[1] = cpu_to_le32(val);
+
+	txp->token = cpu_to_le16(token_id);
+	txp->nbuf = 1;
+	txp->buf[0] = cpu_to_le32(phys + MT_TXD_SIZE + sizeof(*txp));
+
+	return MT_TXD_SIZE + sizeof(*txp);
+}
+
 static void
 mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 {
@@ -1381,7 +1404,7 @@ mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 
 	txp = mt7915_txwi_to_txp(dev, t);
 	for (i = 0; i < txp->nbuf; i++)
-		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
+		dma_unmap_single(dev->dma_dev, le32_to_cpu(txp->buf[i]),
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
 
@@ -1390,6 +1413,7 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 		 struct ieee80211_sta *sta, struct list_head *free_list)
 {
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt7915_sta *msta;
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
@@ -1402,13 +1426,24 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	if (sta) {
 		wcid = (struct mt76_wcid *)sta->drv_priv;
 		wcid_idx = wcid->idx;
-
-		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7915_tx_check_aggr(sta, txwi);
 	} else {
 		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+		wcid = rcu_dereference(dev->mt76.wcid[wcid_idx]);
+
+		if (wcid && wcid->sta) {
+			msta = container_of(wcid, struct mt7915_sta, wcid);
+			sta = container_of((void *)msta, struct ieee80211_sta,
+					  drv_priv);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+		}
 	}
 
+	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt7915_tx_check_aggr(sta, txwi);
+
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
 
 out:
@@ -1416,29 +1451,55 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	mt76_put_txwi(mdev, t);
 }
 
+static void
+mt7915_mac_tx_free_prepare(struct mt7915_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy_ext = mdev->phy2;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+	if (mphy_ext) {
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_PSD], false);
+		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
+	}
+}
+
+static void
+mt7915_mac_tx_free_done(struct mt7915_dev *dev,
+			struct list_head *free_list, bool wake)
+{
+	struct sk_buff *skb, *tmp;
+
+	mt7915_mac_sta_poll(dev);
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	list_for_each_entry_safe(skb, tmp, free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+}
+
 static void
 mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 {
 	struct mt7915_tx_free *free = (struct mt7915_tx_free *)data;
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_phy *mphy_ext = mdev->phy2;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
 	LIST_HEAD(free_list);
-	struct sk_buff *skb, *tmp;
 	void *end = data + len;
 	bool v3, wake = false;
 	u16 total, count = 0;
 	u32 txd = le32_to_cpu(free->txd);
 	__le32 *cur_info;
 
-	/* clean DMA queues and unmap buffers first */
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
-	if (mphy_ext) {
-		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_PSD], false);
-		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
-	}
+	mt7915_mac_tx_free_prepare(dev);
 
 	total = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
 	v3 = (FIELD_GET(MT_TX_FREE_VER, txd) == 0x4);
@@ -1492,17 +1553,38 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		}
 	}
 
-	mt7915_mac_sta_poll(dev);
+	mt7915_mac_tx_free_done(dev, &free_list, wake);
+}
 
-	if (wake)
-		mt76_set_tx_blocked(&dev->mt76, false);
+static void
+mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
+{
+	struct mt7915_tx_free *free = (struct mt7915_tx_free *)data;
+	struct mt76_dev *mdev = &dev->mt76;
+	__le16 *info = (__le16 *)free->info;
+	void *end = data + len;
+	LIST_HEAD(free_list);
+	bool wake = false;
+	u8 i, count;
 
-	mt76_worker_schedule(&dev->mt76.tx_worker);
+	mt7915_mac_tx_free_prepare(dev);
 
-	list_for_each_entry_safe(skb, tmp, &free_list, list) {
-		skb_list_del_init(skb);
-		napi_consume_skb(skb, 1);
+	count = FIELD_GET(MT_TX_FREE_MSDU_CNT_V0, le16_to_cpu(free->ctrl));
+	if (WARN_ON_ONCE((void *)&info[count] > end))
+		return;
+
+	for (i = 0; i < count; i++) {
+		struct mt76_txwi_cache *txwi;
+		u16 msdu = le16_to_cpu(info[i]);
+
+		txwi = mt76_token_release(mdev, msdu, &wake);
+		if (!txwi)
+			continue;
+
+		mt7915_txwi_free(dev, txwi, NULL, &free_list);
 	}
+
+	mt7915_mac_tx_free_done(dev, &free_list, wake);
 }
 
 static bool
@@ -1682,6 +1764,9 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
 	case PKT_TYPE_TXRX_NOTIFY:
 		mt7915_mac_tx_free(dev, data, len);
 		return false;
+	case PKT_TYPE_TXRX_NOTIFY_V0:
+		mt7915_mac_tx_free_v0(dev, data, len);
+		return false;
 	case PKT_TYPE_TXS:
 		for (rxd += 2; rxd + 8 <= end; rxd += 8)
 		    mt7915_mac_add_txs(dev, rxd);
@@ -1709,6 +1794,10 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		mt7915_mac_tx_free(dev, skb->data, skb->len);
 		napi_consume_skb(skb, 1);
 		break;
+	case PKT_TYPE_TXRX_NOTIFY_V0:
+		mt7915_mac_tx_free_v0(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
+		break;
 	case PKT_TYPE_RX_EVENT:
 		mt7915_mcu_rx_event(dev, skb);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 5add1dd36dbe..c5fd1a618ae7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -24,6 +24,7 @@ enum rx_pkt_type {
 	PKT_TYPE_TXRX_NOTIFY,
 	PKT_TYPE_RX_EVENT,
 	PKT_TYPE_RX_FW_MONITOR = 0x0c,
+	PKT_TYPE_TXRX_NOTIFY_V0 = 0x18,
 };
 
 /* RXD DW1 */
@@ -311,6 +312,7 @@ struct mt7915_tx_free {
 
 #define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
+#define MT_TX_FREE_MSDU_CNT_V0	GENMASK(6, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
 /* 0: success, others: dropped */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 5177b19f9154..78bf5ffa7576 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1373,6 +1373,39 @@ mt7915_set_radar_background(struct ieee80211_hw *hw,
 	return ret;
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static int
+mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     struct net_device_path_ctx *ctx,
+			     struct net_device_path *path)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+
+	if (!mtk_wed_device_active(wed))
+		return -ENODEV;
+
+	if (msta->wcid.idx > 0xff)
+		return -EIO;
+
+	path->type = DEV_PATH_MTK_WDMA;
+	path->dev = ctx->dev;
+	path->mtk_wdma.wdma_idx = wed->wdma_idx;
+	path->mtk_wdma.bss = mvif->mt76.idx;
+	path->mtk_wdma.wcid = msta->wcid.idx;
+	path->mtk_wdma.queue = phy != &dev->phy;
+
+	ctx->dev = NULL;
+
+	return 0;
+}
+#endif
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -1420,4 +1453,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sta_add_debugfs = mt7915_sta_add_debugfs,
 #endif
 	.set_radar_background = mt7915_set_radar_background,
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	.net_fill_forward_path = mt7915_net_fill_forward_path,
+#endif
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 7594c2b44fe1..07c1a15e735d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2496,6 +2496,9 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3c55d4cebbf2..c6446757ad4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -550,15 +550,21 @@ static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
 static void mt7915_irq_tasklet(struct tasklet_struct *t)
 {
 	struct mt7915_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 intr, intr1, mask;
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+	if (mtk_wed_device_active(wed)) {
+		mtk_wed_device_irq_set_mask(wed, 0);
+		intr = mtk_wed_device_irq_get(wed, dev->mt76.mmio.irqmask);
+	} else {
+		mt76_wr(dev, MT_INT_MASK_CSR, 0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 
-	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
-	intr &= dev->mt76.mmio.irqmask;
-	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+		intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+		intr &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+	}
 
 	if (dev->hif2) {
 		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
@@ -613,10 +619,15 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7915_dev *dev = dev_instance;
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+	if (mtk_wed_device_active(wed)) {
+		mtk_wed_device_irq_set_mask(wed, 0);
+	} else {
+		mt76_wr(dev, MT_INT_MASK_CSR, 0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+	}
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 26e23bd93154..531c4a22bfc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -434,6 +434,8 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 void mt7915_wfsys_reset(struct mt7915_dev *dev);
 irqreturn_t mt7915_irq_handler(int irq, void *dev_instance);
 u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
+u32 mt7915_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
+
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 7cea49f23941..d74f609775d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -12,6 +12,9 @@
 #include "mac.h"
 #include "../trace.h"
 
+static bool wed_enable = false;
+module_param(wed_enable, bool, 0644);
+
 static LIST_HEAD(hif_list);
 static DEFINE_SPINLOCK(hif_lock);
 static u32 hif_idx;
@@ -92,12 +95,79 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static int mt7915_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	struct mt7915_dev *dev;
+	int ret;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	dev->mt76.token_size = wed->wlan.token_start;
+	spin_unlock_bh(&dev->mt76.token_lock);
+
+	ret = wait_event_timeout(dev->mt76.tx_wait,
+				 !dev->mt76.wed_token_count, HZ);
+	if (!ret)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static void mt7915_wed_offload_disable(struct mtk_wed_device *wed)
+{
+	struct mt7915_dev *dev;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	dev->mt76.token_size = MT7915_TOKEN_SIZE;
+	spin_unlock_bh(&dev->mt76.token_lock);
+}
+#endif
+
+static int
+mt7915_pci_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev, int *irq)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	int ret;
+
+	if (!wed_enable)
+		return 0;
+
+	wed->wlan.pci_dev = pdev;
+	wed->wlan.wpdma_phys = pci_resource_start(pdev, 0) +
+			       MT_WFDMA_EXT_CSR_BASE;
+	wed->wlan.nbuf = 4096;
+	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
+	wed->wlan.init_buf = mt7915_wed_init_buf;
+	wed->wlan.offload_enable = mt7915_wed_offload_enable;
+	wed->wlan.offload_disable = mt7915_wed_offload_disable;
+
+	if (mtk_wed_device_attach(wed) != 0)
+		return 0;
+
+	*irq = wed->irq;
+	dev->mt76.dma_dev = wed->dev;
+
+	ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static int mt7915_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
+	struct mt7915_hif *hif2 = NULL;
 	struct mt7915_dev *dev;
 	struct mt76_dev *mdev;
-	struct mt7915_hif *hif2;
 	int irq;
 	int ret;
 
@@ -129,15 +199,24 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	mt7915_wfsys_reset(dev);
 	hif2 = mt7915_pci_init_hif2(pdev);
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = mt7915_pci_wed_init(dev, pdev, &irq);
 	if (ret < 0)
-		goto free_device;
+		goto free_wed_or_irq_vector;
+
+	if (!ret) {
+		hif2 = mt7915_pci_init_hif2(pdev);
+
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0)
+			goto free_device;
+
+		irq = pdev->irq;
+	}
 
-	irq = pdev->irq;
 	ret = devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
-		goto free_irq_vector;
+		goto free_wed_or_irq_vector;
 
 	/* master switch of PCIe tnterrupt enable */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
@@ -172,8 +251,11 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (dev->hif2)
 		put_device(dev->hif2->dev);
 	devm_free_irq(mdev->dev, irq, dev);
-free_irq_vector:
-	pci_free_irq_vectors(pdev);
+free_wed_or_irq_vector:
+	if (mtk_wed_device_active(&mdev->mmio.wed))
+		mtk_wed_device_detach(&mdev->mmio.wed);
+	else
+		pci_free_irq_vectors(pdev);
 free_device:
 	mt76_free_device(&dev->mt76);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 66c60e60e921..31dffb9c949c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -577,18 +577,31 @@ enum offs_rev {
 
 /* WFDMA CSR */
 #define MT_WFDMA_EXT_CSR_BASE		__REG(WFDMA_EXT_CSR_ADDR)
+#define MT_WFDMA_EXT_CSR_PHYS_BASE	0x18027000
 #define MT_WFDMA_EXT_CSR(ofs)		(MT_WFDMA_EXT_CSR_BASE + (ofs))
+#define MT_WFDMA_EXT_CSR_PHYS(ofs)	(MT_WFDMA_EXT_CSR_PHYS_BASE + (ofs))
 
-#define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR_PHYS(0x30)
 #define MT_WFDMA_HOST_CONFIG_PDMA_BAND	BIT(0)
+#define MT_WFDMA_HOST_CONFIG_WED	BIT(1)
 
-#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_WED_RING_CONTROL	MT_WFDMA_EXT_CSR_PHYS(0x34)
+#define MT_WFDMA_WED_RING_CONTROL_TX0	GENMASK(4, 0)
+#define MT_WFDMA_WED_RING_CONTROL_TX1	GENMASK(12, 8)
+#define MT_WFDMA_WED_RING_CONTROL_RX1	GENMASK(20, 16)
+
+#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR_PHYS(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
 #define MT_PCIE_RECOG_ID		0xd7090
 #define MT_PCIE_RECOG_ID_MASK		GENMASK(30, 0)
 #define MT_PCIE_RECOG_ID_SEM		BIT(31)
 
+#define MT_INT_WED_MASK_CSR		MT_WFDMA_EXT_CSR(0x204)
+
+#define MT_WED_TX_RING_BASE		MT_WFDMA_EXT_CSR(0x300)
+#define MT_WED_RX_RING_BASE		MT_WFDMA_EXT_CSR(0x400)
+
 /* WFDMA0 PCIE1 */
 #define MT_WFDMA0_PCIE1_BASE		__REG(WFDMA0_PCIE1_ADDR)
 #define MT_WFDMA0_PCIE1(ofs)		(MT_WFDMA0_PCIE1_BASE + (ofs))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index ca7e20fb5fc0..2939cf9be355 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -9,7 +9,7 @@ static int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
 {
 	int i, err;
 
-	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE, 0);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 84fa922c977a..02067edca95e 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -726,6 +726,12 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 	if (token >= 0)
 		dev->token_count++;
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(&dev->mmio.wed) &&
+	    token >= dev->mmio.wed.wlan.token_start)
+		dev->wed_token_count++;
+#endif
+
 	if (dev->token_count >= dev->token_size - MT76_TOKEN_FREE_THR)
 		__mt76_set_tx_blocked(dev, true);
 
@@ -743,9 +749,17 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 	spin_lock_bh(&dev->token_lock);
 
 	txwi = idr_remove(&dev->token, token);
-	if (txwi)
+	if (txwi) {
 		dev->token_count--;
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    token >= dev->mmio.wed.wlan.token_start &&
+		    --dev->wed_token_count == 0)
+			wake_up(&dev->tx_wait);
+#endif
+	}
+
 	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
 	    dev->phy.q_tx[0]->blocked)
 		*wake = true;
-- 
2.35.1

