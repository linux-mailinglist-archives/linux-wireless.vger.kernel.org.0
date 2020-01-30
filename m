Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52914DD0B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgA3OrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:22 -0500
Received: from nbd.name ([46.4.11.11]:57450 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbgA3OrW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2MAHg+57WV7LxwmeoHUMutW+3lYr2vzCxzAW+cY2W2s=; b=HuacBxyMVv4S+zmgAd+yY7JDhf
        2AKBm94J3+LzdKT8dvZUPJQ7CLYR+4+u5hSxHzMb5Ej3JwoaB9xxGKi01gDgVnHHUpyxTd6TUGSA8
        dNEuj7V7fxiUACA88uqaq8QkNVGrWSG/CZ9MZUmQ9OLm+Tbsi5fhW1+0saxKqEx3ceKU=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6G-0001Vf-Gy
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:20 +0100
Received: by maeck.local (Postfix, from userid 501)
        id ED2797AE4690; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/15] mt76: mt7615: add dma and tx queue initialization for MT7622
Date:   Thu, 30 Jan 2020 15:47:10 +0100
Message-Id: <20200130144718.14298-7-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7622 queue mapping is different from MT7615 and requires an extra dma
scheduler init and a few register tweaks

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 168 ++++++++++++------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  16 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  21 +++
 3 files changed, 154 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 285d4f1d6178..41dea1aa58db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -12,47 +12,85 @@
 #include "mac.h"
 
 static int
-mt7615_init_tx_queues(struct mt7615_dev *dev, int n_desc)
+mt7615_init_tx_queue(struct mt7615_dev *dev, struct mt76_sw_queue *q,
+		      int idx, int n_desc)
 {
-	struct mt76_sw_queue *q;
 	struct mt76_queue *hwq;
-	int err, i;
+	int err;
 
 	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
 	if (!hwq)
 		return -ENOMEM;
 
-	err = mt76_queue_alloc(dev, hwq, 0, n_desc, 0, MT_TX_RING_BASE);
+	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < MT_TXQ_MCU; i++) {
-		q = &dev->mt76.q_tx[i];
-		INIT_LIST_HEAD(&q->swq);
-		q->q = hwq;
-	}
+	INIT_LIST_HEAD(&q->swq);
+	q->q = hwq;
 
 	return 0;
 }
 
 static int
-mt7615_init_mcu_queue(struct mt7615_dev *dev, struct mt76_sw_queue *q,
-		      int idx, int n_desc)
+mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 {
-	struct mt76_queue *hwq;
-	int err;
+	static const u8 wmm_queue_map[] = {
+		MT7622_TXQ_AC0,
+		MT7622_TXQ_AC1,
+		MT7622_TXQ_AC2,
+		MT7622_TXQ_AC3,
+	};
+	int ret;
+	int i;
 
-	hwq = devm_kzalloc(dev->mt76.dev, sizeof(*hwq), GFP_KERNEL);
-	if (!hwq)
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
+		ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[i],
+					   wmm_queue_map[i],
+					   MT7615_TX_RING_SIZE / 2);
+		if (ret)
+			return ret;
+	}
 
-	err = mt76_queue_alloc(dev, hwq, idx, n_desc, 0, MT_TX_RING_BASE);
-	if (err < 0)
-		return err;
+	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_PSD],
+				   MT7622_TXQ_MGMT, MT7615_TX_MGMT_RING_SIZE);
+	if (ret)
+		return ret;
 
-	INIT_LIST_HEAD(&q->swq);
-	q->q = hwq;
+	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
+				   MT7622_TXQ_MCU, MT7615_TX_MCU_RING_SIZE);
+	return ret;
+}
+
+static int
+mt7615_init_tx_queues(struct mt7615_dev *dev)
+{
+	struct mt76_sw_queue *q;
+	int ret, i;
+
+	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_FWDL],
+				   MT7615_TXQ_FWDL,
+				   MT7615_TX_FWDL_RING_SIZE);
+	if (ret)
+		return ret;
 
+	if (!is_mt7615(&dev->mt76))
+		return mt7622_init_tx_queues_multi(dev);
+
+	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[0], 0,
+				   MT7615_TX_RING_SIZE);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < MT_TXQ_MCU; i++) {
+		q = &dev->mt76.q_tx[i];
+		INIT_LIST_HEAD(&q->swq);
+		q->q = dev->mt76.q_tx[0].q;
+	}
+
+	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
+				   MT7615_TXQ_MCU,
+				   MT7615_TX_MCU_RING_SIZE);
 	return 0;
 }
 
