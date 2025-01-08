Return-Path: <linux-wireless+bounces-17193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49BCA05A37
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23723A24BE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3E1F942E;
	Wed,  8 Jan 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDx1Fbp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05041F8AE3
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336491; cv=none; b=pB2rl5sRHI+bXi6XDH0EKUjaUCPCf619cBMXP2+SbN1P//KFiZocI3XzfSWzbB4rB0liyewcNi8U9VXIXctrgPEFFoA0VIJdV/Z+SHv6ioKIEZNYQ7IsF0hBRZjkqaVf+SmfVKaB0aXvLLmEjEjBlKhHMjMzhdYLReJXL4oVP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336491; c=relaxed/simple;
	bh=gZf44EJ2hzslnOjnucrM0WTDe+HfBwKBsgIgkSHFN5M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=efeGeLpBuqP7tSGnacCF6Jl84g+4WKfMIXffDh7ZT6mCYqbYiZX+CUwggO0vFIYJC+DdZ9OZGN5x2r1CaBMbka5osJ5g2ie1gTUCEiQnhtzIQ+Q0VghBsSFZP92oQmpWqqidUuOaGBI+IX4rvOzL7wqCfSonmijPXRZOCfsaBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDx1Fbp/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so2770521166b.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 03:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736336487; x=1736941287; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI5mgZLF1XH9oEyOXldJAUWfeDgfC9YQtlWgG+HjYEU=;
        b=IDx1Fbp/nbaoDt8kVETUeyBYrvBT/F5jIR+KJG2IG8Q4gpFlLJ/Krx1F9+oaQuCzDJ
         YvFc5Q1mj8onCqzIyXLbxnQB1YdTbfoEfoHeax/2gQd+udXBC/csh5LRltYIQ6nvWcit
         33ke0k1668ErfX/V7pmyZTslmm4wLjxN1Boc9bUQBVhhu6lkiE/SlNl2HrLhXlkRuPp9
         E6TZFGu8nMUoN+47G74xAgnYl1c7sXxe4FWbY9HLTinGzaPGMIQHolJwh6eXhaKR0loe
         IJ+t23YF8dhzFETGFoR1K+8cLGO2WX0C2L7lH3z357iCqcYtzj4KUZdk+8AAuYGRXu+w
         u6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336487; x=1736941287;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WI5mgZLF1XH9oEyOXldJAUWfeDgfC9YQtlWgG+HjYEU=;
        b=BljPVlkqW1jKQNR9p1IgmBq9ROj7reo52V5iaEy9GscDO0ThTapYRhU9Y+W1cpoYTO
         PVd3jHwz/hbw0bYnjsuHn8NbCCbqrcJifXRIhzAnLS+CuK919BxFFTMoasLo4efKLYfD
         uhzY43EMX/rTZ6CsdUW1sLpVXCMFwKq9mtwHmTXtnF5ZybndstMkU57WdgwSeQ5/ean2
         HUuDRgg681QDoO3xA/st+8KV88q9pyArTa2ARuX1g1kdqNV8WznUgWEuYbMQyoqyCZLd
         Ng55U7gvsFEkXDtRz7A1zJIemJ9P6npv2GTmIKTgluOWE8NQNpvbXVqvVuMkR7ixdZes
         8yUA==
X-Gm-Message-State: AOJu0YxKHR6uwFfbseZO/1i0VR2a0pgx69lRJciig9OaxEOZiqEjNR0T
	jDHLy44O1SuKy2C+GLUexCBaC/61g0QWjAbugVdJGICLyNnkEzytvDGIaQ==
X-Gm-Gg: ASbGncvn1D73urIm9keLsAH92MBxIl5CAwD1pMXq8RPD6KZHnvY7P/fTeAI1u9qbceR
	cp8rM1jvSmKVTxYo0/OJxlhnfanOKZ0SLlA1FZS9znsJ1ELya5FMIto9pKzQviO8XLmPTzwtYK8
	kcQfXH5xVpHQj0jrnSfCT4bS0i0BwvIUAKSPyrxX7ki7WAfC0Fq0lKlCAYAbQaVw6U53sQYtYGh
	YYVu69Njb38SAkzksQfRYlpIHszsTgLQG0XqUJOy1kDI08BgPs1EcyPit1kY0UP
