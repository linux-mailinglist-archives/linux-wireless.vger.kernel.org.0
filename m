Return-Path: <linux-wireless+bounces-19967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547EA55BCC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DD37AC035
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8423AD;
	Fri,  7 Mar 2025 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+3GNyyc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F19D7F9
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307144; cv=none; b=ZoSuIBAt0KVEjwCQg4A2R+msypCl/9C2glU2e+XpQZCuNVg7gzOpg0Ss1T9ZERp5k9/aQVqwU9/kIafIDMFJcNUGkMpNqAZujlrcPnh7WCwp2HZnyyULJjQCrjWcJaGLIUyeb1ijWAQ6E4QPvPhJy3be6JBcq+Y8lanIwZRUPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307144; c=relaxed/simple;
	bh=4ALVey5mTmiMwQnGB0w7qD43XYEMUPdhoSXiuHD2qPM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gxubhceVFAy2xck6oQ6wPyQ5+eZDkBnfLxtCGRFnKiqdGyGTj6ULkJnKd978f4xgYvLPfHVWmlvzVA0EFsI0yFzgdC717s1MRwk46agJvhW/2mBDYJECDqtZOLqVHWUobOU4wqR9ueYUgiajL79MU8ShMchIPvZOXdtyNNuwWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+3GNyyc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb12bea54so256501566b.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307139; x=1741911939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wdq+Anh04Ph/jk+gJQrySnUK/6R1CfWRhVG9w7s5q9A=;
        b=P+3GNyyc8EcnINAw+M7glq4p1P00NZvuh9VBKt8K6EI4w7wUdu9/MEwxRuGMTwTqIQ
         z+XOyPGWHyf+BY5rd9x2MpI/a10WvTzHvKe0eA9vcJgrz+Jxz39p1h4xOSnRIsYm2j7V
         O/VYqDm0ml35+J8n4vNqd9K3ppgUMdHaZUX38+IlJETRYSNkqipVPulGuA0gczHP5udx
         HrU+Ufc7mo3Um8EDjfAVA/l/PnJEX3+SMQ3Afw9DacRM6xhYvEIJVR21EwzHDEuRHGCN
         PdsOlmQcM8q4Gb3737U5Gwp1C3deLwe/ThtTQyp/mpWkwbA6FFteal0nC8Sp5p97n1nY
         Ly6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307139; x=1741911939;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdq+Anh04Ph/jk+gJQrySnUK/6R1CfWRhVG9w7s5q9A=;
        b=ODetZZnmvqja4L2kTq8VPvpV6ZahduXEbGGVlYa5pESn2hnhwjAaAf6FhWLpTz8jDI
         AJsIY5aC7hjuvda5MS5x5/QswaO6peds2X+IlULV8+TCG90NupWgvv4dndpsYYoWNygD
         8RTCxnwbxKgn80BSJ/GL+lVFC2sx2cNF44Gd5gDxfQnfe3xykG8rYihlozCZQ932rgdJ
         ZYlMkJXTx5TXWiXCiBNr26FMgNJ4+BRfov9iEuF3T9nAgNOy0nn9OgMr8Z1L/ydIGfyJ
         BxHYadDcmRj8H8xZQawY2GPoICffjX0MEXLYbnfB558qeNSST0cZ2bqtE9nVcZ3icgqu
         BDWg==
X-Gm-Message-State: AOJu0Yzn62EpOTj/X/fX1of2XjDM3jEGxvhnqUDr1Je8L5IZwPYPWVRW
	H7ojtR0lBJhPCvnv/zksyIhjn2gI07GgsB/SQxuGzdGP1gdjm2K6CLBO7g==
X-Gm-Gg: ASbGnctK1T+irFPxQg67vWjFH9bKbkdQ0aMBLXW0friYDqcCy6bwO0ObHnX1Mny0cn1
	5X35UgK+dq1VXtz4+m7wbCDyMC9qBxU/dU8wMeu4JWTIbNjAPemEbOe5kb3tSKuiG1uw6Sgll6C
	cuKq6Xzx220xwPbqhcITNt+WpAVahFqR6zgno3LGTRj3pVIQLTRoYHboflAdw9XOql474U4xT58
	byMH1JCEo9fbMltwDZWbwGhhaYyMmS9dRwdEkZIec+T2THFSp+rgi9ps3MvT2wByvfLGhQ1hHcv
	cr4tybpEjxd3pgBSIaq3OVINO7Vl0yEjEt7UUhgW2rPxRgPIXou1lA==
X-Google-Smtp-Source: AGHT+IE5ezWsAbxabWwB+OYnETAmtibVdzXTRnlrph4TlyaDZescjQyEYAZzrtJABIz/9+92eV2fMQ==
X-Received: by 2002:a17:906:dc8e:b0:abf:67de:2f1f with SMTP id a640c23a62f3a-ac252ba467fmr114651966b.44.1741307139347;
        Thu, 06 Mar 2025 16:25:39 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988c542sm176722666b.134.2025.03.06.16.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:25:39 -0800 (PST)
Message-ID: <71457787-5a9e-4ead-a62c-22ca44e00b89@gmail.com>
Date: Fri, 7 Mar 2025 02:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 6/7] wifi: rtw88: Add rtw8814au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Language: en-US
In-Reply-To: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new module rtw88_8814au.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 .../net/wireless/realtek/rtw88/rtw8814au.c    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814au.c b/drivers/net/wireless/realtek/rtw88/rtw8814au.c
new file mode 100644
index 000000000000..afe045fb84de
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814au.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "main.h"
+#include "rtw8814a.h"
+#include "usb.h"
+
+static const struct usb_device_id rtw_8814au_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8813, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x400b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x400d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9054, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1817, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1852, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1853, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e66, 0x0026, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x809a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x809b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0106, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa834, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa833, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8814a_hw_spec) },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8814au_id_table);
+
+static struct usb_driver rtw_8814au_driver = {
+	.name = "rtw_8814au",
+	.id_table = rtw_8814au_id_table,
+	.probe = rtw_usb_probe,
+	.disconnect = rtw_usb_disconnect,
+};
+module_usb_driver(rtw_8814au_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8814au driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.48.1


