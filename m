Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18D710A8A5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfK0CNi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 21:13:38 -0500
Received: from mail.taht.net ([176.58.107.8]:49178 "EHLO mail.taht.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfK0CNi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 21:13:38 -0500
Received: from nemesis.taht.net (c-71-198-101-102.hsd1.ca.comcast.net [71.198.101.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.taht.net (Postfix) with ESMTPSA id 245F821B46;
        Wed, 27 Nov 2019 02:13:34 +0000 (UTC)
From:   Dave Taht <dave@taht.net>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
References: <20191115014846.126007-1-kyan@google.com>
        <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
        <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
        <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
        <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
        <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
        <8736eiam8f.fsf@toke.dk>
        <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
        <87a78p8rz7.fsf@toke.dk>
        <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
        <87muco5gv5.fsf@toke.dk>
        <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
        <87eexvyoy8.fsf@toke.dk>
Date:   Tue, 26 Nov 2019 18:13:42 -0800
In-Reply-To: <87eexvyoy8.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Tue, 26 Nov 2019 10:19:43 +0100")
Message-ID: <878so2m5gp.fsf@nemesis.taht.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> Kan Yan <kyan@google.com> writes:
>
>>> Yeah, bpftrace can be a bit of a pain to get running; but it may be
>>> worth the investment longer term as well. It really is quite useful! :)
>>
>> My attempt to build bpftrace didn't work out, so I just got the
>> sojourn time using old fashioned trace event.
>> The raw trace, parsed data in csv format and plots can be found here:
>> https://drive.google.com/open?id=1Mg_wHu7elYAdkXz4u--42qGCVE1nrILV
>>
>> All tests are done with 2 TCP download sessions that oversubscribed
>> the link bandwidth.
>> With AQL on, the mean sojourn time about ~20000us, matches the default
>> codel "target".
>
> Yeah, since CoDel is trying to control the latency to 20ms, it makes
> sense that the value is clustered around that. That means that the
> algorithm is working as they're supposed to :)
>
> While you're running tests, could you do one with the target changed to
> 10ms, just to see what it looks like? Both sojourn time values and
> throughput would be interesting here, of course.
>
>> With AQL off, the mean sojourn time is less than 4us even the latency
>> is off the charts, just as we expected that fd_codel with mac80211
>> alone is not effective for drivers with deep firmware/hardware queues

I hope to take a close look at the iwl ax200 chips soon. Unless
someone beats me to it. Can we get these sort of stats out of it?

Has anyone looked at the marvell chips of late?

>
> Yup, also kinda expected; but another good way to visualise the impact.
> Nice!
>
> -Toke
>
> _______________________________________________
> Make-wifi-fast mailing list
> Make-wifi-fast@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/make-wifi-fast
