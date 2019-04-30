Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37184106D4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEAKMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 06:12:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35478 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEAKMw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 06:12:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so12861481lfh.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 May 2019 03:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=91yblX5MKaqxnF25qflRx7IWX0G6YFJweKroNeGpU5Q=;
        b=ZlEeiQEYp2JwbN/Fkk7RLxFnwD5h/DYvzYzO1JxgiFW00l9yi19R9A6oHKM2RgW4SJ
         F16n8/ORKVW4CQVevM5Dv1IgRppi66EnMn67vqiKrU/akMWc0zlJpkfsxf4qNZEV6jHq
         w9ASNxmImdnORyCvQBYD2RehUQSOsJPN6ByR3kLFichPTkXH0WuUmum+wYTa/UX8nm3d
         7CqNE4zKel0JMSSQ9Zg2OBlMBEKDDdL8flXTlLPybl736JsgpRgaEM5VIT5vn8jrYosl
         zb+Pt5cPeC9rfHkcn7kwrSJRCc1DMEFT3OQaJPlnYFw2DPOvT9ibZwLCcGw2Lkw9daa5
         Y9mA==
X-Gm-Message-State: APjAAAWawKHaduF/O5AoTCfWWa/JTSOKM4CWgnP6J+/qmG77gwB8eBad
        1hAfNQRlINb2AQTYR5s1bEpa/YHjRJY=
X-Google-Smtp-Source: APXvYqwj28hHm8dHJMSlLmM/Du8jZPknWT8j72AhSyDTA446kuCu72BEQdSDd0DVnos+jSc6gq0NrA==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr34384581lfk.45.1556705570074;
        Wed, 01 May 2019 03:12:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v26sm8024084lja.60.2019.05.01.03.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 03:12:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C661182083; Tue, 30 Apr 2019 12:39:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, linux-wireless-owner@vger.kernel.org
