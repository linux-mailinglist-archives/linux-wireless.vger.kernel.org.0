Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF52AE3CF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgKJXDO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732168AbgKJXDN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:13 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CF620780;
        Tue, 10 Nov 2020 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049391;
        bh=8W1RGVomrh4B9tfbf5dDBokINMebrtpL1pA/uS3aiAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDQ/bCkwKinSNk3PYLO5F0aPTgO8C2MYxulvpOfeRIPzLKFQKtvvsbyalb2eUDsIP
         +StbvtA+MocGKQ58wTma2oMZyQCXoEkGjhQu4LfMqpClqC+3SMabSH45RBZXJxN7Gy
         1zYxDzfZqDNF0NW3tn5f9YwC8wnaq7CdInF5rqrk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 01/10] mt76: move mt76_init_tx_queue in common code
Date:   Wed, 11 Nov 2020 00:02:51 +0100
Message-Id: <624ebea9edcc5676eef8ee152e43678a6f7de328.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_init_tx_queue in mac80211.c since it is shared by all
drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 21 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 10 +---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 50 +++++++------------
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 10 +---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 48 +++++-------------
 6 files changed, 58 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2bc1ef1cbfea..d48f09a3c539 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1213,3 +1213,24 @@ int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_get_antenna);
+
+int mt76_init_tx_queue(struct mt76_dev *dev, int qid, int idx,
+		       int n_desc, int ring_base)
+{
+	struct mt76_queue *hwq;
+	int err;
+
+	hwq = devm_kzalloc(dev->dev, sizeof(*hwq), GFP_KERNEL);
+	if (!hwq)
+		return -ENOMEM;
+
+	err = dev->queue_ops->alloc(dev, hwq, idx, n_desc, 0, ring_base);
+	if (err < 0)
+		return err;
+
+	hwq->qid = qid;
+	dev->q_tx[qid] = hwq;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_init_tx_queue);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 34b6d32ea1ec..63549a7806cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -134,6 +134,7 @@ struct mt76_queue {
 
 	u8 buf_offset;
 	u8 hw_idx;
+	u8 qid;
 
 	dma_addr_t desc_dma;
 	struct sk_buff *rx_head;
@@ -778,6 +779,9 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_dev *dev);
 
