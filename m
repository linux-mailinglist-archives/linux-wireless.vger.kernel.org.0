Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25570B8CDE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408123AbfITI3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 04:29:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405437AbfITI3r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 04:29:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 076B26141B; Fri, 20 Sep 2019 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968186;
        bh=po+eh5stL8hcqg3N0m0FhhYOQeepkwxi+k0bIJXTXJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z4DbnXfbedDBEaPl/4gpVNUBan3rkYFifsLFRNnAcrwjQl+JKacH1UoOSm+oXcPex
         0ZSBRcg+wp0Fk1fZD2vau1OUK0+oXnagH4Y05N3LSjcbCqanveNgLlfw5WYjhlGuwp
         1RGdLdqAYEm8E69sNDEQhW7TOwvgEVqwY0gmaDS0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2C28460850;
        Fri, 20 Sep 2019 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968184;
        bh=po+eh5stL8hcqg3N0m0FhhYOQeepkwxi+k0bIJXTXJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/lXF2Nq9wV0AwRbJOB6/XMBy15HL7QYb5t/lRfW+iI+VcF+xLp91NSSJ3wv3X/Ng
         iSZeq3ccxFFppCaOisP8VPXwgmme5+BEza2dSv8/psHq61qSTlfeQg1017H1J5kGYG
         j3V9PAXo7J4bygFKTY4C2h3LxVsT+G/Sw5aKcPJ0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Sep 2019 16:29:44 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87tv98fu6l.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
 <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org>
 <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org>
 <87tv98fu6l.fsf@toke.dk>
