Return-Path: <linux-wireless+bounces-26715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C382B38816
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9BE3AF80D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD8276023;
	Wed, 27 Aug 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJK33tJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4A28F50F
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313764; cv=none; b=jhQ5VLFEURJHSdA1M+t2PJEJtamGqt84OMmDNgd8bhDossxvd7uku1l68KJBD5FCQiMD6Cf9uXedRhRqXIXtIqKj2nYagzqHM7M/wzbFjT3TWLJAuK+cs+MDPsGeOwYjEtziONKM3PEFLDDlzBaPfGHF/3IaCvmp+7wldzoJ7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313764; c=relaxed/simple;
	bh=kiK5tIgELdfyguuclUo/XPP2Ax5P5RwQa7GyQN8TLv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=COJ/HG0MNxH89xezYLVgaG/dmFglFhv331ps5y6+gdrTrjZ0ymvbTCxT7Lf7rZiaTrmAKc+1U+AExNpjZp0l5PXZOgUre9BXC66OAylqQ3K4PdR9j/jaOGrRBqsQ5vPeX+gQuLTwpVno0I2LQqjXySFU8SgeGX3Ic2HnZiqum7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJK33tJb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso5595e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313761; x=1756918561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HxTigD3r7zJJMDjBT1aoGWhtl1IIN5dN/a1Zsrz9fmU=;
        b=ZJK33tJbo71NvX86fep/sVCa+2MA6bUrDQi99+tuCQLRgeTtM/DYDg0BE50L1GQD4t
         Hdz0Xsgqcas/vpoos10RPjnrCFR4x6ZG/Pojw9zfKwJmDYE9b4NbbhsnntEmr6hOC6IE
         rqW9vg8E0WATtK3oCfNS804c6puZRGU1g4T0npi3VlPXoKz1KxVVhn+Cm4BishbULF/r
         /yaFvgi4MIPr87pPEVmpy2dSiJi3FT5YPcYGyvBUJDTxbjEFup6maLnfisD+2GZ/Zt2Z
         6UvHg0666amdUMlnP1l61nCopmwwo8ZeKEUqg18s+ZnBNBLRg2zS1rrzEn9aOjsdALy0
         kTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313761; x=1756918561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxTigD3r7zJJMDjBT1aoGWhtl1IIN5dN/a1Zsrz9fmU=;
        b=svOA5+fup2IC9u7onBOCE3Fgw6mwTSGjM21cS+QwcPaLYR7xl4X5jPrXUSh2pVcNkG
         OKe+Z0I0gGIX9AQqUQsZpOeQhHNd6FjDX5VZwMuIPrf9DlnLISkO7+pRxXfwZqL6UQbb
         fGrgf2NYlzWUj4if4b8BSlZHK1LqL2gmI+FD5bJri+ZaSzT92YwG3AF/oSv9gByfBq4z
         AVpAVr7jh9cMvCSf3wD/3E6XvoDlarrrV5/AWG20O5N0QSp2I4qQMKD3qHgP1clunNJC
         nUsenKZeq2ByV9bthek90Idx8togw8VpQkZv4lHdKFFZsdnZKV1/HfGw4qNqzs4al/lc
         d4uw==
X-Gm-Message-State: AOJu0Yxyu3tonNgE+MWDhQ5ZIpD1pdtWaOLApbgEyKksISVdUXQxL5Io
	FkpNd2ILxCuPqQBinunP8gWbfFNtk6+FYXGPjdQy4EgLoFAaUmOrp0it7M/DjQ==
X-Gm-Gg: ASbGncsdBykH/UethbeTJ2Ga+PsaLbc8FC0MNbaqxh+K063tfKEZ6CdSg/ILcQeCrPq
	CReoK+3eRSvretY/kuyphpl0/d5PyhdsFqQ9hy9OJPi8jfLbNfxd4nW7kuNWHafImmtOSpKA1h3
	w5fKznZqQEn5MP8P4QfxsgalCbZB2IiIuWixcSy/gaIE5T9PRHupqEAFSoojTo/qqVFwjV8RvhX
	76IJqDQGH1t50UN/V6TDSCSysBz1zBWs93PxExzDYkwlah4NVzCg0c+Y69PBQCwX7w9hIk214k1
	e9/FLoEKjK8iT4zn4HDNZ7wnfXqXeaa+hriNN/CkMLE+5wyhZRuon+RbPbK99HBvStNEf8oixOy
	n0KWTnZy3UaFXfE8nqdPdVgGM0G64S/EKubtHTwMu
X-Google-Smtp-Source: AGHT+IFYnpwirbd7cJi/hsS/LGg4wzRudI+7rTdDPgrsZ4FHC/WAKImfDsihiSGFFKzy88picAVMuQ==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr162944935e9.26.1756313760592;
        Wed, 27 Aug 2025 09:56:00 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd5997658fsm1466051f8f.46.2025.08.27.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:56:00 -0700 (PDT)
Message-ID: <078ca8f6-92d1-4f32-8a4b-9332f352dc48@gmail.com>
Date: Wed, 27 Aug 2025 19:55:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 08/11] wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 651ef96d143a..dc48c66a3b2b 100644
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
@@ -3051,7 +3093,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
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
2.50.1


