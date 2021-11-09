Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B1544AD04
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 12:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhKIL6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 06:58:45 -0500
Received: from mout01.posteo.de ([185.67.36.65]:44017 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235903AbhKIL6p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 06:58:45 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EE708240029
        for <linux-wireless@vger.kernel.org>; Tue,  9 Nov 2021 12:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1636458958; bh=0c0Z0JzQV2Ih3bG/1DU62l8kPD0Zl0EO/c1M/73N8QY=;
        h=Date:Subject:To:From:From;
        b=ByvIJ4BMHMlHg1+LIIlQFBlIy8La964nAPW+zP/4LU7strJmyR7WkfX7+S+usKWU9
         v83Gp0Dufrs6cxIMzODjGdIe/2i/v2+k4Yn/FAaeOboL2iHj2UxZtfEPvI8kTYckm2
         VAF1GS5bGhmaZkc+HTaI6pk47+/kST3IHxjOIbwOe2zGSuMJynggqSGdGv0JO9cNmT
         Vy0Pr0b0gTFn7xlOvSchXn3kWnWGAT12vi7QKif5vL7kz7kAvPRbBAVLLxr5R+VD5l
         Yb3pjvrNPzT955KkrwNaZogwmwr2X7k7wBkONoYZNYfKOdk8H760uQ/mXTZrHJ9akQ
         lpnGAJM+nf64A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HpRJX3jShz9rxT;
        Tue,  9 Nov 2021 12:55:56 +0100 (CET)
Message-ID: <79ae2f1b-66cb-9182-a639-8fbb6f1fabd9@posteo.de>
Date:   Tue,  9 Nov 2021 11:55:51 +0000
MIME-Version: 1.0
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
Content-Language: en-US
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
 <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
 <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
 <ca99a4cc-eb7d-dfca-1d26-5b504a57e31f@posteo.de>
 <a7e37fa2-5fe7-6a39-d72d-9e3723540331@citymesh.com>
From:   petrosilius <petrosilius@posteo.de>
In-Reply-To: <a7e37fa2-5fe7-6a39-d72d-9e3723540331@citymesh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Koen,

did you find time to look further into this?

regards,

julian

On 13.07.21 16:34, Koen Vandeputte wrote:
>
> On 22.06.21 20:54, Petrosilius wrote:
>> On 22.06.21 14:03, Koen Vandeputte wrote:
>>> Thanks for confirming that.
>>>
>>> What would really help is a small table showing this:
>>>
>>> Real physical distance? (in m)
>>> ack_to reported while stressing the link:
>>>
>>> 20MHz: xx
>>> 10 MHz: yy
>>> 5 MHz: zz
>>>
>>> I'll try to simulate the issue somewhere in the next days.
>>>
>>>
>>> Please do note that ongoing effort is currently going on to improve
>>> dynack on lower distances.
>>>
>>> It was observed and reported by me to Lorenzo that ack_to was way
>>> higher than fixed settings when
>>> real distance is <6km
>>>
>>> Some testing patches were cooked and tested in the field last month
>>> covering long and short distances (1km up to 24km)
>>> and these are matching fixed distance ack_to very close now. (speeds
>>> using dynack were also higher than fixed settings)
>>> It's not finalized yet.
>>>
>>> Also do note that dynack only shows (any) benefit when having links 
>>> >3km
>>> Below that, timing jitter and processing time seems to have more
>>> influence on ack_to than actual distance.
>>>
>>> Regards,
>>>
>>> Koen
>>>
>> Here the testresults
>>
>> real physical distance: 1m
>>
>> BW: 20mhz
>> ackto: 50
>> iperf3
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  86.4 MBytes  72.4 Mbits/sec 0             
>> sender
>> [  5]   0.00-10.01  sec  86.0 MBytes  72.0 Mbits/sec
>> receiver
>>
>> BW: 5mhz
>> ackto: 50
>> iperf3
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.01  sec  45.2 KBytes  37.0 Kbits/sec 14             
>> sender
>> [  5]   0.00-10.07  sec  5.66 KBytes  4.60 Kbits/sec
>> receiver
>>
>> BW: 10mhz
>> ackto: 50
>> iperf3
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec   127 KBytes   104 Kbits/sec 30             
>> sender
>> [  5]   0.00-14.10  sec   107 KBytes  62.4 Kbits/sec
>> receiver
>>
>> Also longer iperf3 tests didnt change anything on this behaviour.
>>
>> After this test we were actually able to get the ack_to doing something
>> for 5mhz (ack_to 641 - ~12MBit iperf3) and 10mhz (ack_to 258 - ~14MBit
>> iperf3) by doing some random wifi-restarts (using openwrt 'wifi'
>> command) and reboots, but this is not really reproducible.
>>
>> We got the gutfeeling that there might be some issue reseting of the
>> dynack part when changing the bandwidths. This might explain, why for
>> the test above the ack_to doesnt change at all from the 50 of the 20Mhz
>> BW. Or is this normal behaviour that the ack_to doesnt change after a
>> bandwidth change?
>>
>> Another observation: Is it normal that 'iw dev' doesnt show 5 & 10 MHz,
>> but always 20 MHz? (We verified that we actually get 5/10MHz Channels by
>> checking visibility of the AP with other clients).
>>
>> To rule out a hardware problem: We used the same hardware successfully
>> on a 8km/20MHz link with dynack.
>>
>> Regards,
>>
>> Julian
>>
> I can simulate the issue.
>
> The problem is that IBSS starts at the highest value (to guarantee 
> connection), but it takes forever to get enough valid samples to 
> actually reach the optimal value through EWMA:
>
> [   48.060768] ath: phy0: ACK timeout 600 slottime 298
> [   51.155507] wlan0: Trigger new scan to find an IBSS to join
> [   53.104609] wlan0: Selected IBSS BSSID ac:c5:2a:a3:61:c9 based on 
> configured SSID
> [   53.160471] ath: phy0: rx sample 46297 [h 0-t 1]
> [   53.160522] ath: phy0: {74:4d:28:14:d9:94} tx sample 46163 [dur 
> 72][h 0-t 1]
> [   53.160533] ath: phy0: ack_ts 46297 st_ts 46163 st_dur 72 [0-0]
> [   53.160542] ath: phy0: 74:4d:28:14:d9:94 to 465 [62]
> [   53.160550] ath: phy0: ACK timeout 465 slottime 231
> [   53.165973] ath: phy0: rx sample 51368 [h 1-t 2]
> [   53.166027] ath: phy0: {74:4d:28:14:d9:94} tx sample 51098 [dur 
> 208][h 1-t 2]
> [   53.166038] ath: phy0: ack_ts 51368 st_ts 51098 st_dur 208 [1-1]
> [   53.166047] ath: phy0: 74:4d:28:14:d9:94 to 364 [62]
> [   53.170739] ath: phy0: rx sample 56568 [h 2-t 3]
> [   53.170791] ath: phy0: {74:4d:28:14:d9:94} tx sample 56222 [dur 
> 284][h 2-t 3]
> [   53.170801] ath: phy0: ack_ts 56568 st_ts 56222 st_dur 284 [2-2]
> [   53.170811] ath: phy0: 74:4d:28:14:d9:94 to 288 [62]
> [   54.169095] ath: phy0: rx sample 1054919 [h 3-t 4]
> [   54.169148] ath: phy0: {74:4d:28:14:d9:94} tx sample 1054598 [dur 
> 260][h 3-t 4]
> [   54.169159] ath: phy0: ack_ts 1054919 st_ts 1054598 st_dur 260 [3-3]
> [   54.169169] ath: phy0: 74:4d:28:14:d9:94 to 231 [61]
> [   54.173970] ath: phy0: rx sample 1059800 [h 4-t 5]
> [   54.174024] ath: phy0: {74:4d:28:14:d9:94} tx sample 1059511 [dur 
> 228][h 4-t 5]
> [   54.174035] ath: phy0: ack_ts 1059800 st_ts 1059511 st_dur 228 [4-4]
> [   54.174044] ath: phy0: 74:4d:28:14:d9:94 to 188 [61]
> ...
> [  326.925123] ath: phy0: ACK timeout 156 slottime 76
> ...
> [  653.145142] ath: phy0: ACK timeout 132 slottime 64
> ...
> [  926.928758] ath: phy0: ACK timeout 114 slottime 55
>
> (static optimal value is 28 .. so it will take a lot longer ..)
>
>
> Above log is with an iperf session running in the background. :-s
>
> Will look further into this ..
>
> Regards,
>
> Koen
>
