Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C023B0F25
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFVVEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFVVEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 17:04:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244CAC061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 14:01:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n20so578670edv.8
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DfxZ8O/bWJfZv0+NqRHZSYO3xZTIdwYfJrzqY7LfZpQ=;
        b=l4hHcLRmVyZjWfWCjMrV8zXfXZzXUpjXXji69Tz8BK7n+CzWnYKytyF2UgE4iaNefd
         aV3SzJPwjt3rqJhKZghuIHc54mzWnVtyiECFzYCPAZSrBwIeGCnCkBCb2GQw3WFmAtWa
         moYgSfZR4O7Yb/wgRazoc6Qlmv4lwdKNgjIhlDnri0lPI7PK8YeTySVnnfNXYojxRARl
         UFkJBTDbHHpu1/yMNCnVGARpYohsmR9epicnGDdgAuMV6qS9w8oY5uJCqGlZ+UdUKs8d
         J/Xrllxh+fdI+DvH3yqDlVAzlkxcLgAuwGFqaQq6ELOzQTpfPLxgfGAy7EDZk8WqRnqT
         kPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DfxZ8O/bWJfZv0+NqRHZSYO3xZTIdwYfJrzqY7LfZpQ=;
        b=NNFNzs1UBkluTSjdZnjSZ3xHej0yxoyo/B2JnXoZPDxuYMuYRradehFNWHEVueg/E9
         Hu+NYdkWjSHFhrNJH7RDiYT9e6x9hVlEqAX8Mx/F5QcqGUT4IC/gXGqZgUPJV75dvlD/
         B79XM4x4SP35n4+qNzWHXODn+tnYs9RGs8MXfD25NttUwhllxPvJwnU3b2xJOJDhmj/n
         iFy01HJ/H/NsFiC6BZuk79kvVXg59LpQUzTVYc1eesPeBy4oaW/XMhwCfoDptinvHcOc
         l8DC1zVDCG+31wpn487r5XZnBZ0aS2b8LsQuk30saJjOaxxjDZHdqVK0scanpjCpww++
         L5gg==
X-Gm-Message-State: AOAM531C+vi9vaYbEwsu39s1oNZFlbA9ic7CUF/QB3Es2GoxcYDOpQ/S
        CR6RoP5d1Vf9MusRfSgIdk0XAQAgxxNTD1d7
X-Google-Smtp-Source: ABdhPJyLROS3L0Y2KZ/HDVYD9+7G7djdnBoOtzqHAilNViaPjoHDDRizmp34Y4Y7BS/kG07uZxfYPw==
X-Received: by 2002:a50:eb8c:: with SMTP id y12mr7684862edr.189.1624395702612;
        Tue, 22 Jun 2021 14:01:42 -0700 (PDT)
Received: from [192.168.5.225] (178-116-168-169.access.telenet.be. [178.116.168.169])
        by smtp.gmail.com with ESMTPSA id u17sm6817041edt.67.2021.06.22.14.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:01:42 -0700 (PDT)
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
Message-ID: <f33b7ef5-8921-fc4c-26e0-cba6d2a1ff1b@citymesh.com>
Date:   Tue, 22 Jun 2021 23:01:38 +0200
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
Great!

Thanks for the details.
i'll have a look at it.

I can't comment for the iw part.

Regards,

Koen

