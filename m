Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540486A9E3F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCCSP0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 13:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCCSPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 13:15:23 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC04126CC
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 10:15:22 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bk32so2426444oib.10
        for <linux-wireless@vger.kernel.org>; Fri, 03 Mar 2023 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677867322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toedUjjXm5nveDQodC1kIxJXLJREqjFOoJ91sbvmPAw=;
        b=JQ3pFXMlSGPIl/hS9omxPxk97oIZ2UQOxNfDbRdq8CQGIIMnhIduxEcJhrqHGv7G6I
         HfwxPUIN/2Nrrsi7KYjSgiDI5RGRc/KnEXoa1gfswlkT0/XqXiUpIlFpr768Cq5zxgOi
         Gr2bhHKpqlkppzhjKBfbuA0DCwHQQp3Ug3mZ6zplTd43PiTO79ji5Pq//u3VAiJ6BCGp
         76PbrhyU+e2+X7+/4fTfkcD9+twp847L4Eeschro6V2uJ7/QfiNxWDrbg9c4snGHBsDw
         mbzjpIXxDUA6fhJuoE63TfYRtr7vugzY4H6PeoAUndOXVEcqQAENDjlL67lR9SEirk+F
         veIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toedUjjXm5nveDQodC1kIxJXLJREqjFOoJ91sbvmPAw=;
        b=fzqS0LpgRY4RP5iXSXt5PagElSHIwgspieKdt83cIarzZf/8lv3wNjW8/iQ0N44m9+
         Rrdr6v2MLeLuc8ZjCkUVDkUjGzqTUZ5+bDCoMiP9grhE/tr4Knr7nCykoJfz6K5+wRR6
         P2M2dOrWSerR6ctvlGo3X2cErBiu4/QeSwLSaJCq3JZ73ex0IIMosmqoMZnuPqRCjAjd
         bwfXn+dM/kbFMutVIp4URETocolyG4LKiA/ggohc0kDP8VhThQ9f+lrA+Bf+/NTRehAl
         wGAv2W/KuW31G150p4BvXJe1eSxMIXjoK+JgbOk9ahroJtpTgL+dWEqUAqMB0cro5ZTq
         x3uQ==
X-Gm-Message-State: AO0yUKXWodi5PZj+bERWuP4VWZBxdPUZzNkc4iIASMvYHAxDkWloImtQ
        K7OJ/9YaOpfrIdYYTAIzPKFttgdyNC8=
X-Google-Smtp-Source: AK7set+yzTajIiDMLsrldbUwXONlk6GqPXTmLZEeB2z03GsTn3IM7teqLouuB1LTO1OXqVqi1+FyyA==
X-Received: by 2002:a05:6808:8cc:b0:37f:9ac9:2d1b with SMTP id k12-20020a05680808cc00b0037f9ac92d1bmr1108476oij.28.1677867321817;
        Fri, 03 Mar 2023 10:15:21 -0800 (PST)
Received: from [192.168.7.168] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id l23-20020aca1917000000b00383e12bedebsm1183362oii.9.2023.03.03.10.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:15:21 -0800 (PST)
Message-ID: <f9eff2cd-8afc-2124-4d02-ed998195c649@gmail.com>
Date:   Fri, 3 Mar 2023 12:15:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Issues with rtw88_8821cu
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        neojou@gmail.com
References: <ee614c10-cfd7-de88-3f85-6448aaa17c5a@gmail.com>
 <20230303125147.GV32097@pengutronix.de>
 <71855f0a-c8f4-9011-2edd-08e1a3eec782@lwfinger.net>
From:   "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <71855f0a-c8f4-9011-2edd-08e1a3eec782@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/3/23 09:53, Larry Finger wrote:
> On 3/3/23 06:51, Sascha Hauer wrote:
>> documentation for these chips and the downstream drivers are a complete
>> mess.
>>
>> Have you tried one of these drivers?
>>
>> https://github.com/lwfinger/rtw88
>> https://github.com/ulli-kroll/rtw88-usb
>>
>> The code is based on the kernel driver and the RTW88 USB support in the
>> kernel is derived from these drivers. There is a chance that I broke
>> something while porting it upstream and if yes it should be fairly easy
>> to sort out.
> 
> My repo is based on code from the wireless-next repo, thus any upstream 
> error will also be in it.
> 

I've had similar results with both repos. ulli-kroll's was a bit weird, 
as I had to use an older kernel -- but I saw the same issue with 2.4GHz 
channels, as well as the occasional USB issues.

Alex
