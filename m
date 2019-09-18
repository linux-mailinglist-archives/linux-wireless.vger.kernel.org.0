Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52552B613D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfIRKQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 06:16:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfIRKQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 06:16:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A7B35602F8; Wed, 18 Sep 2019 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568801799;
        bh=zZmSMI9xJbFedwUxpMliYWUAfGPkhLOmdt4pFKZAJeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mHr/+189qXAkrwWGg04pq3DVoPsYsWumJtPmZb2BxIrkX6HDMbnDwZE4zkOq8SYAO
         bR+MxD8tXP/HyFD5eSDKMGrLEvC9cLPO7I6Cx4eoc/voflx/wf1xl8PYFoR+Wp4BJU
         DAVJ43xoBwxSiTbCqUsMpLUa+qYj3nGWBGBkSinw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E481E6034D;
        Wed, 18 Sep 2019 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568801799;
        bh=zZmSMI9xJbFedwUxpMliYWUAfGPkhLOmdt4pFKZAJeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mHr/+189qXAkrwWGg04pq3DVoPsYsWumJtPmZb2BxIrkX6HDMbnDwZE4zkOq8SYAO
         bR+MxD8tXP/HyFD5eSDKMGrLEvC9cLPO7I6Cx4eoc/voflx/wf1xl8PYFoR+Wp4BJU
         DAVJ43xoBwxSiTbCqUsMpLUa+qYj3nGWBGBkSinw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Sep 2019 18:16:38 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 4/4] mac80211: Sync airtime weight sum with per AC synced
 sta airtime weight together
In-Reply-To: <87impqipl7.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <1568639388-27291-4-git-send-email-yiboz@codeaurora.org>
 <87impqipl7.fsf@toke.dk>
Message-ID: <dad15b9a52a4e136fd3b4f42c2c5b818@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-18 05:24, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> Global airtime weight sum is updated only when txq is added/removed
>> from rbtree. If upper layer configures sta weight during high load,
>> airtime weight sum will not be updated since txq is most likely on the
>> tree. It could a little late for upper layer to reconfigure sta weight
>> when txq is already in the rbtree. And thus, incorrect airtime weight 
>> sum
>> will lead to incorrect global virtual time calculation as well as 
>> global
>> airtime weight sum overflow of airtime weight sum during txq removed.
>> 
>> Hence, need to update airtime weight sum upon receiving event for
>> configuring sta weight once sta's txq is on the rbtree.
>> 
>> Besides, if airtime weight sum of ACs and sta weight is synced under 
>> the
>> same per AC lock protection, there can be a very short window causing
>> incorrct airtime weight sum calculation as below:
>> 
>>     active_txq_lock_VO                          .
>>     VO weight sum is syncd			.
>>     sta airtime weight sum is synced		.
>>     active_txq_unlock_VO			.
>>     .						.
>>     active_txq_lock_VI    			.
>>     VI weight sum is syncd			.
>>     sta airtime weight sum		active_txq_lock_BE
>>     active_txq_unlock_VI	      Remove txq and thus sum
>>     .				      is calculated with synced
>>     .				      sta airtime weight
>>     .					active_txq_unlock_BE
>> 
>> So introduce a per ac synced station airtime weight synced with per
>> AC synced weight sum together. And the per-AC station airtime weight
>> is used to calculate weight sum.
>> 
>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>> ---
>>  net/mac80211/cfg.c      | 27 +++++++++++++++++++++++++--
>>  net/mac80211/sta_info.c |  6 ++++--
>>  net/mac80211/sta_info.h |  3 +++
>>  net/mac80211/tx.c       |  4 ++--
>>  4 files changed, 34 insertions(+), 6 deletions(-)
>> 
>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>> index d65aa01..4b420bb 100644
>> --- a/net/mac80211/cfg.c
>> +++ b/net/mac80211/cfg.c
>> @@ -1284,7 +1284,8 @@ static int sta_apply_parameters(struct 
>> ieee80211_local *local,
>>  	int ret = 0;
>>  	struct ieee80211_supported_band *sband;
>>  	struct ieee80211_sub_if_data *sdata = sta->sdata;
>> -	u32 mask, set;
>> +	u32 mask, set, tid, ac;
>> +	struct txq_info *txqi;
>> 
>>  	sband = ieee80211_get_sband(sdata);
>>  	if (!sband)
>> @@ -1452,8 +1453,30 @@ static int sta_apply_parameters(struct 
>> ieee80211_local *local,
>>  	if (ieee80211_vif_is_mesh(&sdata->vif))
>>  		sta_apply_mesh_params(local, sta, params);
>> 
>> -	if (params->airtime_weight)
>> +	if (params->airtime_weight &&
>> +	    params->airtime_weight != sta->airtime_weight) {
>> +		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
>> +			spin_lock_bh(&local->active_txq_lock[ac]);
>> +			for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
>> +				if (!sta->sta.txq[tid] ||
>> +				    ac != ieee80211_ac_from_tid(tid))
>> +					continue;
>> +
>> +				sta->airtime_weight_synced[ac] =
>> +							params->airtime_weight;
>> +
>> +				txqi = to_txq_info(sta->sta.txq[tid]);
>> +				if (RB_EMPTY_NODE(&txqi->schedule_order))
>> +					continue;
>> +
>> +				local->airtime_weight_sum[ac] = local->airtime_weight_sum[ac] +
>> +								params->airtime_weight -
>> +								sta->airtime_weight;
>> +			}
>> +			spin_unlock_bh(&local->active_txq_lock[ac]);
>> +		}
>>  		sta->airtime_weight = params->airtime_weight;
> 
> With this, airtime_weight is basically only used to return to and from
> userspace, right? I.e., after the above loop has run, it will match the
> contents of airtime_weight_synced; so why not just turn airtime_weight
> into  a per-ac array? You could just use airtime_weight[0] as the value
> to return to userspace...
Yes, I also feel it is a little weird to keep both of them. I am fine 
with suggestion.

> 
> -Toke

-- 
Yibo
