Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889E01075EA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVQhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 11:37:50 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:59978 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVQhu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 11:37:50 -0500
Received: from [192.168.1.47] (unknown [50.34.216.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7BD9C13C359;
        Fri, 22 Nov 2019 08:37:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7BD9C13C359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1574440669;
        bh=a2STn3A1Nt1io1esmeNq6aGz0pxmqBwKk/W/Q0ZorvM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FG6N0PXRdp3H7tWmV86FEYKyF8KlsZQTGgTS/QQIzT7tdq4XiV1rEQciSzDpiAfPE
         MAJ+yDRcTD9KR74UyEU2a8HTqFZSQNucYY7sEQh1Z7NVBJWGnoa3RI+t8pO5WT2E2b
         k6a++bFV2ueibTxdc7s/LnmxR4bFpsDOKZmAh2J4=
Subject: Re: [PATCH 00/10] Ben's grab bag of mac80211 patches
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20191108194210.23618-1-greearb@candelatech.com>
 <40f85196f29bf0dc4bfbe57345a5db4d7aff7f89.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <99eeff65-80de-bb8d-00ba-1863e232476f@candelatech.com>
Date:   Fri, 22 Nov 2019 08:37:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <40f85196f29bf0dc4bfbe57345a5db4d7aff7f89.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/22/2019 03:49 AM, Johannes Berg wrote:
> Hi Ben,
>
> Well, for me to consider any of these, you really should come with
> commit logs and reasons that actually make sense outside of your
> environment :)
>
> I committed a note that replaces patch 1.

Well, 1 out of 10 ain't that bad!

> I don't like 2-4, that just adds state and one should never hit it. If
> you're hitting these you should investigate the root cause, not fix the
> symptoms.
>
> 5 seems like it might be reasonable, but it's hard to read and
> understand, maybe revisit that?

This is the patch you previously said you liked but it would not apply upstream.
Now it applies.  That whole code mess is hard to understand, but I have been running
a similar patch for a while and it has worked well.

Instead of trying to understand the patch, try applying it and then read the resulting
code.  It is a lot simpler to understand that way I think.

You can also sniff air with current code w/out this patch and watch the crappy
retry behaviour where the retries are clumped in a few ms of time instead of being
spread out.

>
> I tend to think the previous module options along the lines of patch 6
> were a mistake, rather than add more ...
>
> 7 is totally not understandable, but might be legitimate? Unlikely, but
> hard to say.

Ath10k will always use legacy rates for ctrl frames and such even if
you otherwise restrict the rateset.  So, it is legit to set a single rate even if
that would leave no legacy rates configured as far as mac80211 is concerned.

Your patch broke the ability to set a single rate in ath10k, and my change will
allow it to work again.

>
> 8 I don't like at all. How about you do it in the driver somehow?

I had low hopes for this one anyway.  mac80211 has the software decrypt logic, not the
driver, so it seemed reasonable to have the mac80211 do a callback.  This patch is likely
only useful for drivers that do block-ack in the firmware and support software decrypt,
which may only be my modified ath10k-ct driver/firmware.

>
> 9 is like 2-4 really, I guess maybe this one I could get behind if it
> came with a commit log that actually explains why one is likely to hit
> this multiple times or something?

Basically, it is almost never useful to use WARN_ON instead of WARN_ON_ONCE.  If you ever
do hit the bug, often the logs are full of WARN_ON spam and you cannot even find the real problem
until you change it to WARN_ON_ONCE and reproduce the problem.

I hit this problem due to some coding bug while poking at ath10k, and you get one splat
per tx frame, so you can image the spam.


> 10 we did to fix other behaviour, so ...

This one is especially useful for roaming several virtual stations, but maybe that is only useful test
case.  I included it more as an RFC, but it has worked well enough for us in case you see some worth in
it (and obviously it should be changed to not use // comments in case the functionality is actually
deemed useful).

Thanks,
Ben

>
> johannes
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
