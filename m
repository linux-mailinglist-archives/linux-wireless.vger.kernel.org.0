Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246A95B4281
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 00:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIIW3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIIW3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 18:29:38 -0400
Received: from hm1480-13.locaweb.com.br (hm1480-13.locaweb.com.br [201.76.49.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49BD113CEC
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 15:29:34 -0700 (PDT)
Received: from mcbain0012.email.locaweb.com.br (189.126.112.16) by hm1480-1.locaweb.com.br id h3ev42169rk4 for <linux-wireless@vger.kernel.org>; Fri, 9 Sep 2022 19:29:17 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.204])
        by mcbain0012.email.locaweb.com.br (Postfix) with ESMTP id 5103E8C08CB;
        Fri,  9 Sep 2022 19:29:19 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 362024A0D86;
        Fri,  9 Sep 2022 19:29:27 -0300 (-03)
Message-ID: <e55819d3-cc2f-23ac-4b40-bdd1fd8e6b68@cesarb.eti.br>
Date:   Fri, 9 Sep 2022 19:29:26 -0300
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
 <7c7135cb-ee5d-e7f3-45ca-8b7206312512@cesarb.eti.br>
 <Yxs9pmL7Efl+EPxe@do-x1extreme>
Content-Language: en-US
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
In-Reply-To: <Yxs9pmL7Efl+EPxe@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Em 09/09/2022 10:20, Seth Forshee escreveu:
> On Wed, Sep 07, 2022 at 05:02:01PM -0300, Cesar Eduardo Barros wrote:
> 
>> And the single one which does it using AUTO-BW (IL) doesn't change the
>> bandwidth of its 5725 - 5875 to 160; is it really necessary to do that
>> change to the bandwidth (considering also that channel 144 is not part of a
>> pure 160 MHz channel, it could be used only for 80+80)? What about the 5150
>> - 5250 and 5250 - 5350 ranges, do they need also to be changed to 160 so
>> that the combined 5170 - 5330 160 MHz channel can be used, or does AUTO-BW
>> allow it even though both ranges are declared as allowing just 80 MHz
>> channels? What about 80+80 channels?
> 
> You cannot change the bandwidth for 5725 - 5875 to 160; the kernel will
> reject the rule since a 160 MHz channel doesn't fit in the range. The
> kernel might still allow a 160 MHz channel though. I haven't looked at
> this code in quite some time and it's pretty convoluted, but some of the
> code does calculate a max bandwidth based on what will fit when dealing
> with AUTO-BW rules.

I took a quick peek at the kernel code, and I also saw the validation 
logic which would reject that 160 MHz rule.

 From my quick look, it seems that it would set a NO-160MHZ flag in the 
rule, which would then propagate to each 20MHz sub-channel, and probably 
would lead to it rejecting the use of the whole as a 160MHz channel; but 
there's also the 80+80 mode, which would still be allowed (and I vaguely 
recall seeing somewhere that adjacent 80+80 was prefered over 160 for 
some reason).

> 
>>> But we do generally try to keep the rules matching the official
>>> documents as much as possible, so for new rules we should split at 5725
>>> and use AUTO-BW as Johannes suggested. Could you send a v2 with that
>>> change?
>>
>> Well, it's not exactly a new rule (the current database already has a 5490 -
>> 5730 @ 160 rule), but we could treat it that way since we're mostly
>> rewriting them all (and the original didn't say where that came from).
>>
>> Since I'm not certain that AUTO-BW will be interpreted as expected, before
>> doing that change, I'll try to see if I can test it first on my laptop (by
>> sheer luck, I happen to be using the 5650 - 5730 80 MHz channel right now,
>> so I'd just have to see if it still connects at 80 MHz, assuming I can
>> somehow convince the kernel to load a modified file). Or would you prefer me
>> to send the patch first (with or without a change in the channel
>> bandwidths)?
> 
> I'd be interested in your results, especially if there's any way you
> could test at 160 MHz bandwidth since the AUTO-BW code in the kernel is
> hard to follow. Getting the kernel to trust the file is the tricky part.
> It would probably be easier to convince CRDA to do it if you want to go
> that route. Or if you contact me off-list I can provide a signed file
> that the kernel will trust -- I'm okay with doing that in this case
> since we wouldn't be trying anything which would be in violation of the
> regulations.

Unfortunately, I don't have any hardware which can use 160MHz channels; 
it's only last month that I upgraded my AP to one which can use 80MHz 
channels (which is what led me to looking into all this stuff).

After looking at the kernel code, I'm feeling more confident on the 
split at 5725 working; I will send the v2 patch.

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br

