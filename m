Return-Path: <linux-wireless+bounces-24304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD6AE229F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714344A285D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0321019E;
	Fri, 20 Jun 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3FKA9kl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF271CBEB9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446187; cv=none; b=mzN39WorDjhkcnr4riA09frivTmuC7V7o23xs2OhlMBMmoBf1Ylrm6re/TEPIdSewpOHSlPAs3eMYV1q5pAYBuZEfWPB8k2KkLNWhNZfwIWLvqhE3/KWoUsNfiI/pGq/5A1B/7bhW62h0Kv7TCKh3OdZT8hj7olkE5YyrvNrO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446187; c=relaxed/simple;
	bh=DhdUEWXwcLveeomNh3l8ywNA/4p4rFBmpho8I+vCkxg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sy7w1iXQiZyVAg8H4mhIY6PXGqPNR73WpQPRzyYLOpL4W0ieRr7bGbsH7apfYeRKXI4O8omX/TClTQ0+OvgjnSHvo+eMRSOONvrLuoaUdJP3+zDa0ZgUn6QYRR+LP+EfzCqNhJzXyAYpHxAfX1UH+HED2/WD060cH9HQOmKi/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3FKA9kl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453647147c6so12072405e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446184; x=1751050984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBmDc7Jb2nUGNlirpNdEGQGBNBqfcVYkc3AV/4dowWw=;
        b=d3FKA9klvJLQgmTog1KZtg/MRHVdMqICf+Q7rlKnPOV1+zQEvHrslxWVRO7bdFg6Yc
         iLeAR3rEifP/f4qxEEnTcy/mMKKgYK8H1FWUL4Q3zEgMtFDe6PMb2O635DzkrVrVzCSR
         88z5msQK44D8DqYteO0r6YuVcxNXX0fIM1N9n2lt7UgXZKL5fwWXPP0p2O6c6SzUFgEA
         wz3DfC9oOqG+YBnQyZ7ekLb7DigegU5STyswfXkP1hw/oKBJsJBtoRInAkrV3+6tm8Ry
         sjV8xO/7BhVmyotof1CQPAYqPBt8r19iYCqOBgapZQ0WD0jDe3zK8XDFJxsgzhfcVLb2
         wMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446184; x=1751050984;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBmDc7Jb2nUGNlirpNdEGQGBNBqfcVYkc3AV/4dowWw=;
        b=OU+j8bQdJoYweRwaOGB0fwToHvhulMwB+CX7idxYoFvv8YRQfpJm1Oiz8XqmEdsvdR
         bfFWayrkhtWXaPEA9eSE4z5BB+OJFrN1jMsOERCatMbCpIjw07a2VlkSmb7EihdFJIEg
         drW0l+Kreq81fRHLIPdfpb72FFBtEMIp1bF21S8J5mPsOxLr43GeB7blI2WyPpM2L+2x
         MdpWGe9hEu0Cf+G4mdD6eJj3ntOhH+w8QRJQFT9rooBC50yLoE0qNBDwLhlc2LgDXFiI
         SdwUstG6SIFzKrskt07uX+q58Ye1fJQZvjpQgzhi+B2Vpnbu6xaY4t3Z2VVtRLhRRlgI
         cNSw==
X-Gm-Message-State: AOJu0Yxgbj6P/PBWErVkb6a9PPtagfrgblpRELN3wu4R/4BWdhVzyEhv
	i6KxkRJ48qI5JK0hjGT6eJfHVk8AulMQRZcxNm3S43u0Prg0cS3IFHDtK53VDg==
X-Gm-Gg: ASbGncukuXJX8L7/a4MDgjEUSXsNL+9SBRYanxdffjnTBTDyDq0zZ2e7AuOmfLc7/Fg
	4pEfD7wnWayaXcF3fmtst22by/44Yxfi/MiOjYU/qNoQ+aYV94ZttTUxOjl3GEaDdUAaA33LJCr
	EQRyqI3a3GcKrrJyPh1em22Aih5bf5+LEnSI7D8WBMnMGJG0ZwSDR/C645lyycQpfzKC0K0KNrD
	SFc/sK0iJE9u+K+p2FDqsxpYJKZxC1IqUwsRbqWokOobgbg+lTojRKTQQHDYfc08Id3nscHOWN8
	zdsBt9iMqI8U8W5cHAOt895O0G7wqhy0r+EPaifHFhp9qUAZfMeomInLNz+SUP43srW0JQ==
