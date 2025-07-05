Return-Path: <linux-wireless+bounces-24844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A7AFA178
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B02D17122C
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A81E5B95;
	Sat,  5 Jul 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSgZHKpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18582E36E6
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744320; cv=none; b=pJ2UCiPXSGaLTVBtMMPWn6p0X+n3vcspchigBJypNTYJgUcmPKHZstBTf1KZOCfrxBSHgwaafQsk7vDBAn9c7Tzp4BdEtJqARW62XxcTMBvB2bIoVXDB7LrYGr1dalsMKQZhtXnlTEWdw2pEB+Udj38J45zafyCk33w4TXCWp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744320; c=relaxed/simple;
	bh=6QkOGaN3I+H/JeKRH5BWCVDe21N7ggO7v1WJCaJKb0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a6gEiRP1xRoPSEOBWwXmThyaXAKFOv00HLPwzO89V0ZfbnC2kI+UZagLoDxLK+GIhTags9BdI86D0i+GH88l/ROLHjonU9oZaTMp4A3M4fa25eIWNTPY6T+UpZPo+ZAmUv/1gVXZhLdH6v+W/6+KMbLBZ3O5MrYsiRzn4Gkm9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSgZHKpX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a582e09144so1118458f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744317; x=1752349117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0mfmk/H5iu16+XKPdIaF80jgsywAgdfCLuksQNcuUHo=;
        b=LSgZHKpXYvpkUfT5j8l6LG7RfoTewT66o6qL/bQg4OUlfLq/QCD2kbgXqIx7YMEImQ
         6XMg8ELEdIDj/Z6xT8TuZvCanGqcMO38Yecr+b30mOjvBRhFMs3RSXagKRa7nnaVvT0x
         ISvTxrnRlkK/nggHofafCys2k3BPw7vOo+7+PYofOpyqVxb/ZUx2RNP9XAi6MPD2qpFd
         1zf3q604RbJQ72FCxV5PnWivbyFnYcAFd0QYn1I/7DHlMj+cdlP0SjpxCPSSGoNHwUCR
         /yZrTOFIP7kyRpCpc50X8UEISqPArhj21hp4dJXl8bkxsrJwCTXveJ4RRrtaTOuCRUvA
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744317; x=1752349117;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mfmk/H5iu16+XKPdIaF80jgsywAgdfCLuksQNcuUHo=;
        b=gOUqauO/6EM+VE3r40jKIws8H/q/fC+MuncbX+CSHG7XfDhIbTQ/DflMRERFXuKPUN
         axd5pNdVTBDdutsLHdI+mvS1G4wTnZ9TwPQ8PGg5X24bkCaEopUYudOiuO+mmeLoKUNL
         NosSpOoxDzE1ee7RqoYrNBV4MrDkrl/x1p3cXRvt9OiD+viEQ9uNSchRr+k4cIhRt6Se
         IkHTqcQozo02bnFqJdvCJBJDjmoSvpGyGpy2uLmc4hVaVE1JZFTUFyrmSeGn+lJIgdYM
         85ByOVzyxv5T77xBJs1DHP649AzR9eg+YTEjNuZZajP0SOz95dTMBtHYW5ISCIGUyJDu
         E7dA==
X-Gm-Message-State: AOJu0YxJArKyAX5mAV94kb9MoihlaC08YMNTorhdWD1E9460F6Hus6Yb
	BUZFB5mTWcE7dznndG7lfcdBPse2IlBEbFo5Kp1uvbKJ/Rm5FL4fvdhPg8lqPw==
X-Gm-Gg: ASbGncsGCaoP53TIN5jsWWHqitQ+xwH3WJW3QddzmkffY1+0WAJ8MaE49pT8GdLPeu3
	TAOrsJ2UjmjZw5ipyFPSKzZpTSXemmgAq30g7Mstyki3W234MuwpwbhsMU3CaZLbBMy6FD6/Chh
	mXLxg5zx4cdUiv/mrxZGxPFjBl5BV+sOPpvq/0YimekSKfOGgXVlcwuQvQGJRacLVPdpZ8PC9/0
	etYPu25a3qV2fiwRdZiwWoyrGFNvraese29BOEAw+J3WYkeIyO+fG8reRLAhTFm+MjN20U10r6I
	4VGiBJ+gwBzWsHtb8ONOZJiX+KS0Z/XjNfPXG6DBl7KpoHHMCJ9+l2/ZdO5dyaaovzdAEg==
X-Google-Smtp-Source: AGHT+IHo1h0vEZnybPJJjE/hWrGGi/PQeGuoRzD5W/nGvdBOla9nMrw0sZtIvE8/G0TDRx5YdrFbqA==
X-Received: by 2002:a05:6000:4a14:b0:3a4:f435:5801 with SMTP id ffacd0b85a97d-3b49701cb56mr5745382f8f.17.1751744317089;
        Sat, 05 Jul 2025 12:38:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a491sm5684257f8f.76.2025.07.05.12.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:38:36 -0700 (PDT)
Message-ID: <40dd1597-27d8-4316-ac3b-4bf7ff9f3e2f@gmail.com>
Date: Sat, 5 Jul 2025 22:38:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 4/6] wifi: rtw89: 8852b: Add
 rtw8852b_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 50eed21371a5..33ab71d84ffc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -49,6 +49,48 @@ static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_usb[] = {
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
+static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_usb = {
+	152, /* Group 0 */
+	0, /* Group 1 */
+	152, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_prec_cfg rtw8852b_hfc_preccfg_usb = {
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
+static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_usb[] = {
+	[RTW89_QTA_SCC] = {rtw8852b_hfc_chcfg_usb, &rtw8852b_hfc_pubcfg_usb,
+			   &rtw8852b_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL,
+			    &rtw8852b_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size7,
 			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
@@ -846,7 +888,9 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie,
+				   rtw8852b_hfc_param_ini_usb,
+				   NULL},
 	.dle_mem		= {rtw8852b_dle_mem_pcie,
 				   rtw8852b_dle_mem_usb3,
 				   rtw8852b_dle_mem_usb3,
-- 
2.49.0


