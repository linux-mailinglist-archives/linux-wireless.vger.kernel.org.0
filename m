Return-Path: <linux-wireless+bounces-24687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860FAEE88A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660B1167FC8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4D49620;
	Mon, 30 Jun 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg+u4d3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353B230D0A
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316476; cv=none; b=ZWZMFhb32T0foaiYEDtvCISOlbJta0hmyV5znhdjWKgCAL1CDewG5WiNBdXiwIBsmYutVEWdxTPB/yd5MObmn4H++7a6t4YlvpTvx8pN4SkrkEVgm04K4bHoKg0bcLe1CJDhyX+udBne9+U2p2ZjHiWWS8fnNF76tqjSjTMr1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316476; c=relaxed/simple;
	bh=2CfFDQoRWfK2uYHNJ9NA24Ao6RfIz/ljtZnMD+0BKe0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=goDVmVC/f+hS2x0Yu5OhowDCezZcXT5urRNnk9xjCFKa+n6ZwpdmxBCUrsjPEWKJyXuh7rqkFd1nOR1i7e9Nigyj0eBvTeZdSQWBcgj2oNzJJEC1gKzLDKy0XcLoqUib9e4iS3b/2RO1BM9rO0DQUklS9XXqBe/VxiYJxQ8yC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg+u4d3R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45377776935so29722975e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316473; x=1751921273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XiXiWK+vAC7S4FXYKWmR6LRF5+SfRMBc7fwfu5Up0jU=;
        b=dg+u4d3RvGcZc7n8jTYp06B+TqBAnccN2An9aDQmpMkjH8u4DpVbqA9D2iQCmpu7e5
         5cAOHWBSigrubkiiENV4/buchjUZmbpJQwmYee41npreqf4A0sRtVt20ZpkscQZFvdkK
         Psbwlp5Enngg7IZgivqbY/c+pVtYqNJW5CQqmNP3oOPOflMB2QwtzZVrrIzLDbazht3u
         X4oKrAbEeeEOIRb4UQF4AAmSfGygPABKN/R2xSVE8iDFfK3cWeTHAfrGHL3jfBYp0mK7
         8togUH8oSYFveh3+lBoTRC7t2+EHbF80uTtdo3hNtoG9eDW0oU4uIIFqbm+f/Tzp4/FF
         fqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316473; x=1751921273;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiXiWK+vAC7S4FXYKWmR6LRF5+SfRMBc7fwfu5Up0jU=;
        b=gUVZ9RwKkvAOzMRa5Np0mObYPNoX9IJBBzKBpsdjxdoY2zie6CPTM1Dc77cCMYNE/T
         2gGaRPrDkUlrk9Zr/ZCrKpfblO9V51xhse4cDpXWoakoGlAHhJPPR9a3nw5DemFp0E1J
         94nH437j9i+WnFCynA1B75GOCSGHyApkahTsyU3yjkNdVacEaSf2SUjBXvN8tDV36Udy
         1KTMev28v6sXzLYu5wmAkYQPTDm/B0WhyQ9qTb+FKylUa4XJf9AkqOZ6p4VoafEB/KVV
         K4EY6Yu61QrNtW2eQXFpe1gFdzJnomV4I3ER558Gc446bQ/hdoBHhM2mzNv6BSgiVnwf
         0Sdg==
X-Gm-Message-State: AOJu0YyCC3hoSG9QaOa+xKHoX/VPx0k+uNgs7frRzupZ3PEKMn/yMNMU
	y4U8sdTlT12hVV83cZ2YDgm9XN27dP0CaAqG7xft1j7GDPTuIh/kKZD7E9pAWg==
X-Gm-Gg: ASbGncva0jGsBWjF3I9uvlRqghwR1/N/fgEi60iRdh+LZZJzEIdsSj8koBkucwiUA/s
	wiXHBw2S5HVhtkAEZWVsb98wgisSpJ4ZulRppgISfrP5KjafRPYLJlQVpyBTuxKyH5k5ssYpreY
	dUWa4G92r9P+AjNb0DKeI/QKlF2tX7Oun710kkpO93DvQOluGjtDMkafZvKrQqPXmNTPFTnkrGm
	eRq5xF+1MtLnB5sJCPu6gB1yGt0FbD7mSbNZNX3xAzgs1inBTkFU7NDFybjSGGgMSnRQJp2SnTG
	C+N7B6ibTSJ4x1LFwSP4ZfkF14TdDRKiwynEFm7cWge2EB/X/M9OSTXIYbaaRODwUJTV1Q==
X-Google-Smtp-Source: AGHT+IFOIsTDDOSyCt2oG2vvfIQSmQX36Pqp3LOXsdmLFqpsgrsIb/Ge3MErsKfgtSAZKpkUepcF0Q==
X-Received: by 2002:a05:600c:3b03:b0:453:5c30:a1d0 with SMTP id 5b1f17b1804b1-4538ee7da93mr147765075e9.21.1751316473289;
        Mon, 30 Jun 2025 13:47:53 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm179195155e9.28.2025.06.30.13.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:47:53 -0700 (PDT)
Message-ID: <4968a9d5-02c8-4d35-a5ad-b75ece8f5d36@gmail.com>
Date: Mon, 30 Jun 2025 23:47:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 14/14] wifi: rtw89: Enable the new USB modules
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
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

v4:
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


