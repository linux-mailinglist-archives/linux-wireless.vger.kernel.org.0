Return-Path: <linux-wireless+bounces-28683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BEC40C2D
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BD074E41DD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65050256C9E;
	Fri,  7 Nov 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6DNFBEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDD27B4E1
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531699; cv=none; b=OQazcwdxEY5GRTG1MWZRKqVWqtdNQGbu1OdfMBSdjHf0gobESHiFI86vKHw9kjsBwi9z5fdHNFYXQY1+p5+lXuwFXXoa61uT2u7jb1mBV4RV5zK3EqyA8Jz9zwAXFXSJqp+IMpSZk4W1FI1Vkc9p1KDMKgElz89f8dAoms0gODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531699; c=relaxed/simple;
	bh=mDSedNXDJJhP9v+nJDgx/F4Vjm/bSlXW/LTqqsh4qvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hts92rHOopP3n44FJrtHYFWeoRP97YNrGEdEdoQKGfSTC9qhkFQcBxhwCqWIBM2nm1kdH3FdyIOaLgLqXuoLi6PI8k6ffp9szv45ZMLDqtJBccW8c0VAWXxJ2JdO7spmeTrAyMR8bQBUATuhSC1VVs0BsUuUriN81XNB7cBJg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6DNFBEr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so654326f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531696; x=1763136496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZ4NobFcJnJ0tILYwbt2NwpSMCncfl05dYmd0XCQ6/4=;
        b=b6DNFBErwU7tKVygyUGifVGt7FqNWYrWDDqPo2f/nZs5wu/Sf6OQ8PqOuOgb3F0bAb
         Z2myyiUa4jDQjfdJdz47urLPgpsfvWPBfOImb2sdZOunWzQj5VyNlY6G6KWZLaqV1nZB
         Nmqn1eVXX6xKnEHoUpm5TAobm4a6TGewgLYyT7d3YSIUOYjy1zMB6QN5j607nl/TUUL3
         4bK/uhGVJb0khBcGXBxH4XwNBpGg6zrSNQVpN+gy0e6daB5YNNxXnY0zc4BzY9HBOwZo
         7fmzxEOFzW4x8Riv1dXR4OBOPPvXomXIFoV7/6OnZWm5QHsm/2EZXJA/qtZyFrPPcPe5
         ruWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531696; x=1763136496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ4NobFcJnJ0tILYwbt2NwpSMCncfl05dYmd0XCQ6/4=;
        b=hOsGIGx9tKW+tLtF7gM9Hrp/HYd7EijJdAEVJc8iBmBbNBT3Uvsn1A/cyObpAl7Xrt
         hsxpTLyIURgwU590iOtHA4Z01fkOcIw3roMCwEHXpKwbcgVjAOx9LOByPNSRwC3U9D0y
         Tvna63pmPxuiXDNIMmPsvVv8CFBHTDILk+1UQwctoXV/VSzMeEYEx85b4sw8SNSdocdS
         guxXP+HgLdru9N1dex3AwQNYZKOb9wPhgdds34JJKDG6EmoZMg1IgZ3mkiRnAf2Kvxi1
         9e6LC2gKuQ+u3Vqh4oQs4HHsNbDoMp9t0BbuYLv2/PU6hrHaRaFtv8Tsk06XYQBL0242
         lJ9w==
X-Gm-Message-State: AOJu0YyvSFXRVNBayUJlAuJscn6ht6GQC1HKiwCih5evneAzUONUEwFI
	HdTFELFc0rdeKjOC2bzzZyxSKs9TrQLFmSKszXbp7hqfUzUPVfsBLl7F1IO1Bg==
X-Gm-Gg: ASbGncvb97AtCAXIFXKNqJMiU6r3IxMDx6QTlQSusX8GT++qQbGE+E15I+uzD9PjG5v
	kFvAuNlZUFatJ7dr1xVMcTi64WvtyA5m+zwpXAkOMLMneE+L89Nklzfy0shawR3B8ucEtJ3Q9Tc
	mBayv8PbBvn9DXqHSdatJ9jDGDGyS6mCZUntPGFaYTToc4OPTaQ7+5d9pksopM8ntQor82bzC2X
	BQip1VKCBmVy8H7eI2oY8jXFj/zuzJK6zndTVAQeEaIYu5azbIkQMYt1L+rsFXfSZnTE2W2v+u0
	V7XHH7Cpt5wrWzj/QomYopROdxHShUFRsQ6ySLuZLHj/f8gajp43bSaLAhT4HxnBKknY7SGx4DW
	7kK6ys7zh9qUIyjoZHznnT+pt6v8UqbNBYQIju9DFEn9cwVQbWwEGJ1p12oQ9r9S1GJxV23DhHS
	ofZ1aIr3WaQ/Bim/rOhO4=
X-Google-Smtp-Source: AGHT+IGDlKgZI/kVEDT9T4tNr3/CllxTUfDFfAQ6gSX9E+bwlRYGSUbckBrsYgxkMyeMLO2fo7aI6w==
X-Received: by 2002:a05:6000:2882:b0:427:a37:ea3e with SMTP id ffacd0b85a97d-42ae5ae858bmr3388453f8f.52.1762531695646;
        Fri, 07 Nov 2025 08:08:15 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63b7d7sm6352403f8f.11.2025.11.07.08.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:08:15 -0800 (PST)
Message-ID: <d1032888-2a53-4c52-a8b9-6e00cd6758dc@gmail.com>
Date: Fri, 7 Nov 2025 18:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/6] wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7855fd55b43e..76b64fd5a639 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -48,6 +48,48 @@ static const struct rtw89_hfc_param_ini rtw8852a_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8852a_hfc_chcfg_usb[] = {
+	{22, 402, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{22, 402, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{22, 402, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{22, 402, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{22, 402, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{22, 402, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8852a_hfc_pubcfg_usb = {
+	512, /* Group 0 */
+	0, /* Group 1 */
+	512, /* Public Max */
+	104 /* WP threshold */
+};
+
+static const struct rtw89_hfc_prec_cfg rtw8852a_hfc_preccfg_usb = {
+	11, /* CH 0-11 pre-cost */
+	32, /* H2C pre-cost */
+	76, /* WP CH 0-7 pre-cost */
+	25, /* WP CH 8-11 pre-cost */
+	1, /* CH 0-11 full condition */
+	1, /* H2C full condition */
+	1, /* WP CH 0-7 full condition */
+	1, /* WP CH 8-11 full condition */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852a_hfc_param_ini_usb[] = {
+	[RTW89_QTA_SCC] = {rtw8852a_hfc_chcfg_usb, &rtw8852a_hfc_pubcfg_usb,
+			   &rtw8852a_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL,
+			    &rtw8852a_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size0,
 			   &rtw89_mac_size.ple_size0, &rtw89_mac_size.wde_qt0,
@@ -2237,7 +2279,9 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie,
+				   rtw8852a_hfc_param_ini_usb,
+				   NULL},
 	.dle_mem		= {rtw8852a_dle_mem_pcie,
 				   rtw8852a_dle_mem_usb,
 				   rtw8852a_dle_mem_usb,
-- 
2.51.1


