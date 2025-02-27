Return-Path: <linux-wireless+bounces-19512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A2EA47072
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A7E188D104
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480627005B;
	Thu, 27 Feb 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOQ56AFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461511CA0
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617030; cv=none; b=swdwP7oZqz1LT/LWq1bLV01SBBJhAoiAUpTLtM3KhPKoyhAo74n1VbI21YbvLFFc5Un4/gx1/Dyih+ph5sTMXgtHsHaEiVaSpbN6gKiw9jv64CzjN0aAyclH5qLsmgcAN4cB/bFIaWR/2hwmb/P7/ejk59DvImrnp5L0Lq1xT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617030; c=relaxed/simple;
	bh=06yaLkNLXwq81PNDcbJ4rWnr8sowBTRSRMta68j6Yf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gS2BG2Cma2K1Kw7vOKuOMvbrU3NbdlysNzkO1IHqM2I0FasSXqoiNnwQCQff+V1dd6PHPHtOw7fw5bD0P2TaGXtSvXzXBTfaxrM/R5nGZfwkcLUIkGLJ6b8KYB864DlzFljhfVEcJ7VpqBXLZuvID4u6xya56UysgtFTHJpt+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOQ56AFA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb7520028bso40826266b.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740617027; x=1741221827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=My89InoJ6R/KqK1ZcJ4VaqiXw78lDvL4f1Uy7BtVGLI=;
        b=DOQ56AFA1rduY6Ehxk9aJ3Jb5Aqtyzau7Z36MBzogxqiehRlbWVqge/IORdbIevIXp
         O0s0IZr+9V4EWwdljEi5Jy+TpSnbamFjVBkUXLeHNtweVPMoDktCqnb/ctsVxwn2d4zF
         N95OdaT0srh9YwXtJuObtSOYRHw7bUMsjVW2aO92M7mhg8X6A94g1YYn50O4FAvchBIg
         fCzeggmo7y+YMWqHe6+JFp/zwgvZGcfLOVgUD8/ILEipmoXsRs8lBTpeCcFfxYL/N1OS
         QhKoCsgEdlUaNjgXihRNdTLVR4HnX3TpQADp1+ObUPHx4/4pqDCc300d/nbwnpKBRZbo
         A2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617027; x=1741221827;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My89InoJ6R/KqK1ZcJ4VaqiXw78lDvL4f1Uy7BtVGLI=;
        b=dpYR6BLCXBzZk57IkgtjhYTmLd2w9YnQ9woax/pua0QoyIp+Lixh+iC+Ag/Uc34xG1
         U9Gg8HCwnCni5ZVCa1dSCdJVMCin6RiuoC30df3aBvskWg++exMrXw5c3pW5LE7oToRv
         xwhFNCP8kaIrpoGYf5UYtd8DdG5YoLghF5X5PxDwU1ox6U7tISYVMJsHh+TryX3Sdiki
         4ArDLFaXRit6iQkeZ6HXZFFspOMhod0aVtNysbhfsTBaONZYj7FQN2wcFI+ZYFTUUy86
         qMQt3xfSFNHjq8GKyxwjVxcpkVJpQ25D6mEfMSA8+Jnas0/ZDp06rt+vK3cvwjb527bU
         nSaw==
X-Gm-Message-State: AOJu0YwAmTnXhjX5ROVOT8ksmy9orWnXeO7jBdzqNYfLngEw0TmvYmbZ
	7xjBJjrAX8HvgYvWkHz3GbSyINckiQHw2p3qEl8FGbwPVCepmYJcI8pC7Q==
X-Gm-Gg: ASbGncs4tpWK6vhXuALLwZI77CGiitlU6b5LeJ6OOJHAtnRas/uvRIipPlBxwq35+nO
	HaT9+sbDzJa1iJLZOhiT3+/Ak4vRhh8+UqwwMmqwEbxS4ftFZsFkbyCPa66Nhc6nM6uUMt53hhJ
	jZxRDCFxbDtaS4xP26c41cSWEXc+K9KxupCQizAtxlFxnLJIopTYjdHM4FG6mUIC9nhkDrSpuGx
	8EkgfmswE5ORaFB1kO2DI9zCQKcQqPRpcxNGnKUOm54tsAWFdDUqA0Gfuef2prTvkKMpPckc6el
	Ii8LkW7why9K0Lw6V8F5WqYbnrHqparZxdI=
X-Google-Smtp-Source: AGHT+IGwVGy3+7yS3KZ+G/zp2mW6ypLRDmxkwujhj6QNUGGSCAM+CySrzykN24dmEf/A4PLTL+MO1w==
X-Received: by 2002:a17:907:7804:b0:ab7:851d:4718 with SMTP id a640c23a62f3a-abeeef33fabmr698012266b.36.1740617027124;
        Wed, 26 Feb 2025 16:43:47 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd9e4sm29875866b.43.2025.02.26.16.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:43:46 -0800 (PST)
Message-ID: <b5628573-87c7-4f0e-bb1c-5652f81fb801@gmail.com>
Date: Thu, 27 Feb 2025 02:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 7/7] wifi: rtw88: Enable the new RTL8814AE/RTL8814AU
 drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Language: en-US
In-Reply-To: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
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


