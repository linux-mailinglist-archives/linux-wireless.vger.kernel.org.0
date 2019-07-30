Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913587AA37
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfG3Ny4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 09:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfG3Ny4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 09:54:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA3388553F;
        Tue, 30 Jul 2019 13:54:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BC5860856;
        Tue, 30 Jul 2019 13:54:52 +0000 (UTC)
Date:   Tue, 30 Jul 2019 15:54:51 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190730135450.GA2361@redhat.com>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729140241.GC4030@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 30 Jul 2019 13:54:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 29, 2019 at 04:02:41PM +0200, Lorenzo Bianconi wrote:
> > On Fri, Jul 26, 2019 at 02:10:56PM +0200, Stanislaw Gruszka wrote:
> > > Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> > > I can observe firmware hangs on MT7630E on station mode: tx stop
> > > functioning after minor activity (rx keep working) and on module
> > > unload device fail to stop with messages:
> > > 
> > > [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> > > [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> > > 
> > > Loading module again results in failure to associate with AP.
> > > Only machine power off / power on cycle can make device work again.
> > > 
> > > I have no idea why the commit caused F/W hangs. Most likely some proper
> > > fix is needed of changing registers programming (or assuring proper order
> > > of actions), but so far I can not came up with any better fix than
> > > a partial revert of 41634aa8d6db.
> > 
> > The difference is that with 41634aa8d6db we can run mt76x02_poll_tx()
> > and mt76x02_tx_tasklet() in parallel on 2 different CPUs. Without
> > the commit, since tasklet is not scheduled from mt76_wake_tx_queue(),
> > it does not happen.
> > 
> > I'm not quite sure why, but MT7630E does not like when we poll tx status
> > on 2 cpus at once. Change like below:
> 
> Hi Stanislaw,

Hi

> have you tried to look at the commit: 6fe533378795f87
> ("mt76: mt76x02: remove irqsave/restore in locking for tx status fifo")?
> Could it be a race between a registermap update and a stats load? (we are using a
> different lock now)

This commit seems to be fine, reverting it did not solve the issue.

> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > index 467b28379870..622251faa415 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
> >  					       mt76.tx_napi);
> >  	int i;
> >  
> > -	mt76x02_mac_poll_tx_status(dev, false);
> > +	mt76x02_mac_poll_tx_status(dev, true);
> 
> I am not sure if we really need mt76x02_mac_poll_tx_status() here since we run
> it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyway the only
> difference doing so is we do not run mt76x02_send_tx_status().

I thought this is the problem, but it was my mistake during testing.
I tested the above change together with mt76_txq_schedule(dev, txq->ac)
change and get wrong impression it fixes the issue. But above change
alone does not help.

I tried to add some locking to avoid parallel execution of mt76x02_poll_tx()
and mt76x02_tx_tasklet(), but it didn't help either. So far only patch
originally posted here make the problem gone.

Stanislaw

