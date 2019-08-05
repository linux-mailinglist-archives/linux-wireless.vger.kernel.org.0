Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6581634
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfHEKBQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 06:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfHEKBP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 06:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D4FBCA36F;
        Mon,  5 Aug 2019 10:01:15 +0000 (UTC)
Received: from localhost (ovpn-204-27.brq.redhat.com [10.40.204.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E61431001B02;
        Mon,  5 Aug 2019 10:01:12 +0000 (UTC)
Date:   Mon, 5 Aug 2019 12:01:11 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190805100110.GA17889@redhat.com>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
 <20190731081957.GA4096@redhat.com>
 <20190731085147.GB4096@redhat.com>
 <20190731090927.GA3665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731090927.GA3665@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 10:01:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 31, 2019 at 11:09:27AM +0200, Lorenzo Bianconi wrote:
> > On Wed, Jul 31, 2019 at 10:19:58AM +0200, Stanislaw Gruszka wrote:
> > > On Tue, Jul 30, 2019 at 04:55:31PM +0200, Lorenzo Bianconi wrote:
> > > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > index 467b28379870..622251faa415 100644
> > > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
> > > > > > >  					       mt76.tx_napi);
> > > > > > >  	int i;
> > > > > > >  
> > > > > > > -	mt76x02_mac_poll_tx_status(dev, false);
> > > > > > > +	mt76x02_mac_poll_tx_status(dev, true);
> > > > > > 
> > > > > > I am not sure if we really need mt76x02_mac_poll_tx_status() here since we run
> > > > > > it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyway the only
> > > > > > difference doing so is we do not run mt76x02_send_tx_status().
> > > > > 
> > > > > I thought this is the problem, but it was my mistake during testing.
> > > > > I tested the above change together with mt76_txq_schedule(dev, txq->ac)
> > > > > change and get wrong impression it fixes the issue. But above change
> > > > > alone does not help.
> > > > > 
> > > > > I tried to add some locking to avoid parallel execution of mt76x02_poll_tx()
> > > > > and mt76x02_tx_tasklet(), but it didn't help either. So far only patch
> > > > > originally posted here make the problem gone.
> > > > 
> > > > so, in order to be on the same page, if you comment out mt76x02_mac_poll_tx_status()
> > > > in mt76x02_poll_tx() the issue will still occur. The only to 'fix' it is to run
> > > > mt76_txq_schedule_all() in mt76x02_poll_tx(), right?
> > > 
> > > Yes.
> > 
> > Err, no, I should read more cerfully. It is partiall revert of 
> > 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet") : 
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> > index 5397827668b9..fefe0ee52584 100644
> > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > @@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
> >         if (!test_bit(MT76_STATE_RUNNING, &dev->state))
> >                 return;
> >  
> > -       tasklet_schedule(&dev->tx_tasklet);
> > +       mt76_txq_schedule(dev, txq->ac);
> >  }
> >  EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
> 
> reviewing the code I think:
> 
> - we should not run mt76u_tx_tasklet() from mt76_wake_tx_queue() since we do
>   not have tx_napi for usb and it will unnecessary go through tx queue checks.
>   We should probably do in mt76_wake_tx_queue() something like:
> 
>   if (is_mmio())

Adding '&& !is_mt7630()' will solve the problem for MT7630E as well ...

> 	  tasklet_schedule(&dev->tx_tasklet);
>   else
> 	  mt76_txq_schedule(dev, txq->ac);
> 
>   Another solution would be add a status_tasklet that just goes through the tx
>   queues receiving the usb tx completion and it schedules the tx_tasklet
>   What do you think?
> 
> - I guess it does not fix the 76x0e issue but we should just schedule tx queues in
>   mt76x02_tx_tasklet() (like it is done for mt7603 and mt7615) and move status
>   processing in mt76x02_poll_tx()

... but I think we have bug when do mt76_txq_schedule_all() in
tx_tasklet, because we can schedule on queues that are stoped.
So reverting 41634aa8d6db and then optimize by removing tx_tasklet
for mmio and remove not needed mt76_txq_schedule_all() calls looks
more reasoneble to me.
 
Stanislaw 
