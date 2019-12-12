Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6311CBA8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfLLLAj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 06:00:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36454 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfLLLAj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 06:00:39 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifMCv-006l2h-DV; Thu, 12 Dec 2019 12:00:33 +0100
Message-ID: <bd9f32d02374a5e0b341585db88856a1e420ede8.camel@sipsolutions.net>
Subject: Re: iwlwifi warnings in 5.5-rc1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Date:   Thu, 12 Dec 2019 12:00:31 +0100
In-Reply-To: <87v9qleru0.fsf@toke.dk>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk>
         <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net>
         <878snjgs5l.fsf@toke.dk>
         <3420d73e667b01ec64bf0cc9da6232b41e862860.camel@sipsolutions.net>
         <875zingnzt.fsf@toke.dk>
         <bfab4987668990ea8d86a98f3e87c3fa31403745.camel@sipsolutions.net>
         <87tv67ez9p.fsf@toke.dk>
         <3ca2be96898e9d30c27b2411148d201318e413f2.camel@sipsolutions.net>
         <87v9qleru0.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-12 at 11:55 +0100, Toke Høiland-Jørgensen wrote:
> 
> > I'm not even sure we *can* do this easily - do we know up-front how many
> > packets this will expand to? We should know, but it might not be so easy
> > given the abstraction layers. We could guess and if it's wrong just set
> > it to 0 on any remaining ones.
> 
> I was thinking about a scheme where we re-defined the value in the cb to
> be a "time per byte" value, that we could just multiply by the packet
> length; that would make it trivial to do partial reporting. Not sure
> it's quite workable in practice, though; it would be hard to avoid
> rounding errors, and there's also the additional headers when splitting
> a packet, so the lengths don't necessarily add up.

Yeah, that won't really work. We could only estimate the # of pieces and
split up the value across them.

> > It's really just an artifact of our software implementation that we
> > report the SKBs back as used with partial content. Maybe we shouldn't
> > even do that, since they weren't generated by mac80211 in the first
> > place, and only report the original skb or something.
> 
> Hmm, yeah, was wondering how that works, actually. I assumed you send
> the whole thing to the hardware as one superpacket? But if so how do you
> get the completion events back? Or are you splitting it in the driver
> just before you send it to the hardware?

If we get say a 64k superpacket, we'll split it first into SKBs of max
A-MSDU size, and then rejigger the pieces inside each A-MSDU thing using
the DMA engine so we get A-MSDUs of MTU-sized packets out at the end.
The hardware is dumb here, it only takes care of TCP checksum.

> > I'm not really sure I want to rely on this - this was never really
> > needed *functionally*, just from a *statistics* point of view (e.g. "iw
> > link" or such).
> 
> Right, I see. Well I guess now that we're turning this on one driver at
> a time, we can ensure that the driver provides sufficiently accurate
> rate information as part of that.

Right.

> BTW, since we're discussing this in the context of iwlwifi: do you have
> any data as to how much benefit AQL would be for that? I.e., do the
> Intel devices tend to buffer a lot of data in hardware/firmware?

Hardware we have queues up to ~240 frames or so, otherwise no real
buffering. Per station/TID.

> > Ideally, it'd be a function call from the rate scaling to mac80211 so we
> > don't have to call a function every time we need the value, but the rate
> > scaling just calls us whenever it updates. This would even work with
> > iwlwifi's offloaded algorithm - it notifies the host on all changes.
> 
> Yup, this makes sense, and would be easy to integrate with Minstrel as
> well, I think. We already have ieee80211_sta_set_expected_throughput(),
> so maybe expanding that? It just provides a single number now, but we
> could change it to set the full rate info instead?

Right, was thinking around that area too. Not sure about the details
really though.

johannes

