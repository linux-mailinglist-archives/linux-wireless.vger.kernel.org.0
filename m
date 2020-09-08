Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E42621D4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgIHVSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgIHVSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B83CC061786
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hRgIPPTP1MZv3c5QwSIhwc1KhU5CJsuFkk1fo0nHrzY=; b=gDc/yAFYhDcYQo//GM7DksSOCs
        01b04C99RXuP4dL5MR4VRzkoi6lYB45+74U1L2YQYEiRAHRCCfYRGKRrY3uIe9gzim1ofpCJQQYPA
        oOBW6j1LEbI7U/hOshTQM0mhrsHWkqRHPEYw8tTQW3blNKWjrJuncyLEymXDEW1eCAZU=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl02-0002Cx-Sm
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:58 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/11] mt76: convert from tx tasklet to tx worker thread
Date:   Tue,  8 Sep 2020 23:17:50 +0200
Message-Id: <20200908211756.15998-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This improves performance by allowing the scheduler to move the tx scheduling
work to idle CPUs. Since tx scheduling work is very latency sensitive and
kept short via AQL, sched_set_fifo_low is used to keep worker priority above
normal tasks

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  1 +
 drivers/net/wireless/mediatek/mt76/mac80211.c | 14 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++--
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  3 +--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  8 +++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  3 ++-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 --
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dma.h  |  1 -
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 22 +++++++------------
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  3 ++-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 ++---
 drivers/net/wireless/mediatek/mt76/testmode.c |  6 ++---
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 ++---
 drivers/net/wireless/mediatek/mt76/usb.c      | 14 +++++++-----
 20 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 240f04b10daf..7f669a2432a4 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -592,6 +592,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 {
 	int i;
 
+	mt76_worker_disable(&dev->tx_worker);
 	netif_napi_del(&dev->tx_napi);
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
 		mt76_dma_tx_cleanup(dev, i, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7014846fd854..c5946ebadc8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
+#include <linux/sched.h>
 #include <linux/of.h>
 #include "mt76.h"
 
@@ -436,14 +437,13 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	skb_queue_head_init(&dev->mcu.res_q);
 	init_waitqueue_head(&dev->mcu.wait);
 	mutex_init(&dev->mcu.mutex);
+	dev->tx_worker.fn = mt76_tx_worker;
 
 	INIT_LIST_HEAD(&dev->txwi_cache);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
 		skb_queue_head_init(&dev->rx_skb[i]);
 
-	tasklet_init(&dev->tx_tasklet, mt76_tx_tasklet, (unsigned long)dev);
-
 	dev->wq = alloc_ordered_workqueue("mt76", 0);
 	if (!dev->wq) {
 		ieee80211_free_hw(hw);
@@ -486,7 +486,14 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			return ret;
 	}
 
-	return ieee80211_register_hw(hw);
+	ret = ieee80211_register_hw(hw);
+	if (ret)
+		return ret;
+
+	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
+	sched_set_fifo_low(dev->tx_worker.task);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_register_device);
 
@@ -503,6 +510,7 @@ EXPORT_SYMBOL_GPL(mt76_unregister_device);
 
 void mt76_free_device(struct mt76_dev *dev)
 {
+	mt76_worker_teardown(&dev->tx_worker);
 	if (dev->wq) {
 		destroy_workqueue(dev->wq);
 		dev->wq = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 59eed5374b38..2d44fe522ade 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -604,7 +604,7 @@ struct mt76_dev {
 	const struct mt76_queue_ops *queue_ops;
 	int tx_dma_idx[4];
 
-	struct tasklet_struct tx_tasklet;
+	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
 	struct delayed_work mac_work;
 
@@ -906,7 +906,7 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_phy *phy);
-void mt76_tx_tasklet(unsigned long data);
+void mt76_tx_worker(struct mt76_worker *w);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  u16 tids, int nframes,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index b51b894a6d84..46be157d8c1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -163,7 +163,7 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 
 	mt7603_mac_sta_poll(dev);
 
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 
 	return 0;
 }
@@ -246,6 +246,5 @@ void mt7603_dma_cleanup(struct mt7603_dev *dev)
 		   MT_WPDMA_GLO_CFG_RX_DMA_EN |
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 
-	tasklet_kill(&dev->mt76.tx_tasklet);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 91a4f7036fea..97679eb4d067 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1402,7 +1402,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
 
-	tasklet_disable(&dev->mt76.tx_tasklet);
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
@@ -1451,7 +1451,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
-	tasklet_enable(&dev->mt76.tx_tasklet);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 242638f96aa0..bf8ae14121db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -297,6 +297,5 @@ void mt7615_dma_cleanup(struct mt7615_dev *dev)
 		   MT_WPDMA_GLO_CFG_RX_DMA_EN);
 	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_SW_RESET);
 
