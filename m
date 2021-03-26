Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B234B0ED
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 21:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZUzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhCZUzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 16:55:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27450C0613AA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oYsFmva6zQUFFIaBXpbbz5siXwBBYCZZqnyaEjib/gM=; b=i4HHBLmhlNGnK0fnPd7KOmnfJa
        Jdi5uRmI8egBNwe7j+aaag5RQPGBTIKBGsH7xL1KiwRGXhdo/h1o39Sq95C6MtktB263yBfAJgiSY
        fm1luNW2nsn+2x0jbH7ZxrtLnjDBQDZvIBZKNp9yTwpTc1m5uH+iqMzR2p2EPkCxTm3A=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPtU3-0001b7-Ok
        for linux-wireless@vger.kernel.org; Fri, 26 Mar 2021 21:55:07 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7615: fix chip reset on MT7622 and MT7663e
Date:   Fri, 26 Mar 2021 21:55:05 +0100
Message-Id: <20210326205505.74383-3-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326205505.74383-1-nbd@nbd.name>
References: <20210326205505.74383-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After chip reset, the DMA scheduler needs to be initialized as well.
Since the code is PCI/SoC specific, move it to pci_mac.c, so that it
can depend on a function in dma.c

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  26 +--
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 170 ------------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   1 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 168 +++++++++++++++++
 7 files changed, 187 insertions(+), 181 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 2e3120eb2da9..0ec1c526f583 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -176,6 +176,21 @@ static void mt7663_dma_sched_init(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_DMA_SHDL(MT_DMASHDL_SCHED_SET1), 0xedcba987);
 }
 
+void mt7615_dma_start(struct mt7615_dev *dev)
+{
+	/* start dma engine */
+	mt76_set(dev, MT_WPDMA_GLO_CFG,
+		 MT_WPDMA_GLO_CFG_TX_DMA_EN |
+		 MT_WPDMA_GLO_CFG_RX_DMA_EN |
+		 MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
+
+	if (is_mt7622(&dev->mt76))
+		mt7622_dma_sched_init(dev);
+
+	if (is_mt7663(&dev->mt76))
+		mt7663_dma_sched_init(dev);
+}
+
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int rx_ring_size = MT7615_RX_RING_SIZE;
@@ -253,20 +268,11 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		  MT_WPDMA_GLO_CFG_TX_DMA_BUSY |
 		  MT_WPDMA_GLO_CFG_RX_DMA_BUSY, 0, 1000);
 
-	/* start dma engine */
-	mt76_set(dev, MT_WPDMA_GLO_CFG,
-		 MT_WPDMA_GLO_CFG_TX_DMA_EN |
-		 MT_WPDMA_GLO_CFG_RX_DMA_EN);
-
 	/* enable interrupts for TX/RX rings */
 	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | mt7615_tx_mcu_int_mask(dev) |
 			       MT_INT_MCU_CMD);
 
-	if (is_mt7622(&dev->mt76))
-		mt7622_dma_sched_init(dev);
-
-	if (is_mt7663(&dev->mt76))
-		mt7663_dma_sched_init(dev);
+	mt7615_dma_start(dev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index c59043195870..857fb4918975 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -504,7 +504,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	init_waitqueue_head(&dev->reset_wait);
 	init_waitqueue_head(&dev->phy.roc_wait);
 
-	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
 	INIT_WORK(&dev->phy.roc_work, mt7615_roc_work);
 	timer_setup(&dev->phy.roc_timer, mt7615_roc_timer, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3d9d893dbac5..6a1395de3066 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1966,76 +1966,6 @@ void mt7615_mac_work(struct work_struct *work)
 				     MT7615_WATCHDOG_TIME);
 }
 
