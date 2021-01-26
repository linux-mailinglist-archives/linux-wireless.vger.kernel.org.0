Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F46303B50
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 12:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392185AbhAZLRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 06:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392108AbhAZLPg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 06:15:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B9F82311C;
        Tue, 26 Jan 2021 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611659660;
        bh=muLsAL8p5CKlpKroOjyCslIuCq9zvz9bumcaxRRSpII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNcc0IP0RfOGyGiAVvQbLT5mxkDSSVgGqdTDfm5qnuaRfU4pSz5MLHGC+JwHyEiIC
         IZoXzK45c9bnfzZcOUTfIgoHetOlZQbpRD1VHAWwI+jo107qQxee0huN64HtK+Jw8d
         h4vNAE/nT3V3JD/3gn3DeJY9QUFeK5mWEU7X1to+gWpsil3l9gv8RqqDPiako9+N1O
         8r0dQLSQIZbMm/1p3MxmfQKcBQGhsBd//NxNbrOBtHT9GHGkzUHMqWaVljaxQlMEcO
         eBhJ9w772TNZnziFN6z6tQ5WyLji/t+4ozxdIZYgleNOlkCs3UX7AkTYlFQtIFmJpx
         HVEE1kClE8KYQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v3 6/6] mt76: mt76_connac: move pm utility routines in mt76_connac_lib module
Date:   Tue, 26 Jan 2021 12:13:56 +0100
Message-Id: <dd8559262ffb5f24b319f8d7259ff5ffbc9b43ca.1611659413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611659413.git.lorenzo@kernel.org>
References: <cover.1611659413.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move power_save common code shared between mt7663 and mt7921 in
mt76_connac module

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  87 +------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  62 +++------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  19 +--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  29 +++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 119 ++++++++++++++++++
 7 files changed, 177 insertions(+), 143 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index fd0a124335a0..eac419c64788 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -27,7 +27,7 @@ mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
 
 mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 
-mt76-connac-lib-y := mt76_connac_mcu.o
+mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 904a8348f94b..6a3e1a609852 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1465,7 +1465,7 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	mt7615_mac_sta_poll(dev);
 	rcu_read_unlock();
 
-	mt7615_pm_power_save_sched(dev);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
@@ -1789,11 +1789,11 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
-	if (mt7615_pm_wake(dev))
+	if (mt76_connac_pm_wake(&dev->mphy, &dev->pm))
 		return;
 
 	__mt7615_update_channel(dev);
-	mt7615_pm_power_save_sched(dev);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 EXPORT_SYMBOL_GPL(mt7615_update_channel);
 
@@ -1862,95 +1862,20 @@ void mt7615_pm_wake_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
 	struct mt76_phy *mphy;
-	int i;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
-	if (mt7615_mcu_set_drv_ctrl(dev)) {
+	if (!mt7615_mcu_set_drv_ctrl(dev))
+		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+	else
 		dev_err(mphy->dev->dev, "failed to wake device\n");
-		goto out;
-	}
-
-	spin_lock_bh(&dev->pm.txq_lock);
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		struct mt76_wcid *wcid = dev->pm.tx_q[i].wcid;
-		struct ieee80211_sta *sta = NULL;
-
-		if (!dev->pm.tx_q[i].skb)
-			continue;
-
-		if (wcid && wcid->sta)
-			sta = container_of((void *)wcid, struct ieee80211_sta,
-					   drv_priv);
-
-		mt76_tx(mphy, sta, wcid, dev->pm.tx_q[i].skb);
-		dev->pm.tx_q[i].skb = NULL;
-	}
-	spin_unlock_bh(&dev->pm.txq_lock);
-
-	mt76_worker_schedule(&dev->mt76.tx_worker);
 
-out:
 	ieee80211_wake_queues(mphy->hw);
 	complete_all(&dev->pm.wake_cmpl);
 }
 
-int mt7615_pm_wake(struct mt7615_dev *dev)
-{
-	struct mt76_phy *mphy = dev->phy.mt76;
-
-	if (!mt7615_firmware_offload(dev))
-		return 0;
-
-	if (!mt76_is_mmio(mphy->dev))
-		return 0;
-
-	if (!test_bit(MT76_STATE_PM, &mphy->state))
-		return 0;
-
-	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
-	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
-		return 0;
-
-	if (queue_work(dev->mt76.wq, &dev->pm.wake_work))
-		reinit_completion(&dev->pm.wake_cmpl);
-
-	if (!wait_for_completion_timeout(&dev->pm.wake_cmpl, 3 * HZ)) {
-		ieee80211_wake_queues(mphy->hw);
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mt7615_pm_wake);
-
-void mt7615_pm_power_save_sched(struct mt7615_dev *dev)
-{
-	struct mt76_phy *mphy = dev->phy.mt76;
-
-	if (!mt7615_firmware_offload(dev))
-		return;
-
-	if (!mt76_is_mmio(mphy->dev))
-		return;
-
-	if (!dev->pm.enable || !test_bit(MT76_STATE_RUNNING, &mphy->state))
-		return;
-
-	dev->pm.last_activity = jiffies;
-
-	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
-	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
-		return;
-
-	if (!test_bit(MT76_STATE_PM, &mphy->state))
-		queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work,
-				   dev->pm.idle_timeout);
-}
-EXPORT_SYMBOL_GPL(mt7615_pm_power_save_sched);
-
 void mt7615_pm_power_save_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 5a6c96dfbbd7..25faf486d279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -24,22 +24,6 @@ static bool mt7615_dev_running(struct mt7615_dev *dev)
 	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 }
 
