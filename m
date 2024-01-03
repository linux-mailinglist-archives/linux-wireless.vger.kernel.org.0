Return-Path: <linux-wireless+bounces-1414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9B82269F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 02:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE66CB2269B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 01:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A39111B;
	Wed,  3 Jan 2024 01:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820610FE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4031gjLJ3641008, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4031gjLJ3641008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 09:42:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 3 Jan 2024 09:42:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 3 Jan 2024
 09:42:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: 8852b: update TX power tables to R36
Date: Wed, 3 Jan 2024 09:41:13 +0800
Message-ID: <20240103014114.9558-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Update TX power tables to RF version R36. Mainly update configurations for
Canada 5.9 GHz (U-NII 4) according to IC (Industry Canada) certification.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852b_table.c   | 142 +++++++++---------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index d2ce16e98bac..07945d06dc59 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -16936,7 +16936,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_WW][8] = 52,
 	[0][0][1][0][RTW89_WW][10] = 52,
 	[0][0][1][0][RTW89_WW][12] = 52,
-	[0][0][1][0][RTW89_WW][14] = 1,
+	[0][0][1][0][RTW89_WW][14] = 52,
 	[0][0][1][0][RTW89_WW][15] = 52,
 	[0][0][1][0][RTW89_WW][17] = 52,
 	[0][0][1][0][RTW89_WW][19] = 52,
@@ -16954,10 +16954,10 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_WW][42] = 28,
 	[0][0][1][0][RTW89_WW][44] = 28,
 	[0][0][1][0][RTW89_WW][46] = 28,
-	[0][0][1][0][RTW89_WW][48] = 78,
-	[0][0][1][0][RTW89_WW][50] = 78,
-	[0][0][1][0][RTW89_WW][52] = 78,
-	[0][1][1][0][RTW89_WW][0] = 1,
+	[0][0][1][0][RTW89_WW][48] = 76,
+	[0][0][1][0][RTW89_WW][50] = 76,
+	[0][0][1][0][RTW89_WW][52] = 76,
+	[0][1][1][0][RTW89_WW][0] = 30,
 	[0][1][1][0][RTW89_WW][2] = 32,
 	[0][1][1][0][RTW89_WW][4] = 30,
 	[0][1][1][0][RTW89_WW][6] = 30,
@@ -16982,9 +16982,9 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_WW][42] = 16,
 	[0][1][1][0][RTW89_WW][44] = 16,
 	[0][1][1][0][RTW89_WW][46] = 16,
-	[0][1][1][0][RTW89_WW][48] = 56,
-	[0][1][1][0][RTW89_WW][50] = 56,
-	[0][1][1][0][RTW89_WW][52] = 56,
+	[0][1][1][0][RTW89_WW][48] = 50,
+	[0][1][1][0][RTW89_WW][50] = 50,
+	[0][1][1][0][RTW89_WW][52] = 50,
 	[0][0][2][0][RTW89_WW][0] = 42,
 	[0][0][2][0][RTW89_WW][2] = 42,
 	[0][0][2][0][RTW89_WW][4] = 42,
@@ -17038,9 +17038,9 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_WW][42] = 16,
 	[0][1][2][0][RTW89_WW][44] = 16,
 	[0][1][2][0][RTW89_WW][46] = 16,
-	[0][1][2][0][RTW89_WW][48] = 58,
-	[0][1][2][0][RTW89_WW][50] = 58,
-	[0][1][2][0][RTW89_WW][52] = 58,
+	[0][1][2][0][RTW89_WW][48] = 50,
+	[0][1][2][0][RTW89_WW][50] = 52,
+	[0][1][2][0][RTW89_WW][52] = 52,
 	[0][1][2][1][RTW89_WW][0] = 14,
 	[0][1][2][1][RTW89_WW][2] = 14,
 	[0][1][2][1][RTW89_WW][4] = 14,
@@ -17066,9 +17066,9 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_WW][42] = 4,
 	[0][1][2][1][RTW89_WW][44] = 4,
 	[0][1][2][1][RTW89_WW][46] = 4,
-	[0][1][2][1][RTW89_WW][48] = 58,
-	[0][1][2][1][RTW89_WW][50] = 58,
-	[0][1][2][1][RTW89_WW][52] = 58,
+	[0][1][2][1][RTW89_WW][48] = 50,
+	[0][1][2][1][RTW89_WW][50] = 52,
+	[0][1][2][1][RTW89_WW][52] = 52,
 	[1][0][2][0][RTW89_WW][1] = 42,
 	[1][0][2][0][RTW89_WW][5] = 42,
 	[1][0][2][0][RTW89_WW][9] = 52,