X-Google-Smtp-Source: AGHT+IFvR2hAR48l9Qtv9Dm4R3jIMdHHvUI8AjS2G3QIP9f7peKDc3H0hCh++wkKqjpyP+Jy3D6wCQ==
X-Received: by 2002:a17:907:60cb:b0:aa9:1b4b:489e with SMTP id a640c23a62f3a-ab2ab70bc75mr178173666b.24.1736336486806;
        Wed, 08 Jan 2025 03:41:26 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894f2esm2518311666b.69.2025.01.08.03.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:41:26 -0800 (PST)
Message-ID: <6c43451f-ab2f-4e76-ac6e-ff5a18dd981d@gmail.com>
Date: Wed, 8 Jan 2025 13:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtw88: Add support for LED blinking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Register a struct led_classdev with the kernel's LED subsystem and
create a throughput-based trigger for it. Then mac80211 makes the LED
blink.

Tested with Tenda U12 (RTL8812AU), Tenda U9 (RTL8811CU), TP-Link Archer
T2U Nano (RTL8811AU), TP-Link Archer T3U Plus (RTL8812BU), Edimax
EW-7611UCB (RTL8821AU), LM842 (RTL8822CU).

Also tested with devices which don't have LEDs: the laptop's internal
RTL8822CE and a no-name RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
- Move LED (de)init to a new file led.c
- Use #ifdef CONFIF_LEDS_CLASS only in the new file led.h

v3:
- Make the empty functions inline.
- Use brightness_set_blocking for SDIO as well, because a user reported
  errors:

Jan 06 12:01:17 X96 kernel: Voluntary context switch within RCU
read-side critical section!
...
Jan 06 12:01:17 X96 kernel: Call trace:
Jan 06 12:01:17 X96 kernel:  rcu_note_context_switch+0x404/0x4c4
Jan 06 12:01:17 X96 kernel:  __schedule+0xa0/0xadc
Jan 06 12:01:17 X96 kernel:  schedule+0x34/0x134
Jan 06 12:01:17 X96 kernel:  schedule_timeout+0x174/0x184
Jan 06 12:01:17 X96 kernel:  wait_for_completion+0x74/0x158
Jan 06 12:01:17 X96 kernel:  mmc_wait_for_req_done+0x2c/0xf8
Jan 06 12:01:17 X96 kernel:  mmc_wait_for_req+0xb0/0x100
Jan 06 12:01:17 X96 kernel:  mmc_io_rw_extended+0x1d0/0x2c0
Jan 06 12:01:17 X96 kernel:  sdio_io_rw_ext_helper+0x190/0x234
Jan 06 12:01:17 X96 kernel:  sdio_readl+0x30/0x5c
Jan 06 12:01:17 X96 kernel:  rtw_sdio_readl+0xbc/0xd4 [rtw_sdio]
Jan 06 12:01:17 X96 kernel:  rtw_sdio_read32+0xb8/0x204 [rtw_sdio]
Jan 06 12:01:17 X96 kernel:  rtw8822c_led_set+0x34/0x78 [rtw_8822c]
---
 drivers/net/wireless/realtek/rtw88/Makefile   |  2 +
 drivers/net/wireless/realtek/rtw88/led.c      | 73 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/led.h      | 25 +++++++
 drivers/net/wireless/realtek/rtw88/main.c     | 12 ++-
 drivers/net/wireless/realtek/rtw88/main.h     |  5 ++
 drivers/net/wireless/realtek/rtw88/reg.h      | 12 +++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 17 +++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 26 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 19 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 19 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 19 +++++
 11 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index f0b49f5a8a5a..e8bad9d099a4 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -20,6 +20,8 @@ rtw88_core-y += main.o \
 
 rtw88_core-$(CONFIG_PM) += wow.o
 
