Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4663611A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiKWOHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiKWOG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 09:06:59 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE7887A5B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 06:03:27 -0800 (PST)
Message-ID: <a5fd1369-7323-8e0d-5e3a-bd758ad7b5ba@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1669212203;
        bh=G9aMGUG58fYS6WeXm13WKeVMiwfuYs9+A5lKpTbcO4c=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=CqiSq3ZGJ/wk33foTwbyKtgdnm5kTpkBHhoMdJymlHq8jPxECm7AwvtoGVXOlnqB6
         e6eYUTB01tAEcy/jp1UNps7YQXgDUeWiX7h645/9jxke1/HFXifPus0A2y6If1Rb8p
         UKfLmGSqKLuoRtTwoTLNKzAqeA32D1mFAnBvHMlU=
Date:   Wed, 23 Nov 2022 15:03:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] wifi: mac80211: integrate PS buffering into iTXQ
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20221102184005.10649-1-alexander@wetzel-home.de>
 <19418837778881777379446e65938b455fbb523a.camel@sipsolutions.net>
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <19418837778881777379446e65938b455fbb523a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22.11.22 22:25, Johannes Berg wrote:
> On Wed, 2022-11-02 at 19:40 +0100, Alexander Wetzel wrote:
>>
>> +++ b/net/mac80211/sta_info.c
>> @@ -114,6 +114,28 @@ static int link_sta_info_hash_del(struct ieee80211_local *local,
>>   			       link_sta_rht_params);
>>   }
>>   
>> +static void num_sta_ps_dec_for_mc_txq(struct ieee80211_sub_if_data *sdata,
>> +				      atomic_t *num_sta_ps)
> 
> passing the pointer to the atomic_t variable seems a bit odd here, maybe
> pass the 'ps' pointer here:
> 

Makes sense, I'll change that.

>> +		/* can call wake_tx_queue for vif.txq */
>> +		num_sta_ps_dec_for_mc_txq(sdata, &ps->num_sta_ps);
> 
> instead?
> 
> Also maybe that comment should be a couple of lines above on the
> local_bh_disable() since that's the context requirement for that?
> 

ieee80211_sta_ps_deliver_wakeup() has the same comment/call just without 
local_bh_disable()

Having the comment for the function which may call wake_tx_queue() makes 
more sense for me. But I'll move the comment some lines up.

>> @@ -1046,8 +1070,8 @@ static void __sta_info_recalc_tim(struct sta_info *sta, bool ignore_pending)
>>   		if (ignore_for_tim & ieee80211_ac_to_qos_mask[ac])
>>   			continue;
>>   
>> -		indicate_tim |= !skb_queue_empty(&sta->tx_filtered[ac]) ||
>> -				!skb_queue_empty(&sta->ps_tx_buf[ac]);
>> +		indicate_tim |= !skb_queue_empty(&sta->tx_filtered[ac]);
> 
> This seems odd, we must indicate the TIM whenever we have *any* traffic
> pending to that STA? IOW also if there's anything on the TXQs?
> 

Yes, looks odd in the patch. But this is only the "early" indicate_tim set.
If there are no filtered frame the code continues.
And the existing code is already checking if we have anything in the 
iTXQ and then sets the the variable.

Here a "commented" sniped of the relevant code:

         for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
                 unsigned long tids;

                 if (ignore_for_tim & ieee80211_ac_to_qos_mask[ac])
                         continue;

                 indicate_tim |= !skb_queue_empty(&sta->tx_filtered[ac]);

                 if (indicate_tim)	
			//if true we don't have to check (more) iTXQs
                         break;

                 tids = ieee80211_tids_for_ac(ac);

                 indicate_tim |=
                         sta->driver_buffered_tids & tids;

		// This will set indicate_tim if anything is in the iTXQ
                 indicate_tim |=
                         sta->txq_buffered_tids & tids;
         }

