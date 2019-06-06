Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA08C37336
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfFFLn4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 07:43:56 -0400
Received: from verein.lst.de ([213.95.11.211]:49104 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfFFLn4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 07:43:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C2C8268B20; Thu,  6 Jun 2019 13:43:26 +0200 (CEST)
Date:   Thu, 6 Jun 2019 13:43:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190606114325.GA7497@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org> <20190606093149.GA11598@darkstar.musicnaut.iki.fi> <d87ac9a7faac0d5522cb496d74afc586410fed9c.camel@kernel.crashing.org> <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 06, 2019 at 08:57:49PM +1000, Benjamin Herrenschmidt wrote:
> > Wow... that's an odd amount. One thing we could possibly do is add code
> > to limit the amount of RAM when we detect that device....
> 
> Sent too quickly... I mean that *or* force swiotlb at 30-bits on those systems based
> on detecting the presence of that device in the device-tree.

swiotlb doesn't really help you, as these days swiotlb on matters for
the dma_map* case.  What would help is a ZONE_DMA that covers these
devices.  No need to do the 24-bit x86 does, but 30-bit would do it.

WIP patch for testing below:

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b8286a2013b4..7a367ce87c41 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -319,6 +319,10 @@ struct vm_area_struct;
 #endif /* __ASSEMBLY__ */
 #include <asm/slice.h>
 
+#if 1 /* XXX: pmac?  dynamic discovery? */
+#define ARCH_ZONE_DMA_BITS 30
+#else
 #define ARCH_ZONE_DMA_BITS 31
+#endif
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index cba29131bccc..2540d3b2588c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -248,7 +248,8 @@ void __init paging_init(void)
 	       (long int)((top_of_ram - total_ram) >> 20));
 
 #ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
+	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
+			((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
