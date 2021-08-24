Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49FB3F5BFA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhHXKX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236294AbhHXKXz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4591761357;
        Tue, 24 Aug 2021 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800591;
        bh=ZKCdGx1GjiDkuyKxTg1nFpSsLpUEWRJzTVf61ShnKls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ih4pgf0zSh5JJJ+lqjIVI/DcC45C6MUW1bQxAq7PLamZn/1hOOHaMm2aMpfo1aDZ5
         yQu0hH0RRud57++h9KUlIUx1OEBGaq50WZAcDb+LdNnmo48Pyqj3MKtwlDgUyhwsOe
         2GLs/3AnWc+sb3n0e7OBZd849Av+z09FdyjsS9G4trjjjmOEN17UO6CS0EqajIT9Cs
         /S56ncURHro4xtW7aGsQ3dTT39TE3tMFznj42IDRmJdST6wQWlGGlSi26v3Zv994f7
         1t9cEvePxfiRNECMU4/fG80tgTA0by2jz7JIRZuosGo0u0M9j5Oa0Hl2CoR2a/8Ttc
         qZHuHkvQME9yQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 8/9] mt76: add 6GHz support
Date:   Tue, 24 Aug 2021 12:22:26 +0200
Message-Id: <4c6f43c3413fe91d22d30def6516b37faf6f655d.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce 6GHz channel list in mt76 module. This is a preliminary patch
to unlock 6GHz band for mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 128 ++++++++++++++++--
 1 file changed, 120 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e282c627e25c..c1b2af458691 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -20,6 +20,13 @@
 	.max_power = 30,			\
 }
 
+#define CHAN6G(_idx, _freq) {			\
+	.band = NL80211_BAND_6GHZ,		\
+	.center_freq = (_freq),			\
+	.hw_value = (_idx),			\
+	.max_power = 30,			\
+}
+
 static const struct ieee80211_channel mt76_channels_2ghz[] = {
 	CHAN2G(1, 2412),
 	CHAN2G(2, 2417),
@@ -70,6 +77,72 @@ static const struct ieee80211_channel mt76_channels_5ghz[] = {
 	CHAN5G(173, 5865),
 };
 
+static const struct ieee80211_channel mt76_channels_6ghz[] = {
+	/* UNII-5 */
+	CHAN6G(1, 5955),
+	CHAN6G(5, 5975),
+	CHAN6G(9, 5995),
+	CHAN6G(13, 6015),
+	CHAN6G(17, 6035),
+	CHAN6G(21, 6055),
+	CHAN6G(25, 6075),
+	CHAN6G(29, 6095),
+	CHAN6G(33, 6115),
+	CHAN6G(37, 6135),
+	CHAN6G(41, 6155),
+	CHAN6G(45, 6175),
+	CHAN6G(49, 6195),
+	CHAN6G(53, 6215),
+	CHAN6G(57, 6235),
+	CHAN6G(61, 6255),
+	CHAN6G(65, 6275),
+	CHAN6G(69, 6295),
+	CHAN6G(73, 6315),
+	CHAN6G(77, 6335),
+	CHAN6G(81, 6355),
+	CHAN6G(85, 6375),
+	CHAN6G(89, 6395),
+	CHAN6G(93, 6415),
+	/* UNII-6 */
+	CHAN6G(97, 6435),
+	CHAN6G(101, 6455),
+	CHAN6G(105, 6475),
+	CHAN6G(109, 6495),
+	CHAN6G(113, 6515),
+	CHAN6G(117, 6535),
+	/* UNII-7 */
+	CHAN6G(121, 6555),
+	CHAN6G(125, 6575),
+	CHAN6G(129, 6595),
+	CHAN6G(133, 6615),
+	CHAN6G(137, 6635),
+	CHAN6G(141, 6655),
+	CHAN6G(145, 6675),
+	CHAN6G(149, 6695),
+	CHAN6G(153, 6715),
+	CHAN6G(157, 6735),
+	CHAN6G(161, 6755),
+	CHAN6G(165, 6775),
+	CHAN6G(169, 6795),
+	CHAN6G(173, 6815),
+	CHAN6G(177, 6835),
+	CHAN6G(181, 6855),
+	CHAN6G(185, 6875),
+	/* UNII-8 */
+	CHAN6G(189, 6895),
+	CHAN6G(193, 6915),
+	CHAN6G(197, 6935),
+	CHAN6G(201, 6955),
+	CHAN6G(205, 6975),
+	CHAN6G(209, 6995),
+	CHAN6G(213, 7015),
+	CHAN6G(217, 7035),
+	CHAN6G(221, 7055),
+	CHAN6G(225, 7075),
+	CHAN6G(229, 7095),
+	CHAN6G(233, 7115),
+};
+
 static const struct ieee80211_tpt_blink mt76_tpt_blink[] = {
 	{ .throughput =   0 * 1024, .blink_time = 334 },
 	{ .throughput =   1 * 1024, .blink_time = 260 },
@@ -194,13 +267,16 @@ void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 		mt76_init_stream_cap(phy, &phy->sband_2g.sband, false);
 	if (phy->cap.has_5ghz)
 		mt76_init_stream_cap(phy, &phy->sband_5g.sband, vht);
+	if (phy->cap.has_6ghz)
+		mt76_init_stream_cap(phy, &phy->sband_6g.sband, vht);
 }
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
 
 static int
 mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 		const struct ieee80211_channel *chan, int n_chan,
-		struct ieee80211_rate *rates, int n_rates, bool vht)
+		struct ieee80211_rate *rates, int n_rates,
+		bool ht, bool vht)
 {
 	struct ieee80211_supported_band *sband = &msband->sband;
 	struct ieee80211_sta_vht_cap *vht_cap;
@@ -224,6 +300,9 @@ mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 	sband->bitrates = rates;
 	sband->n_bitrates = n_rates;
 
+	if (!ht)
+		return 0;
+
 	ht_cap = &sband->ht_cap;
 	ht_cap->ht_supported = true;
 	ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
@@ -260,7 +339,7 @@ mt76_init_sband_2g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 
 	return mt76_init_sband(phy, &phy->sband_2g, mt76_channels_2ghz,
 			       ARRAY_SIZE(mt76_channels_2ghz), rates,
-			       n_rates, false);
+			       n_rates, true, false);
 }
 
 static int
