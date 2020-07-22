Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F64229748
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jul 2020 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGVLTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jul 2020 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGVLTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jul 2020 07:19:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DCC0619DC
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jul 2020 04:19:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so2025732ljg.13
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jul 2020 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhRoQFCJDJNAYkk8149hNtdal6BdWja6VHiCqSxe3pE=;
        b=VA+mc8ihxZhOTud4Xu0JcOQ2GmNFXpavaPko+xxVXDrFjyGnPJ1QswPQGiPKUi2yTY
         rs8q2B8Icjq1J0+9M9WwtGwIJPpfrnM49Ax+59irri5G0cTo30tB1rQr8zek4ftpncuy
         d4eOVZV543AmjkXFkFc+Xd8KAaHL4OKjErPXRscK6oTvGECzzWAdTgPYRuDQXvdRD+GX
         Cnb+EmNnMigzc31xbVXbdEpz0b8Pe2hBM2dObH0mtgy3TLzqkXqa9G78cvXDBBYzQ+Bv
         sZmlODKsBqPNz7WGGzcO32pPWVSbd8FQauUmQexc3eQCG7eUrHRMNybqX+RcEF4OsDoX
         AmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhRoQFCJDJNAYkk8149hNtdal6BdWja6VHiCqSxe3pE=;
        b=L21DYOTYIAJwJw7E687iuljXqeGN2h3/mSFkh/D1Wuw8rihTA0TOL2+lhpszRBqCBM
         VG95grs00HI5RS33q7ZauUbh/GzeErc1NS0tko5YDN0hnoMFOa8AIngDMf3ToBTRy9d1
         3Yfzs+QpHYG7ohYjfuaaqbrbspIRehbO1kxdcEiTnsz70U2smLTqDejX0V7U4bifUYgb
         +D5qRjTz/CDJ7vwICD7Cr5v3gDsZnkHvaiO4FYOhKcFIkNptooiuTxL0i9M/nb1PkI+a
         xH4P5qOndOcv6nDxj1a3tvDsCoTVg+B2+D0pzO6oPRA3d2WLX04POBwJLVa/Cz9B3uoI
         a3AQ==
X-Gm-Message-State: AOAM533GQ7oTD8MHb9/XyFdZV0AkNVaH0pizun5megUFUVeMhbswbWYp
        XORVufjidqApVCCYxK4IZaE5JkPAp7loaw==
X-Google-Smtp-Source: ABdhPJxs/F96hDeYqeVA5sZlJnxeunyvy5Eyo3fpe1t0Xz5vso8XioniLCp+4i+zu/GgHuARBt7+oA==
X-Received: by 2002:a2e:b00a:: with SMTP id y10mr4153105ljk.266.1595416784197;
        Wed, 22 Jul 2020 04:19:44 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id u26sm8789440lfq.72.2020.07.22.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:19:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] bcma: gpio: Use irqchip template
Date:   Wed, 22 Jul 2020 13:17:25 +0200
Message-Id: <20200722111725.210923-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes the driver use the irqchip template to assign
properties to the gpio_irq_chip instead of using the
explicit call to gpiochip_irqchip_add().

The irqchip is instead added while adding the gpiochip.

Cc: Rafał Miłecki <rafal@milecki.pl>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bcma/driver_gpio.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index a5df3d111334..8a1e4705bc87 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -122,6 +122,7 @@ static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
 static int bcma_gpio_irq_init(struct bcma_drv_cc *cc)
 {
 	struct gpio_chip *chip = &cc->gpio;
+	struct gpio_irq_chip *girq = &chip->irq;
 	int hwirq, err;
 
 	if (cc->core->bus->hosttype != BCMA_HOSTTYPE_SOC)
@@ -136,15 +137,13 @@ static int bcma_gpio_irq_init(struct bcma_drv_cc *cc)
 	bcma_chipco_gpio_intmask(cc, ~0, 0);
 	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
 
-	err =  gpiochip_irqchip_add(chip,
-				    &bcma_gpio_irq_chip,
-				    0,
-				    handle_simple_irq,
-				    IRQ_TYPE_NONE);
-	if (err) {
-		free_irq(hwirq, cc);
-		return err;
-	}
+	girq->chip = &bcma_gpio_irq_chip;
+	/* This will let us handle the parent IRQ in the driver */
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_simple_irq;
 
 	return 0;
 }
@@ -212,13 +211,13 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	else
 		chip->base		= -1;
 
-	err = gpiochip_add_data(chip, cc);
+	err = bcma_gpio_irq_init(cc);
 	if (err)
 		return err;
 
-	err = bcma_gpio_irq_init(cc);
+	err = gpiochip_add_data(chip, cc);
 	if (err) {
-		gpiochip_remove(chip);
+		bcma_gpio_irq_exit(cc);
 		return err;
 	}
 
-- 
2.26.2

