Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73811BE301
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2PnJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 11:43:09 -0400
Received: from mail.toke.dk ([45.145.95.4]:50871 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2PnG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 11:43:06 -0400
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1588174983; bh=UkAHXTIqYYPraz9c1FxtG5n4cpk4DuqAYm3GW8V8+oY=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=WpQtOWAWGoyFQDBe9xlLBjV8VNERSVy9zCzQVQWMNTKwoeZQvkI5ojvD+YHpAahL/
         rXnragaiECwuuzmbnE+7omSLgiEOKRhIdYmiaSxSksn3Des/Qx+vOVC7YQ05RVmWZY
         XI/wen44eAuFhQhN0/x2Zk0PjBX2VvHiFTUGkdx5I9ro1B5bhijtiErDlLZ8W1aIcz
         20R9zo1wKB1zI5KTeMaW3Gauz7Yz0P8bW8wzua0pZZTGUj+6jQZXi1qjrXiWRc52rO
         lJZ+ESVHKR92uhC8Krgf0c80LAljwcgi+SvZjkoytekkZs++KSQEIK/+W570ugwZLb
         c8yjGnPkZYINQ==
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
In-Reply-To: <129bca4a-8fd2-faa1-975f-5cb78e8027bc@candelatech.com>
References: <20200427145435.13151-1-greearb@candelatech.com> <87h7x3v1tn.fsf@toke.dk> <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com> <87a72vuyyn.fsf@toke.dk> <e6ee8635-b45f-c5fe-d32a-1d695b3a7934@candelatech.com> <87sggmtzdg.fsf@toke.dk> <31064453-15b4-877f-b70c-b6b9ed4ae50c@candelatech.com> <87blnatk6j.fsf@toke.dk> <129bca4a-8fd2-faa1-975f-5cb78e8027bc@candelatech.com>
Date:   Wed, 29 Apr 2020 17:42:57 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zhaus3ge.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 04/29/2020 07:56 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Ben Greear <greearb@candelatech.com> writes:
>>
>>> On 04/29/2020 02:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Ben Greear <greearb@candelatech.com> writes:
>>>>
>>>>> On 04/28/2020 01:39 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Ben Greear <greearb@candelatech.com> writes:
>>>>>>
>>>>>>> On 04/28/2020 12:37 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> greearb@candelatech.com writes:
>>>>>>>>
>>>>>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>>>>>
>>>>>>>>> While running tcp upload + download tests with ~200
>>>>>>>>> concurrent TCP streams, 1-2 processes, and 30 station
>>>>>>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>>>>>>>> around 20% of the CPU according to perf-top, which other locking
>>>>>>>>> taking an additional ~15%.
>>>>>>>>>
>>>>>>>>> I believe the issue is that the ath10k driver would unlock the
>>>>>>>>> txqueue when a single frame could be transmitted, instead of
>>>>>>>>> waiting for a low water mark.
>>>>>>>>>
>>>>>>>>> So, this patch adds a low-water mark that is 1/4 of the total
>>>>>>>>> tx buffers allowed.
>>>>>>>>>
>>>>>>>>> This appears to resolve the performance problem that I saw.
>>>>>>>>>
>>>>>>>>> Tested with recent wave-1 ath10k-ct firmware.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>>>>>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>>>>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/=
wireless/ath/ath10k/htt.h
>>>>>>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>>>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>>>>>>
>>>>>>>>>  	u8 target_version_major;
>>>>>>>>>  	u8 target_version_minor;
>>>>>>>>> +	bool needs_unlock;
>>>>>>>>>  	struct completion target_version_received;
>>>>>>>>>  	u8 max_num_amsdu;
>>>>>>>>>  	u8 max_num_ampdu;
>>>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/n=
et/wireless/ath/ath10k/htt_tx.c
>>>>>>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k=
_htt *htt)
>>>>>>>>>  	lockdep_assert_held(&htt->tx_lock);
>>>>>>>>>
>>>>>>>>>  	htt->num_pending_tx--;
>>>>>>>>> -	if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx - 1)
>>>>>>>>> +	if ((htt->num_pending_tx <=3D (htt->max_num_pending_tx / 4)) &&=
 htt->needs_unlock) {
>>>>>>>>
>>>>>>>> Why /4? Seems a bit arbitrary?
>>>>>>>
>>>>>>> Yes, arbitrary for sure. I figure restart filling the queue when 1/4
>>>>>>> full so that it is unlikely to run dry. Possibly it should restart
>>>>>>> sooner to keep it more full on average?
>>>>>>
>>>>>> Theoretically, the "keep the queue at the lowest possible level that
>>>>>> keeps it from underflowing" is what BQL is supposed to do. The diff
>>>>>> below uses the dynamic adjustment bit (from dynamic_queue_limits.h) =
in
>>>>>> place of num_pending_tx. I've only compile tested it, and I'm a bit
>>>>>> skeptical that it will work right for this, but if anyone wants to g=
ive
>>>>>> it a shot, there it is.
>>>>>>
>>>>>> BTW, while doing that, I noticed there's a similar arbitrary limit in
>>>>>> ath10k_mac_tx_push_pending() at max_num_pending_tx/2. So if you're g=
oing
>>>>>> to keep the arbitrary limit maybe use the same one? :)
>>>>>>
>>>>>>> Before my patch, the behaviour would be to try to keep it as full as
>>>>>>> possible, as in restart the queues as soon as a single slot opens up
>>>>>>> in the tx queue.
>>>>>>
>>>>>> Yeah, that seems somewhat misguided as well, from a latency perspect=
ive,
>>>>>> at least. But I guess that's what we're fixing with AQL. What does t=
he
>>>>>> firmware do with the frames queued within? Do they just go on a FIFO
>>>>>> queue altogether, or something smarter?
>>>>>
>>>>> Sort of like a mini-mac80211 stack inside the firmware is used to
>>>>> create ampdu/amsdu chains and schedule them with its own scheduler.
>>>>>
>>>>> For optimal throughput with 200 users steaming video,
>>>>> the ath10k driver should think that it has only a few active peers wa=
nting
>>>>> to send data at a time (and so firmware would think the same), and th=
e driver should
>>>>> be fed a large chunk of pkts for those peers.  And then the next few =
peers.
>>>>> That should let firmware send large ampdu/amsdu to each peer, increas=
ing throughput
>>>>> over all.
>>>>
>>>> Yes, but also increasing latency because all other stations have to wa=
it
>>>> for a longer TXOP (see my other reply).
>>>
>>> If you at most sent 4 station's worth of data to the firmware, and max
>>> is 4ms per txop, then you have at most 16ms of latency. You could also
>>> send just two station's worth of data at a time, as long as you can
>>> quickly service the tx-queues again that should be enough to keep the
>>> firmware/radio productive.
>>
>> Sure, but if you have 100 stations that are backlogged, and they each
>> transmit for 4ms every time they get a chance, then on average each
>> station has to wait 400 ms between each TXOP. That is way too long; so
>> the maximum TXOP size should go down as the number of backlogged
>> stations go up.
>
> 400ms should be fine for streaming netflix, and there is no reason
> that higher priority traffic cannot jump ahead in the queue for much
> better latency. If the frames are queued up in mac80211, then you
> don't have to depend on TID scheduling in the driver/firmware anyway.

