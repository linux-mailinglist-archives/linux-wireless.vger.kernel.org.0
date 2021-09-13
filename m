Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E371408828
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhIMJ0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 05:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238002AbhIMJ0t (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 027E060FDA;
        Mon, 13 Sep 2021 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631525134;
        bh=pj/IWWL8AaYHQAGwu+3lon5uK+BPaPcWtcp+EP2SQCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmbzV1AFVVxEfmO3XZEP2EvpEta5mxXI3mepvdBDsv2WA2Q1381IvyrhmTkzCvwjs
         4K3/bbtlXsRiR5zRurnmarpVPrRiZAkE9K119zK9W0azCsfe2jojXjT+BzGhIitm8m
         gH5vCGjb0Lmybl4ReC4B5Pv3frFRjyTQB5IoG0eS+5R9Hxes6YwKZlFfyChASs7TKN
         bFYycNNI7sXQ6Afgh8Jhe3LcGRL3FIRMG7OZ4tA2+jM+Ic/f9gzFihjNjOCqLMsDFv
         +zg3FMqB70PHKxlw+k+qJb7vj9tzfFoxH3BpLddQ4ZWzVnFfr4g7t66oj5B6LZMWGE
         Ey5tWZZhsHkNQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        greearb@candelatech.com, mrkiko.rs@gmail.com
Subject: [PATCH 1/4] mt76: introduce packet_id idr
Date:   Mon, 13 Sep 2021 11:25:02 +0200
Message-Id: <3ffee25fdf6d53539255f8761a49ad60f30b84fd.1631525026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631525026.git.lorenzo@kernel.org>
References: <cover.1631525026.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce per-wcid idr to manage packet id for txs. This allow fast idr
lookup and skb queueing at the same time.

Tested-by: mrkiko.rs@gmail.com
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  7 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 26 +++++++---
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 ++
 drivers/net/wireless/mediatek/mt76/tx.c       | 50 +++++++++++++------
 8 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 476fa513d359..e26cdc254fa8 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -566,6 +566,8 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
+	INIT_LIST_HEAD(&dev->wcid_list);
+
 	INIT_LIST_HEAD(&dev->txwi_cache);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
@@ -1232,6 +1234,7 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	wcid->ext_phy = ext_phy;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
+	mt76_packet_id_init(wcid);
 out:
 	mutex_unlock(&dev->mutex);
 
@@ -1250,9 +1253,11 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	if (dev->drv->sta_remove)
 		dev->drv->sta_remove(dev, vif, sta);
 
-	mt76_tx_status_check(dev, wcid, true);
+	mt76_packet_id_flush(dev, wcid);
+
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
 	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
+
 }
 EXPORT_SYMBOL_GPL(__mt76_sta_remove);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ec360829a9ab..2e5e49c1d071 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -261,7 +261,8 @@ struct mt76_wcid {
 	u32 tx_info;
 	bool sw_iv;
 
-	u8 packet_id;
+	struct list_head list;
+	struct idr pktid;
 };
 
 struct mt76_txq {
@@ -701,6 +702,7 @@ struct mt76_dev {
 
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
+	struct list_head wcid_list;
 
 	u32 rev;
 
@@ -1310,14 +1312,22 @@ mt76_token_put(struct mt76_dev *dev, int token)
 	return txwi;
 }
 
-static inline int
-mt76_get_next_pkt_id(struct mt76_wcid *wcid)
+static inline void mt76_packet_id_init(struct mt76_wcid *wcid)
+{
+	INIT_LIST_HEAD(&wcid->list);
+	idr_init(&wcid->pktid);
+}
+
+static inline void
+mt76_packet_id_flush(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
-	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
-	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
-		wcid->packet_id = MT_PACKET_ID_FIRST;
+	struct sk_buff_head list;
 
-	return wcid->packet_id;
+	mt76_tx_status_lock(dev, &list);
+	mt76_tx_status_skb_get(dev, wcid, -1, &list);
+	mt76_tx_status_unlock(dev, &list);
+
+	idr_destroy(&wcid->pktid);
 }
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 8edea1e7a602..7ac4cd247a73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -69,6 +69,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
+	mt76_packet_id_init(&mvif->sta.wcid);
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, idx, mvif->idx, bc_addr);
@@ -107,6 +108,8 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mutex_lock(&dev->mt76.mutex);
 	dev->mt76.vif_mask &= ~BIT(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
+
+	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
 }
 
 void mt7603_init_edcca(struct mt7603_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7154acf3eb9b..9795c1b4551f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -231,6 +231,8 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
+	mt76_packet_id_init(&mvif->sta.wcid);
+
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -284,6 +286,8 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
 }
 
 static void mt7615_init_dfs_state(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ccdbab341271..1f17d86ff755 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -287,6 +287,8 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mvif->group_wcid.hw_key_idx = -1;
+	mt76_packet_id_init(&mvif->group_wcid);
+
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	mtxq->wcid = &mvif->group_wcid;
 }
