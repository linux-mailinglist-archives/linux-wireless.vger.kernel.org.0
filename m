Return-Path: <linux-wireless+bounces-14413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD989ACC29
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E31C20C94
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDB1B85CF;
	Wed, 23 Oct 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkb/BlLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48815B0E2
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693328; cv=none; b=nDFNoRM0Y6orcJXMXs9VqR/1rUnqrPICfH+Zns3IArGigVjee2U0tW08sc941hvUIXb0sOBFk7VUcfU8UEdXNik85Os1cWrnyay50ZMhF8bw75LZ2VY3CArAmHHGUYqLcpaIwoUl5/1yS5n6lG0qhOVOW11kkH8FfsqQUTidvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693328; c=relaxed/simple;
	bh=g1REvCZSa2DFPiEPS9cEzs92siVVfko+rq8TYZjAaCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pKo6F/uphf62sW3ZIf3lv2dfswKVnOMjNx4fiWY6UPn1ldG5omA9Dc857zGkIvXtmwAnDLo0TIHiBVloCiM337MJyfv/pSBVZ2cEBtquabc77kgrL2zUYbTlBSsg2jW8P2Oa1OTTqwxO+Lglh02CTIezboHfwj6ALy6cnGoU78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkb/BlLQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5111747cso76403231fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729693325; x=1730298125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMQTPHSiJbX53+4P/LtkwTFMhMto8BnUaDZhfPlDIRE=;
        b=kkb/BlLQU1Zn9v1yxvg6B99m8Vy364nn7TuDfLrpOuxONBEphlGY23/eYPLIkD3E1N
         /eRsNLlA7RFcBv5uPOIAUhqNeWLyl2PV40sC21YC+IL7tOj/CNcjJak57wN8I391mzTk
         Sn3RV/QfRLGVGCJd4+Itink3nX1MgoWg1MsKS4rnfEnKSrhzyn1ynp89Z/oF0/K+vQ/j
         W06va3il52KZIO8QKOXOtN7q2YRFLD85O0V8eE8T92YHeBjVnZr0EwLp5cwbHS6yXEi8
         YW1P8eI5L7S8TGLqJQepKNO+RJRU++CwNOEC1YcwTjTxefLbfIWuLHfMli3eClu2Q6sY
         R3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693325; x=1730298125;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMQTPHSiJbX53+4P/LtkwTFMhMto8BnUaDZhfPlDIRE=;
        b=PiWuXO/E4UmcH9S4eczteLM+TMzKMabnwY7Avlwg0YKS3qMXSWniwllzwvz7ap1Mds
         qzNefPcSf3LdfqLUMw1uSZI5H489FcRjo4QNK421kQxJTSNHWRi8hpB3D6JRtCtkVG48
         On/+8BtkAkPuZnFjI+eprjTKUCAkQteGvDcb9YDAjFGAShtssGi0WDkS3S4Z9aNdOSrs
         /9Uuzmf0Z7Do1un2zVox69ZewGXuLQHmSKw2t0bOQZXLFzuNJI/KTi4Vq1crG3N5rCCN
         mSWGyDz02TE6WZSN/Qg4plHPoOr7/LlQTjhEG4Xwf3esIrW6wixJ82PEXFve28l/reMQ
         8PTg==
X-Gm-Message-State: AOJu0YyhdaXOjk2+op5QLGMarvImNNPp/k6rTvNPUzsqlkgyI0xkuSdY
	HnlC3LZ5TU9AdlVF0LAvba+DXPIseLDWlf6qRkrIPBCRYOYNgYt5kJPsCQ==
X-Google-Smtp-Source: AGHT+IHad3RKOTidd22y8mC8ZhBf2HNol9hcvTIdF6FGkQp6axMjPDtCscYYGzZA1vKeU+3gg/F3mQ==
X-Received: by 2002:a05:6512:281e:b0:539:89f7:3187 with SMTP id 2adb3069b0e04-53b1a36c709mr1512315e87.47.1729693325014;
        Wed, 23 Oct 2024 07:22:05 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9155c380sm486545666b.99.2024.10.23.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:22:04 -0700 (PDT)
Message-ID: <2c38fe6a-56e5-490b-af34-624bf12a3fb4@gmail.com>
Date: Wed, 23 Oct 2024 17:22:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 22/22] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 Christian Hewitt <chewitt@libreelec.tv>, Nick Morrow <usbwifi2024@gmail.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are older Wifi 5 chips. RTL8821AU is 1x1, with or without
Bluetooth. RTL8812AU is 2x2, without Bluetooth.

Beamforming is not implemented. It looks like these chips need a
different implementation than what is in bf.c.

Speed tests with RTL8821AU: 137 Mbps download, 144 Mbps upload.
Speed tests with RTL8812AU: 344 Mbps download, 387 Mbps upload.

RTL8812AU should be faster, but my router is currently limited to
transmitting only one spatial stream due to a kernel bug.

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

v3:
 - Mention 8811AU in Kconfig.
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 33 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile | 15 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 02b0d698413b..733b3e58da51 100644
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
+	tristate "Realtek 8821AU/8811AU USB wireless network adapter"
+	depends on USB
+	select RTW88_CORE
+	select RTW88_USB
+	select RTW88_8821A
+	help
+	  Select this option will enable support for 8821AU and 8811AU chipset
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


