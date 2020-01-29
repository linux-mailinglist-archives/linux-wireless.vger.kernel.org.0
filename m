Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5289F14D19F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgA2UBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 15:01:18 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:54696 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2UBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 15:01:18 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7791C137585;
        Wed, 29 Jan 2020 12:01:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7791C137585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1580328077;
        bh=0WjzaowM731hczakQcivHhJlR8L6RO03Am+V6PFvP1g=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=JB4MfezgXLyz3hrLG+FX5xNa1V9md+VgFdbYV8RSNOCUquIukb/7+VnSkkOVFLXzQ
         yZ+WlHm7tdmdtrDHj0RaV9u3yoo4qDbAdhwEvxfkQUPuWlUnMYGo2f554xiAsSqXth
         xEb5DV7d3Xda/u4x0uAZ9NjICHSQnB+11BUIewHw=
Subject: Re: Strange performance issue when using two devices at once
To:     Marlon Smith <marlon.smith10@gmail.com>,
        linux-wireless@vger.kernel.org
References: <1580323191.26012.48.camel@gmail.com>
 <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
 <1580325769.26012.54.camel@gmail.com>
 <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
 <1580327314.26012.59.camel@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <c8788984-3de0-b41c-e2a1-66b67d0674a6@candelatech.com>
Date:   Wed, 29 Jan 2020 12:01:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580327314.26012.59.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/29/20 11:48 AM, Marlon Smith wrote:
> On Wed, 2020-01-29 at 11:27 -0800, Ben Greear wrote:
>> On 1/29/20 11:22 AM, Marlon Smith wrote:
>>>
>>> On Wed, 2020-01-29 at 10:42 -0800, Ben Greear wrote:
>>>>
>>>> On 1/29/20 10:39 AM, Marlon Smith wrote:
>>>>>
>>>>>
>>>>> Hi everyone,
>>>>>
>>>>> I have two RT5370 devices connected to the same access point.
>>>>> Both
>>>>> devices are very slow, but the instant I disconnect one device,
>>>>> the
>>>>> other speeds up by a factor of 10.
>>>> Out of curiosity, are both of the RT5370 used on the same client
>>>> device?
>>>>>
>>>>> Did you check that they have unique MAC addresses?
>>>>> Thanks,
>>>> Ben
>>>>>
>>>>>>
>>>>>>
>>>>> The really strange part is that one device will perform slowly
>>>>> even
>>>>> if
>>>>> the other device is basically idle! I've confirmed this with a
>>>>> packet
>>>>> sniffer.
>>>>>
>>>>> I've been trying to do some debugging, and I've found that when
>>>>> both
>>>>> devices are connected to the access point, they report a large
>>>>> number
>>>>> of duplicate frames. I added some debug output
>>>>> in ieee80211_rx_h_check_dup() to confirm that this only happens
>>>>> while
>>>>> both devices are connected. The packet sniffer also shows a
>>>>> large
>>>>> number of retries while this is occurring.
>>>>>
>>>>> Using backports 5.3-rc4 for this, but also tested on 4.14-rc2.
>>>>>
>>>>> I did post about this previously on this mailing list (RT5370
>>>>> performance issues), but I thought I'd post again with this new
>>>>> information and more descriptive title. I'm a little bit stuck
>>>>> on
>>>>> this
>>>>> for a while now, so any ideas are much appreciated.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Marlon
>>>>>
>>> They are on separate devices, although the mac addresses are close.
>>> 70:F1:1C:2E:AF:B4 and
>>> 70:F1:1C:2E:AF:B6.
>>>
>>> However, I have a third device 70:F1:1C:2E:AF:BB which performs
>>> well
>>> and does not affect the performance of the other two.
>>>
>> Have you tried a different AP?
>>
>> And also tried using the exact same MAC addresses configured on a
>> different
>> radio (like ath9k)?
>>
>> Thanks,
>> Ben
>>
>>
> 
> I have tried a different access point in a different environment but no
> luck. I'll see if I can configure my laptop to use one of the
> problematic devices' mac address.

It might be tricky to determine, but if you can notice whether one of your station devices
is (block-)acking the other's frames, that would be a good clue that it is a station
side bug.  A carefully inspected sniff, especially if you can put sniffer near one station
and far from the other and so use RSSI as a sorting factor, should allow you to determine
this.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

