Return-Path: <linux-wireless+bounces-1357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4378208B2
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Dec 2023 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A741F2147C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Dec 2023 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E53D2FF;
	Sat, 30 Dec 2023 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNCwYjeJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E3D30B
	for <linux-wireless@vger.kernel.org>; Sat, 30 Dec 2023 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33678156e27so7236910f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 30 Dec 2023 14:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703976357; x=1704581157; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3uWNZKv2NjPkr80eo02lK+LDeO6tD8duM2QRgGpEp0=;
        b=mNCwYjeJwV/teSaxOePRKs8qh1nrWkc6n0fdg0/1dzAqDS2ZYtlkzVy4m+oPKVSUyM
         ojc2L4q2FMqBQz35VatvAa1/rGb8Sh388XGyOP4Ndi3fODaWEUE2Gh+XWSSgMgB+zuMj
         ynVKS2mCesJIZ+ojJTU7dG8YFogOYn9vTe4beVzuDDNULOsFMIVanZ8v8+Jzg1UuyGf7
         GjSFkReiPEtrItPMbtwok22hFOpWOAO/yNFy2M8tL8Wh+krEeYdIo5WTmNvWYa614bK+
         OT9vO2tjsO52wNi4nq2+XDwYbQgUzsDMmhbCALZX/QFhgSawKfYo/X5OLgvul5FXVo1z
         QFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703976357; x=1704581157;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d3uWNZKv2NjPkr80eo02lK+LDeO6tD8duM2QRgGpEp0=;
        b=RrzAm1nM470J3J1DOJ3ytI/j0XYOyuIIWz9TskS22mthj/sE8kaXyeoETBlKUnKVYN
         /Z8C9Ewca6RaKJW09oBYeYxf/QJ+8T+x170iV4nNZa78WjVx4S+/tb3eO9fGHa29rIRN
         MmomMYRbqsCYuWQKfceUJGq+swMDQbfd4KkZXm4KmymXYDfHFH0wuNkSJuWjGVywc7bz
         TgccJRb84F180ecEdLndew9Qpw8+XMMlEuJz2sr/GprBwTBePrKOTHn+CoRjbUxOqtac
         ork9WHTS0HmcsijQc3/kJuHV9gLV3hEEJXC3ATm4e5mI5HXi2UPn1xJ7vnY4juIc5n9H
         S4sQ==
X-Gm-Message-State: AOJu0YzLmNqsIUWI77nI9kx9mWhkOUZkMG2gM9RqvtcFLE3//rOWb44C
	clKW3hdv1x2hZuyBXhxjjmIOh17ZZ1M=
X-Google-Smtp-Source: AGHT+IHx8UzHaWXPLNzLFbuA5e4nZyJN0Pek8r/TEJR18DmRc8e0hI0vivclbYcIhZ3uswc80tJL1w==
X-Received: by 2002:a05:600c:b93:b0:40d:8682:9640 with SMTP id fl19-20020a05600c0b9300b0040d86829640mr133435wmb.84.1703976357008;
        Sat, 30 Dec 2023 14:45:57 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id hg10-20020a05600c538a00b0040d7c3d5454sm6154127wmb.3.2023.12.30.14.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 14:45:56 -0800 (PST)
Message-ID: <7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com>
Date: Sun, 31 Dec 2023 00:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Zenm Chen <zenmchen@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtl8xxxu: Fix LED control code of RTL8192FU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some devices, like the Comfast CF-826F, use LED1, which already works.
Others, like Asus USB-N13 C1, use LED0, which doesn't work correctly.

Write the right values to the LED control registers to make LED0 work
as well.

This is unfortunately tested only with the Comfast CF-826F.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Use more bit definitions.
 - Use u32p_replace_bits to touch only the relevant bits.
 - New author.

v2:
 - Explain why to fix the issue in this way in the commit message.
 - Split a long statement into short ones.
 - Use some of the definitions suggested by Ping-Ke Shih.

