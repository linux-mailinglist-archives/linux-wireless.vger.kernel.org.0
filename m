Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BC7087F5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjERSsd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjERSsc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 14:48:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D98E4A
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 11:48:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39415d35301so926387b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684435710; x=1687027710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c+tV4QovLPBvr1GCWkmUYvXmXoAtPafbiLwUtltMYpc=;
        b=ffKU/1MqyTxNuZ5CQ/VMsXbM0TnED2wI9AyJk6wCVtFZ/t35SILQCyhWtk8qwRdoUA
         6ZakwwFBNbLQrlI2SXE2x0jH0EzTtcczoJUlrZJf75i+REHSPhcrmHPR28Wd8m5U5abJ
         MlQxQU3/xMv8YRPYiJWZHZDjNSo1BoSFVPCvnKaClsXb+Y0/F0AwYNJyEUSTGSjSSGqu
         bpbi5KOQIAdz94b4yRrgtUG+tQjlIrI0BXEOhzUNs/J0ufuohA51C+3fxE/ciC/6bQQr
         nKk+0YlbDOecRggqKmZNf1mdiPOrJc9mJH/Rd0hjwe4G3dJmgD0wuS42dBRlxe38Qeg3
         JVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684435710; x=1687027710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+tV4QovLPBvr1GCWkmUYvXmXoAtPafbiLwUtltMYpc=;
        b=Rd7zWsqgQqLQYPYVOd1laXHv6o34YoQRij06Vr0rrD112Ql06M0AuAbMvOCtc3wMx7
         j8RoHpXqxDP/Ys6weq5nqYvrPW1wOqhOL+q6JnAykeLDUkVTIDGyj4PBJdy4J5a9etKh
         lVauXq2GCiqw0coj/sYdjzp55PuJYwzm6M63u+rpizRmzq4kMxlFiISYDeXsqXwXAG5z
         B89eJDJ1tv8odRkmYFSA/t1qtTuOlmNE/YnEze4CL6In/rpIufXOPKiEexCvLtyYmugE
         QcaGFvj0M5nHHLVkDUcN0NPCv1SqD7CrqAMnVnvPiykPzzPnlH6Wne9guaTZGJ5D64Zl
         7LVQ==
X-Gm-Message-State: AC+VfDyC4MThOxezOZAzTtfIbmZrjHHzs1z45tnZTjzKtsv3sZxGQ/m9
        XvrW4NqIj15c5TiNvrqm4rY=
X-Google-Smtp-Source: ACHHUZ70JcMlZO/uPDboLCxp+gBjQ8eL7SLpV/NyGYbGSiMVkXI0CUoLo4BN7L50lTVQB6V+yuXzdA==
X-Received: by 2002:a05:6808:13d4:b0:38d:e632:8302 with SMTP id d20-20020a05680813d400b0038de6328302mr2032699oiw.14.1684435710517;
        Thu, 18 May 2023 11:48:30 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bk7-20020a056820190700b0054248efdd67sm726464oob.29.2023.05.18.11.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 11:48:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e2dc78fd-014a-14d1-9b4e-9ad251e1d9e1@lwfinger.net>
Date:   Thu, 18 May 2023 13:48:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: wifi: rtw88: questions about adding support for
 RTL8723DS/RTL8723BS
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
References: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
 <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
 <CAFBinCD3nPPHUmtoqRch87SOXpLcfrzOT7SDdsJdGe-KGOK9Mg@mail.gmail.com>
 <5673351.DvuYhMxLoT@jernej-laptop>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <5673351.DvuYhMxLoT@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/18/23 12:13, Jernej Škrabec wrote:
