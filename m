Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD44C6F86
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiB1ObU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 09:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiB1ObO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 09:31:14 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5557EB3B
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 06:30:33 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nOh2m-00046m-GZ; Mon, 28 Feb 2022 15:30:32 +0100
Message-ID: <9312eb18-840f-9a1f-bcb0-8e3a43e45239@leemhuis.info>
Date:   Mon, 28 Feb 2022 15:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Nico Sneck <snecknico@gmail.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
References: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
 <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-wireless@vger.kernel.org
In-Reply-To: <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646058634;42b7ba50;
X-HE-SMSGID: 1nOh2m-00046m-GZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Yan-Hsuan Chuang, sorry, I failed to notice that you didn't get the
regression report below. Could you take a look what's wrong there?

BTW: Nico, did you try another bisection? And is the problem still
happening? Did you maybe give 5.17-rc a shot to check if the problem
still happens there?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 15.02.22 09:25, Thorsten Leemhuis wrote:
> [...]
> On 14.02.22 20:25, Nico Sneck wrote:
>> Hi,
>>
>> I'm running Fedora 35 on a Huawei Matestation S (HUAWEI PUM-WDX9), AMD
>> Renoir with Realtek rtw_8822ce handling wifi stuff.
>>
>> Ever since the kernel update from 5.15.13-200.fc35 to 5.16.8-200.fc35
>> (which I performed Feb 12th), I noticed that my Wifi connection
>> doesn't really work anymore. I'm connecting to a Zyxel VMG3927-B50A,
>> and it appears to be using 5 GHz connection always. I also tested that
>> 5.17-rc4 also suffers from this issue.
>>
>> The issue is that even trying to ping my routers gateway address will
>> result in connection timeouts, and ping times are in the thousands to
>> tens of thousands of milliseconds (normally peak ping times are ~3-6
>> ms), making wireless unusable with 5.16+.
>> I can also see that in dmesg logs there are two types of rtw_8822ce
>> driver warnings flooding the logs, which I didn't see with 5.15:
>>
>> "helmi 13 18:20:03 fedora kernel: rtw_8822ce 0000:06:00.0: timed out
>> to flush queue {1,2}"
>> "helmi 13 18:16:23 fedora kernel: rtw_8822ce 0000:06:00.0: failed to
>> get tx report from firmware"
>>
>> Some stats:
>> On kernel 5.15.13-200.fc35 running for 29 days:
>> [nico@fedora ~]$ journalctl -k -b -18 | grep 'timed out to flush queue' | wc -l
>> 0
>>
>> [nico@fedora ~]$ journalctl -k -b -18 | grep 'failed to get tx report
>> from firmware' | wc -l
>> 0
>>
>> On kernel 5.16.8-200.fc35 running for 4 hours:
>> [nico@fedora ~]$ journalctl -k -b -17 | grep 'timed out to flush queue' | wc -l
>> 45370
>>
>> [nico@fedora ~]$ journalctl -k -b -17 | grep 'failed to get tx report
>> from firmware' | wc -l
>> 502
>>
>> I tried bisecting which commit introduced this regression, but after
>> some 12 hours of recompiling and testing, it seems like I failed
>> somehow. I tried a bisect with first known good revision as
>> 8bb7eca972ad (5.15 release commit), and first known bad revision as
>> df0cc57e057f (5.16 release commit). I managed to identify that
>> revision
>> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> is bad, but then all other revisions were good apart from
>> 8a33dcc2f6d5 (refs/bisect/bad) Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>> which was also bad.
>> But here's the baffling part, commit 6b278c0cb378 was good, and it's
>> the last commit in the merge (8a33dcc2f6d5) which appeared bad.
>> Now I retested with 8a33dcc2f6d5, and I don't see the issues anymore,
>> so I guess I tested a wrong kernel version at that point or something.
>> shrug.
>>
>> So I can only assume that the regression came in one of the commits inside
>> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> but it'll take me a while to be try bisecting the commits in that merge again.
>>
>> If anyone has any idea about what could cause these issues I'm seeing,
>> I can try out patches / test different things. But I'll try
>> rebisecting this again soon.
>>
>> - Nico
> 
