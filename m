Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A636DD01
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhD1QaD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD1QaD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 12:30:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324EC061573;
        Wed, 28 Apr 2021 09:29:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so29197380pll.7;
        Wed, 28 Apr 2021 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Jm1Qiw6sG7rg0i6ZsbX28rZ4o7A1N3m+zEYtnr+awQA=;
        b=JCXUzC3v9I/GFjKAMLcDXsQKGTDsx8zvaI3ISqb71SOZIhNRc/9e14jpb7x2NvLjDm
         /vNpiJSVKz1COx8/w7vEBAfLye6XFa954aAw88Lkpf0/65mN88GBPszfnEIL23wAnSF4
         dWmZ/L4ljhyTONAPz/IaFC6c0cIwHBjQ4R5Zk7SHg2DUnJsjiYtUHTEoAnGVMVWijRZD
         ND8e5KW/PJrh+yYTkAWYsKwdG9pAIGm4TS88u4ckxydGJFQEzTHfWPy2UI4hOdXB48+b
         nQx0X6VGmKGUu5vlwfOqc0CMBxM1YC1km8SFXRICqv9Rw4LcRgmlszVeOVPBTV7RBTDB
         nT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Jm1Qiw6sG7rg0i6ZsbX28rZ4o7A1N3m+zEYtnr+awQA=;
        b=NJZqUrNSVDKd8wwCSIutm2CdH3sOCqchDB0NH+cpchX8i2M8PL7ojANiIjZOPixyCm
         el/BvlYwOcJ/PI57RiQotXurNUxqPvfx/6ZOHgb6HpdEprZmrVpTDz/PJhgFDdwTYGQc
         RpNWyvSODZrYo6HO+Dt+CldaGLPqT2Eb5PQF+w0tyLi9zLhHX4VQoMNBwSVHdx6uCP3P
         q7+MqUOL4uac/18CcCXwQqzjrpBGfYRgxAx88Y8Yfqo7vKA+oX0KLFvJg5t5CWICYK4K
         +1tp7r7Wu7TkcygRMKm+KlM3RlFehyYjA9PTadx7Zc6fgW34yWYtSgbFQqfqBlwCJu40
         /LUw==
X-Gm-Message-State: AOAM533t9SH6Ok1RbDW+JawHfK36W8fWjB6l+L6SrmlM6n5lyF9PUmaB
        Gm0cz2oIhFUUiD7F+CHZq36YXk8YnwfM7TMV
X-Google-Smtp-Source: ABdhPJwYo1UWffNjMrEZKZxnxRhmb8978jwv/8lFWFebVwgdd8VyMp572p6h+g5ZC+PFgCh7XlkjSw==
X-Received: by 2002:a17:902:b68a:b029:e9:7643:6335 with SMTP id c10-20020a170902b68ab02900e976436335mr31138249pls.2.1619627357290;
        Wed, 28 Apr 2021 09:29:17 -0700 (PDT)
Received: from localhost ([157.45.42.123])
        by smtp.gmail.com with ESMTPSA id r32sm192926pgm.49.2021.04.28.09.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 09:29:16 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:59:07 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: ssb: main.c: Fix indentation of comment
Message-ID: <20210428162907.bn5q3oh3sji6wlh4@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shifted the closing */ to the next line
This is done to maintain code uniformity.

Acked-by: Michael Büsch <m@bues.ch>
Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/ssb/main.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..0e180c36daa4 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -37,7 +37,8 @@ static LIST_HEAD(buses);
 /* Software ID counter */
 static unsigned int next_busnumber;
 /* buses_mutes locks the two buslists and the next_busnumber.
- * Don't lock this directly, but use ssb_buses_[un]lock() below. */
+ * Don't lock this directly, but use ssb_buses_[un]lock() below.
+ */
 static DEFINE_MUTEX(buses_mutex);
 
 /* There are differences in the codeflow, if the bus is
@@ -45,7 +46,8 @@ static DEFINE_MUTEX(buses_mutex);
  * are not available early. This is a mechanism to delay
  * these initializations to after early boot has finished.
  * It's also used to avoid mutex locking, as that's not
- * available and needed early. */
+ * available and needed early.
+ */
 static bool ssb_is_early_boot = 1;
 
 static void ssb_buses_lock(void);
@@ -161,7 +163,8 @@ int ssb_bus_resume(struct ssb_bus *bus)
 	int err;
 
 	/* Reset HW state information in memory, so that HW is
-	 * completely reinitialized. */
+	 * completely reinitialized.
+	 */
 	bus->mapped_device = NULL;
 #ifdef CONFIG_SSB_DRIVER_PCICORE
 	bus->pcicore.setup_done = 0;
@@ -467,7 +470,8 @@ static int ssb_devices_register(struct ssb_bus *bus)
 		sdev = &(bus->devices[i]);
 
 		/* We don't register SSB-system devices to the kernel,
-		 * as the drivers for them are built into SSB. */
+		 * as the drivers for them are built into SSB.
+		 */
 		switch (sdev->id.coreid) {
 		case SSB_DEV_CHIPCOMMON:
 		case SSB_DEV_PCI:
@@ -521,7 +525,8 @@ static int ssb_devices_register(struct ssb_bus *bus)
 		if (err) {
 			pr_err("Could not register %s\n", dev_name(dev));
 			/* Set dev to NULL to not unregister
-			 * dev on error unwinding. */
+			 * dev on error unwinding.
+			 */
 			sdev->dev = NULL;
 			put_device(dev);
 			goto error;
@@ -667,7 +672,8 @@ ssb_bus_register(struct ssb_bus *bus,
 	ssb_bus_may_powerdown(bus);
 
 	/* Queue it for attach.
-	 * See the comment at the ssb_is_early_boot definition. */
+	 * See the comment at the ssb_is_early_boot definition.
+	 */
 	list_add_tail(&bus->list, &attach_queue);
 	if (!ssb_is_early_boot) {
 		/* This is not early boot, so we must attach the bus now */
@@ -1007,7 +1013,8 @@ static void ssb_flush_tmslow(struct ssb_device *dev)
 	 * a machine check exception otherwise.
 	 * Do this by reading the register back to commit the
 	 * PCI write and delay an additional usec for the device
-	 * to react to the change. */
+	 * to react to the change.
+	 */
 	ssb_read32(dev, SSB_TMSLOW);
 	udelay(1);
 }
@@ -1044,7 +1051,8 @@ void ssb_device_enable(struct ssb_device *dev, u32 core_specific_flags)
 EXPORT_SYMBOL(ssb_device_enable);
 
 /* Wait for bitmask in a register to get set or cleared.
- * timeout is in units of ten-microseconds */
+ * timeout is in units of ten-microseconds
+ */
 static int ssb_wait_bits(struct ssb_device *dev, u16 reg, u32 bitmask,
 			 int timeout, int set)
 {
@@ -1153,7 +1161,8 @@ int ssb_bus_may_powerdown(struct ssb_bus *bus)
 
 	/* On buses where more than one core may be working
 	 * at a time, we must not powerdown stuff if there are
-	 * still cores that may want to run. */
+	 * still cores that may want to run.
+	 */
 	if (bus->bustype == SSB_BUSTYPE_SSB)
 		goto out;
 
@@ -1322,7 +1331,8 @@ static int __init ssb_modinit(void)
 }
 /* ssb must be initialized after PCI but before the ssb drivers.
  * That means we must use some initcall between subsys_initcall
- * and device_initcall. */
+ * and device_initcall.
+ */
 fs_initcall(ssb_modinit);
 
 static void __exit ssb_modexit(void)
-- 
2.17.1

