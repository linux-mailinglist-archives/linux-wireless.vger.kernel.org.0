Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF2546D28
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbiFJTUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349933AbiFJTUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 15:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2B2E9C0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 12:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF89B835DC
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 19:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75376C34114;
        Fri, 10 Jun 2022 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654888797;
        bh=hJB9CC2SkNBQ9nKXFBpytfKDGjgsfZrFpux9pYYpcm4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CcM8pbtbpGzJ4kzJo4DDlyInKxu+QbzYkGTQq6F6aJSUu+/WDfRveyZOrlT4KkqY8
         19ZRbasQSI8aoJ19iTeK9ZXdnhO4+PGY11ON0SOoNAhWyAPbNKu2p0wOH7zVMm5vpo
         S45/juW17dXzxbJ+dG4mS0JSw82VIMDxL+0gZkP+UKEc+iTQ28y95gmGUigXQD9zoL
         lMYV/RnXM+/UQZJk3KnDmUPmwV99rhyB02IypDlmTgD1VoFD6rG+zcwhUC94djZGpq
         6sWyUjZ4LntYc+N3xhIxfOrhK/TPVTIpxpYtfDCrw9ySZ5NY3ekIpM4sxn4ARmDow3
         PbEETIQJB/TRg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6B184405EE7; Fri, 10 Jun 2022 21:19:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/2] mac80211: rework the airtime fairness implementation
In-Reply-To: <266ef9bc-42c9-59e1-8e7c-368bb8e5179b@nbd.name>
References: <20220603164307.92189-1-nbd@nbd.name>
 <20220603164307.92189-2-nbd@nbd.name> <87a6arowpz.fsf@toke.dk>
 <266ef9bc-42c9-59e1-8e7c-368bb8e5179b@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jun 2022 21:19:54 +0200
Message-ID: <87k09o2un9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 05.06.22 19:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> The current ATF implementation has a number of issues which have shown =
up
>>> during testing. Since it does not take into account the AQL budget of
>>> pending packets, the implementation might queue up large amounts of pac=
kets
>>> for a single txq until airtime gets reported after tx completion.
>>> The same then happens to the next txq afterwards. While the end result =
could
>>> still be considered fair, the bursty behavior introduces a large amount=
 of
>>> latency.
>>> The current code also tries to avoid frequent re-sorting of txq entries=
 in
>>> order to avoid having to re-balance the rbtree often.
>>>
>>> In order to fix these issues, introduce skip lists as a data structure,=
 which
>>> offer similar lookup/insert/delete times as rbtree, but avoids the need=
 for
>>> rebalacing by being probabilistic.
>>> Use this to keep tx entries sorted by virtual time + pending AQL budget=
 and
>>> re-sort after each ieee80211_return_txq call.
>>>
>>> Since multiple txqs share a single air_time struct with a virtual time =
value,
>>> switch the active_txqs list to queue up air_time structs instead of que=
ues.
>>> This helps avoid imbalance between shared txqs by servicing them round =
robin.
>>>
>>> ieee80211_next_txq now only dequeues the first element of active_txqs. =
To
>>> make that work for non-AQL or non-ATF drivers as well, add estimated tx
>>> airtime directly to air_info virtual time if either AQL or ATF is not
>>> supported.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>=20
>> Thank you for working on this! I generally approve of this, with a few
>> comments and questions below:
>>=20
>>> ---
>>>  include/linux/skiplist.h   | 250 +++++++++++++++++++++++++++++++++++++
>>>  net/mac80211/cfg.c         |   5 -
>>>  net/mac80211/ieee80211_i.h |  27 +++-
>>>  net/mac80211/main.c        |   2 +-
>>>  net/mac80211/sta_info.c    |   3 +-
>>>  net/mac80211/sta_info.h    |   6 +-
>>>  net/mac80211/tx.c          | 244 +++++++++++++++++-------------------
>>>  7 files changed, 396 insertions(+), 141 deletions(-)
>>>  create mode 100644 include/linux/skiplist.h
>>>
>>> diff --git a/include/linux/skiplist.h b/include/linux/skiplist.h
>>> new file mode 100644
>>> index 000000000000..2312ed87cfe9
>>> --- /dev/null
>>> +++ b/include/linux/skiplist.h
>>> @@ -0,0 +1,250 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * A skip list is a probabilistic alternative to balanced trees. Unlik=
e the
>>> + * red-black tree, it does not require rebalancing.
>>> + *
>>> + * This implementation uses only unidirectional next pointers and is o=
ptimized
>>> + * for use in a priority queue where elements are mostly deleted from =
the front
>>> + * of the queue.
>>> + *
>>> + * When storing up to 2^n elements in a n-level skiplist. lookup and d=
eletion
>>> + * for the first element happens in O(1) time, other than that, insert=
ion and
>>> + * deletion takes O(log n) time, assuming that the number of elements =
for an
>>> + * n-level list does not exceed 2^n.
>>> + *
>>> + * Usage:
>>> + * DECLARE_SKIPLIST_TYPE(foo, 5) will define the data types for a 5-le=
vel list:
>>> + * struct foo_list: the list data type
>>> + * struct foo_node: the node data for an element in the list
>>> + *
>>> + * DECLARE_SKIPLIST_IMPL(foo, foo_cmp_fn)
>>=20
>> I'm a little bit on the fence as to whether the macro-based definitions
>> is a bit too magical. It's not how any of the other list structures in
>> the kernel is done. OTOH, it's nice to have usage-specific structure
>> names. So yeah, on the fence... Hopefully others have a stronger opinion=
 :)
