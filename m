Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4932654517D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jun 2022 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiFIQDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jun 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiFIQDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jun 2022 12:03:01 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533F1D0CF
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jun 2022 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=xFyfzBxB9cXuqDZPYCzry5cKXt5vi1lbGDEyHTEH5RA=; b=JuZqkIzchmBIMc6WI7VrYH7lQA
        mok6F303Zwtaj2spNKctvZJkNkX2a6TWWmv3rERk1YRpsxlc9OtRMLa5xqJXxbwe6Ia8INHdjtaeg
        Y9bCA2UO+SMp9Lq2ml2Mzx1syNhgH5anmktXjsaHZKZHXBsfn1B1aRwmw+q6Hdsc/XcI=;
Received: from p57a6f999.dip0.t-ipconnect.de ([87.166.249.153] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nzKcb-0003TY-Pc; Thu, 09 Jun 2022 18:02:57 +0200
Message-ID: <266ef9bc-42c9-59e1-8e7c-368bb8e5179b@nbd.name>
Date:   Thu, 9 Jun 2022 18:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20220603164307.92189-1-nbd@nbd.name>
 <20220603164307.92189-2-nbd@nbd.name> <87a6arowpz.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/2] mac80211: rework the airtime fairness implementation
In-Reply-To: <87a6arowpz.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.06.22 19:18, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> The current ATF implementation has a number of issues which have shown up
>> during testing. Since it does not take into account the AQL budget of
>> pending packets, the implementation might queue up large amounts of packets
>> for a single txq until airtime gets reported after tx completion.
>> The same then happens to the next txq afterwards. While the end result could
>> still be considered fair, the bursty behavior introduces a large amount of
>> latency.
>> The current code also tries to avoid frequent re-sorting of txq entries in
>> order to avoid having to re-balance the rbtree often.
>>
>> In order to fix these issues, introduce skip lists as a data structure, which
>> offer similar lookup/insert/delete times as rbtree, but avoids the need for
>> rebalacing by being probabilistic.
>> Use this to keep tx entries sorted by virtual time + pending AQL budget and
>> re-sort after each ieee80211_return_txq call.
>>
>> Since multiple txqs share a single air_time struct with a virtual time value,
>> switch the active_txqs list to queue up air_time structs instead of queues.
>> This helps avoid imbalance between shared txqs by servicing them round robin.
>>
>> ieee80211_next_txq now only dequeues the first element of active_txqs. To
>> make that work for non-AQL or non-ATF drivers as well, add estimated tx
>> airtime directly to air_info virtual time if either AQL or ATF is not
>> supported.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> Thank you for working on this! I generally approve of this, with a few
> comments and questions below:
> 
>> ---
>>  include/linux/skiplist.h   | 250 +++++++++++++++++++++++++++++++++++++
>>  net/mac80211/cfg.c         |   5 -
>>  net/mac80211/ieee80211_i.h |  27 +++-
>>  net/mac80211/main.c        |   2 +-
>>  net/mac80211/sta_info.c    |   3 +-
>>  net/mac80211/sta_info.h    |   6 +-
>>  net/mac80211/tx.c          | 244 +++++++++++++++++-------------------
>>  7 files changed, 396 insertions(+), 141 deletions(-)
>>  create mode 100644 include/linux/skiplist.h
>>
>> diff --git a/include/linux/skiplist.h b/include/linux/skiplist.h
>> new file mode 100644
>> index 000000000000..2312ed87cfe9
>> --- /dev/null
>> +++ b/include/linux/skiplist.h
>> @@ -0,0 +1,250 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * A skip list is a probabilistic alternative to balanced trees. Unlike the
>> + * red-black tree, it does not require rebalancing.
>> + *
>> + * This implementation uses only unidirectional next pointers and is optimized
>> + * for use in a priority queue where elements are mostly deleted from the front
>> + * of the queue.
>> + *
>> + * When storing up to 2^n elements in a n-level skiplist. lookup and deletion
>> + * for the first element happens in O(1) time, other than that, insertion and
>> + * deletion takes O(log n) time, assuming that the number of elements for an
>> + * n-level list does not exceed 2^n.
>> + *
>> + * Usage:
>> + * DECLARE_SKIPLIST_TYPE(foo, 5) will define the data types for a 5-level list:
>> + * struct foo_list: the list data type
>> + * struct foo_node: the node data for an element in the list
>> + *
>> + * DECLARE_SKIPLIST_IMPL(foo, foo_cmp_fn)
> 
> I'm a little bit on the fence as to whether the macro-based definitions
> is a bit too magical. It's not how any of the other list structures in
> the kernel is done. OTOH, it's nice to have usage-specific structure
> names. So yeah, on the fence... Hopefully others have a stronger opinion :)
I tried to avoid it, but I didn't find a better way to do it. I added it 
in order to define the number of levels for the skiplist only once and 
make the code resolve it for the individual functions at compile time in 
a type safe way.
Other data structures in the kernel don't need this, because their 
member node struct size typically doesn't change based on a given parameter.


