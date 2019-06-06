Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B437F42
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfFFVK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 17:10:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56105 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFVK1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 17:10:27 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so2262932ita.5
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 14:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4YzJ7oYugaN1y/MfHSeCqI2cuvoQFrIzRLIwOmU+Fc=;
        b=Lqu0zZwIroPGMEAm3MaLA9hkexhz+dZzGqJ/q/BeiVL6S3cTkoZ52u/JNfW2AvjIit
         UhHSknQ+NJvOp63n8YThNgHuuJgDEtjUL95hTHtdRlDNOQ9KenYwpUmadaCPUPnn6z2u
         VaWaogAt6F5oLDFwDtNe9wJPaCr0PAFKvxZE3LadjS8A1oLlLU4fIFo+wpC+foCmIOme
         7I1onJo6zXhxKDRGOstopHJYDocRRA6B1Q72cRo59dwWnthiNvCOvpUur6sX6qROxsVC
         xz3+W5VHYbjWCb7ss1IONkMGLRMibyF0fH0aK8Frl6lxeKTk6p5xbGYu167EjHFs3VMR
         IU/A==
X-Gm-Message-State: APjAAAVK43GUBWHcI2v1M/nk2lzzKLohW5B4QijwOJe8oVDn10iQ5S6m
        N5tEStLES/M618vknWvsIh3b0dMsCpCj1cf9YQTwqvacuSQ=
X-Google-Smtp-Source: APXvYqzfGsoY7EZadszrYltIXO7xqUyVMIRKfFDbZVBzrwDWK2ecNSVsOZEVarGQ9EQvfWAKOXHwbeQdusUBfiGg7RY=
X-Received: by 2002:a24:1192:: with SMTP id 140mr1614944itf.149.1559855426129;
 Thu, 06 Jun 2019 14:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <27c6d00cfb5936978cfb8304c6e1f03973905848.1559835089.git.lorenzo@kernel.org>
 <20190606114845.4026270e@cakuba.netronome.com>
In-Reply-To: <20190606114845.4026270e@cakuba.netronome.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 6 Jun 2019 23:10:15 +0200
Message-ID: <CAJ0CqmUCch1dU1J24XDOg_fg35BfWLWjvXc3nV7QN6JHgWhZJw@mail.gmail.com>
Subject: Re: [PATCH] mt7601u: fix possible memory leak when the device is disconnected
To:     Jakub Kicinski <kubakici@wp.pl>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 6, 2019 at 8:49 PM Jakub Kicinski <kubakici@wp.pl> wrote:
>
> On Thu,  6 Jun 2019 17:34:16 +0200, Lorenzo Bianconi wrote:
> > When the device is disconnected while passing traffic it is possible
> > to receive out of order urbs causing a memory leak since the skb liked
> > to the current tx urb is not removed. Fix the issue deallocating the skb
> > cleaning up the tx ring. Moreover this patch fixes the following kernel
> > warning
>
> Ugh if we don't have ordering guarantees then the entire "ring" scheme
> no longer works :(  Should we move to URB queues, I don't remember now,
> but there seem to had been a better way to manage URBs :S
>

actually I have observed these issues on tx/rx side just during device
disconnection while passing traffic.
I guess we can assume a proper urb ordering during normal operation
(and so tx/rx ring works fine).
Btw what do you mean with 'URB queues'? :)

