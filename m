Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50702362AE7
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhDPWQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 18:16:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230056AbhDPWQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 18:16:54 -0400
X-UUID: 89dbaf7a43bc474dac8d0fc413064587-20210417
X-UUID: 89dbaf7a43bc474dac8d0fc413064587-20210417
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1554075372; Sat, 17 Apr 2021 06:16:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Apr 2021 06:16:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Apr 2021 06:16:21 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: rework the flow of txpower setting
Date:   Sat, 17 Apr 2021 06:16:18 +0800
Message-ID: <29553b340d653c0cc8b46029e9390db260aeb0ef.1618609024.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6c1be8713dfd1154b5ec61b2b094eb156d9fb659.1618609024.git.ryder.lee@mediatek.com>
References: <6c1be8713dfd1154b5ec61b2b094eb156d9fb659.1618609024.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

Clean up the flow of per-rate txpower limit setting to get rid of
dulplicate work since it has already been handled by firmware, and set
proper max_power based on different channels and regdomains.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  34 ++---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 138 ++++--------------
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  40 +----
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  32 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  29 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  10 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  25 ----
 8 files changed, 79 insertions(+), 231 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 2f706620686e..93bde072fe4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -311,8 +311,7 @@ mt7915_queues_read(struct seq_file *s, void *data)
 }
 
 static void
