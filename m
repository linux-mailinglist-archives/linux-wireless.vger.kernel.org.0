Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27C4624E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFNPOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 11:14:47 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56076 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfFNPOh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 11:14:37 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B6AEED936;
        Fri, 14 Jun 2019 08:14:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B6AEED936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1560525276;
        bh=8zcYqNn7o27L37A1IYkS/OReNpXSFzOmHnw8HWKbK0Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mb5+b77vsrEu79tAtf+l/kcUhebXUR9Qdy3AvKkgtaZ9bChlC7ky2n9M6mzuTWnmZ
         XNYMXVKhJnLs+mXOSbasiCEGwN4vCvNA4E0afFBAviehgS9Ax0gTEG2bePFnNJwgxX
         JFFV7cgqK741RpjUd4EkKGp9C0X4JAFFpne23mp4=
Subject: Re: [PATCH-v3 1/2] wireless: Support assoc-at-ms timer in sta-info
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190415172123.6532-1-greearb@candelatech.com>
 <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
 <3ad69c55-2b88-a96b-d21e-99f4418466ee@candelatech.com>
 <e8343919c6851e6b5a7905b708661870c4c88481.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <7d606df7-bb8e-c454-1eaf-24fd454eab8e@candelatech.com>
Date:   Fri, 14 Jun 2019 08:14:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e8343919c6851e6b5a7905b708661870c4c88481.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/19 7:56 AM, Johannes Berg wrote:
> On Fri, 2019-06-14 at 07:46 -0700, Ben Greear wrote:
>>
>> The point of my patch was to allow 'iw' to return a more precise time
>> that the station has been associated, so I am not sure that BOOTIME is
>> a good thing to use for that?
> 
> Depends what you want, really.
> 
>> +       if (sinfo[NL80211_STA_INFO_ASSOC_AT_MS])
>> +               printf("\n\tassociated at:\t%llu ms",
>> +                        (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_MS]));
>>
>> -       printf("\n");
>> +       printf("\n\tcurrent time:\t%llu ms\n", now_ms);
> 
> Since you just print the time in milliseconds, and the current time in
> milliseconds, you don't even really have any value in the wall clock.
> Quite the opposite - this lends itself to subtracting to try to figure
> out how long it was associated, which is the completely wrong thing to
> do with wall clock - timezone adjustment could've happened inbetween,
> for example!
> 
> I really see no point in trying to give the wall clock at assoc time. If
> no timezone adjustment happened, you can just as well give the boottime
> and have the userspace figure out the wall clock. If timezone adjustment
> happened, then any calculations are wrong anyway, what would the point
> be?

So, maybe I return instead the elapsed time in the netlink API instead of a
timestamp.  I think that will give me the value that I am looking for,
and I can still print out the 'real' time in iw so any tools reading that
output and do some simple math and figure out the 'real' associated-at time.

If that sounds good to you, I'll code that up.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

