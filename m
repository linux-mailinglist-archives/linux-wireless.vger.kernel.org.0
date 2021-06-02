Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A2399562
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFBV1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 17:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFBV1S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 17:27:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44E3F613C9;
        Wed,  2 Jun 2021 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622669133;
        bh=yK3WQBMMeMxbKAV9/TxMCM13oArnGK6q8YFGSwV+Cb0=;
        h=From:To:Cc:Subject:Date:From;
        b=JysNYlsH6So6PJBoLqaagUyFo1EdTXmeDimUngBWO5b36BXi1ILNKxQaP475lGwmh
         25t4SNoxscgRisOY1He0ykq1YLSgYiWfv0IcvioFehTMjiffwBJZs25odf2pJQGB9R
         lywBCu2J3h67qoo/5FLULMw0ggR9I1uNvwFUvOYDhDKZu9lmADdksLPR64VZpkU8wG
         vSuhnmee6IOp0OoIvSySOwma8MamHyYmBZ3uNrZePPd+ni6bP6id0BXHnMbPfwJOHU
         5LuoDYtUWhDGxxiaHDjTqOASyLcfYC2Ijqhpmnan/IioA3cjHmF1bjXr7aXbB/aSPE
         XPaiLZTJzgiRQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: connac: add mt76_connac_power_save_sched in mt76_connac_pm_unref
Date:   Wed,  2 Jun 2021 23:25:28 +0200
Message-Id: <31548b57b6932dc8e59d6bc9039d6286b954a68a.1622669073.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Schedule power_save work running mt76_connac_pm_unref in order to reduce
power consumption

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 8004ae5c16a9..b6184234cad2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -81,7 +81,7 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 	if (napi_complete(napi))
 		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
 
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return 0;
 }
@@ -99,7 +99,7 @@ static int mt7615_poll_rx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 	done = mt76_dma_rx_poll(napi, budget);
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return done;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7c9a55c57578..bd2f42ef5ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -693,7 +693,7 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 	msta->n_rates = i;
 	if (mt76_connac_pm_ref(phy->mt76, &dev->pm)) {
 		mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
-		mt76_connac_pm_unref(&dev->pm);
+		mt76_connac_pm_unref(phy->mt76, &dev->pm);
 	}
 	spin_unlock_bh(&dev->mt76.lock);
 }
@@ -709,7 +709,7 @@ void mt7615_tx_worker(struct mt76_worker *w)
 	}
 
 	mt76_tx_worker_run(&dev->mt76);
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
 static void mt7615_tx(struct ieee80211_hw *hw,
@@ -739,7 +739,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 
 	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
 		mt76_tx(mphy, control->sta, wcid, skb);
-		mt76_connac_pm_unref(&dev->pm);
+		mt76_connac_pm_unref(mphy, &dev->pm);
 		return;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 261cff78de40..a2465b49ecd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -98,7 +98,7 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 	addr = mt7615_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
 
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 63c1d1a68a70..0dfa09902ffd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -117,11 +117,15 @@ mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 }
 
 static inline void
-mt76_connac_pm_unref(struct mt76_connac_pm *pm)
+mt76_connac_pm_unref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
 	spin_lock_bh(&pm->wake.lock);
-	pm->wake.count--;
+
 	pm->last_activity = jiffies;
+	if (--pm->wake.count == 0 &&
+	    test_bit(MT76_STATE_MCU_RUNNING, &phy->state))
+		mt76_connac_power_save_sched(phy, pm);
+
 	spin_unlock_bh(&pm->wake.lock);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 7fca7dc466b8..5e745e9c2185 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -74,7 +74,7 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 	mt7921_tx_cleanup(dev);
 	if (napi_complete(napi))
 		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return 0;
 }
@@ -92,7 +92,7 @@ static int mt7921_poll_rx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 	done = mt76_dma_rx_poll(napi, budget);
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return done;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 84930ad5ebc7..0465b91bda6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -680,7 +680,7 @@ void mt7921_tx_worker(struct mt76_worker *w)
 	}
 
 	mt76_txq_schedule_all(&dev->mphy);
-	mt76_connac_pm_unref(&dev->pm);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
 static void mt7921_tx(struct ieee80211_hw *hw,
@@ -710,7 +710,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 
 	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
 		mt76_tx(mphy, control->sta, wcid, skb);
-		mt76_connac_pm_unref(&dev->pm);
+		mt76_connac_pm_unref(mphy, &dev->pm);
 		return;
 	}
 
-- 
2.31.1

