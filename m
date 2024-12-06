Return-Path: <linux-wireless+bounces-15954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC079E6710
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BED618856B3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5881990C2;
	Fri,  6 Dec 2024 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H59xnB0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B331B87CF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464682; cv=none; b=SMj1eT3x2g+IAdHQUgOr7fHZe6dUaYf/gWFBHXBuSfdCuxqzOy26G0r6nGS6U8w69YYZ7z3GB92h394vGcFFnuj1HGrej4zPLlyrGYn6PPgQx0W5jgvRatUbQsLWTII94pSrQpOydprEJ2y092JX34nRAubn5zOTpc+XQfLPWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464682; c=relaxed/simple;
	bh=tQ6XjPVo7NNOiOx6NujpxTYtV1sPk5vdCuERHswv3oU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBr5n0FWBwazsES/WIAe+ZANwse1QoqWZ/E+4kG1+lB7wLzFi2EtN85nUDMM/bYwlINO5c0Vi+RyKIUipmr8XkqASbNUKn2Pv+hTtOMpVweImGJkmdRhiAMXQknpbmEIrU8ZVqKbmQPagHeS8+NtBWbSR2GCvRHxj1usmiLH2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H59xnB0F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65vvx974128215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464678; bh=tQ6XjPVo7NNOiOx6NujpxTYtV1sPk5vdCuERHswv3oU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=H59xnB0F99XjxHcwvXO0fvx7S7BS6K+f1NUdItEdOzbj4cxNVwJJPcd4THwxCUY6n
	 7kwwWpLAKSt7YCfPa6S1c1xu9pwwQ77kcthZmiVN3g1mVq7GdgQx2S62gWxudlWv40
	 kfYlHTicS1q4/txhqS14t3YqPTktzShUT0JZb+EwwbSeWVmzl6WA1zyYo4gAYHiQsv
	 92miAOWcQRV0b6jX0iIr536pifdk+D/Ve/mZGPkveGLLHMPuQkhozA0AzhFV8eHA9B
	 ww06KFw6QZr7aplin3u+Me+BuIgnNirJdQI8EYo+QQjkymKws9K8v1ld1iF1v4ugcu
	 GjDGEqejB2Ecg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65vvx974128215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 6/7] wifi: rtw89: regd: update regulatory map to R68-R51
Date: Fri, 6 Dec 2024 13:57:15 +0800
Message-ID: <20241206055716.18598-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek Channel Plan R68 and Realtek Regulatory R51.
Configure 6 GHz field of Realtek regd for the following countries.
	BO, DO, EG, LS, MZ, NG, OM, ZW, PK, PH, TH, KM, CG, CD,
	GE, GI, GU, LR, MH, FM, MP, PW, MF, SX, SZ, TZ, VI
Besides, add entries for the following countries.
	CU, SY, SD

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 57 ++++++++++++-----------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index cad5189708e7..80b2f74589eb 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -17,7 +17,7 @@ static const struct rtw89_regd rtw89_ww_regd =
 
 static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_FCC),
-	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("CL", RTW89_CHILE, RTW89_CHILE, RTW89_CHILE),
 	COUNTRY_REGD("CO", RTW89_FCC, RTW89_FCC, RTW89_FCC),
@@ -35,7 +35,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("UY", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("VE", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("PR", RTW89_FCC, RTW89_FCC, RTW89_NA),
-	COUNTRY_REGD("DO", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("DO", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("AT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("BE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("CY", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
@@ -72,7 +72,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("BA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("BG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("HR", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("EG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("EG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("GH", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("IQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("IL", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
@@ -82,13 +82,13 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("KW", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("KG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LB", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LS", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("NA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("NG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("OM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("NG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("OM", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("QA", RTW89_QATAR, RTW89_QATAR, RTW89_QATAR),
 	COUNTRY_REGD("RO", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("RU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -101,7 +101,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("UA", RTW89_UKRAINE, RTW89_UKRAINE, RTW89_UKRAINE),
 	COUNTRY_REGD("AE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("YE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("ZW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ZW", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("BD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("KH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("CN", RTW89_CN, RTW89_CN, RTW89_CN),
@@ -110,12 +110,12 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("KR", RTW89_KCC, RTW89_KCC, RTW89_KCC),
 	COUNTRY_REGD("MY", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("PH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("PH", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_ETSI),
-	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_THAILAND),
+	COUNTRY_REGD("TH", RTW89_THAILAND, RTW89_THAILAND, RTW89_THAILAND),
 	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
 	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
@@ -158,9 +158,9 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("TD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("CX", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
 	COUNTRY_REGD("CC", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
-	COUNTRY_REGD("KM", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("CG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("CD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("KM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("CD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("CK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("CI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("DJ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
@@ -176,12 +176,12 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("TF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GM", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
+	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("GW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -194,19 +194,19 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("KI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("XK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LR", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LY", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MV", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("ML", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("MH", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MH", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("MQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MU", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("MD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -216,15 +216,15 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("NE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("NU", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
 	COUNTRY_REGD("NF", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
-	COUNTRY_REGD("MP", RTW89_FCC, RTW89_FCC, RTW89_NA),
-	COUNTRY_REGD("PW", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MP", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("PW", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("RE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("RW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("SH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("KN", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("LC", RTW89_FCC, RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MF", RTW89_FCC, RTW89_FCC, RTW89_NA),
-	COUNTRY_REGD("SX", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("MF", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("SX", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("PM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("VC", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("WS", RTW89_FCC, RTW89_FCC, RTW89_NA),
@@ -237,9 +237,9 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("GS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("SR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("SJ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("SZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("TJ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("TZ", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("TG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("TK", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
 	COUNTRY_REGD("TO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -247,13 +247,16 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("TC", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("TV", RTW89_ETSI, RTW89_NA, RTW89_NA),
 	COUNTRY_REGD("UG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("VI", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("VI", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("UZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("VU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("WF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("EH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("ZM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("CU", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("IR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SY", RTW89_ETSI, RTW89_NA, RTW89_NA),
+	COUNTRY_REGD("SD", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("PS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 };
 
-- 
2.25.1


