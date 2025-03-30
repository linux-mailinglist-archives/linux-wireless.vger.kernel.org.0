Return-Path: <linux-wireless+bounces-20977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633EAA75A68
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4481889DD1
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4661B87EE;
	Sun, 30 Mar 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8l0vV+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402C1EA65
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346550; cv=none; b=W6964wlIY5r5e9/LbawbQu4wzg79Q0Ch1P6qbX17hirDAvIoSxBfIpoYo8QWh4WgKXOL0n0XJy7jyH4KlmGa4dlXDdYzMr3KRAnUP61rrkhpY0wTXIllUHvkRrDN2xpHC2Hr46GU0JZY6lBZiAeVXeCVg7w/OQM8+iZAU6/flls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346550; c=relaxed/simple;
	bh=AVMm2l2BgstreQDTUsZKh9pbF9rfFdLGO5pLhuYFSFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NTswjYhCbCwpX7kg17rYSe44jyGgNljPvxYuiRymjiHWCFA433mzSfZhDVwYuj64vgPBIQq7nFg+cBh9h6d31U9796gpy7NY2vcq/UKiOPKECKASH0dyy85Okf+HjA8i7ZanqcLQI0zWZNYLAFSf0Fc4PPgWOG7tx9a+NZzJ15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8l0vV+v; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso6137121a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346547; x=1743951347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/qqn3Nzhwmxl7J814lmEXZ8DhWz3Yuhf/OAUTfBeJc=;
        b=R8l0vV+vcKkLvoH3QsXRM36jOgKKBeFWdKD7vfFC6zdzZBjoKfdf07glpqO7gY8weA
         BF8j0PlLnJOJAKZbzD/md/7InSPFoyxg9BVbi6M3YTHrVfVKxLtEwuYuKEbGArvCueZQ
         jz4nwE4Zm4ihGC2vEl0o1TLAj0oQaJnGwc/tfUHXDZq1qgE4lKr9NtagldTv4pjKgHTV
         FTiWDzA7K8gjlAKOUpWmXggz6HJ0EoGzZ4UbGHKTsd4VJx7xz0oRZh9E5nhmbTxLkm5P
         0hgBmVyuvdIUkHwmmiZkrCYKI+7hj27iu5CoiZAf26ZWd3hWabWU1DjRwIUpzUf+9AS5
         BrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346547; x=1743951347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/qqn3Nzhwmxl7J814lmEXZ8DhWz3Yuhf/OAUTfBeJc=;
        b=C03eu5QH62YdouMSkDw1gXNLK/h9W2TvEythDacxIr8sHIk33hx8CJ4Jv/ik6SZS4w
         A+8F1EfXII+wOWKt5Kzo9ij82koC9BGnQny+AtBFf/lN+KN22RhSuLgv9g0brSKn8LLj
         nthw2YTEtpP2ArcSRLcQZpPM0PdBciXtq1WUR2XlbrC9gzRY4B8uWpc+GXVL+m8tptyE
         PwxvAM/K6luHlxbrMEscfIWkQ6IfwCKKPRQmJxIYxidfYtHEvyNwOPwEFIDyu0nU9QTu
         el9Fl4MA/Kv82n10pYsBPapgc+3IFsJllv2yOkC9eQK0jnJdQrmeL/l+nf8q8mLoW/Zn
         9uJQ==
X-Gm-Message-State: AOJu0YzYuktkmgAbfBp0ALsqXqci6c3mKvkwrXRKprS/jti6hKMq+b4z
	hv8ErFP2RkTNFBvxljDIx2wvFBwwI2afMmYGXokZ34wSXDKvOyOZJSJlLw==
X-Gm-Gg: ASbGncv5Qym9G+7xyP9l/gHq0Je+gDIrN8iA5/ngKcRTGRoorxMpPBOcG/Qwe9VwV7E
	Uj+1emltdBUStiZNXR94IpQeWi3ArOPY9Zx11PXu98+u0cgl/GC0FO6KrP1Ce7JYmUbZCK5xkod
	HyrD5wYvtn+2fUX2Ol9PGvm9z959nDfZe3LTOn2YnG7xlUw11/8LZeSW1CNrxtQJAbc52Fq2gSR
	CsAwMFb+ovLVTsLSRwSUkpRBKrSRXFYSzFrTW3/mpy1hDP7lmzRh45KCUTyARnwY2oYCmOgSfhs
	6XRA4w4ieF6mVXsjuLhGn8LWMA+DEp9fgxjo6YSVMDHUwHycg5enqw==
X-Google-Smtp-Source: AGHT+IE89lgjLIt59+2glwAbBBXCUU+IaR5Z9fHJWmhexUt5eFpppfG3hdidyPBk35n76peAKmV5Xw==
X-Received: by 2002:a05:6402:40c5:b0:5e5:dea5:3eb2 with SMTP id 4fb4d7f45d1cf-5edfcead0acmr4022788a12.11.1743346546952;
        Sun, 30 Mar 2025 07:55:46 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b2034sm4332812a12.51.2025.03.30.07.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 07:55:46 -0700 (PDT)
Message-ID: <43c72109-2408-4989-bb99-c18ba1ca88f3@gmail.com>
Date: Sun, 30 Mar 2025 17:55:44 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 1/4] wifi: rtw88: usb: Enable switching the
 RTL8814AU to USB 3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Language: en-US
In-Reply-To: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Realtek wifi 5 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

The method used to switch the RTL8812AU also works for the RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c8092fa0d9f1..a78f59fcde58 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1094,7 +1094,8 @@ static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
 
 static bool rtw_usb3_chip_old(u8 chip_id)
 {
-	return chip_id == RTW_CHIP_TYPE_8812A;
+	return chip_id == RTW_CHIP_TYPE_8812A ||
+	       chip_id == RTW_CHIP_TYPE_8814A;
 }
 
 static bool rtw_usb3_chip_new(u8 chip_id)
-- 
2.49.0


