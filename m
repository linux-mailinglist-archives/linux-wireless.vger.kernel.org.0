Return-Path: <linux-wireless+bounces-5024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B578817EF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66492B22445
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CC6A02A;
	Wed, 20 Mar 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldmQ2Z+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2385626
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963165; cv=none; b=OobTCY8Djh7Xifi6Iy2r0xppsl3QpVWRv/T+Kd0xY1NiDG35whdrM/XDo57jK5G3AA23PFJ6l2YPc2yWQ31yEsPikGxj/btHWWDyn7S4VZDk20hdgC94jgTK9fwsChfnYBvln2lS/TR/X2pNou3S4c9eoGV5t03pvxhYxUsffCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963165; c=relaxed/simple;
	bh=QJiYRb0foYJCGpT1uezn5z8aIC8Y0hOnAhF+4RvPW1w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Klv2MSN9jSItVKsFEU4QawOQylxD5qXG3RKNZIz+RVeQxnU2OzcKvZq6TkPWQSFhAazP2z8oVjwa4T10Pu83bPs3edQwTYhJCAioRTUdHNfceLLo1NniRjsElF5OvtRm7SBoC3mFCIt5UPA5ErcrC9wgP6iHuyYXJPnG07TAzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldmQ2Z+n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41464711dc8so1677645e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963162; x=1711567962; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaF7UKyo8eedQstId/5PeQNMHtbZHpwDDae2BomtveY=;
        b=ldmQ2Z+noNGx4sylpWR4tUCzAQqbvhuWgjcAhWwguU7j2JXienTvyikEbuea1UHAlK
         +a65bmrz6lV6fvYlHXk9mSWQ2GE9UyYDvxuQiOI3bZPt7QG+ZlKGcZ2lgVqjSg7Q0ejX
         QkF2DOa1P3sPPScxGu8O89g1jqn1UPbkjW9z6OifMatEFVMFHz3gj8Jek8k2/fK7/Hq5
         YUGF+aY/gv08EsrRKvCFv8Ajen3DpPCXcYRnxdqfjGPtPP7ZXg7DZqg8pp5NRCV0RMVD
         HF6ZERGPYQsREVZfUF/+MK26UUVFzOY8ee0gG601VfwxYlmWaADWmRAP9UArQpw7lpYp
         BTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963162; x=1711567962;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NaF7UKyo8eedQstId/5PeQNMHtbZHpwDDae2BomtveY=;
        b=VCkTDdqgS2jUCmx0xC/c3r2dbidr+3JkWkAC18lUbYxoY3EWLYyDyQU4wICdwQU60U
         8Brr/UXYP7JatObpPcF9g94V6kKg/09+Q/go+uhJbW92WldKge5Df546DJpHW2ARUQx9
         Zgo83bhB4/g22UX6jFiS10pt+nwLCvpMdd9tlXcs9CtQh2bUyknir3X97RgC+A66edGc
         gTBht6ikwntT0ViVLGB/bERxFgwkAfvw6xnfOm6z0es/i8WmRlURPBR5B7XCL6LZ7TbG
         NHYV6EsKFdw99riqZY8l204p8Yf6hrudrGBFWACwuSrxGQA/YlDJ1dIo1wikXx5zjN06
         tEzw==
X-Gm-Message-State: AOJu0YwTatZh1mLOVT6YNdo0YzArYe3gcr77JGZYa6aBK7Zx6oj82Xgc
	+PbIWno3c78fTacSj0weFx8lbA8X10/YXFqYF2ZP/aUKNN/VSMf/a2lGnFsF
X-Google-Smtp-Source: AGHT+IGSIgy1TJZoMEJnlI+PuuMYhdAaYdEXzJgJkQ1mMgarIQBNbyHChYqRRa/geleYim4xZ9hmgA==
X-Received: by 2002:a7b:ce97:0:b0:414:e63:4d34 with SMTP id q23-20020a7bce97000000b004140e634d34mr2529404wmj.33.1710963161571;
        Wed, 20 Mar 2024 12:32:41 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:32:41 -0700 (PDT)
Message-ID: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
Date: Wed, 20 Mar 2024 21:32:39 +0200
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
Subject: [PATCH v3 00/12] wifi: rtlwifi: Add new rtl8192du driver
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

