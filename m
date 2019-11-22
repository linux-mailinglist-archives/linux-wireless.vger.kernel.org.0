Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9952107737
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKVSWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 13:22:41 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:36150 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVSWl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 13:22:41 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id BDD5613C359;
        Fri, 22 Nov 2019 10:22:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BDD5613C359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1574446960;
        bh=H5lKRZGfjQs5omPP4QivF8LYeGAa5yYNBbYUBGQFoNA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=YUNU7WfDlyYV/YVYxRNuzLDh7qyxZwE/U8Cjn9KS6lMEW3TK3aAm5WiDDUftEgk5D
         jkfiFiA4Ev76q5f1Om1Jttohw/AG7RgZ3GJ2KOWN0FnG/35agRMeKLFmrK1azKVD2Q
         VYCCPrC4eL83QZmfIh5GG8NiOZhl5l9AFh8TW69Y=
Subject: Re: [PATCH 00/10] Ben's grab bag of mac80211 patches
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20191108194210.23618-1-greearb@candelatech.com>
 <40f85196f29bf0dc4bfbe57345a5db4d7aff7f89.camel@sipsolutions.net>
 <99eeff65-80de-bb8d-00ba-1863e232476f@candelatech.com>
 <126ddcaac00f3c2de1c25097aa2e42af74dc4a75.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c0bbede4-4dcd-8328-b1da-ffe497100ed5@candelatech.com>
Date:   Fri, 22 Nov 2019 10:22:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <126ddcaac00f3c2de1c25097aa2e42af74dc4a75.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/22/19 9:53 AM, Johannes Berg wrote:
> On Fri, 2019-11-22 at 08:37 -0800, Ben Greear wrote:
> 
>> Well, 1 out of 10 ain't that bad!
> 
> Heh.
> 
>>> 5 seems like it might be reasonable, but it's hard to read and
>>> understand, maybe revisit that?
>>
>> This is the patch you previously said you liked but it would not apply upstream.
>> Now it applies.  That whole code mess is hard to understand, but I have been running
>> a similar patch for a while and it has worked well.
>>
>> Instead of trying to understand the patch, try applying it and then read the resulting
>> code.  It is a lot simpler to understand that way I think.
> 
> OK :)
> 
>> You can also sniff air with current code w/out this patch and watch the crappy
>> retry behaviour where the retries are clumped in a few ms of time instead of being
>> spread out.
> 
> Right. I'll have to review this carefully. I think the Intel firmware
> will soon spread out the hardware retries a bit too (vs. here the
> software retries).
> 
>> Ath10k will always use legacy rates for ctrl frames and such even if
> 
> *control* frames have a very tightly controlled rate, e.g. ACK must have
> the same or next lower mandatory rate, or basic rate, or something. I
> don't have it in my head right now.
> 
> Do you mean *management* frames?

Yes, I mean all sorts of frames that should use legacy rates.  When you 'set the rate'
in ath10k, you are really just setting the data-packet's rate, and upstream driver/firmware
has other limitations (you can set single rate, or mcs-8 or mcs-9, but you cannot tell it to use
mcs-5 and mcs-6 only, for instance).

There are other ways to adjust management frame rates, but it is not through normal
mac80211 rate-setting logic.

>> you otherwise restrict the rateset.  So, it is legit to set a single rate even if
>> that would leave no legacy rates configured as far as mac80211 is concerned.
>>
>> Your patch broke the ability to set a single rate in ath10k, and my change will
>> allow it to work again.
> 
> Either way, it's kind of an ath10k bug in a sense. You don't actually
> want to "set this single rate", you want to "set this single rate for
> data frames" or so ... which is a different API. >
> If you look at ath9k or any other driver with software rate control, it
> would not be able to pick a legacy rate for mgmt frames at all with your
> patch and the warning, and then I'm pretty sure you'll hit a WARN_ON()
> in rate.c.
> 
> So no, I will certainly not apply this.
> 
> Maybe you want to add a different API that affects only data frames (or
> a variant of this API or something), instead, but this is not it. We
> can't leave the software drivers without any rates to pick from for
> management frames.

Maybe we can add a driver flag that indicates we can relax this check
and have ath10k set that flag?  Adding a whole top to bottom API to change
how rates are set sounds like a pain, and would probably be specific to
ath10k only in the end anyway?

(Remember the discussion about setting advertised vs used rates?  This would
  be even more complex and less useful than that I think).

> 
>>> 8 I don't like at all. How about you do it in the driver somehow?
>>
>> I had low hopes for this one anyway.  mac80211 has the software decrypt logic, not the
>> driver, so it seemed reasonable to have the mac80211 do a callback.  This patch is likely
>> only useful for drivers that do block-ack in the firmware and support software decrypt,
>> which may only be my modified ath10k-ct driver/firmware.
> 
> So far that's the only one, as far as I can tell, yeah ...
> 
>>> 9 is like 2-4 really, I guess maybe this one I could get behind if it
>>> came with a commit log that actually explains why one is likely to hit
>>> this multiple times or something?
>>
>> Basically, it is almost never useful to use WARN_ON instead of WARN_ON_ONCE.  If you ever
>> do hit the bug, often the logs are full of WARN_ON spam and you cannot even find the real problem
>> until you change it to WARN_ON_ONCE and reproduce the problem.
>>
>> I hit this problem due to some coding bug while poking at ath10k, and you get one splat
>> per tx frame, so you can image the spam.
> 
> Yeah, but does it matter? It should really just happen during
> development, right? Having the _ONCE makes this cost more space and
> code, and I'm not sure I see that much point in that.

Sure, for this one.  The sdata-in-driver warnings happen often-ish in ath10k.  No one can figure
out how to fix it, or really cares to look I think.

But, really, not worth arguing over.  The main patch in this series that I would like to see upstream
is the one that tweaks retry logic.  Others are fairly easy to maintain outside the tree and are
of more limited use to the general user.

> 
>>> 10 we did to fix other behaviour, so ...
>>
>> This one is especially useful for roaming several virtual stations, but maybe that is only useful test
>> case.  I included it more as an RFC, but it has worked well enough for us in case you see some worth in
>> it (and obviously it should be changed to not use // comments in case the functionality is actually
>> deemed useful).
> 
> I guess we can go back and forth on this ... but in most cases you don't
> know that the AP didn't go away, so IMHO the current behaviour is
> better. It's just in your special case you know it's more likely some
> local issues vs. the AP having disappeared.

What I saw is that supplicant would try to do a roam, and kernel would reject it because
it had just deleted the object.  Maybe it is better to have the kernel be more lenient and
let supplicant take care of the policy decisions?

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

