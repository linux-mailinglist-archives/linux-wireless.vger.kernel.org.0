Return-Path: <linux-wireless+bounces-1415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E618226A0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 02:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A790D284149
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276B1399;
	Wed,  3 Jan 2024 01:42:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31881100
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4031gljcF641060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4031gljcF641060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 09:42:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 3 Jan 2024 09:42:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 3 Jan 2024
 09:42:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8851b: update TX power tables to R37
Date: Wed, 3 Jan 2024 09:41:14 +0800
Message-ID: <20240103014114.9558-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103014114.9558-1-pkshih@realtek.com>
References: <20240103014114.9558-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Update TX power tables to RF version R37. Mainly update configurations for
Canada 5.9 GHz (U-NII 4) according to IC (Industry Canada) certification.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8851b_table.c   | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index 8cb5bde8f625..522883c8dfb9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -5345,7 +5345,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][48] = 72,
 	[0][0][1][0][RTW89_ETSI][48] = 127,
 	[0][0][1][0][RTW89_MKK][48] = 127,
-	[0][0][1][0][RTW89_IC][48] = 127,
+	[0][0][1][0][RTW89_IC][48] = 72,
 	[0][0][1][0][RTW89_KCC][48] = 127,
 	[0][0][1][0][RTW89_ACMA][48] = 127,
 	[0][0][1][0][RTW89_CN][48] = 127,
@@ -5353,7 +5353,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][50] = 72,
 	[0][0][1][0][RTW89_ETSI][50] = 127,
 	[0][0][1][0][RTW89_MKK][50] = 127,
-	[0][0][1][0][RTW89_IC][50] = 127,
+	[0][0][1][0][RTW89_IC][50] = 72,
 	[0][0][1][0][RTW89_KCC][50] = 127,
 	[0][0][1][0][RTW89_ACMA][50] = 127,
 	[0][0][1][0][RTW89_CN][50] = 127,
@@ -5361,7 +5361,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][52] = 72,
 	[0][0][1][0][RTW89_ETSI][52] = 127,
 	[0][0][1][0][RTW89_MKK][52] = 127,
-	[0][0][1][0][RTW89_IC][52] = 127,
+	[0][0][1][0][RTW89_IC][52] = 72,
 	[0][0][1][0][RTW89_KCC][52] = 127,
 	[0][0][1][0][RTW89_ACMA][52] = 127,
 	[0][0][1][0][RTW89_CN][52] = 127,
@@ -5793,7 +5793,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][48] = 74,
 	[0][0][2][0][RTW89_ETSI][48] = 127,
 	[0][0][2][0][RTW89_MKK][48] = 127,
-	[0][0][2][0][RTW89_IC][48] = 127,
+	[0][0][2][0][RTW89_IC][48] = 74,
 	[0][0][2][0][RTW89_KCC][48] = 127,
 	[0][0][2][0][RTW89_ACMA][48] = 127,
 	[0][0][2][0][RTW89_CN][48] = 127,
@@ -5801,7 +5801,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][50] = 76,
 	[0][0][2][0][RTW89_ETSI][50] = 127,
 	[0][0][2][0][RTW89_MKK][50] = 127,
-	[0][0][2][0][RTW89_IC][50] = 127,
+	[0][0][2][0][RTW89_IC][50] = 76,
 	[0][0][2][0][RTW89_KCC][50] = 127,
 	[0][0][2][0][RTW89_ACMA][50] = 127,
 	[0][0][2][0][RTW89_CN][50] = 127,
@@ -5809,7 +5809,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][52] = 76,
 	[0][0][2][0][RTW89_ETSI][52] = 127,
 	[0][0][2][0][RTW89_MKK][52] = 127,
-	[0][0][2][0][RTW89_IC][52] = 127,
+	[0][0][2][0][RTW89_IC][52] = 76,
 	[0][0][2][0][RTW89_KCC][52] = 127,
 	[0][0][2][0][RTW89_ACMA][52] = 127,
 	[0][0][2][0][RTW89_CN][52] = 127,
@@ -6361,7 +6361,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][47] = 84,
 	[1][0][2][0][RTW89_ETSI][47] = 127,
 	[1][0][2][0][RTW89_MKK][47] = 127,
-	[1][0][2][0][RTW89_IC][47] = 127,
+	[1][0][2][0][RTW89_IC][47] = 84,
 	[1][0][2][0][RTW89_KCC][47] = 127,
 	[1][0][2][0][RTW89_ACMA][47] = 127,
 	[1][0][2][0][RTW89_CN][47] = 127,
@@ -6369,7 +6369,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][51] = 84,
 	[1][0][2][0][RTW89_ETSI][51] = 127,
 	[1][0][2][0][RTW89_MKK][51] = 127,
