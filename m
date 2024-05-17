Return-Path: <linux-wireless+bounces-7813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA28C8DA4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563F01C20D59
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411738F9A;
	Fri, 17 May 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTXmi8mV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC81DFE1
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980823; cv=none; b=jJPSwB9wOWGix62ifT6Fn2ALpPbBzcOz8nngLR/t0w1TKwNg6b8P5rh6tUDv82zTnDbHKp0YXVwSiAtgyGojCrPnjv3Uhd7JQjgzJLBjmhGX7mr/yGENGdJ/S0jAvFi5egrwJQqFEcu9e40pY4HYitEMqQCL6fVWgG/hBsDny+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980823; c=relaxed/simple;
	bh=KMOUW5CFf1C7yzkZZLje51AE6TNP8UwopS9Jb26DNwE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fAoKhMrLrk+3yiXj9LZvwNBOdHxJe8SpGxeVmDQ2FG3LlfzY/UzMx/4vjTXpDJh7SRjsEjU5z+DW+7yn4U5V6AYigGpfKDQ+oNHXJsDV5GOmQlTqoCMwyQTDTu7G/XY82PFozpDNOePnhoxNHpBB27tH79mr7l25eHN5tSyp3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTXmi8mV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so13438601fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980820; x=1716585620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LE2VQp5DVpSMP+RuLYmfpTu/jOXcLkXSUSOLgiOBaxk=;
        b=ZTXmi8mVxob414Au8sUZ1PzTcBYwSSrPPOiOpfesCzWABzKYLuv1X8TYG/8O7DPV9U
         3nNrcieoMtqEdl15T7M3gyqn0Qy7QA8RCzfJBrIuM7Ev9S2XxO3nQp8aMuIjqugdlROR
         gufEN1gWCDx89+uptAnkjwdPQsLZ2IXLuwx2CwTv9FN/f1o8G659WAQYy2Ho4VMcLx7N
         G0UwQhUmwhZc6IGHaQmjuN8Nf0F1FwjxikQ+cQhewPrT+VWPStppRxfMMG45nigXJIJi
         K9qYo6Luh+5vLelzgsUigUL9W+7WMzv6PcZu+ps5LDZw5k8rDHUj74sTCzUCroe+wwFA
         HKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980820; x=1716585620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LE2VQp5DVpSMP+RuLYmfpTu/jOXcLkXSUSOLgiOBaxk=;
        b=ApVR/jr8/4+86TsWWWnUgwSnhCL3MpDo7wjEfOAIBdPvMEtyJv+chnEPq9Jew9+ml+
         Y3xg/w/pLhBbkFNLzr4++zwDLG20s8kJ9+RlopHfHQrtm3CoZ8QpC4lLy9wQgjUYN4ld
         Ij+0lGAj1gU+KOxyg8qA+JdgvXuDlKtgysyHhfaAMLQAv915APlCL5P41OWBefl3Jrrp
         f6EhzwwNIKAFME/25M1l2QRT69+yluxRjWM5UNdGhkxNdI8UzsZIcBskmQ3T/Io8Ravg
         UvuxmMmImIwmEQ0DaS8H5UCXXDuawyZi5x6Fk5mQ0KRUFx5gJpTY8kN5lWBKVtYPmAwy
         6kOw==
X-Gm-Message-State: AOJu0YxnuKpqjKwiHwPhimGQifsvjeYZdmz95O1YQoybZqgeTze9Kx5z
	XV5M0NkH7zfmDelgcFeot09ZiASs1fUmzM/VY3Ej/A6tJnhliFFzm/1jVLFl
X-Google-Smtp-Source: AGHT+IG987SMjAdVxum4gZ3CnhBfATUFFTWM6FIPKqSwOxpGwHHPH9TKSryposa1bhaXqnJHDsM3Yg==
X-Received: by 2002:ac2:521a:0:b0:51a:c3b8:b9cf with SMTP id 2adb3069b0e04-5221047590amr16205330e87.69.1715980820094;
        Fri, 17 May 2024 14:20:20 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177f0sm1146641266b.209.2024.05.17.14.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:20:19 -0700 (PDT)
Message-ID: <f32f2712-57a8-4528-a58e-572bc90b1ba5@gmail.com>
Date: Sat, 18 May 2024 00:20:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Language: en-US
In-Reply-To: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
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
v6:
 - No change.

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
index cfe63f7b28d9..1e66c1bf7c8b 100644
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


