Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8045F5466
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJEM0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJEM0g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 08:26:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938550539
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 05:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0208B81DE6
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 12:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61928C433D6;
        Wed,  5 Oct 2022 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664972792;
        bh=UiAg4jq2x3Wz/bR+b5iFRxIYFE6TILn59zRK0fCGpbE=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=TSBf50es3WerurZqikSTYj4mMUS8QSUEfS1zL8foJkuy3O1Sxzs1YGXOtJ49a6cej
         TnqJiHLgTr96m/LHKAAtf/A3Wze6QfQWgG1IZsSGWnZQ88JJEgVEnEDSYqooZPuna4
         IAy0hsm3/dsOFLCgrXepKgGwxDT1OeRhB4sVCFs5Vo0Oa597qTW44c81j2JiOWeuka
         2nhZEpAIDBQVw6rdXJ6PBoeRbVQtZ9T3fKVeClzqrA6PxXpQbkqheK/qDsMoEwHKIn
         s+CW50vTAGq/TKzxkizTizHUjm9goG6cmRFR1vFiNtoGcd2VrsplikYeFEFlpMaMQM
         V/9/oge2x+HYg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E658864EB9A; Wed,  5 Oct 2022 14:26:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
In-Reply-To: <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Oct 2022 14:26:29 +0200
Message-ID: <875ygyihhm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2022-09-26 at 18:13 +0200, Alexander Wetzel wrote:
>
>> -	trace_drv_wake_tx_queue(local, sdata, txq);
>
> Technically, I guess we could keep both tracepoints, but it'd be kind of
> pointless since we know statically which driver does which...
>
>> @@ -596,21 +598,18 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
>>  
>>  	sta->last_connected = ktime_get_seconds();
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
>> +++ b/net/mac80211/util.c
>> @@ -288,6 +288,64 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
>>  }
>>  EXPORT_SYMBOL(ieee80211_ctstoself_duration);
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

Well, this patch does almost exactly the same as the ath9k driver does,
for instance. Really, the wake_tx_queue() is a signal to the driver to
start transmitting on the *hardware* queue that the txq points to. For
some drivers (like Intel, right?) that's a 1-to-1 mapping, for others
there are multiple TXQs being scheduled on the same HW-TXQ. So I think
it's probably the right thing to do to just call next_txq(); if there's
only a single TXQ scheduled it should be pretty cheap to do so.

This logic has implications for putting "urgent" frames (like PS(?)) on
TXQs as well, of course, but that needs to be handled somehow anyway...

> Anyway, then we could require drivers set wake_txq to
> ieee80211_handle_wake_tx_queue and make sure in main.c that
> wake_tx_queue is non-NULL.
>
> That's a bit more churn in drivers, but:
>  * it's not really that hard to do
>  * it avoids an extra function call to then jump to the op
>  * it avoids the tracing changes since now it does look like a driver
>    wake_tx_queue callback
>
> What do you think?

Sounds reasonable :)

-Toke
