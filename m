Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5834D45797D
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Nov 2021 00:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhKSXZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 18:25:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34952 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230351AbhKSXZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 18:25:20 -0500
X-UUID: a79e7ef5bdc14dbbb313a66106faefcf-20211120
X-UUID: a79e7ef5bdc14dbbb313a66106faefcf-20211120
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 737905656; Sat, 20 Nov 2021 07:22:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 20 Nov 2021 07:22:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Nov 2021 07:22:13 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] mt76: mt7921: move mt76_connac_mcu_set_hif_suspend to bus-related files
Date:   Sat, 20 Nov 2021 07:22:10 +0800
Message-ID: <92851c34c3758b7d50f3eaa24b1a27adccde2b1a.1637363831.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch for the following patch
("mt76: mt7921s: fix the device cannot sleep deeply in suspend).

mt76_connac_mcu_set_hif_suspend eventually would be handled in each
bus-level suspend/resume handler in either mt7921/sdio.c or mt7921/pci.c
depending on what type of the bus the device is running on. We can move
mt76_connac_mcu_set_hif_suspend to bus-related files to simplify the logic.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c   | 13 ++-----------
 .../net/wireless/mediatek/mt76/mt7921/pci.c    | 18 +++++-------------
 .../net/wireless/mediatek/mt76/mt7921/sdio.c   | 18 +++++-------------
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b144f5491798..e022251b4006 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1232,7 +1232,6 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	int err;
 
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -1250,25 +1249,18 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 					    mt76_connac_mcu_set_suspend_iter,
 					    &dev->mphy);
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
-
 	mt7921_mutex_release(dev);
 
-	return err;
+	return 0;
 }
 
 static int mt7921_resume(struct ieee80211_hw *hw)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	int err;
 
 	mt7921_mutex_acquire(dev);
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
-	if (err < 0)
-		goto out;
-
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	clear_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
@@ -1278,11 +1270,10 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
-out:
 
 	mt7921_mutex_release(dev);
 
-	return err;
+	return 0;
 }
 
 static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 305b63fa1a8a..c29dde23d4ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -235,7 +235,6 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
-	bool hif_suspend;
 	int i, err;
 
 	pm->suspended = true;
@@ -246,12 +245,9 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (err < 0)
 		goto restore_suspend;
 
-	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
-	if (hif_suspend) {
-		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
-		if (err)
-			goto restore_suspend;
-	}
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	if (err)
+		goto restore_suspend;
 
 	/* always enable deep sleep during suspend to reduce
 	 * power consumption
@@ -302,8 +298,7 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
-	if (hif_suspend)
-		mt76_connac_mcu_set_hif_suspend(mdev, false);
+	mt76_connac_mcu_set_hif_suspend(mdev, false);
 
 restore_suspend:
 	pm->suspended = false;
@@ -356,10 +351,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
-	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
-		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
-
-	return err;
+	return mt76_connac_mcu_set_hif_suspend(mdev, false);
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index ddf0eeb8b688..5fee489c7a99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -203,7 +203,6 @@ static int mt7921s_suspend(struct device *__dev)
 	struct mt7921_dev *dev = sdio_get_drvdata(func);
 	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_dev *mdev = &dev->mt76;
-	bool hif_suspend;
 	int err;
 
 	pm->suspended = true;
@@ -214,12 +213,9 @@ static int mt7921s_suspend(struct device *__dev)
 	if (err < 0)
 		goto restore_suspend;
 
-	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
-	if (hif_suspend) {
-		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
-		if (err)
-			goto restore_suspend;
-	}
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	if (err)
+		goto restore_suspend;
 
 	/* always enable deep sleep during suspend to reduce
 	 * power consumption
@@ -253,8 +249,7 @@ static int mt7921s_suspend(struct device *__dev)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
-	if (hif_suspend)
-		mt76_connac_mcu_set_hif_suspend(mdev, false);
+	mt76_connac_mcu_set_hif_suspend(mdev, false);
 
 restore_suspend:
 	pm->suspended = false;
@@ -285,10 +280,7 @@ static int mt7921s_resume(struct device *__dev)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
-	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
-		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
-
-	return err;
+	return mt76_connac_mcu_set_hif_suspend(mdev, false);
 }
 
 static const struct dev_pm_ops mt7921s_pm_ops = {
-- 
2.25.1

