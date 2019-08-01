Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE97D975
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHAKhB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 06:37:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60861 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfHAKhB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 06:37:01 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AF436CED13;
        Thu,  1 Aug 2019 12:45:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFCv1 2/2] nl80211: Don't split-dump for clients with large
 buffers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
Date:   Thu, 1 Aug 2019 12:36:59 +0200
Cc:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <29DA5CC8-9CAF-4F9A-933C-ED3D6B25FA4E@holtmann.org>
References: <20190801071455.4974-1-denkenz@gmail.com>
 <20190801071455.4974-2-denkenz@gmail.com>
 <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> +		/*
>> +		 * auto-detect support for large buffer sizes: af_netlink
>> +		 * will allocate skbufs larger than 4096 in cases where
>> +		 * it detects that the client receive buffer (given to
>> +		 * recvmsg) is bigger.  In such cases we can assume that
>> +		 * performing split dumps is wasteful since the client
>> +		 * can likely safely consume the entire un-split wiphy
>> +		 * message in one go without the extra message header
>> +		 * overhead.
>> +		 */
>> +		if (skb_tailroom(skb) > 4096) {
>> +			state->large_message = true;
>> +			state->split = false;
>> +		}
> 
> Hmm. That's kinda a neat idea, but I don't think it's a good idea. Have
> you checked how long the message is now?
> 
> Since we *did* in fact hit the previous limit, and have added a *lot* of
> things since then (this was years ago, after all), I wouldn't be
> surprised if we're reasonably close to the new limit you propose even
> now already.
> 
> Also, keep in mind that there are some devices that just have an
> *enormous* amount of channels, and that's only going to increase (right
> now with 6/7 GHz, etc.)
> 
> So in general, given all the variable things we have here, all this
> buffer size estimation doesn't seem very robust to me. You could have
> any number of variable things in a message:
> * channel list - which we alleviated somewhat by having a separate
>   channel dump, so not all data is included here (which I guess you'll
>   complain about next :P)
> * nl80211_send_mgmt_stypes() things are also a bit variable, and we
>   keep adding interface types etc., and some devices may support lots
>   of frames (there's an upper bound, but it's not that small)
> * interface combinations - only getting more complex with more complex
>   devices and more concurrency use cases
> * vendor commands have no real limit
> * I'm sure measurement use cases will only increases
> * and generally of course we keep adding to everything
> 
> 
> Also, I don't really buy the *need* for this since you're just removing
> a few kernel/user roundtrips here when new devices are discovered, a
> rare event. The parsing isn't really any more complicated for the
> userspace side.

that is an argument that is coming to bite you. Forcing multiple roundtrips or even collecting multiple split message for some ancient legacy client behavior is just silly. If clients provide larger buffers, we should start using them.

I have proven a long time ago that round-trips are causing delays and creating visible user experience issues. Look up my DHCP presentation from either LinuxCon or PlumbersConf. One round-trip leads to another and at some point you end up with seconds wasted because you want to sit here and ignore efforts in improving the situation.

> Regarding the other patch, I think most of the above also applies there.
> I can sort of see how you think it's *nice* to have all the data right
> there, but I really don't see why you're so hung up about having to
> request the full information ... And I really don't want to see this hit
> the wall again in the future, in some weird scenarios with devices that
> have lots of <any of the above information>.
> 
> 
>> It should be safe to assume that any users of these new unsolicited
>> NEW_WIPHY events are non-legacy clients, which can use a
>> larger receive buffer for netlink messages.  Since older, legacy clients
>> did not utilize NEW_WIPHY events (they did not exist), it is assumed
>> that even if the client receives such a message (even if truncated), no
>> harm would result and backwards-compatibility would be kept.
> 
> Interesting idea, but no, in general you cannot assume that. Older
> clients might have added support for NEW_WIPHY without fixing the split
> dumps first ...
> 
> Also, you mention in the code that messages are truncated, but I'm
> pretty sure they're just dropped, not truncated.
> 
> And finally, I also see no reason to send out many KB of data for what
> might in the end (e.g. in iw) just be a debug message.

Actually iw is just a dev tool. It should not be run in production and so that is not an argument. Any proper client that cares about your WiFi connections will want this information.

> But really I think the thing that kills this proposal is the fact that
> it reintroduces a message size limit (even if higher now) that we're
> somewhat likely to hit in the future.

Maybe we need to accept that current nl80211 API is broken and start over. Or we should at least start deprecating commands and replacing them with new ones that are doing a better job for clients that actually behave properly.

Regards

Marcel

