Return-Path: <linux-wireless+bounces-23975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF1AD49CA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7403A6738
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBF15574E;
	Wed, 11 Jun 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HTjrRZLh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B38E211497
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614162; cv=none; b=tUirflmwjU0pyUXba/aPtR/m3yfo5xGEdyFoc+b8rJDFlUHqT252Ce3cUwK43jVXSOFmcxdsAppQGyo59APOey9WPOc5Tvug2mQvGeCz4Xj2YCuEcHnLHr/iH7gMaCX/MEhj+X4V/VpJoeBKqr2Qc2fgG/TdZJg7GI9KBDOr0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614162; c=relaxed/simple;
	bh=+PltVg7wRv+ZO9N7QPiCVp6TXsVmzk3jLBIH2e72Zwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxNl0LoKnAmhLgI8dI05r6xpuh40imb8TXLMUrcnVcZKl+uyuKB+UHktI9CiisGRmAJiSsM69VQHrEo0yHMur/2OwvUiiAW5nwj7ysnCBMg9AXWDGZv394ItzPJnfMhXgDZHTEx4ma6Op/jfz3OIG3iR2F3AqdrikQbt0O31NeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HTjrRZLh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3tv9734132056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614157; bh=HJ162AhfdAxfxXacyGyG8OBzAMdmMdp28DkZ685Ht+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HTjrRZLhDH1Wp6L6lf3mqUUXcCKoTxBxJt9vqpDk1zMGMDxQ0/f1agLjh/ax86vQZ
	 KY8PQJOhjHzfdOMhPNcUkX2RmjR+r10i3OrR/zxnpKXbc5IKGxA2Ew1fczbn7LJIB/
	 fuO7nSxVjtgH9IW2P8bo0IpZiykSEI48UXI1j7y1Ens9TytUbI45HTp+CIVsalCcuQ
	 ErYLcXW5d3uefQWHlYYqXLBFMULUrx7DNw6aKRkjGyXCf3HI4sJLXoy1Sjt1JhY7I7
	 QBeyDQ1D5NmQATzrsSAjXVPytGtc9EoROas8faGHfjcPnY4cr22A22bslQV7t/2c1R
	 cduUTptyq7TnQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3tv9734132056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:55:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:55:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:55:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 02/10] wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
Date: Wed, 11 Jun 2025 11:55:15 +0800
Message-ID: <20250611035523.36432-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035523.36432-1-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com>
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

There were some driver API offloaded to firmware, and to recognize the
feature add a version tag for it.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 34 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 5ccf0cbaed2f..2b23febc6f26 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -138,7 +138,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 90, 0),
 	 .fcxbtcrpt = 7, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -146,7 +146,15 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
+	},
+	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 63, 0),
+	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -154,7 +162,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_type = 1, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
@@ -162,7 +170,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -170,7 +178,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -178,7 +186,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -186,7 +194,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
@@ -194,7 +202,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
@@ -202,7 +210,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
-	 .max_role_num = 6,
+	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -210,7 +218,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -218,7 +226,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1280,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
@@ -226,7 +234,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1024,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 
 	/* keep it to be the last as default entry */
@@ -236,7 +244,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1024,
-	 .max_role_num = 5,
+	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c93d3ea2b0a4..daf9a30409ab 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3167,6 +3167,8 @@ struct rtw89_btc_ver {
 	u8 drvinfo_type;
 	u16 info_buf;
 	u8 max_role_num;
+	u8 fcxosi;
+	u8 fcxmlo;
 };
 
 #define RTW89_BTC_POLICY_MAXLEN 512
-- 
2.25.1


