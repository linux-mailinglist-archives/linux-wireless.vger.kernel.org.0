Return-Path: <linux-wireless+bounces-14412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDCC9ACC22
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7531C20835
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D41AB6FF;
	Wed, 23 Oct 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSWK9P1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FF1AA787
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693218; cv=none; b=iFXsXYznA3kGKBbkNEQg+J/oIfBlOmEr+xfr8EU2HMnYIEkdXinlbBNNFZi9clEiNe2dy7iARLB2lJQKakUV1bQCz6asV0RwG5vM3x6U/vscu6A0/fqk9Aaz09cpsuuFc5I0N4Hmme3ZasJt17zw6q+4sbYJdliO22/vN8wxr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693218; c=relaxed/simple;
	bh=kb/iKUzdTcyFItof9fnJ8C885x3SShfamtZRWuBok6Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nvSGRBCzFQAAvSTJ/YpSpzK60N3lkrH/oo8WHqsUHlyhclmZ+r8JI/b0hRyNpxJbHxZ7VQyoe3SgD/53BSSveWRxjdTglIW5yQgzY28OC5pe6X0PCNNDORZAjgxNsqtkMlBH2ZpNvI2Jc4Utzm4xK0nAG+kt+kF+0m37LSW+bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSWK9P1e; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so97592621fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729693214; x=1730298014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f/83vtnYwOI8MNLH9Mr7F/yejs600lCuRgoNhybJBaw=;
        b=QSWK9P1eWKA1546DYe3FDvScxDXw6ERHomLRmOay7kR+eVTt3Kxokg70aa26VF/QBK
         7HVptokU7wIAMsM4iLKxhKdqjDDJ3JJ3dIiGilBfap1HHdoU37lEvgkOYNJXohdIHBbL
         h0L6e0XN4q0kx1YAg78zTIi3CZbBZJyIzjW4kEfICLXzM4GNx/1DTHoC1cZscv8PS3hA
         sczLVQCpvetvv8/zZO+IlUtUBTIqV786IWP5z/vXsX++BN41MEj5Wie5D8DmUS26a0At
         THxDBL7b6DJe8bwT2JFTRW3zPL6aqaM8hl5EmRnRTZcX8Yr7RRTUDitLYXM5Wq/rSxy+
         g6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693214; x=1730298014;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/83vtnYwOI8MNLH9Mr7F/yejs600lCuRgoNhybJBaw=;
        b=rIDMb0KPskrZpSethVqSwv2hWKS63r97TKJ+PjcgujDgGh1ZS0R2Ff0a/6eGd3Dz7P
         tG8swhyp5ktq+HjeqtNCcMtq4R37qbcaAgpXyUWJFCMo/ZP4tk/4UWFbExrMPWJKZfK+
         Iu40jysfowlfrzn6W6chulDFYhxoKsHShCZBvR2D+EATW/3fUqA8yf47gUgZqHrTRuHq
         hwxXWunXn0s2MZ1UW8h6/8iYHgZFMq4gM2DmPyqRL82Qb0SrX8Mbvbqd9VuBUsdy1jbe
         BaZTLWT7gfcnZJLpY84HBjDlMIJF5hPn/5BZ1nPfPeromwqWtNKDKymALT5MTv0w4K4W
         ge+Q==
X-Gm-Message-State: AOJu0YyAeB4iNxObuTKbKEJjoFQU7M2sCHSEbj3Q4aWc0HdqUF8USFPa
	JLGF/jKq7gnnBcv0E1ainDs3eedPCnZgdn/FO5a4hCKzWCn+ut1At1L4Yw==
X-Google-Smtp-Source: AGHT+IGdEULDmCpZPZd0QXlTyZ5SUtlC3V8UToPdBf+kYbNt6UGFcpLF1ZahGLKHGtun/J7mkKH6Qw==
X-Received: by 2002:a05:651c:1191:b0:2fa:cdac:8732 with SMTP id 38308e7fff4ca-2fc9d37fd0fmr19042711fa.30.1729693214303;
        Wed, 23 Oct 2024 07:20:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725easm4616092a12.91.2024.10.23.07.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:20:14 -0700 (PDT)
Message-ID: <777df2e3-1751-428b-956f-46fc928aacf5@gmail.com>
Date: Wed, 23 Oct 2024 17:20:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 21/22] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are the entry points for the new modules rtw88_8821au
(RTL8821AU/RTL8811AU) and rtw88_8812au (RTL8812AU).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Fix copyright year.
 - Include the correct header rtw8812a.h in rtw8812au.c.

v3:
 - No change.
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


