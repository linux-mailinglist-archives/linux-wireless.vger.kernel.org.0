Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA72E9C7B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbhADSB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:01:29 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33089 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727217AbhADSB3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:01:29 -0500
X-UUID: 0d71e06db3cb4c6ebd07d86916d33315-20210105
X-UUID: 0d71e06db3cb4c6ebd07d86916d33315-20210105
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1472997892; Tue, 05 Jan 2021 02:00:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:20 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 01/15] mt76: move mac_work in mt76_core module
Date:   Tue, 5 Jan 2021 02:00:05 +0800
Message-ID: <acd4cd730dec4a6f6a4413bce54ad224ab5b7040.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move mac_work delayed_work and mac_work_count in mt76_phy since it is
used by all drivers. This is a preliminary patch to create a common mcu
library used by mt7615 and mt7921 drivers

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 14 ++++-----
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 10 +++----
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 --
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 25 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 13 +++++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 --
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  9 +++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 --
 22 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 10034c21f812..52228936f792 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -583,6 +583,9 @@ struct mt76_phy {
 #ifdef CONFIG_NL80211_TESTMODE
 	struct mt76_testmode_data test;
 #endif
+
+	struct delayed_work mac_work;
+	u8 mac_work_count;
 };
 
 struct mt76_dev {
@@ -623,7 +626,6 @@ struct mt76_dev {
 
 	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
-	struct delayed_work mac_work;
 
 	wait_queue_head_t tx_wait;
 	struct sk_buff_head status_list;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index b14e08046e20..f0b879c3eba8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -532,7 +532,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	spin_lock_init(&dev->sta_poll_lock);
 	spin_lock_init(&dev->ps_lock);
 
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7603_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7603_mac_work);
 	tasklet_setup(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet);
 
 	dev->slottime = 9;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 55095e66f2ef..7f0e3df3a094 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1788,7 +1788,7 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 void mt7603_mac_work(struct work_struct *work)
 {
 	struct mt7603_dev *dev = container_of(work, struct mt7603_dev,
-					      mt76.mac_work.work);
+					      mphy.mac_work.work);
 	bool reset = false;
 	int i, idx;
 
@@ -1796,7 +1796,7 @@ void mt7603_mac_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	dev->mac_work_count++;
+	dev->mphy.mac_work_count++;
 	mt76_update_survey(&dev->mt76);
 	mt7603_edcca_check(dev);
 
@@ -1807,7 +1807,7 @@ void mt7603_mac_work(struct work_struct *work)
 		dev->mt76.aggr_stats[idx++] += val >> 16;
 	}
 
-	if (dev->mac_work_count == 10)
+	if (dev->mphy.mac_work_count == 10)
 		mt7603_false_cca_check(dev);
 
 	if (mt7603_watchdog_check(dev, &dev->rx_pse_check,
@@ -1838,17 +1838,17 @@ void mt7603_mac_work(struct work_struct *work)
 		dev->rx_dma_idx = ~0;
 		memset(dev->tx_dma_idx, 0xff, sizeof(dev->tx_dma_idx));
 		reset = true;
-		dev->mac_work_count = 0;
+		dev->mphy.mac_work_count = 0;
 	}
 
-	if (dev->mac_work_count >= 10)
-		dev->mac_work_count = 0;
+	if (dev->mphy.mac_work_count >= 10)
+		dev->mphy.mac_work_count = 0;
 
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (reset)
 		mt7603_mac_watchdog_reset(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 6d47b57cbc39..d7e4bb29f5bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -17,7 +17,7 @@ mt7603_start(struct ieee80211_hw *hw)
 	mt7603_mac_start(dev);
 	dev->mphy.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	mt7603_mac_work(&dev->mt76.mac_work.work);
+	mt7603_mac_work(&dev->mphy.mac_work.work);
 
 	return 0;
 }
@@ -28,7 +28,7 @@ mt7603_stop(struct ieee80211_hw *hw)
 	struct mt7603_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt7603_mac_stop(dev);
 }
 
@@ -137,7 +137,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	u8 bw = MT_BW_20;
 	bool failed = false;
 
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -178,7 +178,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 
 	mt76_txq_schedule_all(&dev->mphy);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 
 	/* reset channel stats */
