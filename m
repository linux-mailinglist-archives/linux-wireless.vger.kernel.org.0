Return-Path: <linux-wireless+bounces-17020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3299FFBE7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AB51883E80
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677C81B6CFE;
	Thu,  2 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="g1jegFdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865F17335C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835730; cv=none; b=mbQxwP1u+wFCjIf87R5VxQe+ErpxoDs191SAoh1YgAxaJ+9wfReueEhFCDsX5oQtvgTLiZmE/IiQfMnQURq+3wsYJIY4OLHKoVAxQZzTemzZ10FbfIoKwBzYh4QecK7YoaTznTfQkmhEOaPpuoYpX06Lvo169iaWIeyzffQnhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835730; c=relaxed/simple;
	bh=22dJ5viFecrtfmJVTV/pRBK3LmNCoCK94L5d4LkASNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi+hyVNuIE6WaSIvAJnFe42bMfHrb3ziqSe7pHZZydxps/az18AER+PvL2GbtWUivP88JSe75nTwOr9C51C1Zg3ZOjwTz3zKbw7hJuMrdHSE4Gxx3RuVPa6pCCDEkBbBYlWotpwaI9RKehb6X0VBKM7FyFt6XjHE46K/3/Y9I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=g1jegFdM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5uW21bVLgT7qt7/dtDaB5dNg88+P71eHWGJPz/NaFLA=; b=g1jegFdMkTbQmpKxuV72l9F1cc
	e75W7TRR029Z/SP7JpNkfBpJWvpjOzeKeiXBhqF1RkYdrE/I0bvjCbaVMvWQswd/b/vwqYdNRGFxx
	Sm+GdCgBqcknkGA4NfA4X9RuwmJo9jbom7zKznzZ+vU1Ly/ZlRL6ZLOHsZegKSx+FecE=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAF-0008GS-0M
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:15 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 23/24] wifi: mt76: mt7996: switch to single multi-radio wiphy
Date: Thu,  2 Jan 2025 17:35:07 +0100
Message-ID: <20250102163508.52945-23-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use generic mt76 chanctx functions and look up phy from vif link.
The driver now uses only a single phy to handle multiple interfaces on
different channels. This is preparation for full MLO support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |   1 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 252 ++++---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 649 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  15 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |   3 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  52 +-
 7 files changed, 595 insertions(+), 383 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index da94751df020..53dfac02f8af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -305,6 +305,7 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
 
 	mphy->antenna_mask = BIT(nss) - 1;
 	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
+	phy->orig_chainmask = mphy->chainmask;
 	dev->chainmask |= mphy->chainmask;
 	if (band_idx < MT_BAND2)
 		dev->chainshift[band_idx + 1] = dev->chainshift[band_idx] +
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a28933659c01..c3f99abe2a09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -14,6 +14,28 @@
 #include "coredump.h"
 #include "eeprom.h"
 
+static const struct ieee80211_iface_limit if_limits_global = {
+	.max = MT7996_MAX_INTERFACES * MT7996_MAX_RADIOS,
+	.types = BIT(NL80211_IFTYPE_STATION)
+		 | BIT(NL80211_IFTYPE_ADHOC)
+		 | BIT(NL80211_IFTYPE_AP)
+#ifdef CONFIG_MAC80211_MESH
+		 | BIT(NL80211_IFTYPE_MESH_POINT)
+#endif
+};
+
+static const struct ieee80211_iface_combination if_comb_global = {
+	.limits = &if_limits_global,
+	.n_limits = 1,
+	.max_interfaces = MT7996_MAX_INTERFACES * MT7996_MAX_RADIOS,
+	.num_different_channels = MT7996_MAX_RADIOS,
+	.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+			       BIT(NL80211_CHAN_WIDTH_20) |
+			       BIT(NL80211_CHAN_WIDTH_40) |
+			       BIT(NL80211_CHAN_WIDTH_80) |
+			       BIT(NL80211_CHAN_WIDTH_160),
+};
+
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = 1,
@@ -30,20 +52,18 @@ static const struct ieee80211_iface_limit if_limits[] = {
 	}
 };
 
-static const struct ieee80211_iface_combination if_comb[] = {
-	{
-		.limits = if_limits,
-		.n_limits = ARRAY_SIZE(if_limits),
-		.max_interfaces = MT7996_MAX_INTERFACES,
-		.num_different_channels = 1,
-		.beacon_int_infra_match = true,
-		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-				       BIT(NL80211_CHAN_WIDTH_20) |
-				       BIT(NL80211_CHAN_WIDTH_40) |
-				       BIT(NL80211_CHAN_WIDTH_80) |
-				       BIT(NL80211_CHAN_WIDTH_160),
-		.beacon_int_min_gcd = 100,
-	}
+static const struct ieee80211_iface_combination if_comb = {
+	.limits = if_limits,
+	.n_limits = ARRAY_SIZE(if_limits),
+	.max_interfaces = MT7996_MAX_INTERFACES,
+	.num_different_channels = 1,
+	.beacon_int_infra_match = true,
+	.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+			       BIT(NL80211_CHAN_WIDTH_20) |
+			       BIT(NL80211_CHAN_WIDTH_40) |
+			       BIT(NL80211_CHAN_WIDTH_80) |
+			       BIT(NL80211_CHAN_WIDTH_160),
+	.beacon_int_min_gcd = 100,
 };
 
 static ssize_t mt7996_thermal_temp_show(struct device *dev,
@@ -180,28 +200,32 @@ static const struct thermal_cooling_device_ops mt7996_thermal_ops = {
 static void mt7996_unregister_thermal(struct mt7996_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	char name[sizeof("cooling_device%d")];
 
 	if (!phy->cdev)
 		return;
 
-	sysfs_remove_link(&wiphy->dev.kobj, "cooling_device");
+	snprintf(name, sizeof(name), "cooling_device%d", phy->mt76->band_idx);
+	sysfs_remove_link(&wiphy->dev.kobj, name);
 	thermal_cooling_device_unregister(phy->cdev);
 }
 
 static int mt7996_thermal_init(struct mt7996_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	char cname[sizeof("cooling_device%d")];
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
 	const char *name;
 
-	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7996_%s",
-			      wiphy_name(wiphy));
+	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7996_%s.%d",
+			      wiphy_name(wiphy), phy->mt76->band_idx);
+	snprintf(cname, sizeof(cname), "cooling_device%d", phy->mt76->band_idx);
 
 	cdev = thermal_cooling_device_register(name, phy, &mt7996_thermal_ops);
 	if (!IS_ERR(cdev)) {
 		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
-				      "cooling_device") < 0)
+				      cname) < 0)
 			thermal_cooling_device_unregister(cdev);
 		else
 			phy->cdev = cdev;
