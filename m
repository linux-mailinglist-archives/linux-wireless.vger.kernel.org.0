Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654E547426
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiFKLPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFKLPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 07:15:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3AE28
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 04:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 416B3B80B63
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 11:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FEAC34116;
        Sat, 11 Jun 2022 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654946111;
        bh=Sf3szwU6nbeE7Q8dHzPkQ2KMnYOl1UHmDG9OlBM+jYM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cX+v2sBWUkC7r+7LuqWByRk/vxmq8N3MMKK4NUDuNUaN9wTTNkeHTekFauv6glJ53
         +p4axKxTteyZH561uCNrJGo9Jn3VxjUVRGhmXCjjmTWGFlMoFHHuah3DeaeU6PXOvx
         yvEqESFReeuGdO2/R19PG165wMXb2OjV6Oj4iMkeVnd+8t3eWPoJnWE1SIltwYb2dZ
         LCxSWvdPygHksjJz4Ql65dTI0jCVtgLBFaficVDVBzuWX3MBnDYuXbRU9tfJiPbrNC
         iXZw7/0xyRbIfBFM323zO3z8cgyfbZkUzKWmV49pzT4zqQ2glrwxUsvdjcMqWvZh7U
         sJwJ6QkIndLDA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ACC5640647D; Sat, 11 Jun 2022 13:15:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/2] mac80211: rework the airtime fairness implementation
In-Reply-To: <b73eaeb3-f16d-d1a1-2658-ff3d1a6d0d22@nbd.name>
References: <20220603164307.92189-1-nbd@nbd.name>
 <20220603164307.92189-2-nbd@nbd.name> <87a6arowpz.fsf@toke.dk>
 <266ef9bc-42c9-59e1-8e7c-368bb8e5179b@nbd.name> <87k09o2un9.fsf@toke.dk>
 <b73eaeb3-f16d-d1a1-2658-ff3d1a6d0d22@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Jun 2022 13:15:08 +0200
Message-ID: <8735gb30zn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

>>> I tried to avoid it, but I didn't find a better way to do it. I added it 
>>> in order to define the number of levels for the skiplist only once and 
>>> make the code resolve it for the individual functions at compile time in 
>>> a type safe way.
>>> Other data structures in the kernel don't need this, because their 
>>> member node struct size typically doesn't change based on a given parameter.
>> 
>> Well, only way I can think of would be doing something like:
>> 
>> #define MAX_SKIPLIST_LEVELS 5
>> struct skiplist_node {
>> 	struct skiplist_node *next[MAX_SKIPLIST_LEVELS];
>> };
>> 
>> And then having the init function take the actual number of levels for
>> that instance and store it in the _list struct. Then, if someone wants
>> to use the skiplist with more levels at some later point, they'd bump
>> the MAX_SKIPLIST_LEVELS define and use that for their initialiser.
> That's exactly what I wanted to avoid. For lists with lots of elements 
> you might need a lot more levels, which would add a significant amount 
> of bloat for small lists.

Right, fair enough, let's keep the macro thing, then. I have an idea
that I'd like to test out for a skiplist-based BPF map type which would
require runtime sizing, but I can probably fudge that at least until
I've figured out if it's feasible, then we can revisit if needed.

>>>> So this implies that we always schedule in airtime order (i.e., enforce
>>>> fairness) for any driver that can get a meaningful value returned from
>>>> ieee80211_calc_expected_tx_airtime(), right? That's probably OK, but
>>>> just want to make sure we've thought through all the implications of
>>>> this.
>>>> 
>>>> A comment here explaining why this is done would be useful; it's a bit
>>>> counter-intuitive when just looking at the code. Your comment in the
>>>> commit message implies that scheduling doesn't work correctly if this is
>>>> not done, but then what happens if airtime is 0 and we bail out above?
>>> I guess I need to add something to deal with that corner case, maybe by 
>>> returning the smallest possible value for expected tx airtime if it 
>>> can't be calculated.
>> 
>> I think there are two approaches here:
>> 
>> - Make sure we always return at least '1' for airtime, so the counter
>>    always increases on every schedule (effectively making it a frame
>>    counter instead).
>> 
>> - Make sure the skiplist does the right thing if all entries enqueued
>>    have the same (0) value (i.e., that it degrades to round-robin).
>> 
>> I think the skiplist does in fact degrade to round-robin since it treats
>> equality the same as "greater than", but it may be somewhat inefficient
>> when inserting in this case? Or?
> The delete logic in my skiplist code can't properly deal with multiple 
> items having the same value. Adding that would likely make the 
> implementation somewhat more complex, so I decided to sidestep it by 
> making it use an internal wrapper for the comparison function which 
> compares the pointer address in case of equal value.

Ah, right, missed that bit; was only looking at insert.

Okay, but even if you're returning a fixed minimum value for stations
with no real airtime estimation, that would still result in multiple
entries with the same value with a high probability.