-static bool
-mt7615_wait_reset_state(struct mt7615_dev *dev, u32 state)
-{
-	bool ret;
-
-	ret = wait_event_timeout(dev->reset_wait,
-				 (READ_ONCE(dev->reset_state) & state),
-				 MT7615_RESET_TIMEOUT);
-	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
-	return ret;
-}
-
-static void
-mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct ieee80211_hw *hw = priv;
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_AP:
-		mt7615_mcu_add_beacon(dev, hw, vif,
-				      vif->bss_conf.enable_beacon);
-		break;
-	default:
-		break;
-	}
-}
-
-static void
-mt7615_update_beacons(struct mt7615_dev *dev)
-{
-	ieee80211_iterate_active_interfaces(dev->mt76.hw,
-		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt7615_update_vif_beacon, dev->mt76.hw);
-
-	if (!dev->mt76.phy2)
-		return;
-
-	ieee80211_iterate_active_interfaces(dev->mt76.phy2->hw,
-		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt7615_update_vif_beacon, dev->mt76.phy2->hw);
-}
-
-void mt7615_dma_reset(struct mt7615_dev *dev)
-{
-	int i;
-
-	mt76_clear(dev, MT_WPDMA_GLO_CFG,
-		   MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
-		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
-
-	usleep_range(1000, 2000);
-
-	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
-
-	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_reset(dev, i);
-
-	mt76_set(dev, MT_WPDMA_GLO_CFG,
-		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
-		 MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
-}
-EXPORT_SYMBOL_GPL(mt7615_dma_reset);
-
 void mt7615_tx_token_put(struct mt7615_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
@@ -2053,106 +1983,6 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7615_tx_token_put);
 
-static void
-mt7615_hif_int_event_trigger(struct mt7615_dev *dev, u8 event)
-{
-	mt76_wr(dev, MT_MCU_INT_EVENT, event);
-
-	mt7622_trigger_hif_int(dev, true);
-	mt7622_trigger_hif_int(dev, false);
-}
-
-void mt7615_mac_reset_work(struct work_struct *work)
-{
-	struct mt7615_phy *phy2;
-	struct mt76_phy *ext_phy;
-	struct mt7615_dev *dev;
-
-	dev = container_of(work, struct mt7615_dev, reset_work);
-	ext_phy = dev->mt76.phy2;
-	phy2 = ext_phy ? ext_phy->priv : NULL;
-
-	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_PDMA))
-		return;
-
-	ieee80211_stop_queues(mt76_hw(dev));
-	if (ext_phy)
-		ieee80211_stop_queues(ext_phy->hw);
-
-	set_bit(MT76_RESET, &dev->mphy.state);
-	set_bit(MT76_MCU_RESET, &dev->mphy.state);
-	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	del_timer_sync(&dev->phy.roc_timer);
-	cancel_work_sync(&dev->phy.roc_work);
-	if (phy2) {
-		set_bit(MT76_RESET, &phy2->mt76->state);
-		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-		del_timer_sync(&phy2->roc_timer);
-		cancel_work_sync(&phy2->roc_work);
-	}
-
-	/* lock/unlock all queues to ensure that no tx is pending */
-	mt76_txq_schedule_all(&dev->mphy);
-	if (ext_phy)
-		mt76_txq_schedule_all(ext_phy);
-
-	mt76_worker_disable(&dev->mt76.tx_worker);
-	napi_disable(&dev->mt76.napi[0]);
-	napi_disable(&dev->mt76.napi[1]);
-	napi_disable(&dev->mt76.tx_napi);
-
-	mt7615_mutex_acquire(dev);
-
-	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_STOPPED);
-
-	mt7615_tx_token_put(dev);
-	idr_init(&dev->token);
-
-	if (mt7615_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-		mt7615_dma_reset(dev);
-
-		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
-
-		mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_INIT);
-		mt7615_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
-	}
-
-	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-	clear_bit(MT76_RESET, &dev->mphy.state);
-	if (phy2)
-		clear_bit(MT76_RESET, &phy2->mt76->state);
-
-	mt76_worker_enable(&dev->mt76.tx_worker);
-	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-
-	napi_enable(&dev->mt76.napi[0]);
-	napi_schedule(&dev->mt76.napi[0]);
-
-	napi_enable(&dev->mt76.napi[1]);
-	napi_schedule(&dev->mt76.napi[1]);
-
-	ieee80211_wake_queues(mt76_hw(dev));
-	if (ext_phy)
-		ieee80211_wake_queues(ext_phy->hw);
-
-	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_RESET_DONE);
-	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
-
-	mt7615_update_beacons(dev);
-
-	mt7615_mutex_release(dev);
-
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
-				     MT7615_WATCHDOG_TIME);
-	if (phy2)
-		ieee80211_queue_delayed_work(ext_phy->hw,
-					     &phy2->mt76->mac_work,
-					     MT7615_WATCHDOG_TIME);
-
-}
-
 static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0b8f5dc6b121..03fc58407d72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -283,6 +283,7 @@ void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 			   MT_INFRACFG_MISC_AP2CONN_WAKE,
 			   !en * MT_INFRACFG_MISC_AP2CONN_WAKE);
 }
