Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2F2BC115
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 18:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgKURdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Nov 2020 12:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKURdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Nov 2020 12:33:31 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C9C0613CF
        for <linux-wireless@vger.kernel.org>; Sat, 21 Nov 2020 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DRlcKMfi77watHbpw/xv/0QsNMKb/IzDUIPLh3fuax4=; b=jo6MtkXWglSwdnqwkXT77aNl2a
        A1Q8R91Gl1neVQgH+LH+nke0cmVAMN+c+GqVVd2FQgjFZNPcpKvbRyJyIZxhGSF0cpS4k7lybvxEf
        SZPrswPKfhLnpQbyOt10izAXhdlWwAshN+kOrqbzndEtd7+FgUKSqxMl1AW2ZxO1u5oI=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kgWlM-0004bc-8J
        for linux-wireless@vger.kernel.org; Sat, 21 Nov 2020 18:33:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7915: stop queues when running out of tx tokens
Date:   Sat, 21 Nov 2020 18:33:25 +0100
Message-Id: <20201121173326.88208-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121173326.88208-1-nbd@nbd.name>
References: <20201121173326.88208-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoids packet drops under load with lots of stations

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 39 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ff29a8090739..ed4635bd151a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -690,6 +690,7 @@ void mt7915_unregister_device(struct mt7915_dev *dev)
 			ieee80211_free_txskb(hw, txwi->skb);
 		}
 		mt76_put_txwi(&dev->mt76, txwi);
+		dev->token_count--;
 	}
 	spin_unlock_bh(&dev->token_lock);
 	idr_destroy(&dev->token);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a7fa6fffffff..d93d5ba33dbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -918,6 +918,26 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		mt7915_mac_write_txwi_tm(dev, mphy, txwi, skb);
 }
 
+static void
+mt7915_set_tx_blocked(struct mt7915_dev *dev, bool blocked)
+{
+	struct mt76_phy *mphy = &dev->mphy, *mphy2 = dev->mt76.phy2;
+	struct mt76_queue *q, *q2 = NULL;
+
+	q = mphy->q_tx[0];
+	if (blocked == q->blocked)
+		return;
+
+	q->blocked = blocked;
+	if (mphy2) {
+		q2 = mphy->q_tx[0];
+		q2->blocked = blocked;
+	}
+
+	if (!blocked)
+		mt76_worker_schedule(&dev->mt76.tx_worker);
+}
+
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -974,7 +994,13 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	spin_lock_bh(&dev->token_lock);
 	id = idr_alloc(&dev->token, t, 0, MT7915_TOKEN_SIZE, GFP_ATOMIC);
+	if (id >= 0)
+		dev->token_count++;
+
+	if (dev->token_count >= MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR)
+		mt7915_set_tx_blocked(dev, true);
 	spin_unlock_bh(&dev->token_lock);
+
 	if (id < 0)
 		return id;
 
@@ -1083,6 +1109,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	LIST_HEAD(free_list);
 	struct sk_buff *tmp;
 	u8 i, count;
+	bool wake = true;
 
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
@@ -1135,6 +1162,11 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		spin_lock_bh(&dev->token_lock);
 		txwi = idr_remove(&dev->token, msdu);
+		if (txwi)
+			dev->token_count--;
+		if (dev->token_count < MT7915_TOKEN_SIZE - MT7915_TOKEN_FREE_THR &&
+		    dev->mphy.q_tx[0]->blocked)
+			wake = true;
 		spin_unlock_bh(&dev->token_lock);
 
 		if (!txwi)
@@ -1165,6 +1197,13 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	mt7915_mac_sta_poll(dev);
+
+	if (wake) {
+		spin_lock_bh(&dev->token_lock);
+		mt7915_set_tx_blocked(dev, false);
+		spin_unlock_bh(&dev->token_lock);
+	}
+
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 
 	napi_consume_skb(skb, 1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 30e53a0f01fb..0339abf360d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -32,6 +32,7 @@
 
 #define MT7915_EEPROM_SIZE		3584
 #define MT7915_TOKEN_SIZE		8192
+#define MT7915_TOKEN_FREE_THR		64
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7915_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
@@ -161,6 +162,7 @@ struct mt7915_dev {
 	u32 hw_pattern;
 
 	spinlock_t token_lock;
+	int token_count;
 	struct idr token;
 
 	s8 **rate_power; /* TODO: use mt76_rate_power */
-- 
2.28.0

