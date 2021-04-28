Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12B736D310
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhD1HZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhD1HZp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 03:25:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A0C061574;
        Wed, 28 Apr 2021 00:25:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so6401385plf.12;
        Wed, 28 Apr 2021 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xQY7nvOaiG9v/WUqozQwxPw+zWAFowJJ3OP9IATo7gs=;
        b=Eg6nmcnI/wnQ3WwW9sQ08P/ECUinji/qPkNhavXMmXA3879sS/wcxKAOXpRslPp8e2
         HefZ52KeP4jefvtruI8bMHwkTgxUHqqnldYf9qaB5pR/Q39gnWKLKr8B6fkbfCl3nDp2
         0Xijh/43gqvZAGZJAxecMluL+xzQ95XP+fwQnvSf9IuezTsmkxUqubOOLB9Nv0zMMC8k
         haJnNLAiboRwK5RN+c3/HewmCuA0StIEEjKD+o+BvADCagzK5nU9cdxAtsHC3Rw54CNK
         iUoLfxauZR8PUPUVgOGt4LKoq6sAwvB+rtzoAdKcUl6RUUP0zhHNlzkzDvo+HGViY/XL
         3xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xQY7nvOaiG9v/WUqozQwxPw+zWAFowJJ3OP9IATo7gs=;
        b=gWBn+2q3QKIJVvKIePB+16rXPRIqEZPtVenQc9r7EJQa2Ap43QyNj4x88PHxQQXQWb
         vQX/KjGiVN9Dy4elDZX0GdxBZwZtZ2irDGDYDlbu+N/+NXgq7pbVKK9Tm3IbF9brFRWx
         FvFbEWOE2i8bRwQwL3q8+mQd+AkcdczRagBTfHQwAoChZGNdSIJpAQk96V8xGwMAC2qu
         pSuYZwtmYickPiZR1/qmMRZOz9b0Oj+h0EJFpUe3SSHNDf8CjZLvI7r/b7C0yKy9ttPV
         tep3cE0AVooFlACH8MkaS1llpS++EGzKqJWzv4UlO+vMvjpaGNncTsoqlCp2rdhYuXEu
         +UIw==
X-Gm-Message-State: AOAM533qXtaqFbqfOwcdvhSBMY9S0KsV+3RXzfzcs4ZX4PAMwggzPk2E
        rHhUKtmTxZwcVXdu+sU7Npk=
X-Google-Smtp-Source: ABdhPJz0HUnvgQ6xALDLF8dqETWfykTHExSQkMKbJatqMLIDKRjkpNAspveM6kF4ZAuHdRDut/p7GA==
X-Received: by 2002:a17:902:da8c:b029:ec:f02d:fcce with SMTP id j12-20020a170902da8cb02900ecf02dfccemr22899747plx.0.1619594701029;
        Wed, 28 Apr 2021 00:25:01 -0700 (PDT)
Received: from localhost ([157.45.190.127])
        by smtp.gmail.com with ESMTPSA id h9sm4265298pfv.14.2021.04.28.00.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 00:25:00 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:54:53 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com, shubhankar.vk@gmail.com
Subject: [PATCH] drivers: ssb: main.c: Fix indentation of comment
Message-ID: <20210428072453.obrjwxus3u2ytpgn@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shifted the closing */ to the next line
This is done to maintain code uniformity.

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

