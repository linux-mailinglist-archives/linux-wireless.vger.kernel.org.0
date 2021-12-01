Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C74653B6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351542AbhLARSE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 12:18:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44258 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbhLARSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 12:18:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FC1CB8205D
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 17:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC93C53FAD;
        Wed,  1 Dec 2021 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638378878;
        bh=/CjyHcPeYB1YK0NTivDnJHNtWZS+dxZPjeRtisOz3io=;
        h=From:To:Cc:Subject:Date:From;
        b=jGI+W9OEhGdHD+DrcTG+KUMls3pXs0LIRluJoHiKKm1ZC8h7zIHd9Nco9BqGs1EZ/
         +dbdWkOywG3Zi5tJ/vMSNsTtenX+xjgqPeezVi0smRQmzb5FDInioL2xEPuxp9nJ2D
         hBkuVBocKt62OAR2QzsxAS5v8jJWpmMvOOJPa0wmpnWiq2NYsjdpsXRD+dzdpZdgKk
         FpqZ+iKNtmcoLTVUETm6/MiuE83jugSmPq9Xr4hI8B3wsREJuMIUTdnSGXt2cXnZf2
         CnGzIyTFE/j4f+r07h+Klv5uOmlxBJCKMVqqnzuz5VHqFQzGiTqfssCeXLOU11t++f
         8jz2zLsS4Y1PA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: move sar_capa configuration in common code
Date:   Wed,  1 Dec 2021 18:14:31 +0100
Message-Id: <f7026884beb5158e1f910836a2c574ed7aa5a85e.1638378814.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move wiphy SAR capability configuration in mt76 module and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 20 +++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  7 -------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  8 --------
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index acf400fa8469..20e952cf6e64 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -185,7 +185,6 @@ const struct cfg80211_sar_capa mt76_sar_capa = {
 	.num_freq_ranges = ARRAY_SIZE(mt76_sar_freq_ranges),
 	.freq_ranges = &mt76_sar_freq_ranges[0],
 };
-EXPORT_SYMBOL_GPL(mt76_sar_capa);
 
 static int mt76_led_init(struct mt76_dev *dev)
 {
@@ -393,7 +392,7 @@ mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 	phy->hw->wiphy->bands[band] = NULL;
 }
 
-static void
+static int
 mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 {
 	struct mt76_dev *dev = phy->dev;
@@ -414,6 +413,13 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	wiphy->available_antennas_tx = phy->antenna_mask;
 	wiphy->available_antennas_rx = phy->antenna_mask;
 
+	wiphy->sar_capa = &mt76_sar_capa;
+	phy->frp = devm_kcalloc(dev->dev, wiphy->sar_capa->num_freq_ranges,
+				sizeof(struct mt76_freq_range_power),
+				GFP_KERNEL);
+	if (!phy->frp)
+		return -ENOMEM;
+
 	hw->txq_data_size = sizeof(struct mt76_txq);
 	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
 
@@ -432,6 +438,8 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+
+	return 0;
 }
 
 struct mt76_phy *
@@ -472,7 +480,9 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 {
 	int ret;
 
-	mt76_phy_init(phy, phy->hw);
+	ret = mt76_phy_init(phy, phy->hw);
+	if (ret)
+		return ret;
 
 	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(phy, rates, n_rates);
@@ -591,7 +601,9 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
-	mt76_phy_init(phy, hw);
+	ret = mt76_phy_init(phy, hw);
+	if (ret)
+		return ret;
 
 	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(phy, rates, n_rates);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3acb00840d03..239742112e16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -810,7 +810,6 @@ struct mt76_ethtool_worker_info {
 }
 
 extern struct ieee80211_rate mt76_rates[12];
-extern const struct cfg80211_sar_capa mt76_sar_capa;
 
 #define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
 #define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 06f8fb883ead..dd30f537676d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -174,13 +174,6 @@ int mt76x02_init_device(struct mt76x02_dev *dev)
 	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
-	wiphy->sar_capa = &mt76_sar_capa;
-	dev->mt76.phy.frp = devm_kcalloc(dev->mt76.dev,
-					 wiphy->sar_capa->num_freq_ranges,
-					 sizeof(struct mt76_freq_range_power),
-					 GFP_KERNEL);
-	if (!dev->mt76.phy.frp)
-		return -ENOMEM;
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
 	hw->vif_data_size = sizeof(struct mt76x02_vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index b23067a8326c..ad59ef9839dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -76,14 +76,6 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7921_regd_notifier;
-	wiphy->sar_capa = &mt76_sar_capa;
-
-	phy->mt76->frp = devm_kcalloc(dev->mt76.dev,
-				      wiphy->sar_capa->num_freq_ranges,
-				      sizeof(struct mt76_freq_range_power),
-				      GFP_KERNEL);
-	if (!phy->mt76->frp)
-		return -ENOMEM;
 
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
-- 
2.31.1

