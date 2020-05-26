Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CC1A6824
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgDMO26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 10:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgDMO25 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 10:28:57 -0400
Received: from localhost.localdomain (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D622073E;
        Mon, 13 Apr 2020 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586788136;
        bh=hx7ToLSFqR6GefSKsnFMFt2U8Yu7gx4GWGNa/30QAqk=;
        h=From:To:Cc:Subject:Date:From;
        b=wyCkllMrCcKGsb8C4akbG68h6DIvg4pti1NnGQRRVpo+/z77Ip7/e6QBHGGfWnt6j
         km4/ALzUguaLGMZT7pxhDbQLQiGJ7ufuqwC/zpwPZ4GeUeISYgAovh/79iagfQ8U7O
         aNkJOR3Jvum+d9XE47mAtCT+2L90deJZCusnfUh8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix possible deadlock in mt7615_stop
Date:   Mon, 13 Apr 2020 16:28:48 +0200
Message-Id: <08b91b37146a540fb1f0a7bdcb11bbff3073e081.1586787993.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

make mac_work per phy instead of per device and fix a possible deadlock
in mt7615_stop since mt7615_mac_work runs holding mt76 mutex

Fixes: fdd2e570764c2 ("mt76: mt7615: add dual-phy support for mac80211 ops")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 58 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 19 +++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +-
 4 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index cb626a2d9197..f06de74d009d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -429,6 +429,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	if (phy)
 		return 0;
 
+	INIT_DELAYED_WORK(&phy->mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
 	skb_queue_head_init(&phy->scan_event_list);
 
@@ -487,7 +488,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c38bc395c5a3..5614cd691885 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1815,31 +1815,27 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 
 void mt7615_mac_work(struct work_struct *work)
 {
-	struct mt7615_dev *dev;
-	struct mt7615_phy *ext_phy;
+	struct mt7615_phy *phy;
+	struct mt76_dev *mdev;
 
-	dev = (struct mt7615_dev *)container_of(work, struct mt76_dev,
+	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
 						mac_work.work);
+	mdev = &phy->dev->mt76;
 
-	mutex_lock(&dev->mt76.mutex);
-	mt76_update_survey(&dev->mt76);
-	if (++dev->mac_work_count == 5) {
-		ext_phy = mt7615_ext_phy(dev);
-
-		mt7615_mac_update_mib_stats(&dev->phy);
-		mt7615_mac_scs_check(&dev->phy);
-		if (ext_phy) {
-			mt7615_mac_update_mib_stats(ext_phy);
-			mt7615_mac_scs_check(ext_phy);
-		}
+	mutex_lock(&mdev->mutex);
 
-		dev->mac_work_count = 0;
+	mt76_update_survey(mdev);
+	if (++phy->mac_work_count == 5) {
+		phy->mac_work_count = 0;
+
+		mt7615_mac_update_mib_stats(phy);
+		mt7615_mac_scs_check(phy);
 	}
 
-	mutex_unlock(&dev->mt76.mutex);
+	mutex_unlock(&mdev->mutex);
 
-	mt76_tx_status_check(&dev->mt76, NULL, false);
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	mt76_tx_status_check(mdev, NULL, false);
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
 				     MT7615_WATCHDOG_TIME);
 }
 
@@ -1902,26 +1898,32 @@ mt7615_dma_reset(struct mt7615_dev *dev)
 
 void mt7615_mac_reset_work(struct work_struct *work)
 {
+	struct mt7615_phy *phy2;
+	struct mt76_phy *ext_phy;
 	struct mt7615_dev *dev;
 
 	dev = container_of(work, struct mt7615_dev, reset_work);
+	ext_phy = dev->mt76.phy2;
+	phy2 = ext_phy ? ext_phy->priv : NULL;
 
 	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_PDMA))
 		return;
 
 	ieee80211_stop_queues(mt76_hw(dev));
-	if (dev->mt76.phy2)
-		ieee80211_stop_queues(dev->mt76.phy2->hw);
+	if (ext_phy)
+		ieee80211_stop_queues(ext_phy->hw);
 
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->phy.mac_work);
+	if (phy2)
+		cancel_delayed_work_sync(&phy2->mac_work);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
-	if (dev->mt76.phy2)
-		mt76_txq_schedule_all(dev->mt76.phy2);
+	if (ext_phy)
+		mt76_txq_schedule_all(ext_phy);
 
 	tasklet_disable(&dev->mt76.tx_tasklet);
 	napi_disable(&dev->mt76.napi[0]);
@@ -1955,8 +1957,8 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	napi_schedule(&dev->mt76.napi[1]);
 
 	ieee80211_wake_queues(mt76_hw(dev));
-	if (dev->mt76.phy2)
-		ieee80211_wake_queues(dev->mt76.phy2->hw);
+	if (ext_phy)
+		ieee80211_wake_queues(ext_phy->hw);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
@@ -1965,8 +1967,12 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_update_beacons(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
 				     MT7615_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+					     MT7615_WATCHDOG_TIME);
+
 }
 
 static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b346080458bc..33f67c7ccbf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -55,15 +55,12 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	if (running)
-		goto out;
-
-	mt7615_mac_reset_counters(dev);
-
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mac_work,
 				     MT7615_WATCHDOG_TIME);
 
-out:
+	if (!running)
+		mt7615_mac_reset_counters(dev);
+
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -74,6 +71,8 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
+	cancel_delayed_work_sync(&phy->mac_work);
+
 	mutex_lock(&dev->mt76.mutex);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -85,8 +84,6 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	}
 
 	if (!mt7615_dev_running(dev)) {
-		cancel_delayed_work_sync(&dev->mt76.mac_work);
-
 		mt7615_mcu_set_pm(dev, 0, 1);
 		mt7615_mcu_set_mac_enable(dev, 0, false);
 	}
@@ -245,7 +242,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int ret;
 
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&phy->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
@@ -276,7 +273,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_txq_schedule_all(phy->mt76);
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
 				     MT7615_WATCHDOG_TIME);
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 10a98d38f77e..57c9c1ef8ffc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -192,6 +192,9 @@ struct mt7615_phy {
 
 	struct mib_stats mib;
 
+	struct delayed_work mac_work;
+	u8 mac_work_count;
+
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 };
@@ -259,7 +262,6 @@ struct mt7615_dev {
 	} radar_pattern;
 	u32 hw_pattern;
 
-	u8 mac_work_count;
 	bool fw_debug;
 	bool flash_eeprom;
 
-- 
2.25.2

