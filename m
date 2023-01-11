Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E166623F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 18:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjAKRo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 12:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjAKRoI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 12:44:08 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AF1868F
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 09:44:05 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFf8s-0001z2-GB; Wed, 11 Jan 2023 18:44:02 +0100
Message-ID: <df34778b-3bae-f4dd-32dd-b874654e6fbe@leemhuis.info>
Date:   Wed, 11 Jan 2023 18:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1
Content-Language: en-US, de-DE
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Sicelo <absicsz@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
 <a115fbb8-1048-9ae9-fcfb-ac1fd7d33449@wetzel-home.de>
 <Y7RdQqBQx58dIMAP@tp440p.steeds.sam>
 <f528de6f-2737-8560-3542-051d2d8f3654@wetzel-home.de>
 <Y723mvhkubsvuA3R@tp440p.steeds.sam>
 <6a21d548-9833-0f4d-c3fe-61e28fc66da5@wetzel-home.de>
 <be5db3aa-d284-f77c-9870-a702633a5a2a@wetzel-home.de>
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <be5db3aa-d284-f77c-9870-a702633a5a2a@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673459046;40ff94b9;
X-HE-SMSGID: 1pFf8s-0001z2-GB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11.01.23 17:49, Alexander Wetzel wrote:
> For regression tracking only:
> 
> +CC regressions@lists.linux.dev
> 
> Issue is solved with a patch already on the way into mainline.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230111&id=4444bc2116aecdcde87dce80373540adc8bd478b
> 
> Issue was found and fixed independently of the regression report, so no
> regression tags in the commit.

Happens, thx for letting me know. Now regzbot will know about it as well:

#regzbot fix: wifi: mac80211: Proper mark iTXQs for resumption

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> On 11.01.23 17:21, Alexander Wetzel wrote:
>> On 10.01.23 20:08, Sicelo wrote:
>>> Hello
>>>
>>> On Tue, Jan 10, 2023 at 07:59:24PM +0100, Alexander Wetzel wrote:
>>>> Should have seen the potential sooner, but can you please check if the
>>>> following patch fixes the issue?
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
>>>>
>>>> This patch seems to be a perfect fit to what you are describing...
>>>>
>>>
>>> Yes, someone pointed me to this patch a day ago, and it does fix the
>>> issue indeed.
>>>
>>> Apologies for not responding sooner.
>>>
>> That was fast:-)
>> Thanks for testing and reporting back.
>>
>>>> FYI:
>>>> There is another regression report which has that as a very likely
>>>> but not
>>>> yet confirmed fix:
>>>> https://lore.kernel.org/linux-wireless/7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info/T/#t
>>>>
>>>> (The discussion above has another patch you really want to have when
>>>> AMPDU
>>>> is supported.)
>>>>
>>>
>>> I will give this a try as well during the course of the week. I noticed
>>> the speeds were low, but that could just be the weak hardware itself
>>> (1x600MHz ARM CPU), and I have not had time to compare performance from
>>> before the commits in question.
>>
>> Please keep me posted on the outcome. I expect no relevant change but
>> then I did not test the patch on weak HW so far...
>>
>> Alexander
>>
>>
> 
> 
> 
