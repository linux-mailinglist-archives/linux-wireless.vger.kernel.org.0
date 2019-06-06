Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043D837F34
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfFFVCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 17:02:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34996 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfFFVCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 17:02:20 -0400
Received: by mail-it1-f194.google.com with SMTP id n189so2236533itd.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 14:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0heXj+aKi4YWkRbEV8Gm2F3YiDur/tNCkFklPY55+MM=;
        b=JZNc3NmUpoFQydMzQ+poy2gjwGamUvMALxHwOcgzu/xdvAXBH33BJl1PhxGIPR3C7m
         WsrXSW3mNsqxwiplEXlGhLcEIrhxf2YfZF5EnB2eUNHGLO7Jzce39+2ZNwZhPa3zWOlH
         JPtcCELbT3rcwnyFe0uBqB3Aff7WkjjAUnRDiAD9ar3qmvT5vuTaYibA/bIGGG3bI+VD
         1eNZtm188qYJ0oRlyOTPwP/RuCOfWYhbESBe2rxmpD333pf6Z7/NRXLXATiCXv68+Dq5
         pJUCuDOgvU+upT44vF1/OjDfDGjCRnWq80yf5oh3Xifw5gwhAh5Cp1ooVzijAjgVHzK6
         FyCg==
X-Gm-Message-State: APjAAAVCXvwBDExCy+YNg3VKuKkV9ehFQeaHMziGPje/WXqStyfvksgC
        hNathWFb79DJ6nQDnAU6iAGVzr3BB/6dLa3hZumtcidSZ/I=
X-Google-Smtp-Source: APXvYqwPVbDsooj+MaMZMncz2+3xQojCPQvIcC9iqKIrkBuN1qyIHC6a1DZVLO6gPqflJbnsn1/PVX9LRLGTExB/EkU=
X-Received: by 2002:a24:cd82:: with SMTP id l124mr1704172itg.169.1559854939700;
 Thu, 06 Jun 2019 14:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <a3c72b07e229e1d16e93438d741d69abba6a18cf.1559822991.git.lorenzo@kernel.org>
 <20190606114228.7a0ba115@cakuba.netronome.com>
In-Reply-To: <20190606114228.7a0ba115@cakuba.netronome.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 6 Jun 2019 23:02:08 +0200
Message-ID: <CAJ0CqmUySwtgzPCFR0QsZ-XA7Lm7xU8eMsELV8LEd2MEkhfnLA@mail.gmail.com>
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
> On Thu,  6 Jun 2019 14:26:12 +0200, Lorenzo Bianconi wrote:
> > Do not schedule rx_tasklet when the usb dongle is disconnected. This
> > patch fixes the common kernel warning reported when the device is
> > removed.
> >
> > [   24.921354] usb 3-14: USB disconnect, device number 7
> > [   24.921593] ------------[ cut here ]------------
> > [   24.921594] RX urb mismatch
> > [   24.921675] WARNING: CPU: 4 PID: 163 at drivers/net/wireless/mediatek/mt7601u/dma.c:200 mt7601u_complete_rx+0xcb/0xd0 [mt7601u]
> > [   24.921769] CPU: 4 PID: 163 Comm: kworker/4:2 Tainted: G           OE     4.19.31-041931-generic #201903231635
> > [   24.921770] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z97 Extreme4, BIOS P1.30 05/23/2014
> > [   24.921782] Workqueue: usb_hub_wq hub_event
> > [   24.921797] RIP: 0010:mt7601u_complete_rx+0xcb/0xd0 [mt7601u]
> > [   24.921800] RSP: 0018:ffff9bd9cfd03d08 EFLAGS: 00010086
> > [   24.921802] RAX: 0000000000000000 RBX: ffff9bd9bf043540 RCX: 0000000000000006
> > [   24.921803] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9bd9cfd16420
> > [   24.921804] RBP: ffff9bd9cfd03d28 R08: 0000000000000002 R09: 00000000000003a8
> > [   24.921805] R10: 0000002f485fca34 R11: 0000000000000000 R12: ffff9bd9bf043c1c
> > [   24.921806] R13: ffff9bd9c62fa3c0 R14: 0000000000000082 R15: 0000000000000000
> > [   24.921807] FS:  0000000000000000(0000) GS:ffff9bd9cfd00000(0000) knlGS:0000000000000000
> > [   24.921808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   24.921808] CR2: 00007fb2648b0000 CR3: 0000000142c0a004 CR4: 00000000001606e0
> > [   24.921809] Call Trace:
> > [   24.921812]  <IRQ>
> > [   24.921819]  __usb_hcd_giveback_urb+0x8b/0x140
> > [   24.921821]  usb_hcd_giveback_urb+0xca/0xe0
> > [   24.921828]  xhci_giveback_urb_in_irq.isra.42+0x82/0xf0
> > [   24.921834]  handle_cmd_completion+0xe02/0x10d0
> > [   24.921837]  xhci_irq+0x274/0x4a0
> > [   24.921838]  xhci_msi_irq+0x11/0x20
> > [   24.921851]  __handle_irq_event_percpu+0x44/0x190
> > [   24.921856]  handle_irq_event_percpu+0x32/0x80
> > [   24.921861]  handle_irq_event+0x3b/0x5a
> > [   24.921867]  handle_edge_irq+0x80/0x190
> > [   24.921874]  handle_irq+0x20/0x30
> > [   24.921889]  do_IRQ+0x4e/0xe0
> > [   24.921891]  common_interrupt+0xf/0xf
> > [   24.921892]  </IRQ>
> > [   24.921900] RIP: 0010:usb_hcd_flush_endpoint+0x78/0x180
> > [   24.921354] usb 3-14: USB disconnect, device number 7
>

