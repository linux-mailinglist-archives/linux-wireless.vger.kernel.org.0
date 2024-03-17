Return-Path: <linux-wireless+bounces-4819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD387DF6D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE591F21088
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500081D543;
	Sun, 17 Mar 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW4rySfc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8841D537
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701842; cv=none; b=QQn82UVhpic71uI6KpBlqHanQWAFStoE8mG2HtbfZb6oc1henRiJiQDOkcdNC1W+sV2gtGmTW0CfAmBeD4TJalYeI+bgSj2mlgjESR5GieRBquXN2g4aDJbW3nWDLJnL/b4stG0EhlWUzCs0j91UFTNIjjbFkSDg1Hb6/QlxAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701842; c=relaxed/simple;
	bh=A2kX+udB0wDGNryudgGZgGhrLHSYLYfLPwt6K2xravw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=alvv6rYSFHeGkVGipXiI5QOz7+HycVC/+20ounPfyubzS5H+Q1UKVJ7m0xiO0l2QFQQu5pO2UGrVt+GWLKm9K8akzDppUBF9HnAKybOHQaDY0p+XrwEYKCBZFpa5AQFgDmqnCaRaAy21iKTzv1ENoBAcLV1Ngd1YCjPxYtVsObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW4rySfc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-568a9c331a3so3123623a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701839; x=1711306639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tM/gXQDqadwyYAieA0jveQZr0fwzpJFbSJuFGsZhiyU=;
        b=gW4rySfcbliqU7d9gDVO9iE5VKx9woVUycPlKIk/eGf7wb6iuO3unwHAJRs2qU6lsl
         GqxQGRqIQnKeCCyRbzkiToz/A1Qs6CLi2SbfETNOIZFnf3UN5vNWLWH42hW78auwpkhH
         YUlDJ2p3JKMMTqMDG8wn9BB0PoN1kZbK+hVYBSJPMI01pvQ6TPqhAVHRn00/Azn+vNMY
         RevSa91PhBgUqUApXckI0P0ZZlttdHaITQWlHtF0qpcrDD3DQ9plVTZG1YDH9TK+p7BC
         aABAK+eyLrYe+W38HMgRisrNRxSq8Y/77JlIjm+cCNZbZMhBs7K+x1gO8N06n3uQAfJW
         74oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701839; x=1711306639;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tM/gXQDqadwyYAieA0jveQZr0fwzpJFbSJuFGsZhiyU=;
        b=NYVpkLCw02IR94jzo5hOLpKlLKG8TZ1dlSepO22s+p/XZP7L9CDwdUJHklAjuSJn4n
         3Ft7hkcWViDVoJiF3OhPD+oeHQD6VtmZceWRTHgAhNJAcl9r5UiaMtvx3cjRDCO1QeKZ
         qNW4g7w2Oqr6CcPEOPocwu1lEt6JgTLJu1UbeecPfP71lq03mrlkmdLPOVl8H5kOOpGh
         J6QbCJKuWZOR5JP3K5vMrddXh++2TcZ1eBT188++8VF+buV6KHsSZfZrFwNbQi160g9x
         I9QPOuUYYRp04BYChmuzysYen1GKl/pjD4Z7INwI5kO9rJvfOIPxGFALxsrshX/e+T1m
         bWIw==
X-Gm-Message-State: AOJu0Yy57bIiRUe+678ofhnF3D/EfGyorQjNx7a00QYSVIjw6UcMbCA9
	UmQG9lQ5gfLPDXeiznr/SpFROttw+f/PIs9LRZ8F2ZlBBd4o+kiMwawaFQu3
X-Google-Smtp-Source: AGHT+IFZ9npuWTr/tK5AIwV8XaiIoy8RzSxl53xa7Zfhc+wmgn/QHSk40m+HSFXhC8wvxCE3ieTWXw==
X-Received: by 2002:a17:906:fc09:b0:a44:7209:4c93 with SMTP id ov9-20020a170906fc0900b00a4472094c93mr6211781ejb.32.1710701838703;
        Sun, 17 Mar 2024 11:57:18 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a4550e8ae70sm4032071ejc.63.2024.03.17.11.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:57:18 -0700 (PDT)
Message-ID: <10e2d668-5ab3-4d86-bf88-45eb1d16fb36@gmail.com>
Date: Sun, 17 Mar 2024 20:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
In-Reply-To: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
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
Patch is new in v2, split from patch 3/3 in v1.
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

