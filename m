Return-Path: <linux-wireless+bounces-24298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1774AE2296
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450C76A0F73
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF22DFA49;
	Fri, 20 Jun 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClW1esbb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241641FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445884; cv=none; b=MbWyAYc1opDbY6iO26IhK0NqvXugFxApKOOxgKVOo1b92627ZQIZ1ECX8qx7w71VmXM96ec/SlfHowovFr1GayrpogTi8zNdrI9eZNaWlyiDj119yX5hJ6BEj3aw60mrObxfWqWF5xNjmxrT5ENP+Y1Jgwc5QJRfNROehqMuLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445884; c=relaxed/simple;
	bh=+pGJRWOrzPlTE6vtJwH9BVUMl8e1McBK814ncGAEmFQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r8qMSZLui6E+RRL1x6iLWlWiQHJOCjAV/G6UMu0Fpik5RLhW812A7ODYq2spBugJUEUO/8YtlxSSQEGl2VNa24/aQU4RKz0PkoAd26TyqpKIDd00YOHDJglSCyH18oV9R+JWWLEzVdyWwi1KSR6EDnIwqzjg2fHeWC80/6giSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClW1esbb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so13982445e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445881; x=1751050681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mKfEpQ69Adg71mTd7LQ3/YJRmjUjP170d1PZlBCPVw=;
        b=ClW1esbbXqWZ12GBnccwL4neUk3K6+mJVwY2DjwvC5JsJi1lTmtGDeRCpi56zMm0dm
         t9WUltzieHZW2T5PU1HXp/yohVrTYgQXwWIKfatiWBfxIrc7rm8WxKbaOrTiMfuCghJf
         pf5VQ/2LBRrBDOyql0Wo4Vk5QMTPzOaM7cCsQQLjAoMIqCwuwGTTQJ3nvQ9xvSgG7g0L
         UinzlnZzQk7TvNV1WUZdvBedViwKtyjQLKhVYU2Zd1g7+7sVRssFuh7jKgwG3cu774pt
         Os0CZNRV9ND2piiTflgzXXtafo/620LGifniZcDJyx2EeuibuuhsTejtiBc9THgmXrLr
         NzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445881; x=1751050681;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mKfEpQ69Adg71mTd7LQ3/YJRmjUjP170d1PZlBCPVw=;
        b=dCXb4ewbG19zSpeVToCjAovgpYJDVWMHovx0yIal93h5l841fekH7fcp1xPle7jrco
         L+Zao3YfSbqTYcS7UKVgdGcZCESUY22Ivk79hAHYJYIOhrDXOZvwtso8Q8/Gi1JGLaJi
         xuzd7yIuV65wuXjrzNwfDKIB+Ks/l1O0TpmFWlbdkaSkJbjDy1c+pSEvAM66sE5zz0pR
         odpOu/Pg4RcDWiWeR0XiP4GmjLFWN3DQKHknvFrv8CNYEZnXHRr4nb6MR+HkSg9ILGUh
         UomuEHmk9VAyCw53X6t5ymvkfF9yQukDsBxAJS1oIsZGQkXJbCxJfIwcGmAMwwiEOXlt
         sRMA==
X-Gm-Message-State: AOJu0Yx5QlkWabfIBEhn14AA7xiRWloZ3AFEneYhbbhdzEdEnuYL+tTV
	dYe64T85Ns9Vfbq7nNJXz/wb9dARcA+bWR6P5xfOZCnOB6RONbTE3KEQ/Df1WQ==
X-Gm-Gg: ASbGncudM0jbNmjiqjQuzRxoPd1K8KGXUcT09y3Hglct7LJmSx7bmuyKLcHtkMv6jCL
	21VS6PBfEaicIMaRJSpXEalybouHWasu01DaMeGr2WuVn4MaoPJXf2HLUtnLNKs7+S2N0b2fdXV
	gdltaogpl18HGp/ocE8RqWB+oS76kdlIIFDhQNxzwMJNXNIHmS5EP2/8eOd4G1HayoceIn75oqa
	XvVwYMefQDI/PLlwOfcquM02H1yDo55kMYJ5MkvDN/C5KcefXgqj8FBhgczRY8rI2ozQqDqqFbg
	992RnnNCn5xl8bSfFd/k220UgL3ThD3EA8u+TFFFRFJ1fr+AvW+3vjiW9tU3P1X4MYKgZw==
X-Google-Smtp-Source: AGHT+IFwLiXn5dZohxQdgga4i1c+gyXjjA8B33hACJ6fud9pVvcNq8uwDFrRb2LeiLkdO6sxzr0XJA==
X-Received: by 2002:a05:600c:34d0:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-453653af999mr47317015e9.9.1750445881281;
        Fri, 20 Jun 2025 11:58:01 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a27sm66585375e9.31.2025.06.20.11.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:58:00 -0700 (PDT)
Message-ID: <d57c0958-2ca5-484d-88ff-0a7640488335@gmail.com>
Date: Fri, 20 Jun 2025 21:57:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 05/14] wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8851BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Adapt to the changes in patch 3.
 - Add more information in the commit message.

v3:
 - Add Acked-by.
 - Adjust the wording of the commit message.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 55703de9920a..e6ca3b045fc2 100644
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
@@ -2491,7 +2533,9 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
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


