Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15179BC69
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjIKVsZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjIKSiq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 14:38:46 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A51AD
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BdZtx2ZmTTqQB+AL28Qg5Gu5+zP2wWrVp8BKJchrUPM=; b=bba2vc8LxOOD4AHtqOI3zEs6OP
        GyQ1TDlCA5fIPj7Rs4u3FPKhUjtXQ7SMpsQtMM8SmrDjkNP0U0Pq6vnhmn8BQn1MM4gl6Fe4ENw+B
        7FzbQyoffjuZdKZ/mK89n7bGiox1CDbVSeXiyQ5NQjcFAOQPbIZ3p1ZbPEweViiVVnJE=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qflny-000t0P-9B; Mon, 11 Sep 2023 20:38:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <Ryder.Lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: fix race condition related to checking tx queue fill status
Date:   Mon, 11 Sep 2023 20:38:36 +0200
Message-ID: <20230911183837.51601-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When drv_tx calls race against local tx scheduling, the queue fill status checks
can potentially race, leading to dma queue entries being overwritten.
Fix this by deferring packets from drv_tx calls to the tx worker, in order to
ensure that all regular queue tx comes from the same context.

Reported-by: Ryder Lee <Ryder.Lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  50 +++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  24 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 108 ++++++++++++++----
 10 files changed, 155 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index db24634e4a08..8cd1a7ed82f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -415,6 +415,9 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	struct mt76_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
+	INIT_LIST_HEAD(&phy->tx_list);
+	spin_lock_init(&phy->tx_lock);
+
 	SET_IEEE80211_DEV(hw, dev->dev);
 	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
 
@@ -689,6 +692,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
+	mt76_wcid_init(&dev->global_wcid);
 	ret = mt76_phy_init(phy, hw);
 	if (ret)
 		return ret;
@@ -744,6 +748,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(&dev->phy);
 	mt76_tx_status_check(dev, true);
+	mt76_wcid_cleanup(dev, &dev->global_wcid);
 	ieee80211_unregister_hw(hw);
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_device);
@@ -1412,7 +1417,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
-	mt76_packet_id_init(wcid);
+	mt76_wcid_init(wcid);
 out:
 	mutex_unlock(&dev->mutex);
 
@@ -1431,7 +1436,7 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	if (dev->drv->sta_remove)
 		dev->drv->sta_remove(dev, vif, sta);
 
-	mt76_packet_id_flush(dev, wcid);
+	mt76_wcid_cleanup(dev, wcid);
 
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
 	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
@@ -1487,6 +1492,47 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
 
