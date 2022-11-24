Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2F36378D0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiKXM0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 07:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXM0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 07:26:49 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2450DA4C9
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 04:26:48 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 0822C135628;
        Thu, 24 Nov 2022 12:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 0822C135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669292808;
        bh=KVMQB8L8E8zVbvXs0wCRy86hUTh+0mILCfDqfVGkWWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fq5F4JBgAsZsJk2YeJI5AQO80MnHT68+lvMvmC1Zu0S3MoqbJeScjS8JEWV1eDQrP
         oz2GskYBaCLJX0+7jDSiFw698Iushj4PIBrAwZIQNAoAXyc3sj77Yk40Ocwm4zgALo
         mXwMeSavYKstg2wu/c2V3USIf3zsgbCS3Qp8SLMs=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 78AFA2A00EB;
        Thu, 24 Nov 2022 12:26:47 +0000 (GMT)
Message-ID: <f80c4a64-d987-0f59-418d-adf419fcb054@warmcat.com>
Date:   Thu, 24 Nov 2022 12:26:45 +0000
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
 <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com>
 <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
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



On 11/24/22 12:22, Arend van Spriel wrote:
> On 11/24/2022 1:14 PM, Andy Green wrote:
>>
>>
>> On 11/24/22 09:42, Arend van Spriel wrote:
>>> On 11/18/2022 6:41 AM, Andy Green wrote:
>>>>
>>>>
>>>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>>>
>>>>> I see. So could you load bcmdhd and provide log. Preferably with 
>>>>> higher debug level. It also has a module parameter for it. I think 
>>>>> it is called dhd_msg_level and please set it to 0x817.
>>>>
>>>> It's here:
>>>>
>>>> https://warmcat.com/ap6275p-dhd-log1.txt
>>>
>>> Hi Andy,
>>>
>>> Thanks for the log. Together with the dhd driver sources I could make 
>>> some sense of it. Perhaps you can try the following hack and see if 
>>> we make it over the first hurdle.
>>
>> OH!  I found that the line below should be count, not sizeof(count).
> 
> Good job! I was testing you obviously. You passed. Nah, I just feel stupid.

No it's great, the point is it directly identified the root cause 
without access to the platform, it's not so easy.

>> ... any way, good job!
> 
> Thanks. Will clean it up and formally submit it. I also had a quick look 
> at the SDIO variant, but not seeing anything obvious there in terms of 
> firmware loading.

I only have the pcie module not the SDIO one.

For the scan situation, he understands what is being asked via 
connmanctl "enable wifi", but he feels something wrong

connmanctl> enable wifi

connmanctl>
Enabled wifi
connmanctl> [  272.174946] ieee80211 phy0: brcmf_run_escan: error (-52)
[  272.174956] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)


connmanctl> [  275.133157] ieee80211 phy0: brcmf_run_escan: error (-52)
[  275.133166] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)


connmanctl> [  284.138852] ieee80211 phy0: brcmf_run_escan: error (-52)
[  284.138856] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)

52 is EBADE, I recall you mentioned that the scan api had been changed 
recently... is this possibly related to that?  Grepping around for EBADE 
near the function it mentions, it tries to take evasive action if it 
sees one in some places already.

-Andy


