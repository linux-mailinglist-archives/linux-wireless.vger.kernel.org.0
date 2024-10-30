Return-Path: <linux-wireless+bounces-14749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B559B6C23
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E031B22E41
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1271B95B;
	Wed, 30 Oct 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5cZKrWb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C21BD9F4
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313095; cv=none; b=pNNp3fXncS6VSodu/8D7uuATete1SXZypIIAkgqTwvCe9mBXO/WdG9pTYjk15Qv4g0mlmR55/pZpRgNvRSEI4C9g/pzswXXfpvwEzvJAkCT1RN2Uws/OVNRLmchRm8wlF9C43irT2u4G/J7PFG5adSMOoIkEwQHiRRtpNBB4HxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313095; c=relaxed/simple;
	bh=dSxNfduacesZlnOS1LFItNcxRGae+zN/yHoCktJFcdo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fM5IljyanboS4x1R6hFO2pGFg3jaLKqNxjJ7QqL20cwugWmkGUjt4uVbSE7RhdMS8pN+6zrzISVF0WbqPRZC40ioWYgYRPQIKnBZvqOhT/QvcyWFKjx/3+AHDNRfGK/KB2fKBXCrf36YmMFjaxf16ytNMAUtqAA0jOMYnVIJfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5cZKrWb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so317445a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730313092; x=1730917892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JS4o5FPNWyTuJZZZaU6KJv3THsEE4D+3vVjV2bNWLO4=;
        b=C5cZKrWbF9XvmP9NsohBPFY6HPEqSvZWmsZVWS0Lb8Jj5/HeKLX3a8TrloHXbfbqpj
         4IswTxw9c9/87XOGAgrZr+ErupuKRZOHSQN3Xtk/jOlzqnW+J09c+XYmch//bfG3Lh0q
         ga6pEziBS4Tm+gz78RPfHVJeJ7s4vX+hBl1udlTNtX1IeyOAdIWmyBr9EogSPk6ci6lZ
         jUiBxl6aBHSf/2f+y8E7pswTnb1XKdtxslvagl7pq4QCBAJhzPmXx1ghPhV9EjKNBVkG
         0iWnkCAZWK4jC/7Dc/g88UedeLk4nHV1/G6FbVGlsykmDZzDCXIecNxZyB00pBhfVa72
         I5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730313092; x=1730917892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JS4o5FPNWyTuJZZZaU6KJv3THsEE4D+3vVjV2bNWLO4=;
        b=u/QAQg1u/F1OPTuTlUddqxAvBIyunTZketpnziTyok4oFA8r3l+idyfeJuw8mznzCf
         b52FRcGn4dpkX3Z0mh5x+/0HWf+dWElxKUAvZyHsqDSRretKllvxyhvUq0Vi5WzwQ91X
         L31vOo2raNZFGwvPrrF4jWigkM+7wjfM3VDGuZgTa/LBoJaAA22tW8VPfyTa1VVkTJRZ
         U0lped+qHZHh0Oq1SqQ51WxDK1M9rFmLrhVM0pHo/lovjYxQHjNcP+bybiMJ0D9yl6fc
         tbxYON8dQ9ZiUykQKuBM+2T1mWEWaOq+KegTXeAlw/w9gtPgAGF4YpDqyY0LnCdhrESO
         I4vw==
X-Gm-Message-State: AOJu0Ywy7D5/r/UwBMRTbjbJY2zrLKjmx+vJzZtCKnmAzz0oLp2VNzuE
	izJUocCiq+3mjuzyyepuGkDrWMGWjPq4FAHEaVrwXf7rHjhrn+XyvfE4hA==
X-Google-Smtp-Source: AGHT+IHYO2/766YCUXikoC7mdR5jCott0OTg62y3laBsKXMlHl7mcPlwHbbNZB0yScK/Ex5anxHNLw==
X-Received: by 2002:a17:907:1a4e:b0:a9e:1fa0:d2f0 with SMTP id a640c23a62f3a-a9e1fa0d784mr529912066b.19.1730313091441;
        Wed, 30 Oct 2024 11:31:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297317sm593194066b.103.2024.10.30.11.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:31:31 -0700 (PDT)
Message-ID: <0b8e8093-8103-4999-86bf-0055ec52ea64@gmail.com>
Date: Wed, 30 Oct 2024 20:31:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 7/7] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
Content-Language: en-US
In-Reply-To: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
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

v3:
 - Mention 8811AU in Kconfig.

v4:
 - No change.
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


