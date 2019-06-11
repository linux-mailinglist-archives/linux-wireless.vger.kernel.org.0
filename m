Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B737A3C3C3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfFKGFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:05:53 -0400
Received: from verein.lst.de ([213.95.11.211]:48358 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391051AbfFKGFx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:05:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 98BEE68B20; Tue, 11 Jun 2019 08:05:22 +0200 (CEST)
Date:   Tue, 11 Jun 2019 08:05:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190611060521.GA19512@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net> <20190607172902.GA8183@lst.de> <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net> <20190610081825.GA16534@lst.de> <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 10, 2019 at 11:09:47AM -0500, Larry Finger wrote:
>>>                  return -EIO;
>>>
>>> For b43legacy, dev->dma_mask is 0xc265684800000000.
>>>      dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x3fffffff, and
>>> the routine returns -EIO.
>>>
>>> For b43,       dev->dma_mask is 0xc265684800000001,
>>>      dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x77777777, and
>>> the routine returns 0.
>>
>> I don't fully understand what values the above map to.  Can you send
>> me your actual debugging patch as well?
>
> I do not understand why the if statement returns true as neither of the 
> values is zero. After seeing the x86 output shown below, I also do not 
> understand all the trailing zeros.
>
> My entire patch is attached. That output came from this section:

What might be confusing in your output is that dev->dma_mask is a pointer,
and we are setting it in dma_set_mask.  That is before we only check
if the pointer is set, and later we override it.  Of course this doesn't
actually explain the failure.  But what is even more strange to me
is that you get a return value from dma_supported() that isn't 0 or 1,
as that function is supposed to return a boolean, and I really can't see
how mask >= __phys_to_dma(dev, min_mask), would return anything but 0
or 1.  Does the output change if you use the correct printk specifiers?

i.e. with a debug patch like this:


diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..9e5b30b12b10 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -378,6 +378,7 @@ EXPORT_SYMBOL(dma_direct_map_resource);
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 	u64 min_mask;
+	bool ret;
 
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
@@ -391,7 +392,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * use __phys_to_dma() here so that the SME encryption mask isn't
 	 * part of the check.
 	 */
-	return mask >= __phys_to_dma(dev, min_mask);
+	ret = (mask >= __phys_to_dma(dev, min_mask));
+	if (!ret)
+		dev_info(dev,
+			"%s: failed (mask = 0x%llx, min_mask = 0x%llx/0x%llx, dma bits = %d\n",
+			__func__, mask, min_mask, __phys_to_dma(dev, min_mask), ARCH_ZONE_DMA_BITS);
+	return ret;
 }
 
 size_t dma_direct_max_mapping_size(struct device *dev)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770..6c57ccdee2ae 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -317,8 +317,14 @@ void arch_dma_set_mask(struct device *dev, u64 mask);
 
 int dma_set_mask(struct device *dev, u64 mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, mask))
+	if (!dev->dma_mask) {
+		dev_info(dev, "no DMA mask set!\n");
 		return -EIO;
+	}
+	if (!dma_supported(dev, mask)) {
+		printk("DMA not supported\n");
+		return -EIO;
+	}
 
 	arch_dma_set_mask(dev, mask);
 	dma_check_mask(dev, mask);
