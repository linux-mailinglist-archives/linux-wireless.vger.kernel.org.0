Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308F43B0394
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhFVMF5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFVMFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D245C061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 05:03:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt18so34101097ejc.11
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=QfcOAdPr39XvNclYPzcW5A3nqV+FGt6bsxsWzLNcws4=;
        b=irQAXRfWBTSzJvnvEbn7aV1xsjRQcAVJIUZ3k5o+sj5jh2UrHxqSbdWgsDqYkI5X7G
         +Mgr3+wol5OScF6upPnzkRvsxah+mU877HaVj651JEUtD5lCew4L6Sd5eoc9lLBLNrUg
         mjxrMT0FaHeSa9FHLMGWbO0uu5bytVSA8snbS3CMRbvxhf9QOHjA+mzrp0DpUEBmeh37
         aMpxzAAXUYPTeJ7tBJ6fKfoncwnctjMJ+Ze5oUU10PfPj5SO4cI4ty37pr2VDRCn8ih6
         NKkWbEd9tx+JnPKsAseWvBQtOkyk5XrAWQKPIPNqFLX+HXQ0CCSkmUXwlnsEPW7V6Y6N
         z0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QfcOAdPr39XvNclYPzcW5A3nqV+FGt6bsxsWzLNcws4=;
        b=GyVnBFrl2xq83xoOS70zme9JgLSOWgLOflEkK+F6N25/yfzwIGfqfAhzsSB0pgvx0X
         U5iO2T1hjH4JxEDHuxWSC+c2xJgYHQSuEQMSmKfQXf18hIBB/IHDiU9EaxVGvFYjKhTg
         moWErctl8WftZo1wQzE56fo8xSYRVHd6e6HSGm6M4XcXPa4HcyHjdZO+4zwkl4nhJHRv
         k++gPusTWgPQwKNjV3S9hPHI00jjShRDd8yLdmbsaR5BE0P3GZVtNdS5AR/2bYhdWYZe
         Pcm86JDtD9DZPl4OhRNrC/CBT6hI1u48DmUMELy8O1CM14yMBGegUWUqCsMWs3CMXlsU
         2JjA==
X-Gm-Message-State: AOAM532NHWIpKFCDzCE/bZI/aLzr8wSUgg/fo+dup5jzkJIkAzh8cnP7
        SImWqyR6ZLhy8Yo91yI/IgY650HQ6CsLkrEH
X-Google-Smtp-Source: ABdhPJz5LXolWjT8PQKqEYXBGw0AMDYeZU5JeQV21dxa1tNaEVrS5lYxssu19FTM/6NjkYdWhyBCBQ==
X-Received: by 2002:a17:907:387:: with SMTP id ss7mr3723570ejb.60.1624363418016;
        Tue, 22 Jun 2021 05:03:38 -0700 (PDT)
Received: from [192.168.5.225] (178-116-168-169.access.telenet.be. [178.116.168.169])
        by smtp.gmail.com with ESMTPSA id i17sm1817064ejo.63.2021.06.22.05.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 05:03:37 -0700 (PDT)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Petrosilius <petrosilius@posteo.de>, linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
 <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Message-ID: <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
