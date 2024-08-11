Return-Path: <linux-wireless+bounces-11290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854894E341
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262D628217F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869871537A3;
	Sun, 11 Aug 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7dEutoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AD15F40D
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410526; cv=none; b=KD1rU8lKT0JkIv6NGtJhJBjFHkW3xG5v/rDO0ITpoH8XZjAF4v78Bh9vDvqLKz3JAKs78yJrnvIw9jkeyMFUy+jRiLX6upFAP6Bga7CZ1+R/FYuyDcLDe1eY+yzIu+hmNZuQaK3bfuyUFldTPM9JiR3IEL9FEQipgnyDhLfI2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410526; c=relaxed/simple;
	bh=4PxnRcdnI+3i+kbGi28Ev/2o9HCXNq3nsaUvNdjAtyc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ufvmbvjkva3igHRuZ9hGE6Fj3LXgKL1f0QpspVSIoFMhMjeTJ4peJFJID2TbE1It7oelTIX7jnqYocYk9rwJc3PbQVhj9yq1BKDnNKZN32aA0z5CfW1ebsl7q7s2wLG6/Z0M4gENLf99gxciWU2s+Ha/lXJs9WSlwIiPu1fgeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7dEutoW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aada2358fso721874166b.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410523; x=1724015323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ry+AxyvV3augZGw2JDnUj3CVtPE0w0p+DLbndpHsHg=;
        b=k7dEutoWCzXRU4p/m6z+hbVerX8lGNPd7Lcz3gXuMq3T6zSZYVwicJ7oJzE7jD731J
         8V0Pda0Gwf6KQYgxTRA+4NqCw405eZYVYjkLBd1FAMe597CbJ4CZ5mjX1vgiRghzCuXF
         QdaN9JbsxzRY/nwv4eaSfph/qnqm9ss0GuIXEj3jZRF58myd9PdaQR9tTzS+T/bpx1Ho
         NrOalryLHeUZtqREKpivKHwLjEaQ3VjR5LlJ6ZmbxpjhbWA8ZJZ24/bnu0H7uKH2GJGp
         IbU+zmDXBVVudQXOUMRiAewmuZ3rYpOKW367z3wDRHBTjQsvLGaHVDvUWaWUu5L5xRez
         niiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410523; x=1724015323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ry+AxyvV3augZGw2JDnUj3CVtPE0w0p+DLbndpHsHg=;
        b=ZG+b1FHfy8H5Ie5ocMfpoS/OZ7n184M4N+9VzpbqrMkdmstlgUorsdqEPGKsgfLsPW
         T7jGYNkx/F9xCG4wE11atmN8lAuAjD91dBGDkNt9+TymPCDaAoE7jtmRuHv/ja/iTruS
         SMlu0yxUfrUvGWMlYxGXc0NOYVJ4dAV0r7OSMIyAL8fNkF32V0EJvi73eAM6CXCTDg5g
         iwtifQ5YvwPAlNTKdJSeTp4avMOxSB9RtconmnzeSWdh4xKxcx4abz4r7rYTnEijeV3l
         U2M4QzkdOmpnPW5TX3mgJQuLBvItWqYbkCke48sKDYpehwG/faVoDgPmItKaMJO2Gs1H
         aKDQ==
X-Gm-Message-State: AOJu0Yw5zX7DNhnT4WwmLzLNJZHPUGG3CLxmXBl3MVql/T1oRoDDqkfj
	sgl5IMB73UQwx4Dpe7QiIT02hbN46hRxWSLuVApeUFZ6F8hymXwH/pid3w==
X-Google-Smtp-Source: AGHT+IHF6MsR17x+k0gSDqK5sd21m0uZqFoAreIsLs5uRdsZB2WgdmAZVc/+hsXu9wVVxHxXJ/RiTQ==
X-Received: by 2002:a17:907:36c6:b0:a7a:a763:842e with SMTP id a640c23a62f3a-a80ab795b7dmr677659966b.13.1723410522805;
        Sun, 11 Aug 2024 14:08:42 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1d14dcsm171274266b.121.2024.08.11.14.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:08:42 -0700 (PDT)
Message-ID: <8ad0d339-bded-410c-9fee-4b5730651bbc@gmail.com>
Date: Mon, 12 Aug 2024 00:08:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 19/20] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are the entry points for the new modules rtw88_8821au
(RTL8821AU/RTL8811AU) and rtw88_8812au (RTL8812AU).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw88/rtw8812au.c    | 28 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8821au.c    | 28 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812au.c b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
new file mode 100644
index 000000000000..9997edd386aa
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "main.h"
+#include "rtw8821a.h"
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
index 000000000000..9af5dcc6a86c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
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