-mt7915_puts_rate_txpower(struct seq_file *s, s8 *delta,
-			 s8 txpower_cur, int band)
+mt7915_puts_rate_txpower(struct seq_file *s, s8 txpower_cur, int band)
 {
 	static const char * const sku_group_name[] = {
 		"CCK", "OFDM", "HT20", "HT40",
@@ -320,24 +319,18 @@ mt7915_puts_rate_txpower(struct seq_file *s, s8 *delta,
 		"RU26", "RU52", "RU106", "RU242/SU20",
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
-	s8 txpower[MT7915_SKU_RATE_NUM];
+	s8 txpower[161];
 	int i, idx = 0;
 
-	for (i = 0; i < MT7915_SKU_RATE_NUM; i++)
-		txpower[i] = DIV_ROUND_UP(txpower_cur + delta[i], 2);
+	for (i = 0; i < ARRAY_SIZE(txpower); i++)
+		txpower[i] = DIV_ROUND_UP(txpower_cur, 2);
 
-	for (i = 0; i < MAX_SKU_RATE_GROUP_NUM; i++) {
-		const struct sku_group *sku = &mt7915_sku_groups[i];
-		u32 offset = sku->offset[band];
-
-		if (!offset) {
-			idx += sku->len;
-			continue;
-		}
+	for (i = 0; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
+		u8 len = mt7915_sku_group_len[i];
 
 		mt76_seq_puts_array(s, sku_group_name[i],
-				    txpower + idx, sku->len);
-		idx += sku->len;
+				    txpower + idx, len);
+		idx += len;
 	}
 }
 
@@ -347,21 +340,18 @@ mt7915_read_rate_txpower(struct seq_file *s, void *data)
 	struct mt7915_dev *dev = dev_get_drvdata(s->private);
 	struct mt76_phy *mphy = &dev->mphy;
 	enum nl80211_band band = mphy->chandef.chan->band;
-	s8 *delta = dev->rate_power[band];
-	s8 txpower_base = mphy->txpower_cur - delta[MT7915_SKU_MAX_DELTA_IDX];
+	s8 txpower = mphy->txpower_cur;
 
 	seq_puts(s, "Band 0:\n");
-	mt7915_puts_rate_txpower(s, delta, txpower_base, band);
+	mt7915_puts_rate_txpower(s, txpower, band);
 
 	if (dev->mt76.phy2) {
 		mphy = dev->mt76.phy2;
 		band = mphy->chandef.chan->band;
-		delta = dev->rate_power[band];
-		txpower_base = mphy->txpower_cur -
-			       delta[MT7915_SKU_MAX_DELTA_IDX];
+		txpower = mphy->txpower_cur;
 
 		seq_puts(s, "Band 1:\n");
-		mt7915_puts_rate_txpower(s, delta, txpower_base, band);
+		mt7915_puts_rate_txpower(s, txpower, band);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 738ecf8f4fa2..18be0d659406 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -151,120 +151,38 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 	return target_power;
 }
 
-static const u8 sku_cck_delta_map[] = {
-	SKU_CCK_GROUP0,
-	SKU_CCK_GROUP0,
-	SKU_CCK_GROUP1,
-	SKU_CCK_GROUP1,
-};
-
-static const u8 sku_ofdm_delta_map[] = {
-	SKU_OFDM_GROUP0,
-	SKU_OFDM_GROUP0,
-	SKU_OFDM_GROUP1,
-	SKU_OFDM_GROUP1,
-	SKU_OFDM_GROUP2,
-	SKU_OFDM_GROUP2,
-	SKU_OFDM_GROUP3,
-	SKU_OFDM_GROUP4,
-};
-
-static const u8 sku_mcs_delta_map[] = {
-	SKU_MCS_GROUP0,
-	SKU_MCS_GROUP1,
-	SKU_MCS_GROUP1,
-	SKU_MCS_GROUP2,
-	SKU_MCS_GROUP2,
-	SKU_MCS_GROUP3,
-	SKU_MCS_GROUP4,
-	SKU_MCS_GROUP5,
-	SKU_MCS_GROUP6,
-	SKU_MCS_GROUP7,
-	SKU_MCS_GROUP8,
-	SKU_MCS_GROUP9,
-};
-
-#define SKU_GROUP(_mode, _len, _ofs_2g, _ofs_5g, _map)	\
-	[_mode] = {					\
-	.len = _len,					\
-	.offset = {					\
-		_ofs_2g,				\
-		_ofs_5g,				\
-	},						\
-	.delta_map = _map				\
-}
-
-const struct sku_group mt7915_sku_groups[] = {
-	SKU_GROUP(SKU_CCK, 4, 0x252, 0, sku_cck_delta_map),
-	SKU_GROUP(SKU_OFDM, 8, 0x254, 0x29d, sku_ofdm_delta_map),
-
-	SKU_GROUP(SKU_HT_BW20, 8, 0x259, 0x2a2, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HT_BW40, 9, 0x262, 0x2ab, sku_mcs_delta_map),
-	SKU_GROUP(SKU_VHT_BW20, 12, 0x259, 0x2a2, sku_mcs_delta_map),
-	SKU_GROUP(SKU_VHT_BW40, 12, 0x262, 0x2ab, sku_mcs_delta_map),
-	SKU_GROUP(SKU_VHT_BW80, 12, 0, 0x2b4, sku_mcs_delta_map),
-	SKU_GROUP(SKU_VHT_BW160, 12, 0, 0, sku_mcs_delta_map),
-
-	SKU_GROUP(SKU_HE_RU26, 12, 0x27f, 0x2dd, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU52, 12, 0x289, 0x2e7, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU106, 12, 0x293, 0x2f1, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU242, 12, 0x26b, 0x2bf, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU484, 12, 0x275, 0x2c9, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU996, 12, 0, 0x2d3, sku_mcs_delta_map),
-	SKU_GROUP(SKU_HE_RU2x996, 12, 0, 0, sku_mcs_delta_map),
-};
-
-static s8
-mt7915_get_sku_delta(struct mt7915_dev *dev, u32 addr)
+s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 {
-	u32 val = mt7915_eeprom_read(dev, addr);
-	s8 delta = FIELD_GET(SKU_DELTA_VAL, val);
+	u32 val;
+	s8 delta;
 
-	if (!(val & SKU_DELTA_EN))
-		return 0;
+	if (band == NL80211_BAND_2GHZ)
+		val = mt7915_eeprom_read(dev, MT_EE_RATE_DELTA_2G);
+	else
+		val = mt7915_eeprom_read(dev, MT_EE_RATE_DELTA_5G);
 
-	return val & SKU_DELTA_ADD ? delta : -delta;
-}
+	if (!(val & MT_EE_RATE_DELTA_EN))
+		return 0;
 
-static void
-mt7915_eeprom_init_sku_band(struct mt7915_dev *dev,
-			    struct ieee80211_supported_band *sband)
-{
-	int i, band = sband->band;
-	s8 *rate_power = dev->rate_power[band], max_delta = 0;
-	u8 idx = 0;
-
-	for (i = 0; i < ARRAY_SIZE(mt7915_sku_groups); i++) {
-		const struct sku_group *sku = &mt7915_sku_groups[i];
-		u32 offset = sku->offset[band];
-		int j;
-
-		if (!offset) {
-			idx += sku->len;
-			continue;
-		}
-
-		rate_power[idx++] = mt7915_get_sku_delta(dev, offset);
-		if (rate_power[idx - 1] > max_delta)
-			max_delta = rate_power[idx - 1];
-
-		if (i == SKU_HT_BW20 || i == SKU_VHT_BW20)
-			offset += 1;
-
-		for (j = 1; j < sku->len; j++) {
-			u32 addr = offset + sku->delta_map[j];
-
-			rate_power[idx++] = mt7915_get_sku_delta(dev, addr);
-			if (rate_power[idx - 1] > max_delta)
-				max_delta = rate_power[idx - 1];
-		}
-	}
+	delta = FIELD_GET(MT_EE_RATE_DELTA_MASK, val);
 
-	rate_power[idx] = max_delta;
+	return val & MT_EE_RATE_DELTA_SIGN ? delta : -delta;
 }
 
-void mt7915_eeprom_init_sku(struct mt7915_dev *dev)
-{
-	mt7915_eeprom_init_sku_band(dev, &dev->mphy.sband_2g.sband);
-	mt7915_eeprom_init_sku_band(dev, &dev->mphy.sband_5g.sband);
-}
+const u8 mt7915_sku_group_len[] = {
+	[SKU_CCK] = 4,
+	[SKU_OFDM] = 8,
+	[SKU_HT_BW20] = 8,
+	[SKU_HT_BW40] = 9,
+	[SKU_VHT_BW20] = 12,
+	[SKU_VHT_BW40] = 12,
+	[SKU_VHT_BW80] = 12,
+	[SKU_VHT_BW160] = 12,
+	[SKU_HE_RU26] = 12,
+	[SKU_HE_RU52] = 12,
+	[SKU_HE_RU106] = 12,
+	[SKU_HE_RU242] = 12,
+	[SKU_HE_RU484] = 12,
+	[SKU_HE_RU996] = 12,
+	[SKU_HE_RU2x996] = 12
+};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 3ee8c27bb61b..9d92f95c35da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -18,6 +18,8 @@ enum mt7915_eeprom_field {
 	MT_EE_MAC_ADDR2 =	0x00a,
 	MT_EE_DDIE_FT_VERSION =	0x050,
 	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_RATE_DELTA_2G =	0x252,
+	MT_EE_RATE_DELTA_5G =	0x29d,
 	MT_EE_TX0_POWER_2G =	0x2fc,
 	MT_EE_TX0_POWER_5G =	0x34b,
 	MT_EE_ADIE_FT_VERSION =	0x9a0,
@@ -34,6 +36,10 @@ enum mt7915_eeprom_field {
 #define MT_EE_WIFI_CONF7_TSSI0_5G		BIT(2)
 #define MT_EE_WIFI_CONF7_TSSI1_5G		BIT(4)
 
+#define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
+#define MT_EE_RATE_DELTA_SIGN			BIT(6)
+#define MT_EE_RATE_DELTA_EN			BIT(7)
+
 enum mt7915_eeprom_band {
 	MT_EE_BAND_SEL_DEFAULT,
 	MT_EE_BAND_SEL_5GHZ,
@@ -41,32 +47,6 @@ enum mt7915_eeprom_band {
 	MT_EE_BAND_SEL_DUAL,
 };
 
-#define SKU_DELTA_VAL		GENMASK(5, 0)
-#define SKU_DELTA_ADD		BIT(6)
-#define SKU_DELTA_EN		BIT(7)
-
-enum mt7915_sku_delta_group {
-	SKU_CCK_GROUP0,
-	SKU_CCK_GROUP1,
-
-	SKU_OFDM_GROUP0 = 0,
-	SKU_OFDM_GROUP1,
-	SKU_OFDM_GROUP2,
-	SKU_OFDM_GROUP3,
-	SKU_OFDM_GROUP4,
-
-	SKU_MCS_GROUP0 = 0,
-	SKU_MCS_GROUP1,
-	SKU_MCS_GROUP2,
-	SKU_MCS_GROUP3,
-	SKU_MCS_GROUP4,
-	SKU_MCS_GROUP5,
-	SKU_MCS_GROUP6,
-	SKU_MCS_GROUP7,
-	SKU_MCS_GROUP8,
-	SKU_MCS_GROUP9,
-};
-
 enum mt7915_sku_rate_group {
 	SKU_CCK,
 	SKU_OFDM,
@@ -86,12 +66,6 @@ enum mt7915_sku_rate_group {
 	MAX_SKU_RATE_GROUP_NUM,
 };
 
-struct sku_group {
-	u8 len;
-	u16 offset[2];
-	const u8 *delta_map;
-};
-
 static inline int
 mt7915_get_channel_group(int channel)
 {
@@ -124,6 +98,6 @@ mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 		return eep[MT_EE_WIFI_CONF + 7] & MT_EE_WIFI_CONF7_TSSI0_2G;
 }
 
-extern const struct sku_group mt7915_sku_groups[];
+extern const u8 mt7915_sku_group_len[MAX_SKU_RATE_GROUP_NUM];
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c91ec7bd674d..c2d6b3c23344 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -77,8 +77,12 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	struct mt7915_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
+	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
+	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
+
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
@@ -208,10 +212,13 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
 }
 
 static void
-mt7915_init_txpower_band(struct mt7915_dev *dev,
-			 struct ieee80211_supported_band *sband)
+mt7915_init_txpower(struct mt7915_dev *dev,
+		    struct ieee80211_supported_band *sband)
 {
 	int i, n_chains = hweight8(dev->mphy.antenna_mask);
+	int nss_delta = mt76_tx_power_nss_delta(n_chains);
+	int pwr_delta = mt7915_eeprom_get_power_delta(dev, sband->band);
+	struct mt76_power_limits limits;
 
 	for (i = 0; i < sband->n_channels; i++) {
 		struct ieee80211_channel *chan = &sband->channels[i];
@@ -225,20 +232,18 @@ mt7915_init_txpower_band(struct mt7915_dev *dev,
 			target_power = max(target_power, val);
 		}
 
+		target_power += pwr_delta;
+		target_power = mt76_get_rate_power_limits(&dev->mphy, chan,
+							  &limits,
+							  target_power);
+		target_power += nss_delta;
+		target_power = DIV_ROUND_UP(target_power, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
-					target_power / 2);
-		chan->orig_mpwr = target_power / 2;
+					target_power);
+		chan->orig_mpwr = target_power;
 	}
 }
 
-static void mt7915_init_txpower(struct mt7915_dev *dev)
-{
-	mt7915_init_txpower_band(dev, &dev->mphy.sband_2g.sband);
-	mt7915_init_txpower_band(dev, &dev->mphy.sband_5g.sband);
-
-	mt7915_eeprom_init_sku(dev);
-}
-
 static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy = mt7915_ext_phy(dev);
@@ -295,7 +300,8 @@ static void mt7915_init_work(struct work_struct *work)
 
 	mt7915_mcu_set_eeprom(dev);
 	mt7915_mac_init(dev);
-	mt7915_init_txpower(dev);
+	mt7915_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7915_init_txpower(dev, &dev->mphy.sband_5g.sband);
 	mt7915_txbf_init(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2fd87987312e..2474528de241 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -423,7 +423,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		ret = mt7915_mcu_set_sku(phy);
+		ret = mt7915_mcu_set_txpower_sku(phy);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3d88a05aad5d..77044467f31a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3361,8 +3361,9 @@ int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
 				 sizeof(req), false);
 }
 
-int mt7915_mcu_set_sku(struct mt7915_phy *phy)
+int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 {
+#define MT7915_SKU_RATE_NUM		161
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
@@ -3376,11 +3377,10 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 		.dbdc_idx = phy != &dev->phy,
 	};
 	struct mt76_power_limits limits_array;
-	s8 *delta, *la = (s8 *)&limits_array;
+	s8 *la = (s8 *)&limits_array;
 	int i, idx, n_chains = hweight8(mphy->antenna_mask);
 	int tx_power;
 
-	delta = dev->rate_power[mphy->chandef.chan->band];
 	tx_power = hw->conf.power_level * 2 -
 		   mt76_tx_power_nss_delta(n_chains);
 
@@ -3388,10 +3388,8 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 					      &limits_array, tx_power);
 	mphy->txpower_cur = tx_power;
 
-	for (i = 0, idx = 0; i < MAX_SKU_RATE_GROUP_NUM; i++) {
-		const struct sku_group *sku = &mt7915_sku_groups[i];
-		u32 offset = sku->offset[mphy->chandef.chan->band];
-		u8 mcs_num = sku->len;
+	for (i = 0, idx = 0; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
+		u8 mcs_num, len = mt7915_sku_group_len[i];
 		int j;
 
 		if (i >= SKU_HT_BW20 && i <= SKU_VHT_BW160) {
@@ -3399,22 +3397,15 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 
 			if (i == SKU_HT_BW20 || i == SKU_VHT_BW20)
 				la = (s8 *)&limits_array + 12;
+		} else {
+			mcs_num = len;
 		}
 
-		if (!offset) {
-			idx += sku->len;
-			la += mcs_num;
-			continue;
-		}
-
-		for (j = 0; j < min_t(u8, mcs_num, sku->len); j++) {
-			s8 rate_power;
+		for (j = 0; j < min_t(u8, mcs_num, len); j++)
+			req.val[idx + j] = la[j];
 
-			rate_power = hw->conf.power_level * 2 + delta[idx + j];
-			req.val[idx + j] = min_t(s8, la[j], rate_power);
-		}
 		la += mcs_num;
-		idx += sku->len;
+		idx += len;
 	}
 
 	return mt76_mcu_send_msg(&dev->mt76,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index dbc70c0d6668..397ad71c405a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -39,10 +39,6 @@
 #define MT7915_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
 #define MT7915_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
-#define MT7915_SKU_RATE_NUM		161
-#define MT7915_SKU_MAX_DELTA_IDX	MT7915_SKU_RATE_NUM
-#define MT7915_SKU_TABLE_SIZE		(MT7915_SKU_RATE_NUM + 1)
-
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -195,8 +191,6 @@ struct mt7915_dev {
 	int token_count;
 	struct idr token;
 
-	s8 **rate_power; /* TODO: use mt76_rate_power */
-
 	bool dbdc_support;
 	bool flash_mode;
 	bool fw_debug;
@@ -300,7 +294,7 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy);
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx);
-void mt7915_eeprom_init_sku(struct mt7915_dev *dev);
+s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band);
 int mt7915_dma_init(struct mt7915_dev *dev);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
@@ -350,7 +344,7 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
 int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val);
 int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
-int mt7915_mcu_set_sku(struct mt7915_phy *phy);
+int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev);
 int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev);
 int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 75769595d1e1..ebfc4c15fef2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -154,28 +154,6 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-static int
-mt7915_alloc_device(struct pci_dev *pdev, struct mt7915_dev *dev)
-{
-#define NUM_BANDS	2
-	int i;
-	s8 **sku;
-
-	sku = devm_kzalloc(&pdev->dev, NUM_BANDS * sizeof(*sku), GFP_KERNEL);
-	if (!sku)
-		return -ENOMEM;
-
-	for (i = 0; i < NUM_BANDS; i++) {
-		sku[i] = devm_kzalloc(&pdev->dev, MT7915_SKU_TABLE_SIZE *
-				      sizeof(**sku), GFP_KERNEL);
-		if (!sku[i])
-			return -ENOMEM;
-	}
-	dev->rate_power = sku;
-
-	return 0;
-}
-
 static void mt7915_pci_init_hif2(struct mt7915_dev *dev)
 {
 	struct mt7915_hif *hif;
@@ -270,9 +248,6 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	dev = container_of(mdev, struct mt7915_dev, mt76);
-	ret = mt7915_alloc_device(pdev, dev);
-	if (ret)
-		goto error;
 
 	ret = mt7915_mmio_init(mdev, pcim_iomap_table(pdev)[0], pdev->irq);
 	if (ret)
-- 
2.18.0

