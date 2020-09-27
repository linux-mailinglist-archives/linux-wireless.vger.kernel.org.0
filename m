Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D727A39A
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgI0UAZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 16:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41624 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgI0T52 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 15:57:28 -0400
Message-Id: <20200927194921.454020115@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601236645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nEdxrHzmEZ13nc2oNAX4mlZl848es00xkT/DnJHA5RU=;
        b=ibSynXzNFO24Tr+9mg9CXt5EtKiOcQOu6V+70RX3ktyhWeVX/mh8yC4e7VKa9o+57Capkj
        KhAWmT+9NH/kiSAKQWbRNfrwXJSfqUQIIgwqWaNAptujCvdwBy3v9Et11/IKP/zJH5Pclb
        8ZbPidNYRCIECUt2qnjfkf4v2JwYhqC/T8VEOiCeWQRjnIYDMg1Sxb6O0oTFw8zDUFRdUX
        5ikkLCLQod9OvgM8+5f6VGE5fFEBxbjLkAl+jK/BRvgHR+W+1leJSduGhEdpl5a2HbciY1
        ywv3iCDrWrYyuYcB9ZmvZA22aq92oipmto6n+2gX1YQkd5OQjgkNgcDb+QA+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601236645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nEdxrHzmEZ13nc2oNAX4mlZl848es00xkT/DnJHA5RU=;
        b=r7tOoEsYPpAyx40OdwJ0cukY0N3wA8XromAerzwrBBcIuUAvAIEt2D90A1YdSbKuPruQ8y
        EaBYrjJM5fK8whAg==
Date:   Sun, 27 Sep 2020 21:49:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Dave Miller <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        Vishal Kulkarni <vishal@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Shannon Nelson <snelson@pensando.io>,
        Pensando Drivers <drivers@pensando.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        Jon Mason <jdmason@kudzu.us>, Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jouni Malinen <j@w1.fi>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        libertas-dev@lists.infradead.org,
        Pascal Terjan <pterjan@google.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [patch 16/35] net: sunbmac: Replace in_interrupt() usage
References: <20200927194846.045411263@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

bigmac_init_rings() has an argument signaling if it is called from the
interrupt handler. This is used to decide between GFP_KERNEL and GFP_ATOMIC
for memory allocations.

But it also checks in_interrupt() to handle invocations which come from the
timer callback bigmac_timer() via bigmac_hw_init(), which is invoked with
'in_irq = 0'. While the timer callback is clearly not in hard interrupt
context it is still not sleepable context.

Rename the argument to `non_blocking' and set it to true if invoked from
the timer callback or the interrupt handler which allows to remove the
in_interrupt() check and makes the code consistent.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org

---
 drivers/net/ethernet/sun/sunbmac.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -209,13 +209,13 @@ static void bigmac_clean_rings(struct bi
 	}
 }
 
-static void bigmac_init_rings(struct bigmac *bp, int from_irq)
+static void bigmac_init_rings(struct bigmac *bp, bool non_blocking)
 {
 	struct bmac_init_block *bb = bp->bmac_block;
 	int i;
 	gfp_t gfp_flags = GFP_KERNEL;
 
-	if (from_irq || in_interrupt())
+	if (non_blocking)
 		gfp_flags = GFP_ATOMIC;
 
 	bp->rx_new = bp->rx_old = bp->tx_new = bp->tx_old = 0;
@@ -489,7 +489,7 @@ static void bigmac_tcvr_init(struct bigm
 	}
 }
 
-static int bigmac_init_hw(struct bigmac *, int);
+static int bigmac_init_hw(struct bigmac *, bool);
 
 static int try_next_permutation(struct bigmac *bp, void __iomem *tregs)
 {
@@ -549,7 +549,7 @@ static void bigmac_timer(struct timer_li
 				if (ret == -1) {
 					printk(KERN_ERR "%s: Link down, cable problem?\n",
 					       bp->dev->name);
-					ret = bigmac_init_hw(bp, 0);
+					ret = bigmac_init_hw(bp, true);
 					if (ret) {
 						printk(KERN_ERR "%s: Error, cannot re-init the "
 						       "BigMAC.\n", bp->dev->name);
@@ -617,7 +617,7 @@ static void bigmac_begin_auto_negotiatio
 	add_timer(&bp->bigmac_timer);
 }
 
-static int bigmac_init_hw(struct bigmac *bp, int from_irq)
+static int bigmac_init_hw(struct bigmac *bp, bool non_blocking)
 {
 	void __iomem *gregs        = bp->gregs;
 	void __iomem *cregs        = bp->creg;
@@ -635,7 +635,7 @@ static int bigmac_init_hw(struct bigmac
 	qec_init(bp);
 
 	/* Alloc and reset the tx/rx descriptor chains. */
-	bigmac_init_rings(bp, from_irq);
+	bigmac_init_rings(bp, non_blocking);
 
 	/* Initialize the PHY. */
 	bigmac_tcvr_init(bp);
@@ -749,7 +749,7 @@ static void bigmac_is_medium_rare(struct
 	}
 
 	printk(" RESET\n");
-	bigmac_init_hw(bp, 1);
+	bigmac_init_hw(bp, true);
 }
 
 /* BigMAC transmit complete service routines. */
@@ -921,7 +921,7 @@ static int bigmac_open(struct net_device
 		return ret;
 	}
 	timer_setup(&bp->bigmac_timer, bigmac_timer, 0);
-	ret = bigmac_init_hw(bp, 0);
+	ret = bigmac_init_hw(bp, false);
 	if (ret)
 		free_irq(dev->irq, bp);
 	return ret;
@@ -945,7 +945,7 @@ static void bigmac_tx_timeout(struct net
 {
 	struct bigmac *bp = netdev_priv(dev);
 
-	bigmac_init_hw(bp, 0);
+	bigmac_init_hw(bp, true);
 	netif_wake_queue(dev);
 }
 

