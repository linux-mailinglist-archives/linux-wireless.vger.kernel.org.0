Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D660116333
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 18:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLHR0l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 12:26:41 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56398 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHR0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 12:26:41 -0500
Received: from [192.168.1.47] (unknown [50.34.171.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5A4EB137531;
        Sun,  8 Dec 2019 09:26:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5A4EB137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575826001;
        bh=HgELKjbbZATAnBgNbHxbmwenRadf0P0DGiSuXm6It8s=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=S/sn0sBW+8lMaQzbuf7raRyCFySzsq3IAu2E4e/Q8jNc0dcKetUxhimkLrp2zNI+2
         yZ3eXpGW829I4oW64tWnzVouhrniiC1gGZFXLzifIPgzAtE8KTmDLyibu8+TpLHTA/
         adGwFs+mNeBpbwnH7cQ9sC6fEpb1Q8tyyl2MWfiQ=
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
 <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
 <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
 <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
 <9bcbab4b562669b96198c632f476b1b74956ca09.camel@sipsolutions.net>
 <336996e4-d9fe-bf3a-72fb-6919bd0adcbf@candelatech.com>
 <c2004c4d9defd9c391e072b2703a845185bd395e.camel@sipsolutions.net>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <ed9ae122-7573-a15e-7c42-7ae1fe3d123d@candelatech.com>
Date:   Sun, 8 Dec 2019 09:26:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <c2004c4d9defd9c391e072b2703a845185bd395e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/07/2019 12:09 PM, Johannes Berg wrote:
> On Fri, 2019-12-06 at 15:44 -0800, Ben Greear wrote:
>> I did some tests today:
>>
>> kernel is 5.2.21+, with the fix for ax200 upload corruption bug.
>> AP is QCA 9984 based PC (i5 processor) running ath10k-ct firmware/driver, configured for 2x2 160Mhz
>> STA is PC (i5 processor) with AX200
>> OTA, about 5 feet apart
>> AP reports STA is sending at MCS-9 160Mhz (AX200 STA does not report tx rate it seems)
>
> Yeah, that was an oversight for HE, it should work for HT/VHT. I have a
> patch in the works to report the TX rate properly in iw.

I'm connecting to an /AC AP, so it should only be using VHT rates.  I'm on 5.2-ish
kernel, so maybe it is already fixed in more recent ones?

>
>> Our LANforge tool is traffic generator, running directly on AP and STA machine.
>>
>> Download UDP, I see about 697Mbps goodput
>> Upload UDP, I see about 120Mbps goodput
>>
>> TCP download, about 660Mbps
>> TCP upload, about 99Mbps
>>
>> Our hacked version of pktgen, bps includes down to Ethernet frame:
>> Download: 740Mbps
>> Upload: 129Mbps
>
> Uh, wow, that's not good. I guess after I'm done with this bug, I should
> look at upstream ...
>
>> I changed AP to 80Mhz mode, and re-ran the UDP tests:
>>
>> Upload 137Mbps
>> Download 689Mbps
>>
>> Though not confirmed today, one of us reports about 1.7Gbps download on AX200 against an enterprise /AX AP,
>> and only abuot 600Mbps upload in that same system.  That is in isolation chamber and such.
>>
>> So, for whatever reason(s), we see consistent poor upload performance on AX200.
>>
>> For reference, we have previously seen about 1.1Gbps upload between QCA9984 station and 4x4 /AC APs
>> (and about 1.3Gbps download goodput), so in general, wifi upload can run faster.
>
> Yes, for sure it can. Would be interesting to find out what the limiting
> factor is for you.
>
> Then again, I doubt we've released updated firmware recently - what
> version are you using?

It is 48-something, whatever comes with Fedora-30.  We'd be happy to test more
recent firmware...maybe you could make them available somewhere?

And if you can provide release notes for the firmware, you get +1 damage vs QCA :P

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
