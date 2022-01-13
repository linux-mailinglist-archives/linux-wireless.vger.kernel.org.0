Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BA48D001
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 02:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiAMBLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 20:11:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42611 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiAMBLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 20:11:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20D1AqItA031952, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20D1AqItA031952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 09:10:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 09:10:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 09:10:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 1/2] rtw89: handle 6G band if supported by a chipset
Date:   Thu, 13 Jan 2022 09:10:41 +0800
Message-ID: <20220113011042.6705-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/13/2022 00:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMTIgpFWkyCAxMDowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For next chipset which can support 6G band, we add the handling
of ieee80211_supported_band for 6G band in advance. And a bitmap,
support_bands, is added to rtw89_chip_info to declare which
NL80211_BAND_* are supported. With the chipset's declaration,
we register the corresponding instances of ieee80211_supported_band
with wiphy.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 231 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 3 files changed, 179 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 00ae86807dc21..e7ca3db4b4cf5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -19,50 +19,122 @@ static bool rtw89_disable_ps_mode;
 module_param_named(disable_ps_mode, rtw89_disable_ps_mode, bool, 0644);
 MODULE_PARM_DESC(disable_ps_mode, "Set Y to disable low power mode");
 
+#define RTW89_DEF_CHAN(_freq, _hw_val, _flags, _band)	\
+	{ .center_freq = _freq, .hw_value = _hw_val, .flags = _flags, .band = _band, }
+#define RTW89_DEF_CHAN_2G(_freq, _hw_val)	\
+	RTW89_DEF_CHAN(_freq, _hw_val, 0, NL80211_BAND_2GHZ)
+#define RTW89_DEF_CHAN_5G(_freq, _hw_val)	\
+	RTW89_DEF_CHAN(_freq, _hw_val, 0, NL80211_BAND_5GHZ)
+#define RTW89_DEF_CHAN_5G_NO_HT40MINUS(_freq, _hw_val)	\
+	RTW89_DEF_CHAN(_freq, _hw_val, IEEE80211_CHAN_NO_HT40MINUS, NL80211_BAND_5GHZ)
+#define RTW89_DEF_CHAN_6G(_freq, _hw_val)	\
+	RTW89_DEF_CHAN(_freq, _hw_val, 0, NL80211_BAND_6GHZ)
+
 static struct ieee80211_channel rtw89_channels_2ghz[] = {
-	{ .center_freq = 2412, .hw_value = 1, },
-	{ .center_freq = 2417, .hw_value = 2, },
-	{ .center_freq = 2422, .hw_value = 3, },
-	{ .center_freq = 2427, .hw_value = 4, },
-	{ .center_freq = 2432, .hw_value = 5, },
-	{ .center_freq = 2437, .hw_value = 6, },
-	{ .center_freq = 2442, .hw_value = 7, },
-	{ .center_freq = 2447, .hw_value = 8, },
-	{ .center_freq = 2452, .hw_value = 9, },
-	{ .center_freq = 2457, .hw_value = 10, },
-	{ .center_freq = 2462, .hw_value = 11, },
-	{ .center_freq = 2467, .hw_value = 12, },
-	{ .center_freq = 2472, .hw_value = 13, },
-	{ .center_freq = 2484, .hw_value = 14, },
+	RTW89_DEF_CHAN_2G(2412, 1),
+	RTW89_DEF_CHAN_2G(2417, 2),
+	RTW89_DEF_CHAN_2G(2422, 3),
+	RTW89_DEF_CHAN_2G(2427, 4),
+	RTW89_DEF_CHAN_2G(2432, 5),
+	RTW89_DEF_CHAN_2G(2437, 6),
+	RTW89_DEF_CHAN_2G(2442, 7),
+	RTW89_DEF_CHAN_2G(2447, 8),
+	RTW89_DEF_CHAN_2G(2452, 9),
+	RTW89_DEF_CHAN_2G(2457, 10),
+	RTW89_DEF_CHAN_2G(2462, 11),
+	RTW89_DEF_CHAN_2G(2467, 12),
+	RTW89_DEF_CHAN_2G(2472, 13),
+	RTW89_DEF_CHAN_2G(2484, 14),
 };
 
 static struct ieee80211_channel rtw89_channels_5ghz[] = {
-	{.center_freq = 5180, .hw_value = 36,},
-	{.center_freq = 5200, .hw_value = 40,},
-	{.center_freq = 5220, .hw_value = 44,},
-	{.center_freq = 5240, .hw_value = 48,},
-	{.center_freq = 5260, .hw_value = 52,},
-	{.center_freq = 5280, .hw_value = 56,},
-	{.center_freq = 5300, .hw_value = 60,},
-	{.center_freq = 5320, .hw_value = 64,},
-	{.center_freq = 5500, .hw_value = 100,},
-	{.center_freq = 5520, .hw_value = 104,},
-	{.center_freq = 5540, .hw_value = 108,},
-	{.center_freq = 5560, .hw_value = 112,},
-	{.center_freq = 5580, .hw_value = 116,},
-	{.center_freq = 5600, .hw_value = 120,},
-	{.center_freq = 5620, .hw_value = 124,},
-	{.center_freq = 5640, .hw_value = 128,},
-	{.center_freq = 5660, .hw_value = 132,},
-	{.center_freq = 5680, .hw_value = 136,},
-	{.center_freq = 5700, .hw_value = 140,},
-	{.center_freq = 5720, .hw_value = 144,},
-	{.center_freq = 5745, .hw_value = 149,},
-	{.center_freq = 5765, .hw_value = 153,},
-	{.center_freq = 5785, .hw_value = 157,},
-	{.center_freq = 5805, .hw_value = 161,},
-	{.center_freq = 5825, .hw_value = 165,
-	 .flags = IEEE80211_CHAN_NO_HT40MINUS},
+	RTW89_DEF_CHAN_5G(5180, 36),
+	RTW89_DEF_CHAN_5G(5200, 40),
+	RTW89_DEF_CHAN_5G(5220, 44),
+	RTW89_DEF_CHAN_5G(5240, 48),
+	RTW89_DEF_CHAN_5G(5260, 52),
+	RTW89_DEF_CHAN_5G(5280, 56),
+	RTW89_DEF_CHAN_5G(5300, 60),
+	RTW89_DEF_CHAN_5G(5320, 64),
+	RTW89_DEF_CHAN_5G(5500, 100),
+	RTW89_DEF_CHAN_5G(5520, 104),
+	RTW89_DEF_CHAN_5G(5540, 108),
+	RTW89_DEF_CHAN_5G(5560, 112),
+	RTW89_DEF_CHAN_5G(5580, 116),
+	RTW89_DEF_CHAN_5G(5600, 120),
+	RTW89_DEF_CHAN_5G(5620, 124),
+	RTW89_DEF_CHAN_5G(5640, 128),
+	RTW89_DEF_CHAN_5G(5660, 132),
+	RTW89_DEF_CHAN_5G(5680, 136),
+	RTW89_DEF_CHAN_5G(5700, 140),
+	RTW89_DEF_CHAN_5G(5720, 144),
+	RTW89_DEF_CHAN_5G(5745, 149),
+	RTW89_DEF_CHAN_5G(5765, 153),
+	RTW89_DEF_CHAN_5G(5785, 157),
+	RTW89_DEF_CHAN_5G(5805, 161),
+	RTW89_DEF_CHAN_5G_NO_HT40MINUS(5825, 165),
+};
+
+static struct ieee80211_channel rtw89_channels_6ghz[] = {
+	RTW89_DEF_CHAN_6G(5955, 1),
+	RTW89_DEF_CHAN_6G(5975, 5),
+	RTW89_DEF_CHAN_6G(5995, 9),
+	RTW89_DEF_CHAN_6G(6015, 13),
+	RTW89_DEF_CHAN_6G(6035, 17),
+	RTW89_DEF_CHAN_6G(6055, 21),
+	RTW89_DEF_CHAN_6G(6075, 25),
+	RTW89_DEF_CHAN_6G(6095, 29),
+	RTW89_DEF_CHAN_6G(6115, 33),
+	RTW89_DEF_CHAN_6G(6135, 37),
+	RTW89_DEF_CHAN_6G(6155, 41),
+	RTW89_DEF_CHAN_6G(6175, 45),
+	RTW89_DEF_CHAN_6G(6195, 49),
+	RTW89_DEF_CHAN_6G(6215, 53),
+	RTW89_DEF_CHAN_6G(6235, 57),
+	RTW89_DEF_CHAN_6G(6255, 61),
+	RTW89_DEF_CHAN_6G(6275, 65),
+	RTW89_DEF_CHAN_6G(6295, 69),
+	RTW89_DEF_CHAN_6G(6315, 73),
+	RTW89_DEF_CHAN_6G(6335, 77),
+	RTW89_DEF_CHAN_6G(6355, 81),
+	RTW89_DEF_CHAN_6G(6375, 85),
+	RTW89_DEF_CHAN_6G(6395, 89),
+	RTW89_DEF_CHAN_6G(6415, 93),
+	RTW89_DEF_CHAN_6G(6435, 97),
+	RTW89_DEF_CHAN_6G(6455, 101),
+	RTW89_DEF_CHAN_6G(6475, 105),
+	RTW89_DEF_CHAN_6G(6495, 109),
+	RTW89_DEF_CHAN_6G(6515, 113),
+	RTW89_DEF_CHAN_6G(6535, 117),
+	RTW89_DEF_CHAN_6G(6555, 121),
+	RTW89_DEF_CHAN_6G(6575, 125),
+	RTW89_DEF_CHAN_6G(6595, 129),
+	RTW89_DEF_CHAN_6G(6615, 133),
+	RTW89_DEF_CHAN_6G(6635, 137),
+	RTW89_DEF_CHAN_6G(6655, 141),
+	RTW89_DEF_CHAN_6G(6675, 145),
+	RTW89_DEF_CHAN_6G(6695, 149),
+	RTW89_DEF_CHAN_6G(6715, 153),
+	RTW89_DEF_CHAN_6G(6735, 157),
+	RTW89_DEF_CHAN_6G(6755, 161),
+	RTW89_DEF_CHAN_6G(6775, 165),
+	RTW89_DEF_CHAN_6G(6795, 169),
+	RTW89_DEF_CHAN_6G(6815, 173),
+	RTW89_DEF_CHAN_6G(6835, 177),
+	RTW89_DEF_CHAN_6G(6855, 181),
+	RTW89_DEF_CHAN_6G(6875, 185),
+	RTW89_DEF_CHAN_6G(6895, 189),
+	RTW89_DEF_CHAN_6G(6915, 193),
+	RTW89_DEF_CHAN_6G(6935, 197),
+	RTW89_DEF_CHAN_6G(6955, 201),
+	RTW89_DEF_CHAN_6G(6975, 205),
+	RTW89_DEF_CHAN_6G(6995, 209),
+	RTW89_DEF_CHAN_6G(7015, 213),
+	RTW89_DEF_CHAN_6G(7035, 217),
+	RTW89_DEF_CHAN_6G(7055, 221),
+	RTW89_DEF_CHAN_6G(7075, 225),
+	RTW89_DEF_CHAN_6G(7095, 229),
+	RTW89_DEF_CHAN_6G(7115, 233),
 };
 
 static struct ieee80211_rate rtw89_bitrates[] = {
@@ -116,6 +188,16 @@ static struct ieee80211_supported_band rtw89_sband_5ghz = {
 	.vht_cap	= {0},
 };
 
+static struct ieee80211_supported_band rtw89_sband_6ghz = {
+	.band		= NL80211_BAND_6GHZ,
+	.channels	= rtw89_channels_6ghz,
+	.n_channels	= ARRAY_SIZE(rtw89_channels_6ghz),
+
+	/* 6G has no CCK rates, 1M/2M/5.5M/11M */
+	.bitrates	= rtw89_bitrates + 4,
+	.n_bitrates	= ARRAY_SIZE(rtw89_bitrates) - 4,
+};
+
 static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
 				     struct rtw89_traffic_stats *stats,
 				     struct sk_buff *skb, bool tx)
