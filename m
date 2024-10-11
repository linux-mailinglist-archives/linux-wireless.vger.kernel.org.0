Return-Path: <linux-wireless+bounces-13921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2A99ADDF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973C91C22290
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD731D14EE;
	Fri, 11 Oct 2024 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ/DmrZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECE199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680275; cv=none; b=IL13ehqYqfIrHSRltvXQ+voS1GYoM64XSnzxQxJxF7BhPaFvZ5hllhbn8cGzgmMtk9OlHADQrLDHxDjc9HBJNiw6pdCfk0VVCA1oZmeGDGGHP5GRTvslhMK/ESa+1VaShmCHkSlulj/J3Dw7ftaVoxAF8poIWy9ps9XN4D0wKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680275; c=relaxed/simple;
	bh=ziWm2+ngaUoQT2C8x0Sl5HMBA7tf02WN1FTi9LBXcBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=It/O1up+O8l0KLTibU/PzQNfshnkpFBp/WVsUhdTnHJB/AS/hnhkAU1tMUYInVXk6zikljFn0Kop33i7tA4fpWOzbnTTOhGVzDOCdKRYko4D5eGFAEx/oowzkjBD353I1AGQcyAspsZr+UOuFlnnIthx0WpR7u7vexvLJ77Bl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ/DmrZ9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a993302fa02so379848166b.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680272; x=1729285072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+ZsDva5wM9plswRg48jz0bzrVmsuPe+/kH9kb+DaJs=;
        b=RJ/DmrZ9Gw88uRlnknILkMZB4ODSyyRBWHG7A+vLLc5wp+D94h8cUFb+A/6aAzlwv3
         TTN2eJqWfN9a2FlDbJE+8sUNqUXJOpG6c8HvWPNRD2M0uUKPP5NVaiPr9BGdFimBIcAO
         cLjDxppK7NHo+ynktu6lxRPJbcO1I87ru1+p3/3FMWb8zCwpTzJoG50OHN9aPYqfVcTt
         KzJL5alPZ1UMHlQmXRnqL9lBzJaMEVffENpBjRntIqx+RaSFP4883PH3NApum0FMmFQS
         9WRQUYJQEUtbIv/hg+bO1zg08fv3Oq0VjCV+aq0VUGxGCkZrrk49yo6gH8BLZoFgIT1F
         w86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680272; x=1729285072;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+ZsDva5wM9plswRg48jz0bzrVmsuPe+/kH9kb+DaJs=;
        b=NF2YUufUEbiI98qWgj1TvQYuxYkLHmUll6FfypMcBM8J7ZZDoDDhBC2RMAAJz8kUAC
         DpmS4N5WSiZNV1RRnW8uo4hHrILVYxIC2/GSaRlgZP2s1OLCC1sb4sl70q+jsaJuhx0b
         +I/vcQ06rnK6S1H7dtMMYMBqjPwW43+MC9oyo4JHfpRI8q46Jm3P/kQHtZva9C1AXQTo
         Sd1LMpLvOn8cSoHAJ73niwAncVwp2nlD7wu3ghPzIS3AnevIu5QRu+QO2gUDrnofh63z
         iofxNUUYte3osSaXwa64iNffSvI5LiIODtpQyfW3hMxcr9KQuiIRrGCn89Ga7XVOvzzS
         hWsw==
X-Gm-Message-State: AOJu0YzSkuCOzO7cwV1PxmaLoijyEX20iR4v+KqslrUgt9yscZd7jxMf
	gHbN5HRc6I9tXDViZGjPbEICcUVaAP81znbe9eehpXsfONNnJU2Z4z54iw==
X-Google-Smtp-Source: AGHT+IFHF2UU0xm3Vr/FU3QCq4gwTj+sr7LapY4uXJKYNrJjku4PdqYyQU6QpRq9Y9MV5kHsl/YzhA==
X-Received: by 2002:a17:907:7ba4:b0:a99:76cb:cedd with SMTP id a640c23a62f3a-a99b9303b4fmr287565466b.9.1728680271582;
        Fri, 11 Oct 2024 13:57:51 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99dfa32196sm35814266b.160.2024.10.11.13.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:57:51 -0700 (PDT)
Message-ID: <45604f31-a992-4188-b8c6-2d8e43981d77@gmail.com>
Date: Fri, 11 Oct 2024 23:57:50 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 21/22] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are the entry points for the new modules rtw88_8821au
(RTL8821AU/RTL8811AU) and rtw88_8812au (RTL8812AU).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Fix copyright year.
 - Include the correct header rtw8812a.h in rtw8812au.c.
---
 .../net/wireless/realtek/rtw88/rtw8812au.c    | 28 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8821au.c    | 28 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812au.c b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
new file mode 100644
index 000000000000..4da69590a423
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "main.h"
+#include "rtw8812a.h"
+#include "usb.h"
+
+static const struct usb_device_id rtw_8812au_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2604, 0x0012, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8812au_id_table);
+
+static struct usb_driver rtw_8812au_driver = {
+	.name = "rtw_8812au",
+	.id_table = rtw_8812au_id_table,
+	.probe = rtw_usb_probe,
+	.disconnect = rtw_usb_disconnect,
+};
+module_usb_driver(rtw_8812au_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8812au driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821au.c b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
new file mode 100644
index 000000000000..730018773e1c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "main.h"
+#include "rtw8821a.h"
+#include "usb.h"
+
+static const struct usb_device_id rtw_8821au_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x011e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8821au_id_table);
+
+static struct usb_driver rtw_8821au_driver = {
+	.name = "rtw_8821au",
+	.id_table = rtw_8821au_id_table,
+	.probe = rtw_usb_probe,
+	.disconnect = rtw_usb_disconnect,
+};
+module_usb_driver(rtw_8821au_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8821au/8811au driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.46.0


