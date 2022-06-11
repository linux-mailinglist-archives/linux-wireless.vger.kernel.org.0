Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5274E547472
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiFKMPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiFKMPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 08:15:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FF139
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=VrCEcn+COrobSARzUGJTBz7IbTQRBga2aXwQl9v5eTw=; b=nlbX0Qk67A0fbdQpvwrKxb9lR3
        b0Wj5A+DVu5vAI4wo3qn64A+BiDIWDR159asqw96fFoycgu/QLzUvwJ1w5DT51yLWMDz03x6y9O/t
        lyB88JA2YgPvszbcWzkgapmFQljaWbtgwxIf6waxP7sCcoyDgCGahioj+G4jFWveBM5I=;
Received: from p57a6f999.dip0.t-ipconnect.de ([87.166.249.153] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o001r-0007UK-Rc; Sat, 11 Jun 2022 14:15:47 +0200
Message-ID: <7d46b779-78e0-7426-6de1-015f5075767c@nbd.name>
Date:   Sat, 11 Jun 2022 14:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20220603164307.92189-1-nbd@nbd.name>
 <20220603164307.92189-2-nbd@nbd.name> <87a6arowpz.fsf@toke.dk>
 <266ef9bc-42c9-59e1-8e7c-368bb8e5179b@nbd.name> <87k09o2un9.fsf@toke.dk>
 <b73eaeb3-f16d-d1a1-2658-ff3d1a6d0d22@nbd.name> <8735gb30zn.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/2] mac80211: rework the airtime fairness implementation
In-Reply-To: <8735gb30zn.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11.06.22 13:15, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
>>>>> So this implies that we always schedule in airtime order (i.e., enforce
>>>>> fairness) for any driver that can get a meaningful value returned from
>>>>> ieee80211_calc_expected_tx_airtime(), right? That's probably OK, but
>>>>> just want to make sure we've thought through all the implications of
>>>>> this.
>>>>> 
>>>>> A comment here explaining why this is done would be useful; it's a bit
>>>>> counter-intuitive when just looking at the code. Your comment in the
>>>>> commit message implies that scheduling doesn't work correctly if this is
>>>>> not done, but then what happens if airtime is 0 and we bail out above?
>>>> I guess I need to add something to deal with that corner case, maybe by 
>>>> returning the smallest possible value for expected tx airtime if it 
>>>> can't be calculated.
>>> 
>>> I think there are two approaches here:
>>> 
>>> - Make sure we always return at least '1' for airtime, so the counter
>>>    always increases on every schedule (effectively making it a frame
>>>    counter instead).
>>> 
>>> - Make sure the skiplist does the right thing if all entries enqueued
>>>    have the same (0) value (i.e., that it degrades to round-robin).
>>> 
>>> I think the skiplist does in fact degrade to round-robin since it treats
>>> equality the same as "greater than", but it may be somewhat inefficient
>>> when inserting in this case? Or?
>> The delete logic in my skiplist code can't properly deal with multiple 
>> items having the same value. Adding that would likely make the 
>> implementation somewhat more complex, so I decided to sidestep it by 
>> making it use an internal wrapper for the comparison function which 
>> compares the pointer address in case of equal value.
> 
> Ah, right, missed that bit; was only looking at insert.
> 
> Okay, but even if you're returning a fixed minimum value for stations
> with no real airtime estimation, that would still result in multiple
> entries with the same value with a high probability.
I'd argue that it's still better than purely round robin scheduling, 
because it at least considers the number of transmitted frames.

> Hmm, how about fixing it by adding an "insert epoch" to the
> skiplist_node? I.e., on insert, walk all the nodes with the same cmp()
> value and set this field to the highest value? Like
> 
> cmp(a, b) {
>   cmpval = __cmpfunc(a, b);
>   if (!cmpval)
>     return a->epoch - b->epoch;
> }
> 
> insert() {
>    while (!cmp(node, list[i])) {
>      i++; node->epoch++;
>    }
> }
> 
> (doesn't quite work, but hopefully you get the gist of it? epoch should
> be reset on dequeue of course).
> 
> Something like this would preserve equal-value elements in the same
> order across insert-remove, at the cost of making insert less efficient
> (I think?) if many items share the same value. Maybe that's acceptable?
I don't think this would really improve scheduling behavior, and it also 
adds to the size of the node struct, so I'd prefer to leave it out.