Date:   Tue, 22 Jun 2021 14:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 22.06.21 13:53, Petrosilius wrote:
> On 22.06.21 13:52, Koen Vandeputte wrote:
>> On 22.06.21 12:12, Petrosilius wrote:
>>> On 22.06.21 11:54, Koen Vandeputte wrote:
>>>> On 18.06.21 13:13, Petrosilius wrote:
>>>>> Hello Lorenzo Bianconi,
>>>>>
>>>>> we are running a set of R11e-2HPnD devices and having trouble getting
>>>>> dynack working properly.
>>>>> Setup:
>>>>> * linux-5.4.123
>>>>> * OpenWRT (current development branch) with wireless
>>>>> backports-5.10.34-1
>>>>> * distance 2m between ap and sta
>>>>> * Low ambient noise wifi environment
>>>>> We experienced some non working dynack or low performance in the
>>>>> connection due to too high calculated ackto's.
>>>>>
>>>>> Here is a ath9k debug output example for a non working dynack @ 10Mhz
>>>>> BW:
>>>>>
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500427] ath: phy0:
>>>>> {48:8f:5a:3c:bb:03} tx sample 44905341 [dur 8720][h 29-t 30]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500437] ath: phy0:
>>>>> ack_ts 44844835 st_ts 44905341 st_dur 8720 [17-29]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500445] ath: phy0:
>>>>> ack_ts 44923425 st_ts 44905341 st_dur 8720 [18-29]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554642] ath:
>>>>> phy0: rx
>>>>> sample 44977693 [h 18-t 20]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554701] ath: phy0:
>>>>> {48:8f:5a:3c:bb:03} tx sample 44964984 [dur 6032][h 30-t 31]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554710] ath: phy0:
>>>>> ack_ts 44923425 st_ts 44964984 st_dur 6032 [18-30]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554718] ath: phy0:
>>>>> ack_ts 44977693 st_ts 44964984 st_dur 6032 [19-30]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577890] ath:
>>>>> phy0: rx
>>>>> sample 45000939 [h 19-t 21]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577946] ath: phy0:
>>>>> {48:8f:5a:3c:bb:03} tx sample 44998471 [dur 912][h 31-t 32]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577956] ath: phy0:
>>>>> ack_ts 44977693 st_ts 44998471 st_dur 912 [19-31]
>>>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577964] ath: phy0:
>>>>> ack_ts 45000939 st_ts 44998471 st_dur 912 [20-31]
>>>>>
>>>>> THe above output is generated in dynack.c by
>>>>>
>>>>>            ath_dbg(ath9k_hw_common(ah), DYNACK,
>>>>>                "ack_ts %u st_ts %u st_dur %u [%u-%u]\n",
>>>>>                ack_ts, st_ts->tstamp, st_ts->dur,
>>>>>                da->ack_rbf.h_rb, da->st_rbf.h_rb);
>>>>>
>>>>> The ackto is afterwards calculated by
>>>>>
>>>>>            if (ack_ts > st_ts->tstamp + st_ts->dur) {
>>>>>                ackto = ack_ts - st_ts->tstamp - st_ts->dur;
>>>>>
>>>>> Filling in the values of the first sample:
>>>>>
>>>>> (ack_ts > st_ts->tstamp + st_ts->dur) ?
>>>>> (44844835 > 44905341+8720) ?
>>>>> (44844835 > 44914061) ? ... not given
>>>>>
>>>>> Therefore a new ackto is not calculated and i can also see that in the
>>>>> ack_to file:
>>>>>
>>>>> 600 A
>>>>> 600 A
>>>>> 600 A
>>>>> ...
>>>>>
>>>>> These look like the default values to me (and do not change), but
>>>>> ath_dynack_get_max_to() should return 750 A for our 10MHz BW case -
>>>>> this
>>>>> looks also suspecious to me.
>>>>>
>>>>> For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a
>>>>> bit too
>>>>> high to me) but the performance is way below expectation (<1MBit)
>>>>> For 20 MHz bandwidth there is a ackto calculated (51 A) and the
>>>>> performance is fitting the expectation.
>>>>> If you want to take a look at the logs for each of these cases for ap
>>>>> and sta, you can download them here:
>>>>> https://cloud.hs-augsburg.de/s/eworxkJoL6JXYzZ
>>>>>
>>>>> Did anyone else experience such a behaviour on non 20MHz Channels or
>>>>> does anyone have an idea on where this behaviour might originate from?
>>>>> I am not experienced in the ath9k driver code, but a uneducated guess
>>>>> might be that the ring buffer where the dynack algorithm is taking its
>>>>> frame-samples from is not behaving as expected for the 5&10MHz case.
>>>>>
>>>>> regards,
>>>>> julian dorner
>>>> Are you stressing the link?
>>>> I'll try to simulate this later on
>>>>
>>>> Regards,
>>>>
>>>> Koen
>>>>
>>> Hi Koen,
>>>
>>> we didnt stress the link that much.
>>>
>>> There was only SSH from the ap to the sta running to get access to
>>> the sta.
>>>
>>> regards,
>>>
>>> Julian
>> Hi,
>>
>> Please retry while sending data over the link (iperf or so) and let me
>> know the results. :)
>>
>> Thanks,
>>
>> Koen
>>
> Hi Koen,
>
> we tried this
>
>> For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a bit too
>> high to me) but the performance is way below expectation (<1MBit)
> running iperf didnt help on this.
>
> Regards,
>
> Julian
>
Thanks for confirming that.

What would really help is a small table showing this:

Real physical distance? (in m)
ack_to reported while stressing the link:

20MHz: xx
10 MHz: yy
5 MHz: zz

I'll try to simulate the issue somewhere in the next days.


Please do note that ongoing effort is currently going on to improve 
dynack on lower distances.

It was observed and reported by me to Lorenzo that ack_to was way higher 
than fixed settings when
real distance is <6km

Some testing patches were cooked and tested in the field last month 
covering long and short distances (1km up to 24km)
and these are matching fixed distance ack_to very close now. (speeds 
using dynack were also higher than fixed settings)
It's not finalized yet.

Also do note that dynack only shows (any) benefit when having links >3km
Below that, timing jitter and processing time seems to have more 
influence on ack_to than actual distance.

Regards,

Koen