@@ -333,28 +357,88 @@ mt7996_regd_notifier(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_phy *phy;
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
-	if (dev->mt76.region == NL80211_DFS_UNSET)
-		mt7996_mcu_rdd_background_enable(phy, NULL);
+	mt7996_for_each_phy(dev, phy) {
+		if (dev->mt76.region == NL80211_DFS_UNSET)
+			mt7996_mcu_rdd_background_enable(phy, NULL);
 
+		mt7996_init_txpower(phy);
+		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+		mt7996_dfs_init_radar_detector(phy);
+	}
+}
+
+static void
+mt7996_init_wiphy_band(struct ieee80211_hw *hw, struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct wiphy *wiphy = hw->wiphy;
+	int n_radios = hw->wiphy->n_radio;
+	struct wiphy_radio_freq_range *freq = &dev->radio_freqs[n_radios];
+	struct wiphy_radio *radio = &dev->radios[n_radios];
+
+	phy->slottime = 9;
+	phy->beacon_rate = -1;
+
+	if (phy->mt76->cap.has_2ghz) {
+		phy->mt76->sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+		phy->mt76->sband_2g.sband.ht_cap.ampdu_density =
+			IEEE80211_HT_MPDU_DENSITY_2;
+		freq->start_freq = 2400000;
+		freq->end_freq = 2500000;
+	} else if (phy->mt76->cap.has_5ghz) {
+		phy->mt76->sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+
+		phy->mt76->sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SHORT_GI_160 |
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
+		phy->mt76->sband_5g.sband.ht_cap.ampdu_density =
+			IEEE80211_HT_MPDU_DENSITY_1;
+
+		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+		freq->start_freq = 5000000;
+		freq->end_freq = 5900000;
+	} else if (phy->mt76->cap.has_6ghz) {
+		freq->start_freq = 5900000;
+		freq->end_freq = 7200000;
+	} else {
+		return;
+	}
+
+	dev->radio_phy[n_radios] = phy;
+	radio->freq_range = freq;
+	radio->n_freq_range = 1;
+	radio->iface_combinations = &if_comb;
+	radio->n_iface_combinations = 1;
+	hw->wiphy->n_radio++;
+
+	wiphy->available_antennas_rx |= phy->mt76->chainmask;
+	wiphy->available_antennas_tx |= phy->mt76->chainmask;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7996_set_stream_vht_txbf_caps(phy);
+	mt7996_set_stream_he_eht_caps(phy);
 	mt7996_init_txpower(phy);
-
-	phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
-	mt7996_dfs_init_radar_detector(phy);
 }
 
 static void
 mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt76_dev *mdev = &phy->dev->mt76;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
 	struct wiphy *wiphy = hw->wiphy;
-	u16 max_subframes = phy->dev->has_eht ? IEEE80211_MAX_AMPDU_BUF_EHT :
-						IEEE80211_MAX_AMPDU_BUF_HE;
+	u16 max_subframes = dev->has_eht ? IEEE80211_MAX_AMPDU_BUF_EHT :
+					   IEEE80211_MAX_AMPDU_BUF_HE;
 
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = max_subframes;
@@ -366,14 +450,15 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
 
-	phy->slottime = 9;
-	phy->beacon_rate = -1;
-
 	hw->sta_data_size = sizeof(struct mt7996_sta);
 	hw->vif_data_size = sizeof(struct mt7996_vif);
+	hw->chanctx_data_size = sizeof(struct mt76_chanctx);
+
+	wiphy->iface_combinations = &if_comb_global;
+	wiphy->n_iface_combinations = 1;
+
+	wiphy->radio = dev->radios;
 
-	wiphy->iface_combinations = if_comb;
-	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7996_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->mbssid_max_interfaces = 16;
@@ -390,7 +475,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
-	if (mt7996_has_background_radar(phy->dev) &&
+	if (mt7996_has_background_radar(dev) &&
 	    (!mdev->dev->of_node ||
 	     !of_property_read_bool(mdev->dev->of_node,
 				    "mediatek,disable-radar-background")))
@@ -400,51 +485,21 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
-	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 
 	hw->max_tx_fragments = 4;
 
-	if (phy->mt76->cap.has_2ghz) {
-		phy->mt76->sband_2g.sband.ht_cap.cap |=
-			IEEE80211_HT_CAP_LDPC_CODING |
-			IEEE80211_HT_CAP_MAX_AMSDU;
-		phy->mt76->sband_2g.sband.ht_cap.ampdu_density =
-			IEEE80211_HT_MPDU_DENSITY_2;
-	}
-
-	if (phy->mt76->cap.has_5ghz) {
-		phy->mt76->sband_5g.sband.ht_cap.cap |=
-			IEEE80211_HT_CAP_LDPC_CODING |
-			IEEE80211_HT_CAP_MAX_AMSDU;
-
-		phy->mt76->sband_5g.sband.vht_cap.cap |=
-			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
-			IEEE80211_VHT_CAP_SHORT_GI_160 |
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
-		phy->mt76->sband_5g.sband.ht_cap.ampdu_density =
-			IEEE80211_HT_MPDU_DENSITY_1;
-
-		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
-	}
-
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		phy->mt76->leds.cdev.brightness_set = mt7996_led_set_brightness;
-		phy->mt76->leds.cdev.blink_set = mt7996_led_set_blink;
+		dev->mphy.leds.cdev.brightness_set = mt7996_led_set_brightness;
+		dev->mphy.leds.cdev.blink_set = mt7996_led_set_blink;
 	}
 
-	mt76_set_stream_caps(phy->mt76, true);
-	mt7996_set_stream_vht_txbf_caps(phy);
-	mt7996_set_stream_he_eht_caps(phy);
-	mt7996_init_txpower(phy);
-
-	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
-	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
-
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+
+	mt7996_init_wiphy_band(hw, &dev->phy);
 }
 
 static void
@@ -565,18 +620,15 @@ int mt7996_txbf_init(struct mt7996_dev *dev)
 	return mt7996_mcu_set_txbf(dev, BF_HW_EN_UPDATE);
 }
 
