Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8620BB76
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFZVZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgFZVZx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:53 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038EE20C09;
        Fri, 26 Jun 2020 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206752;
        bh=woDhR3gc+PPlfXpBJSLkqHcY3nS1f3ICCsapV/vjniU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVaT5jojl77636Dj4BkZnk+4gh5bjPccq7Gyttnpg7xRsL1oMCPenHwLUE43AJSBa
         tAm+FlSouA3UwAwjTi0jsNLF4dzWDx68R91UnliKr9rKJ8yl0qR5s2fxhGXBVCLCh6
         sORgEePXFbJQNdGJk9aET5L4Sd8QIYBeMgJO7lVc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 11/17] mt76: mt7615: wake device before pushing frames in mt7615_tx
Date:   Fri, 26 Jun 2020 23:25:11 +0200
Message-Id: <62ced1be6533f90aba09c0136d8e172812d4778e.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Queue frames pushed by mac80211 running mt7615_tx if the device is
low-power state. Run wake workqueue in order to swicth to full-power
before transmitting pending frames

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 25 ++++++++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 56 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index c22878b82540..576c63b2e949 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -448,6 +448,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7615_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7615_pm_wake_work);
 	init_completion(&dev->pm.wake_cmpl);
+	spin_lock_init(&dev->pm.txq_lock);
 	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0a16acf40cf8..8616bac97963 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1836,6 +1836,7 @@ void mt7615_pm_wake_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
 	struct mt76_phy *mphy;
+	int i;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
 						pm.wake_work);
@@ -1846,8 +1847,28 @@ void mt7615_pm_wake_work(struct work_struct *work)
 		goto out;
 	}
 
+	spin_lock_bh(&dev->pm.txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		struct mt7615_sta *msta = dev->pm.tx_q[i].msta;
+		struct mt76_wcid *wcid = msta ? &msta->wcid : NULL;
+		struct ieee80211_sta *sta = NULL;
+
+		if (!dev->pm.tx_q[i].skb)
+			continue;
+
+		if (msta && wcid->sta)
+			sta = container_of((void *)msta, struct ieee80211_sta,
+					   drv_priv);
+
+		mt76_tx(mphy, sta, wcid, dev->pm.tx_q[i].skb);
+		dev->pm.tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&dev->pm.txq_lock);
+
 	tasklet_schedule(&dev->mt76.tx_tasklet);
+
 out:
+	ieee80211_wake_queues(mphy->hw);
 	complete_all(&dev->pm.wake_cmpl);
 }
 
@@ -1871,8 +1892,10 @@ int mt7615_pm_wake(struct mt7615_dev *dev)
 	if (queue_work(dev->mt76.wq, &dev->pm.wake_work))
 		reinit_completion(&dev->pm.wake_cmpl);
 
-	if (!wait_for_completion_timeout(&dev->pm.wake_cmpl, 3 * HZ))
+	if (!wait_for_completion_timeout(&dev->pm.wake_cmpl, 3 * HZ)) {
+		ieee80211_wake_queues(mphy->hw);
 		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9c17026c541d..32f060014bb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -24,6 +24,22 @@ static bool mt7615_dev_running(struct mt7615_dev *dev)
 	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 }
 
+static void mt7615_free_pending_tx_skbs(struct mt7615_dev *dev,
+					struct mt7615_sta *msta)
+{
+	int i;
+
+	spin_lock_bh(&dev->pm.txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		if (msta && dev->pm.tx_q[i].msta != msta)
+			continue;
+
+		dev_kfree_skb(dev->pm.tx_q[i].skb);
+		dev->pm.tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&dev->pm.txq_lock);
+}
+
 static int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -77,6 +93,8 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	cancel_work_sync(&dev->pm.wake_work);
 
+	mt7615_free_pending_tx_skbs(dev, NULL);
+
 	mt7615_mutex_acquire(dev, &dev->mt76.mutex);
 
 	mt76_testmode_reset(&dev->mt76, true);
@@ -215,6 +233,8 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	if (vif == phy->monitor_vif)
 	    phy->monitor_vif = NULL;
 
+	mt7615_free_pending_tx_skbs(dev, msta);
+
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
@@ -592,6 +612,8 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 
+	mt7615_free_pending_tx_skbs(dev, msta);
+
 	mt7615_mcu_sta_add(dev, vif, sta, false);
 	mt7615_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -662,22 +684,43 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct mt7615_sta *msta = NULL;
+	int qid;
 
 	if (control->sta) {
-		struct mt7615_sta *sta;
-
-		sta = (struct mt7615_sta *)control->sta->drv_priv;
-		wcid = &sta->wcid;
+		msta = (struct mt7615_sta *)control->sta->drv_priv;
+		wcid = &msta->wcid;
 	}
 
 	if (vif && !control->sta) {
 		struct mt7615_vif *mvif;
 
 		mvif = (struct mt7615_vif *)vif->drv_priv;
-		wcid = &mvif->sta.wcid;
+		msta = &mvif->sta;
+		wcid = &msta->wcid;
+	}
+
+	if (!test_bit(MT76_STATE_PM, &mphy->state)) {
+		mt76_tx(mphy, control->sta, wcid, skb);
+		return;
+	}
+
+	qid = skb_get_queue_mapping(skb);
+	if (qid >= MT_TXQ_PSD) {
+		qid = IEEE80211_AC_BE;
+		skb_set_queue_mapping(skb, qid);
 	}
 
-	mt76_tx(mphy, control->sta, wcid, skb);
+	spin_lock_bh(&dev->pm.txq_lock);
+	if (!dev->pm.tx_q[qid].skb) {
+		ieee80211_stop_queues(hw);
+		dev->pm.tx_q[qid].msta = msta;
+		dev->pm.tx_q[qid].skb = skb;
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+	} else {
+		dev_kfree_skb(skb);
+	}
+	spin_unlock_bh(&dev->pm.txq_lock);
 }
 
 static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
@@ -1026,6 +1069,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	int err = 0;
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
+	mt7615_free_pending_tx_skbs(dev, NULL);
 
 	mt7615_mutex_acquire(dev, &dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a93ddb1a3def..6da0af628c8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -300,6 +300,12 @@ struct mt7615_dev {
 #endif
 
 	struct {
+		spinlock_t txq_lock;
+		struct {
+			struct mt7615_sta *msta;
+			struct sk_buff *skb;
+		} tx_q[IEEE80211_NUM_ACS];
+
 		struct work_struct wake_work;
 		struct completion wake_cmpl;
 
-- 
2.26.2