-	tasklet_kill(&dev->mt76.tx_tasklet);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9d0edbaa67bc..ab1fbf4c56b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1462,7 +1462,7 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	rcu_read_unlock();
 
 	mt7615_pm_power_save_sched(dev);
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
@@ -1888,7 +1888,7 @@ void mt7615_pm_wake_work(struct work_struct *work)
 	}
 	spin_unlock_bh(&dev->pm.txq_lock);
 
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 
 out:
 	ieee80211_wake_queues(mphy->hw);
@@ -2130,7 +2130,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	if (ext_phy)
 		mt76_txq_schedule_all(ext_phy);
 
-	tasklet_disable(&dev->mt76.tx_tasklet);
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
 	napi_disable(&dev->mt76.tx_napi);
@@ -2151,7 +2151,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
-	tasklet_enable(&dev->mt76.tx_tasklet);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index bdade416934c..3c0101a90205 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -707,7 +707,7 @@ mt7615_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	}
 
 	dev->pm.last_activity = jiffies;
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
 static void mt7615_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index b9794f8a8df4..dbd29d897b29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -88,7 +88,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 
 	napi_disable(&mdev->tx_napi);
-	tasklet_kill(&mdev->tx_tasklet);
+	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
 		napi_disable(&mdev->napi[i]);
@@ -162,6 +162,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 	if (pdma_reset)
 		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
 
+	mt76_worker_enable(&mdev->tx_worker);
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 23a21338c46e..f0ad83af9e00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -180,9 +180,7 @@ static int mt7663u_suspend(struct usb_interface *intf, pm_message_t state)
 	}
 
 	mt76u_stop_rx(&dev->mt76);
-
 	mt76u_stop_tx(&dev->mt76);
-	tasklet_kill(&dev->mt76.tx_tasklet);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 5e567483b372..dda11c704aba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -204,7 +204,7 @@ static void mt76x0e_cleanup(struct mt76x02_dev *dev)
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76x0e_stop_hw(dev);
-	mt76x02_dma_cleanup(dev);
+	mt76_dma_cleanup(&dev->mt76);
 	mt76x02_mcu_cleanup(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h b/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
index 4aff4f8e87b6..23b0e7d10d57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
@@ -61,6 +61,5 @@ mt76x02_wait_for_wpdma(struct mt76_dev *dev, int timeout)
 
 int mt76x02_dma_init(struct mt76x02_dev *dev);
 void mt76x02_dma_disable(struct mt76x02_dev *dev);
-void mt76x02_dma_cleanup(struct mt76x02_dev *dev);
 
 #endif /* __MT76x02_DMA_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4016ffe840ed..cf68731bd094 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -149,9 +149,11 @@ static void mt76x02_process_tx_status_fifo(struct mt76x02_dev *dev)
 		mt76x02_send_tx_status(dev, &stat, &update);
 }
 
-static void mt76x02_tx_tasklet(unsigned long data)
+static void mt76x02_tx_worker(struct mt76_worker *w)
 {
-	struct mt76x02_dev *dev = (struct mt76x02_dev *)data;
+	struct mt76x02_dev *dev;
+
+	dev = container_of(w, struct mt76x02_dev, mt76.tx_worker);
 
 	mt76x02_mac_poll_tx_status(dev, false);
 	mt76x02_process_tx_status_fifo(dev);
@@ -176,7 +178,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 	for (i = MT_TXQ_MCU; i >= 0; i--)
 		mt76_queue_tx_cleanup(dev, i, false);
 
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 
 	return 0;
 }
@@ -195,8 +197,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (!status_fifo)
 		return -ENOMEM;
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt76x02_tx_tasklet,
-		     (unsigned long)dev);
+	dev->mt76.tx_worker.fn = mt76x02_tx_worker;
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
@@ -323,13 +324,6 @@ static void mt76x02_dma_enable(struct mt76x02_dev *dev)
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 }
 
-void mt76x02_dma_cleanup(struct mt76x02_dev *dev)
-{
-	tasklet_kill(&dev->mt76.tx_tasklet);
-	mt76_dma_cleanup(&dev->mt76);
-}
-EXPORT_SYMBOL_GPL(mt76x02_dma_cleanup);
-
 void mt76x02_dma_disable(struct mt76x02_dev *dev)
 {
 	u32 val = mt76_rr(dev, MT_WPDMA_GLO_CFG);
@@ -447,7 +441,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	set_bit(MT76_RESET, &dev->mphy.state);
 
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
-	tasklet_disable(&dev->mt76.tx_tasklet);
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	napi_disable(&dev->mt76.tx_napi);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
@@ -504,7 +498,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
-	tasklet_enable(&dev->mt76.tx_tasklet);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 377cf9c02a6f..4d50dad29ddf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -113,7 +113,7 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	napi_disable(&mdev->tx_napi);
 	tasklet_kill(&mdev->pre_tbtt_tasklet);
-	tasklet_kill(&mdev->tx_tasklet);
+	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i)
 		napi_disable(&mdev->napi[i]);
