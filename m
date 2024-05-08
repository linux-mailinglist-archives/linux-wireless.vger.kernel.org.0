Return-Path: <linux-wireless+bounces-7339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2D8BFB5B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13141F2309A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E312E7C;
	Wed,  8 May 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4IpQ9/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C65481C4
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165724; cv=none; b=DF5XIcWLAbCXeApWGOUEB8qjqrmLnaHW7igVKJHcsisGw8s95iiQsN0SrxSG6z1+9nbLpMzfRwyqozS56gPZiiDK9FU/DVFgGmEU1yXRjPcKGKagFUh7pANnb1DfZaoaNWSs2bxl0rVNYLBUzzZ99ocpS2TVVCBBF2fnu/lzfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165724; c=relaxed/simple;
	bh=szSxRX1lsWNftM6zZKaTlSoFEhoXO1ceaw5xtEgiIo4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oWHwgJndi+kz6ZUOZMeLeGiluPeMqFMFSPHhiYhqeIIhYFDHpfY31n6l++vg66xDcld9taULDcFnI1vphtkW7OH3psYMQomy1Y2X5NmHteRKmzXeOw+08lk7VUaAC7D17ynF0LUVdDRbwuCjOqIlXMbwEhtxn3X1I5dGIRltvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4IpQ9/v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cf8140d0so814993166b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165721; x=1715770521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1TstxgATtKw9McgkuYLrLsMmzQgaKIIZF7p+pl8hfI=;
        b=Q4IpQ9/vzxxxmHwnvm3ThrC780BAreuIvz9LrJgQw0l42XMIW26egAjNNP2j2APgVR
         iiz1iooaX6qUztLIgw/6704kT0FrE0CwoPa1rIl4t4GLPEIVKJ0mLZccOa6vjqiDTTMD
         OVVrOBEEWgoGoGJ8G//gjO8DD/OZm4eozqGmkSqEudFfN5UKgqpbR0QMkawFbMpt6OYT
         FzHtVpi3OkD0uMGILYPz4U15VOJBapbs6RE8euFbIZGanRXzhyWt/MCFIvihBYjmtiR3
         vkkQLdZu+KCdoVBFQBdGniYBRZMK0VFIjtGnSqsqSqXfz1uWQx599H3+GLz9r8MZSvQr
         a0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165721; x=1715770521;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1TstxgATtKw9McgkuYLrLsMmzQgaKIIZF7p+pl8hfI=;
        b=GPdQHMtqe2aJnCE2uaWbxsK+cZhzYa/DAX1y28XtBp1X/TF3r+S7unCRc/OjNbuhh4
         ob+sU7Gu9/LwNi8BjSfPdfJfRD1Ya/igKNW/WCj5NLxaScm934Ma1ZkJt2+xQuVu3HcV
         40IRQvn/OgBrC1a2X1bWiV7qZzu+WWOP2Gf+QMjF+3ePZw0FU/2fO9GnHiNx4Y0rDG3y
         m+iPbzWRFRzXhoVgkH8hxShL+XUoi8a+lFWGYXB8p/2jUwZCqpWFdVVGsEz2qE+1vcUl
         aEt8kR5QAT39jKQHeXERyAg1PabO6mbcKIB1ipw1k34Xl4HiHETwVjaGQmBc1ohHzcqS
         9Ztw==
X-Gm-Message-State: AOJu0YxSOshWjwnTru2XNGfRa/DOZyB7gz5+xpnt4J7LHhOEJRC1i2Ki
	2kgHv2eYqjMIVbr8BXLnZGdSnldrnfobmNfKrFsFeU4EC1xV6svKxsGu63Tq
X-Google-Smtp-Source: AGHT+IGflYhzeh1vSTM7BXsuM1Ou4USm5fyf9uUGQzPvJZiIcNlY93v8S3hiXHyFFf1V4Sfwg/oSxg==
X-Received: by 2002:a17:906:3544:b0:a59:d5f7:a697 with SMTP id a640c23a62f3a-a59fb81a1e9mr146394266b.9.1715165720997;
        Wed, 08 May 2024 03:55:20 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id bf14-20020a170907098e00b00a59c3e28917sm4198927ejc.70.2024.05.08.03.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:55:20 -0700 (PDT)
Message-ID: <0fb5c4d9-d43c-4aa2-b483-c0104995fa9e@gmail.com>
Date: Wed, 8 May 2024 13:55:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Language: en-US
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
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

This was tested only with a single MAC single PHY device, mostly in
station mode. The speeds in the 2.4 GHz band with 20 MHz channel width
are similar to the out-of-tree driver: 85/51 megabits/second.

Stefan Lippers-Hollmann tested the speed in the 5 GHz band with 40 MHz
channel width: 173/99 megabits/second.

It was also tested briefly in AP mode. It's emitting beacons and my
phone can connect to it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v5:
 - Call it 802.11n instead of 802.11an in Kconfig.

v4:
 - No change.

v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 drivers/net/wireless/realtek/rtlwifi/Kconfig        | 12 ++++++++++++
 drivers/net/wireless/realtek/rtlwifi/Makefile       |  1 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/Makefile | 13 +++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile

diff --git a/drivers/net/wireless/realtek/rtlwifi/Kconfig b/drivers/net/wireless/realtek/rtlwifi/Kconfig
index cfe63f7b28d9..991e1025f4d8 100644
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
+	This is the driver for Realtek RTL8192DU 802.11n USB
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
-- 
2.44.0


