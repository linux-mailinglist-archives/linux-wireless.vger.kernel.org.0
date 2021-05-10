Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD376377F55
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEJJ2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46314C06138B
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dF696CKD/KMrlTeyATg+e+p1KAq/2JY4qBH2HeMIN0E=; b=EiU/954kkASmq5QbnDvdbAKZ3a
        LXoD4qACqY0fW9p7EiZNwZEPGeUMeKLOw8JPUGtedLOYZ2MFenAta2dZ2InxElShQjwI5jLcUFPZ2
        cxhlxPeQ/U7cLR8AVxbEIxRMbnkM9i1UC9ZndRM5ADBOx0IxgAVci/XFvCoDa5/w1NL4=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bu-000572-HH
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] mt76: mt7915: rework tx rate reporting
Date:   Mon, 10 May 2021 11:27:02 +0200
Message-Id: <20210510092703.90500-8-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210510092703.90500-1-nbd@nbd.name>
References: <20210510092703.90500-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of attaching the last reported rate to tx packets, use
ieee80211_tx_status_ext to immediately pass the rate to mac80211 after
receiving it from the firmware.
Preparation for implementing full tx status reporting

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 135 +++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   8 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 -
 3 files changed, 61 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2c4516f8dbf1..9b453e45fde0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1073,62 +1073,68 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 }
 
 static void
-mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
-			  struct ieee80211_sta *sta, u8 stat,
-			  struct list_head *free_list)
+mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_tx_status status = {
-		.sta = sta,
-		.info = info,
-		.skb = skb,
-		.free_list = free_list,
-	};
-	struct ieee80211_hw *hw;
+	struct mt7915_txp *txp;
+	int i;
 
-	if (sta) {
-		struct mt7915_sta *msta;
+	txp = mt7915_txwi_to_txp(dev, t);
+	for (i = 0; i < txp->nbuf; i++)
+		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
 
-		msta = (struct mt7915_sta *)sta->drv_priv;
-		status.rate = &msta->stats.tx_rate;
-	}
+static void
+mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
+		 struct ieee80211_sta *sta, struct list_head *free_list)
+{
+	struct ieee80211_tx_status status = {};
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_tx_info *info;
+	struct mt76_wcid *wcid;
+	__le32 *txwi;
+	u16 wcid_idx;
 
-#ifdef CONFIG_NL80211_TESTMODE
-	if (mt76_is_testmode_skb(mdev, skb, &hw)) {
-		struct mt7915_phy *phy = mt7915_hw_phy(hw);
-		struct ieee80211_vif *vif = phy->monitor_vif;
-		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	mt7915_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
 
-		mt76_tx_complete_skb(mdev, mvif->sta.wcid.idx, skb);
-		return;
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (sta) {
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+		wcid_idx = wcid->idx;
+
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7915_tx_check_aggr(sta, txwi);
+	} else {
+		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
 	}
-#endif
 
-	hw = mt76_tx_status_get_hw(mdev, skb);
+	info = IEEE80211_SKB_CB(t->skb);
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+		struct ieee80211_hw *hw;
 
-	if (info->flags & IEEE80211_TX_CTL_AMPDU)
-		info->flags |= IEEE80211_TX_STAT_AMPDU;
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
 
-	if (stat)
-		ieee80211_tx_info_clear_status(info);
+		info->status.rates[0].count = 0;
+		info->status.rates[0].idx = -1;
 
-	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
+		status.skb = t->skb;
+		status.sta = sta;
+		status.info = info;
 
-	info->status.tx_time = 0;
-	ieee80211_tx_status_ext(hw, &status);
-}
+		hw = mt76_tx_status_get_hw(mdev, t->skb);
+		ieee80211_tx_status_ext(hw, &status);
 
-void mt7915_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *t)
-{
-	struct mt7915_txp *txp;
-	int i;
+		goto out;
+	}
 
-	txp = mt7915_txwi_to_txp(dev, t);
-	for (i = 0; i < txp->nbuf; i++)
-		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
-				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
 }
 
 static void
@@ -1197,28 +1203,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		if (!txwi)
 			continue;
 
-		mt7915_txp_skb_unmap(mdev, txwi);
-		if (txwi->skb) {
-			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txwi->skb);
-			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
-
-			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-				mt7915_tx_check_aggr(sta, txwi_ptr);
-
-			if (sta && !info->tx_time_est) {
-				struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-				int pending;
-
-				pending = atomic_dec_return(&wcid->non_aql_packets);
-				if (pending < 0)
-					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
-			}
-
-			mt7915_tx_complete_status(mdev, txwi->skb, sta, stat, &free_list);
-			txwi->skb = NULL;
-		}
-
-		mt76_put_txwi(mdev, txwi);
+		mt7915_txwi_free(dev, txwi, sta, &free_list);
 	}
 
 	mt7915_mac_sta_poll(dev);
@@ -1288,15 +1273,8 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		e->skb = t ? t->skb : NULL;
 	}
 
-	if (e->skb) {
-		struct mt76_tx_cb *cb = mt76_tx_skb_cb(e->skb);
-		struct mt76_wcid *wcid;
-
-		wcid = rcu_dereference(dev->mt76.wcid[cb->wcid]);
-
-		mt7915_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0,
-					  NULL);
-	}
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
@@ -1582,14 +1560,7 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7915_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb) {
-			struct ieee80211_hw *hw;
-
-			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
-			ieee80211_free_txskb(hw, txwi->skb);
-		}
-		mt76_put_txwi(&dev->mt76, txwi);
+		mt7915_txwi_free(dev, txwi, NULL, NULL);
 		dev->mt76.token_count--;
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b3f14ff67c5a..9ec414de317e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -469,6 +469,7 @@ mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
 	u16 attempts = le16_to_cpu(ra->attempts);
 	u16 curr = le16_to_cpu(ra->curr_rate);
 	u16 wcidx = le16_to_cpu(ra->wlan_idx);
+	struct ieee80211_tx_status status = {};
 	struct mt76_phy *mphy = &dev->mphy;
 	struct mt7915_sta_stats *stats;
 	struct mt7915_sta *msta;
@@ -500,6 +501,13 @@ mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		stats->per = 1000 * (attempts - success) / attempts;
 	}
+
+	status.sta = wcid_to_sta(wcid);
+	if (!status.sta)
+		return;
+
+	status.rate = &stats->tx_rate;
+	ieee80211_tx_status_ext(mphy->hw, &status);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 279332b557a8..0342729145e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -417,8 +417,6 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7915_stats_work(struct work_struct *work);
-void mt7915_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *txwi);
 int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
-- 
2.30.1

