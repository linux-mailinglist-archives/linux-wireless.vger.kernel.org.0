Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF70E213612
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgGCIQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgGCIQa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:30 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769C1207DA;
        Fri,  3 Jul 2020 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764188;
        bh=VnxuK2cjMKucPOJnLf3a0PUcWlm/iSRbQ3oatwqZBy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNtFmyDkLN6nctrCZzqZN7PSFX2523FHRIXBjFXGvlGq3n0Pm65UsBkftoK0cKpKV
         cfrliEASehJ4SS8RcTKV7A4Bga4lZ/tl4jnIt7GzkVB6E4wGMjkG6FXLu01ZCZJP9/
         KSc4p3zGGfK4PJ82/QrwWVljN1B895DpRYA6/g40=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 04/22] mt76: mt7615: introduce mt7615_mutex_{acquire,release} utilities
Date:   Fri,  3 Jul 2020 10:15:43 +0200
Message-Id: <afa513f23999b10ea00fe54e5efb636976a3cda1.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mutex_{acquire,release} utility routines in order to
switch in full-power/low-power before/after accessing device register-map

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 14 ++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 82 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 16 ++++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 11 +--
 5 files changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4d8cd88473dd..eb56a7819070 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1530,7 +1530,7 @@ void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable)
 	bool ext_phy = phy != &dev->phy;
 	u32 reg, mask;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	if (phy->scs_en == enable)
 		goto out;
@@ -1557,7 +1557,7 @@ void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable)
 	phy->scs_en = enable;
 
 out:
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy)
@@ -1859,7 +1859,7 @@ void mt7615_mac_work(struct work_struct *work)
 						mac_work.work);
 	mdev = &phy->dev->mt76;
 
-	mutex_lock(&mdev->mutex);
+	mt7615_mutex_acquire(phy->dev);
 
 	mt76_update_survey(mdev);
 	if (++phy->mac_work_count == 5) {
@@ -1869,7 +1869,7 @@ void mt7615_mac_work(struct work_struct *work)
 		mt7615_mac_scs_check(phy);
 	}
 
-	mutex_unlock(&mdev->mutex);
+	mt7615_mutex_release(phy->dev);
 
 	mt76_tx_status_check(mdev, NULL, false);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
@@ -1973,7 +1973,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	napi_disable(&dev->mt76.napi[1]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_PDMA_STOPPED);
 
@@ -2006,10 +2006,10 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
 
-	mutex_unlock(&dev->mt76.mutex);
-
 	mt7615_update_beacons(dev);
 
+	mt7615_mutex_release(dev);
+
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	if (phy2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1e7f7b9b1388..5f2c50a2449b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -33,7 +33,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	if (!mt7615_wait_for_mcu_init(dev))
 		return -EIO;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	running = mt7615_dev_running(dev);
 
@@ -60,7 +60,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	if (!running)
 		mt7615_mac_reset_counters(dev);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
@@ -76,7 +76,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 
 	cancel_work_sync(&dev->pm.wake_work);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	mt76_testmode_reset(&dev->mt76, true);
 
@@ -93,7 +93,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 		mt7615_mcu_set_mac_enable(dev, 0, false);
 	}
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 static int get_omac_idx(enum nl80211_iftype type, u32 mask)
@@ -139,7 +139,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	bool ext_phy = phy != &dev->phy;
 	int idx, ret = 0;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	mt76_testmode_reset(&dev->mt76, true);
 
@@ -191,7 +191,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	ret = mt7615_mcu_add_dev_info(dev, vif, true);
 out:
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return ret;
 }
@@ -207,10 +207,9 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	/* TODO: disable beacon for the bss */
 
-	mutex_lock(&dev->mt76.mutex);
-	mt76_testmode_reset(&dev->mt76, true);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
+	mt76_testmode_reset(&dev->mt76, true);
 	if (vif == phy->monitor_vif)
 	    phy->monitor_vif = NULL;
 
@@ -220,11 +219,11 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	if (vif->txq)
 		mt76_txq_remove(&dev->mt76, vif->txq);
 
-	mutex_lock(&dev->mt76.mutex);
 	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 	dev->omac_mask &= ~BIT(mvif->omac_idx);
 	phy->omac_mask &= ~BIT(mvif->omac_idx);
-	mutex_unlock(&dev->mt76.mutex);
+
+	mt7615_mutex_release(dev);
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
@@ -259,7 +258,8 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	cancel_delayed_work_sync(&phy->mac_work);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
+
 	set_bit(MT76_RESET, &phy->mt76->state);
 
 	mt7615_init_dfs_state(phy);
@@ -285,7 +285,8 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 out:
 	clear_bit(MT76_RESET, &phy->mt76->state);
-	mutex_unlock(&dev->mt76.mutex);
+
+	mt7615_mutex_release(dev);
 
 	mt76_txq_schedule_all(phy->mt76);
 
