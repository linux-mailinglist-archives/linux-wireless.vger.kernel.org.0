Return-Path: <linux-wireless+bounces-14988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44519BEF8B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639731F211F3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F9200CAB;
	Wed,  6 Nov 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNBTPjq4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A081DEFD7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901337; cv=none; b=Ik+DLPhyaUuPFnbMxDv6RfLwes8TLrU1sloFG0O6KpbRBXxRwpEsluf5GNUq1LuI2dOuHRMcyCJxjZk2siLEi4qsG/wODyB4CglXD6i5DWCV6N1qBKzrTcLXgmwLnKx4vOuoJd16c04s1F6sOwSfpL+6c5/nGNi29GR4vNB5Nyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901337; c=relaxed/simple;
	bh=gACqmVDy0P4UPKy2ezEYaT3KBmT1CDR+81Uh2U58UaY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kdN8QmHJa/xsSj0Vyo9ohngenJiiOPScF+hhoeS48XHfR/HM43vQ9B8HkGmOmsTfwL63+3fNEKt73mzp+80mroqGbv5ePVeY2I4u5cpbeu+IFdr+qBAc8Gab22OvZUleWTyomyzoroGF/J+W2jix9P59Utx6tiHZWAyb/wuTcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNBTPjq4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e44654ae3so891359866b.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2024 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730901334; x=1731506134; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6xFIye7RcL9Y1oge4E33mXVelkw8hn3/k+sI99upNs=;
        b=nNBTPjq4sDOD3L4CDh8bcPc5aMzI5RemtwwXekfHZmulnHZ9XAEwDJ/+SUUnvDrn1A
         0oAshTvVQQp+dUDpinP0YQYzIPRpdDboXs1T4cF6XWU5XRMQ5KKvie5HEPPkDrhH40F2
         azYXS4aVA6C2Ffaha7u3v98TjD7pkGW5yr1hRFo29nshzciiY/anNnZU9xD2jJ6FUwas
         SlUvhlNmLRJZwW5L6iILDuxgOmEmBjyp6PeH24WYzqljAUM2GiXgnQ6+UzLiOJvKZ0l4
         tWdreDuUwTEa2zVSW3Kl75AfSsBoiQXw4CJ/S3euemaJlo5IaMQhlC7TzB5p539ODepf
         U2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901334; x=1731506134;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6xFIye7RcL9Y1oge4E33mXVelkw8hn3/k+sI99upNs=;
        b=lRLIxgK/x1I0jYPBi87nh5OdRbo7jKTfbJ1zekiDlSk0j6TB1/P6DSzdNYh/sGw03+
         mS77ihmIHwhA3yXg8a4DcCBgVvxgBCAlITw5Vp4RUkxFP2SKfNXVAyTdql0DNmm9OyHq
         UPriDFmtV2ASzTy2EDx/O/Mhrp/rJvDspcpOVbVJ7XFVbtRSpPBHVhpYBYEvhpHYIzw1
         qehpByU/YBAblGdsXQ6bMT3Z7nTDv6fUMiDLclyvQoc0GhBU0tjvAIZcv+YeX1WgFb20
         iv0y2j0BRFGfdYeBmRFQ6rzjIqT7Q26vjjEjEidvaUkNxmcMTlbYmIJWoSAEUXCc/fR/
         rY0g==
X-Gm-Message-State: AOJu0YwXrYREN1pyr+V2i2YePTQxgSxM1B1sD757lOztybhoTO9rfwpo
	8VLQySmmRkQN75uPW2P+Q2qfC7hcjISBFjCbkluDH8JCqjlli9GgImAqVw==
X-Google-Smtp-Source: AGHT+IFAX5Ufd405KFBfBQfQYFkv/Q8zhsCjelN/yad0qTtqyVgzgsV+gYDvF0WfXAgpyj34qm31nw==
X-Received: by 2002:a17:907:31c4:b0:a9a:90c:8bc with SMTP id a640c23a62f3a-a9e508abcd6mr2041802066b.12.1730901333409;
        Wed, 06 Nov 2024 05:55:33 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb18133aasm288965066b.181.2024.11.06.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 05:55:33 -0800 (PST)
Message-ID: <da05b866-a9ff-428c-a008-35e8cf200a98@gmail.com>
Date: Wed, 6 Nov 2024 15:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: 8821au: Add additional devices to the
 USB_DEVICE list
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Larry Finger <Larry.Finger@gmail.com>

These are the entries that Nick Morrow provided. From
https://github.com/morrownr/8821au-20210708

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw88/rtw8821au.c    | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821au.c b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
index 730018773e1c..a01744b64e8d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821au.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
@@ -9,8 +9,58 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8821au_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x011e, 0xff, 0xff, 0xff),
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x0811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x0820, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x0821, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8822, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x0823, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xa811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x0242, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Buffalo */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x029b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Buffalo */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04bb, 0x0953, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* I-O DATA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4007, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* ELECOM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x400e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* ELECOM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x400f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* ELECOM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9052, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Netgear */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e66, 0x0023, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* HAWKING */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3314, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3318, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab32, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Planex */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x804b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* TRENDnet */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x011e, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* TP Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x011f, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* TP Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0120, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* TP Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3823, 0x6249, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Obihai */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa812, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa813, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xb611, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821au_id_table);

