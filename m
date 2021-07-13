Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9533C724E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhGMOh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhGMOhs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 10:37:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01354C0613DD
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jul 2021 07:34:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l1so11676212edr.11
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jul 2021 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=617n+QwZOhaXk/euGC5USVSRO1Vct/mO36gnhQnfC+4=;
        b=OQkQeX7+bybF6tyRXQKizS8voc5kJDSZEVLTfmvx5EY9ffjFFGG/nKXGJXzjDJkqzf
         hpxfW+LmDrQGCt2/yGvaT6wvQxCNVvdU/FMgFGAtuIPuqgkg0BNI6BETkH7uOP68yzNi
         1Jb/f2yFRG3ZT76CZmjXMIOyLFoHhcjdueYWhqPIMBo8apwQtolbFb5LeKEkEEFirf69
         OhR5pbJvVDKC8Eu2pYi6EYA5D4HPO6oVBT2+VeCpwtMIZCrdWFGXPVsV8qYHVROUtgoj
         /4tv0R5NOU5s502WWFcW3BVDaUnUU12nBrxVesJGObpKEQK4FRhx0mmz5thJA5+Rmn3D
         q83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=617n+QwZOhaXk/euGC5USVSRO1Vct/mO36gnhQnfC+4=;
        b=SS5j3jYBc3yGxSKbTWRTgsSUMsa2GOQK20qXYCh5XoD3SZQjh58AG9B3XEMedAtcRn
         MOrb2PGocJhronVudLB+8dG6s3zVwo/GcTBhMpk5QWZucnzZiMFEVkQqsTGPiI9hfLSc
         Dz+KDGt6GKBqkkLU8VFQckbmywB+pLBiKYnt/QEs5mjqH2wcqo+E0DL+71KhkFtkCbGI
         54cPC9T1WRtL1/yRv/Lm9VyP2mxtU32pXlYEbdc5fxT3bhJ7QH7LJRYSfgfY83mgMO0v
         Pn5YGX0m3vKMGuov/AbPyBkbVk5+kLMZ5/1sAq6Z5FfNEf8yC9s/kjJQgSOwqkopfKTr
         6n/g==
X-Gm-Message-State: AOAM533YbXeqZEvFveVJjcZjLYEqohE/DjeIPfXQxIEFU/KangLN3tH+
        Qkya+MwW2vyvSZvTPutQY+bxdJkTUwuKBw==
X-Google-Smtp-Source: ABdhPJwCHNSiewwZtJ9L//uEFpPBj1o1rA9/AdSyHcvP2z50lxiSOSy48X/3OIAJ1Md8h+HdQ0kIkQ==
X-Received: by 2002:aa7:cb03:: with SMTP id s3mr6141944edt.189.1626186895440;
        Tue, 13 Jul 2021 07:34:55 -0700 (PDT)
Received: from [10.202.0.7] ([31.31.140.89])
        by smtp.gmail.com with ESMTPSA id n3sm6358471edd.53.2021.07.13.07.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 07:34:54 -0700 (PDT)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Petrosilius <petrosilius@posteo.de>, linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
 <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
 <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
 <ca99a4cc-eb7d-dfca-1d26-5b504a57e31f@posteo.de>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Message-ID: <a7e37fa2-5fe7-6a39-d72d-9e3723540331@citymesh.com>
