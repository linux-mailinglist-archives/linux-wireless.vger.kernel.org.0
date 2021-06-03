Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986EE39A238
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFCNcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 09:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFCNcQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 09:32:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16461613E9;
        Thu,  3 Jun 2021 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622727032;
        bh=nHnd7vzh3M8RC1fZNrNRtyhWT47kuzKHbn1QeDwEt+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=lEmr2Z512td2Le9XA0X0ekrs0hkXV+9Gj1rLxIp0328KLzbj+1AP1xqrXSKWtFLCa
         R12KZHYXkSsc3jm+vsR+nj8T3LeD+9eTDVZkeNZ4VmqyJfuDFca9BznRQWKYSRT6Zw
         a2AQODEqSDkyySN/u03Um6xgojD41c3Zsz384wLkd3ku+jgGEtUxTEAn97iCVLgYux
         7EOHLCOaHPtBxitwAnQvj2B6MEjPHqBHlFVJ8HKbxR9Tt8GQdryEvRWjeyqsxoFpoa
         JPSG90kxh4fcfe95d8ndr+ZNJl4GDeX6BAFW6AXOUh55wmL03lQxmN+z+sJYscIkzh
         DxXdcCq0SrnGg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: introduce dedicated control for deep_sleep
Date:   Thu,  3 Jun 2021 15:30:24 +0200
Message-Id: <a0c5992f502b5eca5967de4bc5cfa4533e91a18d.1622726976.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce ds_enable switch to fully control fw deep_sleep capability

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 22 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 ++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 11 ++++++----
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 0dfa09902ffd..2b8f9b5e38f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -45,6 +45,7 @@ enum {
 
 struct mt76_connac_pm {
 	bool enable;
+	bool ds_enable;
 	bool suspended;
 
 	spinlock_t txq_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index b41d70be948b..fe4db4916a4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -248,7 +248,7 @@ mt7921_pm_set(void *data, u64 val)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, mphy->priv);
 
-	mt76_connac_mcu_set_deep_sleep(&dev->mt76, !!pm->enable);
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
 	mt7921_mutex_release(dev);
 
@@ -271,15 +271,31 @@ static int
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
index 59da29032645..be70dd5b4b2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -200,6 +200,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
 	dev->pm.enable = true;
+	dev->pm.ds_enable = true;
 
 	ret = mt7921_init_hardware(dev);
 	if (ret)
@@ -230,7 +231,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.enable);
+	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
 }
 
 void mt7921_unregister_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0465b91bda6d..26dcfb200b4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -815,7 +815,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
-	if (dev->pm.enable) {
+	if (dev->pm.ds_enable) {
 		mt7921_mutex_acquire(dev);
 		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
 		mt7921_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 13263f50dc00..a984f6d43719 100644
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
@@ -300,7 +302,8 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
 
-	if (!dev->pm.enable)
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
-- 
2.31.1

