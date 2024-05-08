Return-Path: <linux-wireless+bounces-7328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13C8BFB3D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63222817F0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762B81AA2;
	Wed,  8 May 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS+U1S5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050C81721
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165211; cv=none; b=rU3szzuCGPxCk8GblapIlPnccHOBq8lyYCXZCqU4Spjvobvt2TcPKYH8Mz9JiRFgvK4R0rEUfNgQJ2ChgJFpg0ECn6KRKSEnE/PoWhydHleQsZqUApQ5hDqCR3eXPvrrAk6r0t4WkrgezVk5ixnLWMwybwB+iSWqOWt/g/Yx7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165211; c=relaxed/simple;
	bh=zXT+xq4Mvi907WjjhIn0J/rkMuLsPNfDBT9+UFpxLg4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ojwfBLOT7xpyXGb5fZEVq/zgWk3fDID/f/j37Fxy9feYf1pgr7JOkMcVEI2/TQDQvUPz2x3v/ruP2mwCNWjWUa9cgJwDTZgfpSm/WuxcBEZMrHVPByqtlynQBlCSe/zrU8ZSppwlKZY7VfG6GesG/GqmiNBK9YXoKdgtysDolyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS+U1S5d; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso38504961fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165208; x=1715770008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw6l9kJ6NcclEoT52Lub3HV9611mkhU543TWOCO7J4Y=;
        b=TS+U1S5dCFaoZYhlNDxLu+/DV8OMWqtQ/usFQbOs8ikRK/TsfCz79Uby5YoD0ef+gd
         00jagkRdOc5N+4H4xNTNxeZGdtf+W//fPeXIGviovf6NFtKjetNCnQclFj5E8td5L09C
         D1ik398g0bYcvTB3BmDK6pMe7y5vlTndInpAMvvJFgJlrHNA4g8XS8dbG11YMx2V2UEY
         k6uhQO/2J9aYjdNHi01vO13VIN74cLqfeTgkvN0c8HZglk67ZxpbFVVXF6/hUNkPgXb0
         JZFqDW1JwU5eciOQYHLALwMudnjVA2ee840rgSICHEKZffuZoQ49fI5dGHYfpv297nMQ
         JCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165208; x=1715770008;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yw6l9kJ6NcclEoT52Lub3HV9611mkhU543TWOCO7J4Y=;
        b=XXb1mqtwBpHBj9Vntv/tJFsRnFCKUnYfLFb7Xzp2CxQ2J2mq23Cd4fRYx75SPP//KZ
         O9fDazUxioJMr2hHra7klQXnTQIef08F+gCH31w/epbTgv+DVPDbcR9zRXfxOPG0yFfx
         3JKOuWwinoNQKGHt6OqVlBkkSnTks/Z5cf8eoQOQRJeLCYrQHzf5tBTRf/3JfMHDYr7V
         OouKkgEVvoxW9jVMn3AwK3iiff6iDRBALO67sCEcoDrRpow+zuOXfaDbNe1ukJLIMReY
         2zYOYxJk+0qs2ee7nS0q5XG5xIpHP2aEyA4hu2HvOiQHU2Q8FqirAzCdTuhj7qDY9jbZ
         O99A==
X-Gm-Message-State: AOJu0YwGCDV0W0G65Gcz9CjTOrye+BwKGVDsS0HYbRokj9rptVnNbSNx
	iV3wxmm+YOKuOxB2teix9Vka3pZUubFYfZIU0uv9n09RtVwVsmT/zP0wBQBI
X-Google-Smtp-Source: AGHT+IH1uvSTfFqVyS2+XGUA6xD2+a4QHPlGaBaM9cvVTppUDwH/Z8iYT0A8j1B7rX5UwSO2LmQW/g==
X-Received: by 2002:ac2:4291:0:b0:51d:3675:6a06 with SMTP id 2adb3069b0e04-5217cf3cbdfmr1606261e87.66.1715165207539;
        Wed, 08 May 2024 03:46:47 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id p2-20020ac24ec2000000b0051e1b40c17bsm2475125lfr.258.2024.05.08.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:46:47 -0700 (PDT)
Message-ID: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Date: Wed, 8 May 2024 13:46:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v5 00/11] wifi: rtlwifi: Add new rtl8192du driver
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add a driver for the RTL8192DU chip.

Power saving is disabled by default because it's not working.

Dual MAC chips are not tested.

Until Ping-Ke Shih will add the firmware to the linux-firmware
repository, the driver can be tested with the firmware from Larry
Finger's repository:
https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

v4 of the series also included the creation of the rtl8192d-common
module, but it was becoming too long. rtl8192d-common was sent
separately and it's merged already.

v5:
 - Call it 802.11n instead of 802.11an in the module description and
   Kconfig.
 - Patch 2 is new.

Bitterblue Smith (11):
  wifi: rtlwifi: Add rtl8192du/table.{c,h}
  wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
  wifi: rtlwifi: Add rtl8192du/hw.{c,h}
  wifi: rtlwifi: Add rtl8192du/phy.{c,h}
  wifi: rtlwifi: Add rtl8192du/trx.{c,h}
  wifi: rtlwifi: Add rtl8192du/rf.{c,h}
  wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
  wifi: rtlwifi: Add rtl8192du/dm.{c,h}
  wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and
    rtl_priv.cfg
  wifi: rtlwifi: Add rtl8192du/sw.{c,h}
  wifi: rtlwifi: Enable the new rtl8192du driver

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |    3 +-
 .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  123 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |   65 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1232 +++++++
 .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   24 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3181 +++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  244 ++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  397 ++
 .../realtek/rtlwifi/rtl8192du/table.c         | 1725 +++++++++
 .../realtek/rtlwifi/rtl8192du/table.h         |   29 +
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  377 ++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   12 +-
 25 files changed, 7577 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

-- 
2.44.0


