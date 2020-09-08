Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E332621EA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIHVZV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgIHVZH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:25:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042CCC061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VxAuGq0aDFJjIfBPgmfnXtimE+3Lu0aMdLMNjh59AQ0=; b=CQFi506v0hAJnqpPovI+41BtRR
        WAE8wvaRErOJo605In1DbdDtE7eRwIZ4+1EUZgdFGtlzTkns7h99JzZTQc6IrmvEeRBZoHyxOJ7v9
        ZWSzIF5E2w2SBIEv4xtt+KKepK66SQKFjm3QivcGKrCighd/cSMEVImhGt8i5L4Rnkvk=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl04-0002Cx-5j
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:18:00 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/11] mt76: remove retry_q from struct mt76_txq and related code
Date:   Tue,  8 Sep 2020 23:17:56 +0200
Message-Id: <20200908211756.15998-11-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the switch to using AQL by default, mtxq->retry_q is never filled anymore
Remove it to get rid of a few more unnecessary cycles in the tx path

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 19 -------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 --
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 --
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  3 --
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 --
 drivers/net/wireless/mediatek/mt76/tx.c       | 51 +++----------------
 7 files changed, 6 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3a6d15b73c06..4068edacae09 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -879,7 +879,6 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	struct ieee80211_hw *hw;
 	struct mt76_wcid *wcid = status->wcid;
 	bool ps;
-	int i;
 
 	hw = mt76_phy_hw(dev, status->ext_phy);
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid) {
@@ -929,20 +928,6 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 	dev->drv->sta_ps(dev, sta, ps);
 	ieee80211_sta_ps_transition(sta, ps);
-
-	if (ps)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
-		struct mt76_txq *mtxq;
-
-		if (!sta->txq[i])
-			continue;
-
-		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-		if (!skb_queue_empty(&mtxq->retry_q))
-			ieee80211_schedule_txq(hw, sta->txq[i]);
-	}
 }
 
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
@@ -1004,8 +989,6 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 
 		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
 		mtxq->wcid = wcid;
-
-		mt76_txq_init(dev, sta->txq[i]);
 	}
 
 	ewma_signal_init(&wcid->rssi);
@@ -1033,8 +1016,6 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		dev->drv->sta_remove(dev, vif, sta);
 
 	mt76_tx_status_check(dev, wcid, true);
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
-		mt76_txq_remove(dev, sta->txq[i]);
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
 	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9b191089defa..bc06d67f7452 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -226,11 +226,8 @@ struct mt76_wcid {
 };
 
 struct mt76_txq {
-	struct mt76_queue *q;
 	struct mt76_wcid *wcid;
 
-	struct sk_buff_head retry_q;
-
 	u16 agg_ssn;
 	bool send_bar;
 	bool aggr;
@@ -900,8 +897,6 @@ static inline bool mt76_testmode_enabled(struct mt76_dev *dev)
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
 void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
-void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq);
-void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq);
 void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index f9ffa8825a79..c9226dceb510 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -75,7 +75,6 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	mtxq->wcid = &mvif->sta.wcid;
-	mt76_txq_init(&dev->mt76, vif->txq);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 
 out:
@@ -99,7 +98,6 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mt7603_beacon_set_timer(dev, mvif->idx, 0);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
-	mt76_txq_remove(&dev->mt76, vif->txq);
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3c0101a90205..3186b7b2ca48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -205,7 +205,6 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = &mvif->sta.wcid;
-		mt76_txq_init(&dev->mt76, vif->txq);
 	}
 
 	ret = mt7615_mcu_add_dev_info(dev, vif, true);
@@ -256,8 +255,6 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
-	if (vif->txq)
-		mt76_txq_remove(&dev->mt76, vif->txq);
 
 	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 	dev->omac_mask &= ~BIT(mvif->omac_idx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 412f3f7aab46..11b769af2f8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -294,8 +294,6 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->group_wcid.hw_key_idx = -1;
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	mtxq->wcid = &mvif->group_wcid;
-
-	mt76_txq_init(&dev->mt76, vif->txq);
 }
 
 int
