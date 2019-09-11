Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2279DAF816
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfIKIhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 04:37:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33392 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKIhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 04:37:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7y7c-0001Vr-IA; Wed, 11 Sep 2019 10:37:04 +0200
Message-ID: <6dac6b1dccf059c964a0010a022402a599b7cc0d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: Add NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 10:37:03 +0200
In-Reply-To: <73e78b3e-f36a-aa29-a818-e0e1f0598b2f@gmail.com> (sfid-20190830_185517_653983_CFF14188)
References: <20190826162637.7535-1-denkenz@gmail.com>
         <f5986ccd8ecdcc08d5c3e0d65f8bddef8b0af021.camel@sipsolutions.net>
         <73e78b3e-f36a-aa29-a818-e0e1f0598b2f@gmail.com>
         (sfid-20190830_185517_653983_CFF14188)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Agreed.  I guess I just view nl80211.h as a sort of combination between 
> a uapi file and an actual manpage.  And manpages do mention which kernel 
> version a certain feature/flag/whatever was added.  Such info can be 
> useful in many ways, e.g. figuring out which kernel version might be 
> required for a certain piece of hardware, etc.

Yeah, fair point, I just think it's better to document that behaviour as
dependent on the flag, not the kernel version; this will continue to be
true for drivers that don't set the flag in future kernels after all.

IOW, I don't see how it does you any good to know that you're running on
kernel version 5.4, when the flag isn't set you still have to follow the
4 steps you outlined.

> > > + * @NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE: This device supports switching
> > > + * 	the IFTYPE of an interface without having to bring the device DOWN
> > > + * 	first via RTNL.  Exact semantics of this feature is driver
> > > + * 	implementation dependent.
> > 
> > That's not really nice.
> 
> Sorry.  This came from some doc changes I have pending.  I think I wrote 
> this after looking at some fullmac drivers and how they handle mode 
> changes and the wording reflects the exasperation I felt at the time.
> 
> Do you want to suggest some alternate wording?  I think it is worth it 
> to have some fair warning in the docs stating that prior to version so 
> and so the semantics are completely driver dependent.

Well, but you're trying to document/advertise the restrictions now. So
this feels a bit insufficient, by advertising the feature flag the
device is now saying "it's possible I can switch, but don't ask me how
or when". (Cont'd below)

So I don't really think it's the wording that bothers me so much as the
fact that you're basically going only half the way documenting this. We
have nothing now, which I can agree isn't a good thing, but adding a
flag that says "maybe you can do it on this device" doesn't really
change the status quo *much*, since that was already true before.

It seems to me you'd rather want a definitive statement.

> > > For mac80211, the following restrictions
> > > + * 	apply:
> > > + * 		- Only devices currently in IFTYPE AP, P2P_GO, P2P_CLIENT,
> > > + * 		  STATION, ADHOC and OCB can be switched.
> > > + * 		- The target IFTYPE must be one of: AP, P2P_GO, P2P_CLIENT,
> > > + * 		  STATION, ADHOC or OCB.
> > > + * 	Other drivers are expected to follow similar restrictions.
> > 
> > Maybe we should instead have a "bitmask of interface types that can be
> > switched while live" or something like that?
> > 
> 
> I'm fine with that, but this would only apply to newer kernels, no?

Sure, but all that you're doing here does.
 
> Don't we at least want to attempt to state what the rules are for older 
> ones?

That's what you did above for the NL80211_CMD_SET_INTERFACE
documentation update, I don't think it would belong into the
documentation for NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE? And you wrote
that this is what happens when the flag is *set* which by definition
cannot happen in older kernels.

> An alternative might be to simply state what the restrictions are and 
> just enforce those at the cfg80211 level.

Sounds good to me, we do that for a lot of things. Basically that just
takes it one step further - I said above we could advertise the
restrictions, but once we do that cfg80211 knows and can also enforce
it.

johannes

