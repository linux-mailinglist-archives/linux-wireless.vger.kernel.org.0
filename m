Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED17703E94
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbjEOUXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjEOUXn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 16:23:43 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A8C1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:23:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19288cce249so10403491fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684182221; x=1686774221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=62b+cmRkmzBEH5fNkZNKyrYt2Tz8fINbUzfKW9vRP50=;
        b=CEPhy+huiUj8kEWZ+D9LTS7LJH42xEejWiFTRzaUskrMk3bg0C0CYTZQriv+a5l0rd
         cleuAuRU5xMlHXDe549uYWUf30ZFSP2YLRlL/4R6li0lhJakKLJmM4zMCNDP3AOs+8gc
         6ilThIuXS+bWFtlsUuj+ydNUANjOgWHX2iMrVUhNF1IY5BYWdOvVk+zLsB/iq8HB7vzz
         EdDycrEdnQva8mEs1UH4O0rdUZFqvRtIh6a40HoKWaxtg4Z9K1Yk3Mc9YGiWBY8bR4Zw
         ig8WaUO7R0K8vgWiBaVHCTWSsIujQUfAp20rVxE18N7RHA5JaKeYHcKogEgurhfazJO4
         teUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684182221; x=1686774221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62b+cmRkmzBEH5fNkZNKyrYt2Tz8fINbUzfKW9vRP50=;
        b=GFbBgaTMTdVNeB8rW5i1PZrnY1GVs6bEL+1FjkncjYNtZ2FL33T0t6OP1XQ1qE2TG1
         tlVbtu6RN+t3pKA0RCYS9sy4HoPAlK0nbydZ0OIO8b8NjAdq2KNHp4TMXtheUqVkYAK3
         jF2uC/XQ76Hw7xLU1SPJBd5KwgvUdjNGzvFnx1Cqi7lL7x0oyOS4we4Eiel7a7abw1pa
         CCwktthhgmEalo026eSXbSv+KPsXYkaK8TNKyoG6/9vxYEA4bknhdIJ5Va65K2D3sGx9
         FNYoKDq7G2wNNXgQ1uY88yhGnCsfVCT2xH7nhti8PJbLYq/DGqm8YYSyxfUd74e2H3wU
         DTLA==
X-Gm-Message-State: AC+VfDxTbxcMuRQyVR75MQSgKYJEz4xkfYFSsYpyA2lReAdLyjMt7Z6M
        VTgFYr6NsXimFtcMdRgxMlVrT8lIzr0=
X-Google-Smtp-Source: ACHHUZ4VL2HrVkOj02Yp8etuLnIjH9+1Q9YOV7XAKCZ7YOCTJ4ESPMnywRN1Z+yqaFpAnuW/xNx/jw==
X-Received: by 2002:a05:6870:8220:b0:18e:ecbb:ad16 with SMTP id n32-20020a056870822000b0018eecbbad16mr17662009oae.21.1684182221091;
        Mon, 15 May 2023 13:23:41 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n40-20020a056870822800b00199c3a06f7esm1614162oae.51.2023.05.15.13.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 13:23:40 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
Date:   Mon, 15 May 2023 15:23:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Driver for rtw8723ds
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <21872829.EfDdHjke4D@jernej-laptop>
 <fc20e35c-c7e6-cfa5-bdc5-f88ceee12f71@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <3162376.5fSG56mABF@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/15/23 11:43, Jernej Škrabec wrote:
> Dne sobota, 13. maj 2023 ob 23:21:47 CEST je Larry Finger napisal(a):
>> On 5/13/23 15:13, Jernej Škrabec wrote:
>>> Dne sobota, 13. maj 2023 ob 21:55:51 CEST je Larry Finger napisal(a):
>>>> On 5/13/23 05:23, Jernej Škrabec wrote:
>>>>> Larry,
>>>>>
>>>>> Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
>>>>>> On 5/10/23 16:07, Martin Blumenstingl wrote:
>>>>>>> On Wed, May 10, 2023 at 12:02 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>>>>> [...]
>>>>>>>> I added that patch to the driver. The user reports that he was able to do a ping
>>>>>>>> and an nslookup before it crashed with the following in the log:
>>>>>>> That's some positive news alongside the crash log: it seems that a
>>>>>>> part of the driver works! :-)
>>>>>>>
>>>>>>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>>>>>>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NULL>
>>>>>>> [...]
>>>>>>>> Somehow skb->tail was greater than skb->end. Unfortunately I do not have access
>>>>>>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the MangoPi
>>>>>>>> MQ Quad.
>>>>>>> I need to have a closer look at the pkg_offset and struct
>>>>>>> rtw_rx_pkt_stat which we receive.
>>>>>>> Recently my own MangoPI MQ-Quad arrived but I did not have the time to
>>>>>>> set it up yet. I'll try to do so during the weekend so I can debug
>>>>>>> this on my own.
>>>>>>>
>>>>>>> Please ping me next week in case I haven't provided any update until then.
>>>>>>
>>>>>> I have some test prints in to check for skb overrun. My initial indication is
>>>>>> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my next run
>>>>>> should verify that. My changes will do a pr_warn_once() when the problem
>>>>>> happens, and then drop the skb.
>>>>>>
>>>>>> My contact reported that he had one run of 3 minutes before the problem
>>>>>> happened, which is good news for most of the driver.
>>>>>
>>>>> I may have discovered something interesting. rtl8723ds vendor driver has
>>>>> following checks in RX data parsing code:
>>>>> https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/rtl8723ds_recv.c#L83-L99
>>>>>
>>>>> Those checks are absent in rtl8822bs vendor driver, which was my original
>>>>> development platform for SDIO. This may indicate some kind of bug in FW
>>>>> and/or HW.
>>>>>
>>>>> I think that at least second check, which checks for exactly the case your
>>>>> client experience, can be easily added and tested.
>>>>
>>>> Thanks for this update. I added the following to the start of rtw_sdio_rx_skb():
>>>>           /* fix Hardware RX data error, drop whole recv_buffer */
>>>>           if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
>>>>                   kfree_skb(skb);
>>>>                   return;
>>>>           }
>>>> I think that duplicates the code in the vendor driver.
>>>>
>>>> I have not heard from my user as to whether it helps. My communications with him
>>>> are at https://github.com/lwfinger/rtl8723ds/issues/37.
>>>
>>> I had second part in mind (see attachment), but this is IMO only sanity check
>>> and it will mask the issue. At this point I'm not sure if this is something that
>>> can happen occasionally or is there additional bug in rtw88 code. I'll check
>>> rtl8723ds c2h code in greater detail.
>>>
>>> In any case, I would argue that all 3 patches in this thread are valid and
>>> should be submitted upstream.
>>
>> That patch looks good. I ill apply it to my rtw88 repo.
> 
> I see that issue is still there. Next idea would be to check if RX aggregation
> is the problem. Just commenting out call to rtw_sdio_enable_rx_aggregation()
> is enough to disable it.

Jernej,

With aggregation disabled, we still get "Invalid RX packet size!" messages. I am 
changing the statement to log (curr_pkt_len + pkt_desc_sz) > rx_len. I will let 
you know when the OP responds.

Larry


