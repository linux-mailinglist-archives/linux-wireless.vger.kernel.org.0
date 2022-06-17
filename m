Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA354F11C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379788AbiFQGjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiFQGjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 02:39:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C656F9E
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 23:39:03 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o25d9-0005uy-Rs; Fri, 17 Jun 2022 08:38:55 +0200
Message-ID: <28d2123f-65ce-f69c-12e1-f672b26225f4@leemhuis.info>
Date:   Fri, 17 Jun 2022 08:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Bug 215635 - iwlwifi: Firmware crash with firmware 36.ca7b901d.0
 (8265-36.ucode)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, golan.ben.ami@intel.com,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Udo Steinberg <udo@hypervisor.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info>
 <20220616115808.141dec76@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220616115808.141dec76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655447943;843236fb;
X-HE-SMSGID: 1o25d9-0005uy-Rs
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CCing Gregory, which became iwlwifi maintainer inbetween.

On 16.06.22 20:58, Jakub Kicinski wrote:
> On Mon, 14 Mar 2022 12:51:38 +0100 Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker.
>>
>> I noticed a regression report in bugzilla.kernel.org that afaics isn't
>> properly handled, that's why I decided to forward it to the lists and a
>> few relevant people to the CC. To quote from
>> https://bugzilla.kernel.org/show_bug.cgi?id=215635 :

BTW, Udo recently confirmed there that the issue still happens on 5.18.

>>> Seeing the following firmware crash frequently with
>>> firmware-version: 36.ca7b901d.0 8265-36.ucode
>>>
>>> [...]
>>>
>>> Afterwards iwlwifi is entirely unusable, i.e. the hardware does not recover.  
>>
>>> I have not been able to observe the problem with 5.15.x so far.
>>>
>>> The problem manifests either by Wi-Fi becoming entirely unresponsive (not even ping to gateway works anymore) or by producing a firmware crash.
>>>
>>> In response to #3, the problem was most recently observed as a firmware crash on Linux 5.16.13. HW is Intel Corporation Wireless 8265 / 8275 (rev 78) (Windstorm Peak) and firmware version 36.ca7b901d.0 8265-36.ucode.
>>>
>>> I'm attaching the dmesg output from 5.16.13 (with the TWT patch mentioned above applied) which includes a firmware crash.  
>>
>> Could somebody take a look into this? Or was this discussed somewhere
>> else already? Or even fixed?
> 
> Any progress / outputs on this one? Folks are reporting it's still
> happening on Fedora 36 w/ 5.17.13.

Jakub, thx for bringing this up, I had "look  into this again" on my
todo list for some time already. Out of interest: where where those reports?

Besides the one the quoted mail is about
(https://bugzilla.kernel.org/show_bug.cgi?id=215635 ) I'm aware of two
other reports that look similar and might or might not be related (hard
to tell without domain knowledge, I guess it might be just similar
symptoms):

https://bugzilla.kernel.org/show_bug.cgi?id=215697
https://bugzilla.kernel.org/show_bug.cgi?id=215789

Gregory, are you aware of these regressions? Is anyone working on them?
Or is this faulty hw or something like that?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
