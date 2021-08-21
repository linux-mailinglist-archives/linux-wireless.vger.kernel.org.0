Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E103F3CCF
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Aug 2021 02:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhHVAAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHVAAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 20:00:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766EC061575
        for <linux-wireless@vger.kernel.org>; Sat, 21 Aug 2021 17:00:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so23984364ljn.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Aug 2021 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ewrnzff7hboyvEG9Koe5XvHu9H6UT6gQnq05IG0OMi4=;
        b=r3T1nOtyA59J9itlGkWYea6NGKEqc8UrjszA0+nJWzYRgjaXL0+NEe4v93MQk7VXPG
         QvkBXFNBUdRSpDTGLI7bXKrLZfVtyuMzTPLXUGYUutEpt9ibpHlAx6l6ZxoEYT7h3V+X
         hJSBQsNAHEBEllsYvzStSUDPZRX7F4fkqC8cL98s8uIbUw1MkXgo+BdDogodXT8G4U2Z
         TvYw9uYqb7un94nWsRDh5TZDtfeRGEe3z4FNYV3/vmxNmnV8eMMsxKKnW7larQshJXeJ
         +CmNJCBJaiDQZqoMRQSOpUynsVsRfYeGk7YiXSk5nYV6bWV6PkC6irZoHCnLQWSIOqB1
         VG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ewrnzff7hboyvEG9Koe5XvHu9H6UT6gQnq05IG0OMi4=;
        b=jWmlYzf3EA6z13/jHtmN3IFIjdbMYOOO7aUz/naUxMXbrqnU/kyQxANounmLxiskY7
         PAP3NDwsuo8cYKhmK3Lmjtnlh38vj9H4V89tYHCkzjqBFYf0GzYulmhZgfI5SlLEXGOS
         neGHgCfbmAOn96WN5XqrH0dGd6tRL5zjbtFie2UxYQuixLe3+mHEKWXT13aqkyhZT6Dd
         PVhBCCZ+K9V5UdfmD+ctYdwEVdYfuqdBdWxrjGCdypn/70dOHT4dRK5yamMHuhm1DrFn
         UAKPiyYygJWD67S33Z2pELpUwjn2LHCcC/aFgJj3juRTinciC4Pf5aUM7o0uinYR2RFu
         mOlg==
X-Gm-Message-State: AOAM5300rwJImoXhjKWsBz31yH4Pmi5hVe4aVx5jYBoVNMeJ4X/gjK7g
        Y1S3s8sP1MjsSQYoMmpAFC5OoKr7JYv+0w==
X-Google-Smtp-Source: ABdhPJzRduaDI4y6GRKN20t5DJ7qROZ9wNGy4ahSXV8scWaLRlfExWNIkyUcBN+gKGHQ5dSc6NLvXg==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr21992975ljp.257.1629590404310;
        Sat, 21 Aug 2021 17:00:04 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r145sm1037523lff.128.2021.08.21.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 17:00:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Michael Buesch <m@bues.ch>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ssb: Drop legacy header include
Date:   Sun, 22 Aug 2021 01:58:00 +0200
Message-Id: <20210821235800.138817-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The SSB header only uses the legacy <linux/gpio.h> header to get
struct gpio_chip so inluce <linux/gpio/driver.h> which is the right
include to deal with gpio_chip.

Cc: Michael Buesch <m@bues.ch>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/ssb/ssb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 0d5a2691e7e9..f9b53acb4e02 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-- 
2.31.1

