Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD452E60B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbiETHSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbiETHSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E93ED22
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:18:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HuQhA023735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HuQhA023735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 15:17:56 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 5/6] rtw89: sar: adjust and support SAR on 6GHz band
Date:   Fri, 20 May 2022 15:17:30 +0800
Message-ID: <20220520071731.38563-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520071731.38563-1-pkshih@realtek.com>
References: <20220520071731.38563-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Since SAR is more expected to follow U-NII bands to plan subbands,
division of 6GHz band is quite different from defined enum of subbands
which is used by PHY in most cases. It's hard and painful if we want to
keep using the same enum on SAR. So, we introduce another enum for SAR
subbands and adjust SAR flow to use it.

Besides, since 6GHz SAR subbands won't be divided with edge alignment,
some cases will span two SAR subbands. For these cases, we describe them
within an array of rtw89_sar_span and take the smaller one between SAR
settings of the two subbands.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  19 ++-
 drivers/net/wireless/realtek/rtw89/debug.h |   1 +
 drivers/net/wireless/realtek/rtw89/sar.c   | 140 ++++++++++++++++++---
 3 files changed, 140 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 35619435ea0a2..6dd341f3fd33e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2550,9 +2550,24 @@ enum rtw89_sar_sources {
 	RTW89_SAR_SOURCE_NR,
 };
 
