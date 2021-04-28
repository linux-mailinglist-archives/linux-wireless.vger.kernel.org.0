Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34F936D35F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhD1Hp0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Hp0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 03:45:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689DC061574;
        Wed, 28 Apr 2021 00:44:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so6441517pjz.0;
        Wed, 28 Apr 2021 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hgRf+WY3My77y9MGaOayXQDhKbTAR0DxBOTc0y4LwQ4=;
        b=KqwWZkWiWZv2dJz+SYjb6uB0Fbq3FKHWMaN5zanPYFIHQ+qo1m4K9xbzCyffMLC3W/
         lTPRexHGNaBpThWC/VQXupVpLUMQGPBZ8DZfV5QEhWv7tRQ0KCgv+xqq5SmceWhyrCuO
         q7AkvOgKKTGauJuqTO1IrzoPBgIOmoOCsTDFrzaXY3Wvk37l+E/StJJJ2n+TtselAiB4
         ZhssSI6/dIUFxP8gweob9dPilbGhXGVotBRuU9igkiOo2tH0dH3v2Ds/Rqa8fXlOoHVX
         Sc9p/tWZ82/IKSm8KBrcgbDzSd3TPCszG+f7pULzoLLlmfadqhinl0PXmIfaYA2MpujC
         xk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hgRf+WY3My77y9MGaOayXQDhKbTAR0DxBOTc0y4LwQ4=;
        b=qhmaETH30SRcpJ550xmIEOWk9zIbjOmA1i1ZRR7uG3ZR06x/jx7gAajxtF8CUrcnIr
         8DjGgnZ9WNLaDt6X5GIDEwyYq9nS3Fa06i5XgKW+VN7jth7QfKvt/eOp8/pxlulMaLwn
         PtbxYvWbu8lfRRqLqfQfyMMAiOPVKWwjl5+6nL7iVnPRb5cl+scV6gR56voLr2SyuAgm
         l24ucpTrTAt8YzEBvvOTgsktL5rVbWyEUNk9OXDBqSPeugqg2Mch5bU8K0o7W5eLrth3
         jOdDH3yCqIA+iWCu3TL99nCTmD4XVRgHmQSuc5xy4xm5NrElQ8iSoj7bp4xEfSzllT1j
         KEXg==
X-Gm-Message-State: AOAM533WA09QXYz3309UbscIEja/9ce0mT0qVzbOOkGmx674AgDubjZb
        UQNYkjDus6T55rEtfpGJ9kc=
X-Google-Smtp-Source: ABdhPJxQivr8przk/O7Nfn1Rhgo7tH9OnYpCvEnkYw1vXmfxseWl5v/8b84jdkSgjxWbGQwMbovLhg==
X-Received: by 2002:a17:90a:e649:: with SMTP id ep9mr742579pjb.8.1619595880059;
        Wed, 28 Apr 2021 00:44:40 -0700 (PDT)
Received: from localhost ([157.45.190.127])
        by smtp.gmail.com with ESMTPSA id w1sm4133269pfu.153.2021.04.28.00.44.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 00:44:39 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:14:32 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: ssb: driver_pcicore.c: Fix indentation of comment
Message-ID: <20210428074432.rhw4zq2vbdemglbr@kewl-virtual-machine>
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

