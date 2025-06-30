Return-Path: <linux-wireless+bounces-24678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F7AEE871
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2094C163E81
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155622DFBA;
	Mon, 30 Jun 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRtWYmK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C421D3D2
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316180; cv=none; b=f8U/K2+kHrQ2XR6A53FDTdopXi7qRgoj+4tsP3aSYI7tToRZHskS38BPyNQOn+lrhxa3r7lteBEiiZxvS4AAxZWMPpKPg8wPIsbhIxLfKmZYqxDa/6YtI7wWzyG8piKFZ+witToHCy251dzkqdUbTNcZC2tkFXp4GbzJGrIBODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316180; c=relaxed/simple;
	bh=xB8mjIqG4qSa2ShqjTFqACUDq182YVXdocEzzmU+M9M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XOFIzInF52AW58dE5SLwADSnW3GqWIPM064T+CDkIl3ZO5VnFj3Zlc6qWwfG43E3Km2q/QX6/1/xGzedqSxSIZQbMKoAR09wqa86W1isLRfzvgKxz4Uy1SsvDlPQxHc4VfA/8ME/Ce+DGWtY65gbBTV2+9jirHaKWOnpcd6Ml3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRtWYmK8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf214200so21635815e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316177; x=1751920977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wKbt1dGDxC4bzaur+UvuWWaw1d3vwmEtuJDncgknm8=;
        b=gRtWYmK892w5EJyG0hpJQjxkDlcevM9qIY0weENUhZ9Rd+LQBN1UAX9p68B6y4WaNM
         k15gFnmZTorw2CslpXFoR2GGQF18RVofkPNu/uepuKgtPctooh4380RSdCjujY/P/fxy
         i7mVi4IF8FMkRCu5pEMY4QsVRUJ1cCg67WRCOOvRZd01PaVUbC9ORKKFPULnHxaIlqxC
         CrUcnbQXdWVI4x6QPtsyB8xeWMy7CTnwlJk9HvZd8mkS2SeLS1S1nBCYIz6Hs29AoTa+
         L2ZTdDCLWD9gVn45BOBwP1CM6abxdaPq7TomNMsU+vlCD+IH7u1+foKZ/zq9+iOn7taE
         Zwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316177; x=1751920977;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wKbt1dGDxC4bzaur+UvuWWaw1d3vwmEtuJDncgknm8=;
        b=ldQEfVifFmPtwYCwsyaGqgUCxRyG4sfIRatwXZezglF4eP7URZS9kGTjpZDRRXASsk
         o1UWc7aHsoLTyEsliRcEettmCRZyQpb1m8JOZCPXr+TUQWeh+cUu40zkB/NfUF+DReC6
         r4uIi9avUuCzcCmKLVxfxew6BzS0P4sZnWZZtRMV2ANBZZN9BSxQPnrqcKUs9c6u6Nok
         c+KrEX2rlY15dlzt6mnByWe2Uo5P02WxeZgv1O2F7OUdK4G/RD9jjnkc2Y3+ClKM98W3
         pVIbAs79AeV/4bOCKwe2f0wzYIiU9hpRnvzeL325lsnQmHyxdAJepXR9Q2vWPXjJi5UW
         VNzA==
X-Gm-Message-State: AOJu0YxsroVC+HuhBgyOe+rsHsO3r8dUvYcHr4HiVdiD2QfiBs5qxiTj
	TXm8ADcoRcT3X6HMzOh2nofG6ZylCKlnxqrHomtca6VHaaRq0MFH2uxoD1N8GQ==
X-Gm-Gg: ASbGnctc8zZnB6UyYZcmNf3yzzqBa5G4XpKXBZF0kkbNmTMFaSOIvZ0+jpLfC6WSR2k
	SKZWM2UUfSLCSlh37UfCkKNQ2fJ9W4XySLSgba/kk1IQWTTAMSB7C7jmxhQJmCvGrzaonJGiHmX
	Ry1lBWJyUN/Yuld1QLAR+OUJrWmbrE3tKkC2XML9FVMGRmCfE7MSwx8MctarSs1AzT/mYJH0AlY
	qpeB2W8JNj0s9cq+dcdqnher1RVVquS6rwX/nxjbMs/2Q8exklV7cEgkaX8+M3ukSyn0zSDkeu+
	XqSeLj2z7WlLqGH0taGUWw1qTBkrHtifb0IQN3+CGzTtLZMKm2fxE5jL5dqpr5HKWnQ4TuiLy6Z
	ayfZm
X-Google-Smtp-Source: AGHT+IFOoZ0hHxidXSCbvXjMZX66iCyqCwULh99pqkxqK0wZXhGWQpgfUb+6W0hGBpRgOaTzPxiqsg==
X-Received: by 2002:a05:6000:4903:b0:3a4:c713:7d8 with SMTP id ffacd0b85a97d-3a8f51c1ae7mr12721371f8f.16.1751316176509;
        Mon, 30 Jun 2025 13:42:56 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c8esm11401545f8f.55.2025.06.30.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:42:56 -0700 (PDT)
Message-ID: <a0dec631-de05-4302-9ef1-e730eb233f08@gmail.com>
Date: Mon, 30 Jun 2025 23:42:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 05/14] wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
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

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 7fa3d15ee10f..5fda45174dfb 100644
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


