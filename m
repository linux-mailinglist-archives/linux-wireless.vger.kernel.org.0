Return-Path: <linux-wireless+bounces-26101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1FB1887E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3D31C84FF5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999028DB7E;
	Fri,  1 Aug 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERPkxicJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96E2147F9
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082224; cv=none; b=mqJqA8mNgVzIzGOf+xrOp/H4dE3HvN1i7X6WOBl0qIxS6kC+DB8NF2GNFnQEYJt1gzg5suVlVPoFTMdP9q2ZLP+pFJeK9Z6INd4xgsK1uY+Z0N+NaSLmXL5wVCXD3zOir93oLcKe1uxqYWx62KzMWd4ioL7SfLO39bpy3gq43eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082224; c=relaxed/simple;
	bh=2aj4M95A9L/jTmkvFhVsXNZxzCYlk2RAf3wE5TQPy+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jiYi4gVEZXnmR+iMDTJDkJV5ir1vxlWmRGopCP6QRcSpX6PgygwIAkvN14wHo1og4bQMejx3q8d7m3OrSwV0kB3DF6YkK9y4frPhMaT2V9ySR02dgaIsBva/qYEwGVxlaMJIThoVQZJRKT+iiwwUckSBGlKA60bYF9LZ45eTuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERPkxicJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso3450953a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082221; x=1754687021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMJTpctO46Y7ie4B8RaYA95CCFU0Fk8ojjxA7PKJtys=;
        b=ERPkxicJJXEXRvV8TfK0QSb5pRqAWMuXCCGwjJITLbgqLtIbMBXQrNaX9ofBQbSHS9
         MgvQLhLoNZxsXk69nEaqOtOv4rVqOow5WUyZK6dlkG06X1dUDr2RemYIBmGOw9tpQkhn
         4hyXpV0H9iNAKsaV/J6XWLgx05WztGDwl8E9EBj2ffRRh6FgCATMWEGQsjqmHYJiXQhM
         A2DOlhElF9Guo0COUjtEeZMxavdNcKV/98W/q+BPgMfTgfGBB0qFP5bXG+49d3DNQYC6
         6kau7f8O+xKTM91HQHsJ+Kvbzv3+7nu/NYsADU8TlQCODaApvzp8xagM3OFYcfqQBhW6
         oflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082221; x=1754687021;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMJTpctO46Y7ie4B8RaYA95CCFU0Fk8ojjxA7PKJtys=;
        b=tVYe2xVlw9RI5hJJ/GFYXVZmqSFEioWbYvQSvA1C1WGFejkC8Q8+lsfQ50AkWv/zeM
         knIE5nHablAU7xpuHcMy2JxZatXOEheJ/fbMzHroi/i3M9fGvaAUmGFdUtZo10pRcSXl
         DOYip9Pq+7fwsa0g8AjvYeY+VIy3CXQUQnwqcjfuqQuYss8W6c3Mj+VEPQKUIV6Y54d/
         +meOBp5aVXvY1moJzXB1VrH9GGaWt2PSPnPygl47RS8Tr2L+S1lxFFaaDj5XMQqRQylm
         Ep9myF4Qxm5ORhWBzz/K3qoMFNnv0HXbVpdH0/csVUUWoHgOF45s/q51FMiymFF/OkTb
         idMQ==
X-Gm-Message-State: AOJu0YxcIXVVbfpJhgRYuj/dKJmH9+mZ3FJyg31o5XoJESepgDtme5Hz
	AcBmK/Yqqzhipb1ZiZZEsOzQ7MJsw0ybn4+wvighgt8gXDUKgayvcZYLWPpNnA==
X-Gm-Gg: ASbGncsTuuyCjLOlSJpsra5HSSfEVoWGtXth6rKF1TlsgoDNkW6GzjjZ+yWKuR3DkCw
	r6VxyoxjVLGnV8etkZqu5IOTCZk93QCy7cbSM87UN4JvLHZfEJNnrZDI0NTUFZQk8mMc+Wb8K71
	twlwr7x0zFVjZ3s5E6OA7fsYG3kpaUSJvdUZB6lzW7KHPSztIVz4FfaZxooBAU7gx9dXgxgQe2e
	whnnBTSZryQNT1rOTFhkBJWfl862zJiKlgnmDUSz+5iLnT2FaGArD5yUZQsb3oiukkQu0+7N8il
	BQwLFjfeEZd/qlkHJxFThJdLcfOSsnIQu+HKwsc/tWjg3dSKu0R1sriaSraU7GUNH2U+7wM+LYQ
	tRHcJrVlB29GdmKbV0vW+yvWYaTBodQ==
X-Google-Smtp-Source: AGHT+IGsHO0U3MeKv2ptX/A0rLeS7lBEwf26q5drPtGGlNjqPQLhc9M7M3UD57T2vE5sopLpM9xg5g==
X-Received: by 2002:a05:6402:35c9:b0:615:9fe5:f9b4 with SMTP id 4fb4d7f45d1cf-615e6f51419mr609788a12.20.1754082221024;
        Fri, 01 Aug 2025 14:03:41 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615c57f9fd0sm2204378a12.11.2025.08.01.14.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:03:40 -0700 (PDT)
Message-ID: <99456c92-b544-44ed-a5dc-b0ee8994ea92@gmail.com>
Date: Sat, 2 Aug 2025 00:03:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 08/11] wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5e58bab5d39f..4a1405ba3567 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -51,6 +51,48 @@ static const struct rtw89_hfc_param_ini rtw8852c_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_usb[] = {
+	{18, 344, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{18, 344, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{18, 344, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{18, 344, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{18, 344, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{18, 344, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8852c_hfc_pubcfg_usb = {
+	344, /* Group 0 */
+	0, /* Group 1 */
+	344, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_prec_cfg rtw8852c_hfc_preccfg_usb = {
+	9, /* CH 0-11 pre-cost */
+	32, /* H2C pre-cost */
+	48, /* WP CH 0-7 pre-cost */
+	48, /* WP CH 8-11 pre-cost */
+	1, /* CH 0-11 full condition */
+	1, /* H2C full condition */
+	1, /* WP CH 0-7 full condition */
+	1, /* WP CH 8-11 full condition */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852c_hfc_param_ini_usb[] = {
+	[RTW89_QTA_SCC] = {rtw8852c_hfc_chcfg_usb, &rtw8852c_hfc_pubcfg_usb,
+			   &rtw8852c_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL,
+			    &rtw8852c_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size19,
 			   &rtw89_mac_size.ple_size19, &rtw89_mac_size.wde_qt18,
@@ -3048,7 +3090,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie,
+				   rtw8852c_hfc_param_ini_usb,
+				   NULL},
 	.dle_mem		= {rtw8852c_dle_mem_pcie,
 				   rtw8852c_dle_mem_usb2,
 				   rtw8852c_dle_mem_usb3,
-- 
2.50.0