@@ -391,9 +392,9 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 		       IEEE80211_CONF_CHANGE_POWER)) {
 #ifdef CONFIG_NL80211_TESTMODE
 		if (dev->mt76.test.state != MT76_TM_STATE_OFF) {
-			mutex_lock(&dev->mt76.mutex);
+			mt7615_mutex_acquire(dev);
 			mt76_testmode_reset(&dev->mt76, false);
-			mutex_unlock(&dev->mt76.mutex);
+			mt7615_mutex_release(dev);
 		}
 #endif
 		ieee80211_stop_queues(hw);
@@ -401,7 +402,7 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		mt76_testmode_reset(&dev->mt76, true);
@@ -414,7 +415,7 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return ret;
 }
@@ -448,7 +449,7 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 			MT_WF_RFCR1_DROP_CFACK;
 	u32 flags = 0;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 #define MT76_FILTER(_flag, _hw) do { \
 		flags |= *total_flags & FIF_##_flag;			\
@@ -488,7 +489,7 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 	else
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
@@ -499,7 +500,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
@@ -528,7 +529,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER)
 		mt7615_mcu_update_arp_filter(hw, vif, info);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 static void
@@ -538,9 +539,9 @@ mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 	mt7615_mcu_add_beacon(dev, hw, vif, true);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -656,9 +657,9 @@ static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 	mt7615_mcu_set_rts_thresh(phy, val);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
@@ -682,7 +683,8 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mtxq = (struct mt76_txq *)txq->drv_priv;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
+
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
@@ -718,7 +720,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return ret;
 }
@@ -763,13 +765,13 @@ mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		u32 t32[2];
 	} tsf;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0);
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return tsf.t64;
 }
@@ -784,14 +786,14 @@ mt7615_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
 	/* TSF software overwrite */
 	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_WRITE);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 static void
@@ -800,10 +802,10 @@ mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_dev *dev = phy->dev;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 	phy->coverage_class = max_t(s16, coverage_class, 0);
 	mt7615_mac_set_timing(phy);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 }
 
 static int
@@ -820,7 +822,7 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
 		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	phy->mt76->antenna_mask = tx_ant;
 	if (ext_phy) {
@@ -833,7 +835,7 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	mt76_set_stream_caps(phy->mt76, true);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
@@ -995,7 +997,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	bool ext_phy = phy != &dev->phy;
 	int err = 0;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
@@ -1011,7 +1013,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	if (!mt7615_dev_running(dev))
 		err = mt7615_mcu_set_hif_suspend(dev, true);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return err;
 }
@@ -1022,7 +1024,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	bool running, ext_phy = phy != &dev->phy;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 
 	running = mt7615_dev_running(dev);
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -1032,7 +1034,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 
 		err = mt7615_mcu_set_hif_suspend(dev, false);
 		if (err < 0) {
-			mutex_unlock(&dev->mt76.mutex);
+			mt7615_mutex_release(dev);
 			return err;
 		}
 	}
@@ -1046,7 +1048,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 				     MT7615_WATCHDOG_TIME);
 	mt76_clear(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b72c824e5c15..ee21f9b2403c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1937,6 +1937,7 @@ int mt7615_driver_own(struct mt7615_dev *dev)
 
 out:
 	mt7622_trigger_hif_int(dev, false);
+	dev->pm.last_activity = jiffies;
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 194ae43091d6..599445d93562 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -301,6 +301,8 @@ struct mt7615_dev {
 	struct {
 		struct work_struct wake_work;
 		struct completion wake_cmpl;
+
+		unsigned long last_activity;
 	} pm;
 };
 
@@ -487,6 +489,20 @@ static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
 		return MT7615_WTBL_SIZE;
 }
 
+static inline void mt7615_mutex_acquire(struct mt7615_dev *dev)
+	 __acquires(&dev->mt76.mutex)
+{
+	mutex_lock(&dev->mt76.mutex);
+	mt7615_pm_wake(dev);
+}
+
+static inline void mt7615_mutex_release(struct mt7615_dev *dev)
+	__releases(&dev->mt76.mutex)
+{
+	dev->pm.last_activity = jiffies;
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
 {
 	static const u8 lmac_queue_map[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index f70a7d9d65e2..a780127377bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -201,12 +201,13 @@ void mt7663u_wtbl_work(struct work_struct *work)
 	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
 						wtbl_work);
 
+	mt7615_mutex_acquire(dev);
+
 	list_for_each_entry_safe(wd, wd_next, &dev->wd_head, node) {
 		spin_lock_bh(&dev->mt76.lock);
 		list_del(&wd->node);
 		spin_unlock_bh(&dev->mt76.lock);
 
-		mutex_lock(&dev->mt76.mutex);
 		switch (wd->type) {
 		case MT7615_WTBL_RATE_DESC:
 			__mt7663u_mac_set_rates(dev, wd);
@@ -215,10 +216,10 @@ void mt7663u_wtbl_work(struct work_struct *work)
 			__mt7663u_mac_set_key(dev, wd);
 			break;
 		}
-		mutex_unlock(&dev->mt76.mutex);
-
 		kfree(wd);
 	}
+
+	mt7615_mutex_release(dev);
 }
 
 static void
@@ -257,9 +258,9 @@ static bool mt7663u_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7615_mutex_acquire(dev);
 	mt7615_mac_sta_poll(dev);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7615_mutex_release(dev);
 
 	return 0;
 }
-- 
2.26.2

