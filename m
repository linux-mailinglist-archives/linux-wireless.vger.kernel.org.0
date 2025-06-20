Return-Path: <linux-wireless+bounces-24306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F26AE22A6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6734A42A4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8421019E;
	Fri, 20 Jun 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjtTHfiE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45A21FF45
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446316; cv=none; b=IrsttLqrazsRgdrNEWpxehHLlTW2Az2zKmxcn+FuhukNyHz9KP3phefgvo2rrNGsC5QnO8g8X+KE6QNa+fGvfKUO0Y5hWk+bn/ObdZBvCy/OjgtnawpJcXJNqXo0eV64ZekojC66Q0sVshZVPNOfhQgGFo7pXmUzvuM9RdZVBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446316; c=relaxed/simple;
	bh=hOaNBd+v6JmFJPZRq0UiAHqQ2HkNHQwK40X+1XxcKgU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RinD3z8olYdW2K4MdhQgU/01Jj33CvVPJl/47Fv44Kn/2uLCHd/OHh3bKidpkVvrDLoYrH/wF+flZKbMd6V1jvxXjQvSDc2thSHWwRlyUZFg/Tin17CAuQ75H+32FUZHHLf+l2E48liDSlIXkiWT+HwmLIW2QIoSZVzNlLMWBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjtTHfiE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1127424f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446313; x=1751051113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GHBg08t98vF5mnv3HSHdhGU+q6xS6XPuyl8IkNvyWig=;
        b=UjtTHfiEmVETtKnWEp7otY9+2r9CtKognDrzbyBF9oLt7jvEKHOptGMxzolzFFJ8j4
         ud55oZtE4WSkuUWr0VLG4xnpC4VM16hqBBgi0/hR6q/BxljlIdEUhGdagFfknFY4YolL
         7uLZOhzCLqkRoCw3mxUssvxBKpmA4X8sTBIJWlOEXt/HMJmVs90gFhUU2S3UPN1G+yCu
         aLtHVefQEbFgWXAIC0rG9Ykqx0K06okemzpOPaxUCfpqH8PsYPlUB+rXeKY9Z1fLCAnp
         Lo21C8eU6nnFXeMm+AJgxGCzmnWD/UGObQOYi5aG2pLu4qa430lD7167GuQ9gZ6UwdaW
         RIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446313; x=1751051113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHBg08t98vF5mnv3HSHdhGU+q6xS6XPuyl8IkNvyWig=;
        b=RvhEtGPWhXfz5hG6YjgEEoLB0CUpUhZrkXwR5TFqiHvwn2YQZP0Lvfd1Jg/xdWdOgz
         x78lsY/D7HuJBYU5vSTPajABj2QidD+K1f130bvWM3YATQPiUXKFgk5g8lGBKvxk6KNW
         yJbtJbN10gYVWCB2x/cN/NqKp+KaoymtuJ+b75N6/h2vmfCwT2Fu7mU67fYd3SbzYKj8
         g9zcnJjnmRV3oN18j65sfTTH2F5Y2DNaEb6R51dcsNpUqIdzYMbjaHl+OycJYbAHJfEm
         WXFBmFVTgd+YN4iGjTdZX193MDLJigOpS7r6b3xEMNurd8oRGN814jNTbJqr/WyuyuN4
         yvCw==
X-Gm-Message-State: AOJu0YykJxMm3AB356JCKCaiuf1/qkPhvQDNv3mrgFie4571/4KQ/L0j
	ty3AmoR0GejqQfp+P9m2t2NTdDcv/blCtJmnp7g7q6cGD4DFtG8CYlzWAivyyA==
X-Gm-Gg: ASbGncsgTf5A5zyziaclH33nibNyGFtd/McTq6h8fxSS05APTc8GVROiATFcn99nLl2
	sVJBvq1HDE3l9YFjpGoGwQ6yYJa1y0FxBDmtw6Q66YmSc4z+bcVYVa/V2p+nFKvdoj08ayQtnsM
	FcbqSIUvV4QB1VxTSOiFYVfXpktWX/yrABAZ9kLf00qtQktSlsiawENR8NtnLfyryiLss5OIT6Z
	cylBs7V/2MmOCfduJnOcAWDn9liaPWWYcCBrUtSRpQuHoGRwtGmPWKvbS1zAzc5bPGM3lVD9ygf
	vt+sO0uB2Odth4qw6M5SETxYr2n9B3wZxqZt6PX/iZ6MhcE9pkU0BQN5BS1E3nTD7r1tdA==
X-Google-Smtp-Source: AGHT+IHd2WonP+wgcMyqtP3XkJnb1L9cYcJ/DO6ZAgQrYrsqYJ0htosBVWSwaUvL9YkuvhVDGRdYWQ==
X-Received: by 2002:a05:6000:4013:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a6d12d5274mr3278026f8f.37.1750446312951;
        Fri, 20 Jun 2025 12:05:12 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10a8csm2820658f8f.13.2025.06.20.12.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:05:12 -0700 (PDT)
Message-ID: <c1548e3f-16c0-473a-a9f0-c364cc080e13@gmail.com>
Date: Fri, 20 Jun 2025 22:05:11 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 13/14] wifi: rtw89: Add rtw8851bu.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
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


