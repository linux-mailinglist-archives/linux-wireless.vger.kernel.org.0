Return-Path: <linux-wireless+bounces-6038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF889E3CA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2289C1F21F3B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD71157A42;
	Tue,  9 Apr 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjKQDSW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F4157A40
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691551; cv=none; b=bh6cER0uneOaeDgHc4PwKiCVIAXA8yblX75Tak/xeaWAoPlApjTiwOu+6fbHkdjlS/adwwtQMU8f4/tCwknwebaB97/w6R1uMKwHKRa0WaEh6/hdL0aqK79O3tNxxPdgJkVL60Jsb3lHu+nU/HmRzRfIDXcC/Ekgo/Qc6bxUPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691551; c=relaxed/simple;
	bh=f2/mp10eqjFiYC5bGpgJuUpYGLaPKJ+e3qILV2TEhMA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=QHx0Uqp5ok5gWAdrSmMxVTuB7RI57pg/Mke0Skf8MtlACyZza/uyL5mYyRyVzZJNTVsYZ60MwNZlDNef4IKUbw1/OQp1HrUypaUtYGuO8ymF67rJ5QsTGL0wg1P2fnfY3XQZjp7telYkGYO+R1S+8l+++Yn4zFF6KS6n2r6KUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjKQDSW7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so6353707e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712691548; x=1713296348; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tn9M21W22+nFx2RXGlfLfHYqDNAN/qSFMI+t9PEG+w=;
        b=XjKQDSW7zBUwKYyBHTvhisHJbvm7178AWDv0/Gl+5AF2TtKrtPibiBb2epBCyum2c8
         MYi6tTbdvJa+qPjARjSlfMlgzXVOWbVDG1uU5O77xTspbOL3pqzUlluAQSAvZZVuzYG9
         ZwlbJNUBewnuCFVsC2bmgUl7OoFHzLxh/MnUnIbdya1q6vIQIQLPM9dJfeDfUltd69y0
         4U1JMVSuS56HMNhY1knhoRLLY6mnY7oKWYTQdDT3ZxIYUr/b4M7efgNXHpWEM/G9atjb
         Z41xmKrGqDqWml3iO+QvdAbxqtg/GmOZ7lTSWuA6WE1uBEocxA3LKRSx3OeBdpOD5H6X
         Jocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691548; x=1713296348;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7tn9M21W22+nFx2RXGlfLfHYqDNAN/qSFMI+t9PEG+w=;
        b=ojhjLuZxkroHu50IzfzkUNCAzRZCxM3Q4b0aAk68ICLiiK5E7go6LajMks7bvjEIGd
         3EUcsAgBHQ3LSidONP3ZtDTNaAiCjpRej/Ndz3XFhsyUMh3twzZA+Oxfs6pvMc/ON2Dl
         aL2AdrJPZf1C3lYklF9OfFRCPprDSFZB3fM1XlYiCNdfMX+BSSKYesqQUkRpFPnj1+c0
         +iZM2aCo/pn/s/F4aknPhF3v65KQuVzzq/y3fmgYG8zwjsD4twfQmOxmdXE57My62FJe
         HIAo9jgpj/1hpRI0U6hDlBKkt43VDErIAkKWlqdci7jRe9oeI2XR7cxygrK+jNIWchNp
         S0+g==
X-Gm-Message-State: AOJu0YyhwzxFD0F/kjK1eJEnqBmlM/HmSpwXk7CpjMODD5DHYDiqn4ft
	yEscCY+cZQsspTPbgb4E3XrPCdBOhGKGmws7U0wy0IX3pSji5qXZjRBRJxnsh18=
X-Google-Smtp-Source: AGHT+IGr3WkTBF2gG/uhdYwe+uRTLJnszE72spS+lLdauPc2YIk79IqqDivpHGDMBy4E67j2LHG0RQ==
X-Received: by 2002:ac2:4304:0:b0:513:a39e:ae45 with SMTP id l4-20020ac24304000000b00513a39eae45mr214254lfh.62.1712691547485;
        Tue, 09 Apr 2024 12:39:07 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906338a00b00a51ce37a708sm3588582eja.94.2024.04.09.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:39:06 -0700 (PDT)
Message-ID: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Date: Tue, 9 Apr 2024 22:39:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Subject: [PATCH v4 00/14] wifi: rtlwifi: Add new rtl8192du driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add a driver for the RTL8192DU chip.

Patches 1 and 2 fix bugs in rtl8192de. Patch 3 depends on them.

Patch 3 moves a good portion of the code from rtl8192de to a new module
rtl8192d-common.

Patch 4 makes some adjustments to rtl8192d-common.

Patch 12 constifies some things.

The remaining patches add the new rtl8192du driver.

Power saving is disabled by default because it's not working yet.

Dual MAC chips are not tested.

Until Ping-Ke Shih will add the firmware to the linux-firmware
repository, the driver can be tested with the firmware from Larry
Finger's repository:
https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

v4:
 - Fix slow speeds with WPA3-SAE.
 - Move global variables into struct rtl_priv.
 - Implement requested changes.
 - More details about the changes can be found in each patch.

v3:
 - Fix compilation error and sparse/smatch warnings.
 - Add another USB ID.
 - More details about the changes can be found in each patch.

v2:
 - Add cover letter.
 - Implement feedback.
 - Fix more problems reported by checkpatch.
 - Split the new driver into several patches (4-12) for easier
   reviewing.
 - More details about the changes can be found in each patch.

Bitterblue Smith (14):
  wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
  wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
  wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
  wifi: rtlwifi: Adjust rtl8192d-common for USB
  wifi: rtlwifi: Add rtl8192du/table.{c,h}
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

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   18 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    2 +
 drivers/net/wireless/realtek/rtlwifi/base.c   |    2 +-
 drivers/net/wireless/realtek/rtlwifi/cam.c    |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h    |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |    3 +-
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1079 ++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |  100 +
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  390 ++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   49 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1218 +++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  854 +++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |  111 +
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |  160 +-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  353 ++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  515 +++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  456 +++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +-----
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +-----
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
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    5 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   18 +-
 59 files changed, 13035 insertions(+), 4996 deletions(-)
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
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (90%)
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
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

-- 
2.44.0



