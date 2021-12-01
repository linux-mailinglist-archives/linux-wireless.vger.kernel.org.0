Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1F4648E0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 08:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbhLAHhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 02:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhLAHhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 02:37:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948ADC061574;
        Tue, 30 Nov 2021 23:34:14 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1msK83-0000cS-8F; Wed, 01 Dec 2021 08:34:11 +0100
Message-ID: <915c3760-181e-bbac-aec4-1e20d0dab2a9@leemhuis.info>
Date:   Wed, 1 Dec 2021 08:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        regressions@lists.linux.dev, mhi <mhi@lists.linux.dev>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <877df6tlnq.fsf@codeaurora.org>
 <CAMZdPi8P7YZPhPir+WfS3cY_a7He1m2Pq2uqBhczPdEeoNRb0Q@mail.gmail.com>
 <87a6jl9ndo.fsf@codeaurora.org> <87ee8hgqni.fsf@codeaurora.org>
 <20211021100305.GD7580@workstation> <20211118174145.GA31300@thinkpad>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
In-Reply-To: <20211118174145.GA31300@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638344054;e5ab82bc;
X-HE-SMSGID: 1msK83-0000cS-8F
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking, this time
looking for a status update.

On 18.11.21 18:41, Manivannan Sadhasivam wrote:
> On Thu, Oct 21, 2021 at 03:33:05PM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Oct 19, 2021 at 03:12:01PM +0300, Kalle Valo wrote:
>>> Kalle Valo <kvalo@codeaurora.org> writes:
>>>
>>>> (adding the new mhi list, yay)
>>>>
>>>> Hi Loic,
>>>>
>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>
>>>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>>>
>>>>>>> On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>>>
>>>>>>>> At the moment I'm running my tests with commit 020d3b26c07a reverted and
>>>>>>>> everything works without problems. Is there a simple way to fix this? Or
>>>>>>>> maybe we should just revert the commit? Commit log and kernel logs from
>>>>>>>> a failing case below.
>>>>>>>
>>>>>>> Do you have log of success case?
>>>>>>
>>>>>> A log from a successful case in the end of email, using v5.15-rc1 plus
>>>>>> revert of commit 020d3b26c07abe27.
>>>>>>
>>>>>>> To me, the device loses power, that is why MHI resuming is failing.
>>>>>>> Normally the device should be properly recovered/reinitialized. Before
>>>>>>> that patch the power loss was simply not detected (or handled at
>>>>>>> higher stack level).
>>>>>>
>>>>>> Currently in ath11k we always keep the firmware running when in suspend,
>>>>>> this is a workaround due to problems between mac80211 and MHI stack.
>>>>>> IIRC the problem was something related MHI creating struct device during
>>>>>> resume or something like that.
>>>>>
>>>>> Could you give a try with the attached patch? It should solve your
>>>>> issue without breaking modem support.
>>>>
>>>> Sorry for taking so long, but I now tested your patch on top of
>>>> v5.15-rc3 and, as expected, everything works as before with QCA6390 on
>>>> NUC x86 testbox.
>>>>
>>>> Tested-by: Kalle Valo <kvalo@codeaurora.org>
>>>
>>> I doubt we will find enough time to fully debug this mhi issue anytime
>>> soon. Can we commit Loic's patch so that this regression is resolved?
>>>
>>
>> Sorry no :( Eventhough Loic's patch is working, I want to understand the
>> issue properly so that we could add a proper fix or patch the firmware
>> if possible.
>>
>> Let's try to get the debug logs as I requested.
> 
> I'm able to reproduce the issue on my NUC. I'm still investigating on how to
> properly fix this issue. Expect a patch soon.

Was there some progress? This issue was reported 75 days ago and still
is not fixed. From the point of the Linux kernel regression tracker I'd
say: it should not take this long. Looking back at it I wonder if
'reverted the culprit and reapply later together with a proper fix'
would have been the better strategy. I wonder if that still would be the
best way forward if no patch is forthcoming soon.

Ciao, Thorsten

#regzbot poke

>>> At the moment I'm doing all my regression testing with commit
>>> 020d3b26c07abe27 reverted. That's a risk, I would prefer to do my
>>> testing without any hacks.
>>>
>>> -- 
>>> https://patchwork.kernel.org/project/linux-wireless/list/
>>>
>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave they thus might sent someone reading this down the
wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.
