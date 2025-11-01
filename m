Return-Path: <linux-wireless+bounces-28461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCFC28635
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6C2B4E1432
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D218FC80;
	Sat,  1 Nov 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMVwLhBt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B72586C9
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025018; cv=none; b=HtvpyyoeLkQIepui+WRIVjirmXh84/+DfvN/nwOIAaMWgzFyy8Jr+Bknb/2nX3lvxnGrJfp5kqLLMCx/jq/FPTDCehx0zL2tpgrb/bi2+M9VDQ4seo4c+MUFuJ8WeQ1UInP+yAihhb3MIZTg//T1fuiJZg+YVCfLzGV44s4q+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025018; c=relaxed/simple;
	bh=HajasGrUpZPqulyq1i5LkTaZ0dUSw8Lkbe4XyQjOfYE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oeCmSZXwmZgpsboAH9tyeT5qTMAlSjvI2csk1gOTIl3KeC2DZADMghtQpIa4TMzKmWOTMNVll9GnTRVMgA4ULtfRlmmYiIe0/LU55K7mfm6/nkBYdcOn7E3pGNqYU8aosvG8vTvEgLWi/24BBq9n6+Zl478x7jkmQIMYo4SXCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMVwLhBt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b895458cso1988321f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025015; x=1762629815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zG9qaWUE78/KLBSJxIHvDAg+2r4+Abpl3fh10kwuc1c=;
        b=hMVwLhBthPQSv4IVe7qtTFRyT4p5Ec+YZIlIcd/CN1qbPIIO9D1YMwYQMaXpzAOfya
         J4IoD4hLOAbtu4F7MAYjtgJTIQEjKTZ2TdMezZpw3w2a+3l5oIaZrnJSSvrCTcXxq+qm
         v3CR3WSOB6FV27XuY7pjPeCL2/ijCp8PJwx8pFKdDTKlt/P6ZDs1tQbij9ttE7/6oOa8
         aYZIgVGeXRns8BftljCZAzn65R4Djt2Qc3H0eU1d3AGJc4xt9FPMiU/Bx2N0TdviNaVN
         1Ez5sdrteKYL1yTemEzuGmAt3lcZ6q8Wr68zpSZeyYarAJabQPxLIwsBUiU//1gzi5ld
         n9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025015; x=1762629815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG9qaWUE78/KLBSJxIHvDAg+2r4+Abpl3fh10kwuc1c=;
        b=A1QJ5cYaHglAjs1GPqNQQGo++IGmk438/pzXAjm8Wl0feHav+As4c2QTKaZn0eOEgL
         0bHVD76bSSlPLt8Lbqcq8WqgGJqtra4jDcGRjJ7d7C5285Mmhr45tpRjGrAluoog2PdT
         Lcrs/865+EvvAlIW5g91l65iP88u1mbaxWpKjEiPBaxCF2aEZxXwjyhCqItu162weIau
         1DDUeHsriT1vIQDqU0p7EQIGYikHtG6xtQ1PsJ4H0l/mhbmLkaHeCQ19jsVzZYPugrkm
         wcU8E+z/vRgG3f3xVytierN7PKTVbUHbIYeinXCoZGhdje5j7YWOTeJrqKutD3BJWXLc
         qwsg==
X-Gm-Message-State: AOJu0Yxum/Uk26V4fFn1rOlpvSmtnuJZfXJzV7FbfjgfDkWkmlurQdUc
	z//80m3O502Nz0ZU+A6NCVUy2Ncr6QvMMpSy/iaSyceD+HhB0fmaAUAjAGmVhQ==
X-Gm-Gg: ASbGncs5xLPa5bykyBN/omivcdGH2e/Vw/O1j6HSo32nski/suma1yhGN/tYHZGeSGw
	LuZ0w///pJCuky1sGzxy2/XsGHbKKOrLVFWfCe5n3NbrWeN89KjMMycjJPOiBL8mTWwyKga1m9B
	rUINbKsFBf5PEWSHG7WVEGXseZand6bMwzCVS99wzAQ12Rdk3FRZK3SY2X9sEcspMKEziUvPiRv
	cwa8wV7UQkL6buRxYSJGu7JFqt7dT0TohJKrGduIKWSwg6scjkEv9Qi/2UiXbKjUJ4qcDlw9e8F
	jLbyxjefp/tIJoaM06i7swMZd6V7TUjFPYTWkQB6k7Ao+BIurR2PKV65XrGODRSKAIMi00fi7Up
	mYTCrFFub9Td3yqiYvUO3RCufA+hNSU0ay0OZbWDewPL6AB4gk85Sm30ivnbHXYZw7OrpBeiWaS
	W9dqxg9PmGePDY7TQrXKI=
X-Google-Smtp-Source: AGHT+IHAo9KH1EuCpDG4ucrxmvX9TTbuFKZkPVjiEmW3mrXLlgvgHnYoZOEb0hLBg3raJgFuAxu+aQ==
X-Received: by 2002:a05:6000:40ca:b0:427:854:770 with SMTP id ffacd0b85a97d-429bd6a5ec5mr6067241f8f.43.1762025015209;
        Sat, 01 Nov 2025 12:23:35 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm7058883f8f.8.2025.11.01.12.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:23:34 -0700 (PDT)
Message-ID: <c12b621a-037c-4870-ac12-9795ddde6b53@gmail.com>
Date: Sat, 1 Nov 2025 21:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 05/12] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_post_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in rtw89_usb_ops_mac_post_init() are located at
different offsets in RTL8852CU, so move them to struct rtw89_usb_info,
which is filled in each chip's driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the registers to struct rtw89_usb_info instead of extending
   rtw89_usb_ops_mac_post_init().

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 3 +++
 drivers/net/wireless/realtek/rtw89/usb.c       | 7 ++++---
 drivers/net/wireless/realtek/rtw89/usb.h       | 3 +++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 9cc682872d24..b8799a37add3 100644
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
index b913cae95e3b..c8a644403341 100644
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
index ea1d8726ec3f..4c47071b30fd 100644
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
2.51.1