-	[1][0][2][0][RTW89_IC][51] = 127,
+	[1][0][2][0][RTW89_IC][51] = 84,
 	[1][0][2][0][RTW89_KCC][51] = 127,
 	[1][0][2][0][RTW89_ACMA][51] = 127,
 	[1][0][2][0][RTW89_CN][51] = 127,
@@ -6649,7 +6649,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][0][2][0][RTW89_FCC][49] = 74,
 	[2][0][2][0][RTW89_ETSI][49] = 127,
 	[2][0][2][0][RTW89_MKK][49] = 127,
-	[2][0][2][0][RTW89_IC][49] = 127,
+	[2][0][2][0][RTW89_IC][49] = 74,
 	[2][0][2][0][RTW89_KCC][49] = 127,
 	[2][0][2][0][RTW89_ACMA][49] = 127,
 	[2][0][2][0][RTW89_CN][49] = 127,
@@ -7975,7 +7975,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][48] = 42,
 	[0][0][RTW89_ETSI][48] = 127,
 	[0][0][RTW89_MKK][48] = 127,
-	[0][0][RTW89_IC][48] = 127,
+	[0][0][RTW89_IC][48] = 42,
 	[0][0][RTW89_KCC][48] = 127,
 	[0][0][RTW89_ACMA][48] = 127,
 	[0][0][RTW89_CN][48] = 127,
@@ -7983,7 +7983,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][50] = 42,
 	[0][0][RTW89_ETSI][50] = 127,
 	[0][0][RTW89_MKK][50] = 127,
-	[0][0][RTW89_IC][50] = 127,
+	[0][0][RTW89_IC][50] = 42,
 	[0][0][RTW89_KCC][50] = 127,
 	[0][0][RTW89_ACMA][50] = 127,
 	[0][0][RTW89_CN][50] = 127,
@@ -7991,7 +7991,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][52] = 40,
 	[0][0][RTW89_ETSI][52] = 127,
 	[0][0][RTW89_MKK][52] = 127,
-	[0][0][RTW89_IC][52] = 127,
+	[0][0][RTW89_IC][52] = 40,
 	[0][0][RTW89_KCC][52] = 127,
 	[0][0][RTW89_ACMA][52] = 127,
 	[0][0][RTW89_CN][52] = 127,
@@ -8423,7 +8423,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][48] = 52,
 	[1][0][RTW89_ETSI][48] = 127,
 	[1][0][RTW89_MKK][48] = 127,
-	[1][0][RTW89_IC][48] = 127,
+	[1][0][RTW89_IC][48] = 52,
 	[1][0][RTW89_KCC][48] = 127,
 	[1][0][RTW89_ACMA][48] = 127,
 	[1][0][RTW89_CN][48] = 127,
@@ -8431,7 +8431,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][50] = 52,
 	[1][0][RTW89_ETSI][50] = 127,
 	[1][0][RTW89_MKK][50] = 127,
-	[1][0][RTW89_IC][50] = 127,
+	[1][0][RTW89_IC][50] = 52,
 	[1][0][RTW89_KCC][50] = 127,
 	[1][0][RTW89_ACMA][50] = 127,
 	[1][0][RTW89_CN][50] = 127,
@@ -8439,7 +8439,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][52] = 52,
 	[1][0][RTW89_ETSI][52] = 127,
 	[1][0][RTW89_MKK][52] = 127,
-	[1][0][RTW89_IC][52] = 127,
+	[1][0][RTW89_IC][52] = 52,
 	[1][0][RTW89_KCC][52] = 127,
 	[1][0][RTW89_ACMA][52] = 127,
 	[1][0][RTW89_CN][52] = 127,
@@ -8871,7 +8871,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][48] = 64,
 	[2][0][RTW89_ETSI][48] = 127,
 	[2][0][RTW89_MKK][48] = 127,
-	[2][0][RTW89_IC][48] = 127,
+	[2][0][RTW89_IC][48] = 64,
 	[2][0][RTW89_KCC][48] = 127,
 	[2][0][RTW89_ACMA][48] = 127,
 	[2][0][RTW89_CN][48] = 127,
@@ -8879,7 +8879,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][50] = 64,
 	[2][0][RTW89_ETSI][50] = 127,
 	[2][0][RTW89_MKK][50] = 127,
-	[2][0][RTW89_IC][50] = 127,
+	[2][0][RTW89_IC][50] = 64,
 	[2][0][RTW89_KCC][50] = 127,
 	[2][0][RTW89_ACMA][50] = 127,
 	[2][0][RTW89_CN][50] = 127,
@@ -8887,7 +8887,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][52] = 60,
 	[2][0][RTW89_ETSI][52] = 127,
 	[2][0][RTW89_MKK][52] = 127,
