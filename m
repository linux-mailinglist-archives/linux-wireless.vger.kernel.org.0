Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77060DCA3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiJZH5I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiJZH5C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 03:57:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16466A835C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:56:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u2so11519349ljl.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feV4Utqv8ozfF9ac7comz58rKZGXfrX6/5o0kmlmYRI=;
        b=LB5bipR1rjFwI3ROgRtNJZRuLW3WFygpwCwwlkqom1YwpJCQHtETRqjfIezbOYaoI3
         q/ZRZ5FAKnPWjSdSTiYLhknHbXGtSpVLdweuY53rN3qfyx6w/xKB1TBAviyNcx7lyGXV
         ta7E/VO5WmUrN0YLCGE8l6sHXhbykw5gk9rJjqOxBVTCv1UUnqBdBcjyhnYsOgTqPlHh
         tB2aJzY8qsInQ2r8XdLbc/a63s71wLqshZipD2U0GSx7xZ9k6FIpWYMzA/HFqiQ+A//z
         RPj9JVsMEKQXEOSk1yg2oBu9ru9ZQwuDzwxk0da6JGQG7D+1084M2lSkXxvWhaAN1Raq
         9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feV4Utqv8ozfF9ac7comz58rKZGXfrX6/5o0kmlmYRI=;
        b=2g0jxWjuRiIdf93KcYuM0/qhX0kCbh6ROWUHmXslFc+gs/3Y/5qpmKJOIiqY0HmqG2
         Do3FARPi5Yz6ayrK0Nu3OQ9PZqyLcBOvjbatmtMjDHgc+XnyEhZwNdcnHxcuKbrzH8cB
         3+Vv4VQ9lxbGuJ0oA3K8TSDyTWgl0vem3vqAymCqXw1PCKoCcQ5BBU1R64/FDlRxOAEP
         kEc1lZEDoo3fnWMGDSXzhuKpqLDYb2cubh83vuZ7u1bl07Zv2Q2LS+9DuPZrNBnaM9yn
         BZ6+BEeZn1K5AW0IWZW4LBt7HekorBxB0sy4gGPQ1dojFqZvn7Ij0aa6TA/ftSuRu9TP
         gg+Q==
X-Gm-Message-State: ACrzQf1Birh9nZ4c9ZPAZZPKEnP4Ki6Mxm4NolX8iO9RPEv9K956ZatE
        jdqUhBRPDl3bFFBRLxgX0tshvQ==
X-Google-Smtp-Source: AMsMyM6mMl/HcxVcX8NbuFjP7m45g5cCb7v2RxusfjBjqk3xE2CPjh0tTK6M50U/L++EFBojTmUFDg==
X-Received: by 2002:a05:651c:1549:b0:277:22c3:1980 with SMTP id y9-20020a05651c154900b0027722c31980mr342178ljp.500.1666771016739;
        Wed, 26 Oct 2022 00:56:56 -0700 (PDT)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id a15-20020a194f4f000000b004acb2adfa1fsm742051lfk.307.2022.10.26.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 00:56:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] wifi: bcma/brcm80211: Use the proper include
Date:   Wed, 26 Oct 2022 09:56:53 +0200
Message-Id: <20221026075653.105387-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
member of the BCMA GPIO struct. Surely this belongs in the
BCMA driver: we cannot have all drivers performing cosistency
checks on the internals of things they are passed.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Combine two co-dependent patches
- Collect Arend's ACK
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 2 +-
 include/linux/bcma/bcma_driver_chipcommon.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c1b9ac692d26..1cce92c5780f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -63,7 +63,7 @@ int brcms_led_register(struct brcms_info *wl)
 	int hwnum = -1;
 	enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
 
-	if (!bcma_gpio || !gpio_is_valid(bcma_gpio->base))
+	if (!bcma_gpio)
 		return -ENODEV;
 
 	/* find radio enabled LED */
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