@@ -90,25 +128,32 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
+static void
+mt7615_tx_cleanup(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
+	if (is_mt7615(&dev->mt76)) {
+		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
+	} else {
+		for (i = 0; i < IEEE80211_NUM_ACS; i++)
+			mt76_queue_tx_cleanup(dev, i, false);
+	}
+}
+
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 {
-	static const u8 queue_map[] = {
-		MT_TXQ_MCU,
-		MT_TXQ_BE
-	};
 	struct mt7615_dev *dev;
-	int i;
 
 	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
 
-	for (i = 0; i < ARRAY_SIZE(queue_map); i++)
-		mt76_queue_tx_cleanup(dev, queue_map[i], false);
+	mt7615_tx_cleanup(dev);
 
 	if (napi_complete_done(napi, 0))
 		mt7615_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	for (i = 0; i < ARRAY_SIZE(queue_map); i++)
-		mt76_queue_tx_cleanup(dev, queue_map[i], false);
+	mt7615_tx_cleanup(dev);
 
 	mt7615_mac_sta_poll(dev);
 
@@ -117,6 +162,30 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
+static void mt7622_dma_sched_init(struct mt7615_dev *dev)
+{
+	u32 reg = mt7615_reg_map(dev, MT_DMASHDL_BASE);
+	int i;
+
+	mt76_rmw(dev, reg + MT_DMASHDL_PKT_MAX_SIZE,
+		 MT_DMASHDL_PKT_MAX_SIZE_PLE | MT_DMASHDL_PKT_MAX_SIZE_PSE,
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PLE, 1) |
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PSE, 8));
+
+	for (i = 0; i <= 5; i++)
+		mt76_wr(dev, reg + MT_DMASHDL_GROUP_QUOTA(i),
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x10) |
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x800));
+
+	mt76_wr(dev, reg + MT_DMASHDL_Q_MAP(0), 0x42104210);
+	mt76_wr(dev, reg + MT_DMASHDL_Q_MAP(1), 0x42104210);
+	mt76_wr(dev, reg + MT_DMASHDL_Q_MAP(2), 0x5);
+	mt76_wr(dev, reg + MT_DMASHDL_Q_MAP(3), 0);
+
+	mt76_wr(dev, reg + MT_DMASHDL_SCHED_SET0, 0x6012345f);
+	mt76_wr(dev, reg + MT_DMASHDL_SCHED_SET1, 0xedcba987);
+}
+
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int ret;
@@ -126,9 +195,12 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_WPDMA_GLO_CFG,
 		MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE |
 		MT_WPDMA_GLO_CFG_FIFO_LITTLE_ENDIAN |
-		MT_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY |
 		MT_WPDMA_GLO_CFG_OMIT_TX_INFO);
 
+	if (!is_mt7622(&dev->mt76))
+		mt76_set(dev, MT_WPDMA_GLO_CFG,
+			 MT_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY);
+
 	mt76_rmw_field(dev, MT_WPDMA_GLO_CFG,
 		       MT_WPDMA_GLO_CFG_TX_BT_SIZE_BIT0, 0x1);
 
@@ -141,28 +213,19 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	mt76_rmw_field(dev, MT_WPDMA_GLO_CFG,
 		       MT_WPDMA_GLO_CFG_MULTI_DMA_EN, 0x3);
 
