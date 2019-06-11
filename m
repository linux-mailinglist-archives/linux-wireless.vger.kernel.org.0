Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B273C496
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfFKG6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:58:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:33661 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403964AbfFKG6h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:58:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B6wCTA031913;
        Tue, 11 Jun 2019 01:58:14 -0500
Message-ID: <fdfc817d1dcdc83f5bc45f0ab12cbce0c61e6702.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 16:58:12 +1000
In-Reply-To: <20190611060816.GA20158@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
         <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
         <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org>
         <3ed1ccfe-d7ca-11b9-17b3-303d1ae1bb0f@lwfinger.net>
         <c91ccbddd6a58dbee5705f10ed1d98fb44bd8f8d.camel@kernel.crashing.org>
         <20190611060816.GA20158@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-11 at 08:08 +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 03:56:33PM +1000, Benjamin Herrenschmidt
> wrote:
> > The reason I think it sort-of-mostly-worked is that to get more
> > than
> > 1GB of RAM, those machines use CONFIG_HIGHMEM. And *most* network
> > buffers aren't allocated in Highmem.... so you got lucky.
> > 
> > That said, there is such as thing as no-copy send on network, so I
> > wouldn't be surprised if some things would still have failed, just
> > not
> > frequent enough for you to notice.
> 
> Unless NETIF_F_HIGHDMA is set on a netdev, the core networkign code
> will bounce buffer highmem pages for the driver under all
> circumstances.

 ... which b43legacy doesn't set to the best of my knowledge ...

Which makes me wonder how come it didn't work even with your patches ?
AFAIK, we have less than 1GB of lowmem unless the config has been
tweaked....

Cheers,
Ben.


