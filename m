Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5072F1C5509
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEEMG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 08:06:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37934 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727090AbgEEMG1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 08:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588680385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CodjD/JIYkjGf2+ET0iLsk/hEiT5RpuBz2OpH/pHl90=;
        b=eM/HrJDrX64OHYWVWdA9mfjczwEDT2EWt7WR2G2LW96KY5s7Dp46A+FiI9EQnd40quKz8U
        VZEvRw1U+A6wkKhGKmF3WjDFG+/yNfaq1Y71iHFUeOF06rnGT1wI/UHXtuCPH9iLD3yfhe
        DJmkt2P1Kl2ta7Mag5wsVkVrFtF4aFY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-46FrsWTuO-asPBfM44_yKw-1; Tue, 05 May 2020 08:06:24 -0400
X-MC-Unique: 46FrsWTuO-asPBfM44_yKw-1
Received: by mail-lf1-f71.google.com with SMTP id j21so536203lfg.18
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CodjD/JIYkjGf2+ET0iLsk/hEiT5RpuBz2OpH/pHl90=;
        b=EZrHXfll7IaXZ2hv8vvo2bTWSGn6V6eMUMtMBL9S4qPC9B4s0uJF8EXDgzHkeekrWW
         2xxxTYw8786NIvhHigmullFBBhv9BdM0CpFKk0y+Gvc+vkcsAXgt0RL2wskLilZoM+MG
         s2SoFOFxT69jqrxhJqonotfZlcQFKzIuwKS1e2Lnz7BJSks9PwW6NfFLLtEeU4XF9m9R
         X1+GMT9GZpAXesijqqDZNoBpiv5fqvHQxLO7hxJLEYHkCC7rs3v4JYhM/IDNZVg3KzpN
         p3YpC0Q4nLcBvLLH4GI1+8WPOQ416KlZ5xNlos1M3qXyAcjbEs4ygbx5M1Rf1S886C03
         1Ahw==
X-Gm-Message-State: AGi0PuYzy6yAy+R4rKjR318dDSdXgJpH0kLRlmR5ZTb8kBWKuvJzmxat
        dbEIBAeoGGg9ivtJu6OACFe3bTVPUcQ256kyF2oH64lU+/pGzmnueRhwxx/nj4AtKPKV+YnhPIW
        oc6SYZUO15WAnsoC9PDF3SSOOUMQ=
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr1658050lji.169.1588680381985;
        Tue, 05 May 2020 05:06:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0FuJhO/xV1EF7QZqBZAJCPl19lsAjEyCZ73GWRTHFjUQ2ee5Uij2CgQqdWwns3GMhMUKsfg==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr1658031lji.169.1588680381641;
        Tue, 05 May 2020 05:06:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f5sm1638482lfh.84.2020.05.05.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 05:06:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 172E41804E9; Tue,  5 May 2020 14:06:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maxime Bizon <mbizon@freebox.fr>, linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
In-Reply-To: <20200504193959.GC26805@sakura>
References: <20200504193959.GC26805@sakura>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 May 2020 14:06:18 +0200
Message-ID: <878si6oabp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> Hello,
>
> Currently switching a driver to .wake_tx_queue() model

Yay :)

> and I would appreciate some guidance over a couple of issues.
>
> My hardware exposes 1 FIFO per ac, so the current driver basically
> queue skb in the correct fifo from drv_tx(), and once a FIFO is big
> "enough" (packet count or total duration), I use
> ieee80211_stop_queue(), and the corresponding ieee80211_wait_queue()
> in tx completion.
>
> Current driver TX flow is:
>  - drv_tx() => push into FIFO
>  - drv_tx() => push into FIFO
>  - drv_tx() => push into FIFO => FIFO full => ieee80211_stop_queue()
>  - [drv_tx won't be called]
>  - tx completion event => ieee80211_wake_queue()
>  - drv_tx()
>  [...]
>
>
> 1) drv_tx() & drv_wake_tx_queue() concurrency
>
> With the .wake_tx_queue model, there are now two entry points in the
> driver, how does the stack ensure that drv_tx() is not blocked forever
> if there is concurrent traffic on the same AC ?
>
>
> for example:
>
>  - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
>  - tx completion event => ieee80211_wake_queue()
>  - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
>  - tx completion event => ieee80211_wake_queue()
>  - [...]
>
> ieee80211_wake_queue() will schedule both tx_pending_tasklet and
> wake_txqs_tasklet, but I don't think there is any guarantee in the
> call ordering.
>
> Is it the driver's duty to leave a bit of room during
> drv_wake_tx_queue() scheduling and not stop the queues from there ?

