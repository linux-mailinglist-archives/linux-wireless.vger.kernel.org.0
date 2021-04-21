Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558D2366962
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhDUKof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhDUKof (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 702086144E;
        Wed, 21 Apr 2021 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001842;
        bh=YowQMm/ScGUPTMfKlC8NZzEN5xZiYLvlxS5mfG1BTnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sw9L0vsaOnX6QU3QfHBo54eqrIYCIlv/OsFcc3lNvePyYydrB4XLOpJaVBRYZorwa
         1aZT6FOV2GtUGOVpqLRP9mleiIzqQOkhcpyu4qF5IqcUrKRmwXVDcIpCSrRUIz55BS
         lhOcW+noO7Yle3DHxZYd61erDB9JTP7YVsO5K3JJd648hONQHs6gE46gfPJBWXhOqc
         vDUiyQ7Ca0uH53TPo05pBV8ynECh1yDqppfWClLm/tldbsuJgKiT3BJ6CFg6MdY4kI
         FUnlG6a5CsAzU+FO6i2gQbV1ixx7zGxWAwiRMNDAp49Tfkk8URRhcZB8MUOF0cGQTh
         FY3RXG8tDy2AQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 2/4] mt76: mt7663: add awake and doze time accounting
Date:   Wed, 21 Apr 2021 12:43:49 +0200
Message-Id: <f5e16e65b66dc39b204f6961b02f8638224a1071.1619001617.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619001617.git.lorenzo@kernel.org>
References: <cover.1619001617.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7921, introduce awake and doze time accounting
for runtime pm.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 32 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 24 +++++++++++---
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 1b414220521a..676bb22726d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -69,6 +69,7 @@ static int
 mt7615_pm_set(void *data, u64 val)
 {
 	struct mt7615_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
 	int ret = 0;
 
 	if (!mt7615_wait_for_mcu_init(dev))
@@ -77,6 +78,9 @@ mt7615_pm_set(void *data, u64 val)
 	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
 		return -EOPNOTSUPP;
 
+	if (val == pm->enable)
+		return 0;
+
 	mt7615_mutex_acquire(dev);
 
 	if (dev->phy.n_beacon_vif) {
@@ -84,7 +88,11 @@ mt7615_pm_set(void *data, u64 val)
 		goto out;
 	}
 
-	dev->pm.enable = val;
+	if (!pm->enable) {
+		pm->stats.last_wake_event = jiffies;
+		pm->stats.last_doze_event = jiffies;
+	}
+	pm->enable = val;
 out:
 	mt7615_mutex_release(dev);
 
@@ -103,6 +111,26 @@ mt7615_pm_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7615_pm_get, mt7615_pm_set, "%lld\n");
 
+static int
+mt7615_pm_stats(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_connac_pm *pm = &dev->pm;
+	unsigned long awake_time = pm->stats.awake_time;
+	unsigned long doze_time = pm->stats.doze_time;
+
+	if (!test_bit(MT76_STATE_PM, &dev->mphy.state))
+		awake_time += jiffies - pm->stats.last_wake_event;
+	else
+		doze_time += jiffies - pm->stats.last_doze_event;
+
+	seq_printf(s, "awake time: %14u\ndoze time: %15u\n",
+		   jiffies_to_msecs(awake_time),
+		   jiffies_to_msecs(doze_time));
+
+	return 0;
+}
+
 static int
 mt7615_pm_idle_timeout_set(void *data, u64 val)
 {
@@ -515,6 +543,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
+				    mt7615_pm_stats);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7615_radio_read);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 894b2588e075..86341d1f82f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -526,6 +526,8 @@ void mt7615_init_device(struct mt7615_dev *dev)
 
 	mt7615_init_wiphy(hw);
 	dev->pm.idle_timeout = MT7615_PM_TIMEOUT;
+	dev->pm.stats.last_wake_event = jiffies;
+	dev->pm.stats.last_doze_event = jiffies;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 45c6fb5832b8..3c1528ed2110 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -288,6 +288,7 @@ EXPORT_SYMBOL_GPL(mt7622_trigger_hif_int);
 static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_dev *mdev = &dev->mt76;
 	u32 addr;
 	int err;
@@ -317,15 +318,20 @@ static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
+
 	return 0;
 }
 
 static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err = 0;
 
-	mutex_lock(&dev->pm.mutex);
+	mutex_lock(&pm->mutex);
 
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
@@ -344,8 +350,11 @@ static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 	}
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
 out:
-	mutex_unlock(&dev->pm.mutex);
+	mutex_unlock(&pm->mutex);
 
 	return err;
 }
@@ -353,12 +362,13 @@ static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	int err = 0;
 	u32 addr;
 
-	mutex_lock(&dev->pm.mutex);
+	mutex_lock(&pm->mutex);
 
-	if (mt76_connac_skip_fw_pmctrl(mphy, &dev->pm))
+	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
 		goto out;
 
 	mt7622_trigger_hif_int(dev, true);
@@ -375,8 +385,12 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	}
 
 	mt7622_trigger_hif_int(dev, false);
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
 out:
-	mutex_unlock(&dev->pm.mutex);
+	mutex_unlock(&pm->mutex);
 
 	return err;
 }
-- 
2.30.2

