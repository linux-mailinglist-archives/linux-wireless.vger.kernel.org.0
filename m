Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B916F7327
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEDTZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDTZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 15:25:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E317AB0
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 12:25:50 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1928eee97f7so801871fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683228350; x=1685820350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=epBl2J8JRNhxFkoakvGttrTzx/eWFI2LOQ6SQooIWBQ=;
        b=dzE8tm4Y3d400A5ot3fySxQlOOudTgwmyN1TsIKcV8i+Zz7Colzz0uiBiLYFmGE4d+
         SGdhMiIToXbLu+TfmKCIU1COOd0/SwDhaKBFCrj3rq+t2VnYk0KBlQWfgQoRFz8Cti50
         3NJ2w8wXoiNLixfY2z3AeoTdZA9x9ZDVhZzrDfb4rHhrBmhYUzVV1eg/v+2BlRmZhVkw
         keFGVhFk4+bT1UnTkBwAIeE0d+tH34T4Hasdx461i8DEi3MjLz+PmtEBZRSXKwFclZ2M
         obRf/CjiZCbf6qKdjuKK1bAsksuDi3IsGDUxVTJfUYHOHdoMVVp1lzdj4OdJ2o/xxHcp
         5XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683228350; x=1685820350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epBl2J8JRNhxFkoakvGttrTzx/eWFI2LOQ6SQooIWBQ=;
        b=Ry3/F1HjuqSvYY43Us37CZXw4Wf3yz09UOAnInH/zzJaumsLsnRptm5KiBZS40756B
         upMpKEeJefbGnOTfNCMNNMtHPbSaKC+UZaDL9ie3KienpRSq6JooipddkvFPP3N0Fs1t
         fVYUTW9xUwmxNSYXKYZsyle8gMIFoHOVaPTxxEb8uD3IZYeFKpeGLD/DsVuf73mllozv
         Ao+eFrtSZW+g6Wlp1NzLpr8R89nyxC/hllf0aaCPFah708MTok6As0TXs3dUxxQjsn61
         DJj0y27rjopMvRu55NOl0yuiy0PIeTYIkl6krz0dS44nvOvIUYqUFecB9PgulO+bLxxa
         MJgg==
X-Gm-Message-State: AC+VfDzSuMQ6+FkWG00xLtNtjpf8eYkiA6WJ7m+5y9ls62h9UBP+wLT+
        9Ec6zo2zs5obJAcYLj1O95u0rOzn4Ts=
X-Google-Smtp-Source: ACHHUZ5LgHTcdH5KJfeem/KpCU9dQwNzuoO41oq0+IFbkprmHqS12fL+kfE0A3kGN6KRPigg9MKMrg==
X-Received: by 2002:a05:6870:9207:b0:18f:558a:1f35 with SMTP id e7-20020a056870920700b0018f558a1f35mr1658182oaf.59.1683228349960;
        Thu, 04 May 2023 12:25:49 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870450200b0017f84f81f3csm956951oao.52.2023.05.04.12.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 12:25:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
Date:   Thu, 4 May 2023 14:25:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <5930608.lOV4Wx5bFT@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/2/23 14:27, Jernej Škrabec wrote:
> Hi Larry,
> 
> /cc Martin
> 
> Dne nedelja, 30. april 2023 ob 18:51:15 CEST je Larry Finger napisal(a):
>> Jernej,
>>
>> Is there a reason that the driver for RTW8723DS was not included along with
>> the other SDIO versions in rtw88?
> 
> We have no HW to test.
> 
>>
>> I have a user of one of my GitHub repos that uses this device.
> 
> Can you ask that user to test following commits?
> https://github.com/xdarklight/linux/commit/
> 3866a7a3702f7f24557f2c065b7d4088f7027466
> https://github.com/xdarklight/linux/commit/
> 66fd078556a6bf246337270b2e91d73c079fce2d
> 
> Patches are trivial, but some testing needs to be done to confirm the driver
> actually works as intended.

Jernej,

The user needs the rtw8723ds driver - the SDIO equivalent of rtw8723du.c that is 
used by the USB device. The riscv changes may be needed, but we are not quite 
that far yet.

Larry


