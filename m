Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1D6FE66C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEJVr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJVr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 17:47:28 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC146A2
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 14:47:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ab15dbef23so2420370a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683755246; x=1686347246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LvSTkry1ew7TKELSDad35g2VKPhoHTy+IPggF2f7vmw=;
        b=CB8VQNkVjMIaGt/8F/aWnSOvQEhsXRZTml0lk3J9ETcMJWH0femxM6LaGoEZaA3IqN
         ZD0PIGEZpu9hNWX8jOaOgN1ziC2QzHL9jSde48lM7Pup9y6dP9FRAw/ZAOlbyrQhNu6j
         /eiPL+eG87t5zBlLrxZfBx2rg7njU5MuxJH/uoMDsyeQmWDUp43tHa8YMrDyEvs1Xe/j
         FfF+5jSTQg6NshheSN1iQ6aqawmOOfvDe5/7y6meDoxf9lr2qn4yQLZ7siUEGTQb0cVi
         oMjD5SLMKpV0K8DUAgluuiAPGfANtXxaqvk4jicHUQiPp7IviviRjXPmB2cA9AKl6HMa
         7//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755246; x=1686347246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvSTkry1ew7TKELSDad35g2VKPhoHTy+IPggF2f7vmw=;
        b=HNyalCE+HW2UwCLNttwT1x1RqMSexmXgPkCHCgeATD8VHUsWiUQkAfbVmdD1/7a7sK
         0XE+zBLTtuapGsofeTCxArpXWi5XCtuzLXRoC9pDr5QfrFn4e5rDUvHrFTg/ohPlbMaU
         ozLPSvSMPpUa8mjMQC0zCakz+wHZB29UBuSvmbkrwaQ05npV6pBKwJvDfmt6GuYokbrV
         BSgy4/Kw8s0EAUzdNJgo5LIoqc8A1tArjYDyZ3wLomaXzoSXqCJQ7/0PzoZ14TpLyYlB
         Gd8kVCAAkCSaDn/bsPHyE1EPOaF0IoL866E0ysUvENQxuHfWUFTtekT7JFFfijTxY41O
         ca+A==
X-Gm-Message-State: AC+VfDwBa8ioe7LxqeQ7fY2iLxfRqzpSLnnqw0fXObCTKY7o+j7+SYZw
        8FqajzfBzTLPJv6tZNlvLfA=
X-Google-Smtp-Source: ACHHUZ6zJ7c0/hEDddzCW626ueRKlYtFsbj90xDhDziCxZ2PgluV3YiyU6jLskwylYczNtYycYbiig==
X-Received: by 2002:a05:6830:1e55:b0:6ab:b4e:8337 with SMTP id e21-20020a0568301e5500b006ab0b4e8337mr3531784otj.8.1683755246059;
        Wed, 10 May 2023 14:47:26 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l17-20020a9d7a91000000b00690e990e61asm357129otn.14.2023.05.10.14.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:47:25 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <880bb4ed-f3a5-2d7f-db10-fec65087dd05@lwfinger.net>
Date:   Wed, 10 May 2023 16:47:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop>
 <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
 <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net>
 <CAFBinCCdbt0OAHMnGPYA+xH8WC1nWqJPP5aBU48R=LHRu_xuew@mail.gmail.com>
 <77bdcc7b-c3b2-7c3b-5146-9b7f8c3ae5a7@lwfinger.net>
 <CAFBinCAA2CXZBRO7yb4Hjg6Cos4JFQiCMWZLGVh8DCOYWg7HhA@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCAA2CXZBRO7yb4Hjg6Cos4JFQiCMWZLGVh8DCOYWg7HhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/10/23 16:07, Martin Blumenstingl wrote:
> On Wed, May 10, 2023 at 12:02 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> [...]
>> I added that patch to the driver. The user reports that he was able to do a ping
>> and an nslookup before it crashed with the following in the log:
> That's some positive news alongside the crash log: it seems that a
> part of the driver works! :-)
> 
>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NULL>
> [...]
>> Somehow skb->tail was greater than skb->end. Unfortunately I do not have access
>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the MangoPi
>> MQ Quad.
> I need to have a closer look at the pkg_offset and struct
> rtw_rx_pkt_stat which we receive.
> Recently my own MangoPI MQ-Quad arrived but I did not have the time to
> set it up yet. I'll try to do so during the weekend so I can debug
> this on my own.
> 
> Please ping me next week in case I haven't provided any update until then.

I have some test prints in to check for skb overrun. My initial indication is 
that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my next run 
should verify that. My changes will do a pr_warn_once() when the problem 
happens, and then drop the skb.

My contact reported that he had one run of 3 minutes before the problem 
happened, which is good news for most of the driver.

Larry


