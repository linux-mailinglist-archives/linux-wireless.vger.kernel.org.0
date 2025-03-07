Return-Path: <linux-wireless+bounces-19968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1419A55BCF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA903B8291
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D67F9;
	Fri,  7 Mar 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nESKyH2m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABADDAB
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307192; cv=none; b=k6RZEW4UD950BWJH40OySna/CY4ljsKtPvxrdjeyL7NMrUsxCwHdDTp8StRoIWoYvi0uWArtk6xhIlH3BfxQJfGlB7gF76EmX4nXldvHu8ZPrlQMCAzuHyrjAqZmBd6YkquHiJeZ7bCzI67t83CkNAeGCA4KNZzQ5iav2XGpOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307192; c=relaxed/simple;
	bh=zhjuHrLO4sbQjKl9Ga9KXL6wxqGcdXckpEZ6wwu1eRc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Js+b9wQRPi0lrMmW9CR8rUu2Lm0vsIYOLS2Q1jSYYytP7d3jPHeMScg8AV/iUZ8af9Wcaf0hUez8ESrY7y2gLSg4HQriebX0Xmx+Yv2mu/dd3ia/H1n1ZR9Ar6Z262JlLQbC8hVPcpAiw7aHn9DiH/5o1hfQi8DBqySO0DOM9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nESKyH2m; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so2009319a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307188; x=1741911988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFoXS0HtxgsEtjMQpzrZstEiI4nD4NXfwnwBBeQuWms=;
        b=nESKyH2mPFJyiRmVSgm4gBPNVWxS5LpI2GZfmxr/9a/a50IMS1S+RtfO5GKSl/k/Hw
         kd9N/W8S7NYJFH2n4ZN+infH1rlkqRKEakV6wCbWGYpzjuLxQ1u+OaOmDGNDWSqTHSfG
         xRqynmCCMik5e8GgT3CDnmFPG69d4nkQrDn4BVbtd5kTwSffhZ/sEwQGVsp8pdLCwGMf
         Pl5et/4WTVGha5TZHHoZLwgX3ZEgvNIA/+xoxDHmhs/sJakXC/cq7d9hQ1K18wgSdNlB
         2yHnP2rJ58S+7KSSzDXD4AbGC6p6mEvArvmoiwupIWo1ZSBkyjm3AUtL/gTZqhnyEDD/
         I9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307188; x=1741911988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFoXS0HtxgsEtjMQpzrZstEiI4nD4NXfwnwBBeQuWms=;
        b=beZE0j+p3YErd9BepSBWnmeRr+FPdxgnhDK6tykx4MA9pAKGEaw5UaAHzWCehgFfrN
         NzhbfqsaU3NmnidMGxh0lx38rdQzyRCC+iKcbx5HjTF9ZXKwuFI3HXbanjVeEIsvOjNE
         cKqVeweEFtim98BAbURwljfLu5dazL2jA37kbaGxWG3HSJpp9HoOu6wsYHxM3AgU+jRD
         nLrTiYoP1+EReq2C76PS2DFFLOz+kmHzy5olz72APxUFYJjsgYfDPRgHBn0atbfXrYQ8
         6SHZUBPDJcb1YDAfEbc4fMBhROUJ/V4rQrJuEM02gpxPgYR2frhwwyGe6FF9a/XRlGvO
         4WTw==
X-Gm-Message-State: AOJu0YyQRSidAgezuTOakuXk+wLfwtfURUHmqCayGGbzPR2FqZGsy2KH
	7RREYN3nPCWIg/Jbus7y/3sD+bkrabCiZh0HzKZvuOU5ADB+fBlUIlX7lQ==
