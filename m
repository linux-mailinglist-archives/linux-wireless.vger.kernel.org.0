Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE5742AD3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjF2Qu3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2Qu2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 12:50:28 -0400
Received: from wp530.webpack.hosteurope.de (unknown [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1CC30F1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 09:50:26 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qEuqR-0002Ke-10; Thu, 29 Jun 2023 18:50:11 +0200
Message-ID: <0d3db91c-f071-009a-952a-bd109b16a352@leemhuis.info>
Date:   Thu, 29 Jun 2023 18:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwlwifi: AX201 misdetected as AX101
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
 <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com>
 <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info>
 <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688057426;cfafd738;
X-HE-SMSGID: 1qEuqR-0002Ke-10
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29.06.23 17:28, Barnabás Pőcze wrote:
> 2023. június 29., csütörtök 13:31 keltezéssel, Thorsten Leemhuis <regressions@leemhuis.info> írta:
>> On 27.06.23 23:55, Barnabás Pőcze wrote:
>>> 2023. május 26., péntek 19:55 keltezéssel, Barnabás Pőcze <pobrn@protonmail.com> írta:
>>>> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has the following intel wireless chip:
>>>>
>>>>    Device:	00:14.3
>>>>     Class:	Network controller [0280]
>>>>    Vendor:	Intel Corporation [8086]
>>>>    Device:	Wi-Fi 6 AX201 [a0f0]
>>>>   SVendor:	Intel Corporation [8086]
>>>>   SDevice:	Wi-Fi 6 AX201 [0244]
>>>>       Rev:	20
>>>>    ProgIf:	00
>>>>    Driver:	iwlwifi
>>>>    Module:	iwlwifi
>>>>
>>>> However, in the kernel message buffer, the following message is written:
>>>>
>>>>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=0x351

Gregory who is CCed since the start of the thread might care to look
into this. According to a quick search lspci is right, but this needs
expects. Maybe it's just a cosmetic problem.

>>> [...]
>>> For the record, I have done a git-bisect[1], and that turned up
>>>   d2ccc5c1526396aef5196e4dd2ec8538994e5072
>>>
>>> as the first good commit[0].
>>>
>>> Sadly, that patch (or even the series) does not appear to be easily backportable,
>>> so it seems likely that current stable kernels won't be able to support this device.
>>
>> Thx for bisecting.
>>
>> Thing is: 6.3 will be EOL in about two or three weeks anyway. And Arch
>> will likely switch to 6.4 (which works -- or did I get this wrong?)
>> within a week or two. Makes be wonder if it's the best solution for
>> everyone involved to not resolve this and move on.
> 
> Yes, 6.4 seems to work.

#regzbot inconclusive: unlikely to be fixed in 6.3 before EOL, but 6.4 works

> I mainly meant LTS releases.  Nonetheless, lspci
> and iwlwifi still disagree on what device it actually is.

Not sure if I properly understand this.

Is this broken in 6.1.y as well, but working in earlier kernels? Then it
needs a separate report.

Or do you mean the disagreement? Maybe mentioning Gregory's name above
will do the trick to make the Intel folks look into this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
