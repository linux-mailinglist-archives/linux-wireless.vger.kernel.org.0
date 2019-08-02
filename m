Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908FD7F647
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392479AbfHBL6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:58:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHBL6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:58:45 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htWCm-0005a2-Oa; Fri, 02 Aug 2019 13:58:40 +0200
Date:   Fri, 2 Aug 2019 13:58:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-wireless@vger.kernel.org
cc:     Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        b43-dev@lists.infradead.org
Subject: [PATCH V2] b43legacy: Remove pointless cond_resched() wrapper
Message-ID: <alpine.DEB.2.21.1908021353190.3924@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cond_resched() can be used unconditionally. If CONFIG_PREEMPT is set, it
becomes a NOP scheduler wise.

Also the B43_BUG_ON() in that wrapper is a homebrewn variant of
__might_sleep() which is part of cond_resched() already.

Remove the cruft and invoke cond_resched() directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
---
V2: Resend to wireless. Picked up Larry's tags
---
 drivers/net/wireless/broadcom/b43legacy/phy.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

--- a/drivers/net/wireless/broadcom/b43legacy/phy.c
+++ b/drivers/net/wireless/broadcom/b43legacy/phy.c
@@ -69,17 +69,6 @@ static const s8 b43legacy_tssi2dbm_g_tab
 
 static void b43legacy_phy_initg(struct b43legacy_wldev *dev);
 
-
-static inline
-void b43legacy_voluntary_preempt(void)
-{
-	B43legacy_BUG_ON(!(!in_atomic() && !in_irq() &&
-			  !in_interrupt() && !irqs_disabled()));
-#ifndef CONFIG_PREEMPT
-	cond_resched();
-#endif /* CONFIG_PREEMPT */
-}
-
 /* Lock the PHY registers against concurrent access from the microcode.
  * This lock is nonrecursive. */
 void b43legacy_phy_lock(struct b43legacy_wldev *dev)
@@ -1124,7 +1113,7 @@ static u16 b43legacy_phy_lo_b_r15_loop(s
 		ret += b43legacy_phy_read(dev, 0x002C);
 	}
 	local_irq_restore(flags);
-	b43legacy_voluntary_preempt();
+	cond_resched();
 
 	return ret;
 }
@@ -1253,7 +1242,7 @@ u16 b43legacy_phy_lo_g_deviation_subval(
 	}
 	ret = b43legacy_phy_read(dev, 0x002D);
 	local_irq_restore(flags);
-	b43legacy_voluntary_preempt();
+	cond_resched();
 
 	return ret;
 }
@@ -1591,7 +1580,7 @@ void b43legacy_phy_lo_g_measure(struct b
 			b43legacy_radio_write16(dev, 0x43, i);
 			b43legacy_radio_write16(dev, 0x52, phy->txctl2);
 			udelay(10);
-			b43legacy_voluntary_preempt();
+			cond_resched();
 
 			b43legacy_phy_set_baseband_attenuation(dev, j * 2);
 
@@ -1642,7 +1631,7 @@ void b43legacy_phy_lo_g_measure(struct b
 					      phy->txctl2
 					      | (3/*txctl1*/ << 4));
 			udelay(10);
-			b43legacy_voluntary_preempt();
+			cond_resched();
 
 			b43legacy_phy_set_baseband_attenuation(dev, j * 2);
 
@@ -1665,7 +1654,7 @@ void b43legacy_phy_lo_g_measure(struct b
 		b43legacy_phy_write(dev, 0x0812, (r27 << 8) | 0xA2);
 		udelay(2);
 		b43legacy_phy_write(dev, 0x0812, (r27 << 8) | 0xA3);
-		b43legacy_voluntary_preempt();
+		cond_resched();
 	} else
 		b43legacy_phy_write(dev, 0x0015, r27 | 0xEFA0);
 	b43legacy_phy_lo_adjust(dev, is_initializing);
