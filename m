Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA03A337A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 20:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFJSpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 14:45:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230184AbhFJSpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 14:45:54 -0400
X-UUID: bb733963c657447f9c107e4ec5b0e826-20210611
X-UUID: bb733963c657447f9c107e4ec5b0e826-20210611
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1165988310; Fri, 11 Jun 2021 02:43:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 02:43:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 02:43:51 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/4] mt76: make mt76_update_survey() per phy
Date:   Fri, 11 Jun 2021 02:43:45 +0800
Message-ID: <ae21e917aeac3695fdebabe7f7526326b82abd4c.1623347029.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
References: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce duplicated survey for DBDC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 15 ++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  8 ++---
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 32 +++++++++----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  8 ++---
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 15 +++------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 12 +++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 12 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5a11dacae09f..ebd59d7e5837 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -633,20 +633,19 @@ void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey_active_time);
 
-void mt76_update_survey(struct mt76_dev *dev)
+void mt76_update_survey(struct mt76_phy *phy)
 {
+	struct mt76_dev *dev = phy->dev;
 	ktime_t cur_time;
 
 	if (dev->drv->update_survey)
-		dev->drv->update_survey(dev);
+		dev->drv->update_survey(phy);
 
 	cur_time = ktime_get_boottime();
-	mt76_update_survey_active_time(&dev->phy, cur_time);
-	if (dev->phy2)
-		mt76_update_survey_active_time(dev->phy2, cur_time);
+	mt76_update_survey_active_time(phy, cur_time);
 
 	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
-		struct mt76_channel_state *state = dev->phy.chan_state;
+		struct mt76_channel_state *state = phy->chan_state;
 
 		spin_lock_bh(&dev->cc_lock);
 		state->cc_bss_rx += dev->cur_cc_bss_rx;
@@ -665,7 +664,7 @@ void mt76_set_channel(struct mt76_phy *phy)
 	int timeout = HZ / 5;
 
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
-	mt76_update_survey(dev);
+	mt76_update_survey(phy);
 
 	phy->chandef = *chandef;
 	phy->chan_state = mt76_channel_state(phy, chandef->chan);
@@ -690,7 +689,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 
 	mutex_lock(&dev->mutex);
 	if (idx == 0 && dev->drv->update_survey)
-		mt76_update_survey(dev);
+		mt76_update_survey(phy);
 
 	sband = &phy->sband_2g;
 	if (idx >= sband->sband.n_channels) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ebacd55cb0cd..971195c5ca95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -336,7 +336,7 @@ struct mt76_driver_ops {
 	u16 token_size;
 	u8 mcs_rates;
 
-	void (*update_survey)(struct mt76_dev *dev);
+	void (*update_survey)(struct mt76_phy *phy);
 
 	int (*tx_prepare_skb)(struct mt76_dev *dev, void *txwi_ptr,
 			      enum mt76_txq_id qid, struct mt76_wcid *wcid,
@@ -1046,7 +1046,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  bool more_data);
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 void mt76_set_channel(struct mt76_phy *phy);
-void mt76_update_survey(struct mt76_dev *dev);
+void mt76_update_survey(struct mt76_phy *phy);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 4e76f9868b9b..8435e9597688 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1584,12 +1584,12 @@ mt7603_watchdog_check(struct mt7603_dev *dev, u8 *counter,
 	return true;
 }
 
-void mt7603_update_channel(struct mt76_dev *mdev)
+void mt7603_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
+	struct mt7603_dev *dev = container_of(mphy->dev, struct mt7603_dev, mt76);
 	struct mt76_channel_state *state;
 
-	state = mdev->phy.chan_state;
+	state = mphy->chan_state;
 	state->cc_busy += mt76_rr(dev, MT_MIB_STAT_CCA);
 }
 
@@ -1806,7 +1806,7 @@ void mt7603_mac_work(struct work_struct *work)
 	mutex_lock(&dev->mt76.mutex);
 
 	dev->mphy.mac_work_count++;
-	mt76_update_survey(&dev->mt76);
+	mt76_update_survey(&dev->mphy);
 	mt7603_edcca_check(dev);
 
 	for (i = 0, idx = 0; i < 2; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 1df5b9fed2bb..0fd46d907638 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -256,7 +256,7 @@ void mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t);
 
-void mt7603_update_channel(struct mt76_dev *mdev);
+void mt7603_update_channel(struct mt76_phy *mphy);
 
 void mt7603_edcca_set_strict(struct mt7603_dev *dev, bool val);
 void mt7603_cca_stats_reset(struct mt7603_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6693830bb6a6..303d9f97b52a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1819,43 +1819,41 @@ mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 	state->noise = -(phy->noise >> 4);
 }
 
-static void __mt7615_update_channel(struct mt7615_dev *dev)
+static void mt7615_update_survey(struct mt7615_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
+	ktime_t cur_time;
+
+	/* MT7615 can only update both phys simultaneously
+	 * since some reisters are shared across bands.
+	 */
 
 	mt7615_phy_update_channel(&mdev->phy, 0);
 	if (mdev->phy2)
 		mt7615_phy_update_channel(mdev->phy2, 1);
 
+	cur_time = ktime_get_boottime();
+
+	mt76_update_survey_active_time(&mdev->phy, cur_time);
+	if (mdev->phy2)
+		mt76_update_survey_active_time(mdev->phy2, cur_time);
+	
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
-void mt7615_update_channel(struct mt76_dev *mdev)
+void mt7615_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_dev *dev = container_of(mphy->dev, struct mt7615_dev, mt76);
 
 	if (mt76_connac_pm_wake(&dev->mphy, &dev->pm))
 		return;
 
-	__mt7615_update_channel(dev);
+	mt7615_update_survey(dev);
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 EXPORT_SYMBOL_GPL(mt7615_update_channel);
 
-static void mt7615_update_survey(struct mt7615_dev *dev)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	ktime_t cur_time;
-
-	__mt7615_update_channel(dev);
-	cur_time = ktime_get_boottime();
-
-	mt76_update_survey_active_time(&mdev->phy, cur_time);
-	if (mdev->phy2)
-		mt76_update_survey_active_time(mdev->phy2, cur_time);
-}
-
 static void
 mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8f03dddba8cf..8fbaf8356e1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -471,7 +471,7 @@ int mt7615_set_channel(struct mt7615_phy *phy);
 void mt7615_init_work(struct mt7615_dev *dev);
 
 int mt7615_mcu_restart(struct mt76_dev *dev);
-void mt7615_update_channel(struct mt76_dev *mdev);
+void mt7615_update_channel(struct mt76_phy *mphy);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 0da37867cb64..7572c793aa51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1022,12 +1022,12 @@ void mt76x02_mac_set_tx_protection(struct mt76x02_dev *dev, bool legacy_prot,
 		mt76_wr(dev, MT_TX_PROT_CFG6 + i * 4, vht_prot[i]);
 }
 
-void mt76x02_update_channel(struct mt76_dev *mdev)
+void mt76x02_update_channel(struct mt76_phy *mphy)
 {
-	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
+	struct mt76x02_dev *dev = container_of(mphy->dev, struct mt76x02_dev, mt76);
 	struct mt76_channel_state *state;
 
-	state = mdev->phy.chan_state;
+	state = mphy->chan_state;
 	state->cc_busy += mt76_rr(dev, MT_CH_BUSY);
 
 	spin_lock_bh(&dev->mt76.cc_lock);
@@ -1169,7 +1169,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt76_update_survey(&dev->mt76);
+	mt76_update_survey(&dev->mphy);
 	for (i = 0, idx = 0; i < 16; i++) {
 		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 0cfbaca50210..5dc6c834111e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -195,7 +195,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 			    struct ieee80211_sta *sta, int len);
 void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq);
 void mt76x02_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
-void mt76x02_update_channel(struct mt76_dev *mdev);
+void mt76x02_update_channel(struct mt76_phy *mphy);
 void mt76x02_mac_work(struct work_struct *work);
 
 void mt76x02_mac_cc_reset(struct mt76x02_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 741899aaaed8..c093c13bf1f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1471,16 +1471,16 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 	return sum / n;
 }
 
-static void
-mt7915_phy_update_channel(struct mt76_phy *mphy, int idx)
+void mt7915_update_channel(struct mt76_phy *mphy)
 {
 	struct mt7915_phy *phy = (struct mt7915_phy *)mphy->priv;
 	struct mt76_channel_state *state = mphy->chan_state;
+	bool ext_phy = phy != &phy->dev->phy;
 	int nf;
 
 	mt7915_mcu_get_chan_mib_info(phy, false);
 
-	nf = mt7915_phy_get_nf(phy, idx);
+	nf = mt7915_phy_get_nf(phy, ext_phy);
 	if (!phy->noise)
 		phy->noise = nf << 4;
 	else if (nf)
@@ -1489,13 +1489,6 @@ mt7915_phy_update_channel(struct mt76_phy *mphy, int idx)
 	state->noise = -(phy->noise >> 4);
 }
 
-void mt7915_update_channel(struct mt76_dev *mdev)
-{
-	mt7915_phy_update_channel(&mdev->phy, 0);
-	if (mdev->phy2)
-		mt7915_phy_update_channel(mdev->phy2, 1);
-}
-
 static bool
 mt7915_wait_reset_state(struct mt7915_dev *dev, u32 state)
 {
@@ -1804,7 +1797,7 @@ void mt7915_mac_work(struct work_struct *work)
 
 	mutex_lock(&mphy->dev->mutex);
 
-	mt76_update_survey(mphy->dev);
+	mt76_update_survey(mphy);
 	if (++mphy->mac_work_count == 5) {
 		mphy->mac_work_count = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a4b32e0d64e9..e8cde81f8417 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -436,7 +436,7 @@ int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
-void mt7915_update_channel(struct mt76_dev *mdev);
+void mt7915_update_channel(struct mt76_phy *mphy);
 int mt7915_init_debugfs(struct mt7915_dev *dev);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f518c84d7fa9..5af3a958e5b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1236,18 +1236,18 @@ mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
 	state->noise = -(phy->noise >> 4);
 }
 
-void mt7921_update_channel(struct mt76_dev *mdev)
+void mt7921_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
 
-	if (mt76_connac_pm_wake(&dev->mphy, &dev->pm))
+	if (mt76_connac_pm_wake(mphy, &dev->pm))
 		return;
 
-	mt7921_phy_update_channel(&mdev->phy, 0);
+	mt7921_phy_update_channel(mphy, 0);
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
 
-	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+	mt76_connac_power_save_sched(mphy, &dev->pm);
 }
 
 void mt7921_tx_token_put(struct mt7921_dev *dev)
@@ -1445,7 +1445,7 @@ void mt7921_mac_work(struct work_struct *work)
 
 	mt7921_mutex_acquire(phy->dev);
 
-	mt76_update_survey(mphy->dev);
+	mt76_update_survey(mphy);
 	if (++mphy->mac_work_count == 2) {
 		mphy->mac_work_count = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8aa8d2ecdffa..135f8a3ec310 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -357,7 +357,7 @@ void mt7921_stats_work(struct work_struct *work);
 void mt7921_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
-void mt7921_update_channel(struct mt76_dev *mdev);
+void mt7921_update_channel(struct mt76_phy *mphy);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
 
 int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
-- 
2.18.0

