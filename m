Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B028ABC0AB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 05:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbfIXDTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 23:19:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfIXDTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 23:19:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29F236076C; Tue, 24 Sep 2019 03:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569295174;
        bh=5fHGFSZ09yQayNghU6B++C4ukJVhlxZr4yvdON9mR0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jp3WoPxLmjAsdajbZxDfA0v6+4Er6F1ILWx8M+pPlnb1EzIOXT5PV0nX4eTR3fwnN
         k4LSaAJmjviD5pVYK/nYwd+JSXbtbInZ+1nhbAxVBjuXUhejKm5CkbK3Ydnq0/PvQ8
         nAztPBOyr68pXQcNEElHMqnzLuj5CNsbxAQ7ZuG0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 98DF1602B8;
        Tue, 24 Sep 2019 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569295173;
        bh=5fHGFSZ09yQayNghU6B++C4ukJVhlxZr4yvdON9mR0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XskCCl8v1QRH03SoCOUJeSziXe5dZshkHZBq0UD9yYYLcSkzM8+YZBSSvoEkUOnbp
         IJQRojPygEPTvvPYHk1jTLDkBGftVWa+uyGFOmoK+HG3QtoLB4WZuwJRHt+ypPiZ7q
         nsfMk6XToM7bHB7l+MrCD9gnvAwXq+1vtmpBfUoA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 11:19:33 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 4/4] mac80211: Sync airtime weight sum with per AC
 synced sta airtime weight together
In-Reply-To: <87blvb5lb9.fsf@toke.dk>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
 <1569223201-1490-5-git-send-email-yiboz@codeaurora.org>
 <87blvb5lb9.fsf@toke.dk>
Message-ID: <ffe79f35d4dcb50aa31dc04035855f79@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 19:00, Toke Høiland-Jørgensen wrote:

>> -	if (params->airtime_weight)
>> -		sta->airtime_weight = params->airtime_weight;
>> +	if (params->airtime_weight &&
>> +	    params->airtime_weight != sta->airtime_weight) {
> 
> This check doesn't work I think? You're not using the array-based
> sta->airtime_weight[], and there are locking issues by just checking
> like this; so maybe just keep the if() on params->airtime_weight, and 
> do
> the checking inside the loop while holding the lock?

It should be array-based sta->airtime_weight[] and I am missing that 
part during the porting. But you are right about we should check it 
inside the loop with the lock.

> 
> Or could we just turn the weights into atomics to avoid the locking
> entirely?

Actually, we still need the active txq locking to make sure the txq is 
on the rbtree. Otherwise, no need to change airtime weight sum.

> 
>> +		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
>> +			spin_lock_bh(&local->active_txq_lock[ac]);
>> +			for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
>> +				if (!sta->sta.txq[tid] ||
>> +				    ac != ieee80211_ac_from_tid(tid))
>> +					continue;
>> +
>> +				pre_weight = sta->airtime_weight[ac];
>> +				sta->airtime_weight[ac] =
>> +						params->airtime_weight;
>> +
>> +				txqi = to_txq_info(sta->sta.txq[tid]);
>> +				if (RB_EMPTY_NODE(&txqi->schedule_order))
>> +					continue;
>> +
>> +				local->airtime_weight_sum[ac] = local->airtime_weight_sum[ac] +
>> +								params->airtime_weight -
>> +								pre_weight;
>> +			}
>> +			spin_unlock_bh(&local->active_txq_lock[ac]);
>> +		}
>> +	}
>> 


-- 
Yibo
