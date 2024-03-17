Return-Path: <linux-wireless+bounces-4807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51287DF4F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FD51F21054
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12E1CD3F;
	Sun, 17 Mar 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpILxV7b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAC1CD2A
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701052; cv=none; b=nWeWwQDTMeFbs8D7zUN0BSnxyP9XF0U9Pyz9l+9oY0xuKXGJrQHRjTG++T10sN/EOlojuK/11Zo5dB6f5mOXPeRW5lmwYYJavK9eS5Aqra2CnjYK3/rVwfQZWt0GETwPdeepY4//5jcUP/mlM/fpXDdgYsdAF7MWadOxD7fZVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701052; c=relaxed/simple;
	bh=25p03pPbOk82cGYc3a3hpNj57n3sYHhitao67hn9EZo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BJuz9KQki7Am9nXL9mQjbMZ9ZVuFImUtO8IyvaqE0WvGr2qFy+GQcqYPnIzHHKHL36Qu9EU9IlwrK+igGkrVN4xhCaMK8g1Sf1M8TlBjl5ilFxuqS2zITG3bgWbBeZw7x8loPlNGy3potdSpqPGX3D5lEFGG5k0fhrV+iVPxQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpILxV7b; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568a42133d8so3759436a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701049; x=1711305849; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyfOJBez2P/5YdB/VRhJH7F7mglQbrkLwc1SvLr1y/Y=;
        b=kpILxV7bmwNaDUTn2DgxLs32d4p6z+FcivGiXy7HrDh5YVa/VHgcCgEFwaWcJUfF9u
         QexaXT8oGIQP8uthDPA+ksTdY3LEtVz6aYCoWs2i2citzE3jF8jLF+AQUs2Sr0HV6nBO
         WG9jUXQxwHknFbhRQq6rHhH5dq8o2hXXtdl+gWfPqQAE7Lj0i1w2UIRVn6cs/5u8yslM
         oGZ7mi9nXZaMpbqkXIqqKXneaZE+AeFQiGBg2qnPdnBMuYhqGBq75Nnj5UFOB4rZLDeD
         6gMEachLXYdiAaIg/tlC842mMtEsd+/pTAMOY5IlHDnNNDS/svjyYWCfJCJMznRM1BTp
         c5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701049; x=1711305849;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyfOJBez2P/5YdB/VRhJH7F7mglQbrkLwc1SvLr1y/Y=;
        b=um2YIUG/kxxA1wptErbwN76n6Xlh1d2jkI1TNxxFo/xkwgFZdizHSUdKhPWNnhCXML
         vizNg8ftcpLG7+gP8RJcrgIaH6H/KiuBBMb1IKkudXqudd7rKZot6J17Iust+CyEVQaM
         F1Sao9MgKsQLtcjMw9ShEwLWEIeqtLveU03EIGmkTRh6QQw6MjMovjllU369jL4WYyI3
         cmRu+2C/RPnBATy3INEaDn16pZYVkdVjo5U5SzFR1tIo8QYRpzGlFOgCao1q/MmLzJhH
         FXF31it/+UcdIX+f2RBWDJDkXEHn5s7LIuUwqOteW+EgKQ3v+uDYZscDSQU67mzAP3jL
         eFKg==
X-Gm-Message-State: AOJu0YxmX5qSs4b5fJ0ctYtjpwa07wJSNhBqqfm4eTMW0noMU2/Ixrir
	q7IHwhG49zl4iSFX1VKBUTorV7mbExU8MDB7mEIP4PGl3STckT3Pw2MNYKEE
X-Google-Smtp-Source: AGHT+IHxBISFZ8/fRaTEGjcGxjbjYjYjwAYVseiJB1X5bAdpS8tljAP/AuNgYXdMa+XCOUa5RVtgtg==
X-Received: by 2002:a05:6402:50d0:b0:568:d55c:1bb3 with SMTP id h16-20020a05640250d000b00568d55c1bb3mr1182947edb.31.1710701049038;
        Sun, 17 Mar 2024 11:44:09 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b00568cee4a83dsm1017622edr.80.2024.03.17.11.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:44:08 -0700 (PDT)
Message-ID: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
Date: Sun, 17 Mar 2024 20:44:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 00/12] wifi: rtlwifi: Add new rtl8192du driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add a driver for the RTL8192DU chip.

Patch 1 fixes a bug in rtl8192de. Patch 2 depends on it.

Patch 2 moves a good portion of the code from rtl8192de to a new module
rtl8192d-common.

Patch 3 makes some adjustments to rtl8192d-common.

The remaining patches add the new rtl8192du driver.

Power saving is disabled by default because it's not working yet.

Dual MAC chips are not tested.

Until Ping-Ke Shih will add the firmware to the linux-firmware
repository, the driver can be tested with the firmware from Larry
Finger's repository:
https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

v2:
 - Add cover letter.
 - Implement feedback.
 - Fix more problems reported by checkpatch.
 - Split the new driver into several patches (4-12) for easier
   reviewing.
 - More details about the changes can be found in each patch.

Bitterblue Smith (12):
  wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
  wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
  wifi: rtlwifi: Adjust rtl8192d-common for USB
  wifi: rtlwifi: Add rtl8192du/table.{c,h}
  wifi: rtlwifi: Add rtl8192du/hw.{c,h}
  wifi: rtlwifi: Add rtl8192du/phy.{c,h}
  wifi: rtlwifi: Add rtl8192du/trx.{c,h}
  wifi: rtlwifi: Add rtl8192du/rf.{c,h}
  wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
  wifi: rtlwifi: Add rtl8192du/dm.{c,h}
  wifi: rtlwifi: Add rtl8192du/sw.{c,h}
  wifi: rtlwifi: Enable the new rtl8192du driver

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   18 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    2 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |    2 +-
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1079 ++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |  100 +
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  390 +++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   49 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1218 +++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  830 +++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |   96 +
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |  155 +-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  378 ++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  516 +++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  442 +++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +-----
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +------
 .../wireless/realtek/rtlwifi/rtl8192de/hw.h   |   11 -
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  |  918 +----
 .../wireless/realtek/rtlwifi/rtl8192de/phy.h  |   59 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  375 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.h   |    5 -
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  515 +--
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  433 ---
 .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  125 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |  109 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1244 +++++++
 .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   24 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3055 +++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  236 ++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  311 ++
 .../wireless/realtek/rtlwifi/rtl8192du/sw.h   |   12 +
 .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++
 .../realtek/rtlwifi/rtl8192du/table.h         |   30 +
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  380 ++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |    6 +
 55 files changed, 12788 insertions(+), 4983 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (91%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
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
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

-- 
2.43.2

