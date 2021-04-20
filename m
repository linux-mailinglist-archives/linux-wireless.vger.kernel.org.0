Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA936615C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhDTVGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 17:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhDTVGO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 17:06:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04937613F3;
        Tue, 20 Apr 2021 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618952742;
        bh=BBlSU2k6emetf1oruljEsAa/ZqMfRuKEsuODb8Dk/o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgnR9zG16iWhXKJqOsDcmGrnwRfb/5jpBkSDK7362ZXQ066FHnzSlVErWpI+U+Fyo
         9tColKHN+QThhbxWxV7au7LYBY63FNMB9H3kjlvA4lAsyzQlqwyhEOn6Imtja6P0A/
         Cb1bk0CvoOGU7Ry4a+8XTJ2QSG4UjvuQyJjsPxrR9QTNz6maNjngwwbITOvQjz0Z3B
         +cTpL4GBU786BPttK37rC/I3bdjVxfjgr+re2jDKuqNi/W3j027k9AypkU/F3Vp7nV
         NOZPT5KwnH03ro2bIHzT2Gg4Jrcc8li9T4cj6qkl2T/URbV3uZ8tGugcwIZW/l7V+r
         jJffuKfLW612Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 1/2] mt76: move token_lock, token and token_count in mt76_dev
Date:   Tue, 20 Apr 2021 23:05:31 +0200
Message-Id: <3942d5b28abdf6848c81128e86ab3e72e39b6709.1618952061.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618952061.git.lorenzo@kernel.org>
References: <cover.1618952061.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move token_lock, token and token_count data structures in mt76_dev.
This is a preliminary patch to move token management in mt76 common
module since it is shared by mt7615, mt7915 and mt7921 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 14 +++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 --
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 14 +++----
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 42 +++++++++----------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 --
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 42 +++++++++----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 --
 11 files changed, 66 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 49f3e5985422..54adc4921d03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -659,6 +659,10 @@ struct mt76_dev {
 	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
 
+	spinlock_t token_lock;
+	struct idr token;
+	int token_count;
+
 	wait_queue_head_t tx_wait;
 	struct sk_buff_head status_list;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 747bf90f9d8a..e3b727c17129 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1466,9 +1466,9 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 
 	trace_mac_tx_free(dev, token);
 
-	spin_lock_bh(&dev->token_lock);
-	txwi = idr_remove(&dev->token, token);
-	spin_unlock_bh(&dev->token_lock);
+	spin_lock_bh(&mdev->token_lock);
+	txwi = idr_remove(&mdev->token, token);
+	spin_unlock_bh(&mdev->token_lock);
 
 	if (!txwi)
 		return;
@@ -1977,8 +1977,8 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 	struct mt76_txwi_cache *txwi;
 	int id;
 
-	spin_lock_bh(&dev->token_lock);
-	idr_for_each_entry(&dev->token, txwi, id) {
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
 		mt7615_txp_skb_unmap(&dev->mt76, txwi);
 		if (txwi->skb) {
 			struct ieee80211_hw *hw;
@@ -1988,8 +1988,8 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 		}
 		mt76_put_txwi(&dev->mt76, txwi);
 	}
-	spin_unlock_bh(&dev->token_lock);
-	idr_destroy(&dev->token);
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
 }
 EXPORT_SYMBOL_GPL(mt7615_tx_token_put);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 4c533b8ffa47..989f05ed4377 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -263,9 +263,6 @@ struct mt7615_dev {
 	bool flash_eeprom;
 	bool dbdc_support;
 
-	spinlock_t token_lock;
-	struct idr token;
-
 	u8 fw_ver;
 
 	struct work_struct rate_work;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 736d19699a03..89475d5931a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -40,8 +40,8 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->mcu_work, mt7615_pci_init_work);
-	spin_lock_init(&dev->token_lock);
-	idr_init(&dev->token);
+	spin_lock_init(&dev->mt76.token_lock);
+	idr_init(&dev->mt76.token);
 
 	ret = mt7615_eeprom_init(dev, addr);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index d20962cdecc8..d5aff409132d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -37,9 +37,9 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 			token = le16_to_cpu(txp->hw.msdu_id[0]) &
 				~MT_MSDU_ID_VALID;
 
-		spin_lock_bh(&dev->token_lock);
-		t = idr_remove(&dev->token, token);
-		spin_unlock_bh(&dev->token_lock);
+		spin_lock_bh(&mdev->token_lock);
+		t = idr_remove(&mdev->token, token);
+		spin_unlock_bh(&mdev->token_lock);
 		e->skb = t ? t->skb : NULL;
 	}
 
