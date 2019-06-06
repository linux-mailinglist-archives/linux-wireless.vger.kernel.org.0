Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61838021
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 00:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFFWAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 18:00:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37636 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFFWAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 18:00:04 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so1449270iok.4
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 15:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GQajOm2MtdM8ShQ34Lw/zEW2c4tCO7hvWkmg9UltbQ=;
        b=gCmwWrGFeVtC/F8Zr6k7LLf3Bj/kkVl6S3waNq+rhKSq4DZJyljVlW07y9bi6LrQSk
         aSH3Hksybl/+NROCyNFOqGgZoU2gS+8gIImfHH8BsbCKfufJnjdYm4pYHLEFcXRp87Xu
         GAkgkzfTpJni/dSUB0btrMepSGX9kTqPBBGrT2dOMCBZTycfX6gn9E98Tt3Uz+DZIqJ+
         Th4J8qBF4Eb2tXjQahDPyimaAsCJFlCjmQgWQizHQyuORZphQ/5fpvX2ADWIigWzvRRy
         WOHFZllZxwEjLzpTU2YoTe3vMqYn/jz0yTeTHl8qxqbHCbuQ3ffEhuTLCKsMRXoVVyFZ
         +HUw==
X-Gm-Message-State: APjAAAXXR+WbvSUU99+NL2sU4jJebe3N3JCoCIH9zQaMvZIkBN0X8LOT
        9yiNozbY1ceacXGB+uT3Klf4fb5PwAwpYQWphsaGleMDmog=
X-Google-Smtp-Source: APXvYqw2f+d83vWGhbv8OQXVIOKWvXTCD8G8JXng2Rjat5N1mdmNOCugGHy75jQKqNN/f6V3DpWlGIjWsW9+TZ9Gzfg=
X-Received: by 2002:a05:6602:2006:: with SMTP id y6mr29193586iod.218.1559858403149;
 Thu, 06 Jun 2019 15:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <a3c72b07e229e1d16e93438d741d69abba6a18cf.1559822991.git.lorenzo@kernel.org>
 <20190606114228.7a0ba115@cakuba.netronome.com> <CAJ0CqmUySwtgzPCFR0QsZ-XA7Lm7xU8eMsELV8LEd2MEkhfnLA@mail.gmail.com>
 <20190606142622.7e5f11de@cakuba.netronome.com>
In-Reply-To: <20190606142622.7e5f11de@cakuba.netronome.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 6 Jun 2019 23:59:52 +0200
Message-ID: <CAJ0CqmWWrQnc55+LVS9L2tXN7MGEFUcaxfLbUbiCRpFitjaJfw@mail.gmail.com>
Subject: Re: [PATCH] mt7601u: do not schedule rx_tasklet when the device has
 been disconnected
To:     Jakub Kicinski <kubakici@wp.pl>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On Thu, 6 Jun 2019 23:02:08 +0200, Lorenzo Bianconi wrote:
> > > On Thu,  6 Jun 2019 14:26:12 +0200, Lorenzo Bianconi wrote:
> > Hi Jakub,
> >
> > thx for the fast review :)
>
> I guess I'm used to the 24h "review timeout" on netdev :)
>

:-)

> > > Is this a new thing?  I def tested unplugging the dongle under
> > > traffic, but that must had been in 3.19 days :S
> >
> > I do not know if the issue has been introduced in recent kernel, I am
> > able to trigger it in a vm running
> > wireless-drivers-next and it has been reported here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=203249
>
> I see.  I'm just worried that we make a mistake here and it will get
> backported all the way back to very old kernels because of the fixes
> tag.  If old kernels worked perhaps it's not worth disturbing them.
>
> > > > Fixes: c869f77d6abb ("add mt7601u driver")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > I will post a patch to fix tx side as well
> > > > ---
> > > >  drivers/net/wireless/mediatek/mt7601u/dma.c | 33 ++++++++++-----------
> > > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > > index f7edeffb2b19..e7703990b291 100644
> > > > --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > > +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > > > @@ -193,10 +193,20 @@ static void mt7601u_complete_rx(struct urb *urb)
> > > >       struct mt7601u_rx_queue *q = &dev->rx_q;
> > > >       unsigned long flags;
> > > >
> > > > -     spin_lock_irqsave(&dev->rx_lock, flags);
> > > > +     switch (urb->status) {
> > > > +     case -ECONNRESET:
> > > > +     case -ESHUTDOWN:
> > > > +     case -ENOENT:
> > > > +             return;
> > >
> > > So we assume this is non-recoverable?  Everything will fail after?
> > > Because pending is incremented linearly :S  That's why there is a
> > > warning here.
> >
> > AFAIK -ECONNRESET/-ENOENT are related to urb unlink/kill while
> > -ESHUTDOWN is related to device disconnection.
> > I guess we can assume the device has been removed if we get these errors
>
> Makes sense.  A bit of an implicit assumption, USB subsystem may break
> this for us.  Let's at least put a comment here so we can go back and
> know that at the time of committing we did double check?
>

ack, I will put a comment in v2

> > > > +     default:
> > > > +             dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
> > > > +                                 urb->status);
> > > > +             /* fall through */
> > > > +     case 0:
> > > > +             break;
> > > > +     }
> > > >
> > > > -     if (mt7601u_urb_has_error(urb))
> > > > -             dev_err(dev->dev, "Error: RX urb failed:%d\n", urb->status);
> > > > +     spin_lock_irqsave(&dev->rx_lock, flags);
> > > >       if (WARN_ONCE(q->e[q->end].urb != urb, "RX urb mismatch"))
> > > >               goto out;
> > > >
> > > > @@ -363,19 +373,10 @@ int mt7601u_dma_enqueue_tx(struct mt7601u_dev *dev, struct sk_buff *skb,
> > > >  static void mt7601u_kill_rx(struct mt7601u_dev *dev)
> > > >  {
> > > >       int i;
> > > > -     unsigned long flags;
> > > > -
> > > > -     spin_lock_irqsave(&dev->rx_lock, flags);
> > > >
> > > > -     for (i = 0; i < dev->rx_q.entries; i++) {
> > > > -             int next = dev->rx_q.end;
> > > > -
> > > > -             spin_unlock_irqrestore(&dev->rx_lock, flags);
> > > > -             usb_poison_urb(dev->rx_q.e[next].urb);
> > > > -             spin_lock_irqsave(&dev->rx_lock, flags);
> > > > -     }
> > >
> > > Why is there no need to take the lock?  Admittedly it's not clear what
> > > this lock is protecting here :P  Perhaps a separate patch to remove the
> > > unnecessary locking with an explanation?
> >
> > usb_poison_urb() can run concurrently with urb completion so I guess
> > we do not need locks here.
> > I guess we need to maintain this chunk in the same patch since now
> > when the device is disconnected
> > we do not increment dev->rx_q.end. What do you think?
>
> Ah, I see!  The completion used to run in between the unlock/lock!
> Now we just poison out of order, because completion doesn't care about
> ordering for errored URBs.  Perhaps worth putting in the commit message?

ack, I will put a comment in v2

Regards,
Lorenzo