-	[2][0][RTW89_IC][52] = 127,
+	[2][0][RTW89_IC][52] = 60,
 	[2][0][RTW89_KCC][52] = 127,
 	[2][0][RTW89_ACMA][52] = 127,
 	[2][0][RTW89_CN][52] = 127,
@@ -11055,7 +11055,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][48] = 72,
 	[0][0][1][0][RTW89_ETSI][48] = 127,
 	[0][0][1][0][RTW89_MKK][48] = 127,
-	[0][0][1][0][RTW89_IC][48] = 127,
+	[0][0][1][0][RTW89_IC][48] = 72,
 	[0][0][1][0][RTW89_KCC][48] = 127,
 	[0][0][1][0][RTW89_ACMA][48] = 127,
 	[0][0][1][0][RTW89_CN][48] = 127,
@@ -11063,7 +11063,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][50] = 72,
 	[0][0][1][0][RTW89_ETSI][50] = 127,
 	[0][0][1][0][RTW89_MKK][50] = 127,
-	[0][0][1][0][RTW89_IC][50] = 127,
+	[0][0][1][0][RTW89_IC][50] = 72,
 	[0][0][1][0][RTW89_KCC][50] = 127,
 	[0][0][1][0][RTW89_ACMA][50] = 127,
 	[0][0][1][0][RTW89_CN][50] = 127,
@@ -11071,7 +11071,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][52] = 72,
 	[0][0][1][0][RTW89_ETSI][52] = 127,
 	[0][0][1][0][RTW89_MKK][52] = 127,
-	[0][0][1][0][RTW89_IC][52] = 127,
+	[0][0][1][0][RTW89_IC][52] = 72,
 	[0][0][1][0][RTW89_KCC][52] = 127,
 	[0][0][1][0][RTW89_ACMA][52] = 127,
 	[0][0][1][0][RTW89_CN][52] = 127,
@@ -11503,7 +11503,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][48] = 74,
 	[0][0][2][0][RTW89_ETSI][48] = 127,
 	[0][0][2][0][RTW89_MKK][48] = 127,
-	[0][0][2][0][RTW89_IC][48] = 127,
+	[0][0][2][0][RTW89_IC][48] = 74,
 	[0][0][2][0][RTW89_KCC][48] = 127,
 	[0][0][2][0][RTW89_ACMA][48] = 127,
 	[0][0][2][0][RTW89_CN][48] = 127,
@@ -11511,7 +11511,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][50] = 74,
 	[0][0][2][0][RTW89_ETSI][50] = 127,
 	[0][0][2][0][RTW89_MKK][50] = 127,
-	[0][0][2][0][RTW89_IC][50] = 127,
+	[0][0][2][0][RTW89_IC][50] = 74,
 	[0][0][2][0][RTW89_KCC][50] = 127,
 	[0][0][2][0][RTW89_ACMA][50] = 127,
 	[0][0][2][0][RTW89_CN][50] = 127,
@@ -11519,7 +11519,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][52] = 74,
 	[0][0][2][0][RTW89_ETSI][52] = 127,
 	[0][0][2][0][RTW89_MKK][52] = 127,
-	[0][0][2][0][RTW89_IC][52] = 127,
+	[0][0][2][0][RTW89_IC][52] = 74,
 	[0][0][2][0][RTW89_KCC][52] = 127,
 	[0][0][2][0][RTW89_ACMA][52] = 127,
 	[0][0][2][0][RTW89_CN][52] = 127,
@@ -12071,7 +12071,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][47] = 80,
 	[1][0][2][0][RTW89_ETSI][47] = 127,
 	[1][0][2][0][RTW89_MKK][47] = 127,
-	[1][0][2][0][RTW89_IC][47] = 127,
+	[1][0][2][0][RTW89_IC][47] = 80,
 	[1][0][2][0][RTW89_KCC][47] = 127,
 	[1][0][2][0][RTW89_ACMA][47] = 127,
 	[1][0][2][0][RTW89_CN][47] = 127,
@@ -12079,7 +12079,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][51] = 80,
 	[1][0][2][0][RTW89_ETSI][51] = 127,
 	[1][0][2][0][RTW89_MKK][51] = 127,
-	[1][0][2][0][RTW89_IC][51] = 127,
+	[1][0][2][0][RTW89_IC][51] = 80,
 	[1][0][2][0][RTW89_KCC][51] = 127,
 	[1][0][2][0][RTW89_ACMA][51] = 127,
 	[1][0][2][0][RTW89_CN][51] = 127,
@@ -12359,7 +12359,7 @@ const s8 rtw89_8851b_txpwr_lmt_5g_type2[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][0][2][0][RTW89_FCC][49] = 72,
 	[2][0][2][0][RTW89_ETSI][49] = 127,
 	[2][0][2][0][RTW89_MKK][49] = 127,
