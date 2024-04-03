Return-Path: <linux-wireless+bounces-5810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BA896D6A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014D41F29FB9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0149B1411D6;
	Wed,  3 Apr 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="tgKHhlIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310EC136980
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141755; cv=none; b=Q8ZredqgxHAAVLXdoPUiESnKzH45rgA/IRbeGdRB0HIbVG21f4GuySuN4+ECYbjkwLsvZm/wp0xDI24/QmDHwnPZxBuGt7mti5KQtaKQW/e5mVDHCrLUG1jvtIllUcbrTZO6ofjsEnJHoOxRhiaCOHs5Qm2+Kk52HCFAjrCrmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141755; c=relaxed/simple;
	bh=Yq736rvx3okFLej+HgKm4Exb5yRepr1ReFP+Elzd4zI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlS16pScH+GTGel/EGIZR4Xq84jIND9V6syhd79bxabhb/5g0+WOFSEDuWlmvz6psdMyo+h6YSGJK2L+ghMTrj9g2BhJVXVsNYUTvuCcfT7n/YXZ+aeLEaxxUmXIyRKM1Xp7F1f6woWKUYjU6tE/PtYrYfsz5tgxQdFaKJIHISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=tgKHhlIq; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xDzossjp47zc17tFP954RN2PKEjXyCsR0Hvpf5sISG4=; b=tgKHhlIqKZFlA4+FyoO8MoLdsB
	fFwe7T+SEknEU0PU4cN3+5RRJ2vZ245H62uqgGHVeEFSbKVYw3nJaHCsmYFVbCptSx+yPsP0WUxt8
	kWOfgWMdBULQVvbFquOF2zGhW0SMZDDFqwkUn1Io9OeTELAD5g33vPmxZRpY40uwvjoQ=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt4-00CgfA-AR
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 10/13] wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
Date: Wed,  3 Apr 2024 12:30:29 +0200
Message-ID: <20240403103032.54823-10-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add pre-calibration for mt7986 and mt7916. It has different data size
with mt7915. Group cal needs 54k and 94k for 2G + 5G and 2G + 6G,
respectively. DPD cal needs 300k.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  16 ++-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  47 +++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 113 ++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +
 4 files changed, 147 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 3bb2643d1b26..5fdcbb521ff7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -9,28 +9,26 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	u8 *eeprom = mdev->eeprom.data;
-	u32 val = eeprom[MT_EE_DO_PRE_CAL];
-	u32 offs;
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
+	u32 size, val = eeprom[offs];
 	int ret;
 
-	if (!dev->flash_mode)
+	if (!dev->flash_mode || !val)
 		return 0;
 
-	if (val != (MT_EE_WIFI_CAL_DPD | MT_EE_WIFI_CAL_GROUP))
-		return 0;
+	size = mt7915_get_cal_group_size(dev) + mt7915_get_cal_dpd_size(dev);
 
-	val = MT_EE_CAL_GROUP_SIZE + MT_EE_CAL_DPD_SIZE;
-	dev->cal = devm_kzalloc(mdev->dev, val, GFP_KERNEL);
+	dev->cal = devm_kzalloc(mdev->dev, size, GFP_KERNEL);
 	if (!dev->cal)
 		return -ENOMEM;
 
 	offs = is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
 
-	ret = mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
+	ret = mt76_get_of_data_from_mtd(mdev, dev->cal, offs, size);
 	if (!ret)
 		return ret;
 
-	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", val);
+	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", size);
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index adc26a222823..509fb43d8a68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -19,6 +19,7 @@ enum mt7915_eeprom_field {
 	MT_EE_DDIE_FT_VERSION =	0x050,
 	MT_EE_DO_PRE_CAL =	0x062,
 	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_DO_PRE_CAL_V2 =	0x19a,
 	MT_EE_RATE_DELTA_2G =	0x252,
 	MT_EE_RATE_DELTA_5G =	0x29d,
 	MT_EE_TX0_POWER_2G =	0x2fc,
@@ -39,10 +40,19 @@ enum mt7915_eeprom_field {
 };
 
 #define MT_EE_WIFI_CAL_GROUP			BIT(0)
-#define MT_EE_WIFI_CAL_DPD			GENMASK(2, 1)
+#define MT_EE_WIFI_CAL_DPD_2G			BIT(2)
+#define MT_EE_WIFI_CAL_DPD_5G			BIT(1)
+#define MT_EE_WIFI_CAL_DPD_6G			BIT(3)
+#define MT_EE_WIFI_CAL_DPD			GENMASK(3, 1)
 #define MT_EE_CAL_UNIT				1024
-#define MT_EE_CAL_GROUP_SIZE			(49 * MT_EE_CAL_UNIT + 16)
-#define MT_EE_CAL_DPD_SIZE			(54 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_GROUP_SIZE_7915		(49 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7916		(54 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7975		(54 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7976		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7916_6G		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_DPD_SIZE_V1			(54 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_DPD_SIZE_V2			(300 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_DPD_SIZE_V2_7981		(102 * MT_EE_CAL_UNIT)	/* no 6g dpd data */
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
@@ -156,6 +166,37 @@ mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 		return val & MT_EE_WIFI_CONF7_TSSI0_5G;
 }
 
