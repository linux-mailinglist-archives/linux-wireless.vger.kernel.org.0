Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810894B5B26
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiBNUoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 15:44:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiBNUof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 15:44:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3251B8592
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 12:41:37 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u13so18735693oie.5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zq+5j0ur9Coiwn+9u0szKfRHwZCnaaKSoQ7ilJ4DDxg=;
        b=PsT33FLXmpCDJFk0l64ta/ElRS6EJTtFeePLLsEJu0pdDON1exoyY/iUBJ7MY71ZWm
         lsAqG7SLhWsj0vThObkt4yvgnD3qh1/NsN0P8g40hanm4iDGKYVJcMyDnfHv3n/JnN/6
         ZhlnJ7vFf8ibZ/GZVAJj0M0iL90gcmvx91lQ84SrGoQz8NErqdEAcVA32skW1gl5JKrj
         t0GlOgC7yEeAivFJMuc9UWmF07isQ+ksUBXI8YTT6YyUpj4pdaYp5BsIyltnTrO9puIW
         MrDvBe3kKShJ7IRHzD1ob/p6AKiKQStU6AvvZaILYFPri5KfdSFyxbdFsU5eR21U87PR
         WWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zq+5j0ur9Coiwn+9u0szKfRHwZCnaaKSoQ7ilJ4DDxg=;
        b=gtH43SC9+zANtl+T0wcoJKXjIMkJdR4yyI6QlH4GwgoHxdARVF33u8+K5zc4CP/Esx
         UlhMX1W6kIC0iSUnz4TMSAhPyXcNH1t7GCTxaUiCy76CRhj00iE9hrV9d27SjE7kbsGj
         4/4/Sa4c50j9rXjKl5HtANr6/A/hXNyVSKkibENZqY+mOwE4WRXMqybJhuEpYCJI5/OE
         8qCJEXi/DrRNLjOUP9PL1clKfKkYs3FmAM2K/6N/yGOb9Bvqg6Seh9i8KgF5q0u6smh+
         nP+YNSvvJ4jmikiI6G9lqCK1+jT4gg1e2Nei5Q2wmiqOB0vVDTUABoeU6FGWZQiARiuF
         XxzQ==
X-Gm-Message-State: AOAM532T6rTnaQrX1yIiZZNHolgriQpfy7fmqfuZsteNexK+GiN64f19
        hq60XP1+muv15Cx7MX9VqC8586cJIOR+E0vXk5FEk7gT8g1ssA==
X-Google-Smtp-Source: ABdhPJy5LNS4DzJH1RqHMAfFywp1C5kiCU7xj9ez8FnuedyR3cq57ViPFCW8GLvsRQhZilY5pz3qYOgQ4E3q/98WSTw=
X-Received: by 2002:a17:90a:6e47:b0:1b9:1154:6635 with SMTP id
 s7-20020a17090a6e4700b001b911546635mr215911pjm.118.1644866766329; Mon, 14 Feb
 2022 11:26:06 -0800 (PST)
MIME-Version: 1.0
From:   Nico Sneck <snecknico@gmail.com>
Date:   Mon, 14 Feb 2022 21:25:55 +0200
Message-ID: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
Subject: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
To:     linux-wireless@vger.kernel.org
Cc:     snecknico@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm running Fedora 35 on a Huawei Matestation S (HUAWEI PUM-WDX9), AMD
Renoir with Realtek rtw_8822ce handling wifi stuff.

Ever since the kernel update from 5.15.13-200.fc35 to 5.16.8-200.fc35
(which I performed Feb 12th), I noticed that my Wifi connection
doesn't really work anymore. I'm connecting to a Zyxel VMG3927-B50A,
and it appears to be using 5 GHz connection always. I also tested that
5.17-rc4 also suffers from this issue.

The issue is that even trying to ping my routers gateway address will
result in connection timeouts, and ping times are in the thousands to
tens of thousands of milliseconds (normally peak ping times are ~3-6
ms), making wireless unusable with 5.16+.
I can also see that in dmesg logs there are two types of rtw_8822ce
driver warnings flooding the logs, which I didn't see with 5.15:

"helmi 13 18:20:03 fedora kernel: rtw_8822ce 0000:06:00.0: timed out
to flush queue {1,2}"
"helmi 13 18:16:23 fedora kernel: rtw_8822ce 0000:06:00.0: failed to
get tx report from firmware"

Some stats:
On kernel 5.15.13-200.fc35 running for 29 days:
[nico@fedora ~]$ journalctl -k -b -18 | grep 'timed out to flush queue' | wc -l
0

[nico@fedora ~]$ journalctl -k -b -18 | grep 'failed to get tx report
from firmware' | wc -l
0

On kernel 5.16.8-200.fc35 running for 4 hours:
[nico@fedora ~]$ journalctl -k -b -17 | grep 'timed out to flush queue' | wc -l
45370

[nico@fedora ~]$ journalctl -k -b -17 | grep 'failed to get tx report
from firmware' | wc -l
502

I tried bisecting which commit introduced this regression, but after
some 12 hours of recompiling and testing, it seems like I failed
somehow. I tried a bisect with first known good revision as
8bb7eca972ad (5.15 release commit), and first known bad revision as
df0cc57e057f (5.16 release commit). I managed to identify that
revision
fc02cb2b37fe Merge tag 'net-next-for-5.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
is bad, but then all other revisions were good apart from
8a33dcc2f6d5 (refs/bisect/bad) Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
which was also bad.
But here's the baffling part, commit 6b278c0cb378 was good, and it's
the last commit in the merge (8a33dcc2f6d5) which appeared bad.
Now I retested with 8a33dcc2f6d5, and I don't see the issues anymore,
so I guess I tested a wrong kernel version at that point or something.
shrug.

So I can only assume that the regression came in one of the commits inside
fc02cb2b37fe Merge tag 'net-next-for-5.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
but it'll take me a while to be try bisecting the commits in that merge again.

If anyone has any idea about what could cause these issues I'm seeing,
I can try out patches / test different things. But I'll try
rebisecting this again soon.

- Nico
