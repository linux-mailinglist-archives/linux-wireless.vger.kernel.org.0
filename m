Return-Path: <linux-wireless+bounces-4640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF25F879E6D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC8F284863
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AE143C62;
	Tue, 12 Mar 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pel5ZOdA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47D144025
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282238; cv=none; b=cMG/5dWbGXDS8VqKVM37jh1vQ/TiCL+kUb6Qmj2PDpp0Ww3ES+A8ElONKUeQUE5zDplNV6Q2643XW42I1J+Xy3hZMujpr9HE8ik2QEYubpd3PLqSvxSIC+tpQI9G3qa+FcABKD8c4X4bKPrJsxC6jL1J/GFuUiGFlobqOS2WdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282238; c=relaxed/simple;
	bh=SaI5xJW/eBk1ZGxbEEN3BMVVUD1gk9ZpZHj4440H58o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H4+wBvjp5UavLTfqPkoZNLzbfwNBipJYgDJc1eEoKoAG+ZfMDefMyZO5jMIYsgZ5Z6cgMaKoHwUoZbDtfpqzGQqFwVskwuVf66Uvm7IThW8kDCC1Cvpk7vTwuruLjzIyieFffKNJ/R4RZ23RwjO14xzwyNRIyY+MI8rVRCtHjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pel5ZOdA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso369586f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710282226; x=1710887026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWLMAN2m3XvJpUk8zrNgDJNq5dK+J4+OJlHZxvNchPs=;
        b=Pel5ZOdA9vfvrr55pXliRdAYXHK+5vn3VmDDGAlpBAL2VQ1g4/qrYrG2F6Iaz5ti2V
         0jYSVicJdU1EJWrNLTijYJPaVnbLcTtjsrN1AuzHlvKTVLaYs5BWhPrDNAZ6F01gmPp9
         iBOyn6l5khLRVtfpo1BVDa1au/DLzLIUx7HaX4oJJI15TSVpGjS1q44aY7gKTbspTzPA
         ibdf/IkeH5J81qp8boZrwXHkbumSTSwL4YOzjlpzFPiet+7mKSi/ghl8lfg/LVNK6LhL
         kdXSleD7WBn1TtK79CIyQhrHmClF1OxZR7AMLe1qvvWRwS1boP+0fJ3AOpjKYGHospuF
         mTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282226; x=1710887026;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWLMAN2m3XvJpUk8zrNgDJNq5dK+J4+OJlHZxvNchPs=;
        b=m4obdX0waVprVLE/Ji5FqwxP3fS1zIVkgLB26oY06R39mM5vPVjwNol+bs3EQUwZzw
         sNUVSFuTIYN7T9F7S0Vj1wq8upgaVBzsTI9i51JAAx3NAIdZID9z3y8r9bJNtMsbfZ+o
         zVYcvanbTBN4t5ixgP5YQDBKq8uuN3WVliMjoEQODgvS01gh7B7PskdrS9KG2WLrrHoc
         sXR4u87jXd1a2lUI4rbctTxaLU34KKzHZJpUsy8v1wHfkKGVqiouZ/c3X+fMEJb8pOtx
         87sF7xYRSHb0KEEvhvIO8ynjdSJuc3QAVWtb1XSgThO+W4lPmA3ucZOTEwOAVzguqbZZ
         BwAg==
X-Gm-Message-State: AOJu0Yzvbe2/5jzc+JMOBiG+4wFsc5XWiugOlSC0aKMaSZWNbJbkn1NH
	a29WxSvxgYnKBQ+XCztCirFp6YtmEt5LosNlRioxyaDfsTUyJCSen4lP6B2R
X-Google-Smtp-Source: AGHT+IF3F0zgcsny42ia63KWkpCnpKXzaOAb+7zGmUClm0DqMIt5577t+KNOhGIJG2tDjASHmSFWrA==
X-Received: by 2002:a5d:43c8:0:b0:33e:6efa:757e with SMTP id v8-20020a5d43c8000000b0033e6efa757emr598225wrr.22.1710282225333;
        Tue, 12 Mar 2024 15:23:45 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b004131b2f3958sm255335wmq.13.2024.03.12.15.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:23:44 -0700 (PDT)
Message-ID: <303a7402-43f0-4f98-9aa1-b4eb660eead0@gmail.com>
Date: Wed, 13 Mar 2024 00:23:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8192DU is an older Wifi 4 dual band chip. It comes in two
flavours: single MAC single PHY (like most Realtek Wifi 4 USB devices),
and dual MAC dual PHY.

The single MAC single PHY version is 2T2R and can work either in the
2.4 GHz band or the 5 GHz band.

The dual MAC dual PHY version has two USB interfaces and appears to the
system as two separate 1T1R Wifi devices, one working in the 2.4 GHz
band, the other in the 5 GHz band.

This was tested only with a single MAC single PHY device.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---

Should I split this into multiple patches, one for each new file,
to make reviewing easier?

---
 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  788 +++++
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |  109 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1238 +++++++
 .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   24 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3064 +++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  236 ++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  310 ++
 .../wireless/realtek/rtlwifi/rtl8192du/sw.h   |   12 +
 .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++
 .../realtek/rtlwifi/rtl8192du/table.h         |   30 +
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  380 ++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
 21 files changed, 8033 insertions(+)
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

diff --git a/drivers/net/wireless/realtek/rtlwifi/Kconfig b/drivers/net/wireless/realtek/rtlwifi/Kconfig
index 2319eaa8845a..67efdf10e936 100644
--- a/drivers/net/wireless/realtek/rtlwifi/Kconfig
+++ b/drivers/net/wireless/realtek/rtlwifi/Kconfig
@@ -119,6 +119,18 @@ config RTL8192CU
 
 	If you choose to build it as a module, it will be called rtl8192cu
 
+config RTL8192DU
+	tristate "Realtek RTL8192DU USB Wireless Network Adapter"
+	depends on USB
+	select RTLWIFI
+	select RTLWIFI_USB
+	select RTL8192D_COMMON
+	help
+	This is the driver for Realtek RTL8192DU 802.11an USB
+	wireless network adapters.
+
+	If you choose to build it as a module, it will be called rtl8192du
+
 config RTLWIFI
 	tristate
 	select FW_LOADER
diff --git a/drivers/net/wireless/realtek/rtlwifi/Makefile b/drivers/net/wireless/realtek/rtlwifi/Makefile
index 423981b148df..9cf32277c7f1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/Makefile
+++ b/drivers/net/wireless/realtek/rtlwifi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_RTL8192CU)		+= rtl8192cu/
 obj-$(CONFIG_RTL8192SE)		+= rtl8192se/
 obj-$(CONFIG_RTL8192D_COMMON)	+= rtl8192d/
 obj-$(CONFIG_RTL8192DE)		+= rtl8192de/