Yeah, this is basically up to the driver. I'm mostly familiar with
ath9k, and I think basically what that does is that it doesn't fill the
HW FIFO in normal operation: For data packets being pulled off
ieee80211_tx_dequeue() it'll only queue two aggregates in the hardware
at a time. This is a good thing! We want the packets to be queued on the
mac80211 TXQs not in a dumb HW FIFO causing bufferbloat!

Given that you're building aggregates in the driver, you could just do
the same thing as ath9k and likely get pretty good results, I think :)

> 2) ieee80211_stop_queue() vs drv_wake_tx_queue()
>
> Commit 21a5d4c3a45ca608477a083096cfbce76e449a0c made it so that
> ieee80211_tx_dequeue() will return nothing if hardware queue is
> stopped, but drv_wake_tx_queue() is still called for ac whose queue is
> stopped.
>
>
> so should I do this ?
>
>  - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
>  - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => NULL => return
>  - tx completion event => ieee80211_wake_queue()
>  - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
>  - [...]
>
> or this ?
>
>  - .wake_tx_queue() => ieee80211_queue_stopped() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
>  - .wake_tx_queue() => ieee80211_queue_stopped() => return
>
> associated commit log only mentions edge cases (channel switch, DFS),
> so I'm not sure if ieee80211_stop_queue() for txqs was intended for
> "fast path", also see 3)

I don't think ieee80211_stop_queue() is meant to be used this way at all
in the wake_tx_queue case. Rather, when you get a wake_tx_queue()
callback, you just queue as many frames as you feel like (see '2
aggregate' limit above), and then return.  Then, on a TX completion you
just call your internal driver function that tries to pull more frames
from the mac80211 TXQs.

You'll keep getting wake_tx_queue callbacks from mac80211, but there's
nothing saying you have to pull any frames on each one.

See ath_txq_schedule() for how ath9k does this :)

> 3) _ieee80211_wake_txqs() looks buggy:
>
> If the cab_queue is not stopped, this loop will unconditionally wake
> up all txqs, which I guess is not what was intended:
>
>         for (i = 0; i < local->hw.queues; i++) {
>                 if (local->queue_stop_reasons[i])
>                         continue;
>
>                         for (ac = 0; ac < n_acs; ac++) {
>                                 int ac_queue = sdata->vif.hw_queue[ac];
>
>                                 if (ac_queue == i ||
>                                     sdata->vif.cab_queue == i)
>                                         __ieee80211_wake_txqs(sdata, ac);
>                         }


(not sure about this none)

> 4) building aggregation in the driver:
>
> I'm doing aggregation on the host side rather than in the firmware,
> which will ends up with more or less the same code as ath9k, is there
> any on-going effort to move that code from the driver into the stack ?

Not aware of any on-going efforts, no. Something like this usually
happens because someone feels it would make their life easier. Say, if
they're writing a new driver and wants to re-use code :)

Looking at the ath9k code, ath_tx_form_aggr() is tied into the internal
driver buffer representations, so I'm not sure how much work it would be
to generalise and split out parts of it. It need not be a complete
"build me an aggregate" function that you move into mac80211, though,
even some utility functions to calculate padding etc might be shareable?
I guess that if you're copying code from there I guess you'll find out :)

-Toke