+void mt76_wcid_init(struct mt76_wcid *wcid)
+{
+	INIT_LIST_HEAD(&wcid->tx_list);
+	skb_queue_head_init(&wcid->tx_pending);
+
+	INIT_LIST_HEAD(&wcid->list);
+	idr_init(&wcid->pktid);
+}
+EXPORT_SYMBOL_GPL(mt76_wcid_init);
+
+void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
+{
+	struct mt76_phy *phy = dev->phys[wcid->phy_idx];
+	struct ieee80211_hw *hw;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	mt76_tx_status_lock(dev, &list);
+	mt76_tx_status_skb_get(dev, wcid, -1, &list);
+	mt76_tx_status_unlock(dev, &list);
+
+	idr_destroy(&wcid->pktid);
+
+	spin_lock_bh(&phy->tx_lock);
+
+	if (!list_empty(&wcid->tx_list))
+		list_del_init(&wcid->tx_list);
+
+	spin_lock(&wcid->tx_pending.lock);
+	skb_queue_splice_tail_init(&wcid->tx_pending, &list);
+	spin_unlock(&wcid->tx_pending.lock);
+
+	spin_unlock_bh(&phy->tx_lock);
+
+	while ((skb = __skb_dequeue(&list)) != NULL) {
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_free_txskb(hw, skb);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e8757865a3d0..9265e1b84b4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -334,6 +334,9 @@ struct mt76_wcid {
 	u32 tx_info;
 	bool sw_iv;
 
+	struct list_head tx_list;
+	struct sk_buff_head tx_pending;
+
 	struct list_head list;
 	struct idr pktid;
 
@@ -719,6 +722,8 @@ struct mt76_phy {
 	unsigned long state;
 	u8 band_idx;
 
+	spinlock_t tx_lock;
+	struct list_head tx_list;
 	struct mt76_queue *q_tx[__MT_TXQ_MAX];
 
 	struct cfg80211_chan_def chandef;
@@ -1598,22 +1603,7 @@ mt76_token_put(struct mt76_dev *dev, int token)
 	return txwi;
 }
 
-static inline void mt76_packet_id_init(struct mt76_wcid *wcid)
-{
-	INIT_LIST_HEAD(&wcid->list);
-	idr_init(&wcid->pktid);
-}
-
-static inline void
-mt76_packet_id_flush(struct mt76_dev *dev, struct mt76_wcid *wcid)
-{
-	struct sk_buff_head list;
-
-	mt76_tx_status_lock(dev, &list);
-	mt76_tx_status_skb_get(dev, wcid, -1, &list);
-	mt76_tx_status_unlock(dev, &list);
-
-	idr_destroy(&wcid->pktid);
-}
+void mt76_wcid_init(struct mt76_wcid *wcid);
+void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index c213fd2a5216..89d738deea62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -70,7 +70,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.vif = mvif;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, idx, mvif->idx, bc_addr);
@@ -110,7 +110,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
 }
 
 void mt7603_init_edcca(struct mt7603_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 200b1752ca77..dab16b5fc386 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -226,7 +226,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -279,7 +279,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
 }
 
 int mt7615_set_channel(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dcbb5c605dfe..8a0e8124b894 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -288,7 +288,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mvif->group_wcid.hw_key_idx = -1;
-	mt76_packet_id_init(&mvif->group_wcid);
+	mt76_wcid_init(&mvif->group_wcid);
 
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	rcu_assign_pointer(dev->mt76.wcid[MT_VIF_WCID(idx)], &mvif->group_wcid);
@@ -346,7 +346,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	rcu_assign_pointer(dev->mt76.wcid[mvif->group_wcid.idx], NULL);
-	mt76_packet_id_flush(&dev->mt76, &mvif->group_wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->group_wcid);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ebbf186fab2..55809d9f7a7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -253,7 +253,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.phy_idx = ext_phy;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -314,7 +314,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
 int mt7915_set_channel(struct mt7915_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 62e6da1386aa..571b82ed9293 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -315,7 +315,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 46be7f996c7e..5648b7328b8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -115,7 +115,7 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 EXPORT_SYMBOL_GPL(mt792x_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c3a479dc3f53..7947142f94b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -207,7 +207,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.phy_idx = band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -268,7 +268,7 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
 int mt7996_set_channel(struct mt7996_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6cc26cc6c517..1809b03292c3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -329,40 +329,32 @@ void
 mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
-	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct mt76_queue *q;
-	int qid = skb_get_queue_mapping(skb);
 
 	if (mt76_testmode_enabled(phy)) {
 		ieee80211_free_txskb(phy->hw, skb);
 		return;
 	}
 
-	if (WARN_ON(qid >= MT_TXQ_PSD)) {
-		qid = MT_TXQ_BE;
-		skb_set_queue_mapping(skb, qid);
-	}
-
-	if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
-	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
-	    !ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_bufferable_mmpdu(skb)) {
-		qid = MT_TXQ_PSD;
-	}
+	if (WARN_ON(skb_get_queue_mapping(skb) >= MT_TXQ_PSD))
+		skb_set_queue_mapping(skb, MT_TXQ_BE);
 
 	if (wcid && !(wcid->tx_info & MT_WCID_TX_INFO_SET))
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
 
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
-	q = phy->q_tx[qid];
 
-	spin_lock_bh(&q->lock);
-	__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
-	dev->queue_ops->kick(dev, q);
-	spin_unlock_bh(&q->lock);
+	spin_lock_bh(&wcid->tx_pending.lock);
+	__skb_queue_tail(&wcid->tx_pending, skb);
+	spin_unlock_bh(&wcid->tx_pending.lock);
+
+	spin_lock_bh(&phy->tx_lock);
+	if (list_empty(&wcid->tx_list))
+		list_add_tail(&wcid->tx_list, &phy->tx_list);
+	spin_unlock_bh(&phy->tx_lock);
+
+	mt76_worker_schedule(&phy->dev->tx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76_tx);
 
@@ -593,10 +585,86 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 
+static int
+mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_sta *sta;
+	struct mt76_queue *q;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	spin_lock(&wcid->tx_pending.lock);
+	while ((skb = skb_peek(&wcid->tx_pending)) != NULL) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		int qid = skb_get_queue_mapping(skb);
+
+		if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
+		    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+		    !ieee80211_is_data(hdr->frame_control) &&
+		    !ieee80211_is_bufferable_mmpdu(skb))
+			qid = MT_TXQ_PSD;
+
+		q = phy->q_tx[qid];
+		if (mt76_txq_stopped(q)) {
+			ret = -1;
+			break;
+		}
+
+		__skb_unlink(skb, &wcid->tx_pending);
+		spin_unlock(&wcid->tx_pending.lock);
+
+		sta = wcid_to_sta(wcid);
+		spin_lock(&q->lock);
+		__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
+		dev->queue_ops->kick(dev, q);
+		spin_unlock(&q->lock);
+
+		spin_lock(&wcid->tx_pending.lock);
+	}
+	spin_unlock(&wcid->tx_pending.lock);
+
+	return ret;
+}
+
+static void mt76_txq_schedule_pending(struct mt76_phy *phy)
+{
+	if (list_empty(&phy->tx_list))
+		return;
+
+	local_bh_disable();
+	rcu_read_lock();
+
+	spin_lock(&phy->tx_lock);
+	while (!list_empty(&phy->tx_list)) {
+		struct mt76_wcid *wcid = NULL;
+		int ret;
+
+		wcid = list_first_entry(&phy->tx_list, struct mt76_wcid, tx_list);
+		list_del_init(&wcid->tx_list);
+
+		spin_unlock(&phy->tx_lock);
+		ret = mt76_txq_schedule_pending_wcid(phy, wcid);
+		spin_lock(&phy->tx_lock);
+
+		if (ret) {
+			if (list_empty(&wcid->tx_list))
+				list_add_tail(&wcid->tx_list, &phy->tx_list);
+			break;
+		}
+	}
+	spin_unlock(&phy->tx_lock);
+
+	rcu_read_unlock();
+	local_bh_enable();
+}
+
 void mt76_txq_schedule_all(struct mt76_phy *phy)
 {
 	int i;
 
+	mt76_txq_schedule_pending(phy);
 	for (i = 0; i <= MT_TXQ_BK; i++)
 		mt76_txq_schedule(phy, i);
 }
-- 
2.41.0

