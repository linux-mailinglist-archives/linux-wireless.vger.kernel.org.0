Return-Path: <linux-wireless+bounces-5515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34F8910CA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EF11F23889
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283F3FE27;
	Fri, 29 Mar 2024 01:54:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32A3DB89
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677265; cv=none; b=lcFyTIuBs4Ze0Aw1iM8chIM8/hTHN9/2gi2jg8l3hCZQZnfSPgbGlrHn/4CAsCCbqGTzuoxjiYe4QZlf1xIwW/+bUYiu5HGT15FaJcAHGtGNSgVPbVqjJ8jBV0R0ctysfbiHUpGXCjDMujDajFxaMnkmpu00DFs4udCs9pH1Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677265; c=relaxed/simple;
	bh=2KmPigWUc/MRtIkKz5v9r+5GKf6a9mHl9jRfSkUZp7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXUPumdCyb1hBSPW3ZUmVAGs+5VpjaTHbAGbVdfLtuxXqm+p7XqnemqhEqZr21FfuPqonbnE9ntU5zdAzeOuvlJzCacc/RZWgXFQxZ7QNh/fFs2GheybJNbLPe4O/fvlbpdipxVgKjD5ZGWmBvImEa16ie0ArSArFYA2gRGSfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1sKfmD3183219, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1sKfmD3183219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:54:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:54:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:54:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: 8852c: update TX power tables to R69
Date: Fri, 29 Mar 2024 09:52:49 +0800
Message-ID: <20240329015251.22762-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329015251.22762-1-pkshih@realtek.com>
References: <20240329015251.22762-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Configure applicable values for IC (Industry Canada) on 5.9GHz.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index ab1a0aadc869..85060c727bb1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -34521,7 +34521,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][48] = 72,
 	[0][0][1][0][RTW89_ETSI][48] = 127,
 	[0][0][1][0][RTW89_MKK][48] = 127,
-	[0][0][1][0][RTW89_IC][48] = 127,
+	[0][0][1][0][RTW89_IC][48] = 72,
 	[0][0][1][0][RTW89_KCC][48] = 127,
 	[0][0][1][0][RTW89_ACMA][48] = 127,
 	[0][0][1][0][RTW89_CN][48] = 127,
@@ -34534,7 +34534,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][50] = 72,
 	[0][0][1][0][RTW89_ETSI][50] = 127,
 	[0][0][1][0][RTW89_MKK][50] = 127,
-	[0][0][1][0][RTW89_IC][50] = 127,
+	[0][0][1][0][RTW89_IC][50] = 72,
 	[0][0][1][0][RTW89_KCC][50] = 127,
 	[0][0][1][0][RTW89_ACMA][50] = 127,
 	[0][0][1][0][RTW89_CN][50] = 127,
@@ -34547,7 +34547,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][1][0][RTW89_FCC][52] = 72,
 	[0][0][1][0][RTW89_ETSI][52] = 127,
 	[0][0][1][0][RTW89_MKK][52] = 127,
-	[0][0][1][0][RTW89_IC][52] = 127,
+	[0][0][1][0][RTW89_IC][52] = 72,
 	[0][0][1][0][RTW89_KCC][52] = 127,
 	[0][0][1][0][RTW89_ACMA][52] = 127,
 	[0][0][1][0][RTW89_CN][52] = 127,
@@ -34885,7 +34885,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][48] = 48,
 	[0][1][1][0][RTW89_ETSI][48] = 127,
 	[0][1][1][0][RTW89_MKK][48] = 127,
-	[0][1][1][0][RTW89_IC][48] = 127,
+	[0][1][1][0][RTW89_IC][48] = 48,
 	[0][1][1][0][RTW89_KCC][48] = 127,
 	[0][1][1][0][RTW89_ACMA][48] = 127,
 	[0][1][1][0][RTW89_CN][48] = 127,
@@ -34898,7 +34898,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][50] = 48,
 	[0][1][1][0][RTW89_ETSI][50] = 127,
 	[0][1][1][0][RTW89_MKK][50] = 127,
