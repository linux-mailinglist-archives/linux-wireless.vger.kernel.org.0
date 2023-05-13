Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6430701A0A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEMVVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEMVVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 17:21:50 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF8E129
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 14:21:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-192adab8f0eso8973809fac.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684012908; x=1686604908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fnSZlZ3Byx+vXxClNgSY6VZRSWujiF5dF1UMurgi7og=;
        b=YBfl/xCCVV0qZzEgXEL0HxwWv4BlnU3i0H9LC1zbF5h1qk0c9F2bzyVvKq+6o8XwZC
         cTcVakGYXZiD+eY4/WOERhsbCCvmcNbkTCNljiIfp4bpawcT1kDq0xYc4YCOHFE+ZCaP
         /yrbhrcFKD2hbdKP0wgFksooaUf/LNcpKbmPou8imHksFUl6lpxxEZd2KiK0nVsylWwW
         z0GD8hLoRCTfytMrcRmmWJKL4CD4lpY7nG9vHqVgOMnXpTz2Fv2YnwXRUhifzq9Et2b6
         n5PuCMaFmFxwDdjDBdFA+RbZBxZz7tLUbdTE4F/kjFPdDNGrbvzrnn7QEvHnhuEoOsG7
         3C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684012908; x=1686604908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnSZlZ3Byx+vXxClNgSY6VZRSWujiF5dF1UMurgi7og=;
        b=fy2WWF8PhAk7C4JWZEWyca0/RKmLZN1zPQF6QHlWnGCZPInSET4XX19i79j8lEKXru
         nW8UbwmXYAfAHst4O8MuzYNRT1KwElwEtrRfnw7/mjW24W/nOqwm14azJ9CZYfDcTXT+
         I8jyQn1Nk4QrGFrwF2obDvOI52kHtRk6U0T5sKCl0Z9SXkPHD9DhiUKjr4EmC+rqZP3z
         LA4qwkWll7QeUd1Gd8knsvRsB6P6BmP3rfEtKdtf5zfE1nj9UNpvJAFxZz0lXDkqcCxh
         0fjBWE5K0/JzH8X3QRk7kkkYaKgdph2z49nBEws+oeyDYc11nYiQ2RbKvHEh93g1/vq3
         vOyw==
X-Gm-Message-State: AC+VfDxkWMohaBeZzwLwi9mcRktl7krA75gcZ2SMUrB2tbqg9igP6UGf
        P++xeriLJ1RwEHcWE8kf6dAPPt2lw0M=
X-Google-Smtp-Source: ACHHUZ5IAHoznOnwCnDOnhqQ0qSXJXm76/KIRgDXI6UHEzAsvPPP1WGhxx5qTqjc3DcX7yOG+flCzQ==
X-Received: by 2002:a05:6870:485:b0:180:5c1f:5446 with SMTP id t5-20020a056870048500b001805c1f5446mr14098019oam.50.1684012908596;
        Sat, 13 May 2023 14:21:48 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w7-20020a4adec7000000b0053b88b03e24sm9461940oou.18.2023.05.13.14.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 14:21:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fc20e35c-c7e6-cfa5-bdc5-f88ceee12f71@lwfinger.net>
Date:   Sat, 13 May 2023 16:21:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Driver for rtw8723ds
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <13262218.uLZWGnKmhe@jernej-laptop>
 <f3368bf9-c6e6-f418-41da-b9de185acd34@lwfinger.net>
 <21872829.EfDdHjke4D@jernej-laptop>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <21872829.EfDdHjke4D@jernej-laptop>
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

On 5/13/23 15:13, Jernej Škrabec wrote:
> Dne sobota, 13. maj 2023 ob 21:55:51 CEST je Larry Finger napisal(a):
>> On 5/13/23 05:23, Jernej Škrabec wrote:
>>> Larry,
>>>
>>> Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
>>>> On 5/10/23 16:07, Martin Blumenstingl wrote:
>>>>> On Wed, May 10, 2023 at 12:02 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>>> [...]
>>>>>> I added that patch to the driver. The user reports that he was able to do a ping
>>>>>> and an nslookup before it crashed with the following in the log:
>>>>> That's some positive news alongside the crash log: it seems that a
>>>>> part of the driver works! :-)
>>>>>
>>>>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>>>>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NULL>
>>>>> [...]
>>>>>> Somehow skb->tail was greater than skb->end. Unfortunately I do not have access
>>>>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the MangoPi
>>>>>> MQ Quad.
>>>>> I need to have a closer look at the pkg_offset and struct
>>>>> rtw_rx_pkt_stat which we receive.
>>>>> Recently my own MangoPI MQ-Quad arrived but I did not have the time to
>>>>> set it up yet. I'll try to do so during the weekend so I can debug
>>>>> this on my own.
>>>>>
>>>>> Please ping me next week in case I haven't provided any update until then.
>>>>
>>>> I have some test prints in to check for skb overrun. My initial indication is
>>>> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my next run
>>>> should verify that. My changes will do a pr_warn_once() when the problem
>>>> happens, and then drop the skb.
>>>>
>>>> My contact reported that he had one run of 3 minutes before the problem
>>>> happened, which is good news for most of the driver.
>>>
>>> I may have discovered something interesting. rtl8723ds vendor driver has
>>> following checks in RX data parsing code:
>>> https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/rtl8723ds_recv.c#L83-L99
>>>
>>> Those checks are absent in rtl8822bs vendor driver, which was my original
>>> development platform for SDIO. This may indicate some kind of bug in FW
>>> and/or HW.
>>>
>>> I think that at least second check, which checks for exactly the case your
>>> client experience, can be easily added and tested.
>>
>> Thanks for this update. I added the following to the start of rtw_sdio_rx_skb():
>>          /* fix Hardware RX data error, drop whole recv_buffer */
>>          if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
>>                  kfree_skb(skb);
>>                  return;
>>          }
>> I think that duplicates the code in the vendor driver.
>>
>> I have not heard from my user as to whether it helps. My communications with him
>> are at https://github.com/lwfinger/rtl8723ds/issues/37.
> 
> I had second part in mind (see attachment), but this is IMO only sanity check
> and it will mask the issue. At this point I'm not sure if this is something that
> can happen occasionally or is there additional bug in rtw88 code. I'll check
> rtl8723ds c2h code in greater detail.
> 
> In any case, I would argue that all 3 patches in this thread are valid and
> should be submitted upstream.

That patch looks good. I ill apply it to my rtw88 repo.

Larry