+EXPORT_SYMBOL_GPL(mt7622_trigger_hif_int);
 
 static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 484fc16f0c11..dbabdeef4e0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -376,6 +376,7 @@ int mt7615_eeprom_get_power_delta_index(struct mt7615_dev *dev,
 					enum nl80211_band band);
 int mt7615_wait_pdma_busy(struct mt7615_dev *dev);
 int mt7615_dma_init(struct mt7615_dev *dev);
+void mt7615_dma_start(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 72395925ddee..a629d9cb3806 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -126,6 +126,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	int ret;
 
 	mt7615_init_device(dev);
+	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 1b4cb145f38e..1b206ccdadf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -181,3 +181,171 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	return 0;
 }
+
+void mt7615_dma_reset(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG,
+		   MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
+		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
+
+	usleep_range(1000, 2000);
+
+	for (i = 0; i < __MT_TXQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	mt7615_dma_start(dev);
+}
+EXPORT_SYMBOL_GPL(mt7615_dma_reset);
+
+static void
+mt7615_hif_int_event_trigger(struct mt7615_dev *dev, u8 event)
+{
+	mt76_wr(dev, MT_MCU_INT_EVENT, event);
+
+	mt7622_trigger_hif_int(dev, true);
+	mt7622_trigger_hif_int(dev, false);
+}
+
+static bool
+mt7615_wait_reset_state(struct mt7615_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7615_RESET_TIMEOUT);
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct ieee80211_hw *hw = priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP:
+		mt7615_mcu_add_beacon(dev, hw, vif,
+				      vif->bss_conf.enable_beacon);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7615_update_beacons(struct mt7615_dev *dev)
+{
+	ieee80211_iterate_active_interfaces(dev->mt76.hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7615_update_vif_beacon, dev->mt76.hw);
+
+	if (!dev->mt76.phy2)
+		return;
+
+	ieee80211_iterate_active_interfaces(dev->mt76.phy2->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7615_update_vif_beacon, dev->mt76.phy2->hw);
+}
+
+void mt7615_mac_reset_work(struct work_struct *work)
+{
+	struct mt7615_phy *phy2;
+	struct mt76_phy *ext_phy;
+	struct mt7615_dev *dev;
+
+	dev = container_of(work, struct mt7615_dev, reset_work);
+	ext_phy = dev->mt76.phy2;
+	phy2 = ext_phy ? ext_phy->priv : NULL;
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_PDMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_stop_queues(ext_phy->hw);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	del_timer_sync(&dev->phy.roc_timer);
+	cancel_work_sync(&dev->phy.roc_work);
+	if (phy2) {
+		set_bit(MT76_RESET, &phy2->mt76->state);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
+		del_timer_sync(&phy2->roc_timer);
+		cancel_work_sync(&phy2->roc_work);
+	}
+
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+	if (ext_phy)
+		mt76_txq_schedule_all(ext_phy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	napi_disable(&dev->mt76.napi[0]);
+	napi_disable(&dev->mt76.napi[1]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mt7615_mutex_acquire(dev);
+
+	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_STOPPED);
+
+	mt7615_tx_token_put(dev);
+	idr_init(&dev->token);
+
+	if (mt7615_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7615_dma_reset(dev);
+
+		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
+
+		mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_INIT);
+		mt7615_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+
+	napi_enable(&dev->mt76.napi[0]);
+	napi_schedule(&dev->mt76.napi[0]);
+
+	napi_enable(&dev->mt76.napi[1]);
+	napi_schedule(&dev->mt76.napi[1]);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_wake_queues(ext_phy->hw);
+
+	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mt7615_update_beacons(dev);
+
+	mt7615_mutex_release(dev);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
+				     MT7615_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &phy2->mt76->mac_work,
+					     MT7615_WATCHDOG_TIME);
+
+}
-- 
2.30.1

