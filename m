Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CEA5F0583
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiI3HJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiI3HJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 03:09:15 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3E4F1E276F
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 00:09:13 -0700 (PDT)
Message-ID: <4496641c-9f7d-a61e-78af-35e9bb7c3a40@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1664521751;
        bh=Z4qWwvYO+onm4fXUolRleWfc0pgfqvs+lWO22Cnv9U0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q2F+PrHG0ij5A42GsF4Tn+7QETRYXoZgHVhokDzjXuOA90hvVVy0Ju5H1+MXfZcpn
         p4/PXZ20wNLBSjzqg8i7vzuXsFY2xSxGOkJrN/KYW1bniWOw3aaU9e+Yh0C7jI5Q/T
         9/K6iIX+yBTFzt1mnXG7rViWES/sOqrzt4KPP18A=
Date:   Fri, 30 Sep 2022 09:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <87wn9ml0no.fsf@toke.dk>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <87wn9ml0no.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<resend to all, sorry for duplicates >

On 29.09.22 16:23, Toke Høiland-Jørgensen wrote:

[...]
>> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
>> index 9f4377566c42..cde169038429 100644
>> --- a/net/mac80211/trace.h
>> +++ b/net/mac80211/trace.h
>> @@ -2301,37 +2301,6 @@ TRACE_EVENT(drv_tdls_recv_channel_switch,
>>   	)
>>   );
>>   
>> -TRACE_EVENT(drv_wake_tx_queue,
>> -	TP_PROTO(struct ieee80211_local *local,
>> -		 struct ieee80211_sub_if_data *sdata,
>> -		 struct txq_info *txq),
>> -
>> -	TP_ARGS(local, sdata, txq),
>> -
>> -	TP_STRUCT__entry(
>> -		LOCAL_ENTRY
>> -		VIF_ENTRY
>> -		STA_ENTRY
>> -		__field(u8, ac)
>> -		__field(u8, tid)
>> -	),
>> -
>> -	TP_fast_assign(
>> -		struct ieee80211_sta *sta = txq->txq.sta;
>> -
>> -		LOCAL_ASSIGN;
>> -		VIF_ASSIGN;
>> -		STA_ASSIGN;
>> -		__entry->ac = txq->txq.ac;
>> -		__entry->tid = txq->txq.tid;
>> -	),
>> -
>> -	TP_printk(
>> -		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
>> -		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
>> -	)
>> -);
>> -
>>   TRACE_EVENT(drv_get_ftm_responder_stats,
>>   	TP_PROTO(struct ieee80211_local *local,
>>   		 struct ieee80211_sub_if_data *sdata,
>> @@ -3026,6 +2995,37 @@ TRACE_EVENT(stop_queue,
>>   	)
>>   );
>>   
>> +TRACE_EVENT(wake_tx_queue,
> 
> I know tracepoints are technically not considered API, but that doesn't
> mean we *have* to break them if there's no reason to. And since the
> actual contents is the same, how about keeping the old name as an alias
> for this?
> 

I don't understand what we would gain by an alias.
For me it looks like an alias would just be confusing and never be used...

Or why would anyone want to make additional calls to 
trace[_drv]_wake_tx_queue() on top what we have in the patch?

I initially also considered to simply keep trace_drv_wake_tx_queue(). 
(But that looked to be misleading.) If there is some reason to keep the 
old name I would just switch back to trace_drv_wake_tx_queue().

But when we are discussing that code anyhow, there is another related issue:
I was not sure if it's ok to keep the renamed wake_tx_queue trace call 
in the old position. (In the section otherwise only having driver 
calls.) Having a better structured file did seem more desirable than a 
shorter patch, so I moved it.

[...]
>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index 48deda3570a7..f4dc1ddbe2ea 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -1599,9 +1599,6 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
>>   	bool supp_vht = false;
>>   	enum nl80211_band band;
>>   
>> -	if (!local->ops->wake_tx_queue)
>> -		return 0;
>> -
>>   	ret = fq_init(fq, 4096);
>>   	if (ret)
>>   		return ret;
>> @@ -1649,9 +1646,6 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
>>   {
>>   	struct fq *fq = &local->fq;
>>   
>> -	if (!local->ops->wake_tx_queue)
>> -		return;
>> -
>>   	kfree(local->cvars);
>>   	local->cvars = NULL;
>>   
>> @@ -1668,8 +1662,7 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
>>   	struct ieee80211_vif *vif;
>>   	struct txq_info *txqi;
>>   
>> -	if (!local->ops->wake_tx_queue ||
>> -	    sdata->vif.type == NL80211_IFTYPE_MONITOR)
>> +	if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
>>   		return false;
>>   
>>   	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>> @@ -4184,12 +4177,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>>   	if (IS_ERR(sta))
>>   		sta = NULL;
>>   
>> -	if (local->ops->wake_tx_queue) {
>> -		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
>> -		skb_set_queue_mapping(skb, queue);
>> -		skb_get_hash(skb);
> 
> This skb_get_hash is there to ensure that the hash is calculated early
> (in particular, before packets are encrypted). This improves the
> behaviour of the FQ, since that will just use the skb->hash value if
> it's set. In most cases the operation here will be a noop because the
> packet was already hashed somewhere in the ingress path, but I think we
> should probably keep this call intact anyway...
> 

Got it and I'll change that in v2. I'll wait for more feedback some days 
- or at least till we have sorted out the issue with 
trace_drv_wake_tx_queue alias above.

[...]

Thanks,
Alexander

