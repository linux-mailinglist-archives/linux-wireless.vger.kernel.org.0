Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE92334CC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgG3Owj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:52:39 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:58712 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3Owj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:52:39 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9CC1013C2B3;
        Thu, 30 Jul 2020 07:52:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9CC1013C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596120757;
        bh=BXMcJ3uAzAKtoktnAc82JnLjdoTo6YdCK2N2dFQ76/U=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Rqu8OZX/rHjo/qDG2z+E95zvVHeKLHW/xhCC+qh/YD1zLO0/DgoM2c9LoDsGYpz0C
         0ewVh2iPW8sthYwqvS6wC643mLtEch5IwMjm1GHLzVe4+WFtXQnOqplZq7nXBCdo7D
         Bh/dd9C7mEyjHOO95sFzuN8D6Hqm0wMCqxFpTD0s=
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200525165317.2269-1-greearb@candelatech.com>
 <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
 <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
 <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
 <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
 <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <98996ee9-a9cc-521b-05cc-1404d3b9b251@candelatech.com>
Date:   Thu, 30 Jul 2020 07:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 6:41 AM, Johannes Berg wrote:
> On Thu, 2020-07-30 at 06:27 -0700, Ben Greear wrote:
> 
>>> 1. track per vif whether it was re-added, and skip before it is
>>>
>>> If that works, I can certainly get behind it for semantic reasons (the
>>> vif isn't yet active again), although even there I'm not sure how
>>> iwlwifi would behave - but that's something I'd look into and perhaps
>>> even consider a bug there since it shouldn't know about that interface
>>> yet.
>>
>> Wouldn't that complicate the sdata-in-driver check even more?  So it would
>> be something like is-in-driver-but-not-yet-reconfigured-in-driver?
> 
> We should probably just clear the "is-in-driver" flag for the most part,
> and just remember "was-in-driver" so we know which ones to reconfigure,
> or something like that?
> 
>> This sort of state is quite nasty in my experience.  Almost better if
>> we had less state.  Driver should already know if it has an object or not,
>> so redundant adds, or requests from mac80211 for objects the driver does not
>> have can be handled properly by the driver?
> 
> I don't think that'll work. Drivers just act on "add" and "remove",
> they're not checking against double-add. And IMHO it makes more sense to
> have mac80211 do good sequencing than the throw our hands in the air and
> let the drivers have to be idempotent just because we can't figure out
> the right sequencing?

They certainly could check.  At the least, removing something that is already
gone should be an easy check.  That would at least let mac80211 be more confident
about cleanup.  The current in-kernel code that cleared SDATA_IN_DRIVER in
the non-recoverable firmware crash bit just assumed that drivers would clean
things up, but I'm not even sure they can entirely clean things up since often
the objects in their local memory are held by mac80211 objects (ie, the priv
opaque objects).


>>> 2. If for some reason that doesn't work, add an iteration flag that
>>> controls this, rather than a per-device config?
>>
>> I wrote this patch probably 5 or so years ago, and since I have fixed most of
>> the ath10k firmware crashes that would tend to trigger this bug.  I think I have no
>> good way to test any complicated change to this patch.
>>
>> I am quite certain that ath9k and ath10k are at least not harmed by this patch, and
>> certainly old ath10k benefited from this.  So, I'm comfortable adding a driver
>> level flag enabled for those two drivers.  Changing all the calling locations to
>> (maybe) add a flag or adding and tracking vif state is too risky to be worth this change I
>> think.
> 
> Uh, why? I mean, at least mechanically replacing all the callers in that
> driver wouldn't really be any different than adding a driver flag, but
> is so much more flexible and can be used elsewhere. I don't think I buy
> this argument much really.
> 
> Yes, I understand that there's always resistance to changing something
> that works, but ...
> 
> Really I think the right thing to do here would be 1., and let mac80211
> sort out the sequencing.
> 
> Consider
> 
> add interface wlan0
> add interface wlan1
> iterate active interfaces -> wlan0 wlan1
> add interface wlan2
> iterate active interfaces -> wlan0 wlan1 wlan2
> 
> If you apply this scenario to a restart, which ought to be functionally
> equivalent to the normal startup, just compressed in time, you're
> basically saying that today you get
> 
> add interface wlan0
> add interface wlan1
> iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
> add interface wlan2
> iterate active interfaces -> wlan0 wlan1 wlan2
> 
> which yeah, totally seems wrong.
> 
> But fixing that to be
> 
> add interface wlan0
> add interface wlan1
> iterate active interfaces ->
> <nothing>
> add interface wlan2
> iterate active interfaces -> <nothing>
> (or
> maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)
> 
> seems equally wrong?

So, looks like there is a flags option passed to the iterate logic, and it is indeed called
directly from drivers.  So, I could just add a new flag value, and | it in when calling from ath10k.

I'm not sure it would really solve the second case, but at least in practice,
that one doesn't seem to be a problem with ath10k, and the first case *was*
a problem.

If that sounds OK to you, I'll work on the patch as described.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
