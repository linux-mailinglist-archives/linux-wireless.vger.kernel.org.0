Return-Path: <linux-wireless+bounces-28682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA21C40C2A
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE473BC784
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6092C08BA;
	Fri,  7 Nov 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkduXQHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A528C5DE
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531632; cv=none; b=XKPhOLbRnGXmGG53YRJpBpMwigOZe/m9jwtaDZ6XzPxEGl4mv1bKnKk1r5v2VmJpKlIxNWFydQ8HFP9r8FXVjy//3hxNIavW5DzLZayNUkSz4IBa6mBmJso+Kbd1StMYG1UYisNI78idwzXrCdNqIlX3XbB5wCxrApCQO6tLEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531632; c=relaxed/simple;
	bh=Vvl0GtmmmYD/TKcbfI+X8SDMvKfzkQjdrYvWqUFO+LE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EB+FkSQy6I8WHLn8HLPCPFwKNJCOzdL4dYkGRidVjMOSvqLixO4XOoE1XeBIvZ5+ogoL5o5JGWEXVV8Wr06SBGFufuNHpfCsHBzGVBRHONG4hK2/TJMagDOsqVBSeF3Vek9qmOs0NirXNlQfvoLKhMxi4lOsmBwqAzeMZKPYbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkduXQHu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae77516so10629935e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531628; x=1763136428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xz2qrDcSIoE48y6POj9CftuiEzF1Cx58P7HiEuwSOwk=;
        b=NkduXQHumIk+Pb3JDLtiSPH/FispmwdbO5ks/jwiIXHZPRYj3S1pIKJYtfese0rZnm
         XIOX8K6IMLP62xXFbjihxKMxafswZSzOGEQJRcemU/Juhms1Hy0Hhxwnv8iWobIU8qfd
         IAYfFuY38qglumxA3aRzK3+0tntamBaexT1rVV9UihZl2/+dTG8Us2hx/ytigVo1l5z2
         JuFbM3G744nCJgvczrQ8SQoliMMZxXe9D0e6wlQbSMwG9VkT/5DL5snCZZpdoTIu1y0y
         R32n7xeFnPhkiMMkCT89WtTlvIbv82RyTyKrB8V/uVkcZBHjaOSrCBA4lXrMT7rZ1cV/
         JsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531628; x=1763136428;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz2qrDcSIoE48y6POj9CftuiEzF1Cx58P7HiEuwSOwk=;
        b=AQ//Ero3YjkDDKhHSS5VuGNlsZL3T3/ZTCLwXVXvAbdK6Nn3ObD50iJzin1Ipjwva/
         Ty7I4JHfk0kLN2mB+mGmf39j0EUHP+3XA/2paowtGew1nh6B9iX4Q2UBTyraBRka0tJr
         R4AKyJpP+923cKbnhXQ0fYWS+ijcKaYQnOmUGrTIhcddCRXZVC1RGlQHMLMLoxDcpPLl
         LB0Cxtj9Ayxhw0AyQn/msxOz5dZVrpDiz3L2aYZNlwRMyFT19X2WXGVGbs14DxyvFUqW
         fXs+99P3VCoyWDsK7F00i88+hJikWG2y07PtJ1Z0024F1jyrEVfHPDbm342IJTiv76tI
         gijg==
X-Gm-Message-State: AOJu0YwR7M4SRBjyy04fZS18/0RHTwXh2BMDUVspHLlnKhJTvGjxWgam
	TCNGS9cDzQxHOhIElceCM+aR9WfNGK7oEvk0h5qFN3kYmoG93tE4wi6tTjlRMg==
X-Gm-Gg: ASbGnctazI7o7R7RcMXLyw/VnfAPJ4LxjJ9gnA3yq7LhdVWP6kSptrUhCI1oaXr8Vxr
	2OZcG9Z+w8RZw0R5DOlIVzojNXY0YLkKQoeqnUCr/wsE7oH7EYA2Ml95e352+1HmvQwpc+JP69J
	bbx2dknniwH5hG62Kg2FcZftKKZprymd64Z/zyjwlF1GvAh+RF4UmXz+tFigAnK44ZWVSaLwrUN
	6vtCJt4EHBIogEMo4kdsfp71k4dhDiCLBCWnaaw0huIP5iIx1ITwEroibToz2GLhkBFKF8M7NK4
	38KWVjFGppdPsqb85zJ93DWsJcjDwPOXQQUu7+1ka9fiX2IAgfOsiFBum3zvzQJATgMbW47Xn/N
	wSHRsA+KOadNG7nqL6kNV7E1LWbD6+b0sqn4IiJ/iXMnZP6/ROkK/2g9k5Q+7kjE8C17rxog7iW
	jb0x0tzEI9EgSPZC83Lqc=
