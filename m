Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD15193FAD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCZN0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:26:40 -0400
Received: from nbd.name ([46.4.11.11]:54280 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCZN0k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QMGx1KQHxqayubXxQlaNjOx3dOu8nSD0WrAUkCgqxBo=; b=QqEhLpiGslXvK2xVTHP6z5wQxZ
        AYFKAY0o9VIjvo7ckGd+pr7WhzdnfL3GKiMpUHp4DIpceLjtMPfxHcm5psKoQ1f1FhQjGwcg+TvT+
        oLn40UNJ0mydvo6hW4MSCHQWFtyoZiFWaP16MW/U00HB4961JuR742MdEYNX23P+d+Gc=;
Received: from p54ae9d8f.dip0.t-ipconnect.de ([84.174.157.143] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jHSWs-0001uS-Gj
        for linux-wireless@vger.kernel.org; Thu, 26 Mar 2020 14:26:38 +0100
Received: by maeck.lan (Postfix, from userid 501)
        id E9BF980DFACB; Thu, 26 Mar 2020 14:26:37 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x02: fix handling MCU timeouts during hw restart
Date:   Thu, 26 Mar 2020 14:26:37 +0100
Message-Id: <20200326132637.31223-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If a MCU timeout occurs before a hw restart completes, another hw restart
is scheduled, and the station state gets corrupted.
To speed up dealing with that, do not issue any MCU commands after the first
timeout, and defer handling timeouts until the reset has completed.
Also ignore errors in MCU commands during start/config to avoid making user
space fail on this condition. If it happens, another restart is scheduled
quickly, and that usually recovers the hardware properly.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 ++
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  3 +++
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 16 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  1 +
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 19 ++++++-------------
 7 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8e4759bc8f59..6d60187e88ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -275,6 +275,7 @@ enum {
 	MT76_STATE_RUNNING,
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
+	MT76_RESTART,
 	MT76_RESET,
 	MT76_MCU_RESET,
 	MT76_REMOVED,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 0b520ae08d01..57091d41eb85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -29,6 +29,7 @@ static void mt76x0e_stop_hw(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	clear_bit(MT76_RESTART, &dev->mphy.state);
 
 	if (!mt76_poll(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_TX_DMA_BUSY,
 		       0, 1000))
@@ -83,6 +84,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.set_coverage_class = mt76x02_set_coverage_class,
 	.set_rts_threshold = mt76x02_set_rts_threshold,
 	.get_antenna = mt76_get_antenna,
+	.reconfig_complete = mt76x02_reconfig_complete,
 };
 
 static int mt76x0e_register_device(struct mt76x02_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 23040c193ca5..94dd142cb3d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -187,6 +187,8 @@ void mt76x02_sta_ps(struct mt76_dev *dev, struct ieee80211_sta *sta, bool ps);
 void mt76x02_bss_info_changed(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *info, u32 changed);
+void mt76x02_reconfig_complete(struct ieee80211_hw *hw,
+			       enum ieee80211_reconfig_type reconfig_type);
 
 struct beacon_bc_data {
 	struct mt76x02_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 5664749ad6c1..8247611d9b18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -20,6 +20,9 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	int ret;
 	u8 seq;
 
+	if (mt76_is_mmio(&dev->mt76) && dev->mcu_timeout)
+		return -EIO;
+
 	skb = mt76x02_mcu_msg_alloc(data, len);
 	if (!skb)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7dcc5d342e9f..7e389dbccfeb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -520,6 +520,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	}
 
 	if (restart) {
+		set_bit(MT76_RESTART, &dev->mphy.state);
 		mt76x02_mcu_function_select(dev, Q_SELECT, 1);
 		ieee80211_restart_hw(dev->mt76.hw);
 	} else {
@@ -528,8 +529,23 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	}
 }
 
+void mt76x02_reconfig_complete(struct ieee80211_hw *hw,
+			       enum ieee80211_reconfig_type reconfig_type)
+{
+	struct mt76x02_dev *dev = hw->priv;
+
+	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
+		return;
+
+	clear_bit(MT76_RESTART, &dev->mphy.state);
+}
+EXPORT_SYMBOL_GPL(mt76x02_reconfig_complete);
+
 static void mt76x02_check_tx_hang(struct mt76x02_dev *dev)
 {
+	if (test_bit(MT76_RESTART, &dev->mphy.state))
+		return;
+
 	if (mt76x02_tx_hang(dev)) {
 		if (++dev->tx_hang_check >= MT_TX_HANG_TH)
 			goto restart;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index c69579e5f647..f27774f57438 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -256,6 +256,7 @@ void mt76x2_stop_hardware(struct mt76x02_dev *dev)
 	cancel_delayed_work_sync(&dev->cal_work);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 	cancel_delayed_work_sync(&dev->wdt_work);
+	clear_bit(MT76_RESTART, &dev->mphy.state);
 	mt76x02_mcu_set_radio_state(dev, false);
 	mt76x2_mac_stop(dev, false);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 105e5b99b3f9..a74599f7f729 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -10,12 +10,9 @@ static int
 mt76x2_start(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
-	int ret;
 
 	mt76x02_mac_start(dev);
-	ret = mt76x2_phy_start(dev);
-	if (ret)
-		return ret;
+	mt76x2_phy_start(dev);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT_MAC_WORK_INTERVAL);
@@ -35,11 +32,9 @@ mt76x2_stop(struct ieee80211_hw *hw)
 	mt76x2_stop_hardware(dev);
 }
 
-static int
+static void
 mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 {
-	int ret;
-
 	cancel_delayed_work_sync(&dev->cal_work);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
@@ -50,7 +45,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76_set_channel(&dev->mphy);
 
 	mt76x2_mac_stop(dev, true);
-	ret = mt76x2_phy_set_channel(dev, chandef);
+	mt76x2_phy_set_channel(dev, chandef);
 
 	mt76x02_mac_cc_reset(dev);
 	mt76x02_dfs_init_params(dev);
@@ -64,15 +59,12 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	mt76_txq_schedule_all(&dev->mphy);
-
-	return ret;
 }
 
 static int
 mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
-	int ret = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -101,11 +93,11 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
-		ret = mt76x2_set_channel(dev, &hw->conf.chandef);
+		mt76x2_set_channel(dev, &hw->conf.chandef);
 		ieee80211_wake_queues(hw);
 	}
 
-	return ret;
+	return 0;
 }
 
 static void
@@ -162,5 +154,6 @@ const struct ieee80211_ops mt76x2_ops = {
 	.set_antenna = mt76x2_set_antenna,
 	.get_antenna = mt76_get_antenna,
 	.set_rts_threshold = mt76x02_set_rts_threshold,
+	.reconfig_complete = mt76x02_reconfig_complete,
 };
 
-- 
2.24.0

