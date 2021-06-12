Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7393A4F60
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFLOvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 10:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhFLOvg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 10:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFBA611CD;
        Sat, 12 Jun 2021 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623509377;
        bh=yW2hdt8mHwT1tQi7UQO720udASyfMrVdkWFJ8QSfP1M=;
        h=From:To:Cc:Subject:Date:From;
        b=dOCR7Z0l9JlYbK5WSdl+4l6kV3Kd0HDfAACFyDP/eOQ7DNVxKebWZq/1zBkj/3e0m
         lHtUF1Cw7kXGXwwNPdu6Gw0Aq61u5K9Mtmup1Dt9KZxPcuaqSsd93jXC3EVu/3MD2Q
         CvT5iXYsEIJWutNlR20jmjv3KWt78AsyazoLSr2NPvpPUNm1A+yi8G2yv0WV8CmEKP
         RYpUbI4mxILsdnPMQsBfdZ7U30YOCgY68/KSAL7LYK4CHFJFbhNGJSK0Qx0Fu/4vyI
         +OhR4WulWHaQ6W6RdMhWYxakos8yaIntgMK5x/g2HX3xbbU2KEiixF8WWUL7tC5glO
         0P9sLMB0VMmbA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v2] mt76: mt7921: introduce dedicated control for deep_sleep
Date:   Sat, 12 Jun 2021 16:49:30 +0200
Message-Id: <fd2b9c9b80149668de039c38403f3022e263955e.1623506799.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce ds_enable switch to fully control fw deep_sleep capability

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- fix compilation error
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 22 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 ++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 14 +++++++-----
 5 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 9b3f8d22f17e..93a37ed0c483 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -46,6 +46,7 @@ enum {
 
 struct mt76_connac_pm {
 	bool enable;
+	bool ds_enable;
 	bool suspended;
 
 	spinlock_t txq_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index c8cba1821cd7..77468bdae460 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -251,7 +251,7 @@ mt7921_pm_set(void *data, u64 val)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, mphy->priv);
 
-	mt76_connac_mcu_set_deep_sleep(&dev->mt76, !!pm->enable);
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
 	mt7921_mutex_release(dev);
 
@@ -274,15 +274,31 @@ static int
 mt7921_deep_sleep_set(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool enable = !!val;
 
 	mt7921_mutex_acquire(dev);
-	mt76_connac_mcu_set_deep_sleep(&dev->mt76, !!val);
+	if (pm->ds_enable != enable) {
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, enable);
+		pm->ds_enable = enable;
+	}
 	mt7921_mutex_release(dev);
 
 	return 0;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, NULL, mt7921_deep_sleep_set, "%lld\n");
+static int
+mt7921_deep_sleep_get(void *data, u64 *val)
+{
+	struct mt7921_dev *dev = data;
+
+	*val = dev->pm.ds_enable;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, mt7921_deep_sleep_get,
+			 mt7921_deep_sleep_set, "%lld\n");
 
 static int
 mt7921_pm_stats(struct seq_file *s, void *data)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2caa5096a419..4f2866ded922 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -201,6 +201,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
 	dev->pm.enable = true;
+	dev->pm.ds_enable = true;
 
 	ret = mt7921_init_hardware(dev);
 	if (ret)
@@ -235,7 +236,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.enable);
+	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
 }
 
 void mt7921_unregister_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 873eecd48833..d20532dd4547 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -818,7 +818,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
-	if (dev->pm.enable) {
+	if (dev->pm.ds_enable) {
 		mt7921_mutex_acquire(dev);
 		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
 		mt7921_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 13263f50dc00..22773bb5d1e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -207,8 +207,10 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 			goto restore_suspend;
 	}
 
-	if (!pm->enable)
-		mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
 
 	napi_disable(&mdev->tx_napi);
 	mt76_worker_disable(&mdev->tx_worker);
@@ -251,7 +253,7 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 	napi_enable(&mdev->tx_napi);
 
-	if (!pm->enable)
+	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	if (hif_suspend)
@@ -267,9 +269,10 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err;
 
-	dev->pm.suspended = false;
+	pm->suspended = false;
 	err = pci_set_power_state(pdev, PCI_D0);
 	if (err)
 		return err;
@@ -300,7 +303,8 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
 
-	if (!dev->pm.enable)
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
-- 
2.31.1

