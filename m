Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BA1C56C1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEENZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 09:25:14 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60850 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbgEENZO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 09:25:14 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 09:25:13 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B75A220DD9;
        Tue,  5 May 2020 15:15:32 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id A973420312;
        Tue,  5 May 2020 15:15:32 +0200 (CEST)
Date:   Tue, 5 May 2020 15:15:31 +0200
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
Message-ID: <20200505131531.GA32619@sakura>
References: <20200504193959.GC26805@sakura>
 <878si6oabp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878si6oabp.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue May  5 15:15:32 2020 +0200 (CEST)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Tuesday 05 May 2020 à 14:06:18 (+0200), Toke Høiland-Jørgensen wrote:

Hello Toke,

thanks for your comments

> I don't think ieee80211_stop_queue() is meant to be used this way at all
> in the wake_tx_queue case. Rather, when you get a wake_tx_queue()
> callback, you just queue as many frames as you feel like (see '2
> aggregate' limit above), and then return.  Then, on a TX completion you
> just call your internal driver function that tries to pull more frames
> from the mac80211 TXQs.

alright, indeed .wake_tx_queue() does not have to result in any actual
frame sent.

but what about .release_buffered_frames then ?

.release_buffered_frames() and .drv_tx() are both "push" oriented
interface. When they are called, you have to push a frame to the
hardware, so if they are called when hardware FIFO is full, you need
to drop the frame (or add yet another intermediate level of queuing)

from what I can see, .release_buffered_frames() will happily be called
even if queue is stopped, and you have to at least send one frame.

I'm just trying to avoid any additionnal intermediate queing in the
driver between what mac80211 gives me and the HW fifo which has a
fixed size (well actually you can choose the size, but only at init
time).

my current workaround is to pre-size the hw fifo queue to handle what
I think is the worst case

Also .release_buffered_frames() codepath is difficult to test, how do
you trigger that reliably ? assuming VIF is an AP, then you need the
remote STA to go to sleep even though you have traffic waiting for it
in the txqi. For now I patch the stack to introduce artificial delay.

Since my hardware has a sticky per-STA PS filter with good status
reporting, I'm considering using ieee80211_sta_block_awake() and only
unblock STA when all its txqi are empty to get rid of
.release_buffered_frames() complexity.

-- 
Maxime