X-Gm-Gg: ASbGncvodo9+lFhrsdeuNCtwIpA4zMldQth8ha2EuXyRKzEAE5tDmjk6mboFEM+BGfW
	eqMsdcJyS1xY+El8sUrMfkE6cr/eqI9a7eoiOM8EwZwZ4bWDR6mS0E2zGjGL5P+oeZatgAddJcK
	WwQ0h9XBA6ZGMTN3QzUlbQaoiXwNJVoCbxmrRPyFd64gd/kIZfkPWadwsYlpPPShLclsIswenqQ
	+W3SVpsewVgCVpS27t3fqMUijKhzAGl1fyizWze9Gu+8iZ5CdX7ww363q3I9L5mh1w04P15dGB6
	d0YMTOCVENUc+UygqYKvb0YR/GDpU/oY2gKW03JrL/rPsAp51IRtNw==
X-Google-Smtp-Source: AGHT+IHyrMgEClVoR6vrz7NGBR/G2VZCxUsFfM17vWb4dKW47UPWYd3kUWSh3bdJrfJyz0s2LzAkLQ==
X-Received: by 2002:a17:907:8293:b0:ab7:ed56:a780 with SMTP id a640c23a62f3a-ac2526ca1ecmr104493266b.27.1741307188368;
        Thu, 06 Mar 2025 16:26:28 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2397358b8sm178132366b.109.2025.03.06.16.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:26:28 -0800 (PST)
Message-ID: <5795b0a7-511e-40b5-ac36-476b63f174c7@gmail.com>
Date: Fri, 7 Mar 2025 02:26:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 7/7] wifi: rtw88: Enable the new
 RTL8814AE/RTL8814AU drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Language: en-US
In-Reply-To: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8814A is a wifi 5 chip with 4 RF paths (chains), 3 spatial streams,
and probably no Bluetooth.

The USB-based RTL8814AU can reach 800 Mbps in the 5 GHz band in USB 3
mode. In USB 2 mode it only uses 2 spatial streams.

The PCI-based RTL8814AE is not as popular and didn't get as much
testing so it's unclear how fast it goes. It's more like a bonus on top
of the RTL8814AU support.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 25 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile |  9 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index ab21b8059e0b..3736f290bd42 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -54,6 +54,9 @@ config RTW88_8812A
 	tristate
 	select RTW88_88XXA
 
+config RTW88_8814A
+	tristate
+
 config RTW88_8822BE
 	tristate "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
@@ -222,6 +225,28 @@ config RTW88_8812AU
 
 	  802.11ac USB wireless network adapter
 
+config RTW88_8814AE
+	tristate "Realtek 8814AE PCI wireless network adapter"
+	depends on PCI
+	select RTW88_CORE
+	select RTW88_PCI
+	select RTW88_8814A
+	help
+	  Select this option will enable support for 8814AE chipset
+
+	  802.11ac PCIe wireless network adapter
+
+config RTW88_8814AU
+	tristate "Realtek 8814AU USB wireless network adapter"
+	depends on USB
+	select RTW88_CORE
+	select RTW88_USB
+	select RTW88_8814A
+	help
+	  Select this option will enable support for 8814AU chipset
+
+	  802.11ac USB wireless network adapter
+
 config RTW88_DEBUG
 	bool "Realtek rtw88 debug support"
 	depends on RTW88_CORE
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 0cbbb366e393..0b3da05a2938 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -94,6 +94,15 @@ rtw88_8821au-objs		:= rtw8821au.o
 obj-$(CONFIG_RTW88_8812AU)	+= rtw88_8812au.o
 rtw88_8812au-objs		:= rtw8812au.o
 
+obj-$(CONFIG_RTW88_8814A)	+= rtw88_8814a.o
+rtw88_8814a-objs		:= rtw8814a.o rtw8814a_table.o
+
+obj-$(CONFIG_RTW88_8814AE)	+= rtw88_8814ae.o
+rtw88_8814ae-objs		:= rtw8814ae.o
+
+obj-$(CONFIG_RTW88_8814AU)	+= rtw88_8814au.o
+rtw88_8814au-objs		:= rtw8814au.o
+
 obj-$(CONFIG_RTW88_PCI)		+= rtw88_pci.o
 rtw88_pci-objs			:= pci.o
 
-- 
2.48.1


