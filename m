Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D866605E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjAKQZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjAKQY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 11:24:58 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3219C37264
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 08:21:43 -0800 (PST)
Message-ID: <6a21d548-9833-0f4d-c3fe-61e28fc66da5@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673454081;
        bh=VWt5AYLXVTmAXTgImJ2cEZoIbpH6gq5PDL3oJnT+zEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BzuPKPG8Sesc9TiOx/C+3fGtBrnjG1Mg5NG4JbisATiOgthRGLK981PebIb82Qaun
         Hd2AHNJP0SbXQ42KQq3cCkgxmKpcx2HVzvwaLxSq747OhZnUCwhHCUVEfcX7t7XP7D
         yT1aTtesBs/VOxThNyLslYnS0blKKP6DvDj+rLEM=
Date:   Wed, 11 Jan 2023 17:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: WLAN broken on Nokia N900 with v6.2-rc1
Content-Language: en-US
To:     Sicelo <absicsz@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam>
 <a115fbb8-1048-9ae9-fcfb-ac1fd7d33449@wetzel-home.de>
 <Y7RdQqBQx58dIMAP@tp440p.steeds.sam>
 <f528de6f-2737-8560-3542-051d2d8f3654@wetzel-home.de>
 <Y723mvhkubsvuA3R@tp440p.steeds.sam>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <Y723mvhkubsvuA3R@tp440p.steeds.sam>
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

On 10.01.23 20:08, Sicelo wrote:
> Hello
> 
> On Tue, Jan 10, 2023 at 07:59:24PM +0100, Alexander Wetzel wrote:
>> Should have seen the potential sooner, but can you please check if the
>> following patch fixes the issue?
>> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
>>
>> This patch seems to be a perfect fit to what you are describing...
>>
> 
> Yes, someone pointed me to this patch a day ago, and it does fix the
> issue indeed.
> 
> Apologies for not responding sooner.
> 
That was fast:-)
Thanks for testing and reporting back.

>> FYI:
>> There is another regression report which has that as a very likely but not
>> yet confirmed fix:
>> https://lore.kernel.org/linux-wireless/7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info/T/#t
>>
>> (The discussion above has another patch you really want to have when AMPDU
>> is supported.)
>>
> 
> I will give this a try as well during the course of the week. I noticed
> the speeds were low, but that could just be the weak hardware itself
> (1x600MHz ARM CPU), and I have not had time to compare performance from
> before the commits in question.

Please keep me posted on the outcome. I expect no relevant change but 
then I did not test the patch on weak HW so far...

Alexander


