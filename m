Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005E610D3D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJ1JaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJ1JaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 05:30:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C63024F12
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:30:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r14so7370285lfm.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1comWph4rDopmDPbZgTgIOpkFSovi8RcD6N+eljKNLQ=;
        b=PebyCk0GKUDOkYDHln5l3moGzPo7x3a1wDeR8cNIviF8N1zUtMD9ki7tVkuwvL1UKV
         d0mTP7Jix8tTBpF3qiUYXMwJt0l0gbsSb4f2mtCEkO42WAb4vbTNKe8Yabsbeh4+/pgD
         7a9sah3MnmTrmQmIvvN/ctl+r99JjiW2nMqq7TyJ8r7KnQt5ZD/9SFMajzWF9pBMlseg
         UO3Yu7HbrPcuf4wH/ZyL2k9phPdSb+EFN1Sq/wDr5Y18dIgkXcvy+aLwI716oAFC3+T2
         612kCJIkf6dlC2RMxOy5BzIfsU6qYaCFdFxedCtT/XogwCk4yzDTZpmhFcKtN0kQ7lJ+
         iZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1comWph4rDopmDPbZgTgIOpkFSovi8RcD6N+eljKNLQ=;
        b=KtYpo+2f8ZpH2bR5oU0nxzf2WmzZsxh9KUcP/jFQEkQFZIUzudNioWHO+jhOlpKZbx
         TTDo+f26FfTm6khNc7Ir3OJ/SMePxVRiSC9ZS+j26CCW57P/99yF9BI7JPFIOzaligHj
         I2LZbqXHw3+Ss5ecO5I2rejAYuWjf2+NijJ/z9rz5l9HexGfKUGN/mmqkI+ZqIyOLLud
         vOjV+iMYm8IWUt+xh4pGFRWTkQURMDGkTiBZboHICcCTVFf306NjK9W+foVCW4B6cbbN
         8x8vWWLIsMpjY76iB5sCb4qP4/0JsDy/AYwpAOd6Qi79poTcOwUMeatKiY7o6SCmujPK
         SeXw==
X-Gm-Message-State: ACrzQf0L0806YTVexxOLh8d00g+Sy1XtZ6RdFOrOEDdm2yURVMJTOvm/
        4qjUEVx1UYRpi/N6QKkDtEb3kA==
X-Google-Smtp-Source: AMsMyM60B47xIxG8gjBXJcPQypm/oFbAWJAsw8O0q7/Ehw/YPuS25M/2MLOIKfvrBXJsctLrqabi8g==
X-Received: by 2002:a05:6512:e9f:b0:4aa:fde3:6f5 with SMTP id bi31-20020a0565120e9f00b004aafde306f5mr9551526lfb.47.1666949402555;
        Fri, 28 Oct 2022 02:30:02 -0700 (PDT)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id s13-20020a056512214d00b004946c3cf53fsm491649lfr.59.2022.10.28.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:30:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bcma: Fail probe if GPIO subdriver fails
Date:   Fri, 28 Oct 2022 11:30:00 +0200
Message-Id: <20221028093000.239020-1-linus.walleij@linaro.org>
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

We currently register the BCMA core even if the GPIO portions
fail. There is no reason for this: the GPIO should register
just fine, if it fails the BCMA driver should fail.

We already gracefully handle the case where the GPIO driver is
not compiled in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bcma/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 44392b624b20..0a8469e0b13a 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -344,8 +344,10 @@ static int bcma_register_devices(struct bcma_bus *bus)
 	err = bcma_gpio_init(&bus->drv_cc);
 	if (err == -ENOTSUPP)
 		bcma_debug(bus, "GPIO driver not activated\n");
-	else if (err)
+	else if (err) {
 		bcma_err(bus, "Error registering GPIO driver: %i\n", err);
+		return err;
+	}
 
 	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
 		err = bcma_chipco_watchdog_register(&bus->drv_cc);
-- 
2.34.1

