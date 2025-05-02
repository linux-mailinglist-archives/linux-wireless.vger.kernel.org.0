Return-Path: <linux-wireless+bounces-22365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54EAA7CA7
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1AA3B8ABD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4512222B6;
	Fri,  2 May 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRZQW/kP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9E221FDF
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228268; cv=none; b=TNrGQmVjLK4O+4SFuKxitEkPeYtd400sjJqFUIJBcjzxwKnDyS5ymyMrwmO0mbZp19CsEwRgKh3cdfPD+IZFXLRb+9aSIxxsjOZTXF18OBLKoEtinUHLk9F7zOeeru9M7Xuce0TNVgB4tudgdwTYqFnIBCFsDfw/TOtWKra5/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228268; c=relaxed/simple;
	bh=ma1aP1556opdaOmQbFsdFe80oHVgYvXnXxFoE7NBj4k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VPbSJ7rJ/ad7k/eUYIpjPpkXMzcXXm0fCcmIszdwNtE5Olp6px4Y5BGCKab990qhRuSwC1NlBRwvJ/ba959nOm1OIRKpb/hGYRWSqNXx2yDy0Mn1D11YY6z8sD0swU6IXj7OXwkM/rbaxG7YCGeSkOx2B66zmZ79/Mqk9mEV3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRZQW/kP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so2166146a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746228266; x=1746833066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmmaXuvUtscA4NwMTGoCdMw4USrOYNFunB6/Y8Is25Y=;
        b=TRZQW/kPYqRunVdkzf2DQLVV/62EqjOIrd2lhA2VaJVxNRuaiO4mf/+8cTp/ReR+Yk
         VgH2eNySrYIaOhLbf3hSw6Ab988I2czAq9dzAQV0F91ZvBQ5ABbZrdHq8mmDP7GKHBV3
         VV9PbY4FKf7T/bp2kyIXofmQZq236bE5njI6zEVUpeHi7c4QvrS7Czdjijr6USp0FRuI
         c0kGaf6rZXZiLOmWCiitJFm+8MvlHy1d4+WISmKMrz6R/qBD+IbrMPn3FMuzynx7L5v+
         KfhrCKOANTPxXa3+/f6JobjmYPLTeRKApx0Cts5TenmgZ2CwPsY2vS1HYitgKNeU5LBw
         zJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228266; x=1746833066;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmmaXuvUtscA4NwMTGoCdMw4USrOYNFunB6/Y8Is25Y=;
        b=o+O4tJn0OKVmS5Z7n6AFFNuTIxgilZSi9oV43ppUziGjr8L7eYbWjcsoWpopdJnfLx
         tv5qVq8aaiUxTV/rn99FP4EFF7Jegec4fv7Ni6i1U6zOlxYZmMiyKkl6ymMBriOmDVVx
         P9XCE+aYDmBkPYgdrAv5FSzt4vMdZ5POVDLKiCz4kZWOFqgkRPtENnrweLjtuVy2I2+d
         Jg7oV7OWP5Co0nnrIpopc8pYHLsmNz14+C8FlCuIlcgcB7A+bYOfx9vKOiMJYf3i1uDk
         kYG8cz2fURPHnE4uS1WXnHPIoxRgNTT3CuuBLtcwjhZGVGxsHG9oo9Yx+s63HJbPhdRC
         qw5A==
X-Gm-Message-State: AOJu0Yyjiy0W4Ld1ePNL2WPwl3bGcB8DsLKc2zzvJ9Q4eXUoCcPqZtEZ
	qZRhgU74UeV/QbVK8gwO+0R5PEcNBFcX5idwP8yGIBS9WuuO/GFqZQRyZqpYjYvdLKHBMQIrANv
	uoAKVjaj0XR0sL9B2Yey/SlC6zaAFJg==
X-Gm-Gg: ASbGncvT9lOO+V7gZT0cCzYimeLVH79j1UfROlhJIzXCvYZr1PgNLcuse3HirOeLP0h
	j+71kJKj7jggB8Fn6fC2ZqaD666C2jquMQMFQY9oPgGLkUe512qcQt9ma9W0U7ab3ZuSnBvxH1O
	47e9M82iSQ7XHbRfzyreEpHA==
X-Google-Smtp-Source: AGHT+IGCq+co31XgZy8j1WdqTbEQPeGmzgZvi5TBdGK9zKMNILpippM3qF+6075wRErLC8YdgWHSf1HO4c718yZuYqw=
X-Received: by 2002:a17:90b:224b:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-30a4e6877e7mr6191736a91.31.1746228266213; Fri, 02 May 2025
 16:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuuki NAGAO <wf.yn386@gmail.com>
Date: Sat, 3 May 2025 08:25:37 +0900
X-Gm-Features: ATxdqUHAkw9VQpghWVBcuqXG2TWrSLS0BKocX4HrMtJjpfDcnAVzoA1ROsXF7SM
Message-ID: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
Subject: [PATCH] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add VID/PID 0411/03d1 for recently released BUFFALO WI-U2-866DM USB
WiFi adapter.

Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 572d1f31832e..ab50b3c40562 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -77,6 +77,8 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
          .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /*
Mercusys MA30N */
        { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
          .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /*
D-Link DWA-T185 rev. A1 */
+       { USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff),
+         .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /*
BUFFALO WI-U2-866DM */
        {},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
--
2.43.0