-	[0][1][1][0][RTW89_IC][50] = 127,
+	[0][1][1][0][RTW89_IC][50] = 48,
 	[0][1][1][0][RTW89_KCC][50] = 127,
 	[0][1][1][0][RTW89_ACMA][50] = 127,
 	[0][1][1][0][RTW89_CN][50] = 127,
@@ -34911,7 +34911,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][1][0][RTW89_FCC][52] = 48,
 	[0][1][1][0][RTW89_ETSI][52] = 127,
 	[0][1][1][0][RTW89_MKK][52] = 127,
-	[0][1][1][0][RTW89_IC][52] = 127,
+	[0][1][1][0][RTW89_IC][52] = 48,
 	[0][1][1][0][RTW89_KCC][52] = 127,
 	[0][1][1][0][RTW89_ACMA][52] = 127,
 	[0][1][1][0][RTW89_CN][52] = 127,
@@ -35249,7 +35249,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][48] = 72,
 	[0][0][2][0][RTW89_ETSI][48] = 127,
 	[0][0][2][0][RTW89_MKK][48] = 127,
-	[0][0][2][0][RTW89_IC][48] = 127,
+	[0][0][2][0][RTW89_IC][48] = 72,
 	[0][0][2][0][RTW89_KCC][48] = 127,
 	[0][0][2][0][RTW89_ACMA][48] = 127,
 	[0][0][2][0][RTW89_CN][48] = 127,
@@ -35262,7 +35262,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][50] = 72,
 	[0][0][2][0][RTW89_ETSI][50] = 127,
 	[0][0][2][0][RTW89_MKK][50] = 127,
-	[0][0][2][0][RTW89_IC][50] = 127,
+	[0][0][2][0][RTW89_IC][50] = 72,
 	[0][0][2][0][RTW89_KCC][50] = 127,
 	[0][0][2][0][RTW89_ACMA][50] = 127,
 	[0][0][2][0][RTW89_CN][50] = 127,
@@ -35275,7 +35275,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][0][2][0][RTW89_FCC][52] = 72,
 	[0][0][2][0][RTW89_ETSI][52] = 127,
 	[0][0][2][0][RTW89_MKK][52] = 127,
-	[0][0][2][0][RTW89_IC][52] = 127,
+	[0][0][2][0][RTW89_IC][52] = 72,
 	[0][0][2][0][RTW89_KCC][52] = 127,
 	[0][0][2][0][RTW89_ACMA][52] = 127,
 	[0][0][2][0][RTW89_CN][52] = 127,
@@ -35613,7 +35613,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][48] = 48,
 	[0][1][2][0][RTW89_ETSI][48] = 127,
 	[0][1][2][0][RTW89_MKK][48] = 127,
-	[0][1][2][0][RTW89_IC][48] = 127,
+	[0][1][2][0][RTW89_IC][48] = 48,
 	[0][1][2][0][RTW89_KCC][48] = 127,
 	[0][1][2][0][RTW89_ACMA][48] = 127,
 	[0][1][2][0][RTW89_CN][48] = 127,
@@ -35626,7 +35626,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][50] = 50,
 	[0][1][2][0][RTW89_ETSI][50] = 127,
 	[0][1][2][0][RTW89_MKK][50] = 127,
-	[0][1][2][0][RTW89_IC][50] = 127,
+	[0][1][2][0][RTW89_IC][50] = 50,
 	[0][1][2][0][RTW89_KCC][50] = 127,
 	[0][1][2][0][RTW89_ACMA][50] = 127,
 	[0][1][2][0][RTW89_CN][50] = 127,
@@ -35639,7 +35639,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][0][RTW89_FCC][52] = 48,
 	[0][1][2][0][RTW89_ETSI][52] = 127,
 	[0][1][2][0][RTW89_MKK][52] = 127,
-	[0][1][2][0][RTW89_IC][52] = 127,
+	[0][1][2][0][RTW89_IC][52] = 48,
 	[0][1][2][0][RTW89_KCC][52] = 127,
 	[0][1][2][0][RTW89_ACMA][52] = 127,
 	[0][1][2][0][RTW89_CN][52] = 127,
@@ -35977,7 +35977,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][48] = 48,
 	[0][1][2][1][RTW89_ETSI][48] = 127,
 	[0][1][2][1][RTW89_MKK][48] = 127,
