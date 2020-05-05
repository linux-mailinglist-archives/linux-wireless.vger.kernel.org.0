Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269081C5AE7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgEEPUO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 11:20:14 -0400
Received: from ns.iliad.fr ([212.27.33.1]:53388 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgEEPUO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 11:20:14 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5348420404;
        Tue,  5 May 2020 17:20:11 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id 474FF20326;
        Tue,  5 May 2020 17:20:11 +0200 (CEST)
Date:   Tue, 5 May 2020 17:20:10 +0200
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
Message-ID: <20200505152010.GA33304@sakura>
References: <20200504193959.GC26805@sakura>
 <878si6oabp.fsf@toke.dk>
 <20200505131531.GA32619@sakura>
 <87368eo5dn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87368eo5dn.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue May  5 17:20:11 2020 +0200 (CEST)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Tuesday 05 May 2020 à 15:53:08 (+0200), Toke Høiland-Jørgensen wrote:

> Well, I think that should be fine? Having a longer HW queue is fine, as
> long as you have some other logic to not fill it all the time (like the
> "max two aggregates" logic I mentioned before). I think this is what
> ath9k does too. At least it looks like both drv_tx() and
> release_buffered_frames() will just abort (and drop in the former case)
> if there is no HW buffer space left.

Ok

BTW, the "max two aggregates" rule, why is it based on number of
frames and not duration ? if you are queing 1500 bytes @1Mbit/s, even
one frame is enough, but not so for faster rates.

It would be even better if minstrel could limit the total duration
when computing number of hardware retries, and then mac80211 could
handle software retries for those really slow packets, no hardware
FIFO "pollution"

> > Also .release_buffered_frames() codepath is difficult to test, how do
> > you trigger that reliably ? assuming VIF is an AP, then you need the
> > remote STA to go to sleep even though you have traffic waiting for it
> > in the txqi. For now I patch the stack to introduce artificial delay.
> >
> > Since my hardware has a sticky per-STA PS filter with good status
> > reporting, I'm considering using ieee80211_sta_block_awake() and only
> > unblock STA when all its txqi are empty to get rid of
> > .release_buffered_frames() complexity.
> 
> I'm probably not the right person to answer that; never did have a good
> grip on the details of PS support.

Hopefully Felix or Johannes will see this.

Just wondering if there is anything I'm missing, this alternative way
of doing looks easier to me because it removes "knowledge" of frame
delivery under service period from the driver:


1) first get rid of buffered txq traffic when entering PS:

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1593,6 +1593,15 @@ static void sta_ps_start(struct sta_info *sta)
                        list_del_init(&txqi->schedule_order);
                spin_unlock(&local->active_txq_lock[txq->ac]);
 
-               if (txq_has_queue(txq))
-                       set_bit(tid, &sta->txq_buffered_tids);
-               else
-                       clear_bit(tid, &sta->txq_buffered_tids);
+               /* transfer txq into tx_filtered frames */
+               spin_lock(&fq->lock);
+               while ((skb = skb_dequeue(&txq->frags)))
+                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
+               /* use something more efficient like fq_tin_reset  */
+               while ((skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func)))
+                       skb_queue_tail(&sta->tx_filtered[txq->ac], skb);
+               spin_unlock_bh(&fq->lock);
+

2) driver register for STA_NOTIFY_SLEEP

3) driver count tx frames pending in the hardware per STA and sets
ieee80211_sta_block_awake(sta, 1) when > 0

4) on tx completion, if STA is sleeping and number of pending tx frames in hardware for a
given STA reaches 0:
 - if driver buffers other frames for this STA, release them with TX_FILTERED in reverse order
 - calls ieee80211_sta_block_awake(false)

what do you think ?


> What hardware is it you're writing a driver for, BTW, and are you
> planning to upstream it? :)

that's a rewrite of the mwl8k driver targeting the same hardware, but
with a different firmware interface.

if I can bring it on par with the existing set of supported hardware
and features, I could try to upstream it yes.

-- 
Maxime
