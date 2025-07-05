Return-Path: <linux-wireless+bounces-24845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB392AFA18F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821A87A5ACE
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34952264C8;
	Sat,  5 Jul 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b45safWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63022576C
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744340; cv=none; b=dAq1Xb0uiLTUKUZcJVnHdDl4SMHmBEQILS1GFfq7Sx7i0YC4jLpjo3wigCcdNW6cn+Wx7sUdW32un20TmsTKLaK6UeKqaSxs7wHMmHitg7kp/3GebaTC6DRH2pm2y7JFKsIIsF9JUt//ZM1un3LKER5nLTyMJ7AqKChX3Jk5yN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744340; c=relaxed/simple;
	bh=npGWutxNGZfjPpg+c9yjE5lmU/buz0/KM+q3cZyixck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DrlWeudPfeh5LfZnuRl4vIFEXiYw87awwIDiqsuTtTcROWIF2ahFDFG06PpOQ2tx3wxpKa3dXst1pQWk/paHX7uRZnYuduG16Mb0WmScQsrb9tfNwlWUlo5MzuSPZAoIwCyhAE1He7PVwF3VS5+RdbRMf+vXJm85na4g6fqF8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b45safWf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d54214adso13049105e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744337; x=1752349137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1k8zwYG8h8pAG/9AhAsJV2XjxQtthCOIhVPB9nz+82w=;
        b=b45safWf2rptgNCOSTaLJf3Pb6P4EgylfWMFQbfHYuvQ74wmWWIbJd3tbWw2YNitAY
         Y+h6ev85Xrs8vnjvFqjNE+UgEhzpbZpl1X53Y4zGhlkN94rocQ1ztwfPYO1ga2gDq59c
         VDny5gSbMIVqwpXB2uH0DTPfD1wwdzIIjghRgiiURuDhMbf5a4QOX6aLFLazctSg8/GC
         s13kPOdYdYf1xNndMLEbCAtrKjHWRP+Xi0jFiS4iMX5Xd9VQ5rhtL8VIoTtlrBOXX/E+
         QMFtfrK6UArtVi+x7yaMagYTFG1Sn/8CRhFOxrZZIWFo2CCZKdng+7FNnO0WhKQVgFkI
         OeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744337; x=1752349137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k8zwYG8h8pAG/9AhAsJV2XjxQtthCOIhVPB9nz+82w=;
        b=cqtgmjKJwJePIhZMVHUF53n2SB7C3vdb8WXkmKZ4unCyY8KtHmHUUtxK29y3/6VmE7
         ibxXS6xQ18K+AIFRTQdRxA8xyJosTkLOkqgWO3noCNm1C4RZZzpwEg8NV8dscmYorONE
         +VRZCwdc9J7sSdIJPNPPX356+fBcluK7rBVbo6SBYK2U/VOXuoIoXSGOMVqit/7W/jCZ
         zuBYgM6qCCZ+2jkUJe0NNnkJoeuxgmqEZWcyRm9czE5xya7ldw6h1gNRrClyl7ORUQpT
         DouXVobViDqE4n7GC0W89Jai9Nfx+6ww55cotNOhfpLrwwtezePj8ID1/FQXAEZB2VZ7
         EajQ==
X-Gm-Message-State: AOJu0YznluMLI9efgPN/F1p8idRs47fAAAZ1A0qCBwCqHHFMA6afB5/e
	gZX+dbGRhnATkTO48SqjekaPQ4KarA/zEtZ+l1+rOuKWJymEg7ywDV/cDfpe6Q==
X-Gm-Gg: ASbGnctoaoKub1r8yWkkPaJZqVGGAn840rOrVuVdUDAICTz1Lbnr4mKspmiV3r+k86J
	5LggFtXI9NMiOsaRaiHIWpqFfnjuDp2gHlXA8zV64d7IKa0DeUpSL02D+8EE5ipO5j24/2xPhdA
	b3wtEthftZSRZQe2NCWJ/r1QBw0QrpGne833cNutYHCp8e5LrPY2PbvLQzw0fsHqcF8cB7mKRGI
	eRgAPgtsO5fu859rg+bqGTtSV1z6A0p5j9iSS46ihSjoEszM5keVnReK9vOOfqb42zEfgMg71gX
	eeTKp1EhWGhXwaYoPn8iLy+yS+uH0wlExRyrv/fYKEMD0I1jNqHhpoZ1piSYb4jzVd5sPg==
X-Google-Smtp-Source: AGHT+IFJrflJgMu+3XUk9TAmUKii5KlPtbE9OltR1C69RlyeobLZTAbSCweJzfN+bDr/G1sI2dxEdQ==
X-Received: by 2002:a05:600c:1f94:b0:454:aba2:c332 with SMTP id 5b1f17b1804b1-454bb82de10mr26903725e9.29.1751744336950;
        Sat, 05 Jul 2025 12:38:56 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba77sm5802618f8f.17.2025.07.05.12.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:38:56 -0700 (PDT)
Message-ID: <bac25b31-8146-4738-b8f2-eba66c51f3d8@gmail.com>
Date: Sat, 5 Jul 2025 22:38:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 5/6] wifi: rtw89: Add rtw8852bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8852bu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


