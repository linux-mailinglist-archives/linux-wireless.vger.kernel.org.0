Return-Path: <linux-wireless+bounces-28685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32530C40C93
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47514E4467
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06032F753;
	Fri,  7 Nov 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOC7+ECT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AF2DAFBE
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531767; cv=none; b=WhI0etGUolnkOiOfdwibfz9XMpRkv7KMvVIX56wgmtNIO5xcPivPvj41gJT9zAgXcfnBk3aEu69xQhybqlYFhBOulJWIfSPz263VWZlFoQlTKAhunjBc/ZAPhKN5nSsz0oQE4vsJb7HJmS4fw8D5HHLGXzAj2pM2jI3KJyBwMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531767; c=relaxed/simple;
	bh=0Ltb6Q4x+z9Omy4ZrNLvVyaSf+SM1Ei6EGnXM6/IZMQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UN2tRTcDqVciusIh2+YaEpN4HY6HNZ0YEDcC2cvMIS2vIgguRtLmti9TtqvoBtKNj7ghjJz7tk8qb1DYEaUOkMGudCDSUu4lMM5XZaDtOw5vFFSDgSBi3VuMvx/9bliGxO0yCKldJ4zW9w3o5HY18Sii+EKuUPq89R0WYglUJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOC7+ECT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47754547a38so7546745e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531764; x=1763136564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGGhYOD+mU6aJuvSeSPvuLAy2TxVSsX5uF8iDEwhHeE=;
        b=gOC7+ECTcofPtzFlrl+IxmWr7X+WbwLBweWy8a0u9NUKhoqeYXCSDUXwvT22Dox0Ji
         eOkhVUISQdfYplJcDGtUX6yfmIh1iOAUjBoFZPjXHcKEV02xJawvaI+d1yia9Dmu2HqR
         ob2nQrqGE0nR3naGo9doNmJyPsWXRd0Mjv2G8C+XJH5Ee2J56L26mH26t6CKDzPSpSpJ
         TZsBkSXR9UZ+DyT3z7Xh/nATsjwIb90ZWa+5OPaGxl8zsn6BPbQebL1iGtPzLpe0lRvu
         Oq1Ot1HZkZ5xbASJg4zFyX7Mnd3P050Z1QGy4KMGtLy5kQBDv7zqgIlZEYUX/m76SoiY
         WIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531764; x=1763136564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGGhYOD+mU6aJuvSeSPvuLAy2TxVSsX5uF8iDEwhHeE=;
        b=tSm75UYzcCb4OL3Y7HZKvZYqrkwdCXHS7kV2EDOBVBIWpKuIf2JNP+KMpqDZa4IxlF
         B0KfpHl9FbtcQSPca7o87qVHA8hMecjMNcTyHRVPqdSgAS56uQUUGnZwrseA4uNXj2gO
         U8lZsrBY5KHXQOfRdah1Yo+elJ4GVd1HHM/V/CV5IV2fAsW+xxWb8SQZ3rvZXSDrQV7d
         NglgBqw2aboaduizHOdWJW8p4Vtuy4B8kmhHW8BjkJZU+CBjPb5p9rYM8bV0lzqnQQ+w
         9//I1PQHmMYfwuD90KDUvzT3m/PRNtIjNwxDiql9UBpWQzmZWZOTb1OmDUAfCZ7LkEWS
         q0cw==
X-Gm-Message-State: AOJu0YyfMYwMmkNqWlbQgWYmuL2ZeJ2W3wlqOBoJDan2cOAyK6ypvJBG
	6EgP0+j8rAds8U/qcQmpb0n74jLCR8fT07Nmt+EpL6fUdqXdL3Y2VOhVp16yJQ==
X-Gm-Gg: ASbGnctXqLAy4+x6qr4CFzVwqc4Uke8rmxF8MriAJwhU0edNmAISUnEaOtea3yncm+s
	Z8E7ulvLZ/LXk7mMvO4CoO7WI6LdN7EPNdIo8ASB23Kbd1Hr7xd7UL9R0+kowbbdATCEW/WY3VZ
	3sNTe1/zay+664c391CJVaLz94Thk4sJuvA/ohCa+Lwsc+OkfBKrO+9UHJyS5LoeybsCQkYYklG
	g8xVTN5JHGe3ggOHF0X+Ba8pCqPr1IdamBN5W/dOCjOrsk0e6OnoZDgCbJsTVBQ+p5s3MPizIhV
	GFhI60N3NtTbdj+JHPJSpmacESYtOHYiutkf4nMBQyl5CqFhtbqUJRoxKO8KPe/KSf1wlvZ8CCS
	YbmtXvumXwXtQ4BXoRGGenXRacFRxkWxH+N/bSEa/Q/yZQFPyMLxcIEbWhwuFFa17pBd+qXPdZ8
	D5u34hH5hVwoTw41Zx1pQ=
X-Google-Smtp-Source: AGHT+IH2I1yq2Hq4SbZLsYVCL5m+5u2EJFZ0WKZzbSIf4kmacqVK5MyTUATTMj4FfoPWmLWAuyYaDg==
X-Received: by 2002:a05:600c:1e88:b0:475:dddc:8c08 with SMTP id 5b1f17b1804b1-4776bc97d32mr29363475e9.15.1762531764151;
        Fri, 07 Nov 2025 08:09:24 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf26sm5928944f8f.3.2025.11.07.08.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:09:23 -0800 (PST)
Message-ID: <9580e5be-2bd1-45f9-ab75-616b86e25694@gmail.com>
Date: Fri, 7 Nov 2025 18:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point of the new rtw89_8852au module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw89/rtw8852au.c    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852au.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
new file mode 100644
index 000000000000..ca782469c455
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8852a.h"
+#include "reg.h"
+#include "usb.h"
+
+static const struct rtw89_usb_info rtw8852a_usb_info = {
+	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2,
+	.usb_wlan0_1			= R_AX_USB_WLAN0_1,
+	.hci_func_en			= R_AX_HCI_FUNC_EN,
+	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0,
+	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2,
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH4] = 4,
+		[RTW89_DMA_ACH6] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 0,
+		[RTW89_DMA_B1MG] = 1,
+		[RTW89_DMA_B1HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
+static const struct rtw89_driver_info rtw89_8852au_info = {
+	.chip = &rtw8852a_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8852a_usb_info,
+	}
+};
+
+static const struct usb_device_id rtw_8852au_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x0312, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4020, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1997, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0x8832, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0x885a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0x885c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3321, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x013f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0140, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0141, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8852au_id_table);
+
+static struct usb_driver rtw_8852au_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtw_8852au_id_table,
+	.probe = rtw89_usb_probe,
+	.disconnect = rtw89_usb_disconnect,
+};
+module_usb_driver(rtw_8852au_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852AU driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.51.1


