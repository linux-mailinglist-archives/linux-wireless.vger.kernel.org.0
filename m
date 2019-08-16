Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC7907E9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfHPSua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 14:50:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57444 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHPSu3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 14:50:29 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5F31ACED26;
        Fri, 16 Aug 2019 20:59:10 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFCv1 2/2] nl80211: Don't split-dump for clients with large
 buffers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e9266656ba9a5df19b26a70840e3d750b57292a3.camel@sipsolutions.net>
Date:   Fri, 16 Aug 2019 20:50:26 +0200
Cc:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <39C08F7B-C198-483A-8A63-317548B13D22@holtmann.org>
References: <20190801071455.4974-1-denkenz@gmail.com>
 <20190801071455.4974-2-denkenz@gmail.com>
 <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
 <29DA5CC8-9CAF-4F9A-933C-ED3D6B25FA4E@holtmann.org>
 <e9266656ba9a5df19b26a70840e3d750b57292a3.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>>> Also, I don't really buy the *need* for this since you're just removing
>>> a few kernel/user roundtrips here when new devices are discovered, a
>>> rare event. The parsing isn't really any more complicated for the
>>> userspace side.
>> 
>> that is an argument that is coming to bite you. Forcing multiple
>> roundtrips or even collecting multiple split message for some ancient
>> legacy client behavior is just silly. If clients provide larger
>> buffers, we should start using them.
> 
> I'm not arguing legacy/old client behaviour.
> 
>> I have proven a long time ago that round-trips are causing delays and
>> creating visible user experience issues. Look up my DHCP presentation
>> from either LinuxCon or PlumbersConf. One round-trip leads to another
>> and at some point you end up with seconds wasted because you want to
>> sit here and ignore efforts in improving the situation.
> 
> Comparing network roundtrips to local kernel access isn't exactly a very
> good comparison.

the speed up wasn’t in UDP packet roundtrips, it was in local roundtrips and system calls.

So yes, roundtrips to the kernel are adding up. And if we increase the message size by adding 75-80% extra bytes, then this is adding up over time. You mention yourself we will see new channels and people are adding 15+ cards to the same machine. Every channel gets its own netlink message and that just adds up in overall netlink messages and roundtrips.

If we keep telling people to talk directly to nl80211, because wpa_supplicant doesn’t provide certain information and also doesn’t want to provide them, then we have more users dumping the wiphy list and that adds up again. As far as I recall we are still holding the big RTNL lock for this operations.

I know you want to remove RTNL dependency, but maybe we should run iwmon first to see if there are not external users ending up dumping the wiphy list over and over again.

>>> And finally, I also see no reason to send out many KB of data for what
>>> might in the end (e.g. in iw) just be a debug message.
>> 
>> Actually iw is just a dev tool. It should not be run in production and
>> so that is not an argument. Any proper client that cares about your
>> WiFi connections will want this information.
> 
> Again, this isn't an argument. I said wpa_s is an example. Any other
> number of tools works, even wpa_s. Heck, probably even iwd, when
> configured to not care about some devices (unless you can't even make it
> ignore devices, which I'd consider a deficiency in its own right).

If you are a production end user device, you have the amount of devices in there that are needed. If you are development systems, then nobody cares about extra messages.

I don’t like this command line thinking approach to things. There is not always some human user behind it that can decide what device to use by calling other commands like ip / ifconfig / dmesg. You need to enumerate it to the human to decide what to use.

So I stand by my point, if you are daemon that tries to handle WiFi, then it will want all information. And this includes device enumeration. With that regard, wpa_supplicant is not an example since it does do any device enumeration. That is external to the calling application or user.

To note here, there is also code in glibc that calls RTM_GETLINK. So every program executions dumps the netdev list.

>>> But really I think the thing that kills this proposal is the fact that
>>> it reintroduces a message size limit (even if higher now) that we're
>>> somewhat likely to hit in the future.
>> 
>> Maybe we need to accept that current nl80211 API is broken and start
>> over. Or we should at least start deprecating commands and replacing
>> them with new ones that are doing a better job for clients that
>> actually behave properly.
> 
> I know you love throwing things away and rewriting them, but you're not
> going to solve the problem.
> 
> I suggest you re-read my email and actually reply to it, rather than
> throwing out bullet points.
> 
> Frankly, I'm tired of having a discussion where all you do is accuse me
> of not caring about the problem, but then you don't even respond to any
> arguments.

If stuff is broken and we can't figure out a way to fix it, then it needs to be thrown away. Sticking the head in the sand and just ignoring it is not helpful. I would like to see better proposals.

Have you lately tried to use NL80211_CMD_GET_WIPHY dumping without the NL80211_ATTR_SPLIT_WIPHY_DUMP flag set? While working on some new testing utility, I ended up getting split dumps without having asked for them. Since is looks like that is broken since 2013, I wonder where are all these legacy applications that we trying to support.

Regards

Marcel

