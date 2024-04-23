Return-Path: <linux-wireless+bounces-6719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360B98AE5B8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C4E1C21735
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3F84DE9;
	Tue, 23 Apr 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX99TQMM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D18405D
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874359; cv=none; b=WSC7Pgwe7Gxwc0hcofw/J3vCjx6p1Gc1DSbBPiAVat+vmkxfzCNajnqR7GKeNaVy09Cyrl281Ax1AmrsLHJnisCO6gBmhXlbGxbm3lwRtQwXIFaXPJfl6f0T7CYz0Pp5STPKiXdbCk64oBT3zHk4iwzJxe8vVJn72GU2NDJwd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874359; c=relaxed/simple;
	bh=0eXJ5AIjzz1TBGZ8SlshIPrEHZaZwZfYEdof+dSpu4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ug0FMWoZUZuytTCJwF4jxc8g5WsxjAvLMRpVxhcqIFNjXWZ4/bOoRejdChv0Mv5vLDy8yjJ2gjqNvmh96u++mO+m2AxjspI1ZLQGBEY6cBSvQQUnX9Hwnx5hLtPS8r9BOO8hDkyFYWC9rqPIMCSrrxCY6JbgGrLbWXCyw8EDoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qX99TQMM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso74926081fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713874356; x=1714479156; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vysJsMiH5IVqdTs4yMwZxZ7nUmt2aG7eBhkn8qm8hvI=;
        b=qX99TQMMdHbskFYUaw8c93sIJsUhKmj/WPdyahHcupUhwn5wol4aVoPczkOKYwJZhE
         eoInxzjAHIl3UNKyvPPrD4MrbLcSoFT6mTFMsgRQYUghsLattmGcqIebu9XT556dBhsf
         DydmpqGgnTOIa+IEknFxg24mo8Xn2LVmDC7LSGEYykUy1xLHd1NSq56YEaYXC7641xeZ
         9TOL0rZszeGld5cCS3013EmEeXQGCC3lAP83Eb48vbFXjPojkN0s40rZ2s8YpVsGT0iP
         LeLVtP/E8XJqi4YipKryKSgbgOvQ1Bclle5+s+2qcJQNnSEjekMwR59BIRs3OZH2SRfN
         gQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874356; x=1714479156;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vysJsMiH5IVqdTs4yMwZxZ7nUmt2aG7eBhkn8qm8hvI=;
        b=NjoEWyZNmIMWZsvnwvtjoOxAWmD/ZUKxlMNL3fEOL3bs9H26hbyaYZp65FEA0dwhVv
         679bzUthOIooGpSRMqwZGwxrnHlSvM6BxeecF2GlWwHMpJ8dHK69tvn0FHzxXA9mgTbp
         i+3cvDN98oKB3yp26Fgylp+W2KLFgDyRRzLWk/WLxz8psnwDizbEzEP7muQKh70W2r3U
         UMNbQajU39s+03etenmhODFrKqZwtuXoT9Moqf1GPuOAtx5Z1XYFU7fAGu/s7MM1h8aA
         T+SXDht5mGWGi0MLffX0RuImtAKEA0n7SNaljT3vIQlRb/5RlcvYwrxamk8/4yDhuTx6
         RoDw==
X-Gm-Message-State: AOJu0YxFL3mfN40WSgvvLiIeZO4VD1aETKgnPLJj6Y4JRqyowXrZ4nXI
	zRnHXoDqBrLg+oWCiGRTqzsa2BpkgOefAMEKjvKbiB9lO9vSiIy9jaOa0PJTgRs=
X-Google-Smtp-Source: AGHT+IHBRMGvaJM98f86Z6m/RfVhK2XejjNGF3EvcRq/4x3oGM0DKpd2PbeCJdgmzHjLPVVbdsNzJg==
X-Received: by 2002:a2e:9852:0:b0:2d8:a98d:18e with SMTP id e18-20020a2e9852000000b002d8a98d018emr7955886ljj.8.1713874355700;
        Tue, 23 Apr 2024 05:12:35 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e7c06000000b002da179d8d25sm1628982ljc.64.2024.04.23.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:12:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 14:12:33 +0200
Subject: [PATCH v2] wifi: ath9k: Obtain system GPIOS from descriptors
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
X-B4-Tracking: v=1; b=H4sIALClJ2YC/22Nyw6CMBBFf4XM2hpanrLyPwyL0o4wCaFkxqCG9
 N+txKXLc5Nz7g6CTCjQZTswbiQUlgTmlIGb7DKiIp8YTG7KXBujPIpjWh+BRT2JcUYRNbTeXir
 v7FBUkNSV8U6vI3vrE08kSXgfL5v+rr9gof8HN61yhdo1rvJ125T1dabFcjgHHqGPMX4Ao4iiN
 LkAAAA=
To: Kalle Valo <kvalo@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The ath9k has an odd use of system-wide GPIOs: if the chip
does not have internal GPIO capability, it will try to obtain a
GPIO line from the system GPIO controller:

  if (BIT(gpio) & ah->caps.gpio_mask)
        ath9k_hw_gpio_cfg_wmac(...);
  else if (AR_SREV_SOC(ah))
        ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);

Where ath9k_hw_gpio_cfg_soc() will attempt to issue
gpio_request_one() passing the local GPIO number of the controller
(0..31) to gpio_request_one().

This is somewhat peculiar and possibly even dangerous: there is
nowadays no guarantee of the numbering of these system-wide
GPIOs, and assuming that GPIO 0..31 as used by ath9k would
correspond to GPIOs 0..31 on the system as a whole seems a bit
wild.