@@ -17095,8 +17095,8 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][0][RTW89_WW][36] = 50,
 	[1][1][2][0][RTW89_WW][39] = 16,
 	[1][1][2][0][RTW89_WW][43] = 16,
-	[1][1][2][0][RTW89_WW][47] = 68,
-	[1][1][2][0][RTW89_WW][51] = 66,
+	[1][1][2][0][RTW89_WW][47] = 62,
+	[1][1][2][0][RTW89_WW][51] = 62,
 	[1][1][2][1][RTW89_WW][1] = 16,
 	[1][1][2][1][RTW89_WW][5] = 16,
 	[1][1][2][1][RTW89_WW][9] = 28,
@@ -17109,8 +17109,8 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_WW][36] = 36,
 	[1][1][2][1][RTW89_WW][39] = 4,
 	[1][1][2][1][RTW89_WW][43] = 4,
-	[1][1][2][1][RTW89_WW][47] = 68,
-	[1][1][2][1][RTW89_WW][51] = 66,
+	[1][1][2][1][RTW89_WW][47] = 62,
+	[1][1][2][1][RTW89_WW][51] = 62,
 	[2][0][2][0][RTW89_WW][3] = 42,
 	[2][0][2][0][RTW89_WW][11] = 52,
 	[2][0][2][0][RTW89_WW][18] = 52,
@@ -17227,7 +17227,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_MEXICO][14] = 78,
 	[0][0][1][0][RTW89_CN][14] = 58,
 	[0][0][1][0][RTW89_QATAR][14] = 58,
-	[0][0][1][0][RTW89_UK][14] = 1,
+	[0][0][1][0][RTW89_UK][14] = 58,
 	[0][0][1][0][RTW89_FCC][15] = 76,
 	[0][0][1][0][RTW89_ETSI][15] = 58,
 	[0][0][1][0][RTW89_MKK][15] = 76,
@@ -17435,7 +17435,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][48] = 78,
 	[0][0][1][0][RTW89_ETSI][48] = 127,
 	[0][0][1][0][RTW89_MKK][48] = 127,
-	[0][0][1][0][RTW89_IC][48] = 127,
+	[0][0][1][0][RTW89_IC][48] = 76,
 	[0][0][1][0][RTW89_KCC][48] = 127,
 	[0][0][1][0][RTW89_ACMA][48] = 127,
 	[0][0][1][0][RTW89_CHILE][48] = 127,
@@ -17447,7 +17447,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][50] = 78,
 	[0][0][1][0][RTW89_ETSI][50] = 127,
 	[0][0][1][0][RTW89_MKK][50] = 127,
-	[0][0][1][0][RTW89_IC][50] = 127,
+	[0][0][1][0][RTW89_IC][50] = 76,
 	[0][0][1][0][RTW89_KCC][50] = 127,
 	[0][0][1][0][RTW89_ACMA][50] = 127,
 	[0][0][1][0][RTW89_CHILE][50] = 127,
@@ -17459,7 +17459,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][52] = 78,
 	[0][0][1][0][RTW89_ETSI][52] = 127,
 	[0][0][1][0][RTW89_MKK][52] = 127,
-	[0][0][1][0][RTW89_IC][52] = 127,
+	[0][0][1][0][RTW89_IC][52] = 76,
 	[0][0][1][0][RTW89_KCC][52] = 127,
 	[0][0][1][0][RTW89_ACMA][52] = 127,
 	[0][0][1][0][RTW89_CHILE][52] = 127,
@@ -17479,7 +17479,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_MEXICO][0] = 50,
 	[0][1][1][0][RTW89_CN][0] = 46,
 	[0][1][1][0][RTW89_QATAR][0] = 46,
-	[0][1][1][0][RTW89_UK][0] = 1,
+	[0][1][1][0][RTW89_UK][0] = 46,
 	[0][1][1][0][RTW89_FCC][2] = 68,
 	[0][1][1][0][RTW89_ETSI][2] = 46,
 	[0][1][1][0][RTW89_MKK][2] = 48,
