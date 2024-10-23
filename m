Return-Path: <linux-wireless+bounces-14390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 493579ACBC7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60BEB223FD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367771AC885;
	Wed, 23 Oct 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmlvsYvt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A4154439
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691962; cv=none; b=mxfGNRNPGVBRyORO3ntde1MprhdR/xGExfxDfZ3bZ/7z4PGDQUkwND5VYrjF2zDXZd8Q996CYTkORBTpI3MWPKzmsQSvAFVBq2mYvKE8VBoGGMoXnM08qcuLwdlX1JTU2hCBZN3KS/4YJiGdrXzTpyTCc5whyz4n+QEzDai7l6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691962; c=relaxed/simple;
	bh=wyz8z+fQG0nQqsYS8loNgn+Fd20tbUJw+LRqV8WmgmM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NX/Dv+64d7d6hmNDg7olz7So01wZO+OoAYo+bVBjmWyMm/3vftKHRqkOKaPv1Cehit+al00xdhH4JAAzDRIruHkkZaIR16Mwk1tP2mVMpN8bEpECbZMigQ7G8uRET0Vw1Oy9jFCbpvekUXPWzvBtEOEZkohcYQD54zOBvUXveWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmlvsYvt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so8008515a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729691959; x=1730296759; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+5kDRWBF9TvX1igWMuh7G2PHBH1Oa3fpxMjemnvDBs=;
        b=XmlvsYvtc7qNg6oH5lDx1EUc0FKMKAQihVPSIZ3OWNrkEl8l1+x3z5TFLcnikAEqUc
         VTPqiRdi2MUz8fxOjY8DzYHqoWIgoafRb7VTrg76s6nFEP448fr/ff//6kcA0Fhod11B
         ym/U71TVQ65ONMiFyr8MMu7QjLxdkGjVFnP7LgE9xvoSR5c/SuAIJOkNtJjj4lD3/PQb
         ApsxLKFRnmnWdgmeph1q7s2Tg9fKyTLWnxdUvgk2XS7VzQLfUKWNEsJDX5mYlLxisGWt
         LmJ3Ojq7BIpga8YTqb1mLD9rggA7lRVYhY3o/YZc7/0UzGuDzCSEMrzVALdZpSwglrbY
         CCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729691959; x=1730296759;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+5kDRWBF9TvX1igWMuh7G2PHBH1Oa3fpxMjemnvDBs=;
        b=WIUpgatAKciCWnHOunlsuyB/6AVkKg9UQS2XJDXTbzsNDdAQkqGI+9RbKRt4RrGL/7
         jcI2Th1tEQWC7kJ1ddxVIRArL29ezYNKpH3c63FwhRgkCTAvd2rMXoNl1meOgZZ2+G3N
         C4wqL4+qldzER+h0kPGQszJBEBk9Zo3gwTS/LaZXLgvk/zOkRholieKdl1LJ3+kRC28C
         Ash3+5sJJpmjW31ygmdE4OEinXGaivpV3umxcS6LrQvBCiiOewuy6PP6pLc4RwNt3Wdy
         TBbwStR8DkTr3C6o/waOyoL9qH4QeUqjZFygXcxhJpE1g3cEjGwahPYrfxY+lqUILARV
         xRdw==
X-Gm-Message-State: AOJu0Yye+V9C0Fdu9xqGKNPdJLRC2nDltRagL5Rdi7qIKxHd9OfNSrY5
	JoLLHbHAW9hbRwHnW9zhGOMtveqrKEQj9I4pd+hkV8ZZDe5QgszycvA0kg==
X-Google-Smtp-Source: AGHT+IGTZS+ZL2Lukzkedm+2DahdQCix050/d7WjG7sB7BXXJf4ltelq6YgA/7Igqnw5N/MuLAbogw==
X-Received: by 2002:a05:6402:2792:b0:5c9:39d8:58b3 with SMTP id 4fb4d7f45d1cf-5cb8b26317dmr2183928a12.23.1729691958308;
        Wed, 23 Oct 2024 06:59:18 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b51asm4530959a12.6.2024.10.23.06.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:59:17 -0700 (PDT)
Message-ID: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Date: Wed, 23 Oct 2024 16:59:16 +0300
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
Subject: [PATCH v3 00/22] wifi: rtw88: Add support for RTL8821AU and RTL8812AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patches 1..15 prepare things, patches 16..21 add the new files,
and patch 22 enables their compilation.

There are five new modules: rtw88_88xxa, which contains shared code,
rtw88_8821a and rtw88_8812a, which contain code specific to each chip,
rtw88_8821au, and rtw88_8812au.

More device IDs will be added later because they are not my patches
and I assume they won't need (as m)any revisions. 22 patches is already
a lot.

Also to be added later: USB 3 support for RTL8812AU and RX aggregation
for both chips.

Bitterblue Smith (22):
  wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
  wifi: rtw88: Dump the HW features only for some chips
  wifi: rtw88: Allow different C2H RA report sizes
  wifi: rtw88: Extend the init table parsing for RTL8812AU
  wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
  wifi: rtw88: Let each driver control the power on/off process
  wifi: rtw88: Enable data rate fallback for older chips
  wifi: rtw88: Make txagc_remnant_ofdm an array
  wifi: rtw88: Support TX page sizes bigger than 128
  wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
  wifi: rtw88: usb: Set pkt_info.ls for the reserved page
  wifi: rtw88: Detect beacon loss with chips other than 8822c
  wifi: rtw88: coex: Support chips without a scoreboard
  wifi: rtw88: 8821a: Regularly ask for BT info updates
  wifi: rtw88: 8812a: Mitigate beacon loss
  wifi: rtw88: Add rtw8812a_table.{c,h}
  wifi: rtw88: Add rtw8821a_table.{c,h}
  wifi: rtw88: Add rtw88xxa.{c,h}
  wifi: rtw88: Add rtw8821a.{c,h}
  wifi: rtw88: Add rtw8812a.{c,h}
  wifi: rtw88: Add rtw8821au.c and rtw8812au.c
  wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile   |   15 +
 drivers/net/wireless/realtek/rtw88/coex.c     |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h     |   11 +
 drivers/net/wireless/realtek/rtw88/debug.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |   44 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |   17 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |   13 +-
 drivers/net/wireless/realtek/rtw88/mac.h      |    3 +
 drivers/net/wireless/realtek/rtw88/main.c     |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   39 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |   76 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  174 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 1102 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.h |   10 +
 .../wireless/realtek/rtw88/rtw8812a_table.c   | 2812 +++++++++++++++++
 .../wireless/realtek/rtw88/rtw8812a_table.h   |   26 +
 .../net/wireless/realtek/rtw88/rtw8812au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 1197 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h |   10 +
 .../wireless/realtek/rtw88/rtw8821a_table.c   | 2350 ++++++++++++++
 .../wireless/realtek/rtw88/rtw8821a_table.h   |   21 +
 .../net/wireless/realtek/rtw88/rtw8821au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |   24 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 1989 ++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h |  175 +
 drivers/net/wireless/realtek/rtw88/sdio.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |    5 +-
 38 files changed, 10277 insertions(+), 140 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h

-- 
2.46.0