>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index 0e4efc08c762..3a81829d2a7a 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -3790,21 +3800,26 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>  encap_out:
>>  	IEEE80211_SKB_CB(skb)->control.vif = vif;
>>  
>> -	if (vif &&
>> -	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
>> -		bool ampdu = txq->ac != IEEE80211_AC_VO;
>> -		u32 airtime;
>> -
>> -		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
>> -							     skb->len, ampdu);
>> -		if (airtime) {
>> -			airtime = ieee80211_info_set_tx_time_est(info, airtime);
>> -			ieee80211_sta_update_pending_airtime(local, tx.sta,
>> -							     txq->ac,
>> -							     airtime,
>> -							     false);
>> -		}
>> -	}
>> +	if (!vif)
>> +		return skb;
>> +
>> +	ampdu = txq->ac != IEEE80211_AC_VO;
>> +	airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
>> +						     skb->len, ampdu);
>> +	if (!airtime)
>> +		return skb;
>> +
>> +	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL) ||
>> +	    !wiphy_ext_feature_isset(local->hw.wiphy,
>> +				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
>> +		ieee80211_register_airtime(txq, airtime, 0);
> 
> So this implies that we always schedule in airtime order (i.e., enforce
> fairness) for any driver that can get a meaningful value returned from
> ieee80211_calc_expected_tx_airtime(), right? That's probably OK, but
> just want to make sure we've thought through all the implications of
> this.
> 
> A comment here explaining why this is done would be useful; it's a bit
> counter-intuitive when just looking at the code. Your comment in the
> commit message implies that scheduling doesn't work correctly if this is
> not done, but then what happens if airtime is 0 and we bail out above?
I guess I need to add something to deal with that corner case, maybe by 
returning the smallest possible value for expected tx airtime if it 
can't be calculated.

>> +	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
>> +		return skb;
>> +
>> +	airtime = ieee80211_info_set_tx_time_est(info, airtime);
>> +	ieee80211_sta_update_pending_airtime(local, tx.sta, txq->ac,
>> +					     airtime, false);
>>  
>>  	return skb;
>>  
>> @@ -3815,85 +3830,95 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>  }
>>  EXPORT_SYMBOL(ieee80211_tx_dequeue);
>>  
>> +static void
>> +airtime_info_next_txq_idx(struct airtime_info *air_info)
>> +{
>> +	air_info->txq_idx++;
>> +	if (air_info->txq_idx >= ARRAY_SIZE(air_info->txq) ||
>> +	    !air_info->txq[air_info->txq_idx])
>> +		air_info->txq_idx = 0;
>> +}
> 
> The void function is a bit cumbersome in use IMO. How about making it
> return the txq pointer directly? You can still save the current txq_idx
> at the beginning of the loop below to detect cycles.
Will do that in v2.

