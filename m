Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628CF233308
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgG3N1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:27:14 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:55314 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3N1N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:27:13 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4E27E13C2B0;
        Thu, 30 Jul 2020 06:27:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4E27E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596115632;
        bh=yawXm3sQrN/4vCJkpI3PxbAGHRZLxx7GTK90BdWL680=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=p/qJZzzPWGKxuq3q/sYVWpQcMffi2wsk5BOK7EwTxPWga5+mfjYTVulpOdJERMJiq
         fqW+xPw2rjnMf8JP6wRjEW6Jo63ffSp9x6kMntCn8bFxGBt2o+072k2o8IRSoZvBdZ
         3GBWFuQKE0CUKRLEkDNQcX+Fw5XNdHHH3DIL6e0I=
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200525165317.2269-1-greearb@candelatech.com>
 <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
 <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
 <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
Date:   Thu, 30 Jul 2020 06:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 6:13 AM, Johannes Berg wrote:
> On Thu, 2020-07-30 at 06:05 -0700, Ben Greear wrote:
> 
>>> It might even be that this can only be done subject to driver choice.
>>
>> I have tested this patch hard for many years with hundreds of station vifs on ath9k radios and
>> 64 station vifs on ath10k radios, probably way harder than anyone else is testing
>> this sort of thing.
> 
> Yeah, I'm sure!
> 
>> Possibly you are correct about iwlwifi, I've never tested it with multi-interface,
>> and as you see, have had bad luck on ax200.
> 
> Right.
> 
>> If you'd accept a patch with a new driver flag check (which I can enable for
>> ath10k and ath9k), then I'll respin it thus.
> 
> My order of preference would be something like
> 
> 1. track per vif whether it was re-added, and skip before it is
> 
> If that works, I can certainly get behind it for semantic reasons (the
> vif isn't yet active again), although even there I'm not sure how
> iwlwifi would behave - but that's something I'd look into and perhaps
> even consider a bug there since it shouldn't know about that interface
> yet.

Wouldn't that complicate the sdata-in-driver check even more?  So it would
be something like is-in-driver-but-not-yet-reconfigured-in-driver?

This sort of state is quite nasty in my experience.  Almost better if
we had less state.  Driver should already know if it has an object or not,
so redundant adds, or requests from mac80211 for objects the driver does not
have can be handled properly by the driver?

> 
> 2. If for some reason that doesn't work, add an iteration flag that
> controls this, rather than a per-device config?

I wrote this patch probably 5 or so years ago, and since I have fixed most of
the ath10k firmware crashes that would tend to trigger this bug.  I think I have no
good way to test any complicated change to this patch.

I am quite certain that ath9k and ath10k are at least not harmed by this patch, and
certainly old ath10k benefited from this.  So, I'm comfortable adding a driver
level flag enabled for those two drivers.  Changing all the calling locations to
(maybe) add a flag or adding and tracking vif state is too risky to be worth this change I
think.

Thanks,
Ben



> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
