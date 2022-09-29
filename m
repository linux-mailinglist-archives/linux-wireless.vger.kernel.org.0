Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3954F5EF768
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiI2OXx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiI2OXv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 10:23:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013485A8AE
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A4CBB82493
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 14:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D5C433B5;
        Thu, 29 Sep 2022 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664461426;
        bh=hulOfCV0vCF220TM/6WLuKnAfz+cd+wrLKpVmc7Q6ro=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m+J5bjhAMZF3k5KyJVvts6rhB9Mm1e5gGgNU+VigrZ/56o+IuKaH0dQxBhXO89zI8
         50i302sIm9qgGmp337aRwiEAmKod8gAuvv4w/bMPby6rM16x44Nu6VlfFOZc9kFHBY
         sajoHpV7IiRcIqNN87qewn4XaXhU4+BDDvudnhUYN4EauoapM6Qo3OR1zvZ0L0p+8R
         PyD5syg2uIrmbnj3eeQbbxQc4U1loUGesm2IH60u+zsIpXZZhE4ArPwO+JwwtYkjlq
         fJBVQsF+cj/0BWcT6aX3rLgOrBf3trU2JrSxJXDlpNQCvyRhGSgjtxmwLI7t0OPf38
         PJsk8DSlSeBfw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1363F64E045; Thu, 29 Sep 2022 16:23:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
In-Reply-To: <20220926161303.13035-1-alexander@wetzel-home.de>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Sep 2022 16:23:39 +0200
Message-ID: <87wn9ml0no.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> writes:

> Align TX handling and use mac80211 internal TX queues (iTXQs) for
> drivers not implementing the optional .wake_tx_queue operation.
>
> mac80211 will handle the iTXQs and push frames via the drv_tx operation
> when a driver is not implementing .wake_tx_queue.
>
> As a side effect this converts all netdev interfaces created by mac80211
> to be non-queuing (using qdisc noqueue).
>
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

Great to see this! I'm actually surprised it doesn't take more code than
this. A few minor-ish comments below:

[...]

> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
> index 9f4377566c42..cde169038429 100644
> --- a/net/mac80211/trace.h
> +++ b/net/mac80211/trace.h
> @@ -2301,37 +2301,6 @@ TRACE_EVENT(drv_tdls_recv_channel_switch,
>  	)
>  );
>  
> -TRACE_EVENT(drv_wake_tx_queue,
> -	TP_PROTO(struct ieee80211_local *local,
> -		 struct ieee80211_sub_if_data *sdata,
> -		 struct txq_info *txq),
> -
> -	TP_ARGS(local, sdata, txq),
> -
> -	TP_STRUCT__entry(
> -		LOCAL_ENTRY
> -		VIF_ENTRY
> -		STA_ENTRY
> -		__field(u8, ac)
> -		__field(u8, tid)
> -	),
> -
> -	TP_fast_assign(
> -		struct ieee80211_sta *sta = txq->txq.sta;
> -
> -		LOCAL_ASSIGN;
> -		VIF_ASSIGN;
> -		STA_ASSIGN;
> -		__entry->ac = txq->txq.ac;
> -		__entry->tid = txq->txq.tid;
> -	),
> -
> -	TP_printk(
> -		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
> -		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
> -	)
> -);
> -
>  TRACE_EVENT(drv_get_ftm_responder_stats,
>  	TP_PROTO(struct ieee80211_local *local,
>  		 struct ieee80211_sub_if_data *sdata,
> @@ -3026,6 +2995,37 @@ TRACE_EVENT(stop_queue,
>  	)
>  );
>  
> +TRACE_EVENT(wake_tx_queue,

I know tracepoints are technically not considered API, but that doesn't
mean we *have* to break them if there's no reason to. And since the
actual contents is the same, how about keeping the old name as an alias
for this?

> +	TP_PROTO(struct ieee80211_local *local,
> +		 struct ieee80211_sub_if_data *sdata,
> +		 struct txq_info *txq),
> +
> +	TP_ARGS(local, sdata, txq),
> +
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		VIF_ENTRY
> +		STA_ENTRY
> +		__field(u8, ac)
> +		__field(u8, tid)
> +	),
> +
> +	TP_fast_assign(
> +		struct ieee80211_sta *sta = txq->txq.sta;
> +
> +		LOCAL_ASSIGN;
> +		VIF_ASSIGN;
> +		STA_ASSIGN;
> +		__entry->ac = txq->txq.ac;
> +		__entry->tid = txq->txq.tid;
> +	),
> +
> +	TP_printk(
> +		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
> +		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
> +	)
> +);
> +
>  #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 48deda3570a7..f4dc1ddbe2ea 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -1599,9 +1599,6 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
>  	bool supp_vht = false;
>  	enum nl80211_band band;
>  
> -	if (!local->ops->wake_tx_queue)
> -		return 0;
> -
>  	ret = fq_init(fq, 4096);
>  	if (ret)
>  		return ret;
> @@ -1649,9 +1646,6 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
>  {
>  	struct fq *fq = &local->fq;
>  
> -	if (!local->ops->wake_tx_queue)
> -		return;
> -
>  	kfree(local->cvars);
>  	local->cvars = NULL;
>  
> @@ -1668,8 +1662,7 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
>  	struct ieee80211_vif *vif;
>  	struct txq_info *txqi;
>  
> -	if (!local->ops->wake_tx_queue ||
> -	    sdata->vif.type == NL80211_IFTYPE_MONITOR)
> +	if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
>  		return false;
>  
>  	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
> @@ -4184,12 +4177,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>  	if (IS_ERR(sta))
>  		sta = NULL;
>  
> -	if (local->ops->wake_tx_queue) {
> -		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
> -		skb_set_queue_mapping(skb, queue);
> -		skb_get_hash(skb);

This skb_get_hash is there to ensure that the hash is calculated early
(in particular, before packets are encrypted). This improves the
behaviour of the FQ, since that will just use the skb->hash value if
it's set. In most cases the operation here will be a noop because the
packet was already hashed somewhere in the ingress path, but I think we
should probably keep this call intact anyway...

> -	}
> -
> +	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
>  	ieee80211_aggr_check(sdata, sta, skb);
>  
>  	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
> @@ -4495,11 +4483,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
>  	struct tid_ampdu_tx *tid_tx;
>  	u8 tid;
>  
> -	if (local->ops->wake_tx_queue) {
> -		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
> -		skb_set_queue_mapping(skb, queue);
> -		skb_get_hash(skb);

As above.


-Toke
