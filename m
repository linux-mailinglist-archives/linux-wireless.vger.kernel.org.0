Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D252C1C0AFD
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 01:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD3XcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 19:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgD3XcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 19:32:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042AC035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 16:32:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l25so1378040pgc.5
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HLd1Vd2YnJnnPb0nB/WI168Sfm2IChW8obsG6ZcNy4o=;
        b=NkeMRlJv6y2pyXqgiCgDCje5crX499fK0K2iO71Px6VroBKUZ/v0Xi951DpsuwvqnP
         Sh5FJrQB8AT/4b1gfNXqguon7ScuuvfZilrXf4v6urcb+GXhpxpt1+r9ujaEoBQVH6gf
         R1BFPRKyT1iQVoNguaJrUFrJYvXXPvK+1HQry576+UXZL+WNVphihJfVW7guw4eIN1Ly
         9LFHqD5J0qHeBoTGEvVRbv1J2N9mw8dDBc7kYRd4NP0IzHMV4VAbK4Tezp8beVcwg241
         NVuEfdwgGGGtFGXj0iioDt4V6W5y0MBHo4HvBWXdvdldlUoRclnSaPQWbt5frwzHN6Oi
         F+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLd1Vd2YnJnnPb0nB/WI168Sfm2IChW8obsG6ZcNy4o=;
        b=LNksnnDiuhKkKPksUd5pQaj9YZsfOs66unLUlhQ/g9r5j/snJzeXv0h9xE3YHqvZxh
         +kfjCUrW+Vhl7e1+/IxR1cty+t55cyRNawEsUAd0Int+AnGwNBPiPcB/UJFEMzGs9pou
         Zv45v7iTYp2fvpTdP5jtitXuAyQ1K2W1yhq2i+vJzrwK6zjJ4zuCQLPM1K/U7N15dMxW
         tl2IWeXHwolfHU/spaful3EEauHCVgUuc6BKG4rR7yGwLkvpUfK6sr5tEHOKxgu1lHaA
         IDSB/lbWzj+jdB/izDUir+JcXdfiTRoaluBA5g50L4RDexDvXjQttO1eTF7/lAJLdq+4
         paDQ==
X-Gm-Message-State: AGi0PubZ1Bjg4ruN3Diu+mJ7YTPwkAgmD/mOvoHXUoQ80SomuUdFHokW
        lBAlmvrbUUWjLpuuFUb7jtAADXtFTag=
X-Google-Smtp-Source: APiQypIh4PqZeDJv+kMX3FOk4+8ua+UPHjFyW/10iJJfxpBJVGS5H2Wru0hSssuAHhJ7atgYUBpyFQ==
X-Received: by 2002:a63:1d11:: with SMTP id d17mr1421040pgd.437.1588289521565;
        Thu, 30 Apr 2020 16:32:01 -0700 (PDT)
Received: from [10.211.55.7] ([112.209.206.99])
        by smtp.gmail.com with ESMTPSA id w69sm705396pff.168.2020.04.30.16.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 16:32:01 -0700 (PDT)
Subject: Re: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
 <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
 <87a72vuyyn.fsf@toke.dk>
From:   John Deere <24601deerej@gmail.com>
Message-ID: <e49a3413-5d5e-cef7-bd31-c3a124a3bb86@gmail.com>
Date:   Fri, 1 May 2020 07:31:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a72vuyyn.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've just tried Toke's DQL on an Archer C7 (QCA 988X) and it errors out 
with:

ath10k_pci  failed to increase tx pending count: -16, dropping

This is with ath10k non-ct firmware and driver on OpenWrt (w/backports 
5.4.27 & AQL). ath10k starts up but is unable to let any stations connect.

I've also tried the standalone patch by Ben and it seems to have reduced 
the latencies on top of AQL by another 5 ms.

