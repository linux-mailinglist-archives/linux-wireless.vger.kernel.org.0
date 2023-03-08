Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799386B1042
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCHRiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 12:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHRh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 12:37:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F6C083C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 09:37:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso1635911wmp.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Mar 2023 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678297070;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skIGdbpVmMRPb/941SzbmTy9IEdDKFk95x2yttIkbCs=;
        b=gLbkbJvQ2YNc9skI238CxF3azuVfi6CnqdjFUgi3WHqNMS9PdlHRUBSjDi5jRGijPX
         W3sjdPenu/8Ezh+s3KGjcUtGdsfm3HEHIQUxP6AO243ZJRQqzq2gewCG4hHaxuHVSXiS
         evZL9rd+VlnqGPq4a4ASjay2s/HMJ4hLesdCaPySck/ApFuwDuV8WaFya8oXieJKn6PM
         tYis72tFHro4o2enQZob9si73lwjrnH1P2RXSlup5J5E4xyum5I7chNqmjZQhxIzxDjQ
         bqT4A7ePLkqMwbeW8ZTjY5rf1XAzWpxGVYVHewwIvnWakegeauGGE8E+WN87ZWJF5bcp
         o48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678297070;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skIGdbpVmMRPb/941SzbmTy9IEdDKFk95x2yttIkbCs=;
        b=HraF4mBaZtGQH7FlOXVx3JmdsVRPiEvJC3t+mxApfqnRvhHAnhPmdE1werBSaA3LwI
         7xi2491CZwU2dhTLD/cLkCjAADCBHTD9oqTZe8r9cO3yO0ARoSo1xDBfDL9T9fVMNAL/
         P0R7AE8AUQzt+CrRS2tovlyONWuGC38qlYZPN1DK3A6+H/1Zg1zshogBivkhZ9x4YYye
         rTEdpWbaJQEJ+lzvT9AJqEi93E5rvo5YnaHNcXaRUMl6cAFZOPqwJUFWKnL/THGdxmwf
         XM1sXB26BcaFTpWe4QYI/qzrhF1hAIVIuMEXwhw/igQh6fEBEEINH18tq5NuIatcKGs6
         OW9Q==
X-Gm-Message-State: AO0yUKXyulPPzPAdEAmrGgR2zs3E5v9tqM2IhXl+x0g8D7y3CNHbJuls
        umdEJ1vtK24XjtZLcKSvfeLJZw==
X-Google-Smtp-Source: AK7set88DVG9CWAtTspajqrUjWpjJ01hMHVoibkhTu1MDm2Om+vXV1B+witcqffqp8E4eiiXeCGQLw==
X-Received: by 2002:a05:600c:a49:b0:3e2:6ec:61ea with SMTP id c9-20020a05600c0a4900b003e206ec61eamr16323844wmq.28.1678297070469;
        Wed, 08 Mar 2023 09:37:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34? ([2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c3b0800b003eae73ee4a1sm108749wms.17.2023.03.08.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:37:50 -0800 (PST)
Message-ID: <629435a5-fb47-2cb5-78b6-e42c943aa397@linaro.org>
Date:   Wed, 8 Mar 2023 18:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
To:     Franky Lin <franky.lin@broadcom.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arend van Spriel <aspriel@gmail.com>,
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
 <f14407f1-e16f-0074-6e29-c597754ae617@free.fr>
 <CA+8PC_dFTvv9VtY9jBWLLwSoQzGxQd57zWMsnN6amddop4Yw-g@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CA+8PC_dFTvv9VtY9jBWLLwSoQzGxQd57zWMsnN6amddop4Yw-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/03/2023 18:21, Franky Lin wrote:
> On Wed, Mar 8, 2023 at 4:48 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>
>> On 08/03/2023 00:15, Franky Lin wrote:
>>
>>> On Tue, Mar 7, 2023 at 6:40 AM Marc Gonzalez wrote:
>>>
>>>> Through the SDIO bus, the WiFi chip reports 0xaae7 (i.e. 43751)
>>>> hence the /sys/bus/sdio/devices output above.
>>>>
>>>> sdio_read_func_cis() -> sdio_read_cis() which sets
>>>> func->vendor/func->device to 2d0/aae7
>>>>
>>>>
>>>> But when brcmf_chip_recognition() calls ci->ops->read32()
>>>> i.e. brcmf_sdio_buscore_read32()
>>>> [ vs brcmf_sdiod_readl() in brcmf_sdio_probe_attach() ]
>>>>
>>>> [    1.177283] brcmfmac: F1 signature read @0x18000000=0x1042aae8
>>>> [    1.182912] found AXI chip: BCM43752/2
>>>> [    1.186384] BCM43752/2: chip=aae8 rev=2 type=1
>>>>
>>>> Here it reports 0xaae8 (i.e. 43752)
>>>>
>>>> Why the discrepancy?
>>>> Can it cause issues?
>>>> (Sometimes, the whole SDIO bus doesn't probe at boot.
>>>> I am still investigating these intermittent problems.)
>>>>
>>>> Should I use 43751 or 43752 firmware...?
>>>
>>> This question should be answered by the Cypress/Infineon folks but
>>> unfortunately they have been quiet for a long time. In general we use
>>> the id read from 0x18000000 to decide which firmware to load. But be
>>> aware that the rev also matters. There are some examples in
>>> brcmf_sdio_fwnames table that the different firmware name can be
>>> derived from the same chip common id but different rev.
>>>
>>> However sdio device enumeration happens before firmware download so
>>> the intermittent problem you are facing probably is not related to
>>> firmware version.
>>
>> Disclosure: My knowledge of SDIO device enumeration is 0.
>>
>> When the host sends the equivalent of an "identify yourself" message
>> on the SDIO bus, doesn't the reply come from the WiFi device?
>> Why would the device reply 0xaae7 instead of 0xaae8?
>>
>> In other words, who is replying 0xaae7?
> 
> The enumeration response is done by the HW sdio core on the chip.  No
> software involved.

Mark,

This would be the:
	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751, CYW),
which is returned by the SDIO bus and associated the SDIO device with the brcmf driver.

All the other IDs are returned by reading registers/send commands to the SDIO device.

Neil
> 
> Regards,
> - Franky

