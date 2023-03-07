Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599996AE374
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCGO4E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 09:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCGOx4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 09:53:56 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460785360;
        Tue,  7 Mar 2023 06:40:24 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5044F200432;
        Tue,  7 Mar 2023 15:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678200022;
        bh=cUlGUlxnrSswLEgVcqajPis8Rc++laPQrrim5zSPy+s=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=o7xInn/vkT5pOuWHAPWOKwqulC4OhEuilkTDXRA779CWcQT2wHa5PjewJfve7OUF2
         3JtSMnOJioljgrYsCL5enpwHMZ8E1sBbqdCIQWAa9ezHULngjEZbyaupG1X0Ploou/
         QChJD8GJJopUVI0cuNUhuJlc87ec2iqFreliL1bV9IYc6xpRiMgb4lyCZ8eb4fZU2/
         jQBSBp5Bm1j0MWMJsaanTx9EdH0+qyjgPQNy4Nr9YWHKkMthVWAzS7P38KIzw+S+W7
         /AKFw69pXNvCpe0m/eEpF1NPgeQ+Shf6wzf/YoXmem3bmEKVaQKWQPTXHyE+YEC3bA
         0tTiP2mpUbk6w==
Message-ID: <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
Date:   Tue, 7 Mar 2023 15:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
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
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
In-Reply-To: <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/03/2023 11:41, Marc Gonzalez wrote:

> On 06/03/2023 11:24, Marc Gonzalez wrote:
> 
>> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
>> OF_NAME=wifi
>> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
>> OF_COMPATIBLE_0=brcm,bcm4329-fmac
>> OF_COMPATIBLE_N=1
>> SDIO_CLASS=00
>> SDIO_ID=02D0:AAE7
>> SDIO_REVISION=0.0
>> MODALIAS=sdio:c00v02D0dAAE7
>>
>> 0xaae7 = 43751
>>
>> Isn't there some overlap between:
>> include/linux/mmc/sdio_ids.h and
>> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h ?
>>
>> Reference used: commit d2587c57ffd8dc
>> "brcmfmac: add 43752 SDIO ids and initialization"
>>
>> Looking at all the occurrences of 43752 to insert a 43751,
>> could someone comment whether this looks reasonable?
> 
> Obviously, the commit message would have to be rewritten
> for a real patch.

Help. I am thoroughly confused... :(


Through the SDIO bus, the WiFi chip reports 0xaae7 (i.e. 43751)
hence the /sys/bus/sdio/devices output above.

sdio_read_func_cis() -> sdio_read_cis() which sets
func->vendor/func->device to 2d0/aae7


But when brcmf_chip_recognition() calls ci->ops->read32()
i.e. brcmf_sdio_buscore_read32()
[ vs brcmf_sdiod_readl() in brcmf_sdio_probe_attach() ]

[    1.177283] brcmfmac: F1 signature read @0x18000000=0x1042aae8
[    1.182912] found AXI chip: BCM43752/2
[    1.186384] BCM43752/2: chip=aae8 rev=2 type=1

Here it reports 0xaae8 (i.e. 43752)

Why the discrepancy?
Can it cause issues?
(Sometimes, the whole SDIO bus doesn't probe at boot.
I am still investigating these intermittent problems.)

Should I use 43751 or 43752 firmware...?

Regards.