-static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
-			       enum mt76_band_id band)
+static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 {
+	struct mt7996_phy *phy;
 	struct mt76_phy *mphy;
 	u32 mac_ofs, hif1_ofs = 0;
 	int ret;
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	if (!mt7996_band_valid(dev, band) || band == MT_BAND0)
-		return 0;
-
-	if (phy)
+	if (!mt7996_band_valid(dev, band))
 		return 0;
 
 	if (is_mt7996(&dev->mt76) && band == MT_BAND2 && dev->hif2) {
@@ -584,7 +636,7 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 		wed = &dev->mt76.mmio.wed_hif2;
 	}
 
-	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7996_ops, band);
+	mphy = mt76_alloc_radio_phy(&dev->mt76, sizeof(*phy), band);
 	if (!mphy)
 		return -ENOMEM;
 
@@ -615,7 +667,7 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	mt76_eeprom_override(mphy);
 
 	/* init wiphy according to mphy and phy */
-	mt7996_init_wiphy(mphy->hw, wed);
+	mt7996_init_wiphy_band(mphy->hw, phy);
 	ret = mt7996_init_tx_queues(mphy->priv,
 				    MT_TXQ_ID(band),
 				    MT7996_TX_RING_SIZE,
@@ -629,10 +681,6 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (ret)
 		goto error;
 
-	ret = mt7996_thermal_init(phy);
-	if (ret)
-		goto error;
-
 	if (wed == &dev->mt76.mmio.wed_hif2 && mtk_wed_device_active(wed)) {
 		u32 irq_mask = dev->mt76.mmio.irqmask | MT_INT_TX_DONE_BAND2;
 
@@ -644,24 +692,14 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 
 error:
 	mphy->dev->phys[band] = NULL;
-	ieee80211_free_hw(mphy->hw);
 	return ret;
 }
 
 static void
-mt7996_unregister_phy(struct mt7996_phy *phy, enum mt76_band_id band)
+mt7996_unregister_phy(struct mt7996_phy *phy)
 {
-	struct mt76_phy *mphy;
-
-	if (!phy)
-		return;
-
-	mt7996_unregister_thermal(phy);
-
-	mphy = phy->dev->mt76.phys[band];
-	mt76_unregister_phy(mphy);
-	ieee80211_free_hw(mphy->hw);
-	phy->dev->mt76.phys[band] = NULL;
+	if (phy)
+		mt7996_unregister_thermal(phy);
 }
 
 static void mt7996_init_work(struct work_struct *work)
@@ -1415,6 +1453,7 @@ void mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy)
 int mt7996_register_device(struct mt7996_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt7996_phy *phy;
 	int ret;
 
 	dev->phy.dev = dev;
@@ -1436,22 +1475,21 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	mt7996_init_wiphy(hw, &dev->mt76.mmio.wed);
 
+	ret = mt7996_register_phy(dev, MT_BAND1);
+	if (ret)
+		return ret;
+
+	ret = mt7996_register_phy(dev, MT_BAND2);
+	if (ret)
+		return ret;
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
 		return ret;
 
-	ret = mt7996_thermal_init(&dev->phy);
-	if (ret)
-		return ret;
-
-	ret = mt7996_register_phy(dev, mt7996_phy2(dev), MT_BAND1);
-	if (ret)
-		return ret;
-
-	ret = mt7996_register_phy(dev, mt7996_phy3(dev), MT_BAND2);
-	if (ret)
-		return ret;
+	mt7996_for_each_phy(dev, phy)
+		mt7996_thermal_init(phy);
 
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
@@ -1476,8 +1514,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 void mt7996_unregister_device(struct mt7996_dev *dev)
 {
 	cancel_work_sync(&dev->wed_rro.work);
-	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
-	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
+	mt7996_unregister_phy(mt7996_phy3(dev));
+	mt7996_unregister_phy(mt7996_phy2(dev));
 	mt7996_unregister_thermal(&dev->phy);
 	mt7996_coredump_unregister(dev);
 	mt76_unregister_device(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 89523afa4aca..f5865d9688b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1738,19 +1738,19 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	ret = mt7996_txbf_init(dev);
 
 	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
-		ret = mt7996_run(dev->mphy.hw);
+		ret = mt7996_run(&dev->phy);
 		if (ret)
 			goto out;
 	}
 
 	if (phy2 && test_bit(MT76_STATE_RUNNING, &phy2->mt76->state)) {
-		ret = mt7996_run(phy2->mt76->hw);
+		ret = mt7996_run(phy2);
 		if (ret)
 			goto out;
 	}
 
 	if (phy3 && test_bit(MT76_STATE_RUNNING, &phy3->mt76->state)) {
-		ret = mt7996_run(phy3->mt76->hw);
+		ret = mt7996_run(phy3);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1bf45888ea1e..77b97324f7d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -7,76 +7,44 @@
 #include "mcu.h"
 #include "mac.h"
 
-static bool mt7996_dev_running(struct mt7996_dev *dev)
+int mt7996_run(struct mt7996_phy *phy)
 {
-	struct mt7996_phy *phy;
-
-	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
-		return true;
-
-	phy = mt7996_phy2(dev);
-	if (phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
-		return true;
-
-	phy = mt7996_phy3(dev);
-
-	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-}
-
-int mt7996_run(struct ieee80211_hw *hw)
-{
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	bool running;
+	struct mt7996_dev *dev = phy->dev;
 	int ret;
 
-	running = mt7996_dev_running(dev);
-	if (!running) {
-		ret = mt7996_mcu_set_hdr_trans(dev, true);
-		if (ret)
-			goto out;
-
-		if (is_mt7992(&dev->mt76)) {
-			u8 queue = mt76_connac_lmac_mapping(IEEE80211_AC_VI);
-
-			ret = mt7996_mcu_cp_support(dev, queue);
-			if (ret)
-				goto out;
-		}
-	}
-
 	mt7996_mac_enable_nf(dev, phy->mt76->band_idx);
 
 	ret = mt7996_mcu_set_rts_thresh(phy, 0x92b);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = mt7996_mcu_set_radio_en(phy, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = mt7996_mcu_set_thermal_throttling(phy, MT7996_THERMAL_THROTTLE_MAX);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = mt7996_mcu_set_thermal_protect(phy, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+	ieee80211_queue_delayed_work(dev->mphy.hw, &phy->mt76->mac_work,
 				     MT7996_WATCHDOG_TIME);
 
-	if (!running)
+	if (!phy->counter_reset) {
 		mt7996_mac_reset_counters(phy);
+		phy->counter_reset = true;
+	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int mt7996_start(struct ieee80211_hw *hw)
@@ -87,16 +55,23 @@ static int mt7996_start(struct ieee80211_hw *hw)
 	flush_work(&dev->init_work);
 
 	mutex_lock(&dev->mt76.mutex);
-	ret = mt7996_run(hw);
+	ret = mt7996_mcu_set_hdr_trans(dev, true);
+	if (!ret && is_mt7992(&dev->mt76)) {
+		u8 queue = mt76_connac_lmac_mapping(IEEE80211_AC_VI);
+
+		ret = mt7996_mcu_cp_support(dev, queue);
+	}
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
 }
 
-static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
+static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = phy->dev;
+
+	if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
@@ -109,6 +84,10 @@ static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void mt7996_stop(struct ieee80211_hw *hw, bool suspend)
+{
+}
+
 static inline int get_free_idx(u32 mask, u8 start, u8 end)
 {
 	return ffs(~mask & GENMASK(end, start));
@@ -177,46 +156,113 @@ mt7996_init_bitrate_mask(struct ieee80211_vif *vif, struct mt7996_vif_link *mlin
 }
 
 static int
-mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-		    struct ieee80211_bss_conf *link_conf)
+mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+		  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		  struct mt7996_vif_link *mlink, struct ieee80211_key_conf *key)
 {
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
+				  &mlink->sta;
+	struct mt76_wcid *wcid = &msta->wcid;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	struct mt7996_phy *phy;
+	int idx = key->keyidx;
+
+	phy = mt7996_vif_link_phy(mlink);
+	if (!phy)
+		return -EINVAL;
+
+	if (sta && !wcid->sta)
+		return -EOPNOTSUPP;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		if (key->keyidx == 6 || key->keyidx == 7) {
+			wcid_keyidx = &wcid->hw_key_idx2;
+			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (cmd == SET_KEY && !sta && !mlink->mt76.cipher) {
+		mlink->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mt7996_mcu_add_bss_info(phy, vif, &vif->bss_conf, &mlink->mt76, true);
+	}
+
+	if (cmd == SET_KEY) {
+		*wcid_keyidx = idx;
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+		return 0;
+	}
+
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
+
+	if (key->keyidx == 6 || key->keyidx == 7)
+		return mt7996_mcu_bcn_prot_enable(dev, vif, key);
+
+	return mt7996_mcu_add_key(&dev->mt76, vif, key,
+				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+				  &msta->wcid, cmd);
+}
+
+static void
+mt7996_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
+		void *data)
+{
+	struct mt7996_vif_link *mlink = data;
+
+	if (sta)
+		return;
+
+	WARN_ON(mt7996_set_hw_key(hw, SET_KEY, vif, NULL, mlink, key));
+}
+
+int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link_conf,
+			struct mt76_vif_link *mlink)
+{
+	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
-	struct mt7996_vif_link *mlink;
 	struct mt76_txq *mtxq;
 	int idx, ret;
 
-	mlink = mt7996_vif_conf_link(dev, vif, link_conf);
-	if (!mlink)
-		return -EINVAL;
-
-	mlink->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mlink->mt76.idx >= mt7996_max_interface_num(dev))
+	mlink->idx = __ffs64(~dev->mt76.vif_mask);
+	if (mlink->idx >= mt7996_max_interface_num(dev))
 		return -ENOSPC;
 
 	idx = get_omac_idx(vif->type, phy->omac_mask);
 	if (idx < 0)
 		return -ENOSPC;
 
-	mlink->mt76.omac_idx = idx;
-	mlink->phy = phy;
-	mlink->mt76.band_idx = band_idx;
-	mlink->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
-	mlink->mt76.wcid = &mlink->sta.wcid;
+	link->phy = phy;
+	mlink->omac_idx = idx;
+	mlink->band_idx = band_idx;
+	mlink->wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
+	mlink->wcid = &link->sta.wcid;
 
-	ret = mt7996_mcu_add_dev_info(phy, vif, link_conf, &mlink->mt76, true);
+	ret = mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, true);
 	if (ret)
 		return ret;
 
-	dev->mt76.vif_mask |= BIT_ULL(mlink->mt76.idx);
-	phy->omac_mask |= BIT_ULL(mlink->mt76.omac_idx);
+	dev->mt76.vif_mask |= BIT_ULL(mlink->idx);
+	phy->omac_mask |= BIT_ULL(mlink->omac_idx);
 
-	idx = MT7996_WTBL_RESERVED - mlink->mt76.idx;
+	idx = MT7996_WTBL_RESERVED - mlink->idx;
 
-	INIT_LIST_HEAD(&mlink->sta.rc_list);
-	mlink->sta.wcid.idx = idx;
-	mlink->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mlink->sta.wcid, band_idx);
+	INIT_LIST_HEAD(&link->sta.rc_list);
+	link->sta.wcid.idx = idx;
+	link->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&link->sta.wcid, band_idx);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -227,56 +273,50 @@ mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	}
 
 	if (vif->type != NL80211_IFTYPE_AP &&
-	    (!mlink->mt76.omac_idx || mlink->mt76.omac_idx > 3))
+	    (!mlink->omac_idx || mlink->omac_idx > 3))
 		vif->offload_flags = 0;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mlink->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+		mlink->basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
 	else
