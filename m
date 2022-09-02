Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80BD5ABACB
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Sep 2022 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiIBWWF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 18:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIBWWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 18:22:01 -0400
Received: from mail4987.hm1479.locaweb.com.br (mail4987.hm1479.locaweb.com.br [201.76.49.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE7FDD760
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 15:21:59 -0700 (PDT)
Received: from mcbain0006.email.locaweb.com.br (189.126.112.72) by mail4970.hm1479.locaweb.com.br id h2a02i2n8lgh for <linux-wireless@vger.kernel.org>; Fri, 2 Sep 2022 19:14:01 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.228])
        by mcbain0006.email.locaweb.com.br (Postfix) with ESMTP id ADD9F6C03AB;
        Fri,  2 Sep 2022 19:21:36 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsUrt2HjzFxJA84Xs1vckHsec-zS6UliOx17_zm9IZkMLTvVK8i2L_eaL5QfFqwvPaPa3RPUNEbbnjpb2EoMenWQylBNnnNiZAUd6qXaHo-KQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsUrt2HjzFxJA84Xs1vckHsec-zS6UliOx17_zm9IZkMLTvVK8i2L_eaL5QfFqwvPaPa3RPUNEbbnjpb2EoMenWQylBNnnNiZAUd6qXaHo-KQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsUrt2HjzFxJA84Xs1vckHsec-zS6UliOx17_zm9IZkMLTvVK8i2L_eaL5QfFqwvPaPa3RPUNEbbnjpb2EoMenWQylBNnnNiZAUd6qXaHo-KQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsUrt2HjzFxJA84Xs1vckHsec-zS6UliOx17_zm9IZkMLTvVK8i2L_eaL5QfFqwvPaPa3RPUNEbbnjpb2EoMenWQylBNnnNiZAUd6qXaHo-KQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id D5FC4408A6;
        Fri,  2 Sep 2022 19:21:50 -0300 (-03)
Message-ID: <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
Date:   Fri, 2 Sep 2022 19:21:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
To:     Johannes Berg <johannes@sipsolutions.net>, sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
 <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
Content-Language: en-US
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
In-Reply-To: <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Em 02/09/2022 11:53, Johannes Berg escreveu:
> On Thu, 2022-09-01 at 20:27 -0300, Cesar Eduardo Barros wrote:
>>
>> +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
>> +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
>> +	# requirements, we can extend the range by 5 MHz to make the kernel
>> +	# happy and be able to use channel 144.
>> +	(5470 - 5730 @ 160), (27), DFS
>> +	(5730 - 5850 @ 80), (30)
>>
> 
> If you do the latter as 160 as well, and add AUTO-BW, couldn't you split
> them at 5725 correctly? But I guess it doesn't matter anyway.

This was copied from the US rules (including the four-line comment), 
which have an identical split. If AUTO-BW worked here, I'd expect the US 
rules to use it.

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br

