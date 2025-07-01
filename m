Return-Path: <linux-wireless+bounces-24737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7923CAEFF17
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7899B3B32FF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20727C162;
	Tue,  1 Jul 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq72CEsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DDD27BF8E
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385882; cv=none; b=cO7qzzztrwpmYwWihLvcjpo71dg2NOWp7ip3ZQBSiza1wu/YtzkaDac2GoKBlBRLBMOv3USd/Nzs6xkbT9mhFNKGzgM2p8whKSWWUbs185wHI3sUDDugr2YgwZDUqR+0tftUuVxOHoklItzUVvbIbYnhnNKMGTcoqfHFAkor1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385882; c=relaxed/simple;
	bh=8yQdklObKl7CtTWda1zxZWJPiBjhJjOnr4Ituo8w3fU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=og0GOQC3J1exxgyoRNULYNqOShNMe3e2tzjbggF/FwgIaFzEP8XwKf8sG+1fRhMZwEwnMSEnyuL09qgxSf+qWtfqp2wWWnswE1CmkYqidwcorDkXJXrwYDcSxfeBEalXr0xXY/twEbQrVlvU3E7/1jEQJLwmLGwcv1amTmHcxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq72CEsl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45348bff79fso34142055e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385878; x=1751990678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mobjiY8tKuhYoUuvsNt8EXyT1YxkBCV9Q1ZOYLabZn4=;
        b=Hq72CEslKW9IMav+IR9g97bArC8cLiX11biqZADJYY4enGDmxPwLuWYbsTTVyWRmEk
         iJUi5u0oix9HLQkWBSRXb6TmZS37IZ4efJ1btdOQjg+3p8gLCNB+r9fsYEWMK8F97Ipn
         Xy0h4mJEeshqj3k7NJb4leRwmo/gSf9HWSNXM+YSp6CWXkKuUFqhFoOgvoHKHWUcvNLt
         /MDkQz3qfm8xBTpOZ2LbTiq8uO9xSmIH2jFs6N7bb0nMVANKR647fSABEVyukovMKPa2
         5joSJSCApwPwatEI06uDFbcq8EHnB03GtgVga28LNv2UlNZYY3tVUmhGH1m2MgD3we7O
         SjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385878; x=1751990678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mobjiY8tKuhYoUuvsNt8EXyT1YxkBCV9Q1ZOYLabZn4=;
        b=VmDdPgjYq1MAhbL9LhZf1H+TlKFdXgvTEg2kMIPulEZTNb8NncXVY8vFvSNrgufWWF
         orCyH+fd0JJFHJMR9I6919awNWmhkNz8Ze/ZbPwLzHYyaRbLTODV4lzGSqcjaUVP2DRT
         btyoJeZxeizEC1bc656T6mk+0Lh2nC8go5DHnNOBwEHL7k6tObRShubHdXaOdLFL6gwc
         sig6FwWhZeAzqRSoDenXgFkmEX5yXKJFV3Unu2rL/0OMT5/1bA903qQPZklM+bUpjgRz
         awt1ftiQSTPMNd0iAumTFWNJAStauq+aDit/Hth12JN+0kqGB+DgH5UNQ3bGqGlbjVYi
         DoBw==
X-Gm-Message-State: AOJu0YzBEGH/nCJEa2A5N58JaQkzZHVqt5IAVfA619YvmcxG1NthlyIq
	zGycdzmJRigiz3rwgsmiofrWkyM3qXrI2Ef9vkx74T+4Mqrwuo1zX/+VLN4zIg==
X-Gm-Gg: ASbGncsa8wwjcTau34x+3wN+2gNbamSZ8bdXq43wabizyExkM0YPCYJdkcQT4lwNbN7
	rG+zu+OCGx/Q26ivEftf032ZcqmSZU0IbnUBCxAmQXgZEX0aIzWtz90SrYosy4wRrBleb9o9bIf
	E7I3G2eqnfKF5dn3pg8hlMqTX8qcbL441pIpWmO4ZyHsV6ei+Hghor8Ad7+DQMbLPhAhjRD5wAa
	FzVqcYXrXMG0bScOYmhNG1vZEDddCNnfQchwdTzLsjXXHzJNYeJKyjgXV2vxIzpkfzvzI5sCm/+
	hyxky+En+Y6iM+TVEzWbkR7rs5Q/NzsNHk85gINxmsv4wOO9QzrhyDZBnmiR0iFoF0aukA==
X-Google-Smtp-Source: AGHT+IFJWheEGgZEoVHzwAwEd8O+RZNJkQQ5arfYIUg8ui+BTPL75KQlWQJX1WUEseBWnHxTQ8R20w==
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-4538ee4fd6cmr201577725e9.4.1751385877837;
        Tue, 01 Jul 2025 09:04:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7098sm13390116f8f.4.2025.07.01.09.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:04:37 -0700 (PDT)
Message-ID: <8297e328-446d-4620-8f49-eefaaeab5bf2@gmail.com>
Date: Tue, 1 Jul 2025 19:04:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8852bu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw89/rtw8852bu.c    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
new file mode 100644
index 000000000000..b315cb997758
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8852b.h"
+#include "usb.h"
+
+static const struct rtw89_driver_info rtw89_8852bu_info = {
+	.chip = &rtw8852b_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+};
+
+static const struct usb_device_id rtw_8852bu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb832, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb83a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb852, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb85a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xa85b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0586, 0x3428, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1a62, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0100, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0108, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0x6822, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8852bu_id_table);
+
+static struct usb_driver rtw_8852bu_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtw_8852bu_id_table,
+	.probe = rtw89_usb_probe,
+	.disconnect = rtw89_usb_disconnect,
+};
+module_usb_driver(rtw_8852bu_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852BU driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.49.0


