Return-Path: <linux-wireless+bounces-22407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69360AA8944
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CB1173444
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F33224CC;
	Sun,  4 May 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izeN9DK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF89C2FD
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391835; cv=none; b=EwJENOvGZlZH992mT+suUKu84F9JBYOb0LLlJZsRM9Dkqd1JuWVISUQKc0LpoiDiLwXapeK40f8dMsFBCg7H74CM4BM49+cPWttfAt0euHjP/xk/rKtb4nHvxQQqkKnkF85s+tUAM2Ofcy1JwLcJ58eRu1DsB0EeKZ6VQ10cuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391835; c=relaxed/simple;
	bh=KhG84KTPCA3XHnMufBs9lmYZ11VeUNrT6h0mz86Rw3U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gRZZxz7cuUgjDyodVYfXVeebz2SS2NcopclTR6RAbrq1bX+6/1tuol/9S5ELDOy1FeFMnIUigWU5CKdxI/HQq99CoRHED8ULdK8Tf2iPfvYHnShzDnEABtukeZxNqMCTU+biAwP2+F9JhLReeQGBVDglZx7hvSlN4LjOEEy1tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izeN9DK2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac339f53df9so798654666b.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391832; x=1746996632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNBXOAe3BA+eHtaauVJXrOm1EzleoQqxba2hFXWz7lY=;
        b=izeN9DK2NwJXOWGUndnvI0pIAptZ0GJf0ZgT+Ei97Xt+893nJnOjGSmhpUV4nzxQMi
         BDVlISitqJ77KmEqQ8TeKSn3ZxRWrAXaKI0ljsWBaScJ3Xaf1iLVu/ivNsU9+zTFLoV2
         gpbPBJgq9bcPy3LWFvlcSYu9dP41qFC9zu/peEJFX+x8weTUO6lPvD870jgqEtSkVu/6
         tZ1y/H1KTeMtaG4LIZJya+gWO56A1U14dUTgDZbvVIbUzTw2ozsKGaG2m/iZ5Qn+X27a
         nDAE+YK6ZGA9obZir+IN057u5Pfe/DHvoNgsdlIpsxNFpJe/BXWX0mdhzbI0vA+JTe0N
         4D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391832; x=1746996632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNBXOAe3BA+eHtaauVJXrOm1EzleoQqxba2hFXWz7lY=;
        b=qBAPv9DTQwJ8wyvx4eCQomc6QdTR3iYEziPPEvqw3T9HhSEY1aBjXswnZoJ723Sfkr
         D+FDT+/tHuztyapi+J5Ton9fcR4KRqF/lm7Ol2qEgD9AOOcPd6+d9qkBYMRNIj5pFZ2H
         ae7lRbCzfuAMRT1C6njPBtmXFfmQraywJIt/vuQtaH73EGaQbjBrOy5KIe4fTGY+sVDp
         JskKKQ2ahU7hYgmgKd1uox7yiCbCQnT+a9EH79/Jqz/aX/HFC6xNjN7TrhrrHzxcRfUK
         xzDTlkFxKXnC8ypBIl3vhFgYM/7+d8MepmeXGdJh9cdwYg8u5tA5otGuDgws3ZVnrgzR
         lOrw==
X-Gm-Message-State: AOJu0YwX+ssTdpfo3+kySOagD/HwNlTXe0ham8MA++tuVrfrBhgXsw/X
	ZaZf3DHPO2nII9W0XQvNEEX9078hMEmNdWsdlkBh6wZAhFyBhIQaJbYdgg==
X-Gm-Gg: ASbGnctFLc4ubh3VtIabDFgraePKfbX3/hrPxABG63RwqQO93PJBq7JIT+QI3DwS0DE
	NUWz7tCaHfp6OIOS9dFyNeoAGQBg9P0YwIXKQ27SMdXtRxfhR490FPZDyRP93XVUXusgQ9CBzQd
	wzBJ8dpbgsf+/9B+XhMUfCAwsd0fGItOOlq2vWRUk048jt+tRdaSnykRQgF7nMyb+OzmQs7WMJj
	RPwQzoy8SeAZzG/zkCpQ+U/HoAex/IzAA1nUwCNeDuiBQQG1vs23leMj5jrpkz5PZMa/MfO7D2p
	Z9JeKhKj1RWmZiqB5Vn3JaVY9/PrjlpCBy1Z57CG47GoAk+s0A==
