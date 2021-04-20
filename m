Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55F36615D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDTVGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 17:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234085AbhDTVGQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 17:06:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29848613F6;
        Tue, 20 Apr 2021 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618952744;
        bh=vm1rjatX1pnrW9mhbq2CwBY1rmZHWNcDfKD8Hjs5mFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDAu4Wyg0RT5UWKDVfTbC7ELWCDy8XxaLwfZ9s041rhHxm5Y+uds8PFqUsga2xT4i
         r5kWlxUrJbq8CnwkFzvi/hAHKVoMnfcWbgOigsrECl1xdbFWbb04QjUUyWhfpKKB3O
         CLwxmKB9HIPVxB/BKRyTmFJdgsutlVw5hnx6mdYhDAqJVh0gQMlHnl1BwNjgW/hB5F
         iMK3qYdAx206/qEakMysms9qHXMkdhuN77rFG0+/r8oGPMf/kzIFL8kx+/CHoEmpto
         LDB54u9umKGZvOmECBIHzeVvTfWv9yzeTV7nm/alufS3Y8DBSfq9A2dU1RkEx19lOu
         FXPM57jZgnpdg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 2/2] mt76: move token utilities in mt76 common module
Date:   Tue, 20 Apr 2021 23:05:32 +0200
Message-Id: <9fc737db2d841437b799d24f3869a6fdd41ae444.1618952061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618952061.git.lorenzo@kernel.org>
References: <cover.1618952061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move token management in mt76 common module since it is shared between
mt7615, mt7915 and mt7921 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 50 ++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  3 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  8 +--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 52 ++------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 46 ++-----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 68 +++++++++++++++++++
 14 files changed, 132 insertions(+), 113 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 54adc4921d03..cc5d95aeebbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -17,12 +17,14 @@
 #include "util.h"
 #include "testmode.h"
 
-#define MT_MCU_RING_SIZE    32
-#define MT_RX_BUF_SIZE      2048
-#define MT_SKB_HEAD_LEN     128
+#define MT_MCU_RING_SIZE	32
+#define MT_RX_BUF_SIZE		2048
+#define MT_SKB_HEAD_LEN		128
 
-#define MT_MAX_NON_AQL_PKT  16
-#define MT_TXQ_FREE_THR     32
+#define MT_MAX_NON_AQL_PKT	16
+#define MT_TXQ_FREE_THR		32
+
+#define MT76_TOKEN_FREE_THR	64
 
 struct mt76_dev;
 struct mt76_phy;
@@ -332,6 +334,7 @@ struct mt76_driver_ops {
 	u32 drv_flags;
 	u32 survey_flags;
 	u16 txwi_size;
+	u16 token_size;
 	u8 mcs_rates;
 
 	void (*update_survey)(struct mt76_dev *dev);
@@ -1215,4 +1218,41 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct mt76_power_limits *dest,
 			      s8 target_power);
 
+struct mt76_txwi_cache *
+mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
+int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
+void mt76_token_init(struct mt76_dev *dev);
+void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked);
+
+static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
+{
+	spin_lock_bh(&dev->token_lock);
+	__mt76_set_tx_blocked(dev, blocked);
+	spin_unlock_bh(&dev->token_lock);
+}
+
+static inline int
+mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
+{
+	int token;
+
+	spin_lock_bh(&dev->token_lock);
+	token = idr_alloc(&dev->token, *ptxwi, 0, dev->drv->token_size,
+			  GFP_ATOMIC);
+	spin_unlock_bh(&dev->token_lock);
+
+	return token;
+}
+
+static inline struct mt76_txwi_cache *
+mt76_token_put(struct mt76_dev *dev, int token)
+{
+	struct mt76_txwi_cache *txwi;
+
+	spin_lock_bh(&dev->token_lock);
+	txwi = idr_remove(&dev->token, token);
+	spin_unlock_bh(&dev->token_lock);
+
+	return txwi;
+}
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e3b727c17129..d11375661875 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1465,11 +1465,7 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 	u8 wcid;
 
 	trace_mac_tx_free(dev, token);
-
-	spin_lock_bh(&mdev->token_lock);
-	txwi = idr_remove(&mdev->token, token);
-	spin_unlock_bh(&mdev->token_lock);
-
+	txwi = mt76_token_put(mdev, token);
 	if (!txwi)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index be93e7ad1279..202ea235415e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -190,6 +190,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7615_TOKEN_SIZE,
 		.tx_prepare_skb = mt7615_tx_prepare_skb,
 		.tx_complete_skb = mt7615_tx_complete_skb,
 		.rx_skb = mt7615_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 89475d5931a6..5d174aa7f88d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -40,8 +40,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->mcu_work, mt7615_pci_init_work);
