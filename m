Return-Path: <linux-wireless+bounces-24134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47DADAB76
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2EF7A59B4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3226D4F8;
	Mon, 16 Jun 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F94US8yf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84020127B
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064815; cv=none; b=E0ipyR9gAMq3xPgyk+qBOuS1q/b4ozZbWIwkuW1J4YPkVxLXZlyi9/UR4J+qGk8NcXJCR1VMmpXKOkRFFuP/EiIwa/hXmEWmonK3Pbx1gRrvIxHkJmEm1R1GkE6hpb8cmdRGolWCSFW1N8sSP91jCvjVCSOGMhaRSHmd7tHlOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064815; c=relaxed/simple;
	bh=98XqIiHGYYo7lsAEg7RgfKqTbLe6h/Ogyv6zEyGAhqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrxztEAbkhbM11weuIzECczrYMO549hgBe/t04V43wRejfqosChz3RRy22hKAIOuT1y6mLXr4k9RBCc7sLIREvZCLkZQdLPTH4OXqMNwCK0eWgHLKsx6mi6FgUU9vkaLvhotbIJqdKo0kvKCSTvTO3TtrKwk23Q0SQOG6lSvo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F94US8yf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96omlE178550, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064810; bh=/7o3G0f4ZiO1WSj5sqJJYAgBQUpevD2EEPj/+wfh2fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=F94US8yf34Q//SKer86dpGZVboEwWjaTyBzJFa0A8o0AIjNRex2189Rd+Fz1v/7QQ
	 xQW1x9/yZyV9u3fHmODGrd+BO1ayQW/K4BIv0Yif9asWWgIDxsPw9J2R0+CruCPBRw
	 M/DimdCMH+0lAJrs4EYYtY2+2gp9Or/pAAuPspJjF8nOzgRDXwyQOmTwY+nav9pgL3
	 Gu3HQVd4PenfaFhvQHPGP9raQn1SkmZDEHhtuWQiSfGrtywI2Gk0unIvoYb6hPUZ8y
	 VWM8uCfur8PHua0MHGM1V1gImmhmLCgGH217kj8+6hXkwsl0CxVC9UOZnSJ6seW2lm
	 37C55qO5pI/6A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96omlE178550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware version
Date: Mon, 16 Jun 2025 17:02:46 +0800
Message-ID: <20250616090252.51098-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Because when Wi-Fi/Bluetooth want to communicate with each other, their
contact window are their firmware. So the desired version code is more
reasonable to change with firmware version.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 34 +++++++++----------
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 -
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 -
 8 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a4c4b56e7fdd..d34af499e137 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -139,7 +139,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
 	},
 	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 90, 0),
 	 .fcxbtcrpt = 7, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -147,7 +147,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 71, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -155,7 +155,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
+	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 63, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -163,7 +163,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
+	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -171,7 +171,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
@@ -179,7 +179,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -187,7 +187,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -195,7 +195,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -203,7 +203,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
@@ -211,7 +211,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
@@ -219,7 +219,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -227,7 +227,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -235,7 +235,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
@@ -243,7 +243,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1024,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 
 	/* keep it to be the last as default entry */
@@ -253,7 +253,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1024,
-	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	},
 };
 
@@ -8823,8 +8823,8 @@ static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += scnprintf(p, end - p, "BT_FW_coex:%d(%s, desired:%d)\n",
 		       bt->ver_info.fw_coex,
-		       (bt->ver_info.fw_coex >= chip->btcx_desired ?
-			"Match" : "Mismatch"), chip->btcx_desired);
+		       (bt->ver_info.fw_coex >= ver->bt_desired ?
+			"Match" : "Mismatch"), ver->bt_desired);
 
 	if (bt->enable.now && bt->ver_info.fw == 0)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3b046727e04a..cdacf100a59a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3199,6 +3199,7 @@ struct rtw89_btc_ver {
 	u8 max_role_num;
 	u8 fcxosi;
 	u8 fcxmlo;
+	u8 bt_desired;
 };
 
 struct rtw89_btc_btf_fwinfo {
@@ -4422,7 +4423,6 @@ struct rtw89_chip_info {
 
 	u32 para_ver;
 	u32 wlcx_desired;
-	u8 btcx_desired;
 	u8 scbd;
 	u8 mailbox;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 39df1a255095..c55833f259de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2529,7 +2529,6 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.phycap_size		= 128,
 	.para_ver		= 0,
 	.wlcx_desired		= 0x06000000,
-	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index dc4eab2e7919..080636e8d0c3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2247,7 +2247,6 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.phycap_size		= 128,
 	.para_ver		= 0x0,
 	.wlcx_desired		= 0x06000000,
-	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 1f1e10f2b39d..c0bf80450acf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -883,7 +883,6 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.phycap_size		= 128,
 	.para_ver		= 0,
 	.wlcx_desired		= 0x05050000,
-	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 4c34f5037908..95e088734423 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -816,7 +816,6 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.phycap_size		= 128,
 	.para_ver		= 0,
 	.wlcx_desired		= 0x070e0000,
-	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b39add1b798c..8f3d0c91a3f8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3070,7 +3070,6 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.phycap_size		= 0x60,
 	.para_ver		= 0x1,
 	.wlcx_desired		= 0x06000000,
-	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index ca32ccb00107..603212ed4558 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2923,7 +2923,6 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.phycap_size		= 0x38,
 	.para_ver		= 0xf,
 	.wlcx_desired		= 0x07110000,
-	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 
-- 
2.25.1


