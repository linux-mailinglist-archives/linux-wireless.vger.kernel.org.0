Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953096A741E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 20:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCATPk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCATPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 14:15:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE234015
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 11:15:38 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id h16so58144075edz.10
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677698137;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSF7CAdQPabkW4jQVuiT+/8O4qCOAIDoRRJX5IUSs84=;
        b=nfIptKZ1tSeeoo7xGJLmq09o5lM0TrQhvucY0XNLi75HEZaXnJJT6J4GFYgDBjPZdq
         aL8aeJzXjk398GgGgyuR7p+jlCefJlblmFfFOFgqATM9juzD5VZKyZtEWC3Q+wJV+NC/
         +qdcOIzUB7CA2Py4DjGYjR6GVaBzWp/pi17w/LYlESes4Oqn2Y+/Cxr3KgIOOgFzb2X3
         7VHyMnNBEd7ZQtGsh3KldwyjzHjRC22SVll/iJyGQ4m+lGdAf4Nt1YpEcD7Y5ZDhnKts
         x0TFIuapL8f9TM+zmgaqW3DtIGQq8C10wVANyCBh4icvEXl5GQTEo3PhA5slelnbmEGw
         WOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677698137;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSF7CAdQPabkW4jQVuiT+/8O4qCOAIDoRRJX5IUSs84=;
        b=RVR4JjWMubdsvzMPFbAl0gurwkOGEC4RA9MISipaV41gi7agy95XW0puqzqlcGBwWc
         LiYwgaGlQ7aFp8ubzJvykroMcNerXfBDOIez5CAJm6eG5YMlzGp6KZE/B7kY6wC7sRGo
         Dc7ijjOgXnP3WVNuBMnQx6xalIEXBuetzyjWW1oEoP/nvHx1j/2vjusSAhZ73ty3qcrq
         yTaM95j1PeYuPlwB7KiZREaxvEDc13UpsMlWf8tSot1cPiXImnnAPFF1vfbzatPfBR/1
         4Bp4LxdXiGHtf64X8KTK6EDDMEJ0gl1Ech7bX822c/CKc/R4mfF1P1FDsQjB30tnHaP3
         4Ypw==
X-Gm-Message-State: AO0yUKVr66ASkK7bsgrVuvbqS3oSswin/ZXTD8eYYFjRSQKdO+VxeVnS
        HfsoMANQPROHEXaCMGL3Pjj+VE8jl2POaiD8
X-Google-Smtp-Source: AK7set8HQoz6OY+vNELwuHXqlyeV2Iw5bsBvxeS2MGBA7s1OSXvbPcjlGxfJCyo71t5DGa0FYynkZg==
X-Received: by 2002:a05:6402:4413:b0:4bb:afe3:e0a with SMTP id y19-20020a056402441300b004bbafe30e0amr4147533eda.3.1677698137020;
        Wed, 01 Mar 2023 11:15:37 -0800 (PST)
Received: from ?IPV6:2a02:2788:415:e0f7:7db8:cf7a:4b76:6555? ([2a02:2788:415:e0f7:7db8:cf7a:4b76:6555])
        by smtp.gmail.com with ESMTPSA id w18-20020a50d792000000b004af720b855fsm5962043edi.82.2023.03.01.11.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 11:15:36 -0800 (PST)
Message-ID: <7f59d087-9c17-d16f-fa50-e16aba563385@gmail.com>
Date:   Wed, 1 Mar 2023 20:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Content-Language: fr-FR
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
 <8f436927-7587-028d-fc1e-4a3103e0e866@lwfinger.net>
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
In-Reply-To: <8f436927-7587-028d-fc1e-4a3103e0e866@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Le 1/03/23 à 17:40, Larry Finger a écrit :
> On 3/1/23 00:26, François Valenduc wrote:
>> systemrescue recently switched from kernel 5.15 to kernel 6.1 and 
>> NetworkManager started to hangs at startup. This seems to be linked 
>> to my wifi card (RTL8723DE). I am also able to reproduce the problem 
>> under gentoo with the same versions for NetworkManager and 
>> linux-firmware than those used in systemrescue (1.42.2 and 20230210). 
>> Under gentoo, the problem appears with kernel 6.1.14 and 6.2.1. I am 
>> able to use NetworkManager and systemrescue without problem on 
>> another computer which has another wifi card.
>>
>> Does anybody have a solution to this problem ?
>
> François,
>
> Without any log information regarding the specific hang, it will be 
> difficult to debug this issue.
>
> Have you installed the drivers from the rtw88 repo at GitHub.com? If 
> so, they may be interfering with the drivers in the kernel. You can 
> test to see if this is the problem by doing an edit of the command 
> line while booting. When GRUB is showing the kernel you wish to boot, 
> press "e". This should bring up a minimal editor. Scroll down until 
> you find the stanza pertaining to the kernel you are booting. It will 
> start with "menuentry 'xxxxx'", where the x's are replaced with the 
> description of the kernel you want.
>
> Once you find that entry, scroll down to the line that starts with 
> "linuxefi" or "linux", then move to the end of that line, and add 
> "rd.driver.blacklist=rtw_8723de" to blacklist the driver from GitHub, or
> "rd.driver.blacklist=rtw88_8723de" to blacklist the kernel version. 
> Once you have added the new info, press the F10 key yo continue the boot.
>
> If one of those lets the computer boot, add that driver to a blacklist 
> file in /usr/lib/modprobe.d/, or wherever your distro keeps the 
> modprobe.d directory.
>
> If neither work, then report back, and we will try to get a dump of 
> the logs when the hand happens.
>
> Larry
>
Good evening,

For sure, I am using the kernel driver in gentoo or in systemrescue. Can 
you explain how I could obtains the logs when the crash occurs ?

François