> I tried to avoid it, but I didn't find a better way to do it. I added it=
=20
> in order to define the number of levels for the skiplist only once and=20
> make the code resolve it for the individual functions at compile time in=
=20
> a type safe way.
> Other data structures in the kernel don't need this, because their=20
> member node struct size typically doesn't change based on a given paramet=
er.

Well, only way I can think of would be doing something like:

#define MAX_SKIPLIST_LEVELS 5
struct skiplist_node {
	struct skiplist_node *next[MAX_SKIPLIST_LEVELS];
};

And then having the init function take the actual number of levels for
that instance and store it in the _list struct. Then, if someone wants
to use the skiplist with more levels at some later point, they'd bump
the MAX_SKIPLIST_LEVELS define and use that for their initialiser.

This will bloat instances with actual levels less than the max by some
extra pointers, of course; so from that perspective the macro approach
is nice from an efficiency PoV if it's likely to expand in the future,
and I can live with keeping it that way if you prefer. If only we had
proper generics in C :(

>>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>>> index 0e4efc08c762..3a81829d2a7a 100644
>>> --- a/net/mac80211/tx.c
>>> +++ b/net/mac80211/tx.c
>>> @@ -3790,21 +3800,26 @@ struct sk_buff *ieee80211_tx_dequeue(struct iee=
e80211_hw *hw,
>>>  encap_out:
>>>  	IEEE80211_SKB_CB(skb)->control.vif =3D vif;
>>>=20=20
>>> -	if (vif &&
>>> -	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)=
) {
>>> -		bool ampdu =3D txq->ac !=3D IEEE80211_AC_VO;
>>> -		u32 airtime;
>>> -
>>> -		airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
>>> -							     skb->len, ampdu);
>>> -		if (airtime) {
>>> -			airtime =3D ieee80211_info_set_tx_time_est(info, airtime);
>>> -			ieee80211_sta_update_pending_airtime(local, tx.sta,
>>> -							     txq->ac,
>>> -							     airtime,
>>> -							     false);
>>> -		}
>>> -	}
>>> +	if (!vif)
>>> +		return skb;
>>> +
>>> +	ampdu =3D txq->ac !=3D IEEE80211_AC_VO;
>>> +	airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
>>> +						     skb->len, ampdu);
>>> +	if (!airtime)
>>> +		return skb;
>>> +
>>> +	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL=
) ||
>>> +	    !wiphy_ext_feature_isset(local->hw.wiphy,
>>> +				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
>>> +		ieee80211_register_airtime(txq, airtime, 0);
>>=20
>> So this implies that we always schedule in airtime order (i.e., enforce
>> fairness) for any driver that can get a meaningful value returned from
>> ieee80211_calc_expected_tx_airtime(), right? That's probably OK, but
>> just want to make sure we've thought through all the implications of
>> this.
>>=20
>> A comment here explaining why this is done would be useful; it's a bit
>> counter-intuitive when just looking at the code. Your comment in the
>> commit message implies that scheduling doesn't work correctly if this is
>> not done, but then what happens if airtime is 0 and we bail out above?
> I guess I need to add something to deal with that corner case, maybe by=20
> returning the smallest possible value for expected tx airtime if it=20
> can't be calculated.

I think there are two approaches here:

- Make sure we always return at least '1' for airtime, so the counter
  always increases on every schedule (effectively making it a frame
  counter instead).

- Make sure the skiplist does the right thing if all entries enqueued
  have the same (0) value (i.e., that it degrades to round-robin).

I think the skiplist does in fact degrade to round-robin since it treats
equality the same as "greater than", but it may be somewhat inefficient
when inserting in this case? Or?

>>> +	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL=
))
>>> +		return skb;
>>> +
>>> +	airtime =3D ieee80211_info_set_tx_time_est(info, airtime);
>>> +	ieee80211_sta_update_pending_airtime(local, tx.sta, txq->ac,
>>> +					     airtime, false);
>>>=20=20
>>>  	return skb;
>>>=20=20
>>> @@ -3815,85 +3830,95 @@ struct sk_buff *ieee80211_tx_dequeue(struct iee=
e80211_hw *hw,
>>>  }
>>>  EXPORT_SYMBOL(ieee80211_tx_dequeue);
>>>=20=20
>>> +static void
>>> +airtime_info_next_txq_idx(struct airtime_info *air_info)
>>> +{
>>> +	air_info->txq_idx++;
>>> +	if (air_info->txq_idx >=3D ARRAY_SIZE(air_info->txq) ||
>>> +	    !air_info->txq[air_info->txq_idx])
>>> +		air_info->txq_idx =3D 0;
>>> +}
>>=20
>> The void function is a bit cumbersome in use IMO. How about making it
>> return the txq pointer directly? You can still save the current txq_idx
>> at the beginning of the loop below to detect cycles.
> Will do that in v2.
>
>>>  struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 a=
c)
>>>  {
>>>  	struct ieee80211_local *local =3D hw_to_local(hw);
>>>  	struct airtime_sched_info *air_sched;
>>>  	u64 now =3D ktime_get_coarse_boottime_ns();
>>> -	struct ieee80211_txq *ret =3D NULL;
>>> +	struct airtime_sched_node *node =3D NULL;
>>> +	struct ieee80211_txq *txq;
>>>  	struct airtime_info *air_info;
>>>  	struct txq_info *txqi =3D NULL;
>>> -	struct rb_node *node;
>>> -	bool first =3D false;
>>> +	u8 txq_idx;
>>>=20=20
>>>  	air_sched =3D &local->airtime[ac];
>>>  	spin_lock_bh(&air_sched->lock);
>>>=20=20
>>> -	node =3D air_sched->schedule_pos;
>>> -
>>>  begin:
>>> -	if (!node) {
>>> -		node =3D rb_first_cached(&air_sched->active_txqs);
>>> -		first =3D true;
>>> -	} else {
>>> -		node =3D rb_next(node);
>>> -	}
>>> +	txq =3D NULL;
>>> +	if (airtime_sched_peek(&air_sched->active_txqs) =3D=3D
>>> +	    air_sched->schedule_pos)
>>> +		goto out;
>>>=20=20
>>> +	node =3D airtime_sched_dequeue(&air_sched->active_txqs);
>>>  	if (!node)
>>>  		goto out;
>>>=20=20
>>> -	txqi =3D container_of(node, struct txq_info, schedule_order);
>>> -	air_info =3D to_airtime_info(&txqi->txq);
>>> +	air_info =3D container_of(node, struct airtime_info, schedule_order);
>>>=20=20
>>> -	if (air_info->v_t > air_sched->v_t &&
>>> -	    (!first || !airtime_catchup_v_t(air_sched, air_info->v_t, now)))
>>> -		goto out;
>>> -
>>> -	if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
>>> -		first =3D false;
>>> +	airtime_info_next_txq_idx(air_info);
>>> +	txq_idx =3D air_info->txq_idx;
>>> +	txq =3D air_info->txq[txq_idx];
>>> +	if (!txq || !ieee80211_txq_airtime_check(hw, txq))
>>>  		goto begin;
>>=20
>> Can txq actually be NULL here? airtime_info_next_txq_idx() has a NULL
>> check inside it as well...
> I don't think it can be NULL, I'll remove the check.
>
>>> +	while (1) {
>>> +		txqi =3D to_txq_info(txq);
>>> +		if (test_and_clear_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags))
>>> +			break;
>>> +
>>> +		if (txq_has_queue(txq))
>>> +			break;
>>> +
>>> +		airtime_info_next_txq_idx(air_info);
>>> +		txq =3D air_info->txq[air_info->txq_idx];
>>> +		if (txq_idx =3D=3D air_info->txq_idx)
>>> +			goto begin;
>>=20
>> How can this happen in normal operation? This implies that a TXQ was
>> scheduled without a backlog; isn't that a bug that we should warn on?
> At least mt76 assumes that calling ieee80211_next_txq in a loop during a=
=20
> scheduling round will eventually return NULL, even when no frames were=20
> queued. ath9k could potentially also need this, depending on the block=20
> ack window state.
> This assumption was valid for the previous implementation, and I figured=
=20
> it would be cleaner and more robust to preserve it.

Sure, I think we should; but doesn't that already happen above, at the
'if (!node)' check? I.e., if the skiplist is empty we'll return NULL.

The 'goto begin' in this inner while loop will happen if an air_info
struct was added to the skiplist, but it has neither frames queued nor
the force bit set on any of its constituent TXQs. How can that happen?

>>> +	}
>>> +
>>> +	if (air_info->v_t_cur > air_sched->v_t) {
>>> +		if (node =3D=3D airtime_sched_peek(&air_sched->active_txqs))
>>> +			airtime_catchup_v_t(air_sched, air_info->v_t_cur, now);
>>=20
>> We obtained node with a dequeue above, so presumably it's no longer at
>> the head of the queue? So how can this check ever be true?
> Right, I forgot to remove this check. It was needed in an earlier local=20
> version of the code where I didn't do the dequeue.

Ah, right :)

