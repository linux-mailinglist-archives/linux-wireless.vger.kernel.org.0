Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056111233B2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLQRjB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 12:39:01 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:38984 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLQRjB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 12:39:01 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B88B013C283;
        Tue, 17 Dec 2019 09:38:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B88B013C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576604339;
        bh=qoga12cLFry7GZ/0UdEHAYzLkqAgOu0DJUyZcqAARTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rk4AMDLP2PkkAQxioPDE9L+T4wnLuaS4hyGGx4+9G/wShNUvZFk7aumU4nNJLXROL
         EwViZT30GeL3X4uzUGhu7khcUI2uC110hYRe6BbnQUMVBlNybk2wRDob5zKZ/jche9
         Y7EUS2UMZyZzqcsoyZsT1v405xiYlAFYlmGRDyvU=
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
References: <20191216220747.887-1-greearb@candelatech.com>
 <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de>
 <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de>
 <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com>
Date:   Tue, 17 Dec 2019 09:38:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/17/19 8:23 AM, Justin Capella wrote:
> I believe someone recently submitted a patch that defined noise floors
> per band (2/5).

I looked at using the real noise floor.  Our radio was reporting a noise floor of around -102,
where the hard-coded default is -95.  This of course would make the reported RSSI lower by 7db
in that case.  I am not sure that is correct.

If this were to be implemented that way, then the firmware would have to be queried for
the noise floor in a better way than it is currently done.  So, I am not planning to work on
that soon.

Someone could post-process RSSI based on the reported noise floor if they want to adjust
the values in user-space, for isntance.

> Can't say I'm a fan of the hacky code, in particular the if/else for
> min/max // maybe abs(a-b)?

I like open coded stuff.  I'm more concerned that maybe the math could
be improved, but it seems to work pretty well in our testing.

Either way, please comment inline so that it is more obvious exactly
what code you are talking about.

