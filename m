Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E801D9248
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgESImX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 04:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgESImX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 04:42:23 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97E6204EA;
        Tue, 19 May 2020 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589877742;
        bh=FHBwROHUsAGlm35+Qn7zvTjZnGTqaUoaPIIdiDpotv0=;
        h=From:To:Cc:Subject:Date:From;
        b=bhCdfKiZZMTHf5i60e5fR+/cc2mkWA7TUuqzZ0yU+fdnEyd3nksYxKopRZLa9o2ae
         DcsAvv9KuMPtV/XJzyi4iPz095UxEs6G8bjZyuxVusfyobz7dBYjb+b5v/NXrAGcNu
         gup8BPB+gmbwrrgTy9VTRe7Ff30jQbhrlh4avteA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: switch to per-vif power_save support
Date:   Tue, 19 May 2020 10:42:11 +0200
Message-Id: <3f46507dbb7ada2f4b1e1b90519a8b5f2d5b9cf2.1589877653.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

switch to per-vif ps support since mt7615 offload firmware can handle it
properly. This patch allows enabling/disabling power-save support on p2p
interface

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 --
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 26 +++----------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 14 +++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 +---
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  1 -
 6 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e2926e091c0f..5c9195f59ae1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -288,7 +288,6 @@ enum {
 	MT76_REMOVED,
 	MT76_READING_STATS,
 	MT76_STATE_POWER_OFF,
-	MT76_STATE_PS,
 	MT76_STATE_SUSPEND,
 	MT76_STATE_ROC,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 0d105e4abdfd..e2d80518e5af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -388,7 +388,6 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
 	skb_queue_head_init(&phy->scan_event_list);
 
-	INIT_WORK(&phy->ps_work, mt7615_ps_work);
 	INIT_WORK(&phy->roc_work, mt7615_roc_work);
 	timer_setup(&phy->roc_timer, mt7615_roc_timer, 0);
 	init_waitqueue_head(&phy->roc_wait);
@@ -447,7 +446,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	init_waitqueue_head(&dev->phy.roc_wait);
 
 	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
-	INIT_WORK(&dev->phy.ps_work, mt7615_ps_work);
 	INIT_WORK(&dev->phy.roc_work, mt7615_roc_work);
 	timer_setup(&dev->phy.roc_timer, mt7615_roc_timer, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index f8cbee1770ce..320dfda6b4e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -71,7 +71,6 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mac_work);
-	cancel_work_sync(&phy->ps_work);
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
@@ -362,20 +361,6 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 }
 
-void mt7615_ps_work(struct work_struct *work)
-{
-	struct mt7615_phy *phy;
-
-	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
-						ps_work);
-
-	mutex_lock(&phy->dev->mt76.mutex);
-	ieee80211_iterate_active_interfaces(phy->mt76->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    m7615_mcu_set_ps_iter, phy);
-	mutex_unlock(&phy->dev->mt76.mutex);
-}
-
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -401,14 +386,6 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS)
-			set_bit(MT76_STATE_PS, &phy->mt76->state);
-		else
-			clear_bit(MT76_STATE_PS, &phy->mt76->state);
-		ieee80211_queue_work(hw, &phy->ps_work);
-	}
-
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
@@ -511,6 +488,9 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		       BSS_CHANGED_BEACON_ENABLED))
 		mt7615_mcu_add_beacon(dev, hw, vif, info->enable_beacon);
 
+	if (changed & BSS_CHANGED_PS)
+		mt7615_mcu_set_vif_ps(dev, vif);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7eb99bde3394..14c2b5d7dbbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2772,11 +2772,9 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 				   sizeof(req), true);
 }
 
-void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_phy *phy = priv;
-	struct mt76_phy *mphy = phy->mt76;
 	struct {
 		u8 bss_idx;
 		u8 ps_state; /* 0: device awake
@@ -2785,12 +2783,14 @@ void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 			      */
 	} req = {
 		.bss_idx = mvif->idx,
-		.ps_state = test_bit(MT76_STATE_PS, &mphy->state) ? 2 : 0,
+		.ps_state = vif->bss_conf.ps ? 2 : 0,
 	};
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		__mt76_mcu_send_msg(&phy->dev->mt76,  MCU_CMD_SET_PS_PROFILE,
-				    &req, sizeof(req), false);
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -ENOTSUPP;
+
+	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_SET_PS_PROFILE,
+				   &req, sizeof(req), false);
 }
 
 int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 71d5d5973116..170d3c2bbbb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -205,8 +205,6 @@ struct mt7615_phy {
 	struct timer_list roc_timer;
 	wait_queue_head_t roc_wait;
 	bool roc_grant;
-
-	struct work_struct ps_work;
 };
 
 #define mt7615_mcu_add_tx_ba(dev, ...)	(dev)->mcu_ops->add_tx_ba((dev), __VA_ARGS__)
@@ -448,7 +446,6 @@ void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_roc_work(struct work_struct *work);
 void mt7615_roc_timer(struct timer_list *timer);
-void mt7615_ps_work(struct work_struct *work);
 void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband);
 void mt7615_phy_init(struct mt7615_dev *dev);
@@ -534,7 +531,7 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
-void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
+int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index c292b41c76e3..a50077eb24d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -51,7 +51,6 @@ static void mt7663u_stop(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	cancel_work_sync(&phy->ps_work);
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
-- 
2.26.2