@@ -147,6 +229,7 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	u8 center_chan;
 	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
 	u8 primary_chan_idx = 0;
+	u8 band;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
@@ -193,10 +276,24 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		break;
 	}
 
+	switch (channel->band) {
+	default:
+	case NL80211_BAND_2GHZ:
+		band = RTW89_BAND_2G;
+		break;
+	case NL80211_BAND_5GHZ:
+		band = RTW89_BAND_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		band = RTW89_BAND_6G;
+		break;
+	}
+
 	chan_param->center_chan = center_chan;
 	chan_param->primary_chan = channel->hw_value;
 	chan_param->bandwidth = bandwidth;
 	chan_param->pri_ch_idx = primary_chan_idx;
+	chan_param->band_type = band;
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
@@ -207,7 +304,6 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	struct rtw89_channel_params ch_param;
 	struct rtw89_channel_help_params bak;
 	u8 center_chan, bandwidth;
-	u8 band_type;
 	bool band_changed;
 
 	rtw89_get_channel_params(&hw->conf.chandef, &ch_param);
@@ -216,15 +312,14 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	center_chan = ch_param.center_chan;
 	bandwidth = ch_param.bandwidth;
-	band_type = center_chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
-	band_changed = hal->current_band_type != band_type ||
+	band_changed = hal->current_band_type != ch_param.band_type ||
 		       hal->current_channel == 0;
 
 	hal->current_band_width = bandwidth;
 	hal->current_channel = center_chan;
 	hal->prev_primary_channel = hal->current_primary_channel;
 	hal->current_primary_channel = ch_param.primary_chan;
