Return-Path: <linux-wireless+bounces-13922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EB99ADEC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAE728C712
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EFB1D0F7D;
	Fri, 11 Oct 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck3RhPHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E724199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680378; cv=none; b=fWMSdUTxWC9zyxmDMdaYnDkp0SZRS6drzP5LR8Sc5P2mkNclR3jpHlKSInW7sT/6VdF5DS9kyJUxz/UVksaBCAbdEXZ4eeMlogbRsBG2bHACWRrCHXZgZAVaa9pNxGRAmkCXnpmcxikd4ULM5Tq8iaFt2Tk/gx/itRWJdM9+75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680378; c=relaxed/simple;
	bh=+aLtGxgwyXoTf272H31YNlH81842EMaVZoqPheZDjFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bJvKm5h58SCP0IlEqkAW7QTlWbDpKPygO6IDshYqyvZ7eigd6hG9wv2nzj+oCzWp7QKeXhcD1RhdL5FL9gDSK5h/qnC/k/vvqwNUkhnbJz4CCtdGenmB2fMbv8zkGF7GDTKqO1vBcAs5AtyDSo7nAMWiIyrk3Iwqm0lwfuAIWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck3RhPHH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso8578975e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680375; x=1729285175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C64T1OkBHMwFqAILNUVhJMwuGbathbTE0nynqHuRkSU=;
        b=Ck3RhPHHJjqdeZtO/EknCIdehpO4V8dZI5Jghmozy+UNLxYWMimD4x1euQzuqmYOge
         No9aYY9LcSliHH6mwtsj9nrmhJCnjwsQPq7WMqN6W/aE3+DZOJ+uCH/YHg3XuESt2V7G
         uitb6hrmQzK5fSva5y0KZT6t7yAXCuKOkDGGL2oss++WgxutEzCtDrVIJLb3hKeS3Jjz
         p5XVTyH4yJkA0l2dVdlU4amQ2FLCJwasj4RScXveE22sq0rzTIoz/kBcbIsziCynfjTQ
         B7eisPwwQcWc5q1fzL/vALLN+IKJfop7ThK1jqjUKRCv5KfjwZAofbyj3JOfx/Rcn9kd
         dpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680375; x=1729285175;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C64T1OkBHMwFqAILNUVhJMwuGbathbTE0nynqHuRkSU=;
        b=cy3MBKkZrzshOK42SeJYna0n58ThkUz7MgSV7787/EUHIGJBADawgM5WOItq6MLX0F
         wKD9EfRlDQrO2JnFYacBNJAIyO6iA9rK1PMZCgouWD+HkOQPbUFvk+C8khqM2WKGWcqK
         qraUgXsPqgZmnIiCjQ1lDYOVh56sH8dN3aW3JxMG3glCLI7txzy2FhQOwvIA0mtRm03e
         ONY9Ex5WpgeotCfK1Qpr4zJ5s4vF43NNj7HonzxpyfF9nV9Qa16uwU0edg54TqbVFOBq
         DqiHJLY2zgSgiLrefR6mRLdRn7AX6dHb+A2lZFhs9+uXNViYzzMCgGScug4ue/hkxl47
         tDkQ==
X-Gm-Message-State: AOJu0YyRUt3BhVcqVbx3e3yWsKGGgbJBfAf4f/9aYvD4qEP3+kgVp1BD
	jSFac00KMNieJuQ9KgUz6xcYoAvHPV7BLPDQKlZAQ75SLg2r27Fc5nMH4g==
X-Google-Smtp-Source: AGHT+IETAgTYU0OFJvPzgIFFLrrCKnXsWgK27KzVQ/e0Su5yi+jCSvzj8UsSKoNibaP7jjMTvO3yPg==
X-Received: by 2002:a05:600c:1d20:b0:42b:af5a:109 with SMTP id 5b1f17b1804b1-4312560903cmr5562025e9.24.1728680374545;
        Fri, 11 Oct 2024 13:59:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffc51sm51000965e9.15.2024.10.11.13.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:59:34 -0700 (PDT)
