Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D113C6F5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbfFKJEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 05:04:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:39418 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404619AbfFKJEt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 05:04:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B949Tk006245;
        Tue, 11 Jun 2019 04:04:10 -0500
Message-ID: <2226c252d2dfa7973bcc298d5bf9521d1e3c5827.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 19:04:09 +1000
In-Reply-To: <20190611075439.GB21815@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
         <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
         <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org>
         <3ed1ccfe-d7ca-11b9-17b3-303d1ae1bb0f@lwfinger.net>
         <c91ccbddd6a58dbee5705f10ed1d98fb44bd8f8d.camel@kernel.crashing.org>
         <20190611060816.GA20158@lst.de>
         <fdfc817d1dcdc83f5bc45f0ab12cbce0c61e6702.camel@kernel.crashing.org>
         <b30ced162fa96d0ca63b8b9629d6fe9bc5c78746.camel@kernel.crashing.org>
         <20190611075439.GB21815@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-11 at 09:54 +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:59:54PM +1000, Benjamin Herrenschmidt
> wrote:
> > Ah stupid me ... it's dma_set_mask that failed, since it has no
> > idea
> > that the calling driver is limited to lowmem.
> > 
> > That's also why the "wrong" patch worked.
> > 
> > So yes, a ZONE_DMA at 30-bits will work, though it's somewhat
> > overkill.
> 
> Well, according to Larry it doesn't actually work, which is odd.

Oh I assume that's just a glitch in the patch :-)

Cheers,
Ben.


