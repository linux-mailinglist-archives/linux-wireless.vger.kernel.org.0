Return-Path: <linux-wireless+bounces-14741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2989B6C03
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2051C23B05
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54A1C7B68;
	Wed, 30 Oct 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSsJPUHa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F701C6882
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312588; cv=none; b=BxCcozW2XwTzkHtWFbyqMm3fbIfYYIeOuWB23vbhtKoGtgAH9hm5bOTmOmsE11NmxuaxeqOrR9KE1jsYE7UkeAQdOgMCmFVwQ9mA6KaVVbOwron7qMU08l75Bo1u5qpSBpLbkig51LpzNVmu9FI50O5dnUkhMGPURo2sx4q3pnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312588; c=relaxed/simple;
	bh=vZjsJ0NfBc1yFPWXtGDnPPXAQfTrWYdDQ9lJhqmYbGo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kVlV+Wa7dYEdre02yxloajPbeYEJ9laT2/VtvU6oUZV5yfnakutEsLLUL329FEwMcA9OqrBT3GcVazmYWiM8zZy0Xhffi8f/8poYNjeLAyqnjHp4BwnAr43f7JrMDkJCYS6rKcJQDiPaQaXjpw3SwB0w0GB7u+22ENjFu2cQ5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSsJPUHa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9acafdb745so25947666b.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312585; x=1730917385; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUCllSXuxm0wWfHQQyxTQuB6fBz5bYeD2es9PUio+n8=;
        b=gSsJPUHavXfZ0zZht+hmQwoTMsHibJ06AoR74l781xKIKmDFnuaX648znwNEF1cZ6S
         A9vIIOdlfY/HwDcsibgj3kGH5/Jq0qtXAMqgxWItJ4XQS/UPRUUazdMuIuXpaUxghLjO
         k+PPILlpnphXUT5oArG5lgc0HPvAoXErFcKWId++0ny/rxLa/tJpktRQGI2AqInJjEWf
         TX4v4FqdQMo2tNhY6NiJd8TJT3vIR1MKROgV84lrPhOuGlRB5pIwE8J+HvdemXcJROqv
         /4czErd1jVmEK/eVZPR/C0ycegIbctQCt5YX8DkQ8fpbNcugeqMIXmLEX9Mga03Pp4Jn
         Wung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312585; x=1730917385;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUCllSXuxm0wWfHQQyxTQuB6fBz5bYeD2es9PUio+n8=;
        b=W72DwB80UQ7Bbq05ezfiJH/CZ80ZopwWxgV96mDhm8iodZOXY5CZiabk5CFEskSaI0
         5BEdugUw1Bu5E0i+PPlRSAcaSmrTCbBLtKzIaxFPJdMC50/Q5UYLsZBFxeubEgQftqb6
         4l8+PRDZgelw+V+PnTgssZSEAjiAClemDpkKCdcew83KAF00cv1WYDMV5BY1W0aTAQkQ
         FdtI7lnSBwKs8+hprtbXNLFwm1gqub0j6gw9AWDbr0W1iMhF9JCeYCRffcwO9UlLTr6I
         qfU/DVVoZv2R97wFGHQM1HBCSUXRYFExLQdPJ2psUxtmyTwp4KdB6db9e/nOIB4bg90O
         b5rA==
X-Gm-Message-State: AOJu0YzMsXA2XCDV/22+GaJ9ie0fn9BfpuJKjjfymzh1gM37FJxklFKe
	2Z9HTsRSlHaeu8GIBD/qOG6iJCGjJKHdIB6mPeG8u6rJzZIXiWPmXG9uqg==
X-Google-Smtp-Source: AGHT+IFDwuESoGm/FP/jhQdbkdSp7A241usYTLzu3pYeDTQTL5MsNIX+eFOjl488dcT8b3Anb25kOQ==
X-Received: by 2002:a17:907:7d8a:b0:a99:f777:c6ef with SMTP id a640c23a62f3a-a9e2b32edb1mr656694966b.3.1730312584629;
        Wed, 30 Oct 2024 11:23:04 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9afcef10efsm591790666b.0.2024.10.30.11.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:23:04 -0700 (PDT)
Message-ID: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
Date: Wed, 30 Oct 2024 20:23:02 +0200
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
Subject: [PATCH v4 0/7] wifi: rtw88: Add support for RTL8821AU and RTL8812AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are five new modules: rtw88_88xxa, which contains shared code,
rtw88_8821a and rtw88_8812a, which contain code specific to each chip,
rtw88_8821au, and rtw88_8812au.

More device IDs will be added later.

Also to be added later: USB 3 support for RTL8812AU and RX aggregation
for both chips.

Bitterblue Smith (7):
  wifi: rtw88: Add rtw8812a_table.{c,h}
  wifi: rtw88: Add rtw8821a_table.{c,h}
  wifi: rtw88: Add rtw88xxa.{c,h}
  wifi: rtw88: Add rtw8821a.{c,h}
  wifi: rtw88: Add rtw8812a.{c,h}
  wifi: rtw88: Add rtw8821au.c and rtw8812au.c
  wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile   |   15 +
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
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 1989 ++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h |  175 +
 14 files changed, 9796 insertions(+)
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


