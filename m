Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67072081C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFBREf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjFBREe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 13:04:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA51A5
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 10:04:30 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6af7fef214cso1704950a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jun 2023 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685725470; x=1688317470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cKrHYet6llFnEg6Amewt06yqKX1PqZs4gfohiQb1qXQ=;
        b=oJno2wNcmD2LZmRJdlevSHvGI8+Dqo2332JQK9r2/YB7MmLe4OCfFTGVs1hDYKtVdA
         prE0rp4r/brEDg8aOZ1itpUgIt3VmXOLZxcQE0+3QNsgzatg9Q/qVxJ3tzEWE5zLhTg6
         MMkpAu/pKU8kmLMUss8njoi1jGVZIvN+3l+Ygiruo4yud/8czONVKv+sEEXle9eIXYqi
         Lftc6fzuzTLwMl8shrPZC45nbEFqRxRHGGN6CcNsg2qRXTAC6Sgne/LWLNJ7VZLymL5c
         OViJ9Aa9mC8o/M/+0X65tG5wGgYwvzFgljLa1FYgxBCONWfBcOWVQzfAylExAPZJ1bbN
         r3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725470; x=1688317470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKrHYet6llFnEg6Amewt06yqKX1PqZs4gfohiQb1qXQ=;
        b=Qk24c6sfbSbPQXjmddKFalOhtcbG7+dYB/XEMJ2yoK+6CpCYJWVwTw0Ln5HQadBN2Q
         Q1JM69PD2rbumGCC0wcPp6zz8cT3z/DR+tUn+gc6gbhI9a1QdjRi8yu4Wv5w8swRiet4
         7Nk5dsmluPjLdiGPwXANgNcVT8t3HX0fAK91iL/eOexFCapyJG9jQ6WpXbmxbhAG8tea
         8lXkfrePUuDIhf5VAoFjf8Ksq7+IeJ+sKMDkTGy5XKXfwDCLO5aX1BlILY/xoslwXCAe
         ukbRCmZMlpf6jGaodBEGdYPrvPlSuPMHfc2nMrd2ZZVOlgiMDAFk+2ObHLFeJEfuFjgd
         4rTg==
X-Gm-Message-State: AC+VfDyyQpRV5WxteeVBCRDhCU8jU8waWGm5vUmXezG71sAAvj005thL
        n82UWNhVS/plOnVSAwOtvnND07JaGtgzFQ==
X-Google-Smtp-Source: ACHHUZ73127aT8Fj3DmTriIe3tuwlSkoMlNtnHK6j7bI6KVJSa9SH1/xBmaSqEihmWqdCmdIeWOrzg==
X-Received: by 2002:a9d:728d:0:b0:6af:9d11:1342 with SMTP id t13-20020a9d728d000000b006af9d111342mr1467747otj.4.1685725470077;
        Fri, 02 Jun 2023 10:04:30 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id b3-20020a05687051c300b0019a291d1672sm809018oaj.26.2023.06.02.10.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:04:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
Date:   Fri, 2 Jun 2023 12:04:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: RTL8822BE not working after suspend
Content-Language: en-US
To:     Utkarsh Verma <utkarsh.naveen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
 <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
 <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
 <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/2/23 08:59, James wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216386
> 
> You could try https://github.com/lwfinger/rtw88
> 
> Jun. 2, 2023 00:19:28 Utkarsh Verma <utkarsh.naveen@gmail.com>:
> 
>> I had been using Linux v6.3.5 for a while and switched to v6.1.31-lts
>> only yesterday, hoping it might work. The same issue happens on newer
>> kernels like Linux v6.3.5 as well.

Utkarsh,

Although James top posting made it difficult to send this properly, he is 
correct to suggest using the rtw88 repo at GitHub.com. It contains code that 
will not be in released kernels until v6.5.

Most systems handle suspend or hibernation correctly, there are some that do 
not. To my knowledge, all of these have been recent HP or Lenovo laptops where 
the BIOS does not handle D3HOT to D0 transitions.

If using rtw88 does not help your system, your best resolution is to install a 
script in /usr/lib/systemd/system-sleep/ that will unload the driver before 
sleep/hibernation, and restore it on resume. Repo rtw88 has scripts for all of 
the PCI drivers, and README.md tells you what to do.

Larry