X-Google-Smtp-Source: AGHT+IHGHvxdOYiooXD314BIh1nKfW3pShgNrlPkYrh4szDkK7s+jQV8tuqmMigiq/cm50D/HMBKtg==
X-Received: by 2002:a05:600c:3104:b0:477:632a:fd85 with SMTP id 5b1f17b1804b1-4776bc906b0mr26192055e9.14.1762531628140;
        Fri, 07 Nov 2025 08:07:08 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcdd833sm53847625e9.9.2025.11.07.08.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:07:07 -0800 (PST)
Message-ID: <d0a09039-97a8-4501-b023-510c126d8c61@gmail.com>
Date: Fri, 7 Nov 2025 18:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/6] wifi: rtw89: Add rtw8852a_dle_mem_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add rtw8852a_dle_mem_usb and its various quotas and sizes in struct
rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8852AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  5 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 18 +++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e22b5d8c8171..dab0a76556c9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1669,6 +1669,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE 64 */
 	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
 	.wde_size0_v1 = {RTW89_WDE_PG_64, 3328, 0, 0,},
+	/* 8852A USB */
+	.wde_size1 = {RTW89_WDE_PG_64, 768, 0,},
 	/* DLFW */
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
 	.wde_size4_v1 = {RTW89_WDE_PG_64, 0, 3328, 0,},
@@ -1692,6 +1694,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
+	/* 8852A USB */
+	.ple_size1 = {RTW89_PLE_PG_128, 3184, 16,},
 	.ple_size3_v1 = {RTW89_PLE_PG_128, 2928, 0, 212992,},
 	/* DLFW */
 	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
@@ -1715,6 +1719,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
+	/* 8852A USB */
+	.wde_qt1 = {512, 196, 0, 60,},
 	/* DLFW */
 	.wde_qt4 = {0, 0, 0, 0,},
 	/* PCIE 64 */
@@ -1743,6 +1749,9 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
 	/* PCIE 64 */
 	.ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,},
+	/* 8852A USB SCC */
+	.ple_qt25 = {1536, 0, 16, 48, 13, 13, 360, 0, 32, 40, 8, 0,},
+	.ple_qt26 = {2654, 0, 1134, 48, 64, 13, 1478, 0, 64, 128, 120, 0,},
 	/* USB 52C USB3.0 */
 	.ple_qt42 = {1068, 0, 16, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
 	/* USB 52C USB3.0 */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index ce3474a7ba03..868413335f6c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -924,6 +924,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c0;
 	const struct rtw89_hfc_prec_cfg hfc_prec_cfg_c2;
 	const struct rtw89_dle_size wde_size0;
+	const struct rtw89_dle_size wde_size1;
 	const struct rtw89_dle_size wde_size0_v1;
 	const struct rtw89_dle_size wde_size4;
 	const struct rtw89_dle_size wde_size4_v1;
@@ -937,6 +938,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size25;
 	const struct rtw89_dle_size wde_size31;
 	const struct rtw89_dle_size ple_size0;
+	const struct rtw89_dle_size ple_size1;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
 	const struct rtw89_dle_size ple_size4;
@@ -950,6 +952,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_dle_size ple_size34;
 	const struct rtw89_wde_quota wde_qt0;
+	const struct rtw89_wde_quota wde_qt1;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
@@ -967,6 +970,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt9;
 	const struct rtw89_ple_quota ple_qt13;
 	const struct rtw89_ple_quota ple_qt18;
+	const struct rtw89_ple_quota ple_qt25;
+	const struct rtw89_ple_quota ple_qt26;
 	const struct rtw89_ple_quota ple_qt42;
 	const struct rtw89_ple_quota ple_qt43;
 	const struct rtw89_ple_quota ple_qt44;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index fa347dbebf9a..7855fd55b43e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -65,6 +65,19 @@ static const struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_dle_mem rtw8852a_dle_mem_usb[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size1,
+			   &rtw89_mac_size.ple_size1, &rtw89_mac_size.wde_qt1,
+			   &rtw89_mac_size.wde_qt1, &rtw89_mac_size.ple_qt25,
+			   &rtw89_mac_size.ple_qt26},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4,
+			    &rtw89_mac_size.ple_size4, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const struct rtw89_reg2_def  rtw8852a_pmac_ht20_mcs7_tbl[] = {
 	{0x44AC, 0x00000000},
 	{0x44B0, 0x00000000},
@@ -2225,7 +2238,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie, NULL, NULL},
-	.dle_mem		= {rtw8852a_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8852a_dle_mem_pcie,
+				   rtw8852a_dle_mem_usb,
+				   rtw8852a_dle_mem_usb,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
-- 
2.51.1


