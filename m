Return-Path: <linux-wireless+bounces-24686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A3AEE883
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C701667E9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33A1885A5;
	Mon, 30 Jun 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwE++54E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFD10A3E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316443; cv=none; b=V9nT0JSzMfkM0nsajIGXf+EPO21TnVoOoviUY2eTc73CfmivwaTYJSpnxF2+WVh8lHWpP3ylZagJBRj7kfy8nnyFdtZEkolDdCBq/FjkusCw7up9dSdRlZN8lRV1oSt++giMAMYlU4aIQycC+qWzcTmPo+web/kXf36U+E1t4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316443; c=relaxed/simple;
	bh=t1GDoxq97SnV3P4m6mAjThl1d/2HnMx96tKb5pEMpug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nh4a3nlVSOFC/uXhNUnfkQ2HsV9Tx9gUN9h2YJ+U+bT6YXWgXW9F10+H1Qfkuz793PXu3/rOEUaIqIWNRUcA3s1c0HkOqnlwDpbcpOAspsH6cQKQbc6fd8K9wYTp+fz1HK273FCpjgH1r98v1Snmn4ZOh/Q9sNF+q7QJAiBy/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwE++54E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso48586315e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316440; x=1751921240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrZ3cIDbLiXAjFlH6OhinDl+ZbwXB36SpQFYkBq9VRg=;
        b=IwE++54EgEmuAdjVuHXbM6fyKXoFqTHuiQUOPlYVHr5D3nWK8Vm3tZaUtMOqbF1Kx1
         uaW/gfIL4jxWlbC5yvJfwfrhf0ZGjb493Y12oFlvCS5wK8EoXV4R1PfDsLMnMPJxN6/t
         4sLEhkhN86+xHN98zeM7a21M/iPULk/SMCMk419UCATcuD1NhboUt5x4cJqaH9+y/UHe
         NS7BaJJg6BCKNrpfI0yvTGpSUmqIY5F1WCQ4XgrvtEfHKMiVkphVFGQprci0aOJ5irjn
         gjecTmW7UGnczp+dbBt3zme8A775SPnYyz6YjFTG13dYobpdAJxhyNUcB8optm6MhGzx
         mk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316440; x=1751921240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrZ3cIDbLiXAjFlH6OhinDl+ZbwXB36SpQFYkBq9VRg=;
        b=u50qHRtQwmqGjoApXM4ausSNW9LUzb4iqxULDB/VH2xo/i9FpfPjYdkO+BqemH0ETU
         sWD8A0vf8BFbq2sKqF3jwRDzKesyYXEXagyVmp20mQ7x/Ktp1VRSGIFdFSB8Qx7DDkNp
         scc4jMHeqysvTsKnpTwIsCeUD9xX0wfPPWElvj29xZh3zU7slD722A8isnInZ2JyDZoC
         iyXXgwlb5ahp+Fsm9MqO6uSVd4l+WJAhxNkpYizSLIIP2MCBK1T1XRzAgLKEpx0F0YKW
         BHWypTSKje0v8VVXi4c8g0TJzws+kMmbE+ee4V88w37AyJkozDZ5SaYRXQNGR2GhLMSo
         bxYQ==
X-Gm-Message-State: AOJu0Yz1Dc8XsVud10CWdMf2FbeyY+hT5C7HcVXB5vHBoD0dL8etmThS
	+QofYzCYfP+tNkglTbAyxYt6lVE1KAyBKkVcGwdy1BQAvLmxbZ9RENQWdQVegw==
X-Gm-Gg: ASbGncuAp21E3g63G4hnhKSehZH9eqPiIWMrgL3NRyubG179Lw1q6j5hQBIElppsV1j
	jPKpyghpyaLg4Lh8BhYnXIIeIBK4UlyEal97CZVw5Xu24I0y6DIiQ1WqXgByJvd62QqjCsRaRa3
	DTZYpJlsPTJotIrCugBAokFDYLFkXl0CqZ+R89wRvCoFaQGOUEmlrlXQHwBc3fe0FPxtGy91MRv
	nOu8w4Tw8aXLFImUVaY1ANMhS4IpdgR8+OBSCDbRGdfH67pkk1z6yfgejIfkqfk8cqZ2tktqSqS
	IVKFDRxPjIusq04M21XRWAVVUolTkXiLCG+ry/3DtuCMZp5wpPydvs4/95oIQ0E80brY0Q==
X-Google-Smtp-Source: AGHT+IEghrq9JbGjMRq1Bx52GeXIqcDIiwZHLldn7Uql9iZO9B21a9VNH4tNo5cfekWDWBVAafbWUg==
X-Received: by 2002:a05:600c:3e10:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-4539148c357mr124155015e9.32.1751316440155;
        Mon, 30 Jun 2025 13:47:20 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8fasm11256115f8f.28.2025.06.30.13.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:47:19 -0700 (PDT)
Message-ID: <9d40c265-2982-4073-84a3-d3781defdbca@gmail.com>
Date: Mon, 30 Jun 2025 23:47:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 13/14] wifi: rtw89: Add rtw8851bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new rtw89_8851bu module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add USB ID 3625:010b for TP-Link Archer TX10UB Nano.
 - Add USB ID 7392:e611 for Edimax EW-7611UXB.

v3:
 - Add Acked-by.

v4:
 - No change.
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