-	[0][1][2][1][RTW89_IC][48] = 127,
+	[0][1][2][1][RTW89_IC][48] = 48,
 	[0][1][2][1][RTW89_KCC][48] = 127,
 	[0][1][2][1][RTW89_ACMA][48] = 127,
 	[0][1][2][1][RTW89_CN][48] = 127,
@@ -35990,7 +35990,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][50] = 50,
 	[0][1][2][1][RTW89_ETSI][50] = 127,
 	[0][1][2][1][RTW89_MKK][50] = 127,
-	[0][1][2][1][RTW89_IC][50] = 127,
+	[0][1][2][1][RTW89_IC][50] = 50,
 	[0][1][2][1][RTW89_KCC][50] = 127,
 	[0][1][2][1][RTW89_ACMA][50] = 127,
 	[0][1][2][1][RTW89_CN][50] = 127,
@@ -36003,7 +36003,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[0][1][2][1][RTW89_FCC][52] = 48,
 	[0][1][2][1][RTW89_ETSI][52] = 127,
 	[0][1][2][1][RTW89_MKK][52] = 127,
-	[0][1][2][1][RTW89_IC][52] = 127,
+	[0][1][2][1][RTW89_IC][52] = 48,
 	[0][1][2][1][RTW89_KCC][52] = 127,
 	[0][1][2][1][RTW89_ACMA][52] = 127,
 	[0][1][2][1][RTW89_CN][52] = 127,
@@ -36172,7 +36172,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][47] = 68,
 	[1][0][2][0][RTW89_ETSI][47] = 127,
 	[1][0][2][0][RTW89_MKK][47] = 127,
-	[1][0][2][0][RTW89_IC][47] = 127,
+	[1][0][2][0][RTW89_IC][47] = 68,
 	[1][0][2][0][RTW89_KCC][47] = 127,
 	[1][0][2][0][RTW89_ACMA][47] = 127,
 	[1][0][2][0][RTW89_CN][47] = 127,
@@ -36185,7 +36185,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][0][2][0][RTW89_FCC][51] = 68,
 	[1][0][2][0][RTW89_ETSI][51] = 127,
 	[1][0][2][0][RTW89_MKK][51] = 127,
-	[1][0][2][0][RTW89_IC][51] = 127,
+	[1][0][2][0][RTW89_IC][51] = 68,
 	[1][0][2][0][RTW89_KCC][51] = 127,
 	[1][0][2][0][RTW89_ACMA][51] = 127,
 	[1][0][2][0][RTW89_CN][51] = 127,
@@ -36354,7 +36354,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][0][RTW89_FCC][47] = 62,
 	[1][1][2][0][RTW89_ETSI][47] = 127,
 	[1][1][2][0][RTW89_MKK][47] = 127,
-	[1][1][2][0][RTW89_IC][47] = 127,
+	[1][1][2][0][RTW89_IC][47] = 62,
 	[1][1][2][0][RTW89_KCC][47] = 127,
 	[1][1][2][0][RTW89_ACMA][47] = 127,
 	[1][1][2][0][RTW89_CN][47] = 127,
@@ -36367,7 +36367,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][0][RTW89_FCC][51] = 60,
 	[1][1][2][0][RTW89_ETSI][51] = 127,
 	[1][1][2][0][RTW89_MKK][51] = 127,
-	[1][1][2][0][RTW89_IC][51] = 127,
+	[1][1][2][0][RTW89_IC][51] = 60,
 	[1][1][2][0][RTW89_KCC][51] = 127,
 	[1][1][2][0][RTW89_ACMA][51] = 127,
 	[1][1][2][0][RTW89_CN][51] = 127,
@@ -36536,7 +36536,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_FCC][47] = 62,
 	[1][1][2][1][RTW89_ETSI][47] = 127,
 	[1][1][2][1][RTW89_MKK][47] = 127,
-	[1][1][2][1][RTW89_IC][47] = 127,
+	[1][1][2][1][RTW89_IC][47] = 62,
 	[1][1][2][1][RTW89_KCC][47] = 127,
 	[1][1][2][1][RTW89_ACMA][47] = 127,
 	[1][1][2][1][RTW89_CN][47] = 127,
