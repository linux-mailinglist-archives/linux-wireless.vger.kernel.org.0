Return-Path: <linux-wireless+bounces-23904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F41AD26C9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704F63B3D65
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B421D5B4;
	Mon,  9 Jun 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBrBNjPE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE521D595
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497594; cv=none; b=PMZC/nj3P7IVlSe//YZNNxXP/0Cf3NtXgGvPCtmLmu9GUpKsux4NHdEFqDqTjolM/nWPTqw7uBwt6msWrS/THYWvnSPcUIFtNYTZXdpnWeb0s0p4h21b8+xvu77oI5Az66ovXsIOa8iSZTY1xOA6Ty2c1o6387xRnl/9YGRS6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497594; c=relaxed/simple;
	bh=1LOPeXDBuuZBQCtN1DwANhsQ+hjfg4SCtB27wwcM2DQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s+yxUOdywNi1C1DMWBvXqlFK6ivBxEpxrFO9wuTiq5g8OTajRCuR2NP2kQTqkK5AOJO5pt2XdXurH6KD1JUL1lAaBu/i5yHSt/wLm1GGWvmgj4PiyiZ9c4xQq8QYwW3HgVd+S8p8YBjQFvLftOdmHqB5HqjZnLgfltoeuL2lH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBrBNjPE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addcea380eeso653009666b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497591; x=1750102391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hPgxAk1LCscr3VqQlcFXVVIn4/tweGo2bp6F79GaWE=;
        b=JBrBNjPEM0URgKsMQH4KqAmmax7R24IvDZtWfEX6NNMROJDmDA7sbQ8N+cNaO1Uhob
         8cwFDLOSOQHrK/ktzv0RAlfO+RFnm7EBX2olGpXIH819agQhJTLTg3We3XwNikpNEPxC
         bsQCotHQ3GGNdqw+Os6/oj1oHFL2TfArwr5pzG0Td9zxRC2U+NTGUN9bD00H81XU+y0F
         RbfARcej2Typdy4eBi/k1SNvqjuNc7/i6YDO7qwuV2TpmHAmg97omjZ/ZYJYUHM4W3YK
         9o2YjeT2QzDWttMkLYw04vYcHVVAWIkfo3bcKLDowWIgHxZ5YHL/xGpSNOvq9r328HGy
         Q5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497591; x=1750102391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hPgxAk1LCscr3VqQlcFXVVIn4/tweGo2bp6F79GaWE=;
        b=X5mL9W4yIvDz/sqMUNOmTFGhAgZBiPx2aMLx/upS11n48qWWjDpKeQuX0kLQL80mlX
         PRzT+Owbfi+X4oc/BGcjFnMk3MP7LagPSovsodaz4sq3Z9gdhavGgjwiR3GCHqhow7ri
         IO+F0Yuh8o6hw8cv2BKbmXbTSXWI0+fqaINMbKyBSkUnY4hFvBt8S44tfLjjZci5cRQ1
         87R3MvarIBZHADi54vPwuZnKOaUQ4Qhj5xq0m3zWyfbyslD6ZmWbGRL/HCxFFBuxcutk
         jxwEe42svhC+g0ZDzFRsXV2sJNZQxXtog9/GG4nEjM4+o6wM/RVMDw2QbqJENrN7R2te
         fbZQ==
X-Gm-Message-State: AOJu0Ywa5OhcSIAQNHCDTInoLT7q79Wob7ax910kC3h95nUkkrxUEQwA
	3j+h+G8WdI+N92ff8n5w4kubiePpgQZ+8oGlRAGy05oJHbXGtuLd02BFP5oNUA==
X-Gm-Gg: ASbGncsyNfoGyHFf+GfHbxyHT5bxVoWgwXnOWFJEDJhnR7kzxiPnKq/yY577YorDPe1
	HSgNlQ4G5aYD+pJEiwur+zr36nE7gN+0SfaU2Gpi31W0x1cOpgKh45yziFkmbIQp1a4CMerh8A7
	kRP92kdeUrX0+Qow5B3nTj3kfT/cVN55V8CjxndcHCIrr1NO17ZRD5GfaOTmoIvbfDn3jRAWEvZ
	2z6nELDH2072LKr+0fDsvMDCBCV7Pbrwv2tFK29Rl2PJgLGr8DniN76UiZwhqBSDiZwGfioP4fF
	d3+G/xFv4ECRq2/iBuWnhf7MgOb2BkkjsnvxqLuK3AmACKFInVCN/4Y5Ho3dEKol59IZFQ==
X-Google-Smtp-Source: AGHT+IFHUtLDJxvOJHvIuVtb08SciXBOnIKDUUEjlyVlU/pfFNQQbExq6ifoB7ICzf9NJbhFVatCiw==
X-Received: by 2002:a17:906:c142:b0:ad8:8717:bf9c with SMTP id a640c23a62f3a-ade1a978b47mr1379997766b.32.1749497590646;
        Mon, 09 Jun 2025 12:33:10 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1e361462sm587906866b.184.2025.06.09.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:33:10 -0700 (PDT)
Message-ID: <327a8202-30b0-4617-87e4-bd5d7916ab2b@gmail.com>
Date: Mon, 9 Jun 2025 22:33:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 13/14] wifi: rtw89: Add rtw8851bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8851bu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add USB ID 3625:010b for TP-Link Archer TX10UB Nano.
 - Add USB ID 7392:e611 for Edimax EW-7611UXB.
---
 .../net/wireless/realtek/rtw89/rtw8851bu.c    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
new file mode 100644
index 000000000000..c3722547c6b0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -0,0 +1,39 @@
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
+	/* TP-Link Archer TX10UB Nano */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* Edimax EW-7611UXB */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xe611, 0xff, 0xff, 0xff),
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