-		mlink->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
+		mlink->basic_rates_idx = MT7996_BASIC_RATES_TBL;
 
-	mt7996_init_bitrate_mask(vif, mlink);
+	mt7996_init_bitrate_mask(vif, link);
 
-	mt7996_mcu_add_bss_info(phy, vif, link_conf, &mlink->mt76, true);
+	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, true);
 	/* defer the first STA_REC of BMC entry to BSS_CHANGED_BSSID for STA
 	 * interface, since firmware only records BSSID when the entry is new
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
-		mt7996_mcu_add_sta(dev, vif, &mlink->mt76, NULL,
-				   CONN_STATE_PORT_SECURE, true);
-	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->sta.wcid);
+		mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_PORT_SECURE, true);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &link->sta.wcid);
+
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, link);
 
 	return 0;
 }
 
-static void
-mt7996_vif_link_remove(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_bss_conf *link_conf)
+void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink)
 {
+	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
-	struct mt7996_vif_link *mlink;
 	struct mt7996_sta *msta;
 	int idx;
 
-	mlink = mt7996_vif_conf_link(dev, vif, link_conf);
-	if (!mlink)
-		return;
-
-	mlink->phy = NULL;
-	msta = &mlink->sta;
+	msta = &link->sta;
 	idx = msta->wcid.idx;
-	mt7996_mcu_add_sta(dev, vif, &mlink->mt76, NULL, CONN_STATE_DISCONNECT,
-			   false);
-	mt7996_mcu_add_bss_info(phy, vif, link_conf, &mlink->mt76, false);
+	mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_DISCONNECT, false);
+	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, false);
 
-	mt7996_mcu_add_dev_info(phy, vif, link_conf, &mlink->mt76, false);
+	mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	mutex_lock(&dev->mt76.mutex);
-	dev->mt76.vif_mask &= ~BIT_ULL(mlink->mt76.idx);
-	phy->omac_mask &= ~BIT_ULL(mlink->mt76.omac_idx);
-	mutex_unlock(&dev->mt76.mutex);
+	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
+	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->wcid.poll_list))
@@ -286,34 +326,121 @@ mt7996_vif_link_remove(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
+static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
+			MT_WF_RFCR1_DROP_BF_POLL |
+			MT_WF_RFCR1_DROP_BA |
+			MT_WF_RFCR1_DROP_CFEND |
+			MT_WF_RFCR1_DROP_CFACK;
+	u32 filter = phy->rxfilter;
+
+	if (filter & MT_WF_RFCR_DROP_OTHER_UC) {
+		filter |= MT_WF_RFCR_DROP_CTS |
+			  MT_WF_RFCR_DROP_RTS |
+			  MT_WF_RFCR_DROP_CTL_RSV |
+			  MT_WF_RFCR_DROP_FCSFAIL;
+	}
+
+	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), filter);
+	if (filter & MT_WF_RFCR_DROP_CTL_RSV)
+		mt76_set(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+	else
+		mt76_clear(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+}
+
+static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
+{
+	struct mt7996_dev *dev = phy->dev;
+
+	if (!phy)
+		return;
+
+	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
+		return;
+
+	if (!enabled)
+		phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+	else
+		phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
+		       MT_DMA_DCR0_RXD_G5_EN, enabled);
+	mt7996_phy_set_rxfilter(phy);
+}
+
 static int mt7996_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	int ret = 0;
+	int i, err = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
+	for (i = 0; i < MT7996_MAX_RADIOS; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+
+		if (!phy || !(wdev->radio_mask & BIT(i)) ||
+		    test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+			continue;
+
+		err = mt7996_run(phy);
+		if (err)
+			goto out;
+
+		if (vif->type == NL80211_IFTYPE_MONITOR)
+			mt7996_set_monitor(phy, true);
+	}
+
 	mt76_vif_init(vif, &mvif->mt76);
 
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
-	ret = mt7996_vif_link_add(phy, vif, &vif->bss_conf);
 
+out:
 	mutex_unlock(&dev->mt76.mutex);
 
-	return ret;
+	return err;
+}
+
+struct mt7996_radio_data {
+	u32 active_mask;
+	u32 monitor_mask;
+};
+
+static void mt7996_remove_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
+	struct mt7996_radio_data *rdata = data;
+
+	rdata->active_mask |= wdev->radio_mask;
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		rdata->monitor_mask |= wdev->radio_mask;
 }
 
 static void mt7996_remove_interface(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_radio_data rdata = {};
+	int i;
 
-	mt7996_vif_link_remove(phy, vif, &vif->bss_conf);
+	ieee80211_iterate_active_interfaces_mtx(hw, 0, mt7996_remove_iter,
+						&rdata);
 	mt76_vif_cleanup(&dev->mt76, vif);
+
+	for (i = 0; i < MT7996_MAX_RADIOS; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+
+		if (!phy)
+			continue;
+		if (!(rdata.monitor_mask & BIT(i)))
+			mt7996_set_monitor(phy, false);
+		if (!(rdata.active_mask & BIT(i)))
+			mt7996_stop_phy(phy);
+	}
 }
 
 int mt7996_set_channel(struct mt76_phy *mphy)
@@ -329,6 +456,10 @@ int mt7996_set_channel(struct mt76_phy *mphy)
 	if (ret)
 		goto out;
 
+	ret = mt7996_mcu_set_txpower_sku(phy);
+	if (ret)
+		goto out;
+
 	ret = mt7996_dfs_init_radar_detector(phy);
 	mt7996_mac_cca_stats_reset(phy);
 
@@ -347,15 +478,9 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_vif_link *mlink = &mvif->deflink;
-	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
-				  &mlink->sta;
-	struct mt76_wcid *wcid = &msta->wcid;
-	u8 *wcid_keyidx = &wcid->hw_key_idx;
-	int idx = key->keyidx;
-	int err = 0;
+	int err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -367,9 +492,6 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
-	if (sta && !wcid->sta)
-		return -EOPNOTSUPP;
-
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -383,11 +505,8 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		if (key->keyidx == 6 || key->keyidx == 7) {
-			wcid_keyidx = &wcid->hw_key_idx2;
-			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		if (key->keyidx == 6 || key->keyidx == 7)
 			break;
-		}
 		fallthrough;
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
@@ -395,31 +514,11 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
+	if (!mt7996_vif_link_phy(mlink))
+	    return 0; /* defer until after link add */
+
 	mutex_lock(&dev->mt76.mutex);
