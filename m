Return-Path: <linux-wireless+bounces-23905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3BAD26D9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC917A9F6A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D6721FF55;
	Mon,  9 Jun 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB2EInfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3321FF42
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497647; cv=none; b=GcsDn43FbFaCZgJXy9dFT/b24b3g3x7vWf516xC7yh63p30adGl8rr0YQfLyPQHJ/9/lnWXNbj92I4+ah0kxN2puKhy9KrA/mZ/sTGVzS3J2FkNYs5kNogfD78eOoiJyvNVRalhFhW+z7ocMWdXNXtTKz9tTw/J+vPcdZUzkTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497647; c=relaxed/simple;
	bh=gu2tdnuPFBsGHrdSi0bV+nic+L5cLpuD4YydiZ9Ii6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ive6hEoOnTC07j1WnYaSk3z5g6ZZxkicG7DTK3/k3MXb49wtjFSK2meL92WRl0jpijgu6gFzfWzfa/490RCsAfe8Gx5hoFkKVhcAESMoo7PHzRJ1lTIe0ogd18TB5MkAaVl92m8Xcoj+aessUXg4Ll1AgFQefH+Pj8/GtO/5k38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB2EInfm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so633850266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497644; x=1750102444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DY8HwOkps1wZ/Hv4SZKRQo+7+ZZLqqhNx7wbzd+QorM=;
        b=TB2EInfmxHqBs9KRLNqUqZLsRNIgAfYoEwFYGwNXmsoMs7G5FXgb7/XpoZDjgBJtGm
         X56XkEaxWnuxIdihhs80KzXKqtfugkG8NxnVL/vsRVwX+EShXZdu6Srn/1/hBq59nVBP
         GMFX7WJqcOWn0aCqNnPnZ78/aBnUwwsQvwmmWPfa+gdHkozojGlD3h3olCaJ4KqdTdMe
         v9CoIT37cEakDunkX3jn4+49z0okJGHAb4JN1vXPmZmp9BdS5wjxU9C6SZyU8IXNcmxb
         9zTKiNDuk9aFqMCp9wapxaONqFfeGat/Br80KnNz4ptWvXrI4zngm9s/JcnQCsSZo8Qu
         xEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497644; x=1750102444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY8HwOkps1wZ/Hv4SZKRQo+7+ZZLqqhNx7wbzd+QorM=;
        b=God1rXMJnReQvtzA1/rpKQM0Z3JRTw68HHvfR8D/97YvtZEvpv0KgKUD+HPUi1cjhR
         1xP2EX+cLTCfD1pXNRihYhlz4ckt8luwoJ2zaYBlM544hB2lFDcwMG9eDwQ1zsGdRH0E
         fvAhqb6gFTdBprdP3O3eVrV1ZueoakNI4A6pkBs2DCxDoSCU1WXD10F2soHDLWAmgF3h
         pE70SKSb3Sc7R2dpwGSpQHOfSX3w/QsNpX00zSh4XUM3iRlm0nTh79YSE+AYDGOHd4CH
         BOr4KTtqI3YWTkqJz/JaNJr+Q/7fg6avdsAbzf33Isef8W1yWZIwfH50hy1QNJ0IBOWn
         ZJJw==
X-Gm-Message-State: AOJu0YyxoDSu3k9Ge5Si8WchbNZt6bizI4WoEeec7RHu783TsV67NbGl
	LUlZCBpNslPF27qZFFws1bFKoXEojTcRBDJstb1fvZhEFhAlyAo2kWmkW9oUVw==
X-Gm-Gg: ASbGncvJJYob1BWivs6DACexSh6msOWwxug3Nl7WOgPOZiQiTECTcKHXsKyj9EuXB2N
	9fp9j5eiHHuaGLRbmMfV6jOOFKBRsgN45Im/4WpenMr77dzm0ygK7SogURuicbQ0Yh1OEOH2VDL
	ilwYvI0TPIIEcfwTt+ccYJ3PSkqvoE7tBY+xGwM5vkXLOId4nQst2LUkzHpL8r6Bw+BNKymw19k
	LroGCh3lqebFvdbubdys4eMpNQNbPyv2xUKCcs7QVDQVaW+1XrJV/s37LEzQadfLqqhgdm1K2sw
	fdGyDss/0gKAInIuciTCg1fF7mx3I5MvLJ0JvMJhAsHlTGbOSHXDfUH3kCw=
X-Google-Smtp-Source: AGHT+IG0RFfqD2mvVlrSMhnZnQN9Q/WMGl4krPpAHVyfL5ywaw6uNOJEGrm5X5gnTjvmrPYrxfS02Q==
X-Received: by 2002:a17:906:4794:b0:ad5:372d:87e3 with SMTP id a640c23a62f3a-ade1aa157fcmr1396913266b.27.1749497643886;
        Mon, 09 Jun 2025 12:34:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55f6bsm596029866b.51.2025.06.09.12.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:34:03 -0700 (PDT)
Message-ID: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
Date: Mon, 9 Jun 2025 22:34:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
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