+enum rtw89_sar_subband {
+	RTW89_SAR_2GHZ_SUBBAND,
+	RTW89_SAR_5GHZ_SUBBAND_1_2, /* U-NII-1 and U-NII-2 */
+	RTW89_SAR_5GHZ_SUBBAND_2_E, /* U-NII-2-Extended */
+	RTW89_SAR_5GHZ_SUBBAND_3,   /* U-NII-3 */
+	RTW89_SAR_6GHZ_SUBBAND_5_L, /* U-NII-5 lower part */
+	RTW89_SAR_6GHZ_SUBBAND_5_H, /* U-NII-5 higher part */
+	RTW89_SAR_6GHZ_SUBBAND_6,   /* U-NII-6 */
+	RTW89_SAR_6GHZ_SUBBAND_7_L, /* U-NII-7 lower part */
+	RTW89_SAR_6GHZ_SUBBAND_7_H, /* U-NII-7 higher part */
+	RTW89_SAR_6GHZ_SUBBAND_8,   /* U-NII-8 */
+
+	RTW89_SAR_SUBBAND_NR,
+};
+
 struct rtw89_sar_cfg_common {
-	bool set[RTW89_SUBBAND_NR];
-	s32 cfg[RTW89_SUBBAND_NR];
+	bool set[RTW89_SAR_SUBBAND_NR];
+	s32 cfg[RTW89_SAR_SUBBAND_NR];
 };
 
 struct rtw89_sar_info {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index de72155ad1fea..561b04faf703d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -24,6 +24,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_BTC = BIT(13),
 	RTW89_DBG_BF = BIT(14),
 	RTW89_DBG_HW_SCAN = BIT(15),
+	RTW89_DBG_SAR = BIT(16),
 };
 
 enum rtw89_debug_mac_reg_sel {
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 097c87899ceaa..eb2d3ec28775f 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -5,15 +5,122 @@
 #include "debug.h"
 #include "sar.h"
 
+static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
+						    u32 center_freq)
+{
+	switch (center_freq) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "center freq: %u to SAR subband is unhandled\n",
+			    center_freq);
+		fallthrough;
+	case 2412 ... 2484:
+		return RTW89_SAR_2GHZ_SUBBAND;
+	case 5180 ... 5320:
+		return RTW89_SAR_5GHZ_SUBBAND_1_2;
+	case 5500 ... 5720:
+		return RTW89_SAR_5GHZ_SUBBAND_2_E;
+	case 5745 ... 5825:
+		return RTW89_SAR_5GHZ_SUBBAND_3;
+	case 5955 ... 6155:
+		return RTW89_SAR_6GHZ_SUBBAND_5_L;
+	case 6175 ... 6415:
+		return RTW89_SAR_6GHZ_SUBBAND_5_H;
+	case 6435 ... 6515:
+		return RTW89_SAR_6GHZ_SUBBAND_6;
+	case 6535 ... 6695:
+		return RTW89_SAR_6GHZ_SUBBAND_7_L;
+	case 6715 ... 6855:
+		return RTW89_SAR_6GHZ_SUBBAND_7_H;
+
+	/* freq 6875 (ch 185, 20MHz) spans RTW89_SAR_6GHZ_SUBBAND_7_H
+	 * and RTW89_SAR_6GHZ_SUBBAND_8, so directly describe it with
+	 * struct rtw89_sar_span in the following.
+	 */
+
+	case 6895 ... 7115:
+		return RTW89_SAR_6GHZ_SUBBAND_8;
+	}
+}
+
+struct rtw89_sar_span {
+	enum rtw89_sar_subband subband_low;
+	enum rtw89_sar_subband subband_high;
+};
+
+#define RTW89_SAR_SPAN_VALID(span) ((span)->subband_high)
+
+#define RTW89_SAR_6GHZ_SPAN_HEAD 6145
+#define RTW89_SAR_6GHZ_SPAN_IDX(center_freq) \
+	((((int)(center_freq) - RTW89_SAR_6GHZ_SPAN_HEAD) / 5) / 2)
+
+#define RTW89_DECL_SAR_6GHZ_SPAN(center_freq, subband_l, subband_h) \
+	[RTW89_SAR_6GHZ_SPAN_IDX(center_freq)] = { \
+		.subband_low = RTW89_SAR_6GHZ_ ## subband_l, \
+		.subband_high = RTW89_SAR_6GHZ_ ## subband_h, \
+	}
+
+/* Since 6GHz SAR subbands are not edge aligned, some cases span two SAR
+ * subbands. In the following, we describe each of them with rtw89_sar_span.
+ */
+static const struct rtw89_sar_span rtw89_sar_overlapping_6ghz[] = {
+	RTW89_DECL_SAR_6GHZ_SPAN(6145, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_SAR_6GHZ_SPAN(6165, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_SAR_6GHZ_SPAN(6185, SUBBAND_5_L, SUBBAND_5_H),
+	RTW89_DECL_SAR_6GHZ_SPAN(6505, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_SAR_6GHZ_SPAN(6525, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_SAR_6GHZ_SPAN(6545, SUBBAND_6, SUBBAND_7_L),
+	RTW89_DECL_SAR_6GHZ_SPAN(6665, SUBBAND_7_L, SUBBAND_7_H),
+	RTW89_DECL_SAR_6GHZ_SPAN(6705, SUBBAND_7_L, SUBBAND_7_H),
+	RTW89_DECL_SAR_6GHZ_SPAN(6825, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_SAR_6GHZ_SPAN(6865, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_SAR_6GHZ_SPAN(6875, SUBBAND_7_H, SUBBAND_8),
+	RTW89_DECL_SAR_6GHZ_SPAN(6885, SUBBAND_7_H, SUBBAND_8),
+};
+
 static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev, s32 *cfg)
 {
 	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
-	enum rtw89_subband subband = rtwdev->hal.current_subband;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_band band = hal->current_band_type;
+	u32 center_freq = hal->current_freq;
+	const struct rtw89_sar_span *span = NULL;
+	enum rtw89_sar_subband subband_l, subband_h;
+	int idx;
+
+	if (band == RTW89_BAND_6G) {
+		idx = RTW89_SAR_6GHZ_SPAN_IDX(center_freq);
+		/* To decrease size of rtw89_sar_overlapping_6ghz[],
+		 * RTW89_SAR_6GHZ_SPAN_IDX() truncates the leading NULLs
+		 * to make first span as index 0 of the table. So, if center
+		 * frequency is less than the first one, it will get netative.
+		 */
+		if (idx >= 0 && idx < ARRAY_SIZE(rtw89_sar_overlapping_6ghz))
+			span = &rtw89_sar_overlapping_6ghz[idx];
+	}
+
+	if (span && RTW89_SAR_SPAN_VALID(span)) {
+		subband_l = span->subband_low;
+		subband_h = span->subband_high;
+	} else {
+		subband_l = rtw89_sar_get_subband(rtwdev, center_freq);
+		subband_h = subband_l;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "for {band %u, center_freq %u}, SAR subband: {%u, %u}\n",
+		    band, center_freq, subband_l, subband_h);
 
-	if (!rtwsar->set[subband])
+	if (!rtwsar->set[subband_l] && !rtwsar->set[subband_h])
 		return -ENODATA;
 
-	*cfg = rtwsar->cfg[subband];
+	if (!rtwsar->set[subband_l])
+		*cfg = rtwsar->cfg[subband_h];
+	else if (!rtwsar->set[subband_h])
+		*cfg = rtwsar->cfg[subband_l];
+	else
+		*cfg = min(rtwsar->cfg[subband_l], rtwsar->cfg[subband_h]);
+
 	return 0;
 }
 
@@ -128,21 +235,20 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static const u8 rtw89_common_sar_subband_map[] = {
-	RTW89_CH_2G,
-	RTW89_CH_5G_BAND_1,
-	RTW89_CH_5G_BAND_3,
-	RTW89_CH_5G_BAND_4,
-};
-
 static const struct cfg80211_sar_freq_ranges rtw89_common_sar_freq_ranges[] = {
 	{ .start_freq = 2412, .end_freq = 2484, },
 	{ .start_freq = 5180, .end_freq = 5320, },
 	{ .start_freq = 5500, .end_freq = 5720, },
 	{ .start_freq = 5745, .end_freq = 5825, },
+	{ .start_freq = 5955, .end_freq = 6155, },
+	{ .start_freq = 6175, .end_freq = 6415, },
+	{ .start_freq = 6435, .end_freq = 6515, },
+	{ .start_freq = 6535, .end_freq = 6695, },
+	{ .start_freq = 6715, .end_freq = 6875, },
+	{ .start_freq = 6875, .end_freq = 7115, },
 };
 
-static_assert(ARRAY_SIZE(rtw89_common_sar_subband_map) ==
+static_assert(RTW89_SAR_SUBBAND_NR ==
 	      ARRAY_SIZE(rtw89_common_sar_freq_ranges));
 
 const struct cfg80211_sar_capa rtw89_sar_capa = {
@@ -159,7 +265,6 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 	u8 fct;
 	u32 freq_start;
 	u32 freq_end;
-	u32 band;
 	s32 power;
 	u32 i, idx;
 
@@ -175,15 +280,14 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 
 		freq_start = rtw89_common_sar_freq_ranges[idx].start_freq;
 		freq_end = rtw89_common_sar_freq_ranges[idx].end_freq;
-		band = rtw89_common_sar_subband_map[idx];
 		power = sar->sub_specs[i].power;
 
-		rtw89_info(rtwdev, "On freq %u to %u, ", freq_start, freq_end);
-		rtw89_info(rtwdev, "set SAR power limit %d (unit: 1/%lu dBm)\n",
-			   power, BIT(fct));
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "On freq %u to %u, set SAR limit %d (unit: 1/%lu dBm)\n",
+			    freq_start, freq_end, power, BIT(fct));
 
-		sar_common.set[band] = true;
-		sar_common.cfg[band] = power;
+		sar_common.set[idx] = true;
+		sar_common.cfg[idx] = power;
 	}
 
 	return rtw89_apply_sar_common(rtwdev, &sar_common);
-- 
2.25.1