+obj-$(CONFIG_RTL8192DU)		+= rtl8192du/
 obj-$(CONFIG_RTL8723AE)		+= rtl8723ae/
 obj-$(CONFIG_RTL8723BE)		+= rtl8723be/
 obj-$(CONFIG_RTL8188EE)		+= rtl8188ee/
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
new file mode 100644
index 000000000000..569bfd3d5030
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+rtl8192du-objs :=		\
+		dm.o		\
+		fw.o		\
+		hw.o		\
+		led.o		\
+		phy.o		\
+		rf.o		\
+		sw.o		\
+		table.o		\
+		trx.o
+
+obj-$(CONFIG_RTL8192DU) += rtl8192du.o
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
new file mode 100644
index 000000000000..3228d29d4c68
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../core.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "phy.h"
+#include "dm.h"
+#include "fw.h"
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
+static void rtl92d_dm_init_1r_cca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ps_t *dm_pstable = &rtlpriv->dm_pstable;
+
+	dm_pstable->pre_ccastate = CCA_MAX;
+	dm_pstable->cur_ccasate = CCA_MAX;
+}
+
+static void rtl92d_dm_1r_cca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ps_t *dm_pstable = &rtlpriv->dm_pstable;
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	int pwdb = rtlpriv->dm_digtable.min_undec_pwdb_for_dm;
+
+	if (rtlhal->macphymode != SINGLEMAC_SINGLEPHY ||
+	    rtlhal->current_bandtype != BAND_ON_5G)
+		return;
+
+	if (pwdb != 0) {
+		if (dm_pstable->pre_ccastate == CCA_2R ||
+		    dm_pstable->pre_ccastate == CCA_MAX)
+			dm_pstable->cur_ccasate = (pwdb >= 35) ? CCA_1R : CCA_2R;
+		else
+			dm_pstable->cur_ccasate = (pwdb <= 30) ? CCA_2R : CCA_1R;
+	} else {
+		dm_pstable->cur_ccasate = CCA_MAX;
+	}
+
+	if (dm_pstable->pre_ccastate == dm_pstable->cur_ccasate)
+		return;
+
+	rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_TRACE,
+		"Old CCA state: %d new CCA state: %d\n",
+		dm_pstable->pre_ccastate, dm_pstable->cur_ccasate);
+
+	if (dm_pstable->cur_ccasate == CCA_1R) {
+		if (rtlpriv->phy.rf_type == RF_2T2R)
+			rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x13);
+		else /* Is this branch reachable? */
+			rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x23);
+	} else { /* CCA_2R or CCA_MAX */
+		rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x33);
+	}
+}
+
+static void rtl92d_dm_pwdb_monitor(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	const u32 max_macid = 32;
+	u32 temp;
+
+	/* AP & ADHOC & MESH will return tmp */
+	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
+		return;
+
+	/* Indicate Rx signal strength to FW. */
+	if (rtlpriv->dm.useramask) {
+		temp = rtlpriv->dm.undec_sm_pwdb << 16;
+		temp |= max_macid << 8;
+
+		rtl92d_fill_h2c_cmd(hw, H2C_RSSI_REPORT, 3, (u8 *)(&temp));
+	} else {
+		rtl_write_byte(rtlpriv, 0x4fe, (u8)rtlpriv->dm.undec_sm_pwdb);
+	}
+}
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
+	rtl92d_phy_ap_calibrate(hw, (thermalvalue -
+				     rtlefuse->eeprom_thermalmeter));
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
+		rtl92d_phy_lc_calibrate(hw);
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
+		rtl92d_phy_iq_calibrate(hw);
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
+static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
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
+		return;
+	} else {
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking direct call!!\n");
+		rtl92d_dm_txpower_tracking_callback_thermalmeter(hw);
+		rtlpriv->dm.tm_trigger = 0;
+	}
+}
+
+void rtl92du_dm_init(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlpriv->dm.dm_type = DM_TYPE_BYDRIVER;
+	rtl_dm_diginit(hw, 0x20);
+	rtlpriv->dm_digtable.rx_gain_max = DM_DIG_FA_UPPER;
+	rtlpriv->dm_digtable.rx_gain_min = DM_DIG_FA_LOWER;
+	rtl92d_dm_init_edca_turbo(hw);
+	rtl92d_dm_init_1r_cca(hw);
+	rtl92d_dm_init_rate_adaptive_mask(hw);
+	rtl92d_dm_initialize_txpower_tracking(hw);
+}
+
+void rtl92du_dm_watchdog(struct ieee80211_hw *hw)
+{
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	bool fw_current_inpsmode = false;
+	bool fwps_awake = true;
+
+	/* 1. RF is OFF. (No need to do DM.)
+	 * 2. Fw is under power saving mode for FwLPS.
+	 *    (Prevent from SW/FW I/O racing.)
+	 * 3. IPS workitem is scheduled. (Prevent from IPS sequence
+	 *    to be swapped with DM.
+	 * 4. RFChangeInProgress is TRUE.
+	 *    (Prevent from broken by IPS/HW/SW Rf off.)
+	 */
+
+	if (ppsc->rfpwr_state == ERFON && !fw_current_inpsmode &&
+	    fwps_awake && !ppsc->rfchange_inprogress) {
+		rtl92d_dm_pwdb_monitor(hw);
+		rtl92d_dm_false_alarm_counter_statistics(hw);
+		rtl92d_dm_find_minimum_rssi(hw);
+		rtl92d_dm_dig(hw);
+		rtl92d_dm_check_txpower_tracking_thermal_meter(hw);
+		rtl92d_dm_check_edca_turbo(hw);
+		rtl92d_dm_1r_cca(hw);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
new file mode 100644
index 000000000000..d036cf722384
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef	__RTL92C_DM_H__
+#define __RTL92C_DM_H__
+
+void rtl92du_dm_init(struct ieee80211_hw *hw);
+void rtl92du_dm_watchdog(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
new file mode 100644
index 000000000000..05d2e22acd6e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../base.h"
+#include "../efuse.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "fw.h"
+#include "sw.h"
+
+int rtl92d_download_fw(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	enum version_8192d version = rtlhal->version;
+	bool fwdl_in_process = false;
+	bool fw_downloaded = false;
+	u32 fwsize, count;
+	u8 *pfwheader;
+	u8 *pfwdata;
+	u8 value;
+	int err;
+
+	if (rtlpriv->max_fw_size == 0 || !rtlhal->pfirmware)
+		return 1;
+
+	fwsize = rtlhal->fwsize;
+	pfwheader = rtlhal->pfirmware;
+	pfwdata = rtlhal->pfirmware;
+	rtlhal->fw_version = (u16)GET_FIRMWARE_HDR_VERSION(pfwheader);
+	rtlhal->fw_subversion = (u16)GET_FIRMWARE_HDR_SUB_VER(pfwheader);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
+		rtlhal->fw_version, rtlhal->fw_subversion,
+		GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
+	if (IS_FW_HEADER_EXIST(pfwheader)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Shift 32 bytes for FW header!!\n");
+		pfwdata = pfwdata + 32;
+		fwsize = fwsize - 32;
+	}
+
+	mutex_lock(&globalmutex_for_fwdownload);
+	fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
+	if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
+		fwdl_in_process = true;
+	else
+		fwdl_in_process = false;
+	if (fw_downloaded) {
+		mutex_unlock(&globalmutex_for_fwdownload);
+		goto exit;
+	} else if (fwdl_in_process) {
+		mutex_unlock(&globalmutex_for_fwdownload);
+		for (count = 0; count < 5000; count++) {
+			udelay(500);
+			mutex_lock(&globalmutex_for_fwdownload);
+			fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
+			if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
+				fwdl_in_process = true;
+			else
+				fwdl_in_process = false;
+			mutex_unlock(&globalmutex_for_fwdownload);
+			if (fw_downloaded)
+				goto exit;
+			else if (!fwdl_in_process)
+				break;
+			else
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Wait for another mac download fw\n");
+		}
+		mutex_lock(&globalmutex_for_fwdownload);
+		value = rtl_read_byte(rtlpriv, 0x1f);
+		value |= BIT(5);
+		rtl_write_byte(rtlpriv, 0x1f, value);
+		mutex_unlock(&globalmutex_for_fwdownload);
+	} else {
+		value = rtl_read_byte(rtlpriv, 0x1f);
+		value |= BIT(5);
+		rtl_write_byte(rtlpriv, 0x1f, value);
+		mutex_unlock(&globalmutex_for_fwdownload);
+	}
+
+	/* If 8051 is running in RAM code, driver should
+	 * inform Fw to reset by itself, or it will cause
+	 * download Fw fail.
+	 */
+	if (rtl_read_byte(rtlpriv, REG_MCUFWDL) & BIT(7)) {
+		rtl92d_firmware_selfreset(hw);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, 0x00);
+	}
+	rtl92d_enable_fw_download(hw, true);
+	rtl92d_write_fw(hw, version, pfwdata, fwsize);
+	rtl92d_enable_fw_download(hw, false);
+	mutex_lock(&globalmutex_for_fwdownload);
+	err = rtl92d_fw_free_to_go(hw);
+	/* download fw over,clear 0x1f[5] */
+	value = rtl_read_byte(rtlpriv, 0x1f);
+	value &= (~BIT(5));
+	rtl_write_byte(rtlpriv, 0x1f, value);
+	mutex_unlock(&globalmutex_for_fwdownload);
+	if (err)
+		pr_err("fw is not ready to run!\n");
+exit:
+	err = rtl92d_fw_init(hw);
+	return err;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
new file mode 100644
index 000000000000..857431fe8952
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D__FW__H__
+#define __RTL92D__FW__H__
+
+int rtl92d_download_fw(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
new file mode 100644
index 000000000000..c58b49627324
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
@@ -0,0 +1,1238 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../efuse.h"
+#include "../base.h"
+#include "../regd.h"
+#include "../cam.h"
+#include "../ps.h"
+#include "../pci.h"
+#include "../usb.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/hw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "phy.h"
+#include "dm.h"
+#include "fw.h"
+#include "led.h"
+#include "sw.h"
+#include "hw.h"
+#include "trx.h"
+
+static void _rtl92de_set_bcn_ctrl_reg(struct ieee80211_hw *hw,
+				      u8 set_bits, u8 clear_bits)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlusb->reg_bcn_ctrl_val |= set_bits;
+	rtlusb->reg_bcn_ctrl_val &= ~clear_bits;
+	rtl_write_byte(rtlpriv, REG_BCN_CTRL, (u8)rtlusb->reg_bcn_ctrl_val);
+}
+
+static void _rtl92de_enable_bcn_sub_func(struct ieee80211_hw *hw)
+{
+	_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(1));
+}
+
+static void _rtl92de_disable_bcn_sub_func(struct ieee80211_hw *hw)
+{
+	_rtl92de_set_bcn_ctrl_reg(hw, BIT(1), 0);
+}
+
+void rtl92du_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
+{
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+
+	switch (variable) {
+	case HW_VAR_RCR:
+		*((u32 *)val) = mac->rx_conf;
+		break;
+	default:
+		rtl92d_get_hw_reg(hw, variable, val);
+		break;
+	}
+}
+
+void rtl92du_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+
+	switch (variable) {
+	case HW_VAR_AC_PARAM: {
+		rtl92d_dm_init_edca_turbo(hw);
+		break;
+	}
+	case HW_VAR_ACM_CTRL: {
+		u8 e_aci = *val;
+		union aci_aifsn *p_aci_aifsn =
+		    (union aci_aifsn *)(&mac->ac[0].aifs);
+		u8 acm = p_aci_aifsn->f.acm;
+		u8 acm_ctrl = rtl_read_byte(rtlpriv, REG_ACMHWCTRL);
+
+		if (acm) {
+			switch (e_aci) {
+			case AC0_BE:
+				acm_ctrl |= ACMHW_BEQEN;
+				break;
+			case AC2_VI:
+				acm_ctrl |= ACMHW_VIQEN;
+				break;
+			case AC3_VO:
+				acm_ctrl |= ACMHW_VOQEN;
+				break;
+			default:
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
+					acm);
+				break;
+			}
+		} else {
+			switch (e_aci) {
+			case AC0_BE:
+				acm_ctrl &= (~ACMHW_BEQEN);
+				break;
+			case AC2_VI:
+				acm_ctrl &= (~ACMHW_VIQEN);
+				break;
+			case AC3_VO:
+				acm_ctrl &= (~ACMHW_VOQEN);
+				break;
+			default:
+				pr_err("%s:%d switch case %#x not processed\n",
+				       __func__, __LINE__, e_aci);
+				break;
+			}
+		}
+		rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+			"SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
+			acm_ctrl);
+		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
+		break;
+	}
+	case HW_VAR_RCR:
+		mac->rx_conf = ((u32 *)val)[0];
+		rtl_write_dword(rtlpriv, REG_RCR, mac->rx_conf);
+		break;
+	case HW_VAR_H2C_FW_JOINBSSRPT: {
+		u8 tmp_regcr, tmp_reg422;
+		bool recover = false;
+		u8 mstatus = *val;
+
+		if (mstatus == RT_MEDIA_CONNECT) {
+			rtlpriv->cfg->ops->set_hw_reg(hw,
+						      HW_VAR_AID, NULL);
+			tmp_regcr = rtl_read_byte(rtlpriv, REG_CR + 1);
+			rtl_write_byte(rtlpriv, REG_CR + 1,
+				       (tmp_regcr | BIT(0)));
+			_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(3));
+			_rtl92de_set_bcn_ctrl_reg(hw, BIT(4), 0);
+			tmp_reg422 = rtl_read_byte(rtlpriv,
+						   REG_FWHW_TXQ_CTRL + 2);
+			if (tmp_reg422 & BIT(6))
+				recover = true;
+			rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL + 2,
+				       tmp_reg422 & (~BIT(6)));
+
+			/* We don't implement FW LPS so this is not needed. */
+			/* rtl92d_set_fw_rsvdpagepkt(hw, 0); */
+
+			_rtl92de_set_bcn_ctrl_reg(hw, BIT(3), 0);
+			_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(4));
+			if (recover)
+				rtl_write_byte(rtlpriv,
+					       REG_FWHW_TXQ_CTRL + 2,
+					       tmp_reg422);
+			rtl_write_byte(rtlpriv, REG_CR + 1,
+				       (tmp_regcr & ~(BIT(0))));
+		}
+		rtl92d_set_fw_joinbss_report_cmd(hw, (*val));
+		break;
+	}
+	case HW_VAR_CORRECT_TSF: {
+		u8 btype_ibss = val[0];
+
+		if (btype_ibss)
+			rtl92de_stop_tx_beacon(hw);
+		_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(3));
+		rtl_write_dword(rtlpriv, REG_TSFTR,
+				(u32)(mac->tsf & 0xffffffff));
+		rtl_write_dword(rtlpriv, REG_TSFTR + 4,
+				(u32)((mac->tsf >> 32) & 0xffffffff));
+		_rtl92de_set_bcn_ctrl_reg(hw, BIT(3), 0);
+		if (btype_ibss)
+			rtl92de_resume_tx_beacon(hw);
+
+		break;
+	}
+	case HW_VAR_KEEP_ALIVE:
+		/* Avoid "switch case not processed" error. RTL8192DU doesn't
+		 * need to do anything here, maybe.
+		 */
+		break;
+	default:
+		rtl92d_set_hw_reg(hw, variable, val);
+		break;
+	}
+}
+
+static void _rtl92du_init_queue_reserved_page(struct ieee80211_hw *hw,
+					      u8 out_ep_num,
+					      u8 queue_sel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u32 txqpagenum, txqpageunit;
+	u32 txqremainingpage;
+	u32 numhq = 0;
+	u32 numlq = 0;
+	u32 numnq = 0;
+	u32 numpubq;
+	u32 value32;
+
+	if (rtlhal->macphymode != SINGLEMAC_SINGLEPHY) {
+		numpubq = NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC;
+		txqpagenum = TX_TOTAL_PAGE_NUMBER_92D_DUAL_MAC - numpubq;
+	} else {
+		numpubq = TEST_PAGE_NUM_PUBQ_92DU;
+		txqpagenum = TX_TOTAL_PAGE_NUMBER_92DU - numpubq;
+	}
+
+	if (rtlhal->macphymode != SINGLEMAC_SINGLEPHY && out_ep_num == 3) {
+		numhq = NORMAL_PAGE_NUM_HPQ_92D_DUAL_MAC;
+		numlq = NORMAL_PAGE_NUM_LPQ_92D_DUAL_MAC;
+		numnq = NORMAL_PAGE_NUM_NORMALQ_92D_DUAL_MAC;
+	} else {
+		txqpageunit = txqpagenum / out_ep_num;
+		txqremainingpage = txqpagenum % out_ep_num;
+
+		if (queue_sel & TX_SELE_HQ)
+			numhq = txqpageunit;
+		if (queue_sel & TX_SELE_LQ)
+			numlq = txqpageunit;
+		if (queue_sel & TX_SELE_NQ)
+			numnq = txqpageunit;
+
+		/* HIGH priority queue always present in the
+		 * configuration of 2 or 3 out-ep. Remainder pages
+		 * assigned to High queue
+		 */
+		if (out_ep_num > 1 && txqremainingpage)
+			numhq += txqremainingpage;
+	}
+
+	/* NOTE: This step done before writing REG_RQPN. */
+	rtl_write_byte(rtlpriv, REG_RQPN_NPQ, (u8)_NPQ(numnq));
+
+	/* TX DMA */
+	value32 = _HPQ(numhq) | _LPQ(numlq) | _PUBQ(numpubq) | LD_RQPN;
+	rtl_write_dword(rtlpriv, REG_RQPN, value32);
+}
+
+static void _rtl92du_init_tx_buffer_boundary(struct ieee80211_hw *hw,
+					     u8 txpktbuf_bndy)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtl_write_byte(rtlpriv, REG_TXPKTBUF_BCNQ_BDNY, txpktbuf_bndy);
+	rtl_write_byte(rtlpriv, REG_TXPKTBUF_MGQ_BDNY, txpktbuf_bndy);
+
+	rtl_write_byte(rtlpriv, REG_TXPKTBUF_WMAC_LBK_BF_HD, txpktbuf_bndy);
+
+	/* TXRKTBUG_PG_BNDY */
+	rtl_write_byte(rtlpriv, REG_TRXFF_BNDY, txpktbuf_bndy);
+
+	/* Beacon Head for TXDMA */
+	rtl_write_byte(rtlpriv, REG_TDECTRL + 1, txpktbuf_bndy);
+}
+
+static bool _rtl92de_llt_table_init(struct ieee80211_hw *hw, u8 txpktbuf_bndy)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	unsigned short i;
+	bool status;
+	u8 maxpage;
+
+	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY)
+		maxpage = 255;
+	else
+		maxpage = 127;
+
+	for (i = 0; i < (txpktbuf_bndy - 1); i++) {
+		status = rtl92de_llt_write(hw, i, i + 1);
+		if (!status)
+			return status;
+	}
+
+	/* end of list */
+	status = rtl92de_llt_write(hw, txpktbuf_bndy - 1, 0xFF);
+	if (!status)
+		return status;
+
+	/* Make the other pages as ring buffer */
+	/* This ring buffer is used as beacon buffer if we */
+	/* config this MAC as two MAC transfer. */
+	/* Otherwise used as local loopback buffer.  */
+	for (i = txpktbuf_bndy; i < maxpage; i++) {
+		status = rtl92de_llt_write(hw, i, (i + 1));
+		if (!status)
+			return status;
+	}
+
+	/* Let last entry point to the start entry of ring buffer */
+	status = rtl92de_llt_write(hw, maxpage, txpktbuf_bndy);
+	if (!status)
+		return status;
+
+	return true;
+}
+
+static void _rtl92d_init_chipn_reg_priority(struct ieee80211_hw *hw, u16 beq,
+					    u16 bkq, u16 viq, u16 voq,
+					    u16 mgtq, u16 hiq)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 value16;
+
+	value16 = rtl_read_word(rtlpriv, REG_TRXDMA_CTRL) & 0x7;
+	value16 |= _TXDMA_BEQ_MAP(beq) | _TXDMA_BKQ_MAP(bkq) |
+		   _TXDMA_VIQ_MAP(viq) | _TXDMA_VOQ_MAP(voq) |
+		   _TXDMA_MGQ_MAP(mgtq) | _TXDMA_HIQ_MAP(hiq);
+	rtl_write_word(rtlpriv,  REG_TRXDMA_CTRL, value16);
+}
+
+static void _rtl92du_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
+						    u8 queue_sel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 value;
+
+	switch (queue_sel) {
+	case TX_SELE_HQ:
+		value = QUEUE_HIGH;
+		break;
+	case TX_SELE_LQ:
+		value = QUEUE_LOW;
+		break;
+	case TX_SELE_NQ:
+		value = QUEUE_NORMAL;
+		break;
+	default:
+		WARN_ON(1); /* Shall not reach here! */
+		return;
+	}
+	_rtl92d_init_chipn_reg_priority(hw, value, value, value, value,
+					value, value);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Tx queue select: 0x%02x\n", queue_sel);
+}
+
+static void _rtl92du_init_chipn_two_out_ep_priority(struct ieee80211_hw *hw,
+						    u8 queue_sel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 beq, bkq, viq, voq, mgtq, hiq;
+	u16 valuehi, valuelow;
+
+	switch (queue_sel) {
+	default:
+		WARN_ON(1);
+		fallthrough;
+	case (TX_SELE_HQ | TX_SELE_LQ):
+		valuehi = QUEUE_HIGH;
+		valuelow = QUEUE_LOW;
+		break;
+	case (TX_SELE_NQ | TX_SELE_LQ):
+		valuehi = QUEUE_NORMAL;
+		valuelow = QUEUE_LOW;
+		break;
+	case (TX_SELE_HQ | TX_SELE_NQ):
+		valuehi = QUEUE_HIGH;
+		valuelow = QUEUE_NORMAL;
+		break;
+	}
+
+	beq = valuelow;
+	bkq = valuelow;
+	viq = valuehi;
+	voq = valuehi;
+	mgtq = valuehi;
+	hiq = valuehi;
+
+	_rtl92d_init_chipn_reg_priority(hw, beq, bkq, viq, voq, mgtq, hiq);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Tx queue select: 0x%02x\n", queue_sel);
+}
+
+static void _rtl92du_init_chipn_three_out_ep_priority(struct ieee80211_hw *hw,
+						      u8 queue_sel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 beq, bkq, viq, voq, mgtq, hiq;
+
+	beq = QUEUE_LOW;
+	bkq = QUEUE_LOW;
+	viq = QUEUE_NORMAL;
+	voq = QUEUE_HIGH;
+	mgtq = QUEUE_HIGH;
+	hiq = QUEUE_HIGH;
+
+	_rtl92d_init_chipn_reg_priority(hw, beq, bkq, viq, voq, mgtq, hiq);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Tx queue select: 0x%02x\n", queue_sel);
+}
+
+static void _rtl92du_init_queue_priority(struct ieee80211_hw *hw,
+					 u8 out_ep_num,
+					 u8 queue_sel)
+{
+	switch (out_ep_num) {
+	case 1:
+		_rtl92du_init_chipn_one_out_ep_priority(hw, queue_sel);
+		break;
+	case 2:
+		_rtl92du_init_chipn_two_out_ep_priority(hw, queue_sel);
+		break;
+	case 3:
+		_rtl92du_init_chipn_three_out_ep_priority(hw, queue_sel);
+		break;
+	default:
+		WARN_ON(1); /* Shall not reach here! */
+		break;
+	}
+}
+
+static void _rtl92du_init_wmac_setting(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+
+	mac->rx_conf = RCR_APM | RCR_AM | RCR_AB | RCR_ADF | RCR_APP_ICV |
+		       RCR_AMF | RCR_HTC_LOC_CTRL | RCR_APP_MIC |
+		       RCR_APP_PHYST_RXFF | RCR_APPFCS;
+
+	rtl_write_dword(rtlpriv, REG_RCR, mac->rx_conf);
+
+	/* Set Multicast Address. */
+	rtl_write_dword(rtlpriv, REG_MAR, 0xffffffff);
+	rtl_write_dword(rtlpriv, REG_MAR + 4, 0xffffffff);
+}
+
+static void _rtl92du_init_adaptive_ctrl(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 val32;
+
+	val32 = rtl_read_dword(rtlpriv, REG_RRSR);
+	val32 &= ~0xfffff;
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G)
+		val32 |= 0xffff0; /* No CCK */
+	else
+		val32 |= 0xffff1;
+	rtl_write_dword(rtlpriv, REG_RRSR, val32);
+
+	/* Set Spec SIFS (used in NAV) */
+	rtl_write_word(rtlpriv, REG_SPEC_SIFS, 0x1010);
+
+	/* Retry limit 0x30 */
+	rtl_write_word(rtlpriv, REG_RL, 0x3030);
+}
+
+static void _rtl92du_init_edca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 val16;
+
+	/* Disable EDCCA count down, to reduce collison and retry */
+	val16 = rtl_read_word(rtlpriv, REG_RD_CTRL);
+	val16 |= DIS_EDCA_CNT_DWN;
+	rtl_write_word(rtlpriv, REG_RD_CTRL, val16);
+
+	/* CCK SIFS shall always be 10us. */
+	rtl_write_word(rtlpriv, REG_SIFS_CTX, 0x0a0a);
+	/* Set SIFS for OFDM */
+	rtl_write_word(rtlpriv, REG_SIFS_TRX, 0x1010);
+
+	rtl_write_word(rtlpriv, REG_PROT_MODE_CTRL, 0x0204);
+
+	rtl_write_dword(rtlpriv, REG_BAR_MODE_CTRL, 0x014004);
+
+	/* TXOP */
+	rtl_write_dword(rtlpriv, REG_EDCA_BE_PARAM, 0x005EA42B);
+	rtl_write_dword(rtlpriv, REG_EDCA_BK_PARAM, 0x0000A44F);
+	rtl_write_dword(rtlpriv, REG_EDCA_VI_PARAM, 0x005EA324);
+	rtl_write_dword(rtlpriv, REG_EDCA_VO_PARAM, 0x002FA226);
+
+	rtl_write_byte(rtlpriv, REG_PIFS, 0x1C);
+
+	rtl_write_byte(rtlpriv, REG_AGGR_BREAK_TIME, 0x16);
+
+	rtl_write_word(rtlpriv, REG_NAV_PROT_LEN, 0x0040);
+
+	rtl_write_byte(rtlpriv, REG_BCNDMATIM, 0x2);
+	rtl_write_byte(rtlpriv, REG_ATIMWND, 0x2);
+}
+
+static void _rtl92du_init_retry_function(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 val8;
+
+	val8 = rtl_read_byte(rtlpriv, REG_FWHW_TXQ_CTRL);
+	val8 |= EN_AMPDU_RTY_NEW;
+	rtl_write_byte(rtlpriv, REG_FWHW_TXQ_CTRL, val8);
+
+	rtl_write_byte(rtlpriv, REG_ACKTO, 0x40);
+}
+
+static void _rtl92du_init_operation_mode(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+
+	rtl_write_byte(rtlpriv, REG_BWOPMODE, BW_OPMODE_20MHZ);
+
+	switch (rtlpriv->phy.rf_type) {
+	case RF_1T2R:
+	case RF_1T1R:
+		rtlhal->minspace_cfg = (MAX_MSS_DENSITY_1T << 3);
+		break;
+	case RF_2T2R:
+	case RF_2T2R_GREEN:
+		rtlhal->minspace_cfg = (MAX_MSS_DENSITY_2T << 3);
+		break;
+	}
+	rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE, rtlhal->minspace_cfg);
+}
+
+static void _rtl92du_init_beacon_parameters(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtl_write_word(rtlpriv, REG_BCN_CTRL, 0x1010);
+
+	rtl_write_word(rtlpriv, REG_TBTT_PROHIBIT, 0x3c02);
+	rtl_write_byte(rtlpriv, REG_DRVERLYINT, 0x05);
+	rtl_write_byte(rtlpriv, REG_BCNDMATIM, 0x03);
+
+	rtl_write_word(rtlpriv, REG_BCNTCFG, 0x660f);
+}
+
+static void _rtl92du_init_ampdu_aggregation(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+
+	/* Aggregation threshold */
+	if (rtlhal->macphymode == DUALMAC_DUALPHY)
+		rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, 0x66525541);
+	else if (rtlhal->macphymode == DUALMAC_SINGLEPHY)
+		rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, 0x44444441);
+	else
+		rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, 0x88728841);
+
+	rtl_write_byte(rtlpriv, REG_AGGR_BREAK_TIME, 0x16);
+}
+
+static bool _rtl92du_init_power_on(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	unsigned short wordtmp;
+	unsigned char bytetmp;
+	u16 retry;
+
+	retry = 0;
+	do {
+		if (rtl_read_byte(rtlpriv, REG_APS_FSMCO) & PFM_ALDN)
+			break;
+
+		if (retry++ > 1000)
+			return false;
+	} while (true);
+
+	/* Unlock ISO/CLK/Power control register */
+	rtl_write_byte(rtlpriv, REG_RSV_CTRL, 0x00);
+
+	/* SPS0_CTRL 0x11[7:0] = 0x2b  enable SPS into PWM mode */
+	rtl_write_byte(rtlpriv, REG_SPS0_CTRL, 0x2b);
+
+	msleep(1);
+
+	bytetmp = rtl_read_byte(rtlpriv, REG_LDOV12D_CTRL);
+	if ((bytetmp & LDV12_EN) == 0) {
+		bytetmp |= LDV12_EN;
+		rtl_write_byte(rtlpriv, REG_LDOV12D_CTRL, bytetmp);
+
+		msleep(1);
+
+		bytetmp = rtl_read_byte(rtlpriv, REG_SYS_ISO_CTRL);
+		bytetmp &= ~ISO_MD2PP;
+		rtl_write_byte(rtlpriv, REG_SYS_ISO_CTRL, bytetmp);
+	}
+
+	/* Auto enable WLAN */
+	wordtmp = rtl_read_word(rtlpriv, REG_APS_FSMCO);
+	wordtmp |= APFM_ONMAC;
+	rtl_write_word(rtlpriv, REG_APS_FSMCO, wordtmp);
+
+	wordtmp = rtl_read_word(rtlpriv, REG_APS_FSMCO);
+	retry = 0;
+	while ((wordtmp & APFM_ONMAC) && retry < 1000) {
+		retry++;
+		wordtmp = rtl_read_word(rtlpriv, REG_APS_FSMCO);
+	}
+
+	/* Release RF digital isolation */
+	wordtmp = rtl_read_word(rtlpriv, REG_SYS_ISO_CTRL);
+	wordtmp &= ~ISO_DIOR;
+	rtl_write_word(rtlpriv, REG_SYS_ISO_CTRL, wordtmp);
+
+	/* Enable MAC DMA/WMAC/SCHEDULE/SEC block */
+	wordtmp = rtl_read_word(rtlpriv, REG_CR);
+	wordtmp |= HCI_TXDMA_EN | HCI_RXDMA_EN | TXDMA_EN | RXDMA_EN |
+		   PROTOCOL_EN | SCHEDULE_EN | MACTXEN | MACRXEN | ENSEC;
+	rtl_write_word(rtlpriv, REG_CR, wordtmp);
+
+	return true;
+}
+
+static bool _rtl92de_init_mac(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 val8;
+
+	rtl_write_byte(rtlpriv, REG_RSV_CTRL, 0x00);
+
+	val8 = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
+	val8 &= ~(FEN_MREGEN >> 8);
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, val8);
+
+	/* For s3/s4 may reset mac, Reg0xf8 may be set to 0,
+	 * so reset macphy control reg here.
+	 */
+	rtl92d_phy_config_macphymode(hw);
+
+	rtl92d_phy_set_poweron(hw);
+
+	if (!_rtl92du_init_power_on(hw)) {
+		pr_err("Failed to init power on!\n");
+		return false;
+	}
+
+	rtl92d_phy_config_maccoexist_rfpage(hw);
+
+	return true;
+}
+
+int rtl92du_hw_init(struct ieee80211_hw *hw)
+{
+	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
+	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 val8, txpktbuf_bndy;
+	unsigned long flags;
+	int err, i;
+	u32 val32;
+	u16 val16;
+
+	/* As this function can take a very long time
+	 * and can be called with irqs disabled, reenable the irqs
+	 * to let the other devices continue being serviced.
+	 *
+	 * It is safe doing so since our own interrupts will only be enabled
+	 * in a subsequent step.
+	 */
+	local_save_flags(flags);
+	local_irq_enable();
+
+	/* Let the first starting mac load RF parameters and do LCK */
+	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+	    ((rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) ||
+	     (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G)))
+		mutex_lock(&globalmutex_for_mac0_2g_mac1_5g);
+
+	mutex_lock(&globalmutex_for_power_and_efuse);
+
+	/* we should do iqk after disable/enable */
+	rtl92d_phy_reset_iqk_result(hw);
+
+	if (!_rtl92de_init_mac(hw)) {
+		pr_err("Init MAC failed\n");
+		mutex_unlock(&globalmutex_for_power_and_efuse);
+		if (mutex_is_locked(&globalmutex_for_mac0_2g_mac1_5g))
+			mutex_unlock(&globalmutex_for_mac0_2g_mac1_5g);
+		return 1;
+	}
+
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY)
+		txpktbuf_bndy = 249;
+	else
+		txpktbuf_bndy = 123;
+
+	if (!_rtl92de_llt_table_init(hw, txpktbuf_bndy)) {
+		pr_err("Init LLT failed\n");
+		mutex_unlock(&globalmutex_for_power_and_efuse);
+		if (mutex_is_locked(&globalmutex_for_mac0_2g_mac1_5g))
+			mutex_unlock(&globalmutex_for_mac0_2g_mac1_5g);
+		return 1;
+	}
+
+	err = rtl92d_download_fw(hw);
+	mutex_unlock(&globalmutex_for_power_and_efuse);
+
+	/* return fail only when part number check fail */
+	if (err && rtl_read_byte(rtlpriv, 0x1c5) == 0xe0) {
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW..\n");
+		if (mutex_is_locked(&globalmutex_for_mac0_2g_mac1_5g))
+			mutex_unlock(&globalmutex_for_mac0_2g_mac1_5g);
+		return 1;
+	}
+	rtlhal->last_hmeboxnum = 0;
+	rtlpriv->psc.fw_current_inpsmode = false;
+
+	rtl92d_phy_mac_config(hw);
+
+	/* Set reserved page for each queue */
+	_rtl92du_init_queue_reserved_page(hw, rtlusb->out_ep_nums,
+					  rtlusb->out_queue_sel);
+
+	_rtl92du_init_tx_buffer_boundary(hw, txpktbuf_bndy);
+
+	_rtl92du_init_queue_priority(hw, rtlusb->out_ep_nums,
+				     rtlusb->out_queue_sel);
+
+	/* Set Tx/Rx page size (Tx must be 128 Bytes,
+	 * Rx can be 64, 128, 256, 512, 1024 bytes)
+	 */
+	rtl_write_byte(rtlpriv, REG_PBP, 0x11);
+
+	/* Get Rx PHY status in order to report RSSI and others. */
+	rtl_write_byte(rtlpriv, REG_RX_DRVINFO_SZ, 0x4);
+
+	rtl_write_dword(rtlpriv, REG_HISR, 0xffffffff);
+	rtl_write_dword(rtlpriv, REG_HIMR, 0xffffffff);
+
+	val8 = rtl_read_byte(rtlpriv, MSR);
+	val8 &= ~MSR_MASK;
+	val8 |= MSR_INFRA;
+	rtl_write_byte(rtlpriv, MSR, val8);
+
+	_rtl92du_init_wmac_setting(hw);
+	_rtl92du_init_adaptive_ctrl(hw);
+	_rtl92du_init_edca(hw);
+
+	rtl_write_dword(rtlpriv, REG_DARFRC, 0x00000000);
+	rtl_write_dword(rtlpriv, REG_DARFRC + 4, 0x10080404);
+	rtl_write_dword(rtlpriv, REG_RARFRC, 0x04030201);
+	rtl_write_dword(rtlpriv, REG_RARFRC + 4, 0x08070605);
+
+	_rtl92du_init_retry_function(hw);
+	/* _InitUsbAggregationSetting(padapter); no aggregation for now */
+	_rtl92du_init_operation_mode(hw);
+	_rtl92du_init_beacon_parameters(hw);
+	_rtl92du_init_ampdu_aggregation(hw);
+
+	rtl_write_byte(rtlpriv, REG_BCN_MAX_ERR, 0xff);
+
+	/* unit: 256us. 256ms */
+	rtl_write_word(rtlpriv, REG_PKT_VO_VI_LIFE_TIME, 0x0400);
+	rtl_write_word(rtlpriv, REG_PKT_BE_BK_LIFE_TIME, 0x0400);
+
+	/* Hardware-controlled blinking. */
+	rtl_write_word(rtlpriv, REG_LEDCFG0, 0x8282);
+	rtl_write_byte(rtlpriv, REG_LEDCFG2, 0x82);
+
+	val32 = rtl_read_dword(rtlpriv, REG_TXDMA_OFFSET_CHK);
+	val32 |= DROP_DATA_EN;
+	rtl_write_dword(rtlpriv, REG_TXDMA_OFFSET_CHK, val32);
+
+	if (mac->rdg_en) {
+		rtl_write_byte(rtlpriv, REG_RD_CTRL, 0xff);
+		rtl_write_word(rtlpriv, REG_RD_NAV_NXT, 0x200);
+		rtl_write_byte(rtlpriv, REG_RD_RESP_PKT_TH, 0x05);
+	}
+
+	for (i = 0; i < 4; i++)
+		rtl_write_dword(rtlpriv, REG_ARFR0 + i * 4, 0x1f8ffff0);
+
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY) {
+		if (rtlusb->out_ep_nums == 2)
+			rtl_write_dword(rtlpriv, REG_FAST_EDCA_CTRL, 0x03066666);
+		else
+			rtl_write_word(rtlpriv, REG_FAST_EDCA_CTRL, 0x8888);
+	} else {
+		rtl_write_word(rtlpriv, REG_FAST_EDCA_CTRL, 0x5555);
+	}
+
+	val8 = rtl_read_byte(rtlpriv, 0x605);
+	val8 |= 0xf0;
+	rtl_write_byte(rtlpriv, 0x605, val8);
+
+	rtl_write_byte(rtlpriv, REG_RXTSF_OFFSET_CCK, 0x30);
+	rtl_write_byte(rtlpriv, REG_RXTSF_OFFSET_OFDM, 0x30);
+	rtl_write_byte(rtlpriv, 0x606, 0x30);
+
+	/* temp for high queue and mgnt Queue corrupt in time; it may
+	 * cause hang when sw beacon use high_Q, other frame use mgnt_Q;
+	 * or, sw beacon use mgnt_Q, other frame use high_Q;
+	 */
+	rtl_write_byte(rtlpriv, REG_DIS_TXREQ_CLR, 0x10);
+	val16 = rtl_read_word(rtlpriv, REG_RD_CTRL);
+	val16 |= BIT(12);
+	rtl_write_word(rtlpriv, REG_RD_CTRL, val16);
+
+	rtl_write_byte(rtlpriv, REG_TXPAUSE, 0);
+
+	/* usb suspend idle time count for bitfile0927 */
+	val8 = rtl_read_byte(rtlpriv, 0xfe56);
+	val8 |= BIT(0) | BIT(1);
+	rtl_write_byte(rtlpriv, 0xfe56, val8);
+
+	if (rtlhal->earlymode_enable) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"EarlyMode Enabled!!!\n");
+
+		val8 = rtl_read_byte(rtlpriv, REG_EARLY_MODE_CONTROL);
+		val8 |= 0x1f;
+		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, val8);
+
+		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL + 3, 0x80);
+
+		val8 = rtl_read_byte(rtlpriv, 0x605);
+		val8 |= 0x40;
+		rtl_write_byte(rtlpriv, 0x605, val8);
+	} else {
+		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0);
+	}
+
+	rtl92d_phy_bb_config(hw);
+
+	rtlphy->rf_mode = RF_OP_BY_SW_3WIRE;
+	/* set before initialize RF */
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0xf);
+
+	/* config RF */
+	rtl92d_phy_rf_config(hw);
+
+	/* set default value after initialize RF */
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0);
+
+	/* After load BB, RF params, we need to do more for 92D. */
+	rtl92d_update_bbrf_configuration(hw);
+
+	rtlphy->rfreg_chnlval[0] = rtl_get_rfreg(hw, RF90_PATH_A,
+						 RF_CHNLBW,
+						 RFREG_OFFSET_MASK);
+	rtlphy->rfreg_chnlval[1] = rtl_get_rfreg(hw, RF90_PATH_B,
+						 RF_CHNLBW,
+						 RFREG_OFFSET_MASK);
+
+	/*---- Set CCK and OFDM Block "ON"----*/
+	if (rtlhal->current_bandtype == BAND_ON_2_4G)
+		rtl_set_bbreg(hw, RFPGA0_RFMOD, BCCKEN, 0x1);
+	rtl_set_bbreg(hw, RFPGA0_RFMOD, BOFDMEN, 0x1);
+
+	/* reset hw sec */
+	rtl_cam_reset_all_entry(hw);
+	rtl92de_enable_hw_security_config(hw);
+
+	rtl_write_byte(rtlpriv, REG_HWSEQ_CTRL, 0xFF);
+
+	/* schmitt trigger, improve tx evm for 92du */
+	val8 = rtl_read_byte(rtlpriv, REG_AFE_XTAL_CTRL);
+	val8 |= BIT(1);
+	rtl_write_byte(rtlpriv, REG_AFE_XTAL_CTRL, val8);
+
+	/* Disable bar */
+	rtl_write_dword(rtlpriv, REG_BAR_MODE_CTRL, 0xffff);
+
+	/* Nav limit */
+	rtl_write_byte(rtlpriv, REG_NAV_CTRL + 2, 0);
+	rtl_write_byte(rtlpriv, ROFDM0_XATXAFE + 3, 0x50);
+
+	/* Read EEPROM TX power index and PHY_REG_PG.txt to capture correct
+	 * TX power index for different rate set.
+	 */
+	rtl92d_phy_get_hw_reg_originalvalue(hw);
+
+	ppsc->rfpwr_state = ERFON;
+
+	/* do IQK for 2.4G for better scan result */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G)
+		rtl92d_phy_iq_calibrate(hw);
+
+	rtl92d_phy_lc_calibrate(hw);
+
+	if (mutex_is_locked(&globalmutex_for_mac0_2g_mac1_5g))
+		mutex_unlock(&globalmutex_for_mac0_2g_mac1_5g);
+
+	rtl92du_phy_init_pa_bias(hw);
+
+	rtl92du_dm_init(hw);
+
+	/* For 2 PORT TSF SYNC */
+	rtl_write_word(rtlpriv, REG_BCN_CTRL, 0x1818);
+	rtlusb->reg_bcn_ctrl_val = 0x18;
+
+	udelay(500);
+
+	if (rtlhal->macphymode != DUALMAC_DUALPHY) {
+		rtl_write_dword(rtlpriv, RFPGA1_TXINFO,
+				rtl_read_dword(rtlpriv, RFPGA1_TXINFO) & ~BIT(30));
+
+		rtl_write_dword(rtlpriv, RFPGA0_TXGAINSTAGE,
+				rtl_read_dword(rtlpriv, RFPGA0_TXGAINSTAGE) & ~BIT(31));
+
+		rtl_write_dword(rtlpriv, ROFDM0_XBTXAFE, 0xa0e40000);
+	}
+
+	val32 = rtl_read_dword(rtlpriv, REG_FWHW_TXQ_CTRL);
+	val32 |= BIT(12);
+	rtl_write_dword(rtlpriv, REG_FWHW_TXQ_CTRL, val32);
+
+	local_irq_disable();
+	local_irq_restore(flags);
+
+	return err;
+}
+
+static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
+				     enum nl80211_iftype type)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	enum led_ctl_mode ledaction = LED_CTL_NO_LINK;
+	u8 bt_msr = rtl_read_byte(rtlpriv, MSR);
+
+	bt_msr &= 0xfc;
+
+	if (type == NL80211_IFTYPE_UNSPECIFIED ||
+	    type == NL80211_IFTYPE_STATION) {
+		rtl92de_stop_tx_beacon(hw);
+		_rtl92de_enable_bcn_sub_func(hw);
+	} else if (type == NL80211_IFTYPE_ADHOC ||
+		type == NL80211_IFTYPE_AP) {
+		rtl92de_resume_tx_beacon(hw);
+		_rtl92de_disable_bcn_sub_func(hw);
+	} else {
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x)\n",
+			type);
+	}
+	switch (type) {
+	case NL80211_IFTYPE_UNSPECIFIED:
+		bt_msr |= MSR_NOLINK;
+		ledaction = LED_CTL_LINK;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		bt_msr |= MSR_ADHOC;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Ad Hoc!\n");
+		break;
+	case NL80211_IFTYPE_STATION:
+		bt_msr |= MSR_INFRA;
+		ledaction = LED_CTL_LINK;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to STA!\n");
+		break;
+	case NL80211_IFTYPE_AP:
+		bt_msr |= MSR_AP;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to AP!\n");
+		break;
+	default:
+		pr_err("Network type %d not supported!\n", type);
+		return 1;
+	}
+	rtl_write_byte(rtlpriv, MSR, bt_msr);
+	rtlpriv->cfg->ops->led_control(hw, ledaction);
+	if ((bt_msr & MSR_MASK) == MSR_AP)
+		rtl_write_byte(rtlpriv, REG_BCNTCFG + 1, 0x00);
+	else
+		rtl_write_byte(rtlpriv, REG_BCNTCFG + 1, 0x66);
+	return 0;
+}
+
+void rtl92de_set_check_bssid(struct ieee80211_hw *hw, bool check_bssid)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 reg_rcr;
+
+	if (rtlpriv->psc.rfpwr_state != ERFON)
+		return;
+
+	rtlpriv->cfg->ops->get_hw_reg(hw, HW_VAR_RCR, (u8 *)(&reg_rcr));
+
+	if (check_bssid) {
+		reg_rcr |= (RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_RCR, (u8 *)(&reg_rcr));
+		_rtl92de_set_bcn_ctrl_reg(hw, 0, BIT(4));
+	} else if (!check_bssid) {
+		reg_rcr &= (~(RCR_CBSSID_DATA | RCR_CBSSID_BCN));
+		_rtl92de_set_bcn_ctrl_reg(hw, BIT(4), 0);
+		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_RCR, (u8 *)(&reg_rcr));
+	}
+}
+
+int rtl92de_set_network_type(struct ieee80211_hw *hw, enum nl80211_iftype type)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	if (_rtl92de_set_media_status(hw, type))
+		return -EOPNOTSUPP;
+
+	/* check bssid */
+	if (rtlpriv->mac80211.link_state == MAC80211_LINKED) {
+		if (type != NL80211_IFTYPE_AP)
+			rtl92de_set_check_bssid(hw, true);
+	} else {
+		rtl92de_set_check_bssid(hw, false);
+	}
+	return 0;
+}
+
+/* do iqk or reload iqk */
+/* windows just rtl92d_phy_reload_iqk_setting in set channel,
+ * but it's very strict for time sequence so we add
+ * rtl92d_phy_reload_iqk_setting here
+ */
+void rtl92d_linked_set_reg(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 channel = rtlphy->current_channel;
+	u8 indexforchannel;
+
+	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
+	if (!rtlphy->iqk_matrix[indexforchannel].iqk_done) {
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_INIT, DBG_DMESG,
+			"Do IQK for channel:%d\n", channel);
+		rtl92d_phy_iq_calibrate(hw);
+	}
+}
+
+void rtl92de_enable_interrupt(struct ieee80211_hw *hw)
+{
+	/* Nothing to do. */
+}
+
+void rtl92de_disable_interrupt(struct ieee80211_hw *hw)
+{
+	/* Nothing to do. */
+}
+
+static void _rtl92du_poweroff_adapter(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 delay = 100;
+	u8 u1b_tmp;
+	u16 val16;
+	u32 val32;
+
+	rtl_write_byte(rtlpriv, REG_LDOA15_CTRL, 0x04);
+
+	rtl_write_byte(rtlpriv, REG_RF_CTRL, 0x00);
+
+	/* IF fw in RAM code, do reset */
+	if (rtl_read_byte(rtlpriv, REG_MCUFWDL) & MCUFWDL_RDY) {
+		rtl_write_byte(rtlpriv, REG_FSIMR, 0);
+
+		/* We need to disable other HRCV INT to influence 8051 reset. */
+		rtl_write_byte(rtlpriv, REG_FWIMR, 0x20);
+
+		/* Close mask to prevent incorrect FW write operation. */
+		rtl_write_byte(rtlpriv, REG_FTIMR, 0);
+
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, 0);
+
+		/* Set (REG_HMETFR + 3) to 0x20 is reset 8051 */
+		rtl_write_byte(rtlpriv, REG_HMETFR + 3, 0x20);
+		val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN);
+		while (val16 & FEN_CPUEN) {
+			delay--;
+			if (delay == 0)
+				break;
+			udelay(50);
+			val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN);
+		}
+
+		if (delay == 0) {
+			rtl_write_byte(rtlpriv, REG_FWIMR, 0);
+
+			/* if 8051 reset fail, reset MAC directly. */
+			rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, 0x50);
+
+			mdelay(10);
+		}
+	}
+
+	/* reset MCU, MAC register, DCORE */
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, 0x54);
+
+	/* reset MCU ready status */
+	rtl_write_byte(rtlpriv, REG_MCUFWDL, 0x00);
+
+	/* Pull GPIO PIN to balance level and LED control */
+
+	/* Disable GPIO[7:0] */
+	rtl_write_word(rtlpriv, REG_GPIO_PIN_CTRL + 2, 0x0000);
+	val32 = rtl_read_dword(rtlpriv, REG_GPIO_PIN_CTRL);
+	u32p_replace_bits(&val32, val32 & 0xff, 0x0000ff00);
+	u32p_replace_bits(&val32, 0xff, 0x00ff0000);
+	rtl_write_dword(rtlpriv, REG_GPIO_PIN_CTRL, val32);
+
+	/* Disable GPIO[10:8] */
+	rtl_write_byte(rtlpriv, REG_MAC_PINMUX_CFG, 0);
+	val16 = rtl_read_word(rtlpriv, REG_GPIO_IO_SEL);
+	u16p_replace_bits(&val16, val16 & 0xf, 0x00f0);
+	u16p_replace_bits(&val16, 0xf, 0x0780);
+	rtl_write_word(rtlpriv, REG_GPIO_IO_SEL, val16);
+
+	/* Disable LED 0, 1, and 2 */
+	rtl_write_word(rtlpriv, REG_LEDCFG0, 0x8888);
+	rtl_write_byte(rtlpriv, REG_LEDCFG2, 0x88);
+
+	/* Disable analog sequence */
+
+	/* enter PFM mode */
+	rtl_write_byte(rtlpriv, REG_SPS0_CTRL, 0x23);
+
+	rtl_write_word(rtlpriv, REG_APS_FSMCO,
+		       APDM_HOST | AFSM_HSUS | PFM_ALDN);
+
+	/* lock ISO/CLK/Power control register */
+	rtl_write_byte(rtlpriv, REG_RSV_CTRL, 0x0e);
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"In PowerOff,reg0x%x=%X\n",
+		REG_SPS0_CTRL, rtl_read_byte(rtlpriv, REG_SPS0_CTRL));
+
+	/* 0x17[7] 1b': power off in process  0b' : power off over */
+	if (rtlpriv->rtlhal.macphymode != SINGLEMAC_SINGLEPHY) {
+		mutex_lock(&globalmutex_power);
+		u1b_tmp = rtl_read_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS);
+		u1b_tmp &= (~BIT(7));
+		rtl_write_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS, u1b_tmp);
+		mutex_unlock(&globalmutex_power);
+	}
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<=======\n");
+}
+
+void rtl92du_card_disable(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	enum nl80211_iftype opmode;
+	u32 val32;
+	u16 val16;
+	u8 val8;
+
+	mac->link_state = MAC80211_NOLINK;
+	opmode = NL80211_IFTYPE_UNSPECIFIED;
+	_rtl92de_set_media_status(hw, opmode);
+
+	RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
+	/* Power sequence for each MAC. */
+	/* a. stop tx DMA  */
+	/* b. close RF */
+	/* c. clear rx buf */
+	/* d. stop rx DMA */
+	/* e. reset MAC */
+
+	val16 = rtl_read_word(rtlpriv, REG_GPIO_MUXCFG);
+	val16 &= ~BIT(12);
+	rtl_write_word(rtlpriv, REG_GPIO_MUXCFG, val16);
+
+	rtl_write_byte(rtlpriv, REG_TXPAUSE, 0xff);
+	udelay(500);
+	rtl_write_byte(rtlpriv, REG_CR, 0);
+
+	/* RF OFF sequence */
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0xf);
+	rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x00);
+
+	rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x40);
+
+	val8 = FEN_USBD | FEN_USBA | FEN_BB_GLB_RSTN;
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, val8);
+
+	/* Mac0 can not do Global reset. Mac1 can do. */
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY ||
+	    rtlhal->interfaceindex == 1) {
+		/* before BB reset should do clock gated */
+		val32 = rtl_read_dword(rtlpriv, RFPGA0_XCD_RFPARAMETER);
+		val32 |= BIT(31);
+		rtl_write_dword(rtlpriv, RFPGA0_XCD_RFPARAMETER, val32);
+
+		val8 &= ~FEN_BB_GLB_RSTN;
+		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, val8);
+	}
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==> Do power off.......\n");
+	if (!rtl92d_phy_check_poweroff(hw))
+		return;
+
+	_rtl92du_poweroff_adapter(hw);
+}
+
+void rtl92de_set_beacon_related_registers(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	u16 bcn_interval, atim_window;
+
+	bcn_interval = mac->beacon_interval;
+	atim_window = 2;
+	rtl92de_disable_interrupt(hw);
+	rtl_write_word(rtlpriv, REG_ATIMWND, atim_window);
+	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
+	rtl_write_word(rtlpriv, REG_BCNTCFG, 0x660f);
+	rtl_write_byte(rtlpriv, REG_RXTSF_OFFSET_CCK, 0x20);
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G)
+		rtl_write_byte(rtlpriv, REG_RXTSF_OFFSET_OFDM, 0x30);
+	else
+		rtl_write_byte(rtlpriv, REG_RXTSF_OFFSET_OFDM, 0x20);
+	rtl_write_byte(rtlpriv, 0x606, 0x30);
+}
+
+void rtl92de_set_beacon_interval(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
+	u16 bcn_interval = mac->beacon_interval;
+
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
+	rtl92de_disable_interrupt(hw);
+	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
+	rtl92de_enable_interrupt(hw);
+}
+
+void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
+				   u32 add_msr, u32 rm_msr)
+{
+	/* Nothing to do here. */
+}
+
+void rtl92du_read_chip_version(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	/* Chip version reading is done in rtl92de_read_eeprom_info. */
+
+	rtlpriv->rtlhal.hw_type = HARDWARE_TYPE_RTL8192DU;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
new file mode 100644
index 000000000000..731aa3b78d07
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_HW_H__
+#define __RTL92DE_HW_H__
+
+void rtl92du_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
+void rtl92du_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val);
+void rtl92du_read_chip_version(struct ieee80211_hw *hw);
+int rtl92du_hw_init(struct ieee80211_hw *hw);
+void rtl92du_card_disable(struct ieee80211_hw *hw);
+void rtl92de_enable_interrupt(struct ieee80211_hw *hw);
+void rtl92de_disable_interrupt(struct ieee80211_hw *hw);
+int rtl92de_set_network_type(struct ieee80211_hw *hw, enum nl80211_iftype type);
+void rtl92de_set_check_bssid(struct ieee80211_hw *hw, bool check_bssid);
+void rtl92de_set_beacon_related_registers(struct ieee80211_hw *hw);
+void rtl92de_set_beacon_interval(struct ieee80211_hw *hw);
+void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
+				   u32 add_msr, u32 rm_msr);
+void rtl92de_suspend(struct ieee80211_hw *hw);
+void rtl92de_resume(struct ieee80211_hw *hw);
+void rtl92d_linked_set_reg(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
new file mode 100644
index 000000000000..a2761f25e94e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "led.h"
+
+void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
+{
+	/* The hardware has control. */
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
new file mode 100644
index 000000000000..b7f7a74d5261
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92CE_LED_H__
+#define __RTL92CE_LED_H__
+
+void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
new file mode 100644
index 000000000000..7628847d4ede
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
@@ -0,0 +1,3064 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../ps.h"
+#include "../core.h"
+#include "../efuse.h"
+#include "../usb.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/rf_common.h"
+#include "phy.h"
+#include "rf.h"
+#include "dm.h"
+#include "table.h"
+#include "sw.h"
+#include "hw.h"
+
+#define MAX_RF_IMR_INDEX			12
+#define MAX_RF_IMR_INDEX_NORMAL			13
+#define RF_REG_NUM_FOR_C_CUT_5G			6
+#define RF_REG_NUM_FOR_C_CUT_5G_INTERNALPA	7
+#define RF_REG_NUM_FOR_C_CUT_2G			5
+#define RF_CHNL_NUM_5G				19
+#define RF_CHNL_NUM_5G_40M			17
+#define TARGET_CHNL_NUM_5G			221
+#define TARGET_CHNL_NUM_2G			14
+#define CV_CURVE_CNT				64
+
+static u32 rf_reg_for_5g_swchnl_normal[MAX_RF_IMR_INDEX_NORMAL] = {
+	0, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x0
+};
+
+static u8 rf_reg_for_c_cut_5g[RF_REG_NUM_FOR_C_CUT_5G] = {
+	RF_SYN_G1, RF_SYN_G2, RF_SYN_G3, RF_SYN_G4, RF_SYN_G5, RF_SYN_G6
+};
+
+static u8 rf_reg_for_c_cut_2g[RF_REG_NUM_FOR_C_CUT_2G] = {
+	RF_SYN_G1, RF_SYN_G2, RF_SYN_G3, RF_SYN_G7, RF_SYN_G8
+};
+
+static u8 rf_for_c_cut_5g_internal_pa[RF_REG_NUM_FOR_C_CUT_5G_INTERNALPA] = {
+	0x0B, 0x48, 0x49, 0x4B, 0x03, 0x04, 0x0E
+};
+
+static u32 rf_reg_mask_for_c_cut_2g[RF_REG_NUM_FOR_C_CUT_2G] = {
+	BIT(19) | BIT(18) | BIT(17) | BIT(14) | BIT(1),
+	BIT(10) | BIT(9),
+	BIT(18) | BIT(17) | BIT(16) | BIT(1),
+	BIT(2) | BIT(1),
+	BIT(15) | BIT(14) | BIT(13) | BIT(12) | BIT(11)
+};
+
+static u8 rf_chnl_5g[RF_CHNL_NUM_5G] = {
+	36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108,
+	112, 116, 120, 124, 128, 132, 136, 140
+};
+
+static u8 rf_chnl_5g_40m[RF_CHNL_NUM_5G_40M] = {
+	38, 42, 46, 50, 54, 58, 62, 102, 106, 110, 114,
+	118, 122, 126, 130, 134, 138
+};
+
+static u32 rf_reg_pram_c_5g[5][RF_REG_NUM_FOR_C_CUT_5G] = {
+	{0xE43BE, 0xFC638, 0x77C0A, 0xDE471, 0xd7110, 0x8EB04},
+	{0xE43BE, 0xFC078, 0xF7C1A, 0xE0C71, 0xD7550, 0xAEB04},
+	{0xE43BF, 0xFF038, 0xF7C0A, 0xDE471, 0xE5550, 0xAEB04},
+	{0xE43BF, 0xFF079, 0xF7C1A, 0xDE471, 0xE5550, 0xAEB04},
+	{0xE43BF, 0xFF038, 0xF7C1A, 0xDE471, 0xd7550, 0xAEB04}
+};
+
+static u32 rf_reg_param_for_c_cut_2g[3][RF_REG_NUM_FOR_C_CUT_2G] = {
+	{0x643BC, 0xFC038, 0x77C1A, 0x41289, 0x01840},
+	{0x643BC, 0xFC038, 0x07C1A, 0x41289, 0x01840},
+	{0x243BC, 0xFC438, 0x07C1A, 0x4128B, 0x0FC41}
+};
+
+static u32 rf_syn_g4_for_c_cut_2g = 0xD1C31 & 0x7FF;
+
+static u32 rf_pram_c_5g_int_pa[3][RF_REG_NUM_FOR_C_CUT_5G_INTERNALPA] = {
+	{0x01a00, 0x40443, 0x00eb5, 0x89bec, 0x94a12, 0x94a12, 0x94a12},
+	{0x01800, 0xc0443, 0x00730, 0x896ee, 0x94a52, 0x94a52, 0x94a52},
+	{0x01800, 0xc0443, 0x00730, 0x896ee, 0x94a12, 0x94a12, 0x94a12}
+};
+
+/* [mode][patha+b][reg] */
+static u32 rf_imr_param_normal[1][3][MAX_RF_IMR_INDEX_NORMAL] = {
+	{
+		/* channel 1-14. */
+		{
+			0x70000, 0x00ff0, 0x4400f, 0x00ff0, 0x0, 0x0, 0x0,
+			0x0, 0x0, 0x64888, 0xe266c, 0x00090, 0x22fff
+		},
+		/* path 36-64 */
+		{
+			0x70000, 0x22880, 0x4470f, 0x55880, 0x00070, 0x88000,
+			0x0, 0x88080, 0x70000, 0x64a82, 0xe466c, 0x00090,
+			0x32c9a
+		},
+		/* 100 -165 */
+		{
+			0x70000, 0x44880, 0x4477f, 0x77880, 0x00070, 0x88000,
+			0x0, 0x880b0, 0x0, 0x64b82, 0xe466c, 0x00090, 0x32c9a
+		}
+	}
+};
+
+static u32 curveindex_5g[TARGET_CHNL_NUM_5G] = {0};
+
+static u32 curveindex_2g[TARGET_CHNL_NUM_2G] = {0};
+
+static u32 targetchnl_5g[TARGET_CHNL_NUM_5G] = {
+	25141, 25116, 25091, 25066, 25041,
+	25016, 24991, 24966, 24941, 24917,
+	24892, 24867, 24843, 24818, 24794,
+	24770, 24765, 24721, 24697, 24672,
+	24648, 24624, 24600, 24576, 24552,
+	24528, 24504, 24480, 24457, 24433,
+	24409, 24385, 24362, 24338, 24315,
+	24291, 24268, 24245, 24221, 24198,
+	24175, 24151, 24128, 24105, 24082,
+	24059, 24036, 24013, 23990, 23967,
+	23945, 23922, 23899, 23876, 23854,
+	23831, 23809, 23786, 23764, 23741,
+	23719, 23697, 23674, 23652, 23630,
+	23608, 23586, 23564, 23541, 23519,
+	23498, 23476, 23454, 23432, 23410,
+	23388, 23367, 23345, 23323, 23302,
+	23280, 23259, 23237, 23216, 23194,
+	23173, 23152, 23130, 23109, 23088,
+	23067, 23046, 23025, 23003, 22982,
+	22962, 22941, 22920, 22899, 22878,
+	22857, 22837, 22816, 22795, 22775,
+	22754, 22733, 22713, 22692, 22672,
+	22652, 22631, 22611, 22591, 22570,
+	22550, 22530, 22510, 22490, 22469,
+	22449, 22429, 22409, 22390, 22370,
+	22350, 22336, 22310, 22290, 22271,
+	22251, 22231, 22212, 22192, 22173,
+	22153, 22134, 22114, 22095, 22075,
+	22056, 22037, 22017, 21998, 21979,
+	21960, 21941, 21921, 21902, 21883,
+	21864, 21845, 21826, 21807, 21789,
+	21770, 21751, 21732, 21713, 21695,
+	21676, 21657, 21639, 21620, 21602,
+	21583, 21565, 21546, 21528, 21509,
+	21491, 21473, 21454, 21436, 21418,
+	21400, 21381, 21363, 21345, 21327,
+	21309, 21291, 21273, 21255, 21237,
+	21219, 21201, 21183, 21166, 21148,
+	21130, 21112, 21095, 21077, 21059,
+	21042, 21024, 21007, 20989, 20972,
+	25679, 25653, 25627, 25601, 25575,
+	25549, 25523, 25497, 25471, 25446,
+	25420, 25394, 25369, 25343, 25318,
+	25292, 25267, 25242, 25216, 25191,
+	25166
+};
+
+/* channel 1~14 */
+static u32 targetchnl_2g[TARGET_CHNL_NUM_2G] = {
+	26084, 26030, 25976, 25923, 25869, 25816, 25764,
+	25711, 25658, 25606, 25554, 25502, 25451, 25328
+};
+
+u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u32 returnvalue, originalvalue, bitshift;
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+		regaddr, bitmask);
+
+	if (rtlhal->during_mac1init_radioa)
+		regaddr |= MAC1_ACCESS_PHY0;
+	else if (rtlhal->during_mac0init_radiob)
+		regaddr |= MAC0_ACCESS_PHY1;
+
+	originalvalue = rtl_read_dword(rtlpriv, regaddr);
+	bitshift = calculate_bit_shift(bitmask);
+	returnvalue = (originalvalue & bitmask) >> bitshift;
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
+	return returnvalue;
+}
+
+void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
+			   u32 regaddr, u32 bitmask, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u32 originalvalue, bitshift;
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
+
+	if (rtlhal->during_mac1init_radioa)
+		regaddr |= MAC1_ACCESS_PHY0;
+	else if (rtlhal->during_mac0init_radiob)
+		regaddr |= MAC0_ACCESS_PHY1;
+
+	if (bitmask != MASKDWORD) {
+		originalvalue = rtl_read_dword(rtlpriv, regaddr);
+		bitshift = calculate_bit_shift(bitmask);
+		data = (originalvalue & (~bitmask)) |
+			((data << bitshift) & bitmask);
+	}
+
+	rtl_write_dword(rtlpriv, regaddr, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
+}
+
+/* To avoid miswrite Reg0x800 for 92D */
+static void rtl92d_phy_set_bb_reg_1byte(struct ieee80211_hw *hw,
+					u32 regaddr, u32 bitmask, u32 data)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 originalvalue, bitshift, offset = 0;
+	u8 value = 0;
+
+	/* BitMask only support bit0~bit7 or bit8~bit15, bit16~bit23,
+	 * bit24~bit31, should be in 1 byte scale;
+	 */
+	bitshift = calculate_bit_shift(bitmask);
+	offset = bitshift / 8;
+
+	originalvalue = rtl_read_dword(rtlpriv, regaddr);
+	data = (originalvalue & (~bitmask)) | ((data << bitshift) & bitmask);
+
+	value = (u8)(data >> (8 * offset));
+
+	rtl_write_byte(rtlpriv, regaddr + offset, value);
+}
+
+bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 arraylength;
+	u32 *ptrarray;
+	u32 i;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
+	arraylength = MAC_2T_ARRAYLENGTH;
+	ptrarray = rtl8192du_mac_2tarray;
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Img:Rtl819XMAC_Array\n");
+	for (i = 0; i < arraylength; i = i + 2)
+		rtl_write_byte(rtlpriv, ptrarray[i], (u8)ptrarray[i + 1]);
+	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY) {
+		/* improve 2-stream TX EVM */
+		/* rtl_write_byte(rtlpriv, 0x14,0x71); */
+		/* AMPDU aggregation number 9 */
+		/* rtl_write_word(rtlpriv, REG_MAX_AGGR_NUM, MAX_AGGR_NUM); */
+		rtl_write_byte(rtlpriv, REG_MAX_AGGR_NUM, 0x0B);
+	} else {
+		/* 92D need to test to decide the num. */
+		rtl_write_byte(rtlpriv, REG_MAX_AGGR_NUM, 0x07);
+	}
+	return true;
+}
+
+static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
+						  u8 configtype)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u16 phy_reg_arraylen, agctab_arraylen = 0;
+	u32 *agctab_array_table = NULL;
+	u32 *agctab_5garray_table;
+	u32 *phy_regarray_table;
+	u16 agctab_5garraylen;
+	int i;
+
+	/* Normal chip,Mac0 use AGC_TAB.txt for 2G and 5G band. */
+	if (rtlhal->interfaceindex == 0) {
+		agctab_arraylen = AGCTAB_ARRAYLENGTH;
+		agctab_array_table = rtl8192du_agctab_array;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			" ===> phy:MAC0, Rtl819XAGCTAB_Array\n");
+	} else {
+		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+			agctab_arraylen = AGCTAB_2G_ARRAYLENGTH;
+			agctab_array_table = rtl8192du_agctab_2garray;
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				" ===> phy:MAC1, Rtl819XAGCTAB_2GArray\n");
+		} else {
+			agctab_5garraylen = AGCTAB_5G_ARRAYLENGTH;
+			agctab_5garray_table = rtl8192du_agctab_5garray;
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				" ===> phy:MAC1, Rtl819XAGCTAB_5GArray\n");
+		}
+	}
+	phy_reg_arraylen = PHY_REG_2T_ARRAYLENGTH;
+	phy_regarray_table = rtl8192du_phy_reg_2tarray;
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		" ===> phy:Rtl819XPHY_REG_Array_PG\n");
+	if (configtype == BASEBAND_CONFIG_PHY_REG) {
+		for (i = 0; i < phy_reg_arraylen; i = i + 2) {
+			rtl_addr_delay(phy_regarray_table[i]);
+			rtl_set_bbreg(hw, phy_regarray_table[i], MASKDWORD,
+				      phy_regarray_table[i + 1]);
+			udelay(1);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The phy_regarray_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
+				phy_regarray_table[i],
+				phy_regarray_table[i + 1]);
+		}
+	} else if (configtype == BASEBAND_CONFIG_AGC_TAB) {
+		if (rtlhal->interfaceindex == 0) {
+			for (i = 0; i < agctab_arraylen; i = i + 2) {
+				rtl_set_bbreg(hw, agctab_array_table[i],
+					      MASKDWORD,
+					      agctab_array_table[i + 1]);
+				/* Add 1us delay between BB/RF register
+				 * setting.
+				 */
+				udelay(1);
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+					"The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+					agctab_array_table[i],
+					agctab_array_table[i + 1]);
+			}
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Normal Chip, MAC0, load Rtl819XAGCTAB_Array\n");
+		} else {
+			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+				for (i = 0; i < agctab_arraylen; i = i + 2) {
+					rtl_set_bbreg(hw, agctab_array_table[i],
+						MASKDWORD,
+						agctab_array_table[i + 1]);
+					/* Add 1us delay between BB/RF register
+					 * setting.
+					 */
+					udelay(1);
+					rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+						"The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+						agctab_array_table[i],
+						agctab_array_table[i + 1]);
+				}
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Load Rtl819XAGCTAB_2GArray\n");
+			} else {
+				for (i = 0; i < agctab_5garraylen; i = i + 2) {
+					rtl_set_bbreg(hw,
+						agctab_5garray_table[i],
+						MASKDWORD,
+						agctab_5garray_table[i + 1]);
+					/* Add 1us delay between BB/RF register
+					 * setting.
+					 */
+					udelay(1);
+					rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+						"The Rtl819XAGCTAB_5GArray_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+						agctab_5garray_table[i],
+						agctab_5garray_table[i + 1]);
+				}
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Load Rtl819XAGCTAB_5GArray\n");
+			}
+		}
+	}
+	return true;
+}
+
+static bool _rtl92d_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
+						    u8 configtype)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 *phy_regarray_table_pg;
+	u16 phy_regarray_pg_len;
+	int i;
+
+	phy_regarray_pg_len = PHY_REG_ARRAY_PG_LENGTH;
+	phy_regarray_table_pg = rtl8192du_phy_reg_array_pg;
+	if (configtype == BASEBAND_CONFIG_PHY_REG) {
+		for (i = 0; i < phy_regarray_pg_len; i = i + 3) {
+			rtl_addr_delay(phy_regarray_table_pg[i]);
+			rtl92d_store_pwrindex_diffrate_offset(hw,
+				phy_regarray_table_pg[i],
+				phy_regarray_table_pg[i + 1],
+				phy_regarray_table_pg[i + 2]);
+		}
+	} else {
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"configtype != BaseBand_Config_PHY_REG\n");
+	}
+	return true;
+}
+
+static bool _rtl92d_phy_bb_config(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	bool rtstatus;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "==>\n");
+	rtstatus = _rtl92d_phy_config_bb_with_headerfile(hw,
+		BASEBAND_CONFIG_PHY_REG);
+	if (!rtstatus) {
+		pr_err("Write BB Reg Fail!!\n");
+		return false;
+	}
+
+	if (rtlefuse->autoload_failflag == false) {
+		rtlphy->pwrgroup_cnt = 0;
+		rtstatus = _rtl92d_phy_config_bb_with_pgheaderfile(hw,
+			BASEBAND_CONFIG_PHY_REG);
+	}
+	if (!rtstatus) {
+		pr_err("BB_PG Reg Fail!!\n");
+		return false;
+	}
+	rtstatus = _rtl92d_phy_config_bb_with_headerfile(hw,
+		BASEBAND_CONFIG_AGC_TAB);
+	if (!rtstatus) {
+		pr_err("AGC Table Fail\n");
+		return false;
+	}
+	rtlphy->cck_high_power = (bool)rtl_get_bbreg(hw,
+						     RFPGA0_XA_HSSIPARAMETER2,
+						     0x200);
+
+	return true;
+}
+
+bool rtl92d_phy_bb_config(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	bool rtstatus;
+	u32 regvaldw;
+	u16 regval;
+	u8 value;
+
+	rtl92d_phy_init_bb_rf_register_definition(hw);
+	regval = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN);
+	rtl_write_word(rtlpriv, REG_SYS_FUNC_EN,
+		       regval | BIT(13) | BIT(0) | BIT(1));
+	rtl_write_byte(rtlpriv, REG_AFE_PLL_CTRL, 0x83);
+	rtl_write_byte(rtlpriv, REG_AFE_PLL_CTRL + 1, 0xdb);
+	/* 0x1f bit7 bit6 represent for mac0/mac1 driver ready */
+	value = rtl_read_byte(rtlpriv, REG_RF_CTRL);
+	rtl_write_byte(rtlpriv, REG_RF_CTRL, value | RF_EN | RF_RSTB |
+		RF_SDMRSTB);
+
+	value = FEN_BB_GLB_RSTN | FEN_BBRSTB;
+	if (rtlhal->interface == INTF_PCI)
+		value |= FEN_PPLL | FEN_PCIEA | FEN_DIO_PCIE;
+	else if (rtlhal->interface == INTF_USB)
+		value |= FEN_USBA | FEN_USBD;
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, value);
+
+	if (rtlhal->interface == INTF_USB) {
+		regvaldw = rtl_read_dword(rtlpriv, RFPGA0_XCD_RFPARAMETER);
+		regvaldw &= ~BIT(31);
+		rtl_write_dword(rtlpriv, RFPGA0_XCD_RFPARAMETER, regvaldw);
+
+		/* To Fix MAC loopback mode fail. */
+		rtl_write_byte(rtlpriv, REG_LDOHCI12_CTRL, 0x0f);
+		rtl_write_byte(rtlpriv, 0x15, 0xe9);
+	}
+
+	rtl_write_byte(rtlpriv, REG_AFE_XTAL_CTRL + 1, 0x80);
+	if (!(IS_92D_SINGLEPHY(rtlpriv->rtlhal.version)) &&
+	    rtlhal->interface == INTF_PCI) {
+		regvaldw = rtl_read_dword(rtlpriv, REG_LEDCFG0);
+		rtl_write_dword(rtlpriv, REG_LEDCFG0, regvaldw | BIT(23));
+	}
+
+	rtstatus = _rtl92d_phy_bb_config(hw);
+
+	if (rtlhal->interface == INTF_USB) {
+		/* Crystal calibration */
+		rtl_set_bbreg(hw, REG_AFE_XTAL_CTRL, 0xf0,
+			      rtlpriv->efuse.crystalcap & 0x0f);
+		rtl_set_bbreg(hw, REG_AFE_PLL_CTRL, 0xf0000000,
+			      (rtlpriv->efuse.crystalcap & 0xf0) >> 4);
+	}
+
+	return rtstatus;
+}
+
+bool rtl92d_phy_rf_config(struct ieee80211_hw *hw)
+{
+	return rtl92d_phy_rf6052_config(hw);
+}
+
+bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
+					  enum rf_content content,
+					  enum radio_path rfpath)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 radioa_arraylen, radiob_arraylen;
+	u32 *radioa_array_table;
+	u32 *radiob_array_table;
+	int i;
+
+	radioa_arraylen = RADIOA_2T_ARRAYLENGTH;
+	radioa_array_table = rtl8192du_radioa_2tarray;
+	radiob_arraylen = RADIOB_2T_ARRAYLENGTH;
+	radiob_array_table = rtl8192du_radiob_2tarray;
+	if (rtlpriv->efuse.internal_pa_5g[0]) {
+		radioa_arraylen = RADIOA_2T_INT_PA_ARRAYLENGTH;
+		radioa_array_table = rtl8192du_radioa_2t_int_paarray;
+	}
+	if (rtlpriv->efuse.internal_pa_5g[1]) {
+		radiob_arraylen = RADIOB_2T_INT_PA_ARRAYLENGTH;
+		radiob_array_table = rtl8192du_radiob_2t_int_paarray;
+	}
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PHY_ConfigRFWithHeaderFile() Radio_A:Rtl819XRadioA_1TArray\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PHY_ConfigRFWithHeaderFile() Radio_B:Rtl819XRadioB_1TArray\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
+
+	/* this only happens when DMDP, mac0 start on 2.4G,
+	 * mac1 start on 5G, mac 0 has to set phy0 & phy1
+	 * pathA or mac1 has to set phy0 & phy1 pathA
+	 */
+	if (content == radiob_txt && rfpath == RF90_PATH_A) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			" ===> althougth Path A, we load radiob.txt\n");
+		radioa_arraylen = radiob_arraylen;
+		radioa_array_table = radiob_array_table;
+	}
+	switch (rfpath) {
+	case RF90_PATH_A:
+		for (i = 0; i < radioa_arraylen; i = i + 2) {
+			rtl_rfreg_delay(hw, rfpath, radioa_array_table[i],
+					RFREG_OFFSET_MASK,
+					radioa_array_table[i + 1]);
+		}
+		break;
+	case RF90_PATH_B:
+		for (i = 0; i < radiob_arraylen; i = i + 2) {
+			rtl_rfreg_delay(hw, rfpath, radiob_array_table[i],
+					RFREG_OFFSET_MASK,
+					radiob_array_table[i + 1]);
+		}
+		break;
+	case RF90_PATH_C:
+	case RF90_PATH_D:
+		pr_err("switch case %#x not processed\n", rfpath);
+		break;
+	}
+	return true;
+}
+
+void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
+			    enum nl80211_channel_type ch_type)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	unsigned long flag = 0;
+	u8 reg_bw_opmode;
+	u8 reg_prsr_rsc;
+
+	if (rtlphy->set_bwmode_inprogress)
+		return;
+	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"FALSE driver sleep or unload\n");
+		return;
+	}
+	rtlphy->set_bwmode_inprogress = true;
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+		rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		"20MHz" : "40MHz");
+	reg_bw_opmode = rtl_read_byte(rtlpriv, REG_BWOPMODE);
+	reg_prsr_rsc = rtl_read_byte(rtlpriv, REG_RRSR + 2);
+	switch (rtlphy->current_chan_bw) {
+	case HT_CHANNEL_WIDTH_20:
+		reg_bw_opmode |= BW_OPMODE_20MHZ;
+		rtl_write_byte(rtlpriv, REG_BWOPMODE, reg_bw_opmode);
+		break;
+	case HT_CHANNEL_WIDTH_20_40:
+		reg_bw_opmode &= ~BW_OPMODE_20MHZ;
+		rtl_write_byte(rtlpriv, REG_BWOPMODE, reg_bw_opmode);
+
+		reg_prsr_rsc = (reg_prsr_rsc & 0x90) |
+			(mac->cur_40_prime_sc << 5);
+		rtl_write_byte(rtlpriv, REG_RRSR + 2, reg_prsr_rsc);
+		break;
+	default:
+		pr_err("unknown bandwidth: %#X\n",
+		       rtlphy->current_chan_bw);
+		break;
+	}
+	switch (rtlphy->current_chan_bw) {
+	case HT_CHANNEL_WIDTH_20:
+		rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BRFMOD, 0x0);
+		rtl_set_bbreg(hw, RFPGA1_RFMOD, BRFMOD, 0x0);
+		/* SET BIT10 BIT11  for receive cck */
+		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER2, BIT(10) |
+			      BIT(11), 3);
+		break;
+	case HT_CHANNEL_WIDTH_20_40:
+		rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BRFMOD, 0x1);
+		rtl_set_bbreg(hw, RFPGA1_RFMOD, BRFMOD, 0x1);
+		/* Set Control channel to upper or lower.
+		 * These settings are required only for 40MHz
+		 */
+		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
+			rtl_set_bbreg(hw, RCCK0_SYSTEM, BCCKSIDEBAND,
+				      mac->cur_40_prime_sc >> 1);
+			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
+		}
+		rtl_set_bbreg(hw, ROFDM1_LSTF, 0xC00, mac->cur_40_prime_sc);
+		/* SET BIT10 BIT11  for receive cck */
+		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER2,
+			      BIT(10) | BIT(11), 0);
+		rtl_set_bbreg(hw, 0x818, (BIT(26) | BIT(27)),
+			      (mac->cur_40_prime_sc ==
+			      HAL_PRIME_CHNL_OFFSET_LOWER) ? 2 : 1);
+		break;
+	default:
+		pr_err("unknown bandwidth: %#X\n",
+		       rtlphy->current_chan_bw);
+		break;
+	}
+	rtl92d_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
+	rtlphy->set_bwmode_inprogress = false;
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+}
+
+static void _rtl92d_phy_stop_trx_before_changeband(struct ieee80211_hw *hw)
+{
+	rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BCCKEN | BOFDMEN, 0);
+	rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x00);
+	rtl_set_bbreg(hw, ROFDM1_TRXPATHENABLE, BDWORD, 0x0);
+}
+
+static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u16 basic_rates;
+	u8 value8;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	rtlhal->bandset = band;
+	rtlhal->current_bandtype = band;
+	if (IS_92D_SINGLEPHY(rtlhal->version))
+		rtlhal->bandset = BAND_ON_BOTH;
+	/* stop RX/Tx */
+	_rtl92d_phy_stop_trx_before_changeband(hw);
+	/* reconfig BB/RF according to wireless mode */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		/* BB & RF Config */
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "====>2.4G\n");
+		if (rtlhal->interfaceindex == 1)
+			_rtl92d_phy_config_bb_with_headerfile(hw,
+				BASEBAND_CONFIG_AGC_TAB);
+	} else {
+		/* 5G band */
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "====>5G\n");
+		if (rtlhal->interfaceindex == 1)
+			_rtl92d_phy_config_bb_with_headerfile(hw,
+				BASEBAND_CONFIG_AGC_TAB);
+	}
+	rtl92d_update_bbrf_configuration(hw);
+
+	basic_rates = RRSR_6M | RRSR_12M | RRSR_24M;
+	if (rtlhal->current_bandtype == BAND_ON_2_4G)
+		basic_rates |= RRSR_1M | RRSR_2M | RRSR_5_5M | RRSR_11M;
+	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BASIC_RATE,
+				      (u8 *)&basic_rates);
+
+	rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BCCKEN | BOFDMEN, 0x3);
+
+	/* 20M BW. */
+	/* rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER2, BIT(10), 1); */
+	rtlhal->reloadtxpowerindex = true;
+	/* notice fw know band status  0x81[1]/0x53[1] = 0: 5G, 1: 2G */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		value8 = rtl_read_byte(rtlpriv,	(rtlhal->interfaceindex ==
+			0 ? REG_MAC0 : REG_MAC1));
+		value8 |= BIT(1);
+		rtl_write_byte(rtlpriv, (rtlhal->interfaceindex ==
+			0 ? REG_MAC0 : REG_MAC1), value8);
+	} else {
+		value8 = rtl_read_byte(rtlpriv, (rtlhal->interfaceindex ==
+			0 ? REG_MAC0 : REG_MAC1));
+		value8 &= (~BIT(1));
+		rtl_write_byte(rtlpriv, (rtlhal->interfaceindex ==
+			0 ? REG_MAC0 : REG_MAC1), value8);
+	}
+	mdelay(1);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<==Switch Band OK\n");
+}
+
+static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
+					   u8 channel, u8 rfpath)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 group, i;
+
+	if (rtlusb->udev->speed != USB_SPEED_HIGH)
+		return;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>path %d\n", rfpath);
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G) {
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD,
+					    BOFDMEN | BCCKEN, 0);
+		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0xf);
+		/* fc area 0xd2c */
+		if (channel >= 149)
+			rtl_set_bbreg(hw, ROFDM1_CFOTRACKING, BIT(13) |
+				      BIT(14), 2);
+		else
+			rtl_set_bbreg(hw, ROFDM1_CFOTRACKING, BIT(13) |
+				      BIT(14), 1);
+		/* leave 0 for channel1-14. */
+		group = channel <= 64 ? 1 : 2;
+		for (i = 0; i < MAX_RF_IMR_INDEX_NORMAL; i++)
+			rtl_set_rfreg(hw, (enum radio_path)rfpath,
+				      rf_reg_for_5g_swchnl_normal[i],
+				      RFREG_OFFSET_MASK,
+				      rf_imr_param_normal[0][group][i]);
+		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0);
+		rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD,
+					    BOFDMEN | BCCKEN, 3);
+	} else {
+		/* G band. */
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"Load RF IMR parameters for G band. IMR already setting %d\n",
+			rtlpriv->rtlhal.load_imrandiqk_setting_for2g);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		if (!rtlpriv->rtlhal.load_imrandiqk_setting_for2g) {
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+				"Load RF IMR parameters for G band. %d\n",
+				rfpath);
+			rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD,
+						    BOFDMEN | BCCKEN, 0);
+			rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4,
+				      0x00f00000, 0xf);
+			for (i = 0; i < MAX_RF_IMR_INDEX_NORMAL; i++) {
+				rtl_set_rfreg(hw, (enum radio_path)rfpath,
+					      rf_reg_for_5g_swchnl_normal[i],
+					      RFREG_OFFSET_MASK,
+					      rf_imr_param_normal[0][0][i]);
+			}
+			rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4,
+				      0x00f00000, 0);
+			rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD,
+						    BOFDMEN | BCCKEN, 3);
+		}
+	}
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+}
+
+static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 path = rtlhal->current_bandtype == BAND_ON_5G ? RF90_PATH_A
+							 : RF90_PATH_B;
+	u32 u4regvalue, mask = 0x1C000, value = 0, u4tmp, u4tmp2;
+	bool need_pwr_down = false, internal_pa = false;
+	u32 regb30 = rtl_get_bbreg(hw, 0xb30, BIT(27));
+	u8 index = 0, i = 0, rfpath = RF90_PATH_A;
+
+	if (rtlusb->udev->speed != USB_SPEED_HIGH)
+		return;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>\n");
+	/* config path A for 5G */
+	if (rtlhal->current_bandtype == BAND_ON_5G) {
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		u4tmp = curveindex_5g[channel - 1];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"ver 1 set RF-A, 5G, 0x28 = 0x%x !!\n", u4tmp);
+		for (i = 0; i < RF_CHNL_NUM_5G; i++) {
+			if (channel == rf_chnl_5g[i] && channel <= 140)
+				index = 0;
+		}
+		for (i = 0; i < RF_CHNL_NUM_5G_40M; i++) {
+			if (channel == rf_chnl_5g_40m[i] && channel <= 140)
+				index = 1;
+		}
+		if (channel == 149 || channel == 155 || channel == 161)
+			index = 2;
+		else if (channel == 151 || channel == 153 || channel == 163 ||
+			 channel == 165)
+			index = 3;
+		else if (channel == 157 || channel == 159)
+			index = 4;
+
+		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+		    rtlhal->interfaceindex == 1) {
+			need_pwr_down = rtl92d_phy_enable_anotherphy(hw, false);
+			rtlhal->during_mac1init_radioa = true;
+			/* asume no this case */
+			if (need_pwr_down)
+				rtl92d_phy_enable_rf_env(hw, path,
+							 &u4regvalue);
+		}
+
+		/* DMDP, if band = 5G, Mac0 need to set PHY1 when regB30[27]=1 */
+		if (regb30 && rtlhal->interfaceindex == 0) {
+			need_pwr_down = rtl92d_phy_enable_anotherphy(hw, true);
+			rtlhal->during_mac0init_radiob = true;
+			if (need_pwr_down)
+				rtl92d_phy_enable_rf_env(hw, path,
+							 &u4regvalue);
+		}
+
+		for (i = 0; i < RF_REG_NUM_FOR_C_CUT_5G; i++) {
+			if (i == 0 && rtlhal->macphymode == DUALMAC_DUALPHY) {
+				rtl_set_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_5g[i],
+					      RFREG_OFFSET_MASK, 0xE439D);
+			} else if (rf_reg_for_c_cut_5g[i] == RF_SYN_G4) {
+				u4tmp2 = (rf_reg_pram_c_5g[index][i] &
+				     0x7FF) | (u4tmp << 11);
+				if (channel == 36)
+					u4tmp2 &= ~(BIT(7) | BIT(6));
+				rtl_set_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_5g[i],
+					      RFREG_OFFSET_MASK, u4tmp2);
+			} else {
+				rtl_set_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_5g[i],
+					      RFREG_OFFSET_MASK,
+					      rf_reg_pram_c_5g[index][i]);
+			}
+			rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+				"offset 0x%x value 0x%x path %d index %d readback 0x%x\n",
+				rf_reg_for_c_cut_5g[i],
+				rf_reg_pram_c_5g[index][i],
+				path, index,
+				rtl_get_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_5g[i],
+					      RFREG_OFFSET_MASK));
+		}
+		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+		    rtlhal->interfaceindex == 1) {
+			if (need_pwr_down)
+				rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+
+			rtl92d_phy_powerdown_anotherphy(hw, false);
+		}
+
+		if (regb30 && rtlhal->interfaceindex == 0) {
+			if (need_pwr_down)
+				rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+
+			rtl92d_phy_powerdown_anotherphy(hw, true);
+		}
+
+		if (channel < 149)
+			value = 0x07;
+		else if (channel >= 149)
+			value = 0x02;
+		if (channel >= 36 && channel <= 64)
+			index = 0;
+		else if (channel >= 100 && channel <= 140)
+			index = 1;
+		else
+			index = 2;
+		for (rfpath = RF90_PATH_A; rfpath < rtlphy->num_total_rfpath;
+			rfpath++) {
+			if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+			    rtlhal->interfaceindex == 1) /* MAC 1 5G */
+				internal_pa = rtlpriv->efuse.internal_pa_5g[1];
+			else
+				internal_pa =
+					 rtlpriv->efuse.internal_pa_5g[rfpath];
+			if (internal_pa) {
+				for (i = 0;
+				     i < RF_REG_NUM_FOR_C_CUT_5G_INTERNALPA;
+				     i++) {
+					if (rf_for_c_cut_5g_internal_pa[i] == 0x03 &&
+					    channel >= 36 && channel <= 64)
+						rtl_set_rfreg(hw, rfpath,
+							rf_for_c_cut_5g_internal_pa[i],
+							RFREG_OFFSET_MASK,
+							0x7bdef);
+					else
+						rtl_set_rfreg(hw, rfpath,
+							rf_for_c_cut_5g_internal_pa[i],
+							RFREG_OFFSET_MASK,
+							rf_pram_c_5g_int_pa[index][i]);
+					rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+						"offset 0x%x value 0x%x path %d index %d\n",
+						rf_for_c_cut_5g_internal_pa[i],
+						rf_pram_c_5g_int_pa[index][i],
+						rfpath, index);
+				}
+			} else {
+				rtl_set_rfreg(hw, (enum radio_path)rfpath, RF_TXPA_AG,
+					      mask, value);
+			}
+		}
+	} else if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		u4tmp = curveindex_2g[channel - 1];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n", u4tmp);
+		if (channel == 1 || channel == 2 || channel == 4 ||
+		    channel == 9 || channel == 10 || channel == 11 ||
+		    channel == 12)
+			index = 0;
+		else if (channel == 3 || channel == 13 || channel == 14)
+			index = 1;
+		else if (channel >= 5 && channel <= 8)
+			index = 2;
+		if (rtlhal->macphymode == DUALMAC_DUALPHY) {
+			path = RF90_PATH_A;
+			if (rtlhal->interfaceindex == 0) {
+				need_pwr_down =
+					 rtl92d_phy_enable_anotherphy(hw, true);
+				rtlhal->during_mac0init_radiob = true;
+
+				if (need_pwr_down)
+					rtl92d_phy_enable_rf_env(hw, path,
+								 &u4regvalue);
+			}
+
+			/* DMDP, if band = 2G, MAC1 need to set PHY0 when regB30[27]=1 */
+			if (regb30 && rtlhal->interfaceindex == 1) {
+				need_pwr_down =
+					 rtl92d_phy_enable_anotherphy(hw, false);
+				rtlhal->during_mac1init_radioa = true;
+
+				if (need_pwr_down)
+					rtl92d_phy_enable_rf_env(hw, path,
+								 &u4regvalue);
+			}
+		}
+		for (i = 0; i < RF_REG_NUM_FOR_C_CUT_2G; i++) {
+			if (rf_reg_for_c_cut_2g[i] == RF_SYN_G7)
+				rtl_set_rfreg(hw, (enum radio_path)path,
+					rf_reg_for_c_cut_2g[i],
+					RFREG_OFFSET_MASK,
+					rf_reg_param_for_c_cut_2g[index][i] |
+					BIT(17));
+			else
+				rtl_set_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_2g[i],
+					      RFREG_OFFSET_MASK,
+					      rf_reg_param_for_c_cut_2g
+					      [index][i]);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+				"offset 0x%x value 0x%x mak 0x%x path %d index %d readback 0x%x\n",
+				rf_reg_for_c_cut_2g[i],
+				rf_reg_param_for_c_cut_2g[index][i],
+				rf_reg_mask_for_c_cut_2g[i], path, index,
+				rtl_get_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_2g[i],
+					      RFREG_OFFSET_MASK));
+		}
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"cosa ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n",
+			rf_syn_g4_for_c_cut_2g | (u4tmp << 11));
+
+		rtl_set_rfreg(hw, (enum radio_path)path, RF_SYN_G4,
+			      RFREG_OFFSET_MASK,
+			      rf_syn_g4_for_c_cut_2g | (u4tmp << 11));
+
+		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+		    rtlhal->interfaceindex == 0) {
+			if (need_pwr_down)
+				rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+
+			rtl92d_phy_powerdown_anotherphy(hw, true);
+		}
+
+		if (regb30 && rtlhal->interfaceindex == 1) {
+			if (need_pwr_down)
+				rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
+
+			rtl92d_phy_powerdown_anotherphy(hw, false);
+		}
+	}
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+}
+
+/* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+static u8 _rtl92d_phy_patha_iqk(struct ieee80211_hw *hw, bool configpathb)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u32 regeac, rege94, rege9c, regea4;
+	u8 result = 0;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path A IQK!\n");
+	/* path-A IQK setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path-A IQK setting!\n");
+	if (rtlhal->interfaceindex == 0) {
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x10008c1f);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x10008c1f);
+	} else {
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x10008c22);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x10008c22);
+	}
+	rtl_set_bbreg(hw, RTX_IQK_PI_A, MASKDWORD, 0x82140102);
+	rtl_set_bbreg(hw, RRX_IQK_PI_A, MASKDWORD,
+		      configpathb ? 0x28160202 : 0x28160502);
+	/* path-B IQK setting */
+	if (configpathb) {
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD, 0x10008c22);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD, 0x10008c22);
+		rtl_set_bbreg(hw, RTX_IQK_PI_B, MASKDWORD, 0x82140102);
+		rtl_set_bbreg(hw, RRX_IQK_PI_B, MASKDWORD, 0x28160206);
+	}
+	/* LO calibration setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LO calibration setting!\n");
+	rtl_set_bbreg(hw, RIQK_AGC_RSP, MASKDWORD, 0x00462911);
+	/* One shot, path A LOK & IQK */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "One shot, path A LOK & IQK!\n");
+	rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xf9000000);
+	rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xf8000000);
+	/* delay x ms */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Delay %d ms for One shot, path A LOK & IQK\n",
+		IQK_DELAY_TIME);
+	mdelay(IQK_DELAY_TIME);
+	/* Check failed */
+	regeac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeac = 0x%x\n", regeac);
+	rege94 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xe94 = 0x%x\n", rege94);
+	rege9c = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xe9c = 0x%x\n", rege9c);
+	regea4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xea4 = 0x%x\n", regea4);
+	if (!(regeac & BIT(28)) &&
+	    (((rege94 & 0x03FF0000) >> 16) != 0x142) &&
+	    (((rege9c & 0x03FF0000) >> 16) != 0x42))
+		result |= 0x01;
+	else /* if Tx not OK, ignore Rx */
+		return result;
+
+	/* if Tx is OK, check whether Rx is OK */
+	if (!(regeac & BIT(27)) &&
+	    (((regea4 & 0x03FF0000) >> 16) != 0x132) &&
+	    (((regeac & 0x03FF0000) >> 16) != 0x36))
+		result |= 0x02;
+	else
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path A Rx IQK fail!!\n");
+	return result;
+}
+
+/* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+static u8 _rtl92d_phy_patha_iqk_5g_normal(struct ieee80211_hw *hw,
+					  bool configpathb)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 TXOKBIT = BIT(28), RXOKBIT = BIT(27);
+	u32 regeac, rege94, rege9c, regea4;
+	u8 timeout = 20, timecount = 0;
+	u8 retrycount = 2;
+	u8 result = 0;
+	u8 i;
+
+	if (rtlhal->interfaceindex == 1) { /* PHY1 */
+		TXOKBIT = BIT(31);
+		RXOKBIT = BIT(30);
+	}
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path A IQK!\n");
+	/* path-A IQK setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path-A IQK setting!\n");
+	rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x18008c1f);
+	rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x18008c1f);
+	rtl_set_bbreg(hw, RTX_IQK_PI_A, MASKDWORD, 0x82140307);
+	rtl_set_bbreg(hw, RRX_IQK_PI_A, MASKDWORD, 0x68160960);
+	/* path-B IQK setting */
+	if (configpathb) {
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD, 0x18008c2f);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD, 0x18008c2f);
+		rtl_set_bbreg(hw, RTX_IQK_PI_B, MASKDWORD, 0x82110000);
+		rtl_set_bbreg(hw, RRX_IQK_PI_B, MASKDWORD, 0x68110000);
+	}
+	/* LO calibration setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LO calibration setting!\n");
+	rtl_set_bbreg(hw, RIQK_AGC_RSP, MASKDWORD, 0x00462911);
+	/* path-A PA on */
+	rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW, MASKDWORD, 0x07000f60);
+	rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE, MASKDWORD, 0x66e60e30);
+	for (i = 0; i < retrycount; i++) {
+		/* One shot, path A LOK & IQK */
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"One shot, path A LOK & IQK!\n");
+		rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xf9000000);
+		rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xf8000000);
+		/* delay x ms */
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Delay %d ms for One shot, path A LOK & IQK.\n",
+			IQK_DELAY_TIME);
+		mdelay(IQK_DELAY_TIME * 10);
+
+		while (timecount < timeout &&
+		       rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, BIT(26)) == 0) {
+			udelay(IQK_DELAY_TIME * 1000 * 2);
+			timecount++;
+		}
+
+		timecount = 0;
+		while (timecount < timeout &&
+		       rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASK_IQK_RESULT) == 0) {
+			udelay(IQK_DELAY_TIME * 1000 * 2);
+			timecount++;
+		}
+
+		/* Check failed */
+		regeac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeac = 0x%x\n", regeac);
+		rege94 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xe94 = 0x%x\n", rege94);
+		rege9c = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xe9c = 0x%x\n", rege9c);
+		regea4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xea4 = 0x%x\n", regea4);
+		if (!(regeac & TXOKBIT) &&
+		    (((rege94 & 0x03FF0000) >> 16) != 0x142)) {
+			result |= 0x01;
+		} else { /* if Tx not OK, ignore Rx */
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path A Tx IQK fail!!\n");
+			continue;
+		}
+
+		/* if Tx is OK, check whether Rx is OK */
+		if (!(regeac & RXOKBIT) &&
+		    (((regea4 & 0x03FF0000) >> 16) != 0x132)) {
+			result |= 0x02;
+			break;
+		} else {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path A Rx IQK fail!!\n");
+		}
+	}
+	/* path A PA off */
+	rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW, MASKDWORD,
+		      rtlphy->iqk_bb_backup[0]);
+	rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE, MASKDWORD,
+		      rtlphy->iqk_bb_backup[1]);
+
+	if (!(result & 0x01)) /* Tx IQK fail */
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x19008c00);
+
+	if (!(result & 0x02)) { /* Rx IQK fail */
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, MASKDWORD, 0x40000100);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x19008c00);
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Path A Rx IQK fail!! 0xe34 = %#x\n",
+			rtl_get_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD));
+	}
+
+	return result;
+}
+
+/* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+static u8 _rtl92d_phy_pathb_iqk(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 regeac, regeb4, regebc, regec4, regecc;
+	u8 result = 0;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path B IQK!\n");
+	/* One shot, path B LOK & IQK */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "One shot, path A LOK & IQK!\n");
+	rtl_set_bbreg(hw, RIQK_AGC_CONT, MASKDWORD, 0x00000002);
+	rtl_set_bbreg(hw, RIQK_AGC_CONT, MASKDWORD, 0x00000000);
+	/* delay x ms  */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Delay %d ms for One shot, path B LOK & IQK\n", IQK_DELAY_TIME);
+	mdelay(IQK_DELAY_TIME);
+	/* Check failed */
+	regeac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeac = 0x%x\n", regeac);
+	regeb4 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeb4 = 0x%x\n", regeb4);
+	regebc = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xebc = 0x%x\n", regebc);
+	regec4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_B_2, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xec4 = 0x%x\n", regec4);
+	regecc = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_B_2, MASKDWORD);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xecc = 0x%x\n", regecc);
+	if (!(regeac & BIT(31)) &&
+	    (((regeb4 & 0x03FF0000) >> 16) != 0x142) &&
+	    (((regebc & 0x03FF0000) >> 16) != 0x42))
+		result |= 0x01;
+	else
+		return result;
+	if (!(regeac & BIT(30)) &&
+	    (((regec4 & 0x03FF0000) >> 16) != 0x132) &&
+	    (((regecc & 0x03FF0000) >> 16) != 0x36))
+		result |= 0x02;
+	else
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path B Rx IQK fail!!\n");
+	return result;
+}
+
+/* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+static u8 _rtl92d_phy_pathb_iqk_5g_normal(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 regeac, regeb4, regebc, regec4, regecc;
+	u8 timeout = 20, timecount = 0;
+	u8 retrycount = 2;
+	u8 result = 0;
+	u8 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path B IQK!\n");
+	/* path-A IQK setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path-A IQK setting!\n");
+	rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x18008c1f);
+	rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x18008c1f);
+	rtl_set_bbreg(hw, RTX_IQK_PI_A, MASKDWORD, 0x82110000);
+	rtl_set_bbreg(hw, RRX_IQK_PI_A, MASKDWORD, 0x68110000);
+
+	/* path-B IQK setting */
+	rtl_set_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD, 0x18008c2f);
+	rtl_set_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD, 0x18008c2f);
+	rtl_set_bbreg(hw, RTX_IQK_PI_B, MASKDWORD, 0x82140307);
+	rtl_set_bbreg(hw, RRX_IQK_PI_B, MASKDWORD, 0x68160960);
+
+	/* LO calibration setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LO calibration setting!\n");
+	rtl_set_bbreg(hw, RIQK_AGC_RSP, MASKDWORD, 0x00462911);
+
+	/* path-B PA on */
+	rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW, MASKDWORD, 0x0f600700);
+	rtl_set_bbreg(hw, RFPGA0_XB_RFINTERFACEOE, MASKDWORD, 0x061f0d30);
+
+	for (i = 0; i < retrycount; i++) {
+		/* One shot, path B LOK & IQK */
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"One shot, path A LOK & IQK!\n");
+		rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xfa000000);
+		rtl_set_bbreg(hw, RIQK_AGC_PTS, MASKDWORD, 0xf8000000);
+
+		/* delay x ms */
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Delay %d ms for One shot, path B LOK & IQK.\n", 10);
+		mdelay(IQK_DELAY_TIME * 10);
+
+		while (timecount < timeout &&
+		       rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, BIT(29)) == 0) {
+			udelay(IQK_DELAY_TIME * 1000 * 2);
+			timecount++;
+		}
+
+		timecount = 0;
+		while (timecount < timeout &&
+		       rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_B_2, MASK_IQK_RESULT) == 0) {
+			udelay(IQK_DELAY_TIME * 1000 * 2);
+			timecount++;
+		}
+
+		/* Check failed */
+		regeac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeac = 0x%x\n", regeac);
+		regeb4 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xeb4 = 0x%x\n", regeb4);
+		regebc = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xebc = 0x%x\n", regebc);
+		regec4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_B_2, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xec4 = 0x%x\n", regec4);
+		regecc = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_B_2, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "0xecc = 0x%x\n", regecc);
+		if (!(regeac & BIT(31)) &&
+		    (((regeb4 & 0x03FF0000) >> 16) != 0x142))
+			result |= 0x01;
+		else
+			continue;
+		if (!(regeac & BIT(30)) &&
+		    (((regec4 & 0x03FF0000) >> 16) != 0x132)) {
+			result |= 0x02;
+			break;
+		} else {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path B Rx IQK fail!!\n");
+		}
+	}
+
+	/* path B PA off */
+	rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW, MASKDWORD,
+		      rtlphy->iqk_bb_backup[0]);
+	rtl_set_bbreg(hw, RFPGA0_XB_RFINTERFACEOE, MASKDWORD,
+		      rtlphy->iqk_bb_backup[2]);
+
+	if (!(result & 0x01))
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD, 0x19008c00);
+
+	if (!(result & 0x02)) {
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, MASKDWORD, 0x40000100);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD, 0x19008c00);
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Path B Rx IQK fail!! 0xe54 = %#x\n",
+			rtl_get_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD));
+	}
+
+	return result;
+}
+
+static void _rtl92d_phy_reload_adda_registers(struct ieee80211_hw *hw,
+					      u32 *adda_reg, u32 *adda_backup,
+					      u32 regnum)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Reload ADDA power saving parameters !\n");
+	for (i = 0; i < regnum; i++) {
+		/* path-A/B BB to initial gain */
+		if (adda_reg[i] == ROFDM0_XAAGCCORE1 ||
+		    adda_reg[i] == ROFDM0_XBAGCCORE1)
+			rtl_set_bbreg(hw, adda_reg[i], MASKDWORD, 0x50);
+
+		rtl_set_bbreg(hw, adda_reg[i], MASKDWORD, adda_backup[i]);
+	}
+}
+
+static void _rtl92d_phy_reload_mac_registers(struct ieee80211_hw *hw,
+					     u32 *macreg, u32 *macbackup)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK, "Reload MAC parameters !\n");
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
+		rtl_write_byte(rtlpriv, macreg[i], (u8)macbackup[i]);
+	rtl_write_dword(rtlpriv, macreg[i], macbackup[i]);
+}
+
+static void _rtl92d_phy_patha_standby(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK, "Path-A standby mode!\n");
+
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x0);
+	rtl_set_bbreg(hw, RFPGA0_XA_LSSIPARAMETER, MASKDWORD, 0x00010000);
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x808000);
+}
+
+static void _rtl92d_phy_pimode_switch(struct ieee80211_hw *hw, bool pi_mode)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 mode;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"BB Switch to %s mode!\n", pi_mode ? "PI" : "SI");
+	mode = pi_mode ? 0x01000100 : 0x01000000;
+	rtl_set_bbreg(hw, RFPGA0_XA_HSSIPARAMETER1, MASKDWORD, mode);
+	rtl_set_bbreg(hw, RFPGA0_XB_HSSIPARAMETER1, MASKDWORD, mode);
+}
+
+static void _rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw, long result[][8],
+				     u8 t, bool is2t)
+{
+	static u32 adda_reg[IQK_ADDA_REG_NUM] = {
+		RFPGA0_XCD_SWITCHCONTROL, RBLUE_TOOTH, RRX_WAIT_CCA,
+		RTX_CCK_RFON, RTX_CCK_BBON, RTX_OFDM_RFON, RTX_OFDM_BBON,
+		RTX_TO_RX, RTX_TO_TX, RRX_CCK, RRX_OFDM, RRX_WAIT_RIFS,
+		RRX_TO_RX, RSTANDBY, RSLEEP, RPMPD_ANAEN
+	};
+	static u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
+		REG_TXPAUSE, REG_BCN_CTRL, REG_BCN_CTRL_1, REG_GPIO_MUXCFG
+	};
+	static u32 iqk_bb_reg[IQK_BB_REG_NUM] = {
+		RFPGA0_XAB_RFINTERFACESW, RFPGA0_XA_RFINTERFACEOE,
+		RFPGA0_XB_RFINTERFACEOE, ROFDM0_TRMUXPAR,
+		RFPGA0_XCD_RFINTERFACESW, ROFDM0_TRXPATHENABLE,
+		RFPGA0_RFMOD, RFPGA0_ANALOGPARAMETER4,
+		ROFDM0_XAAGCCORE1, ROFDM0_XBAGCCORE1
+	};
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	const u32 retrycount = 2;
+	u8 patha_ok, pathb_ok;
+	u32 bbvalue;
+	u32 i;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "IQK for 2.4G :Start!!!\n");
+	if (t == 0) {
+		bbvalue = rtl_get_bbreg(hw, RFPGA0_RFMOD, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "==>0x%08x\n", bbvalue);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "IQ Calibration for %s\n",
+			is2t ? "2T2R" : "1T1R");
+
+		/*  Save ADDA parameters, turn Path A ADDA on */
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
+
+	rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x01017038);
+
+	if (t == 0)
+		rtlphy->rfpi_enable = (u8)rtl_get_bbreg(hw,
+				RFPGA0_XA_HSSIPARAMETER1, BIT(8));
+
+	/*  Switch BB to PI mode to do IQ Calibration. */
+	if (!rtlphy->rfpi_enable)
+		_rtl92d_phy_pimode_switch(hw, true);
+
+	rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BCCKEN, 0x00);
+	rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKDWORD, 0x03a05600);
+	rtl_set_bbreg(hw, ROFDM0_TRMUXPAR, MASKDWORD, 0x000800e4);
+	rtl_set_bbreg(hw, RFPGA0_XCD_RFINTERFACESW, MASKDWORD, 0x22204000);
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0xf00000, 0x0f);
+	if (is2t) {
+		rtl_set_bbreg(hw, RFPGA0_XA_LSSIPARAMETER, MASKDWORD,
+			      0x00010000);
+		rtl_set_bbreg(hw, RFPGA0_XB_LSSIPARAMETER, MASKDWORD,
+			      0x00010000);
+	}
+	/* MAC settings */
+	rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
+					   rtlphy->iqk_mac_backup);
+	/* Page B init */
+	rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x0f600000);
+	if (is2t)
+		rtl_set_bbreg(hw, RCONFIG_ANTB, MASKDWORD, 0x0f600000);
+	/* IQ calibration setting */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "IQK setting!\n");
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x808000);
+	rtl_set_bbreg(hw, RTX_IQK, MASKDWORD, 0x01007c00);
+	rtl_set_bbreg(hw, RRX_IQK, MASKDWORD, 0x01004800);
+	for (i = 0; i < retrycount; i++) {
+		patha_ok = _rtl92d_phy_patha_iqk(hw, is2t);
+		if (patha_ok == 0x03) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path A IQK Success!!\n");
+			result[t][0] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A,
+						     MASK_IQK_RESULT);
+			result[t][1] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A,
+						     MASK_IQK_RESULT);
+			result[t][2] = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2,
+						     MASK_IQK_RESULT);
+			result[t][3] = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2,
+						     MASK_IQK_RESULT);
+			break;
+		} else if (i == (retrycount - 1) && patha_ok == 0x01) {
+			/* Tx IQK OK */
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path A IQK Only  Tx Success!!\n");
+
+			result[t][0] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A,
+						     MASK_IQK_RESULT);
+			result[t][1] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A,
+						     MASK_IQK_RESULT);
+		}
+	}
+	if (patha_ok == 0x00)
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "Path A IQK failed!!\n");
+	if (is2t) {
+		_rtl92d_phy_patha_standby(hw);
+		/* Turn Path B ADDA on */
+		rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
+		for (i = 0; i < retrycount; i++) {
+			pathb_ok = _rtl92d_phy_pathb_iqk(hw);
+			if (pathb_ok == 0x03) {
+				RTPRINT(rtlpriv, FINIT, INIT_IQK,
+					"Path B IQK Success!!\n");
+				result[t][4] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B,
+							     MASK_IQK_RESULT);
+				result[t][5] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B,
+							     MASK_IQK_RESULT);
+				result[t][6] = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_B_2,
+							     MASK_IQK_RESULT);
+				result[t][7] = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_B_2,
+							     MASK_IQK_RESULT);
+				break;
+			} else if (i == (retrycount - 1) && pathb_ok == 0x01) {
+				/* Tx IQK OK */
+				RTPRINT(rtlpriv, FINIT, INIT_IQK,
+					"Path B Only Tx IQK Success!!\n");
+				result[t][4] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B,
+							     MASK_IQK_RESULT);
+				result[t][5] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B,
+							     MASK_IQK_RESULT);
+			}
+		}
+		if (pathb_ok == 0x00)
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path B IQK failed!!\n");
+	}
+
+	/* Back to BB mode, load original value */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"IQK:Back to BB mode, load original value!\n");
+
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x000000);
+	if (t != 0) {
+		/* Switch back BB to SI mode after finish IQ Calibration. */
+		if (!rtlphy->rfpi_enable)
+			_rtl92d_phy_pimode_switch(hw, false);
+		/* Reload ADDA power saving parameters */
+		_rtl92d_phy_reload_adda_registers(hw, adda_reg,
+						  rtlphy->adda_backup,
+						  IQK_ADDA_REG_NUM);
+		/* Reload MAC parameters */
+		_rtl92d_phy_reload_mac_registers(hw, iqk_mac_reg,
+						 rtlphy->iqk_mac_backup);
+		if (is2t)
+			_rtl92d_phy_reload_adda_registers(hw, iqk_bb_reg,
+							  rtlphy->iqk_bb_backup,
+							  IQK_BB_REG_NUM);
+		else
+			_rtl92d_phy_reload_adda_registers(hw, iqk_bb_reg,
+							  rtlphy->iqk_bb_backup,
+							  IQK_BB_REG_NUM - 1);
+		/* load 0xe30 IQC default value */
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x01008c00);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x01008c00);
+	}
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "<==\n");
+}
+
+static void _rtl92d_phy_iq_calibrate_5g_normal(struct ieee80211_hw *hw,
+					       long result[][8], u8 t)
+{
+	static u32 adda_reg[IQK_ADDA_REG_NUM] = {
+		RFPGA0_XCD_SWITCHCONTROL, RBLUE_TOOTH, RRX_WAIT_CCA,
+		RTX_CCK_RFON, RTX_CCK_BBON, RTX_OFDM_RFON, RTX_OFDM_BBON,
+		RTX_TO_RX, RTX_TO_TX, RRX_CCK, RRX_OFDM, RRX_WAIT_RIFS,
+		RRX_TO_RX, RSTANDBY, RSLEEP, RPMPD_ANAEN
+	};
+	static u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
+		REG_TXPAUSE, REG_BCN_CTRL, REG_BCN_CTRL_1, REG_GPIO_MUXCFG
+	};
+	static u32 iqk_bb_reg[IQK_BB_REG_NUM] = {
+		RFPGA0_XAB_RFINTERFACESW, RFPGA0_XA_RFINTERFACEOE,
+		RFPGA0_XB_RFINTERFACEOE, ROFDM0_TRMUXPAR,
+		RFPGA0_XCD_RFINTERFACESW, ROFDM0_TRXPATHENABLE,
+		RFPGA0_RFMOD, RFPGA0_ANALOGPARAMETER4,
+		ROFDM0_XAAGCCORE1, ROFDM0_XBAGCCORE1
+	};
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
+	u8 patha_ok, pathb_ok;
+	bool rf_path_div;
+	u32 bbvalue;
+
+	/* Note: IQ calibration must be performed after loading
+	 * PHY_REG.txt , and radio_a, radio_b.txt
+	 */
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "IQK for 5G NORMAL:Start!!!\n");
+	mdelay(IQK_DELAY_TIME * 20);
+	if (t == 0) {
+		bbvalue = rtl_get_bbreg(hw, RFPGA0_RFMOD, MASKDWORD);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "==>0x%08x\n", bbvalue);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "IQ Calibration for %s\n",
+			is2t ? "2T2R" : "1T1R");
+		/* Save ADDA parameters, turn Path A ADDA on */
+		rtl92d_phy_save_adda_registers(hw, adda_reg,
+					       rtlphy->adda_backup,
+					       IQK_ADDA_REG_NUM);
+		rtl92d_phy_save_mac_registers(hw, iqk_mac_reg,
+					      rtlphy->iqk_mac_backup);
+		if (is2t)
+			rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
+						       rtlphy->iqk_bb_backup,
+						       IQK_BB_REG_NUM);
+		else
+			rtl92d_phy_save_adda_registers(hw, iqk_bb_reg,
+						       rtlphy->iqk_bb_backup,
+						       IQK_BB_REG_NUM - 1);
+	}
+
+	rf_path_div = rtl_get_bbreg(hw, 0xb30, BIT(27));
+	rtl92d_phy_path_adda_on(hw, adda_reg, !rf_path_div, is2t);
+
+	if (t == 0)
+		rtlphy->rfpi_enable = (u8)rtl_get_bbreg(hw,
+			RFPGA0_XA_HSSIPARAMETER1, BIT(8));
+	/*  Switch BB to PI mode to do IQ Calibration. */
+	if (!rtlphy->rfpi_enable)
+		_rtl92d_phy_pimode_switch(hw, true);
+
+	/* MAC settings */
+	rtl92d_phy_mac_setting_calibration(hw, iqk_mac_reg,
+					   rtlphy->iqk_mac_backup);
+	rtl92d_phy_set_bb_reg_1byte(hw, RFPGA0_RFMOD, BCCKEN, 0x00);
+	rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKDWORD, 0x03a05600);
+	rtl_set_bbreg(hw, ROFDM0_TRMUXPAR, MASKDWORD, 0x000800e4);
+	rtl_set_bbreg(hw, RFPGA0_XCD_RFINTERFACESW, MASKDWORD, 0x22208000);
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0xf00000, 0x0f);
+
+	/* Page A AP setting for IQK */
+	rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0);
+	rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x20000000);
+	if (is2t) {
+		/* Page B AP setting for IQK */
+		rtl_set_bbreg(hw, RPDP_ANTB, MASKDWORD, 0);
+		rtl_set_bbreg(hw, RCONFIG_ANTB, MASKDWORD, 0x20000000);
+	}
+	/* IQ calibration setting  */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "IQK setting!\n");
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x808000);
+	rtl_set_bbreg(hw, RTX_IQK, MASKDWORD, 0x10007c00);
+	rtl_set_bbreg(hw, RRX_IQK, MASKDWORD, 0x01004800);
+	patha_ok = _rtl92d_phy_patha_iqk_5g_normal(hw, is2t);
+	if (patha_ok == 0x03) {
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path A IQK Success!!\n");
+		result[t][0] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A,
+					     MASK_IQK_RESULT);
+		result[t][1] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A,
+					     MASK_IQK_RESULT);
+		result[t][2] = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2,
+					     MASK_IQK_RESULT);
+		result[t][3] = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2,
+					     MASK_IQK_RESULT);
+	} else if (patha_ok == 0x01) {	/* Tx IQK OK */
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Path A IQK Only  Tx Success!!\n");
+
+		result[t][0] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A,
+					     MASK_IQK_RESULT);
+		result[t][1] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A,
+					     MASK_IQK_RESULT);
+	} else {
+		rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x000000);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "0xe70 = %#x\n",
+			rtl_get_bbreg(hw, RRX_WAIT_CCA, MASKDWORD));
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "RF path A 0x0 = %#x\n",
+			rtl_get_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK));
+		rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0x808000);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "Path A IQK Fail!!\n");
+	}
+	if (is2t) {
+		/* _rtl92d_phy_patha_standby(hw); */
+		/* Turn Path B ADDA on  */
+		rtl92d_phy_path_adda_on(hw, adda_reg, false, is2t);
+		pathb_ok = _rtl92d_phy_pathb_iqk_5g_normal(hw);
+		if (pathb_ok == 0x03) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path B IQK Success!!\n");
+			result[t][4] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B,
+						     MASK_IQK_RESULT);
+			result[t][5] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B,
+						     MASK_IQK_RESULT);
+			result[t][6] = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_B_2,
+						     MASK_IQK_RESULT);
+			result[t][7] = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_B_2,
+						     MASK_IQK_RESULT);
+		} else if (pathb_ok == 0x01) { /* Tx IQK OK */
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path B Only Tx IQK Success!!\n");
+			result[t][4] = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_B,
+						     MASK_IQK_RESULT);
+			result[t][5] = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_B,
+						     MASK_IQK_RESULT);
+		} else {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"Path B IQK failed!!\n");
+		}
+	}
+
+	/* Back to BB mode, load original value */
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"IQK:Back to BB mode, load original value!\n");
+	rtl_set_bbreg(hw, RFPGA0_IQK, MASKH3BYTES, 0);
+
+	if (is2t)
+		_rtl92d_phy_reload_adda_registers(hw, iqk_bb_reg,
+						  rtlphy->iqk_bb_backup,
+						  IQK_BB_REG_NUM);
+	else
+		_rtl92d_phy_reload_adda_registers(hw, iqk_bb_reg,
+						  rtlphy->iqk_bb_backup,
+						  IQK_BB_REG_NUM - 1);
+
+	/* path A IQ path to DP block */
+	rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x010170b8);
+	if (is2t) /* path B IQ path to DP block */
+		rtl_set_bbreg(hw, RPDP_ANTB, MASKDWORD, 0x010170b8);
+
+	/* Reload MAC parameters */
+	_rtl92d_phy_reload_mac_registers(hw, iqk_mac_reg,
+					 rtlphy->iqk_mac_backup);
+	/* Switch back BB to SI mode after finish IQ Calibration. */
+	if (!rtlphy->rfpi_enable)
+		_rtl92d_phy_pimode_switch(hw, false);
+
+	/* Reload ADDA power saving parameters */
+	_rtl92d_phy_reload_adda_registers(hw, adda_reg,
+					  rtlphy->adda_backup,
+					  IQK_ADDA_REG_NUM);
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "<==\n");
+}
+
+static bool _rtl92d_phy_simularity_compare(struct ieee80211_hw *hw,
+					   long result[][8], u8 c1, u8 c2)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 i, j, diff, sim_bitmap, bound, u4temp = 0;
+	u8 final_candidate[2] = {0xFF, 0xFF};	/* for path A and path B */
+	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
+	bool bresult = true;
+
+	if (is2t)
+		bound = 8;
+	else
+		bound = 4;
+	sim_bitmap = 0;
+	for (i = 0; i < bound; i++) {
+		diff = (result[c1][i] > result[c2][i]) ? (result[c1][i] -
+		       result[c2][i]) : (result[c2][i] - result[c1][i]);
+		if (diff > MAX_TOLERANCE_92D) {
+			if ((i == 2 || i == 6) && !sim_bitmap) {
+				if (result[c1][i] + result[c1][i + 1] == 0)
+					final_candidate[(i / 4)] = c2;
+				else if (result[c2][i] + result[c2][i + 1] == 0)
+					final_candidate[(i / 4)] = c1;
+				else
+					sim_bitmap = sim_bitmap | (1 << i);
+			} else {
+				sim_bitmap = sim_bitmap | (1 << i);
+			}
+		}
+	}
+	if (sim_bitmap == 0) {
+		for (i = 0; i < (bound / 4); i++) {
+			if (final_candidate[i] != 0xFF) {
+				for (j = i * 4; j < (i + 1) * 4 - 2; j++)
+					result[3][j] =
+						 result[final_candidate[i]][j];
+				bresult = false;
+			}
+		}
+
+		for (i = 0; i < bound; i++)
+			u4temp += result[c1][i] + result[c2][i];
+
+		if (u4temp == 0) /* IQK fail for c1 & c2 */
+			bresult = false;
+
+		return bresult;
+	}
+	if (!(sim_bitmap & 0x0F)) { /* path A OK */
+		for (i = 0; i < 4; i++)
+			result[3][i] = result[c1][i];
+	} else if (!(sim_bitmap & 0x03)) { /* path A, Tx OK */
+		for (i = 0; i < 2; i++)
+			result[3][i] = result[c1][i];
+	}
+	if (!(sim_bitmap & 0xF0) && is2t) { /* path B OK */
+		for (i = 4; i < 8; i++)
+			result[3][i] = result[c1][i];
+	} else if (!(sim_bitmap & 0x30)) { /* path B, Tx OK */
+		for (i = 4; i < 6; i++)
+			result[3][i] = result[c1][i];
+	}
+	return false;
+}
+
+static void _rtl92d_phy_patha_fill_iqk_matrix_5g_normal(struct ieee80211_hw *hw,
+							bool iqk_ok,
+							long result[][8],
+							u8 final_candidate,
+							bool txonly)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 val_x, reg;
+	int val_y;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Path A IQ Calibration %s !\n", iqk_ok ? "Success" : "Failed");
+	if (iqk_ok && final_candidate != 0xFF) {
+		val_x = result[final_candidate][0];
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "X = 0x%x\n", val_x);
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, 0x3FF0000, val_x);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24), 0);
+
+		val_y = result[final_candidate][1];
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+
+		/* path B IQK result + 3 */
+		if (rtlhal->current_bandtype == BAND_ON_5G)
+			val_y += 3;
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "Y = 0x%x\n", val_y);
+
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, 0x3FF, val_y);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(26), 0);
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "0xe30 = 0x%x\n",
+			rtl_get_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD));
+
+		if (txonly) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK, "only Tx OK\n");
+			return;
+		}
+		reg = result[final_candidate][2];
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, 0x3FF, reg);
+		reg = result[final_candidate][3] & 0x3F;
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, 0xFC00, reg);
+		reg = (result[final_candidate][3] >> 6) & 0xF;
+		rtl_set_bbreg(hw, ROFDM0_RXIQEXTANTA, 0xF0000000, reg);
+	} else {
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"%s: Tx/Rx fail restore default value\n", __func__);
+
+		rtl_set_bbreg(hw, RTX_IQK_TONE_A, MASKDWORD, 0x19008c00);
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, MASKDWORD, 0x40000100);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_A, MASKDWORD, 0x19008c00);
+	}
+}
+
+static void _rtl92d_phy_patha_fill_iqk_matrix(struct ieee80211_hw *hw,
+					      bool iqk_ok, long result[][8],
+					      u8 final_candidate, bool txonly)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 oldval_0, val_x, tx0_a, reg;
+	long val_y, tx0_c;
+	bool is2t = IS_92D_SINGLEPHY(rtlhal->version) ||
+		    rtlhal->macphymode == DUALMAC_DUALPHY;
+
+	if (rtlhal->current_bandtype == BAND_ON_5G) {
+		_rtl92d_phy_patha_fill_iqk_matrix_5g_normal(hw, iqk_ok, result,
+							    final_candidate,
+							    txonly);
+		return;
+	}
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Path A IQ Calibration %s !\n", iqk_ok ? "Success" : "Failed");
+	if (final_candidate == 0xFF) {
+		return;
+	} else if (iqk_ok) {
+		oldval_0 = (rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+			MASKDWORD) >> 22) & 0x3FF;	/* OFDM0_D */
+		val_x = result[final_candidate][0];
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+		tx0_a = (val_x * oldval_0) >> 8;
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"X = 0x%x, tx0_a = 0x%x, oldval_0 0x%x\n",
+			val_x, tx0_a, oldval_0);
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, 0x3FF, tx0_a);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(24),
+			      ((val_x * oldval_0 >> 7) & 0x1));
+		val_y = result[final_candidate][1];
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+		/* path B IQK result + 3 */
+		if (rtlhal->interfaceindex == 1 &&
+		    rtlhal->current_bandtype == BAND_ON_5G)
+			val_y += 3;
+		tx0_c = (val_y * oldval_0) >> 8;
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"Y = 0x%lx, tx0_c = 0x%lx\n",
+			val_y, tx0_c);
+		rtl_set_bbreg(hw, ROFDM0_XCTXAFE, 0xF0000000,
+			      ((tx0_c & 0x3C0) >> 6));
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, 0x003F0000,
+			      (tx0_c & 0x3F));
+		if (is2t)
+			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(26),
+				      ((val_y * oldval_0 >> 7) & 0x1));
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "0xC80 = 0x%x\n",
+			rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,
+				      MASKDWORD));
+		if (txonly) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,  "only Tx OK\n");
+			return;
+		}
+		reg = result[final_candidate][2];
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, 0x3FF, reg);
+		reg = result[final_candidate][3] & 0x3F;
+		rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, 0xFC00, reg);
+		reg = (result[final_candidate][3] >> 6) & 0xF;
+		rtl_set_bbreg(hw, ROFDM0_RXIQEXTANTA, 0xF0000000, reg);
+	}
+}
+
+static void _rtl92d_phy_pathb_fill_iqk_matrix_5g_normal(struct ieee80211_hw *hw,
+							bool iqk_ok,
+							long result[][8],
+							u8 final_candidate,
+							bool txonly)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 val_x, reg;
+	int val_y;
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"Path B IQ Calibration %s !\n", iqk_ok ? "Success" : "Failed");
+	if (iqk_ok && final_candidate != 0xFF) {
+		val_x = result[final_candidate][4];
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "X = 0x%x\n", val_x);
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, 0x3FF0000, val_x);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(28), 0);
+
+		val_y = result[final_candidate][5];
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+
+		/* path B IQK result + 3 */
+		if (rtlhal->current_bandtype == BAND_ON_5G)
+			val_y += 3;
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "Y = 0x%x\n", val_y);
+
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, 0x3FF, val_y);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(30), 0);
+
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "0xe50 = 0x%x\n",
+			rtl_get_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD));
+
+		if (txonly) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK, "only Tx OK\n");
+			return;
+		}
+		reg = result[final_candidate][6];
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, 0x3FF, reg);
+		reg = result[final_candidate][7] & 0x3F;
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, 0xFC00, reg);
+		reg = (result[final_candidate][7] >> 6) & 0xF;
+		rtl_set_bbreg(hw, ROFDM0_AGCRSSITABLE, 0x0000F000, reg);
+	} else {
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"%s: Tx/Rx fail restore default value\n", __func__);
+
+		rtl_set_bbreg(hw, RTX_IQK_TONE_B, MASKDWORD, 0x19008c00);
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, MASKDWORD, 0x40000100);
+		rtl_set_bbreg(hw, RRX_IQK_TONE_B, MASKDWORD, 0x19008c00);
+	}
+}
+
+static void _rtl92d_phy_pathb_fill_iqk_matrix(struct ieee80211_hw *hw,
+					      bool iqk_ok, long result[][8],
+					      u8 final_candidate, bool txonly)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 oldval_1, val_x, tx1_a, reg;
+	long val_y, tx1_c;
+
+	if (rtlhal->current_bandtype == BAND_ON_5G) {
+		_rtl92d_phy_pathb_fill_iqk_matrix_5g_normal(hw, iqk_ok, result,
+							    final_candidate,
+							    txonly);
+		return;
+	}
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK, "Path B IQ Calibration %s !\n",
+		iqk_ok ? "Success" : "Failed");
+	if (final_candidate == 0xFF) {
+		return;
+	} else if (iqk_ok) {
+		oldval_1 = (rtl_get_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
+					  MASKDWORD) >> 22) & 0x3FF;
+		val_x = result[final_candidate][4];
+		if ((val_x & 0x00000200) != 0)
+			val_x = val_x | 0xFFFFFC00;
+		tx1_a = (val_x * oldval_1) >> 8;
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "X = 0x%x, tx1_a = 0x%x\n",
+			val_x, tx1_a);
+		rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE, 0x3FF, tx1_a);
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(28),
+			      ((val_x * oldval_1 >> 7) & 0x1));
+		val_y = result[final_candidate][5];
+		if ((val_y & 0x00000200) != 0)
+			val_y = val_y | 0xFFFFFC00;
+		if (rtlhal->current_bandtype == BAND_ON_5G)
+			val_y += 3;
+		tx1_c = (val_y * oldval_1) >> 8;
+		RTPRINT(rtlpriv, FINIT, INIT_IQK, "Y = 0x%lx, tx1_c = 0x%lx\n",
+			val_y, tx1_c);
+		rtl_set_bbreg(hw, ROFDM0_XDTXAFE, 0xF0000000,
+			      ((tx1_c & 0x3C0) >> 6));
+		rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE, 0x003F0000,
+			      (tx1_c & 0x3F));
+		rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(30),
+			      ((val_y * oldval_1 >> 7) & 0x1));
+		if (txonly)
+			return;
+		reg = result[final_candidate][6];
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, 0x3FF, reg);
+		reg = result[final_candidate][7] & 0x3F;
+		rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, 0xFC00, reg);
+		reg = (result[final_candidate][7] >> 6) & 0xF;
+		rtl_set_bbreg(hw, ROFDM0_AGCRSSITABLE, 0x0000F000, reg);
+	}
+}
+
+void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw)
+{
+	long rege94, rege9c, regea4, regeac, regeb4;
+	bool is12simular, is13simular, is23simular;
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	long regebc, regec4, regecc, regtmp = 0;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 i, final_candidate, indexforchannel;
+	bool patha_ok, pathb_ok;
+	long result[4][8];
+
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"IQK:Start!!!channel %d\n", rtlphy->current_channel);
+	for (i = 0; i < 8; i++) {
+		result[0][i] = 0;
+		result[1][i] = 0;
+		result[2][i] = 0;
+		result[3][i] = 0;
+	}
+	final_candidate = 0xff;
+	patha_ok = false;
+	pathb_ok = false;
+	is12simular = false;
+	is23simular = false;
+	is13simular = false;
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"IQK !!!currentband %d\n", rtlhal->current_bandtype);
+
+	for (i = 0; i < 3; i++) {
+		if (rtlhal->current_bandtype == BAND_ON_5G) {
+			_rtl92d_phy_iq_calibrate_5g_normal(hw, result, i);
+		} else if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+			if (IS_92D_SINGLEPHY(rtlhal->version))
+				_rtl92d_phy_iq_calibrate(hw, result, i, true);
+			else
+				_rtl92d_phy_iq_calibrate(hw, result, i, false);
+		}
+		if (i == 1) {
+			is12simular = _rtl92d_phy_simularity_compare(hw, result,
+								     0, 1);
+			if (is12simular) {
+				final_candidate = 0;
+				break;
+			}
+		}
+		if (i == 2) {
+			is13simular = _rtl92d_phy_simularity_compare(hw, result,
+								     0, 2);
+			if (is13simular) {
+				final_candidate = 0;
+				break;
+			}
+			is23simular = _rtl92d_phy_simularity_compare(hw, result,
+								     1, 2);
+			if (is23simular) {
+				final_candidate = 1;
+			} else {
+				for (i = 0; i < 8; i++)
+					regtmp += result[3][i];
+
+				if (regtmp != 0)
+					final_candidate = 3;
+				else
+					final_candidate = 0xFF;
+			}
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		rege94 = result[i][0];
+		rege9c = result[i][1];
+		regea4 = result[i][2];
+		regeac = result[i][3];
+		regeb4 = result[i][4];
+		regebc = result[i][5];
+		regec4 = result[i][6];
+		regecc = result[i][7];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"IQK: rege94=%lx rege9c=%lx regea4=%lx regeac=%lx regeb4=%lx regebc=%lx regec4=%lx regecc=%lx\n",
+			rege94, rege9c, regea4, regeac, regeb4, regebc, regec4,
+			regecc);
+	}
+	if (final_candidate != 0xff) {
+		rege94 = result[final_candidate][0];
+		rtlphy->reg_e94 = rege94;
+		rege9c = result[final_candidate][1];
+		rtlphy->reg_e9c = rege9c;
+		regea4 = result[final_candidate][2];
+		regeac = result[final_candidate][3];
+		regeb4 = result[final_candidate][4];
+		rtlphy->reg_eb4 = regeb4;
+		regebc = result[final_candidate][5];
+		rtlphy->reg_ebc = regebc;
+		regec4 = result[final_candidate][6];
+		regecc = result[final_candidate][7];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"IQK: final_candidate is %x\n", final_candidate);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"IQK: rege94=%lx rege9c=%lx regea4=%lx regeac=%lx regeb4=%lx regebc=%lx regec4=%lx regecc=%lx\n",
+			rege94, rege9c, regea4, regeac, regeb4, regebc, regec4,
+			regecc);
+		patha_ok = true;
+		pathb_ok = true;
+	} else {
+		rtlphy->reg_e94 = 0x100;
+		rtlphy->reg_eb4 = 0x100; /* X default value */
+		rtlphy->reg_e9c = 0x0;
+		rtlphy->reg_ebc = 0x0;   /* Y default value */
+	}
+	if (rege94 != 0 /*&& regea4 != 0*/)
+		_rtl92d_phy_patha_fill_iqk_matrix(hw, patha_ok, result,
+						  final_candidate,
+						  regea4 == 0);
+	if (IS_92D_SINGLEPHY(rtlhal->version) &&
+	    regeb4 != 0 /*&& regec4 != 0*/)
+		_rtl92d_phy_pathb_fill_iqk_matrix(hw, pathb_ok, result,
+						  final_candidate,
+						  regec4 == 0);
+
+	if (final_candidate != 0xFF) {
+		indexforchannel = rtl92d_get_rightchnlplace_for_iqk(
+				  rtlphy->current_channel);
+
+		for (i = 0; i < IQK_MATRIX_REG_NUM; i++)
+			rtlphy->iqk_matrix[indexforchannel].
+				value[0][i] = result[final_candidate][i];
+		rtlphy->iqk_matrix[indexforchannel].iqk_done = true;
+
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_MLME, DBG_LOUD,
+			"IQK OK indexforchannel %d\n", indexforchannel);
+	}
+}
+
+void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	u8 indexforchannel;
+	bool need_iqk;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "channel %d\n", channel);
+	/*------Do IQK for normal chip and test chip 5G band------- */
+	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "indexforchannel %d done %d\n",
+		indexforchannel,
+		rtlphy->iqk_matrix[indexforchannel].iqk_done);
+
+	/* We need to do IQK if we're about to connect to a network on 5 GHz.
+	 * On 5 GHz a channel switch outside of scanning happens only before
+	 * connecting.
+	 */
+	need_iqk = !mac->act_scanning;
+
+	if (!rtlphy->iqk_matrix[indexforchannel].iqk_done && need_iqk) {
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_INIT, DBG_LOUD,
+			"Do IQK Matrix reg for channel:%d....\n", channel);
+		rtl92d_phy_iq_calibrate(hw);
+		return;
+	}
+
+	/* Just load the value. */
+	/* 2G band just load once. */
+	if ((!rtlhal->load_imrandiqk_setting_for2g && indexforchannel == 0) ||
+	    indexforchannel > 0) {
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"Just Read IQK Matrix reg for channel:%d....\n",
+			channel);
+		if (rtlphy->iqk_matrix[indexforchannel].value[0][0] != 0)
+			_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
+				rtlphy->iqk_matrix[indexforchannel].value, 0,
+				rtlphy->iqk_matrix[indexforchannel].value[0][2] == 0);
+		if (IS_92D_SINGLEPHY(rtlhal->version) &&
+		    rtlphy->iqk_matrix[indexforchannel].value[0][4] != 0)
+			_rtl92d_phy_pathb_fill_iqk_matrix(hw, true,
+				rtlphy->iqk_matrix[indexforchannel].value, 0,
+				rtlphy->iqk_matrix[indexforchannel].value[0][6] == 0);
+	}
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+}
+
+static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw, u8 channel)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u8 erfpath = rtlpriv->rtlhal.current_bandtype ==
+		BAND_ON_5G ? RF90_PATH_A :
+		IS_92D_SINGLEPHY(rtlpriv->rtlhal.version) ?
+		RF90_PATH_B : RF90_PATH_A;
+	bool bneed_powerdown_radio = false;
+	u32 u4tmp = 0, u4regvalue = 0;
+
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "path %d\n", erfpath);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK, "band type = %d\n",
+		rtlpriv->rtlhal.current_bandtype);
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "channel = %d\n", channel);
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G) {/* Path-A for 5G */
+		u4tmp = curveindex_5g[channel - 1];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"ver 1 set RF-A, 5G,	0x28 = 0x%x !!\n", u4tmp);
+		if (rtlpriv->rtlhal.macphymode == DUALMAC_DUALPHY &&
+		    rtlpriv->rtlhal.interfaceindex == 1) {
+			bneed_powerdown_radio =
+				rtl92d_phy_enable_anotherphy(hw, false);
+			rtlpriv->rtlhal.during_mac1init_radioa = true;
+			/* asume no this case */
+			if (bneed_powerdown_radio)
+				rtl92d_phy_enable_rf_env(hw, erfpath,
+							 &u4regvalue);
+		}
+		rtl_set_rfreg(hw, erfpath, RF_SYN_G4, 0x3f800, u4tmp);
+		if (bneed_powerdown_radio) {
+			rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
+			rtl92d_phy_powerdown_anotherphy(hw, false);
+		}
+	} else if (rtlpriv->rtlhal.current_bandtype == BAND_ON_2_4G) {
+		u4tmp = curveindex_2g[channel - 1];
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n", u4tmp);
+		if (rtlpriv->rtlhal.macphymode == DUALMAC_DUALPHY &&
+		    rtlpriv->rtlhal.interfaceindex == 0) {
+			bneed_powerdown_radio =
+				rtl92d_phy_enable_anotherphy(hw, true);
+			rtlpriv->rtlhal.during_mac0init_radiob = true;
+			if (bneed_powerdown_radio)
+				rtl92d_phy_enable_rf_env(hw, erfpath,
+							 &u4regvalue);
+		}
+		rtl_set_rfreg(hw, erfpath, RF_SYN_G4, 0x3f800, u4tmp);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n",
+			rtl_get_rfreg(hw,  erfpath, RF_SYN_G4, 0x3f800));
+		if (bneed_powerdown_radio) {
+			rtl92d_phy_restore_rf_env(hw, erfpath, &u4regvalue);
+			rtl92d_phy_powerdown_anotherphy(hw, true);
+		}
+	}
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+}
+
+static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u32 curvecount_val[CV_CURVE_CNT * 2] = {0};
+	u16 timeout = 800, timecount = 0;
+	u32 u4tmp, offset, rf_syn_g4[2];
+	u8 tmpreg, index, rf_mode[2];
+	u8 path = is2t ? 2 : 1;
+	u8 i;
+
+	/* Check continuous TX and Packet TX */
+	tmpreg = rtl_read_byte(rtlpriv, 0xd03);
+	/* if Deal with contisuous TX case, disable all continuous TX */
+	/* if Deal with Packet TX case, block all queues */
+	if ((tmpreg & 0x70) != 0)
+		rtl_write_byte(rtlpriv, 0xd03, tmpreg & 0x8F);
+	else
+		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0xFF);
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0xF00000, 0x0F);
+	for (index = 0; index < path; index++) {
+		/* 1. Read original RF mode */
+		offset = index == 0 ? ROFDM0_XAAGCCORE1 : ROFDM0_XBAGCCORE1;
+		rf_mode[index] = rtl_read_byte(rtlpriv, offset);
+		/* 2. Set RF mode = standby mode */
+		rtl_set_rfreg(hw, (enum radio_path)index, RF_AC,
+			      RFREG_OFFSET_MASK, 0x010000);
+
+		rf_syn_g4[index] = rtl_get_rfreg(hw, index, RF_SYN_G4,
+						 RFREG_OFFSET_MASK);
+		rtl_set_rfreg(hw, index, RF_SYN_G4, 0x700, 0x7);
+
+		/* switch CV-curve control by LC-calibration */
+		rtl_set_rfreg(hw, (enum radio_path)index, RF_SYN_G7,
+			      BIT(17), 0x0);
+		/* 4. Set LC calibration begin */
+		rtl_set_rfreg(hw, (enum radio_path)index, RF_CHNLBW,
+			      0x08000, 0x01);
+	}
+
+	for (index = 0; index < path; index++) {
+		u4tmp = rtl_get_rfreg(hw, (enum radio_path)index, RF_SYN_G6,
+				      RFREG_OFFSET_MASK);
+		while ((!(u4tmp & BIT(11))) && timecount <= timeout) {
+			mdelay(50);
+			timecount += 50;
+			u4tmp = rtl_get_rfreg(hw, (enum radio_path)index,
+					      RF_SYN_G6, RFREG_OFFSET_MASK);
+		}
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,
+			"PHY_LCK finish delay for %d ms=2\n", timecount);
+	}
+
+	if ((tmpreg & 0x70) != 0)
+		rtl_write_byte(rtlpriv, 0xd03, tmpreg);
+	else /*Deal with Packet TX case */
+		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
+
+	rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0xF00000, 0x00);
+
+	for (index = 0; index < path; index++) {
+		rtl_get_rfreg(hw, index, RF_SYN_G4, RFREG_OFFSET_MASK);
+		if (index == 0 && rtlhal->interfaceindex == 0) {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"path-A / 5G LCK\n");
+		} else {
+			RTPRINT(rtlpriv, FINIT, INIT_IQK,
+				"path-B / 2.4G LCK\n");
+		}
+		memset(curvecount_val, 0, sizeof(curvecount_val));
+		/* Set LC calibration off */
+		rtl_set_rfreg(hw, (enum radio_path)index, RF_CHNLBW,
+			      0x08000, 0x0);
+		RTPRINT(rtlpriv, FINIT, INIT_IQK,  "set RF 0x18[15] = 0\n");
+		/* save Curve-counting number */
+		for (i = 0; i < CV_CURVE_CNT; i++) {
+			u32 readval = 0, readval2 = 0;
+
+			rtl_set_rfreg(hw, (enum radio_path)index, 0x3F,
+				      0x7f, i);
+
+			rtl_set_rfreg(hw, (enum radio_path)index, 0x4D,
+				      RFREG_OFFSET_MASK, 0x0);
+			readval = rtl_get_rfreg(hw, (enum radio_path)index,
+						0x4F, RFREG_OFFSET_MASK);
+			curvecount_val[2 * i + 1] = (readval & 0xfffe0) >> 5;
+			/* reg 0x4f [4:0] */
+			/* reg 0x50 [19:10] */
+			readval2 = rtl_get_rfreg(hw, (enum radio_path)index,
+						 0x50, 0xffc00);
+			curvecount_val[2 * i] = (((readval & 0x1F) << 10) |
+						 readval2);
+		}
+		if (index == 0 && rtlhal->interfaceindex == 0)
+			rtl92d_phy_calc_curvindex(hw, targetchnl_5g,
+						  curvecount_val,
+						  true, curveindex_5g);
+		else
+			rtl92d_phy_calc_curvindex(hw, targetchnl_2g,
+						  curvecount_val,
+						  false, curveindex_2g);
+		/* switch CV-curve control mode */
+		rtl_set_rfreg(hw, (enum radio_path)index, RF_SYN_G7,
+			      BIT(17), 0x1);
+	}
+
+	/* Restore original situation  */
+	for (index = 0; index < path; index++) {
+		rtl_set_rfreg(hw, index, RF_SYN_G4, RFREG_OFFSET_MASK,
+			      rf_syn_g4[index]);
+
+		offset = index == 0 ? ROFDM0_XAAGCCORE1 : ROFDM0_XBAGCCORE1;
+		rtl_write_byte(rtlpriv, offset, 0x50);
+		rtl_write_byte(rtlpriv, offset, rf_mode[index]);
+	}
+
+	_rtl92d_phy_reload_lck_setting(hw, rtlpriv->phy.current_channel);
+}
+
+void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u32 timeout = 2000, timecount = 0;
+
+	while (rtlpriv->mac80211.act_scanning && timecount < timeout) {
+		udelay(50);
+		timecount += 50;
+	}
+
+	rtlphy->lck_inprogress = true;
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,
+		"LCK:Start!!! currentband %x delay %d ms\n",
+		rtlhal->current_bandtype, timecount);
+	if (IS_92D_SINGLEPHY(rtlhal->version)) {
+		_rtl92d_phy_lc_calibrate_sw(hw, true);
+	} else {
+		/* For 1T1R */
+		_rtl92d_phy_lc_calibrate_sw(hw, false);
+	}
+	rtlphy->lck_inprogress = false;
+	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LCK:Finish!!!\n");
+}
+
+void rtl92d_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
+{
+	/* Nothing to do. */
+}
+
+u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 num_total_rfpath = rtlphy->num_total_rfpath;
+	u8 channel = rtlphy->current_channel;
+	u32 timeout = 1000, timecount = 0;
+	u32 ret_value;
+	u8 rfpath;
+
+	if (rtlphy->sw_chnl_inprogress)
+		return 0;
+	if (rtlphy->set_bwmode_inprogress)
+		return 0;
+
+	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false driver sleep or unload\n");
+		return 0;
+	}
+	while (rtlphy->lck_inprogress && timecount < timeout) {
+		mdelay(50);
+		timecount += 50;
+	}
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY &&
+	    rtlhal->bandset == BAND_ON_BOTH) {
+		ret_value = rtl_get_bbreg(hw, RFPGA0_XAB_RFPARAMETER,
+					  MASKDWORD);
+		if (rtlphy->current_channel > 14 && !(ret_value & BIT(0)))
+			rtl92d_phy_switch_wirelessband(hw, BAND_ON_5G);
+		else if (rtlphy->current_channel <= 14 && (ret_value & BIT(0)))
+			rtl92d_phy_switch_wirelessband(hw, BAND_ON_2_4G);
+	}
+	switch (rtlhal->current_bandtype) {
+	case BAND_ON_5G:
+		/* Get first channel error when change between
+		 * 5G and 2.4G band.
+		 */
+		if (WARN_ONCE(channel <= 14, "rtl8192de: 5G but channel<=14\n"))
+			return 0;
+		break;
+	case BAND_ON_2_4G:
+		/* Get first channel error when change between
+		 * 5G and 2.4G band.
+		 */
+		if (WARN_ONCE(channel > 14, "rtl8192de: 2G but channel>14\n"))
+			return 0;
+		break;
+	default:
+		WARN_ONCE(true, "rtl8192de: Invalid WirelessMode(%#x)!!\n",
+			  rtlpriv->mac80211.mode);
+		break;
+	}
+	rtlphy->sw_chnl_inprogress = true;
+	if (channel == 0)
+		channel = 1;
+
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
+
+	rtl92d_phy_set_txpower_level(hw, channel);
+
+	for (rfpath = 0; rfpath < num_total_rfpath; rfpath++) {
+		u32p_replace_bits(&rtlphy->rfreg_chnlval[rfpath],
+				  channel, 0xff);
+
+		if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G) {
+			if (channel > 99)
+				rtlphy->rfreg_chnlval[rfpath] |= (BIT(18));
+			else
+				rtlphy->rfreg_chnlval[rfpath] &= ~BIT(18);
+			rtlphy->rfreg_chnlval[rfpath] |= (BIT(16) | BIT(8));
+		} else {
+			rtlphy->rfreg_chnlval[rfpath] &=
+				~(BIT(8) | BIT(16) | BIT(18));
+		}
+		rtl_set_rfreg(hw, rfpath, RF_CHNLBW, RFREG_OFFSET_MASK,
+			      rtlphy->rfreg_chnlval[rfpath]);
+		_rtl92d_phy_reload_imr_setting(hw, channel, rfpath);
+	}
+	_rtl92d_phy_switch_rf_setting(hw, channel);
+
+	/* do IQK when all parameters are ready */
+	rtl92d_phy_reload_iqk_setting(hw, channel);
+
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtlphy->sw_chnl_inprogress = false;
+	return 1;
+}
+
+static void _rtl92d_phy_set_rfon(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	/* a.  SYS_CLKR 0x08[11] = 1  restore MAC clock */
+	/* b.  SPS_CTRL 0x11[7:0] = 0x2b */
+	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY)
+		rtl_write_byte(rtlpriv, REG_SPS0_CTRL, 0x2b);
+	/* c.  For PCIE: SYS_FUNC_EN 0x02[7:0] = 0xE3 enable BB TRX function */
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
+	/* RF_ON_EXCEP(d~g): */
+	/* d.  APSD_CTRL 0x600[7:0] = 0x00 */
+	rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x00);
+	/* e.  SYS_FUNC_EN 0x02[7:0] = 0xE2  reset BB TRX function again */
+	/* f.  SYS_FUNC_EN 0x02[7:0] = 0xE3  enable BB TRX function*/
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
+	/* g.   txpause 0x522[7:0] = 0x00  enable mac tx queue */
+	rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
+}
+
+static void _rtl92d_phy_set_rfsleep(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 u4btmp;
+	u8 delay = 5;
+
+	/* a.   TXPAUSE 0x522[7:0] = 0xFF  Pause MAC TX queue  */
+	rtl_write_byte(rtlpriv, REG_TXPAUSE, 0xFF);
+	/* b.   RF path 0 offset 0x00 = 0x00  disable RF  */
+	rtl_set_rfreg(hw, RF90_PATH_A, 0x00, RFREG_OFFSET_MASK, 0x00);
+	/* c.   APSD_CTRL 0x600[7:0] = 0x40 */
+	rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x40);
+	/* d. APSD_CTRL 0x600[7:0] = 0x00
+	 * APSD_CTRL 0x600[7:0] = 0x00
+	 * RF path 0 offset 0x00 = 0x00
+	 * APSD_CTRL 0x600[7:0] = 0x40
+	 */
+	u4btmp = rtl_get_rfreg(hw, RF90_PATH_A, 0, RFREG_OFFSET_MASK);
+	while (u4btmp != 0 && delay > 0) {
+		rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x0);
+		rtl_set_rfreg(hw, RF90_PATH_A, 0x00, RFREG_OFFSET_MASK, 0x00);
+		rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x40);
+		u4btmp = rtl_get_rfreg(hw, RF90_PATH_A, 0, RFREG_OFFSET_MASK);
+		delay--;
+	}
+	if (delay == 0) {
+		/* Jump out the LPS turn off sequence to RF_ON_EXCEP */
+		rtl_write_byte(rtlpriv, REG_APSD_CTRL, 0x00);
+
+		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
+		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
+		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Fail !!! Switch RF timeout\n");
+		return;
+	}
+	/* e.   For PCIE: SYS_FUNC_EN 0x02[7:0] = 0xE2 reset BB TRX function */
+	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
+	/* f.   SPS_CTRL 0x11[7:0] = 0x22 */
+	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY)
+		rtl_write_byte(rtlpriv, REG_SPS0_CTRL, 0x22);
+	/* g.    SYS_CLKR 0x08[11] = 0  gated MAC clock */
+}
+
+bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
+				   enum rf_pwrstate rfpwr_state)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	bool bresult = true;
+
+	if (rfpwr_state == ppsc->rfpwr_state)
+		return false;
+	switch (rfpwr_state) {
+	case ERFON:
+		if (ppsc->rfpwr_state == ERFOFF &&
+		    RT_IN_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC)) {
+			u32 initializecount = 0;
+			bool rtstatus;
+
+			do {
+				initializecount++;
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic enable\n");
+				rtstatus = rtl_ps_enable_nic(hw);
+			} while (!rtstatus && (initializecount < 10));
+
+			RT_CLEAR_PS_LEVEL(ppsc,
+					  RT_RF_OFF_LEVL_HALT_NIC);
+		} else {
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"awake, slept:%d ms state_inap:%x\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies),
+				 rtlpriv->psc.state_inap);
+			ppsc->last_awake_jiffies = jiffies;
+			_rtl92d_phy_set_rfon(hw);
+		}
+
+		if (mac->link_state == MAC80211_LINKED)
+			rtlpriv->cfg->ops->led_control(hw,
+					 LED_CTL_LINK);
+		else
+			rtlpriv->cfg->ops->led_control(hw,
+					 LED_CTL_NO_LINK);
+		break;
+	case ERFOFF:
+		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"IPS Set eRf nic disable\n");
+			rtl_ps_disable_nic(hw);
+			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
+		} else {
+			if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS)
+				rtlpriv->cfg->ops->led_control(hw,
+						 LED_CTL_NO_LINK);
+			else
+				rtlpriv->cfg->ops->led_control(hw,
+						 LED_CTL_POWER_OFF);
+		}
+		break;
+	case ERFSLEEP:
+		if (ppsc->rfpwr_state == ERFOFF)
+			return false;
+
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"sleep awakened:%d ms state_inap:%x\n",
+			jiffies_to_msecs(jiffies -
+					 ppsc->last_awake_jiffies),
+			rtlpriv->psc.state_inap);
+		ppsc->last_sleep_jiffies = jiffies;
+		_rtl92d_phy_set_rfsleep(hw);
+		break;
+	default:
+		pr_err("switch case %#x not processed\n",
+		       rfpwr_state);
+		bresult = false;
+		break;
+	}
+	if (bresult)
+		ppsc->rfpwr_state = rfpwr_state;
+	return bresult;
+}
+
+void rtl92d_phy_set_poweron(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 value8;
+	u16 i;
+	u32 mac_reg = (rtlhal->interfaceindex == 0 ? REG_MAC0 : REG_MAC1);
+
+	/* notice fw know band status  0x81[1]/0x53[1] = 0: 5G, 1: 2G */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		value8 = rtl_read_byte(rtlpriv, mac_reg);
+		value8 |= BIT(1);
+		rtl_write_byte(rtlpriv, mac_reg, value8);
+	} else {
+		value8 = rtl_read_byte(rtlpriv, mac_reg);
+		value8 &= (~BIT(1));
+		rtl_write_byte(rtlpriv, mac_reg, value8);
+	}
+
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY) {
+		value8 = rtl_read_byte(rtlpriv, REG_MAC0);
+		rtl_write_byte(rtlpriv, REG_MAC0, value8 | MAC0_ON);
+	} else {
+		mutex_lock(&globalmutex_power);
+		if (rtlhal->interfaceindex == 0) {
+			value8 = rtl_read_byte(rtlpriv, REG_MAC0);
+			rtl_write_byte(rtlpriv, REG_MAC0, value8 | MAC0_ON);
+		} else {
+			value8 = rtl_read_byte(rtlpriv, REG_MAC1);
+			rtl_write_byte(rtlpriv, REG_MAC1, value8 | MAC1_ON);
+		}
+		value8 = rtl_read_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS);
+		mutex_unlock(&globalmutex_power);
+		for (i = 0; i < 200; i++) {
+			if ((value8 & BIT(7)) == 0) {
+				break;
+			} else {
+				udelay(500);
+				mutex_lock(&globalmutex_power);
+				value8 = rtl_read_byte(rtlpriv,
+						       REG_POWER_OFF_IN_PROCESS);
+				mutex_unlock(&globalmutex_power);
+			}
+		}
+		if (i == 200)
+			WARN_ONCE(true, "rtl8192de: Another mac power off over time\n");
+	}
+}
+
+void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_efuse *rtlefuse = rtl_efuse(rtlpriv);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	u8 rfpath, i;
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	/* r_select_5G for path_A/B 0 for 2.4G, 1 for 5G */
+	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+		/* r_select_5G for path_A/B,0x878 */
+		rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(0), 0x0);
+		rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(15), 0x0);
+		if (rtlhal->macphymode != DUALMAC_DUALPHY) {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(16), 0x0);
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(31), 0x0);
+		}
+		/* rssi_table_select:index 0 for 2.4G.1~3 for 5G,0xc78 */
+		rtl_set_bbreg(hw, ROFDM0_AGCRSSITABLE, BIT(6) | BIT(7), 0x0);
+		/* fc_area  0xd2c */
+		rtl_set_bbreg(hw, ROFDM1_CFOTRACKING, BIT(14) | BIT(13), 0x0);
+		/* 5G LAN ON */
+		rtl_set_bbreg(hw, 0xB30, 0x00F00000, 0xa);
+		/* TX BB gain shift*1,Just for testchip,0xc80,0xc88 */
+		rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD,
+			      0x40000100);
+		rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE, MASKDWORD,
+			      0x40000100);
+		if (rtlhal->macphymode == DUALMAC_DUALPHY) {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW,
+				      BIT(10) | BIT(6) | BIT(5),
+				      ((rtlefuse->eeprom_c9 & BIT(3)) >> 3) |
+				      (rtlefuse->eeprom_c9 & BIT(1)) |
+				      ((rtlefuse->eeprom_cc & BIT(1)) << 4));
+			rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE,
+				      BIT(10) | BIT(6) | BIT(5),
+				      ((rtlefuse->eeprom_c9 & BIT(2)) >> 2) |
+				      ((rtlefuse->eeprom_c9 & BIT(0)) << 1) |
+				      ((rtlefuse->eeprom_cc & BIT(0)) << 5));
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(15), 0);
+
+			rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x01017038);
+			rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x0f600000);
+		} else {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW,
+				      BIT(26) | BIT(22) | BIT(21) | BIT(10) |
+				      BIT(6) | BIT(5),
+				      ((rtlefuse->eeprom_c9 & BIT(3)) >> 3) |
+				      (rtlefuse->eeprom_c9 & BIT(1)) |
+				      ((rtlefuse->eeprom_cc & BIT(1)) << 4) |
+				      ((rtlefuse->eeprom_c9 & BIT(7)) << 9) |
+				      ((rtlefuse->eeprom_c9 & BIT(5)) << 12) |
+				      ((rtlefuse->eeprom_cc & BIT(3)) << 18));
+			rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE,
+				      BIT(10) | BIT(6) | BIT(5),
+				      ((rtlefuse->eeprom_c9 & BIT(2)) >> 2) |
+				      ((rtlefuse->eeprom_c9 & BIT(0)) << 1) |
+				      ((rtlefuse->eeprom_cc & BIT(0)) << 5));
+			rtl_set_bbreg(hw, RFPGA0_XB_RFINTERFACEOE,
+				      BIT(10) | BIT(6) | BIT(5),
+				      ((rtlefuse->eeprom_c9 & BIT(6)) >> 6) |
+				      ((rtlefuse->eeprom_c9 & BIT(4)) >> 3) |
+				      ((rtlefuse->eeprom_cc & BIT(2)) << 3));
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER,
+				      BIT(31) | BIT(15), 0);
+
+			rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x01017038);
+			rtl_set_bbreg(hw, RPDP_ANTB, MASKDWORD, 0x01017038);
+			rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x0f600000);
+			rtl_set_bbreg(hw, RCONFIG_ANTB, MASKDWORD, 0x0f600000);
+		}
+		/* 1.5V_LDO */
+	} else {
+		/* r_select_5G for path_A/B */
+		rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(0), 0x1);
+		rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(15), 0x1);
+		if (rtlhal->macphymode != DUALMAC_DUALPHY) {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(16), 0x1);
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(31), 0x1);
+		}
+		/* rssi_table_select:index 0 for 2.4G.1~3 for 5G */
+		rtl_set_bbreg(hw, ROFDM0_AGCRSSITABLE, BIT(6) | BIT(7), 0x1);
+		/* fc_area */
+		rtl_set_bbreg(hw, ROFDM1_CFOTRACKING, BIT(14) | BIT(13), 0x1);
+		/* 5G LAN ON */
+		rtl_set_bbreg(hw, 0xB30, 0x00F00000, 0x0);
+
+		/* TX BB gain shift,Just for testchip,0xc80,0xc88 */
+		if (rtlefuse->internal_pa_5g[rtlhal->interfaceindex])
+			rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD,
+				      0x2d4000b5);
+		else
+			rtl_set_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD,
+				      0x20000080);
+
+		if (rtlhal->macphymode != DUALMAC_DUALPHY) {
+			if (rtlefuse->internal_pa_5g[1])
+				rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
+					      MASKDWORD, 0x2d4000b5);
+			else
+				rtl_set_bbreg(hw, ROFDM0_XBTXIQIMBALANCE,
+					      MASKDWORD, 0x20000080);
+		}
+
+		rtl_set_bbreg(hw, 0xB30, BIT(27), 0);
+
+		if (rtlhal->macphymode == DUALMAC_DUALPHY) {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW,
+				      BIT(10) | BIT(6) | BIT(5),
+				      (rtlefuse->eeprom_cc & BIT(5)));
+			rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE, BIT(10),
+				      ((rtlefuse->eeprom_cc & BIT(4)) >> 4));
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER, BIT(15),
+				      (rtlefuse->eeprom_cc & BIT(4)) >> 4);
+
+			rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x01017098);
+			rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x20000000);
+		} else {
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFINTERFACESW,
+				      BIT(26) | BIT(22) | BIT(21) | BIT(10) |
+				      BIT(6) | BIT(5),
+				      (rtlefuse->eeprom_cc & BIT(5)) |
+				      ((rtlefuse->eeprom_cc & BIT(7)) << 14));
+			rtl_set_bbreg(hw, RFPGA0_XA_RFINTERFACEOE, BIT(10),
+				      ((rtlefuse->eeprom_cc & BIT(4)) >> 4));
+			rtl_set_bbreg(hw, RFPGA0_XB_RFINTERFACEOE, BIT(10),
+				      ((rtlefuse->eeprom_cc & BIT(6)) >> 6));
+			rtl_set_bbreg(hw, RFPGA0_XAB_RFPARAMETER,
+				      BIT(31) | BIT(15),
+				      ((rtlefuse->eeprom_cc & BIT(4)) >> 4) |
+				      ((rtlefuse->eeprom_cc & BIT(6)) << 10));
+
+			rtl_set_bbreg(hw, RPDP_ANTA, MASKDWORD, 0x01017098);
+			rtl_set_bbreg(hw, RPDP_ANTB, MASKDWORD, 0x01017098);
+			rtl_set_bbreg(hw, RCONFIG_ANTA, MASKDWORD, 0x20000000);
+			rtl_set_bbreg(hw, RCONFIG_ANTB, MASKDWORD, 0x20000000);
+		}
+	}
+	/* update IQK related settings */
+	rtl_set_bbreg(hw, ROFDM0_XARXIQIMBALANCE, MASKDWORD, 0x40000100);
+	rtl_set_bbreg(hw, ROFDM0_XBRXIQIMBALANCE, MASKDWORD, 0x40000100);
+	rtl_set_bbreg(hw, ROFDM0_XCTXAFE, 0xF0000000, 0x00);
+	rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD, BIT(30) | BIT(28) |
+		      BIT(26) | BIT(24), 0x00);
+	rtl_set_bbreg(hw, ROFDM0_XDTXAFE, 0xF0000000, 0x00);
+	rtl_set_bbreg(hw, ROFDM0_RXIQEXTANTA, 0xF0000000, 0x00);
+	rtl_set_bbreg(hw, ROFDM0_AGCRSSITABLE, 0x0000F000, 0x00);
+
+	/* Update RF */
+	for (rfpath = RF90_PATH_A; rfpath < rtlphy->num_total_rfpath;
+	     rfpath++) {
+		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
+			/* MOD_AG for RF path_A 0x18 BIT8,BIT16 */
+			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(8) | BIT(16) |
+				      BIT(18) | 0xff, 1);
+			/* RF0x0b[16:14] =3b'111 */
+			rtl_set_rfreg(hw, (enum radio_path)rfpath, 0x0B,
+				      0x1c000, 0x07);
+		} else {
+			/* MOD_AG for RF path_A 0x18 BIT8,BIT16 */
+			rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW, RFREG_OFFSET_MASK,
+				      0x97524);
+		}
+
+		/* Set right channel on RF reg0x18 for another mac. */
+		if (rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) {
+			/* Set MAC1 default channel if MAC1 not up. */
+			if (!(rtl_read_byte(rtlpriv, REG_MAC1) & MAC1_ON)) {
+				rtl92d_phy_enable_anotherphy(hw, true);
+				rtlhal->during_mac0init_radiob = true;
+				rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW,
+					      RFREG_OFFSET_MASK, 0x97524);
+				rtl92d_phy_powerdown_anotherphy(hw, true);
+			}
+		} else if (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G) {
+			/* Set MAC0 default channel */
+			if (!(rtl_read_byte(rtlpriv, REG_MAC0) & MAC0_ON)) {
+				rtl92d_phy_enable_anotherphy(hw, false);
+				rtlhal->during_mac1init_radioa = true;
+				rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW,
+					      RFREG_OFFSET_MASK, 0x87401);
+				rtl92d_phy_powerdown_anotherphy(hw, false);
+			}
+		}
+	}
+	/* Update for all band. */
+	/* DMDP */
+	if (rtlphy->rf_type == RF_1T1R) {
+		/* Use antenna 0,0xc04,0xd04 */
+		rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x11);
+		rtl_set_bbreg(hw, ROFDM1_TRXPATHENABLE, BDWORD, 0x1);
+
+		/* enable ad/da clock1 for dual-phy reg0x888 */
+		if (rtlhal->interfaceindex == 0) {
+			rtl_set_bbreg(hw, RFPGA0_ADDALLOCKEN, BIT(12) |
+				      BIT(13), 0x3);
+		} else if (rtl92d_phy_enable_anotherphy(hw, false)) {
+			rtlhal->during_mac1init_radioa = true;
+			rtl_set_bbreg(hw, RFPGA0_ADDALLOCKEN,
+				      BIT(12) | BIT(13), 0x3);
+			rtl92d_phy_powerdown_anotherphy(hw, false);
+		}
+
+		rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(19) | BIT(20), 0x0);
+	} else {
+		/* Single PHY */
+		/* Use antenna 0 & 1,0xc04,0xd04 */
+		rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x33);
+		rtl_set_bbreg(hw, ROFDM1_TRXPATHENABLE, BDWORD, 0x3);
+		/* disable ad/da clock1,0x888 */
+		rtl_set_bbreg(hw, RFPGA0_ADDALLOCKEN, BIT(12) | BIT(13), 0);
+
+		rtl_set_bbreg(hw, ROFDM1_LSTF, BIT(19) | BIT(20), 0x1);
+	}
+	for (rfpath = RF90_PATH_A; rfpath < rtlphy->num_total_rfpath;
+	     rfpath++) {
+		rtlphy->rfreg_chnlval[rfpath] = rtl_get_rfreg(hw, rfpath,
+							      RF_CHNLBW,
+							      RFREG_OFFSET_MASK);
+		rtlphy->reg_rf3c[rfpath] = rtl_get_rfreg(hw, rfpath, 0x3C,
+							 RFREG_OFFSET_MASK);
+	}
+	for (i = 0; i < 2; i++)
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "RF 0x18 = 0x%x\n",
+			rtlphy->rfreg_chnlval[i]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<==\n");
+}
+
+bool rtl92d_phy_check_poweroff(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+	u8 u1btmp;
+
+	if (rtlhal->macphymode == SINGLEMAC_SINGLEPHY) {
+		u1btmp = rtl_read_byte(rtlpriv, REG_MAC0);
+		rtl_write_byte(rtlpriv, REG_MAC0, u1btmp & (~MAC0_ON));
+		return true;
+	}
+	mutex_lock(&globalmutex_power);
+	if (rtlhal->interfaceindex == 0) {
+		u1btmp = rtl_read_byte(rtlpriv, REG_MAC0);
+		rtl_write_byte(rtlpriv, REG_MAC0, u1btmp & (~MAC0_ON));
+		u1btmp = rtl_read_byte(rtlpriv, REG_MAC1);
+		u1btmp &= MAC1_ON;
+	} else {
+		u1btmp = rtl_read_byte(rtlpriv, REG_MAC1);
+		rtl_write_byte(rtlpriv, REG_MAC1, u1btmp & (~MAC1_ON));
+		u1btmp = rtl_read_byte(rtlpriv, REG_MAC0);
+		u1btmp &= MAC0_ON;
+	}
+	if (u1btmp) {
+		mutex_unlock(&globalmutex_power);
+		return false;
+	}
+	u1btmp = rtl_read_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS);
+	u1btmp |= BIT(7);
+	rtl_write_byte(rtlpriv, REG_POWER_OFF_IN_PROCESS, u1btmp);
+	mutex_unlock(&globalmutex_power);
+	return true;
+}
+
+void rtl92du_phy_init_pa_bias(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	bool is_single_mac = rtlhal->macphymode == SINGLEMAC_SINGLEPHY;
+	enum radio_path rf_path;
+	u8 val8;
+
+	read_efuse_byte(hw, 0x3FA, &val8);
+
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "%s: 0x3FA %#x\n",
+		__func__, val8);
+
+	if (!(val8 & BIT(0)) && (is_single_mac || rtlhal->interfaceindex == 0)) {
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW, RFREG_OFFSET_MASK, 0x07401);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x0F425);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x4F425);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x8F425);
+
+		/* Back to RX Mode */
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x30000);
+
+		rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "2G PA BIAS path A\n");
+	}
+
+	if (!(val8 & BIT(1)) && (is_single_mac || rtlhal->interfaceindex == 1)) {
+		rf_path = rtlhal->interfaceindex == 1 ? RF90_PATH_A : RF90_PATH_B;
+
+		rtl_set_rfreg(hw, rf_path, RF_CHNLBW, RFREG_OFFSET_MASK, 0x07401);
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x0F425);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x4F425);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x8F425);
+
+		/* Back to RX Mode */
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x30000);
+
+		rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "2G PA BIAS path B\n");
+	}
+
+	if (!(val8 & BIT(2)) && (is_single_mac || rtlhal->interfaceindex == 0)) {
+		/* 5GL_channel */
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW, RFREG_OFFSET_MASK, 0x17524);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* 5GM_channel */
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW, RFREG_OFFSET_MASK, 0x37564);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* 5GH_channel */
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_CHNLBW, RFREG_OFFSET_MASK, 0x57595);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* Back to RX Mode */
+		rtl_set_rfreg(hw, RF90_PATH_A, RF_AC, RFREG_OFFSET_MASK, 0x30000);
+
+		rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "5G PA BIAS path A\n");
+	}
+
+	if (!(val8 & BIT(3)) && (is_single_mac || rtlhal->interfaceindex == 1)) {
+		rf_path = rtlhal->interfaceindex == 1 ? RF90_PATH_A : RF90_PATH_B;
+
+		/* 5GL_channel */
+		rtl_set_rfreg(hw, rf_path, RF_CHNLBW, RFREG_OFFSET_MASK, 0x17524);
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* 5GM_channel */
+		rtl_set_rfreg(hw, rf_path, RF_CHNLBW, RFREG_OFFSET_MASK, 0x37564);
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* 5GH_channel */
+		rtl_set_rfreg(hw, rf_path, RF_CHNLBW, RFREG_OFFSET_MASK, 0x57595);
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x70000);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x0F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x4F496);
+		rtl_set_rfreg(hw, rf_path, RF_IPA, RFREG_OFFSET_MASK, 0x8F496);
+
+		/* Back to RX Mode */
+		rtl_set_rfreg(hw, rf_path, RF_AC, RFREG_OFFSET_MASK, 0x30000);
+
+		rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "5G PA BIAS path B\n");
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
new file mode 100644
index 000000000000..576b6fdf0e4a
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D_PHY_H__
+#define __RTL92D_PHY_H__
+
+u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw,
+			    u32 regaddr, u32 bitmask);
+void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
+			   u32 regaddr, u32 bitmask, u32 data);
+bool rtl92d_phy_mac_config(struct ieee80211_hw *hw);
+bool rtl92d_phy_bb_config(struct ieee80211_hw *hw);
+bool rtl92d_phy_rf_config(struct ieee80211_hw *hw);
+void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
+			    enum nl80211_channel_type ch_type);
+u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw);
+bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
+					  enum rf_content content,
+					  enum radio_path rfpath);
+bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
+				   enum rf_pwrstate rfpwr_state);
+
+void rtl92d_phy_set_poweron(struct ieee80211_hw *hw);
+bool rtl92d_phy_check_poweroff(struct ieee80211_hw *hw);
+void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw);
+void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw);
+void rtl92d_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
+void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw);
+void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel);
+void rtl92du_phy_init_pa_bias(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
new file mode 100644
index 000000000000..afdf03940015
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/rf_common.h"
+#include "phy.h"
+#include "rf.h"
+#include "dm.h"
+#include "hw.h"
+
+bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u8 mac_on_bit = bmac0 ? MAC1_ON : MAC0_ON;
+	u8 mac_reg = bmac0 ? REG_MAC1 : REG_MAC0;
+	bool bresult = true; /* true: need to enable BB/RF power */
+	u32 maskforphyset = 0;
+	u16 val16;
+	u8 u1btmp;
+
+	rtlhal->during_mac0init_radiob = false;
+	rtlhal->during_mac1init_radioa = false;
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
+	/* MAC0 Need PHY1 load radio_b.txt . Driver use DBI to write. */
+	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
+	if (!(u1btmp & mac_on_bit)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
+		/* Enable BB and RF power */
+
+		maskforphyset = bmac0 ? MAC0_ACCESS_PHY1 : MAC1_ACCESS_PHY0;
+
+		val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset);
+		val16 &= 0xfffc;
+		rtl_write_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset, val16);
+
+		val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset);
+		val16 |= BIT(13) | BIT(0) | BIT(1);
+		rtl_write_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset, val16);
+	} else {
+		/* We think if MAC1 is ON,then radio_a.txt
+		 * and radio_b.txt has been load.
+		 */
+		bresult = false;
+	}
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
+	return bresult;
+}
+
+void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u8 mac_on_bit = bmac0 ? MAC1_ON : MAC0_ON;
+	u8 mac_reg = bmac0 ? REG_MAC1 : REG_MAC0;
+	u32 maskforphyset = 0;
+	u8 u1btmp;
+
+	rtlhal->during_mac0init_radiob = false;
+	rtlhal->during_mac1init_radioa = false;
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	/* check MAC0 enable or not again now, if
+	 * enabled, not power down radio A.
+	 */
+	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
+	if (!(u1btmp & mac_on_bit)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
+		/* power down RF radio A according to YuNan's advice. */
+		maskforphyset = bmac0 ? MAC0_ACCESS_PHY1 : MAC1_ACCESS_PHY0;
+		rtl_write_dword(rtlpriv, RFPGA0_XA_LSSIPARAMETER | maskforphyset,
+				0x00000000);
+	}
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+}
+
+bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
+{
+	bool mac1_initradioa_first = false, mac0_initradiob_first = false;
+	bool need_pwrdown_radioa = false, need_pwrdown_radiob = false;
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg;
+	bool true_bpath = false;
+	bool rtstatus = true;
+	u32 u4_regvalue = 0;
+	u8 rfpath;
+
+	if (rtlphy->rf_type == RF_1T1R)
+		rtlphy->num_total_rfpath = 1;
+	else
+		rtlphy->num_total_rfpath = 2;
+
+	/* Single phy mode: use radio_a radio_b config path_A path_B */
+	/* separately by MAC0, and MAC1 needn't configure RF; */
+	/* Dual PHY mode:MAC0 use radio_a config 1st phy path_A, */
+	/* MAC1 use radio_b config 2nd PHY path_A. */
+	/* DMDP,MAC0 on G band,MAC1 on A band. */
+	if (rtlhal->macphymode == DUALMAC_DUALPHY) {
+		if (rtlhal->current_bandtype == BAND_ON_2_4G &&
+		    rtlhal->interfaceindex == 0) {
+			/* MAC0 needs PHY1 load radio_b.txt. */
+			if (rtl92d_phy_enable_anotherphy(hw, true)) {
+				rtlphy->num_total_rfpath = 2;
+				mac0_initradiob_first = true;
+			} else {
+				/* We think if MAC1 is ON,then radio_a.txt and
+				 * radio_b.txt has been load.
+				 */
+				return rtstatus;
+			}
+		} else if (rtlhal->current_bandtype == BAND_ON_5G &&
+			   rtlhal->interfaceindex == 1) {
+			/* MAC1 needs PHY0 load radio_a.txt. */
+			if (rtl92d_phy_enable_anotherphy(hw, false)) {
+				rtlphy->num_total_rfpath = 2;
+				mac1_initradioa_first = true;
+			} else {
+				/* We think if MAC0 is ON, then radio_a.txt and
+				 * radio_b.txt has been load.
+				 */
+				return rtstatus;
+			}
+		} else if (rtlhal->interfaceindex == 1) {
+			/* MAC0 enabled, only init radia B.   */
+			true_bpath = true;
+		}
+	}
+
+	for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
+		/* Mac1 use PHY0 write */
+		if (mac1_initradioa_first) {
+			if (rfpath == RF90_PATH_A) {
+				rtlhal->during_mac1init_radioa = true;
+				need_pwrdown_radioa = true;
+			} else if (rfpath == RF90_PATH_B) {
+				rtlhal->during_mac1init_radioa = false;
+				mac1_initradioa_first = false;
+				rfpath = RF90_PATH_A;
+				true_bpath = true;
+				rtlphy->num_total_rfpath = 1;
+			}
+		} else if (mac0_initradiob_first) {
+			/* Mac0 use PHY1 write */
+			if (rfpath == RF90_PATH_A)
+				rtlhal->during_mac0init_radiob = false;
+			if (rfpath == RF90_PATH_B) {
+				rtlhal->during_mac0init_radiob = true;
+				mac0_initradiob_first = false;
+				need_pwrdown_radiob = true;
+				rfpath = RF90_PATH_A;
+				true_bpath = true;
+				rtlphy->num_total_rfpath = 1;
+			}
+		}
+		pphyreg = &rtlphy->phyreg_def[rfpath];
+		switch (rfpath) {
+		case RF90_PATH_A:
+		case RF90_PATH_C:
+			u4_regvalue = rtl_get_bbreg(hw, pphyreg->rfintfs,
+						    BRFSI_RFENV);
+			break;
+		case RF90_PATH_B:
+		case RF90_PATH_D:
+			u4_regvalue = rtl_get_bbreg(hw, pphyreg->rfintfs,
+						    BRFSI_RFENV << 16);
+			break;
+		}
+		rtl_set_bbreg(hw, pphyreg->rfintfe, BRFSI_RFENV << 16, 0x1);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfintfo, BRFSI_RFENV, 0x1);
+		udelay(1);
+		/* Set bit number of Address and Data for RF register */
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2,
+			      B3WIREADDRESSLENGTH, 0x0);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
+		udelay(1);
+		switch (rfpath) {
+		case RF90_PATH_A:
+			if (true_bpath)
+				rtstatus = rtl92d_phy_config_rf_with_headerfile(
+						hw, radiob_txt,
+						(enum radio_path)rfpath);
+			else
+				rtstatus = rtl92d_phy_config_rf_with_headerfile(
+						hw, radioa_txt,
+						(enum radio_path)rfpath);
+			break;
+		case RF90_PATH_B:
+			rtstatus =
+			    rtl92d_phy_config_rf_with_headerfile(hw, radiob_txt,
+						(enum radio_path)rfpath);
+			break;
+		case RF90_PATH_C:
+			break;
+		case RF90_PATH_D:
+			break;
+		}
+		switch (rfpath) {
+		case RF90_PATH_A:
+		case RF90_PATH_C:
+			rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV,
+				      u4_regvalue);
+			break;
+		case RF90_PATH_B:
+		case RF90_PATH_D:
+			rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16,
+				      u4_regvalue);
+			break;
+		}
+		if (!rtstatus) {
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
+			goto phy_rf_cfg_fail;
+		}
+	}
+
+	/* check MAC0 enable or not again, if enabled,
+	 * not power down radio A.
+	 * check MAC1 enable or not again, if enabled,
+	 * not power down radio B.
+	 */
+	if (need_pwrdown_radioa)
+		rtl92d_phy_powerdown_anotherphy(hw, false);
+	else if (need_pwrdown_radiob)
+		rtl92d_phy_powerdown_anotherphy(hw, true);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+	return rtstatus;
+
+phy_rf_cfg_fail:
+	return rtstatus;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
new file mode 100644
index 000000000000..c097d90cc99c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D_RF_H__
+#define __RTL92D_RF_H__
+
+bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw);
+bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
new file mode 100644
index 000000000000..a05596afbc7b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../core.h"
+#include "../usb.h"
+#include "../base.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/hw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
+#include "phy.h"
+#include "dm.h"
+#include "fw.h"
+#include "hw.h"
+#include "sw.h"
+#include "trx.h"
+#include "led.h"
+
+#include <linux/module.h>
+
+static int rtl92du_init_sw_vars(struct ieee80211_hw *hw)
+{
+	const char *fw_name = "rtlwifi/rtl8192dufw.bin";
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	int err;
+
+	rtlpriv->dm.dm_initialgain_enable = true;
+	rtlpriv->dm.dm_flag = 0;
+	rtlpriv->dm.disable_framebursting = false;
+	rtlpriv->dm.thermalvalue = 0;
+	rtlpriv->dm.useramask = true;
+
+	/* dual mac */
+	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G)
+		rtlpriv->phy.current_channel = 36;
+	else
+		rtlpriv->phy.current_channel = 1;
+
+	if (rtlpriv->rtlhal.macphymode != SINGLEMAC_SINGLEPHY)
+		rtlpriv->rtlhal.disable_amsdu_8k = true;
+
+	/* for LPS & IPS */
+	rtlpriv->psc.inactiveps = rtlpriv->cfg->mod_params->inactiveps;
+	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
+	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
+	if (!rtlpriv->psc.inactiveps)
+		pr_info("Inactive Power Save off (module option)\n");
+
+	/* for early mode */
+	rtlpriv->rtlhal.earlymode_enable = false;
+
+	/* for firmware buf */
+	rtlpriv->rtlhal.pfirmware = kmalloc(0x8000, GFP_KERNEL);
+	if (!rtlpriv->rtlhal.pfirmware) {
+		pr_err("Can't alloc buffer for fw\n");
+		return 1;
+	}
+
+	rtlpriv->max_fw_size = 0x8000;
+	pr_info("Driver for Realtek RTL8192DU WLAN interface\n");
+	pr_info("Loading firmware file %s\n", fw_name);
+
+	/* request fw */
+	err = request_firmware_nowait(THIS_MODULE, 1, fw_name,
+				      rtlpriv->io.dev, GFP_KERNEL, hw,
+				      rtl_fw_cb);
+	if (err) {
+		pr_err("Failed to request firmware!\n");
+		kfree(rtlpriv->rtlhal.pfirmware);
+		rtlpriv->rtlhal.pfirmware = NULL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void rtl92du_deinit_sw_vars(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	kfree(rtlpriv->rtlhal.pfirmware);
+	rtlpriv->rtlhal.pfirmware = NULL;
+}
+
+static struct rtl_hal_ops rtl8192du_hal_ops = {
+	.init_sw_vars = rtl92du_init_sw_vars,
+	.deinit_sw_vars = rtl92du_deinit_sw_vars,
+	.read_chip_version = rtl92du_read_chip_version,
+	.read_eeprom_info = rtl92de_read_eeprom_info,
+	.hw_init = rtl92du_hw_init,
+	.hw_disable = rtl92du_card_disable,
+	.enable_interrupt = rtl92de_enable_interrupt,
+	.disable_interrupt = rtl92de_disable_interrupt,
+	.set_network_type = rtl92de_set_network_type,
+	.set_chk_bssid = rtl92de_set_check_bssid,
+	.set_qos = rtl92de_set_qos,
+	.set_bcn_reg = rtl92de_set_beacon_related_registers,
+	.set_bcn_intv = rtl92de_set_beacon_interval,
+	.update_interrupt_mask = rtl92de_update_interrupt_mask,
+	.get_hw_reg = rtl92du_get_hw_reg,
+	.set_hw_reg = rtl92du_set_hw_reg,
+	.update_rate_tbl = rtl92de_update_hal_rate_tbl,
+	.fill_tx_desc = rtl92du_tx_fill_desc,
+	.query_rx_desc = rtl92de_rx_query_desc,
+	.set_channel_access = rtl92de_update_channel_access_setting,
+	.radio_onoff_checking = rtl92de_gpio_radio_on_off_checking,
+	.set_bw_mode = rtl92d_phy_set_bw_mode,
+	.switch_channel = rtl92d_phy_sw_chnl,
+	.dm_watchdog = rtl92du_dm_watchdog,
+	.scan_operation_backup = rtl_phy_scan_operation_backup,
+	.set_rf_power_state = rtl92d_phy_set_rf_power_state,
+	.led_control = rtl92de_led_control,
+	.set_desc = rtl92de_set_desc,
+	.get_desc = rtl92de_get_desc,
+	.enable_hw_sec = rtl92de_enable_hw_security_config,
+	.set_key = rtl92de_set_key,
+	.get_bbreg = rtl92d_phy_query_bb_reg,
+	.set_bbreg = rtl92d_phy_set_bb_reg,
+	.get_rfreg = rtl92d_phy_query_rf_reg,
+	.set_rfreg = rtl92d_phy_set_rf_reg,
+	.linked_set_reg = rtl92d_linked_set_reg,
+	.fill_h2c_cmd = rtl92d_fill_h2c_cmd,
+	.get_btc_status = rtl_btc_status_false,
+};
+
+static struct rtl_mod_params rtl92du_mod_params = {
+	.sw_crypto = false,
+	.inactiveps = false,
+	.swctrl_lps = false,
+	.debug_level = 0,
+	.debug_mask = 0,
+};
+
+static struct rtl_hal_usbint_cfg rtl92du_interface_cfg = {
+	/* rx */
+	.rx_urb_num = 8,
+	.rx_max_size = 15360,
+	.usb_rx_hdl = NULL,
+	.usb_rx_segregate_hdl = NULL,
+	/* tx */
+	.usb_tx_cleanup = rtl92du_tx_cleanup,
+	.usb_tx_post_hdl = rtl92du_tx_post_hdl,
+	.usb_tx_aggregate_hdl = rtl92du_tx_aggregate_hdl,
+	.usb_endpoint_mapping = rtl92du_endpoint_mapping,
+	.usb_mq_to_hwq = rtl92du_mq_to_hwq,
+};
+
+static struct rtl_hal_cfg rtl92du_hal_cfg = {
+	.name = "rtl8192du",
+	.ops = &rtl8192du_hal_ops,
+	.mod_params = &rtl92du_mod_params,
+	.usb_interface_cfg = &rtl92du_interface_cfg,
+
+	.maps[SYS_ISO_CTRL] = REG_SYS_ISO_CTRL,
+	.maps[SYS_FUNC_EN] = REG_SYS_FUNC_EN,
+	.maps[SYS_CLK] = REG_SYS_CLKR,
+	.maps[MAC_RCR_AM] = RCR_AM,
+	.maps[MAC_RCR_AB] = RCR_AB,
+	.maps[MAC_RCR_ACRC32] = RCR_ACRC32,
+	.maps[MAC_RCR_ACF] = RCR_ACF,
+	.maps[MAC_RCR_AAP] = RCR_AAP,
+
+	.maps[EFUSE_TEST] = REG_EFUSE_TEST,
+	.maps[EFUSE_ACCESS] = REG_EFUSE_ACCESS,
+	.maps[EFUSE_CTRL] = REG_EFUSE_CTRL,
+	.maps[EFUSE_CLK] = 0,	/* just for 92se */
+	.maps[EFUSE_CLK_CTRL] = REG_EFUSE_CTRL,
+	.maps[EFUSE_PWC_EV12V] = PWC_EV12V,
+	.maps[EFUSE_FEN_ELDR] = FEN_ELDR,
+	.maps[EFUSE_LOADER_CLK_EN] = 0,
+	.maps[EFUSE_ANA8M] = 0,	/* just for 92se */
+	.maps[EFUSE_HWSET_MAX_SIZE] = HWSET_MAX_SIZE,
+	.maps[EFUSE_MAX_SECTION_MAP] = EFUSE_MAX_SECTION,
+	.maps[EFUSE_REAL_CONTENT_SIZE] = EFUSE_REAL_CONTENT_LEN,
+
+	.maps[RWCAM] = REG_CAMCMD,
+	.maps[WCAMI] = REG_CAMWRITE,
+	.maps[RCAMO] = REG_CAMREAD,
+	.maps[CAMDBG] = REG_CAMDBG,
+	.maps[SECR] = REG_SECCFG,
+	.maps[SEC_CAM_NONE] = CAM_NONE,
+	.maps[SEC_CAM_WEP40] = CAM_WEP40,
+	.maps[SEC_CAM_TKIP] = CAM_TKIP,
+	.maps[SEC_CAM_AES] = CAM_AES,
+	.maps[SEC_CAM_WEP104] = CAM_WEP104,
+
+	.maps[RTL_IMR_BCNDMAINT6] = IMR_BCNDMAINT6,
+	.maps[RTL_IMR_BCNDMAINT5] = IMR_BCNDMAINT5,
+	.maps[RTL_IMR_BCNDMAINT4] = IMR_BCNDMAINT4,
+	.maps[RTL_IMR_BCNDMAINT3] = IMR_BCNDMAINT3,
+	.maps[RTL_IMR_BCNDMAINT2] = IMR_BCNDMAINT2,
+	.maps[RTL_IMR_BCNDMAINT1] = IMR_BCNDMAINT1,
+	.maps[RTL_IMR_BCNDOK8] = IMR_BCNDOK8,
+	.maps[RTL_IMR_BCNDOK7] = IMR_BCNDOK7,
+	.maps[RTL_IMR_BCNDOK6] = IMR_BCNDOK6,
+	.maps[RTL_IMR_BCNDOK5] = IMR_BCNDOK5,
+	.maps[RTL_IMR_BCNDOK4] = IMR_BCNDOK4,
+	.maps[RTL_IMR_BCNDOK3] = IMR_BCNDOK3,
+	.maps[RTL_IMR_BCNDOK2] = IMR_BCNDOK2,
+	.maps[RTL_IMR_BCNDOK1] = IMR_BCNDOK1,
+	.maps[RTL_IMR_TIMEOUT2] = IMR_TIMEOUT2,
+	.maps[RTL_IMR_TIMEOUT1] = IMR_TIMEOUT1,
+
+	.maps[RTL_IMR_TXFOVW] = IMR_TXFOVW,
+	.maps[RTL_IMR_PSTIMEOUT] = IMR_PSTIMEOUT,
+	.maps[RTL_IMR_BCNINT] = IMR_BCNINT,
+	.maps[RTL_IMR_RXFOVW] = IMR_RXFOVW,
+	.maps[RTL_IMR_RDU] = IMR_RDU,
+	.maps[RTL_IMR_ATIMEND] = IMR_ATIMEND,
+	.maps[RTL_IMR_BDOK] = IMR_BDOK,
+	.maps[RTL_IMR_MGNTDOK] = IMR_MGNTDOK,
+	.maps[RTL_IMR_TBDER] = IMR_TBDER,
+	.maps[RTL_IMR_HIGHDOK] = IMR_HIGHDOK,
+	.maps[RTL_IMR_TBDOK] = IMR_TBDOK,
+	.maps[RTL_IMR_BKDOK] = IMR_BKDOK,
+	.maps[RTL_IMR_BEDOK] = IMR_BEDOK,
+	.maps[RTL_IMR_VIDOK] = IMR_VIDOK,
+	.maps[RTL_IMR_VODOK] = IMR_VODOK,
+	.maps[RTL_IMR_ROK] = IMR_ROK,
+	.maps[RTL_IBSS_INT_MASKS] = (IMR_BCNINT | IMR_TBDOK | IMR_TBDER),
+
+	.maps[RTL_RC_CCK_RATE1M] = DESC_RATE1M,
+	.maps[RTL_RC_CCK_RATE2M] = DESC_RATE2M,
+	.maps[RTL_RC_CCK_RATE5_5M] = DESC_RATE5_5M,
+	.maps[RTL_RC_CCK_RATE11M] = DESC_RATE11M,
+	.maps[RTL_RC_OFDM_RATE6M] = DESC_RATE6M,
+	.maps[RTL_RC_OFDM_RATE9M] = DESC_RATE9M,
+	.maps[RTL_RC_OFDM_RATE12M] = DESC_RATE12M,
+	.maps[RTL_RC_OFDM_RATE18M] = DESC_RATE18M,
+	.maps[RTL_RC_OFDM_RATE24M] = DESC_RATE24M,
+	.maps[RTL_RC_OFDM_RATE36M] = DESC_RATE36M,
+	.maps[RTL_RC_OFDM_RATE48M] = DESC_RATE48M,
+	.maps[RTL_RC_OFDM_RATE54M] = DESC_RATE54M,
+
+	.maps[RTL_RC_HT_RATEMCS7] = DESC_RATEMCS7,
+	.maps[RTL_RC_HT_RATEMCS15] = DESC_RATEMCS15,
+};
+
+MODULE_AUTHOR("lizhaoming	<chaoming_li@realsil.com.cn>");
+MODULE_AUTHOR("Realtek WlanFAE	<wlanfae@realtek.com>");
+MODULE_AUTHOR("Larry Finger	<Larry.Finger@lwfinger.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek 8192DU 802.11an Dual Mac USB wireless");
+MODULE_FIRMWARE("rtlwifi/rtl8192dufw.bin");
+
+module_param_named(swenc, rtl92du_mod_params.sw_crypto, bool, 0444);
+module_param_named(debug_level, rtl92du_mod_params.debug_level, int, 0644);
+module_param_named(ips, rtl92du_mod_params.inactiveps, bool, 0444);
+module_param_named(swlps, rtl92du_mod_params.swctrl_lps, bool, 0444);
+module_param_named(debug_mask, rtl92du_mod_params.debug_mask, ullong, 0644);
+MODULE_PARM_DESC(swenc, "Set to 1 for software crypto (default 0)\n");
+MODULE_PARM_DESC(ips, "Set to 0 to not use link power save (default 0)\n");
+MODULE_PARM_DESC(swlps, "Set to 1 to use SW control power save (default 0)\n");
+MODULE_PARM_DESC(debug_level, "Set debug level (0-5) (default 0)");
+MODULE_PARM_DESC(debug_mask, "Set debug mask (default 0)");
+
+/* Add global mutex to solve the problem that
+ * dual mac register operation on the same time
+ */
+DEFINE_MUTEX(globalmutex_power);
+DEFINE_MUTEX(globalmutex_for_fwdownload);
+DEFINE_MUTEX(globalmutex_for_power_and_efuse);
+DEFINE_MUTEX(globalmutex_for_mac0_2g_mac1_5g);
+
+#define USB_VENDOR_ID_REALTEK		0x0bda
+
+static const struct usb_device_id rtl8192d_usb_ids[] = {
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8194, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8111, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x0193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x8171, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0xe194, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0xab2c, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0xab2d, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0x4903, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x2019, 0x4904, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x07b8, 0x8193, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x20f4, 0x664b, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x04dd, 0x954f, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x04dd, 0x96a6, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x110a, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x1105, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x050d, 0x120a, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x1668, 0x8102, rtl92du_hal_cfg)},
+	{RTL_USB_DEVICE(0x0930, 0x0a0a, rtl92du_hal_cfg)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, rtl8192d_usb_ids);
+
+static int rtl8192du_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	return rtl_usb_probe(intf, id, &rtl92du_hal_cfg);
+}
+
+static struct usb_driver rtl8192du_driver = {
+	.name = "rtl8192du",
+	.probe = rtl8192du_probe,
+	.disconnect = rtl_usb_disconnect,
+	.id_table = rtl8192d_usb_ids,
+	.disable_hub_initiated_lpm = 1,
+};
+
+module_usb_driver(rtl8192du_driver);
+
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.h
new file mode 100644
index 000000000000..364d9a471dc0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_SW_H__
+#define __RTL92DE_SW_H__
+
+extern struct mutex globalmutex_power;
+extern struct mutex globalmutex_for_fwdownload;
+extern struct mutex globalmutex_for_power_and_efuse;
+extern struct mutex globalmutex_for_mac0_2g_mac1_5g;
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
new file mode 100644
index 000000000000..6f571255c1a5
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
@@ -0,0 +1,1675 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include <linux/types.h>
+
+#include "table.h"
+
+u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH] = {
+	0x800, 0x80040002,
+	0x804, 0x00000003,
+	0x808, 0x0000fc00,
+	0x80c, 0x0000000a,
+	0x810, 0x10001331,
+	0x814, 0x020c3d10,
+	0x818, 0x02200385,
+	0x81c, 0x00000000,
+	0x820, 0x01000100,
+	0x824, 0x00390004,
+	0x828, 0x01000100,
+	0x82c, 0x00390004,
+	0x830, 0x27272727,
+	0x834, 0x27272727,
+	0x838, 0x27272727,
+	0x83c, 0x27272727,
+	0x840, 0x00010000,
+	0x844, 0x00010000,
+	0x848, 0x27272727,
+	0x84c, 0x27272727,
+	0x850, 0x00000000,
+	0x854, 0x00000000,
+	0x858, 0x569a569a,
+	0x85c, 0x0c1b25a4,
+	0x860, 0x66e60250,
+	0x864, 0x061f0150,
+	0x868, 0x27272727,
+	0x86c, 0x272b2b2b,
+	0x870, 0x07000700,
+	0x874, 0x22188000,
+	0x878, 0x08080808,
+	0x87c, 0x0001fff8,
+	0x880, 0xc0083070,
+	0x884, 0x00000cd5,
+	0x888, 0x00000000,
+	0x88c, 0xcc0000c0,
+	0x890, 0x00000800,
+	0x894, 0xfffffffe,
+	0x898, 0x40302010,
+	0x89c, 0x00706050,
+	0x900, 0x00000000,
+	0x904, 0x00000023,
+	0x908, 0x00000000,
+	0x90c, 0x81121313,
+	0xa00, 0x00d047c8,
+	0xa04, 0x80ff000c,
+	0xa08, 0x8c8a8300,
+	0xa0c, 0x2e68120f,
+	0xa10, 0x9500bb78,
+	0xa14, 0x11144028,
+	0xa18, 0x00881117,
+	0xa1c, 0x89140f00,
+	0xa20, 0x1a1b0000,
+	0xa24, 0x090e1317,
+	0xa28, 0x00000204,
+	0xa2c, 0x00d30000,
+	0xa70, 0x101fff00,
+	0xa74, 0x00000007,
+	0xc00, 0x40071d40,
+	0xc04, 0x03a05633,
+	0xc08, 0x001000e4,
+	0xc0c, 0x6c6c6c6c,
+	0xc10, 0x08800000,
+	0xc14, 0x40000100,
+	0xc18, 0x08800000,
+	0xc1c, 0x40000100,
+	0xc20, 0x00000000,
+	0xc24, 0x00000000,
+	0xc28, 0x00000000,
+	0xc2c, 0x00000000,
+	0xc30, 0x69e9ac44,
+	0xc34, 0x469652af,
+	0xc38, 0x49795994,
+	0xc3c, 0x0a979718,
+	0xc40, 0x1f7c403f,
+	0xc44, 0x000100b7,
+	0xc48, 0xec020107,
+	0xc4c, 0x007f037f,
+	0xc50, 0x69543420,
+	0xc54, 0x43bc009e,
+	0xc58, 0x69543420,
+	0xc5c, 0x433c00a8,
+	0xc60, 0x00000000,
+	0xc64, 0x7112848b,
+	0xc68, 0x47c00bff,
+	0xc6c, 0x00000036,
+	0xc70, 0x2c7f000d,
+	0xc74, 0x258610db,
+	0xc78, 0x0000001f,
+	0xc7c, 0x40b95612,
+	0xc80, 0x40000100,
+	0xc84, 0x20f60000,
+	0xc88, 0x40000100,
+	0xc8c, 0xa0e40000,
+	0xc90, 0x00121820,
+	0xc94, 0x00000007,
+	0xc98, 0x00121820,
+	0xc9c, 0x00007f7f,
+	0xca0, 0x00000000,
+	0xca4, 0x00000080,
+	0xca8, 0x00000000,
+	0xcac, 0x00000000,
+	0xcb0, 0x00000000,
+	0xcb4, 0x00000000,
+	0xcb8, 0x00000000,
+	0xcbc, 0x28000000,
+	0xcc0, 0x00000000,
+	0xcc4, 0x00000000,
+	0xcc8, 0x00000000,
+	0xccc, 0x00000000,
+	0xcd0, 0x00000000,
+	0xcd4, 0x00000000,
+	0xcd8, 0x64b11e20,
+	0xcdc, 0xe0767533,
+	0xce0, 0x00222222,
+	0xce4, 0x00000000,
+	0xce8, 0x37644302,
+	0xcec, 0x2f97d40c,
+	0xd00, 0x00080740,
+	0xd04, 0x00020403,
+	0xd08, 0x0000907f,
+	0xd0c, 0x20010201,
+	0xd10, 0xa0633333,
+	0xd14, 0x3333bc43,
+	0xd18, 0x7a8f5b6b,
+	0xd2c, 0xcc979975,
+	0xd30, 0x00000000,
+	0xd34, 0x80608404,
+	0xd38, 0x00000000,
+	0xd3c, 0x00027353,
+	0xd40, 0x00000000,
+	0xd44, 0x00000000,
+	0xd48, 0x00000000,
+	0xd4c, 0x00000000,
+	0xd50, 0x6437140a,
+	0xd54, 0x00000000,
+	0xd58, 0x00000000,
+	0xd5c, 0x30032064,
+	0xd60, 0x4653de68,
+	0xd64, 0x04518a3c,
+	0xd68, 0x00002101,
+	0xd6c, 0x2a201c16,
+	0xd70, 0x1812362e,
+	0xd74, 0x322c2220,
+	0xd78, 0x000e3c24,
+	0xe00, 0x2a2a2a2a,
+	0xe04, 0x2a2a2a2a,
+	0xe08, 0x03902a2a,
+	0xe10, 0x2a2a2a2a,
+	0xe14, 0x2a2a2a2a,
+	0xe18, 0x2a2a2a2a,
+	0xe1c, 0x2a2a2a2a,
+	0xe28, 0x00000000,
+	0xe30, 0x1000dc1f,
+	0xe34, 0x10008c1f,
+	0xe38, 0x02140102,
+	0xe3c, 0x681604c2,
+	0xe40, 0x01007c00,
+	0xe44, 0x01004800,
+	0xe48, 0xfb000000,
+	0xe4c, 0x000028d1,
+	0xe50, 0x1000dc1f,
+	0xe54, 0x10008c1f,
+	0xe58, 0x02140102,
+	0xe5c, 0x28160d05,
+	0xe60, 0x00000010,
+	0xe68, 0x001b25a4,
+	0xe6c, 0x63db25a4,
+	0xe70, 0x63db25a4,
+	0xe74, 0x0c126da4,
+	0xe78, 0x0c126da4,
+	0xe7c, 0x0c126da4,
+	0xe80, 0x0c126da4,
+	0xe84, 0x63db25a4,
+	0xe88, 0x0c126da4,
+	0xe8c, 0x63db25a4,
+	0xed0, 0x63db25a4,
+	0xed4, 0x63db25a4,
+	0xed8, 0x63db25a4,
+	0xedc, 0x001b25a4,
+	0xee0, 0x001b25a4,
+	0xeec, 0x6fdb25a4,
+	0xf14, 0x00000003,
+	0xf1c, 0x00000064,
+	0xf4c, 0x00000004,
+	0xf00, 0x00000300,
+};
+
+u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH] = {
+	0xe00, 0xffffffff, 0x07090c0c,
+	0xe04, 0xffffffff, 0x01020405,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x0b0c0c0e,
+	0xe14, 0xffffffff, 0x01030506,
+	0xe18, 0xffffffff, 0x0b0c0d0e,
+	0xe1c, 0xffffffff, 0x01030509,
+	0x830, 0xffffffff, 0x07090c0c,
+	0x834, 0xffffffff, 0x01020405,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x0b0c0c0e,
+	0x848, 0xffffffff, 0x01030506,
+	0x84c, 0xffffffff, 0x0b0c0d0e,
+	0x868, 0xffffffff, 0x01030509,
+	0xe00, 0xffffffff, 0x00000000,
+	0xe04, 0xffffffff, 0x00000000,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x00000000,
+	0xe14, 0xffffffff, 0x00000000,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x00000000,
+	0x834, 0xffffffff, 0x00000000,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x00000000,
+	0x848, 0xffffffff, 0x00000000,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x06060606,
+	0xe14, 0xffffffff, 0x00020406,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x06060606,
+	0x848, 0xffffffff, 0x00020406,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x00000000,
+	0xe04, 0xffffffff, 0x00000000,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x00000000,
+	0xe14, 0xffffffff, 0x00000000,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x00000000,
+	0x834, 0xffffffff, 0x00000000,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x00000000,
+	0x848, 0xffffffff, 0x00000000,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x00000000,
+	0xe04, 0xffffffff, 0x00000000,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x00000000,
+	0xe14, 0xffffffff, 0x00000000,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x00000000,
+	0x834, 0xffffffff, 0x00000000,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x00000000,
+	0x848, 0xffffffff, 0x00000000,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x00000000,
+	0xe14, 0xffffffff, 0x00000000,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x00000000,
+	0x848, 0xffffffff, 0x00000000,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x00000000,
+	0xe04, 0xffffffff, 0x00000000,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x00000000,
+	0xe14, 0xffffffff, 0x00000000,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x00000000,
+	0x834, 0xffffffff, 0x00000000,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x00000000,
+	0x848, 0xffffffff, 0x00000000,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+	0xe00, 0xffffffff, 0x04040404,
+	0xe04, 0xffffffff, 0x00020204,
+	0xe08, 0x0000ff00, 0x00000000,
+	0x86c, 0xffffff00, 0x00000000,
+	0xe10, 0xffffffff, 0x08080808,
+	0xe14, 0xffffffff, 0x00040408,
+	0xe18, 0xffffffff, 0x00000000,
+	0xe1c, 0xffffffff, 0x00000000,
+	0x830, 0xffffffff, 0x04040404,
+	0x834, 0xffffffff, 0x00020204,
+	0x838, 0xffffff00, 0x00000000,
+	0x86c, 0x000000ff, 0x00000000,
+	0x83c, 0xffffffff, 0x08080808,
+	0x848, 0xffffffff, 0x00040408,
+	0x84c, 0xffffffff, 0x00000000,
+	0x868, 0xffffffff, 0x00000000,
+};
+
+u32 rtl8192du_radioa_2tarray[RADIOA_2T_ARRAYLENGTH] = {
+	0x000, 0x00030000,
+	0x001, 0x00030000,
+	0x002, 0x00000000,
+	0x003, 0x00018c63,
+	0x004, 0x00018c63,
+	0x008, 0x00084000,
+	0x00b, 0x0001c000,
+	0x00e, 0x00018c67,
+	0x00f, 0x00000851,
+	0x014, 0x00021440,
+	0x018, 0x00017524,
+	0x019, 0x00000000,
+	0x01d, 0x000a1290,
+	0x023, 0x00001558,
+	0x01a, 0x00030a99,
+	0x01b, 0x00040b00,
+	0x01c, 0x000fc339,
+	0x03a, 0x000a57eb,
+	0x03b, 0x00020000,
+	0x03c, 0x000ff454,
+	0x020, 0x0000aa52,
+	0x021, 0x00054000,
+	0x040, 0x0000aa52,
+	0x041, 0x00014000,
+	0x025, 0x000803be,
+	0x026, 0x000fc638,
+	0x027, 0x00077c18,
+	0x028, 0x000de471,
+	0x029, 0x000d7110,
+	0x02a, 0x0008cb04,
+	0x02b, 0x0004128b,
+	0x02c, 0x00001840,
+	0x043, 0x0002444f,
+	0x044, 0x0001adb0,
+	0x045, 0x00056467,
+	0x046, 0x0008992c,
+	0x047, 0x0000452c,
+	0x048, 0x000f9c43,
+	0x049, 0x00002e0c,
+	0x04a, 0x000546eb,
+	0x04b, 0x0008966c,
+	0x04c, 0x0000dde9,
+	0x018, 0x00007401,
+	0x000, 0x00070000,
+	0x012, 0x000dc000,
+	0x012, 0x00090000,
+	0x012, 0x00051000,
+	0x012, 0x00012000,
+	0x013, 0x000287b7,
+	0x013, 0x000247ab,
+	0x013, 0x0002079f,
+	0x013, 0x0001c793,
+	0x013, 0x0001839b,
+	0x013, 0x00014392,
+	0x013, 0x0001019a,
+	0x013, 0x0000c191,
+	0x013, 0x00008194,
+	0x013, 0x000040a0,
+	0x013, 0x00000018,
+	0x015, 0x0000f424,
+	0x015, 0x0004f424,
+	0x015, 0x0008f424,
+	0x016, 0x000e1330,
+	0x016, 0x000a1330,
+	0x016, 0x00061330,
+	0x016, 0x00021330,
+	0x018, 0x00017524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x018, 0x00037524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x018, 0x00057568,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x030, 0x0004470f,
+	0x031, 0x00044ff0,
+	0x032, 0x00000070,
+	0x033, 0x000dd480,
+	0x034, 0x000ffac0,
+	0x035, 0x000b80c0,
+	0x036, 0x00077000,
+	0x037, 0x00064ff2,
+	0x038, 0x000e7661,
+	0x039, 0x00000e90,
+	0x000, 0x00030000,
+	0x018, 0x0000f401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088009,
+	0x01f, 0x00080003,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088001,
+	0x01f, 0x00080000,
+	0x0fe, 0x00000000,
+	0x018, 0x00097524,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x02b, 0x00041289,
+	0x0fe, 0x00000000,
+	0x02d, 0x0006aaaa,
+	0x02e, 0x000b4d01,
+	0x02d, 0x00080000,
+	0x02e, 0x00004d02,
+	0x02d, 0x00095555,
+	0x02e, 0x00054d03,
+	0x02d, 0x000aaaaa,
+	0x02e, 0x000b4d04,
+	0x02d, 0x000c0000,
+	0x02e, 0x00004d05,
+	0x02d, 0x000d5555,
+	0x02e, 0x00054d06,
+	0x02d, 0x000eaaaa,
+	0x02e, 0x000b4d07,
+	0x02d, 0x00000000,
+	0x02e, 0x00005108,
+	0x02d, 0x00015555,
+	0x02e, 0x00055109,
+	0x02d, 0x0002aaaa,
+	0x02e, 0x000b510a,
+	0x02d, 0x00040000,
+	0x02e, 0x0000510b,
+	0x02d, 0x00055555,
+	0x02e, 0x0005510c,
+};
+
+u32 rtl8192du_radiob_2tarray[RADIOB_2T_ARRAYLENGTH] = {
+	0x000, 0x00030000,
+	0x001, 0x00030000,
+	0x002, 0x00000000,
+	0x003, 0x00018c63,
+	0x004, 0x00018c63,
+	0x008, 0x00084000,
+	0x00b, 0x0001c000,
+	0x00e, 0x00018c67,
+	0x00f, 0x00000851,
+	0x014, 0x00021440,
+	0x018, 0x00007401,
+	0x019, 0x00000060,
+	0x01d, 0x000a1290,
+	0x023, 0x00001558,
+	0x01a, 0x00030a99,
+	0x01b, 0x00040b00,
+	0x01c, 0x000fc339,
+	0x03a, 0x000a57eb,
+	0x03b, 0x00020000,
+	0x03c, 0x000ff454,
+	0x020, 0x0000aa52,
+	0x021, 0x00054000,
+	0x040, 0x0000aa52,
+	0x041, 0x00014000,
+	0x025, 0x000803be,
+	0x026, 0x000fc638,
+	0x027, 0x00077c18,
+	0x028, 0x000d1c31,
+	0x029, 0x000d7110,
+	0x02a, 0x000aeb04,
+	0x02b, 0x0004128b,
+	0x02c, 0x00001840,
+	0x043, 0x0002444f,
+	0x044, 0x0001adb0,
+	0x045, 0x00056467,
+	0x046, 0x0008992c,
+	0x047, 0x0000452c,
+	0x048, 0x000f9c43,
+	0x049, 0x00002e0c,
+	0x04a, 0x000546eb,
+	0x04b, 0x0008966c,
+	0x04c, 0x0000dde9,
+	0x018, 0x00007401,
+	0x000, 0x00070000,
+	0x012, 0x000dc000,
+	0x012, 0x00090000,
+	0x012, 0x00051000,
+	0x012, 0x00012000,
+	0x013, 0x000287b7,
+	0x013, 0x000247ab,
+	0x013, 0x0002079f,
+	0x013, 0x0001c793,
+	0x013, 0x0001839b,
+	0x013, 0x00014392,
+	0x013, 0x0001019a,
+	0x013, 0x0000c191,
+	0x013, 0x00008194,
+	0x013, 0x000040a0,
+	0x013, 0x00000018,
+	0x015, 0x0000f424,
+	0x015, 0x0004f424,
+	0x015, 0x0008f424,
+	0x016, 0x000e1330,
+	0x016, 0x000a1330,
+	0x016, 0x00061330,
+	0x016, 0x00021330,
+	0x018, 0x00017524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x018, 0x00037524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x018, 0x00057524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bc,
+	0x013, 0x000247b0,
+	0x013, 0x000203b4,
+	0x013, 0x0001c3a8,
+	0x013, 0x000181b4,
+	0x013, 0x000141a8,
+	0x013, 0x000100b4,
+	0x013, 0x0000c0a8,
+	0x013, 0x0000b030,
+	0x013, 0x00004024,
+	0x013, 0x00000018,
+	0x015, 0x0000f4c3,
+	0x015, 0x0004f4c3,
+	0x015, 0x0008f4c3,
+	0x016, 0x000e085f,
+	0x016, 0x000a085f,
+	0x016, 0x0006085f,
+	0x016, 0x0002085f,
+	0x030, 0x0004470f,
+	0x031, 0x00044ff0,
+	0x032, 0x00000070,
+	0x033, 0x000dd480,
+	0x034, 0x000ffac0,
+	0x035, 0x000b80c0,
+	0x036, 0x00077000,
+	0x037, 0x00064ff2,
+	0x038, 0x000e7661,
+	0x039, 0x00000e90,
+	0x000, 0x00030000,
+	0x018, 0x0000f401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088009,
+	0x01f, 0x00080003,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088001,
+	0x01f, 0x00080000,
+	0x0fe, 0x00000000,
+	0x018, 0x00087401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x02b, 0x00041289,
+	0x0fe, 0x00000000,
+	0x02d, 0x00066666,
+	0x02e, 0x00064001,
+	0x02d, 0x00091111,
+	0x02e, 0x00014002,
+	0x02d, 0x000bbbbb,
+	0x02e, 0x000b4003,
+	0x02d, 0x000e6666,
+	0x02e, 0x00064004,
+	0x02d, 0x00088888,
+	0x02e, 0x00084005,
+	0x02d, 0x0009dddd,
+	0x02e, 0x000d4006,
+	0x02d, 0x000b3333,
+	0x02e, 0x00034007,
+	0x02d, 0x00048888,
+	0x02e, 0x00084408,
+	0x02d, 0x000bbbbb,
+	0x02e, 0x000b4409,
+	0x02d, 0x000e6666,
+	0x02e, 0x0006440a,
+	0x02d, 0x00011111,
+	0x02e, 0x0001480b,
+	0x02d, 0x0003bbbb,
+	0x02e, 0x000b480c,
+	0x02d, 0x00066666,
+	0x02e, 0x0006480d,
+	0x02d, 0x000ccccc,
+	0x02e, 0x000c480e,
+};
+
+u32 rtl8192du_radioa_2t_int_paarray[RADIOA_2T_INT_PA_ARRAYLENGTH] = {
+	0x000, 0x00030000,
+	0x001, 0x00030000,
+	0x002, 0x00000000,
+	0x003, 0x00018c63,
+	0x004, 0x00018c63,
+	0x008, 0x00084000,
+	0x00b, 0x0001c000,
+	0x00e, 0x00018c67,
+	0x00f, 0x00000851,
+	0x014, 0x00021440,
+	0x018, 0x00017524,
+	0x019, 0x00000000,
+	0x01d, 0x000a1290,
+	0x023, 0x00001558,
+	0x01a, 0x00030a99,
+	0x01b, 0x00040b00,
+	0x01c, 0x000fc339,
+	0x03a, 0x000a57eb,
+	0x03b, 0x00020000,
+	0x03c, 0x000ff455,
+	0x020, 0x0000aa52,
+	0x021, 0x00054000,
+	0x040, 0x0000aa52,
+	0x041, 0x00014000,
+	0x025, 0x000803be,
+	0x026, 0x000fc638,
+	0x027, 0x00077c18,
+	0x028, 0x000de471,
+	0x029, 0x000d7110,
+	0x02a, 0x0008eb04,
+	0x02b, 0x0004128b,
+	0x02c, 0x00001840,
+	0x043, 0x0002444f,
+	0x044, 0x0001adb0,
+	0x045, 0x00056467,
+	0x046, 0x0008992c,
+	0x047, 0x0000452c,
+	0x048, 0x000c0443,
+	0x049, 0x00000730,
+	0x04a, 0x00050f0f,
+	0x04b, 0x000896ef,
+	0x04c, 0x0000ddee,
+	0x018, 0x00007401,
+	0x000, 0x00070000,
+	0x012, 0x000dc000,
+	0x012, 0x00090000,
+	0x012, 0x00051000,
+	0x012, 0x00012000,
+	0x013, 0x000287b7,
+	0x013, 0x000247ab,
+	0x013, 0x0002079f,
+	0x013, 0x0001c793,
+	0x013, 0x0001839b,
+	0x013, 0x00014392,
+	0x013, 0x0001019a,
+	0x013, 0x0000c191,
+	0x013, 0x00008194,
+	0x013, 0x000040a0,
+	0x013, 0x00000018,
+	0x015, 0x0000f424,
+	0x015, 0x0004f424,
+	0x015, 0x0008f424,
+	0x016, 0x000e1330,
+	0x016, 0x000a1330,
+	0x016, 0x00061330,
+	0x016, 0x00021330,
+	0x018, 0x00017524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x018, 0x00037564,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x018, 0x00057595,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x030, 0x0004470f,
+	0x031, 0x00044ff0,
+	0x032, 0x00000070,
+	0x033, 0x000dd480,
+	0x034, 0x000ffac0,
+	0x035, 0x000b80c0,
+	0x036, 0x00077000,
+	0x037, 0x00064ff2,
+	0x038, 0x000e7661,
+	0x039, 0x00000e90,
+	0x000, 0x00030000,
+	0x018, 0x0000f401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088009,
+	0x01f, 0x00080003,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088001,
+	0x01f, 0x00080000,
+	0x0fe, 0x00000000,
+	0x018, 0x00097524,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x02b, 0x00041289,
+	0x0fe, 0x00000000,
+	0x02d, 0x0006aaaa,
+	0x02e, 0x000b4d01,
+	0x02d, 0x00080000,
+	0x02e, 0x00004d02,
+	0x02d, 0x00095555,
+	0x02e, 0x00054d03,
+	0x02d, 0x000aaaaa,
+	0x02e, 0x000b4d04,
+	0x02d, 0x000c0000,
+	0x02e, 0x00004d05,
+	0x02d, 0x000d5555,
+	0x02e, 0x00054d06,
+	0x02d, 0x000eaaaa,
+	0x02e, 0x000b4d07,
+	0x02d, 0x00000000,
+	0x02e, 0x00005108,
+	0x02d, 0x00015555,
+	0x02e, 0x00055109,
+	0x02d, 0x0002aaaa,
+	0x02e, 0x000b510a,
+	0x02d, 0x00040000,
+	0x02e, 0x0000510b,
+	0x02d, 0x00055555,
+	0x02e, 0x0005510c,
+};
+
+u32 rtl8192du_radiob_2t_int_paarray[RADIOB_2T_INT_PA_ARRAYLENGTH] = {
+	0x000, 0x00030000,
+	0x001, 0x00030000,
+	0x002, 0x00000000,
+	0x003, 0x00018c63,
+	0x004, 0x00018c63,
+	0x008, 0x00084000,
+	0x00b, 0x0001c000,
+	0x00e, 0x00018c67,
+	0x00f, 0x00000851,
+	0x014, 0x00021440,
+	0x018, 0x00007401,
+	0x019, 0x00000060,
+	0x01d, 0x000a1290,
+	0x023, 0x00001558,
+	0x01a, 0x00030a99,
+	0x01b, 0x00040b00,
+	0x01c, 0x000fc339,
+	0x03a, 0x000a57eb,
+	0x03b, 0x00020000,
+	0x03c, 0x000ff455,
+	0x020, 0x0000aa52,
+	0x021, 0x00054000,
+	0x040, 0x0000aa52,
+	0x041, 0x00014000,
+	0x025, 0x000803be,
+	0x026, 0x000fc638,
+	0x027, 0x00077c18,
+	0x028, 0x000d1c31,
+	0x029, 0x000d7110,
+	0x02a, 0x000aeb04,
+	0x02b, 0x0004128b,
+	0x02c, 0x00001840,
+	0x043, 0x0002444f,
+	0x044, 0x0001adb0,
+	0x045, 0x00056467,
+	0x046, 0x0008992c,
+	0x047, 0x0000452c,
+	0x048, 0x000c0443,
+	0x049, 0x00000730,
+	0x04a, 0x00050f0f,
+	0x04b, 0x000896ef,
+	0x04c, 0x0000ddee,
+	0x018, 0x00007401,
+	0x000, 0x00070000,
+	0x012, 0x000dc000,
+	0x012, 0x00090000,
+	0x012, 0x00051000,
+	0x012, 0x00012000,
+	0x013, 0x000287b7,
+	0x013, 0x000247ab,
+	0x013, 0x0002079f,
+	0x013, 0x0001c793,
+	0x013, 0x0001839b,
+	0x013, 0x00014392,
+	0x013, 0x0001019a,
+	0x013, 0x0000c191,
+	0x013, 0x00008194,
+	0x013, 0x000040a0,
+	0x013, 0x00000018,
+	0x015, 0x0000f424,
+	0x015, 0x0004f424,
+	0x015, 0x0008f424,
+	0x016, 0x000e1330,
+	0x016, 0x000a1330,
+	0x016, 0x00061330,
+	0x016, 0x00021330,
+	0x018, 0x00017524,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x018, 0x00037564,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x018, 0x00057595,
+	0x000, 0x00070000,
+	0x012, 0x000cf000,
+	0x012, 0x000bc000,
+	0x012, 0x00078000,
+	0x012, 0x00000000,
+	0x013, 0x000287bf,
+	0x013, 0x000247b3,
+	0x013, 0x000207a7,
+	0x013, 0x0001c79b,
+	0x013, 0x0001839f,
+	0x013, 0x00014393,
+	0x013, 0x00010399,
+	0x013, 0x0000c38d,
+	0x013, 0x00008199,
+	0x013, 0x0000418d,
+	0x013, 0x00000099,
+	0x015, 0x0000f495,
+	0x015, 0x0004f495,
+	0x015, 0x0008f495,
+	0x016, 0x000e1874,
+	0x016, 0x000a1874,
+	0x016, 0x00061874,
+	0x016, 0x00021874,
+	0x030, 0x0004470f,
+	0x031, 0x00044ff0,
+	0x032, 0x00000070,
+	0x033, 0x000dd480,
+	0x034, 0x000ffac0,
+	0x035, 0x000b80c0,
+	0x036, 0x00077000,
+	0x037, 0x00064ff2,
+	0x038, 0x000e7661,
+	0x039, 0x00000e90,
+	0x000, 0x00030000,
+	0x018, 0x0000f401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088009,
+	0x01f, 0x00080003,
+	0x0fe, 0x00000000,
+	0x01e, 0x00088001,
+	0x01f, 0x00080000,
+	0x0fe, 0x00000000,
+	0x018, 0x00087401,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x0fe, 0x00000000,
+	0x02b, 0x00041289,
+	0x0fe, 0x00000000,
+	0x02d, 0x00066666,
+	0x02e, 0x00064001,
+	0x02d, 0x00091111,
+	0x02e, 0x00014002,
+	0x02d, 0x000bbbbb,
+	0x02e, 0x000b4003,
+	0x02d, 0x000e6666,
+	0x02e, 0x00064004,
+	0x02d, 0x00088888,
+	0x02e, 0x00084005,
+	0x02d, 0x0009dddd,
+	0x02e, 0x000d4006,
+	0x02d, 0x000b3333,
+	0x02e, 0x00034007,
+	0x02d, 0x00048888,
+	0x02e, 0x00084408,
+	0x02d, 0x000bbbbb,
+	0x02e, 0x000b4409,
+	0x02d, 0x000e6666,
+	0x02e, 0x0006440a,
+	0x02d, 0x00011111,
+	0x02e, 0x0001480b,
+	0x02d, 0x0003bbbb,
+	0x02e, 0x000b480c,
+	0x02d, 0x00066666,
+	0x02e, 0x0006480d,
+	0x02d, 0x000ccccc,
+	0x02e, 0x000c480e,
+};
+
+u32 rtl8192du_mac_2tarray[MAC_2T_ARRAYLENGTH] = {
+	0x420, 0x00000080,
+	0x423, 0x00000000,
+	0x430, 0x00000000,
+	0x431, 0x00000000,
+	0x432, 0x00000000,
+	0x433, 0x00000001,
+	0x434, 0x00000004,
+	0x435, 0x00000005,
+	0x436, 0x00000006,
+	0x437, 0x00000007,
+	0x438, 0x00000000,
+	0x439, 0x00000000,
+	0x43a, 0x00000000,
+	0x43b, 0x00000001,
+	0x43c, 0x00000004,
+	0x43d, 0x00000005,
+	0x43e, 0x00000006,
+	0x43f, 0x00000007,
+	0x440, 0x00000050,
+	0x441, 0x00000001,
+	0x442, 0x00000000,
+	0x444, 0x00000015,
+	0x445, 0x000000f0,
+	0x446, 0x0000000f,
+	0x447, 0x00000000,
+	0x462, 0x00000008,
+	0x463, 0x00000003,
+	0x4c8, 0x000000ff,
+	0x4c9, 0x00000008,
+	0x4cc, 0x000000ff,
+	0x4cd, 0x000000ff,
+	0x4ce, 0x00000001,
+	0x500, 0x00000026,
+	0x501, 0x000000a2,
+	0x502, 0x0000002f,
+	0x503, 0x00000000,
+	0x504, 0x00000028,
+	0x505, 0x000000a3,
+	0x506, 0x0000005e,
+	0x507, 0x00000000,
+	0x508, 0x0000002b,
+	0x509, 0x000000a4,
+	0x50a, 0x0000005e,
+	0x50b, 0x00000000,
+	0x50c, 0x0000004f,
+	0x50d, 0x000000a4,
+	0x50e, 0x00000000,
+	0x50f, 0x00000000,
+	0x512, 0x0000001c,
+	0x514, 0x0000000a,
+	0x515, 0x00000010,
+	0x516, 0x0000000a,
+	0x517, 0x00000010,
+	0x51a, 0x00000016,
+	0x524, 0x0000000f,
+	0x525, 0x0000004f,
+	0x546, 0x00000040,
+	0x547, 0x00000000,
+	0x550, 0x00000010,
+	0x551, 0x00000010,
+	0x559, 0x00000002,
+	0x55a, 0x00000002,
+	0x55d, 0x000000ff,
+	0x605, 0x00000080,
+	0x608, 0x0000000e,
+	0x609, 0x0000002a,
+	0x652, 0x00000020,
+	0x63c, 0x0000000a,
+	0x63d, 0x0000000a,
+	0x63e, 0x0000000e,
+	0x63f, 0x0000000e,
+	0x66e, 0x00000005,
+	0x700, 0x00000021,
+	0x701, 0x00000043,
+	0x702, 0x00000065,
+	0x703, 0x00000087,
+	0x708, 0x00000021,
+	0x709, 0x00000043,
+	0x70a, 0x00000065,
+	0x70b, 0x00000087,
+	0x024, 0x0000000d,
+	0x025, 0x00000080,
+	0x026, 0x00000011,
+	0x027, 0x00000000,
+	0x028, 0x00000083,
+	0x029, 0x000000db,
+	0x02a, 0x000000ff,
+	0x02b, 0x00000000,
+	0x014, 0x00000055,
+	0x015, 0x000000a9,
+	0x016, 0x0000008b,
+	0x017, 0x00000008,
+	0x010, 0x00000003,
+	0x011, 0x0000002b,
+	0x012, 0x00000002,
+	0x013, 0x00000049,
+};
+
+u32 rtl8192du_agctab_array[AGCTAB_ARRAYLENGTH] = {
+	0xc78, 0x7b000001,
+	0xc78, 0x7b010001,
+	0xc78, 0x7b020001,
+	0xc78, 0x7b030001,
+	0xc78, 0x7b040001,
+	0xc78, 0x7b050001,
+	0xc78, 0x7b060001,
+	0xc78, 0x7a070001,
+	0xc78, 0x79080001,
+	0xc78, 0x78090001,
+	0xc78, 0x770a0001,
+	0xc78, 0x760b0001,
+	0xc78, 0x750c0001,
+	0xc78, 0x740d0001,
+	0xc78, 0x730e0001,
+	0xc78, 0x720f0001,
+	0xc78, 0x71100001,
+	0xc78, 0x70110001,
+	0xc78, 0x6f120001,
+	0xc78, 0x6e130001,
+	0xc78, 0x6d140001,
+	0xc78, 0x6c150001,
+	0xc78, 0x6b160001,
+	0xc78, 0x6a170001,
+	0xc78, 0x69180001,
+	0xc78, 0x68190001,
+	0xc78, 0x671a0001,
+	0xc78, 0x661b0001,
+	0xc78, 0x651c0001,
+	0xc78, 0x641d0001,
+	0xc78, 0x631e0001,
+	0xc78, 0x621f0001,
+	0xc78, 0x61200001,
+	0xc78, 0x60210001,
+	0xc78, 0x49220001,
+	0xc78, 0x48230001,
+	0xc78, 0x47240001,
+	0xc78, 0x46250001,
+	0xc78, 0x45260001,
+	0xc78, 0x44270001,
+	0xc78, 0x43280001,
+	0xc78, 0x42290001,
+	0xc78, 0x412a0001,
+	0xc78, 0x402b0001,
+	0xc78, 0x262c0001,
+	0xc78, 0x252d0001,
+	0xc78, 0x242e0001,
+	0xc78, 0x232f0001,
+	0xc78, 0x22300001,
+	0xc78, 0x21310001,
+	0xc78, 0x20320001,
+	0xc78, 0x06330001,
+	0xc78, 0x05340001,
+	0xc78, 0x04350001,
+	0xc78, 0x03360001,
+	0xc78, 0x02370001,
+	0xc78, 0x01380001,
+	0xc78, 0x00390001,
+	0xc78, 0x003a0001,
+	0xc78, 0x003b0001,
+	0xc78, 0x003c0001,
+	0xc78, 0x003d0001,
+	0xc78, 0x003e0001,
+	0xc78, 0x003f0001,
+	0xc78, 0x7b400001,
+	0xc78, 0x7b410001,
+	0xc78, 0x7a420001,
+	0xc78, 0x79430001,
+	0xc78, 0x78440001,
+	0xc78, 0x77450001,
+	0xc78, 0x76460001,
+	0xc78, 0x75470001,
+	0xc78, 0x74480001,
+	0xc78, 0x73490001,
+	0xc78, 0x724a0001,
+	0xc78, 0x714b0001,
+	0xc78, 0x704c0001,
+	0xc78, 0x6f4d0001,
+	0xc78, 0x6e4e0001,
+	0xc78, 0x6d4f0001,
+	0xc78, 0x6c500001,
+	0xc78, 0x6b510001,
+	0xc78, 0x6a520001,
+	0xc78, 0x69530001,
+	0xc78, 0x68540001,
+	0xc78, 0x67550001,
+	0xc78, 0x66560001,
+	0xc78, 0x65570001,
+	0xc78, 0x64580001,
+	0xc78, 0x63590001,
+	0xc78, 0x625a0001,
+	0xc78, 0x615b0001,
+	0xc78, 0x605c0001,
+	0xc78, 0x485d0001,
+	0xc78, 0x475e0001,
+	0xc78, 0x465f0001,
+	0xc78, 0x45600001,
+	0xc78, 0x44610001,
+	0xc78, 0x43620001,
+	0xc78, 0x42630001,
+	0xc78, 0x41640001,
+	0xc78, 0x40650001,
+	0xc78, 0x27660001,
+	0xc78, 0x26670001,
+	0xc78, 0x25680001,
+	0xc78, 0x24690001,
+	0xc78, 0x236a0001,
+	0xc78, 0x226b0001,
+	0xc78, 0x216c0001,
+	0xc78, 0x206d0001,
+	0xc78, 0x206e0001,
+	0xc78, 0x206f0001,
+	0xc78, 0x20700001,
+	0xc78, 0x20710001,
+	0xc78, 0x20720001,
+	0xc78, 0x20730001,
+	0xc78, 0x20740001,
+	0xc78, 0x20750001,
+	0xc78, 0x20760001,
+	0xc78, 0x20770001,
+	0xc78, 0x20780001,
+	0xc78, 0x20790001,
+	0xc78, 0x207a0001,
+	0xc78, 0x207b0001,
+	0xc78, 0x207c0001,
+	0xc78, 0x207d0001,
+	0xc78, 0x207e0001,
+	0xc78, 0x207f0001,
+	0xc78, 0x38000002,
+	0xc78, 0x38010002,
+	0xc78, 0x38020002,
+	0xc78, 0x38030002,
+	0xc78, 0x38040002,
+	0xc78, 0x38050002,
+	0xc78, 0x38060002,
+	0xc78, 0x38070002,
+	0xc78, 0x38080002,
+	0xc78, 0x3c090002,
+	0xc78, 0x3e0a0002,
+	0xc78, 0x400b0002,
+	0xc78, 0x440c0002,
+	0xc78, 0x480d0002,
+	0xc78, 0x4c0e0002,
+	0xc78, 0x500f0002,
+	0xc78, 0x52100002,
+	0xc78, 0x56110002,
+	0xc78, 0x5a120002,
+	0xc78, 0x5e130002,
+	0xc78, 0x60140002,
+	0xc78, 0x60150002,
+	0xc78, 0x60160002,
+	0xc78, 0x62170002,
+	0xc78, 0x62180002,
+	0xc78, 0x62190002,
+	0xc78, 0x621a0002,
+	0xc78, 0x621b0002,
+	0xc78, 0x621c0002,
+	0xc78, 0x621d0002,
+	0xc78, 0x621e0002,
+	0xc78, 0x621f0002,
+	0xc78, 0x32000044,
+	0xc78, 0x32010044,
+	0xc78, 0x32020044,
+	0xc78, 0x32030044,
+	0xc78, 0x32040044,
+	0xc78, 0x32050044,
+	0xc78, 0x32060044,
+	0xc78, 0x34070044,
+	0xc78, 0x35080044,
+	0xc78, 0x36090044,
+	0xc78, 0x370a0044,
+	0xc78, 0x380b0044,
+	0xc78, 0x390c0044,
+	0xc78, 0x3a0d0044,
+	0xc78, 0x3e0e0044,
+	0xc78, 0x420f0044,
+	0xc78, 0x44100044,
+	0xc78, 0x46110044,
+	0xc78, 0x4a120044,
+	0xc78, 0x4e130044,
+	0xc78, 0x50140044,
+	0xc78, 0x55150044,
+	0xc78, 0x5a160044,
+	0xc78, 0x5e170044,
+	0xc78, 0x64180044,
+	0xc78, 0x6e190044,
+	0xc78, 0x6e1a0044,
+	0xc78, 0x6e1b0044,
+	0xc78, 0x6e1c0044,
+	0xc78, 0x6e1d0044,
+	0xc78, 0x6e1e0044,
+	0xc78, 0x6e1f0044,
+	0xc78, 0x6e1f0000,
+};
+
+u32 rtl8192du_agctab_5garray[AGCTAB_5G_ARRAYLENGTH] = {
+	0xc78, 0x7b000001,
+	0xc78, 0x7b010001,
+	0xc78, 0x7a020001,
+	0xc78, 0x79030001,
+	0xc78, 0x78040001,
+	0xc78, 0x77050001,
+	0xc78, 0x76060001,
+	0xc78, 0x75070001,
+	0xc78, 0x74080001,
+	0xc78, 0x73090001,
+	0xc78, 0x720a0001,
+	0xc78, 0x710b0001,
+	0xc78, 0x700c0001,
+	0xc78, 0x6f0d0001,
+	0xc78, 0x6e0e0001,
+	0xc78, 0x6d0f0001,
+	0xc78, 0x6c100001,
+	0xc78, 0x6b110001,
+	0xc78, 0x6a120001,
+	0xc78, 0x69130001,
+	0xc78, 0x68140001,
+	0xc78, 0x67150001,
+	0xc78, 0x66160001,
+	0xc78, 0x65170001,
+	0xc78, 0x64180001,
+	0xc78, 0x63190001,
+	0xc78, 0x621a0001,
+	0xc78, 0x611b0001,
+	0xc78, 0x601c0001,
+	0xc78, 0x481d0001,
+	0xc78, 0x471e0001,
+	0xc78, 0x461f0001,
+	0xc78, 0x45200001,
+	0xc78, 0x44210001,
+	0xc78, 0x43220001,
+	0xc78, 0x42230001,
+	0xc78, 0x41240001,
+	0xc78, 0x40250001,
+	0xc78, 0x27260001,
+	0xc78, 0x26270001,
+	0xc78, 0x25280001,
+	0xc78, 0x24290001,
+	0xc78, 0x232a0001,
+	0xc78, 0x222b0001,
+	0xc78, 0x212c0001,
+	0xc78, 0x202d0001,
+	0xc78, 0x202e0001,
+	0xc78, 0x202f0001,
+	0xc78, 0x20300001,
+	0xc78, 0x20310001,
+	0xc78, 0x20320001,
+	0xc78, 0x20330001,
+	0xc78, 0x20340001,
+	0xc78, 0x20350001,
+	0xc78, 0x20360001,
+	0xc78, 0x20370001,
+	0xc78, 0x20380001,
+	0xc78, 0x20390001,
+	0xc78, 0x203a0001,
+	0xc78, 0x203b0001,
+	0xc78, 0x203c0001,
+	0xc78, 0x203d0001,
+	0xc78, 0x203e0001,
+	0xc78, 0x203f0001,
+	0xc78, 0x32000044,
+	0xc78, 0x32010044,
+	0xc78, 0x32020044,
+	0xc78, 0x32030044,
+	0xc78, 0x32040044,
+	0xc78, 0x32050044,
+	0xc78, 0x32060044,
+	0xc78, 0x34070044,
+	0xc78, 0x35080044,
+	0xc78, 0x36090044,
+	0xc78, 0x370a0044,
+	0xc78, 0x380b0044,
+	0xc78, 0x390c0044,
+	0xc78, 0x3a0d0044,
+	0xc78, 0x3e0e0044,
+	0xc78, 0x420f0044,
+	0xc78, 0x44100044,
+	0xc78, 0x46110044,
+	0xc78, 0x4a120044,
+	0xc78, 0x4e130044,
+	0xc78, 0x50140044,
+	0xc78, 0x55150044,
+	0xc78, 0x5a160044,
+	0xc78, 0x5e170044,
+	0xc78, 0x64180044,
+	0xc78, 0x6e190044,
+	0xc78, 0x6e1a0044,
+	0xc78, 0x6e1b0044,
+	0xc78, 0x6e1c0044,
+	0xc78, 0x6e1d0044,
+	0xc78, 0x6e1e0044,
+	0xc78, 0x6e1f0044,
+	0xc78, 0x6e1f0000,
+};
+
+u32 rtl8192du_agctab_2garray[AGCTAB_2G_ARRAYLENGTH] = {
+	0xc78, 0x7b000001,
+	0xc78, 0x7b010001,
+	0xc78, 0x7b020001,
+	0xc78, 0x7b030001,
+	0xc78, 0x7b040001,
+	0xc78, 0x7b050001,
+	0xc78, 0x7b060001,
+	0xc78, 0x7a070001,
+	0xc78, 0x79080001,
+	0xc78, 0x78090001,
+	0xc78, 0x770a0001,
+	0xc78, 0x760b0001,
+	0xc78, 0x750c0001,
+	0xc78, 0x740d0001,
+	0xc78, 0x730e0001,
+	0xc78, 0x720f0001,
+	0xc78, 0x71100001,
+	0xc78, 0x70110001,
+	0xc78, 0x6f120001,
+	0xc78, 0x6e130001,
+	0xc78, 0x6d140001,
+	0xc78, 0x6c150001,
+	0xc78, 0x6b160001,
+	0xc78, 0x6a170001,
+	0xc78, 0x69180001,
+	0xc78, 0x68190001,
+	0xc78, 0x671a0001,
+	0xc78, 0x661b0001,
+	0xc78, 0x651c0001,
+	0xc78, 0x641d0001,
+	0xc78, 0x631e0001,
+	0xc78, 0x621f0001,
+	0xc78, 0x61200001,
+	0xc78, 0x60210001,
+	0xc78, 0x49220001,
+	0xc78, 0x48230001,
+	0xc78, 0x47240001,
+	0xc78, 0x46250001,
+	0xc78, 0x45260001,
+	0xc78, 0x44270001,
+	0xc78, 0x43280001,
+	0xc78, 0x42290001,
+	0xc78, 0x412a0001,
+	0xc78, 0x402b0001,
+	0xc78, 0x262c0001,
+	0xc78, 0x252d0001,
+	0xc78, 0x242e0001,
+	0xc78, 0x232f0001,
+	0xc78, 0x22300001,
+	0xc78, 0x21310001,
+	0xc78, 0x20320001,
+	0xc78, 0x06330001,
+	0xc78, 0x05340001,
+	0xc78, 0x04350001,
+	0xc78, 0x03360001,
+	0xc78, 0x02370001,
+	0xc78, 0x01380001,
+	0xc78, 0x00390001,
+	0xc78, 0x003a0001,
+	0xc78, 0x003b0001,
+	0xc78, 0x003c0001,
+	0xc78, 0x003d0001,
+	0xc78, 0x003e0001,
+	0xc78, 0x003f0001,
+	0xc78, 0x38000002,
+	0xc78, 0x38010002,
+	0xc78, 0x38020002,
+	0xc78, 0x38030002,
+	0xc78, 0x38040002,
+	0xc78, 0x38050002,
+	0xc78, 0x38060002,
+	0xc78, 0x38070002,
+	0xc78, 0x38080002,
+	0xc78, 0x3c090002,
+	0xc78, 0x3e0a0002,
+	0xc78, 0x400b0002,
+	0xc78, 0x440c0002,
+	0xc78, 0x480d0002,
+	0xc78, 0x4c0e0002,
+	0xc78, 0x500f0002,
+	0xc78, 0x52100002,
+	0xc78, 0x56110002,
+	0xc78, 0x5a120002,
+	0xc78, 0x5e130002,
+	0xc78, 0x60140002,
+	0xc78, 0x60150002,
+	0xc78, 0x60160002,
+	0xc78, 0x62170002,
+	0xc78, 0x62180002,
+	0xc78, 0x62190002,
+	0xc78, 0x621a0002,
+	0xc78, 0x621b0002,
+	0xc78, 0x621c0002,
+	0xc78, 0x621d0002,
+	0xc78, 0x621e0002,
+	0xc78, 0x621f0002,
+	0xc78, 0x6e1f0000,
+};
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
new file mode 100644
index 000000000000..71d943158c5f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_TABLE__H_
+#define __RTL92DE_TABLE__H_
+
+/*Created on  2011/ 1/14,  1:35*/
+
+#define PHY_REG_2T_ARRAYLENGTH 372
+extern u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH];
+#define PHY_REG_ARRAY_PG_LENGTH 624
+extern u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH];
+#define RADIOA_2T_ARRAYLENGTH 378
+extern u32 rtl8192du_radioa_2tarray[RADIOA_2T_ARRAYLENGTH];
+#define RADIOB_2T_ARRAYLENGTH 384
+extern u32 rtl8192du_radiob_2tarray[RADIOB_2T_ARRAYLENGTH];
+#define RADIOA_2T_INT_PA_ARRAYLENGTH 378
+extern u32 rtl8192du_radioa_2t_int_paarray[RADIOA_2T_INT_PA_ARRAYLENGTH];
+#define RADIOB_2T_INT_PA_ARRAYLENGTH 384
+extern u32 rtl8192du_radiob_2t_int_paarray[RADIOB_2T_INT_PA_ARRAYLENGTH];
+#define MAC_2T_ARRAYLENGTH 192
+extern u32 rtl8192du_mac_2tarray[MAC_2T_ARRAYLENGTH];
+#define AGCTAB_ARRAYLENGTH 386
+extern u32 rtl8192du_agctab_array[AGCTAB_ARRAYLENGTH];
+#define AGCTAB_5G_ARRAYLENGTH 194
+extern u32 rtl8192du_agctab_5garray[AGCTAB_5G_ARRAYLENGTH];
+#define AGCTAB_2G_ARRAYLENGTH 194
+extern u32 rtl8192du_agctab_2garray[AGCTAB_2G_ARRAYLENGTH];
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
new file mode 100644
index 000000000000..830e6e1f2718
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../base.h"
+#include "../stats.h"
+#include "../usb.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/trx_common.h"
+#include "phy.h"
+#include "trx.h"
+#include "led.h"
+
+void rtl92du_tx_cleanup(struct ieee80211_hw *hw, struct sk_buff *skb)
+{
+}
+
+int rtl92du_tx_post_hdl(struct ieee80211_hw *hw, struct urb *urb,
+			struct sk_buff *skb)
+{
+	return 0;
+}
+
+struct sk_buff *rtl92du_tx_aggregate_hdl(struct ieee80211_hw *hw,
+					 struct sk_buff_head *list)
+{
+	return skb_dequeue(list);
+}
+
+static enum rtl_desc_qsel _rtl92du_hwq_to_descq(u16 queue_index)
+{
+	switch (queue_index) {
+	case RTL_TXQ_BCN:
+		return QSLT_BEACON;
+	case RTL_TXQ_MGT:
+		return QSLT_MGNT;
+	case RTL_TXQ_VO:
+		return QSLT_VO;
+	case RTL_TXQ_VI:
+		return QSLT_VI;
+	case RTL_TXQ_BK:
+		return QSLT_BK;
+	default:
+	case RTL_TXQ_BE:
+		return QSLT_BE;
+	}
+}
+
+/* For HW recovery information */
+static void _rtl92du_tx_desc_checksum(__le32 *txdesc)
+{
+	__le16 *ptr = (__le16 *)txdesc;
+	u16 checksum = 0;
+	u32 index;
+
+	/* Clear first */
+	set_tx_desc_tx_desc_checksum(txdesc, 0);
+	for (index = 0; index < 16; index++)
+		checksum = checksum ^ le16_to_cpu(*(ptr + index));
+	set_tx_desc_tx_desc_checksum(txdesc, checksum);
+}
+
+void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
+			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
+			  struct ieee80211_sta *sta,
+			  struct sk_buff *skb,
+			  u8 queue_index,
+			  struct rtl_tcb_desc *tcb_desc)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	struct rtl_sta_info *sta_entry;
+	__le16 fc = hdr->frame_control;
+	u8 agg_state = RTL_AGG_STOP;
+	u16 pktlen = skb->len;
+	u8 ampdu_density = 0;
+	u16 seq_number;
+	__le32 *txdesc;
+	u8 rate_flag;
+	u8 tid;
+
+	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
+
+	txdesc = (__le32 *)skb_push(skb, RTL_TX_HEADER_SIZE);
+	memset(txdesc, 0, RTL_TX_HEADER_SIZE);
+
+	set_tx_desc_pkt_size(txdesc, pktlen);
+	set_tx_desc_linip(txdesc, 0);
+	set_tx_desc_pkt_offset(txdesc, RTL_DUMMY_OFFSET);
+	set_tx_desc_offset(txdesc, RTL_TX_HEADER_SIZE);
+	/* 5G have no CCK rate */
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		if (tcb_desc->hw_rate < DESC_RATE6M)
+			tcb_desc->hw_rate = DESC_RATE6M;
+
+	set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
+	if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
+		set_tx_desc_data_shortgi(txdesc, 1);
+
+	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
+	    tcb_desc->hw_rate == DESC_RATEMCS7)
+		set_tx_desc_data_shortgi(txdesc, 1);
+
+	if (sta) {
+		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+		tid = ieee80211_get_tid(hdr);
+		agg_state = sta_entry->tids[tid].agg.agg_state;
+		ampdu_density = sta->deflink.ht_cap.ampdu_density;
+	}
+
+	if (agg_state == RTL_AGG_OPERATIONAL &&
+	    info->flags & IEEE80211_TX_CTL_AMPDU) {
+		set_tx_desc_agg_enable(txdesc, 1);
+		set_tx_desc_max_agg_num(txdesc, 0x14);
+		set_tx_desc_ampdu_density(txdesc, ampdu_density);
+		tcb_desc->rts_enable = 1;
+		tcb_desc->rts_rate = DESC_RATE24M;
+	} else {
+		set_tx_desc_agg_break(txdesc, 1);
+	}
+	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
+	set_tx_desc_seq(txdesc, seq_number);
+	set_tx_desc_rts_enable(txdesc,
+			       ((tcb_desc->rts_enable &&
+				!tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_hw_rts_enable(txdesc,
+				  ((tcb_desc->rts_enable ||
+				   tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_cts2self(txdesc, ((tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_rts_stbc(txdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
+	/* 5G have no CCK rate */
+	if (rtlhal->current_bandtype == BAND_ON_5G)
+		if (tcb_desc->rts_rate < DESC_RATE6M)
+			tcb_desc->rts_rate = DESC_RATE6M;
+	set_tx_desc_rts_rate(txdesc, tcb_desc->rts_rate);
+	set_tx_desc_rts_bw(txdesc, 0);
+	set_tx_desc_rts_sc(txdesc, tcb_desc->rts_sc);
+	set_tx_desc_rts_short(txdesc,
+			      ((tcb_desc->rts_rate <= DESC_RATE54M) ?
+			       (tcb_desc->rts_use_shortpreamble ? 1 : 0)
+			       : (tcb_desc->rts_use_shortgi ? 1 : 0)));
+
+	rate_flag = info->control.rates[0].flags;
+	if (mac->bw_40) {
+		if (rate_flag & IEEE80211_TX_RC_DUP_DATA) {
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_tx_sub_carrier(txdesc, 3);
+		} else if (rate_flag & IEEE80211_TX_RC_40_MHZ_WIDTH) {
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_tx_sub_carrier(txdesc, mac->cur_40_prime_sc);
+		} else {
+			set_tx_desc_data_bw(txdesc, 0);
+			set_tx_desc_tx_sub_carrier(txdesc, 0);
+		}
+	} else {
+		set_tx_desc_data_bw(txdesc, 0);
+		set_tx_desc_tx_sub_carrier(txdesc, 0);
+	}
+
+	if (info->control.hw_key) {
+		struct ieee80211_key_conf *keyconf = info->control.hw_key;
+
+		switch (keyconf->cipher) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+		case WLAN_CIPHER_SUITE_TKIP:
+			set_tx_desc_sec_type(txdesc, 0x1);
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			set_tx_desc_sec_type(txdesc, 0x3);
+			break;
+		default:
+			set_tx_desc_sec_type(txdesc, 0x0);
+			break;
+		}
+	}
+	set_tx_desc_pkt_id(txdesc, 0);
+	set_tx_desc_queue_sel(txdesc, _rtl92du_hwq_to_descq(queue_index));
+	set_tx_desc_data_rate_fb_limit(txdesc, 0x1F);
+	set_tx_desc_rts_rate_fb_limit(txdesc, 0xF);
+	set_tx_desc_disable_fb(txdesc, 0);
+	set_tx_desc_use_rate(txdesc, tcb_desc->use_driver_rate ? 1 : 0);
+	if (ieee80211_is_data_qos(fc)) {
+		if (mac->rdg_en) {
+			rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+				"Enable RDG function\n");
+			set_tx_desc_rdg_enable(txdesc, 1);
+			set_tx_desc_htc(txdesc, 1);
+		}
+		set_tx_desc_qos(txdesc, 1);
+	}
+	if (rtlpriv->dm.useramask) {
+		set_tx_desc_rate_id(txdesc, tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->mac_id);
+	} else {
+		set_tx_desc_rate_id(txdesc, 0xC + tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->ratr_index);
+	}
+	if (!ieee80211_is_data_qos(fc) && ppsc->leisure_ps &&
+	    ppsc->fwctrl_lps) {
+		set_tx_desc_hwseq_en(txdesc, 1);
+		set_tx_desc_pkt_id(txdesc, 8);
+	}
+	if (ieee80211_has_morefrags(fc))
+		set_tx_desc_more_frag(txdesc, 1);
+	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
+	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
+		set_tx_desc_bmc(txdesc, 1);
+	set_tx_desc_own(txdesc, 1);
+	set_tx_desc_last_seg(txdesc, 1);
+	set_tx_desc_first_seg(txdesc, 1);
+	_rtl92du_tx_desc_checksum(txdesc);
+
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
+}
+
+static void _rtl92du_config_out_ep(struct ieee80211_hw *hw, u8 num_out_pipe)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	u16 ep_cfg;
+
+	rtlusb->out_queue_sel = 0;
+	rtlusb->out_ep_nums = 0;
+
+	if (rtlhal->interfaceindex == 0)
+		ep_cfg = rtl_read_word(rtlpriv, REG_USB_Queue_Select_MAC0);
+	else
+		ep_cfg = rtl_read_word(rtlpriv, REG_USB_Queue_Select_MAC1);
+
+	if (ep_cfg & 0x00f) {
+		rtlusb->out_queue_sel |= TX_SELE_HQ;
+		rtlusb->out_ep_nums++;
+	}
+	if (ep_cfg & 0x0f0) {
+		rtlusb->out_queue_sel |= TX_SELE_NQ;
+		rtlusb->out_ep_nums++;
+	}
+	if (ep_cfg & 0xf00) {
+		rtlusb->out_queue_sel |= TX_SELE_LQ;
+		rtlusb->out_ep_nums++;
+	}
+
+	switch (num_out_pipe) {
+	case 3:
+		rtlusb->out_queue_sel = TX_SELE_HQ | TX_SELE_NQ | TX_SELE_LQ;
+		rtlusb->out_ep_nums = 3;
+		break;
+	case 2:
+		rtlusb->out_queue_sel = TX_SELE_HQ | TX_SELE_NQ;
+		rtlusb->out_ep_nums = 2;
+		break;
+	case 1:
+		rtlusb->out_queue_sel = TX_SELE_HQ;
+		rtlusb->out_ep_nums = 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static void _rtl92du_one_out_ep_mapping(struct rtl_usb *rtlusb,
+					struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static void _rtl92du_two_out_ep_mapping(struct rtl_usb *rtlusb,
+					struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static void _rtl92du_three_out_ep_mapping(struct rtl_usb *rtlusb,
+					  struct rtl_ep_map *ep_map)
+{
+	ep_map->ep_mapping[RTL_TXQ_BE] = rtlusb->out_eps[2];
+	ep_map->ep_mapping[RTL_TXQ_BK] = rtlusb->out_eps[2];
+	ep_map->ep_mapping[RTL_TXQ_VI] = rtlusb->out_eps[1];
+	ep_map->ep_mapping[RTL_TXQ_VO] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_MGT] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_BCN] = rtlusb->out_eps[0];
+	ep_map->ep_mapping[RTL_TXQ_HI] = rtlusb->out_eps[0];
+}
+
+static int _rtl92du_out_ep_mapping(struct ieee80211_hw *hw)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	struct rtl_ep_map *ep_map = &rtlusb->ep_map;
+	int err = 0;
+
+	switch (rtlusb->out_ep_nums) {
+	case 1:
+		_rtl92du_one_out_ep_mapping(rtlusb, ep_map);
+		break;
+	case 2:
+		_rtl92du_two_out_ep_mapping(rtlusb, ep_map);
+		break;
+	case 3:
+		_rtl92du_three_out_ep_mapping(rtlusb, ep_map);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+int rtl92du_endpoint_mapping(struct ieee80211_hw *hw)
+{
+	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	int error = -EINVAL;
+
+	_rtl92du_config_out_ep(hw, rtlusb->out_ep_nums);
+
+	/* Normal chip with one IN and one OUT doesn't have interrupt IN EP. */
+	if (rtlusb->out_ep_nums == 1 && rtlusb->in_ep_nums != 1)
+		goto err_out;
+
+	error = _rtl92du_out_ep_mapping(hw);
+	if (error)
+		goto err_out;
+err_out:
+	return error;
+}
+
+u16 rtl92du_mq_to_hwq(__le16 fc, u16 mac80211_queue_index)
+{
+	u16 hw_queue_index;
+
+	if (unlikely(ieee80211_is_beacon(fc))) {
+		hw_queue_index = RTL_TXQ_BCN;
+		goto out;
+	}
+	if (ieee80211_is_mgmt(fc)) {
+		hw_queue_index = RTL_TXQ_MGT;
+		goto out;
+	}
+	switch (mac80211_queue_index) {
+	case 0:
+		hw_queue_index = RTL_TXQ_VO;
+		break;
+	case 1:
+		hw_queue_index = RTL_TXQ_VI;
+		break;
+	case 2:
+		hw_queue_index = RTL_TXQ_BE;
+		break;
+	case 3:
+		hw_queue_index = RTL_TXQ_BK;
+		break;
+	default:
+		hw_queue_index = RTL_TXQ_BE;
+		WARN_ONCE(true, "rtl8192du: QSLT_BE queue, skb_queue:%d\n",
+			  mac80211_queue_index);
+		break;
+	}
+out:
+	return hw_queue_index;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
new file mode 100644
index 000000000000..ace83f1b420d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DE_TRX_H__
+#define __RTL92DE_TRX_H__
+
+#define TX_SELE_HQ				BIT(0)	/* High Queue */
+#define TX_SELE_LQ				BIT(1)	/* Low Queue */
+#define TX_SELE_NQ				BIT(2)	/* Normal Queue */
+
+#define TX_TOTAL_PAGE_NUMBER_92DU			0xF8
+#define TEST_PAGE_NUM_PUBQ_92DU				0x89
+#define TX_TOTAL_PAGE_NUMBER_92D_DUAL_MAC		0x7A
+#define NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC		0x5A
+#define NORMAL_PAGE_NUM_HPQ_92D_DUAL_MAC		0x10
+#define NORMAL_PAGE_NUM_LPQ_92D_DUAL_MAC		0x10
+#define NORMAL_PAGE_NUM_NORMALQ_92D_DUAL_MAC		0
+
+#define WMM_NORMAL_TX_TOTAL_PAGE_NUMBER			0xF5
+
+#define WMM_NORMAL_PAGE_NUM_PUBQ_92D			0x65
+#define WMM_NORMAL_PAGE_NUM_HPQ_92D			0x30
+#define WMM_NORMAL_PAGE_NUM_LPQ_92D			0x30
+#define WMM_NORMAL_PAGE_NUM_NPQ_92D			0x30
+
+#define WMM_NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC		0x32
+#define WMM_NORMAL_PAGE_NUM_HPQ_92D_DUAL_MAC		0x18
+#define WMM_NORMAL_PAGE_NUM_LPQ_92D_DUAL_MAC		0x18
+#define WMM_NORMAL_PAGE_NUM_NPQ_92D_DUAL_MAC		0x18
+
+static inline void set_tx_desc_bmc(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits(__txdesc, __value, BIT(24));
+}
+
+static inline void set_tx_desc_agg_break(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__txdesc + 1), __value, BIT(6));
+}
+
+static inline void set_tx_desc_tx_desc_checksum(__le32 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__txdesc + 7), __value, GENMASK(15, 0));
+}
+
+void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
+			  struct ieee80211_hdr *hdr, u8 *pdesc,
+			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
+			  struct ieee80211_sta *sta,
+			  struct sk_buff *skb, u8 hw_queue,
+			  struct rtl_tcb_desc *ptcb_desc);
+int rtl92du_endpoint_mapping(struct ieee80211_hw *hw);
+u16 rtl92du_mq_to_hwq(__le16 fc, u16 mac80211_queue_index);
+struct sk_buff *rtl92du_tx_aggregate_hdl(struct ieee80211_hw *hw,
+					 struct sk_buff_head *list);
+void rtl92du_tx_cleanup(struct ieee80211_hw *hw, struct sk_buff  *skb);
+int rtl92du_tx_post_hdl(struct ieee80211_hw *hw, struct urb *urb,
+			struct sk_buff *skb);
+
+#endif
-- 
2.43.2

