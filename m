Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C54C7D02
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 23:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiB1WIS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 17:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiB1WHt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 17:07:49 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189ECC55AC
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 14:07:09 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso20383374oon.5
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lqrs3hc5E1oPO593OVEkpPHVfvLkTVtgYaVF90Tj6Ew=;
        b=ZAs00VTUMyL7Luc3LHCeb6WNqjafTPXy8jfUAi3jIunIs1ldWIfFSfBPvqtctpDSoG
         YZpY1Gt5JwZf7nTDuPZBXZbRv4k7GF4tONoJTdgYZ8+/hIDuT4gjd3CdssJQ1Cl2l0Dm
         z3ZkJtBQhg2qbj4NMfnWTPCreXynu2hBwsCdpGpfIvlrKdAPNNCspttCbFx7HFK0dcO3
         y++xVIevpo/7KsVotrip2gI99SFFkqgrSEiS2VDGInH1by1KoMYUqwN9h60cAkR75e73
         OL77/3v8ehNjWSl4sHsauw/5Z5S6FQh/UdXo7XrWS5FqKTUlL5ZaxMeLOW6OCrSJr7vF
         thnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lqrs3hc5E1oPO593OVEkpPHVfvLkTVtgYaVF90Tj6Ew=;
        b=Q74iDSnxbw4DLzrElNG57kz67tm2HnW6v/FOb+GG/ai04BAe/AUJcwPFaYagzJCITE
         wsd1fHAlr7P6SzVLyf4hKbJ9cissO9/oa1R9r8993HqgWqwgrj3jWPE5rmprIAGLTyXa
         chNgmmk0EjrcNMVw0fmbey3PLOeAxNfthcS6i/sN5ATfedWoedFJ+e/wVLhJwz55lzgm
         lToDXXu78k2Rhrt2mm4rvH3sEE8XiOzKZIg0lO1ZWLXpAle12uU2ZVXKjNeS8AUQ1Krf
         upLB+efgGYtXJfqFEM5v57J9XKxs06NTYnoo9cv1wMcQJ6Di/itq+7bwtNKlFkAEUC8r
         f4TA==
X-Gm-Message-State: AOAM531cqCr053gwzUMOLgiak/Zm7QmnYUcx6LgDMTIsULSFSCraiOvA
        W/Bmavv5OIGDyzemfwmn5C8=
X-Google-Smtp-Source: ABdhPJybhAgLju3HSxnTIenKyE7qQaZsc+osuWy48r/F00Z7fgi2MehKAovzXYF/g0zrbIDERyDW1A==
X-Received: by 2002:a05:6870:c43:b0:d7:4c7:5afc with SMTP id lf3-20020a0568700c4300b000d704c75afcmr6554453oab.139.1646086026943;
        Mon, 28 Feb 2022 14:07:06 -0800 (PST)
Received: from ?IPV6:2603:8090:2005:39b3::1064? (2603-8090-2005-39b3-0000-0000-0000-1064.res6.spectrum.com. [2603:8090:2005:39b3::1064])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm5398285oao.3.2022.02.28.14.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 14:07:05 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <236d45a6-8b88-c02e-a61d-ce1773fdb0ef@lwfinger.net>
Date:   Mon, 28 Feb 2022 16:07:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Nico Sneck <snecknico@gmail.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-wireless@vger.kernel.org
References: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
 <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info>
 <9312eb18-840f-9a1f-bcb0-8e3a43e45239@leemhuis.info>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <9312eb18-840f-9a1f-bcb0-8e3a43e45239@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/28/22 08:30, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