>>  struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
>>  {
>>  	struct ieee80211_local *local = hw_to_local(hw);
>>  	struct airtime_sched_info *air_sched;
>>  	u64 now = ktime_get_coarse_boottime_ns();
>> -	struct ieee80211_txq *ret = NULL;
>> +	struct airtime_sched_node *node = NULL;
>> +	struct ieee80211_txq *txq;
>>  	struct airtime_info *air_info;
>>  	struct txq_info *txqi = NULL;
>> -	struct rb_node *node;
>> -	bool first = false;
>> +	u8 txq_idx;
>>  
>>  	air_sched = &local->airtime[ac];
>>  	spin_lock_bh(&air_sched->lock);
>>  
>> -	node = air_sched->schedule_pos;
>> -
>>  begin:
>> -	if (!node) {
>> -		node = rb_first_cached(&air_sched->active_txqs);
>> -		first = true;
>> -	} else {
>> -		node = rb_next(node);
>> -	}
>> +	txq = NULL;
>> +	if (airtime_sched_peek(&air_sched->active_txqs) ==
>> +	    air_sched->schedule_pos)
>> +		goto out;
>>  
>> +	node = airtime_sched_dequeue(&air_sched->active_txqs);
>>  	if (!node)
>>  		goto out;
>>  
>> -	txqi = container_of(node, struct txq_info, schedule_order);
>> -	air_info = to_airtime_info(&txqi->txq);
>> +	air_info = container_of(node, struct airtime_info, schedule_order);
>>  
>> -	if (air_info->v_t > air_sched->v_t &&
>> -	    (!first || !airtime_catchup_v_t(air_sched, air_info->v_t, now)))
>> -		goto out;
>> -
>> -	if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
>> -		first = false;
>> +	airtime_info_next_txq_idx(air_info);
>> +	txq_idx = air_info->txq_idx;
>> +	txq = air_info->txq[txq_idx];
>> +	if (!txq || !ieee80211_txq_airtime_check(hw, txq))
>>  		goto begin;
> 
> Can txq actually be NULL here? airtime_info_next_txq_idx() has a NULL
> check inside it as well...
I don't think it can be NULL, I'll remove the check.

>> +	while (1) {
>> +		txqi = to_txq_info(txq);
>> +		if (test_and_clear_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags))
>> +			break;
>> +
>> +		if (txq_has_queue(txq))
>> +			break;
>> +
>> +		airtime_info_next_txq_idx(air_info);
>> +		txq = air_info->txq[air_info->txq_idx];
>> +		if (txq_idx == air_info->txq_idx)
>> +			goto begin;
> 
> How can this happen in normal operation? This implies that a TXQ was
> scheduled without a backlog; isn't that a bug that we should warn on?
At least mt76 assumes that calling ieee80211_next_txq in a loop during a 
scheduling round will eventually return NULL, even when no frames were 
queued. ath9k could potentially also need this, depending on the block 
ack window state.
This assumption was valid for the previous implementation, and I figured 
it would be cleaner and more robust to preserve it.

>> +	}
>> +
>> +	if (air_info->v_t_cur > air_sched->v_t) {
>> +		if (node == airtime_sched_peek(&air_sched->active_txqs))
>> +			airtime_catchup_v_t(air_sched, air_info->v_t_cur, now);
> 
> We obtained node with a dequeue above, so presumably it's no longer at
> the head of the queue? So how can this check ever be true?
Right, I forgot to remove this check. It was needed in an earlier local 
version of the code where I didn't do the dequeue.


>> @@ -4022,19 +4013,10 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
>>  		ieee80211_update_airtime_weight(local, air_sched, 0, true);
>>  	}
>>  
>> -	if (RB_EMPTY_NODE(&txqi->schedule_order))
>> -		return;
>> -
>> -	if (air_sched->schedule_pos == &txqi->schedule_order)
>> -		air_sched->schedule_pos = rb_prev(&txqi->schedule_order);
>> -
>> +	airtime_sched_delete(&air_sched->active_txqs, &air_info->schedule_order);
>>  	if (!purge)
>>  		airtime_set_active(air_sched, air_info,
>>  				   ktime_get_coarse_boottime_ns());
> 
> Now that there's no early return, this could be made an 'else' branch of
> the if (purge) block above...
Right, will do that in v2.

