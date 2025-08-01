Return-Path: <linux-wireless+bounces-26103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC707B1888C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9913A055E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF36217727;
	Fri,  1 Aug 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPfufcvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2F2036FE
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082401; cv=none; b=NSy0jHUAhlttkjdQXtCzRUZxpAyo3PsMWmZ1PvyYQBihUX9gjV8f8VKEHOycKNj3dU3tNRQFVtDfegvQozJMjF9GXdcENFV/7WYQz9ldgCkM+8ELOAaSC+fuQKReNarMhktttYxXEssvDpQalrXglftScxHutD8CME7si9aJ5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082401; c=relaxed/simple;
	bh=5Sz0KBRkIl6T5cOFKCo/jfWkuHM8BmWxaho0EKiEU2M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hGalOQbZid6kDhjAhRzr10vVvnNPrMPcqrcQ451hPMc0Y89ah9HyOhlXwAjHGsaWHchw6KySQiGQ/Zm22TTw3ZUv1IIFFk761kiXabC6En0Uhq0ruYPlp110eL8I3T5m3DGEHWj+OTjNJ5eRoJrUTee4CAAcK4p/PKzbCfYLv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPfufcvs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso1770387a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082398; x=1754687198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9efBfS1jathstkedLXCTZ+LRGP5+/AFrKfki1cV20k=;
        b=FPfufcvsZYEzcBBJyYT0ecaCO14HkRl5E+Uzg//rbvMtl6+6quNQuGT1rQ8rbbWlV7
         clQjT7cwHZMCdV17Z+hyQwVnmlLDA5ABhFgUs5Et4ESkpHsKh2uYtmXb27P8SKIXnvob
         XjVRicgH8xUE32Ve4o79L6O+12zoWz0YF830ct0J3xNcwue5p4WngNiQoQdCbgKRLGmq
         nJBwqSIiVrlYkon7+DL05/Zw6wLuiVKWAd0/c8p6CxZrqlWkDbm9CgItlORjgeWRA7l3
         sTt3+mLqPVkOKy6tbrY85Aq3+JwNj7W7Uw02yqb7wMbfacn969hQ1O565Tj0a3dulAVg
         ZtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082398; x=1754687198;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9efBfS1jathstkedLXCTZ+LRGP5+/AFrKfki1cV20k=;
        b=EZzzW1HT+Ayt1pgGxygcruEoywbywkgFh40gh2utsnIT1JkIHg9ZN+hZUjvc0uV1Zm
         RCCWjX0hRsBF1743bm28KsI/L7OQ9j/A6inUyavhbYqLOtOEZtnZTwm0YukSQKPq+BxG
         rS99OnaYtiGZbcStnAKkv9X/X7P+wQykBG1ec/lpvXs684DnZ6mBUw4YKsPqhflJRmZx
         CdVn5+MDSmYGi9ektay5X/Q24W5pBMxY87GFMRdDCI0D7e1BUuliFd+BDZw8vQSkFgQb
         c5BX/flQ7sNTBuGfkvwPaqE+97b5rR+2o9c6awZVx3tuz7KIVkhyzLfkQTncUEVJIU3I
         4apw==
X-Gm-Message-State: AOJu0Yy8c7MvIPrX57r9T556aiYuh2VSHTkS+YA9gU51EcmgX4I2pX/N
	goNIU5UajvN8bPZCAVNG+doK4mM4Y0VQah17J+xEPcfds5pvSl13nNJ3UTnvvA==
X-Gm-Gg: ASbGncsPxLJC4Wpxja6smAuIYmojtx5yQ5fZ6+ukat6tZy4LGB2mrgZn0ZcWITd78un
	eX8F7/+tbxwlvcSh307jCpyn59jEsSFnq4RSDRF6MFa0CugMRsx5UOrk9VdGPJ4Z1P7ntf+fqy1
	S+1drh7qZULOTClrm0/xSVcOR0c2bPr91MeS2swBVjpQyC2YfmfgH3unoYHV4JRjXilva9IN9lY
	te+gT2lsjtnsEo5ag6t325Za3/AnocHj1PD+BRqRqRtuWzRUFzAswoiBsNHX4/m3dYdgFhhjyAQ
	dWohEAagIPfS8SYqGH+nFPjoXwgk3eRGBIJSHDqHarTGEVMhyC/ydyQlr5LfPao+fyS1NOGzSLW
	M9YBRZTpRoKfFkAou4Gfd4CIYZTkjvZzxEGf+GMmW
X-Google-Smtp-Source: AGHT+IGfXi1IKHeIcIlxZEifIediHrhn1x/uKLvebSY49bZ9cUZzmTeKqf/jz/CBItZ7PNcOUA2pTg==
X-Received: by 2002:a17:906:dc94:b0:af9:3cd7:d380 with SMTP id a640c23a62f3a-af9401f7d2bmr116445366b.49.1754082398424;
        Fri, 01 Aug 2025 14:06:38 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm332328666b.90.2025.08.01.14.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:06:38 -0700 (PDT)
Message-ID: <d48aa985-2955-4ebf-ac9d-aa384313eb6e@gmail.com>
Date: Sat, 2 Aug 2025 00:06:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 10/11] wifi: rtw89: Add rtw8852cu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8852cu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 .../net/wireless/realtek/rtw89/rtw8852cu.c    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
new file mode 100644
index 000000000000..be9f9f5b0b3f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8852c.h"
+#include "usb.h"
+
+static const struct rtw89_driver_info rtw89_8852cu_info = {
+	.chip = &rtw8852c_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
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
2.50.0


