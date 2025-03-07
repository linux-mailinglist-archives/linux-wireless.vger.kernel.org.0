Return-Path: <linux-wireless+bounces-19966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A3A55BC9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96263B8377
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753FC7F9;
	Fri,  7 Mar 2025 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8XGJKRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BF944E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307116; cv=none; b=Us/EvnwPvQ6d83CbRknC3yFFntIoUavnL41Q5Y/xxu839+2YyBIwgCuEtLDgMzc//DcKBv8ChDNtaMF2n1mtpOA3v5eDoJyR/hRG5cWSZBSOLKh8wu0idaM5OBN9CGD1Zr1jaGiTyYL8DNojnyj6zR25SVs6/JooBAyXU6wo17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307116; c=relaxed/simple;
	bh=AifFJ4rgzlSK3bpMiv3IfU2vpOw3SlodkWWASe1JOFs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kSwXUFI5j54BeRgiNfWHEBoCFFf73LyKPL/9mcCbpYoESnz4PVp3+RtSJt+/lC5npTJFCjNpwRTu7JzGFZyI+H/zHKttYPZahj2OO2aYqFShNxgD3Yx9dMX5ACCN7LVQKji0ENiHuXzTzyFBAaUI7iTkrJ62jzk6ox80N6tNXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8XGJKRW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso2141029a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307113; x=1741911913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TQYqwwoEwqfywC+4Kz6uJ26eeW9nnQh1jx0ormbyn38=;
        b=B8XGJKRWOl7KFzAXqz2OASDhI5NB1m9UK6332ldpTm4Z4eEDWlh+qQ+/u5zRsPPcvA
         tSQPyaEqugTyN3xRRLHP8aqqqun8XbAC96G95PrqYeO3zGdd3CPpV2eUiklHSdKPIPpQ
         7mRTAUScK/VtLydGZsg8Losr72ib+b7157lQtpsGlCw9lCHfwKz2ybcUpWbRJnKGoHfF
         zBwOQuEHVLfTe3qp1bFmy0ygc9GopVkA2m2J2F+3OksgeSxGQQuvs3sfKBmffOAxrL5j
         udzoikMChD4oRwHuLid2Goq/kb1SonRx1t/EkcJ1bUOrRjb63NG8fePEIqa8KHgs477A
         Ibqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307113; x=1741911913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQYqwwoEwqfywC+4Kz6uJ26eeW9nnQh1jx0ormbyn38=;
        b=ua7Ezs10G/Gk1f/Y8SqM1J4j4CADv9ZNkvDmNVkiXO852nDM8NPhPxY1mXVtVPAsaw
         kD1ER+z6ru9bj6v4QzVlNr9Q6tYFDkCuAUsYv/Q4a1XS9aMRqttxsAO5KZ0FnYM/AdDQ
         OMAj3ahzhQ61SyYGo6rucayox/38dfwSKPAUEumookvv2Ywi5DN6KlNdZUIjV/47Eyy8
         DolefhsyVR5clnbMtzFQ6W93OUh6guZ6E79DWAtxPJ8oB+zOLZyN4zhc7Zf3+/4sAopD
         uApBMfdj+6ygf7tPRcnEvb2lr2nasLJUzJ5J85S2FrES8U07+jw/vFiWb4O7fAeLwLVw
         r1NQ==
X-Gm-Message-State: AOJu0Yw2VVJfcMKMLpkm3Vkr+J8vYQOCSar95WvlY4w1z1YxY+rcVipJ
	RbD0XEzSK45mMYhp/U4npX8kNp8NOIhR9+oGEZpr4ya+laUbHxf8O8pQRQ==
X-Gm-Gg: ASbGncs9dYVbAGlPrD4+5X507ncMXgE0bkLy+L34Hc4uyB6ddRJhYA9pvc4qxZEsm6b
	e0z1wA3toGUO1sl/vxUiScl7G87EHKltby2MFWyuM4e2IepulYF9us+I3IkUYHi6NHoRU/lakbE
	VAMCy3VTzNc8p4Rn3+jLPnBC2tg8V1LA/BfTWP0abm8iYUGaC+fVH9IEVOvte5YYgTHIfWqyWKV
	pPyYgY79+7dyheWn552cYrmMWvHyVXVatIz1B4RtgY0/8IIFJGcF1ErwYxwSL83dNZ9TgWsI8qf
	FYAlj5YM6KKdoroTOjoBIQjz+01eyjK1DMjUtHav+FqBkXGo3lk1Ww==
X-Google-Smtp-Source: AGHT+IGx8if/KdDcj1XUGE1ryRtwS74uxUdV+adkcaaLWVu96XEfqEA1ZqTCAbd2pRldaetdy2FSLA==
X-Received: by 2002:a05:6402:4011:b0:5e5:e836:71f3 with SMTP id 4fb4d7f45d1cf-5e5e836730fmr125162a12.29.1741307112863;
        Thu, 06 Mar 2025 16:25:12 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c747219dsm1684550a12.20.2025.03.06.16.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:25:11 -0800 (PST)
Message-ID: <74ebab2f-a23e-4d87-935f-0af2b5cba672@gmail.com>
Date: Fri, 7 Mar 2025 02:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 5/7] wifi: rtw88: Add rtw8814ae.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Language: en-US
In-Reply-To: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new module rtw88_8814ae.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 .../net/wireless/realtek/rtw88/rtw8814ae.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814ae.c b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
new file mode 100644
index 000000000000..54d2e20a7764
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "pci.h"
+#include "rtw8814a.h"
+
+static const struct pci_device_id rtw_8814ae_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8813),
+		.driver_data = (kernel_ulong_t)&rtw8814a_hw_spec
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, rtw_8814ae_id_table);
+
+static struct pci_driver rtw_8814ae_driver = {
+	.name = "rtw_8814ae",
+	.id_table = rtw_8814ae_id_table,
+	.probe = rtw_pci_probe,
+	.remove = rtw_pci_remove,
+	.driver.pm = &rtw_pm_ops,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8814ae_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8814ae driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.48.1