@@ -161,9 +161,9 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&dev->token_lock);
-	id = idr_alloc(&dev->token, t, 0, MT7615_TOKEN_SIZE, GFP_ATOMIC);
-	spin_unlock_bh(&dev->token_lock);
+	spin_lock_bh(&mdev->token_lock);
+	id = idr_alloc(&mdev->token, t, 0, MT7615_TOKEN_SIZE, GFP_ATOMIC);
+	spin_unlock_bh(&mdev->token_lock);
 	if (id < 0)
 		return id;
 
@@ -314,7 +314,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 		mt7615_dma_reset(dev);
 
 		mt7615_tx_token_put(dev);
-		idr_init(&dev->token);
+		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c13b932b0a44..e7fa80e88c18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -351,8 +351,8 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
-	spin_lock_init(&dev->token_lock);
-	idr_init(&dev->token);
+	spin_lock_init(&dev->mt76.token_lock);
+	idr_init(&dev->mt76.token);
 
 	dev->dbdc_support = !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6a4b57509751..a2d60be00f9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1046,14 +1046,14 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&dev->token_lock);
-	id = idr_alloc(&dev->token, t, 0, MT7915_TOKEN_SIZE, GFP_ATOMIC);
+	spin_lock_bh(&mdev->token_lock);
+	id = idr_alloc(&mdev->token, t, 0, MT7915_TOKEN_SIZE, GFP_ATOMIC);
 	if (id >= 0)
-		dev->token_count++;
+		mdev->token_count++;
 
-	if (dev->token_count >= MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR)
+	if (mdev->token_count >= MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR)
 		mt7915_set_tx_blocked(dev, true);
-	spin_unlock_bh(&dev->token_lock);
+	spin_unlock_bh(&mdev->token_lock);
 
 	if (id < 0)
 		return id;
@@ -1218,14 +1218,14 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
-		spin_lock_bh(&dev->token_lock);
-		txwi = idr_remove(&dev->token, msdu);
+		spin_lock_bh(&mdev->token_lock);
+		txwi = idr_remove(&mdev->token, msdu);
 		if (txwi)
-			dev->token_count--;
-		if (dev->token_count < MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR &&
+			mdev->token_count--;
+		if (mdev->token_count < MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR &&
 		    dev->mphy.q_tx[0]->blocked)
 			wake = true;
-		spin_unlock_bh(&dev->token_lock);
+		spin_unlock_bh(&mdev->token_lock);
 
 		if (!txwi)
 			continue;
@@ -1257,9 +1257,9 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	mt7915_mac_sta_poll(dev);
 
 	if (wake) {
-		spin_lock_bh(&dev->token_lock);
+		spin_lock_bh(&mdev->token_lock);
 		mt7915_set_tx_blocked(dev, false);
-		spin_unlock_bh(&dev->token_lock);
+		spin_unlock_bh(&mdev->token_lock);
 	}
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
@@ -1290,9 +1290,9 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 		txp = mt7915_txwi_to_txp(mdev, e->txwi);
 
-		spin_lock_bh(&dev->token_lock);
-		t = idr_remove(&dev->token, le16_to_cpu(txp->token));
-		spin_unlock_bh(&dev->token_lock);
+		spin_lock_bh(&mdev->token_lock);
+		t = idr_remove(&mdev->token, le16_to_cpu(txp->token));
+		spin_unlock_bh(&mdev->token_lock);
 		e->skb = t ? t->skb : NULL;
 	}
 
@@ -1588,8 +1588,8 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 	struct mt76_txwi_cache *txwi;
 	int id;
 
-	spin_lock_bh(&dev->token_lock);
-	idr_for_each_entry(&dev->token, txwi, id) {
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
 		mt7915_txp_skb_unmap(&dev->mt76, txwi);
 		if (txwi->skb) {
 			struct ieee80211_hw *hw;
@@ -1598,10 +1598,10 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 			ieee80211_free_txskb(hw, txwi->skb);
 		}
 		mt76_put_txwi(&dev->mt76, txwi);
-		dev->token_count--;
+		dev->mt76.token_count--;
 	}
-	spin_unlock_bh(&dev->token_lock);
-	idr_destroy(&dev->token);
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
 }
 
 /* system error recovery */
@@ -1649,7 +1649,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		mt7915_dma_reset(dev);
 
 		mt7915_tx_token_put(dev);