Message-ID: <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-19 18:37, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> On 2019-09-18 19:23, Toke Høiland-Jørgensen wrote:
>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>> 
>>>> On 2019-09-18 05:10, Toke Høiland-Jørgensen wrote:
>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>> 
>>>>>> In a loop txqs dequeue scenario, if the first txq in the rbtree 
>>>>>> gets
>>>>>> removed from rbtree immediately in the ieee80211_return_txq(), the
>>>>>> loop will break soon in the ieee80211_next_txq() due to 
>>>>>> schedule_pos
>>>>>> not leading to the second txq in the rbtree. Thus, defering the
>>>>>> removal right before the end of this schedule round.
>>>>>> 
>>>>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
>>>>> 
>>>>> I didn't write this patch, so please don't use my sign-off. I'll 
>>>>> add
>>>>> ack or review tags as appropriate in reply; but a few comments 
>>>>> first:
>>>>> 
>>>>>> ---
>>>>>>  include/net/mac80211.h     | 16 ++++++++++--
>>>>>>  net/mac80211/ieee80211_i.h |  3 +++
>>>>>>  net/mac80211/main.c        |  6 +++++
>>>>>>  net/mac80211/tx.c          | 63
>>>>>> +++++++++++++++++++++++++++++++++++++++++++---
>>>>>>  4 files changed, 83 insertions(+), 5 deletions(-)
>>>>>> 
>>>>>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>>>>>> index ac2ed8e..ba5a345 100644
>>>>>> --- a/include/net/mac80211.h
>>>>>> +++ b/include/net/mac80211.h
>>>>>> @@ -925,6 +925,8 @@ struct ieee80211_tx_rate {
>>>>>> 
>>>>>>  #define IEEE80211_MAX_TX_RETRY		31
>>>>>> 
>>>>>> +#define IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS 100
>>>>>> +
>>>>>>  static inline void ieee80211_rate_set_vht(struct 
>>>>>> ieee80211_tx_rate
>>>>>> *rate,
>>>>>>  					  u8 mcs, u8 nss)
>>>>>>  {
>>>>>> @@ -6232,7 +6234,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct
>>>>>> ieee80211_hw *hw,
>>>>>>   * @ac: AC number to return packets from.
>>>>>>   *
>>>>>>   * Should only be called between calls to
>>>>>> ieee80211_txq_schedule_start()
>>>>>> - * and ieee80211_txq_schedule_end().
>>>>>> + * and ieee80211_txq_schedule_end(). If the txq is empty, it will
>>>>>> be
>>>>>> added
>>>>>> + * to a remove list and get removed later.
>>>>>>   * Returns the next txq if successful, %NULL if no queue is
>>>>>> eligible.
>>>>>> If a txq
>>>>>>   * is returned, it should be returned with ieee80211_return_txq()
>>>>>> after the
>>>>>>   * driver has finished scheduling it.
>>>>>> @@ -6268,7 +6271,8 @@ void ieee80211_txq_schedule_start(struct
>>>>>> ieee80211_hw *hw, u8 ac)
>>>>>>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>>>>>>   * @ac: AC number to acquire locks for
>>>>>>   *
>>>>>> - * Release locks previously acquired by
>>>>>> ieee80211_txq_schedule_end().
>>>>>> + * Release locks previously acquired by
>>>>>> ieee80211_txq_schedule_end().
>>>>>> Check
>>>>>> + * and remove the empty txq from rb-tree.
>>>>>>   */
>>>>>>  void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
>>>>>>  	__releases(txq_lock);
>>>>>> @@ -6287,6 +6291,14 @@ void ieee80211_schedule_txq(struct
>>>>>> ieee80211_hw
>>>>>> *hw, struct ieee80211_txq *txq)
>>>>>>  	__acquires(txq_lock) __releases(txq_lock);
>>>>>> 
>>>>>>  /**
>>>>>> + * ieee80211_txqs_check - Check txqs waiting for removal
>>>>>> + *
>>>>>> + * @tmr: pointer as obtained from local
>>>>>> + *
>>>>>> + */
>>>>>> +void ieee80211_txqs_check(struct timer_list *tmr);
>>>>>> +
>>>>>> +/**
>>>>>>   * ieee80211_txq_may_transmit - check whether TXQ is allowed to
>>>>>> transmit
>>>>>>   *
>>>>>>   * This function is used to check whether given txq is allowed to
>>>>>> transmit by
>>>>>> diff --git a/net/mac80211/ieee80211_i.h 
>>>>>> b/net/mac80211/ieee80211_i.h
>>>>>> index a4556f9..49aa143e 100644
>>>>>> --- a/net/mac80211/ieee80211_i.h
>>>>>> +++ b/net/mac80211/ieee80211_i.h
>>>>>> @@ -847,6 +847,7 @@ struct txq_info {
>>>>>>  	struct codel_stats cstats;
>>>>>>  	struct sk_buff_head frags;
>>>>>>  	struct rb_node schedule_order;
>>>>>> +	struct list_head candidate;
>>>>>>  	unsigned long flags;
>>>>>> 
>>>>>>  	/* keep last! */
>>>>>> @@ -1145,6 +1146,8 @@ struct ieee80211_local {
>>>>>>  	u64 airtime_v_t[IEEE80211_NUM_ACS];
>>>>>>  	u64 airtime_weight_sum[IEEE80211_NUM_ACS];
>>>>>> 
>>>>>> +	struct list_head remove_list[IEEE80211_NUM_ACS];
>>>>>> +	struct timer_list remove_timer;
>>>>>>  	u16 airtime_flags;
>>>>>> 
>>>>>>  	const struct ieee80211_ops *ops;
>>>>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>>>>> index e9ffa8e..78fe24a 100644
>>>>>> --- a/net/mac80211/main.c
>>>>>> +++ b/net/mac80211/main.c
>>>>>> @@ -667,10 +667,15 @@ struct ieee80211_hw
>>>>>> *ieee80211_alloc_hw_nm(size_t priv_data_len,
>>>>>> 
>>>>>>  	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
>>>>>>  		local->active_txqs[i] = RB_ROOT_CACHED;
>>>>>> +		INIT_LIST_HEAD(&local->remove_list[i]);
>>>>>>  		spin_lock_init(&local->active_txq_lock[i]);
>>>>>>  	}
>>>>>>  	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
>>>>>> 
>>>>>> +	timer_setup(&local->remove_timer, ieee80211_txqs_check, 0);
>>>>>> +	mod_timer(&local->remove_timer,
>>>>>> +		  jiffies +
>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>> +
>>>>>>  	INIT_LIST_HEAD(&local->chanctx_list);
>>>>>>  	mutex_init(&local->chanctx_mtx);
>>>>>> 
>>>>>> @@ -1305,6 +1310,7 @@ void ieee80211_unregister_hw(struct
>>>>>> ieee80211_hw
>>>>>> *hw)
>>>>>>  	tasklet_kill(&local->tx_pending_tasklet);
>>>>>>  	tasklet_kill(&local->tasklet);
>>>>>> 
>>>>>> +	del_timer_sync(&local->remove_timer);
>>>>>>  #ifdef CONFIG_INET
>>>>>>  	unregister_inetaddr_notifier(&local->ifa_notifier);
>>>>>>  #endif
>>>>>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>>>>>> index d00baaa..42ca010 100644
>>>>>> --- a/net/mac80211/tx.c
>>>>>> +++ b/net/mac80211/tx.c
>>>>>> @@ -1450,6 +1450,7 @@ void ieee80211_txq_init(struct
>>>>>> ieee80211_sub_if_data *sdata,
>>>>>>  	codel_stats_init(&txqi->cstats);
>>>>>>  	__skb_queue_head_init(&txqi->frags);
>>>>>>  	RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>> +	INIT_LIST_HEAD(&txqi->candidate);
>>>>>> 
>>>>>>  	txqi->txq.vif = &sdata->vif;
>>>>>> 
>>>>>> @@ -3724,6 +3725,9 @@ void ieee80211_schedule_txq(struct
>>>>>> ieee80211_hw
>>>>>> *hw,
>>>>>> 
>>>>>>  	spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>> 
>>>>>> +	if (!list_empty(&txqi->candidate))
>>>>>> +		list_del_init(&txqi->candidate);
>>>>>> +
>>>>>>  	if (!RB_EMPTY_NODE(&txqi->schedule_order))
>>>>>>  		goto out;
>>>>>> 
>>>>>> @@ -3783,6 +3787,20 @@ static void 
>>>>>> __ieee80211_unschedule_txq(struct
>>>>>> ieee80211_hw *hw,
>>>>>>  	RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>>  }
>>>>>> 
>>>>>> +void ieee80211_remove_txq(struct ieee80211_hw *hw,
>>>>>> +			  struct ieee80211_txq *txq)
>>>>>> +{
>>>>>> +	struct ieee80211_local *local = hw_to_local(hw);
>>>>>> +	struct txq_info *txqi = to_txq_info(txq);
>>>>>> +
>>>>>> +	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>> +
>>>>>> +	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
>>>>>> +		__ieee80211_unschedule_txq(hw, txq);
>>>>>> +		list_del_init(&txqi->candidate);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>>  void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
>>>>>>  			      struct ieee80211_txq *txq)
>>>>>>  	__acquires(txq_lock) __releases(txq_lock)
>>>>>> @@ -3790,7 +3808,7 @@ void ieee80211_unschedule_txq(struct
>>>>>> ieee80211_hw *hw,
>>>>>>  	struct ieee80211_local *local = hw_to_local(hw);
>>>>>> 
>>>>>>  	spin_lock_bh(&local->active_txq_lock[txq->ac]);
>>>>>> -	__ieee80211_unschedule_txq(hw, txq);
>>>>>> +	ieee80211_remove_txq(hw, txq);
>>>>>>  	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
>>>>>>  }
>>>>>> 
>>>>>> @@ -3803,11 +3821,48 @@ void ieee80211_return_txq(struct
>>>>>> ieee80211_hw
>>>>>> *hw,
>>>>>>  	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>> 
>>>>>>  	if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
>>>>>> -	    (skb_queue_empty(&txqi->frags) && 
>>>>>> !txqi->tin.backlog_packets))
>>>>>> -		__ieee80211_unschedule_txq(hw, txq);
>>>>>> +		!txq_has_queue(&txqi->txq) &&
>>>>>> +		list_empty(&txqi->candidate))
>>>>>> +		list_add_tail(&txqi->candidate, &local->remove_list[txq->ac]);
>>>>>> +
>>>>>>  }
>>>>>>  EXPORT_SYMBOL(ieee80211_return_txq);
>>>>>> 
>>>>>> +void __ieee80211_check_txqs(struct ieee80211_local *local, int 
>>>>>> ac)
>>>>>> +{
>>>>>> +	struct txq_info *iter, *tmp;
>>>>>> +	struct sta_info *sta;
>>>>>> +
>>>>>> +	lockdep_assert_held(&local->active_txq_lock[ac]);
>>>>>> +
>>>>>> +	list_for_each_entry_safe(iter, tmp, &local->remove_list[ac],
>>>>>> +				 candidate) {
>>>>>> +		sta = container_of(iter->txq.sta, struct sta_info, sta);
>>>>>> +
>>>>>> +		if (txq_has_queue(&iter->txq))
>>>>>> +			list_del_init(&iter->candidate);
>>>>>> +		else
>>>>>> +			ieee80211_remove_txq(&local->hw, &iter->txq);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +void ieee80211_txqs_check(struct timer_list *t)
>>>>>> +{
>>>>>> +	struct ieee80211_local *local = from_timer(local, t,
>>>>>> remove_timer);
>>>>>> +	struct txq_info *iter, *tmp;
>>>>>> +	struct sta_info *sta;
>>>>>> +	int ac;
>>>>>> +
>>>>>> +	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
>>>>>> +		spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>> +		__ieee80211_check_txqs(local, ac);
>>>>>> +		spin_unlock_bh(&local->active_txq_lock[ac]);
>>>>>> +	}
>>>>>> +
>>>>>> +	mod_timer(&local->remove_timer,
>>>>>> +		  jiffies +
>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>> +}
>>>>> 
>>>>> I'll ask the same as I did last time (where you told me to hold off
>>>>> until this round):
>>>>> 
>>>>> Why do you need the timer and the periodic check? If TXQs are added
>>>>> to
>>>>> the remove list during the scheduling run, and
>>>>> __ieee80211_check_txqs()
>>>>> is run from schedule_end(), isn't that sufficient to clear the 
>>>>> list?
>>>> Is it possible that a txq is not added to the remove list but then
>>>> packets in it are dropped by fq_codel algo? Like the station
>>>> disconnects
>>>> without any notification.
>>> 
>>> Well as long as all the other cleanup paths call directly into
>>> __unschedule_txq(), that should remove stations from the scheduler 
>>> when
>>> they disconnect etc.
>> Yes, the disconnect scenario is a bad example. My concern is, say, we
>> have 10 stations and only one of them is assigned a very small weight
>> compared with that of others. Suppose, after its chance of Tx, it is
>> most likely to be placed in the rightmost(still has some packets in 
>> the
>> txq) and no more incoming data for it. The remaining packets in txq 
>> will
>> be dropped due to timeout algo in codel(correct me if I am wrong) but
>> this empty txq will stay on the rbtree until other txqs get drained or
>> global vt catch up with its vt. The staying time could be long if 
>> weight
>> is extremely small. Then do we need timer to check or any other better
>> solution?
> 
> Ah, I see what you mean. No, I don't think this will be a problem; the
> scenario you're describing would play out like this:
> 
> 1. Station ends transmitting, still has a single packet queued, gets
>    moved to the end of the rbtree (and stays there for a while).
> 
> 2. When we finally get to the point where this station gets another
>    chance to transmit, the CoDel drop timer triggers and the last 
> packet
>    is dropped[0]. This means that the queue will just be empty
>    (and ieee80211_tx_dequeue() will return NULL).
> 
> 3. Because the queue is empty, ieee80211_return_txq() will not put it
>    back on the rbtree.
> 
> Crucially, in 2. the CoDel algorithm doesn't kick in until the point of
> packet dequeue. But even if an empty queue stays on the rbtree for a
> while, there is no harm in that: eventually it will get its turn, it
> will turn out to be empty, and just be skipped over.
Then that will be fine. Thanks for the explanation of the dropping part 
in CoDel algorithm.
> 
> The issue we need to be concerned about is the opposite: If we have a
> queue that *does* have packets queued, but which is *not* scheduled for
> transmission, that will stall TX.
Is it by design since its vt is more than global vt, right? The lattency 
may somehow get impacted though.
> 
> [0] CoDel in most cases only drops a single packet at a time, so it 
> will
> not clear out an entire queue with multiple packets in one go. But you
> are right that it could conceivably drop the last packet in a queue.
> 
>>> We only need to defer removal inside a single "scheduling round" 
>>> (i.e.,
>>> between a pair of ieee80211_txq_schedule_start/end. So if we just 
>>> walk
>>> the remove list in schedule_end() we should be enough, no?
>>> 
>>> Hmm, or maybe a simpler way to fix the original issue is just to have
>>> unschedule_txq() update the schedule_pos() pointer?
>>> 
>>> I.e., unschedule_txq checks if the txq being removed is currently 
>>> being
>>> pointed to by schedule_pos[ac], and if it is, it updates schedule_pos
>>> to
>>> be the rb_next of the current value?
>> Actually, if schedule_pos is updated to rb_next of the current value,
>> then in the next_txq() where we are going to use rb_next again and
>> finally pick the next node of the node we really want. Is it fine to
>> update schedule_pos to NULL?
> 
> Hmm, yeah, good point.
> 
> If we do end up setting schedule_pos to NULL in the middle of a
> scheduling round, that will make next_txq() "start over", and do 
> another
> loop through the whole thing. I guess we may be able hit a case where
> things can oscillate back and forth between addition and removal
> resulting in an infinite loop? Not sure, but at least I can't seem to
> convince myself that this can't happen.

As the loop of next_txq under lock protection as below,

txq_schedule_start();
while(txq=next_txq()){
...
return_txq(txq);
}
txq_schedule_end();

I do not see any chance of addition, no?
In ath10k, we will usually push packets of first txq as many as we can 
until it is drained and then move to the next one. So if a txq gets 
removed in the return_txq, it should always be the leftmost. And during 
this period, neither vt of any station or global vt can be updated due 
to lock protection.

> 
> But in that case, we could fix it by just conditionally assigning 
> either
> rb_next or rb_prev to the schedule_pos in unschedule_txq()? I.e.,
> something like:
> 
> local->schedule_pos[ac] = rb_next(node) ?: rb_prev(node);
I am not sure I am getting your point. Still in next_txq, 
schedule_pos[ac] will lead us to the next node of the one we want.
> 
> -Toke

-- 
Yibo