@@ -200,7 +200,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	if (failed)
-		mt7603_mac_work(&dev->mt76.mac_work.work);
+		mt7603_mac_work(&dev->mphy.mac_work.work);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 6e0a92a28b1c..b787c56fd8d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -132,8 +132,6 @@ struct mt7603_dev {
 
 	spinlock_t ps_lock;
 
-	u8 mac_work_count;
-
 	u8 mcu_running;
 
 	u8 ed_monitor_enabled;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a73b76e57c7f..d89b607cce68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -408,7 +408,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7615_init_wiphy(mphy->hw);
 
-	INIT_DELAYED_WORK(&phy->mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
 	skb_queue_head_init(&phy->scan_event_list);
 
@@ -471,7 +471,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
-	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5d2a14cf5d40..2cc329019edc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1976,17 +1976,17 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
-	struct mt76_dev *mdev;
+	struct mt76_phy *mphy;
 
-	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
-						mac_work.work);
-	mdev = &phy->dev->mt76;
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
 
 	mt7615_mutex_acquire(phy->dev);
 
 	mt7615_update_survey(phy->dev);
-	if (++phy->mac_work_count == 5) {
-		phy->mac_work_count = 0;
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
 
 		mt7615_mac_update_mib_stats(phy);
 		mt7615_mac_scs_check(phy);
@@ -1994,8 +1994,8 @@ void mt7615_mac_work(struct work_struct *work)
 
 	mt7615_mutex_release(phy->dev);
 
-	mt76_tx_status_check(mdev, NULL, false);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+	mt76_tx_status_check(mphy->dev, NULL, false);
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7615_WATCHDOG_TIME);
 }
 
@@ -2104,11 +2104,11 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->phy.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	del_timer_sync(&dev->phy.roc_timer);
 	cancel_work_sync(&dev->phy.roc_work);
 	if (phy2) {
-		cancel_delayed_work_sync(&phy2->mac_work);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 		del_timer_sync(&phy2->roc_timer);
 		cancel_work_sync(&phy2->roc_work);
 	}
@@ -2163,10 +2163,11 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_mutex_release(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	if (phy2)
-		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &phy2->mt76->mac_work,
 					     MT7615_WATCHDOG_TIME);
 
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3fc48aaa3b36..a7155509f95a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -70,7 +70,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7615_WATCHDOG_TIME);
 
 	if (!running)
@@ -86,7 +86,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
@@ -300,7 +300,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mt7615_mutex_acquire(dev);
 
@@ -335,7 +335,8 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	mt76_txq_schedule_all(phy->mt76);
 
 	if (!mt76_testmode_enabled(phy->mt76))
-		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+		ieee80211_queue_delayed_work(phy->mt76->hw,
+					     &phy->mt76->mac_work,
 					     MT7615_WATCHDOG_TIME);
 
 	return ret;
@@ -1112,7 +1113,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
@@ -1153,7 +1154,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7615_mcu_set_suspend_iter, phy);
 
