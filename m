Return-Path: <linux-wireless+bounces-6052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14B89E415
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 22:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F99C286C81
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A711581F1;
	Tue,  9 Apr 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFVAzkkZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7260158204
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692970; cv=none; b=mx/4iQ/YEh3/LlQHDd1k62QmGPmuV5u5nSeGXZJ433Pieoglaw62guRl2wyYZsDeeTG5xQQ7/wTt075B+mlFo1UxFMzbGYehcfqDIuqWNhapbec6TZROWBt8vHkpr3qjbeXBypwDUczzyOTgrXlMFe6q4VTB+4Jq4QGTEGZ42RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692970; c=relaxed/simple;
	bh=wsch7RIzRQTqN2vLJKz1LexHTTO/ZmPJjQUyuQ7Ocq4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=id7TA5g9SWbqvr1rQbO9ZT1bGfqmfQTRs5chIEkvbTMU4WCw0vf2CHdRmMKicq5K/kM/qnpbXGolpXf4VFVAGKExNxe/WIzBGkNt6MjUauVHd2LRfzk0ivl6PdQGIaBkdlgP3HVWoAW32mOxrgv0YQJUXXe6xBfcqXqzWkTa/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFVAzkkZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso6015266a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692967; x=1713297767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BH17jkF8T/mdXmxmNSGZ32CGG/Y/aGY6QcU6ztmyFDs=;
        b=eFVAzkkZTR8DM7V5/RorV90xi3AUOu7YaS8Z3m1aFBO88urtpzM8sdIS5kquRd4KDC
         3HNYsbFJubkkxu7DsZstv9M0fJwSzb1dEAQfyolZyB0Gz4A1yRqh5yJjGMGGmEslgaNq
         tlJe/LuhFg5dQayJAIj3ui0c9RI51E2ZUqzcO5KlpRF5g+7YD7KWFuRNgu/i2InGd9zx
         EVio19m0GR1Puz0F0Wxjzh+SgvCTn3z6jfyyEvJgIhMwderaJ11ehCsJBjeNjURdTEdt
         pkCe9AfXhtjQGPa6r4TgHdl2JsIvxbBDqXt2R7PPh6GJZtHP6c5Cf20DHirSm7h5efti
         hphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692967; x=1713297767;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH17jkF8T/mdXmxmNSGZ32CGG/Y/aGY6QcU6ztmyFDs=;
        b=Wlh6AB8Nzpr2HPNhz/ZNK6a3Pb+VTUVvP8VYWQt48mBHz9T1KxHcbwgxjsZYZvz8Cb
         /ZflC+b8DB+b9txEdDctkDXCU+WDrzXbqN1RMq4VMWWhExYeS0i8cpoVb2TkRbWZi0K7
         lLWk+iN4uV5EBnxxduwI4/d716W86hSqNHnH/n6P+iORon+L+F3phUHQ9e+pd/gMy3W/
         s3FsPCnzh9aqgJo7sIV4Dgk9h956XIg1pXZmg+A6wTiwxw4H/ecRU+5sU0Dwi54DK3DT
         bBTNBJ5/BoDi59jaMFIeNC17wAsTUYCvqtVQLMzfkhGTf665reTYKPgz7Ma0NfMa/Bdj
         SenQ==
X-Gm-Message-State: AOJu0YzgyVIqiC4t2HbTx8TIP4vvFhQdpHar6PpAmPEWVrJgyKzR1TE1
	m3MBuAQwHpQnreFJOz3j5uVwJyw0CoD42kXY6R/0ZTg8gKhA1iDr9uv0Oxzb+Qg=
X-Google-Smtp-Source: AGHT+IGSkSiv/yRgBlOsZ0eS63I074rn/5OrNK+MT/kytrzKwq7P89Vvfc+6NwgVNfl4BoJ6QF9Bug==
X-Received: by 2002:a17:906:1545:b0:a51:d611:cd5e with SMTP id c5-20020a170906154500b00a51d611cd5emr310895ejd.57.1712692967061;
        Tue, 09 Apr 2024 13:02:47 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b00a518a133d77sm6158942ejl.144.2024.04.09.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:02:46 -0700 (PDT)
Message-ID: <4b3ef256-df0e-4203-8c15-5f3ef0bfa966@gmail.com>
Date: Tue, 9 Apr 2024 23:02:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 14/14] wifi: rtlwifi: Enable the new rtl8192du driver
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Language: en-US
In-Reply-To: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
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
2.44.0



