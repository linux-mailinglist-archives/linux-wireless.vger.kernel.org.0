Return-Path: <linux-wireless+bounces-26711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA68B38808
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D378188A62C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBB279DAC;
	Wed, 27 Aug 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbeEM6Km"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AF17B505
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313498; cv=none; b=jGrC0pEa+9lnPWtSp4ysLUEIGsUsK2nZfqjldwpWpL2pLwCFLt29g38hRR42GJ4RVBnVM777M4Ezwa/3Kd/y+P7ST+A0w3MQQI2nDWkAol6f3U5kWREUfBFNZ0h7DK9iZiFLVqnQedaFqH2Fp+opWpnSNWbRWUMs4G1ndZWKOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313498; c=relaxed/simple;
	bh=XSQkYQ79KJKuLneUjbPeMOPL6l/NdPcI1awndT13NCQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fXYAW+dBsdxDvU/LTvhaDCEREzAS3EewriPds6KLYRpMhIXDJ1EW7mOO8HbuPRNyqqsKHzgqhh7HpFiRU5eOT86cyciHRxG4YKPWys6moh/vZA8YjkTzS8T4bcRzrD1J7dZ+2x3kTvOie1wGnoQZNt+aEs8Li1v3ztGhBqf/I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbeEM6Km; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso37765e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313495; x=1756918295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Ad63wbZ0+7+OC2arM2tu3tr3qDPs0lF3BbtozfzLgI=;
        b=jbeEM6Km8Cnki7lCIpODiT1H9jvXqXBGAd/lt7IN5h09T5Dj75HhiQ7N1VNBgwj2nk
         uZEpmztfPAGVtNk6R0m5PtTwDbMmfX3fpJPOTpH3TNvQiD4UemPlsq70+0BRbfwZkyCm
         /LronV8ODqAxuFToESp1m3VQyBRrcVuAJf8jkkwEfkxAIKcowTxe4xy2Qyl915YWA87G
         02zAiD3RjeDn8MGmWOyts7HN3VTFpAxsVVg3uGoLhzrgFG/RQlFmF7a+iylZ6VX776F0
         1//NfIDHD8Z9ErdtysFuXDVZA6XYK8m8lNfuWYEtqMs/ApxdyOhsKZH3Ist9Oy533Y7G
         YTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313495; x=1756918295;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ad63wbZ0+7+OC2arM2tu3tr3qDPs0lF3BbtozfzLgI=;
        b=s+4RjWvPSEmybDjR8Pf+Si52IN6230kOadr44IPVFurF6sO41/EeFXUQD/o/LA1+VD
         jt2P13czYA/0pMTUGJ00yVPTKFOMfuGP3I+R/3ngMXSnooyEzlSfI4ahAgTHwQkxycJd
         fA4Gffw3+IR4d0Y3SPj74IxAk+xMTaGcUOhFWd++M7+pY+WuwJB0q6sHJe/+q5OJCYD2
         q0s+drusSczuKrvaE3Ks7ZOZt/DRyAq7L3GQnCcRLeoDS+Zy614qESMhjlXMHHswrSfR
         CQSnLz8Z6xbfBKEB2B3wT5ClgrRuVT5tlqsc7hS2rzqb3I5GddtGE6E7hn/XjCaxN2op
         bkdg==
X-Gm-Message-State: AOJu0YxWx4A5hyX06NqF2ykQBC93pNTVQb675BFZMH5IUJ39GsVHdneW
	PDxrtnjk/jl/EUhcCQN70FYHFdjqM8na+sNC/3gQGzbzNQdWwzJL35XdxupRDA==
