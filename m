Return-Path: <linux-wireless+bounces-22415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7DAA894D
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C133A6AEE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A57187346;
	Sun,  4 May 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpjfSh76"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692623A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746392080; cv=none; b=Fv6r6eLv7SjzwyCFYS1pUw6YHsHtREDk9Njpg8H1LmY71Vr2KyFABb7mMbnrBTgyT1rPb906PBA6vQww8SgQ79lXOtHdj/n76vaZmz2G0C9YAWIKQv5MWjGt6lntugWp/hFm4pItLxKHWiOyqMYqqIA0TKIIZmnVqRj7kPkYars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746392080; c=relaxed/simple;
	bh=phLBdlqMG9IQDqthl2P4yhU56D95r5yIFEVmoWeC2Dg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bvF5QxNh1CKuZoJEn3oBPmlYQ0a8b2yy4xV+D4hp/7NdH5eIjg4ceRKPD1wg3ACVRrpcteBCOxruoAN528CHzG7uR449Pbu54UMttSgYRoZsOQuPwivPMyQ5sOqYSTf1dTQVTvbkUY3JjgOJAw5dcIK4S5HZgQI6ssdFC1GExtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpjfSh76; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so627244166b.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746392077; x=1746996877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J00bcdMjNm3bZLG805/0ATu2XuNOjwFdtGvMXrn2H2c=;
        b=BpjfSh76+lEfqFC0P9L/ZLcrCxFKH4voioojBjMHV9UKDDVOoLcoOPwxQa9MarTleg
         o+d4GGKpsh541KrWWjnMdP8fFjU/Cb8C9i28oC7vBZW/R96mTWss6u+ygTyHeztW14XR
         I1X1x3DtTQe1Kck9Jy+QXf8N01gX7u5R57twYomMMHksgujr5Xc/GA919rE9V8PC1Gh0
         3EuPO5BpA3/cywUWZ7dZcjsuK53GQ6+SaXSa4yPWH58uuiKLYY/djZYzKvSRoi80MNCw
         rAgaCUczhDjpBj219mNfbbyquVqHEBPdLWgeM/zgfG+lrg3r+Xai3ELi7BmvuxhatrDM
         AIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746392077; x=1746996877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J00bcdMjNm3bZLG805/0ATu2XuNOjwFdtGvMXrn2H2c=;
        b=XjZf9mJ32zdDCxexk1DCI/1ejl0GJuX1fMtCxstV3xwGTbeAUAEgRc/ryBQKjyi/EY
         EonFmRe5CLplSxgQJI69yaph0AsIMCtsHgT39Rxv4WddhaWFeFpGEcOl0KAty3erKU0r
         AgWkivOsXXw0/gi+HTblePR4S2OjGKBZxLLkPdyXcZCo73PpI5a2Fn5X+D3oU5kx6Zqs
         nf4kAW0ygK3zjNaiu/E25koK3PHiflHV4Ch3V9741wISmxcVgXtJ+F+xDnEPwmDae1in
         qiDxb3FQPhUOsr93VXWBQ+eQx1Ef3atXd0gmh4CNRgBUUMt6plDNCi5TqvdBP4g6/hrU
         ZEBQ==
X-Gm-Message-State: AOJu0YxWwinwAEO8mwQ9qciXb+zKZQNkWUuoB8Rq8fveshEtEbJzMJ+b
	2sPz32ZpuUJMNxfs9kCH07WTyDok0WB2mYx/x9vFwyyWeM1PS5/Cnq6mFQ==
X-Gm-Gg: ASbGncuQJI1g1Ej7Vzy8JdHWdh2eRViUmVzqaZ3/TUukT2TMxRbQqWMjKAXwo8gxWLk
	aTTkw65PJYyr5mDqjHD2+k/qorCmuY2Nq0u/wVJXO9eBeQFFrt/7i9SaLhQQMY2iJ/Zgw3xo+36
	rW/4yGloi4aP+eT+0c8lpm8Ag9H/TyoEUc4dvscnaoKRwIc7nbkG99161hc2gRxShahVRxHz31l
	pRxUrqWVgEMPa/LlqhCGBv5bxJT024lm+tPhn3qOixxRcmNVrfWpYqjrqvjpKqp8abyP6sxu5N2
	G+05DuY0b+/JCI/NcM4yOhNMfXTGmiyPaHLWKwy94Vyc0M2W0g==
X-Google-Smtp-Source: AGHT+IHzP8qmscYIE79Y2MWXHtPOuYHlhxcemVIEpA0vDZVc5t+m4IUXEfm0t5O4B9GBbRaoSwQtNQ==
X-Received: by 2002:a17:907:1b0c:b0:ace:c3b7:de7b with SMTP id a640c23a62f3a-ad1905ed97cmr667503966b.11.1746392077036;
        Sun, 04 May 2025 13:54:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a2bd8sm375741066b.57.2025.05.04.13.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:54:36 -0700 (PDT)
Message-ID: <f404b504-6acb-481e-b21c-ea2535c3b1e1@gmail.com>
Date: Sun, 4 May 2025 23:54:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 12/13] wifi: rtw89: Add rtw8851bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8851bu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw89/rtw8851bu.c    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
new file mode 100644
index 000000000000..059b9b757698
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8851b.h"
+#include "usb.h"
+
+static const struct rtw89_driver_info rtw89_8851bu_info = {
+	.chip = &rtw8851b_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+};
+
+static const struct usb_device_id rtw_8851bu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8851bu_id_table);
+
+static struct usb_driver rtw_8851bu_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtw_8851bu_id_table,
+	.probe = rtw89_usb_probe,
+	.disconnect = rtw89_usb_disconnect,
+};
+module_usb_driver(rtw_8851bu_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8851BU driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.49.0


