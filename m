Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A327E466
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgI3I5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 04:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgI3I5a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 04:57:30 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D358020659;
        Wed, 30 Sep 2020 08:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601456248;
        bh=lXWtHfHJX+9EiJktlM1ZgBDQsgqVP/SFhjZ+EGKnTEw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ot0+qxy2JO4n7PPpC/9FgUAztJ31pWNZxb6edY5Nq5k3Es5n3vu3tH6c3BneaLgWE
         O8g9PgvIyaLIkIcRg447Rgel7pH8gtw8Hxaaa1f3VwSIL5yNApe5ykNopZ4Xnri7Xn
         eAKlA/MLAwFgo2ZkbAtl4wUezI3P89ac9KfimyYY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2] mt76: mt7615: enable beacon filtering by default for offload fw
Date:   Wed, 30 Sep 2020 10:57:15 +0200
Message-Id: <b67707fd5dd487d91918acd15051f4a9c8ec6497.1601454375.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reduce cpu cycles, enable hw beacon filter by default if
the device is running offload fw with sta only interfaces.
Disable runtime pm for multi-vif scenario.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- disable hw beacon filtering for multi-vif scenario.
- disable runtime pm for multi-vif scenario.
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 17 +++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 86 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 28 ++----
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  7 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 +-
 5 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index efdc61c812ca..8272a980af8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -55,11 +55,26 @@ static int
 mt7615_pm_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
+	int ret = 0;
 
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	return mt7615_pm_set_enable(dev, val);
+	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mt7615_mutex_acquire(dev);
+
+	if (dev->phy.n_beacon_vif) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	dev->pm.enable = val;
+out:
+	mt7615_mutex_release(dev);
+
+	return ret;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8dc645e398fd..abb86a13f241 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1969,49 +1969,6 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
 }
 
-static void
-mt7615_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct mt7615_phy *phy = priv;
-	struct mt7615_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
-
-	if (mt7615_mcu_set_bss_pm(dev, vif, dev->pm.enable))
-		return;
-
-	if (dev->pm.enable) {
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		mt76_set(dev, MT_WF_RFCR(ext_phy),
-			 MT_WF_RFCR_DROP_OTHER_BEACON);
-	} else {
-		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
-		mt76_clear(dev, MT_WF_RFCR(ext_phy),
-			   MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
-}
-
-int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
-{
-	struct mt76_phy *mphy = dev->phy.mt76;
-
-	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
-		return -EOPNOTSUPP;
-
-	mt7615_mutex_acquire(dev);
-
-	if (dev->pm.enable == enable)
-		goto out;
-
-	dev->pm.enable = enable;
-	ieee80211_iterate_active_interfaces(mphy->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7615_pm_interface_iter, mphy->priv);
-out:
-	mt7615_mutex_release(dev);
-
-	return 0;
-}
-
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
@@ -2314,3 +2271,46 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	mt7615_dfs_stop_radar_detector(phy);
 	return 0;
 }
+
+int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	int err;
+
+	if (!mt7615_firmware_offload(dev))
+		return -EOPNOTSUPP;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
+		return 0;
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		if (enable)
+			phy->n_beacon_vif++;
+		else
+			phy->n_beacon_vif--;
+		fallthrough;
+	default:
+		break;
+	}
+
+	err = mt7615_mcu_set_bss_pm(dev, vif, !phy->n_beacon_vif);
+	if (err)
+		return err;
+
+	if (phy->n_beacon_vif) {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3186b7b2ca48..8b4746691954 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -211,15 +211,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	if (dev->pm.enable) {
-		ret = mt7615_mcu_set_bss_pm(dev, vif, true);
-		if (ret)
-			goto out;
-
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		mt76_set(dev, MT_WF_RFCR(ext_phy),
-			 MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
+	mt7615_mac_set_beacon_filter(phy, vif, true);
 out:
 	mt7615_mutex_release(dev);
 
@@ -245,13 +237,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_free_pending_tx_skbs(dev, msta);
 
-	if (dev->pm.enable) {
-		bool ext_phy = phy != &dev->phy;
-
-		mt7615_mcu_set_bss_pm(dev, vif, false);
-		mt76_clear(dev, MT_WF_RFCR(ext_phy),
-			   MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
+	mt7615_mac_set_beacon_filter(phy, vif, false);
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
@@ -511,7 +497,6 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 	} while (0)
 
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-			   MT_WF_RFCR_DROP_OTHER_BEACON |
 			   MT_WF_RFCR_DROP_FRAME_REPORT |
 			   MT_WF_RFCR_DROP_PROBEREQ |
 			   MT_WF_RFCR_DROP_MCAST_FILTERED |
@@ -522,6 +507,9 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 			   MT_WF_RFCR_DROP_UNWANTED_CTL |
 			   MT_WF_RFCR_DROP_STBC_MULTI);
 
+	if (phy->n_beacon_vif || !mt7615_firmware_offload(dev))
+		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_BEACON;
+
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
 			       MT_WF_RFCR_DROP_A3_BSSID);
@@ -1127,7 +1115,6 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	bool ext_phy = phy != &dev->phy;
 	int err = 0;
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
@@ -1139,8 +1126,6 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mac_work);
 
-	mt76_set(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
-
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -1158,7 +1143,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	bool running, ext_phy = phy != &dev->phy;
+	bool running;
 
 	mt7615_mutex_acquire(dev);
 
@@ -1182,7 +1167,6 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 
 	ieee80211_queue_delayed_work(hw, &phy->mac_work,
 				     MT7615_WATCHDOG_TIME);
-	mt76_clear(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 31b40fb83f6c..ffd537f49dcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -3528,9 +3528,8 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	};
 	int err;
 
-	if (vif->type != NL80211_IFTYPE_STATION ||
-	    !mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return 0;
 
 	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
 				  &req_hdr, sizeof(req_hdr), false);
@@ -3744,8 +3743,6 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
 	int i;
 
-	mt7615_mcu_set_bss_pm(phy->dev, vif, suspend);
-
 	mt7615_mcu_set_gtk_rekey(phy->dev, vif, suspend);
 	mt7615_mcu_set_arp_filter(phy->dev, vif, suspend);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 43d8256af66a..51f6f8d9733e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -175,6 +175,8 @@ struct mt7615_phy {
 
 	struct ieee80211_vif *monitor_vif;
 
+	u8 n_beacon_vif;
+
 	u32 rxfilter;
 	u32 omac_mask;
 
@@ -454,7 +456,6 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
-int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable);
 void mt7615_pm_wake_work(struct work_struct *work);
 int mt7615_pm_wake(struct mt7615_dev *dev);
 void mt7615_pm_power_save_sched(struct mt7615_dev *dev);
@@ -653,6 +654,9 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
+int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable);
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
-- 
2.26.2