-		idr_init(&dev->token);
+		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
 		mt7915_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 80eb35231a1a..582c2bfdf070 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -187,10 +187,6 @@ struct mt7915_dev {
 
 	u32 hw_pattern;
 
-	spinlock_t token_lock;
-	int token_count;
-	struct idr token;
-
 	bool dbdc_support;
 	bool flash_mode;
 	bool fw_debug;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index cec17a249a8c..a35fdd1b34f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -170,8 +170,8 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret, idx;
 
-	spin_lock_init(&dev->token_lock);
-	idr_init(&dev->token);
+	spin_lock_init(&dev->mt76.token_lock);
+	idr_init(&dev->mt76.token);
 
 	ret = mt7921_dma_init(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8770e0d93f45..c492d9903815 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -824,14 +824,14 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
-	spin_lock_bh(&dev->token_lock);
-	id = idr_alloc(&dev->token, t, 0, MT7921_TOKEN_SIZE, GFP_ATOMIC);
+	spin_lock_bh(&mdev->token_lock);
+	id = idr_alloc(&mdev->token, t, 0, MT7921_TOKEN_SIZE, GFP_ATOMIC);
 	if (id >= 0)
-		dev->token_count++;
+		mdev->token_count++;
 
-	if (dev->token_count >= MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR)
+	if (mdev->token_count >= MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR)
 		mt7921_set_tx_blocked(dev, true);
-	spin_unlock_bh(&dev->token_lock);
+	spin_unlock_bh(&mdev->token_lock);
 
 	if (id < 0)
 		return id;
@@ -994,14 +994,14 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
-		spin_lock_bh(&dev->token_lock);
-		txwi = idr_remove(&dev->token, msdu);
+		spin_lock_bh(&mdev->token_lock);
+		txwi = idr_remove(&mdev->token, msdu);
 		if (txwi)
-			dev->token_count--;
-		if (dev->token_count < MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR &&
+			mdev->token_count--;
+		if (mdev->token_count < MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR &&
 		    dev->mphy.q_tx[0]->blocked)
 			wake = true;
-		spin_unlock_bh(&dev->token_lock);
+		spin_unlock_bh(&mdev->token_lock);
 
 		if (!txwi)
 			continue;
@@ -1031,9 +1031,9 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	}
 
 	if (wake) {
-		spin_lock_bh(&dev->token_lock);
+		spin_lock_bh(&mdev->token_lock);
 		mt7921_set_tx_blocked(dev, false);
-		spin_unlock_bh(&dev->token_lock);
+		spin_unlock_bh(&mdev->token_lock);
 	}
 
 	napi_consume_skb(skb, 1);
@@ -1067,9 +1067,9 @@ void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		txp = mt7921_txwi_to_txp(mdev, e->txwi);
 
 		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
-		spin_lock_bh(&dev->token_lock);
-		t = idr_remove(&dev->token, token);
-		spin_unlock_bh(&dev->token_lock);
+		spin_lock_bh(&mdev->token_lock);
+		t = idr_remove(&mdev->token, token);
+		spin_unlock_bh(&mdev->token_lock);
 		e->skb = t ? t->skb : NULL;
 	}
 
@@ -1284,8 +1284,8 @@ void mt7921_tx_token_put(struct mt7921_dev *dev)
 	struct mt76_txwi_cache *txwi;
 	int id;
 
-	spin_lock_bh(&dev->token_lock);
-	idr_for_each_entry(&dev->token, txwi, id) {
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
 		mt7921_txp_skb_unmap(&dev->mt76, txwi);
 		if (txwi->skb) {
 			struct ieee80211_hw *hw;
@@ -1294,10 +1294,10 @@ void mt7921_tx_token_put(struct mt7921_dev *dev)
 			ieee80211_free_txskb(hw, txwi->skb);
 		}
 		mt76_put_txwi(&dev->mt76, txwi);
-		dev->token_count--;
+		dev->mt76.token_count--;
 	}
-	spin_unlock_bh(&dev->token_lock);
-	idr_destroy(&dev->token);
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
 }
 
 static void
@@ -1336,7 +1336,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	mt7921_tx_token_put(dev);
-	idr_init(&dev->token);
+	idr_init(&dev->mt76.token);
 
 	/* clean up hw queues */
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c9687c57cbe7..f428719d057c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -161,10 +161,6 @@ struct mt7921_dev {
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
-	spinlock_t token_lock;
-	int token_count;
-	struct idr token;
-
 	u8 fw_debug;
 
 	struct mt76_connac_pm pm;
-- 
2.30.2

