Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025FD1BDF9E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD2Ny3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 09:54:29 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:44824 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgD2Ny3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 09:54:29 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 831F213C283;
        Wed, 29 Apr 2020 06:54:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 831F213C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588168468;
        bh=PrYT77XzJ0Ndlpde8Mp6TDObGBodkfNUrTbakKaAeiA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jTyd3n2kbSNNZ4HjvavqByJKrqfOWKDvasFUNY3aoFxj0cM72p9+ucg2dbHFF/zAx
         Qmy/fyP7iH7S4g1nfSycEyA3q2d31t2UNLxq/ts4XD4q/wpnbkGQDOd4o8l9QBgTAA
         YJLL9Te/MuPAMgWxu6vfBvc0o1PzVOmVsPumAO5s=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
 <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
 <87a72vuyyn.fsf@toke.dk>
 <e6ee8635-b45f-c5fe-d32a-1d695b3a7934@candelatech.com>
 <87sggmtzdg.fsf@toke.dk>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <31064453-15b4-877f-b70c-b6b9ed4ae50c@candelatech.com>
Date:   Wed, 29 Apr 2020 06:54:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <87sggmtzdg.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 04/29/2020 02:28 AM, Toke Høiland-Jørgensen wrote:
> Ben Greear <greearb@candelatech.com> writes:
>
>> On 04/28/2020 01:39 PM, Toke Høiland-Jørgensen wrote:
>>> Ben Greear <greearb@candelatech.com> writes:
>>>
>>>> On 04/28/2020 12:37 PM, Toke Høiland-Jørgensen wrote:
>>>>> greearb@candelatech.com writes:
>>>>>
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
>>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>>>
>>>>>>  	u8 target_version_major;
>>>>>>  	u8 target_version_minor;
>>>>>> +	bool needs_unlock;
>>>>>>  	struct completion target_version_received;
>>>>>>  	u8 max_num_amsdu;
>>>>>>  	u8 max_num_ampdu;
>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>>>>  	lockdep_assert_held(&htt->tx_lock);
>>>>>>
>>>>>>  	htt->num_pending_tx--;
>>>>>> -	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>>>>> +	if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
>>>>>
>>>>> Why /4? Seems a bit arbitrary?
>>>>
>>>> Yes, arbitrary for sure. I figure restart filling the queue when 1/4
>>>> full so that it is unlikely to run dry. Possibly it should restart
>>>> sooner to keep it more full on average?
>>>
>>> Theoretically, the "keep the queue at the lowest possible level that
>>> keeps it from underflowing" is what BQL is supposed to do. The diff
>>> below uses the dynamic adjustment bit (from dynamic_queue_limits.h) in
>>> place of num_pending_tx. I've only compile tested it, and I'm a bit
>>> skeptical that it will work right for this, but if anyone wants to give
>>> it a shot, there it is.
>>>
>>> BTW, while doing that, I noticed there's a similar arbitrary limit in
>>> ath10k_mac_tx_push_pending() at max_num_pending_tx/2. So if you're going
>>> to keep the arbitrary limit maybe use the same one? :)
>>>
>>>> Before my patch, the behaviour would be to try to keep it as full as
>>>> possible, as in restart the queues as soon as a single slot opens up
>>>> in the tx queue.
>>>
>>> Yeah, that seems somewhat misguided as well, from a latency perspective,
>>> at least. But I guess that's what we're fixing with AQL. What does the
>>> firmware do with the frames queued within? Do they just go on a FIFO
>>> queue altogether, or something smarter?
>>
>> Sort of like a mini-mac80211 stack inside the firmware is used to
>> create ampdu/amsdu chains and schedule them with its own scheduler.
>>
>> For optimal throughput with 200 users steaming video,
>> the ath10k driver should think that it has only a few active peers wanting
>> to send data at a time (and so firmware would think the same), and the driver should
>> be fed a large chunk of pkts for those peers.  And then the next few peers.
>> That should let firmware send large ampdu/amsdu to each peer, increasing throughput
>> over all.
>
> Yes, but also increasing latency because all other stations have to wait
> for a longer TXOP (see my other reply).

If you at most sent 4 station's worth of data to the firmware, and max is 4ms per
txop, then you have at most 16ms of latency.  You could also send just two station's
worth of data at a time, as long as you can quickly service the tx-queues again
that should be enough to keep the firmware/radio productive.

In the case where you have many users wanting lots of throughput, 8 or 16ms of extra
latency is a good tradeoff vs no one being able to reliably get the bandwidth they
need.

Higher priority TIDs will get precedence in ath10k firmware anyway, so even if at time 0
you sent 64 frames to a peer on back-ground TID, if you sent a VO frame at time 0+1,
it could be transmitted first.

>
>> If you feed a few frames to each of the 200 peers, then even if
>> firmware has 2000 tx buffers, that is only 10 frames per peer at best,
>> leading to small ampdu/amsdu and thus worse over-all throughput and
>> utilization of airtime.
>
> Do you have any data on exactly how long (in time) each txop becomes in
> these highly congested scenarios?

I didn't look at time, but avg packets-per-ampdu chain is 30+ in single station tests,
and with many stations it goes into the 4-8 range (from memory, so maybe I'm
off a bit).

Here is an open-source tool that can give you those metrics by processing a pcap:

https://github.com/greearb/lanforge-scripts/tree/master/wifi_diag

# Ignore the LANforge bits about creating capture files, here is an example of how to use it:
https://www.candelatech.com/cookbook/wifire/wifi+diagnostic


>
>> It would be nice to be able to set certain traffic flows to have the
>> throughput optimization and others to have the latency optimization.
>> For instance, high latency on a streaming download is a good trade-off
>> if it increases total throughput.
>
> For the individual flows to a peer, fq_codel actually does a pretty good
> job at putting the latency-sensitive flows first. Which is why we want
> the queueing to happen in mac80211 (where fq_codel is active) instead of
> in the firmware.

That sounds good to me.  What is needed from the driver/firmware to make
this work well?

>> Maybe some of the AI folks training their AI to categorize cat
>> pictures could instead start categorizing traffic flows and adjusting
>> the stack realtime...
>
> I know there are people trying to classify traffic with machine learning
> (although usually for more nefarious purposes), but I'm not sure it's
> feasible to do in a queue management algorithm (if at all). :)

If you give an API (maybe using 'tc'?) that user-space can twiddle, then anyone
doing clever things can do it at higher levels.  It could easily be that multiple
APs would gain benefit from being coordinated together for instance, and no local
queueing logic would be able to coordinate that by itself.

Thanks,
Ben

>
> -Toke
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
