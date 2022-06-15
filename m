Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64C54C401
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jun 2022 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiFOIzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jun 2022 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiFOIzG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jun 2022 04:55:06 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 01:55:03 PDT
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4D2CDCF
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 01:55:02 -0700 (PDT)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:35786 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_DHE_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.95)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1o1Okl-0005pP-1m;
        Wed, 15 Jun 2022 10:51:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=tU+l7Fdz3abXql+FiXBRId9jYAOiEybU4ZuL1CHIj8E=;
        b=PqA6fEUQPN7f1n+/ZZFiGXtspy9NovdHKYPGBzAZWnnj1VvJbGNv6qfT2CWHzX/65T9Vyymm+3q3tfrE2qiTGttYxF18HoyLlKEv4nbxJsaSUoyWszVmV5wbw4bPBKj2KvxKWTj6qTHDD5VbgnKL1d0KIZhij/qM6GbYfriFuI4=;
Message-ID: <8fa4c081-d1f6-8bf5-2799-4b028fe572cf@newmedia-net.de>
Date:   Wed, 15 Jun 2022 10:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: brcmfmac
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hranislav Milenkovic <hmilenkovic@protonmail.com>
References: <ummn1_Vf6iygnVWDDcx07aAvrz2wPRnpMWB6A205JWSOMEYGVkGv0_uWYymiZTO7bManVdxSskozUDe_TcYAn6loKaOAptYNT2pl-Tu6q-g=@protonmail.com>
 <dac01b50-c559-c40a-871a-4da514e7c3a3@broadcom.com>
 <2d921af3-9d21-7d86-e6da-bfcd904513e9@broadcom.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
In-Reply-To: <2d921af3-9d21-7d86-e6da-bfcd904513e9@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [81.201.155.134] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1o1Okl-000B1a-Cn; Wed, 15 Jun 2022 10:51:55 +0200
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 14.06.2022 um 10:41 schrieb Arend van Spriel:
> On 6/13/2022 11:19 AM, Arend van Spriel wrote:
>> On 6/12/2022 5:49 PM, Hranislav Milenkovic wrote:
>>> Hi Arend,
>>> I fouded your e-mail here 
>>> https://wireless.wiki.kernel.org/en/users/drivers/brcm80211 
>>> <https://wireless.wiki.kernel.org/en/users/drivers/brcm80211>
>>> I have netgear R8000 with brcm 43602 wifi chip. I am using ddwrt 
>>> with experimental build. There are 2 versions of build, normal with 
>>> dhd and experimental with brvmfmac driver 
>>> https://dd-wrt.com/support/other-downloads/?path=betas%2F2022%2F06-10-2022-r49139%2Fnetgear-r8000%2F 
>>> <https://dd-wrt.com/support/other-downloads/?path=betas%2F2022%2F06-10-2022-r49139%2Fnetgear-r8000%2F> 
>>>
>>> Router crashes sometimes and I emailed ddwrt devs with crashlog... 
>>> but they told me
>>>
>>> "there is nothing to fix. its a firmware error. broadcom does not 
>>> provide support for these firmwares . I cannot fix the firmware 
>>> error for that chipset. its a binary. we can only seek for a newer 
>>> firmware binary somewhere in the wild..."
>>
>> Looked at the log and ddwrt devs are mistaken. In the log it shows:
>>
>>   Jun 12 13:26:00 109.198.5.214 logger : calling done start_checkhostapd
>>   Jun 12 13:26:07 109.198.5.214 kernel [ 4743.815344] ieee80211 phy2: 
>> brcmf_fil_cmd_data: Firmware error:  (-23) cmd 262
>>   Jun 12 13:27:04 109.198.5.214 kernel [ 4800.660849] Unable to 
>> handle kernel NULL pointer dereference at virtual address 00000058
>>
>> So there is a command failing in firmware with error -23, but this is 
>> harmless. The NULL pointer dereference is a driver crash. Can you 
>> build the kernel with CONFIG_DEBUG_INFO and provide me with the 
>> brcmfmac kernel module, ie. brcmfmac.ko?
>
> Hi Sebastian,
>
> I heared from Hranislav that you have a modified version of brcmfmac 
> so it would not help me to get a .ko with debug info from you. So 
> decided to ask you directly. I doubt you modified much in flowring.c. 
> Not sure about fweh.c, but these are the two source files I am 
> interested in. Also I am not scared to look at the ARM assembly so 
> anything you can throw at me would work.
i did not modify much in flowring. nothing in fact. i added some 
features like airtime reporting and noise reporting in the generic code. 
so just all the cosmetic things i need for my firmware. some are might 
be also usefull for merging to upstream. but some of this code might be 
too ugly for it.
you can find the sources here 
https://github.com/mirror/dd-wrt/tree/master/src/router/mac80211/drivers/net/wireless/broadcom/brcm80211/brcmfmac
the issue hranislav is reporting seems also only to affect bcm43602 
chipsets. but not 4366 for instance. or at least i have never seen it.
another thing is that i use customized firmwares for airtime reporting 
etc. you can find them also here

https://github.com/mirror/dd-wrt/tree/master/src/router/mac80211/ath10k-firmware-38eeda3ae6f90fde5546bdd48ee4ff3090f238c0/brcm


Sebastian

>
> Regards,
> Arend
