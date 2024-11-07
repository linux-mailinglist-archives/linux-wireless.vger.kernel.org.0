Return-Path: <linux-wireless+bounces-15022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DA9BFABF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D8283B5A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4485EC0;
	Thu,  7 Nov 2024 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8oyJtXZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D872119;
	Thu,  7 Nov 2024 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939338; cv=none; b=j26x2MqV6N5mDQr3poWySx5SUa8fBhxZfnWFlH/kT+q7n72SDdHtN8qZDcphnNXCB04Irio1PcZ7keMToQt1awNUzIbDN/Okpl28NVJ3unUy8hxAq5RwaFuQYDfipUdk1lLJUqzspUhFALeWOQIw2GhIjZNGwPefE17Ki83aJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939338; c=relaxed/simple;
	bh=u+V3TUjDT6tl4Qikv/xjO+hVpAehJbG1ZbBddW98Vk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cj6aFN9e1yNKXAs+dN/VEBagJKrC0uRudML3d0WYjODg0kK5Ic2ZRJ2fCA9dwtmhVng/+OO58PEKRpOTr+CdI1E4I0JXNweaLPdpqjAW22fNeepPUQn502oLi6il4X/Kg6cYhSiZXd5YxTcr+2F5PgQaEfZzy4/91VNgtioUxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8oyJtXZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720d01caa66so319359b3a.2;
        Wed, 06 Nov 2024 16:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730939336; x=1731544136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYXzdk9lxwEoLysvepNqwx+im1UnVK9BIgVBiniSw/M=;
        b=Z8oyJtXZdNUzQHfksM0tuUmNj9R/AMEGDlV8xdi0ano0AwZlIPCiW1fQzmYBzVh6wC
         lPhDcGNKywp11G315Du674a6wpcSxf6A7z9DXxn3eWfz9mSyZ7usEe9oZQB19F+0jRcf
         2hCVnSghf2OoDOr2Bga3VAW2KTpSA3n5kjaEXc6RNGkw1LXeczY8dAZZHA7iNpkDuy66
         RQWIJ0jeWqHFOxlT4jyRrHfRc5uWYalVEePvS03S6CAbDQjPEiCGCkfi1B8RZHFqoKhU
         MnHCdfwk7QzoELdROd2EKbx3S0HhKg8VN0Dgf0fNSM1dbTVYlIBVKIkzdFS+KpoSUvui
         oepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730939336; x=1731544136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYXzdk9lxwEoLysvepNqwx+im1UnVK9BIgVBiniSw/M=;
        b=WhZP2IfYGH1nYh88suvyVm5dynJev5qd5FT75rnSYX1+qphCoVgP8tX96IGJf1xTG7
         uuiRr4+8zvgTFt2CKUMX2S2c9fut5HbAlXJGdrcCS4b/rgqbsBPlH2NehOdVv63g4fN2
         ZjW9agKdGN7/0+eIEZqq/ERWQXOimFIgAUiWKShIvd1PLh5jweg3/619EczV3h8Vlx11
         daFwfzOjg7cxYjju2++YHTUi1frRRsHzuOMV75YIMt9krY0+1rZM2PTB0xBE2pFtYb9o
         gdl+YJ/FlhXpUlOBONQvqXBZgOCWBtRsyJ/0FAdyTCF1PgLQfuZda5HJAg4cUMgk8txh
         lGpA==
X-Gm-Message-State: AOJu0Yx6nMvW/J/jiRszKhDnx78v8hpeuW+dsU4fOJCzCEmQAaPWx6Mw
	ZX/2eFlFwDGQZ3on25RmatBgUlzZUdTO4xCDjN/Ni0zd2Hs6JT7/lTuw7JRWwLs=
X-Google-Smtp-Source: AGHT+IFH4AqsCRrHFg+2hmItJf3mAhC5s4wEgBOgd57FXKle0PnJ4fPQXbBqMcItUqW06CTs2FG5Dg==
X-Received: by 2002:a05:6a00:2344:b0:71e:581f:7d7e with SMTP id d2e1a72fcca58-724080f8673mr214059b3a.15.1730939336165;
        Wed, 06 Nov 2024 16:28:56 -0800 (PST)
Received: from localhost.localdomain ([1.200.148.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72407a56a3esm150255b3a.176.2024.11.06.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 16:28:55 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pkshih@realtek.com,
	kvalo@kernel.org,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	m.novosyolov@rosalinux.ru,
	zenmchen@gmail.com
Subject: [PATCH] wifi: rtw88: Add additional USB IDs for RTL8812BU
Date: Thu,  7 Nov 2024 08:28:46 +0800
Message-ID: <20241107002846.13748-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nick Morrow <usbwifi2024@gmail.com>

Add three additional USB IDs found in
https://github.com/morrownr/88x2bu-20210702
to support more RTL8812BU devices.

Signed-off-by: Nick Morrow <usbwifi2024@gmail.com>
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index ab620a0b1dfc..8883300fc6ad 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -67,6 +67,12 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* LiteOn */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x808a, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* TRENDnet TEW-808UBM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x805a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* TRENDnet TEW-805UBH */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4011, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* ELECOM WDB-867DU3S */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0107, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30H */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.46.2


