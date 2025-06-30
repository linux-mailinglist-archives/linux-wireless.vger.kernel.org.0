Return-Path: <linux-wireless+bounces-24677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1644AAEE870
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E9D1BC10B3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1AA23183F;
	Mon, 30 Jun 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUNQsuKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7123F9FB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316149; cv=none; b=lMSsuQ6svtxN80mxZzwfZPmnbzykKkBpKnJ1/JT/T838ojdyJZNzu92zJn22XgLudfOal3/ZtV6qQ5pNlkaYKTOnDmWRe/aZWzLi195fdAowkWZala/k3aNvAZ25JCvb+ICNJ8q3RnTL7U14dFLb2CodQ+7nwdM7eipAeszXc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316149; c=relaxed/simple;
	bh=nFOLIfJsk0sFrCjdeqQPKRx1vyy0k4TidhppYKSp0IE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bsgo76ABxBN6ckZhyZjGziiHEyMk8Abt6nPjJxowEeo1sTMSFXuIfiZJDAE1uKQOVy9INlO0jOjrAn6wCnsvSNxOZkvSFnW1QtwGwjk7Dy8AGhSFiUg+oKUK/TcBmcqpZ1f9CNoI+dP7aRZo5zH8fwpj87xkaMj1MbpTuiEM9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUNQsuKg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso48555525e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316146; x=1751920946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iDKoBaFpWlc5XAPSsT5Pp2kiJDEtjEohsU9I8bBWQjE=;
        b=aUNQsuKg6NHhGmcYVrP/PXinaBdK5L8z0rVkA/RmEebo7S8aLGET6v2AMBCiYIGFrx
         27cZxRePYcZZ3LDeGfiY+bYU6k+xVVf3nJvlEQtEDLPZBRE9AFc/GzPKt4vsqy7bzA2/
         OdYBNYUz/bOkYbwkI0lhGup7uD6V1Gy86UZd29ezR/pS9m8SfzgRLmzYi0ilu+q/dBnz
         0M81k4lGK4TZ0BQKsB4bmV1ZMfC/iH8zjYb8dXP8RLVMl7qWdSFL6e/nVd/Lvm+ife/q
         SriuT45fpJenvJt0uXyqeqciJSbqS3wCJZKqQT08+EPRo7/wnuEhbFEjpWTcYzi5v+E0
         H52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316146; x=1751920946;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDKoBaFpWlc5XAPSsT5Pp2kiJDEtjEohsU9I8bBWQjE=;
        b=IJUPOwbTPTOngAKGPXahX8BPm4sfmSzanYBYdZ22Xz8pi9ZV9Y36jyFNX9LsZVwEwp
         yRnE6tnVdZz3nmBe37DlF/7wcdi8XxqRk47jmaiekaJled1XnSUZoKEPs0wv14TmNj0+
         o5/Yr5IQDY1g49mY5Nu7KoNhJMqMyZLjeeEKNWZ6jHg+F+M8WgCLfrczhEbCFNCRDCRa
         kesqGEE09Aq5MMFe0YNxrjF07ZyFlp/tQWnQ1Acd00K4WXqFbIPB/34KZ1de9n/29cyg
         2zwl8C58DxW6lXqw13hyKnGImahHe9MpSCxpFgMWIKaugM7KC9R+zwd7X4fgPscchwxS
         X0ag==
X-Gm-Message-State: AOJu0Yx/RB9X442qajOo4uoNfSPzVbfaUDpb+gVclhsgrS8lSvQI+QG4
	lqyoyvilFHVt4MpMrYeQrPpGoXWiC+3m9VP6LsAxWDk1bEBs+gyHh8sA89nLSA==
X-Gm-Gg: ASbGncvfrhSoRBeJAMHtW01v8Z4Im9v9w5shISLP76DMNVKRmOCwkFqQEvhvowAQazf
	jvqvARZsI+fiVUn3nAVE8gGwlOB+nRj+7+Gyg/Z2UaJc4VyPJ+FwMHy4iegpUH6rTg1GAfjji8K
	NPGGHUvpTt/2h/j0lr9jVQApQFXnfRXzRvYJCpXiYHzsZhp+C6eBdCJahzTTBaEAOn+0f+jwwZP
	Q+JPcvpmSwG884U/MTXAl+yjxEzt5BjkXDLIlkehlpEk5+E2MfO8bkcQmqnUY+z0cmzc/9r96ug
	xCSpJJpDHxE8GJkQ4sehpy8ODKQTMw/rECoNUlHy+nnL2ckWnCKI3VHDc1iuUPMwLVCmPA==
X-Google-Smtp-Source: AGHT+IEK5u+NQ6bAZ88BK5SDTxEF97T2Cm8otpt2vOmzyO8pzI9wpCcGGGiBLnnq4TW1E2b8mDRpLA==
X-Received: by 2002:a05:600c:3495:b0:450:d614:cb with SMTP id 5b1f17b1804b1-4538ee61ceemr124836915e9.33.1751316146049;
        Mon, 30 Jun 2025 13:42:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a306a01sm153174445e9.0.2025.06.30.13.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:42:25 -0700 (PDT)
Message-ID: <91622304-614e-4e91-bf2f-7688cf44070b@gmail.com>
Date: Mon, 30 Jun 2025 23:42:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 04/14] wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
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

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 31 ++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4432b03e8f7a..4c469379be6e 100644
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
index b7fd4a0fdb84..9f596a06b3d0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -924,6 +924,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
+	const struct rtw89_dle_size wde_size25;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
@@ -933,6 +934,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_dle_size ple_size32;
+	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
@@ -941,6 +944,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt23;
+	const struct rtw89_wde_quota wde_qt25;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -955,6 +959,10 @@ struct rtw89_mac_size_set {
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
index 62147203993f..7fa3d15ee10f 100644
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