@@ -36549,7 +36549,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_FCC][51] = 60,
 	[1][1][2][1][RTW89_ETSI][51] = 127,
 	[1][1][2][1][RTW89_MKK][51] = 127,
-	[1][1][2][1][RTW89_IC][51] = 127,
+	[1][1][2][1][RTW89_IC][51] = 60,
 	[1][1][2][1][RTW89_KCC][51] = 127,
 	[1][1][2][1][RTW89_ACMA][51] = 127,
 	[1][1][2][1][RTW89_CN][51] = 127,
@@ -36640,7 +36640,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][0][2][0][RTW89_FCC][49] = 62,
 	[2][0][2][0][RTW89_ETSI][49] = 127,
 	[2][0][2][0][RTW89_MKK][49] = 127,
-	[2][0][2][0][RTW89_IC][49] = 127,
+	[2][0][2][0][RTW89_IC][49] = 62,
 	[2][0][2][0][RTW89_KCC][49] = 127,
 	[2][0][2][0][RTW89_ACMA][49] = 127,
 	[2][0][2][0][RTW89_CN][49] = 127,
@@ -36731,7 +36731,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][0][RTW89_FCC][49] = 62,
 	[2][1][2][0][RTW89_ETSI][49] = 127,
 	[2][1][2][0][RTW89_MKK][49] = 127,
-	[2][1][2][0][RTW89_IC][49] = 127,
+	[2][1][2][0][RTW89_IC][49] = 62,
 	[2][1][2][0][RTW89_KCC][49] = 127,
 	[2][1][2][0][RTW89_ACMA][49] = 127,
 	[2][1][2][0][RTW89_CN][49] = 127,
@@ -36822,7 +36822,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][1][RTW89_FCC][49] = 62,
 	[2][1][2][1][RTW89_ETSI][49] = 127,
 	[2][1][2][1][RTW89_MKK][49] = 127,
-	[2][1][2][1][RTW89_IC][49] = 127,
+	[2][1][2][1][RTW89_IC][49] = 62,
 	[2][1][2][1][RTW89_KCC][49] = 127,
 	[2][1][2][1][RTW89_ACMA][49] = 127,
 	[2][1][2][1][RTW89_CN][49] = 127,
@@ -36861,7 +36861,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[3][0][2][0][RTW89_FCC][45] = 52,
 	[3][0][2][0][RTW89_ETSI][45] = 127,
 	[3][0][2][0][RTW89_MKK][45] = 127,
-	[3][0][2][0][RTW89_IC][45] = 127,
+	[3][0][2][0][RTW89_IC][45] = 52,
 	[3][0][2][0][RTW89_KCC][45] = 127,
 	[3][0][2][0][RTW89_ACMA][45] = 127,
 	[3][0][2][0][RTW89_CN][45] = 127,
@@ -36900,7 +36900,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[3][1][2][0][RTW89_FCC][45] = 46,
 	[3][1][2][0][RTW89_ETSI][45] = 127,
 	[3][1][2][0][RTW89_MKK][45] = 127,
-	[3][1][2][0][RTW89_IC][45] = 127,
+	[3][1][2][0][RTW89_IC][45] = 46,
 	[3][1][2][0][RTW89_KCC][45] = 127,
 	[3][1][2][0][RTW89_ACMA][45] = 127,
 	[3][1][2][0][RTW89_CN][45] = 127,
@@ -36939,7 +36939,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[3][1][2][1][RTW89_FCC][45] = 46,
 	[3][1][2][1][RTW89_ETSI][45] = 127,
 	[3][1][2][1][RTW89_MKK][45] = 127,
-	[3][1][2][1][RTW89_IC][45] = 127,
+	[3][1][2][1][RTW89_IC][45] = 46,
 	[3][1][2][1][RTW89_KCC][45] = 127,
 	[3][1][2][1][RTW89_ACMA][45] = 127,
 	[3][1][2][1][RTW89_CN][45] = 127,
@@ -49374,7 +49374,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][48] = 46,
 	[0][0][RTW89_ETSI][48] = 127,
 	[0][0][RTW89_MKK][48] = 127,