Hmm, how about fixing it by adding an "insert epoch" to the
skiplist_node? I.e., on insert, walk all the nodes with the same cmp()
value and set this field to the highest value? Like

cmp(a, b) {
 cmpval = __cmpfunc(a, b);
 if (!cmpval)
   return a->epoch - b->epoch;
}

insert() {
  while (!cmp(node, list[i])) {
    i++; node->epoch++;
  }
}

(doesn't quite work, but hopefully you get the gist of it? epoch should
be reset on dequeue of course).

Something like this would preserve equal-value elements in the same
order across insert-remove, at the cost of making insert less efficient
(I think?) if many items share the same value. Maybe that's acceptable?

>>>> How can this happen in normal operation? This implies that a TXQ was
>>>> scheduled without a backlog; isn't that a bug that we should warn on?
>>> At least mt76 assumes that calling ieee80211_next_txq in a loop during a 
>>> scheduling round will eventually return NULL, even when no frames were 
>>> queued. ath9k could potentially also need this, depending on the block 
>>> ack window state.
>>> This assumption was valid for the previous implementation, and I figured 
>>> it would be cleaner and more robust to preserve it.
>> 
>> Sure, I think we should; but doesn't that already happen above, at the
>> 'if (!node)' check? I.e., if the skiplist is empty we'll return NULL.
> In the state that I'm talking about, the skiplist won't be empty. I'm 
> assuming that the first txq in the list has some queued packets, has not 
> used its AQL budget yet, but the driver still can't pull more packets 
> from it because of driver specific conditions. In that case, it will run 
> a loop where ieee80211_next_txq returns the same queue over and over 
> again, and the driver returns it each time (which causes it to get added 
> back to the list).

But that's what the check against schedule_pos is for, right? I.e.,
making sure that we return NULL the second time we encounter the same
node in a scheduling round.

What I'm talking about is the last condition check in this while loop:

+	while (1) {
+		txqi = to_txq_info(txq);
+		if (test_and_clear_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags))
+			break;
+
+		if (txq_has_queue(txq))
+			break;
+
+		airtime_info_next_txq_idx(air_info);
+		txq = air_info->txq[air_info->txq_idx];
+		if (txq_idx == air_info->txq_idx)
+			goto begin;
+	}

(the 'goto begin'). That will only get hit if we've looped through all
the TXQs in an air_info, without finding any that has either the force
bit or a packet queued.

But if we agreed (below) that the logic in ieee80211_return_txq() is:

 	if (force || (txq_has_queue(txq) && ieee80211_txq_airtime_check(hw, &txqi->txq)))
 		__ieee80211_insert_txq(local, air_sched, txqi);
 	else
 		__ieee80211_unschedule_txq(hw, txq, false);


... how does an air_info end up in the skiplist without having either
the force bit or a backlog in at least one TXQ?

>>>> This sets the bit even if the AQL check fails below; is that intentional?
>>> Yes. The bit indicates that the queue should be passed to the driver 
>>> even when mac80211 has no frames queued for it (presumably because the 
>>> driver has queued some internally).
>> 
>> But it won't actually be inserted into the rotation if the AQL check
>> fails (because then the 'else if' check of 'force' won't happen)?
>> 
>> I think the right logic would be:
>> 
>> 	if (force || (txq_has_queue(txq) && ieee80211_txq_airtime_check(hw, &txqi->txq)))
>> 		__ieee80211_insert_txq(local, air_sched, txqi);
>> 	else
>> 		__ieee80211_unschedule_txq(hw, txq, false);
>> 
>> no?
> I thought about it some more, and I think you're right. I was not 
> putting it back into rotation under the assumption that pulled but not 
> fully enqueued packets in the driver don't take up a significant chunk 
> of the AQL budget, but that assumption may not always be true, depending 
> on the driver approach and the tx rate (especially with CCK).

Yup, also the AQL limits are user-configurable, so it's probably best
not to make any assumptions about their magnitude...

>>>> I get the intention behind this, and think it's (probably) reasonable.
>>>> But testing it with an actual ath10k device in push/pull mode would be
>>>> good :)
>>> I'm not very familiar with ath10k, could you help me with that?
>> 
>> Sadly I don't have a good handle on the ath10k either, and there are
>> already issues with the current virtual time-based code in ath10k
>> push/pull-mode. There is some discussion on the openwrt forum[0], which
>> indicates that this patch doesn't help with the issue either.
>> 
>> Unless someone shows up with the time, motivation and hardware to
>> properly fix this, I think the most sensible thing to do may be to just
>> turn the whole of ieee80211_txq_may_transmit() into a wrapper around
>> ieee80211_txq_airtime_check() (i.e., do the AQL check, don't bother with
>> fairness). WDYT?
> I agree. My guess is that proper fairness is probably incompatible with 
> push-pull mode behavior of the firmware anyway.

Yeah, I suspect the reason the old code (back when we did round-robin
scheduling) "works" is that it just keeps looping until the TXQ is
eligible, so it's not enforcing fairness anyway...

-Toke
