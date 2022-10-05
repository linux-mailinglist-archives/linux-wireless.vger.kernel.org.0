Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC15F52C0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJEKmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJEKmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 06:42:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8758B51
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 03:41:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id au23so13791630ejc.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Oct 2022 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7O2jM4fax7A9MnpQXYIg7t0j7nY1aVEQlOSLTYCR6pc=;
        b=arp7KM/He57MDMzIp7eGxjOgAMKbBhyTVWzqN5GMO/tDLuJn3HKgAhLzS6pDs+bSgc
         2QiqAsmUgN3d0Tme7Kj6A+t5XP/eAsIAm8FX88rohyVeTt0+1NXHcVIDSQU1gsHDAF6m
         wA/VYC4DQHC8KW0GhKLoDgcs7b7lluKks3NXKBrv9qX7HalhISW7zfhZKnNTjC9FNM4F
         JXLididK5f/b/vsuApvThkkgIOBlmzHmCK38tY6PMpanCYvdS9u+sKjfVytNVl9PucuP
         KZ/0xapVroMVw4abyoQQ5M8R0y3QtN4LnSD4RxtDdrjRw+Cjw0tppRGD8ssvXxpFf7vu
         EAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7O2jM4fax7A9MnpQXYIg7t0j7nY1aVEQlOSLTYCR6pc=;
        b=bC7vPjHjuhLhc5SFT27tUhpVLPZn7JHq66T9ekmxdzl8AbwlYGbAZo/Hn4aAI5dGwh
         jUPDH8/uCnNpw5FtIJusuvvKXpz4FqFV4H4PoAcBti65KZG08I3wepS0AleNBrFlztX3
         2MUEGrC+G/0Te2GB6QP7L91ET3Z9XYNFs8SJqimmzj1C2EG4/n4l/nDZpIHzhr37FVoV
         IOUe+TxZas/TtfWAm9RRAjpE+27IrSJnddcn6RrRzxZIc5adEugaRt3qEAK0ba3vuw9K
         +YDHYdZPqGLezk1B3CVWoadeFBYwpHSi4vVpIxod36qQfmXNutL//PVMvePriTP0SkF8
         bFYg==
X-Gm-Message-State: ACrzQf07vh9Fv+JOBAfr2CdScjw8NR+QwI5br2zx9b0GonsyXHGEvi6R
        yK2ylAm/Awdy0RONEISpjTc=
X-Google-Smtp-Source: AMsMyM760q/c3TjR2XySUEUFkX+Nl4Wv4w5tmXQmvDzmRCvUcL3vKUoC9aMCwQfUF9TY90wlfdl4dQ==
X-Received: by 2002:a17:907:7284:b0:783:ca4d:1c49 with SMTP id dt4-20020a170907728400b00783ca4d1c49mr23006199ejc.618.1664966517838;
        Wed, 05 Oct 2022 03:41:57 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b0074a82932e3bsm5033925ejc.77.2022.10.05.03.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 03:41:57 -0700 (PDT)
Message-ID: <5315f8a6-cd0f-f197-191b-ef0ba90560c6@gmail.com>
Date:   Wed, 5 Oct 2022 12:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/4] brcmfmac: revise SoftAP channel setting
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Ian Lin <ian.lin@infineon.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, Double.Lo@infineon.com
References: <20220929050614.31518-5-ian.lin@infineon.com>
 <166495531224.5945.8900458651808305145.kvalo@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <166495531224.5945.8900458651808305145.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/5/2022 9:35 AM, Kalle Valo wrote:
> Ian Lin <ian.lin@infineon.com> wrote:
> 
>> From: Ting-Ying Li <tingying.li@cypress.com>
>>
>> We need to update "chanspec" iovar for each SoftAP creation
>> because firmware will update the chanspec to current bsscfg
>> for each bss. If we do not update it then the wrong chanspec
>> will be shown on the result of 'wl -i [interface] status'
>> command. No need to handle channel resource reusing for mbss
>> mode by the host driver, it should be covered by firmware.
>>
>> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> 
> The term "SoftAP" is a bit confusing. From an upstream driver point of view
> it's just AP mode, right?

It is. If I have understood things the term is used for using AP 
interface on a non-router platform. To me it always has been a vague term.

> What's wl? Is that some proprietary tool or what?

Yup. Please avoid such references. Same for the term "current bsscfg".

I think I will need to take a closer look at this patch.

Thanks,
Arend
