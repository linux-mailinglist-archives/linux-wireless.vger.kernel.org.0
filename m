Return-Path: <linux-wireless+bounces-5026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8458817F4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C7B281BC6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25F85659;
	Wed, 20 Mar 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjVki8wC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE285282
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963294; cv=none; b=sfe+Pju5uJFk8yVHm9ZTgrl26uFIwkzzS+UFv4uoNU1S324QA4YBrfMtLNOqILx3VmeJ5YHqq93v0CD+gJwI3Fg9lG/QkJG3yLO/osddI76EWsObWtvRviDZ2txRgZAgj/SH9UAacHstC+jlWZy5hWvBzQjFBWUkEFINkJw+SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963294; c=relaxed/simple;
	bh=1iwNv3E0uTRSD+ZvBfGrz1zVc7GscpcpvJVfusQTGxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YmudQn17jrzm1CtZ31LxJRl/+KzVBTku/+pvruPk/GAu6Gfmtx3IGgPfqrrwS+P/SOWuGRC2hLg9AJCQjELIhAjI0EXgVg1XbH5CitFbEWxQqMRS0uusaElP/87XV6V+4IzrNqFaiIlSTGtLbt1uxfaSS2yY58PM+29wg7HiGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjVki8wC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4147018a4c9so1216965e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963279; x=1711568079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npzda5hYcetbEdK/7pso9BbZK6shKgsKT5l83qE8vCU=;
        b=GjVki8wCS0Krzyf5X3b4EOfXNzXs+fFx0lZt++XVyqn9zg6NSGvdm4ivRvzAYHtV8c
         vi1nTADE5B7AffT725RnWvf3mOXKHqYsBFyyHhWRmAwqpnvacvvWoIaZz6fWinAWy48J
         K9d59sk5jrLLOpWaAtX5m7oEgZitlHiEVos4KI4W715Q5xLrHkfxHHVLV2b39U4lrwHV
         8WplBlfHSa6ClJaXmdJ9Lze+zPXh4GFUlzpjhKUQshUb9hp5EHL2VoB5/XHdj8oQSyxA
         5TSsr6fqsXjmbk2ag1YKVGHhv5qLGJOquCVEIc5mIHmiYjcvYuDAEHeipEhA7PU//5WJ
         Irrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963279; x=1711568079;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npzda5hYcetbEdK/7pso9BbZK6shKgsKT5l83qE8vCU=;
        b=SSxS9uNGTrYDPhNT/G+h0c6kHOLUlOh1WUSXkaXWqIOxv5D6rtMI0Bmw3WsVEC52I9
         ADinl51ufophuoRP3WK+If8I55E/cfTeuXws0aUdmyDTaXjXewAxVLX3pA5hes9aTWtZ
         1wnAVBHIroVdG2NitSHnKJzrZ0xeeyY+9CSfu99OxyTsisSXzrmD1LXYikuYybz3Y1O2
         sgV2Y4l6ebxIpFTvm3G7xFDOpjgyEfW7pw8CpA27Pz1UVLM0Fk7L4ubuLtqIjYxHc1Hf
         +Z5icwjLM6S7BN/lgre+YmO4Rj03HL8dZZRisQibsgDM9/2HFstkc89BJvMGAMhYHkIY
         Nnqw==
X-Gm-Message-State: AOJu0YyWy7HBFgH/clpnn/63tcEj3cgH7aMBeA6eNd9Y1+jprBH1MH4W
	ghIfoNktgPs0su1FqyRkDCiVv9wLkQ7y87kQbPuu4HQ2EP04OkDJ2dAqxe9w
X-Google-Smtp-Source: AGHT+IFMouSvNbsjojNPYruhiC+eZoMW24JBq3nB0zVQxEiJve2nNrMZh8r5nVteARAQtDO//ilbCQ==
X-Received: by 2002:a5d:428c:0:b0:33e:b68b:4edd with SMTP id k12-20020a5d428c000000b0033eb68b4eddmr14821639wrq.64.1710963278177;
        Wed, 20 Mar 2024 12:34:38 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:34:37 -0700 (PDT)
Message-ID: <c83c2d67-d476-43c3-86e2-48bacc7d5ba2@gmail.com>
Date: Wed, 20 Mar 2024 21:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 02/12] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
In-Reply-To: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Create the new module rtl8192d-common and move some code into it from
rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
(USB) can share some of the code.

This is mostly the code that required little effort to make it
shareable. There are a few more functions which they could share, with
more changes.

Add phy_iq_calibrate member to struct rtl_hal_ops to allow moving the
TX power tracking code from dm.c.

The other changes in this patch are adjusting whitespace, renaming some
functions, making some arrays const, and making checkpatch.pl less
unhappy.

rtl8192de is compile-tested only. rtl8192d-common is tested with the
new rtl8192du driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Add the declarations of rtl92d_acquire_cckandrw_pagea_ctl and
   rtl92d_release_cckandrw_pagea_ctl in phy_common.h in order to fix
   sparse warnings about locks.
 - Move channel_all array from phy_common.h to phy_common.c because it's
   only used there.
 - Include rf_common.h in rf_common.c.

v2:
 - Fix most things reported by checkpatch.
 - Move the TX power tracking code as well, and add phy_iq_calibrate
   member to struct rtl_hal_ops as part of that.
---
 drivers/net/wireless/realtek/rtlwifi/Kconfig  |    6 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1079 +++++++++++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |  100 ++
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  369 +++++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   39 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1191 +++++++++++++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  827 ++++++++++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |   86 ++
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |    0
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  379 ++++++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  516 +++++++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  442 ++++++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +--------------
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +-----
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +---------------
 .../wireless/realtek/rtlwifi/rtl8192de/hw.h   |   11 -
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  |  918 +------------
 .../wireless/realtek/rtlwifi/rtl8192de/phy.h  |   59 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  375 +-----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.h   |    5 -
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  515 +------
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  433 ------
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |    1 +
 33 files changed, 5206 insertions(+), 4960 deletions(-)
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
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/Kconfig b/drivers/net/wireless/realtek/rtlwifi/Kconfig
index 9f6a4e35543c..2319eaa8845a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/Kconfig
+++ b/drivers/net/wireless/realtek/rtlwifi/Kconfig
@@ -37,6 +37,7 @@ config RTL8192SE
 config RTL8192DE
 	tristate "Realtek RTL8192DE/RTL8188DE PCIe Wireless Network Adapter"
 	depends on PCI
+	select RTL8192D_COMMON
 	select RTLWIFI
 	select RTLWIFI_PCI
 	help
@@ -142,6 +143,11 @@ config RTL8192C_COMMON
 	depends on RTL8192CE || RTL8192CU
 	default y
 
+config RTL8192D_COMMON
+	tristate
+	depends on RTL8192DE
+	default y
+
 config RTL8723_COMMON
 	tristate
 	depends on RTL8723AE || RTL8723BE
diff --git a/drivers/net/wireless/realtek/rtlwifi/Makefile b/drivers/net/wireless/realtek/rtlwifi/Makefile
index 09c30e428375..423981b148df 100644
--- a/drivers/net/wireless/realtek/rtlwifi/Makefile
+++ b/drivers/net/wireless/realtek/rtlwifi/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_RTL8192C_COMMON)	+= rtl8192c/
 obj-$(CONFIG_RTL8192CE)		+= rtl8192ce/
 obj-$(CONFIG_RTL8192CU)		+= rtl8192cu/
 obj-$(CONFIG_RTL8192SE)		+= rtl8192se/
+obj-$(CONFIG_RTL8192D_COMMON)	+= rtl8192d/
 obj-$(CONFIG_RTL8192DE)		+= rtl8192de/
 obj-$(CONFIG_RTL8723AE)		+= rtl8723ae/
 obj-$(CONFIG_RTL8723BE)		+= rtl8723be/
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
new file mode 100644
index 000000000000..beebdfa3f7ff
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+rtl8192d-common-objs :=		\
+		dm_common.o \
+		fw_common.o \
+		hw_common.o \
+		main.o \
+		phy_common.o \
+		rf_common.o \
+		trx_common.o
+
+obj-$(CONFIG_RTL8192D_COMMON) += rtl8192d-common.o
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
similarity index 100%
rename from drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h
rename to drivers/net/wireless/realtek/rtlwifi/rtl8192d/def.h
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
new file mode 100644
index 000000000000..d376e4584454
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
@@ -0,0 +1,1079 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../core.h"
+#include "reg.h"
+#include "def.h"
+#include "phy_common.h"
+#include "dm_common.h"
+
+#define UNDEC_SM_PWDB	entry_min_undec_sm_pwdb
+
+static const u32 ofdmswing_table[OFDM_TABLE_SIZE_92D] = {
+	0x7f8001fe,		/* 0, +6.0dB */
+	0x788001e2,		/* 1, +5.5dB */
+	0x71c001c7,		/* 2, +5.0dB */
+	0x6b8001ae,		/* 3, +4.5dB */
+	0x65400195,		/* 4, +4.0dB */
+	0x5fc0017f,		/* 5, +3.5dB */
+	0x5a400169,		/* 6, +3.0dB */
+	0x55400155,		/* 7, +2.5dB */
+	0x50800142,		/* 8, +2.0dB */
+	0x4c000130,		/* 9, +1.5dB */
+	0x47c0011f,		/* 10, +1.0dB */
+	0x43c0010f,		/* 11, +0.5dB */
+	0x40000100,		/* 12, +0dB */
+	0x3c8000f2,		/* 13, -0.5dB */
+	0x390000e4,		/* 14, -1.0dB */
+	0x35c000d7,		/* 15, -1.5dB */
+	0x32c000cb,		/* 16, -2.0dB */
+	0x300000c0,		/* 17, -2.5dB */
+	0x2d4000b5,		/* 18, -3.0dB */
+	0x2ac000ab,		/* 19, -3.5dB */
+	0x288000a2,		/* 20, -4.0dB */
+	0x26000098,		/* 21, -4.5dB */
+	0x24000090,		/* 22, -5.0dB */
+	0x22000088,		/* 23, -5.5dB */
+	0x20000080,		/* 24, -6.0dB */
+	0x1e400079,		/* 25, -6.5dB */
+	0x1c800072,		/* 26, -7.0dB */
+	0x1b00006c,		/* 27. -7.5dB */
+	0x19800066,		/* 28, -8.0dB */
+	0x18000060,		/* 29, -8.5dB */
+	0x16c0005b,		/* 30, -9.0dB */
+	0x15800056,		/* 31, -9.5dB */
+	0x14400051,		/* 32, -10.0dB */
+	0x1300004c,		/* 33, -10.5dB */
+	0x12000048,		/* 34, -11.0dB */
+	0x11000044,		/* 35, -11.5dB */
+	0x10000040,		/* 36, -12.0dB */
+	0x0f00003c,		/* 37, -12.5dB */
+	0x0e400039,		/* 38, -13.0dB */
+	0x0d800036,		/* 39, -13.5dB */
+	0x0cc00033,		/* 40, -14.0dB */
+	0x0c000030,		/* 41, -14.5dB */
+	0x0b40002d,		/* 42, -15.0dB */
+};
+
+static const u8 cckswing_table_ch1ch13[CCK_TABLE_SIZE][8] = {
+	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04},    /* 0, +0dB */
+	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04},    /* 1, -0.5dB */
+	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03},    /* 2, -1.0dB */
+	{0x2d, 0x2d, 0x27, 0x1f, 0x18, 0x0f, 0x08, 0x03},    /* 3, -1.5dB */
+	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03},    /* 4, -2.0dB */
+	{0x28, 0x28, 0x22, 0x1c, 0x15, 0x0d, 0x07, 0x03},    /* 5, -2.5dB */
+	{0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03},    /* 6, -3.0dB */
+	{0x24, 0x23, 0x1f, 0x19, 0x13, 0x0c, 0x06, 0x03},    /* 7, -3.5dB */
+	{0x22, 0x21, 0x1d, 0x18, 0x11, 0x0b, 0x06, 0x02},    /* 8, -4.0dB */
+	{0x20, 0x20, 0x1b, 0x16, 0x11, 0x08, 0x05, 0x02},    /* 9, -4.5dB */
+	{0x1f, 0x1e, 0x1a, 0x15, 0x10, 0x0a, 0x05, 0x02},    /* 10, -5.0dB */
+	{0x1d, 0x1c, 0x18, 0x14, 0x0f, 0x0a, 0x05, 0x02},    /* 11, -5.5dB */
+	{0x1b, 0x1a, 0x17, 0x13, 0x0e, 0x09, 0x04, 0x02},    /* 12, -6.0dB */
+	{0x1a, 0x19, 0x16, 0x12, 0x0d, 0x09, 0x04, 0x02},    /* 13, -6.5dB */
+	{0x18, 0x17, 0x15, 0x11, 0x0c, 0x08, 0x04, 0x02},    /* 14, -7.0dB */
+	{0x17, 0x16, 0x13, 0x10, 0x0c, 0x08, 0x04, 0x02},    /* 15, -7.5dB */
+	{0x16, 0x15, 0x12, 0x0f, 0x0b, 0x07, 0x04, 0x01},    /* 16, -8.0dB */
+	{0x14, 0x14, 0x11, 0x0e, 0x0b, 0x07, 0x03, 0x02},    /* 17, -8.5dB */
+	{0x13, 0x13, 0x10, 0x0d, 0x0a, 0x06, 0x03, 0x01},    /* 18, -9.0dB */
+	{0x12, 0x12, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01},    /* 19, -9.5dB */
+	{0x11, 0x11, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01},    /* 20, -10.0dB */
+	{0x10, 0x10, 0x0e, 0x0b, 0x08, 0x05, 0x03, 0x01},    /* 21, -10.5dB */
+	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01},    /* 22, -11.0dB */
+	{0x0e, 0x0e, 0x0c, 0x0a, 0x08, 0x05, 0x02, 0x01},    /* 23, -11.5dB */
+	{0x0d, 0x0d, 0x0c, 0x0a, 0x07, 0x05, 0x02, 0x01},    /* 24, -12.0dB */
+	{0x0d, 0x0c, 0x0b, 0x09, 0x07, 0x04, 0x02, 0x01},    /* 25, -12.5dB */
+	{0x0c, 0x0c, 0x0a, 0x09, 0x06, 0x04, 0x02, 0x01},    /* 26, -13.0dB */
+	{0x0b, 0x0b, 0x0a, 0x08, 0x06, 0x04, 0x02, 0x01},    /* 27, -13.5dB */
+	{0x0b, 0x0a, 0x09, 0x08, 0x06, 0x04, 0x02, 0x01},    /* 28, -14.0dB */
+	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01},    /* 29, -14.5dB */
+	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01},    /* 30, -15.0dB */
+	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01},    /* 31, -15.5dB */
+	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}     /* 32, -16.0dB */
+};
+
+static const u8 cckswing_table_ch14[CCK_TABLE_SIZE][8] = {
+	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00},    /* 0, +0dB */
+	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00},    /* 1, -0.5dB */
+	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00},    /* 2, -1.0dB */
+	{0x2d, 0x2d, 0x17, 0x17, 0x00, 0x00, 0x00, 0x00},    /* 3, -1.5dB */
+	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00},    /* 4, -2.0dB */
+	{0x28, 0x28, 0x24, 0x14, 0x00, 0x00, 0x00, 0x00},    /* 5, -2.5dB */
+	{0x26, 0x25, 0x21, 0x13, 0x00, 0x00, 0x00, 0x00},    /* 6, -3.0dB */
+	{0x24, 0x23, 0x1f, 0x12, 0x00, 0x00, 0x00, 0x00},    /* 7, -3.5dB */
+	{0x22, 0x21, 0x1d, 0x11, 0x00, 0x00, 0x00, 0x00},    /* 8, -4.0dB */
+	{0x20, 0x20, 0x1b, 0x10, 0x00, 0x00, 0x00, 0x00},    /* 9, -4.5dB */
+	{0x1f, 0x1e, 0x1a, 0x0f, 0x00, 0x00, 0x00, 0x00},    /* 10, -5.0dB */
+	{0x1d, 0x1c, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00},    /* 11, -5.5dB */
+	{0x1b, 0x1a, 0x17, 0x0e, 0x00, 0x00, 0x00, 0x00},    /* 12, -6.0dB */
+	{0x1a, 0x19, 0x16, 0x0d, 0x00, 0x00, 0x00, 0x00},    /* 13, -6.5dB */
+	{0x18, 0x17, 0x15, 0x0c, 0x00, 0x00, 0x00, 0x00},    /* 14, -7.0dB */
+	{0x17, 0x16, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00},    /* 15, -7.5dB */
+	{0x16, 0x15, 0x12, 0x0b, 0x00, 0x00, 0x00, 0x00},    /* 16, -8.0dB */
+	{0x14, 0x14, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x00},    /* 17, -8.5dB */
+	{0x13, 0x13, 0x10, 0x0a, 0x00, 0x00, 0x00, 0x00},    /* 18, -9.0dB */
+	{0x12, 0x12, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00},    /* 19, -9.5dB */
+	{0x11, 0x11, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00},    /* 20, -10.0dB */
+	{0x10, 0x10, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x00},    /* 21, -10.5dB */
+	{0x0f, 0x0f, 0x0d, 0x08, 0x00, 0x00, 0x00, 0x00},    /* 22, -11.0dB */
+	{0x0e, 0x0e, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00},    /* 23, -11.5dB */
+	{0x0d, 0x0d, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00},    /* 24, -12.0dB */
+	{0x0d, 0x0c, 0x0b, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 25, -12.5dB */
+	{0x0c, 0x0c, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 26, -13.0dB */
+	{0x0b, 0x0b, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 27, -13.5dB */
+	{0x0b, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 28, -14.0dB */
+	{0x0a, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 29, -14.5dB */
+	{0x0a, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 30, -15.0dB */
+	{0x09, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 31, -15.5dB */
+	{0x09, 0x08, 0x07, 0x04, 0x00, 0x00, 0x00, 0x00}     /* 32, -16.0dB */
+};
+
+static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
+{
+	static const u8 index_mapping[RX_INDEX_MAPPING_NUM] = {
+		0x0f, 0x0f, 0x0d, 0x0c, 0x0b,
+		0x0a, 0x09, 0x08, 0x07, 0x06,
+		0x05, 0x04, 0x04, 0x03, 0x02
+	};
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 u4tmp;
+	int i;
+
+	u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
+				rtlpriv->dm.thermalvalue_rxgain)]) << 12;
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"===> Rx Gain %x\n", u4tmp);
+	for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
+		rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
+			      (rtlpriv->phy.reg_rf3c[i] & (~(0xF000))) | u4tmp);
+}
+
+static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
+				 u8 *cck_index_old)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	unsigned long flag = 0;
+	const u8 *cckswing;
+	long temp_cck;
+	int i;
+
+	/* Query CCK default setting From 0xa24 */
+	rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+	temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
+				 MASKDWORD) & MASKCCK;
+	rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+	for (i = 0; i < CCK_TABLE_LENGTH; i++) {
+		if (rtlpriv->dm.cck_inch14)
+			cckswing = &cckswing_table_ch14[i][2];
+		else
+			cckswing = &cckswing_table_ch1ch13[i][2];
+
+		if (temp_cck == le32_to_cpu(*((__le32 *)cckswing))) {
+			*cck_index_old = (u8)i;
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
+				RCCK0_TXFILTER2, temp_cck,
+				*cck_index_old,
+				rtlpriv->dm.cck_inch14);
+			break;
+		}
+	}
+	*temp_cckg = temp_cck;
+}
+
+static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
+			       bool *internal_pa, u8 thermalvalue, u8 delta,
+			       u8 rf, struct rtl_efuse *rtlefuse,
+			       struct rtl_priv *rtlpriv, struct rtl_phy *rtlphy,
+			       const u8 index_mapping[5][INDEX_MAPPING_NUM],
+			       const u8 index_mapping_pa[8][INDEX_MAPPING_NUM])
+{
+	u8 offset = 0;
+	u8 index;
+	int i;
+
+	for (i = 0; i < rf; i++) {
+		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+		    rtlhal->interfaceindex == 1) /* MAC 1 5G */
+			*internal_pa = rtlefuse->internal_pa_5g[1];
+		else
+			*internal_pa = rtlefuse->internal_pa_5g[i];
+		if (*internal_pa) {
+			if (rtlhal->interfaceindex == 1 || i == rf)
+				offset = 4;
+			else
+				offset = 0;
+			if (rtlphy->current_channel >= 100 &&
+			    rtlphy->current_channel <= 165)
+				offset += 2;
+		} else {
+			if (rtlhal->interfaceindex == 1 || i == rf)
+				offset = 2;
+			else
+				offset = 0;
+		}
+		if (thermalvalue > rtlefuse->eeprom_thermalmeter)
+			offset++;
+		if (*internal_pa) {
+			if (delta > INDEX_MAPPING_NUM - 1)
+				index = index_mapping_pa[offset]
+						    [INDEX_MAPPING_NUM - 1];
+			else
+				index =
+				     index_mapping_pa[offset][delta];
+		} else {
+			if (delta > INDEX_MAPPING_NUM - 1)
+				index =
+				   index_mapping[offset][INDEX_MAPPING_NUM - 1];
+			else
+				index = index_mapping[offset][delta];
+		}
+		if (thermalvalue > rtlefuse->eeprom_thermalmeter) {
+			if (*internal_pa && thermalvalue > 0x12) {
+				ofdm_index[i] = rtlpriv->dm.ofdm_index[i] -
+						((delta / 2) * 3 + (delta % 2));
+			} else {
+				ofdm_index[i] -= index;
+			}
+		} else {
+			ofdm_index[i] += index;
+		}
+	}
+}
+
+static void
+rtl92d_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw *hw)
+{
+	static const u8 index_mapping[5][INDEX_MAPPING_NUM] = {
+		/* 5G, path A/MAC 0, decrease power  */
+		{0, 1, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
+		/* 5G, path A/MAC 0, increase power  */
+		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		/* 5G, path B/MAC 1, decrease power */
+		{0, 2, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
+		/* 5G, path B/MAC 1, increase power */
+		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+		/* 2.4G, for decreas power */
+		{0, 1, 2, 3, 4, 5,	6, 7, 7, 8, 9, 10, 10},
+	};
+	static const u8 index_mapping_internal_pa[8][INDEX_MAPPING_NUM] = {
+		/* 5G, path A/MAC 0, ch36-64, decrease power  */
+		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
+		/* 5G, path A/MAC 0, ch36-64, increase power  */
+		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		/* 5G, path A/MAC 0, ch100-165, decrease power  */
+		{0, 1, 2, 3, 5, 6,	8, 10, 11, 13, 14, 15, 15},
+		/* 5G, path A/MAC 0, ch100-165, increase power  */
+		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
+		/* 5G, path B/MAC 1, ch36-64, decrease power */
+		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
+		/* 5G, path B/MAC 1, ch36-64, increase power */
+		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+		/* 5G, path B/MAC 1, ch100-165, decrease power */
+		{0, 1, 2, 3, 5, 6,	8, 9, 10, 12, 13, 14, 14},
+		/* 5G, path B/MAC 1, ch100-165, increase power */
+		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
+	};
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtlpriv);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 thermalvalue, delta, delta_lck, delta_iqk, delta_rxgain;
+	u8 offset, thermalvalue_avg_count = 0;
+	u32 thermalvalue_avg = 0;
+	bool internal_pa = false;
+	long ele_a = 0, ele_d, temp_cck, val_x, value32;
+	long val_y, ele_c = 0;
+	u8 ofdm_index[2];
+	s8 cck_index = 0;
+	u8 ofdm_index_old[2] = {0, 0};
+	s8 cck_index_old = 0;
+	u8 index;
+	int i;
+	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
+	u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
+	u8 indexforchannel =
+	    rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
+
+	rtlpriv->dm.txpower_trackinginit = true;
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
+	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0xf800);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
+		thermalvalue,
+		rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
+
+	if (!thermalvalue)
+		goto exit;
+
+	if (is2t)
+		rf = 2;
+	else
+		rf = 1;
+
+	if (rtlpriv->dm.thermalvalue && !rtlhal->reloadtxpowerindex)
+		goto old_index_done;
+
+	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;
+	for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
+		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
+			ofdm_index_old[0] = (u8)i;
+
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
+				ROFDM0_XATXIQIMBALANCE,
+				ele_d, ofdm_index_old[0]);
+			break;
+		}
+	}
+	if (is2t) {
+		ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD) & MASKOFDM_D;
+		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
+			if (ele_d ==
+			    (ofdmswing_table[i] & MASKOFDM_D)) {
+				ofdm_index_old[1] = (u8)i;
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+					DBG_LOUD,
+					"Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
+					ROFDM0_XBTXIQIMBALANCE, ele_d,
+					ofdm_index_old[1]);
+				break;
+			}
+		}
+	}
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		rtl92d_bandtype_2_4G(hw, &temp_cck, &cck_index_old);
+	} else {
+		temp_cck = 0x090e1317;
+		cck_index_old = 12;
+	}
+
+	if (!rtlpriv->dm.thermalvalue) {
+		rtlpriv->dm.thermalvalue = rtlefuse->eeprom_thermalmeter;
+		rtlpriv->dm.thermalvalue_lck = thermalvalue;
+		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
+		rtlpriv->dm.thermalvalue_rxgain = rtlefuse->eeprom_thermalmeter;
+		for (i = 0; i < rf; i++)
+			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
+		rtlpriv->dm.cck_index = cck_index_old;
+	}
+	if (rtlhal->reloadtxpowerindex) {
+		for (i = 0; i < rf; i++)
+			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
+		rtlpriv->dm.cck_index = cck_index_old;
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"reload ofdm index for band switch\n");
+	}
+old_index_done:
+	for (i = 0; i < rf; i++)
+		ofdm_index[i] = rtlpriv->dm.ofdm_index[i];
+
+	rtlpriv->dm.thermalvalue_avg
+		    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
+	rtlpriv->dm.thermalvalue_avg_index++;
+	if (rtlpriv->dm.thermalvalue_avg_index == AVG_THERMAL_NUM)
+		rtlpriv->dm.thermalvalue_avg_index = 0;
+	for (i = 0; i < AVG_THERMAL_NUM; i++) {
+		if (rtlpriv->dm.thermalvalue_avg[i]) {
+			thermalvalue_avg += rtlpriv->dm.thermalvalue_avg[i];
+			thermalvalue_avg_count++;
+		}
+	}
+	if (thermalvalue_avg_count)
+		thermalvalue = (u8)(thermalvalue_avg / thermalvalue_avg_count);
+	if (rtlhal->reloadtxpowerindex) {
+		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+		rtlhal->reloadtxpowerindex = false;
+		rtlpriv->dm.done_txpower = false;
+	} else if (rtlpriv->dm.done_txpower) {
+		delta = (thermalvalue > rtlpriv->dm.thermalvalue) ?
+		    (thermalvalue - rtlpriv->dm.thermalvalue) :
+		    (rtlpriv->dm.thermalvalue - thermalvalue);
+	} else {
+		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+	}
+	delta_lck = (thermalvalue > rtlpriv->dm.thermalvalue_lck) ?
+	    (thermalvalue - rtlpriv->dm.thermalvalue_lck) :
+	    (rtlpriv->dm.thermalvalue_lck - thermalvalue);
+	delta_iqk = (thermalvalue > rtlpriv->dm.thermalvalue_iqk) ?
+	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
+	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
+	delta_rxgain =
+		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
+		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
+		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
+		thermalvalue, rtlpriv->dm.thermalvalue,
+		rtlefuse->eeprom_thermalmeter, delta, delta_lck,
+		delta_iqk);
+	if (delta_lck > rtlefuse->delta_lck && rtlefuse->delta_lck != 0) {
+		rtlpriv->dm.thermalvalue_lck = thermalvalue;
+		rtlpriv->cfg->ops->phy_lc_calibrate(hw, is2t);
+	}
+
+	if (delta == 0 || !rtlpriv->dm.txpower_track_control)
+		goto check_delta;
+
+	rtlpriv->dm.done_txpower = true;
+	delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
+	    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
+	    (rtlefuse->eeprom_thermalmeter - thermalvalue);
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		offset = 4;
+		if (delta > INDEX_MAPPING_NUM - 1)
+			index = index_mapping[offset][INDEX_MAPPING_NUM - 1];
+		else
+			index = index_mapping[offset][delta];
+		if (thermalvalue > rtlpriv->dm.thermalvalue) {
+			for (i = 0; i < rf; i++)
+				ofdm_index[i] -= delta;
+			cck_index -= delta;
+		} else {
+			for (i = 0; i < rf; i++)
+				ofdm_index[i] += index;
+			cck_index += index;
+		}
+	} else if (rtlhal->current_bandtype == BAND_ON_5G) {
+		rtl92d_bandtype_5G(rtlhal, ofdm_index,
+				   &internal_pa, thermalvalue,
+				   delta, rf, rtlefuse, rtlpriv,
+				   rtlphy, index_mapping,
+				   index_mapping_internal_pa);
+	}
+	if (is2t) {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
+			rtlpriv->dm.ofdm_index[0],
+			rtlpriv->dm.ofdm_index[1],
+			rtlpriv->dm.cck_index);
+	} else {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			rtlpriv->dm.ofdm_index[0],
+			rtlpriv->dm.cck_index);
+	}
+	for (i = 0; i < rf; i++) {
+		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1) {
+			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
+		} else if (internal_pa ||
+			   rtlhal->current_bandtype == BAND_ON_2_4G) {
+			if (ofdm_index[i] < ofdm_min_index_internal_pa)
+				ofdm_index[i] = ofdm_min_index_internal_pa;
+		} else if (ofdm_index[i] < ofdm_min_index) {
+			ofdm_index[i] = ofdm_min_index;
+		}
+	}
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		if (cck_index > CCK_TABLE_SIZE - 1)
+			cck_index = CCK_TABLE_SIZE - 1;
+		else if (cck_index < 0)
+			cck_index = 0;
+	}
+	if (is2t) {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
+			ofdm_index[0], ofdm_index[1],
+			cck_index);
+	} else {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"new OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			ofdm_index[0], cck_index);
+	}
+	ele_d = (ofdmswing_table[ofdm_index[0]] & 0xFFC00000) >> 22;
+	val_x = rtlphy->iqk_matrix[indexforchannel].value[0][0];
+	val_y = rtlphy->iqk_matrix[indexforchannel].value[0][1];
+	if (val_x != 0) {
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+		ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
+
+		/* new element C = element D x Y */
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+		ele_c = ((val_y * ele_d) >> 8) & 0x000003FF;
+
+		/* write new elements A, C, D to regC80 and
+		 * regC94, element B is always 0
+		 */
+		value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+			      MASKDWORD, value32);
+
+		value32 = (ele_c & 0x000003C0) >> 6;
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
+			      value32);
+
+		value32 = ((val_x * ele_d) >> 7) & 0x01;
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
+			      value32);
+
+	} else {
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+			      MASKDWORD,
+			      ofdmswing_table[(u8)ofdm_index[0]]);
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
+			      0x00);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+			      BIT(24), 0x00);
+	}
+
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
+		rtlhal->interfaceindex,
+		val_x, val_y, ele_a, ele_c, ele_d,
+		val_x, val_y);
+
+	if (cck_index >= CCK_TABLE_SIZE)
+		cck_index = CCK_TABLE_SIZE - 1;
+	if (cck_index < 0)
+		cck_index = 0;
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		/* Adjust CCK according to IQK result */
+		if (!rtlpriv->dm.cck_inch14) {
+			rtl_write_byte(rtlpriv, 0xa22,
+				       cckswing_table_ch1ch13[cck_index][0]);
+			rtl_write_byte(rtlpriv, 0xa23,
+				       cckswing_table_ch1ch13[cck_index][1]);
+			rtl_write_byte(rtlpriv, 0xa24,
+				       cckswing_table_ch1ch13[cck_index][2]);
+			rtl_write_byte(rtlpriv, 0xa25,
+				       cckswing_table_ch1ch13[cck_index][3]);
+			rtl_write_byte(rtlpriv, 0xa26,
+				       cckswing_table_ch1ch13[cck_index][4]);
+			rtl_write_byte(rtlpriv, 0xa27,
+				       cckswing_table_ch1ch13[cck_index][5]);
+			rtl_write_byte(rtlpriv, 0xa28,
+				       cckswing_table_ch1ch13[cck_index][6]);
+			rtl_write_byte(rtlpriv, 0xa29,
+				       cckswing_table_ch1ch13[cck_index][7]);
+		} else {
+			rtl_write_byte(rtlpriv, 0xa22,
+				       cckswing_table_ch14[cck_index][0]);
+			rtl_write_byte(rtlpriv, 0xa23,
+				       cckswing_table_ch14[cck_index][1]);
+			rtl_write_byte(rtlpriv, 0xa24,
+				       cckswing_table_ch14[cck_index][2]);
+			rtl_write_byte(rtlpriv, 0xa25,
+				       cckswing_table_ch14[cck_index][3]);
+			rtl_write_byte(rtlpriv, 0xa26,
+				       cckswing_table_ch14[cck_index][4]);
+			rtl_write_byte(rtlpriv, 0xa27,
+				       cckswing_table_ch14[cck_index][5]);
+			rtl_write_byte(rtlpriv, 0xa28,
+				       cckswing_table_ch14[cck_index][6]);
+			rtl_write_byte(rtlpriv, 0xa29,
+				       cckswing_table_ch14[cck_index][7]);
+		}
+	}
+	if (is2t) {
+		ele_d = (ofdmswing_table[ofdm_index[1]] & 0xFFC00000) >> 22;
+		val_x = rtlphy->iqk_matrix[indexforchannel].value[0][4];
+		val_y = rtlphy->iqk_matrix[indexforchannel].value[0][5];
+		if (val_x != 0) {
+			if ((val_x & 0x00000200) != 0)
+				/* consider minus */
+				val_x = val_x | 0xFFFFFC00;
+			ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
+			/* new element C = element D x Y */
+			if ((val_y & 0x00000200) != 0)
+				val_y = val_y | 0xFFFFFC00;
+			ele_c = ((val_y * ele_d) >> 8) & 0x00003FF;
+			/* write new elements A, C, D to regC88
+			 * and regC9C, element B is always 0
+			 */
+			value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
+			rtl_set_bbreg(hw,
+				      ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD, value32);
+			value32 = (ele_c & 0x000003C0) >> 6;
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
+				      MASKH4BITS, value32);
+			value32 = ((val_x * ele_d) >> 7) & 0x01;
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+				      BIT(28), value32);
+		} else {
+			rtl_set_bbreg(hw,
+				      ROFDM0_XBTXIQIMBALANCE,
+				      MASKDWORD,
+				      ofdmswing_table[ofdm_index[1]]);
+			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
+				      MASKH4BITS, 0x00);
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
+				      BIT(28), 0x00);
+		}
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
+			val_x, val_y, ele_a, ele_c,
+			ele_d, val_x, val_y);
+	}
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
+		rtl_get_bbreg(hw, 0xc80, MASKDWORD),
+		rtl_get_bbreg(hw, 0xc94, MASKDWORD),
+		rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
+			      RFREG_OFFSET_MASK));
+
+check_delta:
+	if (delta_iqk > rtlefuse->delta_iqk && rtlefuse->delta_iqk != 0) {
+		rtl92d_phy_reset_iqk_result(hw);
+		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
+		rtlpriv->cfg->ops->phy_iq_calibrate(hw);
+	}
+	if (delta_rxgain > 0 && rtlhal->current_bandtype == BAND_ON_5G &&
+	    thermalvalue <= rtlefuse->eeprom_thermalmeter) {
+		rtlpriv->dm.thermalvalue_rxgain = thermalvalue;
+		rtl92d_dm_rxgain_tracking_thermalmeter(hw);
+	}
+	if (rtlpriv->dm.txpower_track_control)
+		rtlpriv->dm.thermalvalue = thermalvalue;
+
+exit:
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
+}
+
+void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlpriv->dm.txpower_tracking = true;
+	rtlpriv->dm.txpower_trackinginit = false;
+	rtlpriv->dm.txpower_track_control = true;
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"pMgntInfo->txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_initialize_txpower_tracking);
+
+void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (!rtlpriv->dm.txpower_tracking)
+		return;
+
+	if (!rtlpriv->dm.tm_trigger) {
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17) |
+			      BIT(16), 0x03);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 92S Thermal Meter!!\n");
+		rtlpriv->dm.tm_trigger = 1;
+	} else {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking direct call!!\n");
+		rtl92d_dm_txpower_tracking_callback_thermalmeter(hw);
+		rtlpriv->dm.tm_trigger = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_check_txpower_tracking_thermal_meter);
+
+void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
+{
+	u32 ret_value;
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct false_alarm_statistics *falsealm_cnt = &rtlpriv->falsealm_cnt;
+	unsigned long flag = 0;
+
+	/* hold ofdm counter */
+	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 1); /* hold page C counter */
+	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 1); /*hold page D counter */
+
+	ret_value = rtl_get_bbreg(hw, ROFDM0_FRAMESYNC, MASKDWORD);
+	falsealm_cnt->cnt_fast_fsync_fail = (ret_value & 0xffff);
+	falsealm_cnt->cnt_sb_search_fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER1, MASKDWORD);
+	falsealm_cnt->cnt_parity_fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER2, MASKDWORD);
+	falsealm_cnt->cnt_rate_illegal = (ret_value & 0xffff);
+	falsealm_cnt->cnt_crc8_fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER3, MASKDWORD);
+	falsealm_cnt->cnt_mcs_fail = (ret_value & 0xffff);
+	falsealm_cnt->cnt_ofdm_fail = falsealm_cnt->cnt_parity_fail +
+				      falsealm_cnt->cnt_rate_illegal +
+				      falsealm_cnt->cnt_crc8_fail +
+				      falsealm_cnt->cnt_mcs_fail +
+				      falsealm_cnt->cnt_fast_fsync_fail +
+				      falsealm_cnt->cnt_sb_search_fail;
+
+	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
+		/* hold cck counter */
+		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+		ret_value = rtl_get_bbreg(hw, RCCK0_FACOUNTERLOWER, MASKBYTE0);
+		falsealm_cnt->cnt_cck_fail = ret_value;
+		ret_value = rtl_get_bbreg(hw, RCCK0_FACOUNTERUPPER, MASKBYTE3);
+		falsealm_cnt->cnt_cck_fail += (ret_value & 0xff) << 8;
+		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+	} else {
+		falsealm_cnt->cnt_cck_fail = 0;
+	}
+
+	/* reset false alarm counter registers */
+	falsealm_cnt->cnt_all = falsealm_cnt->cnt_fast_fsync_fail +
+				falsealm_cnt->cnt_sb_search_fail +
+				falsealm_cnt->cnt_parity_fail +
+				falsealm_cnt->cnt_rate_illegal +
+				falsealm_cnt->cnt_crc8_fail +
+				falsealm_cnt->cnt_mcs_fail +
+				falsealm_cnt->cnt_cck_fail;
+
+	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 1);
+	/* update ofdm counter */
+	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 0);
+	/* update page C counter */
+	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 0);
+	/* update page D counter */
+	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 0);
+	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
+		/* reset cck counter */
+		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 0);
+		/* enable cck counter */
+		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
+		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+	}
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
+		falsealm_cnt->cnt_fast_fsync_fail,
+		falsealm_cnt->cnt_sb_search_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
+		falsealm_cnt->cnt_parity_fail,
+		falsealm_cnt->cnt_rate_illegal,
+		falsealm_cnt->cnt_crc8_fail,
+		falsealm_cnt->cnt_mcs_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
+		falsealm_cnt->cnt_ofdm_fail,
+		falsealm_cnt->cnt_cck_fail,
+		falsealm_cnt->cnt_all);
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_false_alarm_counter_statistics);
+
+void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+
+	/* Determine the minimum RSSI  */
+	if (mac->link_state < MAC80211_LINKED &&
+	    rtlpriv->dm.UNDEC_SM_PWDB == 0) {
+		de_digtable->min_undec_pwdb_for_dm = 0;
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"Not connected to any\n");
+	}
+	if (mac->link_state >= MAC80211_LINKED) {
+		if (mac->opmode == NL80211_IFTYPE_AP ||
+		    mac->opmode == NL80211_IFTYPE_ADHOC) {
+			de_digtable->min_undec_pwdb_for_dm =
+			    rtlpriv->dm.UNDEC_SM_PWDB;
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				 rtlpriv->dm.UNDEC_SM_PWDB);
+		} else {
+			de_digtable->min_undec_pwdb_for_dm =
+			    rtlpriv->dm.undec_sm_pwdb;
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"STA Default Port PWDB = 0x%x\n",
+				de_digtable->min_undec_pwdb_for_dm);
+		}
+	} else {
+		de_digtable->min_undec_pwdb_for_dm = rtlpriv->dm.UNDEC_SM_PWDB;
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"AP Ext Port or disconnect PWDB = 0x%x\n",
+			de_digtable->min_undec_pwdb_for_dm);
+	}
+
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
+		de_digtable->min_undec_pwdb_for_dm);
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_find_minimum_rssi);
+
+static void rtl92d_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+	unsigned long flag = 0;
+
+	if (de_digtable->cursta_cstate == DIG_STA_CONNECT) {
+		if (de_digtable->pre_cck_pd_state == CCK_PD_STAGE_LOWRSSI) {
+			if (de_digtable->min_undec_pwdb_for_dm <= 25)
+				de_digtable->cur_cck_pd_state =
+							 CCK_PD_STAGE_LOWRSSI;
+			else
+				de_digtable->cur_cck_pd_state =
+							 CCK_PD_STAGE_HIGHRSSI;
+		} else {
+			if (de_digtable->min_undec_pwdb_for_dm <= 20)
+				de_digtable->cur_cck_pd_state =
+							 CCK_PD_STAGE_LOWRSSI;
+			else
+				de_digtable->cur_cck_pd_state =
+							 CCK_PD_STAGE_HIGHRSSI;
+		}
+	} else {
+		de_digtable->cur_cck_pd_state = CCK_PD_STAGE_LOWRSSI;
+	}
+	if (de_digtable->pre_cck_pd_state != de_digtable->cur_cck_pd_state) {
+		if (de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI) {
+			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+			rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0x83);
+			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+		} else {
+			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+			rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0xcd);
+			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+		}
+		de_digtable->pre_cck_pd_state = de_digtable->cur_cck_pd_state;
+	}
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
+		de_digtable->cursta_cstate == DIG_STA_CONNECT ?
+		"DIG_STA_CONNECT " : "DIG_STA_DISCONNECT");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
+		de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI ?
+		"Low RSSI " : "High RSSI ");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
+		IS_92D_SINGLEPHY(rtlpriv->rtlhal.version));
+}
+
+void rtl92d_dm_write_dig(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
+		de_digtable->cur_igvalue, de_digtable->pre_igvalue,
+		de_digtable->back_val);
+	if (!de_digtable->dig_enable_flag) {
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
+		de_digtable->pre_igvalue = 0x17;
+		return;
+	}
+	if (de_digtable->pre_igvalue != de_digtable->cur_igvalue) {
+		rtl_set_bbreg(hw, ROFDM0_XAAGCCORE1, 0x7f,
+			      de_digtable->cur_igvalue);
+		rtl_set_bbreg(hw, ROFDM0_XBAGCCORE1, 0x7f,
+			      de_digtable->cur_igvalue);
+		de_digtable->pre_igvalue = de_digtable->cur_igvalue;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_write_dig);
+
+static void rtl92d_early_mode_enabled(struct rtl_priv *rtlpriv)
+{
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+
+	if (rtlpriv->mac80211.link_state >= MAC80211_LINKED &&
+	    rtlpriv->mac80211.vendor == PEER_CISCO) {
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
+		if (de_digtable->last_min_undec_pwdb_for_dm >= 50 &&
+		    de_digtable->min_undec_pwdb_for_dm < 50) {
+			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x00);
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"Early Mode Off\n");
+		} else if (de_digtable->last_min_undec_pwdb_for_dm <= 55 &&
+			   de_digtable->min_undec_pwdb_for_dm > 55) {
+			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"Early Mode On\n");
+		}
+	} else if (!(rtl_read_byte(rtlpriv, REG_EARLY_MODE_CONTROL) & 0xf)) {
+		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
+	}
+}
+
+void rtl92d_dm_dig(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+	u8 value_igi = de_digtable->cur_igvalue;
+	struct false_alarm_statistics *falsealm_cnt = &rtlpriv->falsealm_cnt;
+
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
+	if (rtlpriv->rtlhal.earlymode_enable) {
+		rtl92d_early_mode_enabled(rtlpriv);
+		de_digtable->last_min_undec_pwdb_for_dm =
+				 de_digtable->min_undec_pwdb_for_dm;
+	}
+	if (!rtlpriv->dm.dm_initialgain_enable)
+		return;
+
+	/* because we will send data pkt when scanning
+	 * this will cause some ap like gear-3700 wep TP
+	 * lower if we return here, this is the diff of
+	 * mac80211 driver vs ieee80211 driver
+	 */
+	/* if (rtlpriv->mac80211.act_scanning)
+	 *      return;
+	 */
+
+	/* Not STA mode return tmp */
+	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
+		return;
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
+	/* Decide the current status and if modify initial gain or not */
+	if (rtlpriv->mac80211.link_state >= MAC80211_LINKED)
+		de_digtable->cursta_cstate = DIG_STA_CONNECT;
+	else
+		de_digtable->cursta_cstate = DIG_STA_DISCONNECT;
+
+	/* adjust initial gain according to false alarm counter */
+	if (falsealm_cnt->cnt_all < DM_DIG_FA_TH0)
+		value_igi--;
+	else if (falsealm_cnt->cnt_all < DM_DIG_FA_TH1)
+		value_igi += 0;
+	else if (falsealm_cnt->cnt_all < DM_DIG_FA_TH2)
+		value_igi++;
+	else if (falsealm_cnt->cnt_all >= DM_DIG_FA_TH2)
+		value_igi += 2;
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() Before: large_fa_hit=%d, forbidden_igi=%x\n",
+		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() Before: Recover_cnt=%d, rx_gain_min=%x\n",
+		de_digtable->recover_cnt, de_digtable->rx_gain_min);
+
+	/* deal with abnormally large false alarm */
+	if (falsealm_cnt->cnt_all > 10000) {
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"dm_DIG(): Abnormally false alarm case\n");
+
+		de_digtable->large_fa_hit++;
+		if (de_digtable->forbidden_igi < de_digtable->cur_igvalue) {
+			de_digtable->forbidden_igi = de_digtable->cur_igvalue;
+			de_digtable->large_fa_hit = 1;
+		}
+		if (de_digtable->large_fa_hit >= 3) {
+			if ((de_digtable->forbidden_igi + 1) > DM_DIG_MAX)
+				de_digtable->rx_gain_min = DM_DIG_MAX;
+			else
+				de_digtable->rx_gain_min =
+				    (de_digtable->forbidden_igi + 1);
+			de_digtable->recover_cnt = 3600;	/* 3600=2hr */
+		}
+	} else {
+		/* Recovery mechanism for IGI lower bound */
+		if (de_digtable->recover_cnt != 0) {
+			de_digtable->recover_cnt--;
+		} else {
+			if (de_digtable->large_fa_hit == 0) {
+				if ((de_digtable->forbidden_igi - 1) <
+				    DM_DIG_FA_LOWER) {
+					de_digtable->forbidden_igi =
+							 DM_DIG_FA_LOWER;
+					de_digtable->rx_gain_min =
+							 DM_DIG_FA_LOWER;
+
+				} else {
+					de_digtable->forbidden_igi--;
+					de_digtable->rx_gain_min =
+					    (de_digtable->forbidden_igi + 1);
+				}
+			} else if (de_digtable->large_fa_hit == 3) {
+				de_digtable->large_fa_hit = 0;
+			}
+		}
+	}
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() After: large_fa_hit=%d, forbidden_igi=%x\n",
+		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() After: recover_cnt=%d, rx_gain_min=%x\n",
+		de_digtable->recover_cnt, de_digtable->rx_gain_min);
+
+	if (value_igi > DM_DIG_MAX)
+		value_igi = DM_DIG_MAX;
+	else if (value_igi < de_digtable->rx_gain_min)
+		value_igi = de_digtable->rx_gain_min;
+	de_digtable->cur_igvalue = value_igi;
+	rtl92d_dm_write_dig(hw);
+	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G)
+		rtl92d_dm_cck_packet_detection_thresh(hw);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_dig);
+
+void rtl92d_dm_init_edca_turbo(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlpriv->dm.current_turbo_edca = false;
+	rtlpriv->dm.is_any_nonbepkts = false;
+	rtlpriv->dm.is_cur_rdlstate = false;
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_init_edca_turbo);
+
+void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	const u32 edca_be_ul = 0x5ea42b;
+	const u32 edca_be_dl = 0x5ea42b;
+	static u64 last_txok_cnt;
+	static u64 last_rxok_cnt;
+	u64 cur_txok_cnt;
+	u64 cur_rxok_cnt;
+
+	if (mac->link_state != MAC80211_LINKED) {
+		rtlpriv->dm.current_turbo_edca = false;
+		goto exit;
+	}
+
+	if (!rtlpriv->dm.is_any_nonbepkts &&
+	    !rtlpriv->dm.disable_framebursting) {
+		cur_txok_cnt = rtlpriv->stats.txbytesunicast - last_txok_cnt;
+		cur_rxok_cnt = rtlpriv->stats.rxbytesunicast - last_rxok_cnt;
+		if (cur_rxok_cnt > 4 * cur_txok_cnt) {
+			if (!rtlpriv->dm.is_cur_rdlstate ||
+			    !rtlpriv->dm.current_turbo_edca) {
+				rtl_write_dword(rtlpriv, REG_EDCA_BE_PARAM,
+						edca_be_dl);
+				rtlpriv->dm.is_cur_rdlstate = true;
+			}
+		} else {
+			if (rtlpriv->dm.is_cur_rdlstate ||
+			    !rtlpriv->dm.current_turbo_edca) {
+				rtl_write_dword(rtlpriv, REG_EDCA_BE_PARAM,
+						edca_be_ul);
+				rtlpriv->dm.is_cur_rdlstate = false;
+			}
+		}
+		rtlpriv->dm.current_turbo_edca = true;
+	} else {
+		if (rtlpriv->dm.current_turbo_edca) {
+			u8 tmp = AC0_BE;
+
+			rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_AC_PARAM,
+						      &tmp);
+			rtlpriv->dm.current_turbo_edca = false;
+		}
+	}
+
+exit:
+	rtlpriv->dm.is_any_nonbepkts = false;
+	last_txok_cnt = rtlpriv->stats.txbytesunicast;
+	last_rxok_cnt = rtlpriv->stats.rxbytesunicast;
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_check_edca_turbo);
+
+void rtl92d_dm_init_rate_adaptive_mask(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rate_adaptive *ra = &rtlpriv->ra;
+
+	ra->ratr_state = DM_RATR_STA_INIT;
+	ra->pre_ratr_state = DM_RATR_STA_INIT;
+	if (rtlpriv->dm.dm_type == DM_TYPE_BYDRIVER)
+		rtlpriv->dm.useramask = true;
+	else
+		rtlpriv->dm.useramask = false;
+}
+EXPORT_SYMBOL_GPL(rtl92d_dm_init_rate_adaptive_mask);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
new file mode 100644
index 000000000000..5e21c6a1d1bc
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef	__RTL92D_DM_COMMON_H__
+#define __RTL92D_DM_COMMON_H__
+
+#define HAL_DM_DIG_DISABLE			BIT(0)
+#define HAL_DM_HIPWR_DISABLE			BIT(1)
+
+#define OFDM_TABLE_LENGTH			37
+#define OFDM_TABLE_SIZE_92D			43
+#define CCK_TABLE_LENGTH			33
+
+#define CCK_TABLE_SIZE				33
+
+#define BW_AUTO_SWITCH_HIGH_LOW			25
+#define BW_AUTO_SWITCH_LOW_HIGH			30
+
+#define DM_DIG_FA_UPPER				0x32
+#define DM_DIG_FA_LOWER				0x20
+#define DM_DIG_FA_TH0				0x100
+#define DM_DIG_FA_TH1				0x400
+#define DM_DIG_FA_TH2				0x600
+
+#define RXPATHSELECTION_SS_TH_LOW		30
+#define RXPATHSELECTION_DIFF_TH			18
+
+#define DM_RATR_STA_INIT			0
+#define DM_RATR_STA_HIGH			1
+#define DM_RATR_STA_MIDDLE			2
+#define DM_RATR_STA_LOW				3
+
+#define CTS2SELF_THVAL				30
+#define REGC38_TH				20
+
+#define WAIOTTHVAL				25
+
+#define TXHIGHPWRLEVEL_NORMAL			0
+#define TXHIGHPWRLEVEL_LEVEL1			1
+#define TXHIGHPWRLEVEL_LEVEL2			2
+#define TXHIGHPWRLEVEL_BT1			3
+#define TXHIGHPWRLEVEL_BT2			4
+
+#define DM_TYPE_BYFW				0
+#define DM_TYPE_BYDRIVER			1
+
+#define TX_POWER_NEAR_FIELD_THRESH_LVL2		74
+#define TX_POWER_NEAR_FIELD_THRESH_LVL1		67
+#define INDEX_MAPPING_NUM			13
+
+struct swat {
+	u8 failure_cnt;
+	u8 try_flag;
+	u8 stop_trying;
+	long pre_rssi;
+	long trying_threshold;
+	u8 cur_antenna;
+	u8 pre_antenna;
+};
+
+enum tag_dynamic_init_gain_operation_type_definition {
+	DIG_TYPE_THRESH_HIGH = 0,
+	DIG_TYPE_THRESH_LOW = 1,
+	DIG_TYPE_BACKOFF = 2,
+	DIG_TYPE_RX_GAIN_MIN = 3,
+	DIG_TYPE_RX_GAIN_MAX = 4,
+	DIG_TYPE_ENABLE = 5,
+	DIG_TYPE_DISABLE = 6,
+	DIG_OP_TYPE_MAX
+};
+
+enum dm_1r_cca {
+	CCA_1R = 0,
+	CCA_2R = 1,
+	CCA_MAX = 2,
+};
+
+enum dm_rf {
+	RF_SAVE = 0,
+	RF_NORMAL = 1,
+	RF_MAX = 2,
+};
+
+enum dm_sw_ant_switch {
+	ANS_ANTENNA_B = 1,
+	ANS_ANTENNA_A = 2,
+	ANS_ANTENNA_MAX = 3,
+};
+
+void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw);
+void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw);
+void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw);
+void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw);
+void rtl92d_dm_write_dig(struct ieee80211_hw *hw);
+void rtl92d_dm_dig(struct ieee80211_hw *hw);
+void rtl92d_dm_init_edca_turbo(struct ieee80211_hw *hw);
+void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw);
+void rtl92d_dm_init_rate_adaptive_mask(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
new file mode 100644
index 000000000000..73cfa9ad78ae
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../base.h"
+#include "../efuse.h"
+#include "def.h"
+#include "reg.h"
+#include "fw_common.h"
+
+bool rtl92d_is_fw_downloaded(struct rtl_priv *rtlpriv)
+{
+	return (rtl_read_dword(rtlpriv, REG_MCUFWDL) & MCUFWDL_RDY) ?
+		true : false;
+}
+EXPORT_SYMBOL_GPL(rtl92d_is_fw_downloaded);
+
+void rtl92d_enable_fw_download(struct ieee80211_hw *hw, bool enable)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 tmp;
+
+	if (enable) {
+		tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
+		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, tmp | 0x04);
+		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, tmp | 0x01);
+		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL + 2);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL + 2, tmp & 0xf7);
+	} else {
+		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, tmp & 0xfe);
+		/* Reserved for fw extension.
+		 * 0x81[7] is used for mac0 status ,
+		 * so don't write this reg here
+		 * rtl_write_byte(rtlpriv, REG_MCUFWDL + 1, 0x00);
+		 */
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_enable_fw_download);
+
+void rtl92d_write_fw(struct ieee80211_hw *hw,
+		     enum version_8192d version, u8 *buffer, u32 size)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 *bufferptr = buffer;
+	u32 pagenums, remainsize;
+	u32 page, offset;
+
+	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE)
+		rtl_fill_dummy(bufferptr, &size);
+	pagenums = size / FW_8192D_PAGE_SIZE;
+	remainsize = size % FW_8192D_PAGE_SIZE;
+	if (pagenums > 8)
+		pr_err("Page numbers should not greater then 8\n");
+	for (page = 0; page < pagenums; page++) {
+		offset = page * FW_8192D_PAGE_SIZE;
+		rtl_fw_page_write(hw, page, (bufferptr + offset),
+				  FW_8192D_PAGE_SIZE);
+	}
+	if (remainsize) {
+		offset = pagenums * FW_8192D_PAGE_SIZE;
+		page = pagenums;
+		rtl_fw_page_write(hw, page, (bufferptr + offset), remainsize);
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_write_fw);
+
+int rtl92d_fw_free_to_go(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 counter = 0;
+	u32 value32;
+
+	do {
+		value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
+	} while ((counter++ < FW_8192D_POLLING_TIMEOUT_COUNT) &&
+		 (!(value32 & FWDL_CHKSUM_RPT)));
+	if (counter >= FW_8192D_POLLING_TIMEOUT_COUNT) {
+		pr_err("chksum report fail! REG_MCUFWDL:0x%08x\n",
+		       value32);
+		return -EIO;
+	}
+	value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
+	value32 |= MCUFWDL_RDY;
+	rtl_write_dword(rtlpriv, REG_MCUFWDL, value32);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtl92d_fw_free_to_go);
+
+void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 u1b_tmp;
+	u8 delay = 100;
+
+	/* Set (REG_HMETFR + 3) to  0x20 is reset 8051 */
+	rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
+	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
+	while (u1b_tmp & BIT(2)) {
+		delay--;
+		if (delay == 0)
+			break;
+		udelay(50);
+		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
+	}
+	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"=====> 8051 reset success (%d)\n", delay);
+}
+EXPORT_SYMBOL_GPL(rtl92d_firmware_selfreset);
+
+int rtl92d_fw_init(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u32 counter;
+
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
+	/* polling for FW ready */
+	counter = 0;
+	do {
+		if (rtlhal->interfaceindex == 0) {
+			if (rtl_read_byte(rtlpriv, FW_MAC0_READY) &
+			    MAC0_READY) {
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
+					rtl_read_byte(rtlpriv,
+						      FW_MAC0_READY));
+				return 0;
+			}
+			udelay(5);
+		} else {
+			if (rtl_read_byte(rtlpriv, FW_MAC1_READY) &
+			    MAC1_READY) {
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
+					rtl_read_byte(rtlpriv,
+						      FW_MAC1_READY));
+				return 0;
+			}
+			udelay(5);
+		}
+	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
+
+	if (rtlhal->interfaceindex == 0) {
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Polling FW ready fail!! MAC0 FW init not ready: 0x%x\n",
+			rtl_read_byte(rtlpriv, FW_MAC0_READY));
+	} else {
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Polling FW ready fail!! MAC1 FW init not ready: 0x%x\n",
+			rtl_read_byte(rtlpriv, FW_MAC1_READY));
+	}
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
+		rtl_read_dword(rtlpriv, REG_MCUFWDL));
+	return -1;
+}
+EXPORT_SYMBOL_GPL(rtl92d_fw_init);
+
+static bool _rtl92d_check_fw_read_last_h2c(struct ieee80211_hw *hw, u8 boxnum)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 val_hmetfr;
+	bool result = false;
+
+	val_hmetfr = rtl_read_byte(rtlpriv, REG_HMETFR);
+	if (((val_hmetfr >> boxnum) & BIT(0)) == 0)
+		result = true;
+	return result;
+}
+
+static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
+				     u8 element_id, u32 cmd_len, u8 *cmdbuffer)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	u8 boxnum;
+	u16 box_reg = 0, box_extreg = 0;
+	u8 u1b_tmp;
+	bool isfw_read = false;
+	u8 buf_index = 0;
+	bool bwrite_success = false;
+	u8 wait_h2c_limmit = 100;
+	u8 wait_writeh2c_limmit = 100;
+	u8 boxcontent[4], boxextcontent[2];
+	u32 h2c_waitcounter = 0;
+	unsigned long flag;
+	u8 idx;
+
+	if (ppsc->rfpwr_state == ERFOFF || ppsc->inactive_pwrstate == ERFOFF) {
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Return as RF is off!!!\n");
+		return;
+	}
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+	while (true) {
+		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
+		if (rtlhal->h2c_setinprogress) {
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"H2C set in progress! Wait to set..element_id(%d)\n",
+				element_id);
+
+			while (rtlhal->h2c_setinprogress) {
+				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
+						       flag);
+				h2c_waitcounter++;
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Wait 100 us (%d times)...\n",
+					h2c_waitcounter);
+				udelay(100);
+
+				if (h2c_waitcounter > 1000)
+					return;
+
+				spin_lock_irqsave(&rtlpriv->locks.h2c_lock,
+						  flag);
+			}
+			spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
+		} else {
+			rtlhal->h2c_setinprogress = true;
+			spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
+			break;
+		}
+	}
+	while (!bwrite_success) {
+		wait_writeh2c_limmit--;
+		if (wait_writeh2c_limmit == 0) {
+			pr_err("Write H2C fail because no trigger for FW INT!\n");
+			break;
+		}
+		boxnum = rtlhal->last_hmeboxnum;
+		switch (boxnum) {
+		case 0:
+			box_reg = REG_HMEBOX_0;
+			box_extreg = REG_HMEBOX_EXT_0;
+			break;
+		case 1:
+			box_reg = REG_HMEBOX_1;
+			box_extreg = REG_HMEBOX_EXT_1;
+			break;
+		case 2:
+			box_reg = REG_HMEBOX_2;
+			box_extreg = REG_HMEBOX_EXT_2;
+			break;
+		case 3:
+			box_reg = REG_HMEBOX_3;
+			box_extreg = REG_HMEBOX_EXT_3;
+			break;
+		default:
+			pr_err("switch case %#x not processed\n",
+			       boxnum);
+			break;
+		}
+		isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
+		while (!isfw_read) {
+			wait_h2c_limmit--;
+			if (wait_h2c_limmit == 0) {
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Waiting too long for FW read clear HMEBox(%d)!\n",
+					boxnum);
+				break;
+			}
+			udelay(10);
+			isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
+			u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
+				boxnum, u1b_tmp);
+		}
+		if (!isfw_read) {
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
+				boxnum);
+			break;
+		}
+		memset(boxcontent, 0, sizeof(boxcontent));
+		memset(boxextcontent, 0, sizeof(boxextcontent));
+		boxcontent[0] = element_id;
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Write element_id box_reg(%4x) = %2x\n",
+			box_reg, element_id);
+		switch (cmd_len) {
+		case 1:
+			boxcontent[0] &= ~(BIT(7));
+			memcpy(boxcontent + 1, cmdbuffer + buf_index, 1);
+			for (idx = 0; idx < 4; idx++)
+				rtl_write_byte(rtlpriv, box_reg + idx,
+					       boxcontent[idx]);
+			break;
+		case 2:
+			boxcontent[0] &= ~(BIT(7));
+			memcpy(boxcontent + 1, cmdbuffer + buf_index, 2);
+			for (idx = 0; idx < 4; idx++)
+				rtl_write_byte(rtlpriv, box_reg + idx,
+					       boxcontent[idx]);
+			break;
+		case 3:
+			boxcontent[0] &= ~(BIT(7));
+			memcpy(boxcontent + 1, cmdbuffer + buf_index, 3);
+			for (idx = 0; idx < 4; idx++)
+				rtl_write_byte(rtlpriv, box_reg + idx,
+					       boxcontent[idx]);
+			break;
+		case 4:
+			boxcontent[0] |= (BIT(7));
+			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
+			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 2);
+			for (idx = 0; idx < 2; idx++)
+				rtl_write_byte(rtlpriv, box_extreg + idx,
+					       boxextcontent[idx]);
+			for (idx = 0; idx < 4; idx++)
+				rtl_write_byte(rtlpriv, box_reg + idx,
+					       boxcontent[idx]);
+			break;
+		case 5:
+			boxcontent[0] |= (BIT(7));
+			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
+			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 3);
+			for (idx = 0; idx < 2; idx++)
+				rtl_write_byte(rtlpriv, box_extreg + idx,
+					       boxextcontent[idx]);
+			for (idx = 0; idx < 4; idx++)
+				rtl_write_byte(rtlpriv, box_reg + idx,
+					       boxcontent[idx]);
+			break;
+		default:
+			pr_err("switch case %#x not processed\n",
+			       cmd_len);
+			break;
+		}
+		bwrite_success = true;
+		rtlhal->last_hmeboxnum = boxnum + 1;
+		if (rtlhal->last_hmeboxnum == 4)
+			rtlhal->last_hmeboxnum = 0;
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"pHalData->last_hmeboxnum  = %d\n",
+			rtlhal->last_hmeboxnum);
+	}
+	spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
+	rtlhal->h2c_setinprogress = false;
+	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
+}
+
+void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
+			 u8 element_id, u32 cmd_len, u8 *cmdbuffer)
+{
+	u32 tmp_cmdbuf[2];
+
+	memset(tmp_cmdbuf, 0, 8);
+	memcpy(tmp_cmdbuf, cmdbuffer, cmd_len);
+	_rtl92d_fill_h2c_command(hw, element_id, cmd_len, (u8 *)&tmp_cmdbuf);
+}
+EXPORT_SYMBOL_GPL(rtl92d_fill_h2c_cmd);
+
+void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus)
+{
+	u8 u1_joinbssrpt_parm[1] = {0};
+
+	u1_joinbssrpt_parm[0] = mstatus;
+	rtl92d_fill_h2c_cmd(hw, H2C_JOINBSSRPT, 1, u1_joinbssrpt_parm);
+}
+EXPORT_SYMBOL_GPL(rtl92d_set_fw_joinbss_report_cmd);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
new file mode 100644
index 000000000000..bf3add89be87
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D__FW_COMMON_H__
+#define __RTL92D__FW_COMMON_H__
+
+#define FW_8192D_START_ADDRESS			0x1000
+#define FW_8192D_PAGE_SIZE			4096
+#define FW_8192D_POLLING_TIMEOUT_COUNT		1000
+
+#define IS_FW_HEADER_EXIST(_pfwhdr)	\
+		((GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFF0) == 0x92C0 || \
+		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFF0) == 0x88C0 ||  \
+		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D0 ||  \
+		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D1 ||  \
+		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D2 ||  \
+		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D3)
+
+/* Firmware Header(8-byte alinment required) */
+/* --- LONG WORD 0 ---- */
+#define GET_FIRMWARE_HDR_SIGNATURE(__fwhdr)		\
+	le32_get_bits(*(__le32 *)__fwhdr, GENMASK(15, 0))
+#define GET_FIRMWARE_HDR_VERSION(__fwhdr)		\
+	le32_get_bits(*(__le32 *)((__fwhdr) + 4), GENMASK(15, 0))
+#define GET_FIRMWARE_HDR_SUB_VER(__fwhdr)		\
+	le32_get_bits(*(__le32 *)((__fwhdr) + 4), GENMASK(23, 16))
+
+bool rtl92d_is_fw_downloaded(struct rtl_priv *rtlpriv);
+void rtl92d_enable_fw_download(struct ieee80211_hw *hw, bool enable);
+void rtl92d_write_fw(struct ieee80211_hw *hw,
+		     enum version_8192d version, u8 *buffer, u32 size);
+int rtl92d_fw_free_to_go(struct ieee80211_hw *hw);
+void rtl92d_firmware_selfreset(struct ieee80211_hw *hw);
+int rtl92d_fw_init(struct ieee80211_hw *hw);
+void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
+			 u32 cmd_len, u8 *p_cmdbuffer);
+void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
new file mode 100644
index 000000000000..849c5fcfd7a5
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
@@ -0,0 +1,1191 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../cam.h"
+#include "../efuse.h"
+#include "../pci.h"
+#include "../regd.h"
+#include "def.h"
+#include "reg.h"
+#include "dm_common.h"
+#include "fw_common.h"
+#include "hw_common.h"
+#include "phy_common.h"
+
+void rtl92de_stop_tx_beacon(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 tmp1byte;
+
+	tmp1byte = rtl_read_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2);
+	rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2, tmp1byte & (~BIT(6)));
+	rtl_write_byte(rtlpriv, REG_BCN_MAX_ERR, 0xff);
+	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 1, 0x64);
+	tmp1byte = rtl_read_byte(rtlpriv, REG_TBTT_PROHIBIT + 2);
+	tmp1byte &= ~(BIT(0));
+	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
+}
+EXPORT_SYMBOL_GPL(rtl92de_stop_tx_beacon);
+
+void rtl92de_resume_tx_beacon(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 tmp1byte;
+
+	tmp1byte = rtl_read_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2);
+	rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2, tmp1byte | BIT(6));
+	rtl_write_byte(rtlpriv, REG_BCN_MAX_ERR, 0x0a);
+	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 1, 0xff);
+	tmp1byte = rtl_read_byte(rtlpriv, REG_TBTT_PROHIBIT + 2);
+	tmp1byte |= BIT(0);
+	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
+}
+EXPORT_SYMBOL_GPL(rtl92de_resume_tx_beacon);
+
+void rtl92d_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+
+	switch (variable) {
+	case HW_VAR_RF_STATE:
+		*((enum rf_pwrstate *)(val)) = ppsc->rfpwr_state;
+		break;
+	case HW_VAR_FWLPS_RF_ON:{
+		enum rf_pwrstate rfstate;
+		u32 val_rcr;
+
+		rtlpriv->cfg->ops->get_hw_reg(hw, HW_VAR_RF_STATE,
+					      (u8 *)(&rfstate));
+		if (rfstate == ERFOFF) {
+			*((bool *)(val)) = true;
+		} else {
+			val_rcr = rtl_read_dword(rtlpriv, REG_RCR);
+			val_rcr &= 0x00070000;
+			if (val_rcr)
+				*((bool *)(val)) = false;
+			else
+				*((bool *)(val)) = true;
+		}
+		break;
+	}
+	case HW_VAR_FW_PSMODE_STATUS:
+		*((bool *)(val)) = ppsc->fw_current_inpsmode;
+		break;
+	case HW_VAR_CORRECT_TSF:{
+		u64 tsf;
+		u32 *ptsf_low = (u32 *)&tsf;
+		u32 *ptsf_high = ((u32 *)&tsf) + 1;
+
+		*ptsf_high = rtl_read_dword(rtlpriv, (REG_TSFTR + 4));
+		*ptsf_low = rtl_read_dword(rtlpriv, REG_TSFTR);
+		*((u64 *)(val)) = tsf;
+		break;
+	}
+	case HW_VAR_INT_MIGRATION:
+		*((bool *)(val)) = rtlpriv->dm.interrupt_migration;
+		break;
+	case HW_VAR_INT_AC:
+		*((bool *)(val)) = rtlpriv->dm.disable_tx_int;
+		break;
+	case HAL_DEF_WOWLAN:
+		break;
+	default:
+		pr_err("switch case %#x not processed\n", variable);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_get_hw_reg);
+
+void rtl92d_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	u8 idx;
+
+	switch (variable) {
+	case HW_VAR_ETHER_ADDR:
+		for (idx = 0; idx < ETH_ALEN; idx++) {
+			rtl_write_byte(rtlpriv, (REG_MACID + idx),
+				       val[idx]);
+		}
+		break;
+	case HW_VAR_BASIC_RATE: {
+		u16 rate_cfg = ((u16 *)val)[0];
+		u8 rate_index = 0;
+
+		rate_cfg = rate_cfg & 0x15f;
+		if (mac->vendor == PEER_CISCO &&
+		    ((rate_cfg & 0x150) == 0))
+			rate_cfg |= 0x01;
+		rtl_write_byte(rtlpriv, REG_RRSR, rate_cfg & 0xff);
+		rtl_write_byte(rtlpriv, REG_RRSR + 1,
+			       (rate_cfg >> 8) & 0xff);
+		while (rate_cfg > 0x1) {
+			rate_cfg = (rate_cfg >> 1);
+			rate_index++;
+		}
+		if (rtlhal->fw_version > 0xe)
+			rtl_write_byte(rtlpriv, REG_INIRTS_RATE_SEL,
+				       rate_index);
+		break;
+	}
+	case HW_VAR_BSSID:
+		for (idx = 0; idx < ETH_ALEN; idx++) {
+			rtl_write_byte(rtlpriv, (REG_BSSID + idx),
+				       val[idx]);
+		}
+		break;
+	case HW_VAR_SIFS:
+		rtl_write_byte(rtlpriv, REG_SIFS_CTX + 1, val[0]);
+		rtl_write_byte(rtlpriv, REG_SIFS_TRX + 1, val[1]);
+		rtl_write_byte(rtlpriv, REG_SPEC_SIFS + 1, val[0]);
+		rtl_write_byte(rtlpriv, REG_MAC_SPEC_SIFS + 1, val[0]);
+		if (!mac->ht_enable)
+			rtl_write_word(rtlpriv, REG_RESP_SIFS_OFDM,
+				       0x0e0e);
+		else
+			rtl_write_word(rtlpriv, REG_RESP_SIFS_OFDM,
+				       *((u16 *)val));
+		break;
+	case HW_VAR_SLOT_TIME: {
+		u8 e_aci;
+
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
+		for (e_aci = 0; e_aci < AC_MAX; e_aci++)
+			rtlpriv->cfg->ops->set_hw_reg(hw,
+						      HW_VAR_AC_PARAM,
+						      (&e_aci));
+		break;
+	}
+	case HW_VAR_ACK_PREAMBLE: {
+		u8 reg_tmp;
+		u8 short_preamble = (bool)(*val);
+
+		reg_tmp = (mac->cur_40_prime_sc) << 5;
+		if (short_preamble)
+			reg_tmp |= 0x80;
+		rtl_write_byte(rtlpriv, REG_RRSR + 2, reg_tmp);
+		break;
+	}
+	case HW_VAR_AMPDU_MIN_SPACE: {
+		u8 min_spacing_to_set;
+
+		min_spacing_to_set = *val;
+		if (min_spacing_to_set <= 7) {
+			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
+					      min_spacing_to_set);
+			*val = min_spacing_to_set;
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+				mac->min_space_cfg);
+			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
+				       mac->min_space_cfg);
+		}
+		break;
+	}
+	case HW_VAR_SHORTGI_DENSITY: {
+		u8 density_to_set;
+
+		density_to_set = *val;
+		mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
+		mac->min_space_cfg |= (density_to_set << 3);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+			mac->min_space_cfg);
+		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
+			       mac->min_space_cfg);
+		break;
+	}
+	case HW_VAR_AMPDU_FACTOR: {
+		u8 factor_toset;
+		u32 regtoset;
+		u8 *ptmp_byte = NULL;
+		u8 index;
+
+		if (rtlhal->macphymode == DUALMAC_DUALPHY)
+			regtoset = 0xb9726641;
+		else if (rtlhal->macphymode == DUALMAC_SINGLEPHY)
+			regtoset = 0x66626641;
+		else
+			regtoset = 0xb972a841;
+		factor_toset = *val;
+		if (factor_toset <= 3) {
+			factor_toset = (1 << (factor_toset + 2));
+			if (factor_toset > 0xf)
+				factor_toset = 0xf;
+			for (index = 0; index < 4; index++) {
+				ptmp_byte = (u8 *)(&regtoset) + index;
+				if ((*ptmp_byte & 0xf0) >
+				    (factor_toset << 4))
+					*ptmp_byte = (*ptmp_byte & 0x0f)
+						 | (factor_toset << 4);
+				if ((*ptmp_byte & 0x0f) > factor_toset)
+					*ptmp_byte = (*ptmp_byte & 0xf0)
+						     | (factor_toset);
+			}
+			rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, regtoset);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+				factor_toset);
+		}
+		break;
+	}
+	case HW_VAR_RETRY_LIMIT: {
+		u8 retry_limit = val[0];
+
+		rtl_write_word(rtlpriv, REG_RL,
+			       retry_limit << RETRY_LIMIT_SHORT_SHIFT |
+			       retry_limit << RETRY_LIMIT_LONG_SHIFT);
+		break;
+	}
+	case HW_VAR_DUAL_TSF_RST:
+		rtl_write_byte(rtlpriv, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
+		break;
+	case HW_VAR_EFUSE_BYTES:
+		rtlefuse->efuse_usedbytes = *((u16 *)val);
+		break;
+	case HW_VAR_EFUSE_USAGE:
+		rtlefuse->efuse_usedpercentage = *val;
+		break;
+	case HW_VAR_IO_CMD:
+		rtl92d_phy_set_io_cmd(hw, (*(enum io_type *)val));
+		break;
+	case HW_VAR_WPA_CONFIG:
+		rtl_write_byte(rtlpriv, REG_SECCFG, *val);
+		break;
+	case HW_VAR_SET_RPWM:
+		rtl92d_fill_h2c_cmd(hw, H2C_PWRM, 1, (val));
+		break;
+	case HW_VAR_H2C_FW_PWRMODE:
+		break;
+	case HW_VAR_FW_PSMODE_STATUS:
+		ppsc->fw_current_inpsmode = *((bool *)val);
+		break;
+	case HW_VAR_AID: {
+		u16 u2btmp;
+
+		u2btmp = rtl_read_word(rtlpriv, REG_BCN_PSR_RPT);
+		u2btmp &= 0xC000;
+		rtl_write_word(rtlpriv, REG_BCN_PSR_RPT, (u2btmp |
+			       mac->assoc_id));
+		break;
+	}
+	default:
+		pr_err("switch case %#x not processed\n", variable);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_set_hw_reg);
+
+bool rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	bool status = true;
+	long count = 0;
+	u32 value = _LLT_INIT_ADDR(address) |
+	    _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
+
+	rtl_write_dword(rtlpriv, REG_LLT_INIT, value);
+	do {
+		value = rtl_read_dword(rtlpriv, REG_LLT_INIT);
+		if (_LLT_OP_VALUE(value) == _LLT_NO_ACTIVE)
+			break;
+		if (count > POLLING_LLT_THRESHOLD) {
+			pr_err("Failed to polling write LLT done at address %d!\n",
+			       address);
+			status = false;
+			break;
+		}
+	} while (++count);
+	return status;
+}
+EXPORT_SYMBOL_GPL(rtl92de_llt_write);
+
+void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 sec_reg_value;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
+		rtlpriv->sec.pairwise_enc_algorithm,
+		rtlpriv->sec.group_enc_algorithm);
+	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"not open hw encryption\n");
+		return;
+	}
+	sec_reg_value = SCR_TXENCENABLE | SCR_RXENCENABLE;
+	if (rtlpriv->sec.use_defaultkey) {
+		sec_reg_value |= SCR_TXUSEDK;
+		sec_reg_value |= SCR_RXUSEDK;
+	}
+	sec_reg_value |= (SCR_RXBCUSEDK | SCR_TXBCUSEDK);
+	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+		"The SECR-value %x\n", sec_reg_value);
+	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
+}
+EXPORT_SYMBOL_GPL(rtl92de_enable_hw_security_config);
+
+/* don't set REG_EDCA_BE_PARAM here because
+ * mac80211 will send pkt when scan
+ */
+void rtl92de_set_qos(struct ieee80211_hw *hw, int aci)
+{
+	rtl92d_dm_init_edca_turbo(hw);
+}
+EXPORT_SYMBOL_GPL(rtl92de_set_qos);
+
+static enum version_8192d _rtl92d_read_chip_version(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	enum version_8192d version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
+	u32 value32;
+
+	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG);
+	if (!(value32 & 0x000f0000)) {
+		version = VERSION_TEST_CHIP_92D_SINGLEPHY;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
+	} else {
+		version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
+	}
+	return version;
+}
+
+static void _rtl92de_readpowervalue_fromprom(struct txpower_info *pwrinfo,
+					     u8 *rom_content, bool autoloadfail)
+{
+	u32 rfpath, eeaddr, group, offset1, offset2;
+	u8 i;
+
+	memset(pwrinfo, 0, sizeof(struct txpower_info));
+	if (autoloadfail) {
+		for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
+			for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
+				if (group < CHANNEL_GROUP_MAX_2G) {
+					pwrinfo->cck_index[rfpath][group] =
+					    EEPROM_DEFAULT_TXPOWERLEVEL_2G;
+					pwrinfo->ht40_1sindex[rfpath][group] =
+					    EEPROM_DEFAULT_TXPOWERLEVEL_2G;
+				} else {
+					pwrinfo->ht40_1sindex[rfpath][group] =
+					    EEPROM_DEFAULT_TXPOWERLEVEL_5G;
+				}
+				pwrinfo->ht40_2sindexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_HT40_2SDIFF;
+				pwrinfo->ht20indexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_HT20_DIFF;
+				pwrinfo->ofdmindexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_LEGACYHTTXPOWERDIFF;
+				pwrinfo->ht40maxoffset[rfpath][group] =
+				    EEPROM_DEFAULT_HT40_PWRMAXOFFSET;
+				pwrinfo->ht20maxoffset[rfpath][group] =
+				    EEPROM_DEFAULT_HT20_PWRMAXOFFSET;
+			}
+		}
+		for (i = 0; i < 3; i++) {
+			pwrinfo->tssi_a[i] = EEPROM_DEFAULT_TSSI;
+			pwrinfo->tssi_b[i] = EEPROM_DEFAULT_TSSI;
+		}
+		return;
+	}
+
+	/* Maybe autoload OK,buf the tx power index value is not filled.
+	 * If we find it, we set it to default value.
+	 */
+	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
+		for (group = 0; group < CHANNEL_GROUP_MAX_2G; group++) {
+			eeaddr = EEPROM_CCK_TX_PWR_INX_2G + (rfpath * 3)
+				 + group;
+			pwrinfo->cck_index[rfpath][group] =
+					(rom_content[eeaddr] == 0xFF) ?
+					     (eeaddr > 0x7B ?
+					     EEPROM_DEFAULT_TXPOWERLEVEL_5G :
+					     EEPROM_DEFAULT_TXPOWERLEVEL_2G) :
+					     rom_content[eeaddr];
+		}
+	}
+	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
+		for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
+			offset1 = group / 3;
+			offset2 = group % 3;
+			eeaddr = EEPROM_HT40_1S_TX_PWR_INX_2G + (rfpath * 3) +
+			    offset2 + offset1 * 21;
+			pwrinfo->ht40_1sindex[rfpath][group] =
+			    (rom_content[eeaddr] == 0xFF) ? (eeaddr > 0x7B ?
+					     EEPROM_DEFAULT_TXPOWERLEVEL_5G :
+					     EEPROM_DEFAULT_TXPOWERLEVEL_2G) :
+						 rom_content[eeaddr];
+		}
+	}
+	/* These just for 92D efuse offset. */
+	for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
+		for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
+			int base1 = EEPROM_HT40_2S_TX_PWR_INX_DIFF_2G;
+
+			offset1 = group / 3;
+			offset2 = group % 3;
+
+			if (rom_content[base1 + offset2 + offset1 * 21] != 0xFF)
+				pwrinfo->ht40_2sindexdiff[rfpath][group] =
+				    (rom_content[base1 +
+				     offset2 + offset1 * 21] >> (rfpath * 4))
+				     & 0xF;
+			else
+				pwrinfo->ht40_2sindexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_HT40_2SDIFF;
+			if (rom_content[EEPROM_HT20_TX_PWR_INX_DIFF_2G + offset2
+			    + offset1 * 21] != 0xFF)
+				pwrinfo->ht20indexdiff[rfpath][group] =
+				    (rom_content[EEPROM_HT20_TX_PWR_INX_DIFF_2G
+				    + offset2 + offset1 * 21] >> (rfpath * 4))
+				    & 0xF;
+			else
+				pwrinfo->ht20indexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_HT20_DIFF;
+			if (rom_content[EEPROM_OFDM_TX_PWR_INX_DIFF_2G + offset2
+			    + offset1 * 21] != 0xFF)
+				pwrinfo->ofdmindexdiff[rfpath][group] =
+				    (rom_content[EEPROM_OFDM_TX_PWR_INX_DIFF_2G
+				     + offset2 + offset1 * 21] >> (rfpath * 4))
+				     & 0xF;
+			else
+				pwrinfo->ofdmindexdiff[rfpath][group] =
+				    EEPROM_DEFAULT_LEGACYHTTXPOWERDIFF;
+			if (rom_content[EEPROM_HT40_MAX_PWR_OFFSET_2G + offset2
+			    + offset1 * 21] != 0xFF)
+				pwrinfo->ht40maxoffset[rfpath][group] =
+				    (rom_content[EEPROM_HT40_MAX_PWR_OFFSET_2G
+				    + offset2 + offset1 * 21] >> (rfpath * 4))
+				    & 0xF;
+			else
+				pwrinfo->ht40maxoffset[rfpath][group] =
+				    EEPROM_DEFAULT_HT40_PWRMAXOFFSET;
+			if (rom_content[EEPROM_HT20_MAX_PWR_OFFSET_2G + offset2
+			    + offset1 * 21] != 0xFF)
+				pwrinfo->ht20maxoffset[rfpath][group] =
+				    (rom_content[EEPROM_HT20_MAX_PWR_OFFSET_2G +
+				     offset2 + offset1 * 21] >> (rfpath * 4)) &
+				     0xF;
+			else
+				pwrinfo->ht20maxoffset[rfpath][group] =
+				    EEPROM_DEFAULT_HT20_PWRMAXOFFSET;
+		}
+	}
+	if (rom_content[EEPROM_TSSI_A_5G] != 0xFF) {
+		/* 5GL */
+		pwrinfo->tssi_a[0] = rom_content[EEPROM_TSSI_A_5G] & 0x3F;
+		pwrinfo->tssi_b[0] = rom_content[EEPROM_TSSI_B_5G] & 0x3F;
+		/* 5GM */
+		pwrinfo->tssi_a[1] = rom_content[EEPROM_TSSI_AB_5G] & 0x3F;
+		pwrinfo->tssi_b[1] =
+		    (rom_content[EEPROM_TSSI_AB_5G] & 0xC0) >> 6 |
+		    (rom_content[EEPROM_TSSI_AB_5G + 1] & 0x0F) << 2;
+		/* 5GH */
+		pwrinfo->tssi_a[2] = (rom_content[EEPROM_TSSI_AB_5G + 1] &
+				      0xF0) >> 4 |
+		    (rom_content[EEPROM_TSSI_AB_5G + 2] & 0x03) << 4;
+		pwrinfo->tssi_b[2] = (rom_content[EEPROM_TSSI_AB_5G + 2] &
+				      0xFC) >> 2;
+	} else {
+		for (i = 0; i < 3; i++) {
+			pwrinfo->tssi_a[i] = EEPROM_DEFAULT_TSSI;
+			pwrinfo->tssi_b[i] = EEPROM_DEFAULT_TSSI;
+		}
+	}
+}
+
+static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
+				       bool autoload_fail, u8 *hwinfo)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct txpower_info pwrinfo;
+	u8 tempval[2], i, pwr, diff;
+	u32 ch, rfpath, group;
+
+	_rtl92de_readpowervalue_fromprom(&pwrinfo, hwinfo, autoload_fail);
+	if (!autoload_fail) {
+		/* bit0~2 */
+		rtlefuse->eeprom_regulatory = (hwinfo[EEPROM_RF_OPT1] & 0x7);
+		rtlefuse->eeprom_thermalmeter =
+			 hwinfo[EEPROM_THERMAL_METER] & 0x1f;
+		rtlefuse->crystalcap = hwinfo[EEPROM_XTAL_K];
+		tempval[0] = hwinfo[EEPROM_IQK_DELTA] & 0x03;
+		tempval[1] = (hwinfo[EEPROM_LCK_DELTA] & 0x0C) >> 2;
+		rtlefuse->txpwr_fromeprom = true;
+		if (IS_92D_D_CUT(rtlpriv->rtlhal.version) ||
+		    IS_92D_E_CUT(rtlpriv->rtlhal.version)) {
+			rtlefuse->internal_pa_5g[0] =
+				!((hwinfo[EEPROM_TSSI_A_5G] & BIT(6)) >> 6);
+			rtlefuse->internal_pa_5g[1] =
+				!((hwinfo[EEPROM_TSSI_B_5G] & BIT(6)) >> 6);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"Is D cut,Internal PA0 %d Internal PA1 %d\n",
+				rtlefuse->internal_pa_5g[0],
+				rtlefuse->internal_pa_5g[1]);
+		}
+		rtlefuse->eeprom_c9 = hwinfo[EEPROM_RF_OPT6];
+		rtlefuse->eeprom_cc = hwinfo[EEPROM_RF_OPT7];
+	} else {
+		rtlefuse->eeprom_regulatory = 0;
+		rtlefuse->eeprom_thermalmeter = EEPROM_DEFAULT_THERMALMETER;
+		rtlefuse->crystalcap = EEPROM_DEFAULT_CRYSTALCAP;
+		tempval[0] = 3;
+		tempval[1] = tempval[0];
+	}
+
+	/* Use default value to fill parameters if
+	 * efuse is not filled on some place.
+	 */
+
+	/* ThermalMeter from EEPROM */
+	if (rtlefuse->eeprom_thermalmeter < 0x06 ||
+	    rtlefuse->eeprom_thermalmeter > 0x1c)
+		rtlefuse->eeprom_thermalmeter = 0x12;
+	rtlefuse->thermalmeter[0] = rtlefuse->eeprom_thermalmeter;
+
+	/* check XTAL_K */
+	if (rtlefuse->crystalcap == 0xFF)
+		rtlefuse->crystalcap = 0;
+	if (rtlefuse->eeprom_regulatory > 3)
+		rtlefuse->eeprom_regulatory = 0;
+
+	for (i = 0; i < 2; i++) {
+		switch (tempval[i]) {
+		case 0:
+			tempval[i] = 5;
+			break;
+		case 1:
+			tempval[i] = 4;
+			break;
+		case 2:
+			tempval[i] = 3;
+			break;
+		case 3:
+		default:
+			tempval[i] = 0;
+			break;
+		}
+	}
+
+	rtlefuse->delta_iqk = tempval[0];
+	if (tempval[1] > 0)
+		rtlefuse->delta_lck = tempval[1] - 1;
+	if (rtlefuse->eeprom_c9 == 0xFF)
+		rtlefuse->eeprom_c9 = 0x00;
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"EEPROMRegulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"ThermalMeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"CrystalCap = 0x%x\n", rtlefuse->crystalcap);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"Delta_IQK = 0x%x Delta_LCK = 0x%x\n",
+		rtlefuse->delta_iqk, rtlefuse->delta_lck);
+
+	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
+		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
+			group = rtl92d_get_chnlgroup_fromarray((u8)ch);
+			if (ch < CHANNEL_MAX_NUMBER_2G)
+				rtlefuse->txpwrlevel_cck[rfpath][ch] =
+				    pwrinfo.cck_index[rfpath][group];
+			rtlefuse->txpwrlevel_ht40_1s[rfpath][ch] =
+				    pwrinfo.ht40_1sindex[rfpath][group];
+			rtlefuse->txpwr_ht20diff[rfpath][ch] =
+				    pwrinfo.ht20indexdiff[rfpath][group];
+			rtlefuse->txpwr_legacyhtdiff[rfpath][ch] =
+				    pwrinfo.ofdmindexdiff[rfpath][group];
+			rtlefuse->pwrgroup_ht20[rfpath][ch] =
+				    pwrinfo.ht20maxoffset[rfpath][group];
+			rtlefuse->pwrgroup_ht40[rfpath][ch] =
+				    pwrinfo.ht40maxoffset[rfpath][group];
+			pwr = pwrinfo.ht40_1sindex[rfpath][group];
+			diff = pwrinfo.ht40_2sindexdiff[rfpath][group];
+			rtlefuse->txpwrlevel_ht40_2s[rfpath][ch] =
+				    (pwr > diff) ? (pwr - diff) : 0;
+		}
+	}
+}
+
+static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
+					       u8 *content)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 macphy_crvalue = content[EEPROM_MAC_FUNCTION];
+
+	if (macphy_crvalue & BIT(3)) {
+		rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode SINGLEMAC_SINGLEPHY\n");
+	} else {
+		rtlhal->macphymode = DUALMAC_DUALPHY;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode DUALMAC_DUALPHY\n");
+	}
+}
+
+static void _rtl92de_read_macphymode_and_bandtype(struct ieee80211_hw *hw,
+						  u8 *content)
+{
+	_rtl92de_read_macphymode_from_prom(hw, content);
+	rtl92d_phy_config_macphymode(hw);
+	rtl92d_phy_config_macphymode_info(hw);
+}
+
+static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	enum version_8192d chipver = rtlpriv->rtlhal.version;
+	u8 cutvalue[2];
+	u16 chipvalue;
+
+	read_efuse_byte(hw, EEPROME_CHIP_VERSION_H, &cutvalue[1]);
+	read_efuse_byte(hw, EEPROME_CHIP_VERSION_L, &cutvalue[0]);
+	chipvalue = (cutvalue[1] << 8) | cutvalue[0];
+	switch (chipvalue) {
+	case 0xAA55:
+		chipver |= CHIP_92D_C_CUT;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
+		break;
+	case 0x9966:
+		chipver |= CHIP_92D_D_CUT;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
+		break;
+	case 0xCC33:
+		chipver |= CHIP_92D_E_CUT;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
+		break;
+	default:
+		chipver |= CHIP_92D_D_CUT;
+		pr_err("Unknown CUT!\n");
+		break;
+	}
+	rtlpriv->rtlhal.version = chipver;
+}
+
+static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
+			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
+			EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+			COUNTRY_CODE_WORLD_WIDE_13};
+	int i;
+	u16 usvalue;
+	u8 *hwinfo;
+
+	hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
+	if (!hwinfo)
+		return;
+
+	if (rtl_get_hwinfo(hw, rtlpriv, HWSET_MAX_SIZE, hwinfo, params))
+		goto exit;
+
+	_rtl92de_efuse_update_chip_version(hw);
+	_rtl92de_read_macphymode_and_bandtype(hw, hwinfo);
+
+	/* Read Permanent MAC address for 2nd interface */
+	if (rtlhal->interfaceindex != 0) {
+		for (i = 0; i < 6; i += 2) {
+			usvalue = *(u16 *)&hwinfo[EEPROM_MAC_ADDR_MAC1_92D + i];
+			*((u16 *)(&rtlefuse->dev_addr[i])) = usvalue;
+		}
+	}
+	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
+				      rtlefuse->dev_addr);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	_rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
+
+	/* Read Channel Plan */
+	switch (rtlhal->bandset) {
+	case BAND_ON_2_4G:
+		rtlefuse->channel_plan = COUNTRY_CODE_TELEC;
+		break;
+	case BAND_ON_5G:
+		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
+		break;
+	case BAND_ON_BOTH:
+		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
+		break;
+	default:
+		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
+		break;
+	}
+	rtlefuse->txpwr_fromeprom = true;
+exit:
+	kfree(hwinfo);
+}
+
+void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 tmp_u1b;
+
+	rtlhal->version = _rtl92d_read_chip_version(hw);
+	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
+	rtlefuse->autoload_status = tmp_u1b;
+	if (tmp_u1b & BIT(4)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
+		rtlefuse->epromtype = EEPROM_93C46;
+	} else {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
+		rtlefuse->epromtype = EEPROM_BOOT_EFUSE;
+	}
+	if (tmp_u1b & BIT(5)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+
+		rtlefuse->autoload_failflag = false;
+		_rtl92de_read_adapter_info(hw);
+	} else {
+		pr_err("Autoload ERR!!\n");
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92de_read_eeprom_info);
+
+static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
+					  struct ieee80211_sta *sta)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u32 ratr_value;
+	u8 ratr_index = 0;
+	u8 nmode = mac->ht_enable;
+	u8 mimo_ps = IEEE80211_SMPS_OFF;
+	u16 shortgi_rate;
+	u32 tmp_ratr_value;
+	u8 curtxbw_40mhz = mac->bw_40;
+	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
+							1 : 0;
+	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
+							1 : 0;
+	enum wireless_mode wirelessmode = mac->mode;
+
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		ratr_value = sta->deflink.supp_rates[1] << 4;
+	else
+		ratr_value = sta->deflink.supp_rates[0];
+	ratr_value |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20 |
+		       sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+	switch (wirelessmode) {
+	case WIRELESS_MODE_A:
+		ratr_value &= 0x00000FF0;
+		break;
+	case WIRELESS_MODE_B:
+		if (ratr_value & 0x0000000c)
+			ratr_value &= 0x0000000d;
+		else
+			ratr_value &= 0x0000000f;
+		break;
+	case WIRELESS_MODE_G:
+		ratr_value &= 0x00000FF5;
+		break;
+	case WIRELESS_MODE_N_24G:
+	case WIRELESS_MODE_N_5G:
+		nmode = 1;
+		if (mimo_ps == IEEE80211_SMPS_STATIC) {
+			ratr_value &= 0x0007F005;
+		} else {
+			u32 ratr_mask;
+
+			if (get_rf_type(rtlphy) == RF_1T2R ||
+			    get_rf_type(rtlphy) == RF_1T1R) {
+				ratr_mask = 0x000ff005;
+			} else {
+				ratr_mask = 0x0f0ff005;
+			}
+
+			ratr_value &= ratr_mask;
+		}
+		break;
+	default:
+		if (rtlphy->rf_type == RF_1T2R)
+			ratr_value &= 0x000ff0ff;
+		else
+			ratr_value &= 0x0f0ff0ff;
+
+		break;
+	}
+	ratr_value &= 0x0FFFFFFF;
+	if (nmode && ((curtxbw_40mhz && curshortgi_40mhz) ||
+		      (!curtxbw_40mhz && curshortgi_20mhz))) {
+		ratr_value |= 0x10000000;
+		tmp_ratr_value = (ratr_value >> 12);
+		for (shortgi_rate = 15; shortgi_rate > 0; shortgi_rate--) {
+			if ((1 << shortgi_rate) & tmp_ratr_value)
+				break;
+		}
+		shortgi_rate = (shortgi_rate << 12) | (shortgi_rate << 8) |
+		    (shortgi_rate << 4) | (shortgi_rate);
+	}
+	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+		rtl_read_dword(rtlpriv, REG_ARFR0));
+}
+
+static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
+					 struct ieee80211_sta *sta,
+					 u8 rssi_level, bool update_bw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_sta_info *sta_entry = NULL;
+	u32 ratr_bitmap;
+	u8 ratr_index;
+	u8 curtxbw_40mhz = (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40) ? 1 : 0;
+	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
+							1 : 0;
+	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
+							1 : 0;
+	enum wireless_mode wirelessmode = 0;
+	bool shortgi = false;
+	u32 value[2];
+	u8 macid = 0;
+	u8 mimo_ps = IEEE80211_SMPS_OFF;
+
+	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+	mimo_ps = sta_entry->mimo_ps;
+	wirelessmode = sta_entry->wireless_mode;
+	if (mac->opmode == NL80211_IFTYPE_STATION)
+		curtxbw_40mhz = mac->bw_40;
+	else if (mac->opmode == NL80211_IFTYPE_AP ||
+		 mac->opmode == NL80211_IFTYPE_ADHOC)
+		macid = sta->aid + 1;
+
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		ratr_bitmap = sta->deflink.supp_rates[1] << 4;
+	else
+		ratr_bitmap = sta->deflink.supp_rates[0];
+	ratr_bitmap |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20 |
+			sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+	switch (wirelessmode) {
+	case WIRELESS_MODE_B:
+		ratr_index = RATR_INX_WIRELESS_B;
+		if (ratr_bitmap & 0x0000000c)
+			ratr_bitmap &= 0x0000000d;
+		else
+			ratr_bitmap &= 0x0000000f;
+		break;
+	case WIRELESS_MODE_G:
+		ratr_index = RATR_INX_WIRELESS_GB;
+
+		if (rssi_level == 1)
+			ratr_bitmap &= 0x00000f00;
+		else if (rssi_level == 2)
+			ratr_bitmap &= 0x00000ff0;
+		else
+			ratr_bitmap &= 0x00000ff5;
+		break;
+	case WIRELESS_MODE_A:
+		ratr_index = RATR_INX_WIRELESS_G;
+		ratr_bitmap &= 0x00000ff0;
+		break;
+	case WIRELESS_MODE_N_24G:
+	case WIRELESS_MODE_N_5G:
+		if (wirelessmode == WIRELESS_MODE_N_24G)
+			ratr_index = RATR_INX_WIRELESS_NGB;
+		else
+			ratr_index = RATR_INX_WIRELESS_NG;
+		if (mimo_ps == IEEE80211_SMPS_STATIC) {
+			if (rssi_level == 1)
+				ratr_bitmap &= 0x00070000;
+			else if (rssi_level == 2)
+				ratr_bitmap &= 0x0007f000;
+			else
+				ratr_bitmap &= 0x0007f005;
+		} else {
+			if (rtlphy->rf_type == RF_1T2R ||
+			    rtlphy->rf_type == RF_1T1R) {
+				if (curtxbw_40mhz) {
+					if (rssi_level == 1)
+						ratr_bitmap &= 0x000f0000;
+					else if (rssi_level == 2)
+						ratr_bitmap &= 0x000ff000;
+					else
+						ratr_bitmap &= 0x000ff015;
+				} else {
+					if (rssi_level == 1)
+						ratr_bitmap &= 0x000f0000;
+					else if (rssi_level == 2)
+						ratr_bitmap &= 0x000ff000;
+					else
+						ratr_bitmap &= 0x000ff005;
+				}
+			} else {
+				if (curtxbw_40mhz) {
+					if (rssi_level == 1)
+						ratr_bitmap &= 0x0f0f0000;
+					else if (rssi_level == 2)
+						ratr_bitmap &= 0x0f0ff000;
+					else
+						ratr_bitmap &= 0x0f0ff015;
+				} else {
+					if (rssi_level == 1)
+						ratr_bitmap &= 0x0f0f0000;
+					else if (rssi_level == 2)
+						ratr_bitmap &= 0x0f0ff000;
+					else
+						ratr_bitmap &= 0x0f0ff005;
+				}
+			}
+		}
+		if ((curtxbw_40mhz && curshortgi_40mhz) ||
+		    (!curtxbw_40mhz && curshortgi_20mhz)) {
+			if (macid == 0)
+				shortgi = true;
+			else if (macid == 1)
+				shortgi = false;
+		}
+		break;
+	default:
+		ratr_index = RATR_INX_WIRELESS_NGB;
+
+		if (rtlphy->rf_type == RF_1T2R)
+			ratr_bitmap &= 0x000ff0ff;
+		else
+			ratr_bitmap &= 0x0f0ff0ff;
+		break;
+	}
+
+	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
+	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x value0:%x value1:%x\n",
+		ratr_bitmap, value[0], value[1]);
+	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
+	if (macid != 0)
+		sta_entry->ratr_index = ratr_index;
+}
+
+void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
+				 struct ieee80211_sta *sta,
+				 u8 rssi_level, bool update_bw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (rtlpriv->dm.useramask)
+		rtl92de_update_hal_rate_mask(hw, sta, rssi_level, update_bw);
+	else
+		rtl92de_update_hal_rate_table(hw, sta);
+}
+EXPORT_SYMBOL_GPL(rtl92de_update_hal_rate_tbl);
+
+void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	u16 sifs_timer;
+
+	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_SLOT_TIME,
+				      &mac->slot_time);
+	if (!mac->ht_enable)
+		sifs_timer = 0x0a0a;
+	else
+		sifs_timer = 0x1010;
+	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_SIFS, (u8 *)&sifs_timer);
+}
+EXPORT_SYMBOL_GPL(rtl92de_update_channel_access_setting);
+
+bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
+	enum rf_pwrstate e_rfpowerstate_toset;
+	u8 u1tmp;
+	bool actuallyset = false;
+	unsigned long flag;
+
+	if (rtlpci->being_init_adapter)
+		return false;
+	if (ppsc->swrf_processing)
+		return false;
+	spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
+	if (ppsc->rfchange_inprogress) {
+		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
+		return false;
+	}
+
+	ppsc->rfchange_inprogress = true;
+	spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
+
+	rtl_write_byte(rtlpriv, REG_MAC_PINMUX_CFG,
+		       rtl_read_byte(rtlpriv, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
+	u1tmp = rtl_read_byte(rtlpriv, REG_GPIO_IO_SEL);
+	e_rfpowerstate_toset = (u1tmp & BIT(3)) ? ERFON : ERFOFF;
+	if (ppsc->hwradiooff && e_rfpowerstate_toset == ERFON) {
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
+		e_rfpowerstate_toset = ERFON;
+		ppsc->hwradiooff = false;
+		actuallyset = true;
+	} else if (!ppsc->hwradiooff && e_rfpowerstate_toset == ERFOFF) {
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
+		e_rfpowerstate_toset = ERFOFF;
+		ppsc->hwradiooff = true;
+		actuallyset = true;
+	}
+	if (actuallyset) {
+		spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
+		ppsc->rfchange_inprogress = false;
+		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
+	} else {
+		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC)
+			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
+		spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
+		ppsc->rfchange_inprogress = false;
+		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
+	}
+	*valid = 1;
+	return !ppsc->hwradiooff;
+}
+EXPORT_SYMBOL_GPL(rtl92de_gpio_radio_on_off_checking);
+
+void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
+		     u8 *p_macaddr, bool is_group, u8 enc_algo,
+		     bool is_wepkey, bool clear_all)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	u8 *macaddr = p_macaddr;
+	u32 entry_id;
+	bool is_pairwise = false;
+	static u8 cam_const_addr[4][6] = {
+		{0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+		{0x00, 0x00, 0x00, 0x00, 0x00, 0x01},
+		{0x00, 0x00, 0x00, 0x00, 0x00, 0x02},
+		{0x00, 0x00, 0x00, 0x00, 0x00, 0x03}
+	};
+	static u8 cam_const_broad[] = {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+
+	if (clear_all) {
+		u8 idx;
+		u8 cam_offset = 0;
+		u8 clear_number = 5;
+
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		for (idx = 0; idx < clear_number; idx++) {
+			rtl_cam_mark_invalid(hw, cam_offset + idx);
+			rtl_cam_empty_entry(hw, cam_offset + idx);
+
+			if (idx < 5) {
+				memset(rtlpriv->sec.key_buf[idx], 0,
+				       MAX_KEY_LEN);
+				rtlpriv->sec.key_len[idx] = 0;
+			}
+		}
+
+		return;
+	}
+
+	switch (enc_algo) {
+	case WEP40_ENCRYPTION:
+		enc_algo = CAM_WEP40;
+		break;
+	case WEP104_ENCRYPTION:
+		enc_algo = CAM_WEP104;
+		break;
+	case TKIP_ENCRYPTION:
+		enc_algo = CAM_TKIP;
+		break;
+	case AESCCMP_ENCRYPTION:
+		enc_algo = CAM_AES;
+		break;
+	default:
+		pr_err("switch case %#x not processed\n",
+		       enc_algo);
+		enc_algo = CAM_TKIP;
+		break;
+	}
+	if (is_wepkey || rtlpriv->sec.use_defaultkey) {
+		macaddr = cam_const_addr[key_index];
+		entry_id = key_index;
+	} else {
+		if (is_group) {
+			macaddr = cam_const_broad;
+			entry_id = key_index;
+		} else {
+			if (mac->opmode == NL80211_IFTYPE_AP) {
+				entry_id = rtl_cam_get_free_entry(hw, p_macaddr);
+				if (entry_id >=  TOTAL_CAM_ENTRY) {
+					pr_err("Can not find free hw security cam entry\n");
+					return;
+				}
+			} else {
+				entry_id = CAM_PAIRWISE_KEY_POSITION;
+			}
+			key_index = PAIRWISE_KEYIDX;
+			is_pairwise = true;
+		}
+	}
+	if (rtlpriv->sec.key_len[key_index] == 0) {
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"delete one entry, entry_id is %d\n",
+			entry_id);
+		if (mac->opmode == NL80211_IFTYPE_AP)
+			rtl_cam_del_entry(hw, p_macaddr);
+		rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
+	} else {
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+			"The insert KEY length is %d\n",
+			rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+			"The insert KEY is %x %x\n",
+			rtlpriv->sec.key_buf[0][0],
+			rtlpriv->sec.key_buf[0][1]);
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"add one entry\n");
+		if (is_pairwise) {
+			RT_PRINT_DATA(rtlpriv, COMP_SEC, DBG_LOUD,
+				      "Pairwise Key content",
+				      rtlpriv->sec.pairwise_key,
+				      rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set Pairwise key\n");
+			rtl_cam_add_one_entry(hw, macaddr, key_index,
+					      entry_id, enc_algo,
+					      CAM_CONFIG_NO_USEDK,
+					      rtlpriv->sec.key_buf[key_index]);
+		} else {
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"set group key\n");
+			if (mac->opmode == NL80211_IFTYPE_ADHOC) {
+				rtl_cam_add_one_entry(hw,
+					rtlefuse->dev_addr,
+					PAIRWISE_KEYIDX,
+					CAM_PAIRWISE_KEY_POSITION,
+					enc_algo, CAM_CONFIG_NO_USEDK,
+					rtlpriv->sec.key_buf[entry_id]);
+			}
+			rtl_cam_add_one_entry(hw, macaddr, key_index,
+					      entry_id, enc_algo,
+					      CAM_CONFIG_NO_USEDK,
+					      rtlpriv->sec.key_buf
+					      [entry_id]);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92de_set_key);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
new file mode 100644
index 000000000000..12b915f15291
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_HW_COMMON_H__
+#define __RTL92DE_HW_COMMON_H__
+
+void rtl92de_stop_tx_beacon(struct ieee80211_hw *hw);
+void rtl92de_resume_tx_beacon(struct ieee80211_hw *hw);
+void rtl92d_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
+void rtl92d_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
+bool rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data);
+void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw);
+void rtl92de_set_qos(struct ieee80211_hw *hw, int aci);
+void rtl92de_read_eeprom_info(struct ieee80211_hw *hw);
+void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
+				 struct ieee80211_sta *sta,
+				 u8 rssi_level, bool update_bw);
+void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw);
+bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid);
+void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
+		     u8 *p_macaddr, bool is_group, u8 enc_algo,
+		     bool is_wepkey, bool clear_all);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
new file mode 100644
index 000000000000..75f7e260a296
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include <linux/module.h>
+
+MODULE_AUTHOR("Realtek WlanFAE	<wlanfae@realtek.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek 8192D 802.11an common routines");
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
new file mode 100644
index 000000000000..f7265712b9c2
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
@@ -0,0 +1,827 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../core.h"
+#include "def.h"
+#include "reg.h"
+#include "dm_common.h"
+#include "phy_common.h"
+#include "rf_common.h"
+
+static const u8 channel_all[59] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
+	36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
+	60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
+	114, 116, 118, 120, 122, 124, 126, 128,	130,
+	132, 134, 136, 138, 140, 149, 151, 153, 155,
+	157, 159, 161, 163, 165
+};
+
+static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
+				      enum radio_path rfpath, u32 offset)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
+	u32 newoffset;
+	u32 tmplong, tmplong2;
+	u8 rfpi_enable = 0;
+	u32 retvalue;
+
+	newoffset = offset;
+	tmplong = rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD);
+	if (rfpath == RF90_PATH_A)
+		tmplong2 = tmplong;
+	else
+		tmplong2 = rtl_get_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD);
+	tmplong2 = (tmplong2 & (~BLSSIREADADDRESS)) |
+		(newoffset << 23) | BLSSIREADEDGE;
+	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
+		      tmplong & (~BLSSIREADEDGE));
+	udelay(10);
+	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
+	udelay(50);
+	udelay(50);
+	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
+		      tmplong | BLSSIREADEDGE);
+	udelay(10);
+	if (rfpath == RF90_PATH_A)
+		rfpi_enable = (u8)rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1,
+						BIT(8));
+	else if (rfpath == RF90_PATH_B)
+		rfpi_enable = (u8)rtl_get_bbreg(hw, RFPGA0_XB_HSSIPARAMETER1,
+						BIT(8));
+	if (rfpi_enable)
+		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rbpi,
+					 BLSSIREADBACKDATA);
+	else
+		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
+					 BLSSIREADBACKDATA);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
+	return retvalue;
+}
+
+static void _rtl92d_phy_rf_serial_write(struct ieee80211_hw *hw,
+					enum radio_path rfpath,
+					u32 offset, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
+	u32 data_and_addr;
+	u32 newoffset;
+
+	newoffset = offset;
+	/* T65 RF */
+	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
+	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset, data_and_addr);
+}
+
+u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
+			    u32 regaddr, u32 bitmask)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 original_value, readback_value, bitshift;
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
+	spin_lock(&rtlpriv->locks.rf_lock);
+	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
+	bitshift = calculate_bit_shift(bitmask);
+	readback_value = (original_value & bitmask) >> bitshift;
+	spin_unlock(&rtlpriv->locks.rf_lock);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
+	return readback_value;
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_query_rf_reg);
+
+void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
+			   u32 regaddr, u32 bitmask, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 original_value, bitshift;
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
+	if (bitmask == 0)
+		return;
+	spin_lock(&rtlpriv->locks.rf_lock);
+	if (rtlphy->rf_mode != RF_OP_BY_FW) {
+		if (bitmask != RFREG_OFFSET_MASK) {
+			original_value = _rtl92d_phy_rf_serial_read(hw,
+								    rfpath,
+								    regaddr);
+			bitshift = calculate_bit_shift(bitmask);
+			data = ((original_value & (~bitmask)) |
+				(data << bitshift));
+		}
+		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
+	}
+	spin_unlock(&rtlpriv->locks.rf_lock);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_set_rf_reg);
+
+void rtl92d_phy_init_bb_rf_register_definition(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+
+	/* RF Interface Sowrtware Control */
+	/* 16 LSBs if read 32-bit from 0x870 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfintfs = RFPGA0_XAB_RFINTERFACESW;
+	/* 16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
+	rtlphy->phyreg_def[RF90_PATH_B].rfintfs = RFPGA0_XAB_RFINTERFACESW;
+	/* 16 LSBs if read 32-bit from 0x874 */
+	rtlphy->phyreg_def[RF90_PATH_C].rfintfs = RFPGA0_XCD_RFINTERFACESW;
+	/* 16 MSBs if read 32-bit from 0x874 (16-bit for 0x876) */
+
+	rtlphy->phyreg_def[RF90_PATH_D].rfintfs = RFPGA0_XCD_RFINTERFACESW;
+	/* RF Interface Readback Value */
+	/* 16 LSBs if read 32-bit from 0x8E0 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfintfi = RFPGA0_XAB_RFINTERFACERB;
+	/* 16 MSBs if read 32-bit from 0x8E0 (16-bit for 0x8E2) */
+	rtlphy->phyreg_def[RF90_PATH_B].rfintfi = RFPGA0_XAB_RFINTERFACERB;
+	/* 16 LSBs if read 32-bit from 0x8E4 */
+	rtlphy->phyreg_def[RF90_PATH_C].rfintfi = RFPGA0_XCD_RFINTERFACERB;
+	/* 16 MSBs if read 32-bit from 0x8E4 (16-bit for 0x8E6) */
+	rtlphy->phyreg_def[RF90_PATH_D].rfintfi = RFPGA0_XCD_RFINTERFACERB;
+
+	/* RF Interface Output (and Enable) */
+	/* 16 LSBs if read 32-bit from 0x860 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfintfo = RFPGA0_XA_RFINTERFACEOE;
+	/* 16 LSBs if read 32-bit from 0x864 */
+	rtlphy->phyreg_def[RF90_PATH_B].rfintfo = RFPGA0_XB_RFINTERFACEOE;
+
+	/* RF Interface (Output and)  Enable */
+	/* 16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
+	rtlphy->phyreg_def[RF90_PATH_A].rfintfe = RFPGA0_XA_RFINTERFACEOE;
+	/* 16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
+	rtlphy->phyreg_def[RF90_PATH_B].rfintfe = RFPGA0_XB_RFINTERFACEOE;
+
+	/* Addr of LSSI. Write RF register by driver */
+	/* LSSI Parameter */
+	rtlphy->phyreg_def[RF90_PATH_A].rf3wire_offset =
+				 RFPGA0_XA_LSSIPARAMETER;
+	rtlphy->phyreg_def[RF90_PATH_B].rf3wire_offset =
+				 RFPGA0_XB_LSSIPARAMETER;
+
+	/* RF parameter */
+	/* BB Band Select */
+	rtlphy->phyreg_def[RF90_PATH_A].rflssi_select = RFPGA0_XAB_RFPARAMETER;
+	rtlphy->phyreg_def[RF90_PATH_B].rflssi_select = RFPGA0_XAB_RFPARAMETER;
+	rtlphy->phyreg_def[RF90_PATH_C].rflssi_select = RFPGA0_XCD_RFPARAMETER;
+	rtlphy->phyreg_def[RF90_PATH_D].rflssi_select = RFPGA0_XCD_RFPARAMETER;
+
+	/* Tx AGC Gain Stage (same for all path. Should we remove this?) */
+	/* Tx gain stage */
+	rtlphy->phyreg_def[RF90_PATH_A].rftxgain_stage = RFPGA0_TXGAINSTAGE;
+	/* Tx gain stage */
+	rtlphy->phyreg_def[RF90_PATH_B].rftxgain_stage = RFPGA0_TXGAINSTAGE;
+	/* Tx gain stage */
+	rtlphy->phyreg_def[RF90_PATH_C].rftxgain_stage = RFPGA0_TXGAINSTAGE;
+	/* Tx gain stage */
+	rtlphy->phyreg_def[RF90_PATH_D].rftxgain_stage = RFPGA0_TXGAINSTAGE;
+
+	/* Transceiver A~D HSSI Parameter-1 */
+	/* wire control parameter1 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfhssi_para1 = RFPGA0_XA_HSSIPARAMETER1;
+	/* wire control parameter1 */
+	rtlphy->phyreg_def[RF90_PATH_B].rfhssi_para1 = RFPGA0_XB_HSSIPARAMETER1;
+
+	/* Transceiver A~D HSSI Parameter-2 */
+	/* wire control parameter2 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfhssi_para2 = RFPGA0_XA_HSSIPARAMETER2;
+	/* wire control parameter2 */
+	rtlphy->phyreg_def[RF90_PATH_B].rfhssi_para2 = RFPGA0_XB_HSSIPARAMETER2;
+
+	/* RF switch Control */
+	/* TR/Ant switch control */
+	rtlphy->phyreg_def[RF90_PATH_A].rfsw_ctrl = RFPGA0_XAB_SWITCHCONTROL;
+	rtlphy->phyreg_def[RF90_PATH_B].rfsw_ctrl = RFPGA0_XAB_SWITCHCONTROL;
+	rtlphy->phyreg_def[RF90_PATH_C].rfsw_ctrl = RFPGA0_XCD_SWITCHCONTROL;
+	rtlphy->phyreg_def[RF90_PATH_D].rfsw_ctrl = RFPGA0_XCD_SWITCHCONTROL;
+
+	/* AGC control 1 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfagc_control1 = ROFDM0_XAAGCCORE1;
+	rtlphy->phyreg_def[RF90_PATH_B].rfagc_control1 = ROFDM0_XBAGCCORE1;
+	rtlphy->phyreg_def[RF90_PATH_C].rfagc_control1 = ROFDM0_XCAGCCORE1;
+	rtlphy->phyreg_def[RF90_PATH_D].rfagc_control1 = ROFDM0_XDAGCCORE1;
+
+	/* AGC control 2  */
+	rtlphy->phyreg_def[RF90_PATH_A].rfagc_control2 = ROFDM0_XAAGCCORE2;
+	rtlphy->phyreg_def[RF90_PATH_B].rfagc_control2 = ROFDM0_XBAGCCORE2;
+	rtlphy->phyreg_def[RF90_PATH_C].rfagc_control2 = ROFDM0_XCAGCCORE2;
+	rtlphy->phyreg_def[RF90_PATH_D].rfagc_control2 = ROFDM0_XDAGCCORE2;
+
+	/* RX AFE control 1 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfrxiq_imbal = ROFDM0_XARXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_B].rfrxiq_imbal = ROFDM0_XBRXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_C].rfrxiq_imbal = ROFDM0_XCRXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_D].rfrxiq_imbal = ROFDM0_XDRXIQIMBALANCE;
+
+	/*RX AFE control 1 */
+	rtlphy->phyreg_def[RF90_PATH_A].rfrx_afe = ROFDM0_XARXAFE;
+	rtlphy->phyreg_def[RF90_PATH_B].rfrx_afe = ROFDM0_XBRXAFE;
+	rtlphy->phyreg_def[RF90_PATH_C].rfrx_afe = ROFDM0_XCRXAFE;
+	rtlphy->phyreg_def[RF90_PATH_D].rfrx_afe = ROFDM0_XDRXAFE;
+
+	/* Tx AFE control 1 */
+	rtlphy->phyreg_def[RF90_PATH_A].rftxiq_imbal = ROFDM0_XATXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_B].rftxiq_imbal = ROFDM0_XBTXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_C].rftxiq_imbal = ROFDM0_XCTXIQIMBALANCE;
+	rtlphy->phyreg_def[RF90_PATH_D].rftxiq_imbal = ROFDM0_XDTXIQIMBALANCE;
+
+	/* Tx AFE control 2 */
+	rtlphy->phyreg_def[RF90_PATH_A].rftx_afe = ROFDM0_XATXAFE;
+	rtlphy->phyreg_def[RF90_PATH_B].rftx_afe = ROFDM0_XBTXAFE;
+	rtlphy->phyreg_def[RF90_PATH_C].rftx_afe = ROFDM0_XCTXAFE;
+	rtlphy->phyreg_def[RF90_PATH_D].rftx_afe = ROFDM0_XDTXAFE;
+
+	/* Transceiver LSSI Readback SI mode */
+	rtlphy->phyreg_def[RF90_PATH_A].rf_rb = RFPGA0_XA_LSSIREADBACK;
+	rtlphy->phyreg_def[RF90_PATH_B].rf_rb = RFPGA0_XB_LSSIREADBACK;
+	rtlphy->phyreg_def[RF90_PATH_C].rf_rb = RFPGA0_XC_LSSIREADBACK;
+	rtlphy->phyreg_def[RF90_PATH_D].rf_rb = RFPGA0_XD_LSSIREADBACK;
+
+	/* Transceiver LSSI Readback PI mode */
+	rtlphy->phyreg_def[RF90_PATH_A].rf_rbpi = TRANSCEIVERA_HSPI_READBACK;
+	rtlphy->phyreg_def[RF90_PATH_B].rf_rbpi = TRANSCEIVERB_HSPI_READBACK;
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_init_bb_rf_register_definition);
+
+void rtl92d_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
+					   u32 regaddr, u32 bitmask, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	int index;
+
+	if (regaddr == RTXAGC_A_RATE18_06)
+		index = 0;
+	else if (regaddr == RTXAGC_A_RATE54_24)
+		index = 1;
+	else if (regaddr == RTXAGC_A_CCK1_MCS32)
+		index = 6;
+	else if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00)
+		index = 7;
+	else if (regaddr == RTXAGC_A_MCS03_MCS00)
+		index = 2;
+	else if (regaddr == RTXAGC_A_MCS07_MCS04)
+		index = 3;
+	else if (regaddr == RTXAGC_A_MCS11_MCS08)
+		index = 4;
+	else if (regaddr == RTXAGC_A_MCS15_MCS12)
+		index = 5;
+	else if (regaddr == RTXAGC_B_RATE18_06)
+		index = 8;
+	else if (regaddr == RTXAGC_B_RATE54_24)
+		index = 9;
+	else if (regaddr == RTXAGC_B_CCK1_55_MCS32)
+		index = 14;
+	else if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff)
+		index = 15;
+	else if (regaddr == RTXAGC_B_MCS03_MCS00)
+		index = 10;
+	else if (regaddr == RTXAGC_B_MCS07_MCS04)
+		index = 11;
+	else if (regaddr == RTXAGC_B_MCS11_MCS08)
+		index = 12;
+	else if (regaddr == RTXAGC_B_MCS15_MCS12)
+		index = 13;
+	else
+		return;
+
+	rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index] = data;
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"MCSTxPowerLevelOriginalOffset[%d][%d] = 0x%x\n",
+		rtlphy->pwrgroup_cnt, index,
+		rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index]);
+	if (index == 13)
+		rtlphy->pwrgroup_cnt++;
+}
+EXPORT_SYMBOL_GPL(rtl92d_store_pwrindex_diffrate_offset);
+
+void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+
+	rtlphy->default_initialgain[0] =
+	    (u8)rtl_get_bbreg(hw, ROFDM0_XAAGCCORE1, MASKBYTE0);
+	rtlphy->default_initialgain[1] =
+	    (u8)rtl_get_bbreg(hw, ROFDM0_XBAGCCORE1, MASKBYTE0);
+	rtlphy->default_initialgain[2] =
+	    (u8)rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
+	rtlphy->default_initialgain[3] =
+	    (u8)rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
+		rtlphy->default_initialgain[0],
+		rtlphy->default_initialgain[1],
+		rtlphy->default_initialgain[2],
+		rtlphy->default_initialgain[3]);
+	rtlphy->framesync = (u8)rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3,
+					      MASKBYTE0);
+	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
+					      MASKDWORD);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default framesync (0x%x) = 0x%x\n",
+		ROFDM0_RXDETECTOR3, rtlphy->framesync);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_get_hw_reg_originalvalue);
+
+static void _rtl92d_get_txpower_index(struct ieee80211_hw *hw, u8 channel,
+				      u8 *cckpowerlevel, u8 *ofdmpowerlevel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	u8 index = (channel - 1);
+
+	/* 1. CCK */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		/* RF-A */
+		cckpowerlevel[RF90_PATH_A] =
+				 rtlefuse->txpwrlevel_cck[RF90_PATH_A][index];
+		/* RF-B */
+		cckpowerlevel[RF90_PATH_B] =
+				 rtlefuse->txpwrlevel_cck[RF90_PATH_B][index];
+	} else {
+		cckpowerlevel[RF90_PATH_A] = 0;
+		cckpowerlevel[RF90_PATH_B] = 0;
+	}
+	/* 2. OFDM for 1S or 2S */
+	if (rtlphy->rf_type == RF_1T2R || rtlphy->rf_type == RF_1T1R) {
+		/*  Read HT 40 OFDM TX power */
+		ofdmpowerlevel[RF90_PATH_A] =
+		    rtlefuse->txpwrlevel_ht40_1s[RF90_PATH_A][index];
+		ofdmpowerlevel[RF90_PATH_B] =
+		    rtlefuse->txpwrlevel_ht40_1s[RF90_PATH_B][index];
+	} else if (rtlphy->rf_type == RF_2T2R) {
+		/* Read HT 40 OFDM TX power */
+		ofdmpowerlevel[RF90_PATH_A] =
+		    rtlefuse->txpwrlevel_ht40_2s[RF90_PATH_A][index];
+		ofdmpowerlevel[RF90_PATH_B] =
+		    rtlefuse->txpwrlevel_ht40_2s[RF90_PATH_B][index];
+	}
+}
+
+static void _rtl92d_ccxpower_index_check(struct ieee80211_hw *hw,
+					 u8 channel, u8 *cckpowerlevel,
+					 u8 *ofdmpowerlevel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+
+	rtlphy->cur_cck_txpwridx = cckpowerlevel[0];
+	rtlphy->cur_ofdm24g_txpwridx = ofdmpowerlevel[0];
+}
+
+static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
+{
+	u8 place = chnl;
+
+	if (chnl > 14) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
+				place++;
+				break;
+			}
+		}
+	}
+	return place;
+}
+
+void rtl92d_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel)
+{
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 cckpowerlevel[2], ofdmpowerlevel[2];
+
+	if (!rtlefuse->txpwr_fromeprom)
+		return;
+	channel = _rtl92c_phy_get_rightchnlplace(channel);
+	_rtl92d_get_txpower_index(hw, channel, &cckpowerlevel[0],
+				  &ofdmpowerlevel[0]);
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G)
+		_rtl92d_ccxpower_index_check(hw, channel, &cckpowerlevel[0],
+					     &ofdmpowerlevel[0]);
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G)
+		rtl92d_phy_rf6052_set_cck_txpower(hw, &cckpowerlevel[0]);
+	rtl92d_phy_rf6052_set_ofdm_txpower(hw, &ofdmpowerlevel[0], channel);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_set_txpower_level);
+
+void rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw, u8 rfpath,
+			      u32 *pu4_regval)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	/*----Store original RFENV control type----*/
+	switch (rfpath) {
+	case RF90_PATH_A:
+	case RF90_PATH_C:
+		*pu4_regval = rtl_get_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV);
+		break;
+	case RF90_PATH_B:
+	case RF90_PATH_D:
+		*pu4_regval =
+		    rtl_get_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16);
+		break;
+	}
+	/*----Set RF_ENV enable----*/
+	rtl_set_bbreg(hw, pphyreg->rfintfe, BRFSI_RFENV << 16, 0x1);
+	udelay(1);
+	/*----Set RF_ENV output high----*/
+	rtl_set_bbreg(hw, pphyreg->rfintfo, BRFSI_RFENV, 0x1);
+	udelay(1);
+	/* Set bit number of Address and Data for RF register */
+	/* Set 1 to 4 bits for 8255 */
+	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREADDRESSLENGTH, 0x0);
+	udelay(1);
+	/*Set 0 to 12 bits for 8255 */
+	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
+	udelay(1);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_enable_rf_env);
+
+void rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
+			       u32 *pu4_regval)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
+	/*----Restore RFENV control type----*/
+	switch (rfpath) {
+	case RF90_PATH_A:
+	case RF90_PATH_C:
+		rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV, *pu4_regval);
+		break;
+	case RF90_PATH_B:
+	case RF90_PATH_D:
+		rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16,
+			      *pu4_regval);
+		break;
+	}
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_restore_rf_env);
+
+u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
+{
+	u8 place;
+
+	if (chnl > 14) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl)
+				return place - 13;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtl92d_get_rightchnlplace_for_iqk);
+
+void rtl92d_phy_save_adda_registers(struct ieee80211_hw *hw, u32 *adda_reg,
+				    u32 *adda_backup, u32 regnum)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Save ADDA parameters.\n");
+	for (i = 0; i < regnum; i++)
+		adda_backup[i] = rtl_get_bbreg(hw, adda_reg[i], MASKDWORD);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_save_adda_registers);
+
+void rtl92d_phy_save_mac_registers(struct ieee80211_hw *hw,
+				   u32 *macreg, u32 *macbackup)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Save MAC parameters.\n");
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
+		macbackup[i] = rtl_read_byte(rtlpriv, macreg[i]);
+	macbackup[i] = rtl_read_dword(rtlpriv, macreg[i]);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_save_mac_registers);
+
+void rtl92d_phy_path_adda_on(struct ieee80211_hw *hw,
+			     u32 *adda_reg, bool patha_on, bool is2t)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 pathon;
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "ADDA ON.\n");
+	pathon = patha_on ? 0x04db25a4 : 0x0b1b25a4;
+	if (patha_on)
+		pathon = rtlpriv->rtlhal.interfaceindex == 0 ?
+		    0x04db25a4 : 0x0b1b25a4;
+	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
+		rtl_set_bbreg(hw, adda_reg[i], MASKDWORD, pathon);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_path_adda_on);
+
+void rtl92d_phy_mac_setting_calibration(struct ieee80211_hw *hw,
+					u32 *macreg, u32 *macbackup)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK, "MAC settings for Calibration.\n");
+	rtl_write_byte(rtlpriv, macreg[0], 0x3F);
+
+	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++)
+		rtl_write_byte(rtlpriv, macreg[i], (u8)(macbackup[i] &
+			       (~BIT(3))));
+	rtl_write_byte(rtlpriv, macreg[i], (u8)(macbackup[i] & (~BIT(5))));
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_mac_setting_calibration);
+
+static u32 _rtl92d_phy_get_abs(u32 val1, u32 val2)
+{
+	u32 ret;
+
+	if (val1 >= val2)
+		ret = val1 - val2;
+	else
+		ret = val2 - val1;
+	return ret;
+}
+
+static bool _rtl92d_is_legal_5g_channel(struct ieee80211_hw *hw, u8 channel)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(channel5g); i++)
+		if (channel == channel5g[i])
+			return true;
+	return false;
+}
+
+void rtl92d_phy_calc_curvindex(struct ieee80211_hw *hw,
+			       u32 *targetchnl, u32 *curvecount_val,
+			       bool is5g, u32 *curveindex)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 smallest_abs_val = 0xffffffff, u4tmp;
+	u8 i, j;
+	u8 chnl_num = is5g ? TARGET_CHNL_NUM_5G : TARGET_CHNL_NUM_2G;
+
+	for (i = 0; i < chnl_num; i++) {
+		if (is5g && !_rtl92d_is_legal_5g_channel(hw, i + 1))
+			continue;
+		curveindex[i] = 0;
+		for (j = 0; j < (CV_CURVE_CNT * 2); j++) {
+			u4tmp = _rtl92d_phy_get_abs(targetchnl[i],
+						    curvecount_val[j]);
+
+			if (u4tmp < smallest_abs_val) {
+				curveindex[i] = j;
+				smallest_abs_val = u4tmp;
+			}
+		}
+		smallest_abs_val = 0xffffffff;
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "curveindex[%d] = %x\n",
+			i, curveindex[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_calc_curvindex);
+
+void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 i;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"settings regs %zu default regs %d\n",
+		ARRAY_SIZE(rtlphy->iqk_matrix),
+		IQK_MATRIX_REG_NUM);
+	/* 0xe94, 0xe9c, 0xea4, 0xeac, 0xeb4, 0xebc, 0xec4, 0xecc */
+	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
+		rtlphy->iqk_matrix[i].value[0][0] = 0x100;
+		rtlphy->iqk_matrix[i].value[0][2] = 0x100;
+		rtlphy->iqk_matrix[i].value[0][4] = 0x100;
+		rtlphy->iqk_matrix[i].value[0][6] = 0x100;
+		rtlphy->iqk_matrix[i].value[0][1] = 0x0;
+		rtlphy->iqk_matrix[i].value[0][3] = 0x0;
+		rtlphy->iqk_matrix[i].value[0][5] = 0x0;
+		rtlphy->iqk_matrix[i].value[0][7] = 0x0;
+		rtlphy->iqk_matrix[i].iqk_done = false;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_reset_iqk_result);
+
+static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"--->Cmd(%#x), set_io_inprogress(%d)\n",
+		rtlphy->current_io_type, rtlphy->set_io_inprogress);
+	switch (rtlphy->current_io_type) {
+	case IO_CMD_RESUME_DM_BY_SCAN:
+		de_digtable->cur_igvalue = rtlphy->initgain_backup.xaagccore1;
+		rtl92d_dm_write_dig(hw);
+		rtl92d_phy_set_txpower_level(hw, rtlphy->current_channel);
+		break;
+	case IO_CMD_PAUSE_DM_BY_SCAN:
+		rtlphy->initgain_backup.xaagccore1 = de_digtable->cur_igvalue;
+		de_digtable->cur_igvalue = 0x37;
+		rtl92d_dm_write_dig(hw);
+		break;
+	default:
+		pr_err("switch case %#x not processed\n",
+		       rtlphy->current_io_type);
+		break;
+	}
+	rtlphy->set_io_inprogress = false;
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
+		rtlphy->current_io_type);
+}
+
+bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	bool postprocessing = false;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"-->IO Cmd(%#x), set_io_inprogress(%d)\n",
+		 iotype, rtlphy->set_io_inprogress);
+	do {
+		switch (iotype) {
+		case IO_CMD_RESUME_DM_BY_SCAN:
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Resume DM after scan\n");
+			postprocessing = true;
+			break;
+		case IO_CMD_PAUSE_DM_BY_SCAN:
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Pause DM before scan\n");
+			postprocessing = true;
+			break;
+		default:
+			pr_err("switch case %#x not processed\n",
+			       iotype);
+			break;
+		}
+	} while (false);
+	if (postprocessing && !rtlphy->set_io_inprogress) {
+		rtlphy->set_io_inprogress = true;
+		rtlphy->current_io_type = iotype;
+	} else {
+		return false;
+	}
+	rtl92d_phy_set_io(hw);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
+	return true;
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_set_io_cmd);
+
+void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 offset = REG_MAC_PHY_CTRL_NORMAL;
+
+	switch (rtlhal->macphymode) {
+	case DUALMAC_DUALPHY:
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: DUALMAC_DUALPHY\n");
+		rtl_write_byte(rtlpriv, offset, 0xF3);
+		break;
+	case SINGLEMAC_SINGLEPHY:
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: SINGLEMAC_SINGLEPHY\n");
+		rtl_write_byte(rtlpriv, offset, 0xF4);
+		break;
+	case DUALMAC_SINGLEPHY:
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: DUALMAC_SINGLEPHY\n");
+		rtl_write_byte(rtlpriv, offset, 0xF1);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_config_macphymode);
+
+void rtl92d_phy_config_macphymode_info(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+
+	switch (rtlhal->macphymode) {
+	case DUALMAC_SINGLEPHY:
+		rtlphy->rf_type = RF_2T2R;
+		rtlhal->version |= RF_TYPE_2T2R;
+		rtlhal->bandset = BAND_ON_BOTH;
+		rtlhal->current_bandtype = BAND_ON_2_4G;
+		break;
+
+	case SINGLEMAC_SINGLEPHY:
+		rtlphy->rf_type = RF_2T2R;
+		rtlhal->version |= RF_TYPE_2T2R;
+		rtlhal->bandset = BAND_ON_BOTH;
+		rtlhal->current_bandtype = BAND_ON_2_4G;
+		break;
+
+	case DUALMAC_DUALPHY:
+		rtlphy->rf_type = RF_1T1R;
+		rtlhal->version &= RF_TYPE_1T1R;
+		/* Now we let MAC0 run on 5G band. */
+		if (rtlhal->interfaceindex == 0) {
+			rtlhal->bandset = BAND_ON_5G;
+			rtlhal->current_bandtype = BAND_ON_5G;
+		} else {
+			rtlhal->bandset = BAND_ON_2_4G;
+			rtlhal->current_bandtype = BAND_ON_2_4G;
+		}
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_config_macphymode_info);
+
+u8 rtl92d_get_chnlgroup_fromarray(u8 chnl)
+{
+	u8 group;
+
+	if (channel_all[chnl] <= 3)
+		group = 0;
+	else if (channel_all[chnl] <= 9)
+		group = 1;
+	else if (channel_all[chnl] <= 14)
+		group = 2;
+	else if (channel_all[chnl] <= 44)
+		group = 3;
+	else if (channel_all[chnl] <= 54)
+		group = 4;
+	else if (channel_all[chnl] <= 64)
+		group = 5;
+	else if (channel_all[chnl] <= 112)
+		group = 6;
+	else if (channel_all[chnl] <= 126)
+		group = 7;
+	else if (channel_all[chnl] <= 140)
+		group = 8;
+	else if (channel_all[chnl] <= 153)
+		group = 9;
+	else if (channel_all[chnl] <= 159)
+		group = 10;
+	else
+		group = 11;
+	return group;
+}
+EXPORT_SYMBOL_GPL(rtl92d_get_chnlgroup_fromarray);
+
+void rtl92d_phy_config_maccoexist_rfpage(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	switch (rtlpriv->rtlhal.macphymode) {
+	case DUALMAC_DUALPHY:
+		rtl_write_byte(rtlpriv, REG_DMC, 0x0);
+		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x08);
+		rtl_write_word(rtlpriv, REG_TRXFF_BNDY + 2, 0x13ff);
+		break;
+	case DUALMAC_SINGLEPHY:
+		rtl_write_byte(rtlpriv, REG_DMC, 0xf8);
+		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x08);
+		rtl_write_word(rtlpriv, REG_TRXFF_BNDY + 2, 0x13ff);
+		break;
+	case SINGLEMAC_SINGLEPHY:
+		rtl_write_byte(rtlpriv, REG_DMC, 0x0);
+		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x10);
+		rtl_write_word(rtlpriv, (REG_TRXFF_BNDY + 2), 0x27FF);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_config_maccoexist_rfpage);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
new file mode 100644
index 000000000000..c196b834ba93
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D_PHY_COMMON_H__
+#define __RTL92D_PHY_COMMON_H__
+
+#define TARGET_CHNL_NUM_5G			221
+#define TARGET_CHNL_NUM_2G			14
+#define CV_CURVE_CNT				64
+#define RT_CANNOT_IO(hw)			false
+#define RX_INDEX_MAPPING_NUM			15
+#define IQK_BB_REG_NUM				10
+
+#define IQK_DELAY_TIME				1
+#define MAX_TOLERANCE				5
+#define MAX_TOLERANCE_92D			3
+
+enum baseband_config_type {
+	BASEBAND_CONFIG_PHY_REG = 0,
+	BASEBAND_CONFIG_AGC_TAB = 1,
+};
+
+enum rf_content {
+	radioa_txt = 0,
+	radiob_txt = 1,
+	radioc_txt = 2,
+	radiod_txt = 3
+};
+
+static inline void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
+						     unsigned long *flag)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (rtlpriv->rtlhal.interfaceindex == 1)
+		spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, *flag);
+}
+
+static inline void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
+						     unsigned long *flag)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (rtlpriv->rtlhal.interfaceindex == 1)
+		spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock,
+				       *flag);
+}
+
+u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
+			    u32 regaddr, u32 bitmask);
+void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
+			   u32 regaddr, u32 bitmask, u32 data);
+void rtl92d_phy_init_bb_rf_register_definition(struct ieee80211_hw *hw);
+void rtl92d_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
+					   u32 regaddr, u32 bitmask, u32 data);
+void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw);
+void rtl92d_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel);
+void rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw, u8 rfpath,
+			      u32 *pu4_regval);
+void rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
+			       u32 *pu4_regval);
+u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl);
+void rtl92d_phy_save_adda_registers(struct ieee80211_hw *hw, u32 *adda_reg,
+				    u32 *adda_backup, u32 regnum);
+void rtl92d_phy_save_mac_registers(struct ieee80211_hw *hw,
+				   u32 *macreg, u32 *macbackup);
+void rtl92d_phy_path_adda_on(struct ieee80211_hw *hw,
+			     u32 *adda_reg, bool patha_on, bool is2t);
+void rtl92d_phy_mac_setting_calibration(struct ieee80211_hw *hw,
+					u32 *macreg, u32 *macbackup);
+void rtl92d_phy_calc_curvindex(struct ieee80211_hw *hw,
+			       u32 *targetchnl, u32 *curvecount_val,
+			       bool is5g, u32 *curveindex);
+void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw);
+bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype);
+void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw);
+void rtl92d_phy_config_macphymode_info(struct ieee80211_hw *hw);
+u8 rtl92d_get_chnlgroup_fromarray(u8 chnl);
+void rtl92d_phy_config_maccoexist_rfpage(struct ieee80211_hw *hw);
+/* Without these declarations sparse warns about context imbalance. */
+void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
+				       unsigned long *flag);
+void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
+				       unsigned long *flag);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
similarity index 100%
rename from drivers/net/wireless/realtek/rtlwifi/rtl8192de/reg.h
rename to drivers/net/wireless/realtek/rtlwifi/rtl8192d/reg.h
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
new file mode 100644
index 000000000000..62613f57bf0b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "def.h"
+#include "reg.h"
+#include "rf_common.h"
+
+void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 rfpath;
+
+	switch (bandwidth) {
+	case HT_CHANNEL_WIDTH_20:
+		for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
+			rtlphy->rfreg_chnlval[rfpath] = ((rtlphy->rfreg_chnlval
+					[rfpath] & 0xfffff3ff) | 0x0400);
+			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) |
+				      BIT(11), 0x01);
+
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"20M RF 0x18 = 0x%x\n",
+				rtlphy->rfreg_chnlval[rfpath]);
+		}
+
+		break;
+	case HT_CHANNEL_WIDTH_20_40:
+		for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
+			rtlphy->rfreg_chnlval[rfpath] =
+			    ((rtlphy->rfreg_chnlval[rfpath] & 0xfffff3ff));
+			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) | BIT(11),
+				      0x00);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"40M RF 0x18 = 0x%x\n",
+				rtlphy->rfreg_chnlval[rfpath]);
+		}
+		break;
+	default:
+		pr_err("unknown bandwidth: %#X\n", bandwidth);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_rf6052_set_bandwidth);
+
+void rtl92d_phy_rf6052_set_cck_txpower(struct ieee80211_hw *hw,
+				       u8 *ppowerlevel)
+{
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 tx_agc[2] = {0, 0}, tmpval;
+	bool turbo_scanoff = false;
+	u8 idx1, idx2;
+	u8 *ptr;
+
+	if (rtlefuse->eeprom_regulatory != 0)
+		turbo_scanoff = true;
+	if (mac->act_scanning) {
+		tx_agc[RF90_PATH_A] = 0x3f3f3f3f;
+		tx_agc[RF90_PATH_B] = 0x3f3f3f3f;
+		if (turbo_scanoff) {
+			for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
+				tx_agc[idx1] = ppowerlevel[idx1] |
+				    (ppowerlevel[idx1] << 8) |
+				    (ppowerlevel[idx1] << 16) |
+				    (ppowerlevel[idx1] << 24);
+			}
+		}
+	} else {
+		for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
+			tx_agc[idx1] = ppowerlevel[idx1] |
+			    (ppowerlevel[idx1] << 8) |
+			    (ppowerlevel[idx1] << 16) |
+			    (ppowerlevel[idx1] << 24);
+		}
+		if (rtlefuse->eeprom_regulatory == 0) {
+			tmpval = (rtlphy->mcs_offset[0][6]) +
+			    (rtlphy->mcs_offset[0][7] << 8);
+			tx_agc[RF90_PATH_A] += tmpval;
+			tmpval = (rtlphy->mcs_offset[0][14]) +
+			    (rtlphy->mcs_offset[0][15] << 24);
+			tx_agc[RF90_PATH_B] += tmpval;
+		}
+	}
+
+	for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
+		ptr = (u8 *)(&tx_agc[idx1]);
+		for (idx2 = 0; idx2 < 4; idx2++) {
+			if (*ptr > RF6052_MAX_TX_PWR)
+				*ptr = RF6052_MAX_TX_PWR;
+			ptr++;
+		}
+	}
+
+	tmpval = tx_agc[RF90_PATH_A] & 0xff;
+	rtl_set_bbreg(hw, RTXAGC_A_CCK1_MCS32, MASKBYTE1, tmpval);
+	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+		"CCK PWR 1M (rf-A) = 0x%x (reg 0x%x)\n",
+		tmpval, RTXAGC_A_CCK1_MCS32);
+	tmpval = tx_agc[RF90_PATH_A] >> 8;
+	rtl_set_bbreg(hw, RTXAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
+	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+		"CCK PWR 2~11M (rf-A) = 0x%x (reg 0x%x)\n",
+		tmpval, RTXAGC_B_CCK11_A_CCK2_11);
+	tmpval = tx_agc[RF90_PATH_B] >> 24;
+	rtl_set_bbreg(hw, RTXAGC_B_CCK11_A_CCK2_11, MASKBYTE0, tmpval);
+	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+		"CCK PWR 11M (rf-B) = 0x%x (reg 0x%x)\n",
+		tmpval, RTXAGC_B_CCK11_A_CCK2_11);
+	tmpval = tx_agc[RF90_PATH_B] & 0x00ffffff;
+	rtl_set_bbreg(hw, RTXAGC_B_CCK1_55_MCS32, 0xffffff00, tmpval);
+	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+		"CCK PWR 1~5.5M (rf-B) = 0x%x (reg 0x%x)\n",
+		tmpval, RTXAGC_B_CCK1_55_MCS32);
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_rf6052_set_cck_txpower);
+
+static void _rtl92d_phy_get_power_base(struct ieee80211_hw *hw,
+				       u8 *ppowerlevel, u8 channel,
+				       u32 *ofdmbase, u32 *mcsbase)
+{
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 powerbase0, powerbase1;
+	u8 legacy_pwrdiff, ht20_pwrdiff;
+	u8 i, powerlevel[2];
+
+	for (i = 0; i < 2; i++) {
+		powerlevel[i] = ppowerlevel[i];
+		legacy_pwrdiff = rtlefuse->txpwr_legacyhtdiff[i][channel - 1];
+		powerbase0 = powerlevel[i] + legacy_pwrdiff;
+		powerbase0 = (powerbase0 << 24) | (powerbase0 << 16) |
+		    (powerbase0 << 8) | powerbase0;
+		*(ofdmbase + i) = powerbase0;
+		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+			" [OFDM power base index rf(%c) = 0x%x]\n",
+			i == 0 ? 'A' : 'B', *(ofdmbase + i));
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20) {
+			ht20_pwrdiff = rtlefuse->txpwr_ht20diff[i][channel - 1];
+			powerlevel[i] += ht20_pwrdiff;
+		}
+		powerbase1 = powerlevel[i];
+		powerbase1 = (powerbase1 << 24) | (powerbase1 << 16) |
+			     (powerbase1 << 8) | powerbase1;
+		*(mcsbase + i) = powerbase1;
+		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+			" [MCS power base index rf(%c) = 0x%x]\n",
+			i == 0 ? 'A' : 'B', *(mcsbase + i));
+	}
+}
+
+static u8 _rtl92d_phy_get_chnlgroup_bypg(u8 chnlindex)
+{
+	u8 group;
+	u8 channel_info[59] = {
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
+		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
+		60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
+		114, 116, 118, 120, 122, 124, 126, 128,	130, 132,
+		134, 136, 138, 140, 149, 151, 153, 155, 157, 159,
+		161, 163, 165
+	};
+
+	if (channel_info[chnlindex] <= 3)	/* Chanel 1-3 */
+		group = 0;
+	else if (channel_info[chnlindex] <= 9)	/* Channel 4-9 */
+		group = 1;
+	else if (channel_info[chnlindex] <= 14)	/* Channel 10-14 */
+		group = 2;
+	else if (channel_info[chnlindex] <= 64)
+		group = 6;
+	else if (channel_info[chnlindex] <= 140)
+		group = 7;
+	else
+		group = 8;
+	return group;
+}
+
+static void _rtl92d_get_txpower_writeval_by_regulatory(struct ieee80211_hw *hw,
+						       u8 channel, u8 index,
+						       u32 *powerbase0,
+						       u32 *powerbase1,
+						       u32 *p_outwriteval)
+{
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 i, chnlgroup = 0, pwr_diff_limit[4];
+	u32 writeval = 0, customer_limit, rf;
+
+	for (rf = 0; rf < 2; rf++) {
+		switch (rtlefuse->eeprom_regulatory) {
+		case 0:
+			chnlgroup = 0;
+			writeval = rtlphy->mcs_offset
+					[chnlgroup][index +
+					(rf ? 8 : 0)] + ((index < 2) ?
+					powerbase0[rf] :
+					powerbase1[rf]);
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"RTK better performance, writeval(%c) = 0x%x\n",
+				rf == 0 ? 'A' : 'B', writeval);
+			break;
+		case 1:
+			if (rtlphy->pwrgroup_cnt == 1)
+				chnlgroup = 0;
+			if (rtlphy->pwrgroup_cnt >= MAX_PG_GROUP) {
+				chnlgroup = _rtl92d_phy_get_chnlgroup_bypg(channel - 1);
+				if (rtlphy->current_chan_bw ==
+				    HT_CHANNEL_WIDTH_20)
+					chnlgroup++;
+				else
+					chnlgroup += 4;
+				writeval = rtlphy->mcs_offset
+						[chnlgroup][index +
+						(rf ? 8 : 0)] + ((index < 2) ?
+						powerbase0[rf] :
+						powerbase1[rf]);
+				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+					"Realtek regulatory, 20MHz, writeval(%c) = 0x%x\n",
+					rf == 0 ? 'A' : 'B', writeval);
+			}
+			break;
+		case 2:
+			writeval = ((index < 2) ? powerbase0[rf] :
+				   powerbase1[rf]);
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"Better regulatory, writeval(%c) = 0x%x\n",
+				rf == 0 ? 'A' : 'B', writeval);
+			break;
+		case 3:
+			chnlgroup = 0;
+			if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
+				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+					"customer's limit, 40MHz rf(%c) = 0x%x\n",
+					rf == 0 ? 'A' : 'B',
+					rtlefuse->pwrgroup_ht40[rf]
+					[channel - 1]);
+			} else {
+				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+					"customer's limit, 20MHz rf(%c) = 0x%x\n",
+					rf == 0 ? 'A' : 'B',
+					rtlefuse->pwrgroup_ht20[rf]
+					[channel - 1]);
+			}
+			for (i = 0; i < 4; i++) {
+				pwr_diff_limit[i] = (u8)((rtlphy->mcs_offset
+					[chnlgroup][index + (rf ? 8 : 0)] &
+					(0x7f << (i * 8))) >> (i * 8));
+				if (rtlphy->current_chan_bw ==
+				    HT_CHANNEL_WIDTH_20_40) {
+					if (pwr_diff_limit[i] >
+					    rtlefuse->pwrgroup_ht40[rf]
+					   [channel - 1])
+						pwr_diff_limit[i] =
+							rtlefuse->pwrgroup_ht40
+							[rf][channel - 1];
+				} else {
+					if (pwr_diff_limit[i] >
+					    rtlefuse->pwrgroup_ht20[rf][channel - 1])
+						pwr_diff_limit[i] =
+						   rtlefuse->pwrgroup_ht20[rf]
+						   [channel - 1];
+				}
+			}
+			customer_limit = (pwr_diff_limit[3] << 24) |
+					 (pwr_diff_limit[2] << 16) |
+					 (pwr_diff_limit[1] << 8) |
+					 (pwr_diff_limit[0]);
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"Customer's limit rf(%c) = 0x%x\n",
+				rf == 0 ? 'A' : 'B', customer_limit);
+			writeval = customer_limit + ((index < 2) ?
+				   powerbase0[rf] : powerbase1[rf]);
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"Customer, writeval rf(%c)= 0x%x\n",
+				rf == 0 ? 'A' : 'B', writeval);
+			break;
+		default:
+			chnlgroup = 0;
+			writeval = rtlphy->mcs_offset[chnlgroup][index +
+				   (rf ? 8 : 0)] + ((index < 2) ?
+				   powerbase0[rf] : powerbase1[rf]);
+			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+				"RTK better performance, writeval rf(%c) = 0x%x\n",
+				rf == 0 ? 'A' : 'B', writeval);
+			break;
+		}
+		*(p_outwriteval + rf) = writeval;
+	}
+}
+
+static void _rtl92d_write_ofdm_power_reg(struct ieee80211_hw *hw,
+					 u8 index, u32 *pvalue)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	static const u16 regoffset_a[6] = {
+		RTXAGC_A_RATE18_06, RTXAGC_A_RATE54_24,
+		RTXAGC_A_MCS03_MCS00, RTXAGC_A_MCS07_MCS04,
+		RTXAGC_A_MCS11_MCS08, RTXAGC_A_MCS15_MCS12
+	};
+	static const u16 regoffset_b[6] = {
+		RTXAGC_B_RATE18_06, RTXAGC_B_RATE54_24,
+		RTXAGC_B_MCS03_MCS00, RTXAGC_B_MCS07_MCS04,
+		RTXAGC_B_MCS11_MCS08, RTXAGC_B_MCS15_MCS12
+	};
+	u8 i, rf, pwr_val[4];
+	u32 writeval;
+	u16 regoffset;
+
+	for (rf = 0; rf < 2; rf++) {
+		writeval = pvalue[rf];
+		for (i = 0; i < 4; i++) {
+			pwr_val[i] = (u8)((writeval & (0x7f <<
+				     (i * 8))) >> (i * 8));
+			if (pwr_val[i] > RF6052_MAX_TX_PWR)
+				pwr_val[i] = RF6052_MAX_TX_PWR;
+		}
+		writeval = (pwr_val[3] << 24) | (pwr_val[2] << 16) |
+			   (pwr_val[1] << 8) | pwr_val[0];
+		if (rf == 0)
+			regoffset = regoffset_a[index];
+		else
+			regoffset = regoffset_b[index];
+		rtl_set_bbreg(hw, regoffset, MASKDWORD, writeval);
+		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
+			"Set 0x%x = %08x\n", regoffset, writeval);
+		if (((get_rf_type(rtlphy) == RF_2T2R) &&
+		     (regoffset == RTXAGC_A_MCS15_MCS12 ||
+		      regoffset == RTXAGC_B_MCS15_MCS12)) ||
+		    ((get_rf_type(rtlphy) != RF_2T2R) &&
+		     (regoffset == RTXAGC_A_MCS07_MCS04 ||
+		      regoffset == RTXAGC_B_MCS07_MCS04))) {
+			writeval = pwr_val[3];
+			if (regoffset == RTXAGC_A_MCS15_MCS12 ||
+			    regoffset == RTXAGC_A_MCS07_MCS04)
+				regoffset = 0xc90;
+			if (regoffset == RTXAGC_B_MCS15_MCS12 ||
+			    regoffset == RTXAGC_B_MCS07_MCS04)
+				regoffset = 0xc98;
+			for (i = 0; i < 3; i++) {
+				if (i != 2)
+					writeval = (writeval > 8) ?
+						   (writeval - 8) : 0;
+				else
+					writeval = (writeval > 6) ?
+						   (writeval - 6) : 0;
+				rtl_write_byte(rtlpriv, (u32)(regoffset + i),
+					       (u8)writeval);
+			}
+		}
+	}
+}
+
+void rtl92d_phy_rf6052_set_ofdm_txpower(struct ieee80211_hw *hw,
+					u8 *ppowerlevel, u8 channel)
+{
+	u32 writeval[2], powerbase0[2], powerbase1[2];
+	u8 index;
+
+	_rtl92d_phy_get_power_base(hw, ppowerlevel, channel,
+				   &powerbase0[0], &powerbase1[0]);
+	for (index = 0; index < 6; index++) {
+		_rtl92d_get_txpower_writeval_by_regulatory(hw, channel, index,
+							   &powerbase0[0],
+							   &powerbase1[0],
+							   &writeval[0]);
+		_rtl92d_write_ofdm_power_reg(hw, index, &writeval[0]);
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92d_phy_rf6052_set_ofdm_txpower);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
new file mode 100644
index 000000000000..c243ec08369b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D_RF_COMMON_H__
+#define __RTL92D_RF_COMMON_H__
+
+void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth);
+void rtl92d_phy_rf6052_set_cck_txpower(struct ieee80211_hw *hw,
+				       u8 *ppowerlevel);
+void rtl92d_phy_rf6052_set_ofdm_txpower(struct ieee80211_hw *hw,
+					u8 *ppowerlevel, u8 channel);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
new file mode 100644
index 000000000000..05b019ccebc9
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../stats.h"
+#include "def.h"
+#include "trx_common.h"
+
+static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
+				     u8 signal_strength_index)
+{
+	long signal_power;
+
+	signal_power = (long)((signal_strength_index + 1) >> 1);
+	signal_power -= 95;
+	return signal_power;
+}
+
+static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
+				       struct rtl_stats *pstats,
+				       struct rx_desc_92d *pdesc,
+				       struct rx_fwinfo_92d *p_drvinfo,
+				       bool packet_match_bssid,
+				       bool packet_toself,
+				       bool packet_beacon)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
+	struct phy_sts_cck_8192d *cck_buf;
+	s8 rx_pwr_all, rx_pwr[4];
+	u8 rf_rx_num = 0, evm, pwdb_all;
+	u8 i, max_spatial_stream;
+	u32 rssi, total_rssi = 0;
+	bool is_cck_rate;
+
+	is_cck_rate = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
+	pstats->packet_matchbssid = packet_match_bssid;
+	pstats->packet_toself = packet_toself;
+	pstats->packet_beacon = packet_beacon;
+	pstats->is_cck = is_cck_rate;
+	pstats->rx_mimo_sig_qual[0] = -1;
+	pstats->rx_mimo_sig_qual[1] = -1;
+
+	if (is_cck_rate) {
+		u8 report, cck_highpwr;
+
+		cck_buf = (struct phy_sts_cck_8192d *)p_drvinfo;
+		if (ppsc->rfpwr_state == ERFON)
+			cck_highpwr = rtlphy->cck_high_power;
+		else
+			cck_highpwr = false;
+		if (!cck_highpwr) {
+			u8 cck_agc_rpt = cck_buf->cck_agc_rpt;
+
+			report = cck_buf->cck_agc_rpt & 0xc0;
+			report = report >> 6;
+			switch (report) {
+			case 0x3:
+				rx_pwr_all = -46 - (cck_agc_rpt & 0x3e);
+				break;
+			case 0x2:
+				rx_pwr_all = -26 - (cck_agc_rpt & 0x3e);
+				break;
+			case 0x1:
+				rx_pwr_all = -12 - (cck_agc_rpt & 0x3e);
+				break;
+			case 0x0:
+				rx_pwr_all = 16 - (cck_agc_rpt & 0x3e);
+				break;
+			}
+		} else {
+			u8 cck_agc_rpt = cck_buf->cck_agc_rpt;
+
+			report = p_drvinfo->cfosho[0] & 0x60;
+			report = report >> 5;
+			switch (report) {
+			case 0x3:
+				rx_pwr_all = -46 - ((cck_agc_rpt & 0x1f) << 1);
+				break;
+			case 0x2:
+				rx_pwr_all = -26 - ((cck_agc_rpt & 0x1f) << 1);
+				break;
+			case 0x1:
+				rx_pwr_all = -12 - ((cck_agc_rpt & 0x1f) << 1);
+				break;
+			case 0x0:
+				rx_pwr_all = 16 - ((cck_agc_rpt & 0x1f) << 1);
+				break;
+			}
+		}
+		pwdb_all = rtl_query_rxpwrpercentage(rx_pwr_all);
+		/* CCK gain is smaller than OFDM/MCS gain,  */
+		/* so we add gain diff by experiences, the val is 6 */
+		pwdb_all += 6;
+		if (pwdb_all > 100)
+			pwdb_all = 100;
+		/* modify the offset to make the same gain index with OFDM. */
+		if (pwdb_all > 34 && pwdb_all <= 42)
+			pwdb_all -= 2;
+		else if (pwdb_all > 26 && pwdb_all <= 34)
+			pwdb_all -= 6;
+		else if (pwdb_all > 14 && pwdb_all <= 26)
+			pwdb_all -= 8;
+		else if (pwdb_all > 4 && pwdb_all <= 14)
+			pwdb_all -= 4;
+		pstats->rx_pwdb_all = pwdb_all;
+		pstats->recvsignalpower = rx_pwr_all;
+		if (packet_match_bssid) {
+			u8 sq;
+
+			if (pstats->rx_pwdb_all > 40) {
+				sq = 100;
+			} else {
+				sq = cck_buf->sq_rpt;
+				if (sq > 64)
+					sq = 0;
+				else if (sq < 20)
+					sq = 100;
+				else
+					sq = ((64 - sq) * 100) / 44;
+			}
+			pstats->signalquality = sq;
+			pstats->rx_mimo_sig_qual[0] = sq;
+			pstats->rx_mimo_sig_qual[1] = -1;
+		}
+	} else {
+		rtlpriv->dm.rfpath_rxenable[0] = true;
+		rtlpriv->dm.rfpath_rxenable[1] = true;
+		for (i = RF90_PATH_A; i < RF6052_MAX_PATH; i++) {
+			if (rtlpriv->dm.rfpath_rxenable[i])
+				rf_rx_num++;
+			rx_pwr[i] = ((p_drvinfo->gain_trsw[i] & 0x3f) * 2)
+				    - 110;
+			rssi = rtl_query_rxpwrpercentage(rx_pwr[i]);
+			total_rssi += rssi;
+			rtlpriv->stats.rx_snr_db[i] =
+					 (long)(p_drvinfo->rxsnr[i] / 2);
+			if (packet_match_bssid)
+				pstats->rx_mimo_signalstrength[i] = (u8)rssi;
+		}
+		rx_pwr_all = ((p_drvinfo->pwdb_all >> 1) & 0x7f) - 106;
+		pwdb_all = rtl_query_rxpwrpercentage(rx_pwr_all);
+		pstats->rx_pwdb_all = pwdb_all;
+		pstats->rxpower = rx_pwr_all;
+		pstats->recvsignalpower = rx_pwr_all;
+		if (pdesc->rxht && pdesc->rxmcs >= DESC_RATEMCS8 &&
+		    pdesc->rxmcs <= DESC_RATEMCS15)
+			max_spatial_stream = 2;
+		else
+			max_spatial_stream = 1;
+		for (i = 0; i < max_spatial_stream; i++) {
+			evm = rtl_evm_db_to_percentage(p_drvinfo->rxevm[i]);
+			if (packet_match_bssid) {
+				if (i == 0)
+					pstats->signalquality =
+						 (u8)(evm & 0xff);
+				pstats->rx_mimo_sig_qual[i] =
+						 (u8)(evm & 0xff);
+			}
+		}
+	}
+	if (is_cck_rate)
+		pstats->signalstrength = (u8)(rtl_signal_scale_mapping(hw,
+				pwdb_all));
+	else if (rf_rx_num != 0)
+		pstats->signalstrength = (u8)(rtl_signal_scale_mapping(hw,
+				total_rssi /= rf_rx_num));
+}
+
+static void rtl92d_loop_over_paths(struct ieee80211_hw *hw,
+				   struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 rfpath;
+
+	for (rfpath = RF90_PATH_A; rfpath < rtlphy->num_total_rfpath;
+	     rfpath++) {
+		if (rtlpriv->stats.rx_rssi_percentage[rfpath] == 0) {
+			rtlpriv->stats.rx_rssi_percentage[rfpath] =
+			    pstats->rx_mimo_signalstrength[rfpath];
+		}
+		if (pstats->rx_mimo_signalstrength[rfpath] >
+		    rtlpriv->stats.rx_rssi_percentage[rfpath]) {
+			rtlpriv->stats.rx_rssi_percentage[rfpath] =
+			    ((rtlpriv->stats.rx_rssi_percentage[rfpath] *
+			      (RX_SMOOTH_FACTOR - 1)) +
+			     (pstats->rx_mimo_signalstrength[rfpath])) /
+			    (RX_SMOOTH_FACTOR);
+			rtlpriv->stats.rx_rssi_percentage[rfpath] =
+			    rtlpriv->stats.rx_rssi_percentage[rfpath] + 1;
+		} else {
+			rtlpriv->stats.rx_rssi_percentage[rfpath] =
+			    ((rtlpriv->stats.rx_rssi_percentage[rfpath] *
+			      (RX_SMOOTH_FACTOR - 1)) +
+			     (pstats->rx_mimo_signalstrength[rfpath])) /
+			    (RX_SMOOTH_FACTOR);
+		}
+	}
+}
+
+static void _rtl92de_process_ui_rssi(struct ieee80211_hw *hw,
+				     struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rt_smooth_data *ui_rssi;
+	u32 last_rssi, tmpval;
+
+	if (!pstats->packet_toself && !pstats->packet_beacon)
+		return;
+
+	ui_rssi = &rtlpriv->stats.ui_rssi;
+
+	rtlpriv->stats.rssi_calculate_cnt++;
+	if (ui_rssi->total_num++ >= PHY_RSSI_SLID_WIN_MAX) {
+		ui_rssi->total_num = PHY_RSSI_SLID_WIN_MAX;
+		last_rssi = ui_rssi->elements[ui_rssi->index];
+		ui_rssi->total_val -= last_rssi;
+	}
+	ui_rssi->total_val += pstats->signalstrength;
+	ui_rssi->elements[ui_rssi->index++] = pstats->signalstrength;
+	if (ui_rssi->index >= PHY_RSSI_SLID_WIN_MAX)
+		ui_rssi->index = 0;
+	tmpval = ui_rssi->total_val / ui_rssi->total_num;
+	rtlpriv->stats.signal_strength = _rtl92de_translate_todbm(hw, (u8)tmpval);
+	pstats->rssi = rtlpriv->stats.signal_strength;
+
+	if (!pstats->is_cck && pstats->packet_toself)
+		rtl92d_loop_over_paths(hw, pstats);
+}
+
+static void _rtl92de_update_rxsignalstatistics(struct ieee80211_hw *hw,
+					       struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	int weighting = 0;
+
+	if (rtlpriv->stats.recv_signal_power == 0)
+		rtlpriv->stats.recv_signal_power = pstats->recvsignalpower;
+	if (pstats->recvsignalpower > rtlpriv->stats.recv_signal_power)
+		weighting = 5;
+	else if (pstats->recvsignalpower < rtlpriv->stats.recv_signal_power)
+		weighting = (-5);
+	rtlpriv->stats.recv_signal_power = (rtlpriv->stats.recv_signal_power *
+		5 + pstats->recvsignalpower + weighting) / 6;
+}
+
+static void _rtl92de_process_pwdb(struct ieee80211_hw *hw,
+				  struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	long undec_sm_pwdb;
+
+	if (mac->opmode == NL80211_IFTYPE_ADHOC	||
+	    mac->opmode == NL80211_IFTYPE_AP)
+		return;
+
+	undec_sm_pwdb = rtlpriv->dm.undec_sm_pwdb;
+
+	if (pstats->packet_toself || pstats->packet_beacon) {
+		if (undec_sm_pwdb < 0)
+			undec_sm_pwdb = pstats->rx_pwdb_all;
+		if (pstats->rx_pwdb_all > (u32)undec_sm_pwdb) {
+			undec_sm_pwdb = (((undec_sm_pwdb) *
+			      (RX_SMOOTH_FACTOR - 1)) +
+			      (pstats->rx_pwdb_all)) / (RX_SMOOTH_FACTOR);
+			undec_sm_pwdb = undec_sm_pwdb + 1;
+		} else {
+			undec_sm_pwdb = (((undec_sm_pwdb) *
+			      (RX_SMOOTH_FACTOR - 1)) +
+			      (pstats->rx_pwdb_all)) / (RX_SMOOTH_FACTOR);
+		}
+		rtlpriv->dm.undec_sm_pwdb = undec_sm_pwdb;
+		_rtl92de_update_rxsignalstatistics(hw, pstats);
+	}
+}
+
+static void rtl92d_loop_over_streams(struct ieee80211_hw *hw,
+				     struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		if (pstats->rx_mimo_sig_qual[stream] != -1) {
+			if (rtlpriv->stats.rx_evm_percentage[stream] == 0) {
+				rtlpriv->stats.rx_evm_percentage[stream] =
+				    pstats->rx_mimo_sig_qual[stream];
+			}
+			rtlpriv->stats.rx_evm_percentage[stream] =
+			    ((rtlpriv->stats.rx_evm_percentage[stream]
+			      * (RX_SMOOTH_FACTOR - 1)) +
+			     (pstats->rx_mimo_sig_qual[stream] * 1)) /
+			    (RX_SMOOTH_FACTOR);
+		}
+	}
+}
+
+static void _rtl92de_process_ui_link_quality(struct ieee80211_hw *hw,
+					     struct rtl_stats *pstats)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rt_smooth_data *ui_link_quality;
+	u32 last_evm, tmpval;
+
+	if (pstats->signalquality == 0)
+		return;
+	if (!pstats->packet_toself && !pstats->packet_beacon)
+		return;
+
+	ui_link_quality = &rtlpriv->stats.ui_link_quality;
+
+	if (ui_link_quality->total_num++ >= PHY_LINKQUALITY_SLID_WIN_MAX) {
+		ui_link_quality->total_num = PHY_LINKQUALITY_SLID_WIN_MAX;
+		last_evm = ui_link_quality->elements[ui_link_quality->index];
+		ui_link_quality->total_val -= last_evm;
+	}
+	ui_link_quality->total_val += pstats->signalquality;
+	ui_link_quality->elements[ui_link_quality->index++] = pstats->signalquality;
+	if (ui_link_quality->index >= PHY_LINKQUALITY_SLID_WIN_MAX)
+		ui_link_quality->index = 0;
+	tmpval = ui_link_quality->total_val / ui_link_quality->total_num;
+	rtlpriv->stats.signal_quality = tmpval;
+	rtlpriv->stats.last_sigstrength_inpercent = tmpval;
+	rtl92d_loop_over_streams(hw, pstats);
+}
+
+static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
+				     u8 *buffer,
+				     struct rtl_stats *pcurrent_stats)
+{
+	if (!pcurrent_stats->packet_matchbssid &&
+	    !pcurrent_stats->packet_beacon)
+		return;
+
+	_rtl92de_process_ui_rssi(hw, pcurrent_stats);
+	_rtl92de_process_pwdb(hw, pcurrent_stats);
+	_rtl92de_process_ui_link_quality(hw, pcurrent_stats);
+}
+
+static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
+					       struct sk_buff *skb,
+					       struct rtl_stats *pstats,
+					       struct rx_desc_92d *pdesc,
+					       struct rx_fwinfo_92d *p_drvinfo)
+{
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
+	struct ieee80211_hdr *hdr;
+	u8 *tmp_buf;
+	u8 *praddr;
+	u16 type, cfc;
+	__le16 fc;
+	bool packet_matchbssid, packet_toself, packet_beacon = false;
+
+	tmp_buf = skb->data + pstats->rx_drvinfo_size + pstats->rx_bufshift;
+	hdr = (struct ieee80211_hdr *)tmp_buf;
+	fc = hdr->frame_control;
+	cfc = le16_to_cpu(fc);
+	type = WLAN_FC_GET_TYPE(fc);
+	praddr = hdr->addr1;
+	packet_matchbssid = ((type != IEEE80211_FTYPE_CTL) &&
+	     ether_addr_equal(mac->bssid,
+			      (cfc & IEEE80211_FCTL_TODS) ? hdr->addr1 :
+			      (cfc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 :
+			      hdr->addr3) &&
+	     (!pstats->hwerror) && (!pstats->crc) && (!pstats->icv));
+	packet_toself = packet_matchbssid &&
+			ether_addr_equal(praddr, rtlefuse->dev_addr);
+	if (ieee80211_is_beacon(fc))
+		packet_beacon = true;
+	_rtl92de_query_rxphystatus(hw, pstats, pdesc, p_drvinfo,
+				   packet_matchbssid, packet_toself,
+				   packet_beacon);
+	_rtl92de_process_phyinfo(hw, tmp_buf, pstats);
+}
+
+bool rtl92de_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
+			   struct ieee80211_rx_status *rx_status,
+			   u8 *pdesc8, struct sk_buff *skb)
+{
+	__le32 *pdesc = (__le32 *)pdesc8;
+	struct rx_fwinfo_92d *p_drvinfo;
+	u32 phystatus = get_rx_desc_physt(pdesc);
+
+	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
+	stats->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(pdesc) *
+				 RX_DRV_INFO_SIZE_UNIT;
+	stats->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
+	stats->icv = (u16)get_rx_desc_icv(pdesc);
+	stats->crc = (u16)get_rx_desc_crc32(pdesc);
+	stats->hwerror = (stats->crc | stats->icv);
+	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
+				      (get_rx_desc_faggr(pdesc) == 1));
+	stats->timestamp_low = get_rx_desc_tsfl(pdesc);
+	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
+	stats->is_ht = (bool)get_rx_desc_rxht(pdesc);
+	rx_status->freq = hw->conf.chandef.chan->center_freq;
+	rx_status->band = hw->conf.chandef.chan->band;
+	if (get_rx_desc_crc32(pdesc))
+		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+	if (!get_rx_desc_swdec(pdesc))
+		rx_status->flag |= RX_FLAG_DECRYPTED;
+	if (get_rx_desc_bw(pdesc))
+		rx_status->bw = RATE_INFO_BW_40;
+	if (get_rx_desc_rxht(pdesc))
+		rx_status->encoding = RX_ENC_HT;
+	rx_status->flag |= RX_FLAG_MACTIME_START;
+	if (stats->decrypted)
+		rx_status->flag |= RX_FLAG_DECRYPTED;
+	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
+						   false, stats->rate);
+	rx_status->mactime = get_rx_desc_tsfl(pdesc);
+	if (phystatus) {
+		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
+						     stats->rx_bufshift);
+		_rtl92de_translate_rx_signal_stuff(hw,
+						   skb, stats,
+						   (struct rx_desc_92d *)pdesc,
+						   p_drvinfo);
+	}
+	/*rx_status->qual = stats->signal; */
+	rx_status->signal = stats->recvsignalpower + 10;
+	return true;
+}
+EXPORT_SYMBOL_GPL(rtl92de_rx_query_desc);
+
+void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
+		      u8 desc_name, u8 *val)
+{
+	__le32  *pdesc = (__le32 *)pdesc8;
+
+	if (istx) {
+		switch (desc_name) {
+		case HW_DESC_OWN:
+			wmb();
+			set_tx_desc_own(pdesc, 1);
+			break;
+		case HW_DESC_TX_NEXTDESC_ADDR:
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
+			break;
+		default:
+			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
+				  desc_name);
+			break;
+		}
+	} else {
+		switch (desc_name) {
+		case HW_DESC_RXOWN:
+			wmb();
+			set_rx_desc_own(pdesc, 1);
+			break;
+		case HW_DESC_RXBUFF_ADDR:
+			set_rx_desc_buff_addr(pdesc, *(u32 *)val);
+			break;
+		case HW_DESC_RXPKT_LEN:
+			set_rx_desc_pkt_len(pdesc, *(u32 *)val);
+			break;
+		case HW_DESC_RXERO:
+			set_rx_desc_eor(pdesc, 1);
+			break;
+		default:
+			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
+				  desc_name);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(rtl92de_set_desc);
+
+u64 rtl92de_get_desc(struct ieee80211_hw *hw,
+		     u8 *p_desc8, bool istx, u8 desc_name)
+{
+	__le32 *p_desc = (__le32 *)p_desc8;
+	u32 ret = 0;
+
+	if (istx) {
+		switch (desc_name) {
+		case HW_DESC_OWN:
+			ret = get_tx_desc_own(p_desc);
+			break;
+		case HW_DESC_TXBUFF_ADDR:
+			ret = get_tx_desc_tx_buffer_address(p_desc);
+			break;
+		default:
+			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
+				  desc_name);
+			break;
+		}
+	} else {
+		switch (desc_name) {
+		case HW_DESC_OWN:
+			ret = get_rx_desc_own(p_desc);
+			break;
+		case HW_DESC_RXPKT_LEN:
+			ret = get_rx_desc_pkt_len(p_desc);
+		break;
+		case HW_DESC_RXBUFF_ADDR:
+			ret = get_rx_desc_buff_addr(p_desc);
+			break;
+		default:
+			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
+				  desc_name);
+			break;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rtl92de_get_desc);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
new file mode 100644
index 000000000000..c41438ae4c4a
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
@@ -0,0 +1,442 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_TRX_COMMON_H__
+#define __RTL92DE_TRX_COMMON_H__
+
+#define RX_DRV_INFO_SIZE_UNIT			8
+
+/* macros to read/write various fields in RX or TX descriptors */
+
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_offset(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
+}
+
+static inline void set_tx_desc_htc(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(25));
+}
+
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(26));
+}
+
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(27));
+}
+
+static inline void set_tx_desc_linip(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(28));
+}
+
+static inline void set_tx_desc_own(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(31));
+}
+
+static inline u32 get_tx_desc_own(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(31));
+}
+
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, BIT(5));
+}
+
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, BIT(7));
+}
+
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(19, 16));
+}
+
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
+}
+
+static inline void set_tx_desc_pkt_offset(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(30, 26));
+}
+
+static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 2), __val, BIT(17));
+}
+
+static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 2), __val, GENMASK(22, 20));
+}
+
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
+}
+
+static inline void set_tx_desc_pkt_id(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(31, 28));
+}
+
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_qos(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(6));
+}
+
+static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(7));
+}
+
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(8));
+}
+
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(10));
+}
+
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
+}
+
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(13));
+}
+
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(21, 20));
+}
+
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
+}
+
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
+}
+
+static inline void set_tx_desc_rts_bw(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, BIT(27));
+}
+
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(29, 28));
+}
+
+static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(31, 30));
+}
+
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(5, 0));
+}
+
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 5), __val, BIT(6));
+}
+
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
+}
+
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 6), __val, GENMASK(15, 11));
+}
+
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
+{
+	*(__pdesc + 8) = cpu_to_le32(__val);
+}
+
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
+{
+	return le32_to_cpu(*(__pdesc + 8));
+}
+
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
+{
+	*(__pdesc + 10) = cpu_to_le32(__val);
+}
+
+static inline u32 get_rx_desc_pkt_len(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(13, 0));
+}
+
+static inline u32 get_rx_desc_crc32(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(14));
+}
+
+static inline u32 get_rx_desc_icv(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(15));
+}
+
+static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(19, 16));
+}
+
+static inline u32 get_rx_desc_shift(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(25, 24));
+}
+
+static inline u32 get_rx_desc_physt(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(26));
+}
+
+static inline u32 get_rx_desc_swdec(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(27));
+}
+
+static inline u32 get_rx_desc_own(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, BIT(31));
+}
+
+static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(30));
+}
+
+static inline void set_rx_desc_own(__le32 *__pdesc, u32 __val)
+{
+	le32p_replace_bits(__pdesc, __val, BIT(31));
+}
+
+static inline u32 get_rx_desc_paggr(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 1), BIT(14));
+}
+
+static inline u32 get_rx_desc_faggr(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
+}
+
+static inline u32 get_rx_desc_rxmcs(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
+}
+
+static inline u32 get_rx_desc_rxht(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
+}
+
+static inline u32 get_rx_desc_splcp(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 3), BIT(8));
+}
+
+static inline u32 get_rx_desc_bw(__le32 *__pdesc)
+{
+	return le32_get_bits(*(__pdesc + 3), BIT(9));
+}
+
+static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
+{
+	return le32_to_cpu(*(__pdesc + 5));
+}
+
+static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
+{
+	return le32_to_cpu(*(__pdesc + 6));
+}
+
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
+{
+	*(__pdesc + 6) = cpu_to_le32(__val);
+}
+
+/* For 92D early mode */
+static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits(__paddr, __value, GENMASK(2, 0));
+}
+
+static inline void set_earlymode_len0(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
+}
+
+static inline void set_earlymode_len1(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
+}
+
+static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
+}
+
+static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(7, 0));
+}
+
+static inline void set_earlymode_len3(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(19, 8));
+}
+
+static inline void set_earlymode_len4(__le32 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(31, 20));
+}
+
+struct rx_fwinfo_92d {
+	u8 gain_trsw[4];
+	u8 pwdb_all;
+	u8 cfosho[4];
+	u8 cfotail[4];
+	s8 rxevm[2];
+	s8 rxsnr[4];
+	u8 pdsnr[2];
+	u8 csi_current[2];
+	u8 csi_target[2];
+	u8 sigevm;
+	u8 max_ex_pwr;
+	u8 ex_intf_flag:1;
+	u8 sgi_en:1;
+	u8 rxsc:2;
+	u8 reserve:4;
+} __packed;
+
+struct rx_desc_92d {
+	u32 length:14;
+	u32 crc32:1;
+	u32 icverror:1;
+	u32 drv_infosize:4;
+	u32 security:3;
+	u32 qos:1;
+	u32 shift:2;
+	u32 phystatus:1;
+	u32 swdec:1;
+	u32 lastseg:1;
+	u32 firstseg:1;
+	u32 eor:1;
+	u32 own:1;
+
+	u32 macid:5;
+	u32 tid:4;
+	u32 hwrsvd:5;
+	u32 paggr:1;
+	u32 faggr:1;
+	u32 a1_fit:4;
+	u32 a2_fit:4;
+	u32 pam:1;
+	u32 pwr:1;
+	u32 moredata:1;
+	u32 morefrag:1;
+	u32 type:2;
+	u32 mc:1;
+	u32 bc:1;
+
+	u32 seq:12;
+	u32 frag:4;
+	u32 nextpktlen:14;
+	u32 nextind:1;
+	u32 rsvd:1;
+
+	u32 rxmcs:6;
+	u32 rxht:1;
+	u32 amsdu:1;
+	u32 splcp:1;
+	u32 bandwidth:1;
+	u32 htc:1;
+	u32 tcpchk_rpt:1;
+	u32 ipcchk_rpt:1;
+	u32 tcpchk_valid:1;
+	u32 hwpcerr:1;
+	u32 hwpcind:1;
+	u32 iv0:16;
+
+	u32 iv1;
+
+	u32 tsfl;
+
+	u32 bufferaddress;
+	u32 bufferaddress64;
+
+} __packed;
+
+bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,
+			   struct rtl_stats *stats,
+			   struct ieee80211_rx_status *rx_status,
+			   u8 *pdesc, struct sk_buff *skb);
+void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+		      u8 desc_name, u8 *val);
+u64 rtl92de_get_desc(struct ieee80211_hw *hw,
+		     u8 *p_desc, bool istx, u8 desc_name);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index cf4aca83bd05..c6a2e8b22fa0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -4,455 +4,16 @@
 #include "../wifi.h"
 #include "../base.h"
 #include "../core.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/fw_common.h"
 #include "phy.h"
 #include "dm.h"
-#include "fw.h"
 
 #define UNDEC_SM_PWDB	entry_min_undec_sm_pwdb
 
-static const u32 ofdmswing_table[OFDM_TABLE_SIZE_92D] = {
-	0x7f8001fe,		/* 0, +6.0dB */
-	0x788001e2,		/* 1, +5.5dB */
-	0x71c001c7,		/* 2, +5.0dB */
-	0x6b8001ae,		/* 3, +4.5dB */
-	0x65400195,		/* 4, +4.0dB */
-	0x5fc0017f,		/* 5, +3.5dB */
-	0x5a400169,		/* 6, +3.0dB */
-	0x55400155,		/* 7, +2.5dB */
-	0x50800142,		/* 8, +2.0dB */
-	0x4c000130,		/* 9, +1.5dB */
-	0x47c0011f,		/* 10, +1.0dB */
-	0x43c0010f,		/* 11, +0.5dB */
-	0x40000100,		/* 12, +0dB */
-	0x3c8000f2,		/* 13, -0.5dB */
-	0x390000e4,		/* 14, -1.0dB */
-	0x35c000d7,		/* 15, -1.5dB */
-	0x32c000cb,		/* 16, -2.0dB */
-	0x300000c0,		/* 17, -2.5dB */
-	0x2d4000b5,		/* 18, -3.0dB */
-	0x2ac000ab,		/* 19, -3.5dB */
-	0x288000a2,		/* 20, -4.0dB */
-	0x26000098,		/* 21, -4.5dB */
-	0x24000090,		/* 22, -5.0dB */
-	0x22000088,		/* 23, -5.5dB */
-	0x20000080,		/* 24, -6.0dB */
-	0x1e400079,		/* 25, -6.5dB */
-	0x1c800072,		/* 26, -7.0dB */
-	0x1b00006c,		/* 27. -7.5dB */
-	0x19800066,		/* 28, -8.0dB */
-	0x18000060,		/* 29, -8.5dB */
-	0x16c0005b,		/* 30, -9.0dB */
-	0x15800056,		/* 31, -9.5dB */
-	0x14400051,		/* 32, -10.0dB */
-	0x1300004c,		/* 33, -10.5dB */
-	0x12000048,		/* 34, -11.0dB */
-	0x11000044,		/* 35, -11.5dB */
-	0x10000040,		/* 36, -12.0dB */
-	0x0f00003c,		/* 37, -12.5dB */
-	0x0e400039,		/* 38, -13.0dB */
-	0x0d800036,		/* 39, -13.5dB */
-	0x0cc00033,		/* 40, -14.0dB */
-	0x0c000030,		/* 41, -14.5dB */
-	0x0b40002d,		/* 42, -15.0dB */
-};
-
-static const u8 cckswing_table_ch1ch13[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04},    /* 0, +0dB */
-	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04},    /* 1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03},    /* 2, -1.0dB */
-	{0x2d, 0x2d, 0x27, 0x1f, 0x18, 0x0f, 0x08, 0x03},    /* 3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03},    /* 4, -2.0dB */
-	{0x28, 0x28, 0x22, 0x1c, 0x15, 0x0d, 0x07, 0x03},    /* 5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03},    /* 6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x19, 0x13, 0x0c, 0x06, 0x03},    /* 7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x18, 0x11, 0x0b, 0x06, 0x02},    /* 8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x16, 0x11, 0x08, 0x05, 0x02},    /* 9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x15, 0x10, 0x0a, 0x05, 0x02},    /* 10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x14, 0x0f, 0x0a, 0x05, 0x02},    /* 11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x13, 0x0e, 0x09, 0x04, 0x02},    /* 12, -6.0dB */
-	{0x1a, 0x19, 0x16, 0x12, 0x0d, 0x09, 0x04, 0x02},    /* 13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x11, 0x0c, 0x08, 0x04, 0x02},    /* 14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x10, 0x0c, 0x08, 0x04, 0x02},    /* 15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0f, 0x0b, 0x07, 0x04, 0x01},    /* 16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0e, 0x0b, 0x07, 0x03, 0x02},    /* 17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0d, 0x0a, 0x06, 0x03, 0x01},    /* 18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01},    /* 19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01},    /* 20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x0b, 0x08, 0x05, 0x03, 0x01},    /* 21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01},    /* 22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x0a, 0x08, 0x05, 0x02, 0x01},    /* 23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x0a, 0x07, 0x05, 0x02, 0x01},    /* 24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x09, 0x07, 0x04, 0x02, 0x01},    /* 25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x09, 0x06, 0x04, 0x02, 0x01},    /* 26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x08, 0x06, 0x04, 0x02, 0x01},    /* 27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x08, 0x06, 0x04, 0x02, 0x01},    /* 28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01},    /* 29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01},    /* 30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01},    /* 31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}     /* 32, -16.0dB */
-};
-
-static const u8 cckswing_table_ch14[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00},    /* 0, +0dB */
-	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00},    /* 1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00},    /* 2, -1.0dB */
-	{0x2d, 0x2d, 0x17, 0x17, 0x00, 0x00, 0x00, 0x00},    /* 3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00},    /* 4, -2.0dB */
-	{0x28, 0x28, 0x24, 0x14, 0x00, 0x00, 0x00, 0x00},    /* 5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x13, 0x00, 0x00, 0x00, 0x00},    /* 6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x12, 0x00, 0x00, 0x00, 0x00},    /* 7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x11, 0x00, 0x00, 0x00, 0x00},    /* 8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x10, 0x00, 0x00, 0x00, 0x00},    /* 9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x0f, 0x00, 0x00, 0x00, 0x00},    /* 10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00},    /* 11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x0e, 0x00, 0x00, 0x00, 0x00},    /* 12, -6.0dB */
-	{0x1a, 0x19, 0x16, 0x0d, 0x00, 0x00, 0x00, 0x00},    /* 13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x0c, 0x00, 0x00, 0x00, 0x00},    /* 14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00},    /* 15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0b, 0x00, 0x00, 0x00, 0x00},    /* 16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x00},    /* 17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0a, 0x00, 0x00, 0x00, 0x00},    /* 18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00},    /* 19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00},    /* 20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x00},    /* 21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x08, 0x00, 0x00, 0x00, 0x00},    /* 22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00},    /* 23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00},    /* 24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00},    /* 27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00},    /* 31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x04, 0x00, 0x00, 0x00, 0x00}     /* 32, -16.0dB */
-};
-
-static void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
-{
-	u32 ret_value;
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct false_alarm_statistics *falsealm_cnt = &(rtlpriv->falsealm_cnt);
-	unsigned long flag = 0;
-
-	/* hold ofdm counter */
-	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 1); /* hold page C counter */
-	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 1); /*hold page D counter */
-
-	ret_value = rtl_get_bbreg(hw, ROFDM0_FRAMESYNC, MASKDWORD);
-	falsealm_cnt->cnt_fast_fsync_fail = (ret_value & 0xffff);
-	falsealm_cnt->cnt_sb_search_fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER1, MASKDWORD);
-	falsealm_cnt->cnt_parity_fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER2, MASKDWORD);
-	falsealm_cnt->cnt_rate_illegal = (ret_value & 0xffff);
-	falsealm_cnt->cnt_crc8_fail = ((ret_value & 0xffff0000) >> 16);
-	ret_value = rtl_get_bbreg(hw, ROFDM_PHYCOUNTER3, MASKDWORD);
-	falsealm_cnt->cnt_mcs_fail = (ret_value & 0xffff);
-	falsealm_cnt->cnt_ofdm_fail = falsealm_cnt->cnt_parity_fail +
-				      falsealm_cnt->cnt_rate_illegal +
-				      falsealm_cnt->cnt_crc8_fail +
-				      falsealm_cnt->cnt_mcs_fail +
-				      falsealm_cnt->cnt_fast_fsync_fail +
-				      falsealm_cnt->cnt_sb_search_fail;
-
-	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
-		/* hold cck counter */
-		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
-		ret_value = rtl_get_bbreg(hw, RCCK0_FACOUNTERLOWER, MASKBYTE0);
-		falsealm_cnt->cnt_cck_fail = ret_value;
-		ret_value = rtl_get_bbreg(hw, RCCK0_FACOUNTERUPPER, MASKBYTE3);
-		falsealm_cnt->cnt_cck_fail += (ret_value & 0xff) << 8;
-		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
-	} else {
-		falsealm_cnt->cnt_cck_fail = 0;
-	}
-
-	/* reset false alarm counter registers */
-	falsealm_cnt->cnt_all = falsealm_cnt->cnt_fast_fsync_fail +
-				falsealm_cnt->cnt_sb_search_fail +
-				falsealm_cnt->cnt_parity_fail +
-				falsealm_cnt->cnt_rate_illegal +
-				falsealm_cnt->cnt_crc8_fail +
-				falsealm_cnt->cnt_mcs_fail +
-				falsealm_cnt->cnt_cck_fail;
-
-	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 1);
-	/* update ofdm counter */
-	rtl_set_bbreg(hw, ROFDM1_LSTF, 0x08000000, 0);
-	/* update page C counter */
-	rtl_set_bbreg(hw, ROFDM0_LSTF, BIT(31), 0);
-	/* update page D counter */
-	rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(31), 0);
-	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G) {
-		/* reset cck counter */
-		rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
-		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 0);
-		/* enable cck counter */
-		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
-		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
-	}
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
-		falsealm_cnt->cnt_fast_fsync_fail,
-		falsealm_cnt->cnt_sb_search_fail);
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
-		falsealm_cnt->cnt_parity_fail,
-		falsealm_cnt->cnt_rate_illegal,
-		falsealm_cnt->cnt_crc8_fail,
-		falsealm_cnt->cnt_mcs_fail);
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
-		falsealm_cnt->cnt_ofdm_fail,
-		falsealm_cnt->cnt_cck_fail,
-		falsealm_cnt->cnt_all);
-}
-
-static void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-	struct rtl_mac *mac = rtl_mac(rtlpriv);
-
-	/* Determine the minimum RSSI  */
-	if ((mac->link_state < MAC80211_LINKED) &&
-	    (rtlpriv->dm.UNDEC_SM_PWDB == 0)) {
-		de_digtable->min_undec_pwdb_for_dm = 0;
-		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			"Not connected to any\n");
-	}
-	if (mac->link_state >= MAC80211_LINKED) {
-		if (mac->opmode == NL80211_IFTYPE_AP ||
-		    mac->opmode == NL80211_IFTYPE_ADHOC) {
-			de_digtable->min_undec_pwdb_for_dm =
-			    rtlpriv->dm.UNDEC_SM_PWDB;
-			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				"AP Client PWDB = 0x%lx\n",
-				 rtlpriv->dm.UNDEC_SM_PWDB);
-		} else {
-			de_digtable->min_undec_pwdb_for_dm =
-			    rtlpriv->dm.undec_sm_pwdb;
-			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				"STA Default Port PWDB = 0x%x\n",
-				de_digtable->min_undec_pwdb_for_dm);
-		}
-	} else {
-		de_digtable->min_undec_pwdb_for_dm = rtlpriv->dm.UNDEC_SM_PWDB;
-		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			"AP Ext Port or disconnect PWDB = 0x%x\n",
-			de_digtable->min_undec_pwdb_for_dm);
-	}
-
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
-		de_digtable->min_undec_pwdb_for_dm);
-}
-
-static void rtl92d_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-	unsigned long flag = 0;
-
-	if (de_digtable->cursta_cstate == DIG_STA_CONNECT) {
-		if (de_digtable->pre_cck_pd_state == CCK_PD_STAGE_LOWRSSI) {
-			if (de_digtable->min_undec_pwdb_for_dm <= 25)
-				de_digtable->cur_cck_pd_state =
-							 CCK_PD_STAGE_LOWRSSI;
-			else
-				de_digtable->cur_cck_pd_state =
-							 CCK_PD_STAGE_HIGHRSSI;
-		} else {
-			if (de_digtable->min_undec_pwdb_for_dm <= 20)
-				de_digtable->cur_cck_pd_state =
-							 CCK_PD_STAGE_LOWRSSI;
-			else
-				de_digtable->cur_cck_pd_state =
-							 CCK_PD_STAGE_HIGHRSSI;
-		}
-	} else {
-		de_digtable->cur_cck_pd_state = CCK_PD_STAGE_LOWRSSI;
-	}
-	if (de_digtable->pre_cck_pd_state != de_digtable->cur_cck_pd_state) {
-		if (de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI) {
-			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
-			rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0x83);
-			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
-		} else {
-			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
-			rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0xcd);
-			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
-		}
-		de_digtable->pre_cck_pd_state = de_digtable->cur_cck_pd_state;
-	}
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
-		de_digtable->cursta_cstate == DIG_STA_CONNECT ?
-		"DIG_STA_CONNECT " : "DIG_STA_DISCONNECT");
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
-		de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI ?
-		"Low RSSI " : "High RSSI ");
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
-		IS_92D_SINGLEPHY(rtlpriv->rtlhal.version));
-
-}
-
-void rtl92d_dm_write_dig(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
-		de_digtable->cur_igvalue, de_digtable->pre_igvalue,
-		de_digtable->back_val);
-	if (de_digtable->dig_enable_flag == false) {
-		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
-		de_digtable->pre_igvalue = 0x17;
-		return;
-	}
-	if (de_digtable->pre_igvalue != de_digtable->cur_igvalue) {
-		rtl_set_bbreg(hw, ROFDM0_XAAGCCORE1, 0x7f,
-			      de_digtable->cur_igvalue);
-		rtl_set_bbreg(hw, ROFDM0_XBAGCCORE1, 0x7f,
-			      de_digtable->cur_igvalue);
-		de_digtable->pre_igvalue = de_digtable->cur_igvalue;
-	}
-}
-
-static void rtl92d_early_mode_enabled(struct rtl_priv *rtlpriv)
-{
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-
-	if ((rtlpriv->mac80211.link_state >= MAC80211_LINKED) &&
-	    (rtlpriv->mac80211.vendor == PEER_CISCO)) {
-		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
-		if (de_digtable->last_min_undec_pwdb_for_dm >= 50
-		    && de_digtable->min_undec_pwdb_for_dm < 50) {
-			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x00);
-			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-				"Early Mode Off\n");
-		} else if (de_digtable->last_min_undec_pwdb_for_dm <= 55 &&
-			   de_digtable->min_undec_pwdb_for_dm > 55) {
-			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-				"Early Mode On\n");
-		}
-	} else if (!(rtl_read_byte(rtlpriv, REG_EARLY_MODE_CONTROL) & 0xf)) {
-		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
-	}
-}
-
-static void rtl92d_dm_dig(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-	u8 value_igi = de_digtable->cur_igvalue;
-	struct false_alarm_statistics *falsealm_cnt = &(rtlpriv->falsealm_cnt);
-
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
-	if (rtlpriv->rtlhal.earlymode_enable) {
-		rtl92d_early_mode_enabled(rtlpriv);
-		de_digtable->last_min_undec_pwdb_for_dm =
-				 de_digtable->min_undec_pwdb_for_dm;
-	}
-	if (!rtlpriv->dm.dm_initialgain_enable)
-		return;
-
-	/* because we will send data pkt when scanning
-	 * this will cause some ap like gear-3700 wep TP
-	 * lower if we return here, this is the diff of
-	 * mac80211 driver vs ieee80211 driver */
-	/* if (rtlpriv->mac80211.act_scanning)
-	 *      return; */
-
-	/* Not STA mode return tmp */
-	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
-		return;
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
-	/* Decide the current status and if modify initial gain or not */
-	if (rtlpriv->mac80211.link_state >= MAC80211_LINKED)
-		de_digtable->cursta_cstate = DIG_STA_CONNECT;
-	else
-		de_digtable->cursta_cstate = DIG_STA_DISCONNECT;
-
-	/* adjust initial gain according to false alarm counter */
-	if (falsealm_cnt->cnt_all < DM_DIG_FA_TH0)
-		value_igi--;
-	else if (falsealm_cnt->cnt_all < DM_DIG_FA_TH1)
-		value_igi += 0;
-	else if (falsealm_cnt->cnt_all < DM_DIG_FA_TH2)
-		value_igi++;
-	else if (falsealm_cnt->cnt_all >= DM_DIG_FA_TH2)
-		value_igi += 2;
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"dm_DIG() Before: large_fa_hit=%d, forbidden_igi=%x\n",
-		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"dm_DIG() Before: Recover_cnt=%d, rx_gain_min=%x\n",
-		de_digtable->recover_cnt, de_digtable->rx_gain_min);
-
-	/* deal with abnormally large false alarm */
-	if (falsealm_cnt->cnt_all > 10000) {
-		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-			"dm_DIG(): Abnormally false alarm case\n");
-
-		de_digtable->large_fa_hit++;
-		if (de_digtable->forbidden_igi < de_digtable->cur_igvalue) {
-			de_digtable->forbidden_igi = de_digtable->cur_igvalue;
-			de_digtable->large_fa_hit = 1;
-		}
-		if (de_digtable->large_fa_hit >= 3) {
-			if ((de_digtable->forbidden_igi + 1) > DM_DIG_MAX)
-				de_digtable->rx_gain_min = DM_DIG_MAX;
-			else
-				de_digtable->rx_gain_min =
-				    (de_digtable->forbidden_igi + 1);
-			de_digtable->recover_cnt = 3600;	/* 3600=2hr */
-		}
-	} else {
-		/* Recovery mechanism for IGI lower bound */
-		if (de_digtable->recover_cnt != 0) {
-			de_digtable->recover_cnt--;
-		} else {
-			if (de_digtable->large_fa_hit == 0) {
-				if ((de_digtable->forbidden_igi - 1) <
-				    DM_DIG_FA_LOWER) {
-					de_digtable->forbidden_igi =
-							 DM_DIG_FA_LOWER;
-					de_digtable->rx_gain_min =
-							 DM_DIG_FA_LOWER;
-
-				} else {
-					de_digtable->forbidden_igi--;
-					de_digtable->rx_gain_min =
-					    (de_digtable->forbidden_igi + 1);
-				}
-			} else if (de_digtable->large_fa_hit == 3) {
-				de_digtable->large_fa_hit = 0;
-			}
-		}
-	}
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"dm_DIG() After: large_fa_hit=%d, forbidden_igi=%x\n",
-		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
-		"dm_DIG() After: recover_cnt=%d, rx_gain_min=%x\n",
-		de_digtable->recover_cnt, de_digtable->rx_gain_min);
-
-	if (value_igi > DM_DIG_MAX)
-		value_igi = DM_DIG_MAX;
-	else if (value_igi < de_digtable->rx_gain_min)
-		value_igi = de_digtable->rx_gain_min;
-	de_digtable->cur_igvalue = value_igi;
-	rtl92d_dm_write_dig(hw);
-	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G)
-		rtl92d_dm_cck_packet_detection_thresh(hw);
-	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
-}
-
 static void rtl92d_dm_init_dynamic_txpower(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -579,626 +140,7 @@ static void rtl92d_dm_pwdb_monitor(struct ieee80211_hw *hw)
 	}
 }
 
-void rtl92d_dm_init_edca_turbo(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	rtlpriv->dm.current_turbo_edca = false;
-	rtlpriv->dm.is_any_nonbepkts = false;
-	rtlpriv->dm.is_cur_rdlstate = false;
-}
-
-static void rtl92d_dm_check_edca_turbo(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	const u32 edca_be_ul = 0x5ea42b;
-	const u32 edca_be_dl = 0x5ea42b;
-	static u64 last_txok_cnt;
-	static u64 last_rxok_cnt;
-	u64 cur_txok_cnt;
-	u64 cur_rxok_cnt;
-
-	if (mac->link_state != MAC80211_LINKED) {
-		rtlpriv->dm.current_turbo_edca = false;
-		goto exit;
-	}
-
-	if ((!rtlpriv->dm.is_any_nonbepkts) &&
-	    (!rtlpriv->dm.disable_framebursting)) {
-		cur_txok_cnt = rtlpriv->stats.txbytesunicast - last_txok_cnt;
-		cur_rxok_cnt = rtlpriv->stats.rxbytesunicast - last_rxok_cnt;
-		if (cur_rxok_cnt > 4 * cur_txok_cnt) {
-			if (!rtlpriv->dm.is_cur_rdlstate ||
-			    !rtlpriv->dm.current_turbo_edca) {
-				rtl_write_dword(rtlpriv, REG_EDCA_BE_PARAM,
-						edca_be_dl);
-				rtlpriv->dm.is_cur_rdlstate = true;
-			}
-		} else {
-			if (rtlpriv->dm.is_cur_rdlstate ||
-			    !rtlpriv->dm.current_turbo_edca) {
-				rtl_write_dword(rtlpriv, REG_EDCA_BE_PARAM,
-						edca_be_ul);
-				rtlpriv->dm.is_cur_rdlstate = false;
-			}
-		}
-		rtlpriv->dm.current_turbo_edca = true;
-	} else {
-		if (rtlpriv->dm.current_turbo_edca) {
-			u8 tmp = AC0_BE;
-			rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_AC_PARAM,
-						      &tmp);
-			rtlpriv->dm.current_turbo_edca = false;
-		}
-	}
-
-exit:
-	rtlpriv->dm.is_any_nonbepkts = false;
-	last_txok_cnt = rtlpriv->stats.txbytesunicast;
-	last_rxok_cnt = rtlpriv->stats.rxbytesunicast;
-}
-
-static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 index_mapping[RX_INDEX_MAPPING_NUM] = {
-		0x0f, 0x0f, 0x0d, 0x0c, 0x0b,
-		0x0a, 0x09, 0x08, 0x07, 0x06,
-		0x05, 0x04, 0x04, 0x03, 0x02
-	};
-	int i;
-	u32 u4tmp;
-
-	u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
-				rtlpriv->dm.thermalvalue_rxgain)]) << 12;
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"===> Rx Gain %x\n", u4tmp);
-	for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
-		rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
-			      (rtlpriv->phy.reg_rf3c[i] & (~(0xF000))) | u4tmp);
-}
-
-static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
-				 u8 *cck_index_old)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	int i;
-	unsigned long flag = 0;
-	long temp_cck;
-	const u8 *cckswing;
-
-	/* Query CCK default setting From 0xa24 */
-	rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
-	temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
-				 MASKDWORD) & MASKCCK;
-	rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
-	for (i = 0; i < CCK_TABLE_LENGTH; i++) {
-		if (rtlpriv->dm.cck_inch14)
-			cckswing = &cckswing_table_ch14[i][2];
-		else
-			cckswing = &cckswing_table_ch1ch13[i][2];
-
-		if (temp_cck == le32_to_cpu(*((__le32 *)cckswing))) {
-			*cck_index_old = (u8)i;
-			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				"Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
-				RCCK0_TXFILTER2, temp_cck,
-				*cck_index_old,
-				rtlpriv->dm.cck_inch14);
-			break;
-		}
-	}
-	*temp_cckg = temp_cck;
-}
-
-static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
-			       bool *internal_pa, u8 thermalvalue, u8 delta,
-			       u8 rf, struct rtl_efuse *rtlefuse,
-			       struct rtl_priv *rtlpriv, struct rtl_phy *rtlphy,
-			       const u8 index_mapping[5][INDEX_MAPPING_NUM],
-			       const u8 index_mapping_pa[8][INDEX_MAPPING_NUM])
-{
-	int i;
-	u8 index;
-	u8 offset = 0;
-
-	for (i = 0; i < rf; i++) {
-		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
-		    rtlhal->interfaceindex == 1)	/* MAC 1 5G */
-			*internal_pa = rtlefuse->internal_pa_5g[1];
-		else
-			*internal_pa = rtlefuse->internal_pa_5g[i];
-		if (*internal_pa) {
-			if (rtlhal->interfaceindex == 1 || i == rf)
-				offset = 4;
-			else
-				offset = 0;
-			if (rtlphy->current_channel >= 100 &&
-				rtlphy->current_channel <= 165)
-				offset += 2;
-		} else {
-			if (rtlhal->interfaceindex == 1 || i == rf)
-				offset = 2;
-			else
-				offset = 0;
-		}
-		if (thermalvalue > rtlefuse->eeprom_thermalmeter)
-			offset++;
-		if (*internal_pa) {
-			if (delta > INDEX_MAPPING_NUM - 1)
-				index = index_mapping_pa[offset]
-						    [INDEX_MAPPING_NUM - 1];
-			else
-				index =
-				     index_mapping_pa[offset][delta];
-		} else {
-			if (delta > INDEX_MAPPING_NUM - 1)
-				index =
-				   index_mapping[offset][INDEX_MAPPING_NUM - 1];
-			else
-				index = index_mapping[offset][delta];
-		}
-		if (thermalvalue > rtlefuse->eeprom_thermalmeter) {
-			if (*internal_pa && thermalvalue > 0x12) {
-				ofdm_index[i] = rtlpriv->dm.ofdm_index[i] -
-						((delta / 2) * 3 + (delta % 2));
-			} else {
-				ofdm_index[i] -= index;
-			}
-		} else {
-			ofdm_index[i] += index;
-		}
-	}
-}
-
-static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
-			struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 thermalvalue, delta, delta_lck, delta_iqk, delta_rxgain;
-	u8 offset, thermalvalue_avg_count = 0;
-	u32 thermalvalue_avg = 0;
-	bool internal_pa = false;
-	long ele_a = 0, ele_d, temp_cck, val_x, value32;
-	long val_y, ele_c = 0;
-	u8 ofdm_index[2];
-	s8 cck_index = 0;
-	u8 ofdm_index_old[2] = {0, 0};
-	s8 cck_index_old = 0;
-	u8 index;
-	int i;
-	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
-	u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
-	u8 indexforchannel =
-	    rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
-	static const u8 index_mapping[5][INDEX_MAPPING_NUM] = {
-		/* 5G, path A/MAC 0, decrease power  */
-		{0, 1, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
-		/* 5G, path A/MAC 0, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
-		/* 5G, path B/MAC 1, decrease power */
-		{0, 2, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
-		/* 5G, path B/MAC 1, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
-		/* 2.4G, for decreas power */
-		{0, 1, 2, 3, 4, 5,	6, 7, 7, 8, 9, 10, 10},
-	};
-	static const u8 index_mapping_internal_pa[8][INDEX_MAPPING_NUM] = {
-		/* 5G, path A/MAC 0, ch36-64, decrease power  */
-		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
-		/* 5G, path A/MAC 0, ch36-64, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
-		/* 5G, path A/MAC 0, ch100-165, decrease power  */
-		{0, 1, 2, 3, 5, 6,	8, 10, 11, 13, 14, 15, 15},
-		/* 5G, path A/MAC 0, ch100-165, increase power  */
-		{0, 2, 4, 5, 7, 10,	12, 14, 16, 18, 18, 18, 18},
-		/* 5G, path B/MAC 1, ch36-64, decrease power */
-		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
-		/* 5G, path B/MAC 1, ch36-64, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
-		/* 5G, path B/MAC 1, ch100-165, decrease power */
-		{0, 1, 2, 3, 5, 6,	8, 9, 10, 12, 13, 14, 14},
-		/* 5G, path B/MAC 1, ch100-165, increase power */
-		{0, 2, 4, 5, 7, 10,	13, 16, 16, 18, 18, 18, 18},
-	};
-
-	rtlpriv->dm.txpower_trackinginit = true;
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
-	thermalvalue = (u8) rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0xf800);
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
-		thermalvalue,
-		rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
-	rtl92d_phy_ap_calibrate(hw, (thermalvalue -
-				     rtlefuse->eeprom_thermalmeter));
-
-	if (!thermalvalue)
-		goto exit;
-
-	if (is2t)
-		rf = 2;
-	else
-		rf = 1;
-
-	if (rtlpriv->dm.thermalvalue && !rtlhal->reloadtxpowerindex)
-		goto old_index_done;
-
-	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;
-	for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
-		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
-			ofdm_index_old[0] = (u8)i;
-
-			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				"Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
-				ROFDM0_XATXIQIMBALANCE,
-				ele_d, ofdm_index_old[0]);
-			break;
-		}
-	}
-	if (is2t) {
-		ele_d = rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
-				      MASKDWORD) & MASKOFDM_D;
-		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
-			if (ele_d ==
-			    (ofdmswing_table[i] & MASKOFDM_D)) {
-				ofdm_index_old[1] = (u8)i;
-				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
-					DBG_LOUD,
-					"Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
-					ROFDM0_XBTXIQIMBALANCE, ele_d,
-					ofdm_index_old[1]);
-				break;
-			}
-		}
-	}
-	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		rtl92d_bandtype_2_4G(hw, &temp_cck, &cck_index_old);
-	} else {
-		temp_cck = 0x090e1317;
-		cck_index_old = 12;
-	}
-
-	if (!rtlpriv->dm.thermalvalue) {
-		rtlpriv->dm.thermalvalue = rtlefuse->eeprom_thermalmeter;
-		rtlpriv->dm.thermalvalue_lck = thermalvalue;
-		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
-		rtlpriv->dm.thermalvalue_rxgain = rtlefuse->eeprom_thermalmeter;
-		for (i = 0; i < rf; i++)
-			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-		rtlpriv->dm.cck_index = cck_index_old;
-	}
-	if (rtlhal->reloadtxpowerindex) {
-		for (i = 0; i < rf; i++)
-			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
-		rtlpriv->dm.cck_index = cck_index_old;
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"reload ofdm index for band switch\n");
-	}
-old_index_done:
-	for (i = 0; i < rf; i++)
-		ofdm_index[i] = rtlpriv->dm.ofdm_index[i];
-
-	rtlpriv->dm.thermalvalue_avg
-		    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
-	rtlpriv->dm.thermalvalue_avg_index++;
-	if (rtlpriv->dm.thermalvalue_avg_index == AVG_THERMAL_NUM)
-		rtlpriv->dm.thermalvalue_avg_index = 0;
-	for (i = 0; i < AVG_THERMAL_NUM; i++) {
-		if (rtlpriv->dm.thermalvalue_avg[i]) {
-			thermalvalue_avg += rtlpriv->dm.thermalvalue_avg[i];
-			thermalvalue_avg_count++;
-		}
-	}
-	if (thermalvalue_avg_count)
-		thermalvalue = (u8)(thermalvalue_avg / thermalvalue_avg_count);
-	if (rtlhal->reloadtxpowerindex) {
-		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
-		rtlhal->reloadtxpowerindex = false;
-		rtlpriv->dm.done_txpower = false;
-	} else if (rtlpriv->dm.done_txpower) {
-		delta = (thermalvalue > rtlpriv->dm.thermalvalue) ?
-		    (thermalvalue - rtlpriv->dm.thermalvalue) :
-		    (rtlpriv->dm.thermalvalue - thermalvalue);
-	} else {
-		delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-		    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-		    (rtlefuse->eeprom_thermalmeter - thermalvalue);
-	}
-	delta_lck = (thermalvalue > rtlpriv->dm.thermalvalue_lck) ?
-	    (thermalvalue - rtlpriv->dm.thermalvalue_lck) :
-	    (rtlpriv->dm.thermalvalue_lck - thermalvalue);
-	delta_iqk = (thermalvalue > rtlpriv->dm.thermalvalue_iqk) ?
-	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
-	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
-	delta_rxgain =
-		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
-		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
-		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-		thermalvalue, rtlpriv->dm.thermalvalue,
-		rtlefuse->eeprom_thermalmeter, delta, delta_lck,
-		delta_iqk);
-	if (delta_lck > rtlefuse->delta_lck && rtlefuse->delta_lck != 0) {
-		rtlpriv->dm.thermalvalue_lck = thermalvalue;
-		rtl92d_phy_lc_calibrate(hw);
-	}
-
-	if (delta == 0 || !rtlpriv->dm.txpower_track_control)
-		goto check_delta;
-
-	rtlpriv->dm.done_txpower = true;
-	delta = (thermalvalue > rtlefuse->eeprom_thermalmeter) ?
-	    (thermalvalue - rtlefuse->eeprom_thermalmeter) :
-	    (rtlefuse->eeprom_thermalmeter - thermalvalue);
-	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		offset = 4;
-		if (delta > INDEX_MAPPING_NUM - 1)
-			index = index_mapping[offset][INDEX_MAPPING_NUM - 1];
-		else
-			index = index_mapping[offset][delta];
-		if (thermalvalue > rtlpriv->dm.thermalvalue) {
-			for (i = 0; i < rf; i++)
-				ofdm_index[i] -= delta;
-			cck_index -= delta;
-		} else {
-			for (i = 0; i < rf; i++)
-				ofdm_index[i] += index;
-			cck_index += index;
-		}
-	} else if (rtlhal->current_bandtype == BAND_ON_5G) {
-		rtl92d_bandtype_5G(rtlhal, ofdm_index,
-				   &internal_pa, thermalvalue,
-				   delta, rf, rtlefuse, rtlpriv,
-				   rtlphy, index_mapping,
-				   index_mapping_internal_pa);
-	}
-	if (is2t) {
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
-			rtlpriv->dm.ofdm_index[0],
-			rtlpriv->dm.ofdm_index[1],
-			rtlpriv->dm.cck_index);
-	} else {
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
-			rtlpriv->dm.ofdm_index[0],
-			rtlpriv->dm.cck_index);
-	}
-	for (i = 0; i < rf; i++) {
-		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1) {
-			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
-		} else if (internal_pa ||
-			   rtlhal->current_bandtype == BAND_ON_2_4G) {
-			if (ofdm_index[i] < ofdm_min_index_internal_pa)
-				ofdm_index[i] = ofdm_min_index_internal_pa;
-		} else if (ofdm_index[i] < ofdm_min_index) {
-			ofdm_index[i] = ofdm_min_index;
-		}
-	}
-	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		if (cck_index > CCK_TABLE_SIZE - 1) {
-			cck_index = CCK_TABLE_SIZE - 1;
-		} else if (cck_index < 0) {
-			cck_index = 0;
-		}
-	}
-	if (is2t) {
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
-			ofdm_index[0], ofdm_index[1],
-			cck_index);
-	} else {
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"new OFDM_A_index=0x%x,cck_index = 0x%x\n",
-			ofdm_index[0], cck_index);
-	}
-	ele_d = (ofdmswing_table[ofdm_index[0]] & 0xFFC00000) >> 22;
-	val_x = rtlphy->iqk_matrix[indexforchannel].value[0][0];
-	val_y = rtlphy->iqk_matrix[indexforchannel].value[0][1];
-	if (val_x != 0) {
-		if ((val_x & 0x00000200) != 0)
-			val_x = val_x | 0xFFFFFC00;
-		ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
-
-		/* new element C = element D x Y */
-		if ((val_y & 0x00000200) != 0)
-			val_y = val_y | 0xFFFFFC00;
-		ele_c = ((val_y * ele_d) >> 8) & 0x000003FF;
-
-		/* write new elements A, C, D to regC80 and
-		 * regC94, element B is always 0
-		 */
-		value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
-		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
-			      MASKDWORD, value32);
-
-		value32 = (ele_c & 0x000003C0) >> 6;
-		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-			      value32);
-
-		value32 = ((val_x * ele_d) >> 7) & 0x01;
-		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
-			      value32);
-
-	} else {
-		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
-			      MASKDWORD,
-			      ofdmswing_table[(u8)ofdm_index[0]]);
-		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, MASKH4BITS,
-			      0x00);
-		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-			      BIT(24), 0x00);
-	}
-
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
-		rtlhal->interfaceindex,
-		val_x, val_y, ele_a, ele_c, ele_d,
-		val_x, val_y);
-
-	if (cck_index >= CCK_TABLE_SIZE)
-		cck_index = CCK_TABLE_SIZE - 1;
-	if (cck_index < 0)
-		cck_index = 0;
-	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		/* Adjust CCK according to IQK result */
-		if (!rtlpriv->dm.cck_inch14) {
-			rtl_write_byte(rtlpriv, 0xa22,
-				       cckswing_table_ch1ch13[cck_index][0]);
-			rtl_write_byte(rtlpriv, 0xa23,
-				       cckswing_table_ch1ch13[cck_index][1]);
-			rtl_write_byte(rtlpriv, 0xa24,
-				       cckswing_table_ch1ch13[cck_index][2]);
-			rtl_write_byte(rtlpriv, 0xa25,
-				       cckswing_table_ch1ch13[cck_index][3]);
-			rtl_write_byte(rtlpriv, 0xa26,
-				       cckswing_table_ch1ch13[cck_index][4]);
-			rtl_write_byte(rtlpriv, 0xa27,
-				       cckswing_table_ch1ch13[cck_index][5]);
-			rtl_write_byte(rtlpriv, 0xa28,
-				       cckswing_table_ch1ch13[cck_index][6]);
-			rtl_write_byte(rtlpriv, 0xa29,
-				       cckswing_table_ch1ch13[cck_index][7]);
-		} else {
-			rtl_write_byte(rtlpriv, 0xa22,
-				       cckswing_table_ch14[cck_index][0]);
-			rtl_write_byte(rtlpriv, 0xa23,
-				       cckswing_table_ch14[cck_index][1]);
-			rtl_write_byte(rtlpriv, 0xa24,
-				       cckswing_table_ch14[cck_index][2]);
-			rtl_write_byte(rtlpriv, 0xa25,
-				       cckswing_table_ch14[cck_index][3]);
-			rtl_write_byte(rtlpriv, 0xa26,
-				       cckswing_table_ch14[cck_index][4]);
-			rtl_write_byte(rtlpriv, 0xa27,
-				       cckswing_table_ch14[cck_index][5]);
-			rtl_write_byte(rtlpriv, 0xa28,
-				       cckswing_table_ch14[cck_index][6]);
-			rtl_write_byte(rtlpriv, 0xa29,
-				       cckswing_table_ch14[cck_index][7]);
-		}
-	}
-	if (is2t) {
-		ele_d = (ofdmswing_table[ofdm_index[1]] & 0xFFC00000) >> 22;
-		val_x = rtlphy->iqk_matrix[indexforchannel].value[0][4];
-		val_y = rtlphy->iqk_matrix[indexforchannel].value[0][5];
-		if (val_x != 0) {
-			if ((val_x & 0x00000200) != 0)
-				/* consider minus */
-				val_x = val_x | 0xFFFFFC00;
-			ele_a = ((val_x * ele_d) >> 8) & 0x000003FF;
-			/* new element C = element D x Y */
-			if ((val_y & 0x00000200) != 0)
-				val_y = val_y | 0xFFFFFC00;
-			ele_c = ((val_y * ele_d) >> 8) & 0x00003FF;
-			/* write new elements A, C, D to regC88
-			 * and regC9C, element B is always 0
-			 */
-			value32 = (ele_d << 22) | ((ele_c & 0x3F) << 16) | ele_a;
-			rtl_set_bbreg(hw,
-				      ROFDM0_XBTXIQIMBALANCE,
-				      MASKDWORD, value32);
-			value32 = (ele_c & 0x000003C0) >> 6;
-			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-				      MASKH4BITS, value32);
-			value32 = ((val_x * ele_d) >> 7) & 0x01;
-			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-				      BIT(28), value32);
-		} else {
-			rtl_set_bbreg(hw,
-				      ROFDM0_XBTXIQIMBALANCE,
-				      MASKDWORD,
-				      ofdmswing_table[ofdm_index[1]]);
-			rtl_set_bbreg(hw, ROFDM0_XDTXAFE,
-				      MASKH4BITS, 0x00);
-			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
-				      BIT(28), 0x00);
-		}
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
-			val_x, val_y, ele_a, ele_c,
-			ele_d, val_x, val_y);
-	}
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
-		rtl_get_bbreg(hw, 0xc80, MASKDWORD),
-		rtl_get_bbreg(hw, 0xc94, MASKDWORD),
-		rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
-			      RFREG_OFFSET_MASK));
-
-check_delta:
-	if (delta_iqk > rtlefuse->delta_iqk && rtlefuse->delta_iqk != 0) {
-		rtl92d_phy_reset_iqk_result(hw);
-		rtlpriv->dm.thermalvalue_iqk = thermalvalue;
-		rtl92d_phy_iq_calibrate(hw);
-	}
-	if (delta_rxgain > 0 && rtlhal->current_bandtype == BAND_ON_5G &&
-	    thermalvalue <= rtlefuse->eeprom_thermalmeter) {
-		rtlpriv->dm.thermalvalue_rxgain = thermalvalue;
-		rtl92d_dm_rxgain_tracking_thermalmeter(hw);
-	}
-	if (rtlpriv->dm.txpower_track_control)
-		rtlpriv->dm.thermalvalue = thermalvalue;
-
-exit:
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
-}
-
-static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	rtlpriv->dm.txpower_tracking = true;
-	rtlpriv->dm.txpower_trackinginit = false;
-	rtlpriv->dm.txpower_track_control = true;
-	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		"pMgntInfo->txpower_tracking = %d\n",
-		rtlpriv->dm.txpower_tracking);
-}
-
-void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	if (!rtlpriv->dm.txpower_tracking)
-		return;
-
-	if (!rtlpriv->dm.tm_trigger) {
-		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17) |
-			      BIT(16), 0x03);
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"Trigger 92S Thermal Meter!!\n");
-		rtlpriv->dm.tm_trigger = 1;
-		return;
-	} else {
-		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			"Schedule TxPowerTracking direct call!!\n");
-		rtl92d_dm_txpower_tracking_callback_thermalmeter(hw);
-		rtlpriv->dm.tm_trigger = 0;
-	}
-}
-
-void rtl92d_dm_init_rate_adaptive_mask(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rate_adaptive *ra = &(rtlpriv->ra);
-
-	ra->ratr_state = DM_RATR_STA_INIT;
-	ra->pre_ratr_state = DM_RATR_STA_INIT;
-	if (rtlpriv->dm.dm_type == DM_TYPE_BYDRIVER)
-		rtlpriv->dm.useramask = true;
-	else
-		rtlpriv->dm.useramask = false;
-}
-
-void rtl92d_dm_init(struct ieee80211_hw *hw)
+void rtl92de_dm_init(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
@@ -1212,7 +154,7 @@ void rtl92d_dm_init(struct ieee80211_hw *hw)
 	rtl92d_dm_initialize_txpower_tracking(hw);
 }
 
-void rtl92d_dm_watchdog(struct ieee80211_hw *hw)
+void rtl92de_dm_watchdog(struct ieee80211_hw *hw)
 {
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	bool fw_current_inpsmode = false;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.h
index 939cc45bfebd..beade227b442 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.h
@@ -4,94 +4,7 @@
 #ifndef	__RTL92C_DM_H__
 #define __RTL92C_DM_H__
 
-#define HAL_DM_DIG_DISABLE			BIT(0)
-#define HAL_DM_HIPWR_DISABLE			BIT(1)
-
-#define OFDM_TABLE_LENGTH			37
-#define OFDM_TABLE_SIZE_92D			43
-#define CCK_TABLE_LENGTH			33
-
-#define CCK_TABLE_SIZE				33
-
-#define BW_AUTO_SWITCH_HIGH_LOW			25
-#define BW_AUTO_SWITCH_LOW_HIGH			30
-
-#define DM_DIG_FA_UPPER				0x32
-#define DM_DIG_FA_LOWER				0x20
-#define DM_DIG_FA_TH0				0x100
-#define DM_DIG_FA_TH1				0x400
-#define DM_DIG_FA_TH2				0x600
-
-#define RXPATHSELECTION_SS_TH_LOW		30
-#define RXPATHSELECTION_DIFF_TH			18
-
-#define DM_RATR_STA_INIT			0
-#define DM_RATR_STA_HIGH			1
-#define DM_RATR_STA_MIDDLE			2
-#define DM_RATR_STA_LOW				3
-
-#define CTS2SELF_THVAL				30
-#define REGC38_TH				20
-
-#define WAIOTTHVAL				25
-
-#define TXHIGHPWRLEVEL_NORMAL			0
-#define TXHIGHPWRLEVEL_LEVEL1			1
-#define TXHIGHPWRLEVEL_LEVEL2			2
-#define TXHIGHPWRLEVEL_BT1			3
-#define TXHIGHPWRLEVEL_BT2			4
-
-#define DM_TYPE_BYFW				0
-#define DM_TYPE_BYDRIVER			1
-
-#define TX_POWER_NEAR_FIELD_THRESH_LVL2		74
-#define TX_POWER_NEAR_FIELD_THRESH_LVL1		67
-#define INDEX_MAPPING_NUM			13
-
-struct swat {
-	u8 failure_cnt;
-	u8 try_flag;
-	u8 stop_trying;
-	long pre_rssi;
-	long trying_threshold;
-	u8 cur_antenna;
-	u8 pre_antenna;
-};
-
-enum tag_dynamic_init_gain_operation_type_definition {
-	DIG_TYPE_THRESH_HIGH = 0,
-	DIG_TYPE_THRESH_LOW = 1,
-	DIG_TYPE_BACKOFF = 2,
-	DIG_TYPE_RX_GAIN_MIN = 3,
-	DIG_TYPE_RX_GAIN_MAX = 4,
-	DIG_TYPE_ENABLE = 5,
-	DIG_TYPE_DISABLE = 6,
-	DIG_OP_TYPE_MAX
-};
-
-enum dm_1r_cca {
-	CCA_1R = 0,
-	CCA_2R = 1,
-	CCA_MAX = 2,
-};
-
-enum dm_rf {
-	RF_SAVE = 0,
-	RF_NORMAL = 1,
-	RF_MAX = 2,
-};
-
-enum dm_sw_ant_switch {
-	ANS_ANTENNA_B = 1,
-	ANS_ANTENNA_A = 2,
-	ANS_ANTENNA_MAX = 3,
-};
-
-void rtl92d_dm_init(struct ieee80211_hw *hw);
-void rtl92d_dm_watchdog(struct ieee80211_hw *hw);
-void rtl92d_dm_init_edca_turbo(struct ieee80211_hw *hw);
-void rtl92d_dm_write_dig(struct ieee80211_hw *hw);
-void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw);
-void rtl92d_dm_init_rate_adaptive_mask(struct ieee80211_hw *hw);
+void rtl92de_dm_init(struct ieee80211_hw *hw);
+void rtl92de_dm_watchdog(struct ieee80211_hw *hw);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index e1fb29962801..c8444a72ff69 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -5,157 +5,12 @@
 #include "../pci.h"
 #include "../base.h"
 #include "../efuse.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
 #include "fw.h"
 #include "sw.h"
 
-static bool _rtl92d_is_fw_downloaded(struct rtl_priv *rtlpriv)
-{
-	return (rtl_read_dword(rtlpriv, REG_MCUFWDL) & MCUFWDL_RDY) ?
-		true : false;
-}
-
-static void _rtl92d_enable_fw_download(struct ieee80211_hw *hw, bool enable)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 tmp;
-
-	if (enable) {
-		tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
-		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, tmp | 0x04);
-		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL);
-		rtl_write_byte(rtlpriv, REG_MCUFWDL, tmp | 0x01);
-		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL + 2);
-		rtl_write_byte(rtlpriv, REG_MCUFWDL + 2, tmp & 0xf7);
-	} else {
-		tmp = rtl_read_byte(rtlpriv, REG_MCUFWDL);
-		rtl_write_byte(rtlpriv, REG_MCUFWDL, tmp & 0xfe);
-		/* Reserved for fw extension.
-		 * 0x81[7] is used for mac0 status ,
-		 * so don't write this reg here
-		 * rtl_write_byte(rtlpriv, REG_MCUFWDL + 1, 0x00);*/
-	}
-}
-
-static void _rtl92d_write_fw(struct ieee80211_hw *hw,
-			     enum version_8192d version, u8 *buffer, u32 size)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 *bufferptr = buffer;
-	u32 pagenums, remainsize;
-	u32 page, offset;
-
-	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
-	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE)
-		rtl_fill_dummy(bufferptr, &size);
-	pagenums = size / FW_8192D_PAGE_SIZE;
-	remainsize = size % FW_8192D_PAGE_SIZE;
-	if (pagenums > 8)
-		pr_err("Page numbers should not greater then 8\n");
-	for (page = 0; page < pagenums; page++) {
-		offset = page * FW_8192D_PAGE_SIZE;
-		rtl_fw_page_write(hw, page, (bufferptr + offset),
-				  FW_8192D_PAGE_SIZE);
-	}
-	if (remainsize) {
-		offset = pagenums * FW_8192D_PAGE_SIZE;
-		page = pagenums;
-		rtl_fw_page_write(hw, page, (bufferptr + offset), remainsize);
-	}
-}
-
-static int _rtl92d_fw_free_to_go(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 counter = 0;
-	u32 value32;
-
-	do {
-		value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
-	} while ((counter++ < FW_8192D_POLLING_TIMEOUT_COUNT) &&
-		 (!(value32 & FWDL_CHKSUM_RPT)));
-	if (counter >= FW_8192D_POLLING_TIMEOUT_COUNT) {
-		pr_err("chksum report fail! REG_MCUFWDL:0x%08x\n",
-		       value32);
-		return -EIO;
-	}
-	value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
-	value32 |= MCUFWDL_RDY;
-	rtl_write_dword(rtlpriv, REG_MCUFWDL, value32);
-	return 0;
-}
-
-void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 u1b_tmp;
-	u8 delay = 100;
-
-	/* Set (REG_HMETFR + 3) to  0x20 is reset 8051 */
-	rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
-	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
-	while (u1b_tmp & BIT(2)) {
-		delay--;
-		if (delay == 0)
-			break;
-		udelay(50);
-		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
-	}
-	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
-	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-		"=====> 8051 reset success (%d)\n", delay);
-}
-
-static int _rtl92d_fw_init(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u32 counter;
-
-	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
-	/* polling for FW ready */
-	counter = 0;
-	do {
-		if (rtlhal->interfaceindex == 0) {
-			if (rtl_read_byte(rtlpriv, FW_MAC0_READY) &
-			    MAC0_READY) {
-				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
-					rtl_read_byte(rtlpriv,
-						      FW_MAC0_READY));
-				return 0;
-			}
-			udelay(5);
-		} else {
-			if (rtl_read_byte(rtlpriv, FW_MAC1_READY) &
-			    MAC1_READY) {
-				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
-					rtl_read_byte(rtlpriv,
-						      FW_MAC1_READY));
-				return 0;
-			}
-			udelay(5);
-		}
-	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
-
-	if (rtlhal->interfaceindex == 0) {
-		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-			"Polling FW ready fail!! MAC0 FW init not ready: 0x%x\n",
-			rtl_read_byte(rtlpriv, FW_MAC0_READY));
-	} else {
-		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-			"Polling FW ready fail!! MAC1 FW init not ready: 0x%x\n",
-			rtl_read_byte(rtlpriv, FW_MAC1_READY));
-	}
-	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
-		"Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
-		rtl_read_dword(rtlpriv, REG_MCUFWDL));
-	return -1;
-}
-
 int rtl92d_download_fw(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -189,7 +44,7 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 	}
 
 	spin_lock_irqsave(&globalmutex_for_fwdownload, flags);
-	fw_downloaded = _rtl92d_is_fw_downloaded(rtlpriv);
+	fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
 	if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
 		fwdl_in_process = true;
 	else
@@ -202,7 +57,7 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 		for (count = 0; count < 5000; count++) {
 			udelay(500);
 			spin_lock_irqsave(&globalmutex_for_fwdownload, flags);
-			fw_downloaded = _rtl92d_is_fw_downloaded(rtlpriv);
+			fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
 			if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
 				fwdl_in_process = true;
 			else
@@ -237,11 +92,11 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 		rtl92d_firmware_selfreset(hw);
 		rtl_write_byte(rtlpriv, REG_MCUFWDL, 0x00);
 	}
-	_rtl92d_enable_fw_download(hw, true);
-	_rtl92d_write_fw(hw, version, pfwdata, fwsize);
-	_rtl92d_enable_fw_download(hw, false);
+	rtl92d_enable_fw_download(hw, true);
+	rtl92d_write_fw(hw, version, pfwdata, fwsize);
+	rtl92d_enable_fw_download(hw, false);
 	spin_lock_irqsave(&globalmutex_for_fwdownload, flags);
-	err = _rtl92d_fw_free_to_go(hw);
+	err = rtl92d_fw_free_to_go(hw);
 	/* download fw over,clear 0x1f[5] */
 	value = rtl_read_byte(rtlpriv, 0x1f);
 	value &= (~BIT(5));
@@ -250,207 +105,10 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 	if (err)
 		pr_err("fw is not ready to run!\n");
 exit:
-	err = _rtl92d_fw_init(hw);
+	err = rtl92d_fw_init(hw);
 	return err;
 }
 
-static bool _rtl92d_check_fw_read_last_h2c(struct ieee80211_hw *hw, u8 boxnum)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 val_hmetfr;
-	bool result = false;
-
-	val_hmetfr = rtl_read_byte(rtlpriv, REG_HMETFR);
-	if (((val_hmetfr >> boxnum) & BIT(0)) == 0)
-		result = true;
-	return result;
-}
-
-static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
-			      u8 element_id, u32 cmd_len, u8 *cmdbuffer)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	u8 boxnum;
-	u16 box_reg = 0, box_extreg = 0;
-	u8 u1b_tmp;
-	bool isfw_read = false;
-	u8 buf_index = 0;
-	bool bwrite_success = false;
-	u8 wait_h2c_limmit = 100;
-	u8 wait_writeh2c_limmit = 100;
-	u8 boxcontent[4], boxextcontent[2];
-	u32 h2c_waitcounter = 0;
-	unsigned long flag;
-	u8 idx;
-
-	if (ppsc->rfpwr_state == ERFOFF || ppsc->inactive_pwrstate == ERFOFF) {
-		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-			"Return as RF is off!!!\n");
-		return;
-	}
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
-	while (true) {
-		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
-		if (rtlhal->h2c_setinprogress) {
-			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-				"H2C set in progress! Wait to set..element_id(%d)\n",
-				element_id);
-
-			while (rtlhal->h2c_setinprogress) {
-				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
-						       flag);
-				h2c_waitcounter++;
-				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-					"Wait 100 us (%d times)...\n",
-					h2c_waitcounter);
-				udelay(100);
-
-				if (h2c_waitcounter > 1000)
-					return;
-
-				spin_lock_irqsave(&rtlpriv->locks.h2c_lock,
-						  flag);
-			}
-			spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
-		} else {
-			rtlhal->h2c_setinprogress = true;
-			spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
-			break;
-		}
-	}
-	while (!bwrite_success) {
-		wait_writeh2c_limmit--;
-		if (wait_writeh2c_limmit == 0) {
-			pr_err("Write H2C fail because no trigger for FW INT!\n");
-			break;
-		}
-		boxnum = rtlhal->last_hmeboxnum;
-		switch (boxnum) {
-		case 0:
-			box_reg = REG_HMEBOX_0;
-			box_extreg = REG_HMEBOX_EXT_0;
-			break;
-		case 1:
-			box_reg = REG_HMEBOX_1;
-			box_extreg = REG_HMEBOX_EXT_1;
-			break;
-		case 2:
-			box_reg = REG_HMEBOX_2;
-			box_extreg = REG_HMEBOX_EXT_2;
-			break;
-		case 3:
-			box_reg = REG_HMEBOX_3;
-			box_extreg = REG_HMEBOX_EXT_3;
-			break;
-		default:
-			pr_err("switch case %#x not processed\n",
-			       boxnum);
-			break;
-		}
-		isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
-		while (!isfw_read) {
-			wait_h2c_limmit--;
-			if (wait_h2c_limmit == 0) {
-				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-					"Waiting too long for FW read clear HMEBox(%d)!\n",
-					boxnum);
-				break;
-			}
-			udelay(10);
-			isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
-			u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
-			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-				"Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
-				boxnum, u1b_tmp);
-		}
-		if (!isfw_read) {
-			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-				"Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
-				boxnum);
-			break;
-		}
-		memset(boxcontent, 0, sizeof(boxcontent));
-		memset(boxextcontent, 0, sizeof(boxextcontent));
-		boxcontent[0] = element_id;
-		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-			"Write element_id box_reg(%4x) = %2x\n",
-			box_reg, element_id);
-		switch (cmd_len) {
-		case 1:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 1);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 2:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 2);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 3:
-			boxcontent[0] &= ~(BIT(7));
-			memcpy(boxcontent + 1, cmdbuffer + buf_index, 3);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 4:
-			boxcontent[0] |= (BIT(7));
-			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
-			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 2);
-			for (idx = 0; idx < 2; idx++)
-				rtl_write_byte(rtlpriv, box_extreg + idx,
-					       boxextcontent[idx]);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		case 5:
-			boxcontent[0] |= (BIT(7));
-			memcpy(boxextcontent, cmdbuffer + buf_index, 2);
-			memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 3);
-			for (idx = 0; idx < 2; idx++)
-				rtl_write_byte(rtlpriv, box_extreg + idx,
-					       boxextcontent[idx]);
-			for (idx = 0; idx < 4; idx++)
-				rtl_write_byte(rtlpriv, box_reg + idx,
-					       boxcontent[idx]);
-			break;
-		default:
-			pr_err("switch case %#x not processed\n",
-			       cmd_len);
-			break;
-		}
-		bwrite_success = true;
-		rtlhal->last_hmeboxnum = boxnum + 1;
-		if (rtlhal->last_hmeboxnum == 4)
-			rtlhal->last_hmeboxnum = 0;
-		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
-			"pHalData->last_hmeboxnum  = %d\n",
-			rtlhal->last_hmeboxnum);
-	}
-	spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
-	rtlhal->h2c_setinprogress = false;
-	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
-}
-
-void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
-			 u8 element_id, u32 cmd_len, u8 *cmdbuffer)
-{
-	u32 tmp_cmdbuf[2];
-
-	memset(tmp_cmdbuf, 0, 8);
-	memcpy(tmp_cmdbuf, cmdbuffer, cmd_len);
-	_rtl92d_fill_h2c_command(hw, element_id, cmd_len, (u8 *)&tmp_cmdbuf);
-	return;
-}
-
 static bool _rtl92d_cmd_send_packet(struct ieee80211_hw *hw,
 				    struct sk_buff *skb)
 {
@@ -599,7 +257,7 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 	struct sk_buff *skb = NULL;
 	u32 totalpacketlen;
 	bool rtstatus;
-	u8 u1rsvdpageloc[3] = { 0 };
+	u8 u1rsvdpageloc[3] = { PROBERSP_PG, PSPOLL_PG, NULL_PG };
 	bool dlok = false;
 	u8 *beacon;
 	u8 *p_pspoll;
@@ -618,7 +276,6 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 	SET_80211_PS_POLL_AID(p_pspoll, (mac->assoc_id | 0xc000));
 	SET_80211_PS_POLL_BSSID(p_pspoll, mac->bssid);
 	SET_80211_PS_POLL_TA(p_pspoll, mac->mac_addr);
-	SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(u1rsvdpageloc, PSPOLL_PG);
 	/*--------------------------------------------------------
 						(3) null data
 	---------------------------------------------------------*/
@@ -626,7 +283,6 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 	SET_80211_HDR_ADDRESS1(nullfunc, mac->bssid);
 	SET_80211_HDR_ADDRESS2(nullfunc, mac->mac_addr);
 	SET_80211_HDR_ADDRESS3(nullfunc, mac->bssid);
-	SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(u1rsvdpageloc, NULL_PG);
 	/*---------------------------------------------------------
 						(4) probe response
 	----------------------------------------------------------*/
@@ -634,7 +290,6 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 	SET_80211_HDR_ADDRESS1(p_probersp, mac->bssid);
 	SET_80211_HDR_ADDRESS2(p_probersp, mac->mac_addr);
 	SET_80211_HDR_ADDRESS3(p_probersp, mac->bssid);
-	SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(u1rsvdpageloc, PROBERSP_PG);
 	totalpacketlen = TOTAL_RESERVED_PKT_LEN;
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "rtl92d_set_fw_rsvdpagepkt(): HW_VAR_SET_TX_CMD: ALL",
@@ -663,11 +318,3 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
 			"Set RSVD page location to Fw FAIL!!!!!!\n");
 }
-
-void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus)
-{
-	u8 u1_joinbssrpt_parm[1] = {0};
-
-	SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(u1_joinbssrpt_parm, mstatus);
-	rtl92d_fill_h2c_cmd(hw, H2C_JOINBSSRPT, 1, u1_joinbssrpt_parm);
-}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
index 7f0a17c1a9ea..9e1385ac17b1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
@@ -4,44 +4,7 @@
 #ifndef __RTL92D__FW__H__
 #define __RTL92D__FW__H__
 
-#define FW_8192D_START_ADDRESS			0x1000
-#define FW_8192D_PAGE_SIZE				4096
-#define FW_8192D_POLLING_TIMEOUT_COUNT	1000
-
-#define IS_FW_HEADER_EXIST(_pfwhdr)	\
-		((GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFF0) == 0x92C0 || \
-		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFF0) == 0x88C0 ||  \
-		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D0 ||  \
-		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D1 ||  \
-		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D2 ||  \
-		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D3)
-
-/* Firmware Header(8-byte alinment required) */
-/* --- LONG WORD 0 ---- */
-#define GET_FIRMWARE_HDR_SIGNATURE(__fwhdr)		\
-	le32_get_bits(*(__le32 *)__fwhdr, GENMASK(15, 0))
-#define GET_FIRMWARE_HDR_VERSION(__fwhdr)		\
-	le32_get_bits(*(__le32 *)(__fwhdr + 4), GENMASK(15, 0))
-#define GET_FIRMWARE_HDR_SUB_VER(__fwhdr)		\
-	le32_get_bits(*(__le32 *)(__fwhdr + 4), GENMASK(23, 16))
-
-#define pagenum_128(_len) \
-	(u32)(((_len) >> 7) + ((_len) & 0x7F ? 1 : 0))
-
-#define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)	\
-	*(u8 *)__ph2ccmd = __val;
-#define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)	\
-	*(u8 *)__ph2ccmd = __val;
-#define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)	\
-	*(u8 *)(__ph2ccmd + 1) = __val;
-#define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)	\
-	*(u8 *)(__ph2ccmd + 2) = __val;
-
 int rtl92d_download_fw(struct ieee80211_hw *hw);
-void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
-			 u32 cmd_len, u8 *p_cmdbuffer);
-void rtl92d_firmware_selfreset(struct ieee80211_hw *hw);
 void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished);
-void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 4ba42f6be3f2..73b81e60cfa9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -8,8 +8,12 @@
 #include "../cam.h"
 #include "../ps.h"
 #include "../pci.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/hw_common.h"
+#include "../rtl8192d/phy_common.h"
 #include "phy.h"
 #include "dm.h"
 #include "fw.h"
@@ -50,34 +54,6 @@ static void _rtl92de_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
 	rtl_write_byte(rtlpriv, REG_BCN_CTRL, (u8) rtlpci->reg_bcn_ctrl_val);
 }
 
-static void _rtl92de_stop_tx_beacon(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 tmp1byte;
-
-	tmp1byte = rtl_read_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2);
-	rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2, tmp1byte & (~BIT(6)));
-	rtl_write_byte(rtlpriv, REG_BCN_MAX_ERR, 0xff);
-	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 1, 0x64);
-	tmp1byte = rtl_read_byte(rtlpriv, REG_TBTT_PROHIBIT + 2);
-	tmp1byte &= ~(BIT(0));
-	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
-}
-
-static void _rtl92de_resume_tx_beacon(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 tmp1byte;
-
-	tmp1byte = rtl_read_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2);
-	rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2, tmp1byte | BIT(6));
-	rtl_write_byte(rtlpriv, REG_BCN_MAX_ERR, 0x0a);
-	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 1, 0xff);
-	tmp1byte = rtl_read_byte(rtlpriv, REG_TBTT_PROHIBIT + 2);
-	tmp1byte |= BIT(0);
-	rtl_write_byte(rtlpriv, REG_TBTT_PROHIBIT + 2, tmp1byte);
-}
-
 static void _rtl92de_enable_bcn_sub_func(struct ieee80211_hw *hw)
 {
 	_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(1));
@@ -90,58 +66,14 @@ static void _rtl92de_disable_bcn_sub_func(struct ieee80211_hw *hw)
 
 void rtl92de_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 {
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
 	switch (variable) {
 	case HW_VAR_RCR:
 		*((u32 *) (val)) = rtlpci->receive_config;
 		break;
-	case HW_VAR_RF_STATE:
-		*((enum rf_pwrstate *)(val)) = ppsc->rfpwr_state;
-		break;
-	case HW_VAR_FWLPS_RF_ON:{
-		enum rf_pwrstate rfstate;
-		u32 val_rcr;
-
-		rtlpriv->cfg->ops->get_hw_reg(hw, HW_VAR_RF_STATE,
-					      (u8 *)(&rfstate));
-		if (rfstate == ERFOFF) {
-			*((bool *) (val)) = true;
-		} else {
-			val_rcr = rtl_read_dword(rtlpriv, REG_RCR);
-			val_rcr &= 0x00070000;
-			if (val_rcr)
-				*((bool *) (val)) = false;
-			else
-				*((bool *) (val)) = true;
-		}
-		break;
-	}
-	case HW_VAR_FW_PSMODE_STATUS:
-		*((bool *) (val)) = ppsc->fw_current_inpsmode;
-		break;
-	case HW_VAR_CORRECT_TSF:{
-		u64 tsf;
-		u32 *ptsf_low = (u32 *)&tsf;
-		u32 *ptsf_high = ((u32 *)&tsf) + 1;
-
-		*ptsf_high = rtl_read_dword(rtlpriv, (REG_TSFTR + 4));
-		*ptsf_low = rtl_read_dword(rtlpriv, REG_TSFTR);
-		*((u64 *) (val)) = tsf;
-		break;
-	}
-	case HW_VAR_INT_MIGRATION:
-		*((bool *)(val)) = rtlpriv->dm.interrupt_migration;
-		break;
-	case HW_VAR_INT_AC:
-		*((bool *)(val)) = rtlpriv->dm.disable_tx_int;
-		break;
-	case HAL_DEF_WOWLAN:
-		break;
 	default:
-		pr_err("switch case %#x not processed\n", variable);
+		rtl92d_get_hw_reg(hw, variable, val);
 		break;
 	}
 }
@@ -151,141 +83,8 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	u8 idx;
 
 	switch (variable) {
-	case HW_VAR_ETHER_ADDR:
-		for (idx = 0; idx < ETH_ALEN; idx++) {
-			rtl_write_byte(rtlpriv, (REG_MACID + idx),
-				       val[idx]);
-		}
-		break;
-	case HW_VAR_BASIC_RATE: {
-		u16 rate_cfg = ((u16 *) val)[0];
-		u8 rate_index = 0;
-
-		rate_cfg = rate_cfg & 0x15f;
-		if (mac->vendor == PEER_CISCO &&
-		    ((rate_cfg & 0x150) == 0))
-			rate_cfg |= 0x01;
-		rtl_write_byte(rtlpriv, REG_RRSR, rate_cfg & 0xff);
-		rtl_write_byte(rtlpriv, REG_RRSR + 1,
-			       (rate_cfg >> 8) & 0xff);
-		while (rate_cfg > 0x1) {
-			rate_cfg = (rate_cfg >> 1);
-			rate_index++;
-		}
-		if (rtlhal->fw_version > 0xe)
-			rtl_write_byte(rtlpriv, REG_INIRTS_RATE_SEL,
-				       rate_index);
-		break;
-	}
-	case HW_VAR_BSSID:
-		for (idx = 0; idx < ETH_ALEN; idx++) {
-			rtl_write_byte(rtlpriv, (REG_BSSID + idx),
-				       val[idx]);
-		}
-		break;
-	case HW_VAR_SIFS:
-		rtl_write_byte(rtlpriv, REG_SIFS_CTX + 1, val[0]);
-		rtl_write_byte(rtlpriv, REG_SIFS_TRX + 1, val[1]);
-		rtl_write_byte(rtlpriv, REG_SPEC_SIFS + 1, val[0]);
-		rtl_write_byte(rtlpriv, REG_MAC_SPEC_SIFS + 1, val[0]);
-		if (!mac->ht_enable)
-			rtl_write_word(rtlpriv, REG_RESP_SIFS_OFDM,
-				       0x0e0e);
-		else
-			rtl_write_word(rtlpriv, REG_RESP_SIFS_OFDM,
-				       *((u16 *) val));
-		break;
-	case HW_VAR_SLOT_TIME: {
-		u8 e_aci;
-
-		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
-			"HW_VAR_SLOT_TIME %x\n", val[0]);
-		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
-		for (e_aci = 0; e_aci < AC_MAX; e_aci++)
-			rtlpriv->cfg->ops->set_hw_reg(hw,
-						      HW_VAR_AC_PARAM,
-						      (&e_aci));
-		break;
-	}
-	case HW_VAR_ACK_PREAMBLE: {
-		u8 reg_tmp;
-		u8 short_preamble = (bool) (*val);
-
-		reg_tmp = (mac->cur_40_prime_sc) << 5;
-		if (short_preamble)
-			reg_tmp |= 0x80;
-		rtl_write_byte(rtlpriv, REG_RRSR + 2, reg_tmp);
-		break;
-	}
-	case HW_VAR_AMPDU_MIN_SPACE: {
-		u8 min_spacing_to_set;
-
-		min_spacing_to_set = *val;
-		if (min_spacing_to_set <= 7) {
-			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
-					      min_spacing_to_set);
-			*val = min_spacing_to_set;
-			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
-				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-				mac->min_space_cfg);
-			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
-				       mac->min_space_cfg);
-		}
-		break;
-	}
-	case HW_VAR_SHORTGI_DENSITY: {
-		u8 density_to_set;
-
-		density_to_set = *val;
-		mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
-		mac->min_space_cfg |= (density_to_set << 3);
-		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
-			"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-			mac->min_space_cfg);
-		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
-			       mac->min_space_cfg);
-		break;
-	}
-	case HW_VAR_AMPDU_FACTOR: {
-		u8 factor_toset;
-		u32 regtoset;
-		u8 *ptmp_byte = NULL;
-		u8 index;
-
-		if (rtlhal->macphymode == DUALMAC_DUALPHY)
-			regtoset = 0xb9726641;
-		else if (rtlhal->macphymode == DUALMAC_SINGLEPHY)
-			regtoset = 0x66626641;
-		else
-			regtoset = 0xb972a841;
-		factor_toset = *val;
-		if (factor_toset <= 3) {
-			factor_toset = (1 << (factor_toset + 2));
-			if (factor_toset > 0xf)
-				factor_toset = 0xf;
-			for (index = 0; index < 4; index++) {
-				ptmp_byte = (u8 *)(&regtoset) + index;
-				if ((*ptmp_byte & 0xf0) >
-				    (factor_toset << 4))
-					*ptmp_byte = (*ptmp_byte & 0x0f)
-						 | (factor_toset << 4);
-				if ((*ptmp_byte & 0x0f) > factor_toset)
-					*ptmp_byte = (*ptmp_byte & 0xf0)
-						     | (factor_toset);
-			}
-			rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, regtoset);
-			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
-				"Set HW_VAR_AMPDU_FACTOR: %#x\n",
-				factor_toset);
-		}
-		break;
-	}
 	case HW_VAR_AC_PARAM: {
 		u8 e_aci = *val;
 		rtl92d_dm_init_edca_turbo(hw);
@@ -346,37 +145,6 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		rtl_write_dword(rtlpriv, REG_RCR, ((u32 *) (val))[0]);
 		rtlpci->receive_config = ((u32 *) (val))[0];
 		break;
-	case HW_VAR_RETRY_LIMIT: {
-		u8 retry_limit = val[0];
-
-		rtl_write_word(rtlpriv, REG_RL,
-			       retry_limit << RETRY_LIMIT_SHORT_SHIFT |
-			       retry_limit << RETRY_LIMIT_LONG_SHIFT);
-		break;
-	}
-	case HW_VAR_DUAL_TSF_RST:
-		rtl_write_byte(rtlpriv, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
-		break;
-	case HW_VAR_EFUSE_BYTES:
-		rtlefuse->efuse_usedbytes = *((u16 *) val);
-		break;
-	case HW_VAR_EFUSE_USAGE:
-		rtlefuse->efuse_usedpercentage = *val;
-		break;
-	case HW_VAR_IO_CMD:
-		rtl92d_phy_set_io_cmd(hw, (*(enum io_type *)val));
-		break;
-	case HW_VAR_WPA_CONFIG:
-		rtl_write_byte(rtlpriv, REG_SECCFG, *val);
-		break;
-	case HW_VAR_SET_RPWM:
-		rtl92d_fill_h2c_cmd(hw, H2C_PWRM, 1, (val));
-		break;
-	case HW_VAR_H2C_FW_PWRMODE:
-		break;
-	case HW_VAR_FW_PSMODE_STATUS:
-		ppsc->fw_current_inpsmode = *((bool *) val);
-		break;
 	case HW_VAR_H2C_FW_JOINBSSRPT: {
 		u8 mstatus = (*val);
 		u8 tmp_regcr, tmp_reg422;
@@ -409,19 +177,11 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		rtl92d_set_fw_joinbss_report_cmd(hw, (*val));
 		break;
 	}
-	case HW_VAR_AID: {
-		u16 u2btmp;
-		u2btmp = rtl_read_word(rtlpriv, REG_BCN_PSR_RPT);
-		u2btmp &= 0xC000;
-		rtl_write_word(rtlpriv, REG_BCN_PSR_RPT, (u2btmp |
-			       mac->assoc_id));
-		break;
-	}
 	case HW_VAR_CORRECT_TSF: {
 		u8 btype_ibss = val[0];
 
 		if (btype_ibss)
-			_rtl92de_stop_tx_beacon(hw);
+			rtl92de_stop_tx_beacon(hw);
 		_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(3));
 		rtl_write_dword(rtlpriv, REG_TSFTR,
 				(u32) (mac->tsf & 0xffffffff));
@@ -429,7 +189,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				(u32) ((mac->tsf >> 32) & 0xffffffff));
 		_rtl92de_set_bcn_ctrl_reg(hw, BIT(3), 0);
 		if (btype_ibss)
-			_rtl92de_resume_tx_beacon(hw);
+			rtl92de_resume_tx_beacon(hw);
 
 		break;
 	}
@@ -472,34 +232,11 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		break;
 	}
 	default:
-		pr_err("switch case %#x not processed\n", variable);
+		rtl92d_set_hw_reg(hw, variable, val);
 		break;
 	}
 }
 
-static bool _rtl92de_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	bool status = true;
-	long count = 0;
-	u32 value = _LLT_INIT_ADDR(address) |
-	    _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
-
-	rtl_write_dword(rtlpriv, REG_LLT_INIT, value);
-	do {
-		value = rtl_read_dword(rtlpriv, REG_LLT_INIT);
-		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
-			break;
-		if (count > POLLING_LLT_THRESHOLD) {
-			pr_err("Failed to polling write LLT done at address %d!\n",
-			       address);
-			status = false;
-			break;
-		}
-	} while (++count);
-	return status;
-}
-
 static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -558,13 +295,13 @@ static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw)
 
 	/* 18.  LLT_table_init(Adapter);  */
 	for (i = 0; i < (txpktbuf_bndy - 1); i++) {
-		status = _rtl92de_llt_write(hw, i, i + 1);
+		status = rtl92de_llt_write(hw, i, i + 1);
 		if (!status)
 			return status;
 	}
 
 	/* end of list */
-	status = _rtl92de_llt_write(hw, (txpktbuf_bndy - 1), 0xFF);
+	status = rtl92de_llt_write(hw, (txpktbuf_bndy - 1), 0xFF);
 	if (!status)
 		return status;
 
@@ -573,13 +310,13 @@ static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw)
 	/* config this MAC as two MAC transfer. */
 	/* Otherwise used as local loopback buffer.  */
 	for (i = txpktbuf_bndy; i < maxpage; i++) {
-		status = _rtl92de_llt_write(hw, i, (i + 1));
+		status = rtl92de_llt_write(hw, i, (i + 1));
 		if (!status)
 			return status;
 	}
 
 	/* Let last entry point to the start entry of ring buffer */
-	status = _rtl92de_llt_write(hw, maxpage, txpktbuf_bndy);
+	status = rtl92de_llt_write(hw, maxpage, txpktbuf_bndy);
 	if (!status)
 		return status;
 
@@ -842,32 +579,6 @@ static void _rtl92de_enable_aspm_back_door(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, 0x352, 0x1);
 }
 
-void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 sec_reg_value;
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
-		rtlpriv->sec.pairwise_enc_algorithm,
-		rtlpriv->sec.group_enc_algorithm);
-	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
-			"not open hw encryption\n");
-		return;
-	}
-	sec_reg_value = SCR_TXENCENABLE | SCR_RXENCENABLE;
-	if (rtlpriv->sec.use_defaultkey) {
-		sec_reg_value |= SCR_TXUSEDK;
-		sec_reg_value |= SCR_RXUSEDK;
-	}
-	sec_reg_value |= (SCR_RXBCUSEDK | SCR_TXBCUSEDK);
-	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
-	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
-		"The SECR-value %x\n", sec_reg_value);
-	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
-}
-
 int rtl92de_hw_init(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -991,11 +702,11 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	_rtl92de_enable_aspm_back_door(hw);
 	/* rtlpriv->intf_ops->enable_aspm(hw); */
 
-	rtl92d_dm_init(hw);
+	rtl92de_dm_init(hw);
 	rtlpci->being_init_adapter = false;
 
 	if (ppsc->rfpwr_state == ERFON) {
-		rtl92d_phy_lc_calibrate(hw);
+		rtl92d_phy_lc_calibrate(hw, IS_92D_SINGLEPHY(rtlhal->version));
 		/* 5G and 2.4G must wait sometime to let RF LO ready */
 		if (rtlhal->macphymode == DUALMAC_DUALPHY) {
 			u32 tmp_rega;
@@ -1020,23 +731,6 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	return err;
 }
 
-static enum version_8192d _rtl92de_read_chip_version(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	enum version_8192d version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
-	u32 value32;
-
-	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG);
-	if (!(value32 & 0x000f0000)) {
-		version = VERSION_TEST_CHIP_92D_SINGLEPHY;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
-	} else {
-		version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
-	}
-	return version;
-}
-
 static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 				     enum nl80211_iftype type)
 {
@@ -1048,11 +742,11 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 
 	if (type == NL80211_IFTYPE_UNSPECIFIED ||
 	    type == NL80211_IFTYPE_STATION) {
-		_rtl92de_stop_tx_beacon(hw);
+		rtl92de_stop_tx_beacon(hw);
 		_rtl92de_enable_bcn_sub_func(hw);
 	} else if (type == NL80211_IFTYPE_ADHOC ||
 		type == NL80211_IFTYPE_AP) {
-		_rtl92de_resume_tx_beacon(hw);
+		rtl92de_resume_tx_beacon(hw);
 		_rtl92de_disable_bcn_sub_func(hw);
 	} else {
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
@@ -1152,13 +846,6 @@ void rtl92d_linked_set_reg(struct ieee80211_hw *hw)
 	}
 }
 
-/* don't set REG_EDCA_BE_PARAM here because
- * mac80211 will send pkt when scan */
-void rtl92de_set_qos(struct ieee80211_hw *hw, int aci)
-{
-	rtl92d_dm_init_edca_turbo(hw);
-}
-
 void rtl92de_enable_interrupt(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -1383,825 +1070,6 @@ void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
 	rtl92de_enable_interrupt(hw);
 }
 
-static void _rtl92de_readpowervalue_fromprom(struct txpower_info *pwrinfo,
-				 u8 *rom_content, bool autoloadfail)
-{
-	u32 rfpath, eeaddr, group, offset1, offset2;
-	u8 i;
-
-	memset(pwrinfo, 0, sizeof(struct txpower_info));
-	if (autoloadfail) {
-		for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
-			for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
-				if (group < CHANNEL_GROUP_MAX_2G) {
-					pwrinfo->cck_index[rfpath][group] =
-					    EEPROM_DEFAULT_TXPOWERLEVEL_2G;
-					pwrinfo->ht40_1sindex[rfpath][group] =
-					    EEPROM_DEFAULT_TXPOWERLEVEL_2G;
-				} else {
-					pwrinfo->ht40_1sindex[rfpath][group] =
-					    EEPROM_DEFAULT_TXPOWERLEVEL_5G;
-				}
-				pwrinfo->ht40_2sindexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_HT40_2SDIFF;
-				pwrinfo->ht20indexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_HT20_DIFF;
-				pwrinfo->ofdmindexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_LEGACYHTTXPOWERDIFF;
-				pwrinfo->ht40maxoffset[rfpath][group] =
-				    EEPROM_DEFAULT_HT40_PWRMAXOFFSET;
-				pwrinfo->ht20maxoffset[rfpath][group] =
-				    EEPROM_DEFAULT_HT20_PWRMAXOFFSET;
-			}
-		}
-		for (i = 0; i < 3; i++) {
-			pwrinfo->tssi_a[i] = EEPROM_DEFAULT_TSSI;
-			pwrinfo->tssi_b[i] = EEPROM_DEFAULT_TSSI;
-		}
-		return;
-	}
-
-	/* Maybe autoload OK,buf the tx power index value is not filled.
-	 * If we find it, we set it to default value. */
-	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
-		for (group = 0; group < CHANNEL_GROUP_MAX_2G; group++) {
-			eeaddr = EEPROM_CCK_TX_PWR_INX_2G + (rfpath * 3)
-				 + group;
-			pwrinfo->cck_index[rfpath][group] =
-					(rom_content[eeaddr] == 0xFF) ?
-					     (eeaddr > 0x7B ?
-					     EEPROM_DEFAULT_TXPOWERLEVEL_5G :
-					     EEPROM_DEFAULT_TXPOWERLEVEL_2G) :
-					     rom_content[eeaddr];
-		}
-	}
-	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
-		for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
-			offset1 = group / 3;
-			offset2 = group % 3;
-			eeaddr = EEPROM_HT40_1S_TX_PWR_INX_2G + (rfpath * 3) +
-			    offset2 + offset1 * 21;
-			pwrinfo->ht40_1sindex[rfpath][group] =
-			    (rom_content[eeaddr] == 0xFF) ? (eeaddr > 0x7B ?
-					     EEPROM_DEFAULT_TXPOWERLEVEL_5G :
-					     EEPROM_DEFAULT_TXPOWERLEVEL_2G) :
-						 rom_content[eeaddr];
-		}
-	}
-	/* These just for 92D efuse offset. */
-	for (group = 0; group < CHANNEL_GROUP_MAX; group++) {
-		for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
-			int base1 = EEPROM_HT40_2S_TX_PWR_INX_DIFF_2G;
-
-			offset1 = group / 3;
-			offset2 = group % 3;
-
-			if (rom_content[base1 + offset2 + offset1 * 21] != 0xFF)
-				pwrinfo->ht40_2sindexdiff[rfpath][group] =
-				    (rom_content[base1 +
-				     offset2 + offset1 * 21] >> (rfpath * 4))
-				     & 0xF;
-			else
-				pwrinfo->ht40_2sindexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_HT40_2SDIFF;
-			if (rom_content[EEPROM_HT20_TX_PWR_INX_DIFF_2G + offset2
-			    + offset1 * 21] != 0xFF)
-				pwrinfo->ht20indexdiff[rfpath][group] =
-				    (rom_content[EEPROM_HT20_TX_PWR_INX_DIFF_2G
-				    + offset2 + offset1 * 21] >> (rfpath * 4))
-				    & 0xF;
-			else
-				pwrinfo->ht20indexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_HT20_DIFF;
-			if (rom_content[EEPROM_OFDM_TX_PWR_INX_DIFF_2G + offset2
-			    + offset1 * 21] != 0xFF)
-				pwrinfo->ofdmindexdiff[rfpath][group] =
-				    (rom_content[EEPROM_OFDM_TX_PWR_INX_DIFF_2G
-				     + offset2 + offset1 * 21] >> (rfpath * 4))
-				     & 0xF;
-			else
-				pwrinfo->ofdmindexdiff[rfpath][group] =
-				    EEPROM_DEFAULT_LEGACYHTTXPOWERDIFF;
-			if (rom_content[EEPROM_HT40_MAX_PWR_OFFSET_2G + offset2
-			    + offset1 * 21] != 0xFF)
-				pwrinfo->ht40maxoffset[rfpath][group] =
-				    (rom_content[EEPROM_HT40_MAX_PWR_OFFSET_2G
-				    + offset2 + offset1 * 21] >> (rfpath * 4))
-				    & 0xF;
-			else
-				pwrinfo->ht40maxoffset[rfpath][group] =
-				    EEPROM_DEFAULT_HT40_PWRMAXOFFSET;
-			if (rom_content[EEPROM_HT20_MAX_PWR_OFFSET_2G + offset2
-			    + offset1 * 21] != 0xFF)
-				pwrinfo->ht20maxoffset[rfpath][group] =
-				    (rom_content[EEPROM_HT20_MAX_PWR_OFFSET_2G +
-				     offset2 + offset1 * 21] >> (rfpath * 4)) &
-				     0xF;
-			else
-				pwrinfo->ht20maxoffset[rfpath][group] =
-				    EEPROM_DEFAULT_HT20_PWRMAXOFFSET;
-		}
-	}
-	if (rom_content[EEPROM_TSSI_A_5G] != 0xFF) {
-		/* 5GL */
-		pwrinfo->tssi_a[0] = rom_content[EEPROM_TSSI_A_5G] & 0x3F;
-		pwrinfo->tssi_b[0] = rom_content[EEPROM_TSSI_B_5G] & 0x3F;
-		/* 5GM */
-		pwrinfo->tssi_a[1] = rom_content[EEPROM_TSSI_AB_5G] & 0x3F;
-		pwrinfo->tssi_b[1] =
-		    (rom_content[EEPROM_TSSI_AB_5G] & 0xC0) >> 6 |
-		    (rom_content[EEPROM_TSSI_AB_5G + 1] & 0x0F) << 2;
-		/* 5GH */
-		pwrinfo->tssi_a[2] = (rom_content[EEPROM_TSSI_AB_5G + 1] &
-				      0xF0) >> 4 |
-		    (rom_content[EEPROM_TSSI_AB_5G + 2] & 0x03) << 4;
-		pwrinfo->tssi_b[2] = (rom_content[EEPROM_TSSI_AB_5G + 2] &
-				      0xFC) >> 2;
-	} else {
-		for (i = 0; i < 3; i++) {
-			pwrinfo->tssi_a[i] = EEPROM_DEFAULT_TSSI;
-			pwrinfo->tssi_b[i] = EEPROM_DEFAULT_TSSI;
-		}
-	}
-}
-
-static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
-				       bool autoload_fail, u8 *hwinfo)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct txpower_info pwrinfo;
-	u8 tempval[2], i, pwr, diff;
-	u32 ch, rfpath, group;
-
-	_rtl92de_readpowervalue_fromprom(&pwrinfo, hwinfo, autoload_fail);
-	if (!autoload_fail) {
-		/* bit0~2 */
-		rtlefuse->eeprom_regulatory = (hwinfo[EEPROM_RF_OPT1] & 0x7);
-		rtlefuse->eeprom_thermalmeter =
-			 hwinfo[EEPROM_THERMAL_METER] & 0x1f;
-		rtlefuse->crystalcap = hwinfo[EEPROM_XTAL_K];
-		tempval[0] = hwinfo[EEPROM_IQK_DELTA] & 0x03;
-		tempval[1] = (hwinfo[EEPROM_LCK_DELTA] & 0x0C) >> 2;
-		rtlefuse->txpwr_fromeprom = true;
-		if (IS_92D_D_CUT(rtlpriv->rtlhal.version) ||
-		    IS_92D_E_CUT(rtlpriv->rtlhal.version)) {
-			rtlefuse->internal_pa_5g[0] =
-				!((hwinfo[EEPROM_TSSI_A_5G] & BIT(6)) >> 6);
-			rtlefuse->internal_pa_5g[1] =
-				!((hwinfo[EEPROM_TSSI_B_5G] & BIT(6)) >> 6);
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-				"Is D cut,Internal PA0 %d Internal PA1 %d\n",
-				rtlefuse->internal_pa_5g[0],
-				rtlefuse->internal_pa_5g[1]);
-		}
-		rtlefuse->eeprom_c9 = hwinfo[EEPROM_RF_OPT6];
-		rtlefuse->eeprom_cc = hwinfo[EEPROM_RF_OPT7];
-	} else {
-		rtlefuse->eeprom_regulatory = 0;
-		rtlefuse->eeprom_thermalmeter = EEPROM_DEFAULT_THERMALMETER;
-		rtlefuse->crystalcap = EEPROM_DEFAULT_CRYSTALCAP;
-		tempval[0] = tempval[1] = 3;
-	}
-
-	/* Use default value to fill parameters if
-	 * efuse is not filled on some place. */
-
-	/* ThermalMeter from EEPROM */
-	if (rtlefuse->eeprom_thermalmeter < 0x06 ||
-	    rtlefuse->eeprom_thermalmeter > 0x1c)
-		rtlefuse->eeprom_thermalmeter = 0x12;
-	rtlefuse->thermalmeter[0] = rtlefuse->eeprom_thermalmeter;
-
-	/* check XTAL_K */
-	if (rtlefuse->crystalcap == 0xFF)
-		rtlefuse->crystalcap = 0;
-	if (rtlefuse->eeprom_regulatory > 3)
-		rtlefuse->eeprom_regulatory = 0;
-
-	for (i = 0; i < 2; i++) {
-		switch (tempval[i]) {
-		case 0:
-			tempval[i] = 5;
-			break;
-		case 1:
-			tempval[i] = 4;
-			break;
-		case 2:
-			tempval[i] = 3;
-			break;
-		case 3:
-		default:
-			tempval[i] = 0;
-			break;
-		}
-	}
-
-	rtlefuse->delta_iqk = tempval[0];
-	if (tempval[1] > 0)
-		rtlefuse->delta_lck = tempval[1] - 1;
-	if (rtlefuse->eeprom_c9 == 0xFF)
-		rtlefuse->eeprom_c9 = 0x00;
-	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
-		"EEPROMRegulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
-	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
-		"ThermalMeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
-	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
-		"CrystalCap = 0x%x\n", rtlefuse->crystalcap);
-	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
-		"Delta_IQK = 0x%x Delta_LCK = 0x%x\n",
-		rtlefuse->delta_iqk, rtlefuse->delta_lck);
-
-	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
-		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
-			group = rtl92d_get_chnlgroup_fromarray((u8) ch);
-			if (ch < CHANNEL_MAX_NUMBER_2G)
-				rtlefuse->txpwrlevel_cck[rfpath][ch] =
-				    pwrinfo.cck_index[rfpath][group];
-			rtlefuse->txpwrlevel_ht40_1s[rfpath][ch] =
-				    pwrinfo.ht40_1sindex[rfpath][group];
-			rtlefuse->txpwr_ht20diff[rfpath][ch] =
-				    pwrinfo.ht20indexdiff[rfpath][group];
-			rtlefuse->txpwr_legacyhtdiff[rfpath][ch] =
-				    pwrinfo.ofdmindexdiff[rfpath][group];
-			rtlefuse->pwrgroup_ht20[rfpath][ch] =
-				    pwrinfo.ht20maxoffset[rfpath][group];
-			rtlefuse->pwrgroup_ht40[rfpath][ch] =
-				    pwrinfo.ht40maxoffset[rfpath][group];
-			pwr = pwrinfo.ht40_1sindex[rfpath][group];
-			diff = pwrinfo.ht40_2sindexdiff[rfpath][group];
-			rtlefuse->txpwrlevel_ht40_2s[rfpath][ch] =
-				    (pwr > diff) ? (pwr - diff) : 0;
-		}
-	}
-}
-
-static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
-					       u8 *content)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 macphy_crvalue = content[EEPROM_MAC_FUNCTION];
-
-	if (macphy_crvalue & BIT(3)) {
-		rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"MacPhyMode SINGLEMAC_SINGLEPHY\n");
-	} else {
-		rtlhal->macphymode = DUALMAC_DUALPHY;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"MacPhyMode DUALMAC_DUALPHY\n");
-	}
-}
-
-static void _rtl92de_read_macphymode_and_bandtype(struct ieee80211_hw *hw,
-						  u8 *content)
-{
-	_rtl92de_read_macphymode_from_prom(hw, content);
-	rtl92d_phy_config_macphymode(hw);
-	rtl92d_phy_config_macphymode_info(hw);
-}
-
-static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	enum version_8192d chipver = rtlpriv->rtlhal.version;
-	u8 cutvalue[2];
-	u16 chipvalue;
-
-	read_efuse_byte(hw, EEPROME_CHIP_VERSION_H, &cutvalue[1]);
-	read_efuse_byte(hw, EEPROME_CHIP_VERSION_L, &cutvalue[0]);
-	chipvalue = (cutvalue[1] << 8) | cutvalue[0];
-	switch (chipvalue) {
-	case 0xAA55:
-		chipver |= CHIP_92D_C_CUT;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
-		break;
-	case 0x9966:
-		chipver |= CHIP_92D_D_CUT;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
-		break;
-	case 0xCC33:
-		chipver |= CHIP_92D_E_CUT;
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
-		break;
-	default:
-		chipver |= CHIP_92D_D_CUT;
-		pr_err("Unknown CUT!\n");
-		break;
-	}
-	rtlpriv->rtlhal.version = chipver;
-}
-
-static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	int params[] = {RTL8190_EEPROM_ID, EEPROM_VID, EEPROM_DID,
-			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR_MAC0_92D,
-			EEPROM_CHANNEL_PLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
-			COUNTRY_CODE_WORLD_WIDE_13};
-	int i;
-	u16 usvalue;
-	u8 *hwinfo;
-
-	hwinfo = kzalloc(HWSET_MAX_SIZE, GFP_KERNEL);
-	if (!hwinfo)
-		return;
-
-	if (rtl_get_hwinfo(hw, rtlpriv, HWSET_MAX_SIZE, hwinfo, params))
-		goto exit;
-
-	_rtl92de_efuse_update_chip_version(hw);
-	_rtl92de_read_macphymode_and_bandtype(hw, hwinfo);
-
-	/* Read Permanent MAC address for 2nd interface */
-	if (rtlhal->interfaceindex != 0) {
-		for (i = 0; i < 6; i += 2) {
-			usvalue = *(u16 *)&hwinfo[EEPROM_MAC_ADDR_MAC1_92D + i];
-			*((u16 *) (&rtlefuse->dev_addr[i])) = usvalue;
-		}
-	}
-	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
-				      rtlefuse->dev_addr);
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
-	_rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
-
-	/* Read Channel Plan */
-	switch (rtlhal->bandset) {
-	case BAND_ON_2_4G:
-		rtlefuse->channel_plan = COUNTRY_CODE_TELEC;
-		break;
-	case BAND_ON_5G:
-		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
-		break;
-	case BAND_ON_BOTH:
-		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
-		break;
-	default:
-		rtlefuse->channel_plan = COUNTRY_CODE_FCC;
-		break;
-	}
-	rtlefuse->txpwr_fromeprom = true;
-exit:
-	kfree(hwinfo);
-}
-
-void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 tmp_u1b;
-
-	rtlhal->version = _rtl92de_read_chip_version(hw);
-	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
-	rtlefuse->autoload_status = tmp_u1b;
-	if (tmp_u1b & BIT(4)) {
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
-		rtlefuse->epromtype = EEPROM_93C46;
-	} else {
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
-		rtlefuse->epromtype = EEPROM_BOOT_EFUSE;
-	}
-	if (tmp_u1b & BIT(5)) {
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
-
-		rtlefuse->autoload_failflag = false;
-		_rtl92de_read_adapter_info(hw);
-	} else {
-		pr_err("Autoload ERR!!\n");
-	}
-	return;
-}
-
-static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
-					  struct ieee80211_sta *sta)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u32 ratr_value;
-	u8 ratr_index = 0;
-	u8 nmode = mac->ht_enable;
-	u8 mimo_ps = IEEE80211_SMPS_OFF;
-	u16 shortgi_rate;
-	u32 tmp_ratr_value;
-	u8 curtxbw_40mhz = mac->bw_40;
-	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
-							1 : 0;
-	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
-							1 : 0;
-	enum wireless_mode wirelessmode = mac->mode;
-
-	if (rtlhal->current_bandtype == BAND_ON_5G)
-		ratr_value = sta->deflink.supp_rates[1] << 4;
-	else
-		ratr_value = sta->deflink.supp_rates[0];
-	ratr_value |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20 |
-		       sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
-	switch (wirelessmode) {
-	case WIRELESS_MODE_A:
-		ratr_value &= 0x00000FF0;
-		break;
-	case WIRELESS_MODE_B:
-		if (ratr_value & 0x0000000c)
-			ratr_value &= 0x0000000d;
-		else
-			ratr_value &= 0x0000000f;
-		break;
-	case WIRELESS_MODE_G:
-		ratr_value &= 0x00000FF5;
-		break;
-	case WIRELESS_MODE_N_24G:
-	case WIRELESS_MODE_N_5G:
-		nmode = 1;
-		if (mimo_ps == IEEE80211_SMPS_STATIC) {
-			ratr_value &= 0x0007F005;
-		} else {
-			u32 ratr_mask;
-
-			if (get_rf_type(rtlphy) == RF_1T2R ||
-			    get_rf_type(rtlphy) == RF_1T1R) {
-				ratr_mask = 0x000ff005;
-			} else {
-				ratr_mask = 0x0f0ff005;
-			}
-
-			ratr_value &= ratr_mask;
-		}
-		break;
-	default:
-		if (rtlphy->rf_type == RF_1T2R)
-			ratr_value &= 0x000ff0ff;
-		else
-			ratr_value &= 0x0f0ff0ff;
-
-		break;
-	}
-	ratr_value &= 0x0FFFFFFF;
-	if (nmode && ((curtxbw_40mhz && curshortgi_40mhz) ||
-	    (!curtxbw_40mhz && curshortgi_20mhz))) {
-		ratr_value |= 0x10000000;
-		tmp_ratr_value = (ratr_value >> 12);
-		for (shortgi_rate = 15; shortgi_rate > 0; shortgi_rate--) {
-			if ((1 << shortgi_rate) & tmp_ratr_value)
-				break;
-		}
-		shortgi_rate = (shortgi_rate << 12) | (shortgi_rate << 8) |
-		    (shortgi_rate << 4) | (shortgi_rate);
-	}
-	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
-	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
-		rtl_read_dword(rtlpriv, REG_ARFR0));
-}
-
-static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
-		struct ieee80211_sta *sta, u8 rssi_level, bool update_bw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct rtl_sta_info *sta_entry = NULL;
-	u32 ratr_bitmap;
-	u8 ratr_index;
-	u8 curtxbw_40mhz = (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40) ? 1 : 0;
-	u8 curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
-							1 : 0;
-	u8 curshortgi_20mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ?
-							1 : 0;
-	enum wireless_mode wirelessmode = 0;
-	bool shortgi = false;
-	u32 value[2];
-	u8 macid = 0;
-	u8 mimo_ps = IEEE80211_SMPS_OFF;
-
-	sta_entry = (struct rtl_sta_info *) sta->drv_priv;
-	mimo_ps = sta_entry->mimo_ps;
-	wirelessmode = sta_entry->wireless_mode;
-	if (mac->opmode == NL80211_IFTYPE_STATION)
-		curtxbw_40mhz = mac->bw_40;
-	else if (mac->opmode == NL80211_IFTYPE_AP ||
-		mac->opmode == NL80211_IFTYPE_ADHOC)
-		macid = sta->aid + 1;
-
-	if (rtlhal->current_bandtype == BAND_ON_5G)
-		ratr_bitmap = sta->deflink.supp_rates[1] << 4;
-	else
-		ratr_bitmap = sta->deflink.supp_rates[0];
-	ratr_bitmap |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20 |
-			sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
-	switch (wirelessmode) {
-	case WIRELESS_MODE_B:
-		ratr_index = RATR_INX_WIRELESS_B;
-		if (ratr_bitmap & 0x0000000c)
-			ratr_bitmap &= 0x0000000d;
-		else
-			ratr_bitmap &= 0x0000000f;
-		break;
-	case WIRELESS_MODE_G:
-		ratr_index = RATR_INX_WIRELESS_GB;
-
-		if (rssi_level == 1)
-			ratr_bitmap &= 0x00000f00;
-		else if (rssi_level == 2)
-			ratr_bitmap &= 0x00000ff0;
-		else
-			ratr_bitmap &= 0x00000ff5;
-		break;
-	case WIRELESS_MODE_A:
-		ratr_index = RATR_INX_WIRELESS_G;
-		ratr_bitmap &= 0x00000ff0;
-		break;
-	case WIRELESS_MODE_N_24G:
-	case WIRELESS_MODE_N_5G:
-		if (wirelessmode == WIRELESS_MODE_N_24G)
-			ratr_index = RATR_INX_WIRELESS_NGB;
-		else
-			ratr_index = RATR_INX_WIRELESS_NG;
-		if (mimo_ps == IEEE80211_SMPS_STATIC) {
-			if (rssi_level == 1)
-				ratr_bitmap &= 0x00070000;
-			else if (rssi_level == 2)
-				ratr_bitmap &= 0x0007f000;
-			else
-				ratr_bitmap &= 0x0007f005;
-		} else {
-			if (rtlphy->rf_type == RF_1T2R ||
-			    rtlphy->rf_type == RF_1T1R) {
-				if (curtxbw_40mhz) {
-					if (rssi_level == 1)
-						ratr_bitmap &= 0x000f0000;
-					else if (rssi_level == 2)
-						ratr_bitmap &= 0x000ff000;
-					else
-						ratr_bitmap &= 0x000ff015;
-				} else {
-					if (rssi_level == 1)
-						ratr_bitmap &= 0x000f0000;
-					else if (rssi_level == 2)
-						ratr_bitmap &= 0x000ff000;
-					else
-						ratr_bitmap &= 0x000ff005;
-				}
-			} else {
-				if (curtxbw_40mhz) {
-					if (rssi_level == 1)
-						ratr_bitmap &= 0x0f0f0000;
-					else if (rssi_level == 2)
-						ratr_bitmap &= 0x0f0ff000;
-					else
-						ratr_bitmap &= 0x0f0ff015;
-				} else {
-					if (rssi_level == 1)
-						ratr_bitmap &= 0x0f0f0000;
-					else if (rssi_level == 2)
-						ratr_bitmap &= 0x0f0ff000;
-					else
-						ratr_bitmap &= 0x0f0ff005;
-				}
-			}
-		}
-		if ((curtxbw_40mhz && curshortgi_40mhz) ||
-		    (!curtxbw_40mhz && curshortgi_20mhz)) {
-
-			if (macid == 0)
-				shortgi = true;
-			else if (macid == 1)
-				shortgi = false;
-		}
-		break;
-	default:
-		ratr_index = RATR_INX_WIRELESS_NGB;
-
-		if (rtlphy->rf_type == RF_1T2R)
-			ratr_bitmap &= 0x000ff0ff;
-		else
-			ratr_bitmap &= 0x0f0ff0ff;
-		break;
-	}
-
-	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
-	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
-	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
-		"ratr_bitmap :%x value0:%x value1:%x\n",
-		ratr_bitmap, value[0], value[1]);
-	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
-	if (macid != 0)
-		sta_entry->ratr_index = ratr_index;
-}
-
-void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
-		struct ieee80211_sta *sta, u8 rssi_level, bool update_bw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	if (rtlpriv->dm.useramask)
-		rtl92de_update_hal_rate_mask(hw, sta, rssi_level, update_bw);
-	else
-		rtl92de_update_hal_rate_table(hw, sta);
-}
-
-void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	u16 sifs_timer;
-
-	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_SLOT_TIME,
-				      &mac->slot_time);
-	if (!mac->ht_enable)
-		sifs_timer = 0x0a0a;
-	else
-		sifs_timer = 0x1010;
-	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_SIFS, (u8 *)&sifs_timer);
-}
-
-bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
-	enum rf_pwrstate e_rfpowerstate_toset;
-	u8 u1tmp;
-	bool actuallyset = false;
-	unsigned long flag;
-
-	if (rtlpci->being_init_adapter)
-		return false;
-	if (ppsc->swrf_processing)
-		return false;
-	spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
-	if (ppsc->rfchange_inprogress) {
-		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
-		return false;
-	} else {
-		ppsc->rfchange_inprogress = true;
-		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
-	}
-	rtl_write_byte(rtlpriv, REG_MAC_PINMUX_CFG, rtl_read_byte(rtlpriv,
-			  REG_MAC_PINMUX_CFG) & ~(BIT(3)));
-	u1tmp = rtl_read_byte(rtlpriv, REG_GPIO_IO_SEL);
-	e_rfpowerstate_toset = (u1tmp & BIT(3)) ? ERFON : ERFOFF;
-	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
-			"GPIOChangeRF  - HW Radio ON, RF ON\n");
-		e_rfpowerstate_toset = ERFON;
-		ppsc->hwradiooff = false;
-		actuallyset = true;
-	} else if (!ppsc->hwradiooff && (e_rfpowerstate_toset == ERFOFF)) {
-		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
-			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
-		e_rfpowerstate_toset = ERFOFF;
-		ppsc->hwradiooff = true;
-		actuallyset = true;
-	}
-	if (actuallyset) {
-		spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
-		ppsc->rfchange_inprogress = false;
-		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
-	} else {
-		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC)
-			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
-		spin_lock_irqsave(&rtlpriv->locks.rf_ps_lock, flag);
-		ppsc->rfchange_inprogress = false;
-		spin_unlock_irqrestore(&rtlpriv->locks.rf_ps_lock, flag);
-	}
-	*valid = 1;
-	return !ppsc->hwradiooff;
-}
-
-void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
-		     u8 *p_macaddr, bool is_group, u8 enc_algo,
-		     bool is_wepkey, bool clear_all)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 *macaddr = p_macaddr;
-	u32 entry_id;
-	bool is_pairwise = false;
-	static u8 cam_const_addr[4][6] = {
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x01},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x02},
-		{0x00, 0x00, 0x00, 0x00, 0x00, 0x03}
-	};
-	static u8 cam_const_broad[] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
-
-	if (clear_all) {
-		u8 idx;
-		u8 cam_offset = 0;
-		u8 clear_number = 5;
-		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
-		for (idx = 0; idx < clear_number; idx++) {
-			rtl_cam_mark_invalid(hw, cam_offset + idx);
-			rtl_cam_empty_entry(hw, cam_offset + idx);
-
-			if (idx < 5) {
-				memset(rtlpriv->sec.key_buf[idx], 0,
-				       MAX_KEY_LEN);
-				rtlpriv->sec.key_len[idx] = 0;
-			}
-		}
-	} else {
-		switch (enc_algo) {
-		case WEP40_ENCRYPTION:
-			enc_algo = CAM_WEP40;
-			break;
-		case WEP104_ENCRYPTION:
-			enc_algo = CAM_WEP104;
-			break;
-		case TKIP_ENCRYPTION:
-			enc_algo = CAM_TKIP;
-			break;
-		case AESCCMP_ENCRYPTION:
-			enc_algo = CAM_AES;
-			break;
-		default:
-			pr_err("switch case %#x not processed\n",
-			       enc_algo);
-			enc_algo = CAM_TKIP;
-			break;
-		}
-		if (is_wepkey || rtlpriv->sec.use_defaultkey) {
-			macaddr = cam_const_addr[key_index];
-			entry_id = key_index;
-		} else {
-			if (is_group) {
-				macaddr = cam_const_broad;
-				entry_id = key_index;
-			} else {
-				if (mac->opmode == NL80211_IFTYPE_AP) {
-					entry_id = rtl_cam_get_free_entry(hw,
-								 p_macaddr);
-					if (entry_id >=  TOTAL_CAM_ENTRY) {
-						pr_err("Can not find free hw security cam entry\n");
-						return;
-					}
-				} else {
-					entry_id = CAM_PAIRWISE_KEY_POSITION;
-				}
-				key_index = PAIRWISE_KEYIDX;
-				is_pairwise = true;
-			}
-		}
-		if (rtlpriv->sec.key_len[key_index] == 0) {
-			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
-				"delete one entry, entry_id is %d\n",
-				entry_id);
-			if (mac->opmode == NL80211_IFTYPE_AP)
-				rtl_cam_del_entry(hw, p_macaddr);
-			rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
-		} else {
-			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
-				"The insert KEY length is %d\n",
-				rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
-			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
-				"The insert KEY is %x %x\n",
-				rtlpriv->sec.key_buf[0][0],
-				rtlpriv->sec.key_buf[0][1]);
-			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
-				"add one entry\n");
-			if (is_pairwise) {
-				RT_PRINT_DATA(rtlpriv, COMP_SEC, DBG_LOUD,
-					      "Pairwise Key content",
-					      rtlpriv->sec.pairwise_key,
-					      rtlpriv->
-					      sec.key_len[PAIRWISE_KEYIDX]);
-				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
-					"set Pairwise key\n");
-				rtl_cam_add_one_entry(hw, macaddr, key_index,
-						      entry_id, enc_algo,
-						      CAM_CONFIG_NO_USEDK,
-						      rtlpriv->
-						      sec.key_buf[key_index]);
-			} else {
-				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
-					"set group key\n");
-				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
-					rtl_cam_add_one_entry(hw,
-						rtlefuse->dev_addr,
-						PAIRWISE_KEYIDX,
-						CAM_PAIRWISE_KEY_POSITION,
-						enc_algo, CAM_CONFIG_NO_USEDK,
-						rtlpriv->sec.key_buf[entry_id]);
-				}
-				rtl_cam_add_one_entry(hw, macaddr, key_index,
-						entry_id, enc_algo,
-						CAM_CONFIG_NO_USEDK,
-						rtlpriv->sec.key_buf
-						[entry_id]);
-			}
-		}
-	}
-}
-
 void rtl92de_suspend(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.h
index ea495216d394..bda4a1a7c91d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.h
@@ -5,7 +5,6 @@
 #define __RTL92DE_HW_H__
 
 void rtl92de_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
-void rtl92de_read_eeprom_info(struct ieee80211_hw *hw);
 void rtl92de_interrupt_recognized(struct ieee80211_hw *hw,
 				  struct rtl_int *int_vec);
 int rtl92de_hw_init(struct ieee80211_hw *hw);
@@ -14,21 +13,11 @@ void rtl92de_enable_interrupt(struct ieee80211_hw *hw);
 void rtl92de_disable_interrupt(struct ieee80211_hw *hw);
 int rtl92de_set_network_type(struct ieee80211_hw *hw, enum nl80211_iftype type);
 void rtl92de_set_check_bssid(struct ieee80211_hw *hw, bool check_bssid);
-void rtl92de_set_qos(struct ieee80211_hw *hw, int aci);
 void rtl92de_set_beacon_related_registers(struct ieee80211_hw *hw);
 void rtl92de_set_beacon_interval(struct ieee80211_hw *hw);
 void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
 				   u32 add_msr, u32 rm_msr);
 void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
-void rtl92de_update_hal_rate_tbl(struct ieee80211_hw *hw,
-				 struct ieee80211_sta *sta, u8 rssi_level,
-				 bool update_bw);
-void rtl92de_update_channel_access_setting(struct ieee80211_hw *hw);
-bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid);
-void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw);
-void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
-		     u8 *p_macaddr, bool is_group, u8 enc_algo,
-		     bool is_wepkey, bool clear_all);
 
 void rtl92de_write_dword_dbi(struct ieee80211_hw *hw, u16 offset, u32 value,
 			     u8 direct);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
index 4bd708570992..33aede56c81b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
@@ -3,7 +3,7 @@
 
 #include "../wifi.h"
 #include "../pci.h"
-#include "reg.h"
+#include "../rtl8192d/reg.h"
 #include "led.h"
 
 void rtl92de_sw_led_on(struct ieee80211_hw *hw, enum rtl_led_pin pin)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 56b5cd032a9a..d429560009bb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -5,8 +5,11 @@
 #include "../pci.h"
 #include "../ps.h"
 #include "../core.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/rf_common.h"
 #include "phy.h"
 #include "rf.h"
 #include "dm.h"
@@ -21,9 +24,6 @@
 #define RF_REG_NUM_FOR_C_CUT_2G			5
 #define RF_CHNL_NUM_5G				19
 #define RF_CHNL_NUM_5G_40M			17
-#define TARGET_CHNL_NUM_5G			221
-#define TARGET_CHNL_NUM_2G			14
-#define CV_CURVE_CNT				64
 
 static u32 rf_reg_for_5g_swchnl_normal[MAX_RF_IMR_INDEX_NORMAL] = {
 	0, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x0
@@ -160,15 +160,6 @@ static u32 targetchnl_2g[TARGET_CHNL_NUM_2G] = {
 	25711, 25658, 25606, 25554, 25502, 25451, 25328
 };
 
-static const u8 channel_all[59] = {
-	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-	36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
-	60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
-	114, 116, 118, 120, 122, 124, 126, 128,	130,
-	132, 134, 136, 138, 140, 149, 151, 153, 155,
-	157, 159, 161, 163, 165
-};
-
 u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -235,119 +226,6 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 		regaddr, bitmask, data);
 }
 
-static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
-				      enum radio_path rfpath, u32 offset)
-{
-
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
-	u32 newoffset;
-	u32 tmplong, tmplong2;
-	u8 rfpi_enable = 0;
-	u32 retvalue;
-
-	newoffset = offset;
-	tmplong = rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD);
-	if (rfpath == RF90_PATH_A)
-		tmplong2 = tmplong;
-	else
-		tmplong2 = rtl_get_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD);
-	tmplong2 = (tmplong2 & (~BLSSIREADADDRESS)) |
-		(newoffset << 23) | BLSSIREADEDGE;
-	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
-		tmplong & (~BLSSIREADEDGE));
-	udelay(10);
-	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, MASKDWORD, tmplong2);
-	udelay(50);
-	udelay(50);
-	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, MASKDWORD,
-		tmplong | BLSSIREADEDGE);
-	udelay(10);
-	if (rfpath == RF90_PATH_A)
-		rfpi_enable = (u8) rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1,
-			      BIT(8));
-	else if (rfpath == RF90_PATH_B)
-		rfpi_enable = (u8) rtl_get_bbreg(hw, RFPGA0_XB_HSSIPARAMETER1,
-			      BIT(8));
-	if (rfpi_enable)
-		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rbpi,
-			BLSSIREADBACKDATA);
-	else
-		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
-			BLSSIREADBACKDATA);
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
-		rfpath, pphyreg->rf_rb, retvalue);
-	return retvalue;
-}
-
-static void _rtl92d_phy_rf_serial_write(struct ieee80211_hw *hw,
-					enum radio_path rfpath,
-					u32 offset, u32 data)
-{
-	u32 data_and_addr;
-	u32 newoffset;
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
-
-	newoffset = offset;
-	/* T65 RF */
-	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
-	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
-		rfpath, pphyreg->rf3wire_offset, data_and_addr);
-}
-
-u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
-			    enum radio_path rfpath, u32 regaddr, u32 bitmask)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 original_value, readback_value, bitshift;
-
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
-		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		regaddr, rfpath, bitmask);
-	spin_lock(&rtlpriv->locks.rf_lock);
-	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = calculate_bit_shift(bitmask);
-	readback_value = (original_value & bitmask) >> bitshift;
-	spin_unlock(&rtlpriv->locks.rf_lock);
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
-		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		regaddr, rfpath, bitmask, original_value);
-	return readback_value;
-}
-
-void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
-	u32 regaddr, u32 bitmask, u32 data)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	u32 original_value, bitshift;
-
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
-		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		regaddr, bitmask, data, rfpath);
-	if (bitmask == 0)
-		return;
-	spin_lock(&rtlpriv->locks.rf_lock);
-	if (rtlphy->rf_mode != RF_OP_BY_FW) {
-		if (bitmask != RFREG_OFFSET_MASK) {
-			original_value = _rtl92d_phy_rf_serial_read(hw,
-				rfpath, regaddr);
-			bitshift = calculate_bit_shift(bitmask);
-			data = ((original_value & (~bitmask)) |
-				(data << bitshift));
-		}
-		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
-	}
-	spin_unlock(&rtlpriv->locks.rf_lock);
-	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
-		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		regaddr, bitmask, data, rfpath);
-}
-
 bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -374,133 +252,6 @@ bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
 	return true;
 }
 
-static void _rtl92d_phy_init_bb_rf_register_definition(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-
-	/* RF Interface Sowrtware Control */
-	/* 16 LSBs if read 32-bit from 0x870 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfintfs = RFPGA0_XAB_RFINTERFACESW;
-	/* 16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
-	rtlphy->phyreg_def[RF90_PATH_B].rfintfs = RFPGA0_XAB_RFINTERFACESW;
-	/* 16 LSBs if read 32-bit from 0x874 */
-	rtlphy->phyreg_def[RF90_PATH_C].rfintfs = RFPGA0_XCD_RFINTERFACESW;
-	/* 16 MSBs if read 32-bit from 0x874 (16-bit for 0x876) */
-
-	rtlphy->phyreg_def[RF90_PATH_D].rfintfs = RFPGA0_XCD_RFINTERFACESW;
-	/* RF Interface Readback Value */
-	/* 16 LSBs if read 32-bit from 0x8E0 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfintfi = RFPGA0_XAB_RFINTERFACERB;
-	/* 16 MSBs if read 32-bit from 0x8E0 (16-bit for 0x8E2) */
-	rtlphy->phyreg_def[RF90_PATH_B].rfintfi = RFPGA0_XAB_RFINTERFACERB;
-	/* 16 LSBs if read 32-bit from 0x8E4 */
-	rtlphy->phyreg_def[RF90_PATH_C].rfintfi = RFPGA0_XCD_RFINTERFACERB;
-	/* 16 MSBs if read 32-bit from 0x8E4 (16-bit for 0x8E6) */
-	rtlphy->phyreg_def[RF90_PATH_D].rfintfi = RFPGA0_XCD_RFINTERFACERB;
-
-	/* RF Interface Output (and Enable) */
-	/* 16 LSBs if read 32-bit from 0x860 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfintfo = RFPGA0_XA_RFINTERFACEOE;
-	/* 16 LSBs if read 32-bit from 0x864 */
-	rtlphy->phyreg_def[RF90_PATH_B].rfintfo = RFPGA0_XB_RFINTERFACEOE;
-
-	/* RF Interface (Output and)  Enable */
-	/* 16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
-	rtlphy->phyreg_def[RF90_PATH_A].rfintfe = RFPGA0_XA_RFINTERFACEOE;
-	/* 16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
-	rtlphy->phyreg_def[RF90_PATH_B].rfintfe = RFPGA0_XB_RFINTERFACEOE;
-
-	/* Addr of LSSI. Wirte RF register by driver */
-	/* LSSI Parameter */
-	rtlphy->phyreg_def[RF90_PATH_A].rf3wire_offset =
-				 RFPGA0_XA_LSSIPARAMETER;
-	rtlphy->phyreg_def[RF90_PATH_B].rf3wire_offset =
-				 RFPGA0_XB_LSSIPARAMETER;
-
-	/* RF parameter */
-	/* BB Band Select */
-	rtlphy->phyreg_def[RF90_PATH_A].rflssi_select = RFPGA0_XAB_RFPARAMETER;
-	rtlphy->phyreg_def[RF90_PATH_B].rflssi_select = RFPGA0_XAB_RFPARAMETER;
-	rtlphy->phyreg_def[RF90_PATH_C].rflssi_select = RFPGA0_XCD_RFPARAMETER;
-	rtlphy->phyreg_def[RF90_PATH_D].rflssi_select = RFPGA0_XCD_RFPARAMETER;
-
-	/* Tx AGC Gain Stage (same for all path. Should we remove this?) */
-	/* Tx gain stage */
-	rtlphy->phyreg_def[RF90_PATH_A].rftxgain_stage = RFPGA0_TXGAINSTAGE;
-	/* Tx gain stage */
-	rtlphy->phyreg_def[RF90_PATH_B].rftxgain_stage = RFPGA0_TXGAINSTAGE;
-	/* Tx gain stage */
-	rtlphy->phyreg_def[RF90_PATH_C].rftxgain_stage = RFPGA0_TXGAINSTAGE;
-	/* Tx gain stage */
-	rtlphy->phyreg_def[RF90_PATH_D].rftxgain_stage = RFPGA0_TXGAINSTAGE;
-
-	/* Tranceiver A~D HSSI Parameter-1 */
-	/* wire control parameter1 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfhssi_para1 = RFPGA0_XA_HSSIPARAMETER1;
-	/* wire control parameter1 */
-	rtlphy->phyreg_def[RF90_PATH_B].rfhssi_para1 = RFPGA0_XB_HSSIPARAMETER1;
-
-	/* Tranceiver A~D HSSI Parameter-2 */
-	/* wire control parameter2 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfhssi_para2 = RFPGA0_XA_HSSIPARAMETER2;
-	/* wire control parameter2 */
-	rtlphy->phyreg_def[RF90_PATH_B].rfhssi_para2 = RFPGA0_XB_HSSIPARAMETER2;
-
-	/* RF switch Control */
-	/* TR/Ant switch control */
-	rtlphy->phyreg_def[RF90_PATH_A].rfsw_ctrl = RFPGA0_XAB_SWITCHCONTROL;
-	rtlphy->phyreg_def[RF90_PATH_B].rfsw_ctrl = RFPGA0_XAB_SWITCHCONTROL;
-	rtlphy->phyreg_def[RF90_PATH_C].rfsw_ctrl = RFPGA0_XCD_SWITCHCONTROL;
-	rtlphy->phyreg_def[RF90_PATH_D].rfsw_ctrl = RFPGA0_XCD_SWITCHCONTROL;
-
-	/* AGC control 1 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfagc_control1 = ROFDM0_XAAGCCORE1;
-	rtlphy->phyreg_def[RF90_PATH_B].rfagc_control1 = ROFDM0_XBAGCCORE1;
-	rtlphy->phyreg_def[RF90_PATH_C].rfagc_control1 = ROFDM0_XCAGCCORE1;
-	rtlphy->phyreg_def[RF90_PATH_D].rfagc_control1 = ROFDM0_XDAGCCORE1;
-
-	/* AGC control 2  */
-	rtlphy->phyreg_def[RF90_PATH_A].rfagc_control2 = ROFDM0_XAAGCCORE2;
-	rtlphy->phyreg_def[RF90_PATH_B].rfagc_control2 = ROFDM0_XBAGCCORE2;
-	rtlphy->phyreg_def[RF90_PATH_C].rfagc_control2 = ROFDM0_XCAGCCORE2;
-	rtlphy->phyreg_def[RF90_PATH_D].rfagc_control2 = ROFDM0_XDAGCCORE2;
-
-	/* RX AFE control 1 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfrxiq_imbal = ROFDM0_XARXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_B].rfrxiq_imbal = ROFDM0_XBRXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_C].rfrxiq_imbal = ROFDM0_XCRXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_D].rfrxiq_imbal = ROFDM0_XDRXIQIMBALANCE;
-
-	/*RX AFE control 1 */
-	rtlphy->phyreg_def[RF90_PATH_A].rfrx_afe = ROFDM0_XARXAFE;
-	rtlphy->phyreg_def[RF90_PATH_B].rfrx_afe = ROFDM0_XBRXAFE;
-	rtlphy->phyreg_def[RF90_PATH_C].rfrx_afe = ROFDM0_XCRXAFE;
-	rtlphy->phyreg_def[RF90_PATH_D].rfrx_afe = ROFDM0_XDRXAFE;
-
-	/* Tx AFE control 1 */
-	rtlphy->phyreg_def[RF90_PATH_A].rftxiq_imbal = ROFDM0_XATXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_B].rftxiq_imbal = ROFDM0_XBTXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_C].rftxiq_imbal = ROFDM0_XCTXIQIMBALANCE;
-	rtlphy->phyreg_def[RF90_PATH_D].rftxiq_imbal = ROFDM0_XDTXIQIMBALANCE;
-
-	/* Tx AFE control 2 */
-	rtlphy->phyreg_def[RF90_PATH_A].rftx_afe = ROFDM0_XATXAFE;
-	rtlphy->phyreg_def[RF90_PATH_B].rftx_afe = ROFDM0_XBTXAFE;
-	rtlphy->phyreg_def[RF90_PATH_C].rftx_afe = ROFDM0_XCTXAFE;
-	rtlphy->phyreg_def[RF90_PATH_D].rftx_afe = ROFDM0_XDTXAFE;
-
-	/* Tranceiver LSSI Readback SI mode */
-	rtlphy->phyreg_def[RF90_PATH_A].rf_rb = RFPGA0_XA_LSSIREADBACK;
-	rtlphy->phyreg_def[RF90_PATH_B].rf_rb = RFPGA0_XB_LSSIREADBACK;
-	rtlphy->phyreg_def[RF90_PATH_C].rf_rb = RFPGA0_XC_LSSIREADBACK;
-	rtlphy->phyreg_def[RF90_PATH_D].rf_rb = RFPGA0_XD_LSSIREADBACK;
-
-	/* Tranceiver LSSI Readback PI mode */
-	rtlphy->phyreg_def[RF90_PATH_A].rf_rbpi = TRANSCEIVERA_HSPI_READBACK;
-	rtlphy->phyreg_def[RF90_PATH_B].rf_rbpi = TRANSCEIVERB_HSPI_READBACK;
-}
-
 static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 	u8 configtype)
 {
@@ -601,58 +352,6 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 	return true;
 }
 
-static void _rtl92d_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
-						   u32 regaddr, u32 bitmask,
-						   u32 data)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	int index;
-
-	if (regaddr == RTXAGC_A_RATE18_06)
-		index = 0;
-	else if (regaddr == RTXAGC_A_RATE54_24)
-		index = 1;
-	else if (regaddr == RTXAGC_A_CCK1_MCS32)
-		index = 6;
-	else if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00)
-		index = 7;
-	else if (regaddr == RTXAGC_A_MCS03_MCS00)
-		index = 2;
-	else if (regaddr == RTXAGC_A_MCS07_MCS04)
-		index = 3;
-	else if (regaddr == RTXAGC_A_MCS11_MCS08)
-		index = 4;
-	else if (regaddr == RTXAGC_A_MCS15_MCS12)
-		index = 5;
-	else if (regaddr == RTXAGC_B_RATE18_06)
-		index = 8;
-	else if (regaddr == RTXAGC_B_RATE54_24)
-		index = 9;
-	else if (regaddr == RTXAGC_B_CCK1_55_MCS32)
-		index = 14;
-	else if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff)
-		index = 15;
-	else if (regaddr == RTXAGC_B_MCS03_MCS00)
-		index = 10;
-	else if (regaddr == RTXAGC_B_MCS07_MCS04)
-		index = 11;
-	else if (regaddr == RTXAGC_B_MCS11_MCS08)
-		index = 12;
-	else if (regaddr == RTXAGC_B_MCS15_MCS12)
-		index = 13;
-	else
-		return;
-
-	rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index] = data;
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
-		"MCSTxPowerLevelOriginalOffset[%d][%d] = 0x%x\n",
-		rtlphy->pwrgroup_cnt, index,
-		rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index]);
-	if (index == 13)
-		rtlphy->pwrgroup_cnt++;
-}
-
 static bool _rtl92d_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 	u8 configtype)
 {
@@ -666,7 +365,7 @@ static bool _rtl92d_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 	if (configtype == BASEBAND_CONFIG_PHY_REG) {
 		for (i = 0; i < phy_regarray_pg_len; i = i + 3) {
 			rtl_addr_delay(phy_regarray_table_pg[i]);
-			_rtl92d_store_pwrindex_diffrate_offset(hw,
+			rtl92d_store_pwrindex_diffrate_offset(hw,
 				phy_regarray_table_pg[i],
 				phy_regarray_table_pg[i + 1],
 				phy_regarray_table_pg[i + 2]);
@@ -726,7 +425,7 @@ bool rtl92d_phy_bb_config(struct ieee80211_hw *hw)
 	u32 regvaldw;
 	u8 value;
 
-	_rtl92d_phy_init_bb_rf_register_definition(hw);
+	rtl92d_phy_init_bb_rf_register_definition(hw);
 	regval = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN);
 	rtl_write_word(rtlpriv, REG_SYS_FUNC_EN,
 		       regval | BIT(13) | BIT(0) | BIT(1));
@@ -812,115 +511,6 @@ bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 	return true;
 }
 
-void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-
-	rtlphy->default_initialgain[0] =
-	    (u8) rtl_get_bbreg(hw, ROFDM0_XAAGCCORE1, MASKBYTE0);
-	rtlphy->default_initialgain[1] =
-	    (u8) rtl_get_bbreg(hw, ROFDM0_XBAGCCORE1, MASKBYTE0);
-	rtlphy->default_initialgain[2] =
-	    (u8) rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
-	rtlphy->default_initialgain[3] =
-	    (u8) rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
-		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
-		rtlphy->default_initialgain[0],
-		rtlphy->default_initialgain[1],
-		rtlphy->default_initialgain[2],
-		rtlphy->default_initialgain[3]);
-	rtlphy->framesync = (u8)rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3,
-					      MASKBYTE0);
-	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
-					      MASKDWORD);
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
-		"Default framesync (0x%x) = 0x%x\n",
-		ROFDM0_RXDETECTOR3, rtlphy->framesync);
-}
-
-static void _rtl92d_get_txpower_index(struct ieee80211_hw *hw, u8 channel,
-	u8 *cckpowerlevel, u8 *ofdmpowerlevel)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_hal *rtlhal = &(rtlpriv->rtlhal);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 index = (channel - 1);
-
-	/* 1. CCK */
-	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		/* RF-A */
-		cckpowerlevel[RF90_PATH_A] =
-				 rtlefuse->txpwrlevel_cck[RF90_PATH_A][index];
-		/* RF-B */
-		cckpowerlevel[RF90_PATH_B] =
-				 rtlefuse->txpwrlevel_cck[RF90_PATH_B][index];
-	} else {
-		cckpowerlevel[RF90_PATH_A] = 0;
-		cckpowerlevel[RF90_PATH_B] = 0;
-	}
-	/* 2. OFDM for 1S or 2S */
-	if (rtlphy->rf_type == RF_1T2R || rtlphy->rf_type == RF_1T1R) {
-		/*  Read HT 40 OFDM TX power */
-		ofdmpowerlevel[RF90_PATH_A] =
-		    rtlefuse->txpwrlevel_ht40_1s[RF90_PATH_A][index];
-		ofdmpowerlevel[RF90_PATH_B] =
-		    rtlefuse->txpwrlevel_ht40_1s[RF90_PATH_B][index];
-	} else if (rtlphy->rf_type == RF_2T2R) {
-		/* Read HT 40 OFDM TX power */
-		ofdmpowerlevel[RF90_PATH_A] =
-		    rtlefuse->txpwrlevel_ht40_2s[RF90_PATH_A][index];
-		ofdmpowerlevel[RF90_PATH_B] =
-		    rtlefuse->txpwrlevel_ht40_2s[RF90_PATH_B][index];
-	}
-}
-
-static void _rtl92d_ccxpower_index_check(struct ieee80211_hw *hw,
-	u8 channel, u8 *cckpowerlevel, u8 *ofdmpowerlevel)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-
-	rtlphy->cur_cck_txpwridx = cckpowerlevel[0];
-	rtlphy->cur_ofdm24g_txpwridx = ofdmpowerlevel[0];
-}
-
-static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
-{
-	u8 place = chnl;
-
-	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
-			if (channel_all[place] == chnl) {
-				place++;
-				break;
-			}
-		}
-	}
-	return place;
-}
-
-void rtl92d_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel)
-{
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 cckpowerlevel[2], ofdmpowerlevel[2];
-
-	if (!rtlefuse->txpwr_fromeprom)
-		return;
-	channel = _rtl92c_phy_get_rightchnlplace(channel);
-	_rtl92d_get_txpower_index(hw, channel, &cckpowerlevel[0],
-		&ofdmpowerlevel[0]);
-	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G)
-		_rtl92d_ccxpower_index_check(hw, channel, &cckpowerlevel[0],
-				&ofdmpowerlevel[0]);
-	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G)
-		rtl92d_phy_rf6052_set_cck_txpower(hw, &cckpowerlevel[0]);
-	rtl92d_phy_rf6052_set_ofdm_txpower(hw, &ofdmpowerlevel[0], channel);
-}
-
 void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 			    enum nl80211_channel_type ch_type)
 {
@@ -1122,65 +712,6 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
-static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
-	u8 rfpath, u32 *pu4_regval)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
-
-	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
-	/*----Store original RFENV control type----*/
-	switch (rfpath) {
-	case RF90_PATH_A:
-	case RF90_PATH_C:
-		*pu4_regval = rtl_get_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV);
-		break;
-	case RF90_PATH_B:
-	case RF90_PATH_D:
-		*pu4_regval =
-		    rtl_get_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16);
-		break;
-	}
-	/*----Set RF_ENV enable----*/
-	rtl_set_bbreg(hw, pphyreg->rfintfe, BRFSI_RFENV << 16, 0x1);
-	udelay(1);
-	/*----Set RF_ENV output high----*/
-	rtl_set_bbreg(hw, pphyreg->rfintfo, BRFSI_RFENV, 0x1);
-	udelay(1);
-	/* Set bit number of Address and Data for RF register */
-	/* Set 1 to 4 bits for 8255 */
-	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREADDRESSLENGTH, 0x0);
-	udelay(1);
-	/*Set 0 to 12 bits for 8255 */
-	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
-	udelay(1);
-	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
-}
-
-static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
-				       u32 *pu4_regval)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
-
-	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
-	/*----Restore RFENV control type----*/
-	switch (rfpath) {
-	case RF90_PATH_A:
-	case RF90_PATH_C:
-		rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV, *pu4_regval);
-		break;
-	case RF90_PATH_B:
-	case RF90_PATH_D:
-		rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16,
-			      *pu4_regval);
-		break;
-	}
-	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
-}
-
 static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -1221,8 +752,8 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 			rtlhal->during_mac1init_radioa = true;
 			/* asume no this case */
 			if (need_pwr_down)
-				_rtl92d_phy_enable_rf_env(hw, path,
-							  &u4regvalue);
+				rtl92d_phy_enable_rf_env(hw, path,
+							 &u4regvalue);
 		}
 		for (i = 0; i < RF_REG_NUM_FOR_C_CUT_5G; i++) {
 			if (i == 0 && (rtlhal->macphymode == DUALMAC_DUALPHY)) {
@@ -1253,7 +784,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 					      RFREG_OFFSET_MASK));
 		}
 		if (need_pwr_down)
-			_rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+			rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
 		if (rtlhal->during_mac1init_radioa)
 			rtl92d_phy_powerdown_anotherphy(hw, false);
 		if (channel < 149)
@@ -1313,8 +844,8 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 				rtlhal->during_mac0init_radiob = true;
 
 				if (need_pwr_down)
-					_rtl92d_phy_enable_rf_env(hw, path,
-								  &u4regvalue);
+					rtl92d_phy_enable_rf_env(hw, path,
+								 &u4regvalue);
 			}
 		}
 		for (i = 0; i < RF_REG_NUM_FOR_C_CUT_2G; i++) {
@@ -1347,31 +878,13 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 			      RFREG_OFFSET_MASK,
 			      rf_syn_g4_for_c_cut_2g | (u4tmp << 11));
 		if (need_pwr_down)
-			_rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+			rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
 		if (rtlhal->during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
 	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
-u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
-{
-	u8 place;
-
-	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
-			if (channel_all[place] == chnl)
-				return place - 13;
-		}
-	}
-
-	return 0;
-}
-
-#define MAX_TOLERANCE		5
-#define IQK_DELAY_TIME		1	/* ms */
-#define MAX_TOLERANCE_92D	3
-
 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
 static u8 _rtl92d_phy_patha_iqk(struct ieee80211_hw *hw, bool configpathb)
 {
@@ -1636,30 +1149,6 @@ static u8 _rtl92d_phy_pathb_iqk_5g_normal(struct ieee80211_hw *hw)
 	return result;
 }
 
-static void _rtl92d_phy_save_adda_registers(struct ieee80211_hw *hw,
-					    u32 *adda_reg, u32 *adda_backup,
-					    u32 regnum)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 i;
-
-	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Save ADDA parameters.\n");
-	for (i = 0; i < regnum; i++)
-		adda_backup[i] = rtl_get_bbreg(hw, adda_reg[i], MASKDWORD);
-}
-
-static void _rtl92d_phy_save_mac_registers(struct ieee80211_hw *hw,
-	u32 *macreg, u32 *macbackup)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 i;
-
-	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Save MAC parameters.\n");
-	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
-		macbackup[i] = rtl_read_byte(rtlpriv, macreg[i]);
-	macbackup[i] = rtl_read_dword(rtlpriv, macreg[i]);
-}
-
 static void _rtl92d_phy_reload_adda_registers(struct ieee80211_hw *hw,
 					      u32 *adda_reg, u32 *adda_backup,
 					      u32 regnum)
@@ -1685,37 +1174,6 @@ static void _rtl92d_phy_reload_mac_registers(struct ieee80211_hw *hw,
 	rtl_write_byte(rtlpriv, macreg[i], macbackup[i]);
 }
 
-static void _rtl92d_phy_path_adda_on(struct ieee80211_hw *hw,
-		u32 *adda_reg, bool patha_on, bool is2t)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 pathon;
-	u32 i;
-
-	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "ADDA ON.\n");
-	pathon = patha_on ? 0x04db25a4 : 0x0b1b25a4;
-	if (patha_on)
-		pathon = rtlpriv->rtlhal.interfaceindex == 0 ?
-		    0x04db25a4 : 0x0b1b25a4;
-	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
-		rtl_set_bbreg(hw, adda_reg[i], MASKDWORD, pathon);
-}
-
-static void _rtl92d_phy_mac_setting_calibration(struct ieee80211_hw *hw,
-						u32 *macreg, u32 *macbackup)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 i;
-
-	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "MAC settings for Calibration.\n");
-	rtl_write_byte(rtlpriv, macreg[0], 0x3F);
-
-	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++)
-		rtl_write_byte(rtlpriv, macreg[i], (u8)(macbackup[i] &
-			       (~BIT(3))));
-	rtl_write_byte(rtlpriv, macreg[i], (u8) (macbackup[i] & (~BIT(5))));
-}
-
 static void _rtl92d_phy_patha_standby(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -1772,14 +1230,16 @@ static void _rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw, long result[][8],
 			is2t ? "2T2R" : "1T1R");
 
 		/*  Save ADDA parameters, turn Path A ADDA on */
-		_rtl92d_phy_save_adda_registers(hw, adda_reg,
-			rtlphy->adda_backup, IQK_ADDA_REG_NUM);
-		_rtl92d_phy_save_mac_registers(hw, iqk_mac_reg,
-			rtlphy->iqk_mac_backup);
-		_rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
-			rtlphy->iqk_bb_backup, IQK_BB_REG_NUM);
-	}
-	_rtl92d_phy_path_adda_on(hw, adda_reg, true, is2t);
+		rtl92d_phy_save_adda_registers(hw, adda_reg,
+					       rtlphy->adda_backup,
+					       IQK_ADDA_REG_NUM);
+		rtl92d_phy_save_mac_registers(hw, iqk_mac_reg,
+					      rtlphy->iqk_mac_backup);
+		rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
+					       rtlphy->iqk_bb_backup,
+					       IQK_BB_REG_NUM);
+	}
+	rtl92d_phy_path_adda_on(hw, adda_reg, true, is2t);
 	if (t == 0)
 		rtlphy->rfpi_enable = (u8) rtl_get_bbreg(hw,
 				RFPGA0_XA_HSSIPARAMETER1, BIT(8));
@@ -1800,8 +1260,8 @@ static void _rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw, long result[][8],
 			      0x00010000);
 	}
 	/* MAC settings */
-	_rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
-					    rtlphy->iqk_mac_backup);
+	rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
+					   rtlphy->iqk_mac_backup);
 	/* Page B init */
 	rtl_set_bbreg(hw, 0xb68, MASKDWORD, 0x0f600000);
 	if (is2t)
@@ -1841,7 +1301,7 @@ static void _rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw, long result[][8],
 	if (is2t) {
 		_rtl92d_phy_patha_standby(hw);
 		/* Turn Path B ADDA on */
-		_rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
+		rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
 		for (i = 0; i < retrycount; i++) {
 			pathb_ok = _rtl92d_phy_pathb_iqk(hw);
 			if (pathb_ok == 0x03) {
@@ -1938,24 +1398,24 @@ static void _rtl92d_phy_iq_calibrate_5g_normal(struct ieee80211_hw *hw,
 		RTPRINT(rtlpriv, FINIT, INIT_IQK, "IQ Calibration for %s\n",
 			is2t ? "2T2R" : "1T1R");
 		/* Save ADDA parameters, turn Path A ADDA on */
-		_rtl92d_phy_save_adda_registers(hw, adda_reg,
-						rtlphy->adda_backup,
-						IQK_ADDA_REG_NUM);
-		_rtl92d_phy_save_mac_registers(hw, iqk_mac_reg,
-					       rtlphy->iqk_mac_backup);
+		rtl92d_phy_save_adda_registers(hw, adda_reg,
+					       rtlphy->adda_backup,
+					       IQK_ADDA_REG_NUM);
+		rtl92d_phy_save_mac_registers(hw, iqk_mac_reg,
+					      rtlphy->iqk_mac_backup);
 		if (is2t)
-			_rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
-							rtlphy->iqk_bb_backup,
-							IQK_BB_REG_NUM);
+			rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
+						       rtlphy->iqk_bb_backup,
+						       IQK_BB_REG_NUM);
 		else
-			_rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
-							rtlphy->iqk_bb_backup,
-							IQK_BB_REG_NUM - 1);
+			rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
+						       rtlphy->iqk_bb_backup,
+						       IQK_BB_REG_NUM - 1);
 	}
-	_rtl92d_phy_path_adda_on(hw, adda_reg, true, is2t);
+	rtl92d_phy_path_adda_on(hw, adda_reg, true, is2t);
 	/* MAC settings */
-	_rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
-			rtlphy->iqk_mac_backup);
+	rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
+					   rtlphy->iqk_mac_backup);
 	if (t == 0)
 		rtlphy->rfpi_enable = (u8) rtl_get_bbreg(hw,
 			RFPGA0_XA_HSSIPARAMETER1, BIT(8));
@@ -2002,7 +1462,7 @@ static void _rtl92d_phy_iq_calibrate_5g_normal(struct ieee80211_hw *hw,
 	if (is2t) {
 		/* _rtl92d_phy_patha_standby(hw); */
 		/* Turn Path B ADDA on  */
-		_rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
+		rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
 		pathb_ok = _rtl92d_phy_pathb_iqk_5g_normal(hw);
 		if (pathb_ok == 0x03) {
 			RTPRINT(rtlpriv, FINIT, INIT_IQK,
@@ -2401,56 +1861,6 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
-static u32 _rtl92d_phy_get_abs(u32 val1, u32 val2)
-{
-	u32 ret;
-
-	if (val1 >= val2)
-		ret = val1 - val2;
-	else
-		ret = val2 - val1;
-	return ret;
-}
-
-static bool _rtl92d_is_legal_5g_channel(struct ieee80211_hw *hw, u8 channel)
-{
-
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(channel5g); i++)
-		if (channel == channel5g[i])
-			return true;
-	return false;
-}
-
-static void _rtl92d_phy_calc_curvindex(struct ieee80211_hw *hw,
-				       u32 *targetchnl, u32 * curvecount_val,
-				       bool is5g, u32 *curveindex)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 smallest_abs_val = 0xffffffff, u4tmp;
-	u8 i, j;
-	u8 chnl_num = is5g ? TARGET_CHNL_NUM_5G : TARGET_CHNL_NUM_2G;
-
-	for (i = 0; i < chnl_num; i++) {
-		if (is5g && !_rtl92d_is_legal_5g_channel(hw, i + 1))
-			continue;
-		curveindex[i] = 0;
-		for (j = 0; j < (CV_CURVE_CNT * 2); j++) {
-			u4tmp = _rtl92d_phy_get_abs(targetchnl[i],
-				curvecount_val[j]);
-
-			if (u4tmp < smallest_abs_val) {
-				curveindex[i] = j;
-				smallest_abs_val = u4tmp;
-			}
-		}
-		smallest_abs_val = 0xffffffff;
-		RTPRINT(rtlpriv, FINIT, INIT_IQK, "curveindex[%d] = %x\n",
-			i, curveindex[i]);
-	}
-}
-
 static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 		u8 channel)
 {
@@ -2477,12 +1887,12 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 			rtlpriv->rtlhal.during_mac1init_radioa = true;
 			/* asume no this case */
 			if (bneed_powerdown_radio)
-				_rtl92d_phy_enable_rf_env(hw, erfpath,
-							  &u4regvalue);
+				rtl92d_phy_enable_rf_env(hw, erfpath,
+							 &u4regvalue);
 		}
 		rtl_set_rfreg(hw, erfpath, RF_SYN_G4, 0x3f800, u4tmp);
 		if (bneed_powerdown_radio)
-			_rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
+			rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
 		if (rtlpriv->rtlhal.during_mac1init_radioa)
 			rtl92d_phy_powerdown_anotherphy(hw, false);
 	} else if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G) {
@@ -2495,15 +1905,15 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 				rtl92d_phy_enable_anotherphy(hw, true);
 			rtlpriv->rtlhal.during_mac0init_radiob = true;
 			if (bneed_powerdown_radio)
-				_rtl92d_phy_enable_rf_env(hw, erfpath,
-							  &u4regvalue);
+				rtl92d_phy_enable_rf_env(hw, erfpath,
+							 &u4regvalue);
 		}
 		rtl_set_rfreg(hw, erfpath, RF_SYN_G4, 0x3f800, u4tmp);
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n",
 			rtl_get_rfreg(hw,  erfpath, RF_SYN_G4, 0x3f800));
 		if (bneed_powerdown_radio)
-			_rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
+			rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
 		if (rtlpriv->rtlhal.during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
@@ -2588,13 +1998,13 @@ static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
 						 readval2);
 		}
 		if (index == 0 && rtlhal->interfaceindex == 0)
-			_rtl92d_phy_calc_curvindex(hw, targetchnl_5g,
-						   curvecount_val,
-						   true, curveindex_5g);
+			rtl92d_phy_calc_curvindex(hw, targetchnl_5g,
+						  curvecount_val,
+						  true, curveindex_5g);
 		else
-			_rtl92d_phy_calc_curvindex(hw, targetchnl_2g,
-						   curvecount_val,
-						   false, curveindex_2g);
+			rtl92d_phy_calc_curvindex(hw, targetchnl_2g,
+						  curvecount_val,
+						  false, curveindex_2g);
 		/* switch CV-curve control mode */
 		rtl_set_rfreg(hw, (enum radio_path)index, RF_SYN_G7,
 			      BIT(17), 0x1);
@@ -2622,7 +2032,7 @@ static void _rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	_rtl92d_phy_lc_calibrate_sw(hw, is2t);
 }
 
-void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw)
+void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
@@ -2638,12 +2048,9 @@ void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw)
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,
 		"LCK:Start!!! currentband %x delay %d ms\n",
 		rtlhal->current_bandtype, timecount);
-	if (IS_92D_SINGLEPHY(rtlhal->version)) {
-		_rtl92d_phy_lc_calibrate(hw, true);
-	} else {
-		/* For 1T1R */
-		_rtl92d_phy_lc_calibrate(hw, false);
-	}
+
+	_rtl92d_phy_lc_calibrate(hw, is2t);
+
 	rtlphy->lck_inprogress = false;
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LCK:Finish!!!\n");
 }
@@ -2674,30 +2081,6 @@ static bool _rtl92d_phy_set_sw_chnl_cmdarray(struct swchnlcmd *cmdtable,
 	return true;
 }
 
-void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	u8 i;
-
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"settings regs %zu default regs %d\n",
-		ARRAY_SIZE(rtlphy->iqk_matrix),
-		IQK_MATRIX_REG_NUM);
-	/* 0xe94, 0xe9c, 0xea4, 0xeac, 0xeb4, 0xebc, 0xec4, 0xecc */
-	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
-		rtlphy->iqk_matrix[i].value[0][0] = 0x100;
-		rtlphy->iqk_matrix[i].value[0][2] = 0x100;
-		rtlphy->iqk_matrix[i].value[0][4] = 0x100;
-		rtlphy->iqk_matrix[i].value[0][6] = 0x100;
-		rtlphy->iqk_matrix[i].value[0][1] = 0x0;
-		rtlphy->iqk_matrix[i].value[0][3] = 0x0;
-		rtlphy->iqk_matrix[i].value[0][5] = 0x0;
-		rtlphy->iqk_matrix[i].value[0][7] = 0x0;
-		rtlphy->iqk_matrix[i].iqk_done = false;
-	}
-}
-
 static bool _rtl92d_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 					     u8 channel, u8 *stage, u8 *step,
 					     u32 *delay)
@@ -2891,74 +2274,6 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 	return 1;
 }
 
-static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
-		"--->Cmd(%#x), set_io_inprogress(%d)\n",
-		rtlphy->current_io_type, rtlphy->set_io_inprogress);
-	switch (rtlphy->current_io_type) {
-	case IO_CMD_RESUME_DM_BY_SCAN:
-		de_digtable->cur_igvalue = rtlphy->initgain_backup.xaagccore1;
-		rtl92d_dm_write_dig(hw);
-		rtl92d_phy_set_txpower_level(hw, rtlphy->current_channel);
-		break;
-	case IO_CMD_PAUSE_DM_BY_SCAN:
-		rtlphy->initgain_backup.xaagccore1 = de_digtable->cur_igvalue;
-		de_digtable->cur_igvalue = 0x37;
-		rtl92d_dm_write_dig(hw);
-		break;
-	default:
-		pr_err("switch case %#x not processed\n",
-		       rtlphy->current_io_type);
-		break;
-	}
-	rtlphy->set_io_inprogress = false;
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
-		rtlphy->current_io_type);
-}
-
-bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	bool postprocessing = false;
-
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
-		"-->IO Cmd(%#x), set_io_inprogress(%d)\n",
-		 iotype, rtlphy->set_io_inprogress);
-	do {
-		switch (iotype) {
-		case IO_CMD_RESUME_DM_BY_SCAN:
-			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
-				"[IO CMD] Resume DM after scan\n");
-			postprocessing = true;
-			break;
-		case IO_CMD_PAUSE_DM_BY_SCAN:
-			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
-				"[IO CMD] Pause DM before scan\n");
-			postprocessing = true;
-			break;
-		default:
-			pr_err("switch case %#x not processed\n",
-			       iotype);
-			break;
-		}
-	} while (false);
-	if (postprocessing && !rtlphy->set_io_inprogress) {
-		rtlphy->set_io_inprogress = true;
-		rtlphy->current_io_type = iotype;
-	} else {
-		return false;
-	}
-	rtl92d_phy_set_io(hw);
-	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
-	return true;
-}
-
 static void _rtl92d_phy_set_rfon(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -3141,100 +2456,6 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 	return bresult;
 }
 
-void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 offset = REG_MAC_PHY_CTRL_NORMAL;
-
-	switch (rtlhal->macphymode) {
-	case DUALMAC_DUALPHY:
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"MacPhyMode: DUALMAC_DUALPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF3);
-		break;
-	case SINGLEMAC_SINGLEPHY:
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"MacPhyMode: SINGLEMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF4);
-		break;
-	case DUALMAC_SINGLEPHY:
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"MacPhyMode: DUALMAC_SINGLEPHY\n");
-		rtl_write_byte(rtlpriv, offset, 0xF1);
-		break;
-	}
-}
-
-void rtl92d_phy_config_macphymode_info(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-
-	switch (rtlhal->macphymode) {
-	case DUALMAC_SINGLEPHY:
-		rtlphy->rf_type = RF_2T2R;
-		rtlhal->version |= RF_TYPE_2T2R;
-		rtlhal->bandset = BAND_ON_BOTH;
-		rtlhal->current_bandtype = BAND_ON_2_4G;
-		break;
-
-	case SINGLEMAC_SINGLEPHY:
-		rtlphy->rf_type = RF_2T2R;
-		rtlhal->version |= RF_TYPE_2T2R;
-		rtlhal->bandset = BAND_ON_BOTH;
-		rtlhal->current_bandtype = BAND_ON_2_4G;
-		break;
-
-	case DUALMAC_DUALPHY:
-		rtlphy->rf_type = RF_1T1R;
-		rtlhal->version &= RF_TYPE_1T1R;
-		/* Now we let MAC0 run on 5G band. */
-		if (rtlhal->interfaceindex == 0) {
-			rtlhal->bandset = BAND_ON_5G;
-			rtlhal->current_bandtype = BAND_ON_5G;
-		} else {
-			rtlhal->bandset = BAND_ON_2_4G;
-			rtlhal->current_bandtype = BAND_ON_2_4G;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
-u8 rtl92d_get_chnlgroup_fromarray(u8 chnl)
-{
-	u8 group;
-
-	if (channel_all[chnl] <= 3)
-		group = 0;
-	else if (channel_all[chnl] <= 9)
-		group = 1;
-	else if (channel_all[chnl] <= 14)
-		group = 2;
-	else if (channel_all[chnl] <= 44)
-		group = 3;
-	else if (channel_all[chnl] <= 54)
-		group = 4;
-	else if (channel_all[chnl] <= 64)
-		group = 5;
-	else if (channel_all[chnl] <= 112)
-		group = 6;
-	else if (channel_all[chnl] <= 126)
-		group = 7;
-	else if (channel_all[chnl] <= 140)
-		group = 8;
-	else if (channel_all[chnl] <= 153)
-		group = 9;
-	else if (channel_all[chnl] <= 159)
-		group = 10;
-	else
-		group = 11;
-	return group;
-}
-
 void rtl92d_phy_set_poweron(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -3286,31 +2507,6 @@ void rtl92d_phy_set_poweron(struct ieee80211_hw *hw)
 	}
 }
 
-void rtl92d_phy_config_maccoexist_rfpage(struct ieee80211_hw *hw)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	switch (rtlpriv->rtlhal.macphymode) {
-	case DUALMAC_DUALPHY:
-		rtl_write_byte(rtlpriv, REG_DMC, 0x0);
-		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x08);
-		rtl_write_word(rtlpriv, REG_TRXFF_BNDY + 2, 0x13ff);
-		break;
-	case DUALMAC_SINGLEPHY:
-		rtl_write_byte(rtlpriv, REG_DMC, 0xf8);
-		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x08);
-		rtl_write_word(rtlpriv, REG_TRXFF_BNDY + 2, 0x13ff);
-		break;
-	case SINGLEMAC_SINGLEPHY:
-		rtl_write_byte(rtlpriv, REG_DMC, 0x0);
-		rtl_write_byte(rtlpriv, REG_RX_PKT_LIMIT, 0x10);
-		rtl_write_word(rtlpriv, (REG_TRXFF_BNDY + 2), 0x27FF);
-		break;
-	default:
-		break;
-	}
-}
-
 void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
index 8d07c783a023..bbe9ef77225e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
@@ -10,11 +10,8 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x		64
 
-#define RT_CANNOT_IO(hw)			false
 #define HIGHPOWER_RADIOA_ARRAYLEN		22
 
-#define MAX_TOLERANCE				5
-
 #define	APK_BB_REG_NUM				5
 #define	APK_AFE_REG_NUM				16
 #define	APK_CURVE_REG_NUM			4
@@ -27,12 +24,8 @@
 #define RESET_CNT_LIMIT				3
 
 #define IQK_ADDA_REG_NUM			16
-#define IQK_BB_REG_NUM				10
 #define IQK_BB_REG_NUM_test			6
 #define IQK_MAC_REG_NUM				4
-#define RX_INDEX_MAPPING_NUM			15
-
-#define IQK_DELAY_TIME				1
 
 #define CT_OFFSET_MAC_ADDR			0X16
 
@@ -68,80 +61,30 @@ struct swchnlcmd {
 	u32 msdelay;
 };
 
-enum baseband_config_type {
-	BASEBAND_CONFIG_PHY_REG = 0,
-	BASEBAND_CONFIG_AGC_TAB = 1,
-};
-
-enum rf_content {
-	radioa_txt = 0,
-	radiob_txt = 1,
-	radioc_txt = 2,
-	radiod_txt = 3
-};
-
-static inline void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
-						     unsigned long *flag)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	if (rtlpriv->rtlhal.interfaceindex == 1)
-		spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, *flag);
-}
-
-static inline void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
-						     unsigned long *flag)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-
-	if (rtlpriv->rtlhal.interfaceindex == 1)
-		spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock,
-			*flag);
-}
-
 u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw,
 			    u32 regaddr, u32 bitmask);
 void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 			   u32 regaddr, u32 bitmask, u32 data);
-u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
-			    enum radio_path rfpath, u32 regaddr,
-			    u32 bitmask);
-void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw,
-			   enum radio_path rfpath, u32 regaddr,
-			   u32 bitmask, u32 data);
 bool rtl92d_phy_mac_config(struct ieee80211_hw *hw);
 bool rtl92d_phy_bb_config(struct ieee80211_hw *hw);
 bool rtl92d_phy_rf_config(struct ieee80211_hw *hw);
 bool rtl92c_phy_config_rf_with_feaderfile(struct ieee80211_hw *hw,
 					  enum radio_path rfpath);
-void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw);
-void rtl92d_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel);
 void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 			    enum nl80211_channel_type ch_type);
 u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw);
 bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 					  enum rf_content content,
 					  enum radio_path rfpath);
-bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype);
 bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				   enum rf_pwrstate rfpwr_state);
 
-void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw);
-void rtl92d_phy_config_macphymode_info(struct ieee80211_hw *hw);
-u8 rtl92d_get_chnlgroup_fromarray(u8 chnl);
 void rtl92d_phy_set_poweron(struct ieee80211_hw *hw);
-void rtl92d_phy_config_maccoexist_rfpage(struct ieee80211_hw *hw);
 bool rtl92d_phy_check_poweroff(struct ieee80211_hw *hw);
-void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw);
+void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t);
 void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw);
 void rtl92d_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
 void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw);
-void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw);
-void rtl92d_release_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
-				       unsigned long *flag);
-void rtl92d_acquire_cckandrw_pagea_ctl(struct ieee80211_hw *hw,
-				       unsigned long *flag);
-u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl);
 void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
index 83787fd293de..eb7d8b070cc7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
@@ -2,383 +2,14 @@
 /* Copyright(c) 2009-2012  Realtek Corporation.*/
 
 #include "../wifi.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
 #include "phy.h"
 #include "rf.h"
 #include "dm.h"
 #include "hw.h"
 
-void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	u8 rfpath;
-
-	switch (bandwidth) {
-	case HT_CHANNEL_WIDTH_20:
-		for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
-			rtlphy->rfreg_chnlval[rfpath] = ((rtlphy->rfreg_chnlval
-					[rfpath] & 0xfffff3ff) | 0x0400);
-			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) |
-				      BIT(11), 0x01);
-
-			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
-				"20M RF 0x18 = 0x%x\n",
-				rtlphy->rfreg_chnlval[rfpath]);
-		}
-
-		break;
-	case HT_CHANNEL_WIDTH_20_40:
-		for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
-			rtlphy->rfreg_chnlval[rfpath] =
-			    ((rtlphy->rfreg_chnlval[rfpath] & 0xfffff3ff));
-			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) | BIT(11),
-				      0x00);
-			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
-				"40M RF 0x18 = 0x%x\n",
-				rtlphy->rfreg_chnlval[rfpath]);
-		}
-		break;
-	default:
-		pr_err("unknown bandwidth: %#X\n", bandwidth);
-		break;
-	}
-}
-
-void rtl92d_phy_rf6052_set_cck_txpower(struct ieee80211_hw *hw,
-				       u8 *ppowerlevel)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u32 tx_agc[2] = {0, 0}, tmpval;
-	bool turbo_scanoff = false;
-	u8 idx1, idx2;
-	u8 *ptr;
-
-	if (rtlefuse->eeprom_regulatory != 0)
-		turbo_scanoff = true;
-	if (mac->act_scanning) {
-		tx_agc[RF90_PATH_A] = 0x3f3f3f3f;
-		tx_agc[RF90_PATH_B] = 0x3f3f3f3f;
-		if (turbo_scanoff) {
-			for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
-				tx_agc[idx1] = ppowerlevel[idx1] |
-				    (ppowerlevel[idx1] << 8) |
-				    (ppowerlevel[idx1] << 16) |
-				    (ppowerlevel[idx1] << 24);
-			}
-		}
-	} else {
-		for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
-			tx_agc[idx1] = ppowerlevel[idx1] |
-			    (ppowerlevel[idx1] << 8) |
-			    (ppowerlevel[idx1] << 16) |
-			    (ppowerlevel[idx1] << 24);
-		}
-		if (rtlefuse->eeprom_regulatory == 0) {
-			tmpval = (rtlphy->mcs_offset[0][6]) +
-			    (rtlphy->mcs_offset[0][7] << 8);
-			tx_agc[RF90_PATH_A] += tmpval;
-			tmpval = (rtlphy->mcs_offset[0][14]) +
-			    (rtlphy->mcs_offset[0][15] << 24);
-			tx_agc[RF90_PATH_B] += tmpval;
-		}
-	}
-
-	for (idx1 = RF90_PATH_A; idx1 <= RF90_PATH_B; idx1++) {
-		ptr = (u8 *) (&(tx_agc[idx1]));
-		for (idx2 = 0; idx2 < 4; idx2++) {
-			if (*ptr > RF6052_MAX_TX_PWR)
-				*ptr = RF6052_MAX_TX_PWR;
-			ptr++;
-		}
-	}
-
-	tmpval = tx_agc[RF90_PATH_A] & 0xff;
-	rtl_set_bbreg(hw, RTXAGC_A_CCK1_MCS32, MASKBYTE1, tmpval);
-	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-		"CCK PWR 1M (rf-A) = 0x%x (reg 0x%x)\n",
-		tmpval, RTXAGC_A_CCK1_MCS32);
-	tmpval = tx_agc[RF90_PATH_A] >> 8;
-	rtl_set_bbreg(hw, RTXAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
-	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-		"CCK PWR 2~11M (rf-A) = 0x%x (reg 0x%x)\n",
-		tmpval, RTXAGC_B_CCK11_A_CCK2_11);
-	tmpval = tx_agc[RF90_PATH_B] >> 24;
-	rtl_set_bbreg(hw, RTXAGC_B_CCK11_A_CCK2_11, MASKBYTE0, tmpval);
-	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-		"CCK PWR 11M (rf-B) = 0x%x (reg 0x%x)\n",
-		tmpval, RTXAGC_B_CCK11_A_CCK2_11);
-	tmpval = tx_agc[RF90_PATH_B] & 0x00ffffff;
-	rtl_set_bbreg(hw, RTXAGC_B_CCK1_55_MCS32, 0xffffff00, tmpval);
-	RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-		"CCK PWR 1~5.5M (rf-B) = 0x%x (reg 0x%x)\n",
-		tmpval, RTXAGC_B_CCK1_55_MCS32);
-}
-
-static void _rtl92d_phy_get_power_base(struct ieee80211_hw *hw,
-				       u8 *ppowerlevel, u8 channel,
-				       u32 *ofdmbase, u32 *mcsbase)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u32 powerbase0, powerbase1;
-	u8 legacy_pwrdiff, ht20_pwrdiff;
-	u8 i, powerlevel[2];
-
-	for (i = 0; i < 2; i++) {
-		powerlevel[i] = ppowerlevel[i];
-		legacy_pwrdiff = rtlefuse->txpwr_legacyhtdiff[i][channel - 1];
-		powerbase0 = powerlevel[i] + legacy_pwrdiff;
-		powerbase0 = (powerbase0 << 24) | (powerbase0 << 16) |
-		    (powerbase0 << 8) | powerbase0;
-		*(ofdmbase + i) = powerbase0;
-		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-			" [OFDM power base index rf(%c) = 0x%x]\n",
-			i == 0 ? 'A' : 'B', *(ofdmbase + i));
-	}
-
-	for (i = 0; i < 2; i++) {
-		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20) {
-			ht20_pwrdiff = rtlefuse->txpwr_ht20diff[i][channel - 1];
-			powerlevel[i] += ht20_pwrdiff;
-		}
-		powerbase1 = powerlevel[i];
-		powerbase1 = (powerbase1 << 24) | (powerbase1 << 16) |
-			     (powerbase1 << 8) | powerbase1;
-		*(mcsbase + i) = powerbase1;
-		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-			" [MCS power base index rf(%c) = 0x%x]\n",
-			i == 0 ? 'A' : 'B', *(mcsbase + i));
-	}
-}
-
-static u8 _rtl92d_phy_get_chnlgroup_bypg(u8 chnlindex)
-{
-	u8 group;
-	u8 channel_info[59] = {
-		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
-		60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
-		114, 116, 118, 120, 122, 124, 126, 128,	130, 132,
-		134, 136, 138, 140, 149, 151, 153, 155, 157, 159,
-		161, 163, 165
-	};
-
-	if (channel_info[chnlindex] <= 3)	/* Chanel 1-3 */
-		group = 0;
-	else if (channel_info[chnlindex] <= 9)	/* Channel 4-9 */
-		group = 1;
-	else if (channel_info[chnlindex] <= 14)	/* Channel 10-14 */
-		group = 2;
-	else if (channel_info[chnlindex] <= 64)
-		group = 6;
-	else if (channel_info[chnlindex] <= 140)
-		group = 7;
-	else
-		group = 8;
-	return group;
-}
-
-static void _rtl92d_get_txpower_writeval_by_regulatory(struct ieee80211_hw *hw,
-						       u8 channel, u8 index,
-						       u32 *powerbase0,
-						       u32 *powerbase1,
-						       u32 *p_outwriteval)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	u8 i, chnlgroup = 0, pwr_diff_limit[4];
-	u32 writeval = 0, customer_limit, rf;
-
-	for (rf = 0; rf < 2; rf++) {
-		switch (rtlefuse->eeprom_regulatory) {
-		case 0:
-			chnlgroup = 0;
-			writeval = rtlphy->mcs_offset
-					[chnlgroup][index +
-					(rf ? 8 : 0)] + ((index < 2) ?
-					powerbase0[rf] :
-					powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"RTK better performance, writeval(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
-			break;
-		case 1:
-			if (rtlphy->pwrgroup_cnt == 1)
-				chnlgroup = 0;
-			if (rtlphy->pwrgroup_cnt >= MAX_PG_GROUP) {
-				chnlgroup = _rtl92d_phy_get_chnlgroup_bypg(
-								channel - 1);
-				if (rtlphy->current_chan_bw ==
-				    HT_CHANNEL_WIDTH_20)
-					chnlgroup++;
-				else
-					chnlgroup += 4;
-				writeval = rtlphy->mcs_offset
-						[chnlgroup][index +
-						(rf ? 8 : 0)] + ((index < 2) ?
-						powerbase0[rf] :
-						powerbase1[rf]);
-				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-					"Realtek regulatory, 20MHz, writeval(%c) = 0x%x\n",
-					rf == 0 ? 'A' : 'B', writeval);
-			}
-			break;
-		case 2:
-			writeval = ((index < 2) ? powerbase0[rf] :
-				   powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"Better regulatory, writeval(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
-			break;
-		case 3:
-			chnlgroup = 0;
-			if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-					"customer's limit, 40MHz rf(%c) = 0x%x\n",
-					rf == 0 ? 'A' : 'B',
-					rtlefuse->pwrgroup_ht40[rf]
-					[channel - 1]);
-			} else {
-				RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-					"customer's limit, 20MHz rf(%c) = 0x%x\n",
-					rf == 0 ? 'A' : 'B',
-					rtlefuse->pwrgroup_ht20[rf]
-					[channel - 1]);
-			}
-			for (i = 0; i < 4; i++) {
-				pwr_diff_limit[i] = (u8)((rtlphy->mcs_offset
-					[chnlgroup][index + (rf ? 8 : 0)] &
-					(0x7f << (i * 8))) >> (i * 8));
-				if (rtlphy->current_chan_bw ==
-				    HT_CHANNEL_WIDTH_20_40) {
-					if (pwr_diff_limit[i] >
-					    rtlefuse->pwrgroup_ht40[rf]
-					   [channel - 1])
-						pwr_diff_limit[i] =
-							rtlefuse->pwrgroup_ht40
-							[rf][channel - 1];
-				} else {
-					if (pwr_diff_limit[i] >
-					    rtlefuse->pwrgroup_ht20[rf][
-						channel - 1])
-						pwr_diff_limit[i] =
-						   rtlefuse->pwrgroup_ht20[rf]
-						   [channel - 1];
-				}
-			}
-			customer_limit = (pwr_diff_limit[3] << 24) |
-					 (pwr_diff_limit[2] << 16) |
-					 (pwr_diff_limit[1] << 8) |
-					 (pwr_diff_limit[0]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"Customer's limit rf(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', customer_limit);
-			writeval = customer_limit + ((index < 2) ?
-				   powerbase0[rf] : powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"Customer, writeval rf(%c)= 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
-			break;
-		default:
-			chnlgroup = 0;
-			writeval = rtlphy->mcs_offset[chnlgroup][index +
-				   (rf ? 8 : 0)] + ((index < 2) ?
-				   powerbase0[rf] : powerbase1[rf]);
-			RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-				"RTK better performance, writeval rf(%c) = 0x%x\n",
-				rf == 0 ? 'A' : 'B', writeval);
-			break;
-		}
-		*(p_outwriteval + rf) = writeval;
-	}
-}
-
-static void _rtl92d_write_ofdm_power_reg(struct ieee80211_hw *hw,
-					 u8 index, u32 *pvalue)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	static u16 regoffset_a[6] = {
-		RTXAGC_A_RATE18_06, RTXAGC_A_RATE54_24,
-		RTXAGC_A_MCS03_MCS00, RTXAGC_A_MCS07_MCS04,
-		RTXAGC_A_MCS11_MCS08, RTXAGC_A_MCS15_MCS12
-	};
-	static u16 regoffset_b[6] = {
-		RTXAGC_B_RATE18_06, RTXAGC_B_RATE54_24,
-		RTXAGC_B_MCS03_MCS00, RTXAGC_B_MCS07_MCS04,
-		RTXAGC_B_MCS11_MCS08, RTXAGC_B_MCS15_MCS12
-	};
-	u8 i, rf, pwr_val[4];
-	u32 writeval;
-	u16 regoffset;
-
-	for (rf = 0; rf < 2; rf++) {
-		writeval = pvalue[rf];
-		for (i = 0; i < 4; i++) {
-			pwr_val[i] = (u8) ((writeval & (0x7f <<
-				     (i * 8))) >> (i * 8));
-			if (pwr_val[i] > RF6052_MAX_TX_PWR)
-				pwr_val[i] = RF6052_MAX_TX_PWR;
-		}
-		writeval = (pwr_val[3] << 24) | (pwr_val[2] << 16) |
-			   (pwr_val[1] << 8) | pwr_val[0];
-		if (rf == 0)
-			regoffset = regoffset_a[index];
-		else
-			regoffset = regoffset_b[index];
-		rtl_set_bbreg(hw, regoffset, MASKDWORD, writeval);
-		RTPRINT(rtlpriv, FPHY, PHY_TXPWR,
-			"Set 0x%x = %08x\n", regoffset, writeval);
-		if (((get_rf_type(rtlphy) == RF_2T2R) &&
-		    (regoffset == RTXAGC_A_MCS15_MCS12 ||
-		    regoffset == RTXAGC_B_MCS15_MCS12)) ||
-		    ((get_rf_type(rtlphy) != RF_2T2R) &&
-		    (regoffset == RTXAGC_A_MCS07_MCS04 ||
-		    regoffset == RTXAGC_B_MCS07_MCS04))) {
-			writeval = pwr_val[3];
-			if (regoffset == RTXAGC_A_MCS15_MCS12 ||
-			    regoffset == RTXAGC_A_MCS07_MCS04)
-				regoffset = 0xc90;
-			if (regoffset == RTXAGC_B_MCS15_MCS12 ||
-			    regoffset == RTXAGC_B_MCS07_MCS04)
-				regoffset = 0xc98;
-			for (i = 0; i < 3; i++) {
-				if (i != 2)
-					writeval = (writeval > 8) ?
-						   (writeval - 8) : 0;
-				else
-					writeval = (writeval > 6) ?
-						   (writeval - 6) : 0;
-				rtl_write_byte(rtlpriv, (u32) (regoffset + i),
-					       (u8) writeval);
-			}
-		}
-	}
-}
-
-void rtl92d_phy_rf6052_set_ofdm_txpower(struct ieee80211_hw *hw,
-					u8 *ppowerlevel, u8 channel)
-{
-	u32 writeval[2], powerbase0[2], powerbase1[2];
-	u8 index;
-
-	_rtl92d_phy_get_power_base(hw, ppowerlevel, channel,
-			&powerbase0[0],	&powerbase1[0]);
-	for (index = 0; index < 6; index++) {
-		_rtl92d_get_txpower_writeval_by_regulatory(hw,
-				channel, index,	&powerbase0[0],
-				&powerbase1[0],	&writeval[0]);
-		_rtl92d_write_ofdm_power_reg(hw, index, &writeval[0]);
-	}
-}
-
 bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.h
index 4e646cc9ebc0..c097d90cc99c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.h
@@ -4,11 +4,6 @@
 #ifndef __RTL92D_RF_H__
 #define __RTL92D_RF_H__
 
-void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth);
-void rtl92d_phy_rf6052_set_cck_txpower(struct ieee80211_hw *hw,
-				       u8 *ppowerlevel);
-void rtl92d_phy_rf6052_set_ofdm_txpower(struct ieee80211_hw *hw,
-					u8 *ppowerlevel, u8 channel);
 bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw);
 bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0);
 void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index afd685ed460a..5f6311c2aac4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -5,8 +5,12 @@
 #include "../core.h"
 #include "../pci.h"
 #include "../base.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/hw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
 #include "phy.h"
 #include "dm.h"
 #include "hw.h"
@@ -207,7 +211,7 @@ static struct rtl_hal_ops rtl8192de_hal_ops = {
 	.radio_onoff_checking = rtl92de_gpio_radio_on_off_checking,
 	.set_bw_mode = rtl92d_phy_set_bw_mode,
 	.switch_channel = rtl92d_phy_sw_chnl,
-	.dm_watchdog = rtl92d_dm_watchdog,
+	.dm_watchdog = rtl92de_dm_watchdog,
 	.scan_operation_backup = rtl_phy_scan_operation_backup,
 	.set_rf_power_state = rtl92d_phy_set_rf_power_state,
 	.led_control = rtl92de_led_control,
@@ -223,6 +227,8 @@ static struct rtl_hal_ops rtl8192de_hal_ops = {
 	.set_rfreg = rtl92d_phy_set_rf_reg,
 	.linked_set_reg = rtl92d_linked_set_reg,
 	.get_btc_status = rtl_btc_status_false,
+	.phy_iq_calibrate = rtl92d_phy_iq_calibrate,
+	.phy_lc_calibrate = rtl92d_phy_lc_calibrate,
 };
 
 static struct rtl_mod_params rtl92de_mod_params = {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 192982ec8152..2b9b352f7783 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -5,8 +5,10 @@
 #include "../pci.h"
 #include "../base.h"
 #include "../stats.h"
-#include "reg.h"
-#include "def.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
 #include "phy.h"
 #include "trx.h"
 #include "led.h"
@@ -23,434 +25,6 @@ static u8 _rtl92de_map_hwqueue_to_fwqueue(struct sk_buff *skb, u8 hw_queue)
 	return skb->priority;
 }
 
-static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
-				     u8 signal_strength_index)
-{
-	long signal_power;
-
-	signal_power = (long)((signal_strength_index + 1) >> 1);
-	signal_power -= 95;
-	return signal_power;
-}
-
-static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
-				       struct rtl_stats *pstats,
-				       struct rx_desc_92d *pdesc,
-				       struct rx_fwinfo_92d *p_drvinfo,
-				       bool packet_match_bssid,
-				       bool packet_toself,
-				       bool packet_beacon)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
-	struct phy_sts_cck_8192d *cck_buf;
-	s8 rx_pwr_all, rx_pwr[4];
-	u8 rf_rx_num = 0, evm, pwdb_all;
-	u8 i, max_spatial_stream;
-	u32 rssi, total_rssi = 0;
-	bool is_cck_rate;
-
-	is_cck_rate = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
-	pstats->packet_matchbssid = packet_match_bssid;
-	pstats->packet_toself = packet_toself;
-	pstats->packet_beacon = packet_beacon;
-	pstats->is_cck = is_cck_rate;
-	pstats->rx_mimo_sig_qual[0] = -1;
-	pstats->rx_mimo_sig_qual[1] = -1;
-
-	if (is_cck_rate) {
-		u8 report, cck_highpwr;
-		cck_buf = (struct phy_sts_cck_8192d *)p_drvinfo;
-		if (ppsc->rfpwr_state == ERFON)
-			cck_highpwr = rtlphy->cck_high_power;
-		else
-			cck_highpwr = false;
-		if (!cck_highpwr) {
-			u8 cck_agc_rpt = cck_buf->cck_agc_rpt;
-			report = cck_buf->cck_agc_rpt & 0xc0;
-			report = report >> 6;
-			switch (report) {
-			case 0x3:
-				rx_pwr_all = -46 - (cck_agc_rpt & 0x3e);
-				break;
-			case 0x2:
-				rx_pwr_all = -26 - (cck_agc_rpt & 0x3e);
-				break;
-			case 0x1:
-				rx_pwr_all = -12 - (cck_agc_rpt & 0x3e);
-				break;
-			case 0x0:
-				rx_pwr_all = 16 - (cck_agc_rpt & 0x3e);
-				break;
-			}
-		} else {
-			u8 cck_agc_rpt = cck_buf->cck_agc_rpt;
-			report = p_drvinfo->cfosho[0] & 0x60;
-			report = report >> 5;
-			switch (report) {
-			case 0x3:
-				rx_pwr_all = -46 - ((cck_agc_rpt & 0x1f) << 1);
-				break;
-			case 0x2:
-				rx_pwr_all = -26 - ((cck_agc_rpt & 0x1f) << 1);
-				break;
-			case 0x1:
-				rx_pwr_all = -12 - ((cck_agc_rpt & 0x1f) << 1);
-				break;
-			case 0x0:
-				rx_pwr_all = 16 - ((cck_agc_rpt & 0x1f) << 1);
-				break;
-			}
-		}
-		pwdb_all = rtl_query_rxpwrpercentage(rx_pwr_all);
-		/* CCK gain is smaller than OFDM/MCS gain,  */
-		/* so we add gain diff by experiences, the val is 6 */
-		pwdb_all += 6;
-		if (pwdb_all > 100)
-			pwdb_all = 100;
-		/* modify the offset to make the same gain index with OFDM. */
-		if (pwdb_all > 34 && pwdb_all <= 42)
-			pwdb_all -= 2;
-		else if (pwdb_all > 26 && pwdb_all <= 34)
-			pwdb_all -= 6;
-		else if (pwdb_all > 14 && pwdb_all <= 26)
-			pwdb_all -= 8;
-		else if (pwdb_all > 4 && pwdb_all <= 14)
-			pwdb_all -= 4;
-		pstats->rx_pwdb_all = pwdb_all;
-		pstats->recvsignalpower = rx_pwr_all;
-		if (packet_match_bssid) {
-			u8 sq;
-			if (pstats->rx_pwdb_all > 40) {
-				sq = 100;
-			} else {
-				sq = cck_buf->sq_rpt;
-				if (sq > 64)
-					sq = 0;
-				else if (sq < 20)
-					sq = 100;
-				else
-					sq = ((64 - sq) * 100) / 44;
-			}
-			pstats->signalquality = sq;
-			pstats->rx_mimo_sig_qual[0] = sq;
-			pstats->rx_mimo_sig_qual[1] = -1;
-		}
-	} else {
-		rtlpriv->dm.rfpath_rxenable[0] = true;
-		rtlpriv->dm.rfpath_rxenable[1] = true;
-		for (i = RF90_PATH_A; i < RF6052_MAX_PATH; i++) {
-			if (rtlpriv->dm.rfpath_rxenable[i])
-				rf_rx_num++;
-			rx_pwr[i] = ((p_drvinfo->gain_trsw[i] & 0x3f) * 2)
-				    - 110;
-			rssi = rtl_query_rxpwrpercentage(rx_pwr[i]);
-			total_rssi += rssi;
-			rtlpriv->stats.rx_snr_db[i] =
-					 (long)(p_drvinfo->rxsnr[i] / 2);
-			if (packet_match_bssid)
-				pstats->rx_mimo_signalstrength[i] = (u8) rssi;
-		}
-		rx_pwr_all = ((p_drvinfo->pwdb_all >> 1) & 0x7f) - 106;
-		pwdb_all = rtl_query_rxpwrpercentage(rx_pwr_all);
-		pstats->rx_pwdb_all = pwdb_all;
-		pstats->rxpower = rx_pwr_all;
-		pstats->recvsignalpower = rx_pwr_all;
-		if (pdesc->rxht && pdesc->rxmcs >= DESC_RATEMCS8 &&
-		    pdesc->rxmcs <= DESC_RATEMCS15)
-			max_spatial_stream = 2;
-		else
-			max_spatial_stream = 1;
-		for (i = 0; i < max_spatial_stream; i++) {
-			evm = rtl_evm_db_to_percentage(p_drvinfo->rxevm[i]);
-			if (packet_match_bssid) {
-				if (i == 0)
-					pstats->signalquality =
-						 (u8)(evm & 0xff);
-				pstats->rx_mimo_sig_qual[i] =
-						 (u8)(evm & 0xff);
-			}
-		}
-	}
-	if (is_cck_rate)
-		pstats->signalstrength = (u8)(rtl_signal_scale_mapping(hw,
-				pwdb_all));
-	else if (rf_rx_num != 0)
-		pstats->signalstrength = (u8)(rtl_signal_scale_mapping(hw,
-				total_rssi /= rf_rx_num));
-}
-
-static void rtl92d_loop_over_paths(struct ieee80211_hw *hw,
-				   struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
-	u8 rfpath;
-
-	for (rfpath = RF90_PATH_A; rfpath < rtlphy->num_total_rfpath;
-	     rfpath++) {
-		if (rtlpriv->stats.rx_rssi_percentage[rfpath] == 0) {
-			rtlpriv->stats.rx_rssi_percentage[rfpath] =
-			    pstats->rx_mimo_signalstrength[rfpath];
-
-		}
-		if (pstats->rx_mimo_signalstrength[rfpath] >
-		    rtlpriv->stats.rx_rssi_percentage[rfpath]) {
-			rtlpriv->stats.rx_rssi_percentage[rfpath] =
-			    ((rtlpriv->stats.rx_rssi_percentage[rfpath] *
-			      (RX_SMOOTH_FACTOR - 1)) +
-			     (pstats->rx_mimo_signalstrength[rfpath])) /
-			    (RX_SMOOTH_FACTOR);
-			rtlpriv->stats.rx_rssi_percentage[rfpath] =
-			    rtlpriv->stats.rx_rssi_percentage[rfpath] + 1;
-		} else {
-			rtlpriv->stats.rx_rssi_percentage[rfpath] =
-			    ((rtlpriv->stats.rx_rssi_percentage[rfpath] *
-			      (RX_SMOOTH_FACTOR - 1)) +
-			     (pstats->rx_mimo_signalstrength[rfpath])) /
-			    (RX_SMOOTH_FACTOR);
-		}
-	}
-}
-
-static void _rtl92de_process_ui_rssi(struct ieee80211_hw *hw,
-				     struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 last_rssi, tmpval;
-
-	if (pstats->packet_toself || pstats->packet_beacon) {
-		rtlpriv->stats.rssi_calculate_cnt++;
-		if (rtlpriv->stats.ui_rssi.total_num++ >=
-		    PHY_RSSI_SLID_WIN_MAX) {
-			rtlpriv->stats.ui_rssi.total_num =
-						 PHY_RSSI_SLID_WIN_MAX;
-			last_rssi = rtlpriv->stats.ui_rssi.elements[
-				rtlpriv->stats.ui_rssi.index];
-			rtlpriv->stats.ui_rssi.total_val -= last_rssi;
-		}
-		rtlpriv->stats.ui_rssi.total_val += pstats->signalstrength;
-		rtlpriv->stats.ui_rssi.elements
-			[rtlpriv->stats.ui_rssi.index++] =
-			pstats->signalstrength;
-		if (rtlpriv->stats.ui_rssi.index >= PHY_RSSI_SLID_WIN_MAX)
-			rtlpriv->stats.ui_rssi.index = 0;
-		tmpval = rtlpriv->stats.ui_rssi.total_val /
-			rtlpriv->stats.ui_rssi.total_num;
-		rtlpriv->stats.signal_strength = _rtl92de_translate_todbm(hw,
-			(u8) tmpval);
-		pstats->rssi = rtlpriv->stats.signal_strength;
-	}
-	if (!pstats->is_cck && pstats->packet_toself)
-		rtl92d_loop_over_paths(hw, pstats);
-}
-
-static void _rtl92de_update_rxsignalstatistics(struct ieee80211_hw *hw,
-					       struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	int weighting = 0;
-
-	if (rtlpriv->stats.recv_signal_power == 0)
-		rtlpriv->stats.recv_signal_power = pstats->recvsignalpower;
-	if (pstats->recvsignalpower > rtlpriv->stats.recv_signal_power)
-		weighting = 5;
-	else if (pstats->recvsignalpower < rtlpriv->stats.recv_signal_power)
-		weighting = (-5);
-	rtlpriv->stats.recv_signal_power = (rtlpriv->stats.recv_signal_power *
-		5 + pstats->recvsignalpower + weighting) / 6;
-}
-
-static void _rtl92de_process_pwdb(struct ieee80211_hw *hw,
-				  struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	long undec_sm_pwdb;
-
-	if (mac->opmode == NL80211_IFTYPE_ADHOC	||
-		mac->opmode == NL80211_IFTYPE_AP)
-		return;
-	else
-		undec_sm_pwdb = rtlpriv->dm.undec_sm_pwdb;
-
-	if (pstats->packet_toself || pstats->packet_beacon) {
-		if (undec_sm_pwdb < 0)
-			undec_sm_pwdb = pstats->rx_pwdb_all;
-		if (pstats->rx_pwdb_all > (u32) undec_sm_pwdb) {
-			undec_sm_pwdb = (((undec_sm_pwdb) *
-			      (RX_SMOOTH_FACTOR - 1)) +
-			      (pstats->rx_pwdb_all)) / (RX_SMOOTH_FACTOR);
-			undec_sm_pwdb = undec_sm_pwdb + 1;
-		} else {
-			undec_sm_pwdb = (((undec_sm_pwdb) *
-			      (RX_SMOOTH_FACTOR - 1)) +
-			      (pstats->rx_pwdb_all)) / (RX_SMOOTH_FACTOR);
-		}
-		rtlpriv->dm.undec_sm_pwdb = undec_sm_pwdb;
-		_rtl92de_update_rxsignalstatistics(hw, pstats);
-	}
-}
-
-static void rtl92d_loop_over_streams(struct ieee80211_hw *hw,
-				     struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		if (pstats->rx_mimo_sig_qual[stream] != -1) {
-			if (rtlpriv->stats.rx_evm_percentage[stream] == 0) {
-				rtlpriv->stats.rx_evm_percentage[stream] =
-				    pstats->rx_mimo_sig_qual[stream];
-			}
-			rtlpriv->stats.rx_evm_percentage[stream] =
-			    ((rtlpriv->stats.rx_evm_percentage[stream]
-			      * (RX_SMOOTH_FACTOR - 1)) +
-			     (pstats->rx_mimo_sig_qual[stream] * 1)) /
-			    (RX_SMOOTH_FACTOR);
-		}
-	}
-}
-
-static void _rtl92de_process_ui_link_quality(struct ieee80211_hw *hw,
-					     struct rtl_stats *pstats)
-{
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 last_evm, tmpval;
-
-	if (pstats->signalquality == 0)
-		return;
-	if (pstats->packet_toself || pstats->packet_beacon) {
-		if (rtlpriv->stats.ui_link_quality.total_num++ >=
-		    PHY_LINKQUALITY_SLID_WIN_MAX) {
-			rtlpriv->stats.ui_link_quality.total_num =
-			    PHY_LINKQUALITY_SLID_WIN_MAX;
-			last_evm = rtlpriv->stats.ui_link_quality.elements[
-				rtlpriv->stats.ui_link_quality.index];
-			rtlpriv->stats.ui_link_quality.total_val -= last_evm;
-		}
-		rtlpriv->stats.ui_link_quality.total_val +=
-						 pstats->signalquality;
-		rtlpriv->stats.ui_link_quality.elements[
-			rtlpriv->stats.ui_link_quality.index++] =
-						 pstats->signalquality;
-		if (rtlpriv->stats.ui_link_quality.index >=
-		    PHY_LINKQUALITY_SLID_WIN_MAX)
-			rtlpriv->stats.ui_link_quality.index = 0;
-		tmpval = rtlpriv->stats.ui_link_quality.total_val /
-		    rtlpriv->stats.ui_link_quality.total_num;
-		rtlpriv->stats.signal_quality = tmpval;
-		rtlpriv->stats.last_sigstrength_inpercent = tmpval;
-		rtl92d_loop_over_streams(hw, pstats);
-	}
-}
-
-static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
-				     u8 *buffer,
-				     struct rtl_stats *pcurrent_stats)
-{
-
-	if (!pcurrent_stats->packet_matchbssid &&
-	    !pcurrent_stats->packet_beacon)
-		return;
-
-	_rtl92de_process_ui_rssi(hw, pcurrent_stats);
-	_rtl92de_process_pwdb(hw, pcurrent_stats);
-	_rtl92de_process_ui_link_quality(hw, pcurrent_stats);
-}
-
-static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
-					       struct sk_buff *skb,
-					       struct rtl_stats *pstats,
-					       struct rx_desc_92d *pdesc,
-					       struct rx_fwinfo_92d *p_drvinfo)
-{
-	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
-	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct ieee80211_hdr *hdr;
-	u8 *tmp_buf;
-	u8 *praddr;
-	u16 type, cfc;
-	__le16 fc;
-	bool packet_matchbssid, packet_toself, packet_beacon = false;
-
-	tmp_buf = skb->data + pstats->rx_drvinfo_size + pstats->rx_bufshift;
-	hdr = (struct ieee80211_hdr *)tmp_buf;
-	fc = hdr->frame_control;
-	cfc = le16_to_cpu(fc);
-	type = WLAN_FC_GET_TYPE(fc);
-	praddr = hdr->addr1;
-	packet_matchbssid = ((IEEE80211_FTYPE_CTL != type) &&
-	     ether_addr_equal(mac->bssid,
-			      (cfc & IEEE80211_FCTL_TODS) ? hdr->addr1 :
-			      (cfc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 :
-			      hdr->addr3) &&
-	     (!pstats->hwerror) && (!pstats->crc) && (!pstats->icv));
-	packet_toself = packet_matchbssid &&
-			ether_addr_equal(praddr, rtlefuse->dev_addr);
-	if (ieee80211_is_beacon(fc))
-		packet_beacon = true;
-	_rtl92de_query_rxphystatus(hw, pstats, pdesc, p_drvinfo,
-				   packet_matchbssid, packet_toself,
-				   packet_beacon);
-	_rtl92de_process_phyinfo(hw, tmp_buf, pstats);
-}
-
-bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
-		struct ieee80211_rx_status *rx_status,
-		u8 *pdesc8, struct sk_buff *skb)
-{
-	__le32 *pdesc = (__le32 *)pdesc8;
-	struct rx_fwinfo_92d *p_drvinfo;
-	u32 phystatus = get_rx_desc_physt(pdesc);
-
-	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
-	stats->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(pdesc) *
-				 RX_DRV_INFO_SIZE_UNIT;
-	stats->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
-	stats->icv = (u16)get_rx_desc_icv(pdesc);
-	stats->crc = (u16)get_rx_desc_crc32(pdesc);
-	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !get_rx_desc_swdec(pdesc);
-	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
-	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
-	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
-	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
-				      (get_rx_desc_faggr(pdesc) == 1));
-	stats->timestamp_low = get_rx_desc_tsfl(pdesc);
-	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
-	stats->is_ht = (bool)get_rx_desc_rxht(pdesc);
-	rx_status->freq = hw->conf.chandef.chan->center_freq;
-	rx_status->band = hw->conf.chandef.chan->band;
-	if (get_rx_desc_crc32(pdesc))
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!get_rx_desc_swdec(pdesc))
-		rx_status->flag |= RX_FLAG_DECRYPTED;
-	if (get_rx_desc_bw(pdesc))
-		rx_status->bw = RATE_INFO_BW_40;
-	if (get_rx_desc_rxht(pdesc))
-		rx_status->encoding = RX_ENC_HT;
-	rx_status->flag |= RX_FLAG_MACTIME_START;
-	if (stats->decrypted)
-		rx_status->flag |= RX_FLAG_DECRYPTED;
-	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
-						   false, stats->rate);
-	rx_status->mactime = get_rx_desc_tsfl(pdesc);
-	if (phystatus) {
-		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
-						     stats->rx_bufshift);
-		_rtl92de_translate_rx_signal_stuff(hw,
-						   skb, stats,
-						   (struct rx_desc_92d *)pdesc,
-						   p_drvinfo);
-	}
-	/*rx_status->qual = stats->signal; */
-	rx_status->signal = stats->recvsignalpower + 10;
-	return true;
-}
-
 static void _rtl92de_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 				      u8 *virtualaddress8)
 {
@@ -712,87 +286,6 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
 	set_tx_desc_own(pdesc, 1);
 }
 
-void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
-		      u8 desc_name, u8 *val)
-{
-	__le32  *pdesc = (__le32 *)pdesc8;
-
-	if (istx) {
-		switch (desc_name) {
-		case HW_DESC_OWN:
-			wmb();
-			set_tx_desc_own(pdesc, 1);
-			break;
-		case HW_DESC_TX_NEXTDESC_ADDR:
-			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
-			break;
-		default:
-			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
-				  desc_name);
-			break;
-		}
-	} else {
-		switch (desc_name) {
-		case HW_DESC_RXOWN:
-			wmb();
-			set_rx_desc_own(pdesc, 1);
-			break;
-		case HW_DESC_RXBUFF_ADDR:
-			set_rx_desc_buff_addr(pdesc, *(u32 *)val);
-			break;
-		case HW_DESC_RXPKT_LEN:
-			set_rx_desc_pkt_len(pdesc, *(u32 *)val);
-			break;
-		case HW_DESC_RXERO:
-			set_rx_desc_eor(pdesc, 1);
-			break;
-		default:
-			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
-				  desc_name);
-			break;
-		}
-	}
-}
-
-u64 rtl92de_get_desc(struct ieee80211_hw *hw,
-		     u8 *p_desc8, bool istx, u8 desc_name)
-{
-	__le32 *p_desc = (__le32 *)p_desc8;
-	u32 ret = 0;
-
-	if (istx) {
-		switch (desc_name) {
-		case HW_DESC_OWN:
-			ret = get_tx_desc_own(p_desc);
-			break;
-		case HW_DESC_TXBUFF_ADDR:
-			ret = get_tx_desc_tx_buffer_address(p_desc);
-			break;
-		default:
-			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
-				  desc_name);
-			break;
-		}
-	} else {
-		switch (desc_name) {
-		case HW_DESC_OWN:
-			ret = get_rx_desc_own(p_desc);
-			break;
-		case HW_DESC_RXPKT_LEN:
-			ret = get_rx_desc_pkt_len(p_desc);
-		break;
-		case HW_DESC_RXBUFF_ADDR:
-			ret = get_rx_desc_buff_addr(p_desc);
-			break;
-		default:
-			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
-				  desc_name);
-			break;
-		}
-	}
-	return ret;
-}
-
 bool rtl92de_is_tx_desc_closed(struct ieee80211_hw *hw,
 			       u8 hw_queue, u16 index)
 {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index 2992668c156c..d3c480c75678 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -8,384 +8,17 @@
 #define TX_DESC_AGGR_SUBFRAME_SIZE		32
 
 #define RX_DESC_SIZE				32
-#define RX_DRV_INFO_SIZE_UNIT			8
 
 #define	TX_DESC_NEXT_DESC_OFFSET		40
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH				4
 
-/* macros to read/write various fields in RX or TX descriptors */
-
-static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
-}
-
-static inline void set_tx_desc_offset(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
-}
-
-static inline void set_tx_desc_htc(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(25));
-}
-
-static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(26));
-}
-
-static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(27));
-}
-
-static inline void set_tx_desc_linip(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(28));
-}
-
-static inline void set_tx_desc_own(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(31));
-}
-
-static inline u32 get_tx_desc_own(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(31));
-}
-
-static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
-}
-
-static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, BIT(5));
-}
-
-static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, BIT(7));
-}
-
-static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
-}
-
-static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, GENMASK(19, 16));
-}
-
-static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
-}
-
-static inline void set_tx_desc_pkt_offset(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 1), __val, GENMASK(30, 26));
-}
-
-static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 2), __val, BIT(17));
-}
-
-static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 2), __val, GENMASK(22, 20));
-}
-
-static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
-}
-
-static inline void set_tx_desc_pkt_id(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 3), __val, GENMASK(31, 28));
-}
-
-static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, GENMASK(4, 0));
-}
-
-static inline void set_tx_desc_qos(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(6));
-}
-
-static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(7));
-}
-
-static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(8));
-}
-
-static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(10));
-}
-
-static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
-}
-
-static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
-}
-
-static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(13));
-}
-
-static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, GENMASK(21, 20));
-}
-
-static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
-}
-
-static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
-}
-
-static inline void set_tx_desc_rts_bw(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, BIT(27));
-}
-
-static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, GENMASK(29, 28));
-}
-
-static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 4), __val, GENMASK(31, 30));
-}
-
-static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 5), __val, GENMASK(5, 0));
-}
-
-static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 5), __val, BIT(6));
-}
-
-static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 5), __val, GENMASK(12, 8));
-}
-
-static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
-}
-
-static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 6), __val, GENMASK(15, 11));
-}
-
-static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
-}
-
-static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
-{
-	*(__pdesc + 8) = cpu_to_le32(__val);
-}
-
-static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
-{
-	return le32_to_cpu(*(__pdesc + 8));
-}
-
-static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
-{
-	*(__pdesc + 10) = cpu_to_le32(__val);
-}
-
-static inline u32 get_rx_desc_pkt_len(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, GENMASK(13, 0));
-}
-
-static inline u32 get_rx_desc_crc32(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(14));
-}
-
-static inline u32 get_rx_desc_icv(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(15));
-}
-
-static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, GENMASK(19, 16));
-}
-
-static inline u32 get_rx_desc_shift(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, GENMASK(25, 24));
-}
-
-static inline u32 get_rx_desc_physt(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(26));
-}
-
-static inline u32 get_rx_desc_swdec(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(27));
-}
-
-static inline u32 get_rx_desc_own(__le32 *__pdesc)
-{
-	return le32_get_bits(*__pdesc, BIT(31));
-}
-
-static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
-}
-
-static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(30));
-}
-
-static inline void set_rx_desc_own(__le32 *__pdesc, u32 __val)
-{
-	le32p_replace_bits(__pdesc, __val, BIT(31));
-}
-
-static inline u32 get_rx_desc_paggr(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 1), BIT(14));
-}
-
-static inline u32 get_rx_desc_faggr(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 1), BIT(15));
-}
-
-static inline u32 get_rx_desc_rxmcs(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
-}
-
-static inline u32 get_rx_desc_rxht(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 3), BIT(6));
-}
-
-static inline u32 get_rx_desc_splcp(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 3), BIT(8));
-}
-
-static inline u32 get_rx_desc_bw(__le32 *__pdesc)
-{
-	return le32_get_bits(*(__pdesc + 3), BIT(9));
-}
-
-static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
-{
-	return le32_to_cpu(*(__pdesc + 5));
-}
-
-static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
-{
-	return le32_to_cpu(*(__pdesc + 6));
-}
-
-static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
-{
-	*(__pdesc + 6) = cpu_to_le32(__val);
-}
-
 static inline void clear_pci_tx_desc_content(__le32 *__pdesc, u32 _size)
 {
 	memset((void *)__pdesc, 0,
 	       min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET));
 }
 
-/* For 92D early mode */
-static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits(__paddr, __value, GENMASK(2, 0));
-}
-
-static inline void set_earlymode_len0(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
-}
-
-static inline void set_earlymode_len1(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
-}
-
-static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
-}
-
-static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits((__paddr + 1), __value, GENMASK(7, 0));
-}
-
-static inline void set_earlymode_len3(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits((__paddr + 1), __value, GENMASK(19, 8));
-}
-
-static inline void set_earlymode_len4(__le32 *__paddr, u32 __value)
-{
-	le32p_replace_bits((__paddr + 1), __value, GENMASK(31, 20));
-}
-
-struct rx_fwinfo_92d {
-	u8 gain_trsw[4];
-	u8 pwdb_all;
-	u8 cfosho[4];
-	u8 cfotail[4];
-	s8 rxevm[2];
-	s8 rxsnr[4];
-	u8 pdsnr[2];
-	u8 csi_current[2];
-	u8 csi_target[2];
-	u8 sigevm;
-	u8 max_ex_pwr;
-	u8 ex_intf_flag:1;
-	u8 sgi_en:1;
-	u8 rxsc:2;
-	u8 reserve:4;
-} __packed;
-
 struct tx_desc_92d {
 	u32 pktsize:16;
 	u32 offset:8;
@@ -488,78 +121,12 @@ struct tx_desc_92d {
 	u32 reserve_pass_pcie_mm_limit[4];
 } __packed;
 
-struct rx_desc_92d {
-	u32 length:14;
-	u32 crc32:1;
-	u32 icverror:1;
-	u32 drv_infosize:4;
-	u32 security:3;
-	u32 qos:1;
-	u32 shift:2;
-	u32 phystatus:1;
-	u32 swdec:1;
-	u32 lastseg:1;
-	u32 firstseg:1;
-	u32 eor:1;
-	u32 own:1;
-
-	u32 macid:5;
-	u32 tid:4;
-	u32 hwrsvd:5;
-	u32 paggr:1;
-	u32 faggr:1;
-	u32 a1_fit:4;
-	u32 a2_fit:4;
-	u32 pam:1;
-	u32 pwr:1;
-	u32 moredata:1;
-	u32 morefrag:1;
-	u32 type:2;
-	u32 mc:1;
-	u32 bc:1;
-
-	u32 seq:12;
-	u32 frag:4;
-	u32 nextpktlen:14;
-	u32 nextind:1;
-	u32 rsvd:1;
-
-	u32 rxmcs:6;
-	u32 rxht:1;
-	u32 amsdu:1;
-	u32 splcp:1;
-	u32 bandwidth:1;
-	u32 htc:1;
-	u32 tcpchk_rpt:1;
-	u32 ipcchk_rpt:1;
-	u32 tcpchk_valid:1;
-	u32 hwpcerr:1;
-	u32 hwpcind:1;
-	u32 iv0:16;
-
-	u32 iv1;
-
-	u32 tsfl;
-
-	u32 bufferaddress;
-	u32 bufferaddress64;
-
-} __packed;
-
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_hdr *hdr, u8 *pdesc,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
 			  struct sk_buff *skb, u8 hw_queue,
 			  struct rtl_tcb_desc *ptcb_desc);
-bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,
-			   struct rtl_stats *stats,
-			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc, struct sk_buff *skb);
-void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
-		      u8 desc_name, u8 *val);
-u64 rtl92de_get_desc(struct ieee80211_hw *hw,
-		     u8 *p_desc, bool istx, u8 desc_name);
 bool rtl92de_is_tx_desc_closed(struct ieee80211_hw *hw,
 			       u8 hw_queue, u16 index);
 void rtl92de_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 9fabf597cfd6..098db85e381c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2268,6 +2268,7 @@ struct rtl_hal_ops {
 	bool (*config_bb_with_pgheaderfile)(struct ieee80211_hw *hw,
 					    u8 configtype);
 	void (*phy_lc_calibrate)(struct ieee80211_hw *hw, bool is2t);
+	void (*phy_iq_calibrate)(struct ieee80211_hw *hw);
 	void (*phy_set_bw_mode_callback)(struct ieee80211_hw *hw);
 	void (*dm_dynamic_txpower)(struct ieee80211_hw *hw);
 	void (*c2h_command_handle)(struct ieee80211_hw *hw);
-- 
2.43.2