Register all 32 GPIOs at index 0..31 directly in the ATH79K
GPIO driver and associate with WIFI if and only if we are probing
ATH79K wifi from the AHB bus (used for SoCs).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Define all the descriptors directly in the ATH79K
  GPIO driver in case the driver want to request them directly.
- Link to v1: https://lore.kernel.org/r/20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org
---
 drivers/gpio/gpio-ath79.c           | 47 ++++++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath9k/hw.c | 29 ++++++++++++-----------
 drivers/net/wireless/ath/ath9k/hw.h |  3 ++-
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index f0c0c0f77eb0..f83ce0595ea8 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h> /* For WLAN GPIOs */
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-ath79.h>
 #include <linux/of.h>
@@ -222,6 +223,46 @@ static const struct of_device_id ath79_gpio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ath79_gpio_of_match);
 
+#if IS_ENABLED(CONFIG_ATH9K_AHB)
+/*
+ * This registers all of the ath79k GPIOs as descriptors to be picked
+ * directly from the ATH79K wifi driver if the two are jitted together
+ * in the same SoC.
+ */
+#define ATH79K_WIFI_DESCS 32
+static int ath79_gpio_register_wifi_descriptors(struct device *dev,
+						const char *label)
+{
+	struct gpiod_lookup_table *lookup;
+	int i;
+
+	/* Create a gpiod lookup using gpiochip-local offsets + 1 for NULL */
+        lookup = devm_kzalloc(dev,
+			      struct_size(lookup, table, ATH79K_WIFI_DESCS + 1),
+			      GFP_KERNEL);
+
+	if (!lookup)
+		return -ENOMEM;
+
+	lookup->dev_id = "ath9k";
+
+	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
+		lookup->table[i] = (struct gpiod_lookup)
+			GPIO_LOOKUP_IDX(label, 0, NULL, i,
+					GPIO_ACTIVE_HIGH);
+	}
+
+	gpiod_add_lookup_table(lookup);
+
+	return 0;
+}
+#else
+static int ath79_gpio_register_wifi_descriptors(struct device *dev,
+						const char *label)
+{
+}
+#endif
+
 static int ath79_gpio_probe(struct platform_device *pdev)
 {
 	struct ath79_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -291,7 +332,11 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 		girq->handler = handle_simple_irq;
 	}
 
-	return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
+	err = devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
+	if (err)
+		return err;
+
+	return ath79_gpio_register_wifi_descriptors(dev, ctrl->gc.label);
 }
 
 static struct platform_driver ath79_gpio_driver = {
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5982e0db45f9..ee6705836746 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -20,7 +20,7 @@
 #include <linux/time.h>
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <asm/unaligned.h>
 
 #include "hw.h"
@@ -2727,19 +2727,25 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
 static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
 				  const char *label)
 {
+	enum gpiod_flags flags = out ? GPIOD_OUT_LOW : GPIOD_IN;
+	struct gpio_desc *gpiod;
 	int err;
 
-	if (ah->caps.gpio_requested & BIT(gpio))
+	if (ah->gpiods[gpio])
 		return;
 
-	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
-	if (err) {
+	/* Obtains a system specific GPIO descriptor from another GPIO controller */
+	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);
+
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
 		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
 			gpio, err);
 		return;
 	}
 
-	ah->caps.gpio_requested |= BIT(gpio);
+	gpiod_set_consumer_name(gpiod, label);
+	ah->gpiods[gpio] = gpiod;
 }
 
 static void ath9k_hw_gpio_cfg_wmac(struct ath_hw *ah, u32 gpio, bool out,
@@ -2800,11 +2806,6 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
 		return;
 
 	WARN_ON(gpio >= ah->caps.num_gpio_pins);
-
-	if (ah->caps.gpio_requested & BIT(gpio)) {
-		gpio_free(gpio);
-		ah->caps.gpio_requested &= ~BIT(gpio);
-	}
 }
 EXPORT_SYMBOL(ath9k_hw_gpio_free);
 
@@ -2832,8 +2833,8 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
 			val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
 		else
 			val = MS_REG_READ(AR, gpio);
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		val = gpio_get_value(gpio) & BIT(gpio);
+	} else if (ah->gpiods[gpio]) {
+		val = gpiod_get_value(ah->gpiods[gpio]);
 	} else {
 		WARN_ON(1);
 	}
@@ -2856,8 +2857,8 @@ void ath9k_hw_set_gpio(struct ath_hw *ah, u32 gpio, u32 val)
 			AR7010_GPIO_OUT : AR_GPIO_IN_OUT(ah);
 
 		REG_RMW(ah, out_addr, val << gpio, BIT(gpio));
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		gpio_set_value(gpio, val);
+	} else if (ah->gpiods[gpio]) {
+		gpiod_set_value(ah->gpiods[gpio], val);
 	} else {
 		WARN_ON(1);
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 450ab19b1d4e..1eb4ff8955ae 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -19,6 +19,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/firmware.h>
 
@@ -302,7 +303,6 @@ struct ath9k_hw_capabilities {
 	u8 max_rxchains;
 	u8 num_gpio_pins;
 	u32 gpio_mask;
-	u32 gpio_requested;
 	u8 rx_hp_qdepth;
 	u8 rx_lp_qdepth;
 	u8 rx_status_len;
@@ -783,6 +783,7 @@ struct ath_hw {
 	struct ath9k_hw_capabilities caps;
 	struct ath9k_channel channels[ATH9K_NUM_CHANNELS];
 	struct ath9k_channel *curchan;
+	struct gpio_desc *gpiods[32];
 
 	union {
 		struct ar5416_eeprom_def def;

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240122-descriptors-wireless-b8da95dcab35

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


