Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF3D1C5DD8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 18:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgEEQuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 12:50:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728804AbgEEQuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 12:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588697451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVOhiF/jRIisDSOWprbssnuSK8OuNCD7rVyEUJwjeGM=;
        b=OCYM6MXu0njWYlE5YwglwWPmQg1gG4vEXjc26eANU/ONbKX+umJES3bh6xo2iw33tynHaD
        VNvXtvqDBDTHoiu1OHQTAyaiVKxP/0RNUWb3G5Y9NtcBmUd1pJxeYJIvs4ScBFgv+UtyFR
        Zf9DD7YX17vN8Y7uaTixGOhwzF36z6I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-W4Bjg2vQMoKpkCMOS7L4NA-1; Tue, 05 May 2020 12:50:50 -0400
X-MC-Unique: W4Bjg2vQMoKpkCMOS7L4NA-1
Received: by mail-lj1-f198.google.com with SMTP id c20so564110lji.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 09:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zVOhiF/jRIisDSOWprbssnuSK8OuNCD7rVyEUJwjeGM=;
        b=P73Vsqwh5H2FjVpoi+2WYAyYI2NiysoNqyVwxebf5tM31kQaGWcY0huF9GZs6wlM5u
         EIdC3j3NXOzS7PRflF9jGXPNjA8YTn3xanwAj5s5sM3gk0WqDPnh+DPpx1lP9W+S45+4
         A4qcW5AY2jqHxjPV4cbiY+i3zh2mW0O4NXLUkANYG9CIllDg1LGWcIjMtvDnTLsAus20
         C1Kt4UcKblIyNikod5j9nPv1mw8tXh46ujfhAur/g8b2SMRlce8smCUzpAFyFh/v+kKi
         JlgO9GLCDW9SoeXbhP6+3pDY5ZRSMj7+6XosqdUaUmLP2NTLx2Ck7FW9mVuyoyRwtEN1
         sTAw==
X-Gm-Message-State: AGi0PuaMEhJSQYeuWDnfyXSzniavma0cdrmyKq/mF8vJNwel6bhwL4Mm
        DwKWqB8A0L0VGU0rgJm4my6hYjKe6TKWdrIZXra2zmTwa0x81Juhg69aP6cHqMzlCuNiS8Ax8v+
        gPXrWsO5qMoruHmzCyBjtcVngccc=
X-Received: by 2002:a05:6512:108f:: with SMTP id j15mr2291604lfg.19.1588697448437;
        Tue, 05 May 2020 09:50:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4f3BN3RJ+hgPKeRfdSAfe8RBcphR5Lw28FoUkgA83Mut8WPgx0ABsmLW6LEKTsR6c7Pq9Pw==
X-Received: by 2002:a05:6512:108f:: with SMTP id j15mr2291588lfg.19.1588697448074;
        Tue, 05 May 2020 09:50:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e25sm2279025lfb.89.2020.05.05.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:50:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 936CF1804E9; Tue,  5 May 2020 18:50:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
In-Reply-To: <20200505152010.GA33304@sakura>
References: <20200504193959.GC26805@sakura> <878si6oabp.fsf@toke.dk> <20200505131531.GA32619@sakura> <87368eo5dn.fsf@toke.dk> <20200505152010.GA33304@sakura>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 May 2020 18:50:45 +0200
Message-ID: <87pnbimil6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Tuesday 05 May 2020 =C3=A0 15:53:08 (+0200), Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>
>> Well, I think that should be fine? Having a longer HW queue is fine, as
>> long as you have some other logic to not fill it all the time (like the
>> "max two aggregates" logic I mentioned before). I think this is what
>> ath9k does too. At least it looks like both drv_tx() and
>> release_buffered_frames() will just abort (and drop in the former case)
>> if there is no HW buffer space left.
>
> Ok
>
> BTW, the "max two aggregates" rule, why is it based on number of
> frames and not duration ? if you are queing 1500 bytes @1Mbit/s, even
> one frame is enough, but not so for faster rates.

It's the minimum amount that works - assuming you get a TX completion
when one is done, the CPU has time to build the next one before the
second one is done, and you avoid starvation. Note this only works well
for aggregates, since their size tend to vary with rate; if you're
queueing individual packets to the HWQ you need something that takes
rate into account, which is what AQL (Airtime Queue Limits) does for
ath10k.