@@ -341,6 +343,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
 	dev->mt76.vif_mask &= ~BIT(mvif->idx);
+	mt76_packet_id_flush(&dev->mt76, &mvif->group_wcid);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0aea6272fd14..0f72cb4002ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -239,6 +239,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.ext_phy = mvif->band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_packet_id_init(&mvif->sta.wcid);
+
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -293,6 +295,8 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
 
 static void mt7915_init_dfs_state(struct mt7915_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index cd3974b6ba8f..c51266e40cb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -304,6 +304,8 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_packet_id_init(&mvif->sta.wcid);
+
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -350,6 +352,8 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
 
 static int mt7921_set_channel(struct mt7921_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6f302acb6e69..5ae95018415f 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -92,8 +92,6 @@ __mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb, u8 flags,
 	if ((flags & done) != done)
 		return;
 
-	__skb_unlink(skb, &dev->status_list);
-
 	/* Tx status can be unreliable. if it fails, mark the frame as ACKed */
 	if (flags & MT_TX_CB_TXS_FAILED) {
 		info->status.rates[0].count = 0;
@@ -120,6 +118,8 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 	int pid;
 
+	memset(cb, 0, sizeof(*cb));
+
 	if (!wcid)
 		return MT_PACKET_ID_NO_ACK;
 
@@ -132,13 +132,21 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 	spin_lock_bh(&dev->status_list.lock);
 
-	memset(cb, 0, sizeof(*cb));
-	pid = mt76_get_next_pkt_id(wcid);
+	pid = idr_alloc(&wcid->pktid, skb, MT_PACKET_ID_FIRST,
+			MT_PACKET_ID_MASK, GFP_ATOMIC);
+	if (pid < 0) {
+		pid = MT_PACKET_ID_NO_SKB;
+		goto out;
+	}
+
 	cb->wcid = wcid->idx;
 	cb->pktid = pid;
 	cb->jiffies = jiffies;
 
-	__skb_queue_tail(&dev->status_list, skb);
+	if (list_empty(&wcid->list))
+		list_add_tail(&wcid->list, &dev->wcid_list);
+
+out:
 	spin_unlock_bh(&dev->status_list.lock);
 
 	return pid;
@@ -149,26 +157,33 @@ struct sk_buff *
 mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		       struct sk_buff_head *list)
 {
-	struct sk_buff *skb, *tmp;
+	struct sk_buff *skb;
+	int id;
 
-	skb_queue_walk_safe(&dev->status_list, skb, tmp) {
-		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
+	lockdep_assert_held(&dev->status_list.lock);
 
-		if (wcid && cb->wcid != wcid->idx)
-			continue;
+	skb = idr_remove(&wcid->pktid, pktid);
+	if (skb)
+		goto out;
 
-		if (cb->pktid == pktid)
-			return skb;
+	/* look for stale entries in the wcid idr queue */
+	idr_for_each_entry(&wcid->pktid, skb, id) {
+		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 
 		if (pktid >= 0 && !time_after(jiffies, cb->jiffies +
 					      MT_TX_STATUS_SKB_TIMEOUT))
 			continue;
 
+		idr_remove(&wcid->pktid, cb->pktid);
 		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
 						    MT_TX_CB_TXS_DONE, list);
 	}
 
-	return NULL;
+out:
+	if (idr_is_empty(&wcid->pktid))
+		list_del_init(&wcid->list);
+
+	return skb;
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_skb_get);
 
@@ -178,7 +193,11 @@ mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid, bool flush)
 	struct sk_buff_head list;
 
 	mt76_tx_status_lock(dev, &list);
-	mt76_tx_status_skb_get(dev, wcid, flush ? -1 : 0, &list);
+	while (!list_empty(&dev->wcid_list)) {
+		wcid = list_first_entry(&dev->wcid_list, struct mt76_wcid,
+					list);
+		mt76_tx_status_skb_get(dev, wcid, flush ? -1 : 0, &list);
+	}
 	mt76_tx_status_unlock(dev, &list);
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_check);
@@ -201,6 +220,7 @@ mt76_tx_check_non_aql(struct mt76_dev *dev, struct mt76_wcid *wcid,
 void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
 			    struct list_head *free_list)
 {
+	struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 	struct ieee80211_tx_status status = {
 		.skb = skb,
 		.free_list = free_list,
@@ -230,7 +250,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	}
 #endif
 
-	if (!skb->prev) {
+	if (cb->pktid < MT_PACKET_ID_FIRST) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
 		ieee80211_tx_status_ext(hw, &status);
-- 
2.31.1

