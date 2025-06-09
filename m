Return-Path: <linux-wireless+bounces-23895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A6AD26B9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F051162470
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014519258E;
	Mon,  9 Jun 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg/N2wdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368F20C480
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497190; cv=none; b=e2Vk3dw8n53c4CPBJZSYz2NzjwChaeidazcYN3GkSoSqmejm3sOeCltW5VTj5PuyfbF4OfhwssbPJxZHxvSRytp1IeR8nR6g8G5UDq0oclf4LvHb/zN3Q/vcvTZRHfYi1Ww64yZSnPx6D/d+Re62n91gKWXH2cXsEJ+ZOzp4jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497190; c=relaxed/simple;
	bh=mfnHIozESxHIQiE3eq8y2aIFH/uLN4eDSrs0OwxTbCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a7OVMvgc14MOl3XlIuWyy/ah3IhT6pXLxvqW3ZrmWjTkodb8Po90ijr+YVSOwyR4UyKhqOxl4uDz+CQCVYHSgVq1ghCt6ALQoF/QtEZrk0kFG3RiwjzrFaJm2nP4lqU2BkjDUuigRRqOHcFABO0czMGBYh95gbwn+PcrYoEUHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg/N2wdm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so672761066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497187; x=1750101987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zUq+r7ef+v2QkzFYgSwjq5w0l+Bf32YG8AOBYcjTTeg=;
        b=gg/N2wdmGDLfsILkIzHdprVy+yZ12JXhHQe0ao/PqJa7DpNjxouqGwNQvNK34YH5r+
         CXShuI8flSD6iAGm2j9eX2W9YSAz5zSJLX1BwAkbj9esQHPzxxe3EOf+0VyqaBchxQRo
         btx8r0oZoAJYeuZMf/f4aS5CjHrjGsnsID/df/rCyfOJIEXfU8qw2LzfwwaEWEARuTk/
         +MdQFB1fvwkgcSpNKl/pM+7Cfmu+yIYE7En9ZTxQrCIEdh0sY+f+d7Qp7O94uEg6cIFi
         euevF6lUTnTz2b2Kc5JmFrGsaK/i/7tFC157AIeku76OgED2E6TEUOCPn3LR2k+O8pkz
         h53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497187; x=1750101987;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUq+r7ef+v2QkzFYgSwjq5w0l+Bf32YG8AOBYcjTTeg=;
        b=uEzFtfK+Fu1hda+VojModP45TZGZ1Yuxf7TTw2VGJeNsVOE7SoZLB35NvOFFrDOUzo
         KetqTwAQSa0HuMk8+KzTBGV4gQ3ItH+PRzROuYrF6PXEi9fXmLbpXRbIqJCYAGntq0TR
         DpH3aLH3H0zzFGiiyggpQEmAxPPcl5i+MOZBKyCRkQI1K9+EvKR7Y777xE0zT48b+wQO
         P+mz2khjiF2wEmhkiQqYzlpOZIYbA4GvrckvjRFzz8OZ0i3dElCuYn9upg3Ep/WuXdv5
         li5uBwEBRqBc9A4fjK+D8Xav+Dzify/zpzVjwV+uaFrcAtlHwy+PU9CrmSskExcb7fvt
         6NjQ==
X-Gm-Message-State: AOJu0YwkN47D4Xc7dzw32GUP4nfxndBbHKK3zpW0YcMWc9xD6N1s3C99
	SCSbWNqmttvYUIJpY7A+im7y+ac8gVByv/sxmCU/4Y3zpLRe329wl7ufro5Hyw==
X-Gm-Gg: ASbGncsNw+j0NvH5yhvN/aR3Tg9FUXy9khCH0m5YtGT7VKJXs6KuVTiW32kObMOCs6G
	RFPpAVdQPJC0vbspMW/o8ZOwBAnXFnoqm+qVjK2qxuUkW65KCsuG17UB+g6TLlqWY5BSO4Ds/ha
	VhkIs3HI017MJ+8H72iPnpnCdiHd9zDSOKM8T8nO3PvWIQMEuEBI5ZheLxk8T5GzYGtO+SOIcuM
	zya4FEPnYa26vXi8pynO2gF6uRve5m8fnnYyo5ogvtwvw3qwDxRTybgVNZbbD6re3VhDCTDVp8v
	hb1CGatxIVQHYQYcskWLXppUyG+dP+2y0rp2hZ38u/44pZ9Q1L1o/K2itGzEzsY8MxJZgQ==
X-Google-Smtp-Source: AGHT+IFgGewMzh+9uCgGBY+Kn1tsLeFhryWUvGjeGUgcXtTdmQ4VqmEEhmd2vcP4Oml8wVbMTCXHRA==
X-Received: by 2002:a17:907:1c0b:b0:ad8:9257:571b with SMTP id a640c23a62f3a-ade1a9057b3mr1473741966b.16.1749497186850;
        Mon, 09 Jun 2025 12:26:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db54c3esm593430966b.39.2025.06.09.12.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:26:26 -0700 (PDT)
Message-ID: <bf2e3a4c-79ea-4110-b180-e388c04d54c2@gmail.com>
Date: Mon, 9 Jun 2025 22:26:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 04/14] wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add rtw8851b_dle_mem_usb2 and rtw8851b_dle_mem_usb3 and their various
quotas and sizes in struct rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8851BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add space in comments before */
 - Add more information in the commit message.
 - Adapt to the changes in patch 2.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  8 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 31 ++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0a3603f2e6bf..9ca88a293f99 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1647,6 +1647,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
+	/* 8852B USB2.0/USB3.0 SCC */
+	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1662,6 +1664,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
@@ -1676,6 +1682,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
 	.wde_qt23 = {958, 48, 0, 16,},
+	/* 8852B USB2.0/USB3.0 SCC */
+	.wde_qt25 = {152, 2, 0, 8,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1699,6 +1707,13 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
index 8013c852d5be..8e771afb6e5c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -921,6 +921,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
+	const struct rtw89_dle_size wde_size25;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
@@ -930,6 +931,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size9;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_dle_size ple_size32;
+	const struct rtw89_dle_size ple_size33;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
@@ -938,6 +941,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt23;
+	const struct rtw89_wde_quota wde_qt25;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -952,6 +956,10 @@ struct rtw89_mac_size_set {
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
index b825b1b4ad9f..cd5039e1294c 100644
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
@@ -2465,7 +2491,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
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