X-Google-Smtp-Source: AGHT+IHJAWwSJBpindfcbhOQYwEbVAECXyhrQxMdwqGK2p44bfD395RHlAh06KZDGjaa93M0AHYDiw==
X-Received: by 2002:a05:600c:468b:b0:442:f98e:f37 with SMTP id 5b1f17b1804b1-453658ba2e3mr36986635e9.21.1750446183665;
        Fri, 20 Jun 2025 12:03:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e9844c3sm67915625e9.11.2025.06.20.12.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:03:03 -0700 (PDT)
Message-ID: <3fcba6f4-8c7a-4a3e-a2e9-abf7c70f31fb@gmail.com>
Date: Fri, 20 Jun 2025 22:03:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 11/14] wifi: rtw89: Add some definitions for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add various register and bit definitions which will be used by the new
USB driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/reg.h  | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index be4a8486c9f8..aa9e1668996d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -382,6 +382,18 @@
 #define B_AX_ACH1_BUSY BIT(9)
 #define B_AX_ACH0_BUSY BIT(8)
 
+#define R_AX_USB_ENDPOINT_0 0x1060
+#define B_AX_EP_IDX GENMASK(3, 0)
+#define R_AX_USB_ENDPOINT_2 0x1068
+#define NUMP 0x1
+#define R_AX_USB_HOST_REQUEST_2 0x1078
+#define B_AX_R_USBIO_MODE BIT(4)
+#define R_AX_USB3_MAC_NPI_CONFIG_INTF_0 0x1114
+#define B_AX_SSPHY_LFPS_FILTER BIT(31)
+#define R_AX_USB_WLAN0_1 0x1174
+#define B_AX_USBRX_RST BIT(9)
+#define B_AX_USBTX_RST BIT(8)
+
 #define R_AX_PCIE_DBG_CTRL 0x11C0
 #define B_AX_DBG_DUMMY_MASK GENMASK(23, 16)
 #define B_AX_PCIE_DBG_SEL_MASK GENMASK(15, 13)
@@ -461,6 +473,17 @@
 #define R_AX_WP_PAGE_CTRL2_V1 0x17A4
 #define R_AX_WP_PAGE_INFO1_V1 0x17A8
 
+#define R_AX_USB_ENDPOINT_0_V1 0x5060
+#define B_AX_EP_IDX_V1 GENMASK(3, 0)
+#define R_AX_USB_ENDPOINT_2_V1 0x5068
+#define R_AX_USB_HOST_REQUEST_2_V1 0x5078
+#define B_AX_R_USBIO_MODE_V1 BIT(4)
+#define R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1 0x5114
+#define B_AX_SSPHY_LFPS_FILTER_V1 BIT(31)
+#define R_AX_USB_WLAN0_1_V1 0x5174
+#define B_AX_USBRX_RST_V1 BIT(9)
+#define B_AX_USBTX_RST_V1 BIT(8)
+
 #define R_AX_H2CREG_DATA0_V1 0x7140
 #define R_AX_H2CREG_DATA1_V1 0x7144
 #define R_AX_H2CREG_DATA2_V1 0x7148
@@ -1027,6 +1050,12 @@
 #define B_AX_DISPATCHER_INTN_SEL_MASK GENMASK(7, 4)
 #define B_AX_DISPATCHER_CH_SEL_MASK GENMASK(3, 0)
 
+#define R_AX_RXDMA_SETTING 0x8908
+#define B_AX_BULK_SIZE GENMASK(1, 0)
+#define USB11_BULKSIZE 0x2
+#define USB2_BULKSIZE 0x1
+#define USB3_BULKSIZE 0x0
+
 #define R_AX_RX_FUNCTION_STOP 0x8920
 #define B_AX_HDR_RX_STOP BIT(0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 94f27a9ee9f7..ec01bfc363da 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -73,6 +73,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_BODY0_FW_DL BIT(20)
 #define RTW89_TXWD_BODY0_CHANNEL_DMA GENMASK(19, 16)
 #define RTW89_TXWD_BODY0_HDR_LLC_LEN GENMASK(15, 11)
+#define RTW89_TXWD_BODY0_STF_MODE BIT(10)
 #define RTW89_TXWD_BODY0_WD_PAGE BIT(7)
 #define RTW89_TXWD_BODY0_HW_AMSDU BIT(5)
 #define RTW89_TXWD_BODY0_HW_SSN_SEL GENMASK(3, 2)
-- 
2.49.0


