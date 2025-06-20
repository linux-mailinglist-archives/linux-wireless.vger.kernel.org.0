Return-Path: <linux-wireless+bounces-24297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39FAE2294
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6624D7A8D6E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07E27E040;
	Fri, 20 Jun 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCGDwccu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF141FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445808; cv=none; b=D3WOUQ8WHNu6SvxOhwCX5TiIqx/VXJ6A5Cd8fxHNpQ6SoxsAj08NGD4ru+3qxskrv9UMWf7iVllaYXrMXM3mLryK0gvCMyQX6OZqt8/jUCOMTv/erx+XICvNczHjDkUPEruPkzSjNQZPFvHZvdDCLN5kc0Pr/roypTFoYklm8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445808; c=relaxed/simple;
	bh=UVV0OUMPMNDeer6QPkSSsB4oN8dOhPRpht5HNSzapfs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h4+cjTz8JWz3kbhjPq+t2rlD5//tAIJCof4pzpBDaLq9FbqUnBJ3NBg7vqeLeQQHKmW9f2FDuOeqQnfKYeIZLrtTX/6FJ20bGRSkmUsGOD1NAJXK29MW7sILd3AkL7FA22VrET92VjsCuJkIrjxfRMvb1lDnyMxg8Nkng35TsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCGDwccu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450ce671a08so13978575e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445805; x=1751050605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ud/kGF0UB8Kg0e6PduGiSevIhYTr1MFiaE3pFpA2jAE=;
        b=TCGDwccuq8rOVCdrOxIjuDti62V/V17PtBRRhEUTaGRnwRNSLRVxnL6JlXyGBW2Ay4
         Gf9u/j7oIkdPiaTGyJSqSe0B4NyCPmw4zOM6Th2kxIU09+INpX6CCbvLDt89tYZTa3TL
         tQd3420z+eskq1XuM5kVrOTVLv1mnihrCvrC6m2Z1TRZRsUgyAdbpN9XeFWjAZvs8C22
         FoT1HHGAFwbmi7/Sfy/KJUKSaT65GfkhGCvIp+X90816Bfx/cXgAKeixLa+e9zEU8wsl
         +W/byhZBQ74BM3eda5QIH+Y6ygugBpKDvvlamuARpdVbdzaOHyMdW30KI04ORyo+Kyxp
         SCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445805; x=1751050605;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud/kGF0UB8Kg0e6PduGiSevIhYTr1MFiaE3pFpA2jAE=;
        b=dTV3kjMAuLT/v1voG9TjGk+8+b69Ppw2XKruYwIMZKohytPZTr0MPkABhtZrSG71ZH
         FGoN8TRnrmUq+l9JCCCV5C2BeUEsyeIaXyNr316IpJw3sOxRQTzBazTDBo+0VZwaLE7W
         N7jYzPw1/NbX67hJnNefYgAHz7z0bIcYvtRqaVDALwp4lX0SaUeui6H8IgyZ4fi64tEe
         Az4zng7TouyB4ERKZUMQMYgwgdbfq/v66vn/qR5ghAd7BfGbBCCBARBXpA+LPtJVdyij
         bqXhV+CmLCfiiY+4NDX8mZRtVRlBAJwgT4QurPNwwSKnkcZXGs2eQuoeQYMoHyV5OoyL
         t1Ew==
X-Gm-Message-State: AOJu0Yw92fK+6cCGFt+AX/Hp4phX7Ar9NebBZlXoWz6g0FfzRMc1bmkn
	E3EOa0KO0KpgXN5AXTM7W1WeSNxeaV+EO4R2np02BFCFzO5Vpv1nHe+Xit/oSA==
X-Gm-Gg: ASbGncszKyTacJGQajwPLX7zvIobelEhz+2BSXbOEGlYK1QXHDxNidGihylrqserVyX
	GG0YSg8P+dt7cA8chhRLDwH91sW040rCXR9WmVFRlaXxlh6DGdyp6CaNXoPKzo6Nd5xsbiv5jfY
	jd84nvcdlmpidFYE5YVN8K50h37dLpvigji0Zbg+dLyqZoL1hymBMqFYcHH3bs/ntYv8o5oNbLX
	28m/UdRe4WAWfLmSz6KD2qH6JbjJATYlnwmH8ggR9tlNmrPT/n5wXiDN5QybSB6KWqYr8vIfRqh
	RyXGS11HXtj1Ems6EBjf2HUiHzQyFMiosxSiFWHYLMVaEmdNbkQdetUatd1MoNneS1vRGA==
