Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53721C64B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2020 23:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGKVD4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jul 2020 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKVD4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jul 2020 17:03:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC5C08C5DD
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2020 14:03:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so5164423lfm.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2020 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GupWpkc3Xw4xMgWCS32w8NIxBce7/TnF421DQ0g+UDY=;
        b=FmVWv8XSOKDqtn5tZKlxmp87Vc7CunggMTHYxA0TsYpEtaIu2UizL1o32mvdhK7JRU
         3dLHvQUaQuq8ibV+tr0OOv/5JFRneghf7VNoWsjIvQSJxpSa/zJIk7J90+Mu8dp1+oiy
         Xx0N8rPzFaScfCtKcGRTNRIxg3Q0MwLZ4AUaYiMwL46SNvyBurFtGZgK08CAdy5/buwv
         22IKf/HazT0nJJwFYQ8WUAGDey7PNaoFqs/MbHF/VCPbZBfZ+gz1NunfzzaNwmulPG8l
         PuAbOzBaphW6fHF7z36U4mmHUoXkyuFNxc57e14dI7tCTvW8SHksu3/brpbTvEG5/s2e
         X+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GupWpkc3Xw4xMgWCS32w8NIxBce7/TnF421DQ0g+UDY=;
        b=oEwZ8o74qYBYv2v/1jGEe3w8ypfxiJHWuZTj98+y50JBcRWQXWvGrO4N4d/QOK1GTU
         lByv+IploB2LJIPGzlNPi8d++scG9vMAQwGLY9R820T6M5pYNSv+v3+qnnIZFpcMUBAE
         PhxU6Pf6YKS3dJCWqaxX3C10WztR/DN4v3TNDN7Ct3I1rJM9TEDvqSy/TzwfzyCRtmaC
         TLlbmpFbvUgpZ4TkBSQw5O36QDpsyfRsBiyK6heTVHa1pu17ch8n4S0ZFPr0fXvF4HOq
         8QOQ8hmveo4uk7pzx4SZCxe50HnwPRMGCoi9I7mDqrSwaFGDoq3fve72uNaCYmVMLN7f
         0m0Q==
X-Gm-Message-State: AOAM532obZniwr0Lin68oaTo+GM6IU7607WZwd5N6Zo4ykvOzlLmLdtX
        jPeUMDUw077pzTb60gJcJ9zrDw==
X-Google-Smtp-Source: ABdhPJyAdlaOnPWadqP8lYbJivEgIeWpp/veJeN1AmLdlwY0oWzxuKsux/hG4ms/Fb84++ZIUiT5aw==
X-Received: by 2002:a19:691c:: with SMTP id e28mr48309952lfc.131.1594501434331;
        Sat, 11 Jul 2020 14:03:54 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id q4sm116882ljq.56.2020.07.11.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 14:03:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Frank Kao <frank.kao@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v2] brcm80211: brcmsmac: Move LEDs to GPIO descriptors
Date:   Sat, 11 Jul 2020 23:01:50 +0200
Message-Id: <20200711210150.4943-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The code in the BRCM80211 BRCMSMAC driver is using the legacy
GPIO API to to a complex check of the validity of the base of
the GPIO chip and whether it is present at all and then adding
an offset to the base of the chip.

Use the existing function to obtain a GPIO line internally
from a GPIO chip so we can use the offset directly and
modernize the code to use GPIO descriptors instead of integers
from the global GPIO numberspace.

Cc: Wright Feng <wright.feng@cypress.com>
Cc: Frank Kao <frank.kao@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use the PTR_ERR() error code in an error message found
  uninitialized by the kernel test robot.
---
 .../broadcom/brcm80211/brcmsmac/led.c         | 62 ++++++++-----------
 .../broadcom/brcm80211/brcmsmac/led.h         |  6 +-
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c0a5449ed72c..c1b9ac692d26 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/mac80211.h>
 #include <linux/bcma/bcma_driver_chipcommon.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 
 #include "mac80211_if.h"
 #include "pub.h"