-	mt76_wr(dev, MT_WPDMA_GLO_CFG1, 0x1);
-	mt76_wr(dev, MT_WPDMA_TX_PRE_CFG, 0xf0000);
-	mt76_wr(dev, MT_WPDMA_RX_PRE_CFG, 0xf7f0000);
-	mt76_wr(dev, MT_WPDMA_ABT_CFG, 0x4000026);
-	mt76_wr(dev, MT_WPDMA_ABT_CFG1, 0x18811881);
-	mt76_set(dev, 0x7158, BIT(16));
-	mt76_clear(dev, 0x7000, BIT(23));
-	mt76_wr(dev, MT_WPDMA_RST_IDX, ~0);
-
-	ret = mt7615_init_tx_queues(dev, MT7615_TX_RING_SIZE);
-	if (ret)
-		return ret;
+	if (is_mt7615(&dev->mt76)) {
+		mt76_wr(dev, MT_WPDMA_GLO_CFG1, 0x1);
+		mt76_wr(dev, MT_WPDMA_TX_PRE_CFG, 0xf0000);
+		mt76_wr(dev, MT_WPDMA_RX_PRE_CFG, 0xf7f0000);
+		mt76_wr(dev, MT_WPDMA_ABT_CFG, 0x4000026);
+		mt76_wr(dev, MT_WPDMA_ABT_CFG1, 0x18811881);
+		mt76_set(dev, 0x7158, BIT(16));
+		mt76_clear(dev, 0x7000, BIT(23));
+	}
 
-	ret = mt7615_init_mcu_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
-				    MT7615_TXQ_MCU,
-				    MT7615_TX_MCU_RING_SIZE);
-	if (ret)
-		return ret;
+	mt76_wr(dev, MT_WPDMA_RST_IDX, ~0);
 
-	ret = mt7615_init_mcu_queue(dev, &dev->mt76.q_tx[MT_TXQ_FWDL],
-				    MT7615_TXQ_FWDL,
-				    MT7615_TX_FWDL_RING_SIZE);
+	ret = mt7615_init_tx_queues(dev);
 	if (ret)
 		return ret;
 
@@ -201,6 +264,9 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	/* enable interrupts for TX/RX rings */
 	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL);
 
+	if (is_mt7622(&dev->mt76))
+		mt7622_dma_sched_init(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 5348bd28001c..d9e487ba98e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -20,6 +20,7 @@
 #define MT7615_RATE_RETRY		2
 
 #define MT7615_TX_RING_SIZE		1024
+#define MT7615_TX_MGMT_RING_SIZE	128
 #define MT7615_TX_MCU_RING_SIZE		128
 #define MT7615_TX_FWDL_RING_SIZE	128
 
@@ -56,6 +57,16 @@ enum mt7615_hw_txq_id {
 	MT7615_TXQ_FWDL,
 };
 
+enum mt7622_hw_txq_id {
+	MT7622_TXQ_AC0,
+	MT7622_TXQ_AC1,
+	MT7622_TXQ_AC2,
+	MT7622_TXQ_FWDL = MT7615_TXQ_FWDL,
+	MT7622_TXQ_AC3,
+	MT7622_TXQ_MGMT,
+	MT7622_TXQ_MCU = 15,
+};
+
 struct mt7615_rate_set {
 	struct ieee80211_tx_rate probe_rate;
 	struct ieee80211_tx_rate rates[4];
@@ -287,6 +298,11 @@ static inline bool is_mt7622(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7622;
 }
 
+static inline bool is_mt7615(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7615;
+}
+
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 1d764c587d25..de71d2672cf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -339,6 +339,27 @@
 
 #define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
 
+#define MT_DMASHDL_BASE			0x5000a000
+#define MT_DMASHDL_OPTIONAL		0x008
+#define MT_DMASHDL_PAGE			0x00c
+
+#define MT_DMASHDL_REFILL		0x010
+
+#define MT_DMASHDL_PKT_MAX_SIZE		0x01c
+#define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
+#define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
+
+#define MT_DMASHDL_GROUP_QUOTA(_n)	(0x020 + ((_n) << 2))
+#define MT_DMASHDL_GROUP_QUOTA_MIN	GENMASK(11, 0)
+#define MT_DMASHDL_GROUP_QUOTA_MAX	GENMASK(27, 16)
+
+#define MT_DMASHDL_SCHED_SET0		0x0b0
+#define MT_DMASHDL_SCHED_SET1		0x0b4
+
+#define MT_DMASHDL_Q_MAP(_n)		(0x0d0 + ((_n) << 2))
+#define MT_DMASHDL_Q_MAP_MASK		GENMASK(3, 0)
+#define MT_DMASHDL_Q_MAP_SHIFT(_n)	(4 * ((_n) % 8))
+
 #define MT_LED_BASE_PHYS		0x80024000
 #define MT_LED_PHYS(_n)			(MT_LED_BASE_PHYS + (_n))
 
-- 
2.24.0