-	[0][0][RTW89_IC][48] = 127,
+	[0][0][RTW89_IC][48] = 46,
 	[0][0][RTW89_KCC][48] = 127,
 	[0][0][RTW89_ACMA][48] = 127,
 	[0][0][RTW89_CN][48] = 127,
@@ -49387,7 +49387,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][50] = 44,
 	[0][0][RTW89_ETSI][50] = 127,
 	[0][0][RTW89_MKK][50] = 127,
-	[0][0][RTW89_IC][50] = 127,
+	[0][0][RTW89_IC][50] = 44,
 	[0][0][RTW89_KCC][50] = 127,
 	[0][0][RTW89_ACMA][50] = 127,
 	[0][0][RTW89_CN][50] = 127,
@@ -49400,7 +49400,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][0][RTW89_FCC][52] = 34,
 	[0][0][RTW89_ETSI][52] = 127,
 	[0][0][RTW89_MKK][52] = 127,
-	[0][0][RTW89_IC][52] = 127,
+	[0][0][RTW89_IC][52] = 34,
 	[0][0][RTW89_KCC][52] = 127,
 	[0][0][RTW89_ACMA][52] = 127,
 	[0][0][RTW89_CN][52] = 127,
@@ -49738,7 +49738,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][48] = 20,
 	[0][1][RTW89_ETSI][48] = 127,
 	[0][1][RTW89_MKK][48] = 127,
-	[0][1][RTW89_IC][48] = 127,
+	[0][1][RTW89_IC][48] = 20,
 	[0][1][RTW89_KCC][48] = 127,
 	[0][1][RTW89_ACMA][48] = 127,
 	[0][1][RTW89_CN][48] = 127,
@@ -49751,7 +49751,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][50] = 20,
 	[0][1][RTW89_ETSI][50] = 127,
 	[0][1][RTW89_MKK][50] = 127,
-	[0][1][RTW89_IC][50] = 127,
+	[0][1][RTW89_IC][50] = 20,
 	[0][1][RTW89_KCC][50] = 127,
 	[0][1][RTW89_ACMA][50] = 127,
 	[0][1][RTW89_CN][50] = 127,
@@ -49764,7 +49764,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[0][1][RTW89_FCC][52] = 8,
 	[0][1][RTW89_ETSI][52] = 127,
 	[0][1][RTW89_MKK][52] = 127,
-	[0][1][RTW89_IC][52] = 127,
+	[0][1][RTW89_IC][52] = 8,
 	[0][1][RTW89_KCC][52] = 127,
 	[0][1][RTW89_ACMA][52] = 127,
 	[0][1][RTW89_CN][52] = 127,
@@ -50102,7 +50102,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][48] = 56,
 	[1][0][RTW89_ETSI][48] = 127,
 	[1][0][RTW89_MKK][48] = 127,
-	[1][0][RTW89_IC][48] = 127,
+	[1][0][RTW89_IC][48] = 56,
 	[1][0][RTW89_KCC][48] = 127,
 	[1][0][RTW89_ACMA][48] = 127,
 	[1][0][RTW89_CN][48] = 127,
@@ -50115,7 +50115,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][50] = 58,
 	[1][0][RTW89_ETSI][50] = 127,
 	[1][0][RTW89_MKK][50] = 127,
-	[1][0][RTW89_IC][50] = 127,
+	[1][0][RTW89_IC][50] = 58,
 	[1][0][RTW89_KCC][50] = 127,
 	[1][0][RTW89_ACMA][50] = 127,
 	[1][0][RTW89_CN][50] = 127,
@@ -50128,7 +50128,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][0][RTW89_FCC][52] = 56,
 	[1][0][RTW89_ETSI][52] = 127,
 	[1][0][RTW89_MKK][52] = 127,
-	[1][0][RTW89_IC][52] = 127,
+	[1][0][RTW89_IC][52] = 56,
 	[1][0][RTW89_KCC][52] = 127,
 	[1][0][RTW89_ACMA][52] = 127,
 	[1][0][RTW89_CN][52] = 127,