Date:   Tue, 13 Jul 2021 16:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ca99a4cc-eb7d-dfca-1d26-5b504a57e31f@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 22.06.21 20:54, Petrosilius wrote:
> On 22.06.21 14:03, Koen Vandeputte wrote:
>> Thanks for confirming that.
>>
>> What would really help is a small table showing this:
>>
>> Real physical distance? (in m)
>> ack_to reported while stressing the link:
>>
>> 20MHz: xx
>> 10 MHz: yy
>> 5 MHz: zz
>>
>> I'll try to simulate the issue somewhere in the next days.
>>
>>
>> Please do note that ongoing effort is currently going on to improve
>> dynack on lower distances.
>>
>> It was observed and reported by me to Lorenzo that ack_to was way
>> higher than fixed settings when
>> real distance is <6km
>>
>> Some testing patches were cooked and tested in the field last month
>> covering long and short distances (1km up to 24km)
>> and these are matching fixed distance ack_to very close now. (speeds
>> using dynack were also higher than fixed settings)
>> It's not finalized yet.
>>
>> Also do note that dynack only shows (any) benefit when having links >3km
>> Below that, timing jitter and processing time seems to have more
>> influence on ack_to than actual distance.
>>
>> Regards,
>>
>> Koen
>>
> Here the testresults
>
> real physical distance: 1m
>
> BW: 20mhz
> ackto: 50
> iperf3
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  86.4 MBytes  72.4 Mbits/sec    0             sender
> [  5]   0.00-10.01  sec  86.0 MBytes  72.0 Mbits/sec
> receiver
>
> BW: 5mhz
> ackto: 50
> iperf3
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.01  sec  45.2 KBytes  37.0 Kbits/sec   14             sender
> [  5]   0.00-10.07  sec  5.66 KBytes  4.60 Kbits/sec
> receiver
>
> BW: 10mhz
> ackto: 50
> iperf3
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   127 KBytes   104 Kbits/sec   30             sender
> [  5]   0.00-14.10  sec   107 KBytes  62.4 Kbits/sec
> receiver
>
> Also longer iperf3 tests didnt change anything on this behaviour.
>
> After this test we were actually able to get the ack_to doing something
> for 5mhz (ack_to 641 - ~12MBit iperf3) and 10mhz (ack_to 258 - ~14MBit
> iperf3) by doing some random wifi-restarts (using openwrt 'wifi'
> command) and reboots, but this is not really reproducible.
>
> We got the gutfeeling that there might be some issue reseting of the
> dynack part when changing the bandwidths. This might explain, why for
> the test above the ack_to doesnt change at all from the 50 of the 20Mhz
> BW. Or is this normal behaviour that the ack_to doesnt change after a
> bandwidth change?
>
> Another observation: Is it normal that 'iw dev' doesnt show 5 & 10 MHz,
> but always 20 MHz? (We verified that we actually get 5/10MHz Channels by
> checking visibility of the AP with other clients).
>
> To rule out a hardware problem: We used the same hardware successfully
> on a 8km/20MHz link with dynack.
>
> Regards,
>
> Julian
>
I can simulate the issue.

The problem is that IBSS starts at the highest value (to guarantee 
connection), but it takes forever to get enough valid samples to 
actually reach the optimal value through EWMA:

[   48.060768] ath: phy0: ACK timeout 600 slottime 298
[   51.155507] wlan0: Trigger new scan to find an IBSS to join
[   53.104609] wlan0: Selected IBSS BSSID ac:c5:2a:a3:61:c9 based on 
configured SSID
[   53.160471] ath: phy0: rx sample 46297 [h 0-t 1]
[   53.160522] ath: phy0: {74:4d:28:14:d9:94} tx sample 46163 [dur 72][h 
0-t 1]
[   53.160533] ath: phy0: ack_ts 46297 st_ts 46163 st_dur 72 [0-0]
[   53.160542] ath: phy0: 74:4d:28:14:d9:94 to 465 [62]
[   53.160550] ath: phy0: ACK timeout 465 slottime 231
[   53.165973] ath: phy0: rx sample 51368 [h 1-t 2]
[   53.166027] ath: phy0: {74:4d:28:14:d9:94} tx sample 51098 [dur 
208][h 1-t 2]
[   53.166038] ath: phy0: ack_ts 51368 st_ts 51098 st_dur 208 [1-1]
[   53.166047] ath: phy0: 74:4d:28:14:d9:94 to 364 [62]
[   53.170739] ath: phy0: rx sample 56568 [h 2-t 3]
[   53.170791] ath: phy0: {74:4d:28:14:d9:94} tx sample 56222 [dur 
284][h 2-t 3]
[   53.170801] ath: phy0: ack_ts 56568 st_ts 56222 st_dur 284 [2-2]
[   53.170811] ath: phy0: 74:4d:28:14:d9:94 to 288 [62]
[   54.169095] ath: phy0: rx sample 1054919 [h 3-t 4]
[   54.169148] ath: phy0: {74:4d:28:14:d9:94} tx sample 1054598 [dur 
260][h 3-t 4]
[   54.169159] ath: phy0: ack_ts 1054919 st_ts 1054598 st_dur 260 [3-3]
[   54.169169] ath: phy0: 74:4d:28:14:d9:94 to 231 [61]
[   54.173970] ath: phy0: rx sample 1059800 [h 4-t 5]
[   54.174024] ath: phy0: {74:4d:28:14:d9:94} tx sample 1059511 [dur 
228][h 4-t 5]
[   54.174035] ath: phy0: ack_ts 1059800 st_ts 1059511 st_dur 228 [4-4]
[   54.174044] ath: phy0: 74:4d:28:14:d9:94 to 188 [61]
...
[  326.925123] ath: phy0: ACK timeout 156 slottime 76
...
[  653.145142] ath: phy0: ACK timeout 132 slottime 64
...
[  926.928758] ath: phy0: ACK timeout 114 slottime 55

(static optimal value is 28 .. so it will take a lot longer ..)


Above log is with an iperf session running in the background. :-s

Will look further into this ..

Regards,

Koen

