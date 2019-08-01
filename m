Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A67D9F9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfHALFH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 07:05:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58712 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfHALFH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 07:05:07 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ht8tI-0004GA-8X; Thu, 01 Aug 2019 13:05:00 +0200
Message-ID: <e9266656ba9a5df19b26a70840e3d750b57292a3.camel@sipsolutions.net>
Subject: Re: [RFCv1 2/2] nl80211: Don't split-dump for clients with large
 buffers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Thu, 01 Aug 2019 13:04:57 +0200
In-Reply-To: <29DA5CC8-9CAF-4F9A-933C-ED3D6B25FA4E@holtmann.org>
References: <20190801071455.4974-1-denkenz@gmail.com>
         <20190801071455.4974-2-denkenz@gmail.com>
         <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
         <29DA5CC8-9CAF-4F9A-933C-ED3D6B25FA4E@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marcel,

> > Also, I don't really buy the *need* for this since you're just removing
> > a few kernel/user roundtrips here when new devices are discovered, a
> > rare event. The parsing isn't really any more complicated for the
> > userspace side.
> 
> that is an argument that is coming to bite you. Forcing multiple
> roundtrips or even collecting multiple split message for some ancient
> legacy client behavior is just silly. If clients provide larger
> buffers, we should start using them.

I'm not arguing legacy/old client behaviour.

> I have proven a long time ago that round-trips are causing delays and
> creating visible user experience issues. Look up my DHCP presentation
> from either LinuxCon or PlumbersConf. One round-trip leads to another
> and at some point you end up with seconds wasted because you want to
> sit here and ignore efforts in improving the situation.

Comparing network roundtrips to local kernel access isn't exactly a very
good comparison.

> > And finally, I also see no reason to send out many KB of data for what
> > might in the end (e.g. in iw) just be a debug message.
> 
> Actually iw is just a dev tool. It should not be run in production and
> so that is not an argument. Any proper client that cares about your
> WiFi connections will want this information.

Again, this isn't an argument. I said wpa_s is an example. Any other
number of tools works, even wpa_s. Heck, probably even iwd, when
configured to not care about some devices (unless you can't even make it
ignore devices, which I'd consider a deficiency in its own right).

> > But really I think the thing that kills this proposal is the fact that
> > it reintroduces a message size limit (even if higher now) that we're
> > somewhat likely to hit in the future.
> 
> Maybe we need to accept that current nl80211 API is broken and start
> over. Or we should at least start deprecating commands and replacing
> them with new ones that are doing a better job for clients that
> actually behave properly.

I know you love throwing things away and rewriting them, but you're not
going to solve the problem.

I suggest you re-read my email and actually reply to it, rather than
throwing out bullet points.

Frankly, I'm tired of having a discussion where all you do is accuse me
of not caring about the problem, but then you don't even respond to any
arguments.

johannes

