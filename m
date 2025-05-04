Return-Path: <linux-wireless+bounces-22408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB5AA8945
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6D17341B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5B224CC;
	Sun,  4 May 2025 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QATNK6oQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A223AC18
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391869; cv=none; b=SZb8yNfLg8iLaNQsoKRZABB0bfq7iCqSkhRSDC0RtM3VxFi1mqB3X8LL8qXEUTR75aTq/Z772zSWHqg9+6xCg0li/dhtOwX22Z0u5A7gSHGE7fNXtlzNucrPd3S7JsGXThS4Os6D6XVFCFfOdwOulUatokSlLKNnkUKwPkWakDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391869; c=relaxed/simple;
	bh=9LxZcpXwJVF+C6DlfFpWRScnzTIfcVTUq2jtlVGWLC0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOBGbxvy6RrlQ9vpthGuGYm0jlwb5pFiWVz7VpzC6oGKldg2mvN1Q+QduxrwsbUnYtYeMJxARCLk14tpOor1E5GSY4e+fSftuWj17YGcI1QCj4I7nbZe90llZdbP2Vg0ri/kKDIONhGwH8gfy3rxVYHmW8VmjO7tL7wdZA3Opoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QATNK6oQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fafcdac19aso651778a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391866; x=1746996666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1mrx/5ySRSqfezc/WvXUvIkjRPqlTJh0SQ32WRJs34=;
        b=QATNK6oQoPXJ82bxlvsN7ki+pNeEpTHwZiLFRC4XCP8cP5geNdp188OU62mLwVjw0Y
         Mg9nDtcysYGnFeaudbOh+r8x4UER1v3trm00/Irwelc78AY8baOWXjpQ09gYK7vI37vY
         BWq0vWXTYl+JkXik0SLYlo/vJHby7eGMPjOIjK7LPCSOi5VgprKZIfOFjWVsyRhxvQSn
         EPW2bttw0Ds0Sgco+Injx1aMowjYHaQmH3uiPvSWCdIA35OHlKCKGQNl95S8bQ58IA6e
         sm99fDVBIULvwYGehQP2jDH3mfThiiEPJX7xPQ3gt1S/WpbihS8QXTLUPm6jrnEFgInM
         SHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391866; x=1746996666;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1mrx/5ySRSqfezc/WvXUvIkjRPqlTJh0SQ32WRJs34=;
        b=OBM9Z+A3IQlQTmeV5XmlOPqXqvwkHHFRS0vPlKI4fb7JaRe2oAxUkUVZ4c1OhcSG4i
         VKNTfM4PtMBS/6jYuMv5sT3Lm4CdvlsJIWbEosbAXRnvCuLmHLEyUtopcWC+QNl/bmCh
         9UCOGSTyBIfongq+ILRpaRmpOrqO1X28Pb6mN6g8zUim3SGDUy5DMRVq565CZLIQ6iQE
         rEl9ngCLTgSmE3mUkmBlVlrQeCD9FP9LVQwTTupnw6Q1njU7N/Kv6KL2EFHxjcuwiWxC
         HykhjVEdKOXiAtuLbwA632NdUwh+m1dpPpE8E3K8LvRtrCTOz3qNCRM5l96r3k+yKdG5
         s6Yw==
X-Gm-Message-State: AOJu0YzVdp0ECpUgohC0TaYkjdMob6kBjZ72XDLhotEj6CtILCGOqOYg
	PyTu8tvXMkNv3XTiFNgVJyKR3pagyVEocH7V7s3/tBEGgfZZXVNGQyxZOA==
X-Gm-Gg: ASbGnctwfdb1XHd0bZ0cClooEPCZO7clV2N0xSM1/ouFOUYyqQWkcFmMmizTnKKBqOO
	TYd5ReDGjNwS9I/If7YS60eO30skaptVEQCRlc2Eq2j/0uU165ndAVe3jh998QvqZ8h/g1QrMyz
	l26jlr9KYxOj71gWzjo5A6SPft0/S3nyJRsk9Y0Rn3X2FD7uvTL2vx4DF6DyhXv6ZCKX3PELOFN
	c+ebPrpHHZTKI4Fc2eF4q1WTrEfoZ0ef5OPs2oAPAS5TTmwawAAWhLhbA9bmqHsAHADi0ZYDSfc
	p/Z+uNF6YrCp2pPrWPE5ogwQyGG/Sa5jaKVnniKMrinCNn75XL/6D5jjJkzj