@@ -17771,7 +17771,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][48] = 56,
 	[0][1][1][0][RTW89_ETSI][48] = 127,
 	[0][1][1][0][RTW89_MKK][48] = 127,
-	[0][1][1][0][RTW89_IC][48] = 127,
+	[0][1][1][0][RTW89_IC][48] = 50,
 	[0][1][1][0][RTW89_KCC][48] = 127,
 	[0][1][1][0][RTW89_ACMA][48] = 127,
 	[0][1][1][0][RTW89_CHILE][48] = 127,
@@ -17783,7 +17783,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][50] = 56,
 	[0][1][1][0][RTW89_ETSI][50] = 127,
 	[0][1][1][0][RTW89_MKK][50] = 127,
-	[0][1][1][0][RTW89_IC][50] = 127,
+	[0][1][1][0][RTW89_IC][50] = 50,
 	[0][1][1][0][RTW89_KCC][50] = 127,
 	[0][1][1][0][RTW89_ACMA][50] = 127,
 	[0][1][1][0][RTW89_CHILE][50] = 127,
@@ -17795,7 +17795,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][52] = 56,
 	[0][1][1][0][RTW89_ETSI][52] = 127,
 	[0][1][1][0][RTW89_MKK][52] = 127,
-	[0][1][1][0][RTW89_IC][52] = 127,
+	[0][1][1][0][RTW89_IC][52] = 50,
 	[0][1][1][0][RTW89_KCC][52] = 127,
 	[0][1][1][0][RTW89_ACMA][52] = 127,
 	[0][1][1][0][RTW89_CHILE][52] = 127,
@@ -18107,7 +18107,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][48] = 78,
 	[0][0][2][0][RTW89_ETSI][48] = 127,
 	[0][0][2][0][RTW89_MKK][48] = 127,
-	[0][0][2][0][RTW89_IC][48] = 127,
+	[0][0][2][0][RTW89_IC][48] = 78,
 	[0][0][2][0][RTW89_KCC][48] = 127,
 	[0][0][2][0][RTW89_ACMA][48] = 127,
 	[0][0][2][0][RTW89_CHILE][48] = 127,
@@ -18119,7 +18119,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][50] = 78,
 	[0][0][2][0][RTW89_ETSI][50] = 127,
 	[0][0][2][0][RTW89_MKK][50] = 127,
-	[0][0][2][0][RTW89_IC][50] = 127,
+	[0][0][2][0][RTW89_IC][50] = 78,
 	[0][0][2][0][RTW89_KCC][50] = 127,
 	[0][0][2][0][RTW89_ACMA][50] = 127,
 	[0][0][2][0][RTW89_CHILE][50] = 127,
@@ -18131,7 +18131,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][52] = 78,
 	[0][0][2][0][RTW89_ETSI][52] = 127,
 	[0][0][2][0][RTW89_MKK][52] = 127,
-	[0][0][2][0][RTW89_IC][52] = 127,
+	[0][0][2][0][RTW89_IC][52] = 78,
 	[0][0][2][0][RTW89_KCC][52] = 127,
 	[0][0][2][0][RTW89_ACMA][52] = 127,
 	[0][0][2][0][RTW89_CHILE][52] = 127,
@@ -18443,7 +18443,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][48] = 58,
 	[0][1][2][0][RTW89_ETSI][48] = 127,
 	[0][1][2][0][RTW89_MKK][48] = 127,
-	[0][1][2][0][RTW89_IC][48] = 127,
+	[0][1][2][0][RTW89_IC][48] = 50,
 	[0][1][2][0][RTW89_KCC][48] = 127,
 	[0][1][2][0][RTW89_ACMA][48] = 127,
 	[0][1][2][0][RTW89_CHILE][48] = 127,
@@ -18455,7 +18455,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][50] = 58,
 	[0][1][2][0][RTW89_ETSI][50] = 127,
 	[0][1][2][0][RTW89_MKK][50] = 127,
-	[0][1][2][0][RTW89_IC][50] = 127,
+	[0][1][2][0][RTW89_IC][50] = 52,
 	[0][1][2][0][RTW89_KCC][50] = 127,
 	[0][1][2][0][RTW89_ACMA][50] = 127,
 	[0][1][2][0][RTW89_CHILE][50] = 127,
@@ -18467,7 +18467,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][52] = 58,
 	[0][1][2][0][RTW89_ETSI][52] = 127,
 	[0][1][2][0][RTW89_MKK][52] = 127,
