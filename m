Return-Path: <linux-wireless+bounces-17600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21011A139B2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49362168EB2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF21D6DAA;
	Thu, 16 Jan 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Amky3+bA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B324A7C2
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029107; cv=none; b=AX6ZLz3Daj4xT+u7uwIEp7BdDU07XaWC7t3iiElo55uWESpgcDlLvloKXRNercLnO5uUV9BWHWjMp8NqYZtDtUReidOlwccIyxTk2td3D+1PWuq/v8KzqzWtqW6RUdtf4p4JHkNweT/fPLvQnPRHYsk9p0lFOj7q1j3C58Q63q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029107; c=relaxed/simple;
	bh=r6485evTJ6FWA1R8v31Drf6EiPl3Bfqb8qV6tWT/TA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9XJ22wh5/EVycdxeatkb+URmnihHVDQHv1JRegz+3Ta48Zw6LVqlNu8no/YozLffkzUskVwH1FWGbrhrfkPOZYIrrGBzj2PyIuePNcpjlNUIgVFWl3mR+qZ63h16xqHyRjUESzLvhjxElIN7sSTEoAY1L+FcZZTr84mskgZR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Amky3+bA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50GC4gsnE947726, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737029083; bh=r6485evTJ6FWA1R8v31Drf6EiPl3Bfqb8qV6tWT/TA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Amky3+bAINWypUZvdhbkisBooY51HbuFijHAQqa3q2aXm5xw3biBEbvZrqLJQoP+5
	 XVSXlLkBzJzilKuw3sIBorfuMM01wOc4gKjCpfpGTAEkMi1eNUzdw6TTpIK0HOZyih
	 uLbkdiFThO1YcuBD0/iZLlMukAs2YmG6HWrLCIdBjdGZoXnmSz6ggTbWVdLz7AAFYD
	 zXw6MiE47Gjd5hysdr+OOH2JZtl4VnTmNHWIXublia1ZE+pWoiqGWsQ936KS01rREg
	 a468KX3lcPEIwmJfbKsQ0GbZiTuPpAUrerMHTu2c5LyJnMuE2ixKRBHOcoW39cDlGJ
	 UGWoxzYNviclQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50GC4gsnE947726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:04:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 Jan 2025 20:04:43 +0800
Received: from [127.0.1.1] (172.16.16.153) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 16 Jan
 2025 20:04:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <sfr@canb.auug.org.au>
Subject: [PATCH v2] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig
Date: Thu, 16 Jan 2025 20:04:24 +0800
Message-ID: <20250116120424.13174-1-pkshih@realtek.com>
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

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-wireless/e19a87ad9cd54bfa9907f3a043b25d30@realtek.com/T/#me407832de1040ce22e53517bcb18e322ad0e2260
Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add Reported-by and Closes
  - use 'depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211'
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 5 +++++
 drivers/net/wireless/realtek/rtw88/Makefile | 2 +-
 drivers/net/wireless/realtek/rtw88/led.h    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 733b3e58da51..ab21b8059e0b 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -238,4 +238,9 @@ config RTW88_DEBUGFS
 
 	  If unsure, say Y to simplify debug problems
 
+config RTW88_LEDS
+	bool
+	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
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


