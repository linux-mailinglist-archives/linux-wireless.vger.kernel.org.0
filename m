Return-Path: <linux-wireless+bounces-24684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDE2AEE87E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763DC7AD8E5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0D13AD26;
	Mon, 30 Jun 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF6nWwlS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8810A3E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316396; cv=none; b=uK4orVkp/j2gqXZwlTnhh+aADNapF2Y6kkfYqwpDmiHGw2rPhPgFja6XL5DqofqlcwOW0+++7Cru+a2yFcbRnSYbN2ggL6AN+iIm3Xk0AxIHss1Q7YtMA5pkKcfo4TH4hT2Kq/wEur/OkhXeddgABo19JIF0CuQWVlQd4CY6HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316396; c=relaxed/simple;
	bh=svFTzVpsz4QFz5L0TSmXywImxB5tUCJDERkTCDXh8Fo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=prNXNGA462N+jbNQFThY/8x3/wqPvL0vzxzyqRUOjgvEYuNYukjts1wlIL5LtBW1rh5+ZCCN9E2rvPsmNVHEpK96EiBtrcv3o5FGF9Hl0Jy7WnoeLp5reSWeXrmiLj+2YTyXPP7d/Y0XXiTKDx1E4kmxumT+bhD165PbD8ZcT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF6nWwlS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2301920f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316393; x=1751921193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aCT15AxIa74u+FtJiATLEjHa5Xw4+9MbQICalSm0zR8=;
        b=LF6nWwlSm4eBDrQkYhSCn707D/zNQ483C5n+72Fnb4zKKaud1r9FYNSGOGgkTiuvNB
         WVchIjTD+nOP5B18odRuL6sG14bRATc9gJWyoTRi5PTJjGJC3UzT79vJg98A+7jrIN56
         nwC5I5yeSZXIRT8DMx4cSbfrJUY4xDMZFO4oN6AP5QAW/Kwhfcjd2klvQBZ7IgIl3LjL
         Fc1+vujDgr6m+FDnxF3vsDOCLZS/wfaSAS4wjxmhRyXTW/Y4YpYaoMGFFnCrqwPkfFYm
         fas9sxRULDdoo7ZRWb7FgzpaapIJ23USv3JLJFJMc9ZwDWA5r6E1aQ81ex5tkJYBbUsp
         oqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316393; x=1751921193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCT15AxIa74u+FtJiATLEjHa5Xw4+9MbQICalSm0zR8=;
        b=PD6CERuIDNDL+3hwryBX06XqpNtXOC5TI8QSPD/Jl9f6kGfDnCiDgALxSKMRo7LYVJ
         iaWUpVN1HU8uYDKyDPQho2rOy4iqxKFH70ReTm+yW0PDaM+hsd7tBrltLQKL8XH1MnMh
         nb42VzCnAbykcWMVpMB+QroUq52kIq4pZ9lKw2yCdxqj+slJymJwtD4TdUZiA4gJ/5sy
         bAeozZQQ5vO0PzAsTRYUREo+9y5k/Oz7/NhQXIJbT31Bgcs4HMm5zlm/+aZqUTYswGtK
         +joOaoNilAZK6OguvUYYSMk07RV4SiYNYOU5WBimU5vJ2H1MK/0+8WeXwFVoZNnixZ+h
         m5Lw==
X-Gm-Message-State: AOJu0YyEN2gsGn8QPrPXklSFADGFgH0KUtmoNUpjMeRelkdnfIFvXsdv
	zoK/aZKJDIkJgcVS392CYJ/os6r4tveIDcltK9xuldmaeUixA7/knik/a7hdSg==
X-Gm-Gg: ASbGnct+fxNtTe4RrE44f1gbFrhJuRuFsLpImhkC9szrQYFDovQDPVXvSI5gIfm25s6
	0I+ZTFVHwqSRHM1l6VIF3glv6+L0s6MLzrfNzU6wboZsnE2aHuch42NhJtfXXvyoDw3Xn1AM1GW
	0UpxHjqQ3j5jOE2J58JlegRaHhWmB1urFTeQnNT4fm6j1uX7w5t47ZqmH4DVtsUwugIrmjdQ/j/
	J34npS6y6Up+L0v35KLWlrvIemV9HJicwYO8MhGZui5hMoY0lpJmtaQDib6ZWM18y92WBJkLAOR
	2iTSTgFp2Wz011FclfobKS0oNOrG+VdMVA3Bf+qNxnHSzoqBvQwFTHQrqQSLYCakC23grA==
X-Google-Smtp-Source: AGHT+IFTnHKNuwG+tuCIoj2mfNhXbm8CW/Nn0RkQMInrNWxAyYBgPGke9h2u232Bkc+tBf8cLY58Xw==
X-Received: by 2002:a05:6000:2082:b0:3a5:2875:f985 with SMTP id ffacd0b85a97d-3a90066afb5mr13159398f8f.59.1751316393332;
        Mon, 30 Jun 2025 13:46:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8e1sm11143057f8f.88.2025.06.30.13.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:46:33 -0700 (PDT)
Message-ID: <5812bb0c-20d0-48df-916d-25225eee8132@gmail.com>
Date: Mon, 30 Jun 2025 23:46:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 11/14] wifi: rtw89: Add some definitions for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
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

v4:
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