> 
> Yan-Hsuan Chuang, sorry, I failed to notice that you didn't get the
> regression report below. Could you take a look what's wrong there?
> 
> BTW: Nico, did you try another bisection? And is the problem still
> happening? Did you maybe give 5.17-rc a shot to check if the problem
> still happens there?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> #regzbot poke
> 
> On 15.02.22 09:25, Thorsten Leemhuis wrote:
>> [...]
>> On 14.02.22 20:25, Nico Sneck wrote:
>>> Hi,
>>>
>>> I'm running Fedora 35 on a Huawei Matestation S (HUAWEI PUM-WDX9), AMD
>>> Renoir with Realtek rtw_8822ce handling wifi stuff.
>>>
>>> Ever since the kernel update from 5.15.13-200.fc35 to 5.16.8-200.fc35
>>> (which I performed Feb 12th), I noticed that my Wifi connection
>>> doesn't really work anymore. I'm connecting to a Zyxel VMG3927-B50A,
>>> and it appears to be using 5 GHz connection always. I also tested that
>>> 5.17-rc4 also suffers from this issue.
>>>
>>> The issue is that even trying to ping my routers gateway address will
>>> result in connection timeouts, and ping times are in the thousands to
>>> tens of thousands of milliseconds (normally peak ping times are ~3-6
>>> ms), making wireless unusable with 5.16+.
>>> I can also see that in dmesg logs there are two types of rtw_8822ce
>>> driver warnings flooding the logs, which I didn't see with 5.15:
>>>
>>> "helmi 13 18:20:03 fedora kernel: rtw_8822ce 0000:06:00.0: timed out
>>> to flush queue {1,2}"
>>> "helmi 13 18:16:23 fedora kernel: rtw_8822ce 0000:06:00.0: failed to
>>> get tx report from firmware"
>>>
>>> Some stats:
>>> On kernel 5.15.13-200.fc35 running for 29 days:
>>> [nico@fedora ~]$ journalctl -k -b -18 | grep 'timed out to flush queue' | wc -l
>>> 0
>>>
>>> [nico@fedora ~]$ journalctl -k -b -18 | grep 'failed to get tx report
>>> from firmware' | wc -l
>>> 0
>>>
>>> On kernel 5.16.8-200.fc35 running for 4 hours:
>>> [nico@fedora ~]$ journalctl -k -b -17 | grep 'timed out to flush queue' | wc -l
>>> 45370
>>>
>>> [nico@fedora ~]$ journalctl -k -b -17 | grep 'failed to get tx report
>>> from firmware' | wc -l
>>> 502
>>>
>>> I tried bisecting which commit introduced this regression, but after
>>> some 12 hours of recompiling and testing, it seems like I failed
>>> somehow. I tried a bisect with first known good revision as
>>> 8bb7eca972ad (5.15 release commit), and first known bad revision as
>>> df0cc57e057f (5.16 release commit). I managed to identify that
>>> revision
>>> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>>> is bad, but then all other revisions were good apart from
>>> 8a33dcc2f6d5 (refs/bisect/bad) Merge
>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>> which was also bad.
>>> But here's the baffling part, commit 6b278c0cb378 was good, and it's
>>> the last commit in the merge (8a33dcc2f6d5) which appeared bad.
>>> Now I retested with 8a33dcc2f6d5, and I don't see the issues anymore,
>>> so I guess I tested a wrong kernel version at that point or something.
>>> shrug.
>>>
>>> So I can only assume that the regression came in one of the commits inside
>>> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>>> but it'll take me a while to be try bisecting the commits in that merge again.
>>>
>>> If anyone has any idea about what could cause these issues I'm seeing,
>>> I can try out patches / test different things. But I'll try
>>> rebisecting this again soon.

Nico,

Your use of rtw_8822ce in the title finally registered on me. With that driver 
in use, that means that you are using my GitHub repo; however, newer kernels 
have the driver built in, but with names such as rtw88_8822ce. The difference in 
the name is deliberate. If you want to use the GitHub version, you must 
blacklist the ones from the kernel.

To check this, run 'lsmod | grep 88'. If you see a mixture of rtw_xxx and 
rtw88_xxx, then this is your problem.

Larry

