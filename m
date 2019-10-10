Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0374D1EA1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfJJCnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 22:43:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfJJCnw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 22:43:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B03660E5A; Thu, 10 Oct 2019 02:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570675431;
        bh=24BqhuLC/g82Gtaoa9FnLy2P+s++jHVz4WjUtvWEM2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UNXvEzh+jNH8DE/BNaGJDTyyGDKs/YkdhwSwwem3u14OlU8fqfYnaje8BRsfX/4Hq
         Gd4MZ0Tyqcwh7Q0nYl3RoIu7ji2r6jdtcBIBUifTz1dbN9H6d2PMqxHQbtowkUF3CK
         5OSvaehUy2ZrLBBpsPiZ6UL8p0n0AwDzPcZRdkqs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D9FA660E41;
        Thu, 10 Oct 2019 02:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570675430;
        bh=24BqhuLC/g82Gtaoa9FnLy2P+s++jHVz4WjUtvWEM2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RrCDnbUVR6ek04kNckIQSzW56GPYmutoiArhsp5h7OkE8VIVr1n7jZR7/Kk0lBe3x
         SVhL22+S3Ugu5hoIpb+BT03dbwsCV9ria8YW0EOphllUij61SFgmR5H6y3UiKF32XW
         +cHxAvmi7XlQSBHbS4InoQS7U7gnVmoTXfwidshk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Oct 2019 10:43:49 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] mac80211: rework locking for txq scheduling / airtime
 fairness
In-Reply-To: <20190315100335.91445-1-nbd@nbd.name>
References: <20190315100335.91445-1-nbd@nbd.name>
Message-ID: <b2bded992cb02bad84fc738b7e4b1837@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index ca23abbf5c0b..51cc37802439 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3653,16 +3653,17 @@ EXPORT_SYMBOL(ieee80211_tx_dequeue);
>  struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 
> ac)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
> +	struct ieee80211_txq *ret = NULL;
>  	struct txq_info *txqi = NULL;
> 
> -	lockdep_assert_held(&local->active_txq_lock[ac]);
> +	spin_lock_bh(&local->active_txq_lock[ac]);
> 
>   begin:
>  	txqi = list_first_entry_or_null(&local->active_txqs[ac],
>  					struct txq_info,
>  					schedule_order);
>  	if (!txqi)
> -		return NULL;
> +		goto out;
> 
>  	if (txqi->txq.sta) {
>  		struct sta_info *sta = container_of(txqi->txq.sta,
> @@ -3679,21 +3680,25 @@ struct ieee80211_txq
> *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
> 
> 
>  	if (txqi->schedule_round == local->schedule_round[ac])
> -		return NULL;
> +		goto out;
> 
>  	list_del_init(&txqi->schedule_order);
>  	txqi->schedule_round = local->schedule_round[ac];
> -	return &txqi->txq;
> +	ret = &txqi->txq;
> +
> +out:
> +	spin_unlock_bh(&local->active_txq_lock[ac]);
> +	return ret;
>  }
>  EXPORT_SYMBOL(ieee80211_next_txq);
> 
> -void ieee80211_return_txq(struct ieee80211_hw *hw,
> -			  struct ieee80211_txq *txq)
> +void ieee80211_schedule_txq(struct ieee80211_hw *hw,
> +			    struct ieee80211_txq *txq)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
>  	struct txq_info *txqi = to_txq_info(txq);
> 
> -	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
> +	spin_lock_bh(&local->active_txq_lock[txq->ac]);
> 
>  	if (list_empty(&txqi->schedule_order) &&
>  	    (!skb_queue_empty(&txqi->frags) || txqi->tin.backlog_packets)) {
> @@ -3713,17 +3718,7 @@ void ieee80211_return_txq(struct ieee80211_hw 
> *hw,
>  			list_add_tail(&txqi->schedule_order,
>  				      &local->active_txqs[txq->ac]);
>  	}
> -}
> -EXPORT_SYMBOL(ieee80211_return_txq);
> 
> -void ieee80211_schedule_txq(struct ieee80211_hw *hw,
> -			    struct ieee80211_txq *txq)
> -	__acquires(txq_lock) __releases(txq_lock)
> -{
> -	struct ieee80211_local *local = hw_to_local(hw);
> -
> -	spin_lock_bh(&local->active_txq_lock[txq->ac]);
> -	ieee80211_return_txq(hw, txq);
>  	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
>  }
>  EXPORT_SYMBOL(ieee80211_schedule_txq);
> @@ -3736,7 +3731,7 @@ bool ieee80211_txq_may_transmit(struct 
> ieee80211_hw *hw,
>  	struct sta_info *sta;
>  	u8 ac = txq->ac;
> 
> -	lockdep_assert_held(&local->active_txq_lock[ac]);
> +	spin_lock_bh(&local->active_txq_lock[ac]);
> 
>  	if (!txqi->txq.sta)
>  		goto out;
> @@ -3766,34 +3761,27 @@ bool ieee80211_txq_may_transmit(struct 
> ieee80211_hw *hw,
> 
>  	sta->airtime[ac].deficit += sta->airtime_weight;
>  	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
> +	spin_unlock_bh(&local->active_txq_lock[ac]);
> 
>  	return false;
>  out:
>  	if (!list_empty(&txqi->schedule_order))
>  		list_del_init(&txqi->schedule_order);
> +	spin_unlock_bh(&local->active_txq_lock[ac]);
> 
>  	return true;
>  }
>  EXPORT_SYMBOL(ieee80211_txq_may_transmit);
> 
>  void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
> -	__acquires(txq_lock)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
> 
>  	spin_lock_bh(&local->active_txq_lock[ac]);
>  	local->schedule_round[ac]++;
Hi Felix,

In ath10k, we might have situations like,

           CPU0                           CPU1
...                                   ieee80211_txq_schedule_start()
...                                   while(ieee80211_next_txq()) {
...                                       driver dequeue packets from 
txq
...                                       ieee80211_return_txq()
ieee80211_txq_schedule_start()            ...
ieee80211_next_txq()                  }
driver dequeue packets from txq       ieee80211_txq_schedule_end()
ieee80211_return_txq()
ieee80211_txq_schedule_end()

The problem is while CPU1 is looping to dequeue txqs, the schedule_round 
which is used to make sure no infinite loop will be changed in CPU0. So 
a txq has already been scheduled will be scheduled again then the loop 
won't be end at that point as our expected.

> -}
> -EXPORT_SYMBOL(ieee80211_txq_schedule_start);
> -
> -void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
> -	__releases(txq_lock)
> -{
> -	struct ieee80211_local *local = hw_to_local(hw);
> -
>  	spin_unlock_bh(&local->active_txq_lock[ac]);
>  }
> -EXPORT_SYMBOL(ieee80211_txq_schedule_end);
> +EXPORT_SYMBOL(ieee80211_txq_schedule_start);
> 
>  void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>  				  struct net_device *dev,

-- 
Yibo
