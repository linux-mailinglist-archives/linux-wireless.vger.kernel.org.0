Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364891E0AF6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbgEYJrF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389590AbgEYJrF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:47:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E07C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:47:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9hG-002cLh-JB; Mon, 25 May 2020 11:47:02 +0200
Message-ID: <ac76e45633dbafb07c2086b0eeee823f5a4f5a0b.camel@sipsolutions.net>
Subject: Re: Regarding .wake_tx_queue() model
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Maxime Bizon <mbizon@freebox.fr>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 11:47:01 +0200
In-Reply-To: <20200505152010.GA33304@sakura> (sfid-20200505_172027_527369_0A123F8C)
References: <20200504193959.GC26805@sakura> <878si6oabp.fsf@toke.dk>
         <20200505131531.GA32619@sakura> <87368eo5dn.fsf@toke.dk>
         <20200505152010.GA33304@sakura> (sfid-20200505_172027_527369_0A123F8C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-05-05 at 17:20 +0200, Maxime Bizon wrote:

> > > Also .release_buffered_frames() codepath is difficult to test, how do
> > > you trigger that reliably ? assuming VIF is an AP, then you need the
> > > remote STA to go to sleep even though you have traffic waiting for it
> > > in the txqi. For now I patch the stack to introduce artificial delay.
> > > 
> > > Since my hardware has a sticky per-STA PS filter with good status
> > > reporting, I'm considering using ieee80211_sta_block_awake() and only
> > > unblock STA when all its txqi are empty to get rid of
> > > .release_buffered_frames() complexity.
> > 
> > I'm probably not the right person to answer that; never did have a good
> > grip on the details of PS support.
> 
> Hopefully Felix or Johannes will see this.
> 
> Just wondering if there is anything I'm missing, this alternative way
> of doing looks easier to me because it removes "knowledge" of frame
> delivery under service period from the driver:

This stuff is a mess. I had a plan once to just rip it all out and
combine it all with the TXQs, but not only is it hard to test, we've
also offloaded this stuff to the firmware for our devices, so motivation
is pretty low.

> 1) first get rid of buffered txq traffic when entering PS:
> 
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -1593,6 +1593,15 @@ static void sta_ps_start(struct sta_info *sta)
>                         list_del_init(&txqi->schedule_order);
>                 spin_unlock(&local->active_txq_lock[txq->ac]);
>  
> -               if (txq_has_queue(txq))
> -                       set_bit(tid, &sta->txq_buffered_tids);
> -               else
> -                       clear_bit(tid, &sta->txq_buffered_tids);
> +               /* transfer txq into tx_filtered frames */
> +               spin_lock(&fq->lock);
> +               while ((skb = skb_dequeue(&txq->frags)))
> +                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
> +               /* use something more efficient like fq_tin_reset  */
> +               while ((skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func)))
> +                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
> +               spin_unlock_bh(&fq->lock);
> +
> 
> 2) driver register for STA_NOTIFY_SLEEP
> 
> 3) driver count tx frames pending in the hardware per STA and sets
> ieee80211_sta_block_awake(sta, 1) when > 0
> 
> 4) on tx completion, if STA is sleeping and number of pending tx frames in hardware for a
> given STA reaches 0:
>  - if driver buffers other frames for this STA, release them with TX_FILTERED in reverse order
>  - calls ieee80211_sta_block_awake(false)
> 
> what do you think ?

I really don't know, off the top of my head, sorry.

johannes


