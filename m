Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8A6B076D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCHMsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 07:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHMsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 07:48:20 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC365BC8A;
        Wed,  8 Mar 2023 04:48:19 -0800 (PST)
Received: from [IPV6:2a02:8428:2a4:1a01:45c4:a757:53fe:d68b] (unknown [IPv6:2a02:8428:2a4:1a01:45c4:a757:53fe:d68b])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 31D3B19F5AD;
        Wed,  8 Mar 2023 13:47:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678279697;
        bh=khQxVjFHMjEKGcJe0J+IKRrBiCSANsezuEHC8IvabDI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uthwmaaBuqqeWDXGBUXa60Z5MPrU6O0uLQAShfd73hN8O8BdkFhbf2Pr2TjX6MH28
         uQwLDjUkbp8qM/vD3BRhctd3gPzbLtzfQZ61R7TevX9i9lqMhjhrCnjTrgUgOG1ayQ
         666x28QubRO0Y5IJjZu5ledQCao76ser7c//XJh3u+5Uf9ZvhSQqMdOE3B7HhlpYHL
         SZM0oHlbnfTBSL6R6snF2v6tGY0V0CBwi3y+H33P4GmfLP/cQTdRRuvKZFrcfYWMhZ
         sXIcjQFkBXxTN/PcROWwHhODvG1WIMCuBzi+utQqiHdjl3NMTwQ1/HiBAXR1wScFd0
         HIv60mCwo+qPw==
Message-ID: <f14407f1-e16f-0074-6e29-c597754ae617@free.fr>
Date:   Wed, 8 Mar 2023 13:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
 <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
 <CA+8PC_du5dMwkmAshG2mM9TdeJft5aeAbEdDp0_q3Rxdvpq4MQ@mail.gmail.com>
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CA+8PC_du5dMwkmAshG2mM9TdeJft5aeAbEdDp0_q3Rxdvpq4MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/03/2023 00:15, Franky Lin wrote:

> On Tue, Mar 7, 2023 at 6:40 AM Marc Gonzalez wrote:
> 
>> Through the SDIO bus, the WiFi chip reports 0xaae7 (i.e. 43751)
>> hence the /sys/bus/sdio/devices output above.
>>
>> sdio_read_func_cis() -> sdio_read_cis() which sets
>> func->vendor/func->device to 2d0/aae7
>>
>>
>> But when brcmf_chip_recognition() calls ci->ops->read32()
>> i.e. brcmf_sdio_buscore_read32()
>> [ vs brcmf_sdiod_readl() in brcmf_sdio_probe_attach() ]
>>
>> [    1.177283] brcmfmac: F1 signature read @0x18000000=0x1042aae8
>> [    1.182912] found AXI chip: BCM43752/2
>> [    1.186384] BCM43752/2: chip=aae8 rev=2 type=1
>>
>> Here it reports 0xaae8 (i.e. 43752)
>>
>> Why the discrepancy?
>> Can it cause issues?
>> (Sometimes, the whole SDIO bus doesn't probe at boot.
>> I am still investigating these intermittent problems.)
>>
>> Should I use 43751 or 43752 firmware...?
> 
> This question should be answered by the Cypress/Infineon folks but
> unfortunately they have been quiet for a long time. In general we use
> the id read from 0x18000000 to decide which firmware to load. But be
> aware that the rev also matters. There are some examples in
> brcmf_sdio_fwnames table that the different firmware name can be
> derived from the same chip common id but different rev.
> 
> However sdio device enumeration happens before firmware download so
> the intermittent problem you are facing probably is not related to
> firmware version.

Disclosure: My knowledge of SDIO device enumeration is 0.

When the host sends the equivalent of an "identify yourself" message
on the SDIO bus, doesn't the reply come from the WiFi device?
Why would the device reply 0xaae7 instead of 0xaae8?

In other words, who is replying 0xaae7?

Regards.

