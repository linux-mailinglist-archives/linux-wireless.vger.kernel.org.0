Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556136C08D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 03:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCTCLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Mar 2023 22:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTCLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Mar 2023 22:11:51 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C018B2B
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 19:11:50 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id q79-20020a4a3352000000b0052fe885deddso1704530ooq.0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679278309;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OKXR7wSwYjQMJwYJ5IN26xPwqxndgDNAQwDMuGTvdAo=;
        b=OOJBseEnVp/8vtTgwuWY+s9BB0LmJ4KGuOM55/XI2uXFe/XwBAay8kfZ+DZQ24ch1R
         h/zAZcyRFmg1hpSN3a9aW2U8K8aHmKq05wB9frkVhqnEQvp8TRKRMdkAEUMQuPz6m3Nl
         IyEeh3cyhubXgvsyBIbwjU8OHXptDJB3/Y8e1hANmCFidPCREtLlsBxOG1SGw0dzKr4g
         quwE9/ADhbSDuaF6v2aTqUR1zKVfeXRSGcIaUICi+c0DBjEPnu61D+Y7p/0Q96upf1QB
         rGpnnrN+a/39ex2tYQW6tMwVvgRBpdGTWYM7Mekywo9LqKZLFynmJGUbgAsBkzgzYYTK
         Z+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679278309;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKXR7wSwYjQMJwYJ5IN26xPwqxndgDNAQwDMuGTvdAo=;
        b=FqrTBnwgcod1nnk6SIFxs5vlc8Q7JYHAAulcsY3uGrbx17z+AUr34bbQ9GUG/yLN3a
         jvBWS2FlhuDptIEBFtvMvRo/s9wNGDg6/T+reWNYv6YTyz+1f80mvAJQgEsHhFLe66rX
         yXRxF29p2esQ6VcFY1WLLbYReTYnlsVzfQzQOXuy1BLBMa/ge7/sad5gK7xN57muLRgV
         D1Jkslti3g/WYBsYaFlcxGsAH7KkWAIrecv5EH2cknjg0GvqsHjn55BOndH1IL6+pvUj
         EC9NMTRBLPS6uAUrjB36M7z58j4SiE9u64tj0az2XnLtO1tdzEycr5YqHaZTO43Vzh0Q
         OVWA==
X-Gm-Message-State: AO0yUKWBOXBXjbfiHfXmLGv+joT5h4m+Na2UmxocZ8eKYlVeZ2UvCxU8
        sP9vp4o/c97tYMVsMiHmFUDRyEOVc4s=
X-Google-Smtp-Source: AK7set+AtE5FZ84aEcc5Qiz2Js3thKIdZhFk3AjuY8KUvb+U7O0z7iAS3CqVhXTT3LZfhfDP2KXOpw==
X-Received: by 2002:a4a:d756:0:b0:53b:1086:7a09 with SMTP id h22-20020a4ad756000000b0053b10867a09mr970915oot.3.1679278309541;
        Sun, 19 Mar 2023 19:11:49 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d68-20020a4a5247000000b004fd878ef510sm3386474oob.21.2023.03.19.19.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 19:11:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3f92a510-d8e3-4a6f-c963-bb38d416ed06@lwfinger.net>
Date:   Sun, 19 Mar 2023 21:11:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Kernel 6.2.4 and WiFi with BCM4345
Content-Language: en-US
To:     arm@lists.opensuse.org, Michael Ayers <anothergrump@runbox.com>
References: <e26eeebb-4fb0-5506-afbc-e9b56b849211@runbox.com>
 <c09e012e-7abd-7304-3721-799758a7f0e3@lwfinger.net>
 <cc6e8c12-33b7-7c42-345b-c3212b13bc77@runbox.com>
 <fa88eb52-7194-ecb2-0590-f554a12485ec@runbox.com>
 <1db6b607-faff-9ae2-0cf3-567d9c86e4ba@lwfinger.net>
 <a1953a58-9bdb-384a-42ca-503389aed8e5@runbox.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <a1953a58-9bdb-384a-42ca-503389aed8e5@runbox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/19/23 20:41, Michael Ayers wrote:
> 
> On 20/03/23 13:12, Larry Finger wrote:
>> On 3/19/23 14:35, Michael Ayers wrote:
>>>
>>> On 20/03/2023 08:24, Michael Ayers wrote:
>>>>
>>>> On 20/03/2023 07:58, Larry Finger wrote:
>>>>> On 3/19/23 13:20, Michael Ayers wrote:
>>>>>> Kernel 6.2.4-1-default has broken wifi on the Pinebook pro, kernel 
>>>>>> 6.2.1-1-default works fine.
>>>>>>
>>>>>> Logs give me so much information that I am not sure where to begin.
>>>>>
>>>>> The first piece of information would be to tell us what what device you 
>>>>> have. The Pinebrook Pro web site says that you have an 802.11ac (Wifi 5) 
>>>>> device, but not who made it. The output of 'lspci -nn' or 'lsusb' would be 
>>>>> useful.
>>>>>
>>>>> You should also run the command 'sudo dmesg > dmesg.txt', and post 
>>>>> dmesg.txt at pastebin.com, or some similar site. Report the URL back with 
>>>>> the ouput of the two commands above. Do not attach dmesg.txt to your reply. 
>>>>> There are thousands of readers of this list that do not care, thus they 
>>>>> should not be forced to download such stuff.
>>>>>
>>>>> Larry
>>>>>
>>>>>
>>>> The wifi device would seem to be a Broadcom 4345 and if I've done this right 
>>>> this: https://pastebin.com/rz2wnuVt should be the link to dmesg.txt.
>>>>
>>>> MIke
>>>
>>>
>>> Sorry that is the wrong dmesg link it should be: https://pastebin.com/SE0DV7XP
>>
>> Mike,
>>
>> I just noticed that the linux-wireless list was not in the Cc list - I added 
>> it. I also changed the subject to help catch the attention of the Broadcom 
>> maintainers. I am definitely not one of them.
>>
>> Your device is a BCM4345, which uses the brcmfmac driver. The dmesg output 
>> that you posted shows the firmware loading, but nothing happens beyond that. 
>> This is the point where I would expect the user-space code such as 
>> NetworkManager to take over. What code do you use to control wifi? Did that 
>> change when your kernel was updated?
>>
>> Larry
>>
>>
> Larry,
> 
> I'm using NetworkManager but I also tried Wicked with the same results.
> 
> NetworkManager tries to connect but fails.

Why was that not logged in your dmesg output?

Broadcom devs: Is there something in kernels 6.2.2 or later that break connections?

Larry


