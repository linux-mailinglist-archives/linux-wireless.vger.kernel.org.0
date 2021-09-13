Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980F0408829
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhIMJ06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 05:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238281AbhIMJ0w (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A40460E94;
        Mon, 13 Sep 2021 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631525137;
        bh=ITY7VVGxTfi8Wk9TtlIJBqi5rBCkm4f1udyJUwk6Ihc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7ehSHxNjXK5uWE5jVh9UZZazqzShmoqiZ1r12VKaA9XdJ09eBtxMBDOi3bI5VsxC
         7C4OvsNvjdzXexI31vs25oKAQ1QCJ/CZezEjYpBtXqvU37H3+r6gRpQNYhsHo6qXwp
         u0rdSUykv4OA5Vwa8FATQqvOwwqM4Cm5LsYQ1i+6L83tUZzDe6phJbmZcttswmvp0r
         XKNF8MvgqTm0hyE8sooDvg+82YZClzguzrHsBW6JV/DtXTXEjeW9p9ZUjQ5lZNmA1B
         K0VgW9NjdRW2aRRLo8HPIF7aVswl/q543er4R0L4lvVVeorlFauXNDd4J1sV5Lz6iG
         NN2+U4r+zQwSA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        greearb@candelatech.com, mrkiko.rs@gmail.com
Subject: [PATCH 2/4] mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
Date:   Mon, 13 Sep 2021 11:25:03 +0200
Message-Id: <307402423b46b5a5351100cfaa5df8cfbc060ee0.1631525026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631525026.git.lorenzo@kernel.org>
References: <cover.1631525026.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt76_wcid pointer from mt76_tx_status_check signature since it is
always set to NULL

Tested-by: mrkiko.rs@gmail.com
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c       | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h           | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c           | 2 +-
 drivers/net/wireless/mediatek/mt76/tx.c             | 3 ++-
 drivers/net/wireless/mediatek/mt76/usb.c            | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e26cdc254fa8..47e4494bcbff 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -511,7 +511,7 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 
-	mt76_tx_status_check(dev, NULL, true);
+	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
 	dev->phy2 = NULL;
 }
@@ -639,7 +639,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(dev);
-	mt76_tx_status_check(dev, NULL, true);
+	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(hw);
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2e5e49c1d071..a62d74500fd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1115,8 +1115,7 @@ mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
     __mt76_tx_complete_skb(dev, wcid, skb, NULL);
 }
 
-void mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid,
-			  bool flush);
+void mt76_tx_status_check(struct mt76_dev *dev, bool flush);
 int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta,
 		   enum ieee80211_sta_state old_state,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3972c56136a2..93a49db5b590 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1458,7 +1458,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 		mt76_queue_rx_reset(dev, i);
 	}
 
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	mt76_tx_status_check(&dev->mt76, true);
 
 	mt7603_dma_sched_reset(dev);
 
@@ -1814,7 +1814,7 @@ void mt7603_mac_work(struct work_struct *work)
 	bool reset = false;
 	int i, idx;
 
-	mt76_tx_status_check(&dev->mt76, NULL, false);
+	mt76_tx_status_check(&dev->mt76, false);
 
 	mutex_lock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ed1bba42a322..02900a56b124 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2082,7 +2082,7 @@ void mt7615_mac_work(struct work_struct *work)
 
 	mt7615_mutex_release(phy->dev);
 
-	mt76_tx_status_check(mphy->dev, NULL, false);
+	mt76_tx_status_check(mphy->dev, false);
 
 	timeout = mt7615_get_macwork_timeout(phy->dev);
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work, timeout);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index cd2964d24eed..c7052d536446 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -202,7 +202,7 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	mt76_tx_status_check(&dev->mt76, true);
 
 	mt7615_dma_start(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 305bb8597531..fb0f8f34b8f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -432,7 +432,7 @@ static int mt7663s_suspend(struct device *dev)
 	cancel_work_sync(&mdev->mt76.sdio.stat_work);
 	clear_bit(MT76_READING_STATS, &mdev->mphy.state);
 
-	mt76_tx_status_check(&mdev->mt76, NULL, true);
+	mt76_tx_status_check(&mdev->mt76, true);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 07b21b208582..a404fd7ea968 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1186,7 +1186,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_tx_status_check(&dev->mt76, NULL, false);
+	mt76_tx_status_check(&dev->mt76, false);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index b50084bbe83d..de04ecb5d86a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -472,7 +472,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 		mt76_queue_rx_reset(dev, i);
 	}
 
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	mt76_tx_status_check(&dev->mt76, true);
 
 	mt76x02_mac_start(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1c487f22453c..7d6287df8ae6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1751,7 +1751,7 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	mt76_tx_status_check(&dev->mt76, true);
 
 	/* re-init prefetch settings after reset */
 	mt7915_dma_prefetch(dev);
@@ -1964,7 +1964,7 @@ void mt7915_mac_work(struct work_struct *work)
 
 	mutex_unlock(&mphy->dev->mutex);
 
-	mt76_tx_status_check(mphy->dev, NULL, false);
+	mt76_tx_status_check(mphy->dev, false);
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7915_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 62cee662ba28..802e40e42040 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -272,7 +272,7 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
 
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	mt76_tx_status_check(&dev->mt76, true);
 
 	return mt7921_dma_enable(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8fd11497d8e6..27f13228c5a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1695,7 +1695,7 @@ void mt7921_mac_work(struct work_struct *work)
 
 	mt7921_mutex_release(phy->dev);
 
-	mt76_tx_status_check(mphy->dev, NULL, false);
+	mt76_tx_status_check(mphy->dev, false);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
 				     MT7921_WATCHDOG_TIME);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 783a15635ec5..4abf432750c6 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -328,7 +328,7 @@ void mt76s_deinit(struct mt76_dev *dev)
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
-	mt76_tx_status_check(dev, NULL, true);
+	mt76_tx_status_check(dev, true);
 
 	sdio_claim_host(sdio->func);
 	sdio_release_irq(sdio->func);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5ae95018415f..5f0040df9e1c 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -188,9 +188,10 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 EXPORT_SYMBOL_GPL(mt76_tx_status_skb_get);
 
 void
-mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid, bool flush)
+mt76_tx_status_check(struct mt76_dev *dev, bool flush)
 {
 	struct sk_buff_head list;
+	struct mt76_wcid *wcid;
 
 	mt76_tx_status_lock(dev, &list);
 	while (!list_empty(&dev->wcid_list)) {
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1e9f60bb811a..0a7006c8959b 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1081,7 +1081,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 
 	mt76_worker_enable(&dev->usb.status_worker);
 
-	mt76_tx_status_check(dev, NULL, true);
+	mt76_tx_status_check(dev, true);
 }
 EXPORT_SYMBOL_GPL(mt76u_stop_tx);
 
-- 
2.31.1

