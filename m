Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4932A1C2361
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 07:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEBFtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbgEBFtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 01:49:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E15C061A0C
        for <linux-wireless@vger.kernel.org>; Fri,  1 May 2020 22:49:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so935212pju.2
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2020 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jC+bT4ynzF5BOOQPlmyHCBj1pLebeRYphXDTzcbeqfc=;
        b=dCKORbpTl31tIWAyBOG8vCzHVtny94m2TQopi65NMAh1OIpSHF7dZJ8mjbRxXzW/i6
         8PXtksIe5dKth0k5L9ZukAiffE32sL2pw3w8j62bS/XJoIlVdjddiwjlLdAWFEFZTN6o
         SGAXetDSPIAVhOf0kQN1DA46weW0m9TMwR9g8ah6GFDXMx9LMHU8t875/QIpXiu71pIa
         sCsC+nsqRIWS0YQ81iQ1ZYmYkee0pRHgGYucNDLPzn+Xq8/HOa7QmkkzUyS8g8Nl1KzK
         oe2RHCamyDg7bcyYfpt2AP6JSAIwpvstkDJei4q/jMoPcSex9kXxWw7lMhfpIwrUqxPR
         jwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jC+bT4ynzF5BOOQPlmyHCBj1pLebeRYphXDTzcbeqfc=;
        b=lvu+faNmDW3+dFIOM5kwT0I7IZ/eCndV2YPYBRqogf2Ea21j7hdQ6N7PVq0Rr+lFHi
         iemLS6rjGnkEHw28VTpeGCXn/wIRKUTuZbwxwt5CCz8PyeP8jEC/y55dj5UCDzCFICfV
         U2NaP5jM0+543cJOEHsGuLaT/Saaf1LISmveYgai9o8SBn0NaVhPegDvC/f/ZkS9zcYv
         1Ie6oi8mZUBRed4x1fyRrXHUzrIZaxWxcvOMi+v6CZBuo0BUHGJnTR3NeCULMXQAYsgS
         WB7juVQWWpMXGcdfEsXxQ3DNhOXh3hP1L6Qok2mkHYjyjYN3uh/HbNHQAYssk5jeXI3z
         cfhg==
X-Gm-Message-State: AGi0PubB3/2BBCh2VECVGgCFuQN3Ywue4FB3yzFsVCBzRE9PDvWpAkBD
        YOdYzuuHG+2JTuFUjaEJ9r9x1MQ0
X-Google-Smtp-Source: APiQypI5wuRpkFfhBcuUebsWHwzaPq7SXVDmcGj5Dv2kuHgUD6UX6UTLXPchM2H6EEfO5NU2TlPaKA==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr8110869plz.10.1588398590225;
        Fri, 01 May 2020 22:49:50 -0700 (PDT)
Received: from [10.211.55.7] ([112.209.124.182])
        by smtp.gmail.com with ESMTPSA id p7sm3284845pgg.91.2020.05.01.22.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 22:49:49 -0700 (PDT)
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Mark Baker <mark@e-bakers.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
 <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
 <87a72vuyyn.fsf@toke.dk> <e49a3413-5d5e-cef7-bd31-c3a124a3bb86@gmail.com>
 <1108576c-3bf1-fde0-8266-f8e4c4a477bf@candelatech.com>
 <61bd26ed-93cb-01d9-6912-cc683d09560a@gmail.com>
 <D8BAA006-A2CD-410D-8B37-08FF28A28B04@e-bakers.com>
From:   John Deere <24601deerej@gmail.com>
Message-ID: <11e39934-c28b-44ea-ad4e-69ff6471d177@gmail.com>
Date:   Sat, 2 May 2020 13:49:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <D8BAA006-A2CD-410D-8B37-08FF28A28B04@e-bakers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/2/20 1:51 AM, Mark Baker wrote:
> I have been using Toke’s patch successfully with my Netgear R7800 (QCA9884) running OpenWRT snapshot build with ath10k-ct firmware and ath10k-ct-smallbuffers driver. I am using my R7800 as an AP only, so I am running a very stripped down build of OpenWRT.

Interesting to hear that it works for you. To narrow it down on whether 
it is due to CT-FW & Driver vs the device being Wave 2, is it possible 
for you to test a builed with ath10k non-CT driver and FW?