-	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7615_WATCHDOG_TIME);
 
 	mt7615_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 979c5c7fe93c..99365807142e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -185,9 +185,6 @@ struct mt7615_phy {
 
 	struct mib_stats mib;
 
-	struct delayed_work mac_work;
-	u8 mac_work_count;
-
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index a60cfa345521..dbf59f1ccda2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -29,7 +29,7 @@ static void mt7663u_stop(struct ieee80211_hw *hw)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 	mt76u_stop_tx(&dev->mt76);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index b87d8e136cb9..02d0aa0b815e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -16,7 +16,7 @@ static int mt76x0e_start(struct ieee80211_hw *hw)
 
 	mt76x02_mac_start(dev);
 	mt76x0_phy_calibrate(dev, true);
-	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
@@ -28,7 +28,7 @@ static int mt76x0e_start(struct ieee80211_hw *hw)
 static void mt76x0e_stop_hw(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	clear_bit(MT76_RESTART, &dev->mphy.state);
 
 	if (!mt76_poll(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_TX_DMA_BUSY,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index b12cb17cb43d..a593a7796d23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -82,7 +82,7 @@ static void mt76x0u_stop(struct ieee80211_hw *hw)
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt76u_stop_tx(&dev->mt76);
 	mt76x02u_exit_beacon_config(dev);
 
@@ -108,7 +108,7 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 		return ret;
 
 	mt76x0_phy_calibrate(dev, true);
-	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 16b40a73fd1f..e0c4e1981e5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1162,7 +1162,7 @@ static void mt76x02_edcca_check(struct mt76x02_dev *dev)
 void mt76x02_mac_work(struct work_struct *work)
 {
 	struct mt76x02_dev *dev = container_of(work, struct mt76x02_dev,
-					       mt76.mac_work.work);
+					       mphy.mac_work.work);
 	int i, idx;
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1185,7 +1185,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 	mt76_tx_status_check(&dev->mt76, NULL, false);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 7ac20d3c16d7..db7bd35d425c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -149,7 +149,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
 
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt76x02_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt76x02_mac_work);
 
 	hw->queues = 4;
 	hw->max_rates = 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 620484390418..c6fa8cf92529 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -271,7 +271,7 @@ static int mt76x2_init_hardware(struct mt76x02_dev *dev)
 void mt76x2_stop_hardware(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&dev->wdt_work);
 	clear_bit(MT76_RESTART, &dev->mphy.state);
 	mt76x02_mcu_set_radio_state(dev, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 98f4cf398320..93fa3f644bb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -14,7 +14,7 @@ mt76x2_start(struct ieee80211_hw *hw)
 	mt76x02_mac_start(dev);
 	mt76x2_phy_start(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->wdt_work,
 				     MT_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index ffc2deba29ac..85dcdc22fbeb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -236,7 +236,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 void mt76x2u_stop_hw(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt76x2u_mac_stop(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index bab4e6e1904e..b66836928d9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -15,7 +15,7 @@ static int mt76x2u_start(struct ieee80211_hw *hw)
 	if (ret)
 		return ret;
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 255ccd7e3d27..6d1ea2998b52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -240,7 +240,7 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mt7915_init_wiphy(mphy->hw);
 
 	INIT_LIST_HEAD(&phy->stats_list);
-	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	mt7915_eeprom_parse_band_config(phy);
 	mt7915_set_stream_vht_txbf_caps(phy);
@@ -622,7 +622,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mt76.phy.priv = &dev->phy;
 	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
-	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7915_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index dc1f56fb823d..cdc4b3ed5259 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1544,9 +1544,9 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->phy.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	if (phy2)
-		cancel_delayed_work_sync(&phy2->mac_work);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
@@ -1600,10 +1600,11 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt7915_update_beacons(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT7915_WATCHDOG_TIME);
 	if (phy2)
-		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &phy2->mt76->mac_work,
 					     MT7915_WATCHDOG_TIME);
 }
 
@@ -1714,17 +1715,17 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 void mt7915_mac_work(struct work_struct *work)
 {
 	struct mt7915_phy *phy;
-	struct mt76_dev *mdev;
+	struct mt76_phy *mphy;
 
-	phy = (struct mt7915_phy *)container_of(work, struct mt7915_phy,
-						mac_work.work);
-	mdev = &phy->dev->mt76;
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
 
-	mutex_lock(&mdev->mutex);
+	mutex_lock(&mphy->dev->mutex);
 
-	mt76_update_survey(mdev);
-	if (++phy->mac_work_count == 5) {
-		phy->mac_work_count = 0;
+	mt76_update_survey(mphy->dev);
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
 
 		mt7915_mac_update_mib_stats(phy);
 	}
@@ -1734,9 +1735,9 @@ void mt7915_mac_work(struct work_struct *work)
 		mt7915_mac_sta_stats_work(phy);
 	};
 
-	mutex_unlock(&mdev->mutex);
+	mutex_unlock(&mphy->dev->mutex);
 
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7915_WATCHDOG_TIME);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3e0458fee937..60a0fc9ec3c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -50,7 +50,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (!mt76_testmode_enabled(phy->mt76))
-		ieee80211_queue_delayed_work(hw, &phy->mac_work,
+		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 					     MT7915_WATCHDOG_TIME);
 
 	if (!running)
@@ -66,7 +66,7 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -273,7 +273,7 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
@@ -299,7 +299,8 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	mt76_txq_schedule_all(phy->mt76);
 
 	if (!mt76_testmode_enabled(phy->mt76))
-		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+		ieee80211_queue_delayed_work(phy->mt76->hw,
+					     &phy->mt76->mac_work,
 					     MT7915_WATCHDOG_TIME);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index df7ac2cf052f..a3cdaecef4ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -140,8 +140,6 @@ struct mt7915_phy {
 	struct mib_stats mib;
 	struct list_head stats_list;
 
-	struct delayed_work mac_work;
-	u8 mac_work_count;
 	u8 sta_work_count;
 
 #ifdef CONFIG_NL80211_TESTMODE
-- 
2.25.1

