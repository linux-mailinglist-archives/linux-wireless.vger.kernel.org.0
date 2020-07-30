Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E8233294
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG3NFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:05:18 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:54214 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:05:17 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4357B13C2B3;
        Thu, 30 Jul 2020 06:05:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4357B13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596114317;
        bh=XNjKFknzhMuOsFa0Z1nux0tAwq9b2Vcby6MRYGiq9m0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=M+ekPgfzmjd1vo9rHlyRvi69ccQL1t8A2f5auTFP7v/W6N6JbV8ZyMrbnqQBS7rTG
         8OVIUbR+xqutzzdXyQmQLSUT3pajwNiCJIbnczMGDcVh0UoPGXqCO3M5Vig4Xnv/CJ
         ZAHW8uZxzRjgJJRcEWwzWUBmDkA3jpYjov25/3qo=
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200525165317.2269-1-greearb@candelatech.com>
 <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
Date:   Thu, 30 Jul 2020 06:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 4:48 AM, Johannes Berg wrote:
> On Mon, 2020-05-25 at 09:53 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This appears to fix a problem where ath10k firmware would crash,
> 
> 
> "appears to", heh
> 
> Really though, in general, you need to start thinking about mac80211 and
> the drivers as two separate things. You've also submitted another patch
> where you say "this iwlwifi thing requires mac80211 to change", and here
> you're submitting a patch saying "this ath10k thing requires mac80211 to
> change", but I don't see you considering much the fact that mac80211 is
> actually used for both.
> 
> It'd be good to have a discussion of such things in the commit log for
> changes that will affect multiple drivers, rather than focusing on a
> single bug for a single driver. In general, not just in this patch.
> 
>> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
>> index 5db2cd0..186a696 100644
>> --- a/net/mac80211/util.c
>> +++ b/net/mac80211/util.c
>> @@ -831,7 +831,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
>>   			break;
>>   		}
>>   		if (!(iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL) &&
>> -		    active_only && !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
>> +		    (active_only && (local->in_reconfig || !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))))
>>   			continue;
> 
> Anyway, this seems wrong to me. If anything, it should skip those
> interfaces that weren't re-added yet, but not all of them. I'm pretty
> sure this would cause iwlwifi to misbehave with multiple interfaces, as
> it sometimes relies on iterating to understand what else is going on
> before configuring something.
> 
> It might even be that this can only be done subject to driver choice.

I have tested this patch hard for many years with hundreds of station vifs on ath9k radios and
64 station vifs on ath10k radios, probably way harder than anyone else is testing
this sort of thing.

Possibly you are correct about iwlwifi, I've never tested it with multi-interface,
and as you see, have had bad luck on ax200.

If you'd accept a patch with a new driver flag check (which I can enable for
ath10k and ath9k), then I'll respin it thus.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
