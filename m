Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A839A379A18
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEJWa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 18:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhEJWay (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 18:30:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1287361581;
        Mon, 10 May 2021 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685789;
        bh=P76/1MMWh4HZqIQTVVGkmFQftzTWoXSf7yPpB+C4i/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp2Cw6c73poizpJZe/4ErwgmMyw0krtLwE/Ee/KHNTv3dKLBqKTpNhqrhGxr3hHOl
         UpoA+afgMqbPJiThTPCjShqpAy2VdmZgSfNBvXBrGKd/hLbhlgZNZ/jvl03TDKJL/m
         yrsgWDBYtTgS6ijEMLy+WFYsBJAE6J0z+m/OjFFwAOkBx9dWo9Jv3bTloJl3zSt889
         ojiNxQ0MLhJDEsudB3uDPGCm7amBgCrI3JE0325BZfdPwh9XjTv1aFOrx8fYSbfghn
         N72BEvlJtcSn6c/wGe8e0354DxFWtT2KiCxtrMu8e5xCkaV/bJ0tm+cX7uG/TIp2yw
         CUG4BSoKrSkFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 5/5] mt76: mt7615: set macwork timeout according to runtime-pm
Date:   Tue, 11 May 2021 00:29:24 +0200
Message-Id: <7ccfbf127354bc4552fc76959a3f57e3e3c685de.1620685619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620685619.git.lorenzo@kernel.org>
References: <cover.1620685619.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set macwork timeout value according to runtime-pm in order to reduce
power consumption

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c    | 15 +++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/main.c   | 18 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h |  7 ++++++-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c    |  7 ++++---
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 12c628bb200e..afcb71699c41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1918,9 +1918,14 @@ void mt7615_pm_wake_work(struct work_struct *work)
 			mt76_queue_tx_cleanup(dev, mdev->q_mcu[MT_MCUQ_WM],
 					      false);
 		}
-		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state)) {
+			unsigned long timeout;
+
+			timeout = mt7615_get_macwork_timeout(dev);
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-						     MT7615_WATCHDOG_TIME);
+						     timeout);
+		}
 	}
 
 	ieee80211_wake_queues(mphy->hw);
@@ -1955,6 +1960,7 @@ void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
 	struct mt76_phy *mphy;
+	unsigned long timeout;
 
 	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
 					       mac_work.work);
@@ -1973,8 +1979,9 @@ void mt7615_mac_work(struct work_struct *work)
 	mt7615_mutex_release(phy->dev);
 
 	mt76_tx_status_check(mphy->dev, NULL, false);
-	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-				     MT7615_WATCHDOG_TIME);
+
+	timeout = mt7615_get_macwork_timeout(phy->dev);
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work, timeout);
 }
 
 void mt7615_tx_token_put(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index faae60775b16..827f19727f3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -28,6 +28,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	unsigned long timeout;
 	bool running;
 	int ret;
 
@@ -78,8 +79,8 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
-				     MT7615_WATCHDOG_TIME);
+	timeout = mt7615_get_macwork_timeout(dev);
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work, timeout);
 
 	if (!running)
 		mt7615_mac_reset_counters(dev);
@@ -352,10 +353,12 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mutex_release(dev);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
-	if (!mt76_testmode_enabled(phy->mt76))
+	if (!mt76_testmode_enabled(phy->mt76)) {
+		unsigned long timeout = mt7615_get_macwork_timeout(dev);
+
 		ieee80211_queue_delayed_work(phy->mt76->hw,
-					     &phy->mt76->mac_work,
-					     MT7615_WATCHDOG_TIME);
+					     &phy->mt76->mac_work, timeout);
+	}
 
 	return ret;
 }
@@ -1200,6 +1203,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	unsigned long timeout;
 	bool running;
 
 	mt7615_mutex_acquire(dev);
@@ -1223,8 +1227,8 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 					    mt76_connac_mcu_set_suspend_iter,
 					    phy->mt76);
 
-	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
-				     MT7615_WATCHDOG_TIME);
+	timeout = mt7615_get_macwork_timeout(dev);
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work, timeout);
 
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2ba86bd96a31..1e0f6a0f8c66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -20,7 +20,6 @@
 					 MT7615_MAX_INTERFACES)
 
 #define MT7615_PM_TIMEOUT		(HZ / 12)
-#define MT7615_WATCHDOG_TIME		(HZ / 10)
 #define MT7615_HW_SCAN_TIMEOUT		(HZ / 10)
 #define MT7615_RESET_TIMEOUT		(30 * HZ)
 #define MT7615_RATE_RETRY		2
@@ -460,6 +459,12 @@ static inline u32 mt7615_tx_mcu_int_mask(struct mt7615_dev *dev)
 	return MT_INT_TX_DONE(dev->mt76.q_mcu[MT_MCUQ_WM]->hw_idx);
 }
 
+static inline unsigned long
+mt7615_get_macwork_timeout(struct mt7615_dev *dev)
+{
+	return dev->pm.enable ? HZ / 3 : HZ / 10;
+}
+
 void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_roc_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index cc278d8cb888..da87c02a73eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -268,6 +268,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	struct mt7615_phy *phy2;
 	struct mt76_phy *ext_phy;
 	struct mt7615_dev *dev;
+	unsigned long timeout;
 
 	dev = container_of(work, struct mt7615_dev, reset_work);
 	ext_phy = dev->mt76.phy2;
@@ -345,11 +346,11 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_mutex_release(dev);
 
+	timeout = mt7615_get_macwork_timeout(dev);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
-				     MT7615_WATCHDOG_TIME);
+				     timeout);
 	if (phy2)
 		ieee80211_queue_delayed_work(ext_phy->hw,
-					     &phy2->mt76->mac_work,
-					     MT7615_WATCHDOG_TIME);
+					     &phy2->mt76->mac_work, timeout);
 
 }
-- 
2.31.1

