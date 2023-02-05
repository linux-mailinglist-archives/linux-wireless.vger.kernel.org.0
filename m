Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3641868AFD5
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Feb 2023 14:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBENDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Feb 2023 08:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBENDJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Feb 2023 08:03:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACBC640;
        Sun,  5 Feb 2023 05:03:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A9F224261A;
        Sun,  5 Feb 2023 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675602182; bh=ZNHL58yNQz66uuQ3joFjqdj8irCpAfg7ZEmcywobkfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mKHBjQb+zxKz02buS76DyTL8ssNj2HRWLjk0LC9QypmmCBg90Wh+cvKH/zzscBZi5
         wrtdKQu8eTI/R9TXpp/2L5IGcxXTfr68U5T5vCgv/w9dxnM+5CE1vdDhA1mDWkLOgb
         5wDUo4iR+Sx29zlEiCAUAHgd6KQaDAdZkCHQrg6Gi+WZGyZO3KhQ4xr2cGaL5fRFnF
         7b1eIupcqgahMDJWaeRiH8w/2Lg7E1KWgZW4JXTWB7c717aoYov+9SvTSAmNEktvou
         aNF2V30gXaFpK2MdJO2OGAPlLPqGXp2zGh2qGuNt5MXffdRldTSU41OqjsLkMAtowI
         XdHHlhhM8yUug==
Message-ID: <d86f369d-a28c-bba3-a09b-31407acb4a25@marcan.st>
Date:   Sun, 5 Feb 2023 22:02:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] brcmfmac: Drop all the RAW device IDs
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     "'Hector Martin' via BRCM80211-DEV-LIST,PDL" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Prutskov <alep@cypress.com>,
        Ian Lin <ian.lin@infineon.com>,
        Joseph chuang <jiac@cypress.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Aditya Garg <gargaditya08@live.com>, asahi@lists.linux.dev,
        linux-wireless@vger.kernel.org, SHA-cyfmac-dev-list@infineon.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>
References: <20230131112840.14017-1-marcan@marcan.st>
 <20230131112840.14017-2-marcan@marcan.st>
 <CAOiHx=mYxFx0kr5s=4X_qywZBpPqCbrNjLnTXfigPOnqZSxjag@mail.gmail.com>
 <4fb4af22-d115-de62-3bda-c1ae02e097ee@marcan.st>
 <1861323f100.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <28ed8713-4243-7c67-b792-92d0dde82256@marcan.st>
 <186205e1c60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAOiHx=m2NFo2hbS4a3j67B4iFrkM7dGKGhwLkXuwOZAR=+C63Q@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <CAOiHx=m2NFo2hbS4a3j67B4iFrkM7dGKGhwLkXuwOZAR=+C63Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05/02/2023 21.44, Jonas Gorski wrote:
> On Sun, 5 Feb 2023 at 07:58, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> - stale Cypress emails
>>
>> On February 5, 2023 3:50:41 AM Hector Martin <marcan@marcan.st> wrote:
>>
>>> On 03/02/2023 02.19, Arend Van Spriel wrote:
>>>> On February 2, 2023 6:25:28 AM "'Hector Martin' via BRCM80211-DEV-LIST,PDL"
>>>> <brcm80211-dev-list.pdl@broadcom.com> wrote:
>>>>
>>>>> On 31/01/2023 23.17, Jonas Gorski wrote:
>>>>>> On Tue, 31 Jan 2023 at 12:36, Hector Martin <marcan@marcan.st> wrote:
>>>>>>>
>>>>>>> These device IDs are only supposed to be visible internally, in devices
>>>>>>> without a proper OTP. They should never be seen in devices in the wild,
>>>>>>> so drop them to avoid confusion.
>>>>>>
>>>>>> I think these can still show up in embedded platforms where the
>>>>>> OTP/SPROM is provided on-flash.
>>>>>>
>>>>>> E.g. https://forum.archive.openwrt.org/viewtopic.php?id=55367&p=4
>>>>>> shows this bootlog on an BCM4709A0 router with two BCM43602 wifis:
>>>>>>
>>>>>> [    3.237132] pci 0000:01:00.0: [14e4:aa52] type 00 class 0x028000
>>>>>> [    3.237174] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
>>>>>> [    3.237199] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x003fffff 64bit]
>>>>>> [    3.237302] pci 0000:01:00.0: supports D1 D2
>>>>>> ...
>>>>>> [    3.782384] pci 0001:03:00.0: [14e4:aa52] type 00 class 0x028000
>>>>>> [    3.782440] pci 0001:03:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
>>>>>> [    3.782474] pci 0001:03:00.0: reg 0x18: [mem 0x00000000-0x003fffff 64bit]
>>>>>> [    3.782649] pci 0001:03:00.0: supports D1 D2
>>>>>>
>>>>>> 0xaa52 == 43602 (BRCM_PCIE_43602_RAW_DEVICE_ID)
>>>>>>
>>>>>> Rafał can probably provide more info there.
>>>>>>
>>>>>> Regards
>>>>>> Jonas
>>>>>
>>>>> Arend, any comments on these platforms?
>>>>
>>>> Huh? I already replied to that couple of days ago or did I only imagine
>>>> doing that.
>>>
>>> I don't see any replies from you on the lists (or my inbox) to Jonas' email.
>>
>> Accidentally sent that reply to internal mailing list. So quoting myself here:
>>
>> """
>> Shaking the tree helps ;-) What is meant by "OTP/SPROM is provided
>> on-flash"? I assume you mean that it is on the host side and the wifi PCIe
>> device can not access it when it gets powered up. Maybe for this scenario
>> we should have a devicetree compatible to configure the device id, but that
>> does not help any current users of these platforms. Thanks for providing
>> this info.
> 
> That's what I meant, the wifi chip itself does not have any (valid)
> OTP/SPROM attached/populated, and requires the driver to setup the
> values at runtime based on the host SoC's flash contents (most likely
> NVRAM contents).
> 
> This was the case in about 99% of embedded systems based on MIPS
> bcm47xx/bcm63xx, where the wifi chips then always identified
> themselves with their raw chip IDs as PCI device IDs (even leading to
> one or two ID conflicts ...).
> 
> I have to admit I don't know how much this is still an issue on
> current (ARM) systems, but at least that one BCM4709A one suggests
> this is still happening in "recent" designs. Probably because it saves
> half a cent per board or so ;-)
> 
> Regards
> Jonas
> 

As far as I know the OTP is built into the chips themselves, and even
Apple (who refuses to put per-device calibration data in OTP these days
and loads it from DT) still manages to burn in the proper device ID and
basic info at least... so I'm not sure how this saves any money. I
thought chips weren't supposed to even leave Broadcom without at least
an ID burned in?

- Hector