+int mt76_init_tx_queue(struct mt76_dev *dev, int qid, int idx,
+		       int n_desc, int ring_base);
+
 static inline struct mt76_phy *
 mt76_dev_phy(struct mt76_dev *dev, bool phy_ext)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index d60d00f6f6a0..05a5801646d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -7,19 +7,13 @@
 static int
 mt7603_init_tx_queue(struct mt7603_dev *dev, int qid, int idx, int n_desc)
 {
-	struct mt76_queue *hwq;
 	int err;
 
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
-
-	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(&dev->mt76, qid, idx, n_desc,
+				 MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
-	dev->mt76.q_tx[qid] = hwq;
-
 	mt7603_irq_enable(dev, MT_INT_TX_DONE(idx));
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index bf8ae14121db..333254734ac5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -11,25 +11,6 @@
 #include "../dma.h"
 #include "mac.h"
 
-static int
-mt7615_init_tx_queue(struct mt7615_dev *dev, int qid, int idx, int n_desc)
-{
-	struct mt76_queue *hwq;
-	int err;
-
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
-
-	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
-	if (err < 0)
-		return err;
-
-	dev->mt76.q_tx[qid] = hwq;
-
-	return 0;
-}
-
 static int
 mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 {
@@ -43,20 +24,22 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
-		ret = mt7615_init_tx_queue(dev, i, wmm_queue_map[i],
-					   MT7615_TX_RING_SIZE / 2);
+		ret = mt76_init_tx_queue(&dev->mt76, i, wmm_queue_map[i],
+					 MT7615_TX_RING_SIZE / 2,
+					 MT_TX_RING_BASE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt7615_init_tx_queue(dev, MT_TXQ_PSD,
-				   MT7622_TXQ_MGMT, MT7615_TX_MGMT_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_PSD, MT7622_TXQ_MGMT,
+				 MT7615_TX_MGMT_RING_SIZE,
+				 MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	ret = mt7615_init_tx_queue(dev, MT_TXQ_MCU,
-				   MT7622_TXQ_MCU, MT7615_TX_MCU_RING_SIZE);
-	return ret;
+	return mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7622_TXQ_MCU,
+				  MT7615_TX_MCU_RING_SIZE,
+				  MT_TX_RING_BASE);
 }
 
 static int
@@ -64,25 +47,26 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 {
 	int ret, i;
 
-	ret = mt7615_init_tx_queue(dev, MT_TXQ_FWDL,
-				   MT7615_TXQ_FWDL,
-				   MT7615_TX_FWDL_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_FWDL, MT7615_TXQ_FWDL,
+				 MT7615_TX_FWDL_RING_SIZE,
+				 MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	if (!is_mt7615(&dev->mt76))
 		return mt7622_init_tx_queues_multi(dev);
 
-	ret = mt7615_init_tx_queue(dev, 0, 0, MT7615_TX_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, 0, 0, MT7615_TX_RING_SIZE,
+				 MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	for (i = 1; i < MT_TXQ_MCU; i++)
 		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
-	ret = mt7615_init_tx_queue(dev, MT_TXQ_MCU, MT7615_TXQ_MCU,
-				   MT7615_TX_MCU_RING_SIZE);
-	return 0;
+	return mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7615_TXQ_MCU,
+				  MT7615_TX_MCU_RING_SIZE,
+				  MT_TX_RING_BASE);
 }
 
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 67911c021633..82f65fa1a39d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -106,19 +106,13 @@ EXPORT_SYMBOL_GPL(mt76x02e_init_beacon_config);
 static int
 mt76x02_init_tx_queue(struct mt76x02_dev *dev, int qid, int idx, int n_desc)
 {
-	struct mt76_queue *hwq;
 	int err;
 
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
-
-	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(&dev->mt76, qid, idx, n_desc,
+				 MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
-	dev->mt76.q_tx[qid] = hwq;
-
 	mt76x02_irq_enable(dev, MT_INT_TX_DONE(idx));
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 33c42ecef2a4..7c9fe142ed41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -6,41 +6,16 @@
 #include "mac.h"
 
 static int
-mt7915_init_tx_queues(struct mt7915_dev *dev, int n_desc)
+mt7915_init_tx_queues(struct mt7915_dev *dev, int idx, int n_desc)
 {
-	struct mt76_queue *hwq;
-	int err, i;
+	int i, err;
 
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
-
-	err = mt76_queue_alloc(dev, hwq, MT7915_TXQ_BAND0, n_desc, 0,
-			       MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(&dev->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
 	for (i = 0; i < MT_TXQ_MCU; i++)
-		dev->mt76.q_tx[i] = hwq;
-
-	return 0;
-}
-
-static int
-mt7915_init_mcu_queue(struct mt7915_dev *dev, int qid, int idx, int n_desc)
-{
-	struct mt76_queue *hwq;
-	int err;
-
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
-
-	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
-	if (err < 0)
-		return err;
-
-	dev->mt76.q_tx[qid] = hwq;
+		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
 	return 0;
 }
@@ -262,25 +237,26 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0, 0);
 
 	/* init tx queue */
-	ret = mt7915_init_tx_queues(dev, MT7915_TX_RING_SIZE);
+	ret = mt7915_init_tx_queues(dev, MT7915_TXQ_BAND0,
+				    MT7915_TX_RING_SIZE);
 	if (ret)
 		return ret;
 
 	/* command to WM */
-	ret = mt7915_init_mcu_queue(dev, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
-				    MT7915_TX_MCU_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
+				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* command to WA */
-	ret = mt7915_init_mcu_queue(dev, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
-				    MT7915_TX_MCU_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
+				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* firmware download */
-	ret = mt7915_init_mcu_queue(dev, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
-				    MT7915_TX_FWDL_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mt76, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
+				 MT7915_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-- 
2.26.2

