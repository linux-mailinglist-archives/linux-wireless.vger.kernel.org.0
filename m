Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACB6F778E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 22:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjEDUzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 16:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjEDUzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 16:55:09 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D112EB6
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 13:54:48 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1925ad4953dso470709fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683233640; x=1685825640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zU8Xn/MMdkDkss//AoWsAjfvW2Pqeculutrx/5/p5tA=;
        b=LysxShiXLwNTPvGRv/wyQ/wWiZoHxvG3CUf9REO43AbFglwEWMBuonIsidPEaUktPX
         gnZIZij52TIz405urzqqLObBYPFb2cGs58I/2TBCbhLCwzjf9Icv7TL7fJhW1zeCT9EA
         39Wq5G2YrBzVjVhwTcX6or/qFSa+V6HSLi19VxtEWv4lZYrZ20eC66H/kvDkjguFq9eq
         P/m7x1OqdyMxb4PzbDQ/FxQZ4snngCK2ZEUq+0XeNF3hvwrQJt99Ksz2TFveandWKbFQ
         XMlpoXrnVQiTnDDg+vVO+0hPtBz4UsRBTdtSrUr9pfbqKNz6cp66E0Q9qHaTIACIB/3d
         PW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233640; x=1685825640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU8Xn/MMdkDkss//AoWsAjfvW2Pqeculutrx/5/p5tA=;
        b=R7mN+Ti6wM0FJhnnfJkIosowGrcSy0b62x3fElR8TPe8HAuy5gMLf2oSMKQ1hMMVD9
         JMxtwIALmlodZeElBiol17Al0hL6TJat5xG58ozl347VQzSoO6QYk8djg9Fu2dsjItsb
         HPqOihDWf+Nvuzb7Bqi5K54mmGzNaqeuXlimRrOk/QNhqHXmyzwTcEA1AhOEhTv+I8b8
         ZySvpDqjb5O97RrTQXH9Gn9R9pz6on3ZdL9egptEia+EFS8g7s2juSCAa9l4I5l8b51+
         v4JrPS9aOEH0Pq1g9POclc75Tl8axm9YjL4Zkk0toSb8874R75Jj2Bc6GZ3k1GDSoS8D
         atIw==
X-Gm-Message-State: AC+VfDxhynntNd/siB570n+xkTh9BiC51ZpFWiTu9txutN3ZFUioT8+a
        NiTXWECBcYTjRgUVHscYJmEviMKw8gE=
X-Google-Smtp-Source: ACHHUZ5/F7YNNlVxeoOLmmXr1ci9jXJUIrlqQO2kyuJ8Ulo9jE4cNeQESo+Qx3dauhI4cfc1Hl2ing==
X-Received: by 2002:a05:6870:d347:b0:184:87d:a773 with SMTP id h7-20020a056870d34700b00184087da773mr1755228oag.49.1683233640214;
        Thu, 04 May 2023 13:54:00 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id j19-20020a4adf53000000b0054c7ed51952sm217336oou.0.2023.05.04.13.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 13:53:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1901d4d8-bb68-ac5a-0d1f-9bdc46aed43d@lwfinger.net>
Date:   Thu, 4 May 2023 15:53:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
 <2282070.ElGaqSPkdT@jernej-laptop>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2282070.ElGaqSPkdT@jernej-laptop>
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

On 5/4/23 15:13, Jernej Škrabec wrote:
> Dne četrtek, 04. maj 2023 ob 21:45:31 CEST je Martin Blumenstingl napisal(a):
>> Hi Larry,
>>
>> On Thu, May 4, 2023 at 9:25 PM Larry Finger <Larry.Finger@lwfinger.net>
>> wrote: [...]
>>
>>>> Can you ask that user to test following commits?
>>>> https://github.com/xdarklight/linux/commit/
>>>> 3866a7a3702f7f24557f2c065b7d4088f7027466
>>>> https://github.com/xdarklight/linux/commit/
>>>> 66fd078556a6bf246337270b2e91d73c079fce2d
>>>>
>>>> Patches are trivial, but some testing needs to be done to confirm the
>>>> driver actually works as intended.
>>>
>>> Jernej,
>>>
>>> The user needs the rtw8723ds driver - the SDIO equivalent of rtw8723du.c
>>> that is used by the USB device. The riscv changes may be needed, but we
>>> are not quite that far yet.
>>
>> Strange, can you please elaborate what you are seeing in terms of riscv?
>> The two commits that Jernej shared are for an update to rtw8723d.c [0]
>> and the addition of a rtw8723ds driver [1]. None of these mentions
>> riscv (at least that's what my tired eyes are seeing today).
>>
>>
>> Best regards,
>> Martin
>>
>>
>> [0]
>> https://github.com/xdarklight/linux/commit/3866a7a3702f7f24557f2c065b7d4088
>> f7027466 [1]
>> https://github.com/xdarklight/linux/commit/66fd078556a6bf246337270b2e91d73c
>> 079fce2d
> 
> Problem is that my e-mail client split commit links in two parts. If you
> combine hashes with rest it opens correct commits. Currently, it opens head of
> your master branch, which is by chance risc-v merge commit.

After I compared the links that Martin sent with yours, I figured out the problem.

I downloaded the patches and applied them to my rtw88 repo. The user that wanted 
rtw8723ds support has been notified. We will see how it goes.

Thanks,

Larry


