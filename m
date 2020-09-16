Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2426CEBC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 00:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIPW2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 18:28:16 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:39040 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPW2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 18:28:16 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2466713C2B0;
        Wed, 16 Sep 2020 15:28:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2466713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600295295;
        bh=TKlFpo4QXqO7jDcnZxjIoNr1Nuv3yHnLSWqA5dCPa2c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XtSQ1iS0Vcj11/EFjY7VNsvyOxvjOTPNO1mqfTNcXO8xmJjetj2cFvoV4th0FPgR5
         mhxTRBu5xSKCWsCF4wZjmdMO1IE/UnKb1W944lnl4hhrfYEX+NcPc2CUKTxzc1n/Kk
         Ur54/xugjSZjmg3NkdplCQnn51VdSwMGbHbuXz14=
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
References: <20200525165317.2269-1-greearb@candelatech.com>
 <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
 <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
 <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
 <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
 <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
 <98996ee9-a9cc-521b-05cc-1404d3b9b251@candelatech.com>
 <cbe230f7270587e14ccee835561c437362e3933d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a38f8f2f-9de6-5e03-4df5-1b5fae584ecd@candelatech.com>
Date:   Wed, 16 Sep 2020 15:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cbe230f7270587e14ccee835561c437362e3933d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 8:03 AM, Johannes Berg wrote:
> On Thu, 2020-07-30 at 07:52 -0700, Ben Greear wrote:
> 
>>> Consider
>>>
>>> add interface wlan0
>>> add interface wlan1
>>> iterate active interfaces -> wlan0 wlan1
>>> add interface wlan2
>>> iterate active interfaces -> wlan0 wlan1 wlan2
>>>
>>> If you apply this scenario to a restart, which ought to be functionally
>>> equivalent to the normal startup, just compressed in time, you're
>>> basically saying that today you get
>>>
>>> add interface wlan0
>>> add interface wlan1
>>> iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
>>> add interface wlan2
>>> iterate active interfaces -> wlan0 wlan1 wlan2
>>>
>>> which yeah, totally seems wrong.
>>>
>>> But fixing that to be
>>>
>>> add interface wlan0
>>> add interface wlan1
>>> iterate active interfaces ->
>>> <nothing>
>>> add interface wlan2
>>> iterate active interfaces -> <nothing>
>>> (or
>>> maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)
>>>
>>> seems equally wrong?
>>
>> So, looks like there is a flags option passed to the iterate logic, and it is indeed called
>> directly from drivers.  So, I could just add a new flag value, and | it in when calling from ath10k.
>>
>> I'm not sure it would really solve the second case, but at least in practice,
>> that one doesn't seem to be a problem with ath10k, and the first case *was*
>> a problem.
>>
>> If that sounds OK to you, I'll work on the patch as described.
> 
> Right, that'd be the option 2. I described earlier. I can live with that
> even if I'd prefer to fix it as per 1. to "make sense". But I guess
> there could even be "more legitimate" cases to not want to iterate while
> restarting, even if I'm not really sure where that'd make sense?
> 
> I guess Kalle should comment on whether he'd accept that into the
> driver.
> 
> Kalle, as you can see above mac80211 appears to be broken wrt. iterating
> "active" interfaces during a restart - the iteration considers all
> interfaces active that were active before the restart, not just the ones
> that were already re-added to the driver. Ben says this causes trouble
> in ath10k.
> 
> IMHO the right fix for this would be to fix the iteration to only reach
> the ones that have been re-added, like I've said above. OTOH, Ben isn't
> really convinced that that's right, and has experience with a patch that
> makes mac80211 return *no* interfaces whatsoever in the iteration when
> done while in restart. Like I say there, it seems wrong to me.
> 
> But depending on what ath10k actually _does_ with this list, perhaps
> it's not an issue. Perhaps it's just transient state that it derives
> from it, so if it does it again after the reconfig is completed, it
> would in fact get all the information it needed.
> 
> I'm pretty sure this would break iwlwifi, so one option (less preferred)
> would be to add a flag to say "skip iteration in reconfig".
> 
> actually does the driver know it's in reconfig? Perhaps it could even do
> that completely on its own?
> 
> Anyway, the question is what you think about doing such a thing in the
> driver, if it fixes issues even if it's probably not really correct.
> 
> johannes

So, no response from Kalle on this for some time.  I thought I'd ping one
more time before I make an effort to create another out-of-tree patch.

Johannes, if you are OK with a new flag in mac80211, then I can patch ath10k-ct
driver regardless of whether other drivers use it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
