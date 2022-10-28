Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC10A610CFD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ1JXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ1JXn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 05:23:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141E1C6BCE
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:23:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b2so7321387lfp.6
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=go3krACNX2RzbQivd6srgPrhcMf9HCsabSQ3dXxwO4g=;
        b=RRth31ZfMwHdyMz7dVfSMzIhaCEWIME50qkKDcPdh2DWt6o8yF2Ax2ElzlR2iAy3RS
         Mi9ivz6iqp51KSDl9QVWcnhb2VcTEquw181lT1LzbJ7gTR7OOq8wdBOT/Gtl9IMifreV
         Xkx+YTj4seL33HmUDTsenA9giVfH+irz0ABFrkrUCR6jrjTlHKaWaThD3e2uj/N5CRc/
         n5J6IQoD/naa9RSuIpYiBQS7gTmRF9SL77gRpOOnlF0S6Qq9L6rIHCy6W+CPpicNZNTo
         NNDoKoFIFT3lmWqngkTpky1o6d33FonEr6T0TmCDqOYJ6406p/4Cz2j7lfwQir6qxIUW
         crrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go3krACNX2RzbQivd6srgPrhcMf9HCsabSQ3dXxwO4g=;
        b=HAw4uRENoUY9DvzuaY29JbskAt8edZgjds6AZddHfO7SytXm/OAeXWmLguue+SAAhx
         gr0PRpQWq+gvmeVJK9M6aE//7eBNYlXdB8veTuV3Bodzez2BK9zBBETid5CaSkBmpdgN
         HlufuHgycPun/qoBtqv7HM8/fB5oz86863qtWWIyQIgWTeEpF0JKXCiF740wuyfhKjG1
         fdHOQGNtyy52DhIuKLrXZZy+NWQKYQgWc+c3EZSxTcDkVwbspxDkP0x5GEjYdGoMOSCh
         JJca2YtEODCuYHiwL9bQ/4WVQHQoFsxXKwTAMA/YEirEuH39rRDtIiCqXVwnpPTnOQET
         byDQ==
X-Gm-Message-State: ACrzQf04sEWplA3Gx/vrD9rPh1v62rYT5c6v92l+qKx16Hypj4Zk7fJd
        rdZVPkIXkDXYWjQVZMKq0q9SeQ==
X-Google-Smtp-Source: AMsMyM6C44sS8vfXPtZ5FQyvFEa3xlvHTqcbvnsvTolvFWWCGMYjzkixme5fqh/H6BNNxGnZGZuflQ==
X-Received: by 2002:a05:6512:104c:b0:4a2:6cee:ae17 with SMTP id c12-20020a056512104c00b004a26ceeae17mr18805296lfb.417.1666949020895;
        Fri, 28 Oct 2022 02:23:40 -0700 (PDT)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id d3-20020a056512368300b00492ce573726sm485799lfs.47.2022.10.28.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:23:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH v3] wifi: bcma/brcm80211: Use the proper include
Date:   Fri, 28 Oct 2022 11:23:32 +0200
Message-Id: <20221028092332.238728-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The <linux/bcma/bcma_driver_chipcommon.h> is including the legacy
header <linux/gpio.h> to obtain struct gpio_chip. Instead, include
<linux/gpio/driver.h> where this struct is defined.

It turns out that the brcm80211 brcmsmac depends on this to
bring in the symbol gpio_is_valid().

The driver looks up the BCMA parent GPIO driver and checks that
this succeeds, but then it goes on to use the deprecated GPIO
call gpio_is_valid() to check the consistency of the .base
member of the BCMA GPIO struct. The whole check can be dropped
because the bcma_gpio is initialized in the declarations:

  struct gpio_chip *bcma_gpio = &cc_drv->gpio;

And this can never be NULL.

Cc: Jonas Gorski <jonas.gorski@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Drop the whole bcma_gpio check because it cannot be NULL.
  Update commit message.
ChangeLog v1->v2:
- Combine two co-dependent patches
- Collect Arend's ACK
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 3 ---
 include/linux/bcma/bcma_driver_chipcommon.h            | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c1b9ac692d26..9540a05247c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -63,9 +63,6 @@ int brcms_led_register(struct brcms_info *wl)
 	int hwnum = -1;
 	enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
 
-	if (!bcma_gpio || !gpio_is_valid(bcma_gpio->base))
-		return -ENODEV;
-
 	/* find radio enabled LED */
 	for (i = 0; i < BRCMS_LED_NO; i++) {
 		u8 led = *leds[i];
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index 2d94c30ed439..0cb6638b55e5 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -4,7 +4,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/platform_data/brcmnand.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 /** ChipCommon core registers. **/
 #define BCMA_CC_ID			0x0000
-- 
2.34.1