-	[0][1][2][0][RTW89_IC][52] = 127,
+	[0][1][2][0][RTW89_IC][52] = 52,
 	[0][1][2][0][RTW89_KCC][52] = 127,
 	[0][1][2][0][RTW89_ACMA][52] = 127,
 	[0][1][2][0][RTW89_CHILE][52] = 127,
@@ -18779,7 +18779,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][48] = 58,
 	[0][1][2][1][RTW89_ETSI][48] = 127,
 	[0][1][2][1][RTW89_MKK][48] = 127,
-	[0][1][2][1][RTW89_IC][48] = 127,
+	[0][1][2][1][RTW89_IC][48] = 50,
 	[0][1][2][1][RTW89_KCC][48] = 127,
 	[0][1][2][1][RTW89_ACMA][48] = 127,
 	[0][1][2][1][RTW89_CHILE][48] = 127,
@@ -18791,7 +18791,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][50] = 58,
 	[0][1][2][1][RTW89_ETSI][50] = 127,
 	[0][1][2][1][RTW89_MKK][50] = 127,
-	[0][1][2][1][RTW89_IC][50] = 127,
+	[0][1][2][1][RTW89_IC][50] = 52,
 	[0][1][2][1][RTW89_KCC][50] = 127,
 	[0][1][2][1][RTW89_ACMA][50] = 127,
 	[0][1][2][1][RTW89_CHILE][50] = 127,
@@ -18803,7 +18803,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][52] = 58,
 	[0][1][2][1][RTW89_ETSI][52] = 127,
 	[0][1][2][1][RTW89_MKK][52] = 127,
-	[0][1][2][1][RTW89_IC][52] = 127,
+	[0][1][2][1][RTW89_IC][52] = 52,
 	[0][1][2][1][RTW89_KCC][52] = 127,
 	[0][1][2][1][RTW89_ACMA][52] = 127,
 	[0][1][2][1][RTW89_CHILE][52] = 127,
@@ -18959,7 +18959,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][47] = 78,
 	[1][0][2][0][RTW89_ETSI][47] = 127,
 	[1][0][2][0][RTW89_MKK][47] = 127,
-	[1][0][2][0][RTW89_IC][47] = 127,
+	[1][0][2][0][RTW89_IC][47] = 78,
 	[1][0][2][0][RTW89_KCC][47] = 127,
 	[1][0][2][0][RTW89_ACMA][47] = 127,
 	[1][0][2][0][RTW89_CHILE][47] = 127,
@@ -18971,7 +18971,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][51] = 70,
 	[1][0][2][0][RTW89_ETSI][51] = 127,
 	[1][0][2][0][RTW89_MKK][51] = 127,
-	[1][0][2][0][RTW89_IC][51] = 127,
+	[1][0][2][0][RTW89_IC][51] = 78,
 	[1][0][2][0][RTW89_KCC][51] = 127,
 	[1][0][2][0][RTW89_ACMA][51] = 127,
 	[1][0][2][0][RTW89_CHILE][51] = 127,
@@ -19127,7 +19127,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][0][RTW89_FCC][47] = 68,
 	[1][1][2][0][RTW89_ETSI][47] = 127,
 	[1][1][2][0][RTW89_MKK][47] = 127,
-	[1][1][2][0][RTW89_IC][47] = 127,
+	[1][1][2][0][RTW89_IC][47] = 62,
 	[1][1][2][0][RTW89_KCC][47] = 127,
 	[1][1][2][0][RTW89_ACMA][47] = 127,
 	[1][1][2][0][RTW89_CHILE][47] = 127,
@@ -19139,7 +19139,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][0][RTW89_FCC][51] = 66,
 	[1][1][2][0][RTW89_ETSI][51] = 127,
 	[1][1][2][0][RTW89_MKK][51] = 127,
-	[1][1][2][0][RTW89_IC][51] = 127,
+	[1][1][2][0][RTW89_IC][51] = 62,
 	[1][1][2][0][RTW89_KCC][51] = 127,
 	[1][1][2][0][RTW89_ACMA][51] = 127,
 	[1][1][2][0][RTW89_CHILE][51] = 127,
@@ -19295,7 +19295,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_FCC][47] = 68,
 	[1][1][2][1][RTW89_ETSI][47] = 127,
 	[1][1][2][1][RTW89_MKK][47] = 127,