> 
> I provided several Flent tests to Dave Taht and Toke showing some pretty significant improvements in latency. I did not capture any CPU/sirq stats on my R7800 during these tests, though. It does appear my maximum download bandwidth has decreased somewhat, but I am more than happy to take that hit for the benefit of significantly lower latency.
> 
>> On May 1, 2020, at 11:50 AM, John Deere <24601deerej@gmail.com> wrote:
>>
>>
>>
>> On 5/1/20 10:16 AM, Ben Greear wrote:
>>> On 04/30/2020 04:31 PM, John Deere wrote:
>>>> I've just tried Toke's DQL on an Archer C7 (QCA 988X) and it errors out with:
>>>>
>>>> ath10k_pci  failed to increase tx pending count: -16, dropping
>>>>
>>>> This is with ath10k non-ct firmware and driver on OpenWrt (w/backports 5.4.27 & AQL). ath10k starts up but is unable to let any stations connect.
>>>>
>>>> I've also tried the standalone patch by Ben and it seems to have reduced the latencies on top of AQL by another 5 ms.
>>> Hello,
>>> Did you notice any throughput changes or system load changes in the test that you did with my patch?

Hi Ben,

I've ran some basic throughput tests with iperf and it seems that there 
was also slight hit in throughput, but only by 5-20 mbps or so.