On 4/29/20 4:39 AM, Toke Høiland-Jørgensen wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
>> On 04/28/2020 12:37 PM, Toke Høiland-Jørgensen wrote:
>>> greearb@candelatech.com writes:
>>>
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
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>> ---
>>>>   drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>>>>   drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
>>>> index 31c4ddbf45cb..b5634781c0dc 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/htt.h
>>>> +++ b/drivers/net/wireless/ath/ath10k/htt.h
>>>> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>>>>
>>>>   	u8 target_version_major;
>>>>   	u8 target_version_minor;
>>>> +	bool needs_unlock;
>>>>   	struct completion target_version_received;
>>>>   	u8 max_num_amsdu;
>>>>   	u8 max_num_ampdu;
>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>> index 9b3c3b080e92..44795d9a7c0c 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>>>> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>>>>   	lockdep_assert_held(&htt->tx_lock);
>>>>
>>>>   	htt->num_pending_tx--;
>>>> -	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
>>>> +	if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
>>>
>>> Why /4? Seems a bit arbitrary?
>>
>> Yes, arbitrary for sure. I figure restart filling the queue when 1/4
>> full so that it is unlikely to run dry. Possibly it should restart
>> sooner to keep it more full on average?
> 
> Theoretically, the "keep the queue at the lowest possible level that
> keeps it from underflowing" is what BQL is supposed to do. The diff
> below uses the dynamic adjustment bit (from dynamic_queue_limits.h) in
> place of num_pending_tx. I've only compile tested it, and I'm a bit
> skeptical that it will work right for this, but if anyone wants to give
> it a shot, there it is.
> 
> BTW, while doing that, I noticed there's a similar arbitrary limit in
> ath10k_mac_tx_push_pending() at max_num_pending_tx/2. So if you're going
> to keep the arbitrary limit maybe use the same one? :)
> 
>> Before my patch, the behaviour would be to try to keep it as full as
>> possible, as in restart the queues as soon as a single slot opens up
>> in the tx queue.
> 
> Yeah, that seems somewhat misguided as well, from a latency perspective,
> at least. But I guess that's what we're fixing with AQL. What does the
> firmware do with the frames queued within? Do they just go on a FIFO
> queue altogether, or something smarter?
> 
> -Toke
> 
> 
> 
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index f26cc6989dad..72771ff38a94 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2497,6 +2497,10 @@ static int ath10k_core_init_firmware_features(struct ath10k *ar)
>   		return -EINVAL;
>   	}
>   
> +	dql_init(&ar->htt.dql, HZ);
> +	ar->htt.dql.max_limit = ar->htt.max_num_pending_tx;
> +	ar->htt.dql.min_limit = 8;
> +
>   	if (ar->hw_params.num_peers)
>   		ar->max_num_peers = ar->hw_params.num_peers;
>   	else
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 4a12564fc30e..19024d063896 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -13,6 +13,7 @@
>   #include <linux/dmapool.h>
>   #include <linux/hashtable.h>
>   #include <linux/kfifo.h>
> +#include <linux/dynamic_queue_limits.h>
>   #include <net/mac80211.h>
>   
>   #include "htc.h"
> @@ -1965,8 +1966,8 @@ struct ath10k_htt {
>   	/* Protects access to pending_tx, num_pending_tx */
>   	spinlock_t tx_lock;
>   	int max_num_pending_tx;
> -	int num_pending_tx;
>   	int num_pending_mgmt_tx;
> +	struct dql dql;
>   	struct idr pending_tx;
>   	wait_queue_head_t empty_tx_wq;
>   
> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
> index e9d12ea708b6..911a79470bdf 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -144,8 +144,8 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>   {
>   	lockdep_assert_held(&htt->tx_lock);
>   
> -	htt->num_pending_tx--;
> -	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
> +	dql_completed(&htt->dql, 1);
> +	if (dql_avail(&htt->dql) > 0)
>   		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>   }
>   
> @@ -153,11 +153,11 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>   {
>   	lockdep_assert_held(&htt->tx_lock);
>   
> -	if (htt->num_pending_tx >= htt->max_num_pending_tx)
> +	if (dql_avail(&htt->dql) <= 0)
>   		return -EBUSY;
>   
> -	htt->num_pending_tx++;
> -	if (htt->num_pending_tx == htt->max_num_pending_tx)
> +	dql_queued(&htt->dql, 1);
> +	if (dql_avail(&htt->dql) <= 0)
>   		ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
>   
>   	return 0;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 2d03b8dd3b8c..1fe251742b0a 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -3998,7 +3998,7 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
>   	if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
>   		return true;
>   
> -	if (ar->htt.num_pending_tx < ar->htt.tx_q_state.num_push_allowed)
> +	if (dql_avail(&ar->htt.dql) < ar->htt.tx_q_state.num_push_allowed)
>   		return true;
>   
>   	if (artxq->num_fw_queued < artxq->num_push_allowed)
> @@ -4159,7 +4159,7 @@ void ath10k_mac_tx_push_pending(struct ath10k *ar)
>   	if (ar->htt.tx_q_state.mode != HTT_TX_MODE_SWITCH_PUSH)
>   		return;
>   
> -	if (ar->htt.num_pending_tx >= (ar->htt.max_num_pending_tx / 2))
> +	if (dql_avail(&ar->htt.dql) < (ar->htt.dql.limit / 2))
>   		return;
>   
>   	rcu_read_lock();
> @@ -7160,7 +7160,7 @@ void ath10k_mac_wait_tx_complete(struct ath10k *ar)
>   			bool empty;
>   
>   			spin_lock_bh(&ar->htt.tx_lock);
> -			empty = (ar->htt.num_pending_tx == 0);
> +			empty = (ar->htt.dql.num_completed == ar->htt.dql.num_queued);
>   			spin_unlock_bh(&ar->htt.tx_lock);
>   
>   			skip = (ar->state == ATH10K_STATE_WEDGED) ||
> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
> index 39abf8b12903..fe7cd53c2bf9 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -80,7 +80,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>   
>   	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
>   	ath10k_htt_tx_dec_pending(htt);
> -	if (htt->num_pending_tx == 0)
> +	if (htt->dql.num_completed == htt->dql.num_queued)
>   		wake_up(&htt->empty_tx_wq);
>   	spin_unlock_bh(&htt->tx_lock);
>   
> 