> 
> if (e40 != 0x80) { // whats this case about?

0x80 means 'value is not valid'.  I can add a comment about that.

> 
> Are there reasons to not use log?

I don't want to use log in the rx path, it would very likely decrease
rx performance, especially on lower powered systems.


Thanks,
Ben

> 
> 
> 
> 
> On Tue, Dec 17, 2019 at 7:59 AM Sebastian Gottschall
> <s.gottschall@newmedia-net.de> wrote:
>>
>>
>>>> currently debugging in your code, but i already have seen that the
>>>> values are wrong now for this chipset
>>>
>>> Thanks for testing.  I'll add a check for 0 and ignore that value
>>> too.  That seem OK?
>> i tested already the 0 check and it works
>>>
>>> Were the per-chain values OK?
>> on 9984 i see no disadvantage so far. seem to work and the values look
>> sane. i will do a side by side comparisation later this day on 9984
>>>
>>> Thanks,
>>> Ben
>>>
>>>>>
>>>>> Am 16.12.2019 um 23:07 schrieb greearb@candelatech.com:
>>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>>
>>>>>> This makes per-chain RSSI be more consistent between HT20, HT40, HT80.
>>>>>> Instead of doing precise log math for adding dbm, I did a rough
>>>>>> estimate,
>>>>>> it seems to work good enough.
>>>>>>
>>>>>> Tested on ath10k-ct 9984 firmware.
>>>>>>
>>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>>> ---
>>>>>>    drivers/net/wireless/ath/ath10k/htt_rx.c  | 64
>>>>>> ++++++++++++++++++++---
>>>>>>    drivers/net/wireless/ath/ath10k/rx_desc.h |  3 +-
>>>>>>    2 files changed, 60 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c
>>>>>> b/drivers/net/wireless/ath/ath10k/htt_rx.c
>>>>>> index 13f652b622df..034d4ace228d 100644
>>>>>> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
>>>>>> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
>>>>>> @@ -1167,6 +1167,44 @@ static bool ath10k_htt_rx_h_channel(struct
>>>>>> ath10k *ar,
>>>>>>        return true;
>>>>>>    }
>>>>>>    +static int ath10k_sum_sigs_2(int a, int b) {
>>>>>> +    int diff;
>>>>>> +
>>>>>> +    if (b == 0x80)
>>>>>> +        return a;
>>>>>> +
>>>>>> +    if (a >= b) {
>>>>>> +        diff = a - b;
>>>>>> +        if (diff == 0)
>>>>>> +            return a + 3;
>>>>>> +        else if (diff == 1)
>>>>>> +            return a + 2;
>>>>>> +        else if (diff == 2)
>>>>>> +            return a + 1;
>>>>>> +        return a;
>>>>>> +    }
>>>>>> +    else {
>>>>>> +        diff = b - a;
>>>>>> +        if (diff == 0)
>>>>>> +            return b + 3;
>>>>>> +        else if (diff == 1)
>>>>>> +            return b + 2;
>>>>>> +        else if (diff == 2)
>>>>>> +            return b + 1;
>>>>>> +        return b;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static int ath10k_sum_sigs(int p20, int e20, int e40, int e80) {
>>>>>> +    /* Hacky attempt at summing dbm without resorting to log(10)
>>>>>> business */
>>>>>> +    if (e40 != 0x80) {
>>>>>> +        return ath10k_sum_sigs_2(ath10k_sum_sigs_2(p20, e20),
>>>>>> ath10k_sum_sigs_2(e40, e80));
>>>>>> +    }
>>>>>> +    else {
>>>>>> +        return ath10k_sum_sigs_2(p20, e20);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>    static void ath10k_htt_rx_h_signal(struct ath10k *ar,
>>>>>>                       struct ieee80211_rx_status *status,
>>>>>>                       struct htt_rx_desc *rxd)
>>>>>> @@ -1177,18 +1215,32 @@ static void ath10k_htt_rx_h_signal(struct
>>>>>> ath10k *ar,
>>>>>>            status->chains &= ~BIT(i);
>>>>>>              if (rxd->ppdu_start.rssi_chains[i].pri20_mhz != 0x80) {
>>>>>> -            status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR +
>>>>>> - rxd->ppdu_start.rssi_chains[i].pri20_mhz;
>>>>>> +            status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR
>>>>>> +                +
>>>>>> ath10k_sum_sigs(rxd->ppdu_start.rssi_chains[i].pri20_mhz,
>>>>>> + rxd->ppdu_start.rssi_chains[i].ext20_mhz,
>>>>>> + rxd->ppdu_start.rssi_chains[i].ext40_mhz,
>>>>>> + rxd->ppdu_start.rssi_chains[i].ext80_mhz);
>>>>>> +            //ath10k_warn(ar, "rx-h-sig, chain[%i] pri20: %d
>>>>>> ext20: %d  ext40: %d  ext80: %d\n",
>>>>>> +            //        i, rxd->ppdu_start.rssi_chains[i].pri20_mhz,
>>>>>> rxd->ppdu_start.rssi_chains[i].ext20_mhz,
>>>>>> +            // rxd->ppdu_start.rssi_chains[i].ext40_mhz,
>>>>>> rxd->ppdu_start.rssi_chains[i].ext80_mhz);
>>>>>>                  status->chains |= BIT(i);
>>>>>>            }
>>>>>>        }
>>>>>>          /* FIXME: Get real NF */
>>>>>> -    status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>>>>>> -             rxd->ppdu_start.rssi_comb;
>>>>>> -    /* ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x
>>>>>> chain[0]: %d  chain[1]: %d  chan[2]: %d\n",
>>>>>> -                       status->signal, status->chains,
>>>>>> status->chain_signal[0], status->chain_signal[1],
>>>>>> status->chain_signal[2]); */
>>>>>> +    if (rxd->ppdu_start.rssi_comb_ht != 0x80) {
>>>>>> +        status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>>>>>> +            rxd->ppdu_start.rssi_comb_ht;
>>>>>> +    }
>>>>>> +    else {
>>>>>> +        status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
>>>>>> +            rxd->ppdu_start.rssi_comb;
>>>>>> +    }
>>>>>> +
>>>>>> +    //ath10k_warn(ar, "rx-h-sig, signal: %d  chains: 0x%x
>>>>>> chain[0]: %d  chain[1]: %d  chain[2]: %d chain[3]: %d\n",
>>>>>> +    //        status->signal, status->chains,
>>>>>> status->chain_signal[0],
>>>>>> +    //        status->chain_signal[1], status->chain_signal[2],
>>>>>> status->chain_signal[3]);
>>>>>>        status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
>>>>>>    }
>>>>>>    diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h
>>>>>> b/drivers/net/wireless/ath/ath10k/rx_desc.h
>>>>>> index dec1582005b9..6b44677474dd 100644
>>>>>> --- a/drivers/net/wireless/ath/ath10k/rx_desc.h
>>>>>> +++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
>>>>>> @@ -726,7 +726,8 @@ struct rx_ppdu_start {
>>>>>>            u8 ext80_mhz;
>>>>>>        } rssi_chains[4];
>>>>>>        u8 rssi_comb;
>>>>>> -    __le16 rsvd0;
>>>>>> +    u8 rsvd0; /* first two bits are bandwidth, other 6 are
>>>>>> reserved */
>>>>>> +    u8 rssi_comb_ht;
>>>>>>        u8 info0; /* %RX_PPDU_START_INFO0_ */
>>>>>>        __le32 info1; /* %RX_PPDU_START_INFO1_ */
>>>>>>        __le32 info2; /* %RX_PPDU_START_INFO2_ */
>>>>>
>>>>> _______________________________________________
>>>>> ath10k mailing list
>>>>> ath10k@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/ath10k
>>>>>
>>>>
>>>
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