>> @@ -4054,14 +4036,24 @@ void ieee80211_return_txq(struct ieee80211_hw *hw,
>>  {
>>  	struct ieee80211_local *local = hw_to_local(hw);
>>  	struct txq_info *txqi = to_txq_info(txq);
>> +	struct airtime_sched_info *air_sched;
>> +	struct airtime_info *air_info;
>>  
>> -	spin_lock_bh(&local->airtime[txq->ac].lock);
>> +	air_sched = &local->airtime[txq->ac];
>> +	air_info = to_airtime_info(&txqi->txq);
>>  
>> -	if (!RB_EMPTY_NODE(&txqi->schedule_order) && !force &&
>> -	    !txq_has_queue(txq))
>> -		__ieee80211_unschedule_txq(hw, txq, false);
>> +	if (force)
>> +		set_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags);
> 
> This sets the bit even if the AQL check fails below; is that intentional?
Yes. The bit indicates that the queue should be passed to the driver 
even when mac80211 has no frames queued for it (presumably because the 
driver has queued some internally).

>> -	spin_unlock_bh(&local->airtime[txq->ac].lock);
>> +	spin_lock_bh(&air_sched->lock);
>> +	if (!ieee80211_txq_airtime_check(hw, &txqi->txq))
>> +	    airtime_sched_delete(&air_sched->active_txqs,
>> +				 &air_info->schedule_order);
> 
> why delete here instead of unschedule?
Right, unschedule makes sense.

>> @@ -4100,46 +4092,48 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
>>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>>  				struct ieee80211_txq *txq)
>>  {
>> -	struct txq_info *first_txqi = NULL, *txqi = to_txq_info(txq);
>> +	struct txq_info *txqi = to_txq_info(txq);
>>  	struct ieee80211_local *local = hw_to_local(hw);
>>  	struct airtime_sched_info *air_sched;
>> +	struct airtime_sched_node *node = NULL;
>>  	struct airtime_info *air_info;
>> -	struct rb_node *node = NULL;
>>  	bool ret = false;
>> +	u32 aql_slack;
>>  	u64 now;
>>  
>> -
>>  	if (!ieee80211_txq_airtime_check(hw, txq))
>>  		return false;
>>  
>>  	air_sched = &local->airtime[txq->ac];
>>  	spin_lock_bh(&air_sched->lock);
>>  
>> -	if (RB_EMPTY_NODE(&txqi->schedule_order))
>> -		goto out;
>> -
>>  	now = ktime_get_coarse_boottime_ns();
>>  
>>  	/* Like in ieee80211_next_txq(), make sure the first station in the
>>  	 * scheduling order is eligible for transmission to avoid starvation.
>>  	 */
>> -	node = rb_first_cached(&air_sched->active_txqs);
>> +	node = airtime_sched_peek(&air_sched->active_txqs);
>>  	if (node) {
>> -		first_txqi = container_of(node, struct txq_info,
>> -					  schedule_order);
>> -		air_info = to_airtime_info(&first_txqi->txq);
>> +		air_info = container_of(node, struct airtime_info,
>> +					schedule_order);
>>  
>>  		if (air_sched->v_t < air_info->v_t)
>>  			airtime_catchup_v_t(air_sched, air_info->v_t, now);
>>  	}
>>  
>>  	air_info = to_airtime_info(&txqi->txq);
>> -	if (air_info->v_t <= air_sched->v_t) {
>> +	aql_slack = air_info->aql_limit_low;
>> +	aql_slack *= air_info->weight_reciprocal;
>> +	aql_slack >>= IEEE80211_RECIPROCAL_SHIFT_STA - IEEE80211_WEIGHT_SHIFT;
>> +	/*
>> +	 * add extra slack of aql_limit_low in order to avoid queue
>> +	 * starvation when bypassing normal scheduling order
>> +	 */
>> +	if (air_info->v_t <= air_sched->v_t + aql_slack) {
> 
> I get the intention behind this, and think it's (probably) reasonable.
> But testing it with an actual ath10k device in push/pull mode would be
> good :)
I'm not very familiar with ath10k, could you help me with that?

Thanks for the detailed review!

- Felix