-	[2][0][2][0][RTW89_IC][49] = 127,
+	[2][0][2][0][RTW89_IC][49] = 72,
 	[2][0][2][0][RTW89_KCC][49] = 127,
 	[2][0][2][0][RTW89_ACMA][49] = 127,
 	[2][0][2][0][RTW89_CN][49] = 127,
@@ -13685,7 +13685,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][48] = 40,
 	[0][0][RTW89_ETSI][48] = 127,
 	[0][0][RTW89_MKK][48] = 127,
-	[0][0][RTW89_IC][48] = 127,
+	[0][0][RTW89_IC][48] = 40,
 	[0][0][RTW89_KCC][48] = 127,
 	[0][0][RTW89_ACMA][48] = 127,
 	[0][0][RTW89_CN][48] = 127,
@@ -13693,7 +13693,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][50] = 42,
 	[0][0][RTW89_ETSI][50] = 127,
 	[0][0][RTW89_MKK][50] = 127,
-	[0][0][RTW89_IC][50] = 127,
+	[0][0][RTW89_IC][50] = 42,
 	[0][0][RTW89_KCC][50] = 127,
 	[0][0][RTW89_ACMA][50] = 127,
 	[0][0][RTW89_CN][50] = 127,
@@ -13701,7 +13701,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][52] = 38,
 	[0][0][RTW89_ETSI][52] = 127,
 	[0][0][RTW89_MKK][52] = 127,
-	[0][0][RTW89_IC][52] = 127,
+	[0][0][RTW89_IC][52] = 38,
 	[0][0][RTW89_KCC][52] = 127,
 	[0][0][RTW89_ACMA][52] = 127,
 	[0][0][RTW89_CN][52] = 127,
@@ -14133,7 +14133,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][48] = 52,
 	[1][0][RTW89_ETSI][48] = 127,
 	[1][0][RTW89_MKK][48] = 127,
-	[1][0][RTW89_IC][48] = 127,
+	[1][0][RTW89_IC][48] = 52,
 	[1][0][RTW89_KCC][48] = 127,
 	[1][0][RTW89_ACMA][48] = 127,
 	[1][0][RTW89_CN][48] = 127,
@@ -14141,7 +14141,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][50] = 52,
 	[1][0][RTW89_ETSI][50] = 127,
 	[1][0][RTW89_MKK][50] = 127,
-	[1][0][RTW89_IC][50] = 127,
+	[1][0][RTW89_IC][50] = 52,
 	[1][0][RTW89_KCC][50] = 127,
 	[1][0][RTW89_ACMA][50] = 127,
 	[1][0][RTW89_CN][50] = 127,
@@ -14149,7 +14149,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][52] = 50,
 	[1][0][RTW89_ETSI][52] = 127,
 	[1][0][RTW89_MKK][52] = 127,
-	[1][0][RTW89_IC][52] = 127,
+	[1][0][RTW89_IC][52] = 50,
 	[1][0][RTW89_KCC][52] = 127,
 	[1][0][RTW89_ACMA][52] = 127,
 	[1][0][RTW89_CN][52] = 127,
@@ -14581,7 +14581,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][48] = 62,
 	[2][0][RTW89_ETSI][48] = 127,
 	[2][0][RTW89_MKK][48] = 127,
-	[2][0][RTW89_IC][48] = 127,
+	[2][0][RTW89_IC][48] = 62,
 	[2][0][RTW89_KCC][48] = 127,
 	[2][0][RTW89_ACMA][48] = 127,
 	[2][0][RTW89_CN][48] = 127,
@@ -14589,7 +14589,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][50] = 62,
 	[2][0][RTW89_ETSI][50] = 127,
 	[2][0][RTW89_MKK][50] = 127,
-	[2][0][RTW89_IC][50] = 127,
+	[2][0][RTW89_IC][50] = 62,
 	[2][0][RTW89_KCC][50] = 127,
 	[2][0][RTW89_ACMA][50] = 127,
 	[2][0][RTW89_CN][50] = 127,
@@ -14597,7 +14597,7 @@ const s8 rtw89_8851b_txpwr_lmt_ru_5g_type2[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][52] = 60,
 	[2][0][RTW89_ETSI][52] = 127,
 	[2][0][RTW89_MKK][52] = 127,
-	[2][0][RTW89_IC][52] = 127,
+	[2][0][RTW89_IC][52] = 60,
 	[2][0][RTW89_KCC][52] = 127,
 	[2][0][RTW89_ACMA][52] = 127,
 	[2][0][RTW89_CN][52] = 127,
-- 
2.25.1


