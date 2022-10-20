Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6A605A19
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJTIlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJTIlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 04:41:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C615B12B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 01:41:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l28so13275937qtv.4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/AThwvADeBAp+alg9WOruwZf/m3b3fMO0/6Sqpu80k=;
        b=KnwDVBaBid5r6hkQHqjieUG+9VC//zO5Y0c2Mj2VocAfax8/mD6RnKtsvgyQhTlKQf
         YyPMlJjohuuWeXsLnSsN2Wo79Kb/XAsMh+Dq9l7+C5UPZhKifsUxA4CN6lUUIDRO+GH8
         QrNhNiZjU9zl8Qs/tBJYwBO2P1CsocdHw7KHt9rS2ZzYK0V/C6Y/IRg875JYp2OErryN
         Sisno9oGmVebXqKCPZshoGUVXKswarSAbhnb6g9dsqqou2Kg4u/g/STxQnizqejjyNAv
         rlq1VDuVijIfRDzW803H0jpIKrAtyQTYx94SQKeHLm+8QUsdSlNsNTjRGNC6zVSU74mI
         IaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/AThwvADeBAp+alg9WOruwZf/m3b3fMO0/6Sqpu80k=;
        b=AHdzydNbNa5iBzElhO7sZ6PLBEh8LRbAB9dcV+yzwE5t+kuYSMdaXp40qD7wxRVljP
         lrZJU1SGoNrjEB4xMipTESzxQuRb++BaFO7o3oCQBExnI1/0hHulEzM5K2FhXGNWsj1v
         dDcidDDitv6ZRBeHOvFUhZvMWEADhaK78IObc+rJVPtLEfsIGT0euXxHwryUHz9TpyPk
         hQdh6a5N4PFFqeQEAAWf30H7vuq4qjFiEZto0zoE6zQOsAMpm5aBH5Kktz92Uo5xUQJZ
         B1BXNlEJJbMkAnF9TOqFbWxF5LIcGBNShZs74wm4/ewFknnJgAvwhn3qnvcL7zAwdsAX
         e+9Q==
X-Gm-Message-State: ACrzQf0T1xLQF0yEFLLmtK7RoXP9MhjBXgr9/xehYFMHAtUn3RBXns8Q
        rgSSlna/wnqosPFOxus4hzgQZ8Kdoa+ZRL2T
X-Google-Smtp-Source: AMsMyM4+xj4wgnIuy7v6zrNwkw02QnqwTM6LWJS8gLEU7XJb+y5uLsy+eNZ92RiVABbBZLRAGki0ZQ==
X-Received: by 2002:ac8:5708:0:b0:39c:e967:bc05 with SMTP id 8-20020ac85708000000b0039ce967bc05mr9885333qtw.493.1666255296195;
        Thu, 20 Oct 2022 01:41:36 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a408300b006ce515196a7sm6983954qko.8.2022.10.20.01.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:41:35 -0700 (PDT)
Message-ID: <e3e67383-6f34-825b-8a2c-1c6decc44576@gmail.com>
Date:   Thu, 20 Oct 2022 10:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Content-Language: en-US
From:   Arend Van Spriel <aspriel@gmail.com>
To:     Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
References: <20221020014907.GA338234@laguna>
 <649de84e-6f9a-5c6b-9a94-a7c6462abd1f@gmail.com>
In-Reply-To: <649de84e-6f9a-5c6b-9a94-a7c6462abd1f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/20/2022 10:39 AM, Arend Van Spriel wrote:
>> -        else
>> +        } else {
>> +            if (emsg.bsscfgidx >= BRCMF_MAX_IFS) {
>> +                bphy_err(drvr, "invalid bsscfg index: %u\n", 
>> emsg.bsscfgidx);
>> +                goto event_free;
>> +            }
> 
> probably better to do the validation before any other handling. So right 
> after converting the event message at line 245
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c#L245 

Actually, if we ignore the event message we can avoid the whole 
conversion as well doing the validation before the convert.

Regards,
Arend