> > [   57.480771] usb 1-1: USB disconnect, device number 2
> > [   57.483451] ------------[ cut here ]------------
> > [   57.483462] TX urb mismatch
> > [   57.483481] WARNING: CPU: 1 PID: 32 at drivers/net/wireless/mediatek/mt7601u/dma.c:245 mt7601u_complete_tx+0x165/00
> > [   57.483483] Modules linked in:
> > [   57.483496] CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.2.0-rc1+ #72
> > [   57.483498] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-2.fc30 04/01/2014
> > [   57.483502] Workqueue: usb_hub_wq hub_event
> > [   57.483507] RIP: 0010:mt7601u_complete_tx+0x165/0x1e0
> > [   57.483510] Code: 8b b5 10 04 00 00 8b 8d 14 04 00 00 eb 8b 80 3d b1 cb e1 00 00 75 9e 48 c7 c7 a4 ea 05 82 c6 05 f
> > [   57.483513] RSP: 0000:ffffc900000a0d28 EFLAGS: 00010092
> > [   57.483516] RAX: 000000000000000f RBX: ffff88802c0a62c0 RCX: ffffc900000a0c2c
> > [   57.483518] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff810a8371
> > [   57.483520] RBP: ffff88803ced6858 R08: 0000000000000000 R09: 0000000000000001
> > [   57.483540] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000046
> > [   57.483542] R13: ffff88802c0a6c88 R14: ffff88803baab540 R15: ffff88803a0cc078
> > [   57.483548] FS:  0000000000000000(0000) GS:ffff88803eb00000(0000) knlGS:0000000000000000
> > [   57.483550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   57.483552] CR2: 000055e7f6780100 CR3: 0000000028c86000 CR4: 00000000000006a0
> > [   57.483554] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   57.483556] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   57.483559] Call Trace:
> > [   57.483561]  <IRQ>
> > [   57.483565]  __usb_hcd_giveback_urb+0x77/0xe0
> > [   57.483570]  xhci_giveback_urb_in_irq.isra.0+0x8b/0x140
> > [   57.483574]  handle_cmd_completion+0xf5b/0x12c0
> > [   57.483577]  xhci_irq+0x1f6/0x1810
> > [   57.483581]  ? lockdep_hardirqs_on+0x9e/0x180
> > [   57.483584]  ? _raw_spin_unlock_irq+0x24/0x30
> > [   57.483588]  __handle_irq_event_percpu+0x3a/0x260
> > [   57.483592]  handle_irq_event_percpu+0x1c/0x60
> > [   57.483595]  handle_irq_event+0x2f/0x4c
> > [   57.483599]  handle_edge_irq+0x7e/0x1a0
> > [   57.483603]  handle_irq+0x17/0x20
> > [   57.483607]  do_IRQ+0x54/0x110
> > [   57.483610]  common_interrupt+0xf/0xf
> > [   57.483612]  </IRQ>
> >
> > Fixes: c869f77d6abb ("add mt7601u driver")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt7601u/dma.c | 24 +++++++++++++++------
> >  drivers/net/wireless/mediatek/mt7601u/tx.c  |  4 ++--
> >  2 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > index e7703990b291..bbf1deed7f3b 100644
> > --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> > +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> > @@ -238,14 +238,25 @@ static void mt7601u_complete_tx(struct urb *urb)
> >       struct sk_buff *skb;
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&dev->tx_lock, flags);
> > +     switch (urb->status) {
> > +     case -ECONNRESET:
> > +     case -ESHUTDOWN:
> > +     case -ENOENT:
> > +             return;
> > +     default:
> > +             dev_err_ratelimited(dev->dev, "tx urb failed: %d\n",
> > +                                 urb->status);
> > +             /* fall through */
> > +     case 0:
> > +             break;
> > +     }
> >
> > -     if (mt7601u_urb_has_error(urb))
> > -             dev_err(dev->dev, "Error: TX urb failed:%d\n", urb->status);
> > +     spin_lock_irqsave(&dev->tx_lock, flags);
> >       if (WARN_ONCE(q->e[q->start].urb != urb, "TX urb mismatch"))
> >               goto out;
> >
> >       skb = q->e[q->start].skb;
> > +     q->e[q->start].skb = NULL;
> >       trace_mt_tx_dma_done(dev, skb);
> >
> >       __skb_queue_tail(&dev->tx_skb_done, skb);
> > @@ -446,10 +457,10 @@ static void mt7601u_free_tx_queue(struct mt7601u_tx_queue *q)
> >  {
> >       int i;
> >
> > -     WARN_ON(q->used);
> > -
> >       for (i = 0; i < q->entries; i++)  {
> >               usb_poison_urb(q->e[i].urb);
> > +             if (q->e[i].skb)
> > +                     mt7601u_tx_status(q->dev, q->e[i].skb);
>
> Perhaps a separate patch?
>

As I did for rx side, if we do not schedule the tx tasklet when the
device has been disconnected I guess we need this chuck in the same
patch. What do you think?

Regards,
Lorenzo

> >               usb_free_urb(q->e[i].urb);
> >       }
> >  }
> > @@ -463,6 +474,7 @@ static void mt7601u_free_tx(struct mt7601u_dev *dev)
> >
> >       for (i = 0; i < __MT_EP_OUT_MAX; i++)
> >               mt7601u_free_tx_queue(&dev->tx_q[i]);
> > +     tasklet_kill(&dev->tx_tasklet);
> >  }
> >
> >  static int mt7601u_alloc_tx_queue(struct mt7601u_dev *dev,
> > @@ -528,6 +540,4 @@ void mt7601u_dma_cleanup(struct mt7601u_dev *dev)
> >
> >       mt7601u_free_rx(dev);
> >       mt7601u_free_tx(dev);
> > -
> > -     tasklet_kill(&dev->tx_tasklet);
> >  }
> > diff --git a/drivers/net/wireless/mediatek/mt7601u/tx.c b/drivers/net/wireless/mediatek/mt7601u/tx.c
> > index 3600e911a63e..4d81c45722fb 100644
> > --- a/drivers/net/wireless/mediatek/mt7601u/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt7601u/tx.c
> > @@ -117,9 +117,9 @@ void mt7601u_tx_status(struct mt7601u_dev *dev, struct sk_buff *skb)
> >       info->status.rates[0].idx = -1;
> >       info->flags |= IEEE80211_TX_STAT_ACK;
> >
> > -     spin_lock(&dev->mac_lock);
> > +     spin_lock_bh(&dev->mac_lock);
> >       ieee80211_tx_status(dev->hw, skb);
> > -     spin_unlock(&dev->mac_lock);
> > +     spin_unlock_bh(&dev->mac_lock);
> >  }
> >
> >  static int mt7601u_skb_rooms(struct mt7601u_dev *dev, struct sk_buff *skb)
>