Subject: Re: [RFC/RFT] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <a9bfcb131944fafb838ab5cd448e7da2@codeaurora.org>
References: <20190215170512.31512-1-toke@redhat.com> <753b328855b85f960ceaf974194a7506@codeaurora.org> <87ftqy41ea.fsf@toke.dk> <acd33756e87ea64c608e306e5ee60aa2@codeaurora.org> <877ec2ykrh.fsf@toke.dk> <89d32174b282006c8d4e7614657171be@codeaurora.org> <87a7gyw3cu.fsf@toke.dk> <73077ba7cda566d5eeb2395978b3524c@codeaurora.org> <877ec0u6mu.fsf@toke.dk> <76591d2924d7b6fec06d0df07247166a@codeaurora.org> <87bm10ped0.fsf@toke.dk> <a9bfcb131944fafb838ab5cd448e7da2@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Apr 2019 12:39:13 +0200
Message-ID: <875zqvojzi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-04-21 05:15, Toke Høiland-Jørgensen wrote:
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>> 
>>> On 2019-04-11 19:24, Toke Høiland-Jørgensen wrote:
>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>> 
>>>>> On 2019-04-10 18:40, Toke Høiland-Jørgensen wrote:
>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>> 
>>>>>>> On 2019-04-10 04:41, Toke Høiland-Jørgensen wrote:
>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>> 
>>>>>>>>> On 2019-04-04 16:31, Toke Høiland-Jørgensen wrote:
>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>> 
>>>>>>>>>>> On 2019-02-16 01:05, Toke Høiland-Jørgensen wrote:
>>>>>>>>>>>> This switches the airtime scheduler in mac80211 to use a
>>>>>>>>>>>> virtual
>>>>>>>>>>>> time-based
>>>>>>>>>>>> scheduler instead of the round-robin scheduler used before.
>>>>>>>>>>>> This
>>>>>>>>>>>> has
>>>>>>>>>>>> a
>>>>>>>>>>>> couple of advantages:
>>>>>>>>>>>> 
>>>>>>>>>>>> - No need to sync up the round-robin scheduler in
>>>>>>>>>>>> firmware/hardware
>>>>>>>>>>>> with
>>>>>>>>>>>>   the round-robin airtime scheduler.
>>>>>>>>>>>> 
>>>>>>>>>>>> - If several stations are eligible for transmission we can
>>>>>>>>>>>> schedule
>>>>>>>>>>>> both of
>>>>>>>>>>>>   them; no need to hard-block the scheduling rotation until 
>>>>>>>>>>>> the
>>>>>>>>>>>> head
>>>>>>>>>>>> of
>>>>>>>>>>>> the
>>>>>>>>>>>>   queue has used up its quantum.
>>>>>>>>>>>> 
>>>>>>>>>>>> - The check of whether a station is eligible for transmission
>>>>>>>>>>>> becomes
>>>>>>>>>>>>   simpler (in ieee80211_txq_may_transmit()).
>>>>>>>>>>>> 
>>>>>>>>>>>> The drawback is that scheduling becomes slightly more
>>>>>>>>>>>> expensive,
>>>>>>>>>>>> as
>>>>>>>>>>>> we
>>>>>>>>>>>> need
>>>>>>>>>>>> to maintain an rbtree of TXQs sorted by virtual time. This
>>>>>>>>>>>> means
>>>>>>>>>>>> that
>>>>>>>>>>>> ieee80211_register_airtime() becomes O(logN) in the number of
>>>>>>>>>>>> currently
>>>>>>>>>>>> scheduled TXQs. However, hopefully this number rarely grows 
>>>>>>>>>>>> too
>>>>>>>>>>>> big
>>>>>>>>>>>> (it's
>>>>>>>>>>>> only TXQs currently backlogged, not all associated stations),
>>>>>>>>>>>> so
>>>>>>>>>>>> it
>>>>>>>>>>>> shouldn't be too big of an issue.
>>>>>>>>>>>> 
>>>>>>>>>>>> @@ -1831,18 +1830,32 @@ void
>>>>>>>>>>>> ieee80211_sta_register_airtime(struct
>>>>>>>>>>>> ieee80211_sta *pubsta, u8 tid,
>>>>>>>>>>>>  {
>>>>>>>>>>>>  	struct sta_info *sta = container_of(pubsta, struct 
>>>>>>>>>>>> sta_info,
>>>>>>>>>>>> sta);
>>>>>>>>>>>>  	struct ieee80211_local *local = sta->sdata->local;
>>>>>>>>>>>> +	struct ieee80211_txq *txq = sta->sta.txq[tid];
>>>>>>>>>>>>  	u8 ac = ieee80211_ac_from_tid(tid);
>>>>>>>>>>>> -	u32 airtime = 0;
>>>>>>>>>>>> +	u64 airtime = 0, weight_sum;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	if (!txq)
>>>>>>>>>>>> +		return;
>>>>>>>>>>>> 
>>>>>>>>>>>>  	if (sta->local->airtime_flags & AIRTIME_USE_TX)
>>>>>>>>>>>>  		airtime += tx_airtime;
>>>>>>>>>>>>  	if (sta->local->airtime_flags & AIRTIME_USE_RX)
>>>>>>>>>>>>  		airtime += rx_airtime;
>>>>>>>>>>>> 
>>>>>>>>>>>> +	/* Weights scale so the unit weight is 256 */
>>>>>>>>>>>> +	airtime <<= 8;
>>>>>>>>>>>> +
>>>>>>>>>>>>  	spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>>> +
>>>>>>>>>>>>  	sta->airtime[ac].tx_airtime += tx_airtime;
>>>>>>>>>>>>  	sta->airtime[ac].rx_airtime += rx_airtime;
>>>>>>>>>>>> -	sta->airtime[ac].deficit -= airtime;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	weight_sum = local->airtime_weight_sum[ac] ?:
>>>>>>>>>>>> sta->airtime_weight;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	local->airtime_v_t[ac] += airtime / weight_sum;
>>> Hi Toke,
>>> 
>>> I was porting this version of ATF design to my ath10k platform and 
>>> found
>>> my old kernel version not supporting 64bit division. I'm wondering if 
>>> it
>>> is necessary to use u64 for airtime and weight_sum here though I can
>>> find a solution for it. I think u32 might be enough. For airtime,
>>> u32_max / 256 = 7182219 us(718 ms). As for weight_sum, u32_max / 8092 
>>> us
>>> = 130490, meaning we can support more than 130000 nodes with airtime
>>> weight 8092 us.
>> 
>> As Felix said, we don't really want divides in the fast path at all. 
>> And
>> since the divisors are constant, we should be able to just pre-compute
>> reciprocals and turn the whole thing into multiplications...
>> 
>>> Another finding was when I configured two 11ac STAs with different
>>> airtime weight, such as 256 and 1024 meaning ratio is 1:4, the
>>> throughput ratio was not roughly matching the ratio. Could you please
>>> share your results? I am not sure if it is due to platform difference.
>> 
>> Hmm, I tested them with ath9k where things seemed to work equivalently
>> to the DRR. Are you testing the same hardware with that? Would be a 
>> good
>> baseline.
>> 
>> I am on vacation until the end of the month, but can share my actual
>> test results once I get back...
> Hi Toke,
> I saw your commit in hostapd in
> http://patchwork.ozlabs.org/patch/1059334/
>
> For dynamic and limit mode described in above hostapd patch, do I need 
> to change any code in this kernel patch or any other patches am I 
> missing?

Nope, the kernel just exposes the API to set weights, hostapd does
everything else :)

> After a quick look at the hostapd patch, I guess all the efforts for 
> both modes are done in hostapd. Correct me if I am wrong. :)

You are quite right!

-Toke