+static inline u32
+mt7915_get_cal_group_size(struct mt7915_dev *dev)
+{
+	u8 *eep = dev->mt76.eeprom.data;
+	u32 val;
+
+	if (is_mt7915(&dev->mt76)) {
+		return MT_EE_CAL_GROUP_SIZE_7915;
+	} else if (is_mt7916(&dev->mt76)) {
+		val = eep[MT_EE_WIFI_CONF + 1];
+		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+		return (val == MT_EE_V2_BAND_SEL_6GHZ) ? MT_EE_CAL_GROUP_SIZE_7916_6G :
+							 MT_EE_CAL_GROUP_SIZE_7916;
+	} else if (mt7915_check_adie(dev, false)) {
+		return MT_EE_CAL_GROUP_SIZE_7976;
+	} else {
+		return MT_EE_CAL_GROUP_SIZE_7975;
+	}
+}
+
+static inline u32
+mt7915_get_cal_dpd_size(struct mt7915_dev *dev)
+{
+	if (is_mt7915(&dev->mt76))
+		return MT_EE_CAL_DPD_SIZE_V1;
+	else if (is_mt7981(&dev->mt76))
+		return MT_EE_CAL_DPD_SIZE_V2_7981;
+	else
+		return MT_EE_CAL_DPD_SIZE_V2;
+}
+
 extern const u8 mt7915_sku_group_len[MAX_SKU_RATE_GROUP_NUM];
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 398afab447c7..a61e71237a02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2903,9 +2903,10 @@ static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev)
 {
 	u8 idx = 0, *cal = dev->cal, *eep = dev->mt76.eeprom.data;
-	u32 total = MT_EE_CAL_GROUP_SIZE;
+	u32 total = mt7915_get_cal_group_size(dev);
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
 
-	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_GROUP))
+	if (!(eep[offs] & MT_EE_WIFI_CAL_GROUP))
 		return 0;
 
 	/*
@@ -2941,9 +2942,9 @@ static int mt7915_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
 	return -1;
 }
 
-static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
+static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
 {
-	static const u16 freq_list[] = {
+	const u16 freq_list_v1[] = {
 		5180, 5200, 5220, 5240,
 		5260, 5280, 5300, 5320,
 		5500, 5520, 5540, 5560,
@@ -2951,65 +2952,135 @@ static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
 		5660, 5680, 5700, 5745,
 		5765, 5785, 5805, 5825
 	};
-	int offset_2g = ARRAY_SIZE(freq_list);
+	const u16 freq_list_v2[] = {
+		/* 6G BW20*/
+		5955, 5975, 5995, 6015,
+		6035, 6055, 6075, 6095,
+		6115, 6135, 6155, 6175,
+		6195, 6215, 6235, 6255,
+		6275, 6295, 6315, 6335,
+		6355, 6375, 6395, 6415,
+		6435, 6455, 6475, 6495,
+		6515, 6535, 6555, 6575,
+		6595, 6615, 6635, 6655,
+		6675, 6695, 6715, 6735,
+		6755, 6775, 6795, 6815,
+		6835, 6855, 6875, 6895,
+		6915, 6935, 6955, 6975,
+		6995, 7015, 7035, 7055,
+		7075, 7095, 7115,
+		/* 6G BW160 */
+		6025, 6185, 6345, 6505,
+		6665, 6825, 6985,
+		/* 5G BW20 */
+		5180, 5200, 5220, 5240,
+		5260, 5280, 5300, 5320,
+		5500, 5520, 5540, 5560,
+		5580, 5600, 5620, 5640,
+		5660, 5680, 5700, 5720,
+		5745, 5765, 5785, 5805,
+		5825, 5845, 5865, 5885,
+		/* 5G BW160 */
+		5250, 5570, 5815
+	};
+	const u16 freq_list_v2_7981[] = {
+		/* 5G BW20 */
+		5180, 5200, 5220, 5240,
+		5260, 5280, 5300, 5320,
+		5500, 5520, 5540, 5560,
+		5580, 5600, 5620, 5640,
+		5660, 5680, 5700, 5720,
+		5745, 5765, 5785, 5805,
+		5825, 5845, 5865, 5885,
+		/* 5G BW160 */
+		5250, 5570, 5815
+	};
+	const u16 *freq_list = freq_list_v1;
+	int n_freqs = ARRAY_SIZE(freq_list_v1);
 	int idx;
 
