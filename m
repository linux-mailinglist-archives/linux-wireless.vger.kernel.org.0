Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A27898F1
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 22:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHZUJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHZUJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 16:09:35 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19FCD5
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 13:09:32 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso1392807fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693080572; x=1693685372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlIiP1fGP9ZCizSII8WfFUp1ZP6G/2K5nC/wtrwHeME=;
        b=U0k6D1HyGT6DrC9w5C/cPVjRipdsEXtq2FGkJU3SbXLv1601ZzXobLKR+9CtQ2+E/U
         jYUbMjH6vmZQj6KFqpugUEDr4nFCQLp9D/Gq5cNRGPYcNAtNijOMVUItvec3HFei+S7s
         4y68HnQYIOhklAqWXzgvEoIKhDarSwWKehC/bN/uwSEkuzRBMi0z2sr2UFRlxHZUCxV4
         OqEtyYXy9EfyCFfto9e+TFUph4pQKacHmaTb64+DjPJ2WkwNi2A2OjevHC/lYzRZvTGW
         CK/R7VRGzJQOEeniAcpvzIcG7/V7BMuYvDhkfuJb83btW/lhYcXiMiYRi7zt+m79rVDo
         7jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080572; x=1693685372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlIiP1fGP9ZCizSII8WfFUp1ZP6G/2K5nC/wtrwHeME=;
        b=NbzPRPRs0lg0atVEPjjd94TG6njegCQfmzOFDCRxsySLkaCfqQeRrYJyz3m0uVKeUk
         WpCvlMAUVz4WYigKuyDCKamBZzJMGx18Y8M+bJ4j5fgnxYbSuJymClQMfwtwgasgJCjG
         hECasEqbQYiXjJiQkYw4W34qq2sab/Kyua20Vo88H0Oj6jh9PHv5fONYEUOfJNaIjpMi
         fbL0D/3EQMuj5sAKmeehEGCMzSiApFCxhSGvxdRo4QBwKzB8tbUdlxIGgfRC6AT141K7
         aMGMUooSh8tHmPYggb18XCeuz8ofeBSAc7Kw+s+YKff006In6kwho1S8alioWGJ6y2uT
         qS/g==
X-Gm-Message-State: AOJu0YyupQ4rxUXWF671dJ5gMACt1I3Uoh+CSyPOV3xiS/pEm4dhZAI8
        l5mdzG1jAXpLvfHgckqJZZ1Fxtnlgx5jkg==
X-Google-Smtp-Source: AGHT+IG2YdL3naOcHyvJadjsQnELa0Ul3ns68RmikpCjsc8DP5wuJLKCnABJ23AEvRTGzg9wqn3zJQ==
X-Received: by 2002:a05:6870:5693:b0:1be:dbd9:dd21 with SMTP id p19-20020a056870569300b001bedbd9dd21mr6855664oao.48.1693080571679;
        Sat, 26 Aug 2023 13:09:31 -0700 (PDT)
Received: from ryzen.lan ([2601:648:8600:e71::a86])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001b04c2023e3sm4119718plg.218.2023.08.26.13.09.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:09:31 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: purelifi: use module_usb_driver
Date:   Sat, 26 Aug 2023 13:09:06 -0700
Message-ID: <20230826200929.9756-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826200929.9756-1-rosenp@gmail.com>
References: <20230826200929.9756-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This follows the pattern with other USB Wifi drivers. There is nothing
special being done in the _init and _exit functions here. Simplifies and
saves some lines of code.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/purelifi/plfxlc/usb.c | 23 +---------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 76d0a778636a..b4bb32911d9f 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -861,26 +861,6 @@ static struct usb_driver driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-static int __init usb_init(void)
-{
-	int r;
-
-	r = usb_register(&driver);
-	if (r) {
-		pr_err("%s usb_register() failed %d\n", driver.name, r);
-		return r;
-	}
-
-	pr_debug("Driver initialized :%s\n", driver.name);
-	return 0;
-}
-
-static void __exit usb_exit(void)
-{
-	usb_deregister(&driver);
-	pr_debug("%s %s\n", driver.name, __func__);
-}
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("USB driver for pureLiFi devices");
 MODULE_AUTHOR("pureLiFi");
@@ -888,5 +868,4 @@ MODULE_VERSION("1.0");
 MODULE_FIRMWARE("plfxlc/lifi-x.bin");
 MODULE_DEVICE_TABLE(usb, usb_ids);
 
-module_init(usb_init);
-module_exit(usb_exit);
+module_usb_driver(driver);
-- 
2.41.0

