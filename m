Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57FB60AD9A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiJXO2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiJXO2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 10:28:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B448D38C8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 06:01:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m16so30789258edc.4
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=948koSWGbbKe0EuzjjGojBkyzFaxMJ4Kx2rqygMi780=;
        b=FKcH5pXWfAJjPshY0C9UI1KCKSiok66+hj63HB05NkQnxZhNbYd1uKq910mUNDvaDt
         0MYKwX9aCXQpN374ROry8G1A1ahXGh2Qm6aMEwp3LeZyv8k0kKDWWBz4tprhy5KAM9Wp
         KicMW7fpWauWvOkikWSlcbykBP0kd55CbfTwAYpmQx1flibo9OzbCul4tTOk3GJfAjdU
         F5i73QF6dSbAHpRmUfYEHqg6FsdZt0f6wBs4nGzo6l+iMWhzlmgdN7OLNl3gEfYaFkFZ
         vzUEmDOdS6g0pIoY6uWj2gAksldn2WylaZbPoApg7JGdZwekavw2zkhTvvnqddZV12EC
         EXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=948koSWGbbKe0EuzjjGojBkyzFaxMJ4Kx2rqygMi780=;
        b=5B4Ld2Esw7qFPGiiTfMzVGSypWYLuIPxgFX6IjuKdJpkFpPUz/WIrc0kZxdJXKMidF
         N+hyhz9is918/xyuqqognMEsFxzRRjQsXCs2TKuTbUjN4HlXR5DuSHmx75k0orqZsY12
         yILOdQyZdXGBDSYikT36+zKftc3xIzea6Lx7I6L5gCEs1EMb2+PYvv9qacDjCHlVsMT8
         XWa+Hb1LAT0q6iTZsetxARn2CRxLj/9iNmIbsYG82zCMAnvu4PY0KTwHAplYPxkDygcP
         G7T6IvapIpOR5e9MoDZtI+TZsWxF0to1h84m/kRE4WalHKcXg0W29lrQ/PMYgYw8fwBY
         6gjQ==
X-Gm-Message-State: ACrzQf3ijKTBIoCvSOzyFAg0vuS/1mKUSl1fSw+S6B98+qRaEAa1pJEJ
        ChiMMszs0CtbgcxvctfxaJvYxTy7k53oNg==
X-Google-Smtp-Source: AMsMyM5DwWRZuq7oVKHt9NJl5lrXsLvsfd4cjAE9/zsaYQm0NdacBHcK6mDpwqtxCpizL3JnOMTmfg==
X-Received: by 2002:a05:6512:3053:b0:4a2:6b9c:a853 with SMTP id b19-20020a056512305300b004a26b9ca853mr11254094lfb.666.1666614510633;
        Mon, 24 Oct 2022 05:28:30 -0700 (PDT)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id k36-20020a0565123da400b004a4754c5db5sm3679861lfv.244.2022.10.24.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:28:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bcma: Use the proper include
Date:   Mon, 24 Oct 2022 14:28:28 +0200
Message-Id: <20221024122828.9692-1-linus.walleij@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/bcma/bcma_driver_chipcommon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