Message-ID: <144dc024-e82b-464a-8182-4b051c009cd8@gmail.com>
Date: Fri, 11 Oct 2024 23:59:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 22/22] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 Christian Hewitt <chewitt@libreelec.tv>, Nick Morrow <usbwifi2024@gmail.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are older Wifi 5 chips. RTL8821AU is 1x1, with or without
Bluetooth. RTL8812AU is 2x2, without Bluetooth.

Beamforming is not implemented. It looks like these chips need a
different implementation than what is in bf.c.

Speed tests with RTL8821AU: 137 Mbps download, 144 Mbps upload.
Speed tests with RTL8812AU: 344 Mbps download, 387 Mbps upload.

Station mode and AP mode were tested.

Bluetooth coexistence works. I used my Bluetooth headphones for
several days, listening to music and watching videos. There is only
a problem with the wifi speeds with one router:

With ISP's HG6544C router:
Official driver: 3/5 Mbps.
rtw88: a bit more, but not steady at all. Not enough to watch a 1080p
Youtube video.

With my D-Link Eagle R32 router running Openwrt, on the same channel:
Official driver: 6/10 Mbps.
rtw88: download starts around 30, climbs to 50 / upload is 10 Mbps.
I can watch a 1080p Youtube video.

The music doesn't cut out during any speed tests.

I also tested transferring files to and from my phone. I don't have
other types of Bluetooth devices to test.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add more information to the commit message.
 - Add the new rtw88_88xxa and rtw88_8812a modules.
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 33 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile | 15 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 02b0d698413b..2e6fc696d220 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -43,6 +43,17 @@ config RTW88_8723D
 config RTW88_8821C
 	tristate
 
+config RTW88_88XXA
+	tristate
+
+config RTW88_8821A
+	tristate
+	select RTW88_88XXA
+
+config RTW88_8812A
+	tristate
+	select RTW88_88XXA
+
 config RTW88_8822BE
 	tristate "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
@@ -189,6 +200,28 @@ config RTW88_8821CU
 
 	  802.11ac USB wireless network adapter
 
+config RTW88_8821AU
+	tristate "Realtek 8821AU USB wireless network adapter"
+	depends on USB
+	select RTW88_CORE
+	select RTW88_USB
+	select RTW88_8821A
+	help
+	  Select this option will enable support for 8821AU chipset
+
+	  802.11ac USB wireless network adapter
+
+config RTW88_8812AU
+	tristate "Realtek 8812AU USB wireless network adapter"
+	depends on USB
+	select RTW88_CORE
+	select RTW88_USB
+	select RTW88_8812A
+	help
+	  Select this option will enable support for 8812AU chipset
+
+	  802.11ac USB wireless network adapter
+
 config RTW88_DEBUG
 	bool "Realtek rtw88 debug support"
 	depends on RTW88_CORE
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 8f47359b4380..f0b49f5a8a5a 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -77,6 +77,21 @@ rtw88_8821cs-objs		:= rtw8821cs.o
 obj-$(CONFIG_RTW88_8821CU)	+= rtw88_8821cu.o
 rtw88_8821cu-objs		:= rtw8821cu.o
 
+obj-$(CONFIG_RTW88_88XXA)	+= rtw88_88xxa.o
+rtw88_88xxa-objs		:= rtw88xxa.o
+
+obj-$(CONFIG_RTW88_8821A)	+= rtw88_8821a.o
+rtw88_8821a-objs		:= rtw8821a.o rtw8821a_table.o
+
+obj-$(CONFIG_RTW88_8812A)	+= rtw88_8812a.o
+rtw88_8812a-objs		:= rtw8812a.o rtw8812a_table.o
+
+obj-$(CONFIG_RTW88_8821AU)	+= rtw88_8821au.o
+rtw88_8821au-objs		:= rtw8821au.o
+
+obj-$(CONFIG_RTW88_8812AU)	+= rtw88_8812au.o
+rtw88_8812au-objs		:= rtw8812au.o
+
 obj-$(CONFIG_RTW88_PCI)		+= rtw88_pci.o
 rtw88_pci-objs			:= pci.o
 
-- 
2.46.0


