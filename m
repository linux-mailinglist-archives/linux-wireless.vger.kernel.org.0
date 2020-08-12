Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E14242836
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHLK2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLK2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E7C06174A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qwihvkBn/j7pJCLCx5Fdxp/XbggZLVUo5EzSY0YFlr0=; b=jgLPHb8EgdtdwNAvko65PKUAMk
        jZeIJT7sVLzXF/yyRt/q3k74atFdVhQozEgEnI+DhqqKXrIpkJ7LyPLOc5uLuujQV6BuEfld2hLpM
        xeE0hn33a/0Wmrc1e7JFQMZdTfSydy+IHTuS/cCqb1M+vcZ0x0w+1KZaOXyOezGbb1iw=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzj-0002U3-PG
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] mt76: mt7915: clean up station stats polling and rate control update
Date:   Wed, 12 Aug 2020 12:28:24 +0200
Message-Id: <20200812102831.11991-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Queueing a per-sta work item from the tx free path can become very expensive
under load. This work is only supposed to pull rate control stats every
second and deal with rate control changes.

Additionally, the rate control update code was wrong, because it was
confusing bit masks and bit numbers in test_bit.

Fix this by introducing a dedicated device work item for rate control
updates, and by polling station stats from the phy mac work.
Stations requiring polling or rate control updates are added to lists
protected by dev->sta_poll_lock.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 83 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 27 +++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 11 ++-
 5 files changed, 88 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 0e6ce6e22142..677b9479176b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -414,7 +414,7 @@ static int mt7915_sta_fixed_rate_set(void *data, u64 rate)
 	struct ieee80211_sta *sta = data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
-	return mt7915_mcu_set_fixed_rate(msta->vif->dev, sta, rate);
+	return mt7915_mcu_set_fixed_rate(msta->vif->phy->dev, sta, rate);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fixed_rate, NULL,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ae1ed9ae7611..47fde7429683 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -618,6 +618,7 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7915_init_wiphy(mphy->hw);
 
+	INIT_LIST_HEAD(&phy->stats_list);
 	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
 
 	/*
@@ -658,7 +659,10 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+	INIT_LIST_HEAD(&dev->phy.stats_list);
+	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7915_mac_work);
+	INIT_LIST_HEAD(&dev->sta_rc_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 99ab5fca0f6d..64089a8a01c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -881,6 +881,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		 */
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7915_sta *msta;
+			struct mt7915_phy *phy;
 			struct mt76_wcid *wcid;
 			u16 idx;
 
@@ -892,8 +893,13 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 				continue;
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
-			ieee80211_queue_work(mt76_hw(dev), &msta->stats_work);
-			continue;
+			phy = msta->vif->phy;
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->stats_list))
+				list_add_tail(&msta->stats_list, &phy->stats_list);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
 		}
 
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
@@ -1282,39 +1288,63 @@ mt7915_mac_update_mib_stats(struct mt7915_phy *phy)
 	}
 }
 
-void mt7915_mac_sta_stats_work(struct work_struct *work)
+static void
+mt7915_mac_sta_stats_work(struct mt7915_phy *phy)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_sta *msta;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&phy->stats_list, &list);
+
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7915_sta, stats_list);
+		list_del_init(&msta->stats_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		/* use MT_TX_FREE_RATE to report Tx rate for further devices */
+		mt7915_mcu_get_rate_info(dev, RATE_CTRL_RU_INFO, msta->wcid.idx);
+
+		spin_lock_bh(&dev->sta_poll_lock);
+	}
+
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
+void mt7915_mac_sta_rc_work(struct work_struct *work)
 {
+	struct mt7915_dev *dev = container_of(work, struct mt7915_dev, rc_work);
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
-	struct mt7915_sta_stats *stats;
 	struct mt7915_sta *msta;
-	struct mt7915_dev *dev;
+	u32 changed;
+	LIST_HEAD(list);
 
-	msta = container_of(work, struct mt7915_sta, stats_work);
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
-	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
-	dev = msta->vif->dev;
-	stats = &msta->stats;
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_rc_list, &list);
 
-	/* use MT_TX_FREE_RATE to report Tx rate for further devices */
-	if (time_after(jiffies, stats->jiffies + HZ)) {
-		mt7915_mcu_get_rate_info(dev, RATE_CTRL_RU_INFO,
-					 msta->wcid.idx);
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7915_sta, rc_list);
+		list_del_init(&msta->rc_list);
+		changed = msta->stats.changed;
+		msta->stats.changed = 0;
+		spin_unlock_bh(&dev->sta_poll_lock);
 