@@ -347,7 +345,6 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-	mt76_txq_remove(&dev->mt76, vif->txq);
 	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 5079098aa025..c48158392057 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -169,7 +169,6 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = &mvif->sta.wcid;
-		mt76_txq_init(&dev->mt76, vif->txq);
 	}
 
 out:
@@ -192,8 +191,6 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mt7915_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
-	if (vif->txq)
-		mt76_txq_remove(&dev->mt76, vif->txq);
 
 	mutex_lock(&dev->mt76.mutex);
 	phy->mt76->vif_mask &= ~BIT(mvif->idx);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 007444385797..bf7a6b3a8db0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -301,23 +301,13 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 EXPORT_SYMBOL_GPL(mt76_tx);
 
 static struct sk_buff *
-mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq, bool ps)
+mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq)
 {
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	struct ieee80211_tx_info *info;
 	bool ext_phy = phy != &phy->dev->phy;
 	struct sk_buff *skb;
 
-	skb = skb_dequeue(&mtxq->retry_q);
-	if (skb) {
-		u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-
-		if (ps && skb_queue_empty(&mtxq->retry_q))
-			ieee80211_sta_set_buffered(txq->sta, tid, false);
-
-		return skb;
-	}
-
 	skb = ieee80211_tx_dequeue(phy->hw, txq);
 	if (!skb)
 		return NULL;
@@ -367,7 +357,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			continue;
 
 		do {
-			skb = mt76_txq_dequeue(phy, mtxq, true);
+			skb = mt76_txq_dequeue(phy, mtxq);
 			if (!skb)
 				break;
 
@@ -410,7 +400,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 	if (atomic_read(&wcid->non_aql_packets) >= MT_MAX_NON_AQL_PKT)
 		return 0;
 
-	skb = mt76_txq_dequeue(phy, mtxq, false);
+	skb = mt76_txq_dequeue(phy, mtxq);
 	if (!skb)
 		return 0;
 
@@ -434,7 +424,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
 			break;
 
-		skb = mt76_txq_dequeue(phy, mtxq, false);
+		skb = mt76_txq_dequeue(phy, mtxq);
 		if (!skb)
 			break;
 
@@ -499,8 +489,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		}
 
 		ret += mt76_txq_send_burst(phy, q, mtxq);
-		ieee80211_return_txq(phy->hw, txq,
-				     !skb_queue_empty(&mtxq->retry_q));
+		ieee80211_return_txq(phy->hw, txq, false);
 	}
 	spin_unlock_bh(&q->lock);
 
@@ -562,8 +551,8 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 		if (!txq)
 			continue;
 
+		hwq = dev->q_tx[mt76_txq_get_qid(txq)];
 		mtxq = (struct mt76_txq *)txq->drv_priv;
-		hwq = mtxq->q;
 
 		spin_lock_bh(&hwq->lock);
 		mtxq->send_bar = mtxq->aggr && send_bar;
@@ -584,34 +573,6 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 }
 EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
 
-void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq)
-{
-	struct ieee80211_hw *hw;
-	struct mt76_txq *mtxq;
-	struct sk_buff *skb;
-
-	if (!txq)
-		return;
-
-	mtxq = (struct mt76_txq *)txq->drv_priv;
-
-	while ((skb = skb_dequeue(&mtxq->retry_q)) != NULL) {
-		hw = mt76_tx_status_get_hw(dev, skb);
-		ieee80211_free_txskb(hw, skb);
-	}
-}
-EXPORT_SYMBOL_GPL(mt76_txq_remove);
-
-void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq)
-{
-	struct mt76_txq *mtxq = (struct mt76_txq *)txq->drv_priv;
-
-	skb_queue_head_init(&mtxq->retry_q);
-
-	mtxq->q = dev->q_tx[mt76_txq_get_qid(txq)];
-}
-EXPORT_SYMBOL_GPL(mt76_txq_init);
-
 u8 mt76_ac_to_hwq(u8 ac)
 {
 	static const u8 wmm_queue_map[] = {
-- 
2.28.0