>>>>> How can this happen in normal operation? This implies that a TXQ was
>>>>> scheduled without a backlog; isn't that a bug that we should warn on?
>>>> At least mt76 assumes that calling ieee80211_next_txq in a loop during a 
>>>> scheduling round will eventually return NULL, even when no frames were 
>>>> queued. ath9k could potentially also need this, depending on the block 
>>>> ack window state.
>>>> This assumption was valid for the previous implementation, and I figured 
>>>> it would be cleaner and more robust to preserve it.
>>> 
>>> Sure, I think we should; but doesn't that already happen above, at the
>>> 'if (!node)' check? I.e., if the skiplist is empty we'll return NULL.
>> In the state that I'm talking about, the skiplist won't be empty. I'm 
>> assuming that the first txq in the list has some queued packets, has not 
>> used its AQL budget yet, but the driver still can't pull more packets 
>> from it because of driver specific conditions. In that case, it will run 
>> a loop where ieee80211_next_txq returns the same queue over and over 
>> again, and the driver returns it each time (which causes it to get added 
>> back to the list).
> 
> But that's what the check against schedule_pos is for, right? I.e.,
> making sure that we return NULL the second time we encounter the same
> node in a scheduling round.
> 
> What I'm talking about is the last condition check in this while loop:
> 
> +	while (1) {
> +		txqi = to_txq_info(txq);
> +		if (test_and_clear_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags))
> +			break;
> +
> +		if (txq_has_queue(txq))
> +			break;
> +
> +		airtime_info_next_txq_idx(air_info);
> +		txq = air_info->txq[air_info->txq_idx];
> +		if (txq_idx == air_info->txq_idx)
> +			goto begin;
> +	}
> 
> (the 'goto begin'). That will only get hit if we've looped through all
> the TXQs in an air_info, without finding any that has either the force
> bit or a packet queued.
Sorry, I got confused here for a moment.

> But if we agreed (below) that the logic in ieee80211_return_txq() is:
> 
>   	if (force || (txq_has_queue(txq) && ieee80211_txq_airtime_check(hw, &txqi->txq)))
>   		__ieee80211_insert_txq(local, air_sched, txqi);
>   	else
>   		__ieee80211_unschedule_txq(hw, txq, false);
> 
> 
> ... how does an air_info end up in the skiplist without having either
> the force bit or a backlog in at least one TXQ?
I guess the check in question is more on the defensive side. I'm not 
100% sure if we can end up with an empty queue on the list, but I'd 
prefer to make sure that we don't accidentally run into an infinite loop 
if that happens. If it ever happens, it's also in my opinion not 
necessarily indicative of a real bug, so I don't want to add a warning 
here either.

>>>>> I get the intention behind this, and think it's (probably) reasonable.
>>>>> But testing it with an actual ath10k device in push/pull mode would be
>>>>> good :)
>>>> I'm not very familiar with ath10k, could you help me with that?
>>> 
>>> Sadly I don't have a good handle on the ath10k either, and there are
>>> already issues with the current virtual time-based code in ath10k
>>> push/pull-mode. There is some discussion on the openwrt forum[0], which
>>> indicates that this patch doesn't help with the issue either.
>>> 
>>> Unless someone shows up with the time, motivation and hardware to
>>> properly fix this, I think the most sensible thing to do may be to just
>>> turn the whole of ieee80211_txq_may_transmit() into a wrapper around
>>> ieee80211_txq_airtime_check() (i.e., do the AQL check, don't bother with
>>> fairness). WDYT?
>> I agree. My guess is that proper fairness is probably incompatible with 
>> push-pull mode behavior of the firmware anyway.
> 
> Yeah, I suspect the reason the old code (back when we did round-robin
> scheduling) "works" is that it just keeps looping until the TXQ is
> eligible, so it's not enforcing fairness anyway...
Makes sense.

- Felix
