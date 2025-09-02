Return-Path: <linux-wireless+bounces-26917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A4B3F31F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 05:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5820173B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84F722688C;
	Tue,  2 Sep 2025 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGsnJyma"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C294CB5B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785489; cv=none; b=PkPWaie6GWsZyh0y0h0W+ECQnjQeKb5XSN2ooU4b1xlWiABZaG/AhqTnsE/fWbnqJThuBS+SxkA9U1SGYJfxm5U0iAZJTUsNY4ATNOhOD//nQuM8dM/Nocfe8NTuUHy4TIX8RKpj70RahvRMJGEc0ABvXnc9vSiZJ2igKiGop5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785489; c=relaxed/simple;
	bh=OQZxChUCz+CEJunvBz7suiSFaRoy6zAIK3l9dCqQa9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ml0sUkGHK4656P1pwKRJ5SiSt3LHKPhzsSB9eowMKZSEByFzuapTKig6vFEcWP6TGqXR9iWceBJIK+3++OK4Q7x6Go3nTkEqBMVFbXa+t1rETL/R+IYuqlCMVb/aqr54A3aPXck1RsEYC7fzAGNB03MHuhNi2WwJ4ruJ28gN4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGsnJyma; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e09f58so5224592a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785487; x=1757390287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg6NyJ2E/NCaNhsEXDHHMEh9GnRGIVz6ZRtRtR3FjMI=;
        b=AGsnJymaMBGveN/4cz83/aY2lMh8fo1agDBnjBb5v//ba2zYOJul/fpambtZ/pwhs5
         /Akt14JTcWszUaTs5c8pJbPAB/3PqReEx4yFKYKdBihgeXXJK0PdrUJT/Lo0KcflTeIY
         pbNEfybSiCfdMiV4GK1wra/z4fBvsW66XH5cLjBGFQsH9ymJ25Z+97DHQZh1q1JtC+R4
         kRy2/HmjjTdllnC3r0lemlawSYh73LjmtnICHqYboML1gpaRwOp8WhA0ze6UV/3/Z4TL
         D5ku6VUZWuzCGk4FX8Uwa8rnD0vJBUk8HuF77jXoPBDvAou7FdELHdE6Boia9tRPdYZE
         1kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785487; x=1757390287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg6NyJ2E/NCaNhsEXDHHMEh9GnRGIVz6ZRtRtR3FjMI=;
        b=sIbxOVNi6Q/P7RDd8mqCo2I/EPQ+WN7IEU89z24Iy9jHI4N0PNNrESkIUvc3Xzyz6H
         WydCrOuKaGQ9yrjnndPXThyoaQZU4MZD2ULvP+evNGOy7uqTXXaSIu9QwPpPKAD7NrC4
         pGr9U27XcVGNCZF4er4dukKl3AtHH5GiOp0xiFfoX0yF2ypgSVoJfSOGHPnZ3ixvXRWn
         v2DDGy//NthZ28K6aJ23oYgX3oeqq3A7x9g2sJV6ipZZgykXvQhKD4BO6MRwl+vw8l3p
         MeaefthbShmNbH9cy0xZJajmdg7hKRUvyyzaJvLlp+0gp9gM5hEm2enGYbXp6EXTyyCn
         pT6w==
X-Gm-Message-State: AOJu0Yz4d5uD2Ta0VFBEUB3tkk/ksoSr98JqZIGHdk4eCrEdSQLnoip6
	+Lf4gF4gYYodAKaNG9vj1c2WxvWQyQjgran4hbNgZ/CvxAo2VcWu+iVEj9dK/w==
X-Gm-Gg: ASbGncuyWvL5KrKUhj/h7QL6mCHwr8qdKJqx2WSCuu5gOvgYYmHZWiPzmp5kjKeeiYe
	sPKxxXB32edrLjHyod243RbaAJfvMFYwfBNjt7sZwOv72brcpCRCkupjfYmzb4uzw2GaNRPfi9R
	rqqaON93Fnj8sBkOYLVb6kEvJfojobnTScOREVwGAjK+BWgI+WtapvgZrUbrioRpyVgf8ikhiGf
	MLrj+XbWehkBwAwITP+Bjie7jKy5id7ke5jX671yimoJ2dyIih7TC9LBlbdkfj47RoQOPhjz+hq
	UB8JT/UN2MwnCWkTYisBLIl7oypX3bPK8v1sQRK+XGS/zFUaq0OrgEWLG0If+AXKr3FJGG9sUir
	qgYENfcI/eoU8Q5SYptlhIf6jGT4FZ0el3kcHgCBLKItlG8HnNia1
X-Google-Smtp-Source: AGHT+IFaVajyEpOAn4xa+hm4ZzmJk6m9D2vltaVBjQaguSH5thYdxXnK+Zpym2NjTQkDh7avwDOfuQ==
X-Received: by 2002:a17:903:1d2:b0:246:1f24:5f56 with SMTP id d9443c01a7336-2494486f4a5mr128387435ad.7.1756785487212;
        Mon, 01 Sep 2025 20:58:07 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm19702085ad.138.2025.09.01.20.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:58:06 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next v2] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
Date: Tue,  2 Sep 2025 11:57:55 +0800
Message-ID: <20250902035755.1969530-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
Wi-Fi adapter.

Only managed mode and AP mode are tested and it works in both.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Sort the VID/PID by alphanumeric order
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index c3722547c..04e1ab13b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -16,6 +16,9 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 static const struct usb_device_id rtw_8851bu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* D-Link AX9U rev. A1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	/* TP-Link Archer TX10UB Nano */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
-- 
2.51.0