>>> @@ -4022,19 +4013,10 @@ static void __ieee80211_unschedule_txq(struct i=
eee80211_hw *hw,
>>>  		ieee80211_update_airtime_weight(local, air_sched, 0, true);
>>>  	}
>>>=20=20
>>> -	if (RB_EMPTY_NODE(&txqi->schedule_order))
>>> -		return;
>>> -
>>> -	if (air_sched->schedule_pos =3D=3D &txqi->schedule_order)
>>> -		air_sched->schedule_pos =3D rb_prev(&txqi->schedule_order);
>>> -
>>> +	airtime_sched_delete(&air_sched->active_txqs, &air_info->schedule_ord=
er);
>>>  	if (!purge)
>>>  		airtime_set_active(air_sched, air_info,
>>>  				   ktime_get_coarse_boottime_ns());
>>=20
>> Now that there's no early return, this could be made an 'else' branch of
>> the if (purge) block above...
> Right, will do that in v2.
>
>>> @@ -4054,14 +4036,24 @@ void ieee80211_return_txq(struct ieee80211_hw *=
hw,
>>>  {
>>>  	struct ieee80211_local *local =3D hw_to_local(hw);
>>>  	struct txq_info *txqi =3D to_txq_info(txq);
>>> +	struct airtime_sched_info *air_sched;
>>> +	struct airtime_info *air_info;
>>>=20=20
>>> -	spin_lock_bh(&local->airtime[txq->ac].lock);
>>> +	air_sched =3D &local->airtime[txq->ac];
>>> +	air_info =3D to_airtime_info(&txqi->txq);
>>>=20=20
>>> -	if (!RB_EMPTY_NODE(&txqi->schedule_order) && !force &&
>>> -	    !txq_has_queue(txq))
>>> -		__ieee80211_unschedule_txq(hw, txq, false);
>>> +	if (force)
>>> +		set_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags);
>>=20
>> This sets the bit even if the AQL check fails below; is that intentional?
> Yes. The bit indicates that the queue should be passed to the driver=20
> even when mac80211 has no frames queued for it (presumably because the=20
> driver has queued some internally).

But it won't actually be inserted into the rotation if the AQL check
fails (because then the 'else if' check of 'force' won't happen)?

I think the right logic would be:

	if (force || (txq_has_queue(txq) && ieee80211_txq_airtime_check(hw, &txqi-=
>txq)))
		__ieee80211_insert_txq(local, air_sched, txqi);
	else
		__ieee80211_unschedule_txq(hw, txq, false);

no?


>>> -	spin_unlock_bh(&local->airtime[txq->ac].lock);
>>> +	spin_lock_bh(&air_sched->lock);
>>> +	if (!ieee80211_txq_airtime_check(hw, &txqi->txq))
>>> +	    airtime_sched_delete(&air_sched->active_txqs,
>>> +				 &air_info->schedule_order);
>>=20
>> why delete here instead of unschedule?
> Right, unschedule makes sense.
>
>>> @@ -4100,46 +4092,48 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
>>>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>>>  				struct ieee80211_txq *txq)
>>>  {
>>> -	struct txq_info *first_txqi =3D NULL, *txqi =3D to_txq_info(txq);
>>> +	struct txq_info *txqi =3D to_txq_info(txq);
>>>  	struct ieee80211_local *local =3D hw_to_local(hw);
>>>  	struct airtime_sched_info *air_sched;
>>> +	struct airtime_sched_node *node =3D NULL;
>>>  	struct airtime_info *air_info;
>>> -	struct rb_node *node =3D NULL;
>>>  	bool ret =3D false;
>>> +	u32 aql_slack;
>>>  	u64 now;
>>>=20=20
>>> -
>>>  	if (!ieee80211_txq_airtime_check(hw, txq))
>>>  		return false;
>>>=20=20
>>>  	air_sched =3D &local->airtime[txq->ac];
>>>  	spin_lock_bh(&air_sched->lock);
>>>=20=20
>>> -	if (RB_EMPTY_NODE(&txqi->schedule_order))
>>> -		goto out;
>>> -
>>>  	now =3D ktime_get_coarse_boottime_ns();
>>>=20=20
>>>  	/* Like in ieee80211_next_txq(), make sure the first station in the
>>>  	 * scheduling order is eligible for transmission to avoid starvation.
>>>  	 */
>>> -	node =3D rb_first_cached(&air_sched->active_txqs);
>>> +	node =3D airtime_sched_peek(&air_sched->active_txqs);
>>>  	if (node) {
>>> -		first_txqi =3D container_of(node, struct txq_info,
>>> -					  schedule_order);
>>> -		air_info =3D to_airtime_info(&first_txqi->txq);
>>> +		air_info =3D container_of(node, struct airtime_info,
>>> +					schedule_order);
>>>=20=20
>>>  		if (air_sched->v_t < air_info->v_t)
>>>  			airtime_catchup_v_t(air_sched, air_info->v_t, now);
>>>  	}
>>>=20=20
>>>  	air_info =3D to_airtime_info(&txqi->txq);
>>> -	if (air_info->v_t <=3D air_sched->v_t) {
>>> +	aql_slack =3D air_info->aql_limit_low;
>>> +	aql_slack *=3D air_info->weight_reciprocal;
>>> +	aql_slack >>=3D IEEE80211_RECIPROCAL_SHIFT_STA - IEEE80211_WEIGHT_SHI=
FT;
>>> +	/*
>>> +	 * add extra slack of aql_limit_low in order to avoid queue
>>> +	 * starvation when bypassing normal scheduling order
>>> +	 */
>>> +	if (air_info->v_t <=3D air_sched->v_t + aql_slack) {
>>=20
>> I get the intention behind this, and think it's (probably) reasonable.
>> But testing it with an actual ath10k device in push/pull mode would be
>> good :)
> I'm not very familiar with ath10k, could you help me with that?

Sadly I don't have a good handle on the ath10k either, and there are
already issues with the current virtual time-based code in ath10k
push/pull-mode. There is some discussion on the openwrt forum[0], which
indicates that this patch doesn't help with the issue either.

Unless someone shows up with the time, motivation and hardware to
properly fix this, I think the most sensible thing to do may be to just
turn the whole of ieee80211_txq_may_transmit() into a wrapper around
ieee80211_txq_airtime_check() (i.e., do the AQL check, don't bother with
fairness). WDYT?

-Toke

[0] https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002/386