-	[1][1][2][1][RTW89_IC][47] = 127,
+	[1][1][2][1][RTW89_IC][47] = 62,
 	[1][1][2][1][RTW89_KCC][47] = 127,
 	[1][1][2][1][RTW89_ACMA][47] = 127,
 	[1][1][2][1][RTW89_CHILE][47] = 127,
@@ -19307,7 +19307,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_FCC][51] = 66,
 	[1][1][2][1][RTW89_ETSI][51] = 127,
 	[1][1][2][1][RTW89_MKK][51] = 127,
-	[1][1][2][1][RTW89_IC][51] = 127,
+	[1][1][2][1][RTW89_IC][51] = 62,
 	[1][1][2][1][RTW89_KCC][51] = 127,
 	[1][1][2][1][RTW89_ACMA][51] = 127,
 	[1][1][2][1][RTW89_CHILE][51] = 127,
@@ -19391,7 +19391,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][0][2][0][RTW89_FCC][49] = 64,
 	[2][0][2][0][RTW89_ETSI][49] = 127,
 	[2][0][2][0][RTW89_MKK][49] = 127,
-	[2][0][2][0][RTW89_IC][49] = 127,
+	[2][0][2][0][RTW89_IC][49] = 74,
 	[2][0][2][0][RTW89_KCC][49] = 127,
 	[2][0][2][0][RTW89_ACMA][49] = 127,
 	[2][0][2][0][RTW89_CHILE][49] = 127,
@@ -19475,7 +19475,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][0][RTW89_FCC][49] = 58,
 	[2][1][2][0][RTW89_ETSI][49] = 127,
 	[2][1][2][0][RTW89_MKK][49] = 127,
-	[2][1][2][0][RTW89_IC][49] = 127,
+	[2][1][2][0][RTW89_IC][49] = 66,
 	[2][1][2][0][RTW89_KCC][49] = 127,
 	[2][1][2][0][RTW89_ACMA][49] = 127,
 	[2][1][2][0][RTW89_CHILE][49] = 127,
@@ -19559,7 +19559,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][1][RTW89_FCC][49] = 58,
 	[2][1][2][1][RTW89_ETSI][49] = 127,
 	[2][1][2][1][RTW89_MKK][49] = 127,
-	[2][1][2][1][RTW89_IC][49] = 127,
+	[2][1][2][1][RTW89_IC][49] = 66,
 	[2][1][2][1][RTW89_KCC][49] = 127,
 	[2][1][2][1][RTW89_ACMA][49] = 127,
 	[2][1][2][1][RTW89_CHILE][49] = 127,
@@ -20723,9 +20723,9 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_WW][42] = 14,
 	[0][1][RTW89_WW][44] = 14,
 	[0][1][RTW89_WW][46] = 14,
-	[0][1][RTW89_WW][48] = 20,
-	[0][1][RTW89_WW][50] = 20,
-	[0][1][RTW89_WW][52] = 20,
+	[0][1][RTW89_WW][48] = 16,
+	[0][1][RTW89_WW][50] = 16,
+	[0][1][RTW89_WW][52] = 16,
 	[1][0][RTW89_WW][0] = 34,
 	[1][0][RTW89_WW][2] = 34,
 	[1][0][RTW89_WW][4] = 34,
@@ -20779,9 +20779,9 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_WW][42] = 16,
 	[1][1][RTW89_WW][44] = 16,
 	[1][1][RTW89_WW][46] = 16,
-	[1][1][RTW89_WW][48] = 32,
-	[1][1][RTW89_WW][50] = 32,
-	[1][1][RTW89_WW][52] = 32,
+	[1][1][RTW89_WW][48] = 28,
+	[1][1][RTW89_WW][50] = 30,
+	[1][1][RTW89_WW][52] = 30,
 	[2][0][RTW89_WW][0] = 44,
 	[2][0][RTW89_WW][2] = 44,
 	[2][0][RTW89_WW][4] = 44,
@@ -20835,9 +20835,9 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_WW][42] = 16,
 	[2][1][RTW89_WW][44] = 16,
 	[2][1][RTW89_WW][46] = 16,