-	spin_lock_init(&dev->mt76.token_lock);
-	idr_init(&dev->mt76.token);
+	mt76_token_init(&dev->mt76);
 
 	ret = mt7615_eeprom_init(dev, addr);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index d5aff409132d..d7cbef752f9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -37,9 +37,7 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 			token = le16_to_cpu(txp->hw.msdu_id[0]) &
 				~MT_MSDU_ID_VALID;
 
-		spin_lock_bh(&mdev->token_lock);
-		t = idr_remove(&mdev->token, token);
-		spin_unlock_bh(&mdev->token_lock);
+		t = mt76_token_put(mdev, token);
 		e->skb = t ? t->skb : NULL;
 	}
 
@@ -161,9 +159,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&mdev->token_lock);
-	id = idr_alloc(&mdev->token, t, 0, MT7615_TOKEN_SIZE, GFP_ATOMIC);
-	spin_unlock_bh(&mdev->token_lock);
+	id = mt76_token_get(mdev, &t);
 	if (id < 0)
 		return id;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index e7fa80e88c18..eb0091e4f468 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -351,8 +351,7 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
-	spin_lock_init(&dev->mt76.token_lock);
-	idr_init(&dev->mt76.token);
+	mt76_token_init(&dev->mt76);
 
 	dev->dbdc_support = !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a2d60be00f9f..7a9759fb79d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -974,26 +974,6 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
 }
 
-static void
-mt7915_set_tx_blocked(struct mt7915_dev *dev, bool blocked)
-{
-	struct mt76_phy *mphy = &dev->mphy, *mphy2 = dev->mt76.phy2;
-	struct mt76_queue *q, *q2 = NULL;
-
-	q = mphy->q_tx[0];
-	if (blocked == q->blocked)
-		return;
-
-	q->blocked = blocked;
-	if (mphy2) {
-		q2 = mphy2->q_tx[0];
-		q2->blocked = blocked;
-	}
-
-	if (!blocked)
-		mt76_worker_schedule(&dev->mt76.tx_worker);
-}
-
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -1046,15 +1026,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&mdev->token_lock);
-	id = idr_alloc(&mdev->token, t, 0, MT7915_TOKEN_SIZE, GFP_ATOMIC);
-	if (id >= 0)
-		mdev->token_count++;
-
-	if (mdev->token_count >= MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR)
-		mt7915_set_tx_blocked(dev, true);
-	spin_unlock_bh(&mdev->token_lock);
-
+	id = mt76_token_consume(mdev, &t);
 	if (id < 0)
 		return id;
 
@@ -1218,15 +1190,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
-		spin_lock_bh(&mdev->token_lock);
-		txwi = idr_remove(&mdev->token, msdu);
-		if (txwi)
-			mdev->token_count--;
-		if (mdev->token_count < MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR &&
-		    dev->mphy.q_tx[0]->blocked)
-			wake = true;
-		spin_unlock_bh(&mdev->token_lock);
-
+		txwi = mt76_token_release(mdev, msdu, &wake);
 		if (!txwi)
 			continue;
 
@@ -1256,11 +1220,8 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	mt7915_mac_sta_poll(dev);
 
-	if (wake) {
-		spin_lock_bh(&mdev->token_lock);
-		mt7915_set_tx_blocked(dev, false);
-		spin_unlock_bh(&mdev->token_lock);
-	}
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 
@@ -1289,10 +1250,7 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		struct mt7915_txp *txp;
 
 		txp = mt7915_txwi_to_txp(mdev, e->txwi);
-
-		spin_lock_bh(&mdev->token_lock);
-		t = idr_remove(&mdev->token, le16_to_cpu(txp->token));
-		spin_unlock_bh(&mdev->token_lock);
+		t = mt76_token_put(mdev, le16_to_cpu(txp->token));
 		e->skb = t ? t->skb : NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 582c2bfdf070..4ea8972d4e2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -32,7 +32,6 @@
 
 #define MT7915_EEPROM_SIZE		3584
 #define MT7915_TOKEN_SIZE		8192
-#define MT7915_TOKEN_FREE_THR		64
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7915_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index ebfc4c15fef2..643f171884cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -212,6 +212,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7915_TOKEN_SIZE,
 		.tx_prepare_skb = mt7915_tx_prepare_skb,
 		.tx_complete_skb = mt7915_tx_complete_skb,
 		.rx_skb = mt7915_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index a35fdd1b34f9..c32fea6378af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -170,9 +170,7 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret, idx;
 
-	spin_lock_init(&dev->mt76.token_lock);
-	idr_init(&dev->mt76.token);
-
+	mt76_token_init(&dev->mt76);
 	ret = mt7921_dma_init(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index c492d9903815..1233e5410ee7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -785,20 +785,6 @@ mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
 	}
 }
 