X-Google-Smtp-Source: AGHT+IET7AFZFAx6Pkv8Ha8JNa/rEnGfauyLstcHGzKNDxOg5V75KSkrwSCS56fxOSQoFwUclGjoDQ==
X-Received: by 2002:a17:907:3da5:b0:acf:15d:2385 with SMTP id a640c23a62f3a-ad1a490f305mr408176266b.16.1746391831615;
        Sun, 04 May 2025 13:50:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189146fb4sm376923266b.10.2025.05.04.13.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:50:31 -0700 (PDT)
Message-ID: <5ab76c63-f605-4d42-b116-f141610cdae6@gmail.com>
Date: Sun, 4 May 2025 23:50:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 04/13] wifi: rtw89: Add dle_mem_usb2 and
 dle_mem_usb3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add new members dle_mem_usb2 and dle_mem_usb3 to struct rtw89_chip_info.
For now initialise them only for RTL8851B.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 28 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 ++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 ++
 9 files changed, 63 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 321de0f76026..335d2314699b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4274,6 +4274,8 @@ struct rtw89_chip_info {
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini_pcie;
 	const struct rtw89_dle_mem *dle_mem_pcie;
+	const struct rtw89_dle_mem *dle_mem_usb2;
+	const struct rtw89_dle_mem *dle_mem_usb3;
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a52de0af605e..4a5d1a5926e9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1646,6 +1646,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
+	/* 8852B USB2.0/USB3.0 SCC */
+	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1661,6 +1663,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
 	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
+	/* 8852B USB2.0 SCC*/
+	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
+	/* 8852B USB3.0 SCC*/
+	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
@@ -1675,6 +1681,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
 	.wde_qt23 = {958, 48, 0, 16,},
+	/* 8852B USB2.0/USB3.0 SCC*/
+	.wde_qt25 = {152, 2, 0, 8,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1698,6 +1706,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
 	.ple_qt59 = {147, 0, 32, 20, 1860, 13, 2025, 0, 1879, 14, 24, 0,},
+	/* USB2.0 52B SCC */
+	.ple_qt72 = {130, 0, 16, 48, 4, 13, 322, 0, 32, 14, 8, 0, 0,},
+	/* USB2.0 52B 92K*/
+	.ple_qt73 = {130, 0, 32, 48, 37, 13, 355, 0, 65, 14, 24, 0, 0,},
+	/* USB3.0 52B 92K*/
+	.ple_qt74 = {286, 0, 16, 48, 4, 13, 178, 0, 32, 14, 8, 0, 0,},
+	.ple_qt75 = {286, 0, 32, 48, 37, 13, 211, 0, 65, 14, 24, 0, 0,},
 	/* 8852A PCIE WOW */
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 	/* 8852B PCIE WOW */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 47d655fbf2ca..afef6228da30 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -907,6 +907,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
+	const struct rtw89_dle_size wde_size25;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
@@ -916,6 +917,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_dle_size ple_size32;
+	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
@@ -924,6 +927,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt23;
+	const struct rtw89_wde_quota wde_qt25;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -938,6 +942,10 @@ struct rtw89_mac_size_set {
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
index 8d5ee870617c..d42bfdcac849 100644
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
@@ -2466,6 +2492,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini_pcie	= rtw8851b_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8851b_dle_mem_pcie,
+	.dle_mem_usb2		= rtw8851b_dle_mem_usb2,
+	.dle_mem_usb3		= rtw8851b_dle_mem_usb3,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index efa944a66976..b4be32ba8d37 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2185,6 +2185,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852a_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852a_dle_mem_pcie,
+	.dle_mem_usb2		= NULL,
+	.dle_mem_usb3		= NULL,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b157fb831479..cde7965860e8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -821,6 +821,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini_pcie	= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852b_dle_mem_pcie,
+	.dle_mem_usb2		= NULL,
+	.dle_mem_usb3		= NULL,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 78abe49a6034..35624f17de6d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -755,6 +755,8 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852bt_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852bt_dle_mem_pcie,
+	.dle_mem_usb2		= NULL,
+	.dle_mem_usb3		= NULL,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cdabfe6acd72..f96bc3036578 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3005,6 +3005,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852c_dle_mem_pcie,
+	.dle_mem_usb2		= NULL,
+	.dle_mem_usb3		= NULL,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0fce7219246d..ee2a664a7cce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2817,6 +2817,8 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini_pcie	= rtw8922a_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8922a_dle_mem_pcie,
+	.dle_mem_usb2		= NULL,
+	.dle_mem_usb3		= NULL,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.49.0


