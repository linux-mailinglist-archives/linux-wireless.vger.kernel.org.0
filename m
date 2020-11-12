Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F512B0263
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgKLJ5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 04:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgKLJ5V (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:21 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E92221FE;
        Thu, 12 Nov 2020 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175040;
        bh=5JYKwMY5BmcyNHZfuMmRn9Fhj2NNPu7iDNaROQYqlaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6wpur8OeT1RfZhGR/ZMGeKf8SXaMAVdq3UjHxlihTBp4NnTBwv8r70bAFMLEJto+
         5GDqo9bkX6C6zU7zNVXkibim9I6JZir+oePTlUfeq+T5vcG8VE7fwNR5h/1DpX1CdO
         jiRnPcDDmLHC4nCSNwxMy7pu519Nqr7a7KwG1rgw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH 1/6] mt76: move band capabilities in mt76_phy
Date:   Thu, 12 Nov 2020 10:56:56 +0100
Message-Id: <8148fc69c41b1fddfc61f0b80660c49916b0af73.1605173301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605173301.git.lorenzo@kernel.org>
References: <cover.1605173301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move properly support mt7915 dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/eeprom.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c   | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt76x0/eeprom.c   |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c  |  8 ++++----
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c   |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/init.c |  5 ++---
 11 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0fc090283f80..28c247c0e0cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -159,9 +159,9 @@ static void mt76_init_stream_cap(struct mt76_phy *phy,
 
 void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 {
-	if (phy->dev->cap.has_2ghz)
+	if (phy->cap.has_2ghz)
 		mt76_init_stream_cap(phy, &phy->sband_2g.sband, false);
-	if (phy->dev->cap.has_5ghz)
+	if (phy->cap.has_5ghz)
 		mt76_init_stream_cap(phy, &phy->sband_5g.sband, vht);
 }
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
@@ -461,13 +461,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	dev_set_drvdata(dev->dev, dev);
 	mt76_phy_init(dev, hw);
 
-	if (dev->cap.has_2ghz) {
+	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(dev, rates, n_rates);
 		if (ret)
 			return ret;
 	}
 
-	if (dev->cap.has_5ghz) {
+	if (phy->cap.has_5ghz) {
 		ret = mt76_init_sband_5g(dev, rates + 4, n_rates - 4, vht);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 17392f250716..3239a99a94d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -569,6 +569,7 @@ struct mt76_phy {
 	struct mt76_channel_state *chan_state;
 	ktime_t survey_time;
 
+	struct mt76_hw_cap cap;
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 
@@ -638,7 +639,6 @@ struct mt76_dev {
 
 	struct debugfs_blob_wrapper eeprom;
 	struct debugfs_blob_wrapper otp;
-	struct mt76_hw_cap cap;
 
 	struct mt76_rate_power rate_power;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 9d5042affcd1..2cd97228e280 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -171,7 +171,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	}
 
 	eeprom = (u8 *)dev->mt76.eeprom.data;
-	dev->mt76.cap.has_2ghz = true;
+	dev->mphy.cap.has_2ghz = true;
 	memcpy(dev->mt76.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
 
 	/* Check for 1SS devices */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index d3033ebaade6..25e3069cf2b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -183,7 +183,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	int ret;
 
 	/* Increase buffer size to receive large VHT MPDUs */
-	if (dev->mt76.cap.has_5ghz)
+	if (dev->mphy.cap.has_5ghz)
 		rx_buf_size *= 2;
 
 	mt76_dma_attach(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index f4756bb946c3..67f7a1ed9258 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -99,20 +99,20 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 
 	if (is_mt7663(&dev->mt76)) {
 		/* dual band */
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
 	if (is_mt7622(&dev->mt76)) {
 		/* 2GHz only */
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		return;
 	}
 
 	if (is_mt7611(&dev->mt76)) {
 		/* 5GHz only */
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
@@ -120,17 +120,17 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 			eeprom[MT_EE_WIFI_CONF]);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	case MT_EE_DBDC:
 		dev->dbdc_support = true;
 		/* fall through */
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index 9087607b621e..ebf4c96532d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -52,15 +52,15 @@ static void mt76x0_set_chip_cap(struct mt76x02_dev *dev)
 
 	mt76x02_eeprom_parse_hw_cap(dev);
 	dev_dbg(dev->mt76.dev, "2GHz %d 5GHz %d\n",
-		dev->mt76.cap.has_2ghz, dev->mt76.cap.has_5ghz);
+		dev->mphy.cap.has_2ghz, dev->mphy.cap.has_5ghz);
 
 	if (dev->no_2ghz) {
-		dev->mt76.cap.has_2ghz = false;
+		dev->mphy.cap.has_2ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 2GHz support\n");
 	}
 
 	if (is_mt7630(dev)) {
-		dev->mt76.cap.has_5ghz = false;
+		dev->mphy.cap.has_5ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 5GHz support\n");
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index d78866bf41ba..0bac39bf3b66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -245,7 +245,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	if (dev->mt76.cap.has_5ghz) {
+	if (dev->mphy.cap.has_5ghz) {
 		struct ieee80211_supported_band *sband;
 
 		sband = &dev->mphy.sband_5g.sband;
@@ -253,7 +253,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 		mt76x0_init_txpower(dev, sband);
 	}
 
-	if (dev->mt76.cap.has_2ghz)
+	if (dev->mphy.cap.has_2ghz)
 		mt76x0_init_txpower(dev, &dev->mphy.sband_2g.sband);
 
 	mt76x02_init_debugfs(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 3de33aadf794..e91c314cdfac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -447,11 +447,11 @@ static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 		else
 			coex3 |= BIT(4);
 		coex3 |= BIT(3);
-		if (dev->mt76.cap.has_2ghz)
+		if (dev->mphy.cap.has_2ghz)
 			wlan |= BIT(6);
 	} else {
 		/* sigle antenna mode */
-		if (dev->mt76.cap.has_5ghz) {
+		if (dev->mphy.cap.has_5ghz) {
 			coex3 |= BIT(3) | BIT(4);
 		} else {
 			wlan |= BIT(6);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index c54c50fd639a..0acabba2d1a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -75,14 +75,14 @@ void mt76x02_eeprom_parse_hw_cap(struct mt76x02_dev *dev)
 
 	switch (FIELD_GET(MT_EE_NIC_CONF_0_BOARD_TYPE, val)) {
 	case BOARD_TYPE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case BOARD_TYPE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 35954a499b33..d65910cc0709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -52,14 +52,14 @@ static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index fe369f85dfeb..53eec43135bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -521,10 +521,9 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 {
 	struct ieee80211_sband_iftype_data *data;
 	struct ieee80211_supported_band *band;
-	struct mt76_dev *mdev = &phy->dev->mt76;
 	int n;
 
-	if (mdev->cap.has_2ghz) {
+	if (phy->mt76->cap.has_2ghz) {
 		data = phy->iftype[NL80211_BAND_2GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_2GHZ, data);
 
@@ -533,7 +532,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		band->n_iftype_data = n;
 	}
 
-	if (mdev->cap.has_5ghz) {
+	if (phy->mt76->cap.has_5ghz) {
 		data = phy->iftype[NL80211_BAND_5GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_5GHZ, data);
 
-- 
2.26.2

