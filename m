Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678A14445D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfFMQgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:36:31 -0400
Received: from verein.lst.de ([213.95.11.211]:36328 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbfFMHaJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 03:30:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 504D068B02; Thu, 13 Jun 2019 09:29:37 +0200 (CEST)
Date:   Thu, 13 Jun 2019 09:29:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190613072937.GA12093@lst.de>
References: <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net> <20190607172902.GA8183@lst.de> <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net> <20190610081825.GA16534@lst.de> <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net> <20190611060521.GA19512@lst.de> <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net> <20190612065558.GA19585@lst.de> <d6d82c0d-4a40-a191-0414-6b9a64547f65@lwfinger.net> <05db995c55ad7c1002124374c139d2c0812ad034.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05db995c55ad7c1002124374c139d2c0812ad034.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 13, 2019 at 07:59:51AM +1000, Benjamin Herrenschmidt wrote:
> > With the patch for Kconfig above, and the original patch setting 
> > ARCH_ZONE_DMA_BITS to 30, everything works.
> > 
> > Do you have any ideas on what should trigger the change in ARCH_ZONE_BITS? 
> > Should it be CONFIG_PPC32 defined, or perhaps CONFIG_G4_CPU defined?
> 
> I think CONFIG_PPC32 is fine

I'll cook up a patch unless someone beats me to it.
