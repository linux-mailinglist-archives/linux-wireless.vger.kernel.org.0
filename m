Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24643C622
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhJ0JMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:10 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53648 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241168AbhJ0JMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:09 -0400
X-UUID: cb743067b8eb425b96b84a6a41e31316-20211027
X-UUID: cb743067b8eb425b96b84a6a41e31316-20211027
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1440391717; Wed, 27 Oct 2021 17:09:39 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:35 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:35 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 05/11] mt76: mt7915: rework eeprom.c to adapt mt7916 changes
Date:   Wed, 27 Oct 2021 16:40:13 +0800
Message-ID: <3151900f0e335bd8b1c00f1b51e2347c93942af0.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 83 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  9 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 46 ++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +-
 4 files changed, 101 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 626ea4a..903fc41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -10,6 +10,7 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	struct mt76_dev *mdev = &dev->mt76;
 	u8 *eeprom = mdev->eeprom.data;
 	u32 val = eeprom[MT_EE_DO_PRE_CAL];
+	u32 offs;
 
 	if (!dev->flash_mode)
 		return 0;
@@ -22,7 +23,9 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	if (!dev->cal)
 		return -ENOMEM;
 
-	return mt76_get_of_eeprom(mdev, dev->cal, MT_EE_PRECAL, val);
+	offs = is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
+
+	return mt76_get_of_eeprom(mdev, dev->cal, offs, val);
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
@@ -113,7 +116,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 	return ret;
 }
 
-void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
+static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
@@ -139,32 +142,56 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 	}
 }
 
-static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
+void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
+				struct mt7915_phy *phy)
 {
 	u8 nss, nss_band, *eeprom = dev->mt76.eeprom.data;
+	struct mt76_phy *mphy = phy->mt76;
+	bool ext_phy = phy != &dev->phy;
+
+	mt7915_eeprom_parse_band_config(phy);
 
-	mt7915_eeprom_parse_band_config(&dev->phy);
+	/* read tx/rx mask from eeprom */
+	if (is_mt7915(&dev->mt76)) {
+		nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
+				eeprom[MT_EE_WIFI_CONF]);
 
-	/* read tx mask from eeprom */
-	nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH, eeprom[MT_EE_WIFI_CONF]);
-	if (!nss || nss > 4)
-		nss = 4;
+		if (dev->dbdc_support)
+			nss = nss >> 1;
+	} else {
+		nss = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
+				eeprom[MT_EE_WIFI_CONF + ext_phy]);
+	}
 
-	nss_band = nss;
+	if (!nss || nss > 2)
+		nss = 2;
 
-	if (dev->dbdc_support) {
+	/* read tx/rx stream */
+	if (is_mt7915(&dev->mt76)) {
 		nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
 				     eeprom[MT_EE_WIFI_CONF + 3]);
-		if (!nss_band || nss_band > 2)
-			nss_band = 2;
+		if (ext_phy)
+			nss_band = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B1,
+					     eeprom[MT_EE_WIFI_CONF + 3]);
+	} else {
+		nss_band = FIELD_GET(MT_EE_WIFI_CONF_STREAM_NUM,
+				     eeprom[MT_EE_WIFI_CONF + 2 + ext_phy]);
 
-		if (nss_band >= nss)
-			nss = 4;
 	}
 
-	dev->chainmask = BIT(nss) - 1;
-	dev->mphy.antenna_mask = BIT(nss_band) - 1;
-	dev->mphy.chainmask = dev->mphy.antenna_mask;
+	if (!nss_band || nss_band > 2)
+		nss_band = 2;
+
+	if (nss_band > nss) {
+		dev_err(dev->mt76.dev,
+			"nss mismatch, nss(%d) nss_band(%d) ext_phy(%d)\n",
+			nss, nss_band, ext_phy);
+		nss = nss_band;
+	}
+
+	mphy->chainmask = ext_phy ? (BIT(nss) - 1) << 2 : (BIT(nss) - 1);
+	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
+	dev->chainmask |= mphy->chainmask;
 }
 
 int mt7915_eeprom_init(struct mt7915_dev *dev)
@@ -179,7 +206,7 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	mt7915_eeprom_parse_hw_cap(dev);
+	mt7915_eeprom_parse_hw_cap(dev, &dev->phy);
 	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
 
