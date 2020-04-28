Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8D1BCCE0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1UAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 16:00:54 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:43164 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1UAj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 16:00:39 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F2A6113C2B8;
        Tue, 28 Apr 2020 13:00:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F2A6113C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588104038;
        bh=RIUD7wsE/hQ6ZPx1nOKiDlQZrb+OZBGcRKOwEeY3hC8=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=DsCS3oSuzbyYXFzIsnHsQC+o7qAtAegG3F3mHJrkImse6qyE7CQvBtLcRkpCstJAt
         jT7ipmj+lK+5fYDCZ5Qlg4XkHWp0wu0Me+fA9cKaMIKa1na/CR/n5nr9I9YIDbx9bE
         BcW0RotyZ92HmhZh9Z22wfdFKySdw3nMwiFLIUSw=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Dave Taht <dave.taht@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@toke.dk>
References: <20200427145435.13151-1-greearb@candelatech.com>
 <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
 <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com>
 <87k11zv1ux.fsf@toke.dk>
 <CAA93jw7exafEx3YkvR5uaaBm5kxzYp3nw14zMfgT=2SwUjaQFg@mail.gmail.com>
Cc:     Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <f0f8b69f-3c1e-2f11-77fe-5c881120cca4@candelatech.com>
Date:   Tue, 28 Apr 2020 13:00:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAA93jw7exafEx3YkvR5uaaBm5kxzYp3nw14zMfgT=2SwUjaQFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 04/28/2020 12:39 PM, Dave Taht wrote:
> On Tue, Apr 28, 2020 at 12:37 PM Toke Høiland-Jørgensen <toke@toke.dk> wrote:
>>
>> Ben Greear <greearb@candelatech.com> writes:
>>
>>> On 04/28/2020 07:56 AM, Steve deRosier wrote:
>>>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>>>>>
>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>
>>>>> While running tcp upload + download tests with ~200
>>>>> concurrent TCP streams, 1-2 processes, and 30 station
>>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>>>> around 20% of the CPU according to perf-top, which other locking
>>>>> taking an additional ~15%.
>>>>>
>>>>> I believe the issue is that the ath10k driver would unlock the
>>>>> txqueue when a single frame could be transmitted, instead of
>>>>> waiting for a low water mark.
>>>>>
>>>>> So, this patch adds a low-water mark that is 1/4 of the total
>>>>> tx buffers allowed.
>>>>>
>>>>> This appears to resolve the performance problem that I saw.
>>>>>
>>>>> Tested with recent wave-1 ath10k-ct firmware.
>>>>>
>>>>
>>>> Hey Ben,
>>>>
>>>> Did you do any testing with this patch around latency?  The nature of
>>>> the thing that you fixed makes me wonder if it was intentional with
>>>> respect to making WiFi fast - ie getting rid of buffers as much as
>>>> possible.  Obviously the CPU impact is likely to be an unintended
>>>> consequence. In any case, I don't know anything for sure, it was just
>>>> a thought that went through my head when reading this.
>>>
>>> I did not, but on average my patch should make the queues be less full,
>>> so I doubt it will hurt latency.
>>
>> I would tend to agree with that.
>
> Well, I don't, as it's dependent on right sizing the ring in the first place.

My patch, barring strange issues elsewhere, can only make the firmware tx queues less full on
average.

If you want to test with different ring sizes, you can play with the tx_desc
setting in the ath10k-ct driver 'fwcfg' options.

http://www.candelatech.com/ath10k-10.4.php#config

My testing shows that overall throughput goes down when using lots of peers
if you have smaller numbers of txbuffers.  This is because the firmware
will typically spread its buffers over lots of peers and have smaller ampdu
chains per transmit.  An upper stack that more intelligently fed frames
to the firmware could mitigate this, and it is not all bad anyway since
giving everyone a 64 ampdu chains will increase burstiness at least somewhat.

I've always envisioned that the stuff you and Toke and others have been
working on would help in this area, but I don't understand your stuff well
enough to know if that is true or not.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
