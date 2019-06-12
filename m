Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3282F44916
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfFMRNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 13:13:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:60838 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfFLWAO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 18:00:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CLxqNj012272;
        Wed, 12 Jun 2019 16:59:53 -0500
Message-ID: <05db995c55ad7c1002124374c139d2c0812ad034.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 07:59:51 +1000
In-Reply-To: <d6d82c0d-4a40-a191-0414-6b9a64547f65@lwfinger.net>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
         <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
         <20190607172902.GA8183@lst.de>
         <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
         <20190610081825.GA16534@lst.de>
         <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
         <20190611060521.GA19512@lst.de>
         <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
         <20190612065558.GA19585@lst.de>
         <d6d82c0d-4a40-a191-0414-6b9a64547f65@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-12 at 14:41 -0500, Larry Finger wrote:
> On 6/12/19 1:55 AM, Christoph Hellwig wrote:
> > 
> > Ooops, yes.  But I think we could just enable ZONE_DMA on 32-bit
> > powerpc.  Crude enablement hack below:
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 8c1c636308c8..1dd71a98b70c 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -372,7 +372,7 @@ config PPC_ADV_DEBUG_DAC_RANGE
> >    
> >    config ZONE_DMA
> >        bool
> > -     default y if PPC_BOOK3E_64
> > +     default y
> >    
> >    config PGTABLE_LEVELS
> >        int
> > 
> 
> With the patch for Kconfig above, and the original patch setting 
> ARCH_ZONE_DMA_BITS to 30, everything works.
> 
> Do you have any ideas on what should trigger the change in ARCH_ZONE_BITS? 
> Should it be CONFIG_PPC32 defined, or perhaps CONFIG_G4_CPU defined?

I think CONFIG_PPC32 is fine

Ben.