-
-	if (cmd == SET_KEY && !sta && !mlink->mt76.cipher) {
-		mlink->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		mt7996_mcu_add_bss_info(phy, vif, &vif->bss_conf, &mlink->mt76,
-					true);
-	}
-
-	if (cmd == SET_KEY) {
-		*wcid_keyidx = idx;
-	} else {
-		if (idx == *wcid_keyidx)
-			*wcid_keyidx = -1;
-		goto out;
-	}
-
-	mt76_wcid_key_setup(&dev->mt76, wcid, key);
-
-	if (key->keyidx == 6 || key->keyidx == 7)
-		err = mt7996_mcu_bcn_prot_enable(dev, vif, key);
-	else
-		err = mt7996_mcu_add_key(&dev->mt76, vif, key,
-					 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-					 &msta->wcid, cmd);
-out:
+	err = mt7996_set_hw_key(hw, cmd, vif, sta, mlink, key);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
@@ -427,40 +526,6 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	int ret;
-
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ret = mt76_update_channel(phy->mt76);
-		if (ret)
-			return ret;
-	}
-
-	if (changed & (IEEE80211_CONF_CHANGE_POWER |
-		       IEEE80211_CONF_CHANGE_CHANNEL)) {
-		ret = mt7996_mcu_set_txpower_sku(phy);
-		if (ret)
-			return ret;
-	}
-
-	mutex_lock(&dev->mt76.mutex);
-
-	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
-
-		if (!enabled)
-			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
-		else
-			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
-
-		mt76_rmw_field(dev, MT_DMA_DCR0(phy->mt76->band_idx),
-			       MT_DMA_DCR0_RXD_G5_EN, enabled);
-		mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
-	}
-
-	mutex_unlock(&dev->mt76.mutex);
-
 	return 0;
 }
 
