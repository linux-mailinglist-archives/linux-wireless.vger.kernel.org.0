Return-Path: <linux-wireless+bounces-14990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F19BEF9E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB71C246F1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E801F9ABF;
	Wed,  6 Nov 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC3lZN2B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A58200CB4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901435; cv=none; b=HcMUW06WjWiEFNhfaFbzx1mKY9+VsSUTqb7S6qkpRpUiuI8mQrHc4aU+ucgu1WluJqPKozxKRg2HV/RpWVZoAOI81kVJFLsFMCe1MEFtuYy5bbuFWJ2A8sLR1DXfG+T9KP9YltHX5gUpdAb1P+YmXUx2oji0sRHNANnD2a7Tgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901435; c=relaxed/simple;
	bh=yWMiTcE+5tywQnmXx6CBjZDWsrcSaLFF1O8Yqd8Q8zA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lw0HT7twk2Bj+P30ct+H31XlFjyUx9XzdvBw2tiFAy3QR3LpCXdABrKsvWxeoLs5U9krV0a7rlkcGQG8PBCxPB4UwG2ZlpFiYGwyS9sI0w5m0fIRqPI6rTiOzvap0mrFmtdKKWbQzQ257JCWIv/K9KG5qqkPFa2jMcV3TpbrE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC3lZN2B; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so10552072e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2024 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730901432; x=1731506232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgksvteD+clw/Xy/GePAMIB/HqDwUTYZPzpjg4HGS1s=;
        b=lC3lZN2B6Hwlwhq6RbNNKCjYPngWdpi2Lpl/joUwgqGjcskvjYa7a7+f5y37IZdcb+
         kSHcYxxtz1cFr0KqFEHP6x+J17hlZoqWOVzraIflJiKC5K/kY9dyL1o2hfbbn5c9Kal0
         1ARX+mtyApSrc+akRvZfhV23DW5NFteAYg6rQChVr4tL/hJrXEPKvknmLaLfIAhIK2rN
         H9k2EwW9KLT1g0UGuK84v3cgiBPp7t57GdlxOsKUdbotxSvLjmW4O8cu4a++spJfe2Gv
         isvf8YTF1Xeq8Q12q2oVASvzocoKGfLVwqDrax/bdIHoNJHBBakCSsbE524Pphz8P/LE
         v0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901432; x=1731506232;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgksvteD+clw/Xy/GePAMIB/HqDwUTYZPzpjg4HGS1s=;
        b=pflxekLOY3wr+Q8kHWqlI1c2xYGmkzvMIhuMEe61VG1quYfjYlS5b692xueg2mw+st
         0cgSZC1qerwyhQLBw0rL1MKwDG+JHA/TPsdXtQXuatuU1TimoAsNcOcMYHog67KqLVYs
         uV0p4Cqg221GDPN0fGHK2aCKc7s9dem1mx+m8WUZrrUjfwEw8gLQTQJ/3j0U8OTEkmDL
         TWxdgKnXs5zN6ieWZcSA+ZDUgB8U8fHIKQ3IteMqEUYM24V/KOi99XaQLpEUIYRSDBfh
         2lgW4w6OGzwTIKMEvM3g3G758wE6P9qqUFqctxznN7+AD/MGXj/t1Y415qS56S6LJpSz
         udEQ==
X-Gm-Message-State: AOJu0YxxmDhrE0CZA+y57N8b6mPcFP1YWSsGGXallOW9TZLuNHitq4HR
	NZ5zj+mSL9iakmCsv+hMojDLZBVWjzIf18vQBC4gex8PO6H2jJsX0Ez/KQ==
X-Google-Smtp-Source: AGHT+IEVjKfe4DxUA5FPIyTlbQbh/P2tqJWtC4s2RslgHtlvaB6I12w4CvGT1GTlLWE29h90kPceWg==
X-Received: by 2002:a05:6512:3043:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53d65e1688cmr14733877e87.52.1730901431494;
        Wed, 06 Nov 2024 05:57:11 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813368sm285516566b.180.2024.11.06.05.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 05:57:11 -0800 (PST)
Message-ID: <31b7ee6b-f96d-43e0-a32f-a9eb1174a0c1@gmail.com>
Date: Wed, 6 Nov 2024 15:57:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: 8812au: Add more device IDs
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <da05b866-a9ff-428c-a008-35e8cf200a98@gmail.com>
Content-Language: en-US
In-Reply-To: <da05b866-a9ff-428c-a008-35e8cf200a98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Nick Morrow <usbwifi2024@gmail.com>

From https://github.com/morrownr/8812au-20210820.

Signed-off-by: Nick Morrow <usbwifi2024@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw88/rtw8812au.c    | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812au.c b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
index 4da69590a423..e18995f4cc78 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812au.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
@@ -9,8 +9,74 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8812au_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x2604, 0x0012, 0xff, 0xff, 0xff),
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8812, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x881a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x881b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x881c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0409, 0x0408, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* NEC */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x025d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Buffalo */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04bb, 0x0952, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* I-O DATA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x1106, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Belkin */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x1109, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Belkin */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0586, 0x3426, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* ZyXEL */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0789, 0x016e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Logitec */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8812, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Abocom */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9051, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Netgear */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17d2, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* ASUS */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0074, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Sitecom */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e66, 0x0022, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Hawking */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x1058, 0x0632, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* WD */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x13b1, 0x003f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Linksys */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x148f, 0x9097, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Amped Wireless */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x1740, 0x0100, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* EnGenius */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3313, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3315, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3316, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab30, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Planex */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x805b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TRENDnet */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0101, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0103, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x010d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x010e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x010f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0122, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* TP-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2604, 0x0012, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Tenda */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa822, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8812a_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8812au_id_table);
-- 
2.47.0


