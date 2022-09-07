Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A005B0DA8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIGUCV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 16:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIGUCM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 16:02:12 -0400
Received: from hm1481-n-164.locaweb.com.br (hm1481-n-164.locaweb.com.br [189.126.112.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6BFA4B16
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 13:02:09 -0700 (PDT)
Received: from mcbain0021.email.locaweb.com.br (201.76.49.41) by hm1481.locaweb.com.br id h33s482n8lgp for <linux-wireless@vger.kernel.org>; Wed, 7 Sep 2022 17:00:04 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.232])
        by mcbain0021.email.locaweb.com.br (Postfix) with ESMTP id 77C9814C01C7;
        Wed,  7 Sep 2022 16:57:04 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 4FE1B4404FD;
        Wed,  7 Sep 2022 17:02:02 -0300 (-03)
Message-ID: <7c7135cb-ee5d-e7f3-45ca-8b7206312512@cesarb.eti.br>
Date:   Wed, 7 Sep 2022 17:02:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Brazil (BR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
 <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
 <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
 <YxiwFLWhsOtJJhrq@do-x1extreme>
Content-Language: en-US
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
In-Reply-To: <YxiwFLWhsOtJJhrq@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Em 07/09/2022 11:52, Seth Forshee escreveu:
> On Fri, Sep 02, 2022 at 07:21:50PM -0300, Cesar Eduardo Barros wrote:
>> Em 02/09/2022 11:53, Johannes Berg escreveu:
>>> On Thu, 2022-09-01 at 20:27 -0300, Cesar Eduardo Barros wrote:
>>>>
>>>> +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
>>>> +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
>>>> +	# requirements, we can extend the range by 5 MHz to make the kernel
>>>> +	# happy and be able to use channel 144.
>>>> +	(5470 - 5730 @ 160), (27), DFS
>>>> +	(5730 - 5850 @ 80), (30)
>>>>
>>>
>>> If you do the latter as 160 as well, and add AUTO-BW, couldn't you split
>>> them at 5725 correctly? But I guess it doesn't matter anyway.
>>
>> This was copied from the US rules (including the four-line comment), which
>> have an identical split. If AUTO-BW worked here, I'd expect the US rules to
>> use it.
> 
> AUTO-BW would work, and we have countries using it for this case. Iirc
> for some countries we move the split to 5730 because even though
> 5725-5730 is at a lower power limit the rules allow channel 144 to be
> used at the power limit for 5710-5725. For the US though I think it's
> just historical -- it was done that way initially, and it isn't
> important enough that anyone has cared to change it.

The only country I found in the database that does it that way is IL, 
and it has the power limits in the opposite direction (its 5470 - 5725 
range has a higher power limit than its 5725 - 5875 range, while for BR 
and US it's the former range which has a lower power limit); looking at 
other countries, AU does the manual adjustment with a comment like US, 
while TW has a 5 MHz overlap on its ranges. So the precedent is not 
enough for me to be confident that using the official split together 
with AUTO-BW would allow using channel 144 (and the 40 MHz and 80 MHz 
channels it's part of).

And the single one which does it using AUTO-BW (IL) doesn't change the 
bandwidth of its 5725 - 5875 to 160; is it really necessary to do that 
change to the bandwidth (considering also that channel 144 is not part 
of a pure 160 MHz channel, it could be used only for 80+80)? What about 
the 5150 - 5250 and 5250 - 5350 ranges, do they need also to be changed 
to 160 so that the combined 5170 - 5330 160 MHz channel can be used, or 
does AUTO-BW allow it even though both ranges are declared as allowing 
just 80 MHz channels? What about 80+80 channels?

> But we do generally try to keep the rules matching the official
> documents as much as possible, so for new rules we should split at 5725
> and use AUTO-BW as Johannes suggested. Could you send a v2 with that
> change?

Well, it's not exactly a new rule (the current database already has a 
5490 - 5730 @ 160 rule), but we could treat it that way since we're 
mostly rewriting them all (and the original didn't say where that came 
from).

Since I'm not certain that AUTO-BW will be interpreted as expected, 
before doing that change, I'll try to see if I can test it first on my 
laptop (by sheer luck, I happen to be using the 5650 - 5730 80 MHz 
channel right now, so I'd just have to see if it still connects at 80 
MHz, assuming I can somehow convince the kernel to load a modified 
file). Or would you prefer me to send the patch first (with or without a 
change in the channel bandwidths)?

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br