-	[2][1][RTW89_WW][48] = 44,
-	[2][1][RTW89_WW][50] = 44,
-	[2][1][RTW89_WW][52] = 44,
+	[2][1][RTW89_WW][48] = 40,
+	[2][1][RTW89_WW][50] = 40,
+	[2][1][RTW89_WW][52] = 40,
 	[0][0][RTW89_FCC][0] = 52,
 	[0][0][RTW89_ETSI][0] = 24,
 	[0][0][RTW89_MKK][0] = 26,
@@ -21141,7 +21141,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][48] = 32,
 	[0][0][RTW89_ETSI][48] = 127,
 	[0][0][RTW89_MKK][48] = 127,
-	[0][0][RTW89_IC][48] = 127,
+	[0][0][RTW89_IC][48] = 42,
 	[0][0][RTW89_KCC][48] = 127,
 	[0][0][RTW89_ACMA][48] = 127,
 	[0][0][RTW89_CHILE][48] = 127,
@@ -21153,7 +21153,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][50] = 32,
 	[0][0][RTW89_ETSI][50] = 127,
 	[0][0][RTW89_MKK][50] = 127,
-	[0][0][RTW89_IC][50] = 127,
+	[0][0][RTW89_IC][50] = 42,
 	[0][0][RTW89_KCC][50] = 127,
 	[0][0][RTW89_ACMA][50] = 127,
 	[0][0][RTW89_CHILE][50] = 127,
@@ -21165,7 +21165,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][52] = 32,
 	[0][0][RTW89_ETSI][52] = 127,
 	[0][0][RTW89_MKK][52] = 127,
-	[0][0][RTW89_IC][52] = 127,
+	[0][0][RTW89_IC][52] = 40,
 	[0][0][RTW89_KCC][52] = 127,
 	[0][0][RTW89_ACMA][52] = 127,
 	[0][0][RTW89_CHILE][52] = 127,
@@ -21477,7 +21477,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][48] = 20,
 	[0][1][RTW89_ETSI][48] = 127,
 	[0][1][RTW89_MKK][48] = 127,
-	[0][1][RTW89_IC][48] = 127,
+	[0][1][RTW89_IC][48] = 16,
 	[0][1][RTW89_KCC][48] = 127,
 	[0][1][RTW89_ACMA][48] = 127,
 	[0][1][RTW89_CHILE][48] = 127,
@@ -21489,7 +21489,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][50] = 20,
 	[0][1][RTW89_ETSI][50] = 127,
 	[0][1][RTW89_MKK][50] = 127,
-	[0][1][RTW89_IC][50] = 127,
+	[0][1][RTW89_IC][50] = 16,
 	[0][1][RTW89_KCC][50] = 127,
 	[0][1][RTW89_ACMA][50] = 127,
 	[0][1][RTW89_CHILE][50] = 127,
@@ -21501,7 +21501,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][52] = 20,
 	[0][1][RTW89_ETSI][52] = 127,
 	[0][1][RTW89_MKK][52] = 127,
-	[0][1][RTW89_IC][52] = 127,
+	[0][1][RTW89_IC][52] = 16,
 	[0][1][RTW89_KCC][52] = 127,
 	[0][1][RTW89_ACMA][52] = 127,
 	[0][1][RTW89_CHILE][52] = 127,
@@ -21813,7 +21813,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][48] = 44,
 	[1][0][RTW89_ETSI][48] = 127,
 	[1][0][RTW89_MKK][48] = 127,
-	[1][0][RTW89_IC][48] = 127,
+	[1][0][RTW89_IC][48] = 54,
 	[1][0][RTW89_KCC][48] = 127,
 	[1][0][RTW89_ACMA][48] = 127,
 	[1][0][RTW89_CHILE][48] = 127,
@@ -21825,7 +21825,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][50] = 44,
 	[1][0][RTW89_ETSI][50] = 127,
 	[1][0][RTW89_MKK][50] = 127,
-	[1][0][RTW89_IC][50] = 127,
+	[1][0][RTW89_IC][50] = 54,
 	[1][0][RTW89_KCC][50] = 127,
 	[1][0][RTW89_ACMA][50] = 127,
 	[1][0][RTW89_CHILE][50] = 127,
@@ -21837,7 +21837,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][52] = 44,
 	[1][0][RTW89_ETSI][52] = 127,
 	[1][0][RTW89_MKK][52] = 127,
-	[1][0][RTW89_IC][52] = 127,
+	[1][0][RTW89_IC][52] = 52,
 	[1][0][RTW89_KCC][52] = 127,
 	[1][0][RTW89_ACMA][52] = 127,
 	[1][0][RTW89_CHILE][52] = 127,
