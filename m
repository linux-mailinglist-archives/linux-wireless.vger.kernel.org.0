Return-Path: <linux-wireless+bounces-26717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 117CEB3881C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CAD1C20C37
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE428F50F;
	Wed, 27 Aug 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk4+0MlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8A225761
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313867; cv=none; b=tVOEDaQfPmwugKWTzeCQNcPgp/kRV0yAcNoSBSG/Ew5nbs+Dy6qdEwwcU352XxzIw/HhNYjggqp3vge+Z0CtPimfMow9GI0C9j/v3Z1hi32/5pAn1r1ivOGSxwRHCPj8HpExYM5Eqb5iRy0hj1HMwk1kXep1w7FhzZfOPvy5cMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313867; c=relaxed/simple;
	bh=vPUD9JjpXk1M7Sn7o4C1QSDViHScDp4GWsIqSbmuq08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AVwtrBESu0yIZilJHusJk/qd2Ca+tFzo7z5qsJjnKYJ+LmmbVJ/pwwYStdQCft92kz9AVGwC0rupjar4iRI1Rs4rR74Y67AJ2JuMGI8alA1eWZPaHrfDqt4YVYkY05WT0nQDxo4esCHumDzKTpcdhWDrADuybmBzGcwIqrtA7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk4+0MlG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c84aea9d32so16805f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313864; x=1756918664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcChkz02eSHU94wNpqclJxj69pwxIJmDqHbDZW/keSQ=;
        b=Vk4+0MlGPEu4q0keljnjpD+Ai8gqx8eU2FtaeNDBAXgqZYGNS8DX4VjqOe2y9Lagrp
         v0gbcf8muMsRIxeuMWQUZp7kNOxm5Z1O54Qzl6bPeLKXzas49lWzUjfUdo9XBxNz8J5k
         v0lFB5iyY1mkhIc9kTDB3oEsLbrb97zHzi2klMcxAZxd97CH5a/99rrVh89vyaceDR8l
         pRitnN+b/3Q/O96SIMTX9r7jLPqvugjL1daAOGFI8S0YHjAA+xk4kOuTAYJ/0yKz5BGz
         dExhsOZ/tPhbuNlYM8dotUeyW9T+Y8AaQlIkb26cCvksMCGooO3Ffk+ihmzIAH5XJLmM
         2DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313864; x=1756918664;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcChkz02eSHU94wNpqclJxj69pwxIJmDqHbDZW/keSQ=;
        b=gVHz9T0fmmktrK2l6QwbXfH1TC1xBu3xN9qiHGwH0Mvc8M45XkYHRgv6l9ITYMht7/
         gyDS2w5A8XibGnRg1X0NXPDs5aIu+rILgikjQBa/1Ko7Q16rT9iY92D8uGPIxfPQD0KF
         OUlWhcHroBysJRLARBk9lemcbXPP6b7GqOeLNYAeVuPZT+9vXRVlqnN40ttvv/o01xEx
         anl3MKO1SMijPwraPXMwl4nrhMdNahyiBhjT2PnVECZcHAzWt4nWt50QRnw4luM77mRw
         Ov7Tm14TBvSY7O0E2cDymcGtPo6wwU2z9tPHWs+j8UsbVulfgKnNN5FGr9LqyMrY58O4
         g6Pg==
X-Gm-Message-State: AOJu0YzWWZ8l67A2aLGv+aUO+cGHhUnpE6VjTJYS8p+ubKam4Y3yrhbv
	9S+IugHNmemFJuBnYexouPJJno7O0jLjE2rImfSdepUHskVolKzWoBp1I47KAA==
X-Gm-Gg: ASbGncvtWorvD9y5zw/wJxusozjlFE6Nwo/OInw0mZz8QQ4KzFn2pcM0QRD+BX0Nrxc
	9BBG/MAmRNdDzS9gKkz6U8EHWrzPSh/bc8nUvPZNyWtkFk1wsT8X9B4wWJFq2puX24oFyAIqqMl
	75G7JxZjTFQFBYOUNC1Co2NUa3VERZIQEXe1mcR5tWQCcwd2C5ssrSuaRJ2/t8IsNK3IvCZCP0m
	KLhO5mSJig1BZ2GcPkHWhvD0u0D3eqioj0qVcOo/GEal6mNNhV0GMi5hmK+mGoFEJ8B+iDeJre9
	NuxnuQPlmnH0sqdL1pBTORbqyN4p0J3PlMImRamXeDZuCA4/l2zX4GLVxEhlklwr+qFdZomDP/Z
	7xvL9KbRKKqcKIbIk20FS2cE+3JXhpyz5OsC2Vzwq
X-Google-Smtp-Source: AGHT+IEFvDiFFxqKQHbLuRgjao0RjHGvjji1epxlvkYDns4+fXxPn02irXYBxsAXzD1gXZo6zxwyaw==
X-Received: by 2002:a05:6000:24c2:b0:3ca:43ce:8a60 with SMTP id ffacd0b85a97d-3ca43ce8debmr7889228f8f.56.1756313864365;
        Wed, 27 Aug 2025 09:57:44 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc56bde919sm4598908f8f.59.2025.08.27.09.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:57:42 -0700 (PDT)
Message-ID: <cc8dcfb0-dbad-4bba-985a-8ee06cce8b95@gmail.com>
Date: Wed, 27 Aug 2025 19:57:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 10/11] wifi: rtw89: Add rtw8852cu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
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
2.50.1


