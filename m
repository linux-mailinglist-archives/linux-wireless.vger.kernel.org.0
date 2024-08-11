Return-Path: <linux-wireless+bounces-11291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D694E343
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEE21F21E73
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36ED157A7C;
	Sun, 11 Aug 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8a0VXhi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853E1537A3
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410722; cv=none; b=ZM+u4+yINpeZ19cP3y3qh0KwnvX8xX7dCmICt4CF6dMhITn7vMz2Rj9tCjHDX5gD/XiFMNIj+PE2q7vqR7x+qoPGKTNUjrRQQwbWr+7GVMKvPFjQYuXL8NZ/VY/QHvlauf3VOEQzJESH0Mbkj+pqfjEsEgfRjqf4bXmaXoo9l7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410722; c=relaxed/simple;
	bh=CkopQd6QEH4F8v0Lzg1M3XDKHqTnue4BUaUDfCRgcvQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XRkUwu75ypl6N+Eh12yMQCVOOju0w2cH9WOggE2/65XtOBZf85U1z1ulfnWaO+k0f65F+KXiWMOXkL0R6tjDtbM6VfYrCH352AoTyOk6rKWZ60Yy6fIrSJlx3wHmoMWAtyviF5V7ZFVqP0YM/WjOtZMNxTRQEBkhtzsKlJuGWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8a0VXhi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso4127121a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410719; x=1724015519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQxCbFseKt4F88mSufr7P8K2mNWGGCAlBDVGDZj2S18=;
        b=Q8a0VXhicHX3S5Olww9MvqLwQLIr/kayMdo4wEI1naHP0QR4zafx+otSZOgOWeHRk3
         79tOuhepSeIqM2T16CZEjC85Ypm3ShD3rMJVBMB5ExWSFXjlw0nXGTIEIeM9PsS7QUFJ
         N+iWIVM+r7Kc+wwZLyfcwxoiSmHSZcv4JotIIEKkBgTeNB3i5qbenEvrBSZEamGaHUsW
         QJQjRYgSPDg+jDUG5ej93eAhb9SgquGBEBUDJwN5MPWPhvnG3Yccf3nmyc8aD6yho6Ls
         O9enoceexw83oq3KMrkVE8jzqs4fzMASmCUUlwgCArK2RuPq7F/or+9mGP56DmZm9Gbz
         IvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410719; x=1724015519;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQxCbFseKt4F88mSufr7P8K2mNWGGCAlBDVGDZj2S18=;
        b=uDsQRLSYz+D2cwRQFKVMJDXWQnBPL3zZTvyMof3xA6p5AuS8nrWWLekbUBTnSZhxnN
         AO0YpcvUsYu2JAr/1imHxOwBZxTF+76xfqvfz57pndjctcKWnQ6kpMJ/ABv5o6IjvFPa
         VwJACJLLc0RWFvkFAzWrxC9buKugvRXKRCHse0Ti21PUelQIEYDR/TzQ4tbbLoG4yedI
         4gvE7UIhAMs44W1NzU+egbw3abZq2uThiJgpAYAnVPZYNIplAxu67UbdGCkV2ty4YERT
         I5HwNXjxxok0Qgpq52f+DlQo1/Qi/ML+IycdY8BOsElTtsxSLU3hqLKUckH1yvlMoeFk
         xhZA==
X-Gm-Message-State: AOJu0YzonJGetkeEgSTT0feP6gr06j+8/Up6jcgdTF4ambeviUSn5Lfw
	DzdajU65dvSYJdgTEpVIuvcPLQvjA8t2ItgI9cKwoCEhiNnJtlbBIXEyKg==
X-Google-Smtp-Source: AGHT+IGxIrY3QuOMaKUJc2LYMpoXcCKazVAoFQGep6inZsDZX/TxNc/ND06QrXjjfH95LzF5fn6n2w==
X-Received: by 2002:a17:907:3d8b:b0:a7a:a46e:dc39 with SMTP id a640c23a62f3a-a80aa15e66fmr561481566b.0.1723410719025;
        Sun, 11 Aug 2024 14:11:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb21314esm172401066b.152.2024.08.11.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:11:58 -0700 (PDT)
Message-ID: <9add94a5-c2e7-4583-9d34-a0b14884903f@gmail.com>
Date: Mon, 12 Aug 2024 00:11:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 20/20] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 Christian Hewitt <chewitt@libreelec.tv>, Nick Morrow <usbwifi2024@gmail.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
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

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 25 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile |  9 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 02b0d698413b..f4746166443f 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -43,6 +43,9 @@ config RTW88_8723D
 config RTW88_8821C
 	tristate
 
+config RTW88_8821A
+	tristate
+
 config RTW88_8822BE
 	tristate "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
@@ -189,6 +192,28 @@ config RTW88_8821CU
 
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
+	select RTW88_8821A
+	help
+	  Select this option will enable support for 8812AU chipset
+
+	  802.11ac USB wireless network adapter
+
 config RTW88_DEBUG
 	bool "Realtek rtw88 debug support"
 	depends on RTW88_CORE
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 8f47359b4380..2827e6373fbc 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -77,6 +77,15 @@ rtw88_8821cs-objs		:= rtw8821cs.o
 obj-$(CONFIG_RTW88_8821CU)	+= rtw88_8821cu.o
 rtw88_8821cu-objs		:= rtw8821cu.o
 
+obj-$(CONFIG_RTW88_8821A)	+= rtw88_8821a.o
+rtw88_8821a-objs		:= rtw8821a.o rtw8821a_table.o rtw8812a_table.o
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


