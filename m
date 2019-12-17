Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DB122B8E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 13:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfLQMcu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 07:32:50 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:38468 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfLQMct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 07:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject; bh=BXHWn//OypmWN4nUwPmIkLW9l6j7erYnadxSsy5HUBc=;
        b=BaewL80GueEIiQy2X5wS7xZjYmwovHnTIvZkuWNSLjaydXvexNugAetKd/I8IX+GPd1rrCBAfAazTnPkZNkg9jbpiPJClXVZacuADQXfKI5SfufcF1/D0T90vodw/eyisksY55aOQtazExnBeyDliVIStoK7N2bO6Qdz2U3zLYs=;
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <20191216220747.887-1-greearb@candelatech.com>
 <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
Message-ID: <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de>
Date:   Tue, 17 Dec 2019 13:32:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:3500:8860:b628:52d9:8f37]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1ihC0Z-0004Q9-K0; Tue, 17 Dec 2019 13:31:23 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

result of my tests

on qca988x rxd->ppdu_start.rssi_comb_ht is always zero. so you need to 
add a additional check

Am 17.12.2019 um 13:02 schrieb Sebastian Gottschall:
> i see a issue in your patch for qca988x chipsets
>
> +    if (rxd->ppdu_start.rssi_comb_ht != 0x80) {
> +        status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
> +            rxd->ppdu_start.rssi_comb_ht;
> +    }
>
>
> this is always true for qca988x, but the field is not provided on 
> these older chipsets. so signal reporting will be broken
> i'm currently debugging in your code, but i already have seen that the 
> values are wrong now for this chipset
>
> Am 16.12.2019 um 23:07 schrieb greearb@candelatech.com:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This makes per-chain RSSI be more consistent between HT20, HT40, HT80.
>> Instead of doing precise log math for adding dbm, I did a rough 
>> estimate,
>> it seems to work good enough.
>>
>> Tested on ath10k-ct 9984 firmware.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/htt_rx.c  | 64 ++++++++++++++++++++---
>>   drivers/net/wireless/ath/ath10k/rx_desc.h |  3 +-
>>   2 files changed, 60 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c 
>> b/drivers/net/wireless/ath/ath10k/htt_rx.c
>> index 13f652b622df..034d4ace228d 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
>> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
>> @@ -1167,6 +1167,44 @@ static bool ath10k_htt_rx_h_channel(struct 
>> ath10k *ar,
>>       return true;
>>   }
>>   +static int ath10k_sum_sigs_2(int a, int b) {
>> +    int diff;
>> +
>> +    if (b == 0x80)
>> +        return a;
>> +
>> +    if (a >= b) {
>> +        diff = a - b;
>> +        if (diff == 0)
>> +            return a + 3;
>> +        else if (diff == 1)
>> +            return a + 2;
>> +        else if (diff == 2)
>> +            return a + 1;
>> +        return a;
>> +    }
>> +    else {
>> +        diff = b - a;
>> +        if (diff == 0)
>> +            return b + 3;
>> +        else if (diff == 1)
>> +            return b + 2;
>> +        else if (diff == 2)
>> +            return b + 1;
>> +        return b;
>> +    }
>> +}
>> +
>> +static int ath10k_sum_sigs(int p20, int e20, int e40, int e80) {
>> +    /* Hacky attempt at summing dbm without resorting to log(10) 
>> business */
>> +    if (e40 != 0x80) {
>> +        return ath10k_sum_sigs_2(ath10k_sum_sigs_2(p20, e20), 
>> ath10k_sum_sigs_2(e40, e80));
>> +    }
>> +    else {
>> +        return ath10k_sum_sigs_2(p20, e20);
>> +    }
>> +}
>> +
>>   static void ath10k_htt_rx_h_signal(struct ath10k *ar,
>>                      struct ieee80211_rx_status *status,
>>                      struct htt_rx_desc *rxd)
>> @@ -1177,18 +1215,32 @@ static void ath10k_htt_rx_h_signal(struct 
>> ath10k *ar,
>>           status->chains &= ~BIT(i);
>>             if (rxd->ppdu_start.rssi_chains[i].pri20_mhz != 0x80) {
>> -            status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR +
>> -                rxd->ppdu_start.rssi_chains[i].pri20_mhz;
>> +            status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR
>> +                + 
>> ath10k_sum_sigs(rxd->ppdu_start.rssi_chains[i].pri20_mhz,
>> + rxd->ppdu_start.rssi_chains[i].ext20_mhz,
>> + rxd->ppdu_start.rssi_chains[i].ext40_mhz,
>> + rxd->ppdu_start.rssi_chains[i].ext80_mhz);
>> +            //ath10k_warn(ar, "rx-h-sig, chain[%i] pri20: %d ext20: 
>> %d  ext40: %d  ext80: %d\n",
>> +            //        i, rxd->ppdu_start.rssi_chains[i].pri20_mhz, 
>> rxd->ppdu_start.rssi_chains[i].ext20_mhz,
>> +            // rxd->ppdu_start.rssi_chains[i].ext40_mhz, 
>> rxd->ppdu_start.rssi_chains[i].ext80_mhz);
>>                 status->chains |= BIT(i);
>>           }
>>       }
>>         /* FIXME: Get real NF */
>> -    status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>> -             rxd->ppdu_start.rssi_comb;
>> -    /* ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x chain[0]: 
>> %d  chain[1]: %d  chan[2]: %d\n",
>> -                       status->signal, status->chains, 
>> status->chain_signal[0], status->chain_signal[1], 
>> status->chain_signal[2]); */
>> +    if (rxd->ppdu_start.rssi_comb_ht != 0x80) {
>> +        status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>> +            rxd->ppdu_start.rssi_comb_ht;
>> +    }
>> +    else {
>> +        status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>> +            rxd->ppdu_start.rssi_comb;
>> +    }
>> +
>> +    //ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x chain[0]: 
>> %d  chain[1]: %d  chain[2]: %d chain[3]: %d\n",
>> +    //        status->signal, status->chains, status->chain_signal[0],
>> +    //        status->chain_signal[1], status->chain_signal[2], 
>> status->chain_signal[3]);
>>       status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
>>   }
>>   diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h 
>> b/drivers/net/wireless/ath/ath10k/rx_desc.h
>> index dec1582005b9..6b44677474dd 100644
>> --- a/drivers/net/wireless/ath/ath10k/rx_desc.h
>> +++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
>> @@ -726,7 +726,8 @@ struct rx_ppdu_start {
>>           u8 ext80_mhz;
>>       } rssi_chains[4];
>>       u8 rssi_comb;
>> -    __le16 rsvd0;
>> +    u8 rsvd0; /* first two bits are bandwidth, other 6 are reserved */
>> +    u8 rssi_comb_ht;
>>       u8 info0; /* %RX_PPDU_START_INFO0_ */
>>       __le32 info1; /* %RX_PPDU_START_INFO1_ */
>>       __le32 info2; /* %RX_PPDU_START_INFO2_ */
>
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
>
