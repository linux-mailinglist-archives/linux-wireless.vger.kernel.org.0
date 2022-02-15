Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7C4B65FC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 09:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiBOIZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 03:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiBOIZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 03:25:38 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E02B9381
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 00:25:28 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nJt9K-0003iE-3h; Tue, 15 Feb 2022 09:25:26 +0100
Message-ID: <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info>
Date:   Tue, 15 Feb 2022 09:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
Content-Language: en-BS
To:     Nico Sneck <snecknico@gmail.com>, linux-wireless@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644913528;73702b06;
X-HE-SMSGID: 1nJt9K-0003iE-3h
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.15..v5.16
#regzbot title net: wireless: rtw_8822ce: Wifi connection doesn't really
work anymore
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), if
they are relevant just for regzbot. With a bit of luck no such messages
will be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.



On 14.02.22 20:25, Nico Sneck wrote:
> Hi,
> 
> I'm running Fedora 35 on a Huawei Matestation S (HUAWEI PUM-WDX9), AMD
> Renoir with Realtek rtw_8822ce handling wifi stuff.
> 
> Ever since the kernel update from 5.15.13-200.fc35 to 5.16.8-200.fc35
> (which I performed Feb 12th), I noticed that my Wifi connection
> doesn't really work anymore. I'm connecting to a Zyxel VMG3927-B50A,
> and it appears to be using 5 GHz connection always. I also tested that
> 5.17-rc4 also suffers from this issue.
> 
> The issue is that even trying to ping my routers gateway address will
> result in connection timeouts, and ping times are in the thousands to
> tens of thousands of milliseconds (normally peak ping times are ~3-6
> ms), making wireless unusable with 5.16+.
> I can also see that in dmesg logs there are two types of rtw_8822ce
> driver warnings flooding the logs, which I didn't see with 5.15:
> 
> "helmi 13 18:20:03 fedora kernel: rtw_8822ce 0000:06:00.0: timed out
> to flush queue {1,2}"
> "helmi 13 18:16:23 fedora kernel: rtw_8822ce 0000:06:00.0: failed to
> get tx report from firmware"
> 
> Some stats:
> On kernel 5.15.13-200.fc35 running for 29 days:
> [nico@fedora ~]$ journalctl -k -b -18 | grep 'timed out to flush queue' | wc -l
> 0
> 
> [nico@fedora ~]$ journalctl -k -b -18 | grep 'failed to get tx report
> from firmware' | wc -l
> 0
> 
> On kernel 5.16.8-200.fc35 running for 4 hours:
> [nico@fedora ~]$ journalctl -k -b -17 | grep 'timed out to flush queue' | wc -l
> 45370
> 
> [nico@fedora ~]$ journalctl -k -b -17 | grep 'failed to get tx report
> from firmware' | wc -l
> 502
> 
> I tried bisecting which commit introduced this regression, but after
> some 12 hours of recompiling and testing, it seems like I failed
> somehow. I tried a bisect with first known good revision as
> 8bb7eca972ad (5.15 release commit), and first known bad revision as
> df0cc57e057f (5.16 release commit). I managed to identify that
> revision
> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> is bad, but then all other revisions were good apart from
> 8a33dcc2f6d5 (refs/bisect/bad) Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> which was also bad.
> But here's the baffling part, commit 6b278c0cb378 was good, and it's
> the last commit in the merge (8a33dcc2f6d5) which appeared bad.
> Now I retested with 8a33dcc2f6d5, and I don't see the issues anymore,
> so I guess I tested a wrong kernel version at that point or something.
> shrug.
> 
> So I can only assume that the regression came in one of the commits inside
> fc02cb2b37fe Merge tag 'net-next-for-5.16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> but it'll take me a while to be try bisecting the commits in that merge again.
> 
> If anyone has any idea about what could cause these issues I'm seeing,
> I can try out patches / test different things. But I'll try
> rebisecting this again soon.
> 
> - Nico

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
