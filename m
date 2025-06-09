Return-Path: <linux-wireless+bounces-23902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C714DAD26C2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893997A8DE0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1A21A455;
	Mon,  9 Jun 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js1/8SEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2838DF9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497489; cv=none; b=HnBUK2t4/C5odsZEl9L8iwzp+xMgbIGQ0W9pit1cFH5ELi7lE10BXL9VJRKfSiKBu0ZOQ22OlyklG3dnNsPlA0mkoVwVkTmltktk3uJ//7QFEIu0k2L5Ax3H+h3EZO6UXPuNokYtye03bvRu5ysHeVK7mv3O8xfWLUhJVVtJC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497489; c=relaxed/simple;
	bh=ybHHz0dRKJzSoK8u8oTEVVOMDkPokb2cMeRgICf44jM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mtDY437jta2Q8OMlLkY1Ur7eXEf99Zhk5u4snTpimJmuBdx3i0vfvqcAkk8NZF7lvUPwDXy5sJGj73zRdRQqKy2T4iPYRlRdoPXeAEyg4M8KWmIKhexINCdMj1pyk1zu6TdmbTOwpdK3JtXH9OX24MNWEc+DoCH1+GPEF7ZlKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js1/8SEG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade5b8aab41so261419566b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497486; x=1750102286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=woIF5jOmIIhi+EBoujXRolNx2+s2+Qr80kYQjs459V4=;
        b=Js1/8SEG+SwK1Ar/yvqWfFtdIZmAoEe5fnKj8K8g5+Bx2Ke3cYxPgMf5kqopae2akD
         60SdUWrWhTX/h6XH1Bwu+G425j/ZhxmTVZo7ccHADOcGodZPDj1NtJ2abpA4JgqJwRnv
         x5iqGXcQ0ckR3MeK+j24Nm22t6emql8qaqA1lhX188kCoRRIWxn7AoFActrarnlYFu7A
         Knt+FLLgXAG+juCVSM6klP8Nt9Bevh5rxWZM7JU3p+txds+VSOAoZE3EbhGwmNMtd4KH
         cZY+xwMiT58zJ5kAPnPrQjCkeXxVhCj+VClo78F54Hr88Fm6X//kMcvY4Vc1jo/S55C2
         hD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497486; x=1750102286;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woIF5jOmIIhi+EBoujXRolNx2+s2+Qr80kYQjs459V4=;
        b=dW45ebj0IWCfVGX9+jXmQpj2yj3orf/hSv++dFxOHNI8Ryv7QNmCl7P4fOkMxdnxn5
         FCfZ0insPGUMLjMBJGPDsZvpKSsK2nP0zX/wEoygPTPIBzSrp4Gv7a2VVjVTpObdJhOK
         5EbwjCCVu6Itw5DASGTUXeYxm4Q0FTHVt5oAqZqB98e9Hi+2Ua8q3EYG2VAuQDWYnwv7
         auyXh7gmMqIAIXdy3xdshfTxwFwfot4a0O21q+LAU8pKiprKEdWrpuieXFZPGAYEwmxn
         1vSaoM1DkYZgxvgfH87yAc3uewxtdzqKfLpeOKeKnRAMShJ0JiUmJb/peUuhgQHEsG6D
         dnWQ==
X-Gm-Message-State: AOJu0YzQR4Fc5/omFDH879rYYbV3mO4vDWVmeQk38ZE8rw93AoFKi8F0
	fIaSWSZnf2ll7hU+yCeoZWsWRLbO9wkAalxUsWzQQXikNIOtTdwgkpnCfkEJOA==
X-Gm-Gg: ASbGncv0nHYMldTlcsMymsxJ99Ice4+zhtewK9aU5M4ZeRno/GISgfsHjvud5NaOGVi
	/cyc6QYTwX+zGLfKlilDIys9h6/yeylpYZTwK2hlgK8VDafLh8Bx9KMV2VlGWGLmVv8QgLZCUWe
	4H4U20BwJz5v2kvsMbGRyY5LQ8gID+GUSB48qPKBfCny5BKcWXzdcRFxxZ0k06AelqnIad5zaJA
	ZJN+fL427vbgNqEWaDZM5bKHnddgm00E6p/JfThKp6vXlF5FAo+Oa57gtVwMa+XZ87KTguVk/Mf
	I9iR6H38bRVyB7s0rt4ocih/BOjsnPbFhDe0IJKN9blcfRJ5DlyqWWhhHJY=
X-Google-Smtp-Source: AGHT+IFojehHx9NmW0lsYZtojzG7Wpsa2p6ZZqO45Cje2tweHcliKD1wt3dVTqNd5wl5seN2YW19mQ==
X-Received: by 2002:a17:907:fdca:b0:ad2:549b:4c8d with SMTP id a640c23a62f3a-ade1aa46a4bmr1462587666b.51.1749497485874;
        Mon, 09 Jun 2025 12:31:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b202sm587746966b.161.2025.06.09.12.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:31:25 -0700 (PDT)
Message-ID: <28ee9b9e-639d-41bd-b233-a45b1fbb8c68@gmail.com>
Date: Mon, 9 Jun 2025 22:31:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 11/14] wifi: rtw89: Add some definitions for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add various register and bit definitions which will be used by the new
USB driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/reg.h  | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9d9e1b02bfc7..a3b83b1a92eb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -381,6 +381,18 @@
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
@@ -460,6 +472,17 @@
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
@@ -1026,6 +1049,12 @@
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


