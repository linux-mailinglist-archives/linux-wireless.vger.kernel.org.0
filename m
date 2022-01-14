Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5579A48F0C4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 21:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiANUMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 15:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiANUMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 15:12:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B93C061574
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 12:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AloS9yA+BXefGuPzZop5LAnDQK/kndIEIQ/H6E2ZsZo=;
        t=1642191133; x=1643400733; b=yASXqfVI96oYjnVSSKL6crIBzz2JZ6jqXvvS/UFOiLRusKK
        fFtFCOftT9bpchJi0VTwVfmS9jUKXJCVo1kw7ZUlJEXiPG0bMf5CYZJJ0lrjNTaEDYJFyQlYAmV0a
        +Aqr+0JhQJzF3NPYD2DigQrhFXQ1dBySi4U00GBIKIIgl5ia85w/s2bfihRf41ux7ZjDYS9HjkgWV
        hUmUXXr+Nsn0JblHRMVPpgTc3HTUNiXKSbqLwZCs0GbxiWuezS+rVowubMqZwelemmHdiNVSe1mH6
        fOGXwnLWmCw1b+CPKi+U2MB7t1aH02G+IN4kdyz31XJc5DEnRGYZo118jBsEGhMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n8Svi-005hUb-U9;
        Fri, 14 Jan 2022 21:12:11 +0100
Message-ID: <ebb1ddc51e6e0eff436de50cbbddec77d61af495.camel@sipsolutions.net>
Subject: Re: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 14 Jan 2022 21:12:10 +0100
In-Reply-To: <d2c980b72af1488282f18e8b1814b56c@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
         <20211006040938.9531-3-alokad@codeaurora.org>
         <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
         <d2c980b72af1488282f18e8b1814b56c@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

> 
> > This function is called from ieee80211_beacon_get_ap(). That's called
> > from __ieee80211_beacon_get(), under RCU read lock.
> > 
> > > +	for (i = 0; i < beacon->mbssid_ies->cnt; i++) {
> > > +		struct ieee80211_ema_bcns *bcn;
> > > +
> > > +		bcn = kzalloc(sizeof(*bcn), GFP_KERNEL);
> > 
> > Therefore, you really cannot GFP_KERNEL allocate anything. But I really
> > only saw this because I went back to my comments on v12 where this was
> > still more obvious.
> > 
> 
> Okay, I understand now that it is illegal because GFP_KERNEL is 
> blocking.

Right.

> I thought of following:
> lock rcu -> get mbssid count first -> unlock rcu -> allocate memory.
> But in that case, will have again: lock -> dereference to get beacon 
> snapshot.
> Beacon can change in between so new count might be wrong. In general 
> sounds complicated and wrong.

Indeed. You could make it work (and count changing is highly unlikely!)
by going back and checking if the count was correct in the critical
section, and then going back if necessary (i.e. if it was wrong). But if
you do this, you should do something like this pseudo-code:

rcu_read_lock();
repeat:
calculated_size = calculate_size();
rcu_read_unlock();

alloc = kzalloc(calculated_size, GFP_KERNEL);
// omitting error handling

rcu_read_lock();
calculated_size = calculate_size();
if (ksize(alloc) < calculated_size)
	goto repeat;
...


i.e. note the ksize(), since allocations are rounded up. Even if the
count increased, you might not need a new allocation.

Also maybe anyway it'd make sense to allocate all of them together as an
array, rather than individual pointers for each beacon?


> I read that GFP_ATOMIC should be used sparingly, mainly for interrupt 
> handlers etc.

I guess once every beacon is still fairly sparingly though :)


> Do you think this code path warrants its use?
> Or should I look for some other function split?
> 
> Will add hwsim test cases before the next version but I genuinely did 
> not see any issue during testing with current code.

Sounds great, thanks!

> So can you tell me which debug flags should be enabled to make such 
> errors become obvious to someone like me who is new to these details in 
> kernel programming?

Hmm. I guess you want at least CONFIG_DEBUG_ATOMIC_SLEEP for this case.
But probably best to (also) turn on lockdep (CONFIG_PROVE_LOCKING=y),
including all the RCU checks (CONFIG_PROVE_RCU=y).

With that, it really _should_ be obvious here once that code path
executes at all, regardless of whether the kzalloc(GFP_KERNEL) actually
sleeps or not.

johannes
