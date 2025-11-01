Return-Path: <linux-wireless+bounces-28467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9BC28650
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4601893EE0
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC12FF678;
	Sat,  1 Nov 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSXDlk3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF492FC86B
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025264; cv=none; b=b+Khz5zwbhXoHrAek90yW8s/g4MJflrzv7kK//+x4dNDssvXhQNy4Qa+rnQqebeDYyAVo2okIqN1yErgoqyILZ8H+94SXTOnMT0n+i40Wsb/rtzmegXC4P3wEnl1MeiJMB5FwzqSI+vGFEIM9OqLiGvontHn68DE+onU5QpZM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025264; c=relaxed/simple;
	bh=T2kOppB1PjUnVq59+kWaZrV3b1TewOxynv0TgUzYoYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OFNmH9PxfSoucVYC86IDRxBxGVR+Gt5IAvucI+o6LLw68RUPpFgO+AmWyy/ojuLi0A0aDaap4VNSbSYm3P0LFsl76EQoODw4/6BG0lKVk7OLWgZhTz0ACHFX7Ue9CQTJXgSVO+15xlzkXORXmEf4Z3ZOocWvZqHeQmrFagnJfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSXDlk3J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso21355415e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025261; x=1762630061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0FhujW+k2/q9FC2pb+nVVv3dV7/p79VxMi6+jUwk+V8=;
        b=dSXDlk3JE3egCXgTTO21v6MXlQDfmt5yY1Hmlva6iOOSqo9euzwuLgMGzJFuNAq83Y
         xNC4/puWk2OjG+TdSFlJCRe/w1yp+OMPHH3wGe54egAl8pyQPv42D3IxPnaObdbEO5qh
         d4eEWeFEJNZrOO/Y2OIhgvUGUx/kRkKbfCkaA5SHHQ1OKrJ1I2EqTnsstLmz95X4EkGb
         C4QrvL+opbYZivSvcR7DtaxxQZa6xA2409p5+cTJRLLmuCVV5ZyESeUNSGofvXEa93nU
         hS64ijP7k3HTiYBySHe+rvZr4NKEoN80r0hkme+xNCRkZ9GqZkaHX8kKhuxPbVk/qgwD
         y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025261; x=1762630061;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FhujW+k2/q9FC2pb+nVVv3dV7/p79VxMi6+jUwk+V8=;
        b=jHQqxhCn0ZR9soWeOGt4P1JWZQImHxX1FahyAme5TynFVYedQrlgK4/jNYBGeO3V3Y
         ITjs804vmTE6OS6iPl/oZy+Gly51vOe5CI/z/+L13FzAtScoKLcF3Nulyn2xtcp8K95+
         0Rd+st3GRFWS8w6nuK4zMz2QJUpAmkJVvI5DlC32Bp/8sy3ZTSEnWYtTkHpGkDfHlc3R
         SBSwsGAWS4o40bc/AvnW0SwZ4zl2Fi2gfzGnrK5Wkry/97UUaeiBstX2yrgp6g+W/ver
         gb6Q5Z9VLHuW37BJPAr5gS0U+7ZZIa1HEWuyB4OQriMRJEKGLiNa4KRaoaq8WiEfrMwx
         iy+A==
X-Gm-Message-State: AOJu0YyBX90LxyZNTJbyIezB15/tsCDMFUxmVU3bQNvJ5aToPvWYW2UM
	TZZk9kAXw25bwuAhynUywECPYVztwkdO9z8spLihO04Xp1SDT48RZ46WQ2IxOA==
X-Gm-Gg: ASbGncstwuCIsaSEu2BHyvP/UcIi7AtQztBaUF/LHLY6INxZOwbjY6CIk9dZZMM+3/y
	jrZ4yAs2Gei6ezWFb7BxvNcvDNTYK2PrQlbMqPSMoF7cODtu5pJlCYCwCyObTH8R4TqC+BBC2qa
	Cc6SMOpZR3h/MBAbmG+nQ2IGO6J8SWXAQbrLdqp9XomZe/+9CeSD/UL7vhYiDl132Bu/z24PzjD
	2dDmBMunJK/r7zzaS4cAbCGsIJLtYoJ3m+N/kO/PuUQFYJWL4x6Yjl6yRX0XXfgWP/dHu+UNypn
	HsozC2rS3Tg8QWveYAEz9xLVg7JdmBcFkpzK3cCCzSFlwB+ocogVJYWKnInldHjLvnmwtFcj+OS
	uJKPZOfohaROHkpgsPQOywh1cKm9Lrh9PypdI/pMYWwJtpPrpMTmZue7VPF3w4lPUJuQTP8cB+i
	9NrfcK6Mdn
X-Google-Smtp-Source: AGHT+IGvP7qyO0HnOYgIrqsR1tCq7v8SPPc+0oaPxCyo9LmnnT2EUbfewP1EBNGtokCHFW/EqQPUvw==
X-Received: by 2002:a05:600d:4352:b0:477:429b:3b93 with SMTP id 5b1f17b1804b1-477429b3fb5mr11106385e9.18.1762025260621;
        Sat, 01 Nov 2025 12:27:40 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm61873185e9.11.2025.11.01.12.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:27:39 -0700 (PDT)
Message-ID: <a63a71f0-8003-4390-8bee-5cfd298867a0@gmail.com>
Date: Sat, 1 Nov 2025 21:27:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 11/12] wifi: rtw89: Add rtw8852cu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8852cu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.

v4:
 - No change.
---
 .../net/wireless/realtek/rtw89/rtw8852cu.c    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
new file mode 100644
index 000000000000..2708b523ca14
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8852c.h"
+#include "reg.h"
+#include "usb.h"
+
+static const struct rtw89_usb_info rtw8852c_usb_info = {
+	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2_V1,
+	.usb_wlan0_1			= R_AX_USB_WLAN0_1_V1,
+	.hci_func_en			= R_AX_HCI_FUNC_EN_V1,
+	.usb3_mac_npi_config_intf_0	= R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1,
+	.usb_endpoint_0			= R_AX_USB_ENDPOINT_0_V1,
+	.usb_endpoint_2			= R_AX_USB_ENDPOINT_2_V1,
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
+static const struct rtw89_driver_info rtw89_8852cu_info = {
+	.chip = &rtw8852c_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8852c_usb_info,
+	},
+};
+
+static const struct usb_device_id rtw_8852cu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc832, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0101, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0102, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8852cu_id_table);
+
+static struct usb_driver rtw_8852cu_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtw_8852cu_id_table,
+	.probe = rtw89_usb_probe,
+	.disconnect = rtw89_usb_disconnect,
+};
+module_usb_driver(rtw_8852cu_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852CU driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.51.1


