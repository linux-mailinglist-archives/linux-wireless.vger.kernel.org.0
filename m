Return-Path: <linux-wireless+bounces-26090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10654B18842
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343CF160C4B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC11F9F70;
	Fri,  1 Aug 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGuvS1N3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4415539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080844; cv=none; b=J7dWMIgW6ggMlfYXK4AjG1ka0suIeFSTQK+feIFniegXHYw2cRG15dscQD3e8HI6578XlxDFo7NuLJbRx7NWblVIoyabMQog1+7kqtWUAacxY03fIqutfzZLFRfGzhf1DONY6PXgfpv//4il4/+ZStTr2dq9tD4YYaR6hCJqljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080844; c=relaxed/simple;
	bh=Kw62kzDX4N7ZTSijMSAxZS9Bn+gi8H6S98RzSJP9rV0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sEf0pDbUS+U8GBKlrA8jR/VKq4oFYuya3tt97NRIS2LexA2of5AoiooB5zVng2iwQDOhE+p8EIvT2R45rXw4sCqUvsZVkYwLk5nkgrdIKvQWGVI8qjRQpA5wX+tDpRj1E5cT8YvuVcYyUWrXwsnRma2YPJ8iqGSeMkynfSI804k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGuvS1N3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so3560946a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080840; x=1754685640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HLcdhJXcxB37Z0w8zmK0/6H0JsnX9Uwl7menN6EJ2k=;
        b=VGuvS1N3pw/2wgcEle7dt8D27f4b3iz2M1z/rAAuYh39+o5EsnfNaKyk5bBAyjyQOE
         9RUVWlffZONbi15gcQviG+YchpzmY2lKq3zuU9uMu1K0qtdQ3it3mkjIrsFWwnwwPw6f
         we0/Ingaoq6kw+fqY6TB5hzBVd7uY8ozw1QGBVhp+iuVV697b80nqhZlZRLME3FRT1gG
         X2zhkOPKsqEXYO+u2hLRPewETVtQMlu7XFuJdUxL1DS/skF6yOwWA0CaYqT17vrL9z1e
         Fo+Gz7oVq1t9cF2/JYm9OQhtAV4c1YnrwiS15xg0pIDDn7XjPzAHZPqJ/g1ecCwgX9Od
         LZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080840; x=1754685640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HLcdhJXcxB37Z0w8zmK0/6H0JsnX9Uwl7menN6EJ2k=;
        b=teDX0NaVf3o78ymjFHG2V6D4ZGT1czSPMr5N9OsbXufABJAji25cBg79qnSgM3JdHA
         RC33u3W7Xz5TRPSneaPMvK1aYZv08XrHc8qEOhtViNR8rjaGDF1PgZQhbfxhOips0lSL
         EvDH34KAecibmINjh0UtX4X1+/z3hussAsohKwaJe9LXY7e8MmraNwfeAuV6r6QM9+QL
         P3T4mBv+HIu9M0vPKLXpUaLIVV5/Qy2VcCKt7Zj2mxrjX7ILrndIq6BR20amF9CF1+KK
         hUv/huvvMSVEyeBFxNFSDkISkxRCautSJrCp+ifsomd/FT+vvCwTFoZU0DvubUn4l6nE
         wtdA==
X-Gm-Message-State: AOJu0YyMklLe37KdAgXIBt48kJNlSzLc14miryBDlpZaaib7OLeXD3OG
	k168Oh+dhmTNIplok2oSBvU+wJMzYujlCwKvWc8MWFp65hJnCLOaoQjTKH3coQ==
X-Gm-Gg: ASbGnctQqPQr9Q2V9Pw0Ss9VnQvQLuzpSj+o2dg7j1YmHFVZU9fcb+2vtDIbBsGTi7V
	cq7Ugls00hkdlYv5YsA1Vz8kHoIEm192SdcELtbbm5qVj9iebVDVq/IjKnJTvN0romFGRUDutdj
	6v2WMKCgQasr2e3OKnD83fd7DnURtf6n+2k3k3r6NeKoXxEBHLc8fP+FYMF6LRBQFCiXTarjNaX
	xLM6Ty8AdsidMBAFQlUikEphToKc/AUhL5E41TlSjslo+O3aMUJB8GlVQ8+E4VXFsNFczxeMk52
	vdMFwAa7+AOhurZrdIr2JFWBC4YeYrls8vCSqBPep2TOk9w7Vl3xDbcQ8+FaT2ZUX7+QEuUxz4x
	bFZEmRxIkgc8iEhnvFpECYvbLJyqfhw==
X-Google-Smtp-Source: AGHT+IGekYgUE3UqwQWIFvbiZ2wqN/37RmgPhQNd9kLTBfeaqqM1SMJ8/cIxkVIABgwRM5cY2Y64Qg==
X-Received: by 2002:a05:6402:210b:b0:604:5cae:4031 with SMTP id 4fb4d7f45d1cf-615e716e449mr688397a12.28.1754080840407;
        Fri, 01 Aug 2025 13:40:40 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm3276252a12.0.2025.08.01.13.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:40:40 -0700 (PDT)
Message-ID: <d8347b77-f0d5-422b-bf53-8d379bc0f95b@gmail.com>
Date: Fri, 1 Aug 2025 23:40:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 00/11] wifi: rtw89: Add support for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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


