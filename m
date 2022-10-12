Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB295FCB73
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 21:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJLT0H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJLTZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 15:25:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F960FF23E
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 12:25:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a6so73398ljq.5
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCH1mBRGKm9XJ+0zaVrmeYH3UMnCiw0sMzGuVdA+Xm4=;
        b=DVKzeXes7fhslfgcATHkasSUQ09TYjIboyKog+Tb03PanCVYGHvZ9A66FVCSl7cgcD
         E3BvbSgaK314zyKMQcIBTuqiSGT1U1CIxu6K0I82nWeR/iA/fotOmfXMobAJTGx+POob
         ClzdoJykGzIPe6k/bvaQS7mTXLO9A+uY2jKQX0fdXENKe9WcctvKtL81OuNo4QHOBlTV
         3RpR0UlAaLu1ACIRs/EkpP2XaYZ7sgPjgp0HYIycZ9WNJpCu2W8/DfxFcfBzpH0jEJnq
         NYCwznyqAoVS3HBZPQG5rHBhMHWO9eP9mo+ifdab/w4MmEIX9mWOeN1A4x/hPZmAi+qF
         40iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCH1mBRGKm9XJ+0zaVrmeYH3UMnCiw0sMzGuVdA+Xm4=;
        b=FcsikgCOwRJHI5fMp5I7i/17eunePLwwgTqttl59HuzJLYRnPnkZt2y7AdCqojAqgA
         Kc+8DxPW/ZKSF6kuwoqCzvsg+Hr5gyCleyiWREY/z2a1U1DVnkc8QKvAzdLHPlWt/7kp
         vLrihtXiGvwu9zkYplIrsL4qJSYl8Qm/9ts0ZQEvN+Lzmaf7HlSmtm9IXHRcCtp+HO2F
         uUrsYxltDz+FaK9qi8y3bRDtlupczrK3QqvZYVpG/MAU0+GH0ENd9nGuZtVHQgZtlN5S
         9Pn9+OOP8nZv9wQo6qWkbusXcAWbwZ6wC6/yvLfe5hSlCODVlM0RCwo3VnQmxFIYX+Q1
         VIpg==
X-Gm-Message-State: ACrzQf2TPh97jVFc3CSQW5uSKmgrGoLqAsQEKSD2md6W6OuWIYRlgDiV
        Sie4rObXzXz/rUF+Ag9tJAA9T9W+6goJ0g==
X-Google-Smtp-Source: AMsMyM74Gwq3RCXbkcUxUIR24aWko10ATiEh3PgUuAWsIHLhtvVzQYcr1viyyvEJimkLvWoPNfZKyA==
X-Received: by 2002:a2e:8e8a:0:b0:26e:7c92:542a with SMTP id z10-20020a2e8e8a000000b0026e7c92542amr9419754ljk.109.1665602751172;
        Wed, 12 Oct 2022 12:25:51 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id c21-20020ac25f75000000b0049fe6f36880sm79738lfc.51.2022.10.12.12.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:25:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] bcma: gpio: Convert to immutable gpio irqchip
Date:   Wed, 12 Oct 2022 21:23:48 +0200
Message-Id: <20221012192348.2234478-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This switches the BCMA gpio irqchip to be immutable.

Tested on the D-Link DWL-6810AP.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bcma/driver_gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index fac8ff983aec..eff6fc330632 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -82,6 +82,7 @@ static void bcma_gpio_irq_unmask(struct irq_data *d)
 	int gpio = irqd_to_hwirq(d);
 	u32 val = bcma_chipco_gpio_in(cc, BIT(gpio));
 
+	gpiochip_enable_irq(gc, gpio);
 	bcma_chipco_gpio_polarity(cc, BIT(gpio), val);
 	bcma_chipco_gpio_intmask(cc, BIT(gpio), BIT(gpio));
 }
@@ -93,12 +94,15 @@ static void bcma_gpio_irq_mask(struct irq_data *d)
 	int gpio = irqd_to_hwirq(d);
 
 	bcma_chipco_gpio_intmask(cc, BIT(gpio), 0);
+	gpiochip_disable_irq(gc, gpio);
 }
 
-static struct irq_chip bcma_gpio_irq_chip = {
+static const struct irq_chip bcma_gpio_irq_chip = {
 	.name		= "BCMA-GPIO",
 	.irq_mask	= bcma_gpio_irq_mask,
 	.irq_unmask	= bcma_gpio_irq_unmask,
+	.flags		= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
@@ -139,7 +143,7 @@ static int bcma_gpio_irq_init(struct bcma_drv_cc *cc)
 	bcma_chipco_gpio_intmask(cc, ~0, 0);
 	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
 
-	girq->chip = &bcma_gpio_irq_chip;
+	gpio_irq_chip_set_chip(girq, &bcma_gpio_irq_chip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.34.1

