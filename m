Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D241AC3B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhI1JuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbhI1JuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 05:50:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F06C061575
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nztK6MRG1RB7m4zyXQ6eLpNXY6AJQqCgJSixE5jGNyg=;
        t=1632822507; x=1634032107; b=tCpV2GjUY1VeRGWpV4rk2WXHS83FopRrPSipyBukYF95y2s
        7/mzwmB03PriFoMNvEyEAar4UnxBIvG3TlNZJJwawxUs9hK+XpL3DV6u0DASMrbToSJqD4VSXD8L7
        NrNH42AbtKdBWMmQJIiK5wlIRt5T5W2j8bKZdGSpoC2MibVEpwBeGy0FjsoF8retLjCKiHgAfDvxw
        69MMtSNw99/Nm7SZVh+5EiHRt1gkjYsRZta/igeqsw4ae4fHguMklCpNQ/Gxx4rJKxGB2aSDNzioL
        nvsLPDdCHdI4D+/VXBAM7nniR9XAEO9UuYVnda3zmfFColW3WLI4YJtilBahxUMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mV9ir-00Coyb-9F;
        Tue, 28 Sep 2021 11:48:25 +0200
Message-ID: <3da22bdc11ee028621ffa043ba37d4223e19c641.camel@sipsolutions.net>
Subject: Re: [PATCH v12 3/4] mac80211: MBSSID and EMA support in beacon
 handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Tue, 28 Sep 2021 11:48:24 +0200
In-Reply-To: <20210916025437.29138-4-alokad@codeaurora.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
         <20210916025437.29138-4-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So I applied patches 1 and 2, but have some comments/questions here.

>  static struct sk_buff *
>  __ieee80211_beacon_get(struct ieee80211_hw *hw,
>  		       struct ieee80211_vif *vif,
>  		       struct ieee80211_mutable_offsets *offs,
> -		       bool is_template)
> +		       bool is_template,
> +		       int ema_index)
>  {
>  	struct ieee80211_local *local = hw_to_local(hw);
>  	struct beacon_data *beacon = NULL;
> @@ -4995,13 +5038,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
>  	struct ieee80211_chanctx_conf *chanctx_conf;
>  	int csa_off_base = 0;
>  
> 
> 
> 
> -	rcu_read_lock();

Why are you making this change that moves the RCU locking out? In two
out of three places, you now have to

	rcu_read_lock();
	__ieee80211_beacon_get(...);
	rcu_read_unlock();

Not sure I see the point?
> 
>  	if (!ieee80211_sdata_running(sdata) || !chanctx_conf)
> -		goto out;
> +		return NULL;

That also causes a lot of collateral changes that make it harder to read
than it needs to be.

Maybe split the locking change to a separate patch, if at all necessary?

(but see below)


> +	rcu_read_lock();
> ...
> +		ema = kmalloc(sizeof(*ema), GFP_KERNEL);

This is obviously wrong - you should add a few more debug options to
your test kernels :-)


> +		if (!ema) {
> +			ieee80211_beacon_free_ema_list(head);
> +			cnt = 0;
> +			goto out;

break would be enough, and you could save the 'out' label?

> +		}
> +
> +		ema->skb = __ieee80211_beacon_get(hw, vif, &ema->offs, true,
> +						  cnt);
> +		if (!ema->skb) {
> +			kfree(ema);
> +			break;
> +		}
> +		list_add_tail(&ema->list, head);
> +		cnt++;
> +	}
> +out:
> +	rcu_read_unlock();


This is also the only place that uses the rcu_read_lock()/unlock() not
directly around the __ieee80211_beacon_get(), but there's absolutely no
point in that?

I think what you intended here was correct, but it was done incorrectly.

Really what it seems you (should have) _wanted_ with the RCU locking
here is that the

	beacon = rcu_dereference(ap->beacon);

is only done *once*, so that you can really get a snapshot of *all*
those MBSSID beacons, even if ap->beacon changed.

However, that's not what you implemented. By moving the rcu_read_lock()
outside, you've achieved nothing, since you still do a dereference
inside, and it can change.

It seems to me that to do this correctly you have to actually split
__ieee80211_beacon_get() and do the dereference *outside* of it, then
pass the 'beacon' pointer into it. Then, you can here do the dereference
outside of the loop too (and in fact can do a much nicer for loop rather
than the infinite loop).

As it is, you've penalized the other cases (they now need to do the
rcu_read_lock() manually), but haven't actually gained anything
(functionally, at least, you save a few cycles by having the RCU stuff
outside the loop, but that doesn't really count).

johannes