>>> Thanks,
>>> Ben
>>
>> I have noticed that there has been a reduction in system load and memory use. Whereas previously with 11 clients on one Archer C7 acting as an AP only, my free memory available would be 51%, it now shows 55-56% - a 4% to 5% reduction. Note, these results were obtained alongside with reverting the following comit https://github.com/openwrt/openwrt/commit/1e27befe63ff4c69f110c7310316f4af75ee63e9. I believe that this same set of patches also are currently in use for the ath10k-ct smallbuffers variant on OpenWrt.
>>
>> I have not had the time to conduct any meaningful throughput measurements.
>>
>>>>
>>>> On 4/29/20 4:39 AM, Toke Høiland-Jørgensen wrote:
>>>>> Ben Greear <greearb@candelatech.com> writes:
>>>>>
>>>>>> On 04/28/2020 12:37 PM, Toke Høiland-Jørgensen wrote:
>>>>>>> greearb@candelatech.com writes:
>>>>>>>
>>>>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>>>>
>>>>>>>> While running tcp upload + download tests with ~200
>>>>>>>> concurrent TCP streams, 1-2 processes, and 30 station
>>>>>>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>>>>>>> around 20% of the CPU according to perf-top, which other locking
>>>>>>>> taking an additional ~15%.
>>>>>>>>
>>>>>>>> I believe the issue is that the ath10k driver would unlock the
>>>>>>>> txqueue when a single frame could be transmitted, instead of
>>>>>>>> waiting for a low water mark.
>>>>>>>>
>>>>>>>> So, this patch adds a low-water mark that is 1/4 of the total
>>>>>>>> tx buffers allowed.
>>>>>>>>
>>>>>>>> This appears to resolve the performance problem that I saw.
>>>>>>>>
>>>>>>>> Tested with recent wave-1 ath10k-ct firmware.
>>>>>>>>
>>>>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>>>>> ---
>>>>>>>>    drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>>>>>    drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>>>>>    2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>>>>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>>>>>
>>>>>>>>        u8 target_version_major;
>>>>>>>>        u8 target_version_minor;
>>>>>>>> +    bool needs_unlock;
>>>>>>>>        struct completion target_version_received;
>>>>>>>>        u8 max_num_amsdu;
>>>>>>>>        u8 max_num_ampdu;
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>>>>>>        lockdep_assert_held(&htt->tx_lock);
>>>>>>>>
>>>>>>>>        htt->num_pending_tx--;
>>>>>>>> -    if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>>>>>>> +    if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
>>>>>>>
>>>>>>> Why /4? Seems a bit arbitrary?
>>>>>>
>>>>>> Yes, arbitrary for sure. I figure restart filling the queue when 1/4
>>>>>> full so that it is unlikely to run dry. Possibly it should restart
>>>>>> sooner to keep it more full on average?
>>>>>
>>>>> Theoretically, the "keep the queue at the lowest possible level that
>>>>> keeps it from underflowing" is what BQL is supposed to do. The diff
>>>>> below uses the dynamic adjustment bit (from dynamic_queue_limits.h) in
>>>>> place of num_pending_tx. I've only compile tested it, and I'm a bit
>>>>> skeptical that it will work right for this, but if anyone wants to give
>>>>> it a shot, there it is.
>>>>>
>>>>> BTW, while doing that, I noticed there's a similar arbitrary limit in
>>>>> ath10k_mac_tx_push_pending() at max_num_pending_tx/2. So if you're going
>>>>> to keep the arbitrary limit maybe use the same one? :)
>>>>>
>>>>>> Before my patch, the behaviour would be to try to keep it as full as
>>>>>> possible, as in restart the queues as soon as a single slot opens up
>>>>>> in the tx queue.
>>>>>
>>>>> Yeah, that seems somewhat misguided as well, from a latency perspective,
>>>>> at least. But I guess that's what we're fixing with AQL. What does the
>>>>> firmware do with the frames queued within? Do they just go on a FIFO
>>>>> queue altogether, or something smarter?
>>>>>
>>>>> -Toke
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
>>>>> index f26cc6989dad..72771ff38a94 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/core.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>>>>> @@ -2497,6 +2497,10 @@ static int ath10k_core_init_firmware_features(struct ath10k *ar)
>>>>>            return -EINVAL;
>>>>>        }
>>>>>    +    dql_init(&ar->htt.dql, HZ);
>>>>> +    ar->htt.dql.max_limit = ar->htt.max_num_pending_tx;
>>>>> +    ar->htt.dql.min_limit = 8;
>>>>> +
>>>>>        if (ar->hw_params.num_peers)
>>>>>            ar->max_num_peers = ar->hw_params.num_peers;
>>>>>        else
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>>>> index 4a12564fc30e..19024d063896 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>> @@ -13,6 +13,7 @@
>>>>>    #include <linux/dmapool.h>
>>>>>    #include <linux/hashtable.h>
>>>>>    #include <linux/kfifo.h>
>>>>> +#include <linux/dynamic_queue_limits.h>
>>>>>    #include <net/mac80211.h>
>>>>>      #include "htc.h"
>>>>> @@ -1965,8 +1966,8 @@ struct ath10k_htt {
>>>>>        /* Protects access to pending_tx, num_pending_tx */
>>>>>        spinlock_t tx_lock;
>>>>>        int max_num_pending_tx;
>>>>> -    int num_pending_tx;
>>>>>        int num_pending_mgmt_tx;
>>>>> +    struct dql dql;
>>>>>        struct idr pending_tx;
>>>>>        wait_queue_head_t empty_tx_wq;
>>>>>    diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> index e9d12ea708b6..911a79470bdf 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> @@ -144,8 +144,8 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>>>    {
>>>>>        lockdep_assert_held(&htt->tx_lock);
>>>>>    -    htt->num_pending_tx--;
>>>>> -    if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>>>> +    dql_completed(&htt->dql, 1);
>>>>> +    if (dql_avail(&htt->dql) > 0)
>>>>>            ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>>>>    }
>>>>>    @@ -153,11 +153,11 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>>>>>    {
>>>>>        lockdep_assert_held(&htt->tx_lock);
>>>>>    -    if (htt->num_pending_tx >= htt->max_num_pending_tx)
>>>>> +    if (dql_avail(&htt->dql) <= 0)
>>>>>            return -EBUSY;
>>>>>    -    htt->num_pending_tx++;
>>>>> -    if (htt->num_pending_tx == htt->max_num_pending_tx)
>>>>> +    dql_queued(&htt->dql, 1);
>>>>> +    if (dql_avail(&htt->dql) <= 0)
>>>>>            ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>>>>          return 0;
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>>>>> index 2d03b8dd3b8c..1fe251742b0a 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>>> @@ -3998,7 +3998,7 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
>>>>>        if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
>>>>>            return true;
>>>>>    -    if (ar->htt.num_pending_tx < ar->htt.tx_q_state.num_push_allowed)
>>>>> +    if (dql_avail(&ar->htt.dql) < ar->htt.tx_q_state.num_push_allowed)
>>>>>            return true;
>>>>>          if (artxq->num_fw_queued < artxq->num_push_allowed)
>>>>> @@ -4159,7 +4159,7 @@ void ath10k_mac_tx_push_pending(struct ath10k *ar)
>>>>>        if (ar->htt.tx_q_state.mode != HTT_TX_MODE_SWITCH_PUSH)
>>>>>            return;
>>>>>    -    if (ar->htt.num_pending_tx >= (ar->htt.max_num_pending_tx / 2))
>>>>> +    if (dql_avail(&ar->htt.dql) < (ar->htt.dql.limit / 2))
>>>>>            return;
>>>>>          rcu_read_lock();
>>>>> @@ -7160,7 +7160,7 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
>>>>>                bool empty;
>>>>>                  spin_lock_bh(&ar->htt.tx_lock);
>>>>> -            empty = (ar->htt.num_pending_tx == 0);
>>>>> +            empty = (ar->htt.dql.num_completed == ar->htt.dql.num_queued);
>>>>>                spin_unlock_bh(&ar->htt.tx_lock);
>>>>>                  skip = (ar->state == ATH10K_STATE_WEDGED) ||
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
>>>>> index 39abf8b12903..fe7cd53c2bf9 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>>>>> @@ -80,7 +80,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>>>>          ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
>>>>>        ath10k_htt_tx_dec_pending(htt);
>>>>> -    if (htt->num_pending_tx == 0)
>>>>> +    if (htt->dql.num_completed == htt->dql.num_queued)
>>>>>            wake_up(&htt->empty_tx_wq);
>>>>>        spin_unlock_bh(&htt->tx_lock);
>>>>>
>>>>
> 
