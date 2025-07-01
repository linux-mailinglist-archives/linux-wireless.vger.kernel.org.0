Return-Path: <linux-wireless+bounces-24736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A3AEFF03
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061B67AB815
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4E27E079;
	Tue,  1 Jul 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE3w5O0P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C327F4CE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385845; cv=none; b=YUPqtUKrGCEYG9xz4ks+3qYdl8R/i9atqTPAtZlb9Qzb1zB3hjm/QldfgH1vVP9MjNeat6S9uMKYza7lyDoa1KvSS3c/j7BAvfCipCn1KhKSZwtam/TASm2eZV+FiAUFlOOPTOL5R4bjYNFLwvf1kx/ONORWoC2CpYGcHDGUte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385845; c=relaxed/simple;
	bh=U1dsarabb30k3wPgX4f6tP87Gu/SjPhCBq5oaqYkc84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eUV0p5rDm9CQQ56QbSLYfPXrgZd+sgrKwLOiK0pSmoJt3U3Xf7pmOneDjR55/6aRP11z3oiFOmI4EEdIXZTSQ7W6oPbH3mix6eL4ZeT6FjGOdrwoXU9ZJH5S78pvpL+QxlqfI98QzW973RPgNReZsIC+80EFbjQwfo3oToaPKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE3w5O0P; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso6248124f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385842; x=1751990642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nv+TJ/GqNZgCdwwS/vXIgOoP2wdGfxQqvoXpc+jAUtU=;
        b=HE3w5O0PHqzR4+a/HXlR4vTsAYtfHYBYEpQrfwwbHB8MmYaLAVDADXCqKmXsmtyBDu
         Pfa+mFPEsQqrIUwWduHj0ewPXzw7k5CXahn6RydZD7n6FdKHzPnfuoMmvMlgan1wgIeC
         TOMoRIcTuzFGLwsMqDdZUqA+83IzOHcdUwKZQw1ZjRQJ9mxP5kY81JfFEracB3aEp8br
         YgxVoP8zMCeawLJAi70m8RZW9F+v8Os1zwr4LdmHXDbPD4ubRxf0Gxratxkzx6mDlZhs
         L8wzuCbg0oLRM3UG75mhmWq++7AO+SRl9a0ea+WhZtyp+BgO1ETq1xNym9mfFn6ukMUp
         y9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385842; x=1751990642;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nv+TJ/GqNZgCdwwS/vXIgOoP2wdGfxQqvoXpc+jAUtU=;
        b=jNUnRBX0NhmrhGleY0p3NNW9bJwqKv6o8SyPP7RuWq5PFZsWGJQP/8sWjc/Qf6J1c5
         mBhxVGC+xu/WL0e35f5mYszn7a+VCSK9hteJm/KVtRMT+qQHG7ryAQTJ3moqyD6xynB3
         1pzcEym/6J4DVrhDwY5u2WkBxcZxb7K6XTXfZfbfJTgXGWGQjFyB0rzzTy05OEOMpkUn
         X7gKyhZbCgIG/FqpQLkJLlybPTmnUOyi0uy/i+7qfIxG4eOkEbyb7mlmJkJlgU/5jy2v
         PZDhqHAazGr4I6w45gSBeDpVrTcEqQdJMD436uXpWk2D+NJ6+GanPnqCAM/khwxz+k5/
         cRmg==
X-Gm-Message-State: AOJu0YxUEjKzxFkyYJT9RQwDOTDFNSInScDmOMyoXrPdvr7SuTuxnmYK
	4+N6uA2BJKMs5leupgyDZ7yanbzkL0onkc/mtUpeQQRYOvCRqUFKtFEfn2OwSg==
X-Gm-Gg: ASbGncsKklfAell5qYOY2kH0mzRKQnISTEgXoU+BIcIt/BTuCV3i7Qry/D3QvDoiPr2
	E0zs9bblUaEr0Qbzy7C2h7NZ6LVvMj3pk9UyhZA2PT2eraPAg31RceIIhVg3uEgoFlNZRIXN/yo
	Ny6sZ383KiLvbbrKOwwLzRbESlh9555exHAcNQp/uOr/znOaWxG68rxk0+R2vv2N2j/1Vysd1Bg
	8nG7HYp8gDTR/f5Uw3yqj1witVI898+0z06k18z6Mx4Lr686XNPLFVzpowLLXmIQTCDmi929+1x
	Qehg+H+9/0Hr8KwSml3OFZQiBBhd+SDvcxpN0ij43tYD1dKWjMZ4FGFQwAqnPeLy1uUR9WD/f+v
	hIOu7
X-Google-Smtp-Source: AGHT+IHvqPe+IfNg4OuVPHmaAXSzgYbIosDd42mNm3fffbo26dzCHGcY3XUxru/ZsaRVc7EoM2oojA==
X-Received: by 2002:adf:e282:0:b0:3a5:2a24:fbf5 with SMTP id ffacd0b85a97d-3a90d69c3ffmr11919104f8f.18.1751385841635;
        Tue, 01 Jul 2025 09:04:01 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f34csm13376314f8f.85.2025.07.01.09.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:04:01 -0700 (PDT)
Message-ID: <fccb1b00-8c8f-43e3-afcc-6466ae25da6b@gmail.com>
Date: Tue, 1 Jul 2025 19:03:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 4/6] wifi: rtw89: 8852b: Add
 rtw8852b_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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