@@ -19,16 +21,13 @@
 
 static void brcms_radio_led_ctrl(struct brcms_info *wl, bool state)
 {
-	if (wl->radio_led.gpio == -1)
+	if (!wl->radio_led.gpiod)
 		return;
 
-	if (wl->radio_led.active_low)
-		state = !state;
-
 	if (state)
-		gpio_set_value(wl->radio_led.gpio, 1);
+		gpiod_set_value(wl->radio_led.gpiod, 1);
 	else
-		gpio_set_value(wl->radio_led.gpio, 0);
+		gpiod_set_value(wl->radio_led.gpiod, 0);
 }
 
 
@@ -45,8 +44,8 @@ void brcms_led_unregister(struct brcms_info *wl)
 {
 	if (wl->led_dev.dev)
 		led_classdev_unregister(&wl->led_dev);
-	if (wl->radio_led.gpio != -1)
-		gpio_free(wl->radio_led.gpio);
+	if (wl->radio_led.gpiod)
+		gpiochip_free_own_desc(wl->radio_led.gpiod);
 }
 
 int brcms_led_register(struct brcms_info *wl)
@@ -61,12 +60,8 @@ int brcms_led_register(struct brcms_info *wl)
 		&sprom->gpio1,
 		&sprom->gpio2,
 		&sprom->gpio3 };
-	unsigned gpio = -1;
-	bool active_low = false;
-
-	/* none by default */
-	radio_led->gpio = -1;
-	radio_led->active_low = false;
+	int hwnum = -1;
+	enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
 
 	if (!bcma_gpio || !gpio_is_valid(bcma_gpio->base))
 		return -ENODEV;
@@ -75,30 +70,26 @@ int brcms_led_register(struct brcms_info *wl)
 	for (i = 0; i < BRCMS_LED_NO; i++) {
 		u8 led = *leds[i];
 		if ((led & BRCMS_LED_BEH_MASK) == BRCMS_LED_RADIO) {
-			gpio = bcma_gpio->base + i;
+			hwnum = i;
 			if (led & BRCMS_LED_AL_MASK)
-				active_low = true;
+				lflags = GPIO_ACTIVE_LOW;
 			break;
 		}
 	}
 
-	if (gpio == -1 || !gpio_is_valid(gpio))
+	/* No LED, bail out */
+	if (hwnum == -1)
 		return -ENODEV;
 
-	/* request and configure LED gpio */
-	err = gpio_request_one(gpio,
-				active_low ? GPIOF_OUT_INIT_HIGH
-					: GPIOF_OUT_INIT_LOW,
-				"radio on");
-	if (err) {
-		wiphy_err(wl->wiphy, "requesting led gpio %d failed (err: %d)\n",
-			  gpio, err);
-		return err;
-	}
-	err = gpio_direction_output(gpio, 1);
-	if (err) {
-		wiphy_err(wl->wiphy, "cannot set led gpio %d to output (err: %d)\n",
-			  gpio, err);
+	/* Try to obtain this LED GPIO line */
+	radio_led->gpiod = gpiochip_request_own_desc(bcma_gpio, hwnum,
+						     "radio on", lflags,
+						     GPIOD_OUT_LOW);
+
+	if (IS_ERR(radio_led->gpiod)) {
+		err = PTR_ERR(radio_led->gpiod);
+		wiphy_err(wl->wiphy, "requesting led GPIO failed (err: %d)\n",
+			  err);
 		return err;
 	}
 
@@ -117,11 +108,8 @@ int brcms_led_register(struct brcms_info *wl)
 		return err;
 	}
 
-	wiphy_info(wl->wiphy, "registered radio enabled led device: %s gpio: %d\n",
-		   wl->radio_led.name,
-		   gpio);
-	radio_led->gpio = gpio;
-	radio_led->active_low = active_low;
+	wiphy_info(wl->wiphy, "registered radio enabled led device: %s\n",
+		   wl->radio_led.name);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
index 17a0b1f5dbcf..d65f5c268fd7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.h
@@ -16,10 +16,12 @@
 
 #ifndef _BRCM_LED_H_
 #define _BRCM_LED_H_
+
+struct gpio_desc;
+
 struct brcms_led {
 	char name[32];
-	unsigned gpio;
-	bool active_low;
+	struct gpio_desc *gpiod;
 };
 
 #ifdef CONFIG_BCMA_DRIVER_GPIO
-- 
2.26.2