-static void mt7615_free_pending_tx_skbs(struct mt7615_dev *dev,
-					struct mt7615_sta *msta)
-{
-	int i;
-
-	spin_lock_bh(&dev->pm.txq_lock);
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		if (msta && dev->pm.tx_q[i].wcid != &msta->wcid)
-			continue;
-
-		dev_kfree_skb(dev->pm.tx_q[i].skb);
-		dev->pm.tx_q[i].skb = NULL;
-	}
-	spin_unlock_bh(&dev->pm.txq_lock);
-}
-
 static int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -95,7 +79,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	cancel_work_sync(&dev->pm.wake_work);
 
-	mt7615_free_pending_tx_skbs(dev, NULL);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt7615_mutex_acquire(dev);
 
@@ -258,7 +242,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	if (vif == phy->monitor_vif)
 	    phy->monitor_vif = NULL;
 
-	mt7615_free_pending_tx_skbs(dev, msta);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 
 	mt7615_mac_set_beacon_filter(phy, vif, false);
 	mt7615_mcu_add_dev_info(phy, vif, false);
@@ -581,6 +565,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_phy *phy;
 	int idx, err;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
@@ -593,21 +578,18 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.ext_phy = mvif->mt76.band_idx;
 
-	err = mt7615_pm_wake(dev);
+	phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+	err = mt76_connac_pm_wake(phy->mt76, &dev->pm);
 	if (err)
 		return err;
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		struct mt7615_phy *phy;
-
-		phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt7615_mcu_add_bss_info(phy, vif, sta, true);
-	}
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	mt7615_mcu_sta_add(&dev->phy, vif, sta, true);
 
-	mt7615_pm_power_save_sched(dev);
+	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
 
 	return 0;
 }
@@ -618,27 +600,26 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_phy *phy;
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 
-	mt7615_free_pending_tx_skbs(dev, msta);
-	mt7615_pm_wake(dev);
+	phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+	mt76_connac_pm_wake(phy->mt76, &dev->pm);
 
 	mt7615_mcu_sta_add(&dev->phy, vif, sta, false);
 	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-		struct mt7615_phy *phy;
-
-		phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt7615_mcu_add_bss_info(phy, vif, sta, false);
-	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 
-	mt7615_pm_power_save_sched(dev);
+	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_sta_remove);
 
@@ -723,16 +704,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 		skb_set_queue_mapping(skb, qid);
 	}
 
-	spin_lock_bh(&dev->pm.txq_lock);
-	if (!dev->pm.tx_q[qid].skb) {
-		ieee80211_stop_queues(hw);
-		dev->pm.tx_q[qid].wcid = wcid;
-		dev->pm.tx_q[qid].skb = skb;
-		queue_work(dev->mt76.wq, &dev->pm.wake_work);
-	} else {
-		dev_kfree_skb(skb);
-	}
-	spin_unlock_bh(&dev->pm.txq_lock);
+	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
 }
 
 static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
@@ -1120,7 +1092,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	int err = 0;
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
-	mt7615_free_pending_tx_skbs(dev, NULL);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt7615_mutex_acquire(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 35fa2104a91f..1bd79dae0171 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -382,8 +382,6 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
 void mt7615_pm_wake_work(struct work_struct *work);
-int mt7615_pm_wake(struct mt7615_dev *dev);
-void mt7615_pm_power_save_sched(struct mt7615_dev *dev);
 void mt7615_pm_power_save_work(struct work_struct *work);
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
@@ -439,19 +437,10 @@ static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
 		return MT7615_WTBL_SIZE;
 }
 
