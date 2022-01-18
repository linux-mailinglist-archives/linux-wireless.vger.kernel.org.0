Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D79492D31
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbiARSW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 13:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244323AbiARSWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 13:22:25 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FBC061574;
        Tue, 18 Jan 2022 10:22:24 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3A92100002;
        Tue, 18 Jan 2022 18:22:17 +0000 (UTC)
Date:   Tue, 18 Jan 2022 19:22:15 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org Wireless" 
        <linux-wireless@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Xue Liu <liuxuenetmail@gmail.com>, Alan Ott <alan@signal11.us>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 17/41] net: ieee802154: at86rf230: Call the complete
 helper when a transmission is over
Message-ID: <20220118192215.3f380866@xps13>
In-Reply-To: <CAB_54W5Uu9_hpqmeL0MC+1ps=yfn2j0-o46cBL7BeBxKXKHa4w@mail.gmail.com>
References: <20220117115440.60296-1-miquel.raynal@bootlin.com>
        <20220117115440.60296-18-miquel.raynal@bootlin.com>
        <CAB_54W76X5vhaVMUv=s3e0pbWZgHRK3W=27N9m5LgEdLgAPAcA@mail.gmail.com>
        <CAB_54W5Uu9_hpqmeL0MC+1ps=yfn2j0-o46cBL7BeBxKXKHa4w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

alex.aring@gmail.com wrote on Mon, 17 Jan 2022 19:36:39 -0500:

> Hi,
> 
> On Mon, 17 Jan 2022 at 19:34, Alexander Aring <alex.aring@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, 17 Jan 2022 at 06:55, Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > >
> > > ieee802154_xmit_complete() is the right helper to call when a
> > > transmission is over. The fact that it completed or not is not really a
> > > question, but drivers must tell the core that the completion is over,
> > > even if it was canceled. Do not call ieee802154_wake_queue() manually,
> > > in order to let full control of this task to the core.
> > >
> > > By using the complete helper we also avoid leacking the skb structure.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/net/ieee802154/at86rf230.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> > > index 583f835c317a..1941e1f3d2ef 100644
> > > --- a/drivers/net/ieee802154/at86rf230.c
> > > +++ b/drivers/net/ieee802154/at86rf230.c
> > > @@ -343,7 +343,7 @@ at86rf230_async_error_recover_complete(void *context)
> > >         if (ctx->free)
> > >                 kfree(ctx);
> > >
> > > -       ieee802154_wake_queue(lp->hw);
> > > +       ieee802154_xmit_complete(lp->hw, lp->tx_skb, false);  
> >
> > also this lp->tx_skb can be a dangled pointer, after xmit_complete()
> > we need to set it to NULL in a xmit_error() we can check on NULL
> > before calling kfree_skb().
> >  
> 
> forget the NULL checking, it's already done by core. However in some
> cases this is called with a dangled pointer on lp->tx_skb.

I'll try to fix these dangling situation first if I find them.

I'll also introduce a xmit_error() helper as you suggest.

Thanks,
Miquèl
