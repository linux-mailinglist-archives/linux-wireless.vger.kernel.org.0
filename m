Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F844E5A3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhKLLjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 06:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhKLLjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 06:39:13 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81774C061766;
        Fri, 12 Nov 2021 03:36:22 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mlUqw-0005bg-KI; Fri, 12 Nov 2021 12:36:18 +0100
Message-ID: <be20e91d-9285-b044-e415-c3728c399c1b@leemhuis.info>
Date:   Fri, 12 Nov 2021 12:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
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
 <20211021100305.GD7580@workstation>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
In-Reply-To: <20211021100305.GD7580@workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636716982;60c2b5c2;
X-HE-SMSGID: 1mlUqw-0005bg-KI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21.10.21 12:03, Manivannan Sadhasivam wrote:
> On Tue, Oct 19, 2021 at 03:12:01PM +0300, Kalle Valo wrote:
>> Kalle Valo <kvalo@codeaurora.org> writes:
>>> (adding the new mhi list, yay)
>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>> Loic Poulain <loic.poulain@linaro.org> writes:
>>>>>> On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>>>> At the moment I'm running my tests with commit 020d3b26c07a reverted and
>>>>>>> everything works without problems. Is there a simple way to fix this? Or
>>>>>>> maybe we should just revert the commit? Commit log and kernel logs from
>>>>>>> a failing case below.
>>>>>>
>>>>>> Do you have log of success case?
>>>>>
>>>>> A log from a successful case in the end of email, using v5.15-rc1 plus
>>>>> revert of commit 020d3b26c07abe27.
>>>>>
>>>>>> To me, the device loses power, that is why MHI resuming is failing.
>>>>>> Normally the device should be properly recovered/reinitialized. Before
>>>>>> that patch the power loss was simply not detected (or handled at
>>>>>> higher stack level).
>>>>>
>>>>> Currently in ath11k we always keep the firmware running when in suspend,
>>>>> this is a workaround due to problems between mac80211 and MHI stack.
>>>>> IIRC the problem was something related MHI creating struct device during
>>>>> resume or something like that.
>>>>
>>>> Could you give a try with the attached patch? It should solve your
>>>> issue without breaking modem support.
>>>
>>> Sorry for taking so long, but I now tested your patch on top of
>>> v5.15-rc3 and, as expected, everything works as before with QCA6390 on
>>> NUC x86 testbox.
>>>
>>> Tested-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> I doubt we will find enough time to fully debug this mhi issue anytime
>> soon. Can we commit Loic's patch so that this regression is resolved?
> 
> Sorry no :( Eventhough Loic's patch is working, I want to understand the
> issue properly so that we could add a proper fix or patch the firmware
> if possible.

Lo, this is your Linux kernel regression tracker speaking!

> Let's try to get the debug logs as I requested.

That was 3 weeks ago. Afaics nothing happened since then (except the
other mail about this on the same day in this thread). Or did I miss
anything? And if not: How can we get the ball rolling somehow again to
get this regression finally fixed?

Ciao, Thorsten (carrying his Linux kernel regression tracker hat)

P.S.: I have no personal interest in this issue and watch it using
regzbot. Hence feel free to exclude me on further messages in this
thread, as I'm only posting this mail to hopefully get a status update
and things rolling again.

#regzbot poke

>> At the moment I'm doing all my regression testing with commit
>> 020d3b26c07abe27 reverted. That's a risk, I would prefer to do my
>> testing without any hacks.
>>
>> -- 
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
> 