-static inline void mt7615_mutex_acquire(struct mt7615_dev *dev)
-	 __acquires(&dev->mt76.mutex)
-{
-	mutex_lock(&dev->mt76.mutex);
-	mt7615_pm_wake(dev);
-}
-
-static inline void mt7615_mutex_release(struct mt7615_dev *dev)
-	__releases(&dev->mt76.mutex)
-{
-	mt7615_pm_power_save_sched(dev);
-	mutex_unlock(&dev->mt76.mutex);
-}
+#define mt7615_mutex_acquire(dev)	\
+	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
+#define mt7615_mutex_release(dev)	\
+	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
 static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 5ac4193b770c..71487f532f36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -76,7 +76,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	bool hif_suspend;
 	int i, err;
 
-	err = mt7615_pm_wake(dev);
+	err = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index a20dc558e8f5..15a7b0a06053 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -59,4 +59,33 @@ struct mt76_connac_pm {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
+int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
+void mt76_connac_power_save_sched(struct mt76_phy *phy,
+				  struct mt76_connac_pm *pm);
+void mt76_connac_free_pending_tx_skbs(struct mt76_connac_pm *pm,
+				      struct mt76_wcid *wcid);
+
+static inline void
+mt76_connac_mutex_acquire(struct mt76_dev *dev, struct mt76_connac_pm *pm)
+	__acquires(&dev->mutex)
+{
+	mutex_lock(&dev->mutex);
+	mt76_connac_pm_wake(&dev->phy, pm);
+}
+
+static inline void
+mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
+	__releases(&dev->mutex)
+{
+	mt76_connac_power_save_sched(&dev->phy, pm);
+	mutex_unlock(&dev->mutex);
+}
+
+void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
+			      struct mt76_connac_pm *pm,
+			      struct mt76_wcid *wcid,
+			      struct sk_buff *skb);
+void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
+				 struct mt76_connac_pm *pm);
+
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
new file mode 100644
index 000000000000..c5f5037f5757
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt76_connac.h"
+
+int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (!pm->enable)
+		return 0;
+
+	if (!mt76_is_mmio(dev))
+		return 0;
+
+	if (!test_bit(MT76_STATE_PM, &phy->state))
+		return 0;
+
+	if (test_bit(MT76_HW_SCANNING, &phy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &phy->state))
+		return 0;
+
+	if (queue_work(dev->wq, &pm->wake_work))
+		reinit_completion(&pm->wake_cmpl);
+
+	if (!wait_for_completion_timeout(&pm->wake_cmpl, 3 * HZ)) {
+		ieee80211_wake_queues(phy->hw);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_wake);
+
+void mt76_connac_power_save_sched(struct mt76_phy *phy,
+				  struct mt76_connac_pm *pm)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (!mt76_is_mmio(dev))
+		return;
+
+	if (!pm->enable || !test_bit(MT76_STATE_RUNNING, &phy->state))
+		return;
+
+	pm->last_activity = jiffies;
+
+	if (test_bit(MT76_HW_SCANNING, &phy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &phy->state))
+		return;
+
+	if (!test_bit(MT76_STATE_PM, &phy->state))
+		queue_delayed_work(dev->wq, &pm->ps_work, pm->idle_timeout);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_power_save_sched);
+
+void mt76_connac_free_pending_tx_skbs(struct mt76_connac_pm *pm,
+				      struct mt76_wcid *wcid)
+{
+	int i;
+
+	spin_lock_bh(&pm->txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		if (wcid && pm->tx_q[i].wcid != wcid)
+			continue;
+
+		dev_kfree_skb(pm->tx_q[i].skb);
+		pm->tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&pm->txq_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_free_pending_tx_skbs);
+
+void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
+			      struct mt76_connac_pm *pm,
+			      struct mt76_wcid *wcid,
+			      struct sk_buff *skb)
+{
+	int qid = skb_get_queue_mapping(skb);
+	struct mt76_phy *phy = hw->priv;
+
+	spin_lock_bh(&pm->txq_lock);
+	if (!pm->tx_q[qid].skb) {
+		ieee80211_stop_queues(hw);
+		pm->tx_q[qid].wcid = wcid;
+		pm->tx_q[qid].skb = skb;
+		queue_work(phy->dev->wq, &pm->wake_work);
+	} else {
+		dev_kfree_skb(skb);
+	}
+	spin_unlock_bh(&pm->txq_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_queue_skb);
+
+void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
+				 struct mt76_connac_pm *pm)
+{
+	int i;
+
+	spin_lock_bh(&pm->txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		struct mt76_wcid *wcid = pm->tx_q[i].wcid;
+		struct ieee80211_sta *sta = NULL;
+
+		if (!pm->tx_q[i].skb)
+			continue;
+
+		if (wcid && wcid->sta)
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+
+		mt76_tx(phy, sta, wcid, pm->tx_q[i].skb);
+		pm->tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&pm->txq_lock);
+
+	mt76_worker_schedule(&phy->dev->tx_worker);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_dequeue_skbs);
-- 
2.29.2