@@ -50466,7 +50466,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][48] = 34,
 	[1][1][RTW89_ETSI][48] = 127,
 	[1][1][RTW89_MKK][48] = 127,
-	[1][1][RTW89_IC][48] = 127,
+	[1][1][RTW89_IC][48] = 34,
 	[1][1][RTW89_KCC][48] = 127,
 	[1][1][RTW89_ACMA][48] = 127,
 	[1][1][RTW89_CN][48] = 127,
@@ -50479,7 +50479,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][50] = 34,
 	[1][1][RTW89_ETSI][50] = 127,
 	[1][1][RTW89_MKK][50] = 127,
-	[1][1][RTW89_IC][50] = 127,
+	[1][1][RTW89_IC][50] = 34,
 	[1][1][RTW89_KCC][50] = 127,
 	[1][1][RTW89_ACMA][50] = 127,
 	[1][1][RTW89_CN][50] = 127,
@@ -50492,7 +50492,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[1][1][RTW89_FCC][52] = 30,
 	[1][1][RTW89_ETSI][52] = 127,
 	[1][1][RTW89_MKK][52] = 127,
-	[1][1][RTW89_IC][52] = 127,
+	[1][1][RTW89_IC][52] = 30,
 	[1][1][RTW89_KCC][52] = 127,
 	[1][1][RTW89_ACMA][52] = 127,
 	[1][1][RTW89_CN][52] = 127,
@@ -50830,7 +50830,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][48] = 64,
 	[2][0][RTW89_ETSI][48] = 127,
 	[2][0][RTW89_MKK][48] = 127,
-	[2][0][RTW89_IC][48] = 127,
+	[2][0][RTW89_IC][48] = 64,
 	[2][0][RTW89_KCC][48] = 127,
 	[2][0][RTW89_ACMA][48] = 127,
 	[2][0][RTW89_CN][48] = 127,
@@ -50843,7 +50843,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][50] = 64,
 	[2][0][RTW89_ETSI][50] = 127,
 	[2][0][RTW89_MKK][50] = 127,
-	[2][0][RTW89_IC][50] = 127,
+	[2][0][RTW89_IC][50] = 64,
 	[2][0][RTW89_KCC][50] = 127,
 	[2][0][RTW89_ACMA][50] = 127,
 	[2][0][RTW89_CN][50] = 127,
@@ -50856,7 +50856,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][0][RTW89_FCC][52] = 64,
 	[2][0][RTW89_ETSI][52] = 127,
 	[2][0][RTW89_MKK][52] = 127,
-	[2][0][RTW89_IC][52] = 127,
+	[2][0][RTW89_IC][52] = 64,
 	[2][0][RTW89_KCC][52] = 127,
 	[2][0][RTW89_ACMA][52] = 127,
 	[2][0][RTW89_CN][52] = 127,
@@ -51194,7 +51194,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][48] = 40,
 	[2][1][RTW89_ETSI][48] = 127,
 	[2][1][RTW89_MKK][48] = 127,
-	[2][1][RTW89_IC][48] = 127,
+	[2][1][RTW89_IC][48] = 40,
 	[2][1][RTW89_KCC][48] = 127,
 	[2][1][RTW89_ACMA][48] = 127,
 	[2][1][RTW89_CN][48] = 127,
@@ -51207,7 +51207,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][50] = 40,
 	[2][1][RTW89_ETSI][50] = 127,
 	[2][1][RTW89_MKK][50] = 127,
-	[2][1][RTW89_IC][50] = 127,
+	[2][1][RTW89_IC][50] = 40,
 	[2][1][RTW89_KCC][50] = 127,
 	[2][1][RTW89_ACMA][50] = 127,
 	[2][1][RTW89_CN][50] = 127,
@@ -51220,7 +51220,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_FCC][52] = 40,
 	[2][1][RTW89_ETSI][52] = 127,
 	[2][1][RTW89_MKK][52] = 127,
-	[2][1][RTW89_IC][52] = 127,
+	[2][1][RTW89_IC][52] = 40,
 	[2][1][RTW89_KCC][52] = 127,
 	[2][1][RTW89_ACMA][52] = 127,
 	[2][1][RTW89_CN][52] = 127,
-- 
2.25.1