X-Gm-Gg: ASbGncv8IG/ZHckBg6ENHouXi7nWbFL6wfrT93WPn433aBTCCob6zsgONcsCK4Mvfk3
	8QrM5UidrY39dP0RMWb/M/s0EMEBM9U2XiI2kayCX0hB5ZsDsTkysweGx7ZxPe65owVrvdUnNVu
	Sbr544N+eySKrqLzAM6ES1hq3hcbjpcvkP4p/m9mfShhaxPxKkr4+MadHqmlL2aRHgi0dqWKiX9
	qe0BnCfWRikQCuNdhzN+cTLB1GIADWXJZtl2fj2engnLnP7cUQ20bjfOY4pzB+TnaXZy5vUW4in
	KUcJ3R+hO0KdRwZeh2Un7x70ZoDczbQAj91NlsD2UNb+4JSuEyA6FyY+9NchLDJfZZmnyeSOQi+
	Q0F+T5abzXJGQ9jJWxj2LjC6nfhHP5Q==
X-Google-Smtp-Source: AGHT+IE3gx7aYu+2rFWeY44aooJFUwzXysOTj0PD5pNs6df07mrIwwWmX1eu9k0lNH7yGC451JOt4A==
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea6 with SMTP id ffacd0b85a97d-3cb46fc9122mr4936641f8f.3.1756313494464;
        Wed, 27 Aug 2025 09:51:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cdaa4a8b36sm399513f8f.0.2025.08.27.09.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:51:34 -0700 (PDT)
Message-ID: <1b5c6b0f-ca50-4ef4-ad3c-6ecf85adf86e@gmail.com>
Date: Wed, 27 Aug 2025 19:51:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 04/11] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_post_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in rtw89_usb_ops_mac_post_init() are located at
different offsets in RTL8852CU, so move them to struct rtw89_usb_info,
which is filled in each chip's driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the registers to struct rtw89_usb_info instead of extending
   rtw89_usb_ops_mac_post_init().
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 3 +++
 drivers/net/wireless/realtek/rtw89/usb.c       | 7 ++++---
 drivers/net/wireless/realtek/rtw89/usb.h       | 3 +++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 3fcab1d94208..bd634722411d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -12,6 +12,9 @@ static const struct rtw89_usb_info rtw8851b_usb_info = {
 	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2,
 	.usb_wlan0_1			= R_AX_USB_WLAN0_1,
 	.hci_func_en			= R_AX_HCI_FUNC_EN,
+	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
+	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 5c91e123672a..8cee94874134 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -12,6 +12,9 @@ static const struct rtw89_usb_info rtw8852b_usb_info = {
 	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2,
 	.usb_wlan0_1			= R_AX_USB_WLAN0_1,
 	.hci_func_en			= R_AX_HCI_FUNC_EN,
+	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
+	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index a3769b91bc1f..a165d4d708df 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -708,10 +708,11 @@ static int rtw89_usb_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
 static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	const struct rtw89_usb_info *info = rtwusb->info;
 	enum usb_device_speed speed;
 	u32 ep;
 
-	rtw89_write32_clr(rtwdev, R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+	rtw89_write32_clr(rtwdev, info->usb3_mac_npi_config_intf_0,
 			  B_AX_SSPHY_LFPS_FILTER);
 
 	speed = rtwusb->udev->speed;
@@ -727,9 +728,9 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 		if (ep == 8)
 			continue;
 
-		rtw89_write8_mask(rtwdev, R_AX_USB_ENDPOINT_0,
+		rtw89_write8_mask(rtwdev, info->usb_endpoint_0,
 				  B_AX_EP_IDX, ep);
-		rtw89_write8(rtwdev, R_AX_USB_ENDPOINT_2 + 1, NUMP);
+		rtw89_write8(rtwdev, info->usb_endpoint_2 + 1, NUMP);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index be3a9fbe42c0..32cdbf5128e4 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -24,6 +24,9 @@ struct rtw89_usb_info {
 	u32 usb_host_request_2;
 	u32 usb_wlan0_1;
 	u32 hci_func_en;
+	u32 usb3_mac_npi_config_intf_0;
+	u32 usb_endpoint_0;
+	u32 usb_endpoint_2;
 	u8 bulkout_id[RTW89_DMA_CH_NUM];
 };
 
-- 
2.50.1


