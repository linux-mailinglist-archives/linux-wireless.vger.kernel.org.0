Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4BD096E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJIISW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 04:18:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIISV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 04:18:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E882861A3D; Wed,  9 Oct 2019 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609100;
        bh=yVACcIyD8sXXrbvUi7xGYw1ltxq2hUy0puNDsNVcAn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ivhG/JU+cTVrmdhpnrLdXGsCooIKAEZqO7DYSWKY4G41n8T74SlVcBDJXQJaXhaAV
         ejpB48gAyWjHlWfw5exQ4EE3NORgezA0C/xbW32EgODzgI+On19IXlResl8QQphaXe
         JlPYKueW95h0pO4rcSF6GdnH0HCdRXFTyOeqR8to=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1BC4561A3D;
        Wed,  9 Oct 2019 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609100;
        bh=yVACcIyD8sXXrbvUi7xGYw1ltxq2hUy0puNDsNVcAn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ivhG/JU+cTVrmdhpnrLdXGsCooIKAEZqO7DYSWKY4G41n8T74SlVcBDJXQJaXhaAV
         ejpB48gAyWjHlWfw5exQ4EE3NORgezA0C/xbW32EgODzgI+On19IXlResl8QQphaXe
         JlPYKueW95h0pO4rcSF6GdnH0HCdRXFTyOeqR8to=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Oct 2019 16:18:20 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com, nbd@nbd.name
Subject: Re: [PATCH v2 1/2] mac80211: Implement Airtime-based Queue Limit
 (AQL)
In-Reply-To: <20191007043120.67567-2-kyan@google.com>
References: <20191007043120.67567-1-kyan@google.com>
 <20191007043120.67567-2-kyan@google.com>
Message-ID: <18630c07d0aa46d16cf660d013f96b3d@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index f13eb2f61ccf..dadb643a5498 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3669,7 +3669,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct
> ieee80211_hw *hw, u8 ac)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
>  	struct ieee80211_txq *ret = NULL;
> -	struct txq_info *txqi = NULL;
> +	struct txq_info *txqi = NULL, *head = NULL;
> +	bool found_eligible_txq = false;
> 
>  	spin_lock_bh(&local->active_txq_lock[ac]);
> 
> @@ -3680,20 +3681,32 @@ struct ieee80211_txq
> *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
>  	if (!txqi)
>  		goto out;
> 
> +	if (txqi == head && !found_eligible_txq)
> +		goto out;

I assume here the only txq in the list that does not meet AQL check will 
not be dequeued. Right? Will it affect peak throughput once there is 
only one station.

How about dequeuing it anyway regardless AQL because it is the only one 
active now so it is fine to occupy the rest bandwidth. Otherwise, I am 
afraid next_txq() will return NULL in the test only one station is 
present.

> @@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct 
> ieee80211_hw *hw,
>  	struct sta_info *sta;
>  	u8 ac = txq->ac;
> 
> -	spin_lock_bh(&local->active_txq_lock[ac]);
> -
>  	if (!txqi->txq.sta)
> -		goto out;
> +		return true;

why return here? I think even a txq without sta info should get removed 
from list and added it back later in return_txq() if needed. No?

> +
> +	spin_lock_bh(&local->active_txq_lock[ac]);
> 
>  	if (list_empty(&txqi->schedule_order))
>  		goto out;


-- 
Yibo