+rtw88_core-$(CONFIG_LEDS_CLASS) += led.o
+
 obj-$(CONFIG_RTW88_8822B)	+= rtw88_8822b.o
 rtw88_8822b-objs		:= rtw8822b.o rtw8822b_table.o
 
diff --git a/drivers/net/wireless/realtek/rtw88/led.c b/drivers/net/wireless/realtek/rtw88/led.c
new file mode 100644
index 000000000000..25aa6cbaa728
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/led.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include "main.h"
+#include "debug.h"
+#include "led.h"
+
+static int rtw_led_set_blocking(struct led_classdev *led,
+				enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+
+	rtwdev->chip->ops->led_set(led, brightness);
+
+	return 0;
+}
+
+void rtw_led_init(struct rtw_dev *rtwdev)
+{
+	static const struct ieee80211_tpt_blink rtw_tpt_blink[] = {
+		{ .throughput = 0 * 1024, .blink_time = 334 },
+		{ .throughput = 1 * 1024, .blink_time = 260 },
+		{ .throughput = 5 * 1024, .blink_time = 220 },
+		{ .throughput = 10 * 1024, .blink_time = 190 },
+		{ .throughput = 20 * 1024, .blink_time = 170 },
+		{ .throughput = 50 * 1024, .blink_time = 150 },
+		{ .throughput = 70 * 1024, .blink_time = 130 },
+		{ .throughput = 100 * 1024, .blink_time = 110 },
+		{ .throughput = 200 * 1024, .blink_time = 80 },
+		{ .throughput = 300 * 1024, .blink_time = 50 },
+	};
+	struct led_classdev *led = &rtwdev->led_cdev;
+	int err;
+
+	if (!rtwdev->chip->ops->led_set)
+		return;
+
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
+		led->brightness_set = rtwdev->chip->ops->led_set;
+	else
+		led->brightness_set_blocking = rtw_led_set_blocking;
+
+	snprintf(rtwdev->led_name, sizeof(rtwdev->led_name),
+		 "rtw88-%s", dev_name(rtwdev->dev));
+
+	led->name = rtwdev->led_name;
+	led->max_brightness = LED_ON;
+	led->default_trigger =
+		ieee80211_create_tpt_led_trigger(rtwdev->hw,
+						 IEEE80211_TPT_LEDTRIG_FL_RADIO,
+						 rtw_tpt_blink,
+						 ARRAY_SIZE(rtw_tpt_blink));
+
+	err = led_classdev_register(rtwdev->dev, led);
+	if (err) {
+		rtw_warn(rtwdev, "Failed to register the LED, error %d\n", err);
+		return;
+	}
+
+	rtwdev->led_registered = true;
+}
+
+void rtw_led_deinit(struct rtw_dev *rtwdev)
+{
+	struct led_classdev *led = &rtwdev->led_cdev;
+
+	if (!rtwdev->led_registered)
+		return;
+
+	rtwdev->chip->ops->led_set(led, LED_OFF);
+	led_classdev_unregister(led);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/led.h b/drivers/net/wireless/realtek/rtw88/led.h
new file mode 100644
index 000000000000..c3bb6fe49b49
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/led.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#ifndef __RTW_LED_H
+#define __RTW_LED_H
+
+#ifdef CONFIG_LEDS_CLASS
+
+void rtw_led_init(struct rtw_dev *rtwdev);
+void rtw_led_deinit(struct rtw_dev *rtwdev);
+
+#else
+
+static inline void rtw_led_init(struct rtw_dev *rtwdev)
+{
+}
+
+static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
+{
+}
+
+#endif
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6993f93c8f06..0cee0fd8c0ef 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -19,6 +19,7 @@
 #include "bf.h"
 #include "sar.h"
 #include "sdio.h"
+#include "led.h"
 
 bool rtw_disable_lps_deep_mode;
 EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
@@ -2292,16 +2293,18 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 		return ret;
 	}
 
