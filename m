Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF3533B3B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiEYLCv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiEYLCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 07:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CFB233A35
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653476568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8tsgh1ccs5uN+XjBy58PPjJ8oivnMej95KEP2UBGE8=;
        b=b0dlbfW1aGk16LxbY+mBKT8x0J6i3wIi/UVxh5VtpyH65uMxTyFNW0HYGmNKnm0uCXTpUd
        ePCiTuyYbMkZIByzyPSEQPBtP7FDvQosar2w2R9p7rI/marjVEnPdU6LJJ7r6i2cXBuTIC
        li6fUsTJOo+GhhVmET2xKTZ9iehouIE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-eqs-Pgw7Ooec1uKHE7LhHQ-1; Wed, 25 May 2022 07:02:46 -0400
X-MC-Unique: eqs-Pgw7Ooec1uKHE7LhHQ-1
Received: by mail-ej1-f71.google.com with SMTP id bk16-20020a170906b0d000b006fe34a2e598so9284223ejb.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 04:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=U8tsgh1ccs5uN+XjBy58PPjJ8oivnMej95KEP2UBGE8=;
        b=F2s2Jk7EoVpo93TAWeGP6jMfUTfsf9sJvSJ/8drZB+DKkjHvpnkSJyHJxh68cHIq1a
         IpV3pBZuune0fNBvdoR9YB4DfRIxW+I1LgjRxej6xLsbiyaGXCzWf1TYiec3rAgLT4xc
         tduGz0odg8Pz4k9t/4WpDCpFWPfzg4s3vDMaoqObpzhipsM4I3ir8uFgd5p8PQH7r7oi
         VzUIAJ2W2096M4f4C37lkUVWaNw4+USvmUT7rbdS58Bn9cV99DOZ/KziWjcPsOJeN1PO
         1v7MkornOKztJdL1EeRlkU4bF8G9+1y+/t+lUBs6mVZ2ubNiivGdpq/hPUF//JcihrZK
         oJpA==
X-Gm-Message-State: AOAM530K+iT2R9QcUjwsA5dPNvh2gQnYVi06Ex7oXAQeB0RzT3fRLqBP
        /D9gVUftOom+vGjyehY0ocykfxQPTNhGtwu71KpWc85bp7HMQ9COdApEiMdzwiSSI1cHGdf+ga6
        mBkxMTDFN5es1SSUQWtTtxPSxwUw=
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr33664426edv.35.1653476565627;
        Wed, 25 May 2022 04:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFYZtxgjMVMnq9mo9h0AR1W6426oamDPgcdGhR/YwkxFKJjd/XVL5U3uNZnOId/fcd5HTUdA==
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr33664391edv.35.1653476565218;
        Wed, 25 May 2022 04:02:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a50c111000000b0042b9c322348sm1362171edf.35.2022.05.25.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:02:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A925B3DED45; Wed, 25 May 2022 13:02:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Baligh Gasmi <gasmibal@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Baligh Gasmi <gasmibal@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] mac80211: use AQL airtime for expected throughput.
In-Reply-To: <20220525103512.3666956-1-gasmibal@gmail.com>
References: <20220525103512.3666956-1-gasmibal@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 25 May 2022 13:02:43 +0200
Message-ID: <87r14hoox8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baligh Gasmi <gasmibal@gmail.com> writes:

> Since the integration of AQL, packet TX airtime estimation is
> calculated and counted to be used for the dequeue limit.
>
> Use this estimated airtime to compute expected throughput for
> each station.
>
> It will be a generic mac80211 implementation. If the driver has
> get_expected_throughput implementation, it will be used instead.
>
> Useful for L2 routing protocols, like B.A.T.M.A.N.
>
> Signed-off-by: Baligh Gasmi <gasmibal@gmail.com>
> ---
>  net/mac80211/driver-ops.h |  2 ++
>  net/mac80211/sta_info.h   |  2 ++
>  net/mac80211/status.c     | 22 ++++++++++++++++++++++
>  net/mac80211/tx.c         |  3 ++-
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
> index 4e2fc1a08681..4331b79647fa 100644
> --- a/net/mac80211/driver-ops.h
> +++ b/net/mac80211/driver-ops.h
> @@ -1142,6 +1142,8 @@ static inline u32 drv_get_expected_throughput(struct ieee80211_local *local,
>  	trace_drv_get_expected_throughput(&sta->sta);
>  	if (local->ops->get_expected_throughput && sta->uploaded)
>  		ret = local->ops->get_expected_throughput(&local->hw, &sta->sta);
> +	else
> +		ret = ewma_avg_est_tp_read(&sta->status_stats.avg_est_tp);
>  	trace_drv_return_u32(local, ret);
>  
>  	return ret;
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index 379fd367197f..fe60be4c671d 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -123,6 +123,7 @@ enum ieee80211_sta_info_flags {
>  #define HT_AGG_STATE_STOP_CB		7
>  #define HT_AGG_STATE_SENT_ADDBA		8
>  
> +DECLARE_EWMA(avg_est_tp, 8, 16)
>  DECLARE_EWMA(avg_signal, 10, 8)
>  enum ieee80211_agg_stop_reason {
>  	AGG_STOP_DECLINED,
> @@ -641,6 +642,7 @@ struct sta_info {
>  		s8 last_ack_signal;
>  		bool ack_signal_filled;
>  		struct ewma_avg_signal avg_ack_signal;
> +		struct ewma_avg_est_tp avg_est_tp;
>  	} status_stats;
>  
>  	/* Updated from TX path only, no locking requirements */
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index e81e8a5bb774..647ade3719f5 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -1145,6 +1145,28 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
>  			sta->status_stats.retry_failed++;
>  		sta->status_stats.retry_count += retry_count;
>  
> +		if (skb && tx_time_est) {

Shouldn't this be conditioned on actually being used (i.e., existence of
get_expected_throughput op? Also maybe pull it out into its own function
to make it clear what it's doing...

> +			/* max average packet size */
> +			size_t pkt_size = skb->len > 1024 ? 1024 : skb->len;
> +
> +			if (acked) {
> +				/* ACK packet size */
> +				pkt_size += 14;
> +				/* SIFS x 2 */
> +				tx_time_est += 2 * 2;
> +			}
> +
> +			/* Backoff average x retries */
> +			tx_time_est += retry_count ? retry_count * 2 : 2;
> +
> +			/* failed tx */
> +			if (!acked && !noack_success)
> +				pkt_size = 0;
> +
> +			ewma_avg_est_tp_add(&sta->status_stats.avg_est_tp,
> +					    ((pkt_size * 8) * 1000) / tx_time_est);

Could we avoid adding this division in the fast path?

> +		}
> +
>  		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
>  			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
>  			    skb && !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index b6b20f38de0e..d866a721690d 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3793,7 +3793,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  	IEEE80211_SKB_CB(skb)->control.vif = vif;
>  
>  	if (vif &&
> -	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
> +	    (!local->ops->get_expected_throughput ||
> +	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))) {

This implicitly enables AQL for every driver that doesn't set
get_expected_throughput, no? That is probably not a good idea...

-Toke