Linking v2 and v1 because it's been a while:
https://lore.kernel.org/linux-wireless/20230912112709.22456-1-zenmchen@gmail.com/
https://lore.kernel.org/linux-wireless/20230910002038.56362-1-zenmchen@gmail.com/
---
 .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 32 +++++++++++++------
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h | 15 +++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 28e93835e05a..585b1a5eed69 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -2014,26 +2014,40 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
 	struct rtl8xxxu_priv *priv = container_of(led_cdev,
 						  struct rtl8xxxu_priv,
 						  led_cdev);
-	u16 ledcfg;
+	u32 ledcfg;
 
 	/* Values obtained by observing the USB traffic from the Windows driver. */
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
 
-	ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
+	ledcfg = rtl8xxxu_read32(priv, REG_LEDCFG0);
+
+	/* Comfast CF-826F uses LED1. Asus USB-N13 C1 uses LED0. Set both. */
+
+	u32p_replace_bits(&ledcfg, LED_GPIO_ENABLE, LEDCFG0_LED2EN);
+	u32p_replace_bits(&ledcfg, LED_IO_MODE_OUTPUT, LEDCFG0_LED0_IO_MODE);
+	u32p_replace_bits(&ledcfg, LED_IO_MODE_OUTPUT, LEDCFG0_LED1_IO_MODE);
 
 	if (brightness == LED_OFF) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7);
+		u32p_replace_bits(&ledcfg, LED_MODE_SW_CTRL, LEDCFG0_LED0CM);
+		u32p_replace_bits(&ledcfg, LED_SW_OFF, LEDCFG0_LED0SV);
+		u32p_replace_bits(&ledcfg, LED_MODE_SW_CTRL, LEDCFG0_LED1CM);
+		u32p_replace_bits(&ledcfg, LED_SW_OFF, LEDCFG0_LED1SV);
 	} else if (brightness == LED_ON) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7) | BIT(11);
+		u32p_replace_bits(&ledcfg, LED_MODE_SW_CTRL, LEDCFG0_LED0CM);
+		u32p_replace_bits(&ledcfg, LED_SW_ON, LEDCFG0_LED0SV);
+		u32p_replace_bits(&ledcfg, LED_MODE_SW_CTRL, LEDCFG0_LED1CM);
+		u32p_replace_bits(&ledcfg, LED_SW_ON, LEDCFG0_LED1SV);
 	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
-		/* Value obtained by brute force. */
-		ledcfg = BIT(8) | BIT(9);
+		u32p_replace_bits(&ledcfg, LED_MODE_TX_OR_RX_EVENTS,
+				  LEDCFG0_LED0CM);
+		u32p_replace_bits(&ledcfg, LED_SW_OFF, LEDCFG0_LED0SV);
+		u32p_replace_bits(&ledcfg, LED_MODE_TX_OR_RX_EVENTS,
+				  LEDCFG0_LED1CM);
+		u32p_replace_bits(&ledcfg, LED_SW_OFF, LEDCFG0_LED1SV);
 	}
 
-	rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
+	rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 920ee50e2115..61c0c0ec07b3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -146,6 +146,21 @@
 #define  GPIO_INTM_EDGE_TRIG_IRQ	BIT(9)
 
 #define REG_LEDCFG0			0x004c
+#define  LEDCFG0_LED0CM			GENMASK(2, 0)
+#define  LEDCFG0_LED1CM			GENMASK(10, 8)
+#define   LED_MODE_SW_CTRL		0x0
+#define   LED_MODE_TX_OR_RX_EVENTS	0x3
+#define  LEDCFG0_LED0SV			BIT(3)
+#define  LEDCFG0_LED1SV			BIT(11)
+#define   LED_SW_OFF			0x0
+#define   LED_SW_ON			0x1
+#define  LEDCFG0_LED0_IO_MODE		BIT(7)
+#define  LEDCFG0_LED1_IO_MODE		BIT(15)
+#define   LED_IO_MODE_OUTPUT		0x0
+#define   LED_IO_MODE_INPUT		0x1
+#define  LEDCFG0_LED2EN			BIT(21)
+#define   LED_GPIO_DISABLE		0x0
+#define   LED_GPIO_ENABLE		0x1
 #define  LEDCFG0_DPDT_SELECT		BIT(23)
 #define REG_LEDCFG1			0x004d
 #define  LEDCFG1_HW_LED_CONTROL		BIT(1)
-- 
2.43.0

