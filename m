Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D5BD937
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437608AbfIYHhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 03:37:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbfIYHhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 03:37:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B30B1611D1; Wed, 25 Sep 2019 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569397043;
        bh=px9OAsbOU/ibGuwYN0wC3R9woTZO327A8jXehViy47s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ux7rgm68DZhcWylFF9ZEf72HNMGH9fz0TEdvvGkmc7xynkw9WtRbbJdkSsdsygTiH
         BMpF7S9YcNPGmN37huZQGtsrmc1uYQioOW7usfGR4Vt9hLR0fuWUsZ0TxUfGk91Gmc
         MCmLXzrynmzufbhzaSjDBOzNsmKACuD/aD71K4rk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 831DB6115A;
        Wed, 25 Sep 2019 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569397042;
        bh=px9OAsbOU/ibGuwYN0wC3R9woTZO327A8jXehViy47s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lcMgPoVh/bW3AYMDdv8GgH5AKA80XE7XIKvRnmI0oIn8Cy09Mnm1vHIVLBiWmOaax
         AF4+jEtZ96aCtPJH94dVIl6zpJDfFRdsrwO/t4MRlVG59i+ELNjRbM4g+5DLHYXBt+
         t5Bd+BAVUkEH58Z2+Fpof5hu918Gu9yoHK8YSiK4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Sep 2019 15:37:22 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
In-Reply-To: <156889576869.191202.510507546538322707.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
Message-ID: <2f6b649dcb788222e070ebb5593918c7@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-19 20:22, Toke Høiland-Jørgensen wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Some devices have deep buffers in firmware and/or hardware which 
> prevents
> the FQ structure in mac80211 from effectively limiting bufferbloat on 
> the
> link. For Ethernet devices we have BQL to limit the lower-level queues, 
> but
> this cannot be applied to mac80211 because transmit rates can vary 
> wildly
> between packets depending on which station we are transmitting it to.
> 
> To overcome this, we can use airtime-based queue limiting (AQL), where 
> we
> estimate the transmission time for each packet before dequeueing it, 
> and
> use that to limit the amount of data in-flight to the hardware. This 
> idea
> was originally implemented as part of the out-of-tree airtime fairness
> patch to ath10k[0] in chromiumos.
> 
> This patch ports that idea over to mac80211. The basic idea is simple
> enough: Whenever we dequeue a packet from the TXQs and send it to the
> driver, we estimate its airtime usage, based on the last recorded TX 
> rate
> of the station that packet is destined for. We keep a running per-AC 
> total
> of airtime queued for the whole device, and when that total climbs 
> above 8
> ms' worth of data (corresponding to two maximum-sized aggregates), we
> simply throttle the queues until it drops down again.
> 
> The estimated airtime for each skb is stored in the tx_info, so we can
> subtract the same amount from the running total when the skb is freed 
> or
> recycled. The throttling mechanism relies on this accounting to be
> accurate (i.e., that we are not freeing skbs without subtracting any
> airtime they were accounted for), so we put the subtraction into
> ieee80211_report_used_skb().
> 
> This patch does *not* include any mechanism to wake a throttled TXQ 
> again,
> on the assumption that this will happen anyway as a side effect of 
> whatever
> freed the skb (most commonly a TX completion).
> 
> The throttling mechanism only kicks in if the queued airtime total goes
> above the limit. Since mac80211 calculates the time based on the 
> reported
> last_tx_time from the driver, the whole throttling mechanism only kicks 
> in
> for drivers that actually report this value. With the exception of
> multicast, where we always calculate an estimated tx time on the 
> assumption
> that multicast is transmitted at the lowest (6 Mbps) rate.
> 
> The throttling added in this patch is in addition to any throttling 
> already
> performed by the airtime fairness mechanism, and in principle the two
> mechanisms are orthogonal (and currently also uses two different 
> sources of
> airtime). In the future, we could amend this, using the airtime 
> estimates
> calculated by this mechanism as a fallback input to the airtime 
> fairness
> scheduler, to enable airtime fairness even on drivers that don't have a
> hardware source of airtime usage for each station.
> 
So if it is going to work together with virtual time based mechanism in 
the future, the Tx criteria will be met both of below conditions,
        1. Lower than g_vt
        2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT

Are we going to maintain two kinds of airtime that one is from 
estimation and the other is basically from FW reporting?

Meanwhile, airtime_queued will also limit the situation that we only 
have a station for transmission. Not sure if the peak throughput will be 
impacted. I believe it may work fine with 11ac in chromiumos, how about 
11n and 11a?

Anyway, I think this approach will help to improve performance of the 
virtual time based mechanism since it makes packets buffered in host 
instead of FW's deep queue. We have observed 2-clients case with 
different ratio in TCP fails to maintain the ratio because the packets 
arriving at host get pushed to FW immediately and thus the airtime 
weight sum is 0 in most of time meaning no TXQ in the rbtree. For UDP, 
if we pump load more than the PHY rate, the ratio can be maintained 
beacuse the FW queue is full and packtes begin to be buffered in host 
making TXQs staying on the rbtree for most of time. However, TCP has its 
own flow control that we can not push enough load like UDP.

>  out:
> @@ -3676,6 +3706,9 @@ struct ieee80211_txq *ieee80211_next_txq(struct
> ieee80211_hw *hw, u8 ac)
> 
>  	spin_lock_bh(&local->active_txq_lock[ac]);
> 
> +	if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
> +		goto out;
> +
>   begin:
>  	txqi = list_first_entry_or_null(&local->active_txqs[ac],
>  					struct txq_info,
> @@ -3753,6 +3786,9 @@ bool ieee80211_txq_may_transmit(struct 
> ieee80211_hw *hw,
> 
>  	spin_lock_bh(&local->active_txq_lock[ac]);
> 
> +	if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
> +		goto out;
> +
>  	if (!txqi->txq.sta)
>  		goto out;

-- 
Yibo