@@ -202,15 +229,20 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 	tssi_on = mt7915_tssi_enabled(dev, chan->band);
 
 	if (chan->band == NL80211_BAND_2GHZ) {
-		index = MT_EE_TX0_POWER_2G + chain_idx * 3;
+		u32 power = is_mt7915(&dev->mt76) ?
+			MT_EE_TX0_POWER_2G : MT_EE_TX0_POWER_2G_V2;
+
+		index = power + chain_idx * 3;
 		target_power = eeprom[index];
 
 		if (!tssi_on)
 			target_power += eeprom[index + 1];
 	} else {
 		int group = mt7915_get_channel_group(chan->hw_value);
+		u32 power = is_mt7915(&dev->mt76) ?
+			MT_EE_TX0_POWER_5G : MT_EE_TX0_POWER_5G_V2;
 
-		index = MT_EE_TX0_POWER_5G + chain_idx * 12;
+		index = power + chain_idx * 12;
 		target_power = eeprom[index + group];
 
 		if (!tssi_on)
@@ -225,11 +257,18 @@ s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 	u8 *eeprom = dev->mt76.eeprom.data;
 	u32 val;
 	s8 delta;
+	u32 rate_2g, rate_5g;
+
+	rate_2g = is_mt7915(&dev->mt76) ?
+		MT_EE_RATE_DELTA_2G : MT_EE_RATE_DELTA_2G_V2;
+
+	rate_5g = is_mt7915(&dev->mt76) ?
+		MT_EE_RATE_DELTA_5G : MT_EE_RATE_DELTA_5G_V2;
 
 	if (band == NL80211_BAND_2GHZ)
-		val = eeprom[MT_EE_RATE_DELTA_2G];
+		val = eeprom[rate_2g];
 	else
-		val = eeprom[MT_EE_RATE_DELTA_5G];
+		val = eeprom[rate_5g];
 
 	if (!(val & MT_EE_RATE_DELTA_EN))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index a43389a..92d1a94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -23,11 +23,17 @@ enum mt7915_eeprom_field {
 	MT_EE_RATE_DELTA_5G =	0x29d,
 	MT_EE_TX0_POWER_2G =	0x2fc,
 	MT_EE_TX0_POWER_5G =	0x34b,
+	MT_EE_RATE_DELTA_2G_V2 = 0x7d3,
+	MT_EE_RATE_DELTA_5G_V2 = 0x81e,
+	MT_EE_TX0_POWER_2G_V2 =	0x441,
+	MT_EE_TX0_POWER_5G_V2 =	0x445,
 	MT_EE_ADIE_FT_VERSION =	0x9a0,
 
 	__MT_EE_MAX =		0xe00,
+	__MT_EE_MAX_V2 =	0x1000,
 	/* 0xe10 ~ 0x5780 used to save group cal data */
-	MT_EE_PRECAL =		0xe10
+	MT_EE_PRECAL =		0xe10,
+	MT_EE_PRECAL_V2 =	0x1010
 };
 
 #define MT_EE_WIFI_CAL_GROUP			BIT(0)
@@ -39,6 +45,7 @@ enum mt7915_eeprom_field {
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
 #define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(7, 6)
+#define MT_EE_WIFI_CONF_STREAM_NUM		GENMASK(7, 5)
 #define MT_EE_WIFI_CONF3_TX_PATH_B0		GENMASK(1, 0)
 #define MT_EE_WIFI_CONF3_TX_PATH_B1		GENMASK(5, 4)
 #define MT_EE_WIFI_CONF7_TSSI0_2G		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a4e2d85..8d16c96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -307,6 +307,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct wiphy *wiphy = hw->wiphy;
+	struct mt7915_dev *dev = phy->dev;
 
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
@@ -352,14 +353,34 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 		phy->mt76->sband_5g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
-		phy->mt76->sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+
+		if (is_mt7915(&dev->mt76)) {
+			phy->mt76->sband_5g.sband.vht_cap.cap |=
+				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
+				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+
+			if (!dev->dbdc_support)
+				phy->mt76->sband_5g.sband.vht_cap.cap |=
+					IEEE80211_VHT_CAP_SHORT_GI_160 |
+					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
+		} else {
+			phy->mt76->sband_5g.sband.vht_cap.cap |=
+				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+
+			/* mt7916 dbdc with 2g 2x2 bw40 and 5g 2x2 bw160c */
+			phy->mt76->sband_5g.sband.vht_cap.cap |=
+				IEEE80211_VHT_CAP_SHORT_GI_160 |
+				IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
+		}
 	}
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
 	mt7915_set_stream_he_caps(phy);
+
+	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
+	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
 }
 
 static void
@@ -459,18 +480,17 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	phy = mphy->priv;
 	phy->dev = dev;
 	phy->mt76 = mphy;
-	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
-	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
 
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
-	mt7915_eeprom_parse_band_config(phy);
-	mt7915_init_wiphy(mphy->hw);
+	mt7915_eeprom_parse_hw_cap(dev, phy);
 
 	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR2,
 	       ETH_ALEN);
 	mt76_eeprom_override(mphy);
 
+	/* init wiphy according to mphy and phy */
+	mt7915_init_wiphy(mphy->hw);
 	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
 				    MT7915_TX_RING_SIZE);
 	if (ret)
@@ -554,7 +574,9 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
-	dev->dbdc_support = !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5));
+
+	dev->dbdc_support = is_mt7915(&dev->mt76) ?
+			    !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5)) : true;
 
 	/* If MCU was already running, it is likely in a bad state */
 	if (mt76_get_field(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE) >
@@ -581,7 +603,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-
 	if (dev->flash_mode) {
 		ret = mt7915_mcu_apply_group_cal(dev);
 		if (ret)
@@ -927,13 +948,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	mt7915_init_wiphy(hw);
 
-	if (!dev->dbdc_support)
-		dev->mphy.sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_SHORT_GI_160 |
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
-
-	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
-	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index cee719f..3e2e900 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -386,7 +386,8 @@ u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
-void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy);
+void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
+				struct mt7915_phy *phy);
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
-- 
2.18.0

