Return-Path: <linux-wireless+bounces-24673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C75AEE866
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EE7A500D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6C230BE4;
	Mon, 30 Jun 2025 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecO05Wgc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748613F9FB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315995; cv=none; b=uyRSULlIzzKfGwjOTx8KIhyjkEUrxz8/2xk8kVuNVpIgr62ZfB03pCOU+m0KaT3V884POnM5mAEgW207rV5sxomu+Vujl+xI8iotuJDYRajzGjlc0V+x9VSTlYi7SOumzUaoygzPJgvWSwMTHxRtdA33BS6U0ciQjF7tiHwGQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315995; c=relaxed/simple;
	bh=9N/PkEDwcA16zddYICe18jyXGcOhZRZ+SAcj1OF5xyo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iJUx/W9ZJBRzgPu4S855EyOX938cwL8dTRSjTFB2zZtaSv9n82u1Lsqe1TEM6J+uLfjoL8Qwi2b1rx+riAXfx+lyeHdQz/yRbwE66Jh1XvIE+LvViptx9rhBNpAojdq9WWE2BFzvc3G9QDhXPjfaJHny5bAXnEQM+ZqCZjNjN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecO05Wgc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45348bff79fso25521445e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751315992; x=1751920792; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULhqisocm7FwndLTDDRjzt94xXmR4/EbQof6/uvScwo=;
        b=ecO05Wgck5RSJCb+c+5WpH/L6wkcPgxEAoJib9nH+ezIXdCNKFzAFcquQlK8KPkcu9
         DI8g9feO7kfpKKEYZ4A62nyANr4wD4MeYLav9KhKbnjbeSJ4hvKbEhOV5l7PC9/uvNQL
         crcArgevCKE78B6VeQ588saeg0IX55gNilEKtrimUBY/d7dKwoiYAi2AuIoBHPdctxmg
         zGin4EiFm3GJ6gLdN++RpWqGsNnfFA0VImAoGwOPM+gVMbm7cEhdVWonLuIUibt7NOC/
         bHrI/jCSkLDZInij/XWZ0TULVwT0OX+9rdEvzBzlAHoeliOl6PkBnUxClMq1XgpsWYCp
         sz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751315992; x=1751920792;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULhqisocm7FwndLTDDRjzt94xXmR4/EbQof6/uvScwo=;
        b=B6fOY87HcYb6pNc/DOAvNG3N+6Bchg7R54mowhjX9Bb7VDZchh68t74hcmBHy5ZpQ9
         ke6vJpIH2FjuoLvA8AfaNyNhhtHq9lSSgU/tfHzK/LuXw1r92CP9A+9rQTur9LeeJQAy
         EyQWkk4+l8+aMDtKRxZHwgqb2zE10XbzDY/lwO5Y75vRT4g3Tp/Aj2b5sxTDdW8WdUas
         2ZJqbhn87LcdBfhWccdy51uYHnHqwYKQ0BBan23oiQKOcBRWgteLVHsOU17u0surIVo5
         l6zBxB5Q2thZAZxVC2uX78UilTfqtGy6O575LfaI6eT496GwHzM3kwhr4HtWTI2qJtB9
         ZwdA==
X-Gm-Message-State: AOJu0YyMbswv1kxeobR+1KUBvxO/2gASOuogGWiVMOXzr59ykV0Hx2fm
	cRqQkEoYlhwEJrmy12AUN5a8J+YiPuKS9TWTvZLON3afD3beUD31d1K0T/IDsg==
X-Gm-Gg: ASbGncsi2HA+pJJ9Ccf4KcLNRk3ElfOGjNHC0PH7509v3h7r882NzqbiHhkBl2fcojL
	eynNXMKwzfguB+Xn9e2zap8nJ0uEOjfnd7FL6jYzUUOCoUMh3ugESU+VxqCbofyqoA34HdO62KU
	n/G386w2rSw0KJ5jiAy57omQLVbMuqY6uWuwVA8pH+xvN5AQYDspVwnAH298GBK8V0EXmID1tLR
	JL7mIWvey5/FTYtqVoiJJCJwlp0XY0FQhhuwYo3Sw9/+Zwf47RkqAYvEOezZfc3RWn8P0RGeiXy
	WZXVJiMR+WmfxJ60ZtH3Q7G+xAUuvuJ+/I9Zx+YXNbd5TE9voyB5pjz/KSeOcRJKNBfoyODVmK1
	AOwqg
X-Google-Smtp-Source: AGHT+IH0wC6ck0NRO6TkHRJk+KzC3hAyKoqV+Tw+1i3HU8aei+GOcQR+++h5LtMCbYUmMkaTIKIRiw==
X-Received: by 2002:a05:600c:4fd6:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-4538ee4f9c5mr133306685e9.1.1751315991439;
        Mon, 30 Jun 2025 13:39:51 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0f3sm179084795e9.19.2025.06.30.13.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:39:51 -0700 (PDT)
Message-ID: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Date: Mon, 30 Jun 2025 23:39:49 +0300
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
Subject: [PATCH rtw-next v4 00/14] wifi: rtw89: Add support for USB devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for USB devices, starting with just RTL8851BU.
RTL8832BU/RTL8852BU can be supported easily later. RTL8832CU/RTL8852CU
can be supported as well, but it keeps losing the connection.

This is based on rtw88_usb, rtw89_pci, and the official rtl8851bu driver
v1.19.10-70-g84e35c28d.20231019 from here:
https://github.com/fofajardo/rtl8851bu

Bitterblue Smith (14):
  wifi: rtw89: 8851b: Accept USB devices and load their MAC address
  wifi: rtw89: Make dle_mem in rtw89_chip_info an array
  wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
  wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
  wifi: rtw89: Disable deep power saving for USB/SDIO
  wifi: rtw89: Add extra TX headroom for USB
  wifi: rtw89: Hide some errors when the device is unplugged
  wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
  wifi: rtw89: Fix rtw89_mac_power_switch() for USB
  wifi: rtw89: Add some definitions for USB
  wifi: rtw89: Add usb.{c,h}
  wifi: rtw89: Add rtw8851bu.c
  wifi: rtw89: Enable the new USB modules

 drivers/net/wireless/realtek/rtw89/Kconfig    |   14 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    6 +
 drivers/net/wireless/realtek/rtw89/core.c     |    6 +
 drivers/net/wireless/realtek/rtw89/core.h     |   17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   83 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c      |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   31 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  115 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 1042 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h      |   65 +
 19 files changed, 1399 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

-- 
2.49.0


