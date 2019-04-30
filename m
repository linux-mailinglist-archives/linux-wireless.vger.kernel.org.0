Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D0F99A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfD3NMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NMO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:12:14 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6E821670;
        Tue, 30 Apr 2019 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556629933;
        bh=+AmXrAwxoSSKKfpfwAKKvwboAuqwpouTM204gxiNcjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCuq5gXdUdSTaLINLEFxaXLsNJMO4APy9VWMsuWw4OiI1Kr2yZBs5I7FDCHOeVU7+
         iV44S+xAabAWImOR7S8az3K+ey13kMLOM/S7sG7kVJo/jHXS+w+OA9fgO3DFzfSJZy
         rJyvHH0HHwdT3IGdlcV4GmvX+9f/Ovn8MNKUWMno=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v3 1/3] mt76: move pre_tbtt_tasklet in mt76_dev
Date:   Tue, 30 Apr 2019 15:12:01 +0200
Message-Id: <3222128e8996718883f7d10f7acd62f9e9e6972c.1556629547.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556629547.git.lorenzo@kernel.org>
References: <cover.1556629547.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move pre_tbtt_tasklet tasklet in mt76_dev data structure since
it is used by all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/core.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h   |  2 --
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         |  1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |  4 ++--
 12 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f1f56d24e8fc..8ecbf81a906f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -469,6 +469,7 @@ struct mt76_dev {
 	u8 antenna_mask;
 	u16 chainmask;
 
+	struct tasklet_struct pre_tbtt_tasklet;
 	int beacon_int;
 	u8 beacon_mask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 0d06ff67ce44..37e5644b45ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -27,7 +27,7 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 
 		mt76_wr(dev, MT_HW_INT_STATUS(3), hwintr);
 		if (hwintr & MT_HW_INT3_PRE_TBTT0)
-			tasklet_schedule(&dev->pre_tbtt_tasklet);
+			tasklet_schedule(&dev->mt76.pre_tbtt_tasklet);
 
 		if ((hwintr & MT_HW_INT3_TBTT0) && dev->mt76.csa_complete)
 			mt76_csa_finish(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 46ac23e2d0b7..78cdbb70e178 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -515,7 +515,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	spin_lock_init(&dev->ps_lock);
 
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7603_mac_work);
-	tasklet_init(&dev->pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
+	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
 	/* Check for 7688, which only has 1SS */
@@ -574,7 +574,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 void mt7603_unregister_device(struct mt7603_dev *dev)
 {
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76_unregister_device(&dev->mt76);
 	mt7603_mcu_exit(dev);
 	mt7603_dma_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 02e18b976de5..6d506e34c3ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1279,7 +1279,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mt76_txq_schedule_all(&dev->mt76);
 
 	tasklet_disable(&dev->mt76.tx_tasklet);
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
 
@@ -1328,7 +1328,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	tasklet_enable(&dev->mt76.tx_tasklet);
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
-	tasklet_enable(&dev->pre_tbtt_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	mt7603_beacon_set_timer(dev, -1, beacon_int);
 
 	napi_enable(&dev->mt76.napi[0]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 9be9ae02103e..be5d43050100 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -294,9 +294,9 @@ mt7603_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (changed & (BSS_CHANGED_BEACON_ENABLED | BSS_CHANGED_BEACON_INT)) {
 		int beacon_int = !!info->enable_beacon * info->beacon_int;
 
-		tasklet_disable(&dev->pre_tbtt_tasklet);
+		tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 		mt7603_beacon_set_timer(dev, mvif->idx, beacon_int);
-		tasklet_enable(&dev->pre_tbtt_tasklet);
+		tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index cc20a0cbed8d..fa64bbaab0d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -140,8 +140,6 @@ struct mt7603_dev {
 	u32 reset_test;
 
 	unsigned int reset_cause[__RESET_CAUSE_MAX];
-
-	struct tasklet_struct pre_tbtt_tasklet;
 };
 
 extern const struct mt76_driver_ops mt7603_drv_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 0eeccc3b529d..4585e1b756c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -213,7 +213,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void mt76x0e_cleanup(struct mt76x02_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76x0e_stop_hw(dev);
 	mt76x02_dma_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index a679914e4551..687bd14b2d77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -91,7 +91,6 @@ struct mt76x02_dev {
 	struct sk_buff *rx_head;
 
 	struct napi_struct tx_napi;
-	struct tasklet_struct pre_tbtt_tasklet;
 	struct delayed_work cal_work;
 	struct delayed_work wdt_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4e0f8aed4603..8f899b8aa9fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -68,9 +68,9 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 static void mt76x02e_pre_tbtt_enable(struct mt76x02_dev *dev, bool en)
 {
 	if (en)
-		tasklet_enable(&dev->pre_tbtt_tasklet);
+		tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	else
-		tasklet_disable(&dev->pre_tbtt_tasklet);
+		tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 }
 
 static void mt76x02e_beacon_enable(struct mt76x02_dev *dev, bool en)
@@ -198,7 +198,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 
 	tasklet_init(&dev->mt76.tx_tasklet, mt76x02_tx_tasklet,
 		     (unsigned long) dev);
-	tasklet_init(&dev->pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
+	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
 	spin_lock_init(&dev->txstatus_fifo_lock);
@@ -285,7 +285,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 	}
 
 	if (intr & MT_INT_PRE_TBTT)
-		tasklet_schedule(&dev->pre_tbtt_tasklet);
+		tasklet_schedule(&dev->mt76.pre_tbtt_tasklet);
 
 	/* send buffered multicast frames now */
 	if (intr & MT_INT_TBTT) {
@@ -449,7 +449,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	ieee80211_stop_queues(dev->mt76.hw);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->mt76.tx_tasklet);
 	napi_disable(&dev->tx_napi);
 
@@ -508,7 +508,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	napi_enable(&dev->tx_napi);
 	napi_schedule(&dev->tx_napi);
 
-	tasklet_enable(&dev->pre_tbtt_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++) {
 		napi_enable(&dev->mt76.napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 227c360165b0..12724e96b290 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -594,7 +594,7 @@ void mt76x02_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76x02_dev *dev = hw->priv;
 
 	if (mt76_is_mmio(dev))
-		tasklet_disable(&dev->pre_tbtt_tasklet);
+		tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	set_bit(MT76_SCANNING, &dev->mt76.state);
 }
 EXPORT_SYMBOL_GPL(mt76x02_sw_scan);
@@ -606,7 +606,7 @@ void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
 	if (mt76_is_mmio(dev))
-		tasklet_enable(&dev->pre_tbtt_tasklet);
+		tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	if (dev->cal.gain_init_done) {
 		/* Restore AGC gain and resume calibration after scanning. */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 90c1a0489294..71aea2832644 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -300,7 +300,7 @@ void mt76x2_stop_hardware(struct mt76x02_dev *dev)
 void mt76x2_cleanup(struct mt76x02_dev *dev)
 {
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x2_stop_hardware(dev);
 	mt76x02_dma_cleanup(dev);
 	mt76x02_mcu_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index ab716957b8ba..e416eee6a306 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -59,7 +59,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 
 	mt76_set_channel(&dev->mt76);
 
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
 	mt76x2_mac_stop(dev, true);
@@ -73,7 +73,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 
 	mt76x2_mac_resume(dev);
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
-	tasklet_enable(&dev->pre_tbtt_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
-- 
2.20.1

