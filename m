Return-Path: <linux-wireless+bounces-2917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53684844B1A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A21F28F54
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC13A28B;
	Wed, 31 Jan 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjIJsYT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55A3A1DF
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740650; cv=none; b=Ic5pXMMEBEaHscuJEEGMsnMo5CofbSpbsRjTtiOaLfjNyYB79LN2vtgEhUX1iRxGgZIWRkMADQ2qaspa2KUzpcilEpGQCRlcU/yqiUyGI8y8Q4fziBYGrWtwIYiZCQDYfKyx4miqUJ6sDxBfCOhrT7+7dVPfYQcGmYsvZJWsujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740650; c=relaxed/simple;
	bh=xEeZnTStjXW+P4mPZi6D/2+tjnokrcA0eBD1CbKd8MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7HfEiV12Yk7ayVaDKQHJ9sFbYrsoRIfngtHkBN7kFIi8F28Cw2PqXOK1PJ+T7xnRApdUyT9VNZbRI48r31aiTI5WcvD1HJSnZGo1y+oPxsQKVx1WPdG8c3ZjDH1xuTQecTozMQSRTXVGFh9ZC8VK9roTTXHxXZ/RD+Gp/MMhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjIJsYT8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso387091e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740646; x=1707345446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtLJJ49D/VVSAFpOTc5rh0hgC/Wh9sQ3F5R/ApzLoDU=;
        b=mjIJsYT8Wf2NqPUJZ7aMZ+dzziwm45gx1GKrbIPR6JkzFZ9sYbJiYicYdb7xWyriHJ
         ZBKgtfIyebqgKFV0AhVPiQND9QtVKV1/jKTyjONxhshy1YgfF1gRRw7Fra/lKbjDUETB
         TrnohDpZBDrQ+/1oIv2mYUV6HrHV88Pdw2YCXUA0bsy/KlDwFQ17CThYxnZWm7Ah3Y87
         rd6fm3HzyeiVDnHPsBrd+a1ciDog5b6g473U87rTNRgLKzyHbptVneInR+/nXcOMUjbV
         YG2DpKBbau1anIJ3jwD6ZLb1daAt4NvAMUuMV1Hdv+xec2FIpd2xbERqHoxwnSeRWip+
         qQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740646; x=1707345446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtLJJ49D/VVSAFpOTc5rh0hgC/Wh9sQ3F5R/ApzLoDU=;
        b=wcOul7LGYrsbTkT647wju4Cfl/vJHtnzTy5SX4j8ZaJ156+/OxI7KBURvZjT+rwrGs
         r8MJQvdtqq+XToWffvJ2LU62NP/fiGUtzQuS99U0eKycI8MB3WoV6S5PcSadmBJr0Kst
         1S5xBIldv0d9rRQYPc96zr5k8p75SHBAObShNYhInT7PS/QSfV0la1E3Vn5JyGgNxBxl
         MQrIZu8RkBqoSeTgBAKu0/97mfe2p4huG+EDWlIMvEzPZa4FjFbK5JX27tTTtXbnr4nM
         VVhHs4hOadKlEteNYkNIKUor+bMhmtjU3VmqgesXOsWuqYkyn8rGia9Czuzjasx8JbXe
         7sbA==
X-Gm-Message-State: AOJu0Yz4sKckoS99l6UEQ5dePS9em56fLCF5k+iZszwMgd0dk7ddtYE6
	RU2bTk0zu2+wk15bX76W2LRMNnEMjrCOw38GjgfSzDYkQSzVL6LzuFyTqFNw7IM=
X-Google-Smtp-Source: AGHT+IGqo/WAMhlei83aqBH+2aI0bsnoI1goaE4Rtzf4Ns0DDE/tJyzFfiZlyjHv+57hLxfWYytPWA==
X-Received: by 2002:a05:6512:259:b0:511:b9a:8225 with SMTP id b25-20020a056512025900b005110b9a8225mr517980lfo.26.1706740645904;
        Wed, 31 Jan 2024 14:37:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXI7ulUucw+ILUhbCKkyrl1gPSZ1vKCiwSPVqR0EWTbaO3HmZWLCZ7olBmXfr5We7oBEvitXqNorItj42KF2SCRXy4Q6doWgwdlJTh+bDJHHMv/B2gPhXzW6Vbq1pi/9yX49e7e3drSSkJwPWaAqXMB9fpUnnEuq7ChPNkiGZjMhIzQSDTVLJlsKCVQ7DANRMH0hiEzgJQevL9sqA7hX40jrbS9aZcP9AuE8qRj2kcmGksAnDskl/ZoDnzrkhb4qY9HR04rlHowRwCKoIGw+Lp2h2P7f0qEleA2UyRv2oFnYk0z6KvaCCFAO1C7bnfsDZfl1xXufuiIvPASdozDoMQ0hUU4uuuHx5gRXdNzAi1cklDK24mzssrkbt79/F9mzdSuG1q81nqjjckAJSihunSRc8kfCLV0lr2w7eMqHsn0+rBj6CUMhE39em6yVIXZ1lDyPYzj34c9jfse1g==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:20 +0100
Subject: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

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

My best guess is that everyone actually using this driver has
support for the local (custom) GPIO API and the bit in
h->caps.gpio_mask is always set for any GPIO the driver may
try to obtain, so this facility to use system-wide GPIOs is
actually unused and could be deleted.

Anyway: I cannot know if this is really the case, so implement
a fallback handling using GPIO descriptors obtained from the
ah->dev device indexed 0..31. These can for example be passed
in the device tree, ACPI or through board files. I doubt that
anyone will use them, but this makes it possible to obtain a
system-wide GPIO for any of the 0..31 GPIOs potentially
requested by the driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/ath/ath9k/hw.c | 29 +++++++++++++++--------------
 drivers/net/wireless/ath/ath9k/hw.h |  3 ++-
 2 files changed, 17 insertions(+), 15 deletions(-)

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

-- 
2.34.1


