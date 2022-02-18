Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAE4BB04B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 04:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiBRDlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 22:41:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBRDlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 22:41:24 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F53DF86
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 19:41:07 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21I3f2bI5023591, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21I3f2bI5023591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 11:41:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 11:41:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 18 Feb
 2022 11:41:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 2/2] rtw89: phy: handle txpwr lmt/lmt_ru of 160M bandwidth
Date:   Fri, 18 Feb 2022 11:40:42 +0800
Message-ID: <20220218034042.9218-1-pkshih@realtek.com>
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

Add handling to fill struct rtw89_txpwr_limit and rtw89_txpwr_limit_ru
for 160Mhz bandwidth case. And enlarge RTW89_5G_BW_NUM because the chip
under planning can support 160Mhz bandwidth on 5G band.

Moreover, refine the filling of OFDM entry of struct rtw89_txpwr_limit
by using the value corresponding to primary channel.

E.g. center channel 38 (40Mhz bandwidth case)
Originally OFDM entry was filled by value corresponding to 'ch - 2' (36)
Now, we consider that it could be 36 or 40.

E.g. cneter channel 42 (80Mhz bandwidth case)
Originally OFDM entry was filled by value corresponding to 'ch - 6' (36)
Now, we consider that it could be 36, 40, 44, or 48.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 115 ++++++++++++++++++++--
 2 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b70570934e595..2c81e19d4b51c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -572,7 +572,7 @@ enum rtw89_ps_mode {
 };
 
 #define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
-#define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
+#define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 #define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 #define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7cc6155aa188d..719a2d6be0be9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1226,14 +1226,14 @@ static void rtw89_phy_fill_txpwr_limit_20m(struct rtw89_dev *rtwdev,
 
 static void rtw89_phy_fill_txpwr_limit_40m(struct rtw89_dev *rtwdev,
 					   struct rtw89_txpwr_limit *lmt,
-					   u8 ntx, u8 ch)
+					   u8 ntx, u8 ch, u8 pri_ch)
 {
 	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_CCK, ch - 2);
 	__fill_txpwr_limit_nonbf_bf(lmt->cck_40m, RTW89_CHANNEL_WIDTH_40,
 				    ntx, RTW89_RS_CCK, ch);
 	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
-				    ntx, RTW89_RS_OFDM, ch - 2);
+				    ntx, RTW89_RS_OFDM, pri_ch);
 	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 2);
 	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
@@ -1244,14 +1244,14 @@ static void rtw89_phy_fill_txpwr_limit_40m(struct rtw89_dev *rtwdev,
 
 static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
 					   struct rtw89_txpwr_limit *lmt,
-					   u8 ntx, u8 ch)
+					   u8 ntx, u8 ch, u8 pri_ch)
 {
 	s8 val_0p5_n[RTW89_BF_NUM];
 	s8 val_0p5_p[RTW89_BF_NUM];
 	u8 i;
 
 	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
-				    ntx, RTW89_RS_OFDM, ch - 6);
+				    ntx, RTW89_RS_OFDM, pri_ch);
 	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_MCS, ch - 6);
 	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
@@ -1276,10 +1276,82 @@ static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
 		lmt->mcs_40m_0p5[i] = min_t(s8, val_0p5_n[i], val_0p5_p[i]);
 }
 