+	if (!is_mt7915(&dev->mt76)) {
+		if (is_mt7981(&dev->mt76)) {
+			freq_list = freq_list_v2_7981;
+			n_freqs = ARRAY_SIZE(freq_list_v2_7981);
+		} else {
+			freq_list = freq_list_v2;
+			n_freqs = ARRAY_SIZE(freq_list_v2);
+		}
+	}
+
 	if (freq < 4000) {
 		if (freq < 2432)
-			return offset_2g;
+			return n_freqs;
 		if (freq < 2457)
-			return offset_2g + 1;
+			return n_freqs + 1;
 
-		return offset_2g + 2;
+		return n_freqs + 2;
 	}
 
-	if (bw == NL80211_CHAN_WIDTH_80P80 || bw == NL80211_CHAN_WIDTH_160)
+	if (bw == NL80211_CHAN_WIDTH_80P80)
 		return -1;
 
 	if (bw != NL80211_CHAN_WIDTH_20) {
-		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
-					   freq + 10);
+		idx = mt7915_find_freq_idx(freq_list, n_freqs, freq + 10);
 		if (idx >= 0)
 			return idx;
 
-		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
-					   freq - 10);
+		idx = mt7915_find_freq_idx(freq_list, n_freqs, freq - 10);
 		if (idx >= 0)
 			return idx;
 	}
 
-	return mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
+	return mt7915_find_freq_idx(freq_list, n_freqs, freq);
 }
 
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	u16 total = 2, center_freq = chandef->center_freq1;
+	enum nl80211_band band = chandef->chan->band;
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
+	u16 center_freq = chandef->center_freq1;
 	u8 *cal = dev->cal, *eep = dev->mt76.eeprom.data;
+	u8 dpd_mask, cal_num = is_mt7915(&dev->mt76) ? 2 : 3;
 	int idx;
 
-	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_DPD))
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		dpd_mask = MT_EE_WIFI_CAL_DPD_2G;
+		break;
+	case NL80211_BAND_5GHZ:
+		dpd_mask = MT_EE_WIFI_CAL_DPD_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		dpd_mask = MT_EE_WIFI_CAL_DPD_6G;
+		break;
+	default:
+		dpd_mask = 0;
+		break;
+	}
+
+	if (!(eep[offs] & dpd_mask))
 		return 0;
 
-	idx = mt7915_dpd_freq_idx(center_freq, chandef->width);
+	idx = mt7915_dpd_freq_idx(dev, center_freq, chandef->width);
 	if (idx < 0)
 		return -EINVAL;
 
 	/* Items: Tx DPD, Tx Flatness */
-	idx = idx * 2;
-	cal += MT_EE_CAL_GROUP_SIZE;
+	idx = idx * cal_num;
+	cal += mt7915_get_cal_group_size(dev) + (idx * MT_EE_CAL_UNIT);
 
-	while (total--) {
+	while (cal_num--) {
 		int ret;
 
-		cal += (idx * MT_EE_CAL_UNIT);
 		ret = mt7915_mcu_set_pre_cal(dev, idx, cal, MT_EE_CAL_UNIT,
 					     MCU_EXT_CMD(DPD_PRE_CAL_INFO));
 		if (ret)
 			return ret;
 
 		idx++;
+		cal += MT_EE_CAL_UNIT;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6e79bc65f5a5..a30d08eb0656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -302,6 +302,10 @@ struct mt7915_dev {
 	struct rchan *relay_fwlog;
 
 	void *cal;
+	u32 cur_prek_offset;
+	u8 dpd_chan_num_2g;
+	u8 dpd_chan_num_5g;
+	u8 dpd_chan_num_6g;
 
 	struct {
 		u8 debug_wm;
-- 
2.43.0