@@ -147,6 +147,7 @@ mt76x2e_resume(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	mt76_worker_enable(&mdev->tx_worker);
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
 		napi_schedule(&mdev->napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 101a0fe00ef3..48a3ebc9892a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -283,7 +283,7 @@ void mt76x2_cleanup(struct mt76x02_dev *dev)
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x2_stop_hardware(dev);
-	mt76x02_dma_cleanup(dev);
+	mt76_dma_cleanup(&dev->mt76);
 	mt76x02_mcu_cleanup(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index a183b76855b8..875badcc3070 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -372,6 +372,5 @@ void mt7915_dma_cleanup(struct mt7915_dev *dev)
 		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
 		 MT_WFDMA0_RST_LOGIC_RST);
 
-	tasklet_kill(&dev->mt76.tx_tasklet);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 4d6e4143e346..54088d8e151f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -951,7 +951,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 
 	mt7915_mac_sta_poll(dev);
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
@@ -1223,7 +1223,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (ext_phy)
 		mt76_txq_schedule_all(ext_phy);
 
-	tasklet_disable(&dev->mt76.tx_tasklet);
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
 	napi_disable(&dev->mt76.napi[2]);
@@ -1243,7 +1243,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
 
-	tasklet_enable(&dev->mt76.tx_tasklet);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 	napi_enable(&dev->mt76.tx_napi);
 	napi_schedule(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index a38abb6868d5..883f59c7a7e4 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -161,7 +161,7 @@ mt76_testmode_tx_start(struct mt76_dev *dev)
 	td->tx_queued = 0;
 	td->tx_done = 0;
 	td->tx_pending = td->tx_count;
-	tasklet_schedule(&dev->tx_tasklet);
+	mt76_worker_schedule(&dev->tx_worker);
 }
 
 static void
@@ -169,11 +169,11 @@ mt76_testmode_tx_stop(struct mt76_dev *dev)
 {
 	struct mt76_testmode_data *td = &dev->test;
 
-	tasklet_disable(&dev->tx_tasklet);
+	mt76_worker_disable(&dev->tx_worker);
 
 	td->tx_pending = 0;
 
-	tasklet_enable(&dev->tx_tasklet);
+	mt76_worker_enable(&dev->tx_worker);
 
 	wait_event_timeout(dev->tx_wait, td->tx_done == td->tx_queued, 10 * HZ);
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 8a12a890e998..5914312d8944 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -604,9 +604,9 @@ void mt76_txq_schedule_all(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
-void mt76_tx_tasklet(unsigned long data)
+void mt76_tx_worker(struct mt76_worker *w)
 {
-	struct mt76_dev *dev = (struct mt76_dev *)data;
+	struct mt76_dev *dev = container_of(w, struct mt76_dev, tx_worker);
 
 	mt76_txq_schedule_all(&dev->phy);
 	if (dev->phy2)
@@ -649,7 +649,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	if (!test_bit(MT76_STATE_RUNNING, &phy->state))
 		return;
 
-	tasklet_schedule(&dev->tx_tasklet);
+	mt76_worker_schedule(&dev->tx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 18dbecafb7a0..edbcabd2b797 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -792,9 +792,9 @@ int mt76u_resume_rx(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-static void mt76u_tx_tasklet(unsigned long data)
+static void mt76u_tx_worker(struct mt76_worker *w)
 {
-	struct mt76_dev *dev = (struct mt76_dev *)data;
+	struct mt76_dev *dev = container_of(w, struct mt76_dev, tx_worker);
 	struct mt76_queue_entry entry;
 	struct mt76_queue *q;
 	bool wake;
@@ -864,7 +864,7 @@ static void mt76u_complete_tx(struct urb *urb)
 		dev_err(dev->dev, "tx urb failed: %d\n", urb->status);
 	e->done = true;
 
-	tasklet_schedule(&dev->tx_tasklet);
+	mt76_worker_schedule(&dev->tx_worker);
 }
 
 static int
@@ -1020,6 +1020,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 {
 	int ret;
 
+	mt76_worker_disable(&dev->tx_worker);
+
 	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
 	if (!ret) {
@@ -1038,8 +1040,6 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 				usb_kill_urb(q->entry[j].urb);
 		}
 
-		tasklet_kill(&dev->tx_tasklet);
-
 		/* On device removal we maight queue skb's, but mt76u_tx_kick()
 		 * will fail to submit urb, cleanup those skb's manually.
 		 */
@@ -1058,6 +1058,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	cancel_work_sync(&dev->usb.stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
+	mt76_worker_enable(&dev->tx_worker);
+
 	mt76_tx_status_check(dev, NULL, true);
 }
 EXPORT_SYMBOL_GPL(mt76u_stop_tx);
@@ -1107,8 +1109,8 @@ int mt76u_init(struct mt76_dev *dev,
 	mt76u_ops.rmw = ext ? mt76u_rmw_ext : mt76u_rmw;
 	mt76u_ops.write_copy = ext ? mt76u_copy_ext : mt76u_copy;
 
+	dev->tx_worker.fn = mt76u_tx_worker;
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
-	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
-- 
2.28.0