+	rtw_led_init(rtwdev);
+
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		rtw_err(rtwdev, "failed to register hw\n");
-		return ret;
+		goto led_deinit;
 	}
 
 	ret = rtw_regd_hint(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to hint regd\n");
-		return ret;
+		goto led_deinit;
 	}
 
 	rtw_debugfs_init(rtwdev);
@@ -2310,6 +2313,10 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	rtwdev->bf_info.bfer_su_cnt = 0;
 
 	return 0;
+
+led_deinit:
+	rtw_led_deinit(rtwdev);
+	return ret;
 }
 EXPORT_SYMBOL(rtw_register_hw);
 
@@ -2320,6 +2327,7 @@ void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_unregister_hw(hw);
 	rtw_unset_supported_band(hw, chip);
 	rtw_debugfs_deinit(rtwdev);
+	rtw_led_deinit(rtwdev);
 }
 EXPORT_SYMBOL(rtw_unregister_hw);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6ba9e0dcf9fd..62cd4c526301 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -887,6 +887,7 @@ struct rtw_chip_ops {
 			       bool is_tx2_path);
 	void (*config_txrx_mode)(struct rtw_dev *rtwdev, u8 tx_path,
 				 u8 rx_path, bool is_tx2_path);
+	void (*led_set)(struct led_classdev *led, enum led_brightness brightness);
 	/* for USB/SDIO only */
 	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
 				     struct rtw_tx_pkt_info *pkt_info,
@@ -2097,6 +2098,10 @@ struct rtw_dev {
 	struct completion fw_scan_density;
 	bool ap_active;
 
+	bool led_registered;
+	char led_name[32];
+	struct led_classdev led_cdev;
+
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 95a39ae74cd3..e438405fba56 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -78,7 +78,19 @@
 #define BIT_PAPE_SEL_EN		BIT(25)
 #define BIT_DPDT_WL_SEL		BIT(24)
 #define BIT_DPDT_SEL_EN		BIT(23)
+#define BIT_GPIO13_14_WL_CTRL_EN	BIT(22)
+#define BIT_LED2_SV		BIT(19)
+#define BIT_LED2_CM		GENMASK(18, 16)
+#define BIT_LED1_SV		BIT(11)
+#define BIT_LED1_CM		GENMASK(10, 8)
+#define BIT_LED0_SV		BIT(3)
+#define BIT_LED0_CM		GENMASK(2, 0)
+#define BIT_LED_MODE_SW_CTRL	0
+#define BIT_LED_MODE_RX		6
+#define BIT_LED_MODE_TX		4
+#define BIT_LED_MODE_TRX	2
 #define REG_LEDCFG2		0x004E
+#define REG_GPIO_PIN_CTRL_2	0x0060
 #define REG_PAD_CTRL1		0x0064
 #define BIT_BT_BTG_SEL		BIT(31)
 #define BIT_PAPE_WLBT_SEL	BIT(29)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index 21795286a1a0..f9ba2aa2928a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -868,6 +868,22 @@ static void rtw8812a_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+static void rtw8812a_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u8 ledcfg;
+
+	ledcfg = rtw_read8(rtwdev, REG_LED_CFG);
+	ledcfg &= BIT(6) | BIT(4);
+	ledcfg |= BIT(5);
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT(3);
+
+	rtw_write8(rtwdev, REG_LED_CFG, ledcfg);
+}
+
 static void rtw8812a_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -916,6 +932,7 @@ static const struct rtw_chip_ops rtw8812a_ops = {
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
+	.led_set		= rtw8812a_led_set,
 	.fill_txdesc_checksum	= rtw8812a_fill_txdesc_checksum,
 	.coex_set_init		= rtw8812a_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index dafab2af33bc..f68239b07319 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -706,6 +706,31 @@ static void rtw8821a_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+static void rtw8821a_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 gpio8_cfg;
+	u8 ledcfg;
+
+	if (brightness == LED_OFF) {
+		gpio8_cfg = rtw_read32(rtwdev, REG_GPIO_PIN_CTRL_2);
+		gpio8_cfg &= ~BIT(24);
+		gpio8_cfg |= BIT(16) | BIT(8);
+		rtw_write32(rtwdev, REG_GPIO_PIN_CTRL_2, gpio8_cfg);
+	} else {
+		ledcfg = rtw_read8(rtwdev, REG_LED_CFG + 2);
+		gpio8_cfg = rtw_read32(rtwdev, REG_GPIO_PIN_CTRL_2);
+
+		ledcfg &= BIT(7) | BIT(6);
+		rtw_write8(rtwdev, REG_LED_CFG + 2, ledcfg);
+
+		gpio8_cfg &= ~(BIT(24) | BIT(8));
+		gpio8_cfg |= BIT(16);
+		rtw_write32(rtwdev, REG_GPIO_PIN_CTRL_2, gpio8_cfg);
+	}
+}
+
 static void rtw8821a_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -853,6 +878,7 @@ static const struct rtw_chip_ops rtw8821a_ops = {
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
+	.led_set		= rtw8821a_led_set,
 	.fill_txdesc_checksum	= rtw8821a_fill_txdesc_checksum,
 	.coex_set_init		= rtw8821a_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8821a_coex_cfg_ant_switch,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 0270225b9c20..eb7e34c545d0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1206,6 +1206,24 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 			 dm_info->cck_pd_default + new_lvl * 2);
 }
 
