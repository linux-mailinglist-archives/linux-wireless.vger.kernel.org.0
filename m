Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784B137F82
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfFFV0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 17:26:36 -0400
Received: from mx4.wp.pl ([212.77.101.12]:14857 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFFV0g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 17:26:36 -0400
Received: (wp-smtpd smtp.wp.pl 8131 invoked from network); 6 Jun 2019 23:26:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1559856391; bh=MoEhhcS56+Ul0wdDS33s9XPn3fvsVDzPk92eFDa6MSY=;
          h=From:To:Cc:Subject;
          b=GpWS5qrd8mbvrb2HQGuVjjBBY1gq2MLDrXPXMOUyl1uxDts1cY2CYXdsXXmdh9VDl
           Nq60wquUSxt9dyQBV3ovqojFKLytrRk0E/Zekf5VcEnMu7KCGs/n8PyMiOHja1NibU
           SKXF7Un9biLX847KEzYYBH0xIK0ulXsYQP/TR/WE=
Received: from 014.152-60-66-biz-static.surewest.net (HELO cakuba.netronome.com) (kubakici@wp.pl@[66.60.152.14])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lorenzo.bianconi@redhat.com>; 6 Jun 2019 23:26:31 +0200
Date:   Thu, 6 Jun 2019 14:26:22 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mt7601u: do not schedule rx_tasklet when the device has
 been disconnected
Message-ID: <20190606142622.7e5f11de@cakuba.netronome.com>
In-Reply-To: <CAJ0CqmUySwtgzPCFR0QsZ-XA7Lm7xU8eMsELV8LEd2MEkhfnLA@mail.gmail.com>
References: <a3c72b07e229e1d16e93438d741d69abba6a18cf.1559822991.git.lorenzo@kernel.org>
        <20190606114228.7a0ba115@cakuba.netronome.com>
        <CAJ0CqmUySwtgzPCFR0QsZ-XA7Lm7xU8eMsELV8LEd2MEkhfnLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 5aad7a902b5d09fef16868a9652ee52f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4YMU]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 6 Jun 2019 23:02:08 +0200, Lorenzo Bianconi wrote:
> > On Thu,  6 Jun 2019 14:26:12 +0200, Lorenzo Bianconi wrote:  
> Hi Jakub,
> 
> thx for the fast review :)

I guess I'm used to the 24h "review timeout" on netdev :)

> > Is this a new thing?  I def tested unplugging the dongle under
> > traffic, but that must had been in 3.19 days :S
> 
> I do not know if the issue has been introduced in recent kernel, I am
> able to trigger it in a vm running
> wireless-drivers-next and it has been reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=203249

I see.  I'm just worried that we make a mistake here and it will get
backported all the way back to very old kernels because of the fixes
tag.  If old kernels worked perhaps it's not worth disturbing them.

> > > Fixes: c869f77d6abb ("add mt7601u driver")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > I will post a patch to fix tx side as well
> > > ---
> > >  drivers/net/wireless/mediatek/mt7601u/dma.c | 33 ++++++++++-----------
> > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > index f7edeffb2b19..e7703990b291 100644
> > > --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > @@ -193,10 +193,20 @@ static void mt7601u_complete_rx(struct urb *urb)
> > >       struct mt7601u_rx_queue *q = &dev->rx_q;
> > >       unsigned long flags;
> > >
> > > -     spin_lock_irqsave(&dev->rx_lock, flags);
> > > +     switch (urb->status) {
> > > +     case -ECONNRESET:
> > > +     case -ESHUTDOWN:
> > > +     case -ENOENT:
> > > +             return;  
> >
> > So we assume this is non-recoverable?  Everything will fail after?
> > Because pending is incremented linearly :S  That's why there is a
> > warning here.  
> 
> AFAIK -ECONNRESET/-ENOENT are related to urb unlink/kill while
> -ESHUTDOWN is related to device disconnection.
> I guess we can assume the device has been removed if we get these errors

Makes sense.  A bit of an implicit assumption, USB subsystem may break
this for us.  Let's at least put a comment here so we can go back and
know that at the time of committing we did double check?

> > > +     default:
> > > +             dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
> > > +                                 urb->status);
> > > +             /* fall through */
> > > +     case 0:
> > > +             break;
> > > +     }
> > >
> > > -     if (mt7601u_urb_has_error(urb))
> > > -             dev_err(dev->dev, "Error: RX urb failed:%d\n", urb->status);
> > > +     spin_lock_irqsave(&dev->rx_lock, flags);
> > >       if (WARN_ONCE(q->e[q->end].urb != urb, "RX urb mismatch"))
> > >               goto out;
> > >
> > > @@ -363,19 +373,10 @@ int mt7601u_dma_enqueue_tx(struct mt7601u_dev *dev, struct sk_buff *skb,
> > >  static void mt7601u_kill_rx(struct mt7601u_dev *dev)
> > >  {
> > >       int i;
> > > -     unsigned long flags;
> > > -
> > > -     spin_lock_irqsave(&dev->rx_lock, flags);
> > >
> > > -     for (i = 0; i < dev->rx_q.entries; i++) {
> > > -             int next = dev->rx_q.end;
> > > -
> > > -             spin_unlock_irqrestore(&dev->rx_lock, flags);
> > > -             usb_poison_urb(dev->rx_q.e[next].urb);
> > > -             spin_lock_irqsave(&dev->rx_lock, flags);
> > > -     }  
> >
> > Why is there no need to take the lock?  Admittedly it's not clear what
> > this lock is protecting here :P  Perhaps a separate patch to remove the
> > unnecessary locking with an explanation?  
> 
> usb_poison_urb() can run concurrently with urb completion so I guess
> we do not need locks here.
> I guess we need to maintain this chunk in the same patch since now
> when the device is disconnected
> we do not increment dev->rx_q.end. What do you think?

Ah, I see!  The completion used to run in between the unlock/lock!
Now we just poison out of order, because completion doesn't care about
ordering for errored URBs.  Perhaps worth putting in the commit message?
