Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F062332BB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgG3NLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgG3NLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:11:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1E6C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:11:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18L1-00DXVV-62; Thu, 30 Jul 2020 15:11:11 +0200
Message-ID: <a91c9337da6458e5f1d61ff36ec07e66132d0c1e.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix kernel hang on ax200 firmware crash.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:11:10 +0200
In-Reply-To: <fffa6cc5-99b6-f598-e20f-b30270ecd04c@candelatech.com>
References: <20200610204017.4531-1-greearb@candelatech.com>
         <62c74ddba571af59b2aeba116ff78ecc3b9b9710.camel@sipsolutions.net>
         <fffa6cc5-99b6-f598-e20f-b30270ecd04c@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 05:52 -0700, Ben Greear wrote:
> 
> > > +		if (++count > 1000) {
> > > +			/* WTF, bail out so that at least we don't hang the system. */
> > > +			sdata_err(sdata, "Could not move state after 1000 tries, ret: %d  state: %d\n",
> > > +				  ret, sta->sta_state);
> > > +			WARN_ON_ONCE(1);
> > > +			break;
> > > +		}
> > 
> > I guess that should be
> > 
> > if (WARN_ON_ONCE()) ...
> 
> If we spin 1000 times, it is worth a second warning.  Or do you mean
> the WARN_ON_ONCE(ret) should have if in front of it?

Ah. I missed the WARN_ON_ONCE(ret) entirely. I just meant that the
warning could/should be around the condition.

In fact though, even the message probably should:

	if (WARN_ONCE(++count > 1000, "...", ...))
		break;

That way the message would be captured inside the warning, which is
better for tooling that parses warnings.

> > 
> > etc.
> > 
> > >   		int err = drv_sta_state(sta->local, sta->sdata, sta,
> > >   					sta->sta_state, new_state);
> > > -		if (err)
> > > -			return err;
> > > +		if (err == -EIO) {
> > > +			/* Sdata-not-in-driver, we are out of sync, but probably
> > > +			 * best to carry on instead of bailing here, at least maybe
> > > +			 * we can clean this up.
> > > +			 */
> > 
> > It _could_ be the driver itself returning -EIO, so why not check the
> > sdata-in-driver flag?
> 
> Right, but if driver is complaining here, we need to bail out regardless of
> sdata-in-driver or not,

Yes. But I'm not sure we should WARN on that?

>  unless you think a driver could return EIO and then
> a small bit later start working for the same request?

Hah, no. If that's a possibility due to some stupid firmware reasons,
let the driver deal with it.

> > Really here that mostly applies to the commit log, which should probably
> > say something like
> > 
> > 	mac80211: deadlock due to driver misbehaviour
> > 
> > or so, and then go on to explain what it does in *mac80211*, and show
> > the iwlwifi parts only as an *example*.
> 
> Its not really driver mis-behaviour per se.  The root cause is that the
> firmware crashes too badly for the driver to recover (ok, so driver might
> could be better, but I've also seen cases where ath10k NIC falls off the PCI
> bus, so nothing the driver can do in that case I think).

Fair enough. We actually do have some code in there that tries to
unbind/rebind the driver from the device eventually, but that's
obviously a very last resort.

FWIW, we do have multiple NICs in a single machine, but then we run them
from VMs so each VM only has a single NIC. But I don't see why that
should be different from the device/firmware point of view. Perhaps your
PCIe configuration is different.

> Per my other patches, I've seen this sdata-in-driver crap in the past, so
> I think I probably hit a similar bug in both ax200 and ath10k, but since
> ax200 is so easy to crash, it is much more likely to hit this bug than any
> other driver I'm aware of.
> 
> I'll try to re-word the commit message though, I don't really care what it
> says so long as the code gets in.

:)

Thanks,
johannes

