Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E610DE0A
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfK3Pau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:50 -0500
Received: from nbd.name ([46.4.11.11]:56062 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfK3Pau (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4zO8RwgXllbrGVpPJCYOpRIhlvKzsAMUxi/oFu662gg=; b=Ie7JsTSv6K1sl8WNLxXgqltAzZ
        PecfvYEWWFx2p72ahGSeBmwqcFrO3lZplYSf2+e2jfJlLpkPB6cC09GHTo33NrChvg5zAD3aGYjde
        onGwT+bGLA+GHG2Vx/7TlUyq71SKqCFYp7QXNUE/k7Vny4Wg8VrnnzOGTjwvquWEiw14=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iQ-R5
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0CE18721EBEA; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/29] mt76: add support for an extra wiphy in the tx status path
Date:   Sat, 30 Nov 2019 16:30:21 +0100
Message-Id: <20191130153045.28105-5-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt76.h | 17 +++++++++++++
 drivers/net/wireless/mediatek/mt76/tx.c   | 29 +++++++++++++++++++----
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index eed387b10d48..67d10099cb71 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -286,6 +286,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
+	struct ieee80211_hw *hw;
 	int len, n = 0, ret = -ENOMEM;
 	struct mt76_queue_entry e;
 	struct mt76_txwi_cache *t;
@@ -295,7 +296,8 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 
 	t = mt76_get_txwi(dev);
 	if (!t) {
-		ieee80211_free_txskb(dev->hw, skb);
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_free_txskb(hw, skb);
 		return -ENOMEM;
 	}
 	txwi = mt76_get_txwi_ptr(dev, t);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4fd36b3e9440..4c0fe88155e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -177,6 +177,9 @@ enum mt76_wcid_flags {
 
 #define MT76_N_WCIDS 128
 
+/* stored in ieee80211_tx_info::hw_queue */
+#define MT_TX_HW_QUEUE_EXT_PHY		BIT(7)
+
 DECLARE_EWMA(signal, 10, 8);
 
 #define MT_WCID_TX_INFO_RATE		GENMASK(15, 0)
@@ -793,6 +796,20 @@ u32 mt76_calc_tx_airtime(struct mt76_dev *dev, struct ieee80211_tx_info *info,
 			 int len);
 
 /* internal */
+static inline struct ieee80211_hw *
+mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hw *hw = dev->phy.hw;
+
+	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phy2)
+		hw = dev->phy2->hw;
+
+	info->hw_queue &= ~MT_TX_HW_QUEUE_EXT_PHY;
+
+	return hw;
+}
+
 void mt76_tx_free(struct mt76_dev *dev);
 struct mt76_txwi_cache *mt76_get_txwi(struct mt76_dev *dev);
 void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d9fccbeff206..c993ad7ef2e3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -109,13 +109,17 @@ void
 mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		      __releases(&dev->status_list.unlock)
 {
+	struct ieee80211_hw *hw;
 	struct sk_buff *skb;
 
 	spin_unlock_bh(&dev->status_list.lock);
 	__release(&dev->status_list.unlock);
 
-	while ((skb = __skb_dequeue(list)) != NULL)
-		ieee80211_tx_status(dev->hw, skb);
+	while ((skb = __skb_dequeue(list)) != NULL) {
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_tx_status(hw, skb);
+	}
+
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_unlock);
 
@@ -231,10 +235,12 @@ EXPORT_SYMBOL_GPL(mt76_tx_status_check);
 
 void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 {
+	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 
 	if (!skb->prev) {
-		ieee80211_free_txskb(dev->hw, skb);
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_free_txskb(hw, skb);
 		return;
 	}
 
@@ -253,6 +259,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_queue *q;
 	int qid = skb_get_queue_mapping(skb);
+	bool ext_phy = phy != &dev->phy;
 
 	if (WARN_ON(qid >= MT_TXQ_PSD)) {
 		qid = MT_TXQ_BE;
@@ -276,6 +283,9 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 			mt76_check_agg_ssn(mtxq, skb);
 	}
 
+	if (ext_phy)
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+
 	q = dev->q_tx[qid].q;
 
 	spin_lock_bh(&q->lock);
@@ -295,6 +305,8 @@ static struct sk_buff *
 mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq, bool ps)
 {
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
+	struct ieee80211_tx_info *info;
+	bool ext_phy = phy != &phy->dev->phy;
 	struct sk_buff *skb;
 
 	skb = skb_dequeue(&mtxq->retry_q);
@@ -311,6 +323,10 @@ mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq, bool ps)
 	if (!skb)
 		return NULL;
 
+	info = IEEE80211_SKB_CB(skb);
+	if (ext_phy)
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+
 	return skb;
 }
 
@@ -597,6 +613,7 @@ EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
 
 void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq)
 {
+	struct ieee80211_hw *hw;
 	struct mt76_txq *mtxq;
 	struct sk_buff *skb;
 
@@ -605,8 +622,10 @@ void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq)
 
 	mtxq = (struct mt76_txq *)txq->drv_priv;
 
-	while ((skb = skb_dequeue(&mtxq->retry_q)) != NULL)
-		ieee80211_free_txskb(dev->hw, skb);
+	while ((skb = skb_dequeue(&mtxq->retry_q)) != NULL) {
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_free_txskb(hw, skb);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_txq_remove);
 
-- 
2.24.0

