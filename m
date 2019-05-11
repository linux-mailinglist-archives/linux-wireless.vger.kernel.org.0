Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021391A788
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfEKKS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 06:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfEKKS1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 06:18:27 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8372146F;
        Sat, 11 May 2019 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569906;
        bh=DZavJf1n2mJZuYNur/fJSukMQbZjHTtIpfG0gof9g8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8w7IQh/Bsno85bYircrKPqFPqaAATqWVLMUKVn4xJPg0JvyjNKMU3kuEBEWQvAvr
         L9onCmv/ZVkgBCiKcd2v5kB1WEnOXNQrqqPxhbS/cP52k54BJnLiAjEOj+meDQYeBx
         kqVTRUIwoPWqw0tQ+ZImvMYs+jIGKpU/pE7275Zk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 4/4] mt76: mt76x02: run mt76x02_edcca_init atomically in mt76_edcca_set
Date:   Sat, 11 May 2019 12:17:54 +0200
Message-Id: <436469e1a4c1e0c11ae43a0b002378708d31f15d.1557567465.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557567465.git.lorenzo@kernel.org>
References: <cover.1557567465.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt76x02_edcca_init atomically in mt76_edcca_set since it runs
concurrently with calibration work and mt76x2_set_channel.
Introduce __mt76x02_edcca_init helper routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h      |  7 +++++++
 .../net/wireless/mediatek/mt76/mt76x02_debugfs.c  |  6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 -
 .../net/wireless/mediatek/mt76/mt76x2/pci_phy.c   | 15 ++++++++++-----
 .../net/wireless/mediatek/mt76/mt76x2/usb_phy.c   | 15 ++++++++++-----
 8 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 800ebbfc3055..115961a054e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -33,7 +33,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76_rr(dev, MT_CH_IDLE);
 	mt76_rr(dev, MT_CH_BUSY);
 
-	mt76x02_edcca_init(dev);
+	__mt76x02_edcca_init(dev);
 
 	if (mt76_is_mmio(dev)) {
 		mt76x02_dfs_init_params(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f7fd53a1738a..e028c1a4cf88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -268,4 +268,11 @@ mt76x02_rx_get_sta_wcid(struct mt76x02_sta *sta, bool unicast)
 		return &sta->vif->group_wcid;
 }
 
+void __mt76x02_edcca_init(struct mt76x02_dev *dev);
+static inline void mt76x02_edcca_init(struct mt76x02_dev *dev)
+{
+	mutex_lock(&dev->mt76.mutex);
+	__mt76x02_edcca_init(dev);
+	mutex_unlock(&dev->mt76.mutex);
+}
 #endif /* __MT76x02_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 7853078e8ca4..501794a6076b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -122,10 +122,14 @@ mt76_edcca_set(void *data, u64 val)
 	struct mt76x02_dev *dev = data;
 	enum nl80211_dfs_regions region = dev->dfs_pd.region;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	dev->ed_monitor_enabled = !!val;
 	dev->ed_monitor = dev->ed_monitor_enabled &&
 			  region == NL80211_DFS_ETSI;
-	mt76x02_edcca_init(dev);
+	__mt76x02_edcca_init(dev);
+
+	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 84b845647881..e372621c3798 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -887,7 +887,7 @@ mt76x02_dfs_set_domain(struct mt76x02_dev *dev,
 
 		dev->ed_monitor = dev->ed_monitor_enabled &&
 				  region == NL80211_DFS_ETSI;
-		mt76x02_edcca_init(dev);
+		__mt76x02_edcca_init(dev);
 
 		dfs_pd->region = region;
 		mt76x02_dfs_init_params(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index ee4a86971be7..ac29422b5335 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -945,7 +945,7 @@ mt76x02_edcca_tx_enable(struct mt76x02_dev *dev, bool enable)
 	dev->ed_tx_blocked = !enable;
 }
 
-void mt76x02_edcca_init(struct mt76x02_dev *dev)
+void __mt76x02_edcca_init(struct mt76x02_dev *dev)
 {
 	dev->ed_trigger = 0;
 	dev->ed_silent = 0;
@@ -979,7 +979,7 @@ void mt76x02_edcca_init(struct mt76x02_dev *dev)
 	mt76_rr(dev, MT_ED_CCA_TIMER);
 	dev->ed_time = ktime_get_boottime();
 }
-EXPORT_SYMBOL_GPL(mt76x02_edcca_init);
+EXPORT_SYMBOL_GPL(__mt76x02_edcca_init);
 
 #define MT_EDCCA_TH		92
 #define MT_EDCCA_BLOCK_TH	2
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index cb39da79527a..ce73c60c579a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -209,5 +209,4 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 				   struct ieee80211_vif *vif, bool val);
 
-void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index 7a39a390a7ac..818c4f051df3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -43,17 +43,17 @@ mt76x2_phy_tssi_init_cal(struct mt76x02_dev *dev)
 	return true;
 }
 
