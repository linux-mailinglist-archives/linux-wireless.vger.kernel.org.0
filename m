Return-Path: <linux-wireless+bounces-5036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A160881819
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B3E1F234B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAE8593E;
	Wed, 20 Mar 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koN72hby"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840478592B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963881; cv=none; b=gL6SX8EPJ1hGJjW8ywwAEQFavyxGv5z4NvWvClLXxoHZe5gE37W9+6w/o+TQzqn7NsAypJCPaBVwbsbNHjIutVmbdSY0l36TtM8l6ZBtdnFERaJMRKOFKfAHUo68KpYRsNfHN9keK2CcY1yhQIfN1bBYLS+gsR3VhjnUS0YNmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963881; c=relaxed/simple;
	bh=2Fh8r1RSvNGnaOEq6g5I6GBBCo4xlvbNgdeHY8JMc4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfEyNlM7OAAi6iVgosLsDkCoPsP/lzSYJY/aEeFOZxUfbB2TBA5UoLwGi4wV6jDPUGlBV3FCrw9bfnx8Dbuji4H/hH3YyJxjamC4aZOjAlnbezjAFKoe54kQ+SE3Puv6KraY0KDTn7IPfVVBt0FWzzdqEQTCfeQsVfxafrBs9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koN72hby; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414633f7a52so2027085e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963878; x=1711568678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgnRni5XvP/RpES/0kv3HXib0LLb7DGWhosJ5Y53JiU=;
        b=koN72hbyq3Tn9gZnv/quEj5r4Hp6oaMf4BrT6mnuwhTbnrLl0IQwYSgBBRFubtBKlw
         zqka+p41MDa94Lecj6dO1Lk0cG7kmp36BEeme4BQrCEqZ93taoJykk6TjmmBamBGYx9A
         UvzWZ9AzWacz59ZitOXRGe37xEPrgZ9TAY0XqoluYm1mTOnY2kcA8T+7AfVKqV9LxAHE
         oa4oMu8d8cJCB+n5zrKCL8IXjcUQnD3L0e5RN6aSD+mQMNpu3XH1Q0f+0QTPc9+eusQO
         WrP+IQXINFf5ET73Yp1Bkt7DrJNKO3476ow8B/pHfFblfck539WvyvapnbOiUBpNXKNA
         1mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963878; x=1711568678;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgnRni5XvP/RpES/0kv3HXib0LLb7DGWhosJ5Y53JiU=;
        b=OT7Tht2RwA0VE/ywEYHJD94WpWAQZJMH/H/OUPBHdrU+qddfwE8XFPuxWLyMLqf2Pz
         /wJdHX320+HA4DawGT8eMSe5sOdln2ZBmXpG0gZlRk7VaLvB4FieGb8MduYn6JlcL+KA
         4zEA0wv0lmUCB/rcnhW4uQPHEuc8fqv/VVOUCr5ZWevk62tVutpt+DikbwVbAOxCVGwm
         +OxAm8CiQhGeRtSWULmdZ83GiRn3q7djJUemseu+7FShHzGVRMLhZgIjwwlHFqbM27mm
         vCeZs0tvOMm/s3Tmr/4+2qdYJpfiM/cCfX1cjKrN/taqrcGzLUgYv3i7v+cyfJkUl09A
         tXlg==
X-Gm-Message-State: AOJu0YzBDBMjzUT6cobDvW84Cg0Ufw5oXdVPjP0qK11P0KGtVEGHyzl1
	RA8w77+AFyHBcmNzRVoDauDuf/QKPNM2vAysh8OucxiyRSqYfmgAhGoZDf0t
X-Google-Smtp-Source: AGHT+IFzT7ULpJk6oCsFkuhPU1nwI+wLCLGQGj58UY+mMZs05NH5neQCTL39AjU9QbkBvGI5HjDVeQ==
X-Received: by 2002:a05:600c:68c8:b0:413:2a10:8a29 with SMTP id jd8-20020a05600c68c800b004132a108a29mr12967570wmb.13.1710963877719;
        Wed, 20 Mar 2024 12:44:37 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:44:37 -0700 (PDT)
Message-ID: <5c56d4d0-eff2-41c0-95be-fb903abd4175@gmail.com>
Date: Wed, 20 Mar 2024 21:44:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
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
-- 
2.43.2

