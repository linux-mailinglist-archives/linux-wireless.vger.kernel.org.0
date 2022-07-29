Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F3584E0E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiG2Jcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiG2Jca (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 05:32:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D5140B1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 02:32:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk8so7519212ejc.7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NrfgRugzBHaLDQI30ztA44x/8iQuQCRZbmL8D4ZJtHE=;
        b=eMJKO6dRlSlqPIB3XO+44kiGscbI6NzOMDgCgb1I2Oy08yHXjANDCyEjbcEQcox4UU
         OocZH+SpTjTjOZfRapZsmn4GNBVVRf7jv2PAaRgfP2ju7cNDDMFJsYqyNgNcWUg66nWA
         UsmfGG7JrPOh1FQaYn0pma24daDl7005ABvmp7Dz1l5HlNzsk+76GqJWi0uCi3M8BW6T
         3K+qTEcIFV5rPqgAcAl12h1/W4VlFT0sB3LayF61FH7Zyzx8QbFeLgWIaBtt23/ZT9z+
         tPkuoPW7miat58DqcQ5YgLWPgKUvHhLLETBEFnNSAgPDWQeU6YmiXq20YNfSk5IotpI4
         FXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NrfgRugzBHaLDQI30ztA44x/8iQuQCRZbmL8D4ZJtHE=;
        b=mT/M+vHggJui4rLylvArkM8wQ4BAV/siGw5Miwf9DMj3GsNZ8Xp3D5ekjuxNoUKuoN
         6gettz3CRE15JonyDceVtzu3cDUD4ZpsNpaJ/ebPpGDEELNOy5jeF6jS+EPp+9JY8uJs
         iAwJUagpQfVtzXXTlXaZp+oTlJW4CAF4xdz1lhHV4ofCujuCaimU/QQZAfWHJPjFcOvr
         WtkRfATNKjoW3R542+KtIe2DJLMDcJwQssSk7u+CSp51QR54VvDxPnnBOJ1G9hGMWuZg
         WLCwhm43bG1FR17P0/r2AiyGjzG/zT8pTI9wmM5ZMMd8E9AcnGmE1VUsHAFIC+nnhshe
         6MdA==
X-Gm-Message-State: AJIora8yUUVhEiRJTxiv0exPmItmc9leqeBGf3OU6mnI+DhVr0JklvkE
        FqsVfNxRMuA8Gd6wyRG55S0=
X-Google-Smtp-Source: AGRyM1tr6dwDGwRc5S8P1jDh1FAy+YnEOPLfnBKGoHFBkxkRi1XcHilLJLOvjEJZYkhof02s0mJ6eQ==
X-Received: by 2002:a17:907:6d8b:b0:72b:5f51:a9e7 with SMTP id sb11-20020a1709076d8b00b0072b5f51a9e7mr2268303ejc.628.1659087146951;
        Fri, 29 Jul 2022 02:32:26 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b0072af930cf97sm1453706eje.115.2022.07.29.02.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 02:32:26 -0700 (PDT)
Message-ID: <4e5c9cc1-a00e-c3de-3186-6d4cf5694339@gmail.com>
Date:   Fri, 29 Jul 2022 11:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] brcmfmac: add support for vendor-specific firmware
 api
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
 <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
 <87sfmlo9yi.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87sfmlo9yi.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/28/2022 11:36 AM, Kalle Valo wrote:
> aspriel@gmail.com writes:
> 
>> The driver is being used by multiple vendors who develop the firmware
>> api independently. So far the firmware api as used by the driver has
>> not diverged (yet). This change adds framework for supporting multiple
>> firmware apis. The vendor-specific support code has to provide a number
>> of callback operations. Right now it is only attach and detach callbacks
>> so no real functionality as the api is still common. This code only
>> adds WCC variant anyway, which is selected for all devices right now.
>>
>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> 
> [...]
> 
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
>> @@ -8,6 +8,22 @@ config BRCMFMAC
>>   	  interface support. If you choose to build a module, it'll be called
>>   	  brcmfmac.ko.
>>
>> +config BRCMFMAC_VENDOR_MODULES
>> +	bool "Use vendor-specific modules"
>> +	depends on BRCMFMAC = m
>> +	help
>> +	  This option will build separate modules for the vendor-specific
>> +	  firmware support. If not selected the vendor-specific support
>> +	  will be build in brcmfmac.ko.
>> +
>> +config BRCMFMAC_VENDOR_WCC
>> +	bool "Broadcom WCC"
>> +	default y
>> +	depends on BRCMFMAC
>> +        help
>> +          This option will allow the driver to communicate with devices
>> +          shipped by Broadcom WCC division.
>> +
> 
> I'm not really a fan of these Kconfig options, I would rather have them
> always enabled. Why do we need these options, what would be the use case
> when user disables these?

I assume with "always enabled" you mean "drop these options". Obviously 
I would prefer to keep them. The default will result in a single module 
with all vendor support built-in, but this allows people to trim down 
their configuration based on what they have. So the choices are:

1) single module with all vendor support built-in
2) single module with partial vendor support built-in (as needed)

    allows users to select vendor for their specific device not carrying
    stuff they don't need. If they have a Cypress/Infineon device they
    only need support for that.

3) separate vendor support modules loaded as needed during device probe

    build one or more vendor support modules and they are loaded into
    memory only when they are needed for the device detected.

Regards,
Arend
