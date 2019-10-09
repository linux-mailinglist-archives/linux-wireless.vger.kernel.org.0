Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969FAD192C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfJITpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 15:45:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35667 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITpU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 15:45:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so3758608lji.2;
        Wed, 09 Oct 2019 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmPVQEnpjipxWeyFZpCS/dPubFPvdXRXnBDLynnz6Hw=;
        b=hF4SZalCdpKxqdOPG4AOuy4m9gPQll8fjepU3K8fV1XVE42jwxnfXMS7Au/BAg2kTG
         BQ0xlx19FiR+BcABFFkGz2qxSKSIhOLmbHEBOtQvF/RlUu5kflIsaKiEbv2NBXaD9MaL
         C2MauWv9b9skhcNYTJEye4lLj/UOhjFjws75h1OUnySOb197RChzNR/usLUqxV95Ibzt
         Szksa6N/SRHQEewCaUdc/AimyDTynBvOtRT8VOjuqSwwqAYMNZztK2uOReBLpkxGy9Jv
         LwyBBYd/4x0A5OHPTpaQkEX7Jt9K0MxYns8rM1q16G6Xu8A4m/ZnVkPhirXqUWlqhBs6
         giLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmPVQEnpjipxWeyFZpCS/dPubFPvdXRXnBDLynnz6Hw=;
        b=oXVcGJcf0gSXU2dD731Sl3Jl0KALBXYayKBU/aGQDXcwnhs7UMIhEP/VAnl6spbGvS
         pWrB+yeNyOOjyrhFhzWrTijehRRfVh/QFoqVqmT52doqIcrOYKcKnCiAZUYaWyUFzsjG
         Ipooy0XK572Re7PP9d94nW+MOU+alZ3vN407btcxKdnTvlNhJ2ysB/oR5M5wBQ1jcVxa
         4Bw289MmXSxj4yygQ8OvK/RArrrTaI2pkV+/g17DzfjgdXstTGezrbtDFpeWEXOkmn5R
         d/ZYEtCu1Ej/87ayngMBvc4jVEgPZRSV2mH0ksvzdOCbJJXigzpowWcKkogxzpyEA82S
         36vg==
X-Gm-Message-State: APjAAAXVKfJrILFWtUWMqBb4XqI15eq59PultRWr02wHgzXGd8dqAkkg
        L7KII+PbGnXsx8gnmRaDjyCvZteb3GM=
X-Google-Smtp-Source: APXvYqwPT9zZIpgQBWMqHiuRGXolOAJXuNI8NyQAcf67PQinS2bjqXqZ4RY87fkqNwY8xGHvgoqj3g==
X-Received: by 2002:a2e:8852:: with SMTP id z18mr3525471ljj.230.1570650316995;
        Wed, 09 Oct 2019 12:45:16 -0700 (PDT)
Received: from [192.168.1.244] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id g27sm660014lja.33.2019.10.09.12.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 12:45:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] ath10k: switch to ieee80211_tx_dequeue_ni
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     Peter Oh <peter.oh@eero.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190617200140.6189-1-erik.stromdahl@gmail.com>
 <20190617200140.6189-2-erik.stromdahl@gmail.com>
 <87eezw660r.fsf@kamboji.qca.qualcomm.com>
 <19f8023a-1943-9bf5-9a59-a7643f7692bf@eero.com>
 <fd43b218-7dc7-22dd-664b-46c55c3dd94e@gmail.com>
Message-ID: <f1669b69-6762-1341-8822-de08d9ddd55b@gmail.com>
Date:   Wed, 9 Oct 2019 21:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fd43b218-7dc7-22dd-664b-46c55c3dd94e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/9/19 9:23 PM, Erik Stromdahl wrote:
> 
> 
> On 10/1/19 7:13 PM, Peter Oh wrote:
>>
>> On 10/1/19 4:48 AM, Kalle Valo wrote:
>>> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
>>>
>>>> Since ath10k_mac_tx_push_txq() can be called from process context, we
>>>> must explicitly disable softirqs before the call into mac80211.
>>>>
>>>> By calling ieee80211_tx_dequeue_ni() instead of ieee80211_tx_dequeue()
>>>> we make sure softirqs are always disabled even in the case when
>>>> ath10k_mac_tx_push_txq() is called from process context.
>>>>
>>>> Calling ieee80211_tx_dequeue_ni() with softirq's already disabled
>>>> (e.g., from softirq context) should be safe as the local_bh_disable()
>>>> and local_bh_enable() functions (called from ieee80211_tx_dequeue_ni)
>>>> are fully reentrant.
>>>>
>>>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>>> I already applied this, but I still want to check _why_ you are changing
>>> this? Is it that you want to call ath10k_mac_tx_push_pending() from a
>>> workqueue in sdio.c in a future patch, or what? Because at the moment me
>>> and Johannes were not able to find where this is called in process
>>> context.
>>>
> SDIO irqs are threaded irqs (at least on my iMX6 board) and hence process context.
> I will see if I can find a trace that shows the call chain more exactly.
> 

I found this backtrace in a log file:
(it does not show the call to ieee80211_tx_dequeue_ni(), but it shows that
ath10k_sdio_irq_handler() is called from process context)

          irq/62-mmc1-65    [000] ....   785.261081: ath10k_mac_op_wake_tx_queue <-ieee80211_queue_skb
          irq/62-mmc1-65    [000] ....   785.261090: <stack trace>
      => ieee80211_queue_skb
      => __ieee80211_subif_start_xmit
      => ieee80211_subif_start_xmit
      => dev_hard_start_xmit
      => __dev_queue_xmit
      => dev_queue_xmit
      => ip_finish_output2
      => ip_finish_output
      => ip_output
      => ip_local_out
      => ip_queue_xmit
      => tcp_transmit_skb
      => tcp_write_xmit
      => __tcp_push_pending_frames
      => tcp_rcv_established
      => tcp_v4_do_rcv
      => tcp_v4_rcv
      => ip_local_deliver_finish
      => ip_local_deliver
      => ip_rcv_finish
      => ip_rcv
      => __netif_receive_skb_core
      => __netif_receive_skb
      => netif_receive_skb_internal
      => netif_receive_skb
      => ieee80211_deliver_skb
      => ieee80211_rx_handlers
      => ieee80211_prepare_and_rx_handle
      => ieee80211_rx_napi
      => ath10k_htt_t2h_msg_handler
      => ath10k_htt_htc_t2h_msg_handler
      => ath10k_sdio_mbox_rxmsg_pending_handler
      => ath10k_sdio_irq_handler                        <- ath10k_mac_tx_push_pending() is called from here
      => process_sdio_pending_irqs
      => sdio_run_irqs
      => sdhci_thread_irq
      => irq_thread_fn
      => irq_thread
      => kthread
      => ret_from_fork
      => 0

 From ath10k_sdio_irq_handler(), the call chain down to ieee80211_tx_dequeue_ni()
looks like this:

ath10k_sdio_irq_handler() =>
   ath10k_mac_tx_push_pending() =>
     ath10k_mac_schedule_txq() =>
       ath10k_mac_tx_push_txq() =>
         ieee80211_tx_dequeue_ni()

> 
>> It seems Johannes wants to fix it in mac80211.
>>
>> [PATCH v2] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
>>
>> Drivers typically expect this, as it's the case for almost all cases
>> where this is called (i.e. from the TX path). Also, the code in mac80211
>> itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
>> uses this_cpu_ptr() without additional protection.
>>
