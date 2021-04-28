Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19F36DCAC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhD1QIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhD1QIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 12:08:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C1C061573;
        Wed, 28 Apr 2021 09:07:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o16so19501969plg.5;
        Wed, 28 Apr 2021 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=HFXMnyauVEAn7M4sEEG2ql95kFRnwgv0LYPISmLeMIQ=;
        b=K504PjKmWI9dQz5TyfEUaWlNmdqNgk25AgjqYh7sFnol//BfQoc3xa1TS9JhWSbpbR
         ruk/QqTRQW/Ueq/m5K6udn0SN4rVgAbssqPqJwd5Bb/HvlJCWOjeZIcvmZiY5K0rjt9C
         b7QYikIu8HC6h0uGaw9m9nWqlb4GhSaeU7soyIbQxRZyd4+yYcdYWEkoifLzRvF98OQZ
         V6N2S6Tx5BCIzHSwiRPkfAHSFOAyhwKC/CQU1WP4aFXZlVQNNFspSj8/vD7Isj+lXhzV
         9+MeyzXU0dM4kyNCqTSLNhT582xgMyIsxHTHFJJ1gZMf4Nb7zzrp4Ae6xYT+JJmIG5Nz
         drhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=HFXMnyauVEAn7M4sEEG2ql95kFRnwgv0LYPISmLeMIQ=;
        b=T3a4FKT3H3OQ1AkJlplYj8ayQ7olJKLGR5HT+AeDSMJC9LQz8kCQRXs73ipfH/jtZy
         l4J37MctUIHX9cbTuziz1qB0VZejNhXml/M/TswiyqdplJuaVFAsFhAzA61pZoiGp/q4
         19NXwJ1F2eWQ+ufhBwJXwhtrnVPOL3I8QWctnkCJ9lVUdJhKMm30WvZnmVHjdT0I+PAv
         lkVqoOB4ZIRNLCPUmnRHt3wabMVucI6a/XHbFWe0wkCuElKXUcswUH0xrQUXYKn+7qo0
         rGrx0BFlwZ2xoRCYTIzg5w3Z9zUT0pD1MOyUZTn4BM30ymrKhgBnkbjLMrhV8IgUbSQQ
         wycg==
X-Gm-Message-State: AOAM530BwzPuYmQAaXryavdbCTPgC7aYrOyOtwX8zFHj+n3jaycZbhpY
        TsoI/33oIdAnv/tm9ZRonyeH5Sj5ftdatpe6
X-Google-Smtp-Source: ABdhPJxK8iAKQjmySacunUI8P7OPRQO3Mkmk/U7+oDY6Qup5Ug1bCtU9b6SYTDInbrMYO+buir8LZg==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr4944520pjr.47.1619626076248;
        Wed, 28 Apr 2021 09:07:56 -0700 (PDT)
Received: from localhost ([157.45.42.123])
        by smtp.gmail.com with ESMTPSA id s3sm159651pgs.62.2021.04.28.09.07.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 09:07:55 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:37:47 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: ssb: driver_gpio.c: Fix alignment of comment
Message-ID: <20210428160747.qy23g6zpmheiacpl@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The closing */ has been shifted to a new line
This is done to maintain code uniformity.

Acked-by: Michael Büsch <m@bues.ch>
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