-static void mt7921_set_tx_blocked(struct mt7921_dev *dev, bool blocked)
-{
-	struct mt76_phy *mphy = &dev->mphy;
-	struct mt76_queue *q;
-
-	q = mphy->q_tx[0];
-	if (blocked == q->blocked)
-		return;
-
-	q->blocked = blocked;
-	if (!blocked)
-		mt76_worker_schedule(&dev->mt76.tx_worker);
-}
-
 int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -824,15 +810,7 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&mdev->token_lock);
-	id = idr_alloc(&mdev->token, t, 0, MT7921_TOKEN_SIZE, GFP_ATOMIC);
-	if (id >= 0)
-		mdev->token_count++;
-
-	if (mdev->token_count >= MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR)
-		mt7921_set_tx_blocked(dev, true);
-	spin_unlock_bh(&mdev->token_lock);
-
+	id = mt76_token_consume(mdev, &t);
 	if (id < 0)
 		return id;
 
@@ -994,15 +972,7 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
-		spin_lock_bh(&mdev->token_lock);
-		txwi = idr_remove(&mdev->token, msdu);
-		if (txwi)
-			mdev->token_count--;
-		if (mdev->token_count < MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR &&
-		    dev->mphy.q_tx[0]->blocked)
-			wake = true;
-		spin_unlock_bh(&mdev->token_lock);
-
+		txwi = mt76_token_release(mdev, msdu, &wake);
 		if (!txwi)
 			continue;
 
@@ -1030,11 +1000,8 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_put_txwi(mdev, txwi);
 	}
 
-	if (wake) {
-		spin_lock_bh(&mdev->token_lock);
-		mt7921_set_tx_blocked(dev, false);
-		spin_unlock_bh(&mdev->token_lock);
-	}
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
 
 	napi_consume_skb(skb, 1);
 
@@ -1065,11 +1032,8 @@ void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		u16 token;
 
 		txp = mt7921_txwi_to_txp(mdev, e->txwi);
-
 		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
-		spin_lock_bh(&mdev->token_lock);
-		t = idr_remove(&mdev->token, token);
-		spin_unlock_bh(&mdev->token_lock);
+		t = mt76_token_put(mdev, token);
 		e->skb = t ? t->skb : NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f428719d057c..846655cd9b23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -35,7 +35,6 @@
 
 #define MT7921_EEPROM_SIZE		3584
 #define MT7921_TOKEN_SIZE		8192
-#define MT7921_TOKEN_FREE_THR		64
 
 #define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index d5da98d36f63..ea8b90b169d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -99,6 +99,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7921_TOKEN_SIZE,
 		.tx_prepare_skb = mt7921_tx_prepare_skb,
 		.tx_complete_skb = mt7921_tx_complete_skb,
 		.rx_skb = mt7921_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 236eaa351f53..29a56f304aae 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -648,3 +648,71 @@ void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 	spin_unlock_bh(&q->lock);
 }
 EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
+
+void mt76_token_init(struct mt76_dev *dev)
+{
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+}
+EXPORT_SYMBOL_GPL(mt76_token_init);
+
+void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
+{
+	struct mt76_phy *phy = &dev->phy, *phy2 = dev->phy2;
+	struct mt76_queue *q, *q2 = NULL;
+
+	q = phy->q_tx[0];
+	if (blocked == q->blocked)
+		return;
+
+	q->blocked = blocked;
+	if (phy2) {
+		q2 = phy2->q_tx[0];
+		q2->blocked = blocked;
+	}
+
+	if (!blocked)
+		mt76_worker_schedule(&dev->tx_worker);
+}
+EXPORT_SYMBOL_GPL(__mt76_set_tx_blocked);
+
+int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
+{
+	int token;
+
+	spin_lock_bh(&dev->token_lock);
+
+	token = idr_alloc(&dev->token, *ptxwi, 0, dev->drv->token_size,
+			  GFP_ATOMIC);
+	if (token >= 0)
+		dev->token_count++;
+
+	if (dev->token_count >= dev->drv->token_size - MT76_TOKEN_FREE_THR)
+		__mt76_set_tx_blocked(dev, true);
+
+	spin_unlock_bh(&dev->token_lock);
+
+	return token;
+}
+EXPORT_SYMBOL_GPL(mt76_token_consume);
+
+struct mt76_txwi_cache *
+mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
+{
+	struct mt76_txwi_cache *txwi;
+
+	spin_lock_bh(&dev->token_lock);
+
+	txwi = idr_remove(&dev->token, token);
+	if (txwi)
+		dev->token_count--;
+
+	if (dev->token_count < dev->drv->token_size - MT76_TOKEN_FREE_THR &&
+	    dev->phy.q_tx[0]->blocked)
+		*wake = true;
+
+	spin_unlock_bh(&dev->token_lock);
+
+	return txwi;
+}
+EXPORT_SYMBOL_GPL(mt76_token_release);
-- 
2.30.2

