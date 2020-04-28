Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255991BCC92
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgD1ToQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 15:44:16 -0400
Received: from mail.toke.dk ([45.145.95.4]:58353 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgD1ToP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 15:44:15 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 15:44:14 EDT
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1588102621; bh=Mn4I6ePw/xBdzyLJuFb2yiAOfSq3tEEz1ur0xTDFEwo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S8IwdpHTpMIb2jw3dc6S+5s5EfCY+JE9kahoPfz0aM7Wy3CexkaC6IJc+1ORIDEMT
         agxVWxX9ICnz0cA9759zelMYVK4JTZfEzym93SIaQbuzNtgXqJjagdlLjYS8QbOSxO
         jMcLNu05VhBScw4y2lEptySBJh3CVqLf+CkilYOTDJGGUTPVUnGo23+0AmNEXL+I+C
         5epocI0jiB4TWra5s5Q/VqGgMJzpvmNI/igv0/juX3JhpIaHAbp0gVKUhAuTwBKxTu
         kBQcV/lgjjYflLy5+BVcXYGDas+HgCX0rlnkZLU2ouRwKSQJSJ+dxSseO6NpyAkNd7
         8zvGelckinlVA==
To:     Ben Greear <greearb@candelatech.com>,
        Steve deRosier <derosier@gmail.com>, dave.taht@gmail.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
In-Reply-To: <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com>
References: <20200427145435.13151-1-greearb@candelatech.com> <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com> <1e1664b6-1998-5a4b-67ba-09113ec8d3a7@candelatech.com>
Date:   Tue, 28 Apr 2020 21:36:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87k11zv1ux.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 04/28/2020 07:56 AM, Steve deRosier wrote:
>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>>>
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> While running tcp upload + download tests with ~200
>>> concurrent TCP streams, 1-2 processes, and 30 station
>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>> around 20% of the CPU according to perf-top, which other locking
>>> taking an additional ~15%.
>>>
>>> I believe the issue is that the ath10k driver would unlock the
>>> txqueue when a single frame could be transmitted, instead of
>>> waiting for a low water mark.
>>>
>>> So, this patch adds a low-water mark that is 1/4 of the total
>>> tx buffers allowed.
>>>
>>> This appears to resolve the performance problem that I saw.
>>>
>>> Tested with recent wave-1 ath10k-ct firmware.
>>>
>>
>> Hey Ben,
>>
>> Did you do any testing with this patch around latency?  The nature of
>> the thing that you fixed makes me wonder if it was intentional with
>> respect to making WiFi fast - ie getting rid of buffers as much as
>> possible.  Obviously the CPU impact is likely to be an unintended
>> consequence. In any case, I don't know anything for sure, it was just
>> a thought that went through my head when reading this.
>
> I did not, but on average my patch should make the queues be less full,
> so I doubt it will hurt latency.

I would tend to agree with that.

-Toke

>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> ---
>>>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>
>>>         u8 target_version_major;
>>>         u8 target_version_minor;
>>> +       bool needs_unlock;
>>>         struct completion target_version_received;
>>>         u8 max_num_amsdu;
>>>         u8 max_num_ampdu;
>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>         lockdep_assert_held(&htt->tx_lock);
>>>
>>>         htt->num_pending_tx--;
>>> -       if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>> +       if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
>>> +               htt->needs_unlock = false;
>>>                 ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>> +       }
>>>  }
>>>
>>>  int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>>> @@ -157,8 +159,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>>>                 return -EBUSY;
>>>
>>>         htt->num_pending_tx++;
>>> -       if (htt->num_pending_tx == htt->max_num_pending_tx)
>>> +       if (htt->num_pending_tx == htt->max_num_pending_tx) {
>>> +               htt->needs_unlock = true;
>>>                 ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>> +       }
>>>
>>>         return 0;
>>>  }
>>> --
>>> 2.20.1
>>>
>>
>
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
