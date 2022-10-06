Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB725F6B32
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJFQGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiJFQGK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 12:06:10 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13C8661B39
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 09:06:04 -0700 (PDT)
Message-ID: <7ecc4f00-f883-f251-4367-376f9f62a46e@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665072362;
        bh=WYO9aO67rja1qBIk7lYUhmeTL6khVJnjFdKD5CpYPY0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mmUcnMPZjrXWIYsLhzbB66mhQKP5d8w0MyRnvppM0Wg1mTnMqkFcDbU782VFRkShM
         v02a3IsxHztRM75QHwVLGUZ8FpbnusT+mKsbb1LppAp17m4nzQJLXPmksarzubDybi
         ZUKosCAohSGwOzUw9JQge7WWQD2Y8sP3G2HerW/Y=
Date:   Thu, 6 Oct 2022 18:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.10.22 13:39, Johannes Berg wrote:
> On Mon, 2022-09-26 at 18:13 +0200, Alexander Wetzel wrote:
> 
>> -	trace_drv_wake_tx_queue(local, sdata, txq);
> 
> Technically, I guess we could keep both tracepoints, but it'd be kind of
> pointless since we know statically which driver does which...
> 
>> @@ -596,21 +598,18 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
>>   
>>   	sta->last_connected = ktime_get_seconds();
>>   
>> -	if (local->ops->wake_tx_queue) {
>> -		void *txq_data;
>> -		int size = sizeof(struct txq_info) +
>> -			   ALIGN(hw->txq_data_size, sizeof(void *));
>> +	size = sizeof(struct txq_info) +
>> +	       ALIGN(hw->txq_data_size, sizeof(void *));
>>   
>> -		txq_data = kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
>> -		if (!txq_data)
>> -			goto free;
>> +	txq_data = kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
>> +	if (!txq_data)
>> +		goto free;
>>   
>> -		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
>> -			struct txq_info *txq = txq_data + i * size;
>> +	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
>> +		struct txq_info *txq = txq_data + i * size;
>>   
>> -			/* might not do anything for the bufferable MMPDU TXQ */
>> -			ieee80211_txq_init(sdata, sta, txq, i);
>> -		}
>> +		/* might not do anything for the bufferable MMPDU TXQ */
>> +		ieee80211_txq_init(sdata, sta, txq, i);
> 
> Is that comment still true?
> 

Pretty sure, yes. This patch is not changing anything related to that.
It could change when we are able to handle PS with iTXQ, though. (So far 
only mvm has this queue, no other driver)

Since that is/was a tricky construct for me:
For my understanding this is the non-data queue for stations and the 
comment is a bit misleading:
The queue is theoretical also accepting some non-bufferable frames when 
the interface is in NL80211_IFTYPE_STATION mode. But since an AP never 
sleeps we accept these frames here, too.

Or in other words:
We can't put a MPDU in any iTXQ which may have to be send out to a 
sleeping station. But when our interface is a manged BSS member we know 
that the remote sta (AP) never sleeps, allowing us to use this queue for 
more frame types.


>> +++ b/net/mac80211/util.c
>> @@ -288,6 +288,64 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
>>   }
>>   EXPORT_SYMBOL(ieee80211_ctstoself_duration);
>>   
>> +static void wake_tx_push_queue(struct ieee80211_local *local,
>> +			       struct ieee80211_sub_if_data *sdata,
>> +			       struct ieee80211_txq *queue)
>> +{
>> +	int q = sdata->vif.hw_queue[queue->ac];
>> +	struct ieee80211_tx_control control = {};
>> +	struct sk_buff *skb;
>> +	unsigned long flags;
>> +	bool q_stopped;
>> +
>> +	control.sta = queue->sta;
>> +
>> +	while (1) {
>> +		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
>> +		q_stopped = local->queue_stop_reasons[q];
>> +		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
>> +
>> +		if (q_stopped)
>> +			break;
>> +
>> +		skb = ieee80211_tx_dequeue(&local->hw, queue);
>> +		if (!skb)
>> +			break;
>> +
>> +		drv_tx(local, &control, skb);
>> +	}
>> +}
>> +
>> +void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq)
>> +{
>> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
>> +	struct ieee80211_txq *queue;
>> +
>> +	/* In reconfig don't transmit now, but mark for waking later */
>> +	if (local->in_reconfig) {
>> +		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
>> +		return;
>> +	}
>> +
>> +	if (!check_sdata_in_driver(sdata))
>> +		return;
>> +
>> +	trace_wake_tx_queue(local, sdata, txq);
>> +
>> +	if (local->ops->wake_tx_queue) {
>> +		drv_wake_tx_queue(local, txq);
>> +		return;
>> +	}
>> +
>> +	/* Driver has no native support for iTXQ, handle the queues */
>> +	ieee80211_txq_schedule_start(&local->hw, txq->txq.ac);
>> +	while ((queue = ieee80211_next_txq(&local->hw, txq->txq.ac))) {
>> +		wake_tx_push_queue(local, sdata, queue);
>> +		ieee80211_return_txq(&local->hw, queue, false);
>> +	}
>> +	ieee80211_txq_schedule_end(&local->hw, txq->txq.ac);
>> +}
> 
> Here's another thought:
> 
> Since this code is basically all moved from the original
> drv_wake_tx_queue(), except for the "else" portion (after the if/return)
> of it, another thing we could do is to just have an exported function
> that does this:
> 
> void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
> 				    struct ieee80211_txq *txq)
> {
> 	... *local = from_hw(hw);
> 	... *sdata = from_vif(txq->vif);
> 
> 	wake_tx_push_queue(local, sdata, txq);
> }
> 
> Actually ... I wonder why you'd here - in waking a single TXQ - use
> ieee80211_next_txq() at all, Toke, what do you think?
> 
> 
> Anyway, then we could require drivers set wake_txq to
> ieee80211_handle_wake_tx_queue and make sure in main.c that
> wake_tx_queue is non-NULL.
> 
> That's a bit more churn in drivers, but:
>   * it's not really that hard to do
>   * it avoids an extra function call to then jump to the op
>   * it avoids the tracing changes since now it does look like a driver
>     wake_tx_queue callback
> 
> What do you think?
> 

Makes sense: V2 will then have three patches:
1) adding ieee80211_handle_wake_tx_queue to mac80211
2) switch the drivers without iTXQ support to it
3) drop driver support for the old push path

> johannes

Alexander
