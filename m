Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2236DCD4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhD1QTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbhD1QTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 12:19:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF435C061573;
        Wed, 28 Apr 2021 09:18:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s22so23975894pgk.6;
        Wed, 28 Apr 2021 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=4KdFCe/NpGrn4wFl2jm3JV8cEJkLdQPsCStGpRUg9EY=;
        b=LXufmLPp2PIqrGeDr0IeJ2QF7Lz9fr5UQRJ7GSCUVa/AAs6tmTTkBa89A3YTz90wdM
         DbfdbvQ3KQttYQE7Ld90tCD1rynzLWjMEmXWSiiskL4hkQN/l2/o90BALpwC3TNKvW7a
         v6xrjVz0pP0C+Z9C6Si4rI/eqNFJCnzfZ8o8hLmF68tEM4HGH29tUbxZNRljNqj1Vvbt
         zH00Ed7L8zs0T54wJ0UwXA5Q2mal69lNjGZCptnfu5tmdFIvdvc6neugJVERkmyt8V2V
         HvlpWo5weR3UBlNVCrLHaPdoZOKcKJpr3gthc/cCyWJ9qqDPSR3t3JnWprxAs/ZrGAXu
         ng2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=4KdFCe/NpGrn4wFl2jm3JV8cEJkLdQPsCStGpRUg9EY=;
        b=Zk84884AySYtRwL6ULuwHTogNkQxF62BYUB0KSBHWCF7xXL0cRHcGLTXcZkMmuWYXZ
         /ZtkGGETEFSFyaxoOINSfY0epUbIhi8T0bpmug4xYsT2ia5ZUS8yPgP9HIvO1s9wHB5u
         vNVek1zh8U1zD0Lvah1b2nKttIQwPGew4s2dKk5gc06M+DeI+HzH0Fnpp1MPksAdvVHC
         Lu7HiSftItygFvpn78TfiM1NPo5Wc+yvkZ0RvmD5ozi2n2ero3aioZgueQZBeyWmSK90
         vCMN5UH4q1377nMZ/wSrO4ypikJUU16nPqB40F92AOlsvyniD9PSDMs/+6jVZ7KIxV16
         i3dw==
X-Gm-Message-State: AOAM530/NenDH1h/9mNpR3/H7/D6Yo0/4gHJRU3axfaF2CNNvoLFv+f5
        fnsAUCyYjF0zar0ZbUc2oKeudloFLMIr+28P
X-Google-Smtp-Source: ABdhPJykHrCXKoJsVZqkZ0d/ZmlR4vixNwf3QGMDo2xrA6UBQ2d/02w1TcOobp78boSfZMVfbJCdkQ==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr27197697pgc.230.1619626726139;
        Wed, 28 Apr 2021 09:18:46 -0700 (PDT)
Received: from localhost ([157.45.42.123])
        by smtp.gmail.com with ESMTPSA id mp3sm78151pjb.15.2021.04.28.09.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 09:18:45 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:48:36 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: ssb: driver_pcicore.c: Fix indentation of comment
Message-ID: <20210428161836.sdrxzcrfiekloucz@kewl-virtual-machine>
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
 drivers/ssb/driver_pcicore.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
index c1186415896b..d11b4242b6d2 100644
--- a/drivers/ssb/driver_pcicore.c
+++ b/drivers/ssb/driver_pcicore.c
@@ -55,7 +55,8 @@ void pcicore_write16(struct ssb_pcicore *pc, u16 offset, u16 value)
 #include <asm/paccess.h>
 /* Probe a 32bit value on the bus and catch bus exceptions.
  * Returns nonzero on a bus exception.
- * This is MIPS specific */
+ * This is MIPS specific
+ */
 #define mips_busprobe32(val, addr)	get_dbe((val), ((u32 *)(addr)))
 
 /* Assume one-hot slot wiring */
@@ -255,7 +256,8 @@ static struct pci_controller ssb_pcicore_controller = {
 };
 
 /* This function is called when doing a pci_enable_device().
- * We must first check if the device is a device on the PCI-core bridge. */
+ * We must first check if the device is a device on the PCI-core bridge.
+ */
 int ssb_pcicore_plat_dev_init(struct pci_dev *d)
 {
 	if (d->bus->ops != &ssb_pcicore_pciops) {
@@ -381,11 +383,13 @@ static void ssb_pcicore_init_hostmode(struct ssb_pcicore *pc)
 
 	/* Ok, ready to run, register it to the system.
 	 * The following needs change, if we want to port hostmode
-	 * to non-MIPS platform. */
+	 * to non-MIPS platform.
+	 */
 	ssb_pcicore_controller.io_map_base = (unsigned long)ioremap(SSB_PCI_MEM, 0x04000000);
 	set_io_port_base(ssb_pcicore_controller.io_map_base);
 	/* Give some time to the PCI controller to configure itself with the new
-	 * values. Not waiting at this point causes crashes of the machine. */
+	 * values. Not waiting at this point causes crashes of the machine.
+	 */
 	mdelay(10);
 	register_pci_controller(&ssb_pcicore_controller);
 }
@@ -405,7 +409,8 @@ static int pcicore_is_in_hostmode(struct ssb_pcicore *pc)
 		return 0;
 
 	/* The 200-pin BCM4712 package does not bond out PCI. Even when
-	 * PCI is bonded out, some boards may leave the pins floating. */
+	 * PCI is bonded out, some boards may leave the pins floating.
+	 */
 	if (bus->chip_id == 0x4712) {
 		if (bus->chip_package == SSB_CHIPPACK_BCM4712S)
 			return 0;
@@ -685,7 +690,8 @@ int ssb_pcicore_dev_irqvecs_enable(struct ssb_pcicore *pc,
 	if (dev->bus->bustype != SSB_BUSTYPE_PCI) {
 		/* This SSB device is not on a PCI host-bus. So the IRQs are
 		 * not routed through the PCI core.
-		 * So we must not enable routing through the PCI core. */
+		 * So we must not enable routing through the PCI core.
+		 */
 		goto out;
 	}
 
-- 
2.17.1

