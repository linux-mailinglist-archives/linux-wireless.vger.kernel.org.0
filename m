Return-Path: <linux-wireless+bounces-6865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D08B27DF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36AE28226A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895E14EC42;
	Thu, 25 Apr 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh2gxFpa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630014EC41
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068504; cv=none; b=TPvk2+76YXLkMm6/TSy2FQugBzqGf3XtcxTVmr2YaoCXxy6D5akL1V7+0RhIGgLycmIo3toGZ8JBQpTa9mOdwHDPNX1a6SXYBYBe2lRASjJdKqI+wHgauPm95dq+qRPgZEKwqxNBYolSB9FdJ3FsId3SzZqm2OaezQimKbOJsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068504; c=relaxed/simple;
	bh=2cKlU2rAJXqDLaZdq56VgkfQh6p8Z8BXPzwwbRHw5Us=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Nz6Td0C7GRdvWoPqPAOoJKMWcVHeqb8PMyF64i1/igZMM6skGALu0My4HZVSbLDIDG/bOmxkF6WTm7qvMfaur8xDmiHKZlHEplF/5/Bc3XSauJLQ8O+8L0JjI4jeNqJzsMg+mDIbDBMBJ6Yq5ExUcSMxNmTqvg+vFN6DM50Rqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh2gxFpa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4702457ccbso177768766b.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068500; x=1714673300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1slGjMmQjqh+0ydmyuyl9wGslqdVPhV7jOcfzHCbQAs=;
        b=kh2gxFpa1Em72b1vjtaTHFuPEGKTyCmfoS9yPnZd8G2UxXHcdPfR1ATQmhY1BIye3t
         UKFrZ/5syx1T1ZlobLPrkd4D6NNLf60NrSsKedzlRR8ZwWkxSPXY/5Ll+Mp+jpocmXdE
         PKQCzUbN3Y4vKx1NHk3aDgQU3OP1U45XSqHyvzMEznXGM/fAW1nbohZbMsPTp3hGjPgF
         YrqqZA1u+GlFKpmQ92LwyzJpkbUkwOQMwNHxomcOCXk3QLIHg7um13j3rKN1umwScgC3
         +pwXbW9q6x11ZzplkdCc12XzkAcnMfaqGYZIXeJPb3B3IW0mzIE1rBVgTVoFDCgnkK0x
         0C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068500; x=1714673300;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1slGjMmQjqh+0ydmyuyl9wGslqdVPhV7jOcfzHCbQAs=;
        b=IUVyW2l1lO5zyqr6dixR1jH+vfWPxL/O//YFy6RxD9Gr5+8LUNWr2bqKbnAJ7IECBO
         WAm1eb9WVj/x+sSIZmtdqMh69CCXvwNWDfT8kJ6sOzervyUM2k0G4wmVBDO0lFpWGdRc
         z3GJKn/1di7d60w11CAhTRCmSeuFP+uu9BebhGBbi4QNHj/jyDoSFVxdd+rIOrWaQnca
         Wd/Nj2TsgImrcSZK5/p5BM9wj4UBE/l4F4YRCQ59BM/KDht1GdnSnaesZWcQlfs+plgK
         WNCHb0FQHsFIBIpJm7dgtEurhCeuGt+RgElHgbmt0fErlL9YG/cVAXaB1DiwT8Hg/Ui9
         hHqw==
X-Gm-Message-State: AOJu0YwRj90dy9H314zxPhIwFyUIzUwPWTVBxoTRZNaIWN8bQ3fRmgpm
	k+OQ8mvzTKmT6UcWIm4nQIBxUQVv/136DLzKhuUm7Erb927LQGr3tkRt3B0o
X-Google-Smtp-Source: AGHT+IFQdzw+tadpUfRNhVn6Ny8y+KCxguJ2xFtALGFVQPKtn1N4aA72ftVs0CtuwnLvR2g8q7wcZg==
X-Received: by 2002:a17:906:2543:b0:a55:be99:60d5 with SMTP id j3-20020a170906254300b00a55be9960d5mr330286ejb.23.1714068500291;
        Thu, 25 Apr 2024 11:08:20 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id qt11-20020a170906eceb00b00a55ab2630c3sm6007439ejb.38.2024.04.25.11.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:08:20 -0700 (PDT)
Message-ID: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
Date: Thu, 25 Apr 2024 21:08:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v7 0/6] wifi: rtlwifi: Move common code from rtl8192de to
 rtl8192d-common
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches fix some bugs in rtl8192de and move some of the code to
a new rtl8192d-common module, in order to share that code with the new
rtl8192du driver.

v4 of the series included the new rtl8192du driver as well, but it was
becoming too long. The new driver will be added in another series of
patches.

v7:
 - Call rtl92d_fill_h2c_cmd() in rtl92de_update_hal_rate_mask()
   directly for PCI, like it was originally.
 - More details about the changes can be found in each patch.

v6:
 - More cleanup.
 - More details about the changes can be found in each patch.

v5:
 - Fix some endianness issues in rtl8192de.
 - Clean up the common code a bit.
 - Drop the patches which added the new driver.
 - More details about the changes can be found in each patch.

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

Bitterblue Smith (6):
  wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
  wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
  wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
  wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
  wifi: rtlwifi: Clean up rtl8192d-common a bit
  wifi: rtlwifi: Adjust rtl8192d-common for USB

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |    4 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c    |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h    |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |    2 +-
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1061 ++++++++++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |   79 ++
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  370 +++++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   49 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1225 +++++++++++++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  856 ++++++++++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |  111 ++
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |  162 ++-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  359 +++++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  516 +++++++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  405 ++++++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +--------------
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +---------------
 .../wireless/realtek/rtlwifi/rtl8192de/hw.h   |   11 -
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  |  918 +-----------
 .../wireless/realtek/rtlwifi/rtl8192de/phy.h  |   59 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.h   |    5 -
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  515 +------
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  433 ------
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |    6 +
 38 files changed, 5364 insertions(+), 4988 deletions(-)
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

-- 
2.44.0


