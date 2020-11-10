Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050D42AE3D5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgKJXDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJXDb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:31 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98ED20780;
        Tue, 10 Nov 2020 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049410;
        bh=DC35GSaT/OmORMaUFyd3DkN5zCaznS/vF4cHX/tkZMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xN1J0Z0IgjLhXrWKsibZ5ystDxPk01iJp6txMoRU3KYp4vho67WoNVieSW8v4Rb3m
         bG+rlxsKETvKOezRKyk04KSRfGcntL/tRYXm/7uXqps2M9NhTE2nXuScf6iYBk3X3p
         kiq5WwWm+icTdL6nnOoQsY6G53bPeL8FICZLCwDw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 07/10] mt76: introduce mt76_init_mcu_queue utility routine
Date:   Wed, 11 Nov 2020 00:02:57 +0100
Message-Id: <dea70648732a6fe31627b9d73f7a8f1fd5971114.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_init_mcu_queue utility routine in order to allocate
dedicate q_mcu pointers for mcu hw queues. This is a preliminary patch
to move data queues in mt76_phy and add dbdc support to mt7915 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 16 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 39 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 12 +++---
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  8 ++--
 6 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d48f09a3c539..6dcd902efb3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1214,23 +1214,21 @@ int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 }
 EXPORT_SYMBOL_GPL(mt76_get_antenna);
 
-int mt76_init_tx_queue(struct mt76_dev *dev, int qid, int idx,
-		       int n_desc, int ring_base)
+struct mt76_queue *
+mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
+		int ring_base)
 {
 	struct mt76_queue *hwq;
 	int err;
 
 	hwq = devm_kzalloc(dev->dev, sizeof(*hwq), GFP_KERNEL);
 	if (!hwq)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	err = dev->queue_ops->alloc(dev, hwq, idx, n_desc, 0, ring_base);
 	if (err < 0)
-		return err;
-
-	hwq->qid = qid;
-	dev->q_tx[qid] = hwq;
+		return ERR_PTR(err);
 
-	return 0;
+	return hwq;
 }
-EXPORT_SYMBOL_GPL(mt76_init_tx_queue);
+EXPORT_SYMBOL_GPL(mt76_init_queue);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8a9c87301fea..de0bac2cf632 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -72,6 +72,10 @@ enum mt76_txq_id {
 	__MT_TXQ_MAX
 };
 
+enum mt76_mcuq_id {
+	__MT_MCUQ_MAX
+};
+
 enum mt76_rxq_id {
 	MT_RXQ_MAIN,
 	MT_RXQ_MCU,
@@ -604,6 +608,7 @@ struct mt76_dev {
 
 	struct list_head txwi_cache;
 	struct mt76_queue *q_tx[2 * __MT_TXQ_MAX];
+	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
 	int tx_dma_idx[4];
@@ -780,8 +785,38 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_dev *dev);
 
-int mt76_init_tx_queue(struct mt76_dev *dev, int qid, int idx,
-		       int n_desc, int ring_base);
+struct mt76_queue *
+mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
+		int ring_base);
+static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
+				     int n_desc, int ring_base)
+{
+	struct mt76_queue *q;
+
+	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
+
+	q->qid = qid;
+	phy->dev->q_tx[qid] = q;
+
+	return 0;
+}
+
+static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
+				      int n_desc, int ring_base)
+{
+	struct mt76_queue *q;
+
+	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
+
+	q->qid = qid;
+	dev->q_mcu[qid] = q;
+
+	return 0;
+}
 
 static inline struct mt76_phy *
 mt76_dev_phy(struct mt76_dev *dev, bool phy_ext)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 200d9fb7175d..8fbbee2e1ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -9,7 +9,7 @@ mt7603_init_tx_queue(struct mt7603_dev *dev, int qid, int idx, int n_desc)
 {
 	int err;
 
-	err = mt76_init_tx_queue(&dev->mt76, qid, idx, n_desc,
+	err = mt76_init_tx_queue(&dev->mphy, qid, idx, n_desc,
 				 MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 6d50ac636a8c..0072331701f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -24,20 +24,20 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
-		ret = mt76_init_tx_queue(&dev->mt76, i, wmm_queue_map[i],
+		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
 					 MT7615_TX_RING_SIZE / 2,
 					 MT_TX_RING_BASE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_PSD, MT7622_TXQ_MGMT,
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT7622_TXQ_MGMT,
 				 MT7615_TX_MGMT_RING_SIZE,
 				 MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	return mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7622_TXQ_MCU,
+	return mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7622_TXQ_MCU,
 				  MT7615_TX_MCU_RING_SIZE,
 				  MT_TX_RING_BASE);
 }
@@ -47,7 +47,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 {
 	int ret, i;
 
-	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_FWDL, MT7615_TXQ_FWDL,
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_FWDL, MT7615_TXQ_FWDL,
 				 MT7615_TX_FWDL_RING_SIZE,
 				 MT_TX_RING_BASE);
 	if (ret)
@@ -56,7 +56,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	if (!is_mt7615(&dev->mt76))
 		return mt7622_init_tx_queues_multi(dev);
 
-	ret = mt76_init_tx_queue(&dev->mt76, 0, 0, MT7615_TX_RING_SIZE,
+	ret = mt76_init_tx_queue(&dev->mphy, 0, 0, MT7615_TX_RING_SIZE,
 				 MT_TX_RING_BASE);
 	if (ret)
 		return ret;
@@ -64,7 +64,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	for (i = 1; i < MT_TXQ_MCU; i++)
 		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
-	return mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7615_TXQ_MCU,
+	return mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7615_TXQ_MCU,
 				  MT7615_TX_MCU_RING_SIZE,
 				  MT_TX_RING_BASE);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 15c11ff93d81..c5212f8b08e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -109,7 +109,7 @@ mt76x02_init_tx_queue(struct mt76x02_dev *dev, int qid, int idx, int n_desc)
 {
 	int err;
 
-	err = mt76_init_tx_queue(&dev->mt76, qid, idx, n_desc,
+	err = mt76_init_tx_queue(&dev->mphy, qid, idx, n_desc,
 				 MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 46788ad9960b..445530031d81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -10,7 +10,7 @@ mt7915_init_tx_queues(struct mt7915_dev *dev, int idx, int n_desc)
 {
 	int i, err;
 
-	err = mt76_init_tx_queue(&dev->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(&dev->mphy, 0, idx, n_desc, MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
@@ -244,19 +244,19 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		return ret;
 
 	/* command to WM */
-	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
 				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* command to WA */
-	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
 				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* firmware download */
-	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
 				 MT7915_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
-- 
2.26.2

