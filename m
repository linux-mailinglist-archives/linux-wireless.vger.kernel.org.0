Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740AC1076FA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKVSIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 13:08:54 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:49088 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfKVSIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 13:08:54 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYD7z-0002Dg-9O; Fri, 22 Nov 2019 18:53:55 +0100
Message-ID: <126ddcaac00f3c2de1c25097aa2e42af74dc4a75.camel@sipsolutions.net>
Subject: Re: [PATCH 00/10] Ben's grab bag of mac80211 patches
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 18:53:54 +0100
In-Reply-To: <99eeff65-80de-bb8d-00ba-1863e232476f@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
         <40f85196f29bf0dc4bfbe57345a5db4d7aff7f89.camel@sipsolutions.net>
         <99eeff65-80de-bb8d-00ba-1863e232476f@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 08:37 -0800, Ben Greear wrote:

> Well, 1 out of 10 ain't that bad!

Heh.

> > 5 seems like it might be reasonable, but it's hard to read and
> > understand, maybe revisit that?
> 
> This is the patch you previously said you liked but it would not apply upstream.
> Now it applies.  That whole code mess is hard to understand, but I have been running
> a similar patch for a while and it has worked well.
> 
> Instead of trying to understand the patch, try applying it and then read the resulting
> code.  It is a lot simpler to understand that way I think.

OK :)

> You can also sniff air with current code w/out this patch and watch the crappy
> retry behaviour where the retries are clumped in a few ms of time instead of being
> spread out.

Right. I'll have to review this carefully. I think the Intel firmware
will soon spread out the hardware retries a bit too (vs. here the
software retries).

> Ath10k will always use legacy rates for ctrl frames and such even if

*control* frames have a very tightly controlled rate, e.g. ACK must have
the same or next lower mandatory rate, or basic rate, or something. I
don't have it in my head right now.

Do you mean *management* frames?

> you otherwise restrict the rateset.  So, it is legit to set a single rate even if
> that would leave no legacy rates configured as far as mac80211 is concerned.
> 
> Your patch broke the ability to set a single rate in ath10k, and my change will
> allow it to work again.

Either way, it's kind of an ath10k bug in a sense. You don't actually
want to "set this single rate", you want to "set this single rate for
data frames" or so ... which is a different API.

If you look at ath9k or any other driver with software rate control, it
would not be able to pick a legacy rate for mgmt frames at all with your
patch and the warning, and then I'm pretty sure you'll hit a WARN_ON()
in rate.c.

So no, I will certainly not apply this.

Maybe you want to add a different API that affects only data frames (or
a variant of this API or something), instead, but this is not it. We
can't leave the software drivers without any rates to pick from for
management frames.

> > 8 I don't like at all. How about you do it in the driver somehow?
> 
> I had low hopes for this one anyway.  mac80211 has the software decrypt logic, not the
> driver, so it seemed reasonable to have the mac80211 do a callback.  This patch is likely
> only useful for drivers that do block-ack in the firmware and support software decrypt,
> which may only be my modified ath10k-ct driver/firmware.

So far that's the only one, as far as I can tell, yeah ...

> > 9 is like 2-4 really, I guess maybe this one I could get behind if it
> > came with a commit log that actually explains why one is likely to hit
> > this multiple times or something?
> 
> Basically, it is almost never useful to use WARN_ON instead of WARN_ON_ONCE.  If you ever
> do hit the bug, often the logs are full of WARN_ON spam and you cannot even find the real problem
> until you change it to WARN_ON_ONCE and reproduce the problem.
> 
> I hit this problem due to some coding bug while poking at ath10k, and you get one splat
> per tx frame, so you can image the spam.

Yeah, but does it matter? It should really just happen during
development, right? Having the _ONCE makes this cost more space and
code, and I'm not sure I see that much point in that.

> > 10 we did to fix other behaviour, so ...
> 
> This one is especially useful for roaming several virtual stations, but maybe that is only useful test
> case.  I included it more as an RFC, but it has worked well enough for us in case you see some worth in
> it (and obviously it should be changed to not use // comments in case the functionality is actually
> deemed useful).

I guess we can go back and forth on this ... but in most cases you don't
know that the AP didn't go away, so IMHO the current behaviour is
better. It's just in your special case you know it's more likely some
local issues vs. the AP having disappeared.

johannes

