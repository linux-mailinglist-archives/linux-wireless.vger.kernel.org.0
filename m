Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305542334EE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgG3PDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgG3PDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 11:03:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657BC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 08:03:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k1A5j-00Db0Q-BR; Thu, 30 Jul 2020 17:03:31 +0200
Message-ID: <cbe230f7270587e14ccee835561c437362e3933d.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Date:   Thu, 30 Jul 2020 17:03:30 +0200
In-Reply-To: <98996ee9-a9cc-521b-05cc-1404d3b9b251@candelatech.com>
References: <20200525165317.2269-1-greearb@candelatech.com>
         <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
         <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
         <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
         <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
         <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
         <98996ee9-a9cc-521b-05cc-1404d3b9b251@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 07:52 -0700, Ben Greear wrote:

> > Consider
> > 
> > add interface wlan0
> > add interface wlan1
> > iterate active interfaces -> wlan0 wlan1
> > add interface wlan2
> > iterate active interfaces -> wlan0 wlan1 wlan2
> > 
> > If you apply this scenario to a restart, which ought to be functionally
> > equivalent to the normal startup, just compressed in time, you're
> > basically saying that today you get
> > 
> > add interface wlan0
> > add interface wlan1
> > iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
> > add interface wlan2
> > iterate active interfaces -> wlan0 wlan1 wlan2
> > 
> > which yeah, totally seems wrong.
> > 
> > But fixing that to be
> > 
> > add interface wlan0
> > add interface wlan1
> > iterate active interfaces ->
> > <nothing>
> > add interface wlan2
> > iterate active interfaces -> <nothing>
> > (or
> > maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)
> > 
> > seems equally wrong?
> 
> So, looks like there is a flags option passed to the iterate logic, and it is indeed called
> directly from drivers.  So, I could just add a new flag value, and | it in when calling from ath10k.
> 
> I'm not sure it would really solve the second case, but at least in practice,
> that one doesn't seem to be a problem with ath10k, and the first case *was*
> a problem.
> 
> If that sounds OK to you, I'll work on the patch as described.

Right, that'd be the option 2. I described earlier. I can live with that
even if I'd prefer to fix it as per 1. to "make sense". But I guess
there could even be "more legitimate" cases to not want to iterate while
restarting, even if I'm not really sure where that'd make sense?

I guess Kalle should comment on whether he'd accept that into the
driver.

Kalle, as you can see above mac80211 appears to be broken wrt. iterating
"active" interfaces during a restart - the iteration considers all
interfaces active that were active before the restart, not just the ones
that were already re-added to the driver. Ben says this causes trouble
in ath10k.

IMHO the right fix for this would be to fix the iteration to only reach
the ones that have been re-added, like I've said above. OTOH, Ben isn't
really convinced that that's right, and has experience with a patch that
makes mac80211 return *no* interfaces whatsoever in the iteration when
done while in restart. Like I say there, it seems wrong to me.

But depending on what ath10k actually _does_ with this list, perhaps
it's not an issue. Perhaps it's just transient state that it derives
from it, so if it does it again after the reconfig is completed, it
would in fact get all the information it needed.

I'm pretty sure this would break iwlwifi, so one option (less preferred)
would be to add a flag to say "skip iteration in reconfig".

actually does the driver know it's in reconfig? Perhaps it could even do
that completely on its own?

Anyway, the question is what you think about doing such a thing in the
driver, if it fixes issues even if it's probably not really correct.

johannes

