Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726C31BCC8B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgD1Tnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgD1Tnd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 15:43:33 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Apr 2020 12:43:33 PDT
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D8C03C1AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 12:43:33 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1588103011; bh=4uywyY28Aw5WxX+aheSnZ0Ts/bOdaHukNk4gJid3N7g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=yPi9KTuP1sONUMVktAbYfj2AItiiT3Ol+mUi2A+kMk1OdDjpf5gDn0zJE5tw+xmZ1
         MUybLcl1FHE7wtT9KbyKZYkRLjSr6wSTEOOEyb5/1voS9s2YgHma3XhwOD3Seqcpix
         zPRDaDTIJ3WoRPFtRYIsSc4HnkTTjS+kvPzJToijO12YKoRjHZpYsCAEI5PKy/ONKb
         WfDo6LzBBLYKoUCdBSX+Qds27kilRHZHi+CFWZzdLA8zESfj1vj/cSAsWayfK0Xl/c
         DzTsyhadC/JzK0/Mxwyqeu2szzizFllZMf6NPOJJbqFMn7JsC9qBsJ5QDSIzeaapZp
         Q25gnEf+dQd/g==
To:     Ben Greear <greearb@candelatech.com>,
        Dave Taht <dave.taht@gmail.com>,
        Steve deRosier <derosier@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
In-Reply-To: <ae5587d1-f910-5fbe-42ab-3c4d722b259b@candelatech.com>
References: <20200427145435.13151-1-greearb@candelatech.com> <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com> <CAA93jw5tcptB64B8nGH0hqr4xC9G2SXNjp2tPf3YK5R7t6ZjXw@mail.gmail.com> <ae5587d1-f910-5fbe-42ab-3c4d722b259b@candelatech.com>
Date:   Tue, 28 Apr 2020 21:43:21 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ees7v1k6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 04/28/2020 09:27 AM, Dave Taht wrote:
>> On Tue, Apr 28, 2020 at 7:56 AM Steve deRosier <derosier@gmail.com> wrote:
>>>
>>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>>>>
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> While running tcp upload + download tests with ~200
>>>> concurrent TCP streams, 1-2 processes, and 30 station
>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>>> around 20% of the CPU according to perf-top, which other locking
>>>> taking an additional ~15%.
>>>>
>>>> I believe the issue is that the ath10k driver would unlock the
>>>> txqueue when a single frame could be transmitted, instead of
>>>> waiting for a low water mark.
>>>>
>>>> So, this patch adds a low-water mark that is 1/4 of the total
>>>> tx buffers allowed.
>>>>
>>>> This appears to resolve the performance problem that I saw.
>>>>
>>>> Tested with recent wave-1 ath10k-ct firmware.
>>>>
>>>
>>> Hey Ben,
>>>
>>> Did you do any testing with this patch around latency?  The nature of
>>> the thing that you fixed makes me wonder if it was intentional with
>>> respect to making WiFi fast - ie getting rid of buffers as much as
>>> possible.  Obviously the CPU impact is likely to be an unintended
>>> consequence. In any case, I don't know anything for sure, it was just
>>> a thought that went through my head when reading this.
>>
>> I note that I'd prefer a BQL-like high/low watermark approach in
>> general... bytes, not packets, or better, perceived
>> airtime in a revision of AQL...
>>
>> ... but we'll try this patch, thx!
>
> Is there a nice diagram somewhere that shows where the various
> buffer-bloat technologies sit in the stack?

Not really. Best thing I know of is the one I drew myself: Figure 3 of this paper:
https://www.usenix.org/system/files/conference/atc17/atc17-hoiland-jorgensen.pdf

That is still a semi-accurate representation of the queueing structure
in mac80211. For ath10k, just imagine that the bit that says "ath9k
driver" is part of mac80211, and that the "HW queue" is everything the
driver and firmware does... AQL also activates in the circle labelled
"RR" there, but the figure predates AQL.

> I suspect such should be above the txqueue start/stop logic in the
> driver that I mucked with, and certainly the old behaviour has no
> obvious tie-in with any higher-level algorithms.
>
> I doubt my patch will change much except in pathological cases where
> the system is transmitting frames fast enough to fully fill the tx
> buffers and also loaded in such a way that it can process just a few
> tx frames at a time to keep bouncing to full and not full over and
> over.

The latter part of that ("can process just a few tx frames at a time")
mostly happens when many stations are active at the same time, right?

-Toke
