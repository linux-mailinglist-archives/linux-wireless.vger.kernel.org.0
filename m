Return-Path: <linux-wireless+bounces-24307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2BAE22A9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7161C22962
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554021019E;
	Fri, 20 Jun 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl+zPYGB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D411CBEB9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446358; cv=none; b=J2JUgq4q30mYpJiQSa1EAQadJpnz0VgWC/+ty1D54IkSVYqQ5c50ytRsZWZHY+3AKNUIBeDL3xPaYdX/OZvGfkFgoWtrO1WKN9s5HpeYTyyuFjHZIY4c4iIo9E3RM9d99Vw+NjeJ34JRqU9/MK9x37RwAkXlHTXmXOi3qhyaTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446358; c=relaxed/simple;
	bh=8cRSxAo8k23x1ifmKZFIJ6/fWI6Mg04kwvnMHL83eMA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SpH49A1KmYhfrARC+TPLtnI0Cci56a9MD0ISeNYUbEM1SWrj159YEctFhoc8cQ674+QxLnWsvinSRYK/NFD1zSRLUgZpf34kHENm22piZWvOMHkaG6fKn3+csER9+2i/ZopiRTjSYQdyn/qB4zzB7kS/Ts9M3KoRrus0eQfGiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl+zPYGB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f71831abso1850132f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446353; x=1751051153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KErb8EL3hziV2a0PRUm4OcX6fVqV2+wqmk5qxf2OZUs=;
        b=Kl+zPYGBKRqnNV2g7dX0vk2hfcH+nToEBD4nEG2/tmFt8yl2hVZaso2WdBvcWwe6tb
         /Y/9UMyrGQqVn5weXtJ7jLI8BMybj+q1roU736NGYDDzzLwPNcvGK59bTpw2felB+dcN
         h5wObYZwx5Owingrmnv6gnmi+mKNg8v+M0tqmDfn9EXfJGAmGIXVWMg3szYWiebiLpMk
         ij/w30shc5toXB+zaJRQeVbOncuw3ZhRLISgJSXIlB8qVaeaaD7L4x7gSLum854X68HU
         0D4a6DsUjdAb+/R5K9Q23t0MWTC6D+77R+xFg4YgAGeJpccvZnRjnsB0a4MX0pMzLm1v
         mZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446353; x=1751051153;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KErb8EL3hziV2a0PRUm4OcX6fVqV2+wqmk5qxf2OZUs=;
        b=uQaK9JKH1Cb6c/pdlT/8ccQbulQlrTovDZImfCEhQo8C4woRLrkohrZkHhNLXW5v3e
         Wk1HJJ3Z8gOY09i7TX9SoOWkv9NyuaF7GlEWhE0Klj2G8AhH42fiD56eey65u3/1Qqj8
         kqbsnCvJluz4t/Cuc1WnbaYxZx1t3dJWGrdlu5tBHErx+3rehGqMP2VAip/vHAk0CpCW
         H+O8JxQd5HTI0omNNadyo5XaV+FWXkUDQCGCD4+HrmbUheUSS6sWrLnLz6dQsDa7e3iw
         Vqn3iu17B0tiWPUN4rzL7DPf0RCXTxqf5ouM7mGOHFTlH5y32f26kX22DcsdfRp3Net2
         ES9w==
X-Gm-Message-State: AOJu0YwVYmw7Tjj2rwmobf6nQPi8/P0SSDIWbTuCghXalcXZpczN+Eaf
	iZ44AexyldIjRScdoA8fP6SkhVzUwsFPXfkK9hBRd7zCrzTTU1axb1mIrkag7w==
X-Gm-Gg: ASbGncuczbMF8JNM1oNNx958cSg0ET14SZfPYRCCKK/uQfNDCpSHKXspChobnSLvONh
	NTVLNdUosXvj0jutvxUQwUgS5AQ7HacDTfk97tHw6lsYXb3aXoid08UqeMKLc0WPU3V7ESCA1Gc
	5x0FLRrOV+NW/An0AyMtesklBDpIDlCOLOrBsQqm8z4D9Jc6svQk2vi/6JtdMKJCtVtwR5022w0
	8wjmwDwyfudHdXcKLaCeTmpO1tKfK/8xDARGtjuBp4VwfHqcNZWCOsePJ+peIzXx8MV21xc75Ot
	CW6n+d+F74PB3N8b+PU3Uiu9e99Z4QRh4vq8patxfkwJnBWCdApbnnpyq0nY0tn3r3jcIQ==
X-Google-Smtp-Source: AGHT+IGd7iTzHvUiT0lOnM1Zb+lD73MRfPVwBioVtAH9Y6kdjnJtKrLKe4Dns1R8VJ9BULSghLzNGw==
X-Received: by 2002:a05:6000:25ed:b0:3a5:1240:6802 with SMTP id ffacd0b85a97d-3a6d132bf3cmr3700271f8f.57.1750446353101;
        Fri, 20 Jun 2025 12:05:53 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a1bsm68288135e9.33.2025.06.20.12.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:05:52 -0700 (PDT)
Message-ID: <31a677fe-40fe-4c1c-9863-11cbcb7afdb6@gmail.com>
Date: Fri, 20 Jun 2025 22:05:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 14/14] wifi: rtw89: Enable the new USB modules
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable compilation of the new rtw89_usb and rtw89_8851bu modules.

Tested mostly in station mode, and a little bit in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
 - Add more information in the commit message.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 205d7ecca7d7..bd180f3369c3 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -17,6 +17,9 @@ config RTW89_CORE
 config RTW89_PCI
 	tristate
 
+config RTW89_USB
+	tristate
+
 config RTW89_8851B
 	tristate
 
@@ -49,6 +52,17 @@ config RTW89_8851BE
 
 	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
 
+config RTW89_8851BU
+	tristate "Realtek 8851BU USB wireless network (Wi-Fi 6) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8851B
+	help
+	  Select this option will enable support for 8851BU chipset
+
+	  802.11ax USB wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852AE
 	tristate "Realtek 8852AE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index c751013e811e..891e2d55c335 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -31,6 +31,9 @@ rtw89_8851b-objs := rtw8851b.o \
 obj-$(CONFIG_RTW89_8851BE) += rtw89_8851be.o
 rtw89_8851be-objs := rtw8851be.o
 
+obj-$(CONFIG_RTW89_8851BU) += rtw89_8851bu.o
+rtw89_8851bu-objs := rtw8851bu.o
+
 obj-$(CONFIG_RTW89_8852A) += rtw89_8852a.o
 rtw89_8852a-objs := rtw8852a.o \
 		    rtw8852a_table.o \
@@ -81,3 +84,6 @@ rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
 rtw89_pci-y := pci.o pci_be.o
 
+obj-$(CONFIG_RTW89_USB) += rtw89_usb.o
+rtw89_usb-y := usb.o
+
-- 
2.49.0


