Return-Path: <linux-wireless+bounces-14748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0D9B6C19
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD63B21010
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8E1C9EBB;
	Wed, 30 Oct 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3h42dBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E51BD9DA
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312975; cv=none; b=LoP4A8IfN/QwUUJ9oLSixwWjafYDOjh0tTIBMc6DCBSt8Vjxov6bIANJDeJg1CfN1ch/W06ZjmuGgXnYPzRBP8LvpqC8LyrVHsZxwtul1zMj+CWFatpRgwl1n86pkrJ7sGonQRSldj1SVyJH0Up9kFgW48yWmIroS6bmp2r5px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312975; c=relaxed/simple;
	bh=OsGcTja0wrrtqyjvDkRyztQ9779ISddz+34sASFVh7Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pnn0Lp43WlERL+9MG7uTzuC73vrMQqQVN933IRoyAYE2Dpx3glQw+elN5fBcgCepliz63lQAJVDSmGMirfnvUmiGIgbr5gLBEBhNXIlYtI5sVNEWkKK5cs3yuwFMXT3cyFsAqPpWNT6A9o0uzUVBwG8HLW751+lr0znNcDlhkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3h42dBj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb587d0436so722841fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312971; x=1730917771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+1lZ4giOmpe95+Gq/i2PbzQXe88NZzeDPUC5J9YVC4=;
        b=A3h42dBjcRmyLPiZs/Vy+GlqEy0IPqRKxPlaA+SInBhVZfDyLSyl3tiPZf0bqqsRrt
         Dk5UZaS7M6D0n+DIsOzfvrESXM034jGEpN6EHcMc0qzefvmBdJ+zytq+Bi1PBtgAgNDY
         O6BJr+r3O56t+AlF4BDM9ZCY4fjsVdsxhyBASHIAkDt8n0qlwFwr1YNu5gPFV58ThFQQ
         uGUDsUtJYid7Zq4ck1EPyAR2uHJClsWq60uZ5KUWWD4rWN4yEwF0xw5FZMGTvf9YAuPu
         wDfaaJM2khxxcdzdZIOI4eDepXs0wp8w1Z3XG+2pukuI8/aEwuWSQMpmaVjBvf2+8ZC9
         /dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312971; x=1730917771;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+1lZ4giOmpe95+Gq/i2PbzQXe88NZzeDPUC5J9YVC4=;
        b=HSRAI11W3r5tBQyx8wHdkdZ+YboOKtRLc9X0iyOd5leZxLJwgJHyvqjuHB6BhCTLmy
         LxWQMuUY68l0x9sUP7twaqDbt+zoL3DaD++kPR8eNsOrt6NYJhKk2zopYin+saF3cr1I
         jXH/iVKGrT71eeBWqCvghCACxGVeQ4lVN/iR6JFRJpWAU+IFrg/rPpkz15SiPmPj/Cjb
         KniAkww9Mc1lckeO4/OgExl9/KdedG3LR5xaZhe6uRZjFIRNSwyLpt9gQ8BB6kc6iJX8
         zr0Jb2EV/MKW1665jDtcVzWht6MzFPzBXR9/6ehM4yKBVO2QjQuwbkE8LTi8Taba4UCP
         2YGw==
X-Gm-Message-State: AOJu0YzZo6Ej83b0Su8bla0/hGvwMD89qOgUNy8XwRdj6p5idiko7kuC
	ah9xa4DRKy1f+6X53cHnD+ZW+NgdkSVMIQiDGhHLJ4PlqkCz4PZHiTXW+Q==
X-Google-Smtp-Source: AGHT+IEI1HJ/4nV8wi2ipi4l6ct3k+N+5+Yd4e4HauIqJfdutLuESJRycAp7cRZ1bR1EHw0Z0FCQtg==
X-Received: by 2002:a05:651c:550:b0:2f7:64b9:ff90 with SMTP id 38308e7fff4ca-2fcbdf61ed6mr75102111fa.9.1730312970889;
        Wed, 30 Oct 2024 11:29:30 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6257b19sm4904093a12.16.2024.10.30.11.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:29:29 -0700 (PDT)
Message-ID: <91c495f8-a607-429b-8bc0-5a45d3c1393e@gmail.com>
Date: Wed, 30 Oct 2024 20:29:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 6/7] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
Content-Language: en-US
In-Reply-To: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
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

v4:
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


