Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073B7DD78
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfD2INX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:23 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DD52087B;
        Mon, 29 Apr 2019 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525602;
        bh=Yh8ku5/7fhG3KiQwKaqBxBc9mgzQ3p3Hml9eMgnFemo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRBHzPyi/geP/H7X/QrPQdW75u7pdzWrUBP7ROMvFuHif4lFPUPlS7j+p43jaoSdK
         nBQRbY9I2xIYqXNkSBIVGwciAwjp0qvf0cWP9rSa63Q8MzOiZjxtwSakpcrC3eKCZ/
         lgwTGLaDlghW9gD2e52HT9hW1htX8C9bZipq16ls=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 4/5] mt76: move pre_tbtt_tasklet in mt76_dev
Date:   Mon, 29 Apr 2019 10:13:01 +0200
Message-Id: <92b351c2c91ab8cc311cf280ca3562dd6f49649b.1556525110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556525110.git.lorenzo@kernel.org>
References: <cover.1556525110.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |  4 ++--
 11 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fb0ba1500d89..859c9f019323 100644
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
index d394839f1bd8..c3c295919020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -514,7 +514,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	spin_lock_init(&dev->ps_lock);
 
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7603_mac_work);
-	tasklet_init(&dev->pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
+	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
 	/* Check for 7688, which only has 1SS */
@@ -573,7 +573,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 void mt7603_unregister_device(struct mt7603_dev *dev)
 {
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76_unregister_device(&dev->mt76);
 	mt7603_mcu_exit(dev);
 	mt7603_dma_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index a5a881738d83..ad517e1af75b 100644
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
index 8f5ae1644a92..56ef73e41a5a 100644
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
index f106dbfa665f..6a8fe82ab9ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -219,7 +219,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void mt76x0e_cleanup(struct mt76x02_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76x0e_stop_hw(dev);
 	mt76x02_dma_cleanup(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f754790dada4..07579a951dd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -90,7 +90,6 @@ struct mt76x02_dev {
 	struct sk_buff *rx_head;
 
 	struct tasklet_struct tx_tasklet;
-	struct tasklet_struct pre_tbtt_tasklet;
 	struct delayed_work cal_work;
 	struct delayed_work wdt_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 31e0d4b03f6b..c4ead6a76766 100644
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
@@ -184,7 +184,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 
 	tasklet_init(&dev->mt76.tx_tasklet, mt76x02_tx_tasklet,
 		     (unsigned long) dev);
-	tasklet_init(&dev->pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
+	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
 	kfifo_init(&dev->txstatus_fifo, status_fifo, fifo_size);
@@ -267,7 +267,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 	}
 
 	if (intr & MT_INT_PRE_TBTT)
-		tasklet_schedule(&dev->pre_tbtt_tasklet);
+		tasklet_schedule(&dev->mt76.pre_tbtt_tasklet);
 
 	/* send buffered multicast frames now */
 	if (intr & MT_INT_TBTT) {
@@ -427,7 +427,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	ieee80211_stop_queues(dev->mt76.hw);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->mt76.tx_tasklet);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++)
@@ -484,7 +484,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	tasklet_enable(&dev->mt76.tx_tasklet);
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
-	tasklet_enable(&dev->pre_tbtt_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++) {
 		napi_enable(&dev->mt76.napi[i]);
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
index 77f63cb14f35..93ad12391e33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -66,7 +66,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 
 	mt76_set_channel(&dev->mt76);
 
-	tasklet_disable(&dev->pre_tbtt_tasklet);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
 	mt76x2_mac_stop(dev, true);
@@ -80,7 +80,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 
 	mt76x2_mac_resume(dev);
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
-	tasklet_enable(&dev->pre_tbtt_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
-- 
2.20.1