+static void rtw8821c_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
 static void rtw8821c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -1655,6 +1673,7 @@ static const struct rtw_chip_ops rtw8821c_ops = {
 	.config_bfee		= rtw8821c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.led_set		= rtw8821c_led_set,
 	.fill_txdesc_checksum	= rtw8821c_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8821c_coex_cfg_init,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 739809f4cab5..7f03903ddf4b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1566,6 +1566,24 @@ static void rtw8822b_adaptivity(struct rtw_dev *rtwdev)
 	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
 }
 
+static void rtw8822b_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
 static void rtw8822b_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -2146,6 +2164,7 @@ static const struct rtw_chip_ops rtw8822b_ops = {
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 	.adaptivity_init	= rtw8822b_adaptivity_init,
 	.adaptivity		= rtw8822b_adaptivity,
+	.led_set		= rtw8822b_led_set,
 	.fill_txdesc_checksum	= rtw8822b_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index af6b76937f1d..ec362a817f5f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4537,6 +4537,24 @@ static void rtw8822c_adaptivity(struct rtw_dev *rtwdev)
 	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
 }
 
+static void rtw8822c_led_set(struct led_classdev *led,
+			     enum led_brightness brightness)
+{
+	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
+	u32 ledcfg;
+
+	ledcfg = rtw_read32(rtwdev, REG_LED_CFG);
+	u32p_replace_bits(&ledcfg, BIT_LED_MODE_SW_CTRL, BIT_LED2_CM);
+	ledcfg &= ~BIT_GPIO13_14_WL_CTRL_EN;
+
+	if (brightness == LED_OFF)
+		ledcfg |= BIT_LED2_SV;
+	else
+		ledcfg &= ~BIT_LED2_SV;
+
+	rtw_write32(rtwdev, REG_LED_CFG, ledcfg);
+}
+
 static void rtw8822c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 					  struct rtw_tx_pkt_info *pkt_info,
 					  u8 *txdesc)
@@ -4964,6 +4982,7 @@ static const struct rtw_chip_ops rtw8822c_ops = {
 	.cfo_track		= rtw8822c_cfo_track,
 	.config_tx_path		= rtw8822c_config_tx_path,
 	.config_txrx_mode	= rtw8822c_config_trx_mode,
+	.led_set		= rtw8822c_led_set,
 	.fill_txdesc_checksum	= rtw8822c_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
-- 
2.47.1


