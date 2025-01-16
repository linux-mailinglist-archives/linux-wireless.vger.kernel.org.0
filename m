Return-Path: <linux-wireless+bounces-17581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E23A132B6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 06:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA48188A959
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A216CD1D;
	Thu, 16 Jan 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TCd777rX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB489158524
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006250; cv=none; b=XkasDOxoeZCbR3xoEp5xYp06JwnBXnjEjCZBhm28Yzy/YOSUNQe1p0hyiin1D1DcCozBkGC2tSQaUVd4MM2p92CEPFggQD1d2nFvSFtVPxbDrhKdl9F44/4d12IzYFgeY26WH7y9RryR6KrS+oGvL1nyBuVcOhgpG2vGhG/sKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006250; c=relaxed/simple;
	bh=XukguOx/oyu56t3JNKSHHb9sdMm4kT0heU8RK+dE6Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/vw/9515If1CpkVVvJ2jRIbmWZVTzp8sBVp6ghcO48dl09njDss8jg6xXUUtEwLqCnlUO+zDXBYmk6ybI92PxXLP4IDPObVOzeGeZ1Hn8g6eJAJV1sCPytUUGgQ65VFQVWNYtiEqc5qqpvJch5cR2E/hMRXEgOITrOwL+/AycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TCd777rX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50G5ho7J3493101, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737006230; bh=XukguOx/oyu56t3JNKSHHb9sdMm4kT0heU8RK+dE6Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TCd777rXHgvyFUoN6LshVlhwPbDBv6fDbmE1PEAqatzM4QXbhT4kinSaAmWg5tGxJ
	 ZIht2n7jb+C6VHowUyiuS6ztoDFxU2ObeKjellShP+U87KzCesjyGu6qA3MMROsAEt
	 rJIp1cqNsCJJCVbnkKJhB/vCGkI8AvMDAA7KXdUvOnTFZUFdXvIWDhfH5nG292ZNqf
	 z1DnzNKTxbK8p/IHTad6Uj9f9pswnktN7ga3jITOrwdxXQMN00a2MaZpJ5qqfHrJkh
	 hE8ab+Uxg3e25TpBoi2CTPWQuMgj9QabsmT2MCnkGxnsbvPpLYKtdNbhCPavWJVnVC
	 EI1z3CztWqN0Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50G5ho7J3493101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:43:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 Jan 2025 13:43:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 16 Jan
 2025 13:43:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig
Date: Thu, 16 Jan 2025 13:43:37 +0800
Message-ID: <20250116054337.35723-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

When using allmodconfig, .config has CONFIG_LEDS_CLASS=m but
autoconf.h has CONFIG_LEDS_CLASS_MODULE (additional suffix _MODULE)
instead of CONFIG_LEDS_CLASS, which condition CONFIG_LEDS_CLASS in
rtw88/led.h can't work properly.

Add RTW88_LEDS to Kconfig, and use it as condition to fix this problem.

drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of 'rtw_led_init'
   19 | void rtw_led_init(struct rtw_dev *rtwdev)
      |      ^~~~~~~~~~~~
In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
   15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
      |                    ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of 'rtw_led_deinit'
   64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
      |      ^~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
   19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
      |                    ^~~~~~~~~~~~~~

Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 5 +++++
 drivers/net/wireless/realtek/rtw88/Makefile | 2 +-
 drivers/net/wireless/realtek/rtw88/led.h    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 733b3e58da51..5828162add6f 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -238,4 +238,9 @@ config RTW88_DEBUGFS
 
 	  If unsure, say Y to simplify debug problems
 
+config RTW88_LEDS
+	bool
+	depends on LEDS_CLASS
+	default y
+
 endif
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index e8bad9d099a4..0cbbb366e393 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -20,7 +20,7 @@ rtw88_core-y += main.o \
 
 rtw88_core-$(CONFIG_PM) += wow.o
 
-rtw88_core-$(CONFIG_LEDS_CLASS) += led.o
+rtw88_core-$(CONFIG_RTW88_LEDS) += led.o
 
 obj-$(CONFIG_RTW88_8822B)	+= rtw88_8822b.o
 rtw88_8822b-objs		:= rtw8822b.o rtw8822b_table.o
diff --git a/drivers/net/wireless/realtek/rtw88/led.h b/drivers/net/wireless/realtek/rtw88/led.h
index c3bb6fe49b49..fa64002b0215 100644
--- a/drivers/net/wireless/realtek/rtw88/led.h
+++ b/drivers/net/wireless/realtek/rtw88/led.h
@@ -5,7 +5,7 @@
 #ifndef __RTW_LED_H
 #define __RTW_LED_H
 
-#ifdef CONFIG_LEDS_CLASS
+#ifdef CONFIG_RTW88_LEDS
 
 void rtw_led_init(struct rtw_dev *rtwdev);
 void rtw_led_deinit(struct rtw_dev *rtwdev);
-- 
2.25.1


