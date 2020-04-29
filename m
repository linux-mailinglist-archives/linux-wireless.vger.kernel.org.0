Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2EA1BD83B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgD2J2U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 05:28:20 -0400
Received: from mail.toke.dk ([45.145.95.4]:40101 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2J2U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 05:28:20 -0400
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1588152497; bh=jFTuPTft5YhcY0LVcqI1C+/Jlqg+JaQXjcbFTVf/uT8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=XncTpNFlmQ/fIZgH7/9vqBUVj38YrjdUKWbgElVZxYYObzrTaCr1tmL1XLuegAZSo
         t4g9Ew4G6bNydypz1KaAKSBLX0GHYeEcsYXHtVb7O1hm2BUBVB50npD+SdXP1rbROz
         8ejTKx38ax10r6ZAVHWpHWpCwvvQuXlYHlPwl3XzxncdRzf1GqYAejtACE4Coti2dc
         WuyZNsSF9rei8WvnZE4xlKpKNTyc4qSRz1oMEUwIR7qotT+zrA4+bHgHmIwZg7UCjV
         UXhEjoW0IT6w8ZJCzTYV74XiatuOWE5tC4UWmaWEjgTfIDc89hLIbYWq9oYq8qXrw5
         6SHWudTcUyjsg==
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
In-Reply-To: <e6ee8635-b45f-c5fe-d32a-1d695b3a7934@candelatech.com>
References: <20200427145435.13151-1-greearb@candelatech.com> <87h7x3v1tn.fsf@toke.dk> <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com> <87a72vuyyn.fsf@toke.dk> <e6ee8635-b45f-c5fe-d32a-1d695b3a7934@candelatech.com>
Date:   Wed, 29 Apr 2020 11:28:11 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sggmtzdg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 04/28/2020 01:39 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Ben Greear <greearb@candelatech.com> writes:
>>
>>> On 04/28/2020 12:37 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> greearb@candelatech.com writes:
>>>>
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
>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>> ---
>>>>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wire=
less/ath/ath10k/htt.h
>>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>>
>>>>>  	u8 target_version_major;
>>>>>  	u8 target_version_minor;
>>>>> +	bool needs_unlock;
>>>>>  	struct completion target_version_received;
>>>>>  	u8 max_num_amsdu;
>>>>>  	u8 max_num_ampdu;
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/w=
ireless/ath/ath10k/htt_tx.c
>>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt=
 *htt)
>>>>>  	lockdep_assert_held(&htt->tx_lock);
>>>>>
>>>>>  	htt->num_pending_tx--;
>>>>> -	if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx - 1)
>>>>> +	if ((htt->num_pending_tx <=3D (htt->max_num_pending_tx / 4)) && htt=
->needs_unlock) {
>>>>
>>>> Why /4? Seems a bit arbitrary?
>>>
>>> Yes, arbitrary for sure. I figure restart filling the queue when 1/4
>>> full so that it is unlikely to run dry. Possibly it should restart
>>> sooner to keep it more full on average?
>>
>> Theoretically, the "keep the queue at the lowest possible level that
>> keeps it from underflowing" is what BQL is supposed to do. The diff
>> below uses the dynamic adjustment bit (from dynamic_queue_limits.h) in
>> place of num_pending_tx. I've only compile tested it, and I'm a bit
>> skeptical that it will work right for this, but if anyone wants to give
>> it a shot, there it is.
>>
>> BTW, while doing that, I noticed there's a similar arbitrary limit in
>> ath10k_mac_tx_push_pending() at max_num_pending_tx/2. So if you're going
>> to keep the arbitrary limit maybe use the same one? :)
>>
>>> Before my patch, the behaviour would be to try to keep it as full as
>>> possible, as in restart the queues as soon as a single slot opens up
>>> in the tx queue.
>>
>> Yeah, that seems somewhat misguided as well, from a latency perspective,
>> at least. But I guess that's what we're fixing with AQL. What does the
>> firmware do with the frames queued within? Do they just go on a FIFO
>> queue altogether, or something smarter?
>
> Sort of like a mini-mac80211 stack inside the firmware is used to
> create ampdu/amsdu chains and schedule them with its own scheduler.
>
> For optimal throughput with 200 users steaming video,
> the ath10k driver should think that it has only a few active peers wanting
> to send data at a time (and so firmware would think the same), and the dr=
iver should
> be fed a large chunk of pkts for those peers.  And then the next few peer=
s.
> That should let firmware send large ampdu/amsdu to each peer, increasing =
throughput
> over all.

Yes, but also increasing latency because all other stations have to wait
for a longer TXOP (see my other reply).

> If you feed a few frames to each of the 200 peers, then even if
> firmware has 2000 tx buffers, that is only 10 frames per peer at best,
> leading to small ampdu/amsdu and thus worse over-all throughput and
> utilization of airtime.

Do you have any data on exactly how long (in time) each txop becomes in
these highly congested scenarios?

> It would be nice to be able to set certain traffic flows to have the
> throughput optimization and others to have the latency optimization.
> For instance, high latency on a streaming download is a good trade-off
> if it increases total throughput.

For the individual flows to a peer, fq_codel actually does a pretty good
job at putting the latency-sensitive flows first. Which is why we want
the queueing to happen in mac80211 (where fq_codel is active) instead of
in the firmware.

> Maybe some of the AI folks training their AI to categorize cat
> pictures could instead start categorizing traffic flows and adjusting
> the stack realtime...

I know there are people trying to classify traffic with machine learning
(although usually for more nefarious purposes), but I'm not sure it's
feasible to do in a queue management algorithm (if at all). :)

-Toke
