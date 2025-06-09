Return-Path: <linux-wireless+bounces-23896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD5AD26BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8F1886D6F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700019258E;
	Mon,  9 Jun 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjQDATn4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614E145B25
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497260; cv=none; b=RQSM6flypaZPNLj+tvUpVScj5zS3VXbuUZ7Cq5yXnhyXzsYb7oGR/hQlgj5JSWtX8YzeHoA6+ZsKGU8M2L9qMmVozFqo7oBqmQdfa6cXcx+aSUh8IcjEBCAcYWFsxFWswL+AZh3NhccTBwi3aO57j0v/urobN5fmMZ7oqova7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497260; c=relaxed/simple;
	bh=7p5CbvrkN+3zfriFescKoWzZqb6H09+xAkqYXYw5XA4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=faeJl69r7pDuU3nAM0I0Uq5gsiaNovizrOMcuc9R3myX3cMJAcmcpgCGKr1X5Tp1ooifK95i+m96yLwl2emmJAbWdDkKgEdCD7xqnRXJpYKiM44mxn5G4Uijt8tZPdo6xberFenahTPi+UEkq+2olD6ZAAPwVG+Qj8eEMVEn/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjQDATn4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso5506863a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497257; x=1750102057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4pB9NAvcYQukC55NC2RiOm0Y3hDCYj32ioujV7S5kk=;
        b=bjQDATn42dhtbr5b/xkM3ig0JNKwqttBwJzQrAOIn95SwOU3UQXdRqjLqeOt5vrfNg
         SfwKZX12HZG2TuK3BmTDaF4sXeCC0zQM0KONHJ4Z3yM/wScdvtl5yobG5658CXK48te/
         j4D1TKyL3JrE9kh+Rm1dRb+eEwPmiFRe12HzhRfaTY2zycHTtLI4gJE/aB0uW6GYwAkM
         kbGbrN34Pg1RoGl5cZu81zIdn4SqBCtVNPh9ave9Jc2+e89+7vj0roZIvG83wzb9Pyug
         IcyDZg5gCQfIXAzOPp1+6ts5PtNvAZiJ+Z8BUMv6Rr/Q47uZzLeQQ6gqDS3R8ynFhQPs
         KMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497257; x=1750102057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4pB9NAvcYQukC55NC2RiOm0Y3hDCYj32ioujV7S5kk=;
        b=ikfb1f6mxxDn7JBh0GGaQh5/mtI7bXbF2CCScLc6TqStOrK7RzDrlx2mSL7ektvef2
         da1tP+OLd09iE+eZ2FRwp9Ph8HLkbhSO6j5hgC9abUw6zS9UOu9cvItH0Xb00Qy8tAz0
         9YPnWZBRT856p2dYsSiDQIWeL0tpqGV8c2OgFG5WKjrH4tevG9FjgZq3gWQu6x0DEbNh
         wlVuoEl40x+T0wpp64g87Bolwv8W4TNWKQbM0t/9uKMV0ZN5Nu8WjU9NpgRq5JADhBod
         ZncsVnDiyhlzL4fe3shEDiTFaDSsNqUOdolyZ5+kVtYfDTXMCy1LYhWahOE8btLxoX9K
         gVfw==
X-Gm-Message-State: AOJu0YyPSapQ/EbGN/yNcCU/BROJ6mXOf3p+qcTxnG8tcH4hYm50wtua
	4jhDYJT6/bcMHVt9PbQ01TiC9V7haiD6jxu2awzIoD9J+Pw3vD0oyMJS1w4F7A==
X-Gm-Gg: ASbGncuEi4+R8VGGFJkBvWkZmMvpvFSk8W+yRMWLvtPVFLgDo2A4tTHtu1M7Fy8+wA9
	wBHYs0ZeekpGwxy6tJh8gyBJPCaKCQDgzY85yWkBm8WER8C02dX6a1nV3wf6gtWJtV/LLmCHreB
	AevGEsbbh1T0/jOxFyyqJ+JDde6foxnBOPiIZKqQTBbZjRVRFM5fZeGAVEPjHrg9PHCtotQBNya
	atEWXsbMGhpCJDO+04cnBggeMZd81NecDwqrqMoZWA5hNRu0HkJmXY4m/QzNx8E+MPsBUKwgNJX
	1OyBRp2TOveCO5A0qQm+psurCViSr+PwPJAgnU/7ffc9v0+BYf3c81a6n1w=
X-Google-Smtp-Source: AGHT+IFpKm3Up7Pfl9xHzCq3W250N5gjm+v2IdObc8/Sxj7b1gC5xfU2bvLZHwx7a01bW452BJmpxQ==
X-Received: by 2002:a05:6402:d0b:b0:607:2469:68bb with SMTP id 4fb4d7f45d1cf-6077498ed5cmr12635126a12.33.1749497256712;
        Mon, 09 Jun 2025 12:27:36 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783dccbdsm4952357a12.54.2025.06.09.12.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:27:36 -0700 (PDT)
Message-ID: <e088be63-97a5-4b07-bed9-b8eac50f2ee9@gmail.com>
Date: Mon, 9 Jun 2025 22:27:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 05/14] wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" seems to mean "hci fc" which may be "Host Control Interface Flow
Control". These are some parameters needed for RTL8851BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Adapt to the changes in patch 3.
 - Add more information in the commit message.
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 46 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9ca88a293f99..7f3c816d4704 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -881,6 +881,7 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
+	case RTW89_HCI_TYPE_USB:
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index cd5039e1294c..048e64fa1d51 100644
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
@@ -2490,7 +2532,9 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie,
+				   rtw8851b_hfc_param_ini_usb,
+				   NULL},
 	.dle_mem		= {rtw8851b_dle_mem_pcie,
 				   rtw8851b_dle_mem_usb2,
 				   rtw8851b_dle_mem_usb3,
-- 
2.49.0


