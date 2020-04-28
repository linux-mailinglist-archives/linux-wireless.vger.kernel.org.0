Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B51BCDCD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 22:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD1U63 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1U62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 16:58:28 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE6C03C1AC
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 13:58:28 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1588107506; bh=OgLlq/adecw9MNHf3zkwGnebuyicGwxKeANh2hSGzWE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E7dd61vkMkWxxxlL7AX8xGgP7z8f3aag+JlmOx4EdQsAprXwF1ijX/dYf+0LegD69
         CaAIj6Pr5smM5wG9ho+SbrPBU039TJzHCtW0EFgzJ6CradSpifgFcSIGjirWpiACo4
         jUeGvJWKIE0zl7eT/l1p8TLC5sgbuiiEOyLuQTaUWWHmoMlKCDEfGiX3yZQ+GFESHG
         J9gGq7aCXjLhXHuuazEagGr5fz6/XXBW7rxaAz/qgFCWpYBDZxU/X1I5WcC6o45R1Z
         lD88bHU8WFxzrhL2XlT98iWGLP8pUgkoCEC8+olQ/bp3ei1SJtt+M1xwklI/siAKWh
         1kYf3In6U7LPQ==
To:     Ben Greear <greearb@candelatech.com>,
        Dave Taht <dave.taht@gmail.com>
Cc:     Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
In-Reply-To: <f0f8b69f-3c1e-2f11-77fe-5c881120cca4@candelatech.com>
References: <20200427145435.13151-1-greearb@candelatech.com> <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com> <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com> <87k11zv1ux.fsf@toke.dk> <CAA93jw7exafEx3YkvR5uaaBm5kxzYp3nw14zMfgT=2SwUjaQFg@mail.gmail.com> <f0f8b69f-3c1e-2f11-77fe-5c881120cca4@candelatech.com>
Date:   Tue, 28 Apr 2020 22:58:24 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874kt3uy33.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 04/28/2020 12:39 PM, Dave Taht wrote:
>> On Tue, Apr 28, 2020 at 12:37 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
toke.dk> wrote:
>>>
>>> Ben Greear <greearb@candelatech.com> writes:
>>>
>>>> On 04/28/2020 07:56 AM, Steve deRosier wrote:
>>>>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>>>>>>
>>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>>
>>>>>> While running tcp upload + download tests with ~200
>>>>>> concurrent TCP streams, 1-2 processes, and 30 station
>>>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>>>>> around 20% of the CPU according to perf-top, which other locking
>>>>>> taking an additional ~15%.
>>>>>>
>>>>>> I believe the issue is that the ath10k driver would unlock the
>>>>>> txqueue when a single frame could be transmitted, instead of
>>>>>> waiting for a low water mark.
>>>>>>
>>>>>> So, this patch adds a low-water mark that is 1/4 of the total
>>>>>> tx buffers allowed.
>>>>>>
>>>>>> This appears to resolve the performance problem that I saw.
>>>>>>
>>>>>> Tested with recent wave-1 ath10k-ct firmware.
>>>>>>
>>>>>
>>>>> Hey Ben,
>>>>>
>>>>> Did you do any testing with this patch around latency?  The nature of
>>>>> the thing that you fixed makes me wonder if it was intentional with
>>>>> respect to making WiFi fast - ie getting rid of buffers as much as
>>>>> possible.  Obviously the CPU impact is likely to be an unintended
>>>>> consequence. In any case, I don't know anything for sure, it was just
>>>>> a thought that went through my head when reading this.
>>>>
>>>> I did not, but on average my patch should make the queues be less full,
>>>> so I doubt it will hurt latency.
>>>
>>> I would tend to agree with that.
>>
>> Well, I don't, as it's dependent on right sizing the ring in the first p=
lace.
>
> My patch, barring strange issues elsewhere, can only make the firmware tx=
 queues less full on
> average.
>
> If you want to test with different ring sizes, you can play with the tx_d=
esc
> setting in the ath10k-ct driver 'fwcfg' options.
>
> http://www.candelatech.com/ath10k-10.4.php#config
>
> My testing shows that overall throughput goes down when using lots of pee=
rs
> if you have smaller numbers of txbuffers.  This is because the firmware
> will typically spread its buffers over lots of peers and have smaller amp=
du
> chains per transmit.  An upper stack that more intelligently fed frames
> to the firmware could mitigate this, and it is not all bad anyway since
> giving everyone a 64 ampdu chains will increase burstiness at least
> somewhat.

Making each transmission shorter is arguably the right thing to do in
the "extremely congested" scenario, though. If you have to wait your
turn behind 100 other stations for your next TXOP you'd generally want
each of those other stations to only transmit (say) 1ms instead of their
full 4ms. Yes, this will hurt aggregate throughput somewhat, but I'd
argue that in most cases the overall application performance would be
better. You're right, though, that ideally this would be managed a bit
smarter than by just running out of buffers :)

> I've always envisioned that the stuff you and Toke and others have been
> working on would help in this area, but I don't understand your stuff well
> enough to know if that is true or not.

It might, although as per above I'm not quite sure what "helps" really
means in this context. What would you expect a good behaviour to be
here? I think what you're alluding to is to limit the total number of
stations that will be allowed to have outstanding data in the firmware
at the same time, right? Here it would help a bit to know some more
details of how the firmware manages its internal queueing, and how it
schedules stations (if at all)?

BTW, are you running any of these tests with AQL enabled?

-Toke
