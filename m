Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D428279A58
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIZPW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZPW2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:22:28 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EED207D3;
        Sat, 26 Sep 2020 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601133748;
        bh=8XuBgMMonX/7r4EaCMY+H3hyyjoQe3gMoSZB+ddJLRU=;
        h=From:To:Cc:Subject:Date:From;
        b=nS3Rj0/lCya3dwnt1mES1hMQRi9jX8VF1miOfPAmZaZv0kTYgg5oFeu13LI87Ff1x
         boqcI8QxUsjaOSClRf5sBSaXnNCtZ3ZFffANL+k12RXGu1big9jnv/VaEmE3I04guN
         53K+AsL9cYPKUyYhqnxFD1bCQNv9650BU3Nk5O80=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: enable beacon filtering by default for offload fw
Date:   Sat, 26 Sep 2020 17:22:09 +0200
Message-Id: <bfe45686ca8d8b5db2b27e33859bea7450f7b920.1601133687.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reduce cpu cycles, enable hw beacon filter by default if the
device is running offload fw

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  9 +++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 43 -------------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 26 ++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 29 ++++++++++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +-
 5 files changed, 35 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 00ba550fc48f..2eaf6e4529a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -59,7 +59,14 @@ mt7615_pm_set(void *data, u64 val)
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	return mt7615_pm_set_enable(dev, val);
+	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
+		return -EOPNOTSUPP;
+
+	mt7615_mutex_acquire(dev);
+	dev->pm.enable = val;
+	mt7615_mutex_release(dev);
+
+	return 0;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8dc645e398fd..40a34a5126e4 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3186b7b2ca48..ab68997b7b43 100644
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
+	mt7615_mcu_set_bss_pm(phy, vif, true);
 out:
 	mt7615_mutex_release(dev);
 
@@ -245,13 +237,6 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_free_pending_tx_skbs(dev, msta);
 
-	if (dev->pm.enable) {
-		bool ext_phy = phy != &dev->phy;
-
-		mt7615_mcu_set_bss_pm(dev, vif, false);
-		mt76_clear(dev, MT_WF_RFCR(ext_phy),
-			   MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
@@ -511,7 +496,6 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 	} while (0)
 
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-			   MT_WF_RFCR_DROP_OTHER_BEACON |
 			   MT_WF_RFCR_DROP_FRAME_REPORT |
 			   MT_WF_RFCR_DROP_PROBEREQ |
 			   MT_WF_RFCR_DROP_MCAST_FILTERED |
@@ -521,6 +505,8 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 			   MT_WF_RFCR_DROP_A2_BSSID |
 			   MT_WF_RFCR_DROP_UNWANTED_CTL |
 			   MT_WF_RFCR_DROP_STBC_MULTI);
+	if (!mt7615_firmware_offload(dev))
+		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_BEACON;
 
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
@@ -1127,7 +1113,6 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	bool ext_phy = phy != &dev->phy;
 	int err = 0;
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
@@ -1139,8 +1124,6 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mac_work);
 
-	mt76_set(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
-
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -1158,7 +1141,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	bool running, ext_phy = phy != &dev->phy;
+	bool running;
 
 	mt7615_mutex_acquire(dev);
 
@@ -1182,7 +1165,6 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 
 	ieee80211_queue_delayed_work(hw, &phy->mac_work,
 				     MT7615_WATCHDOG_TIME);
-	mt76_clear(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8de9bba384f4..462299ca85c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -3499,7 +3499,7 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 	return ret;
 }
 
-int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+int mt7615_mcu_set_bss_pm(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			  bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
@@ -3525,19 +3525,36 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	} req_hdr = {
 		.bss_idx = mvif->idx,
 	};
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 	int err;
 
 	if (vif->type != NL80211_IFTYPE_STATION ||
 	    !mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
 				  &req_hdr, sizeof(req_hdr), false);
-	if (err < 0 || !enable)
+	if (err < 0)
 		return err;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED,
-				   &req, sizeof(req), false);
+	if (enable) {
+		err =  __mt76_mcu_send_msg(&dev->mt76,
+					   MCU_CMD_SET_BSS_CONNECTED,
+					   &req, sizeof(req), false);
+		if (err < 0)
+			return err;
+
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -3743,8 +3760,6 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
 	int i;
 
-	mt7615_mcu_set_bss_pm(phy->dev, vif, suspend);
-
 	mt7615_mcu_set_gtk_rekey(phy->dev, vif, suspend);
 	mt7615_mcu_set_arp_filter(phy->dev, vif, suspend);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 716956b58c13..84ae6ee0ef75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -452,7 +452,6 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
-int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable);
 void mt7615_pm_wake_work(struct work_struct *work);
 int mt7615_pm_wake(struct mt7615_dev *dev);
 void mt7615_pm_power_save_sched(struct mt7615_dev *dev);
@@ -651,7 +650,7 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
-int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+int mt7615_mcu_set_bss_pm(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			  bool enable);
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
-- 
2.26.2

