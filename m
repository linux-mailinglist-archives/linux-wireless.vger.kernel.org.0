Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93346378AB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKXMOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 07:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKXMOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 07:14:12 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF42597EC0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 04:14:10 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id ED31D135628;
        Thu, 24 Nov 2022 12:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com ED31D135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669292049;
        bh=yHfmWAubuues4GxU00XubRYgyjYMZE+RqkiyXk0vFXo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZGtV3gqo75TepeH1axMq6c9BdJz54b+hXsMBmzY5gfeIh5L8Wd5pZ3f6Gamco4ZdD
         6OFdd8DWCAkHMiCLdGSjf9mfQo+Nl1vEVT8qQCGDGuqlHpEwADhQOTBVRbAYWgYuzA
         GYZT1Wo/s3OErtevbatGvJAjGFi9TSYTGap+55H4=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 6205F2A00C0;
        Thu, 24 Nov 2022 12:14:09 +0000 (GMT)
Message-ID: <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com>
Date:   Thu, 24 Nov 2022 12:14:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/24/22 09:42, Arend van Spriel wrote:
> On 11/18/2022 6:41 AM, Andy Green wrote:
>>
>>
>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>
>>> I see. So could you load bcmdhd and provide log. Preferably with 
>>> higher debug level. It also has a module parameter for it. I think it 
>>> is called dhd_msg_level and please set it to 0x817.
>>
>> It's here:
>>
>> https://warmcat.com/ap6275p-dhd-log1.txt
> 
> Hi Andy,
> 
> Thanks for the log. Together with the dhd driver sources I could make 
> some sense of it. Perhaps you can try the following hack and see if we 
> make it over the first hurdle.

OH!  I found that the line below should be count, not sizeof(count).

> +    addr -= sizeof(count);
> +    memcpy_toio(devinfo->tcm + addr, seed, count);
> +}

With that, you were right on the money, the firmware comes up

[    3.796062] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43752/2 
wl0: Jul 12 2022 18:54:54 version 18.35.387.23.146 (g412cc5ec) FWID 
01-93c53be6

along with

wlP2p33s0: flags=4098<BROADCAST,MULTICAST>  mtu 1500
         ether d4:9c:dd:f5:bf:7e  txqueuelen 1000  (Ethernet)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

I will try get it to scan...

... any way, good job!

-Andy
