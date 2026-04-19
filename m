Return-Path: <linux-wireless+bounces-34986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDpuBQbd5GkibQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:47:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAC4243C0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4D4300CC2A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940E244661;
	Sun, 19 Apr 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcDxO1wa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267340DFD7
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606467; cv=none; b=HMpO36+aRUPEyofdCwxswMo+zl7ocptzi0CUoHXAky9UEk+jn/anj0dambaXkOK1bhkrn3gBrcjZ2POcAJXAh9yQzGsUTYH4+pnI+hWvi/i11JRkEcIGnqvUGJe+2AUeM3KCOnEOFVcqXowk0134uQFmZ6d29ZI9EtAQf0mqftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606467; c=relaxed/simple;
	bh=ZCRn3/LnC8VjUSd0i3NBvvxWyuYi3F7cuiW6vzRuRdI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=av9aSyJdtxHQ1pG5tMVPrNzXE3nKcRbnQ2Lc/7dkajv6t57Z34U0iRZtHZF08beh7EtMrAIsloMVmBTPP4GDIFq4DhaC2M08ZUZYAB3VKu4x5e+KZO4K+HjH2b2dsdLssbSQ3l6LRxXDM9W4m3KnAW19QMy22+7xNWjHsVdBQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcDxO1wa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20476415e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606464; x=1777211264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uc+McJPqFjngP9DDNYtOH7oEz9MdueojnQ2WvqWeIYI=;
        b=RcDxO1waHXhuhzYA+tC7Eqk5ur2q6aDxqwQyHi2UtH3ZbOmlhdk5+ezAMR5pLZpOlp
         /5273ARC+d+FK/SwrdMG44OdwZLASmVfbrPOYFwvje4jB91vmCGI0AhucIQUO0piW5gO
         qN6BFn/wiWrrVnXF41l7RZ5vuFwssYtZfSnCuEmM7O6hcdFyDVdQJkeKyyh/UtOLlbaE
         JYDcvw2kwsDLFgOqQvrgjO4FxRY3KJzELQZIh2yn05GSNg9QPsCTEio540eF7PDvKKm/
         ixmK4Bg9aXxky6hf72m/1F377X4AO9aEM69Vyn4te4Xpc5SvbfBvTiNIIjFSMZWchyxf
         LQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606464; x=1777211264;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc+McJPqFjngP9DDNYtOH7oEz9MdueojnQ2WvqWeIYI=;
        b=oeTyoiTCyWSJOc47g2wZnb224miCLwl+gluT3yPHuzwsUCBaqwWsLTmOH665eXJefP
         P/Qj7DI/rsFbqjcWrzDawVCLVwXePbrWRuMa2f5zsU1+IQMcQni6UATiKNq12ZGIE379
         PY+p/nl1poEPBoiNjfbhO2H3JJo3UvdJt3mz4kopCKl2FzZ91UUMOUxH8EB1w0u05bPt
         uJMZOjPYt0CLjFfR/3lNyWP8NLtkwfBqau1fuNL1KU4s/ejtQFJqbzHdYoEjPl/mtDyQ
         ihaEpR2Byk8EG5HIYtH420FPYBCepvnhlZlFPb2Rc76UXchFm4S0/ZBCn7ga2U49B7Kh
         yhqg==
X-Gm-Message-State: AOJu0YztCOXImhJZbtDKl9mTpy2lmOdXpPcb/IevC1ZkoDYGan4nKRpW
	7/6ROTSLSDM5VbR3cMDu6d80jJOQke6K2sPxluxGGC4vklCsgKOPKTQ2kFtq1w==
X-Gm-Gg: AeBDievCWuQsN07ROLtGRVv1T9SG6UhsLqJzfLhyiylsubyb3jp2MAByVIkpPIyAb03
	Qj2Lr4I4Pkobv4+UrpEgA2vU+Y4Ydb5oG6Ny5ZoKf+mQSgGv473M2v32ZtchskxljjhbS3Fz7TC
	IdO5jgseaYAhNvWT3l68vYbQ4h0c9gG1M8rlZVJpYCHySVG7MM7/+vgm8KMm5cODiCJFdduXVD9
	JyFH4fFu9GAFUINRvHHRFaesWIpW/0QhRKqoS4MCiV2gs9j//Dhe14QRbX0ZjWhen75qKADdfsU
	ZUiJ2JQpFpHOU8NvRHpSHh4OSwwEs2bBxZRZnzdzcINd2yk6fUMSECq2FyZ2LV0+p4pdm1mQaPo
	XvJigtDAx8C5FnCLryACEDBX0/41VY+y7AIlg4+6f+lFAlqXetJpBHOJaXHlE/54W7LnhAqLtwM
	hBc4sf8VEHX9o5LKWaOHhI0toq0GX23Yj26X/kum/h
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr5502325e9.6.1776606464023;
        Sun, 19 Apr 2026 06:47:44 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm75446575e9.22.2026.04.19.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:47:43 -0700 (PDT)
Message-ID: <0d22cd72-4048-41ad-a4aa-511681e6ba51@gmail.com>
Date: Sun, 19 Apr 2026 16:47:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 10/11] wifi: rtw89: Add rtw8922au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34986-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67AAC4243C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is the entry point of the new rtw89_8922au module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add more devices: 7392:5822 and 056e:4026.
---
 .../net/wireless/realtek/rtw89/rtw8922au.c    | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922au.c b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
new file mode 100644
index 000000000000..347bde171391
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "rtw8922a.h"
+#include "usb.h"
+
+static const struct rtw89_usb_info rtw8922a_usb_info = {
+	.usb_host_request_2		= 0,
+	.usb_wlan0_1			= 0,
+	.hci_func_en			= 0,
+	.usb3_mac_npi_config_intf_0	= 0,
+	.usb_endpoint_0			= 0,
+	.usb_endpoint_2			= 0,
+	.rx_agg_alignment		= 16,
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH4] = 4,
+		[RTW89_DMA_ACH6] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 0,
+		[RTW89_DMA_B1MG] = 1,
+		[RTW89_DMA_B1HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
+static const struct rtw89_driver_info rtw89_8922au_info = {
+	.chip = &rtw8922a_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8922a_usb_info,
+	},
+};
+
+static const struct usb_device_id rtw_8922au_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03ef, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0502, 0x76d7, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4025, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4026, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1bcf, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x1bd2, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0x8912, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0xda0e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0100, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0101, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0x3822, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0x4822, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0x5822, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{},
+};
+MODULE_DEVICE_TABLE(usb, rtw_8922au_id_table);
+
+static struct usb_driver rtw_8922au_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtw_8922au_id_table,
+	.probe = rtw89_usb_probe,
+	.disconnect = rtw89_usb_disconnect,
+};
+module_usb_driver(rtw_8922au_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922AU driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.53.0


