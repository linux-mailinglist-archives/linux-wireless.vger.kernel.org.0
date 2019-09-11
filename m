Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A67B0473
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfIKTKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 15:10:32 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:50498 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728415AbfIKTKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 15:10:32 -0400
Received: from [71.219.36.120] (port=5964 helo=[10.168.3.100])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@timhiggins.com>)
        id 1i880c-0005pF-Uy; Wed, 11 Sep 2019 14:10:31 -0500
Cc:     tim@timhiggins.com
Subject: Re: Question on Intel AX200
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
 <ebe5532f-f456-2534-cd5e-c44d4c43696b@timhiggins.com>
 <CAM0KTbDS3FpGkdTB7J5PKNyjC809d6tt1E8aQE5D8d1ya-Y78Q@mail.gmail.com>
From:   Tim Higgins <tim@timhiggins.com>
Message-ID: <6e9ad429-2a0b-37a8-4767-c5a036f77567@timhiggins.com>
Date:   Wed, 11 Sep 2019 15:10:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAM0KTbDS3FpGkdTB7J5PKNyjC809d6tt1E8aQE5D8d1ya-Y78Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - roobidoo.pudai.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - timhiggins.com
X-Get-Message-Sender-Via: roobidoo.pudai.com: authenticated_id: tim@timhiggins.com
X-Authenticated-Sender: roobidoo.pudai.com: tim@timhiggins.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>> On 9/11/2019 9:49 AM, Ben Greear wrote:
>>> Hello,
>>>
>>> Does anyone know how well AX200 currently supports:
>>>
>>> OFDMA
>>>
>>> MU-MIMO (receiver)
>>>
>>> AP Mode
>>>
>>> And, can anyone suggest a good /AX AP to test against for these features?
>>>
>>> Thanks,
>>> Ben
>>>
>> Hi Ben,
>> I've been doing a lot of testing with the AX200 as a STA and sniffer, focusing on trying to see
>> if OFDMA lives up to its advertised features. This topic is probably not of interest to this
>> general list, so I'm happy to take the discussion to one-on-one.
>>
>> Tim
I'll provide a brief summary and anyone interested can follow up directly with me.

My focus is on the consumer Wi-Fi space, so I can't speak for Enterprise grade gear.
In that space, the only products that currently have OFDMA enabled are the ASUS RT-AX88U 
(Broadcom platform),  NETGEAR RAX120 (Qualcomm platform) and Arris SURFboard mAX PRO and 
SURFboard mAX PLUS. I have looked at the ASUS and NETGEAR, but don't have the Arris in hand.

Engenius' EWS357AP (Qualcomm platform) also has OFDMA enabled. I'm not sure of the state of 
publicly released firmware. I tried a few firmware versions and the results were not very good. 
So I've set that one aside for now.

The ASUS has beta code that the company says supports OFDMA DL in 5 GHz best, uplink no so much 
and 2.4 GHz is not stable.

The NETGEAR supports OFDMA in both 2.4 and 5 GHz, but downlink only.

There is no product I know of that supports DL and UL OFDMA in both bands.

I've been using four Samsung S10e's as my STAs to run traffic to using iperf3. I also have a few 
Intel AX200's on ASUS mini ITX boards and one on an ASUS pico ITX board. Right now, the AX200 is 
used mainly for capture. Thanks to help from Johannes, I got the debug kernel capability working 
that allows capturing individual AIDs. So I can capture OFDMA data frames and, of course, HE 
management and trigger frames.

An ongoing issue is that I'm not sure what I'm supposed to be seeing when sniffing OFDMA DL and 
UL traffic. The DL OFDMA and UL OFDMA sequences described in David Coleman's Aerohive blog 
posts, which are also in the CWNA 5th Edition Study Guide that David co-authored, have yet to be 
seen.
https://blog.aerohive.com/dl-ofdma/
https://blog.aerohive.com/uplink-orthogonal-division-multiple-access-ul-ofdma-in-802-11ax/

So I don't even know if the products I'm testing are implementing "proper" OFDMA.

I've yet to see OFDMA's key features of higher efficiency and lower latency using simple TCP/IP 
traffic and ping. There are many moving parts on both AP and STA...this is going to take awhile 
to sort out.