@@ -491,34 +556,18 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 				    u64 multicast)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
-			MT_WF_RFCR1_DROP_BF_POLL |
-			MT_WF_RFCR1_DROP_BA |
-			MT_WF_RFCR1_DROP_CFEND |
-			MT_WF_RFCR1_DROP_CFACK;
+	struct mt7996_phy *phy;
+	u32 filter_mask = 0, filter_set = 0;
 	u32 flags = 0;
 
-#define MT76_FILTER(_flag, _hw) do {					\
-		flags |= *total_flags & FIF_##_flag;			\
-		phy->rxfilter &= ~(_hw);				\
-		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
+#define MT76_FILTER(_flag, _hw) do {				\
+		flags |= *total_flags & FIF_##_flag;		\
+		filter_mask |= (_hw);				\
+		filter_set |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
-			   MT_WF_RFCR_DROP_OTHER_BEACON |
-			   MT_WF_RFCR_DROP_FRAME_REPORT |
-			   MT_WF_RFCR_DROP_PROBEREQ |
-			   MT_WF_RFCR_DROP_MCAST_FILTERED |
-			   MT_WF_RFCR_DROP_MCAST |
-			   MT_WF_RFCR_DROP_BCAST |
-			   MT_WF_RFCR_DROP_DUPLICATE |
-			   MT_WF_RFCR_DROP_A2_BSSID |
-			   MT_WF_RFCR_DROP_UNWANTED_CTL |
-			   MT_WF_RFCR_DROP_STBC_MULTI);
-
 	MT76_FILTER(OTHER_BSS, MT_WF_RFCR_DROP_OTHER_TIM |
 			       MT_WF_RFCR_DROP_A3_MAC |
 			       MT_WF_RFCR_DROP_A3_BSSID);
@@ -530,12 +579,23 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_CTL_RSV);
 
 	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
 
-	if (*total_flags & FIF_CONTROL)
-		mt76_clear(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
-	else
-		mt76_set(dev, MT_WF_RFCR1(phy->mt76->band_idx), ctl_flags);
+	mt7996_for_each_phy(dev, phy) {
+		phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
+				   MT_WF_RFCR_DROP_OTHER_BEACON |
+				   MT_WF_RFCR_DROP_FRAME_REPORT |
+				   MT_WF_RFCR_DROP_PROBEREQ |
+				   MT_WF_RFCR_DROP_MCAST_FILTERED |
+				   MT_WF_RFCR_DROP_MCAST |
+				   MT_WF_RFCR_DROP_BCAST |
+				   MT_WF_RFCR_DROP_DUPLICATE |
+				   MT_WF_RFCR_DROP_A2_BSSID |
+				   MT_WF_RFCR_DROP_UNWANTED_CTL |
+				   MT_WF_RFCR_DROP_STBC_MULTI |
+				   filter_mask);
+		phy->rxfilter |= filter_set;
+		mt7996_phy_set_rxfilter(phy);
+	}
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -593,12 +653,25 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_vif_link *mvif = mt76_vif_conf_link(&dev->mt76, vif, info);
+	struct mt76_vif_link *mvif;
+	struct mt7996_vif_link *link;
+	struct mt7996_phy *phy;
+	struct mt76_phy *mphy;
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mvif = mt76_vif_conf_link(&dev->mt76, vif, info);
+	if (!mvif)
+		goto out;
+
+	link = container_of(mvif, struct mt7996_vif_link, mt76);
+	mphy = mt76_vif_link_phy(mvif);
+	if (!mphy)
+		goto out;
+
+	phy = mphy->priv;
+
 	/* station mode uses BSSID to map the wlan entry to a peer,
 	 * and then peer references bss_info_rfch to set bandwidth cap.
 	 */
@@ -660,6 +733,13 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		mt7996_update_mu_group(hw, vif, info);
 