> Dne četrtek, 18. maj 2023 ob 19:00:14 CEST je Martin Blumenstingl napisal(a):
>> Hi Ping-Ke,
>>
>> On Wed, May 17, 2023 at 4:06 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>
>>> Hi Martin,
>>>
>>>> -----Original Message-----
>>>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> Sent: Wednesday, May 17, 2023 12:40 AM
>>>> To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
>>>> Cc: Larry Finger <Larry.Finger@lwfinger.net>; tony0620emma@gmail.com; jernej.skrabec@gmail.com
>>>> Subject: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
>>>>
>>>> Hello Ping-Ke,
>>>>
>>>> as a next step I want to add support for RTW_WCPU_11N SDIO cards to
>>>> the rtw88 driver.
>>>> Currently only one RTW_WCPU_11N chip is supported: RTL8723D by the
>>>> rtw88 (PCIe and USB HCIs).
>>>
>>> Originally, we intended to add 8723D to rtlwifi, because it is a 802.11n chip
>>> and very similar to 8723BE. However, its PCIe HCI is changed to use circular
>>> ring instead of own bit, like other chips implemented in rtw88.
>> As far as I can tell such differences are not present in the SDIO HCI
>>
>>>>
>>>> My first question is very hopefully a simple one:
>>>> It seems that RTL8723DS has two SDIO IDs: 0xd723 and 0xd724.
>>>> Do these have the same name or is there some kind of "revision" (like
>>>> rev 2, revision B, ...) internally?
>>>
>>> 0xd723 is dual antenna, and 0xd724 is single antenna. Since 8723D is a
>>> 1x1 WiFi BT combo chip, 0xd723 can have a dedicated antenna for BT.
>>> The main difference will be BT-coex code.
>> Awesome, thanks for the explanation. I sent patches to add RTL8723DS
>> support to the rtw88 driver.
>>
>>>>
>>>> My second question is more abstract:
>>>> Based on my understanding of the vendor drivers for RTL8723BS and
>>>> RTL8723DS both seem very close in terms of registers. initialization
>>>> sequence, ...
>>>> So I am hoping that it's possible to add RTL8723BS support to the rtw88 driver.
>>>> There's two main differences that I found so far:
>>>> - rtw_dump_hw_feature() doesn't work because REG_C2HEVT has an
>>>> incorrect value (C2H_HW_FEATURE_REPORT is expected but it still
>>>> contains C2H_HW_FEATURE_DUMP). It seems that this is a firmware issue.
>>>
>>> Not an issue. At that moment of developing 8723B, applications are simple, so
>>> we don't read feature from firmware, so just ignore this for 8723B.
>> Jernej also suggested this as a first step. So I guess it's the way to go.
>>
>> [...]
>>>> Have you considered adding RTW8723B support to the rtw88 driver?
>>>> Do you have some initial suggestions on what would be needed to do so
>>>> (is my list from above complete, what do do about these points, ...)?
>>>
>>> As my comment above, 8723BE use different PCIe design, and rtlwifi
>>> has been supported it, so I don't have plan to support 8723BE in rtw88.
>>> But, to add 8723BS to rtw88 seems workable.
>>>
>>> To add 8723B, you can make a copy from 8723D and change settings along
>>> with vendor driver. The main things you need to review are:
>>> 1. PCI probe when plugging wifi card
>>> 2. hardware initialization when interface up
>>> 3. RF calibration when starting connection (you may put this work later)
>>> 4. connection setting after connected
>>> 5. BT-coex you have mentioned
>>>
>>>
>>> To make rtlwifi support SDIO is another way. It seems like add a HCI is
>>> easier than an new chip, and we can have a simple support list of rtlwifi
>>> and rtw88 eventually, like
>>>
>>>          rtlwifi       rtw88
>>> 8723BE    o
>>> 8723BS    o?
>>> 8723DE                  o
>>> 8723DS                  o
>> Per chip support matrix is:
>> 8723BE: rtlwifi
>> 8723BU: rtl8xxxu
>> 8723BS: staging driver which I'd like to replace
>> 8723DE/U/S: rtw88
>>
>> HCI support matrix:
>> rtlwifi: PCIe, USB
>> rtl8xxxu: USB
>> rtw88: PCIe, USB and SDIO
>>
>> So it seems you are right: I should consider whether adding RTL8723BS
>> support to rtw88 is the right choice.
> 
> While rtw88 might not be best choice by above matrix, it seems to be most
> featureful, stable and at least from what I saw, easiest to add new variants.
> 
> I'll do a bit of experiment with rtw88 to see how hard it would be...
> 
> Best regards,
> Jernej

Now that RTL8192CU is being handled, the USB part of rtlwifi is being considered 
for deletion. If you decide in terms of adding RTL8723BS to rtlwifi, please let 
me know.

Larry


