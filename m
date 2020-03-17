Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2118896C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCQPth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 11:49:37 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:60066 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQPtg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 11:49:36 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2353E13C344;
        Tue, 17 Mar 2020 08:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2353E13C344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1584460176;
        bh=2cUhwfw+SkkrbYReOItECee1wB78xjadHwnsOU7E2Hw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WVGm2aGJTV3tj/T934WUPExMznF/w6JtAOZhyGUD3Y56tZ+pPcJOKpSofLH0gZVPM
         8sCUSUl+u7QVC3z32yYIKBub9P8MmsXDRWHLe4sWf16aRon2mYjyXRjX+x4NnlrYGN
         MoHW8M5La/f8TA+dWhTKSEjAov8bIF59xHD7a/JA=
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Chuang <yhchuang@realtek.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com>
 <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
Date:   Tue, 17 Mar 2020 08:49:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/17/20 8:40 AM, Kalle Valo wrote:
> Tony Chuang <yhchuang@realtek.com> writes:
> 
>> // Add Johannes for commenting on adding another nl80211 commands
>>
>> Kalle Valo <kvalo@codeaurora.org> writes:>
>>
>>> Tony Chuang <yhchuang@realtek.com> writes:
>>>
>>>> Kalle Valo <kvalo@codeaurora.org> writes:
>>>>
>>>>> <yhchuang@realtek.com> writes:
>>>>>
>>>>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>>>>
>>>>>> It is useful to fix the bit rate of TX packets. For example, if
>>>>>> someone is measuring the TX power, or debugging with the issues
>>>>>> of the TX throughput on the field.
>>>>>>
>>>>>> To set the value of fixed rate, one should input corresponding
>>>>>> desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
>>>>>> Set a value larger than DESC_RATE_MAX will disable fix rate, so
>>>>>> the rate adaptive mechanism can resume to work.
>>>>>>
>>>>>> Example,
>>>>>>    To fix rate at MCS 1:
>>>>>>    echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>>>>>>
>>>>>>    To not to fix rate:
>>>>>>    echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>>>>>>
>>>>>>    To know which rate was fixed at:
>>>>>>    cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
>>>>>>
>>>>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>>>
>>>>> No way, debugfs is not a method for working around nl80211 and doing
>>>>> whatever idea you come up with. The goal is that we have a generic
>>>>> nl80211 command for all generic actions, like this one. And I think we
>>>>> already have an nl80211 command for fixing the tx rate, right?
>>>>>
>>>>
>>>> No, as I can see, there's no suitable nl80211 command that can achieve
>>>> what I want. If you are saying about
>>> NL80211_CMD_SET_TX_BITRATE_MASK,
>>>> it's used to allow some rates. But actually the firmware has its own rate
>>>> adaptive mechanism, so mask out the other rates does not mean the rate
>>>> left will be chosen. Moreover, the hardware will choose a lower bit rate
>>>> when retry, then the TX rate is not fixed at all. So the debugfs can disable
>>>> the firmware's RA mechanism, also disable the TX rate fall back when retry.
>>>> Both of them cannot be done by setting TX bitrate mask.
>>>
>>> I'm confused, here you talk about firmware implementation etc but I'm
>>> just talking about replacing the fix_rate debugfs file to an nl80211
>>> command (for providing the fix_rate value). Can you clarify more why you
>>> think nl80211 is not suitable?
>>
>> Oops, I thought that you wanted me to use the existing nl80211
>> command.
> 
> Either use an existing nl80211 command or add a new one if needed. For
> me most important is that we don't add hacks to debugfs just for
> avoiding using nl80211.
> 
>> Now I know that you think we can add a new nl80211 command to help
>> drivers to fix the TX bitrate if necessary. If adding another nl80211
>> command for that is acceptable, I can work on this. But I need
>> Johannes's comment if it's better to add a new nl80211 command or to
>> expand the existing command (ex. NL80211_CMD_SET_TX_BITRATE_MASK).
> 
> _Why_ is NL80211_CMD_SET_TX_BITRATE_MASK not suitable for you? You keep
> saying that but I have still figured out why exactly you think so.
> Please clarify this in detail.
> 
>> It looks like that adding a new nl80211 command will be better for me
>> as expanding the existing one would have great impact on the already
>> distributed drivers/user-tools.
> 
> What kind of great impact are you talking about? Please be specific so
> that we don't need to guess.

At least with ath10k, the issues I found were that nl80211 doesn't like it
when you try to disable all legacy rates (and force frames out at 54Mbps
encoding, for instance).

I'm not even sure upstream ath10k will even let you set a single rate
using normal API now.  Have you tried it?

Another problem is that to keep a connection alive, you probably want mgt
and null-func frames to go out normal and only have the firmware use a particular MCS
for data frames.

Lots of reasons to want a low-level hack for this sort of thing.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