+	if (changed & BSS_CHANGED_TXPOWER &&
+	    info->txpower != phy->txpower) {
+		phy->txpower = info->txpower;
+		mt7996_mcu_set_txpower_sku(phy);
+	}
+
+out:
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -777,6 +857,22 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 
+	if (vif) {
+		struct mt7996_vif *mvif;
+
+		mvif = (struct mt7996_vif *)vif->drv_priv;
+		wcid = &mvif->deflink.sta.wcid;
+
+		if (mvif->mt76.roc_phy &&
+		    (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
+			mphy = mvif->mt76.roc_phy;
+			if (mphy->roc_link)
+				wcid = mphy->roc_link->wcid;
+		} else {
+			mphy = mt76_vif_link_phy(&mvif->deflink.mt76);
+		}
+	}
+
 	if (control->sta) {
 		struct mt7996_sta *sta;
 
@@ -784,11 +880,9 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		wcid = &sta->wcid;
 	}
 
-	if (vif && !control->sta) {
-		struct mt7996_vif *mvif;
-
-		mvif = (struct mt7996_vif *)vif->drv_priv;
-		wcid = &mvif->deflink.sta.wcid;
+	if (!mphy) {
+		ieee80211_free_txskb(hw, skb);
+		return;
 	}
 
 	mt76_tx(mphy, control->sta, wcid, skb);
@@ -796,12 +890,20 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 
 static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	int ret;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	int i, ret;
 
-	mutex_lock(&phy->dev->mt76.mutex);
-	ret = mt7996_mcu_set_rts_thresh(phy, val);
-	mutex_unlock(&phy->dev->mt76.mutex);
+	mutex_lock(&dev->mt76.mutex);
+
+	for (i = 0; i < hw->wiphy->n_radio; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+
+		ret = mt7996_mcu_set_rts_thresh(phy, val);
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
 }
@@ -867,16 +969,21 @@ static int
 mt7996_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_mib_stats *mib = &phy->mib;
+	int i;
 
 	mutex_lock(&dev->mt76.mutex);
 
-	stats->dot11RTSSuccessCount = mib->rts_cnt;
-	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
-	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
-	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+	memset(stats, 0, sizeof(*stats));
+	for (i = 0; i < hw->wiphy->n_radio; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+		struct mt76_mib_stats *mib = &phy->mib;
+
+		stats->dot11RTSSuccessCount += mib->rts_cnt;
+		stats->dot11RTSFailureCount += mib->rts_retries_cnt;
+		stats->dot11FCSErrorCount += mib->fcs_err_cnt;
+		stats->dot11ACKFailureCount += mib->ack_fail_cnt;
+	}
 
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -886,13 +993,16 @@ mt7996_get_stats(struct ieee80211_hw *hw,
 u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf;
 	u16 n;
 
+	if (!phy)
+		return 0;
+
 	lockdep_assert_held(&dev->mt76.mutex);
 
 	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
@@ -926,13 +1036,16 @@ mt7996_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
+	if (!phy)
+		return;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
@@ -952,13 +1065,16 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
+	if (!phy)
+		return;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
@@ -975,12 +1091,14 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static void
 mt7996_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy;
 
 	mutex_lock(&dev->mt76.mutex);
-	phy->coverage_class = max_t(s16, coverage_class, 0);
-	mt7996_mac_set_coverage_class(phy);
+	mt7996_for_each_phy(dev, phy) {
+		phy->coverage_class = max_t(s16, coverage_class, 0);
+		mt7996_mac_set_coverage_class(phy);
+	}
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -988,33 +1106,33 @@ static int
 mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
-	u8 band_idx = phy->mt76->band_idx, shift = dev->chainshift[band_idx];
+	int i;
 
-	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+	if (tx_ant != rx_ant)
 		return -EINVAL;
 
-	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
-		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+	for (i = 0; i < hw->wiphy->n_radio; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+
+		if (!(tx_ant & phy->orig_chainmask))
+			return -EINVAL;
+	}
 
 	mutex_lock(&dev->mt76.mutex);
 
-	phy->mt76->antenna_mask = tx_ant;
+	for (i = 0; i < hw->wiphy->n_radio; i++) {
+		struct mt7996_phy *phy = dev->radio_phy[i];
+		u8 band_idx = phy->mt76->band_idx;
+		u8 shift = dev->chainshift[band_idx];
 
-	/* restore to the origin chainmask which might have auxiliary path */
-	if (hweight8(tx_ant) == max_nss && band_idx < MT_BAND2)
-		phy->mt76->chainmask = ((dev->chainmask >> shift) &
-					(BIT(dev->chainshift[band_idx + 1] - shift) - 1)) << shift;
-	else if (hweight8(tx_ant) == max_nss)
-		phy->mt76->chainmask = (dev->chainmask >> shift) << shift;
-	else
-		phy->mt76->chainmask = tx_ant << shift;
+		phy->mt76->chainmask = tx_ant & phy->orig_chainmask;
+		phy->mt76->antenna_mask = phy->mt76->chainmask >> shift;
 
-	mt76_set_stream_caps(phy->mt76, true);
-	mt7996_set_stream_vht_txbf_caps(phy);
-	mt7996_set_stream_he_eht_caps(phy);
-	mt7996_mcu_set_txpower_sku(phy);
+		mt76_set_stream_caps(phy->mt76, true);
+		mt7996_set_stream_vht_txbf_caps(phy);
+		mt7996_set_stream_he_eht_caps(phy);
+		mt7996_mcu_set_txpower_sku(phy);
+	}
 
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -1026,7 +1144,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  struct station_info *sinfo)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
 
@@ -1060,7 +1178,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 
-	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 		sinfo->tx_bytes = msta->wcid.stats.tx_bytes;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 
@@ -1093,9 +1211,8 @@ static void mt7996_sta_rc_update(struct ieee80211_hw *hw,
 				 struct ieee80211_link_sta *link_sta,
 				 u32 changed)
 {
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct ieee80211_sta *sta = link_sta->sta;
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_dev *dev = phy->dev;
 
 	mt7996_sta_rc_work(&changed, sta);
 	ieee80211_queue_work(hw, &dev->rc_work);
@@ -1105,9 +1222,8 @@ static int
 mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			const struct cfg80211_bitrate_mask *mask)
 {
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_dev *dev = phy->dev;
 	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 
 	mvif->deflink.bitrate_mask = *mask;
@@ -1306,8 +1422,8 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 			 struct ethtool_stats *stats, u64 *data)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
@@ -1316,6 +1432,9 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 	/* See mt7996_ampdu_stat_read_phy, etc */
 	int i, ei = 0;
 
+	if (!phy)
+		return;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	mt7996_mac_update_stats(phy);
@@ -1409,11 +1528,14 @@ static int
 mt7996_set_radar_background(struct ieee80211_hw *hw,
 			    struct cfg80211_chan_def *chandef)
 {
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_band_phy(dev, chandef->chan->band);
 	int ret = -EINVAL;
 	bool running;
 
+	if (!phy)
+	    return -EINVAL;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	if (dev->mt76.region == NL80211_DFS_UNSET)
@@ -1464,9 +1586,14 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_vif_link *mlink = &mvif->deflink;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct mt7996_phy *phy;
+
+	phy = mt7996_vif_link_phy(mlink);
+	if (!phy)
+		return -ENODEV;
 
 	if (phy != &dev->phy && phy->mt76->band_idx == MT_BAND2)
 		wed = &dev->mt76.mmio.wed_hif2;
@@ -1493,10 +1620,12 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 #endif
 
 const struct ieee80211_ops mt7996_ops = {
-	.add_chanctx = ieee80211_emulate_add_chanctx,
-	.remove_chanctx = ieee80211_emulate_remove_chanctx,
-	.change_chanctx = ieee80211_emulate_change_chanctx,
-	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
+	.add_chanctx = mt76_add_chanctx,
+	.remove_chanctx = mt76_remove_chanctx,
+	.change_chanctx = mt76_change_chanctx,
+	.assign_vif_chanctx = mt76_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt76_unassign_vif_chanctx,
+	.switch_vif_chanctx = mt76_switch_vif_chanctx,
 	.tx = mt7996_tx,
 	.start = mt7996_start,
 	.stop = mt7996_stop,
@@ -1515,6 +1644,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.hw_scan = mt76_hw_scan,
 	.cancel_hw_scan = mt76_cancel_hw_scan,
+	.remain_on_channel = mt76_remain_on_channel,
+	.cancel_remain_on_channel = mt76_cancel_remain_on_channel,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7996_channel_switch_beacon,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ada019e44712..6abd666ff19d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2572,18 +2572,24 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 #define OFFLOAD_TX_MODE_SU	BIT(0)
 #define OFFLOAD_TX_MODE_MU	BIT(1)
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->deflink.phy->mt76->chandef;
-	enum nl80211_band band = chandef->chan->band;
+	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	struct bss_inband_discovery_tlv *discov;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *rskb, *skb = NULL;
+	struct cfg80211_chan_def *chandef;
+	enum nl80211_band band;
 	struct tlv *tlv;
 	u8 *buf, interval;
 	int len;
 
+	if (!phy)
+		return -EINVAL;
+
+	chandef = &phy->mt76->chandef;
+	band = chandef->chan->band;
+
 	if (vif->bss_conf.nontransmitted)
 		return 0;
 
@@ -4495,7 +4501,6 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 #define TX_POWER_LIMIT_TABLE_RATE	0
 	struct mt7996_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
-	struct ieee80211_hw *hw = mphy->hw;
 	struct tx_power_limit_table_ctrl {
 		u8 __rsv1[4];
 
@@ -4515,7 +4520,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 	struct sk_buff *skb;
 	int i, tx_power;
 
-	tx_power = mt7996_get_power_bound(phy, hw->conf.power_level);
+	tx_power = mt7996_get_power_bound(phy, phy->txpower);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &la, tx_power);
 	mphy->txpower_cur = tx_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index f9aa12866a2e..d85abec19c6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -605,6 +605,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
+		.link_data_size = sizeof(struct mt7996_vif_link),
 		.drv_flags = MT_DRV_TXWI_NO_FREE |
 			     MT_DRV_AMSDU_OFFLOAD |
 			     MT_DRV_HW_MGMT_TXQ,
@@ -622,6 +623,8 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.sta_remove = mt7996_mac_sta_remove,
 		.update_survey = mt7996_update_channel,
 		.set_channel = mt7996_set_channel,
+		.vif_link_add = mt7996_vif_link_add,
+		.vif_link_remove = mt7996_vif_link_remove,
 	};
 	struct mt7996_dev *dev;
 	struct mt76_dev *mdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index f1384e4e7e7f..18ae2e3ad71b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -11,6 +11,7 @@
 #include "../mt76_connac.h"
 #include "regs.h"
 
+#define MT7996_MAX_RADIOS		3
 #define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
 #define MT7996_WTBL_BMC_SIZE		(is_mt7992(&dev->mt76) ? 32 : 64)
@@ -270,11 +271,15 @@ struct mt7996_phy {
 
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
+	int txpower;
 
 	struct mt76_mib_stats mib;
 	struct mt76_channel_state state_ts;
 
+	u16 orig_chainmask;
+
 	bool has_aux_rx;
+	bool counter_reset;
 };
 
 struct mt7996_dev {
@@ -283,6 +288,10 @@ struct mt7996_dev {
 		struct mt76_phy mphy;
 	};
 
+	struct mt7996_phy *radio_phy[MT7996_MAX_RADIOS];
+	struct wiphy_radio radios[MT7996_MAX_RADIOS];
+	struct wiphy_radio_freq_range radio_freqs[MT7996_MAX_RADIOS];
+
 	struct mt7996_hif *hif2;
 	struct mt7996_reg_desc reg;
 	u8 q_id[MT7996_MAX_QUEUE];
@@ -402,14 +411,6 @@ enum mt7996_rdd_cmd {
 	RDD_IRQ_OFF,
 };
 
-static inline struct mt7996_phy *
-mt7996_hw_phy(struct ieee80211_hw *hw)
-{
-	struct mt76_phy *phy = hw->priv;
-
-	return phy->priv;
-}
-
 static inline struct mt7996_dev *
 mt7996_hw_dev(struct ieee80211_hw *hw)
 {
@@ -469,12 +470,35 @@ mt7996_has_background_radar(struct mt7996_dev *dev)
 	return true;
 }
 
+static inline struct mt7996_phy *
+mt7996_band_phy(struct mt7996_dev *dev, enum nl80211_band band)
+{
+	struct mt76_phy *mphy;
+
+	mphy = dev->mt76.band_phys[band];
+	if (!mphy)
+		return NULL;
+
+	return mphy->priv;
+}
+
 static inline struct mt7996_vif_link *
 mt7996_vif_link(struct mt7996_dev *dev, struct ieee80211_vif *vif, int link_id)
 {
 	return (struct mt7996_vif_link *)mt76_vif_link(&dev->mt76, vif, link_id);
 }
 
+static inline struct mt7996_phy *
+mt7996_vif_link_phy(struct mt7996_vif_link *link)
+{
+	struct mt76_phy *mphy = mt76_vif_link_phy(&link->mt76);
+
+	if (!mphy)
+		return NULL;
+
+	return mphy->priv;
+}
+
 static inline struct mt7996_vif_link *
 mt7996_vif_conf_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		     struct ieee80211_bss_conf *link_conf)
@@ -483,6 +507,10 @@ mt7996_vif_conf_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 							    link_conf);
 }
 
+#define mt7996_for_each_phy(dev, phy)					\
+	for (int __i = 0; __i < ARRAY_SIZE((dev)->radio_phy); __i++)	\
+		if (((phy) = (dev)->radio_phy[__i]) != NULL)
+
 extern const struct ieee80211_ops mt7996_ops;
 extern struct pci_driver mt7996_pci_driver;
 extern struct pci_driver mt7996_hif_driver;
@@ -494,6 +522,12 @@ irqreturn_t mt7996_irq_handler(int irq, void *dev_instance);
 u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif);
 int mt7996_register_device(struct mt7996_dev *dev);
 void mt7996_unregister_device(struct mt7996_dev *dev);
+int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link_conf,
+			struct mt76_vif_link *mlink);
+void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink);
 int mt7996_eeprom_init(struct mt7996_dev *dev);
 int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy);
 int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
@@ -509,7 +543,7 @@ int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx,
 void mt7996_init_txpower(struct mt7996_phy *phy);
 int mt7996_txbf_init(struct mt7996_dev *dev);
 void mt7996_reset(struct mt7996_dev *dev);
-int mt7996_run(struct ieee80211_hw *hw);
+int mt7996_run(struct mt7996_phy *phy);
 int mt7996_mcu_init(struct mt7996_dev *dev);
 int mt7996_mcu_init_firmware(struct mt7996_dev *dev);
 int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
-- 
2.47.1


