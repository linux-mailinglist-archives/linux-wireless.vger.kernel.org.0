Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24E636D3FB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhD1IbW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbhD1IbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 04:31:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8B1C061574;
        Wed, 28 Apr 2021 01:30:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d124so449233pfa.13;
        Wed, 28 Apr 2021 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v7m0D7rx0mHGeruDjxwKiC0tRb8Flpj4t02w67RLk04=;
        b=YuY9LSU10AzRV8q3HxrvO4+ECbK7HSr7PjVy68MTkqZSnLLZjD7QIfobR90b5UzeT9
         Xwtu+BYL7dO+uwKJGtFYjZHxF4J5ND2ILXcLch5gcgPTYcMu/B36cwc00PdvkEdd++Oe
         KeOAXjY0sDeWO+mRIkZJZuo2DWaK2hTmAxqT3WpanmHSrL/tyHT5elyIlhZ0dMDz5llR
         6kHTiKHqC5BqofCr3nhb6VIjPdoQfQXrYjLJPrPbdYsZrntABBm05AwS0BwJFTiw7+jX
         VHMqwJ10GL1yWv3j2M8CRW9OZeWsiAp0Y+UpGmCBVAt78EJVEn8aDWLlMo7kDj4qsPlX
         BQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v7m0D7rx0mHGeruDjxwKiC0tRb8Flpj4t02w67RLk04=;
        b=muX7TpU/YWQZnTKfEfzrz8PUHVOxuEdo+XL7rhjX4QD5jI3a8J5mZxItwv8KqB/TSV
         Cu1q64VZy0GVRuuMgtc5fyRU0YkNfq5P80o8h+5jiIrCIvCkWdCq6PdD5mE75SorSasK
         CsanHzWk1NTADGnrHW/c1tyLoFTXFu3YmUEkVkMbLaPPKnvROQVHoavrsjd18Z+ZrOAi
         kyUFYjsbMxhwPP2e+cklo10not4Qg4jhyUA4jJwFabomqk/hikEeIdbxZgSf34wQGzbU
         /TWUtpkbLsA1nJipKYpCCsI3JW56N0W9ZNH6vrVsCvR4e1ev/C3xLXbNWUzxELsWFnus
         UaxQ==
X-Gm-Message-State: AOAM532cGN+ubiQdRPQchv61wvDwtPGwmCFvBrOUjJ0Ws3Rtao3O2OsW
        nQxy6Nx3HG9uidK+TWoLqa8=
X-Google-Smtp-Source: ABdhPJxImi7e1CDSgVORCSBBjuxGkT4tEH9F2seAxYefktDE8vlf5hbPfe0l8ExYvsmXd7n14a9ocg==
X-Received: by 2002:aa7:8c47:0:b029:25c:8bbd:908 with SMTP id e7-20020aa78c470000b029025c8bbd0908mr26727892pfd.54.1619598627997;
        Wed, 28 Apr 2021 01:30:27 -0700 (PDT)
Received: from localhost ([157.45.46.0])
        by smtp.gmail.com with ESMTPSA id e9sm1784514pgk.69.2021.04.28.01.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 01:30:27 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:00:20 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: ssb: driver_gpio.c: Fix alignment of comment
Message-ID: <20210428083020.gt6ea2guhfp75pan@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The closing */ has been shifted to a new line
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/ssb/driver_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 66a76fd83248..2de3896489c8 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -231,7 +231,8 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-	 * a random base number. */
+	 * a random base number.
+	 */
 	if (bus->bustype == SSB_BUSTYPE_SSB)
 		chip->base		= 0;
 	else
@@ -424,7 +425,8 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->ngpio		= 5;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-	 * a random base number. */
+	 * a random base number.
+	 */
 	if (bus->bustype == SSB_BUSTYPE_SSB)
 		chip->base		= 0;
 	else
-- 
2.17.1

