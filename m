Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D1705B72
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjEPXly (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjEPXlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 19:41:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231B527C
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 16:41:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ab0967093dso153425a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684280511; x=1686872511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5OqbjUWSPQ7aIaIGQbhH/u54X9htzzqfehRPAy3oeVA=;
        b=N+se8bLzasUMFYIFs97h3VFz3zzu0j2jcCToV1hJtrNOZ0g5SlmO9a16b+olY7jhH5
         /fKkwvd7fcY5ijoDD63iRVeHXyRuZ/rVvDLQhuyFTxcbH5IMI+uuHpPjtWMcCvf7LLMd
         P5Wc9hcAUABa1OlFvdBhgvPp9I8QN39FzQcrTeL1nQFt32arKkqD/AkHo2EdxrhLjZlF
         XJXR1RStzeMdHrGMgc4VyiuaiIcp7SWQq+1Xnk5du3rffXdw3FS/f55AuJQsfgUz3Nop
         QJkmpEbr8yoncTjwRd9C3GqgJqhq7viRkmDx4hfNuKovt5jAx9AUaIMpWIQiCgDreOVW
         VTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684280511; x=1686872511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OqbjUWSPQ7aIaIGQbhH/u54X9htzzqfehRPAy3oeVA=;
        b=e8SlCl5Yie9yceXzkYZ5db5d6tGluE4f4k0/YuI4yKD6qGmyDZGDXrHx55/HQWIlKL
         nrSpaTLdeQU9wmYF3KxfgRATWYSKcuWleMi3Q81KzxkCKbDuIP1/8zt1u5Fqk1IZp+Nx
         0udeGHrFunw9Ltm7o2Sh0NVdJPMvLr2V41VDROwy5MU1okq19VF3rKqC4jc8cKdGvOPR
         mTGt1WYaQtb2UnMR9AsnRyX7Dm2o66rrblNsYvuEiIkRoshC/4gsdLoLBiyQN55WsnJ6
         Ymv1YffQTZhqAnl5bzOcoGCm4yDwYPayFppcfX5oZX2taZQLKCBHUEbcFEG8IoKHIj2S
         Smfw==
X-Gm-Message-State: AC+VfDyp1XFPREoohqjPQUujcAiZzxE/WRtf/K/s6O66oktltPctCM55
        z+VDdHsh44kIT0Ya5zw0j10=
X-Google-Smtp-Source: ACHHUZ7A/I5l0nkDemGPLrItrqUFtmDhZFN37t1nZapO1D/zlFdXyOxUxSyeMleHjepo23vzYVEU3w==
X-Received: by 2002:a9d:6e0f:0:b0:6ab:75a1:ee1b with SMTP id e15-20020a9d6e0f000000b006ab75a1ee1bmr10504385otr.36.1684280511406;
        Tue, 16 May 2023 16:41:51 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d5c0d000000b006864b5f4650sm13036695otk.46.2023.05.16.16.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 16:41:50 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c11a65bc-9927-898b-b91d-fc876b51e19d@lwfinger.net>
Date:   Tue, 16 May 2023 18:41:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop>
 <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
 <1855371.CQOukoFCf9@jernej-laptop>
 <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
 <CAFBinCAD-7Mi06z-RGVREDQ3bYsDUOyDkBgoNW5mDLuKM8H7sg@mail.gmail.com>
 <7106ab11-197d-e0d1-f54a-f56d438a022d@lwfinger.net>
 <CAFBinCDbY5_xs7eNv5M-GyYGGFSwwTUtRSQSi9R9wZFzumiE5Q@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCDbY5_xs7eNv5M-GyYGGFSwwTUtRSQSi9R9wZFzumiE5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/23 13:48, Martin Blumenstingl wrote:
> Hi Larry,
> 
> On Tue, May 16, 2023 at 8:31 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> [...]
>>>> I'm out of time for today though so I cannot continue testing.
>>> I took time during my lunch break for some more experiments and came
>>> up with the attached patch (the vendor driver does something similar
>>> and I only noticed that after I observed some rtw_rx_pkt_stat with
>>> pkt_len being zero).
>>> It survived 30 minutes of uptime, updating my system and several
>>> iperf3 runs (in both directions).
>>> iperf results:
>>> - RX: 48 Mbit/s
>>> - TX: 33 Mbit/s
>>>
>>> And to be clear, those results are with:
>>> - the word IO bugfix
>>> - the initial two patches from this series
>>> - Larry's addition of the second RTL8723DS SDIO ID
>>> - the attached patch
>>
>> Martin,
>>
>> Please send me a copy of the version of sdio.c that works. It seems likely that
>> I got mine all messed up as the OP at GitHub is getting lots of warnings from
>> net/mac80211/rx.c:803.
> Please take the file from [0] - this is how I successfully tested it.

Thanks. I got it and replaced the one in rtw88. Speedtest shows him getting a 
little over 40 Mbps.

Thanks for the help from both of you,

Larry



