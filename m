Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3774BB048
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 04:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBRDlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 22:41:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBRDlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 22:41:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4F38BDC
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 19:40:51 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21I3edFyB023549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21I3edFyB023549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 11:40:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 11:40:39 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 18 Feb
 2022 11:40:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 1/2] rtw89: phy: handle txpwr lmt/lmt_ru of 6G band
Date:   Fri, 18 Feb 2022 11:40:16 +0800
Message-ID: <20220218034017.9160-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218034017.9160-1-pkshih@realtek.com>
References: <20220218034017.9160-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/18/2022 03:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTggpFekyCAwMTo1MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Add declarations of 6G stuff and extend rtw89_channel_to_idx() to
map 6G's channels to 6G channel indexes. While 6G, correspondingly
read 6G's entry for tx power limit and limit_ru.

After this, we should pay attention to chip_info::support_bands.
If a chip declares 6G support, it must configure txpwr_lmt_6g and
txpwr_lmt_ru_6g in case accessing NULL pointer while setting tx power
limit/limit_ru on 6G band.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 25 ++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 46 +++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3254be670bd67..b70570934e595 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -371,6 +371,25 @@ enum rtw89_hw_rate {
  */
 #define RTW89_5G_CH_NUM 53
 
+/* 6G channels,
+ * 1, 3, 5, 7, 9, 11, 13, 15,
+ * 17, 19, 21, 23, 25, 27, 29, 33,
+ * 35, 37, 39, 41, 43, 45, 47, 49,
+ * 51, 53, 55, 57, 59, 61, 65, 67,
+ * 69, 71, 73, 75, 77, 79, 81, 83,
+ * 85, 87, 89, 91, 93, 97, 99, 101,
+ * 103, 105, 107, 109, 111, 113, 115, 117,
+ * 119, 121, 123, 125, 129, 131, 133, 135,
+ * 137, 139, 141, 143, 145, 147, 149, 151,
+ * 153, 155, 157, 161, 163, 165, 167, 169,
+ * 171, 173, 175, 177, 179, 181, 183, 185,
+ * 187, 189, 193, 195, 197, 199, 201, 203,
+ * 205, 207, 209, 211, 213, 215, 217, 219,
+ * 221, 225, 227, 229, 231, 233, 235, 237,
+ * 239, 241, 243, 245, 247, 249, 251, 253,
+ */
+#define RTW89_6G_CH_NUM 120
+
 enum rtw89_rate_section {
 	RTW89_RS_CCK,
 	RTW89_RS_OFDM,
@@ -554,6 +573,7 @@ enum rtw89_ps_mode {
 
 #define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
 #define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
+#define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 #define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
 
 enum rtw89_ru_bandwidth {
@@ -2246,10 +2266,15 @@ struct rtw89_chip_info {
 	const s8 (*txpwr_lmt_5g)[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+	const s8 (*txpwr_lmt_6g)[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
+				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+				[RTW89_REGD_NUM][RTW89_6G_CH_NUM];
 	const s8 (*txpwr_lmt_ru_2g)[RTW89_RU_NUM][RTW89_NTX_NUM]
 				   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
 	const s8 (*txpwr_lmt_ru_5g)[RTW89_RU_NUM][RTW89_NTX_NUM]
 				   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+	const s8 (*txpwr_lmt_ru_6g)[RTW89_RU_NUM][RTW89_NTX_NUM]
+				   [RTW89_REGD_NUM][RTW89_6G_CH_NUM];
 
 	u8 txpwr_factor_rf;
 	u8 txpwr_factor_mac;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d1d3ebb5e2264..7cc6155aa188d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1115,8 +1115,36 @@ s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_read_txpwr_byrate);
 
-static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 channel)
+static u8 rtw89_channel_6g_to_idx(struct rtw89_dev *rtwdev, u8 channel_6g)
+{
+	switch (channel_6g) {
+	case 1 ... 29:
+		return (channel_6g - 1) / 2;
+	case 33 ... 61:
+		return (channel_6g - 3) / 2;
+	case 65 ... 93:
+		return (channel_6g - 5) / 2;
+	case 97 ... 125:
+		return (channel_6g - 7) / 2;
+	case 129 ... 157:
+		return (channel_6g - 9) / 2;
+	case 161 ... 189:
+		return (channel_6g - 11) / 2;
+	case 193 ... 221:
+		return (channel_6g - 13) / 2;
+	case 225 ... 253:
+		return (channel_6g - 15) / 2;
+	default:
+		rtw89_warn(rtwdev, "unknown 6g channel: %d\n", channel_6g);
+		return 0;
+	}
+}
+
+static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 {
+	if (band == RTW89_BAND_6G)
+		return rtw89_channel_6g_to_idx(rtwdev, channel);
+
 	switch (channel) {
 	case 1 ... 14:
 		return channel - 1;
@@ -1136,8 +1164,8 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 ch_idx = rtw89_channel_to_idx(rtwdev, ch);
 	u8 band = rtwdev->hal.current_band_type;
+	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt = 0, sar;
 
@@ -1154,6 +1182,12 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 			lmt = (*chip->txpwr_lmt_5g)[bw][ntx][rs][bf]
 						   [RTW89_WW][ch_idx];
 		break;
+	case RTW89_BAND_6G:
+		lmt = (*chip->txpwr_lmt_6g)[bw][ntx][rs][bf][regd][ch_idx];
+		if (!lmt)
+			lmt = (*chip->txpwr_lmt_6g)[bw][ntx][rs][bf]
+						   [RTW89_WW][ch_idx];
+		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
 		return 0;
@@ -1269,8 +1303,8 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 					u8 ru, u8 ntx, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 ch_idx = rtw89_channel_to_idx(rtwdev, ch);
 	u8 band = rtwdev->hal.current_band_type;
+	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt_ru = 0, sar;
 
@@ -1287,6 +1321,12 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 			lmt_ru = (*chip->txpwr_lmt_ru_5g)[ru][ntx]
 							 [RTW89_WW][ch_idx];
 		break;
+	case RTW89_BAND_6G:
+		lmt_ru = (*chip->txpwr_lmt_ru_6g)[ru][ntx][regd][ch_idx];
+		if (!lmt_ru)
+			lmt_ru = (*chip->txpwr_lmt_ru_6g)[ru][ntx]
+							 [RTW89_WW][ch_idx];
+		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
 		return 0;
-- 
2.25.1

