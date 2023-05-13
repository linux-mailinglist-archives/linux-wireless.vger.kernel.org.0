Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA55701991
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEMTz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjEMTz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 15:55:57 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB41FF6
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 12:55:56 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-54feb64eec0so2324877eaf.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684007755; x=1686599755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kQdksBYxy3jSYGFuO7oxQJ7eTybGhbzKiV8woVxJZjw=;
        b=jb6ruIho6gy8z2KJebQR0QBFDhgP8rWdmeBYniIcLy/Groo25GirFSq7B2WOKk+yCu
         w68voq5NRnKt0kkL+T25hb0vYcLJiTcucvKd58AyCZTYmZcZZCz9JIWMwHoBqrGGYooX
         KiigbXWeUUJRSb/CP8/8KfAYSiOCCs3Bx6cjWti90Yq2UqKzd1RGAdLs7E0+QzNUvll+
         hYuE+kp6IK/9IU8w9ysiKHWCbAE0uiWdgt4dhGD7boWtSrzfS79NYVLQ3alwkUsi3lBA
         imAqKvbizrHxhs3PgTlQsFXymDjNzt2p6Ff20MOoPVuqC9xKasnMbcg99NcJ2WveWGsJ
         MsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684007755; x=1686599755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQdksBYxy3jSYGFuO7oxQJ7eTybGhbzKiV8woVxJZjw=;
        b=e3XbDvFyGKZIZ1aWZJj8dZSCO6QMiOd7ZF+KOhLEazeWEDZPVCwVzp4EmbS/HsSup8
         BUlJ9Salmi6u6xB7CY8CK35Ko3rl+hLc+j2RrVFXXiwytc+epIXOIUQOPmTbWK4YTf6B
         Icte8JU1QFPAMNrqUTicOrUWTr7dp/265O4sUektpEgp3DVhftukwgIXedmHhu+/KhkS
         MVuBe6hFcpFoNtG/FmB91+jeNJZEe6gLTGLAIwJKnbgxU7i/smvt+2V6RKva0pyBaXzt
         hOwAcKCGh3a++fAlqh+I+ZJNMFTL7l3aalK9LCvZB/c1zSp1GUj1POq8eSBbggJHqgh3
         M+6Q==
X-Gm-Message-State: AC+VfDyh0qFAucUvB5KhMkPHkeyss3RtvfcJ5vdTH7deqG3kEp5kLEub
        zVOsVi9h1D69BTwg70xw3mw7f8H6g28=
X-Google-Smtp-Source: ACHHUZ4w4KhReKDDE0/8WcxU4q5w2D/Uvd9Od0mYcjXpoa79am58Xi968paYdObs1r+xQpJxp5JACw==
X-Received: by 2002:a05:6808:9a2:b0:394:4d9a:6539 with SMTP id e2-20020a05680809a200b003944d9a6539mr4889243oig.11.1684007755523;
        Sat, 13 May 2023 12:55:55 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id fu24-20020a0568082a7800b0038eeba6fce1sm5592651oib.55.2023.05.13.12.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 12:55:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f3368bf9-c6e6-f418-41da-b9de185acd34@lwfinger.net>
Date:   Sat, 13 May 2023 14:55:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Driver for rtw8723ds
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <CAFBinCAA2CXZBRO7yb4Hjg6Cos4JFQiCMWZLGVh8DCOYWg7HhA@mail.gmail.com>
 <880bb4ed-f3a5-2d7f-db10-fec65087dd05@lwfinger.net>
 <13262218.uLZWGnKmhe@jernej-laptop>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <13262218.uLZWGnKmhe@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/13/23 05:23, Jernej Škrabec wrote:
> Larry,
> 
> Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
>> On 5/10/23 16:07, Martin Blumenstingl wrote:
>>> On Wed, May 10, 2023 at 12:02 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> [...]
>>>> I added that patch to the driver. The user reports that he was able to do a ping
>>>> and an nslookup before it crashed with the following in the log:
>>> That's some positive news alongside the crash log: it seems that a
>>> part of the driver works! :-)
>>>
>>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NULL>
>>> [...]
>>>> Somehow skb->tail was greater than skb->end. Unfortunately I do not have access
>>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the MangoPi
>>>> MQ Quad.
>>> I need to have a closer look at the pkg_offset and struct
>>> rtw_rx_pkt_stat which we receive.
>>> Recently my own MangoPI MQ-Quad arrived but I did not have the time to
>>> set it up yet. I'll try to do so during the weekend so I can debug
>>> this on my own.
>>>
>>> Please ping me next week in case I haven't provided any update until then.
>>
>> I have some test prints in to check for skb overrun. My initial indication is
>> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my next run
>> should verify that. My changes will do a pr_warn_once() when the problem
>> happens, and then drop the skb.
>>
>> My contact reported that he had one run of 3 minutes before the problem
>> happened, which is good news for most of the driver.
> 
> I may have discovered something interesting. rtl8723ds vendor driver has
> following checks in RX data parsing code:
> https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/rtl8723ds_recv.c#L83-L99
> 
> Those checks are absent in rtl8822bs vendor driver, which was my original
> development platform for SDIO. This may indicate some kind of bug in FW
> and/or HW.
> 
> I think that at least second check, which checks for exactly the case your
> client experience, can be easily added and tested.

Thanks for this update. I added the following to the start of rtw_sdio_rx_skb():
        /* fix Hardware RX data error, drop whole recv_buffer */
        if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
                kfree_skb(skb);
                return;
        }
I think that duplicates the code in the vendor driver.

I have not heard from my user as to whether it helps. My communications with him 
are at https://github.com/lwfinger/rtl8723ds/issues/37.

Larry


