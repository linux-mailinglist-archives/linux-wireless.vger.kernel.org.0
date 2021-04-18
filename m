Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208263636CD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhDRQqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236006AbhDRQqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A766135B;
        Sun, 18 Apr 2021 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764379;
        bh=5bD7zNhNiaEj6SrRbnCF6ioX6j2dwQ37ChWFzXOCbaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHf3gORb6/QkElXS0lGekCypnWsBKYzlkHe98qXmIrwRfbovRMFMwOfo85nQ2DlBt
         E1hbeHHP7HANORjf3/HLz/oDHipvelqFcZE5ILgQhpnI43iKmwOjZ8nYpEtwsqW4m4
         7QyFRKMhy8FxfjXeqSsydoPPWdqyJuyLwqLV1QmsLkGAfPPfYsueLmr9N/YYz6pGvc
         rax9qbDDSheWuSH6C7DaY77KPXsV3u0wHzbxxgGyXUVRHlOdMK7zoFwE9z3mj/mYeI
         XDBbrC1c7mgHefwLH0mTB/kcf7iGL5MyDqVEo+KOzudxS9xuVrWvsxz6YdZLncYxxs
         QJYXvKWIdxlmA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 18/19] mt76: mt7921: add awake and doze time accounting
Date:   Sun, 18 Apr 2021 18:45:44 +0200
Message-Id: <4834194c31eacec6ed555319c7300ff2cebd296d.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce awake and doze time accounting for runtime pm.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  6 ++++
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 32 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  5 ++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 19 ++++++++---
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index e3937f6d3640..9e61c107c640 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -64,6 +64,12 @@ struct mt76_connac_pm {
 	struct delayed_work ps_work;
 	unsigned long last_activity;
 	unsigned long idle_timeout;
+	struct {
+		unsigned long last_wake_event;
+		unsigned long awake_time;
+		unsigned long last_doze_event;
+		unsigned long doze_time;
+	} stats;
 };
 
 struct mt76_connac_coredump {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 5a54cd8d2ce4..f3982578cc56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -230,11 +230,19 @@ static int
 mt7921_pm_set(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
+	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_phy *mphy = dev->phy.mt76;
 
+	if (val == pm->enable)
+		return 0;
+
 	mt7921_mutex_acquire(dev);
 
-	dev->pm.enable = val;
+	if (!pm->enable) {
+		pm->stats.last_wake_event = jiffies;
+		pm->stats.last_doze_event = jiffies;
+	}
+	pm->enable = val;
 
 	ieee80211_iterate_active_interfaces(mphy->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -256,6 +264,26 @@ mt7921_pm_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n");
 
+static int
+mt7921_pm_stats(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
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
 mt7921_pm_idle_timeout_set(void *data, u64 val)
 {
@@ -322,6 +350,8 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
 	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
+				    mt7921_pm_stats);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2d8dba000d0b..cec17a249a8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -239,12 +239,15 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
 
+	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
+	dev->pm.stats.last_wake_event = jiffies;
+	dev->pm.stats.last_doze_event = jiffies;
+
 	ret = mt7921_init_hardware(dev);
 	if (ret)
 		return ret;
 
 	mt7921_init_wiphy(hw);
-	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->mphy.sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1204f5d324f8..c00295b63ba8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1267,9 +1267,10 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err = 0;
 
-	mutex_lock(&dev->pm.mutex);
+	mutex_lock(&pm->mutex);
 
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
@@ -1288,8 +1289,11 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	}
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
+	pm->stats.last_wake_event = jiffies;
+	pm->stats.doze_time += pm->stats.last_wake_event -
+			       pm->stats.last_doze_event;
 out:
-	mutex_unlock(&dev->pm.mutex);
+	mutex_unlock(&pm->mutex);
 
 	if (err)
 		mt7921_reset(&dev->mt76);
@@ -1300,11 +1304,12 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err = 0;
 
-	mutex_lock(&dev->pm.mutex);
+	mutex_lock(&pm->mutex);
 
-	if (mt76_connac_skip_fw_pmctrl(mphy, &dev->pm))
+	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
 		goto out;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
@@ -1319,8 +1324,12 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 		clear_bit(MT76_STATE_PM, &mphy->state);
 		err = -EIO;
 	}
+
+	pm->stats.last_doze_event = jiffies;
+	pm->stats.awake_time += pm->stats.last_doze_event -
+				pm->stats.last_wake_event;
 out:
-	mutex_unlock(&dev->pm.mutex);
+	mutex_unlock(&pm->mutex);
 
 	if (err)
 		mt7921_reset(&dev->mt76);
-- 
2.30.2

