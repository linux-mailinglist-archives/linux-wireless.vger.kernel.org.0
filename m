Return-Path: <linux-wireless+bounces-28468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 983AAC28653
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 661AC4E27A9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97EE2FF678;
	Sat,  1 Nov 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6JPOeFn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BD2749F2
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025303; cv=none; b=oeYGnzU+nzp26qNRD2+TsdBHi4soLS5I6FNtQSvYkIpVJdGd6VjunaHUt0fMCG6j+ljqN9K9Jl4vcp+XK/g/4ZfCwfi9pd7KrjCOjpHTItQAKITa3RYPtf1Woabz6LXdhJug5/a3XtInMudGmtGVQo48krpREJHaxeDohAeyW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025303; c=relaxed/simple;
	bh=BD5Y0fJ7CQwcGnuOHwmTfLPCx5mRMzKC6TGiTQrZJRM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XN1OxKSl+WnVQgjP/LZjtqMjGafrCeKJI1Xm6DH4U9XLxE4hx7ZH9WyAO6gN5Yby+luHaG3+CgI7oyJY4a3PSMavXlrSNPci+aySyTMgIeWTmbh86pm7gm98jUQMSP2JTgrWExgGO8+qN+aE/6R9axOKWDLFSwMh4SwCk05Eb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6JPOeFn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47710acf715so15737265e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025300; x=1762630100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rx1WXIDZlMMhMnJprMHTd6q3GY5GMEu1H8fJ3KsQfhg=;
        b=L6JPOeFntodzlfJKptcq9ilalwDwsHJb2bd0SGf1UroHiezWQyLYGrVupu2OqTFI+Z
         pApU/kOpKTEvoiwrb6i7A5FpE8ScVbddRE6PwBdsX31mqf3fJOk6q+m5tGxU2OPL4VOR
         B2VXHRqoGVc94RmLQZAo6oI9JAb+jkx8oyMy20K88KnXVPXIo7KbNf/0ySXb7rqSFye6
         XrHMaQT2mvznbquZ2NxYgfG+83azfuDly3kyo7/TNoPa+wdHinPrQ4/+KL+ySbm48LAR
         Haen56ShqdFagLrSK6uV9WcbHgfIsbeMOttrGo37D7/a3UsVbbmtu+s2C/mySxO+v5L/
         xM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025300; x=1762630100;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx1WXIDZlMMhMnJprMHTd6q3GY5GMEu1H8fJ3KsQfhg=;
        b=hT+ClWK1oC1MmKwWFSm3xYpT001zym/iLfSSPgVk3fAFpKQG/nwl/XajJ5ribE9Y17
         B0jDNhiCnSiQNxfBAlKZ9jte3M1XwfAIXeahdxKVG/gz8ucqVGEzkgl5f0gKXGdqaEXt
         U98Q1Gy3qBv6COtoJZZ8oe7tXulG796OqN4fP+rSjsFH6Lrj/0140JTMW90tpEvDMtTl
         mbbsYALp1gVKYb3I9FXm0zLnktGcAo2tn+kK2oWzDzu5/xWB/onnVZDOwLrBxsEzRLxc
         7s7OdolDdF2L4A53hLqvwoODqazGumH4yxfIX7fCQ1tH9USHd5uK/xQ0LiClBbQkeL6z
         uzIQ==
X-Gm-Message-State: AOJu0Yz6+POnT6cFcN8a4VpaJ0rkt0fzFLdgxIbKfzEFzZOv0B6xWlE7
	G+/FFwc1BVT6TIx4rg0PUbzw2qHYHDl/LdMejJRm8awSfmglsjZs9ns5XMl1BA==
X-Gm-Gg: ASbGncuj8pNmOGM8VoyfTTa4dgTxK8w3V2TOkWadu3ZV4OnGAv9H0e3DGmom8Xtw8Td
	jnAnRQFUmjjYbljWZoArPRWdv2z0i76HAivlEs+jYBej2Jg9YWtl4+U6T1vmjP3i8/JKE01jVO2
	415HJBnBR6YvOEGcNaMt4b5uyOurTnsx6rBCLK00iASaDBZ1sEV6a22qmG2zevAnnTYlwEso2/v
	z+sPPY20ksAyZC+EEtz7xq7TEUGz9ScNFMJprKPp35rYuRqtRrWRLePsq98ZMoqMoklOa8TnV+E
	SvT6KsJI85Ex06/0ewn4lXksR+Okf8m5Cx585H8vD+WxJe/dvgJWAtSgQZqwvy+qbYtfKALOsqI
	zp4CUWlerSjAVy76q7iWfYL1Sed34F1eNtgeAlm6ifo6dgjHNn8O4K+vowyUpqL1EIm7CQ619pU
	qYfXN/bRwnHl/q4k94fp8=
X-Google-Smtp-Source: AGHT+IFfP3M1RYxydndVg0os2RGoYtOHufYdfv7BQD3i4dEfFtb73pZGGIigOJdCpsLwTLG7DMCUVQ==
X-Received: by 2002:a05:600c:3f92:b0:471:95a:60c9 with SMTP id 5b1f17b1804b1-477307b8665mr81747795e9.8.1762025299998;
        Sat, 01 Nov 2025 12:28:19 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd38c4esm46553425e9.12.2025.11.01.12.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:28:18 -0700 (PDT)
Message-ID: <859a45ce-2730-4eeb-99d2-37d7ff277bd7@gmail.com>
Date: Sat, 1 Nov 2025 21:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 12/12] wifi: rtw89: Enable the new rtw89_8852cu
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 4288c30b400a..e89f7481475a 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -121,6 +121,17 @@ config RTW89_8852CE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6E) adapter
 
+config RTW89_8852CU
+	tristate "Realtek 8852CU USB wireless network (Wi-Fi 6E) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8852C
+	help
+	  Select this option will enable support for 8852CU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6E) adapter
+
 config RTW89_8922AE
 	tristate "Realtek 8922AE/8922AE-VS PCI wireless network (Wi-Fi 7) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 23e43c444f69..e0d21972e57c 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -75,6 +75,9 @@ rtw89_8852c-objs := rtw8852c.o \
 obj-$(CONFIG_RTW89_8852CE) += rtw89_8852ce.o
 rtw89_8852ce-objs := rtw8852ce.o
 
+obj-$(CONFIG_RTW89_8852CU) += rtw89_8852cu.o
+rtw89_8852cu-objs := rtw8852cu.o
+
 obj-$(CONFIG_RTW89_8922A) += rtw89_8922a.o
 rtw89_8922a-objs := rtw8922a.o \
 		    rtw8922a_rfk.o
-- 
2.51.1


