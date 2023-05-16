Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04D705600
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjEPSbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPSbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 14:31:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C94222
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:31:50 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1928ec49077so11392826fac.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684261910; x=1686853910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yINSq1rlA+m03gP+GVoU6HlqBQEH9Yg4DkFgf9kZnio=;
        b=fWnDZchMlhWC4xee4s+rYR/3EJft8LZNTJorcvfoyF+QvSYHJFAAMvlMw8Lc0Stxdq
         jWgOh+d4jsDIpIW/+AdhyptywGjBivbq9oFU1/ZWH77v/tuEpQ8piMOWdHjzkHDkjH+Y
         rbBaTWwXak+65EpRyxX2CfO2YPEYE4fxff/8mfM4W+JTPPfZYlr5uexyQhCOv4l4xZyf
         yj8izzcnIQDGHcYtx+h0YQcPXPc3Z/kXqwsCiXmaihPzsdcrKlFl2sURj419iIVpo60s
         mBhyxpGAt00l2kvdvqf2V++erLxKr/uYnS01yr4SIBm8nt+SHOeRgTeW6Py+jX0gtwL/
         pN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261910; x=1686853910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yINSq1rlA+m03gP+GVoU6HlqBQEH9Yg4DkFgf9kZnio=;
        b=GoWj8TTSVR4VTSOyzvVdy5sdBr/kU/76V3fa0p2zCzRXGAQBT4Vjh4LzwAqmZIhuRa
         cMMYYp+/4SeL9/AiyJxqA8+mkY0k18E05mN0eyZLCe5UUYD3BCeApM50QVBaG9JetowM
         ii2EhQw6meROx6Wzjw/todNcXpc6XR3cqHGYjYjeMSLcgk83JdWcFSRj1KWl1GEk6utv
         Z7b4RZrKgr7C3OQGGCNqXwCBLcLjFlmu1mYP35x7yhBFyUfXhJo3gCXavqsbBCOlhtDj
         O8GW0W5FD+N1RAllsoA/Rw4mpWfpHsIlj18ITbsP+uNXGS0mAA2dwxWB+Wl2XOxHYOHG
         usNw==
X-Gm-Message-State: AC+VfDxc4RBfcaRuTTLdN3ZFzqJWXosYCVB8z4EEa1iG8z6jQaCBBsHe
        EL4dBLvfmPiROpjSqFeFwYk=
X-Google-Smtp-Source: ACHHUZ5vXXrEul7ZZyMtH0qWbdkJH/yG7KBXmFH2NyenDBmz3NN64Y9VLWaxWbDQefvPnZSgxDX6+w==
X-Received: by 2002:a05:6870:c384:b0:195:f311:46ad with SMTP id g4-20020a056870c38400b00195f31146admr22608085oao.15.1684261909790;
        Tue, 16 May 2023 11:31:49 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f23-20020a9d7b57000000b0069f0a85fa36sm8408434oto.57.2023.05.16.11.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:31:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7106ab11-197d-e0d1-f54a-f56d438a022d@lwfinger.net>
Date:   Tue, 16 May 2023 13:31:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop>
 <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
 <1855371.CQOukoFCf9@jernej-laptop>
 <CAFBinCCjzLH7ZZJ9Siw1Lp49qneO+qRJp-g8rGwAYuRwNj2Oyw@mail.gmail.com>
 <CAFBinCAD-7Mi06z-RGVREDQ3bYsDUOyDkBgoNW5mDLuKM8H7sg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCAD-7Mi06z-RGVREDQ3bYsDUOyDkBgoNW5mDLuKM8H7sg@mail.gmail.com>
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

On 5/16/23 05:22, Martin Blumenstingl wrote:
> On Mon, May 15, 2023 at 11:11 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Jernej,
>>
>> On Mon, May 15, 2023 at 10:37 PM Jernej Škrabec
>> <jernej.skrabec@gmail.com> wrote:
>> [...]
>>>> With aggregation disabled, we still get "Invalid RX packet size!" messages. I am
>>>> changing the statement to log (curr_pkt_len + pkt_desc_sz) > rx_len. I will let
>>>> you know when the OP responds.
>>>
>>> Yeah, I saw. I just find another possible reason, which fits nicely in current
>>> situation. Vendor driver parses drv_info_sz and shift fields only if packet
>>> is normal, e.g. not c2h type. However, rtw88 always parses those fields. It's
>>> possible that they have some value which should be ignored on 8723ds. I
>>> appended another patch to test.
>> I tried that patch and it didn't work for me (I can't get the card to
>> assoc to my AP with that patch).
>> Additionally I tried a simplified version (attached) and it didn't work.
>>
>> I'm out of time for today though so I cannot continue testing.
> I took time during my lunch break for some more experiments and came
> up with the attached patch (the vendor driver does something similar
> and I only noticed that after I observed some rtw_rx_pkt_stat with
> pkt_len being zero).
> It survived 30 minutes of uptime, updating my system and several
> iperf3 runs (in both directions).
> iperf results:
> - RX: 48 Mbit/s
> - TX: 33 Mbit/s
> 
> And to be clear, those results are with:
> - the word IO bugfix
> - the initial two patches from this series
> - Larry's addition of the second RTL8723DS SDIO ID
> - the attached patch

Martin,

Please send me a copy of the version of sdio.c that works. It seems likely that 
I got mine all messed up as the OP at GitHub is getting lots of warnings from 
net/mac80211/rx.c:803.

I though I followed all the patches you and Jernej sent, but I must have messed 
something up.

Thanks,

Larry


