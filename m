Return-Path: <linux-wireless+bounces-8025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D18CD61C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8973828237E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7D1879;
	Thu, 23 May 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyLP8s+F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2065680
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475745; cv=none; b=GC1y+mHs2CPa9i4m68Bt0Uy5YDDaeaIDhtICbwNQatyrdvqFjvNglfUSkLfd2cUy9zLAY0KshmP1q5JuToYjP2UjfC7pgNys5V5sgbVqkjTsMvmTbW5U65JkzVtfTTewbnI4TA6vdOMsMwCNOHviZw8MHjuIXnrZAa/dyBXJz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475745; c=relaxed/simple;
	bh=rek681CRKnJqPPswKQBMz8O4nbF3GFatCyIl5hXCXow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eb/3KOuRem2PEC3++rvPwk/IKJyGRvwoG864k+5m2FBmEXtI5XWx2fux8kcuEoLKvsspwgBMSFCm2fTELJg1UPan5D2QxdaJhesoMFmfp46ONhW4A1mAm5MB36nfoVyQOlyiNI/48DiTTjU8B5noyhRX1RyLhQbm41tbY2Bwe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyLP8s+F; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1035521166b.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475742; x=1717080542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JVPtuioW/i3T4EJpa8MApq+uNZTLdss73Dgg/pPnxM=;
        b=YyLP8s+F7SrOyO7oQgIeEm5wlKhBMY0VmyDuHZrdzWVzg5dIEC33UncwIL+BoxTVx+
         p3MpGqKM1sauHsdmxLLtNG0L3aRT5I7YsLMGANuLRepPztfCBvoNQ+zfesNvy9xUMUuF
         hMjqt+rYY99TDCUyPeZy9EW/w1W8FTaqrwr1cW4Y+lgzgq12C4ZuHQsrgOw+1Aiavr3O
         /OC1C9ZljnN3GK4dhH9E8+1ghf6q2x5ooimlJfwyBHiEiIxWohrMaL1w1U2D5FIAclZM
         g2quB++8i5vnoYC6+uLV1j6AaeSBRkdkRlUSBWz+KD8oIrID+ArRqKtO5s/Kxo8bnpXu
         Rpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475742; x=1717080542;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JVPtuioW/i3T4EJpa8MApq+uNZTLdss73Dgg/pPnxM=;
        b=qFNSpBMCcWd/LPrWuZwh9hoU6crVR44r3kBoaNFYPbdJcH9ojJ4AVfMCNmcTf05ebt
         4pSfYl0yZsv+i6O8M7pjRIb5PJPRM1GxQ6GOWfzA8fYDIrPMVAAgle2rbnEwZ+5pEuWR
         9hSTp1Mr5pMshMUGnHaNJddW+DvMC9twHhAWExAR4FWWcXbWah2NbS/D3taYQgW/kG+W
         Qawnd2glsT5vUG1bam3r6vKg9I9eWl3ULYQGRnZp5JjYCsQ4NvuYILJmkphPHnJpMQUr
         JSwL1IYeZFTIemgsCmNDHZz8DJFBDqSRS0LL5kdP+38TkpwPliy/B17TsKL3yIC1QdRm
         DBmw==
X-Gm-Message-State: AOJu0Yz6NcxwBCrpqfbRZN6CetYyyEDSTNmjbPptZhwLhI44laUAijd0
	7yCwRvW0KSgBOFPa68kLtO6Zw9CQSJlB98TXccjbtaYRT1dFE8dSbXoPqQ==
X-Google-Smtp-Source: AGHT+IGZbvJ5RikkQOCiSEc7UtnixqiL2IxhqZ79KGfZHw9yKo2c+a7Y5wzXGYx1EJGIYYNc7W/R1w==
X-Received: by 2002:a17:906:4bd2:b0:a5a:34ae:10ea with SMTP id a640c23a62f3a-a622818ecf2mr353265366b.76.1716475742125;
        Thu, 23 May 2024 07:49:02 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01652sm1949530066b.167.2024.05.23.07.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:49:01 -0700 (PDT)
Message-ID: <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
Date: Thu, 23 May 2024 17:49:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Language: en-US
In-Reply-To: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
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
v7:
 - No change.

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
2.45.1


