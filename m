Return-Path: <linux-wireless+bounces-30666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80AD10321
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 01:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15210300078C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F21E2606;
	Mon, 12 Jan 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2gwTtZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5EE1E231E
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768178886; cv=none; b=j06g9eYeKMfpbaVHLZs3nPpBuMqfRFwBGWkEb+hoIY3h6oUI31eKGS90cJU11+Y2zqJPqxhr6nst9beUjLq9bs2HTolH4NfcEK1aZCeUw4ccSEPX+aQC/+74XaYEhx1wFlFVKMWAkQVommnXZM54vCxcCBzgE7ZEiy2OOiz28ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768178886; c=relaxed/simple;
	bh=wBq6+ErrkEa8/rXPEkjB07oq+CR61dEnSX57GX96fY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTQ8a4HeTGjoWsswTe3PF8SWi0E13+AHmO/1XPd4g4Fs9oU9IZh59qq/pMPTs3kuFQfdhcV5ctmgjvqiP4WTtJ1xS5TtcmhrFDWxJDo5CLDCu/FzgfJM0eiulTPyeVHaJxaRjlg7mfpXTZhr4J/+NCBOFCOHl3diVWzG15/FDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2gwTtZ9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a33d0585so36881055ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768178884; x=1768783684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODlLbjMyUFvBRwcS6LIqiN1bX2cNJolNyobTlkLjNwI=;
        b=j2gwTtZ9yhsCNl2eOvyidtbR7NIZhHBM7JFlVg8QXVm2bjftuYk34qLEFeLlk7/sFk
         Sdth9IjT5urDAWjLlgn6BBqicjhK2Yd2xst9sjFOTl3n7fCpQ1mq6qHQEIJEV9ibVgrB
         xzQIaVAA1/0sSslEA7zIX/qXEoTwxAUPtBieOeXLrhXjNCKq1/0ZuJIPu0jR/c4bmq6V
         fKgI4wBJ64vgM4aRsCuMVmrVer1tJkYKbI8wzzmmY2RLdyimR/b+vKZLChlJbjiIwkDy
         PwEm/eM9RZa6YtDm8bl2rCKLrcw0gQEWfhZVQ5HL9DSA8QXWH+WGoym2B2SXfZ2RFLuq
         uToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768178884; x=1768783684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODlLbjMyUFvBRwcS6LIqiN1bX2cNJolNyobTlkLjNwI=;
        b=IiEpKcMJqici+VPa08Zo9QbdqL68TYFedLTJlOJPWt2BQt6W9KJwzp4kDGNzHhuxFo
         NpeGZl9kOrUDfXh0YSLXPMIBop5f3jO2sf/6HcrCIpwSO3/+7QN/r0tuzZg0K2VFvmgt
         fxkkmhr18XXGH+Oaz6h1e/YjFYlKOO6poGvVJjtSyzUhRv0MksaschbV9DUerY15/8yV
         cDbC1zF4aK7bt6kuSUVVAiaPnsSx1KBcsHTM/YLBVmTi5x+CsDYEnc/AD6HCMpxsO17A
         SijlF+heOa651z8D3+Vu4eYGCASGck/wHAnCewjuHpRKMGTs8wuyYY08ggq5cx2CnYM8
         RjBw==
X-Gm-Message-State: AOJu0YxzelJx98BBFsC36OjBc3zED0YxYmtWQfLV0TxZPpuBktdwSz18
	dhqHU4X0fafkcW0c8jMFNGFPAHAxQKdeLsIP5eSOrwBYPmvKUZhCkJ0fh2Y+Lxzn
X-Gm-Gg: AY/fxX7gl0oVVX+2kNzYBfOajIql6PhxAXdzD5stUS3xED29FrldC0QH+Lg9wHncU+e
	dznjE3d2qJ1yrmjvKWQxJCgmDzio5dqkQ8peY+K4j0WlFwPwouvmxMqfSQz66RlyKTDLoNECAr5
	ZCDxVtU+5ex5isQvxnjpMEE8a5BcNg20kGrIr/ev5FpoIqMpnKwqhbpud9fTcMfm5DrDPLPlLMI
	gl5dAaLPwwvz5WBCEVdaaroXJ1imRzatY1YNAM0VVGH+c/Y+m+KHsaNdojzrJ93SlE8NNt4Gub9
	3ucvYf8wZ70lxBwXCzYMikW7SrAJt9aJO+E/aoaX/AToueND47xC0C4rLaJ4qL0GggjH3nYxS+0
	nysekLYZgpyuWe/Imp6jMTgzlEAVcManqoxFOk42Or0heHDgh5XIYK8l5ZRmL3AOya3nmDSf5sG
	d/RhhgTQ7WSb30MUicsqD793dXos7dDL7JziN7wSgNhA==
X-Google-Smtp-Source: AGHT+IED2Xk8eWzqzupEFIvijGrkU6khXTt+FXqmgv9kR91Xd1+XQLqZ4E0B8mX1u9M9kK1tM8pB5g==
X-Received: by 2002:a17:902:daca:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a3ee443bf0mr172824265ad.25.1768178884460;
        Sun, 11 Jan 2026 16:48:04 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a3e3cd4a41sm41767785ad.100.2026.01.11.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 16:48:04 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	xirxes@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)
Date: Mon, 12 Jan 2026 08:47:59 +0800
Message-ID: <20260112004759.6028-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID 2001:3323 to the table to support an additional RTL8832AU
adapter: D-Link VR Air Bridge (DWA-F18).

Compile tested only.

Link: https://github.com/morrownr/rtw89/pull/44
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index 74a976c98..ccdbcc178 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -52,6 +52,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3321, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3323, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332c, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x013f, 0xff, 0xff, 0xff),
-- 
2.52.0


