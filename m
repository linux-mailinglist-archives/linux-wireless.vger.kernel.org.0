Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D947F969A2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfHTTn2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 15:43:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42432 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTTn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 15:43:27 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0A2P-0006uR-7X; Tue, 20 Aug 2019 21:43:25 +0200
Message-ID: <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dan Williams <dcbw@redhat.com>
Date:   Tue, 20 Aug 2019 21:43:22 +0200
In-Reply-To: <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com> (sfid-20190820_213040_001184_91DC1D7A)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
         <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
         <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
         (sfid-20190820_213040_001184_91DC1D7A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 14:22 -0500, Denis Kenzior wrote:
> Hi Johannes,
> 
> So keeping things purely technical now :)
> 
> > I thought so, but I had another thought later. It might be possible to
> > set LIVE_ADDR_CHANGE, but then block it in mac80211 when the interface
> > is already connected (or beaconing, or whatever, using the MAC address
> > in some way - even while scanning, remain-on-channel is active, etc.)
> > 
> 
> Here's what we would like to see:
> 
> - The ability for userspace to add a 'Local Mac Address to use' 
> attribute on CMD_CONNECT and CMD_AUTHENTICATE.

Why here though? I don't really like this as it's extra complexity
there, and dev_set_mac_address() is really easy to call from userspace.
Yes, that's sort of a round-trip more (you wouldn't even really have to
wait for it I guess), but we have to make trade-offs like that (vs.
kernel complexity) at some point.

> - It doesn't seem useful to add this to CMD_ASSOCIATE at the moment, as 
> for new connections you'd always go either through CMD_AUTHENTICATE, 
> CMD_ASSOCIATE sequence or use CMD_CONNECT.  This should take care of 
> some (most) of your objections about specifying different addresses for 
> authenticate/associate.  Feel free to correct me here.

That wasn't really my objection, I was more wondering why James
implemented it *only* for CMD_CONNECT, when I had been under the
(apparently mistaken) impression that one would generally prefer
CMD_ASSOCIATE over CMD_CONNECT, if available.

> - Optionally (and I'm thinking of tools like NM here), add the ability 
> to set the mac address via RTNL while the device is UP but has no 
> carrier, and things like scanning, offchannel, etc are not in progress. 
> Though really I don't see how NM could guarantee this without bringing 
> the device down first, so I'll let NM guys chime in to see if this is a 
> good idea.

I'm thinking along the lines of letting you do this *instead* of the
scheme you described above. That way, we don't even need to have a
discussion over whether it makes sense at CONNECT, AUTH, ASSOC, or
whatever because you can essentially do it before/with any of these
commands.

Why would this not be sufficient?

> - We definitely do not want to to mess with the device state otherwise. 
> E.g. no firmware downloading, powering the adapter down, etc.  That just 
> takes too much time.

I can understand this part.

> So tell us what you would like to see.  A new 
> IFF_NO_CARRIER_ADDRESS_CHANGE or whether it is possible to use 
> IFF_LIVE_ADDR_CHANGE with some additional restrictions.

I don't know. This is not something I'm intimately familiar with. I
could imagine (as you quoted above) that we just set
IFF_LIVE_ADDR_CHANGE and manage the exclusions local to e.g. mac80211.

> > I still think you'd have to bake it into the mac80211<->driver API
> > somehow, because we normally "add_interface()" with the MAC address, and
> > nothing says that the driver cannot ignore the MAC address from that
> > point on. The fact that iwlwifi just copies it into every new MAC_CTXT
> > command and the firmware actually accepts the update seems rather
> > accidental and therefore fragile to rely on.
> > 
> 
> Since you seem to have a clear(er?) idea here, can you elaborate or 
> possibly provide the driver interface changes you want to see?

I can see a few ways of doing this, for example having an optional
"change_vif_addr" method in the mac80211 ops, so that drivers can do the
necessary work. I suppose iwlwifi would actually want to send a new
MAC_CONTEXT command at this time, for example, because the firmware is
notoriously finicky when it comes to command sequences.

Alternatively, and this would work with all drivers, you could just
pretend to remove/add the interface, ie. in mac80211 call

 drv_remove_interface(sdata)
 // set new mac addr
 drv_add_interface(sdata)

This has the advantage that it'll be guaranteed to work with all
drivers, at the expense of perhaps a few more firmware commands
(depending on the driver).

You can probably come up with other ways, like having a feature flag
whether this is supported and then the driver has to detect it as
certain documented points in time, etc., but all of those feel
relatively fragile to me.


My personal preference would be for

 * allow RTNL MAC address changes at "idle" times (TBD what that really
   means) with IFF_LIVE_ADDR_CHANGE, but mac80211 guarding it
 * mac80211 doing remove/add as far as the driver is concerned

Yes, you can probably shave a few more milliseconds off by adding more
complexity, but unless we measure that and find it to be significant, I
think the added complexity (in cfg80211 code) and restrictions (many
drivers not supporting it if it's opt-in) wouldn't be worth it.

johannes