Yeah, in an ideal world where you have total information about current
and future traffic patterns that is of course what you would do. The
trick is to design a general algorithm that works for all the weird
cases (and traffic mixes!) with only the information that's available to
it. We've gotten a fair way towards that, but as you point out there are
still improvements possible.

Really, I think you're the only one who's testing with this many
stations active at the same time, so I guess it's not surprising that
this case has not seen too much scrutiny thus far :)

>> AQL already does some the right thing, BTW: When the total outstanding
>> data queued in the firmware exceeds 24ms (by the AQL estimation), it'll
>> switch the per-station limit from 12ms to 5ms of queued data. Arguably
>> that could be lower (say, 2ms for the low per-station limit).
>
> That still should work OK for bulk transport, as 5ms is a full ampdu chai=
n.
>
>>> In the case where you have many users wanting lots of throughput, 8 or
>>> 16ms of extra latency is a good tradeoff vs no one being able to
>>> reliably get the bandwidth they need.
>>
>> Yes, 8-16ms of extra latency is likely worth it, but not much more than
>> that...
>>
>>> Higher priority TIDs will get precedence in ath10k firmware anyway, so
>>> even if at time 0 you sent 64 frames to a peer on back-ground TID, if
>>> you sent a VO frame at time 0+1, it could be transmitted first.
>>
>> Assuming anyone is actually using the priorities, that is; most
>> appliations are not (and those that are often do it wrong). Also, using
>> the VO queue hurts efficiency as well for the same reason, since it
>> can't aggregate at all.
>
> I think ath10k aggregates VO traffic just fine, but either way, you could
> use VI instead.
>
> The kernel can adjust the TID appropriately, so the mac80211 scheduler
> to could tweak the tid so that bulk transport always goes on BK, and
> things needing lower latency goes out on VI perhaps?