X-Google-Smtp-Source: AGHT+IEvUXzLrki02CCdufrqOEExnhMgpH1iLuvxOfMVFTIWYJqmnxwa+hOVw8DNLIR/GBOZ6dj1/w==
X-Received: by 2002:a17:906:794f:b0:ac8:1142:a9e5 with SMTP id a640c23a62f3a-ad1a4b05f09mr462482566b.47.1746391865640;
        Sun, 04 May 2025 13:51:05 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18950928esm372826666b.143.2025.05.04.13.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:51:05 -0700 (PDT)
Message-ID: <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
Date: Sun, 4 May 2025 23:51:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add hfc_param_ini_usb to struct rtw89_chip_info. For now initialise it
only for RTL8851B.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  6 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 43 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 8 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 335d2314699b..f17f046e773f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4273,6 +4273,7 @@ struct rtw89_chip_info {
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini_pcie;
+	const struct rtw89_hfc_param_ini *hfc_param_ini_usb;
 	const struct rtw89_dle_mem *dle_mem_pcie;
 	const struct rtw89_dle_mem *dle_mem_usb2;
 	const struct rtw89_dle_mem *dle_mem_usb3;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4a5d1a5926e9..a316864ad137 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -882,12 +882,16 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
 		param_ini = rtwdev->chip->hfc_param_ini_pcie[qta_mode];
-		param->en = 0;
+		break;
+	case RTW89_HCI_TYPE_USB:
+		param_ini = rtwdev->chip->hfc_param_ini_usb[qta_mode];
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	param->en = 0;
+
 	if (param_ini.pub_cfg)
 		param->pub_cfg = *param_ini.pub_cfg;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d42bfdcac849..35417cdde8d5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -51,6 +51,48 @@ static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8851b_hfc_chcfg_usb[] = {
+	{18, 152, grp_0}, /* ACH 0 */
+	{18, 152, grp_0}, /* ACH 1 */
+	{18, 152, grp_0}, /* ACH 2 */
+	{18, 152, grp_0}, /* ACH 3 */
+	{0, 0, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{0, 0, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{18, 152, grp_0}, /* B0MGQ */
+	{18, 152, grp_0}, /* B0HIQ */
+	{0, 0, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8851b_hfc_pubcfg_usb = {
+	152, /* Group 0 */
+	0, /* Group 1 */
+	152, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_prec_cfg rtw8851b_hfc_preccfg_usb = {
+	9, /* CH 0-11 pre-cost */
+	32, /* H2C pre-cost */
+	64, /* WP CH 0-7 pre-cost */
+	24, /* WP CH 8-11 pre-cost */
+	1, /* CH 0-11 full condition */
+	1, /* H2C full condition */
+	1, /* WP CH 0-7 full condition */
+	1, /* WP CH 8-11 full condition */
+};
+
+static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_usb[] = {
+	[RTW89_QTA_SCC] = {rtw8851b_hfc_chcfg_usb, &rtw8851b_hfc_pubcfg_usb,
+			   &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL,
+			   &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
 			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
@@ -2491,6 +2533,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini_pcie	= rtw8851b_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= rtw8851b_hfc_param_ini_usb,
 	.dle_mem_pcie		= rtw8851b_dle_mem_pcie,
 	.dle_mem_usb2		= rtw8851b_dle_mem_usb2,
 	.dle_mem_usb3		= rtw8851b_dle_mem_usb3,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index b4be32ba8d37..9d0cb83d15a0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2184,6 +2184,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852a_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= NULL,
 	.dle_mem_pcie		= rtw8852a_dle_mem_pcie,
 	.dle_mem_usb2		= NULL,
 	.dle_mem_usb3		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index cde7965860e8..9349d1a34bf6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -820,6 +820,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini_pcie	= rtw8852b_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= NULL,
 	.dle_mem_pcie		= rtw8852b_dle_mem_pcie,
 	.dle_mem_usb2		= NULL,
 	.dle_mem_usb3		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 35624f17de6d..e32c6a1a25a8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -754,6 +754,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852bt_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= NULL,
 	.dle_mem_pcie		= rtw8852bt_dle_mem_pcie,
 	.dle_mem_usb2		= NULL,
 	.dle_mem_usb3		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f96bc3036578..edbfca5bee3f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3004,6 +3004,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini_pcie	= rtw8852c_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= NULL,
 	.dle_mem_pcie		= rtw8852c_dle_mem_pcie,
 	.dle_mem_usb2		= NULL,
 	.dle_mem_usb3		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index ee2a664a7cce..59e7e7a4d829 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2816,6 +2816,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini_pcie	= rtw8922a_hfc_param_ini_pcie,
+	.hfc_param_ini_usb	= NULL,
 	.dle_mem_pcie		= rtw8922a_dle_mem_pcie,
 	.dle_mem_usb2		= NULL,
 	.dle_mem_usb3		= NULL,
-- 
2.49.0