-	hal->current_band_type = band_type;
+	hal->current_band_type = ch_param.band_type;
 
 	switch (center_chan) {
 	case 1 ... 14:
@@ -2136,34 +2231,52 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_supported_band *sband_2ghz = NULL, *sband_5ghz = NULL;
+	struct ieee80211_supported_band *sband_6ghz = NULL;
 	u32 size = sizeof(struct ieee80211_supported_band);
+	u8 support_bands = rtwdev->chip->support_bands;
 
-	sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
-	if (!sband_2ghz)
-		goto err;
-	rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
-	rtw89_init_he_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
-	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband_2ghz;
+	if (support_bands & BIT(NL80211_BAND_2GHZ)) {
+		sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
+		if (!sband_2ghz)
+			goto err;
+		rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
+		rtw89_init_he_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
+		hw->wiphy->bands[NL80211_BAND_2GHZ] = sband_2ghz;
+	}
 
-	sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
-	if (!sband_5ghz)
-		goto err;
-	rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
-	rtw89_init_vht_cap(rtwdev, &sband_5ghz->vht_cap);
-	rtw89_init_he_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
-	hw->wiphy->bands[NL80211_BAND_5GHZ] = sband_5ghz;
+	if (support_bands & BIT(NL80211_BAND_5GHZ)) {
+		sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
+		if (!sband_5ghz)
+			goto err;
+		rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
+		rtw89_init_vht_cap(rtwdev, &sband_5ghz->vht_cap);
+		rtw89_init_he_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
+		hw->wiphy->bands[NL80211_BAND_5GHZ] = sband_5ghz;
+	}
+
+	if (support_bands & BIT(NL80211_BAND_6GHZ)) {
+		sband_6ghz = kmemdup(&rtw89_sband_6ghz, size, GFP_KERNEL);
+		if (!sband_6ghz)
+			goto err;
+		rtw89_init_he_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
+		hw->wiphy->bands[NL80211_BAND_6GHZ] = sband_6ghz;
+	}
 
 	return 0;
 
 err:
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
 	if (sband_2ghz)
 		kfree(sband_2ghz->iftype_data);
 	if (sband_5ghz)
 		kfree(sband_5ghz->iftype_data);
+	if (sband_6ghz)
+		kfree(sband_6ghz->iftype_data);
 	kfree(sband_2ghz);
 	kfree(sband_5ghz);
+	kfree(sband_6ghz);
 	return -ENOMEM;
 }
 
@@ -2173,10 +2286,14 @@ static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
 
 	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]->iftype_data);
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
+	if (hw->wiphy->bands[NL80211_BAND_6GHZ])
+		kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
 	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
+	kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
 }
 
 static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c84556ec4ada..bec1e640cd71b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -205,6 +205,7 @@ enum rtw89_port {
 enum rtw89_band {
 	RTW89_BAND_2G = 0,
 	RTW89_BAND_5G = 1,
+	RTW89_BAND_6G = 2,
 	RTW89_BAND_MAX,
 };
 
@@ -573,6 +574,7 @@ struct rtw89_channel_params {
 	u8 primary_chan;
 	u8 bandwidth;
 	u8 pri_ch_idx;
+	u8 band_type;
 };
 
 struct rtw89_channel_help_params {
@@ -2192,6 +2194,7 @@ struct rtw89_chip_info {
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
 	const struct rtw89_dle_mem *dle_mem;
 	u32 rf_base_addr[2];
+	u8 support_bands;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6b75e4bc73523..bf6754a8cf1b1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2019,6 +2019,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ),
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
-- 
2.25.1