-		stats->jiffies = jiffies;
-	}
+		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
-	if (test_and_clear_bit(IEEE80211_RC_SUPP_RATES_CHANGED |
+		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
 			       IEEE80211_RC_NSS_CHANGED |
-			       IEEE80211_RC_BW_CHANGED, &stats->changed))
-		mt7915_mcu_add_rate_ctrl(dev, vif, sta);
+			       IEEE80211_RC_BW_CHANGED))
+			mt7915_mcu_add_rate_ctrl(dev, vif, sta);
 
-	if (test_and_clear_bit(IEEE80211_RC_SMPS_CHANGED, &stats->changed))
-		mt7915_mcu_add_smps(dev, vif, sta);
+		if (changed & IEEE80211_RC_SMPS_CHANGED)
+			mt7915_mcu_add_smps(dev, vif, sta);
+
+		spin_lock_bh(&dev->sta_poll_lock);
+	}
 
-	spin_lock_bh(&dev->sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
@@ -1336,6 +1366,11 @@ void mt7915_mac_work(struct work_struct *work)
 		mt7915_mac_update_mib_stats(phy);
 	}
 
+	if (++phy->sta_work_count == 10) {
+		phy->sta_work_count = 0;
+		mt7915_mac_sta_stats_work(phy);
+	};
+
 	mutex_unlock(&mdev->mutex);
 
 	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 889f5f93ce30..0feea2c33717 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -137,7 +137,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 		goto out;
 	}
 	mvif->omac_idx = idx;
-	mvif->dev = dev;
+	mvif->phy = phy;
 	mvif->band_idx = ext_phy;
 
 	if (ext_phy)
@@ -155,6 +155,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 
 	idx = MT7915_WTBL_RESERVED - mvif->idx;
 
+	INIT_LIST_HEAD(&mvif->sta.rc_list);
+	INIT_LIST_HEAD(&mvif->sta.stats_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.ext_phy = mvif->band_idx;
@@ -493,8 +495,9 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
+	INIT_LIST_HEAD(&msta->rc_list);
+	INIT_LIST_HEAD(&msta->stats_list);
 	INIT_LIST_HEAD(&msta->poll_list);
-	INIT_WORK(&msta->stats_work, mt7915_mac_sta_stats_work);
 	spin_lock_init(&msta->ampdu_lock);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
@@ -528,6 +531,10 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->stats_list))
+		list_del_init(&msta->stats_list);
+	if (!list_empty(&msta->rc_list))
+		list_del_init(&msta->rc_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
@@ -789,18 +796,16 @@ mt7915_sta_rc_update(struct ieee80211_hw *hw,
 		     struct ieee80211_sta *sta,
 		     u32 changed)
 {
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
-	rcu_read_lock();
-	sta = ieee80211_find_sta(vif, sta->addr);
-	if (!sta) {
-		rcu_read_unlock();
-		return;
-	}
-	rcu_read_unlock();
+	spin_lock_bh(&dev->sta_poll_lock);
+	msta->stats.changed |= changed;
+	if (list_empty(&msta->rc_list))
+		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
 
-	set_bit(changed, &msta->stats.changed);
-	ieee80211_queue_work(hw, &msta->stats_work);
+	ieee80211_queue_work(hw, &dev->rc_work);
 }
 
 const struct ieee80211_ops mt7915_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3eaf5e64b0b4..f8b7752a201b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -79,11 +79,12 @@ struct mt7915_sta {
 
 	struct mt7915_vif *vif;
 
+	struct list_head stats_list;
 	struct list_head poll_list;
+	struct list_head rc_list;
 	u32 airtime_ac[8];
 
 	struct mt7915_sta_stats stats;
-	struct work_struct stats_work;
 
 	spinlock_t ampdu_lock;
 	enum mt7915_ampdu_state ampdu_state[IEEE80211_NUM_TIDS];
@@ -96,7 +97,7 @@ struct mt7915_vif {
 	u8 wmm_idx;
 
 	struct mt7915_sta sta;
-	struct mt7915_dev *dev;
+	struct mt7915_phy *phy;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 };
@@ -131,9 +132,11 @@ struct mt7915_phy {
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
+	struct list_head stats_list;
 
 	struct delayed_work mac_work;
 	u8 mac_work_count;
+	u8 sta_work_count;
 };
 
 struct mt7915_dev {
@@ -147,10 +150,12 @@ struct mt7915_dev {
 	u16 chainmask;
 
 	struct work_struct init_work;
+	struct work_struct rc_work;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_wait;
 	u32 reset_state;
 
+	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
@@ -455,7 +460,7 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
-void mt7915_mac_sta_stats_work(struct work_struct *work);
+void mt7915_mac_sta_rc_work(struct work_struct *work);
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
-- 
2.28.0