>> @@ -1553,23 +1547,11 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
>>   
>>   	BUILD_BUG_ON(BITS_TO_LONGS(IEEE80211_NUM_TIDS) > 1);
>>   	sta->driver_buffered_tids = 0;
>> -	sta->txq_buffered_tids = 0;
>>   
>>   	if (!ieee80211_hw_check(&local->hw, AP_LINK_PS))
>>   		drv_sta_notify(local, sdata, STA_NOTIFY_AWAKE, &sta->sta);
>>   
>> -	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
>> -		if (!sta->sta.txq[i] || !txq_has_queue(sta->sta.txq[i]))
>> -			continue;
>> -
>> -		schedule_and_wake_txq(local, to_txq_info(sta->sta.txq[i]));
>> -	}
>> -
>> -	skb_queue_head_init(&pending);
>> -
>> -	/* sync with ieee80211_tx_h_unicast_ps_buf */
>> -	spin_lock(&sta->ps_lock);
>> -	/* Send all buffered frames to the station */
>> +	/* Send all filtered frames to the station */
>>   	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
>>   		int count = skb_queue_len(&pending), tmp;
>>   
>> @@ -1579,16 +1561,39 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
>>   		tmp = skb_queue_len(&pending);
>>   		filtered += tmp - count;
>>   		count = tmp;
>> -
>> -		spin_lock_irqsave(&sta->ps_tx_buf[ac].lock, flags);
>> -		skb_queue_splice_tail_init(&sta->ps_tx_buf[ac], &pending);
>> -		spin_unlock_irqrestore(&sta->ps_tx_buf[ac].lock, flags);
>> -		tmp = skb_queue_len(&pending);
>> -		buffered += tmp - count;
>>   	}
>>   
>> +	skb_queue_head_init(&pending);
>>   	ieee80211_add_pending_skbs(local, &pending);
> 
> It seems to me you moved the skb_queue_head_init() erroneously, it's
> still needed for the loop for the filtered frames?
> 
> If you reinit here you probably leak, and if it's not inited before you
> probably crash?
> 

Agree. That has somehow slipped to a wrong position. Will move that back.


>> +	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
>> +		if (!sta->sta.txq[i])
>> +			continue;
>> +
>> +		txqi = to_txq_info(sta->sta.txq[i]);
>> +		clear_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
>> +	}
> 
> Should we really do this before pending are transmitted? Actually I'm a
> bit confused about ieee80211_add_pending_skbs() now - does that mean
> those frames don't go to the driver via TXQs?
> 

That is a complicate question:-)

Short answer is, that this is already broken and this patch is not 
fixing it. The transmit logic for pending frames is not changed.
And yes, pending tx path is not (yet) using iTXQs.

The patch has a - probably incomplete - drive-by fix and reorders the 
actions to first try to send out pending/filtered frames. (I commented 
on that shortly in the v1 patch.)

Old logic was: Send out iTXQ, send filtered, send buffered.
New logic is: Send out filtered, send iTXQ.

When taking back a step and looking at how pending frames are handled in 
more detail there is no difference to the current code:
ieee80211_add_pending_skbs() is still simply adding the skbs to 
local->pending. (The original code is doing that for filtered and 
buffered frames, the patched one only for filtered.)

These frames are then send via the tx_pending_tasklet. Which gets 
scheduled in __ieee80211_wake_queue() and thus directly with the 
ieee80211_add_pending_skbs() call.

In other words:
Calling ieee80211_add_pending_skbs() will schedule a run for 
tx_pending_tasklet to send out the frames via ieee80211_tx_pending_skb() 
and ultimately using drv_tx(). Not using iTXQs.

But I do not see how the code makes sure that the tasklet run happens 
prior to dequeuing frames from the iTXQs. So that's probably another bug.

I can also look into that. Either by starting to use iTXQs also for 
filtered frames or a more simple stop gap solution for now.

All assuming I read understand the code right and don't miss a clever 
way the current code still ends up doing the right thing...

Alexander

> johannes

