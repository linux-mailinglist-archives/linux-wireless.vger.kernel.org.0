Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949077898F0
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 22:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHZUJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHZUJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 16:09:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC78A1AD
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 13:09:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-54290603887so933171a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693080571; x=1693685371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2K0i+q1vtQDNkHEHlsAOOOf/oRQws8UMp1W1FTBoOrQ=;
        b=Ttm3Oq55mNfcleZmjc0pa0BeVVqCB692mdzWykwAv13oww2LtLWynq7VmvsLAEjV73
         4HmEQO4xMGxrEAvwL1bLiXM6/cX2CJvqHfTK8RaabKl3DDbOO4xQHtftNe3ngHH7F/l/
         xALdQVyHP8xC2oR690zLR/5nZacrgodJdX/sayZxZO8oKiF+N63xSDZwFDDpsVf7PScA
         R7Z6C5wAwGRmzRa0zehTtaytudSH9pG3YqxZ89gIPrKuKvz08Km82dnxnRrEwHWkFisl
         qqKOkGpyQZQA03a57BLVQ2IgByCcjWWExzHxv2ddGuCIY5Ymp+bOhM8QpbNyC4pXNB0W
         wTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080571; x=1693685371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K0i+q1vtQDNkHEHlsAOOOf/oRQws8UMp1W1FTBoOrQ=;
        b=GIhk3o+SjVYY8RF8QxPhp/VeISYWQU3oBzb3tsbgUJ/tdVuHUdMr7NjjC/0oZTyOXi
         gWF3oFjw8VFnlBRKlK5hXugc3oXhxjhSmCMaWYAh3Aox3sW9O9twfRfwjJYvwwuyrM7F
         2id8hpCVvwYeyp9Y0xcdT/X83uhg6W8pdxXwgxU8Y8joIrQPlxiVKhMJ5BVqwXJo9a2H
         NJlfxv/f3IZU1bGYgi+qYezs23IXYPY68I+B8OvztIRCXfInx5PYjxTOIJ+Z6uMkeUwA
         vEu0RPEEsyroOK3qbzaeiE08pUHqC+4TolJFBYLCy0yr5XezzjsUMkGhpsXpdv0u0Scm
         cppw==
X-Gm-Message-State: AOJu0YyxfkiG8ZcDaztD821z0uZOxew7eld+Ob6GOt4fHZ+9sp+nrqf8
        lYrR5cbVlofVS43gGK2IY6ifRrVuGAhxWg==
X-Google-Smtp-Source: AGHT+IEZjuC/o/R5Fv/jWOv2zECxTG8UDWttlbWILZ7O6s4j7uszeITkuMWt5ZLL67V/Q7TMksPH3A==
X-Received: by 2002:a17:902:6b0c:b0:1b7:f64b:378a with SMTP id o12-20020a1709026b0c00b001b7f64b378amr16415480plk.16.1693080570924;
        Sat, 26 Aug 2023 13:09:30 -0700 (PDT)
Received: from ryzen.lan ([2601:648:8600:e71::a86])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001b04c2023e3sm4119718plg.218.2023.08.26.13.09.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:09:30 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath9k_htc: use module_usb_driver
Date:   Sat, 26 Aug 2023 13:09:05 -0700
Message-ID: <20230826200929.9756-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.41.0
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
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 10 ----------
 drivers/net/wireless/ath/ath9k/hif_usb.h      |  2 --
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 18 +-----------------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 27ff1ca2631f..e261e4258f0a 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1535,13 +1535,3 @@ static struct usb_driver ath9k_hif_usb_driver = {
 	.soft_unbind = 1,
 	.disable_hub_initiated_lpm = 1,
 };
-
-int ath9k_hif_usb_init(void)
-{
-	return usb_register(&ath9k_hif_usb_driver);
-}
-
-void ath9k_hif_usb_exit(void)
-{
-	usb_deregister(&ath9k_hif_usb_driver);
-}
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index 5985aa15ca93..6a7da71c9da6 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -136,8 +136,6 @@ struct hif_device_usb {
 	u8 flags; /* HIF_USB_* */
 };
 
-int ath9k_hif_usb_init(void);
-void ath9k_hif_usb_exit(void);
 void ath9k_hif_usb_dealloc_urbs(struct hif_device_usb *hif_dev);
 
 #endif /* HTC_USB_H */
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index dae3d9c7b640..beaaa31f32a5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -1018,20 +1018,4 @@ int ath9k_htc_resume(struct htc_target *htc_handle)
 }
 #endif
 
-static int __init ath9k_htc_init(void)
-{
-	if (ath9k_hif_usb_init() < 0) {
-		pr_err("No USB devices found, driver not installed\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-module_init(ath9k_htc_init);
-
-static void __exit ath9k_htc_exit(void)
-{
-	ath9k_hif_usb_exit();
-	pr_info("Driver unloaded\n");
-}
-module_exit(ath9k_htc_exit);
+module_usb_driver(ath9k_hif_usb_driver)
-- 
2.41.0

