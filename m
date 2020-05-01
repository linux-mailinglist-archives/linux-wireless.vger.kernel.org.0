Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD51C0C0F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 04:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEACQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 22:16:52 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:54170 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgEACQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 22:16:52 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CB8B413C2B0;
        Thu, 30 Apr 2020 19:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CB8B413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588299411;
        bh=ZxBeV4DjC5hlsfiNANjBKhAfv4kNyycACWVVoHr5f9I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HtM4vAGbEv33rdV2lWDJ2R1sr/WnqJzURCv1HSG533R+dseUhikM2a0o/ilJBat3g
         Pzp0MgGyKHG8Pysy9Ffhki82Q4Q4m/v1oqvsaxYG/MMHCLCjVyvzaTbgae78ZNisx9
         zvw03lohaDsV/tAGmTohxLXA2wVUNLWqpDTgdMBw=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     John Deere <24601deerej@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?= =?UTF-8?Q?gensen?= 
        <toke@toke.dk>, linux-wireless@vger.kernel.org
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
 <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
 <87a72vuyyn.fsf@toke.dk> <e49a3413-5d5e-cef7-bd31-c3a124a3bb86@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <1108576c-3bf1-fde0-8266-f8e4c4a477bf@candelatech.com>
Date:   Thu, 30 Apr 2020 19:16:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <e49a3413-5d5e-cef7-bd31-c3a124a3bb86@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 04/30/2020 04:31 PM, John Deere wrote:
> I've just tried Toke's DQL on an Archer C7 (QCA 988X) and it errors out with:
>
> ath10k_pci  failed to increase tx pending count: -16, dropping
>
> This is with ath10k non-ct firmware and driver on OpenWrt (w/backports 5.4.27 & AQL). ath10k starts up but is unable to let any stations connect.
>
> I've also tried the standalone patch by Ben and it seems to have reduced the latencies on top of AQL by another 5 ms.

Hello,

Did you notice any throughput changes or system load changes in the test that you did with my patch?

Thanks,
Ben

>
> On 4/29/20 4:39 AM, Toke Høiland-Jørgensen wrote:
>> Ben Greear <greearb@candelatech.com> writes:
>>
>>> On 04/28/2020 12:37 PM, Toke Høiland-Jørgensen wrote:
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
>>>>>   drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>>   drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>>
>>>>>       u8 target_version_major;
>>>>>       u8 target_version_minor;
>>>>> +    bool needs_unlock;
>>>>>       struct completion target_version_received;
>>>>>       u8 max_num_amsdu;
>>>>>       u8 max_num_ampdu;
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>>>       lockdep_assert_held(&htt->tx_lock);
>>>>>
>>>>>       htt->num_pending_tx--;
>>>>> -    if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>>>> +    if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
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
>>
>> -Toke
>>
>>
>>
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
>> index f26cc6989dad..72771ff38a94 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -2497,6 +2497,10 @@ static int ath10k_core_init_firmware_features(struct ath10k *ar)
>>           return -EINVAL;
>>       }
>>   +    dql_init(&ar->htt.dql, HZ);
>> +    ar->htt.dql.max_limit = ar->htt.max_num_pending_tx;
>> +    ar->htt.dql.min_limit = 8;
>> +
>>       if (ar->hw_params.num_peers)
>>           ar->max_num_peers = ar->hw_params.num_peers;
>>       else
>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>> index 4a12564fc30e..19024d063896 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>> @@ -13,6 +13,7 @@
>>   #include <linux/dmapool.h>
>>   #include <linux/hashtable.h>
>>   #include <linux/kfifo.h>
>> +#include <linux/dynamic_queue_limits.h>
>>   #include <net/mac80211.h>
>>     #include "htc.h"
>> @@ -1965,8 +1966,8 @@ struct ath10k_htt {
>>       /* Protects access to pending_tx, num_pending_tx */
>>       spinlock_t tx_lock;
>>       int max_num_pending_tx;
>> -    int num_pending_tx;
>>       int num_pending_mgmt_tx;
>> +    struct dql dql;
>>       struct idr pending_tx;
>>       wait_queue_head_t empty_tx_wq;
>>   diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> index e9d12ea708b6..911a79470bdf 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> @@ -144,8 +144,8 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>   {
>>       lockdep_assert_held(&htt->tx_lock);
>>   -    htt->num_pending_tx--;
>> -    if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>> +    dql_completed(&htt->dql, 1);
>> +    if (dql_avail(&htt->dql) > 0)
>>           ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>   }
>>   @@ -153,11 +153,11 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>>   {
>>       lockdep_assert_held(&htt->tx_lock);
>>   -    if (htt->num_pending_tx >= htt->max_num_pending_tx)
>> +    if (dql_avail(&htt->dql) <= 0)
>>           return -EBUSY;
>>   -    htt->num_pending_tx++;
>> -    if (htt->num_pending_tx == htt->max_num_pending_tx)
>> +    dql_queued(&htt->dql, 1);
>> +    if (dql_avail(&htt->dql) <= 0)
>>           ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>>         return 0;
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>> index 2d03b8dd3b8c..1fe251742b0a 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -3998,7 +3998,7 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
>>       if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
>>           return true;
>>   -    if (ar->htt.num_pending_tx < ar->htt.tx_q_state.num_push_allowed)
>> +    if (dql_avail(&ar->htt.dql) < ar->htt.tx_q_state.num_push_allowed)
>>           return true;
>>         if (artxq->num_fw_queued < artxq->num_push_allowed)
>> @@ -4159,7 +4159,7 @@ void ath10k_mac_tx_push_pending(struct ath10k *ar)
>>       if (ar->htt.tx_q_state.mode != HTT_TX_MODE_SWITCH_PUSH)
>>           return;
>>   -    if (ar->htt.num_pending_tx >= (ar->htt.max_num_pending_tx / 2))
>> +    if (dql_avail(&ar->htt.dql) < (ar->htt.dql.limit / 2))
>>           return;
>>         rcu_read_lock();
>> @@ -7160,7 +7160,7 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
>>               bool empty;
>>                 spin_lock_bh(&ar->htt.tx_lock);
>> -            empty = (ar->htt.num_pending_tx == 0);
>> +            empty = (ar->htt.dql.num_completed == ar->htt.dql.num_queued);
>>               spin_unlock_bh(&ar->htt.tx_lock);
>>                 skip = (ar->state == ATH10K_STATE_WEDGED) ||
>> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
>> index 39abf8b12903..fe7cd53c2bf9 100644
>> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>> @@ -80,7 +80,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>         ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
>>       ath10k_htt_tx_dec_pending(htt);
>> -    if (htt->num_pending_tx == 0)
>> +    if (htt->dql.num_completed == htt->dql.num_queued)
>>           wake_up(&htt->empty_tx_wq);
>>       spin_unlock_bh(&htt->tx_lock);
>>
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
