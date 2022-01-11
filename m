Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A848AA9E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbiAKJe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 04:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiAKJe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 04:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F5C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 01:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659C460EB1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 09:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA9BC36AE9;
        Tue, 11 Jan 2022 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641893667;
        bh=dHqMO0A99U1RXMriAsyuBhLKcr7I05amA5lr2GzBmfw=;
        h=From:To:Cc:Subject:Date:From;
        b=BS3C0WCRzs91wGtXakAUjYEPmyA4uWCe9QzATTEE8Vqw2CRJlZAoCLxcwh1GhC9d+
         LhtzILA5nCMseoCDe2BUGs8ymVlMsxb+FrjNaivND/5Jy2pfPuJddIaYljwhJJW1o6
         N8I6MMemm71TCU3Fxj/YQKtmegkTDcFPG/jT2p3F0OXDNNmRP3or47bO5T3tc+7moW
         2xJsAmBY+4QC77fYdYYdGJsjq2V1MR4VBep5NW68vmCwCY2FtXTNc1PBOU8TKm/UyW
         KDbETsGYlCVk7rwiRpLllNmI15f+ej7dHuDpfiRyeYh9EK2NbkhNgsCOY8Z6BLZHAP
         hMxvSzO2DfoYQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: toggle runtime-pm adding a monitor vif
Date:   Tue, 11 Jan 2022 10:34:17 +0100
Message-Id: <f6ad709b1a64152b5955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toggle runtime-pm and deep-sleep configuration adding/removing
a montior vif in order to forward all tx/rx frames to mac80211.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  8 +++--
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 36 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 ++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 5 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 426adbb56a2d..b353c26b7d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -45,9 +45,11 @@ enum {
 };
 
 struct mt76_connac_pm {
-	bool enable;
-	bool ds_enable;
-	bool suspended;
+	bool enable:1;
+	bool enable_user:1;
+	bool ds_enable:1;
+	bool ds_enable_user:1;
+	bool suspended:1;
 
 	spinlock_t txq_lock;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 45a393070e46..dd04909d980a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -262,14 +262,6 @@ mt7921_txpwr(struct seq_file *s, void *data)
 	return 0;
 }
 
-static void
-mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct mt7921_dev *dev = priv;
-
-	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
-}
-
 static int
 mt7921_pm_set(void *data, u64 val)
 {
@@ -278,10 +270,10 @@ mt7921_pm_set(void *data, u64 val)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (val == pm->enable)
+	if (val == pm->enable_user)
 		goto out;
 
-	if (!pm->enable) {
+	if (!pm->enable_user) {
 		pm->stats.last_wake_event = jiffies;
 		pm->stats.last_doze_event = jiffies;
 	}
@@ -291,12 +283,8 @@ mt7921_pm_set(void *data, u64 val)
 	pm->enable = false;
 	mt76_connac_pm_wake(&dev->mphy, pm);
 
-	pm->enable = val;
-	ieee80211_iterate_active_interfaces(mt76_hw(dev),
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7921_pm_interface_iter, dev);
-
-	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+	pm->enable_user = val;
+	mt7921_set_runtime_pm(dev);
 	mt76_connac_power_save_sched(&dev->mphy, pm);
 out:
 	mutex_unlock(&dev->mt76.mutex);
@@ -309,7 +297,7 @@ mt7921_pm_get(void *data, u64 *val)
 {
 	struct mt7921_dev *dev = data;
 
-	*val = dev->pm.enable;
+	*val = dev->pm.enable_user;
 
 	return 0;
 }
@@ -321,13 +309,17 @@ mt7921_deep_sleep_set(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(dev->mphy.hw->conf.flags & IEEE80211_CONF_MONITOR);
 	bool enable = !!val;
 
 	mt7921_mutex_acquire(dev);
-	if (pm->ds_enable != enable) {
-		mt76_connac_mcu_set_deep_sleep(&dev->mt76, enable);
-		pm->ds_enable = enable;
-	}
+	if (pm->ds_enable_user == enable)
+		goto out;
+
+	pm->ds_enable_user = enable;
+	pm->ds_enable = enable && !monitor;
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+out:
 	mt7921_mutex_release(dev);
 
 	return 0;
@@ -338,7 +330,7 @@ mt7921_deep_sleep_get(void *data, u64 *val)
 {
 	struct mt7921_dev *dev = data;
 
-	*val = dev->pm.ds_enable;
+	*val = dev->pm.ds_enable_user;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ad59ef9839dc..6059d8a0f227 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -229,7 +229,9 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	/* TODO: mt7921s run sleep mode on default  */
 	if (mt76_is_mmio(&dev->mt76)) {
+		dev->pm.enable_user = true;
 		dev->pm.enable = true;
+		dev->pm.ds_enable_user = true;
 		dev->pm.ds_enable = true;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 6073bedaa1c0..92371f3c99a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -469,6 +469,28 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return err;
 }
 
+static void
+mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = priv;
+
+	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
+}
+
+void mt7921_set_runtime_pm(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = dev->mphy.hw;
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	pm->enable = pm->enable_user && !monitor;
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_pm_interface_iter, dev);
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+}
+
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
@@ -502,6 +524,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
 		mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
+		mt7921_set_runtime_pm(dev);
 	}
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8b674e042568..7e763b0d9d40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -456,4 +456,5 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
+void mt7921_set_runtime_pm(struct mt7921_dev *dev);
 #endif
-- 
2.34.1