> It would be even better if minstrel could limit the total duration
> when computing number of hardware retries, and then mac80211 could
> handle software retries for those really slow packets, no hardware
> FIFO "pollution"

Minstrel will compute the max aggregate size based on the rate, which is
why the "two aggregates" scheme works. It likely could be smarter about
limiting the number of retries, as you say, but we never did get around
to doing anything about that :)

>> > Also .release_buffered_frames() codepath is difficult to test, how do
>> > you trigger that reliably ? assuming VIF is an AP, then you need the
>> > remote STA to go to sleep even though you have traffic waiting for it
>> > in the txqi. For now I patch the stack to introduce artificial delay.
>> >
>> > Since my hardware has a sticky per-STA PS filter with good status
>> > reporting, I'm considering using ieee80211_sta_block_awake() and only
>> > unblock STA when all its txqi are empty to get rid of
>> > .release_buffered_frames() complexity.
>>=20
>> I'm probably not the right person to answer that; never did have a good
>> grip on the details of PS support.
>
> Hopefully Felix or Johannes will see this.
>
> Just wondering if there is anything I'm missing, this alternative way
> of doing looks easier to me because it removes "knowledge" of frame
> delivery under service period from the driver:
>
>
> 1) first get rid of buffered txq traffic when entering PS:
>
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -1593,6 +1593,15 @@ static void sta_ps_start(struct sta_info *sta)
>                         list_del_init(&txqi->schedule_order);
>                 spin_unlock(&local->active_txq_lock[txq->ac]);
>=20=20
> -               if (txq_has_queue(txq))
> -                       set_bit(tid, &sta->txq_buffered_tids);
> -               else
> -                       clear_bit(tid, &sta->txq_buffered_tids);
> +               /* transfer txq into tx_filtered frames */
> +               spin_lock(&fq->lock);
> +               while ((skb =3D skb_dequeue(&txq->frags)))
> +                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
> +               /* use something more efficient like fq_tin_reset  */
> +               while ((skb =3D fq_tin_dequeue(fq, tin, fq_tin_dequeue_fu=
nc)))
> +                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
> +               spin_unlock_bh(&fq->lock);

This seems like a bad idea; we want the TXQ mechanism to decide which
frame to send on wakeup.

> 2) driver register for STA_NOTIFY_SLEEP
>
> 3) driver count tx frames pending in the hardware per STA and sets
> ieee80211_sta_block_awake(sta, 1) when > 0
>
> 4) on tx completion, if STA is sleeping and number of pending tx frames i=
n hardware for a
> given STA reaches 0:
>  - if driver buffers other frames for this STA, release them with TX_FILT=
ERED in reverse order
>  - calls ieee80211_sta_block_awake(false)
>
> what do you think ?

As I said, I'm not an expert on the PS code, so I may be missing
something. But it seems to me that in a model where the driver pulls the
frames from mac80211 (i.e., for drivers using wake_tx_queue), there
really is no way around having a way to instruct the driver "please use
these flags for the next N frames you send" - which is what
release_buffered_frames() does. What you're suggesting is basically
turning off this 'pull mode' for the frames buffered during PS and have
mac80211 revert to push mode for those, right? But then you lose the
benefits of pull mode (the TXQs) for those frames.

I remember Johannes talking about a 'shim layer' between the mac80211
TXQs and the 'drv_tx()' hook as a way to bring the benefits of the TXQs
to the 'long tail' of simple drivers that don't do any internal
buffering anyway, without having to change the drivers to use 'pull
mode'. Am I wrong in thinking that mwl8k may be a good candidate for
such a layer? From glancing through the existing driver it looks like
it's mostly just taking each frame, wrapping it in a HW descriptor, and
sticking it on a TX ring?

>> What hardware is it you're writing a driver for, BTW, and are you
>> planning to upstream it? :)
>
> that's a rewrite of the mwl8k driver targeting the same hardware, but
> with a different firmware interface.
>
> if I can bring it on par with the existing set of supported hardware
> and features, I could try to upstream it yes.

That would be awesome! :)

-Toke