Hi Jakub,

thx for the fast review :)

> Is this a new thing?  I def tested unplugging the dongle under
> traffic, but that must had been in 3.19 days :S
>

I do not know if the issue has been introduced in recent kernel, I am
able to trigger it in a vm running
wireless-drivers-next and it has been reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=203249

> > Fixes: c869f77d6abb ("add mt7601u driver")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > I will post a patch to fix tx side as well
> > ---
> >  drivers/net/wireless/mediatek/mt7601u/dma.c | 33 ++++++++++-----------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > index f7edeffb2b19..e7703990b291 100644
> > --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> > +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > @@ -193,10 +193,20 @@ static void mt7601u_complete_rx(struct urb *urb)
> >       struct mt7601u_rx_queue *q = &dev->rx_q;
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&dev->rx_lock, flags);
> > +     switch (urb->status) {
> > +     case -ECONNRESET:
> > +     case -ESHUTDOWN:
> > +     case -ENOENT:
> > +             return;
>
> So we assume this is non-recoverable?  Everything will fail after?
> Because pending is incremented linearly :S  That's why there is a
> warning here.

AFAIK -ECONNRESET/-ENOENT are related to urb unlink/kill while
-ESHUTDOWN is related to device disconnection.
I guess we can assume the device has been removed if we get these errors

>
> > +     default:
> > +             dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
> > +                                 urb->status);
> > +             /* fall through */
> > +     case 0:
> > +             break;
> > +     }
> >
> > -     if (mt7601u_urb_has_error(urb))
> > -             dev_err(dev->dev, "Error: RX urb failed:%d\n", urb->status);
> > +     spin_lock_irqsave(&dev->rx_lock, flags);
> >       if (WARN_ONCE(q->e[q->end].urb != urb, "RX urb mismatch"))
> >               goto out;
> >
> > @@ -363,19 +373,10 @@ int mt7601u_dma_enqueue_tx(struct mt7601u_dev *dev, struct sk_buff *skb,
> >  static void mt7601u_kill_rx(struct mt7601u_dev *dev)
> >  {
> >       int i;
> > -     unsigned long flags;
> > -
> > -     spin_lock_irqsave(&dev->rx_lock, flags);
> >
> > -     for (i = 0; i < dev->rx_q.entries; i++) {
> > -             int next = dev->rx_q.end;
> > -
> > -             spin_unlock_irqrestore(&dev->rx_lock, flags);
> > -             usb_poison_urb(dev->rx_q.e[next].urb);
> > -             spin_lock_irqsave(&dev->rx_lock, flags);
> > -     }
>
> Why is there no need to take the lock?  Admittedly it's not clear what
> this lock is protecting here :P  Perhaps a separate patch to remove the
> unnecessary locking with an explanation?

usb_poison_urb() can run concurrently with urb completion so I guess
we do not need locks here.
I guess we need to maintain this chunk in the same patch since now
when the device is disconnected
we do not increment dev->rx_q.end. What do you think?

>
> > -     spin_unlock_irqrestore(&dev->rx_lock, flags);
> > +     for (i = 0; i < dev->rx_q.entries; i++)
> > +             usb_poison_urb(dev->rx_q.e[i].urb);
> > +     tasklet_kill(&dev->rx_tasklet);
> >  }
> >
> >  static int mt7601u_submit_rx_buf(struct mt7601u_dev *dev,
> > @@ -525,8 +526,6 @@ void mt7601u_dma_cleanup(struct mt7601u_dev *dev)
> >  {
> >       mt7601u_kill_rx(dev);
> >
> > -     tasklet_kill(&dev->rx_tasklet);
>
> Why the move?  Looks a bit unnecessary..
>

ack, I will put it back in v2 :)

Regards,
Lorenzo

> >       mt7601u_free_rx(dev);
> >       mt7601u_free_tx(dev);
> >
