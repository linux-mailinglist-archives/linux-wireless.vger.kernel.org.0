Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA36660F3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 17:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjAKQtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 11:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjAKQtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 11:49:50 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D201251
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 08:49:49 -0800 (PST)
Message-ID: <be5db3aa-d284-f77c-9870-a702633a5a2a@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673455788;
        bh=3gBG7uUsoBr9fO73rxmVw1Zcrehn8lfWRiEhF87wpME=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=WIIEJQHnWbAOftFYs18GkYkfsR9dZdPE2s22KuBN46jv4JWjxWiFRzVbjFpYymBRN
         JdCt1lcBQcpfFrR3+6AZvZ0H8jMT/qvG6ZjO2U3p+K7dyk/SEcQ4jZw/CeZDzn+HMk
         XyfwkT4ZU5xnaqBVQnwHaVFYglQ5+XOUyLhS2N3c=
Date:   Wed, 11 Jan 2023 17:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Sicelo <absicsz@gmail.com>
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
In-Reply-To: <6a21d548-9833-0f4d-c3fe-61e28fc66da5@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For regression tracking only:

+CC regressions@lists.linux.dev

Issue is solved with a patch already on the way into mainline.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230111&id=4444bc2116aecdcde87dce80373540adc8bd478b

Issue was found and fixed independently of the regression report, so no 
regression tags in the commit.

On 11.01.23 17:21, Alexander Wetzel wrote:
> On 10.01.23 20:08, Sicelo wrote:
>> Hello
>>
>> On Tue, Jan 10, 2023 at 07:59:24PM +0100, Alexander Wetzel wrote:
>>> Should have seen the potential sooner, but can you please check if the
>>> following patch fixes the issue?
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
>>>
>>> This patch seems to be a perfect fit to what you are describing...
>>>
>>
>> Yes, someone pointed me to this patch a day ago, and it does fix the
>> issue indeed.
>>
>> Apologies for not responding sooner.
>>
> That was fast:-)
> Thanks for testing and reporting back.
> 
>>> FYI:
>>> There is another regression report which has that as a very likely 
>>> but not
>>> yet confirmed fix:
>>> https://lore.kernel.org/linux-wireless/7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info/T/#t
>>>
>>> (The discussion above has another patch you really want to have when 
>>> AMPDU
>>> is supported.)
>>>
>>
>> I will give this a try as well during the course of the week. I noticed
>> the speeds were low, but that could just be the weak hardware itself
>> (1x600MHz ARM CPU), and I have not had time to compare performance from
>> before the commits in question.
> 
> Please keep me posted on the outcome. I expect no relevant change but 
> then I did not test the patch on weak HW so far...
> 
> Alexander
> 
> 