@@ -22149,7 +22149,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][48] = 32,
 	[1][1][RTW89_ETSI][48] = 127,
 	[1][1][RTW89_MKK][48] = 127,
-	[1][1][RTW89_IC][48] = 127,
+	[1][1][RTW89_IC][48] = 28,
 	[1][1][RTW89_KCC][48] = 127,
 	[1][1][RTW89_ACMA][48] = 127,
 	[1][1][RTW89_CHILE][48] = 127,
@@ -22161,7 +22161,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][50] = 32,
 	[1][1][RTW89_ETSI][50] = 127,
 	[1][1][RTW89_MKK][50] = 127,
-	[1][1][RTW89_IC][50] = 127,
+	[1][1][RTW89_IC][50] = 30,
 	[1][1][RTW89_KCC][50] = 127,
 	[1][1][RTW89_ACMA][50] = 127,
 	[1][1][RTW89_CHILE][50] = 127,
@@ -22173,7 +22173,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][52] = 32,
 	[1][1][RTW89_ETSI][52] = 127,
 	[1][1][RTW89_MKK][52] = 127,
-	[1][1][RTW89_IC][52] = 127,
+	[1][1][RTW89_IC][52] = 30,
 	[1][1][RTW89_KCC][52] = 127,
 	[1][1][RTW89_ACMA][52] = 127,
 	[1][1][RTW89_CHILE][52] = 127,
@@ -22486,7 +22486,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_ETSI][48] = 127,
 	[2][0][RTW89_MKK][48] = 127,
 	[2][0][RTW89_IC][48] = 127,
-	[2][0][RTW89_KCC][48] = 127,
+	[2][0][RTW89_KCC][48] = 66,
 	[2][0][RTW89_ACMA][48] = 127,
 	[2][0][RTW89_CHILE][48] = 127,
 	[2][0][RTW89_UKRAINE][48] = 127,
@@ -22498,7 +22498,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_ETSI][50] = 127,
 	[2][0][RTW89_MKK][50] = 127,
 	[2][0][RTW89_IC][50] = 127,
-	[2][0][RTW89_KCC][50] = 127,
+	[2][0][RTW89_KCC][50] = 66,
 	[2][0][RTW89_ACMA][50] = 127,
 	[2][0][RTW89_CHILE][50] = 127,
 	[2][0][RTW89_UKRAINE][50] = 127,
@@ -22510,7 +22510,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_ETSI][52] = 127,
 	[2][0][RTW89_MKK][52] = 127,
 	[2][0][RTW89_IC][52] = 127,
-	[2][0][RTW89_KCC][52] = 127,
+	[2][0][RTW89_KCC][52] = 66,
 	[2][0][RTW89_ACMA][52] = 127,
 	[2][0][RTW89_CHILE][52] = 127,
 	[2][0][RTW89_UKRAINE][52] = 127,
@@ -22821,7 +22821,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][48] = 44,
 	[2][1][RTW89_ETSI][48] = 127,
 	[2][1][RTW89_MKK][48] = 127,
-	[2][1][RTW89_IC][48] = 127,
+	[2][1][RTW89_IC][48] = 40,
 	[2][1][RTW89_KCC][48] = 127,
 	[2][1][RTW89_ACMA][48] = 127,
 	[2][1][RTW89_CHILE][48] = 127,
@@ -22833,7 +22833,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][50] = 44,
 	[2][1][RTW89_ETSI][50] = 127,
 	[2][1][RTW89_MKK][50] = 127,
-	[2][1][RTW89_IC][50] = 127,
+	[2][1][RTW89_IC][50] = 40,
 	[2][1][RTW89_KCC][50] = 127,
 	[2][1][RTW89_ACMA][50] = 127,
 	[2][1][RTW89_CHILE][50] = 127,
@@ -22845,7 +22845,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][52] = 44,
 	[2][1][RTW89_ETSI][52] = 127,
 	[2][1][RTW89_MKK][52] = 127,
-	[2][1][RTW89_IC][52] = 127,
+	[2][1][RTW89_IC][52] = 40,
 	[2][1][RTW89_KCC][52] = 127,
 	[2][1][RTW89_ACMA][52] = 127,
 	[2][1][RTW89_CHILE][52] = 127,
-- 
2.25.1


