Return-Path: <linux-wireless+bounces-34000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGfpEZdrxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-34000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:23:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A6033919F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5719430028D5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F227FD75;
	Thu, 26 Mar 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhlRNDBp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB351D6187
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544959; cv=none; b=tkC81BiKfTkKIZoAiWT3rdaXTOCE55l09WyHKUoz4y74i4XqqAzcm9IgyKhxtlB6T0raOn5gqmfI6z+U61bHtaKI9RRdO3cuFOvCmiE+h3M/yUfMCKYKWl0fS0bit32IbiYJXp6SM9qcXU1v6/q1BbPyxYvSRbHiQZI0SLmIr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544959; c=relaxed/simple;
	bh=KJXgeq7Gu97DlpnJ3hwVqcKwgVpqq1WxqEQfWbr/kXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XOov6iDouA3IcnhuHx3EBISlfMRQ5kSUr9Udk0HX2lpGHvk+LdPeor1Sax4Gh0zYycRb9Mg6akpboe/yu7tdYS2OK17jhHdRAatuutVGVCWFtqzp4wzKYSAyznbwW+t+VlBogxJjlxwuHDm1r7u2QM2Uj1EQL2gt/BMEkLM74X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhlRNDBp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb14227cso15103705e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544956; x=1775149756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e0Lng48LXYJje0Tzcy4OlTQ8rIi9GEnNlAoquCKzsjQ=;
        b=JhlRNDBpC22lxJIaPyDFVU7GgpWyHeIX926Mdd51LKw3wq0tY38b6QkN5WsGOcCqHc
         +QXWrNq/RnfPJMYvXOWW1Tav4PZPnZ53/SAMtmP/BNHBV+OutYPBitTbH+hsO8IIY+ja
         feClnbYK5cQe4Z+yIvZKNUDqji8bZqkk0iNBa/ZCLnFVvMN5XqDiG49YUl3yHB/D864k
         WtgOSd3WiZ3mNM1fGia2VhEFkDwb9n3S+R3p4al64g7f0JKKJRuceaSJXPVfYlgMmagw
         st468Yw0FgR2d6ugzPsD4Ua5RdgRPEVHA//lp33Tl52/O3QOkeZoOBIukgr51HJW09TJ
         VVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544956; x=1775149756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0Lng48LXYJje0Tzcy4OlTQ8rIi9GEnNlAoquCKzsjQ=;
        b=RxBVA0nVH9Bw9yJIoRCcPzP+tzDXRk3YxGAO5cCFCUtl9ntM3iD4NBh8bVJBxWIjBq
         A+9SJBYlWe3mHhMP90cGdQjg1BTuhxaXzeQDGsQb4awj6idyTaSlDLR2spKMAOUL43j6
         TnJwuGrvTay840N3q7eI9n+K2oWMpZ7nUOGx5N4QFSaNXuzQeLoOHbrj5jwCgKM/4tCZ
         WHdxUhhdo+hcXzN+nTA2Cg/eNHC/mkTrunXh6NXRJJL1ByP6YrDwNshxlOI5Gn+ViaGY
         vJeCBBDi6y9GHigL/EHT6d5/WComLRKzk3bDfv/FgseNk/ij7s5Zq7XE2BT3BdTeR3VJ
         peww==
X-Gm-Message-State: AOJu0Yy0zQGANEsOCvIioQuEdydAOp2aafW03WpPQyletAI3mo9SysdP
	9jiOa9UK47C8sRfedU4Y4b6SNhbd9p2/BWW2onvoPl32LaYu79+YeDcTsiztVA==
X-Gm-Gg: ATEYQzzdBZCPkY02iw8b00jwaP4g/+ngplmduSnJv/EwQ6crZk2Mvn/KXp6dUjfjZL1
	xOtl9iTHbr8hqD35sWDuqpZ05UABUG6bD1JaaG8GTWKKJmnWYwRYD7UhfhTlnxd6m4MTjlhXK6K
	Gx+2/k0IHiEHBuqQYm9xvC88O4m5IuYDidgocpu+vurOKkrzQJT3RkLMvG5beAxXD17/zZWFG/e
	4bQpcpJi5otvwu65yS2nKiLNM0wQc/xTlxzHyJth4CEX4TRyKHW+Lv/WGqF0ShedC9sLvOXJwX2
	i7bl1hgkwCIPO5YeAl80+yMkkbwM+Z8snMa3VlpqMjXhAPqdZ6hnvmmXI7lFzScDKMO0QWl2Umc
	1SCUTRvWocCn6sTJwn1haYwch0Xn5cSqPTy8WG6Lfw6iZ0BjgoY6JJrckbYnK0WMJABCaliZELI
	B7IX8cbRa7FUcoI8dcZQXhBHbSjL2JtQ==
X-Received: by 2002:a05:600c:8b2a:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-48715fc3793mr122890495e9.3.1774544956274;
        Thu, 26 Mar 2026 10:09:16 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eaeb62sm555065e9.19.2026.03.26.10.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:09:15 -0700 (PDT)
Message-ID: <c171e4ff-2a84-4c71-9c1c-a485863c1855@gmail.com>
Date: Thu, 26 Mar 2026 19:09:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 11/12] wifi: rtw89: Add rtw8922au.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34000-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A6033919F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is the entry point of the new rtw89_8922au module.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw89/rtw8922au.c    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922au.c b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
new file mode 100644
index 000000000000..a490a7474a3b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
@@ -0,0 +1,81 @@
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