+static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
+					    struct rtw89_txpwr_limit *lmt,
+					    u8 ntx, u8 ch, u8 pri_ch)
+{
+	s8 val_0p5_n[RTW89_BF_NUM];
+	s8 val_0p5_p[RTW89_BF_NUM];
+	s8 val_2p5_n[RTW89_BF_NUM];
+	s8 val_2p5_p[RTW89_BF_NUM];
+	u8 i;
+
+	/* fill ofdm section */
+	__fill_txpwr_limit_nonbf_bf(lmt->ofdm, RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_OFDM, pri_ch);
+
+	/* fill mcs 20m section */
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[0], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch - 14);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[1], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch - 10);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[2], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch - 6);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[3], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch - 2);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[4], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch + 2);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[5], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch + 6);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[6], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch + 10);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_20m[7], RTW89_CHANNEL_WIDTH_20,
+				    ntx, RTW89_RS_MCS, ch + 14);
+
+	/* fill mcs 40m section */
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[0], RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch - 12);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[1], RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch - 4);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[2], RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch + 4);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_40m[3], RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch + 12);
+
+	/* fill mcs 80m section */
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[0], RTW89_CHANNEL_WIDTH_80,
+				    ntx, RTW89_RS_MCS, ch - 8);
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_80m[1], RTW89_CHANNEL_WIDTH_80,
+				    ntx, RTW89_RS_MCS, ch + 8);
+
+	/* fill mcs 160m section */
+	__fill_txpwr_limit_nonbf_bf(lmt->mcs_160m, RTW89_CHANNEL_WIDTH_160,
+				    ntx, RTW89_RS_MCS, ch);
+
+	/* fill mcs 40m 0p5 section */
+	__fill_txpwr_limit_nonbf_bf(val_0p5_n, RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch - 4);
+	__fill_txpwr_limit_nonbf_bf(val_0p5_p, RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch + 4);
+
+	for (i = 0; i < RTW89_BF_NUM; i++)
+		lmt->mcs_40m_0p5[i] = min_t(s8, val_0p5_n[i], val_0p5_p[i]);
+
+	/* fill mcs 40m 2p5 section */
+	__fill_txpwr_limit_nonbf_bf(val_2p5_n, RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch - 8);
+	__fill_txpwr_limit_nonbf_bf(val_2p5_p, RTW89_CHANNEL_WIDTH_40,
+				    ntx, RTW89_RS_MCS, ch + 8);
+
+	for (i = 0; i < RTW89_BF_NUM; i++)
+		lmt->mcs_40m_2p5[i] = min_t(s8, val_2p5_n[i], val_2p5_p[i]);
+}
+
 void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 				struct rtw89_txpwr_limit *lmt,
 				u8 ntx)
 {
+	u8 pri_ch = rtwdev->hal.current_primary_channel;
 	u8 ch = rtwdev->hal.current_channel;
 	u8 bw = rtwdev->hal.current_band_width;
 
@@ -1290,10 +1362,13 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 		rtw89_phy_fill_txpwr_limit_20m(rtwdev, lmt, ntx, ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_fill_txpwr_limit_40m(rtwdev, lmt, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_40m(rtwdev, lmt, ntx, ch, pri_ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_fill_txpwr_limit_80m(rtwdev, lmt, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_80m(rtwdev, lmt, ntx, ch, pri_ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_fill_txpwr_limit_160m(rtwdev, lmt, ntx, ch, pri_ch);
 		break;
 	}
 }
@@ -1401,6 +1476,31 @@ rtw89_phy_fill_txpwr_limit_ru_80m(struct rtw89_dev *rtwdev,
 							 ntx, ch + 6);
 }
 
+static void
+rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
+				   struct rtw89_txpwr_limit_ru *lmt_ru,
+				   u8 ntx, u8 ch)
+{
+	static const int ofst[] = { -14, -10, -6, -2, 2, 6, 10, 14 };
+	int i;
+
+	static_assert(ARRAY_SIZE(ofst) == RTW89_RU_SEC_NUM);
+	for (i = 0; i < RTW89_RU_SEC_NUM; i++) {
+		lmt_ru->ru26[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+								RTW89_RU26,
+								ntx,
+								ch + ofst[i]);
+		lmt_ru->ru52[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+								RTW89_RU52,
+								ntx,
+								ch + ofst[i]);
+		lmt_ru->ru106[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev,
+								 RTW89_RU106,
+								 ntx,
+								 ch + ofst[i]);
+	}
+}
+
 void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
 				   u8 ntx)
@@ -1420,6 +1520,9 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	case RTW89_CHANNEL_WIDTH_80:
 		rtw89_phy_fill_txpwr_limit_ru_80m(rtwdev, lmt_ru, ntx, ch);
 		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_fill_txpwr_limit_ru_160m(rtwdev, lmt_ru, ntx, ch);
+		break;
 	}
 }
 EXPORT_SYMBOL(rtw89_phy_fill_txpwr_limit_ru);
-- 
2.25.1