-static void
+static bool
 mt76x2_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 {
 	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
 	bool is_5ghz = chan->band == NL80211_BAND_5GHZ;
 
 	if (dev->cal.channel_cal_done)
-		return;
+		return false;
 
 	if (mt76x2_channel_silent(dev))
-		return;
+		return false;
 
 	if (!dev->cal.tssi_cal_done)
 		mt76x2_phy_tssi_init_cal(dev);
@@ -74,9 +74,10 @@ mt76x2_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 		mt76x2_mac_resume(dev);
 
 	mt76x2_apply_gain_adj(dev);
-	mt76x02_edcca_init(dev);
 
 	dev->cal.channel_cal_done = true;
+
+	return true;
 }
 
 void mt76x2_phy_set_antenna(struct mt76x02_dev *dev)
@@ -245,6 +246,7 @@ int mt76x2_phy_set_channel(struct mt76x02_dev *dev,
 		return 0;
 
 	mt76x2_phy_channel_calibrate(dev, true);
+	__mt76x02_edcca_init(dev);
 	mt76x02_init_agc_gain(dev);
 
 	/* init default values for temp compensation */
@@ -292,9 +294,12 @@ mt76x2_phy_temp_compensate(struct mt76x02_dev *dev)
 void mt76x2_phy_calibrate(struct work_struct *work)
 {
 	struct mt76x02_dev *dev;
+	bool ret;
 
 	dev = container_of(work, struct mt76x02_dev, cal_work.work);
-	mt76x2_phy_channel_calibrate(dev, false);
+	ret = mt76x2_phy_channel_calibrate(dev, false);
+	if (ret)
+		mt76x02_edcca_init(dev);
 	mt76x2_phy_tssi_compensate(dev);
 	mt76x2_phy_temp_compensate(dev);
 	mt76x2_phy_update_channel_gain(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index c7208c5375ac..2576654f2920 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -18,17 +18,17 @@
 #include "eeprom.h"
 #include "../mt76x02_phy.h"
 
-static void
+static bool
 mt76x2u_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 {
 	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
 	bool is_5ghz = chan->band == NL80211_BAND_5GHZ;
 
 	if (dev->cal.channel_cal_done)
-		return;
+		return false;
 
 	if (mt76x2_channel_silent(dev))
-		return;
+		return false;
 
 	if (!mac_stopped)
 		mt76x2u_mac_stop(dev);
@@ -45,17 +45,21 @@ mt76x2u_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 	if (!mac_stopped)
 		mt76x2_mac_resume(dev);
 	mt76x2_apply_gain_adj(dev);
-	mt76x02_edcca_init(dev);
 
 	dev->cal.channel_cal_done = true;
+
+	return true;
 }
 
 void mt76x2u_phy_calibrate(struct work_struct *work)
 {
 	struct mt76x02_dev *dev;
+	bool ret;
 
 	dev = container_of(work, struct mt76x02_dev, cal_work.work);
-	mt76x2u_phy_channel_calibrate(dev, false);
+	ret = mt76x2u_phy_channel_calibrate(dev, false);
+	if (ret)
+		mt76x02_edcca_init(dev);
 	mt76x2_phy_tssi_compensate(dev);
 	mt76x2_phy_update_channel_gain(dev);
 
@@ -177,6 +181,7 @@ int mt76x2u_phy_set_channel(struct mt76x02_dev *dev,
 		return 0;
 
 	mt76x2u_phy_channel_calibrate(dev, true);
+	__mt76x02_edcca_init(dev);
 	mt76x02_init_agc_gain(dev);
 
 	if (mt76x2_tssi_enabled(dev)) {
-- 
2.20.1

