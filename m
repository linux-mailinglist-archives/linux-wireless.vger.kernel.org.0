Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49B20BB7A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgFZV0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgFZV0A (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:26:00 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1AF2145D;
        Fri, 26 Jun 2020 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206759;
        bh=NjCg9TJbrn3aTeEsOUJUIsK0CgtJm+Ne4JBeG0M5ZmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVcUD90K5+z2hKmBLFYrChvfJ9yjGAXqHxDJjh8bv2pHX6sC+H3nEv1tqFs7K20sW
         1S8f4F2cEkq0pmPCOTUkOfr95egTBK0Y6E5ZtnHTX5nwoJfw9r5acXmNc8IF/Opgqs
         vcK8ZroxAS+/xo64cEG6ryDBjXempsLKHRKGwtHs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 15/17] mt76: mt7615: enable beacon hw filter for runtime-pm
Date:   Fri, 26 Jun 2020 23:25:15 +0200
Message-Id: <8c80e5d2071ca6f06b667762a7dc12332267ffdb.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reduce number of received interrupts and power consumption,
enable hw beacon filter if runtime-pm is enabled

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 26 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 19 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  5 ++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d3e3112359e8..e93d229a7887 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1929,8 +1929,31 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 				   MT7615_PM_TIMEOUT);
 }
 
+static void
+mt7615_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7615_phy *phy = priv;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+
+	if (mt7615_mcu_set_bss_pm(dev, vif, dev->pm.enable))
+		return;
+
+	if (dev->pm.enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+}
+
 int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
 {
+	struct mt76_phy *mphy = dev->phy.mt76;
+
 	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
 		return -EOPNOTSUPP;
 
@@ -1940,6 +1963,9 @@ int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
 		goto out;
 
 	dev->pm.enable = enable;
+	ieee80211_iterate_active_interfaces(mphy->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_pm_interface_iter, mphy->priv);
 	if (!enable)
 		cancel_delayed_work_sync(&dev->pm.ps_work);
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3ab8e7e9be44..0bc38472cf0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -209,6 +209,18 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ret = mt7615_mcu_add_dev_info(dev, vif, true);
+	if (ret)
+		goto out;
+
+	if (dev->pm.enable) {
+		ret = mt7615_mcu_set_bss_pm(dev, vif, true);
+		if (ret)
+			goto out;
+
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
 out:
 	mt7615_mutex_release(dev, &dev->mt76.mutex);
 
@@ -235,6 +247,13 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_free_pending_tx_skbs(dev, msta);
 
+	if (dev->pm.enable) {
+		bool ext_phy = phy != &dev->phy;
+
+		mt7615_mcu_set_bss_pm(dev, vif, false);
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 874b6571a679..293799263412 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -3581,9 +3581,8 @@ int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
 
-static int
-mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		      bool enable)
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 02282b1a00b0..9591dedee416 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -642,6 +642,8 @@ int mt7615_driver_own(struct mt7615_dev *dev);
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
-- 
2.26.2

