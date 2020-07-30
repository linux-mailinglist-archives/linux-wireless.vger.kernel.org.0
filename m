Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5F233344
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgG3Nlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgG3Nlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:41:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D75C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:41:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18oT-00DYSj-Ey; Thu, 30 Jul 2020 15:41:37 +0200
Message-ID: <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:41:36 +0200
In-Reply-To: <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
References: <20200525165317.2269-1-greearb@candelatech.com>
         <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
         <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
         <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
         <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 06:27 -0700, Ben Greear wrote:

> > 1. track per vif whether it was re-added, and skip before it is
> > 
> > If that works, I can certainly get behind it for semantic reasons (the
> > vif isn't yet active again), although even there I'm not sure how
> > iwlwifi would behave - but that's something I'd look into and perhaps
> > even consider a bug there since it shouldn't know about that interface
> > yet.
> 
> Wouldn't that complicate the sdata-in-driver check even more?  So it would
> be something like is-in-driver-but-not-yet-reconfigured-in-driver?

We should probably just clear the "is-in-driver" flag for the most part,
and just remember "was-in-driver" so we know which ones to reconfigure,
or something like that?

> This sort of state is quite nasty in my experience.  Almost better if
> we had less state.  Driver should already know if it has an object or not,
> so redundant adds, or requests from mac80211 for objects the driver does not
> have can be handled properly by the driver?

I don't think that'll work. Drivers just act on "add" and "remove",
they're not checking against double-add. And IMHO it makes more sense to
have mac80211 do good sequencing than the throw our hands in the air and
let the drivers have to be idempotent just because we can't figure out
the right sequencing?

> > 2. If for some reason that doesn't work, add an iteration flag that
> > controls this, rather than a per-device config?
> 
> I wrote this patch probably 5 or so years ago, and since I have fixed most of
> the ath10k firmware crashes that would tend to trigger this bug.  I think I have no
> good way to test any complicated change to this patch.
> 
> I am quite certain that ath9k and ath10k are at least not harmed by this patch, and
> certainly old ath10k benefited from this.  So, I'm comfortable adding a driver
> level flag enabled for those two drivers.  Changing all the calling locations to
> (maybe) add a flag or adding and tracking vif state is too risky to be worth this change I
> think.

Uh, why? I mean, at least mechanically replacing all the callers in that
driver wouldn't really be any different than adding a driver flag, but
is so much more flexible and can be used elsewhere. I don't think I buy
this argument much really.

Yes, I understand that there's always resistance to changing something
that works, but ...

Really I think the right thing to do here would be 1., and let mac80211
sort out the sequencing.

Consider

add interface wlan0
add interface wlan1
iterate active interfaces -> wlan0 wlan1
add interface wlan2
iterate active interfaces -> wlan0 wlan1 wlan2

If you apply this scenario to a restart, which ought to be functionally
equivalent to the normal startup, just compressed in time, you're
basically saying that today you get

add interface wlan0
add interface wlan1
iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
add interface wlan2
iterate active interfaces -> wlan0 wlan1 wlan2

which yeah, totally seems wrong.

But fixing that to be

add interface wlan0
add interface wlan1
iterate active interfaces ->
<nothing>
add interface wlan2
iterate active interfaces -> <nothing>
(or
maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)

seems equally wrong?

johannes

