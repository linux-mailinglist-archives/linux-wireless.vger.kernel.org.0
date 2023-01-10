Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43626664BD1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjAJS7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 13:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbjAJS73 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 13:59:29 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2C9C1C4
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 10:59:27 -0800 (PST)
Message-ID: <f528de6f-2737-8560-3542-051d2d8f3654@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673377165;
        bh=9vZu8eFcHnXhHnFszKmZw1sAxh+JQeBIkJgZJU0WzO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ua6rmBWxcTUl/26UQ6n7dRRq2lq3WzcBmSO5whYW8REHASHL/ssENQZ6OIHwYq0qP
         DhwSUNZRFEtvgiKPU0G4HgHqyDc+BjgYAVxRdtk+7WCDdLpWdBBQ8g5+ib1DDbAKW3
         /M3YuasDG1hpXvF2d0W49sF+RrbhDwgJDmW6N3AU=
Date:   Tue, 10 Jan 2023 19:59:24 +0100
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
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <Y7RdQqBQx58dIMAP@tp440p.steeds.sam>
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

On 03.01.23 17:52, Sicelo wrote:
> Hi Alexander
> 
>>
>> I do not yet see how switching the driver to iTXQ can cause the observed
>> errors. The warnings above happen during scan, which should not be affected
>> by the commit above. So I assume for now that's these are just follow up
>> issues and something is wrong before the error messages we get...
>>
>> But scanning itself is still working for you? You see the networks, just
>> joining them is not working, correct?
> 
> Yes, although later I found that joining does actually work, but takes
> an unusually long time. I later observed that I can even get an IP
> address. However, there is 100% packet loss.
> 
> Accidentally, I stumbled on the fact that if I turn power saving off,
> then it starts working reasonably well. I am not sure what this
> observation suggests though.
> 

Should have seen the potential sooner, but can you please check if the 
following patch fixes the issue?
https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/

This patch seems to be a perfect fit to what you are describing...

FYI:
There is another regression report which has that as a very likely but 
not yet confirmed fix:
https://lore.kernel.org/linux-wireless/7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info/T/#t

(The discussion above has another patch you really want to have when 
AMPDU is supported.)

Alexander