X-Google-Smtp-Source: AGHT+IF1pSu6F6lF2cHVwTWLMwa2nJonnTxC/0/An6fTC1Ae4irvvNogKIwaNd1LKk+LGe2j8nXFqQ==
X-Received: by 2002:a05:600c:34d0:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-453653af999mr47289425e9.9.1750445804836;
        Fri, 20 Jun 2025 11:56:44 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45359c1772csm62623955e9.0.2025.06.20.11.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:56:44 -0700 (PDT)
Message-ID: <7168370a-9c16-4649-877e-ea6120bc43ad@gmail.com>
Date: Fri, 20 Jun 2025 21:56:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 04/14] wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add rtw8851b_dle_mem_usb2 and rtw8851b_dle_mem_usb3 and their various
quotas and sizes in struct rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8851BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add space in comments before */
 - Add more information in the commit message.
 - Adapt to the changes in patch 2.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 31 ++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d3814012a02e..b281668c6c87 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1645,6 +1645,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
+	/* 8852B USB2.0/USB3.0 SCC */
+	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1660,6 +1662,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
 	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
+	/* 8852B USB2.0 SCC */
+	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
+	/* 8852B USB3.0 SCC */
+	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
@@ -1674,6 +1680,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
 	.wde_qt23 = {958, 48, 0, 16,},
+	/* 8852B USB2.0/USB3.0 SCC */
+	.wde_qt25 = {152, 2, 0, 8,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1697,6 +1705,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
 	.ple_qt59 = {147, 0, 32, 20, 1860, 13, 2025, 0, 1879, 14, 24, 0,},
+	/* USB2.0 52B SCC */
+	.ple_qt72 = {130, 0, 16, 48, 4, 13, 322, 0, 32, 14, 8, 0, 0,},
+	/* USB2.0 52B 92K */
+	.ple_qt73 = {130, 0, 32, 48, 37, 13, 355, 0, 65, 14, 24, 0, 0,},
+	/* USB3.0 52B 92K */
+	.ple_qt74 = {286, 0, 16, 48, 4, 13, 178, 0, 32, 14, 8, 0, 0,},
+	.ple_qt75 = {286, 0, 32, 48, 37, 13, 211, 0, 65, 14, 24, 0, 0,},
 	/* 8852A PCIE WOW */
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 	/* 8852B PCIE WOW */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c1cbc53b16a7..50deea693447 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -922,6 +922,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
+	const struct rtw89_dle_size wde_size25;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
@@ -931,6 +932,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_dle_size ple_size32;
+	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
@@ -939,6 +942,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt23;
+	const struct rtw89_wde_quota wde_qt25;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -953,6 +957,10 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt57;
 	const struct rtw89_ple_quota ple_qt58;
 	const struct rtw89_ple_quota ple_qt59;
+	const struct rtw89_ple_quota ple_qt72;
+	const struct rtw89_ple_quota ple_qt73;
+	const struct rtw89_ple_quota ple_qt74;
+	const struct rtw89_ple_quota ple_qt75;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
 	const struct rtw89_ple_quota ple_qt_52b_wow;
 	const struct rtw89_ple_quota ple_qt_52bt_wow;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 7872c58c37ec..55703de9920a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -68,6 +68,32 @@ static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_dle_mem rtw8851b_dle_mem_usb2[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
+			   &rtw89_mac_size.ple_size32, &rtw89_mac_size.wde_qt25,
+			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt72,
+			   &rtw89_mac_size.ple_qt73},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const struct rtw89_dle_mem rtw8851b_dle_mem_usb3[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
+			   &rtw89_mac_size.ple_size33, &rtw89_mac_size.wde_qt25,
+			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt74,
+			   &rtw89_mac_size.ple_qt75},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const struct rtw89_reg3_def rtw8851b_btc_preagc_en_defs[] = {
 	{0x46D0, GENMASK(1, 0), 0x3},
 	{0x4AD4, GENMASK(31, 0), 0xf},
@@ -2466,7 +2492,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie, NULL, NULL},
-	.dle_mem		= {rtw8851b_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8851b_dle_mem_pcie,
+				   rtw8851b_dle_mem_usb2,
+				   rtw8851b_dle_mem_usb3,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
-- 
2.49.0