base-commit: 1f3de77752a7bf0d1beb44603f048eb46948b9fe
prerequisite-patch-id: 8b66ae2bfbf46f30a9c17b37423ea9f42f3e56c7
prerequisite-patch-id: a700764f0bfe91e9a17bfe194ffef9b59d8cc994
prerequisite-patch-id: aa91f11d43dbf3e0081fb33022fdf623b2e1fe41
prerequisite-patch-id: fff3a9dafec3b293c8c1c3059ab8c85ed8d51af2
prerequisite-patch-id: 05bc1efb4d16788c5dc7a82a5fc02ebc2c40b9bb
prerequisite-patch-id: 33acc0f39fc264666ddc16e371f4190a117b9b0a
prerequisite-patch-id: 586a4c77227a0942032a70d7752328906f5c2353
prerequisite-patch-id: 9005f7599ce3819f952955e356f2971f942491cf
prerequisite-patch-id: 6565f68bb43594f2e3bbd310ae6d1e10aff52ba2
prerequisite-patch-id: 247a49275f81bc0ea4704813c845d0f4b212b4fa
prerequisite-patch-id: cadb4f3eead80e0b8dc21c4976df6e3d4eed4411
prerequisite-patch-id: bcc4b916fa66e3a1f8830ed91ae66d0edc792c27
prerequisite-patch-id: 61bd0f9fa3727495e0b575699c572e9028add725
prerequisite-patch-id: 67db016e612870e24bb50686c7b8382df78a3b3b
prerequisite-patch-id: 241b9366e96914fdc3736ca3a694a2b7b645c25e
prerequisite-patch-id: d2a9596fdb06a0be72a8810108854ea059b20ac8
prerequisite-patch-id: aa2559586159d347d03e247c6ab1752c7766b198
prerequisite-patch-id: 7981f49a43504646fd84b1b3adf995a736bc33eb
prerequisite-patch-id: 0ce4cf3b765d24fd438e6ba64b89e1b72048b65d
prerequisite-patch-id: c6ac89babaf69252ddbf1717138067c8ab3b0e77
prerequisite-patch-id: 74d3154402984209896914648e007cffe37bdd3c
prerequisite-patch-id: c36cea8efa84a07a046ea2932e1cc5d0eebc467c
prerequisite-patch-id: 479974f2c2409052c0c8448cd27a3fc73b8e73d0
prerequisite-patch-id: b60b6c409a2e5927ac7a49098b001071ce43f3fa
prerequisite-patch-id: 9e4bfe239b896239676462a48d32dacb209a56a6
prerequisite-patch-id: f1b3646b39c10f1f161375b8b776f6b66b8f33fb
prerequisite-patch-id: 736ad8d856f1cc2a83255a011d2db3460f1e85b1
prerequisite-patch-id: 48d62dd217e39eb066b3a06b194b4e381793127b
prerequisite-patch-id: 238957a0ff4ef34bbedf672ff67da8d662b01a67
prerequisite-patch-id: a5449cf3f19fa1b121198019fdb22fa0b6c48a49
prerequisite-patch-id: f346f8594746643ef30be1d361dcdacfb5be4e3c
prerequisite-patch-id: fb031f6f42836fbe1d60763a58b35097a2e9457c
prerequisite-patch-id: e29ec9929e742da830e4ee1fa808829774d8ee6a
prerequisite-patch-id: 0829766dcbc11378cad6c756a6cafd93070b992d
prerequisite-patch-id: 5dd8ec4c6093fd9a1e1737f9ba869ef3d188d5a2
prerequisite-patch-id: a680a3f9bf6c1588e3a62a17522be06a3cdeb079
prerequisite-patch-id: 07c39d390fb61e4eb8e80ee5f3836767a3f6680b
prerequisite-patch-id: 672a373a86d7a211e85859237d243347a2d13ce0
prerequisite-patch-id: d2e00f128353188d030f39b3658451c57bd9c913
prerequisite-patch-id: 7df183849b8a6d64f52d078856eb831e9634b566
prerequisite-patch-id: cd152cbdc8c9de5873e98789abc4caea7dc1c870
prerequisite-patch-id: 4818acfce4e354055ff924b0b89001d0e217cdc1
prerequisite-patch-id: bc0a866ecbe4ed2a47160ed7f4ccc873363f563e
prerequisite-patch-id: e8143557e487ccfe2e47984b2180fcc073809918
prerequisite-patch-id: d63803c13783916dfb1b749eeb1489375a7eb430
prerequisite-patch-id: 99377bd088a6e29960512c992d8230696d738590
prerequisite-patch-id: ed2518483f01f0318d05340c810dd00fa9ef11a6
prerequisite-patch-id: a8cf4b56e129d2f3c45f81c14cfa2303c4390b5d
prerequisite-patch-id: fe466966970d814fa39e382576d81581a12bccaf
prerequisite-patch-id: d93663ab1bf75a8195e277ee3a9ab94a8d7b2549
prerequisite-patch-id: 525e477a3d2b1ea716c1f4f11541b682d63b3cb2
prerequisite-patch-id: 1de02a8e6dcb59729482d47530ac88395cd170e1
prerequisite-patch-id: 0b210cacbae1c807bc8c451810694cbf04022b25
prerequisite-patch-id: c931ac7fbeed6e2726e13c9a6e2d9b3464b95c12
prerequisite-patch-id: 0aca217593ea6baafd4b06b6c0f9afbf072c6b3e
prerequisite-patch-id: 1459cd218e055ad892ace18ed623eba0f5edbd77
prerequisite-patch-id: c7fe9e344191cd37d3f9bc91e005efef0bec334f
prerequisite-patch-id: d663885e71ace7de915daee73c450a85ef4daa8f
prerequisite-patch-id: 3cf29e3f9c292f4eca2e6393d98670c216a22f41
prerequisite-patch-id: 182184449702b94beeade2526e691ea4c4eef7ed
-- 
2.47.0