@@ -271,7 +350,18 @@ mt76_init_sband_5g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 
 	return mt76_init_sband(phy, &phy->sband_5g, mt76_channels_5ghz,
 			       ARRAY_SIZE(mt76_channels_5ghz), rates,
-			       n_rates, vht);
+			       n_rates, true, vht);
+}
+
+static int
+mt76_init_sband_6g(struct mt76_phy *phy, struct ieee80211_rate *rates,
+		   int n_rates)
+{
+	phy->hw->wiphy->bands[NL80211_BAND_6GHZ] = &phy->sband_6g.sband;
+
+	return mt76_init_sband(phy, &phy->sband_6g, mt76_channels_6ghz,
+			       ARRAY_SIZE(mt76_channels_6ghz), rates,
+			       n_rates, false, false);
 }
 
 static void
@@ -400,9 +490,16 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 			return ret;
 	}
 
+	if (phy->cap.has_6ghz) {
+		ret = mt76_init_sband_6g(phy, rates + 4, n_rates - 4);
+		if (ret)
+			return ret;
+	}
+
 	wiphy_read_of_freq_limits(phy->hw->wiphy);
 	mt76_check_sband(phy, &phy->sband_2g, NL80211_BAND_2GHZ);
 	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
+	mt76_check_sband(phy, &phy->sband_6g, NL80211_BAND_6GHZ);
 
 	ret = ieee80211_register_hw(phy->hw);
 	if (ret)
@@ -510,9 +607,16 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			return ret;
 	}
 
+	if (phy->cap.has_6ghz) {
+		ret = mt76_init_sband_6g(phy, rates + 4, n_rates - 4);
+		if (ret)
+			return ret;
+	}
+
 	wiphy_read_of_freq_limits(hw->wiphy);
 	mt76_check_sband(&dev->phy, &phy->sband_2g, NL80211_BAND_2GHZ);
 	mt76_check_sband(&dev->phy, &phy->sband_5g, NL80211_BAND_5GHZ);
+	mt76_check_sband(&dev->phy, &phy->sband_6g, NL80211_BAND_6GHZ);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
 		ret = mt76_led_init(dev);
@@ -657,6 +761,8 @@ mt76_channel_state(struct mt76_phy *phy, struct ieee80211_channel *c)
 
 	if (c->band == NL80211_BAND_2GHZ)
 		msband = &phy->sband_2g;
+	else if (c->band == NL80211_BAND_6GHZ)
+		msband = &phy->sband_6g;
 	else
 		msband = &phy->sband_5g;
 
@@ -732,10 +838,16 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx == 0 && dev->drv->update_survey)
 		mt76_update_survey(phy);
 
-	sband = &phy->sband_2g;
-	if (idx >= sband->sband.n_channels) {
-		idx -= sband->sband.n_channels;
+	if (idx >= phy->sband_2g.sband.n_channels +
+		   phy->sband_5g.sband.n_channels) {
+		idx -= (phy->sband_2g.sband.n_channels +
+			phy->sband_5g.sband.n_channels);
+		sband = &phy->sband_6g;
+	} else if (idx >= phy->sband_2g.sband.n_channels) {
+		idx -= phy->sband_2g.sband.n_channels;
 		sband = &phy->sband_5g;
+	} else {
+		sband = &phy->sband_2g;
 	}
 
 	if (idx >= sband->sband.n_channels) {
@@ -1285,7 +1397,7 @@ int mt76_get_rate(struct mt76_dev *dev,
 	int i, offset = 0, len = sband->n_bitrates;
 
 	if (cck) {
-		if (sband == &dev->phy.sband_5g.sband)
+		if (sband != &dev->phy.sband_2g.sband)
 			return 0;
 
 		idx &= ~BIT(2); /* short preamble */
@@ -1357,7 +1469,7 @@ u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 	int offset = 0;
 	struct ieee80211_rate *rate;
 
-	if (phy->chandef.chan->band == NL80211_BAND_5GHZ)
+	if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
 		offset = 4;
 
 	rate = &mt76_rates[offset + rateidx];
-- 
2.31.1