I thought about messing with priorities like this, actually. The reason
I didn't go any further with it was that we found that it was often not
a win at all; if a station has both latency-sensitive and bulk traffic
you might as well just stick the low-latency traffic at the front of the
aggregate and send the whole thing in one go. Saves a TXOP :)

>>>>> If you feed a few frames to each of the 200 peers, then even if
>>>>> firmware has 2000 tx buffers, that is only 10 frames per peer at best,
>>>>> leading to small ampdu/amsdu and thus worse over-all throughput and
>>>>> utilization of airtime.
>>>>
>>>> Do you have any data on exactly how long (in time) each txop becomes in
>>>> these highly congested scenarios?
>>>
>>> I didn't look at time, but avg packets-per-ampdu chain is 30+ in
>>> single station tests, and with many stations it goes into the 4-8
>>> range (from memory, so maybe I'm off a bit).
>>
>> Right; was just looking for rough numbers, so that is fine.
>>
>>> Here is an open-source tool that can give you those metrics by processi=
ng a pcap:
>>>
>>> https://github.com/greearb/lanforge-scripts/tree/master/wifi_diag
>>>
>>> # Ignore the LANforge bits about creating capture files, here is an exa=
mple of how to use it:
>>> https://www.candelatech.com/cookbook/wifire/wifi+diagnostic
>>>
>>>>
>>>>> It would be nice to be able to set certain traffic flows to have the
>>>>> throughput optimization and others to have the latency optimization.
>>>>> For instance, high latency on a streaming download is a good trade-off
>>>>> if it increases total throughput.
>>>>
>>>> For the individual flows to a peer, fq_codel actually does a pretty go=
od
>>>> job at putting the latency-sensitive flows first. Which is why we want
>>>> the queueing to happen in mac80211 (where fq_codel is active) instead =
of
>>>> in the firmware.
>>>
>>> That sounds good to me. What is needed from the driver/firmware to
>>> make this work well?
>>
>> To queue as little as possible :)
>>
>> AQL is the mechanism we have to enforce this (for ath10k), by throttling
>> queueing into the firmware earlier. It only does this on a per-station
>> limit, though, and there's currently no mechanism to limit the total
>> number of stations with outstanding data, as you're requesting. Which I
>> guess means it won't help much in your case. One could imagine building
>> a mechanism on top of AQL to do this, though, although I think it may
>> not be quite trivial to get the interaction with the station scheduler
>> right. The basic building blocks are there, though...
>
> (I think this below is right, but it is complicated as can be so maybe I
> am wrong in places.)
>
> The ath10k wave-2 firmware has its own scheduler. It asks the driver
> what peers need to transmit, then it requests buffers for those peers
> (based on its own idea of fairness and scheduling). If the driver
> tells it all want to tx frames, it will queue lots and you are at the
> mercy of its scheduler. But, if the driver tells firmware only a few
> peers want to transmit, then the driver (and upper stacks) will have a
> lot more control over the firmware's queueing and scheduling.

Yeah, that's basically what we're trying to do in the airtime fairness
scheduler (see ieee80211_txq_may_transmit()).

-Toke
