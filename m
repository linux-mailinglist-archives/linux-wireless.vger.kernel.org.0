Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9621542D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGFIt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgGFIt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 04:49:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B9C061794
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 01:49:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so31071102ljm.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2020 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYHXuW1zxFX03r/ani/HTsgLODB4/FNjPp9EU+DSW1I=;
        b=Xd06LhPRVNt+uAn87t19mQ/MMY4mdbl8jsx6zZ7JvFFMnpu9ABq3CN3K7rA3Hvmj9n
         wT7tQlc+IZUoojkJyXVUqIt0vy8UyH6j0oYOgA0Y5ne0KdQKAf1OqYPoqaTbGqlRNPOH
         rHka3hlXLGFE+w6ynJ/AswTSBrzhzxIkycn7xcp590KQgg9S3D2xQcx/iKZeqfHLQGsR
         9wBlzwuFzIHwVLNBtY4JziFj67G97vesJGKdqkqa6nELv3G6UpUB0Raj3RTn40s2n0Eo
         IuMTlobd+RsMUDZx8s3ZILU9mbvj9epqyr37qziyGi1Y7iH9JUXF36D4VWYzdt/uj+qr
         MOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYHXuW1zxFX03r/ani/HTsgLODB4/FNjPp9EU+DSW1I=;
        b=DJcjl8p4BaYKlwk79/0zqQXvVy2q0LWNXw2yMexB9AnhQd8TpF/mLLRM1ky0qFZ7KQ
         R1GU7ZWDucj977q4+cstNFC7g4SY37ykXIpDhA8pPN6jsHLHWbNp82QQfsGNV//BCHLZ
         I4AcJ3OfSlw4U8mtmce0GWFQPxI1vD2v3LMdwcs6DoRO+rF3913gCgv0yIH5+lv88ApO
         cQJ1DioHdx7qynQLw0ctGCur7RhMBe6E8nCitsSmL94Ah1Onfxr11FZ6Yei3d21vVrWn
         bYh10QfmC3C9Vr5K82aomBSZ3BLA9FvOSv4nVq+qvIb5OLueNtMsT1bj+aJUjtwHPaeV
         AK/A==
X-Gm-Message-State: AOAM531dquncASuJQrt9uPlNomCYpHs+8uSoicFjseOSYifWnqEyNwu+
        7XaPoZ7qs5UoTWaBHhJmmlN6eQ==
X-Google-Smtp-Source: ABdhPJwlknh40JZUpq/u6IURc2vL3zZbk7e5aOG/ZPqRErz4Kh7sOmRG4vrQDxZt2NmuvMB2MqwZQw==
X-Received: by 2002:a2e:9b8c:: with SMTP id z12mr26245981lji.35.1594025367045;
        Mon, 06 Jul 2020 01:49:27 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id b16sm7647319ljp.124.2020.07.06.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 01:49:26 -0700 (PDT)
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
Subject: [PATCH] brcm80211: brcmsmac: Move LEDs to GPIO descriptors
Date:   Mon,  6 Jul 2020 10:47:19 +0200
Message-Id: <20200706084719.691548-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.4
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
 .../broadcom/brcm80211/brcmsmac/led.c         | 63 ++++++++-----------
 .../broadcom/brcm80211/brcmsmac/led.h         |  6 +-
 2 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c0a5449ed72c..099e8585f0d4 100644
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
@@ -75,31 +70,26 @@ int brcms_led_register(struct brcms_info *wl)
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
-		return err;
+	/* Try to obtain this LED GPIO line */
+	radio_led->gpiod = gpiochip_request_own_desc(bcma_gpio, hwnum,
+						     "radio on", lflags,
+						     GPIOD_OUT_LOW);
+
+	if (IS_ERR(radio_led->gpiod)) {
+		wiphy_err(wl->wiphy, "requesting led GPIO failed (err: %d)\n",
+			  err);
+		return PTR_ERR(radio_led->gpiod);
 	}
 
 	snprintf(wl->radio_led.name, sizeof(wl->radio_led.name),
@@ -117,11 +107,8 @@ int brcms_led_register(struct brcms_info *wl)
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
2.25.4

