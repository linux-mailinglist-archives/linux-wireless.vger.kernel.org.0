Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AC6A7B5E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 07:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCBGYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 01:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCBGYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 01:24:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189D18149
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 22:24:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so911694edb.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 22:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677738264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96tnRVy67gbVcAhZJrtqxH4ZHmeLLXWlWG3PhZjbqSE=;
        b=EolPIXzNzP1VdfLOwxU3Hu0+6yeSy7H72rMB5VUo/O1ReP4SZgLhbPFCPSu/auYVLd
         p3+M+HPIQepYvc/CxpDMdA5v01GndMxyNUwusVlOhnGYq/zxprB+yRXXN1+NN+M/xU0b
         sXdxxd+t+fpGhbJ3e8Hmstz1vfIVgFJv0IGEsZ1CpYG1mBYIPdtWZzz5aqNUtfzTjfbo
         N+E7QUQjIe9WhTpJXHzbXRlf9uHqjbDVLWeHM3xKOxvNFck8+WMPXnYF1KhR9zq6Zso+
         GqOsDHr8q7JYCGyzohJ0bL4VwA16WdF8BAK8oZbjB+bGYjuneql0Nf2jMfqVHG91YlwR
         IOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677738264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96tnRVy67gbVcAhZJrtqxH4ZHmeLLXWlWG3PhZjbqSE=;
        b=I0Q0xzUIjjNDfZsAn6ib8/iVDKeBErBLw2EI7Xf8B8QFpR1jMqSbvdYtM2timCyjEI
         ThpICBhRlb/7QoHlpD30reJU/U1ovG41dQo8pe6TyFXEZ5+WDy3wMkJodukrn71ieQLh
         9qLbRxJ1KtZXCQJvSzna0P5psTFMR+cCuSE/LUgdbreCyHb8tPf8UOSSDi2/qkSX5IKq
         GMwWltWawtH1yc//3ppz1AnyvQnNusz/taWLJeCE47rqGiTViKz1UgwTS56ZDGU5IzXO
         Wkha00C2HVA5irZ1RfMv5F//5f4L5YsPUSl6mT3QcQ/hFKCnBBACJSPjRMOXXuFhCASo
         mbqg==
X-Gm-Message-State: AO0yUKW4/LPdKXub/Z1MWlF3//AOb/uzjAmXm4p8QoctcEk58bk820Ay
        rj8gokYSJNvzhTbei21b1SN0v2Mdt9tAPcAPz8w=
X-Google-Smtp-Source: AK7set8Qb8of4zEXD5zxatMMG/kzKV7dbDr66CVSaQTK+Mh/12Jv0PQ3K2GpNH7OL03G+54gTeb2BA==
X-Received: by 2002:a17:906:74d6:b0:8a9:e5c2:e3b8 with SMTP id z22-20020a17090674d600b008a9e5c2e3b8mr8120680ejl.2.1677738263890;
        Wed, 01 Mar 2023 22:24:23 -0800 (PST)
Received: from ?IPV6:2a02:2788:415:e0f7:ab10:10c9:842a:7cc? ([2a02:2788:415:e0f7:ab10:10c9:842a:7cc])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906350700b008b2e4f88ed7sm6687723eja.111.2023.03.01.22.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 22:24:23 -0800 (PST)
Message-ID: <c92df9a9-bff0-6dff-6416-5ee761334c2a@gmail.com>
Date:   Thu, 2 Mar 2023 07:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Hangs with NetworkManager and rtw8723_de with kernel 6.1
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
 <ad187d12189d45a68bc8bdc229ab5d4e@realtek.com>
Content-Language: fr-FR
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
In-Reply-To: <ad187d12189d45a68bc8bdc229ab5d4e@realtek.com>
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


Le 2/03/23 à 02:27, Ping-Ke Shih a écrit :
>
>> -----Original Message-----
>> From: François Valenduc <francoisvalenduc@gmail.com>
>> Sent: Wednesday, March 1, 2023 2:26 PM
>> To: linux-wireless@vger.kernel.org
>> Subject: Hangs with NetworkManager and rtw8723_de with kernel 6.1
>>
>> Good morning,
>>
>> systemrescue recently switched from kernel 5.15 to kernel 6.1 and
>> NetworkManager started to hangs at startup. This seems to be linked to
>> my wifi card (RTL8723DE). I am also able to reproduce the problem under
>> gentoo with the same versions for NetworkManager and linux-firmware than
>> those used in systemrescue (1.42.2 and 20230210). Under gentoo, the
>> problem appears with kernel 6.1.14 and 6.2.1. I am able to use
>> NetworkManager and systemrescue without problem on another computer
>> which has another wifi card.
>>
>> Does anybody have a solution to this problem ?
>>
> I think this problem is the same as
> https://bugzilla.kernel.org/show_bug.cgi?id=217016
>
> Ping-Ke
>
>
This is indeed the same bug. I applied this patch on top of kernel 
6.1.14 and the hang doesn't occur anymore, neither in Gentoo or in 
SystemRescue. I see this patch has been merged in mainline and marked 
for stable. However, it is not included in the current review for 
6.1.15. I hope it will make it to stable kernels soon.

Thanks for your help,

François Valenduc

