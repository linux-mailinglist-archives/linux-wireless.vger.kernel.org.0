Return-Path: <linux-wireless+bounces-19511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386FA4706D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19064163D7C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00A4C70;
	Thu, 27 Feb 2025 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ6dvst0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09A2837A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616946; cv=none; b=hy50f8mASCdfsZRUaqYwlhdeYPEbmmSWN63u2LBoaxNfnB/HG9i6NtC6CQZcpHuENEyU/zYQOPQrGTrkKhKU48ydFAxltJ8uLJMu5dk1h0FgPN25omjSzfwuoy4s9G89rK/Ogo8fDVSMcHPZVjzhYR8stLpitxGVOQAzKQyewxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616946; c=relaxed/simple;
	bh=i3fjHd4CGl9dEbAi+yYVnKzo11mKXcLBy4p4FtVoX08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cazsS2GjZ2u6klj+ZiJj6xdYuMvruDtHYg5mHc6zq6EcP+iv3aWyoRkTuJotDW2UKMsi2DuPTY2njxY+BDL8VzqA3qqD1E/lttoZXJOnJtguDBKmhG7xfy3oaeY8suixzjfyIQhkgbTEiOArMJBIwAOcsIik34NbscfpdGr+8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ6dvst0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb81285d33so72612666b.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616943; x=1741221743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0U/SQXog+QFPtjzUWOw1Ko/94okF1fZ6QkBVNdj6+vA=;
        b=UQ6dvst0C03s8iUo1+k2Pp0eVty7AwtPAHkSES/xoWByDY8uTyjLPz0/VsM+QR4PRY
         yJRettcWJwrxTXnRsfo3pMklhqljFyj6gD2OwSjPd96Rh2L8wy/6A/mjsqNgLmwI97T6
         trIXYhdmNcStxz8BJ6DZJHFgTA5C4MUmL5m6EeA/llbfcBsGPSHn7xtfJEeHEUMGSLAO
         EFjYzfyQcZQcz4vuZxBs7f2zPWo4tWsBMMjfcIHmFe4+guWI2SHuAks6NcxHDif/AH1e
         tt4QwYZdqcln44+3D2Wr2JuvkbFwjC9fXUBxGrrIUkA/skg3wSwaxvIHlrO4nB5OAJbn
         w4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616943; x=1741221743;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U/SQXog+QFPtjzUWOw1Ko/94okF1fZ6QkBVNdj6+vA=;
        b=wYh9TrhUyGcNfgV343fz4Bu4l5lQ2DDXMZ+vNSpA8wOdhAuqZeTUPxNW9TUWJrpfxi
         pkO5HWMf/TDD/nfJCr9nlfahb9Jew2S/oHSg7p3VCn+esTK8dw+iZBQIAWr0obMKazsG
         Txpzy22EntM+E1DjTzcwi1fqCn/n/SskrxxzNc0QkSCWJz7TSnL0YVsLliczfotCufJF
         TcM3fjdswVZ0X3nQEPomhHkB/y6CA5lD8T+NSyvJKwCU2wK4MN+usfpmX+2m5dPyYUW0
         j9elgb+aDvV0G97Sa8sckfjj/f4Iz7Rt7VmLob+tYoxvfiFDeEsygTaZZPvI655CLC0v
         B9eg==
X-Gm-Message-State: AOJu0Yz8cels6k8Ml1gStAKPFOgPfyYoFfGWyC5F2p4kyrxLRHQOpTyg
	ZlZM9QVrgI/0PL7TWxAExK//dbgf/X+EkXipOCdndnaQWPyrN0H0e6bGJA==
X-Gm-Gg: ASbGncu+lCAWamlyE9hObl1x1bQFQ8iRcnfmaDktSL8wlJxIHkQjlk5iOBRikNTO+is
	fdWajozZzi0U8ULgJW4Oz2MEuKgoc8Mv1wHy7utK5jdA0MT0dV3lrKO/z/ImEmJHQW7Z8LujZGy
	qoqz6/4hmdPEGu5pyXVIE7PbTFkc6KxqjCy2PHIdLXNOhOCWbGlUaHXgvvImPV7Rt3YKAeQ0OSz
	lxnNjy6GY+PmxM7ccGmn3ab7whh6FT2HeMT+rnSo00mP0VnVq/HtOgyCeoVKl/7lh+07FHCJIQC
	LWOGB/ywP4+MkhCJ9eFpYUJDSD4HVVq82Oo=
X-Google-Smtp-Source: AGHT+IEmzDoDb7xEfnpx/3Vl+nKXkXMhYcTI1BBLQiU9MSagohNfMupeAK2N27s/VIhiGuIT8B4pyA==
X-Received: by 2002:a17:906:32d8:b0:abb:9d27:290b with SMTP id a640c23a62f3a-abc099b3566mr2195030166b.9.1740616942654;
        Wed, 26 Feb 2025 16:42:22 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc168sm30022066b.70.2025.02.26.16.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:42:21 -0800 (PST)
Message-ID: <dfd029db-fbaa-4fae-8bf8-0be679418a9a@gmail.com>
Date: Thu, 27 Feb 2025 02:42:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 6/7] wifi: rtw88: Add rtw8814au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Language: en-US
In-Reply-To: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new module rtw88_8814au.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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


