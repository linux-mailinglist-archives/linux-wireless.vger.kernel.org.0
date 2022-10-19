Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200D60455B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJSMdb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 08:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiJSMdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 08:33:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9815A304
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 05:12:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so10495119qkk.7
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZLHL73mpnCWBwVHdH8NaBZIpeTUZhU6UooVah42CMc=;
        b=S1PwHXJt3ONBq1X/XET/6X6lFt1Q+BsDS6ss/5nkuhlKyaJ1j08bJPI3h4qhfuy9+O
         sZP4JyaXb5hClBiBwgcTIQJ8qraUvBtV/3PoZj2jrb8x8ebL3uvs0z5phMtzusmqpm+u
         BsiuW85DDmvwYaUh1es5w/OMiihXSyfYqE7KjhUw9CxnGdHPGzE7ATnTtMIg7151ci1i
         IAx8BpXh9aMNJkziI44l86ZvhjBdRmugAXJu2zYEWvPpFBIhdf1PwL6B+A+TLt16B+g7
         EeWGBhw+ZbcLQzwbY64Qzm0KraYCjW+GVDCPiB/ui9jUM4ISF8y9DbdD4pojYagDMdhY
         kuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZLHL73mpnCWBwVHdH8NaBZIpeTUZhU6UooVah42CMc=;
        b=okKlb43A4SEXfDGDxkiy0duyTvbiDQ4OqYwt229XERnpKg3im7DispshOFJQPMh5QP
         Ln8qG9S3QPUaCJPoefB3n2X1rlcfWeGLjmWouvaFlSr0MfsRnzxCpAg34z9E4mRYeZ+6
         //I49DmwKF0iJmhxlvZSL5A9JomeCMqQKnQN2PaXYRYeSGc3wGu8axAW7qWQDVyoI3cl
         5NingsNqmtySvy80JJ8YxWWX3Fw6eYmUZSsJnJKqszNwqVhWpfUH1Tltwun8OU8UFh6R
         mtn7zKDwPnRO+LG9AbpX6ZM2Rb0IC+s8elgky4aTI/oupeBK+PI6BNqM6J+ecOkNdOAY
         j8Sw==
X-Gm-Message-State: ACrzQf3qNdPw1oLPiCVXrxRa2M/Tycehbo7l5WjafvMDG/bcFGm8Xcax
        vfY3g1bqq5g65sRuW9NcY8j9K732xLm1mA==
X-Google-Smtp-Source: AMsMyM52HLn4bk5XU58g1/MwIKbQ/2pqXIQfVBs+/WgUD/QtH1JkotQcNyUKGN+/2TGogS1XU1OxzA==
X-Received: by 2002:ac8:7dc8:0:b0:39c:e637:b995 with SMTP id c8-20020ac87dc8000000b0039ce637b995mr5901857qte.528.1666180721174;
        Wed, 19 Oct 2022 04:58:41 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id bs20-20020a05620a471400b006b615cd8c13sm4646902qkb.106.2022.10.19.04.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 04:58:40 -0700 (PDT)
Message-ID: <e622b8bd-5490-5d8c-6209-c1ace0d1acf3@gmail.com>
Date:   Wed, 19 Oct 2022 13:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/7] brcmfmac: add support for vendor-specific firmware
 api
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
 <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
 <87sfmlo9yi.fsf@kernel.org> <4e5c9cc1-a00e-c3de-3186-6d4cf5694339@gmail.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <4e5c9cc1-a00e-c3de-3186-6d4cf5694339@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/29/2022 11:32 AM, Arend Van Spriel wrote:
> On 7/28/2022 11:36 AM, Kalle Valo wrote:
>> aspriel@gmail.com writes:
>>
>>> The driver is being used by multiple vendors who develop the firmware
>>> api independently. So far the firmware api as used by the driver has
>>> not diverged (yet). This change adds framework for supporting multiple
>>> firmware apis. The vendor-specific support code has to provide a number
>>> of callback operations. Right now it is only attach and detach callbacks
>>> so no real functionality as the api is still common. This code only
>>> adds WCC variant anyway, which is selected for all devices right now.
>>>
>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>
>> [...]
>>
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>>> @@ -8,6 +8,22 @@ config BRCMFMAC
>>>         interface support. If you choose to build a module, it'll be 
>>> called
>>>         brcmfmac.ko.
>>>
>>> +config BRCMFMAC_VENDOR_MODULES
>>> +    bool "Use vendor-specific modules"
>>> +    depends on BRCMFMAC = m
>>> +    help
>>> +      This option will build separate modules for the vendor-specific
>>> +      firmware support. If not selected the vendor-specific support
>>> +      will be build in brcmfmac.ko.
>>> +
>>> +config BRCMFMAC_VENDOR_WCC
>>> +    bool "Broadcom WCC"
>>> +    default y
>>> +    depends on BRCMFMAC
>>> +        help
>>> +          This option will allow the driver to communicate with devices
>>> +          shipped by Broadcom WCC division.
>>> +
>>
>> I'm not really a fan of these Kconfig options, I would rather have them
>> always enabled. Why do we need these options, what would be the use case
>> when user disables these?
> 
> I assume with "always enabled" you mean "drop these options". Obviously 
> I would prefer to keep them. The default will result in a single module 
> with all vendor support built-in, but this allows people to trim down 
> their configuration based on what they have. So the choices are:
> 
> 1) single module with all vendor support built-in
> 2) single module with partial vendor support built-in (as needed)
> 
>     allows users to select vendor for their specific device not carrying
>     stuff they don't need. If they have a Cypress/Infineon device they
>     only need support for that.
> 
> 3) separate vendor support modules loaded as needed during device probe
> 
>     build all (or some) vendor support modules and they are loaded into
>     memory only when they are needed for the device detected.

Hi Kalle,

I wanted to give this series another try, but the conversation above 
never came to any conclusion/consensus. Maybe good to finish this before 
resending?

Regards,
Arend
