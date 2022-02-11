Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582EE4B1FCB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 09:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbiBKIAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 03:00:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbiBKIAf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 03:00:35 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F193BD2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 00:00:33 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B80LPA0023913, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B80LPA0023913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 16:00:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 16:00:21 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 16:00:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 3/6] rtw89: extend subband for 6G band
Date:   Fri, 11 Feb 2022 15:59:50 +0800
Message-ID: <20220211075953.40421-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211075953.40421-1-pkshih@realtek.com>
References: <20220211075953.40421-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
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

Split 6G band into 8 sub-bands where indexes are from 0 to 7,
i.e. RTW89_CH_6G_BAND_IDX[0-7]. Then, decide subband by both
band and channel instead of just channel because conflicts
between 5G channels and 6G channels.

Moreover, add default case to the existing use of switch (subband).

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 59 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     |  9 +++
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  2 +
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a9544b006f0b4..116c5cb65fe46 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -293,19 +293,58 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		break;
 	}
 
-	switch (center_chan) {
+	switch (band) {
 	default:
-	case 1 ... 14:
-		subband = RTW89_CH_2G;
-		break;
-	case 36 ... 64:
-		subband = RTW89_CH_5G_BAND_1;
+	case RTW89_BAND_2G:
+		switch (center_chan) {
+		default:
+		case 1 ... 14:
+			subband = RTW89_CH_2G;
+			break;
+		}
 		break;
-	case 100 ... 144:
-		subband = RTW89_CH_5G_BAND_3;
+	case RTW89_BAND_5G:
+		switch (center_chan) {
+		default:
+		case 36 ... 64:
+			subband = RTW89_CH_5G_BAND_1;
+			break;
+		case 100 ... 144:
+			subband = RTW89_CH_5G_BAND_3;
+			break;
+		case 149 ... 177:
+			subband = RTW89_CH_5G_BAND_4;
+			break;
+		}
 		break;
-	case 149 ... 177:
-		subband = RTW89_CH_5G_BAND_4;
+	case RTW89_BAND_6G:
+		switch (center_chan) {
+		default:
+		case 1 ... 29:
+			subband = RTW89_CH_6G_BAND_IDX0;
+			break;
+		case 33 ... 61:
+			subband = RTW89_CH_6G_BAND_IDX1;
+			break;
+		case 65 ... 93:
+			subband = RTW89_CH_6G_BAND_IDX2;
+			break;
+		case 97 ... 125:
+			subband = RTW89_CH_6G_BAND_IDX3;
+			break;
+		case 129 ... 157:
+			subband = RTW89_CH_6G_BAND_IDX4;
+			break;
+		case 161 ... 189:
+			subband = RTW89_CH_6G_BAND_IDX5;
+			break;
+		case 193 ... 221:
+			subband = RTW89_CH_6G_BAND_IDX6;
+			break;
+		case 225 ... 253:
+			subband = RTW89_CH_6G_BAND_IDX7;
+			break;
+		}
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index deb91f6b67375..c5d40777558ec 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -61,6 +61,15 @@ enum rtw89_subband {
 	RTW89_CH_5G_BAND_3 = 3,
 	RTW89_CH_5G_BAND_4 = 4,
 
+	RTW89_CH_6G_BAND_IDX0, /* Low */
+	RTW89_CH_6G_BAND_IDX1, /* Low */
+	RTW89_CH_6G_BAND_IDX2, /* Mid */
+	RTW89_CH_6G_BAND_IDX3, /* Mid */
+	RTW89_CH_6G_BAND_IDX4, /* High */
+	RTW89_CH_6G_BAND_IDX5, /* High */
+	RTW89_CH_6G_BAND_IDX6, /* Ultra-high */
+	RTW89_CH_6G_BAND_IDX7, /* Ultra-high */
+
 	RTW89_SUBBAND_NR,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index aa326681b5090..acdad5a300ddb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2917,6 +2917,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	u8 i, j;
 
 	switch (subband) {
+	default:
 	case RTW89_CH_2G:
 		thm_up_a = rtw89_8852a_trk_cfg.delta_swingidx_2ga_p;
 		thm_down_a = rtw89_8852a_trk_cfg.delta_swingidx_2ga_n;
@@ -3101,6 +3102,7 @@ static void _tssi_pak(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 subband = rtwdev->hal.current_subband;
 
 	switch (subband) {
+	default:
 	case RTW89_CH_2G:
 		rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
 					 &rtw8852a_tssi_pak_defs_a_2g_tbl,
-- 
2.25.1

