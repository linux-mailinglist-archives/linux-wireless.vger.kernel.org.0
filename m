Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6E4DB798
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353546AbiCPRvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiCPRvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 13:51:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F16C948
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 10:50:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n15so2427207plh.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhoEzT3FlgwmaLIUhwD7E5Tjj9F3HD6xs6kiQuTOyxI=;
        b=VdaWQ97wKhDRAr32HE6STpT7x+Kmn+zgb7z1Kd1cOR+dUBiIl4NsUEyLw5riU0/X3H
         o5vAbrUvgLf0LeaPd55/gtq1fGZIvpE5lKRqLAo/oY8yep4tJA39pQbuS8XDj1eVuPsK
         fC/GH7osPv9CXxDqLz8IbxFMVzkkh816m8clyi+F1j8T6sTPX9ZmooGyvVK/TIANpxjl
         WZLUzQaHZsCDy32PXCqzFCMU0mZRzDnUr+E1VUHiLrJJoWBnCoqHlCbir8SNUBOlVoPH
         gEU8Ubav4vum/1vWDWaswkPfKw6tRkSdeKyH3pBKpnvKAlCMzob1CnQXsFYsXfTu1nXH
         8IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhoEzT3FlgwmaLIUhwD7E5Tjj9F3HD6xs6kiQuTOyxI=;
        b=q9ofQfG7EOshsy1vVUmikEHCCX3m7kSqyuF+4ZHDDoDL7HKQrLBRgB98HXKBE2wf6C
         3uYVhQ+UnTdT8FvcFBgtRcc5NOJN9LL3Gta3mJEsN3eTpJQBgGyIJcA3gAebOyxzAWlH
         aVLtS38GR3zId2lzJXAVVZQNJUzO+qZJcCcDlLSpn9obfUKgpzHabrk6dG9dtJWg7+Jy
         /1dYs9WDg2kuX54JTNYSc+GidqfDtmDpS6PAIYQjCEW3SviIMIyE4kaowG2Q+8zyIB7V
         uDVwAoc7mSAib/XGjlV0Xpao4cY1ZNck4337lEvKJA7jVR0+SBEwWb/KtpwwTOkpemAx
         w0IA==
X-Gm-Message-State: AOAM530flQbyCE0SICZrs4Lgn+sAJx1+IXXpSUSjMLWAdjrifjJcoq9t
        KT4pVPeDKdHnMecZIz8jNeQnbcKjZtzK9+CfHEE=
X-Google-Smtp-Source: ABdhPJyGyueFKDTCggNOCf4JrRL0Ele7BjHEaC5N4esbX2kSMluKBbc/+V9CSX1WfU7i4DxdwPwEIjE2Rbaun/s03jY=
X-Received: by 2002:a17:902:ea0b:b0:153:c2c9:71b4 with SMTP id
 s11-20020a170902ea0b00b00153c2c971b4mr1118774plg.110.1647453025144; Wed, 16
 Mar 2022 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_iuKEL8tHnovpGiQGUxg7JUpZFxHpxhOHbqAMgbt5R4Eftgg@mail.gmail.com>
 <2d1c129b-d473-39e3-69b7-6f36dc1682a6@leemhuis.info> <9312eb18-840f-9a1f-bcb0-8e3a43e45239@leemhuis.info>
 <236d45a6-8b88-c02e-a61d-ce1773fdb0ef@lwfinger.net> <02ef7552-67f5-dbcf-ece6-87b5b49e1bb5@leemhuis.info>
 <CAO_iuKHQ2DdLvSegcoezCzRVHqNFg+HM8qk1fr1n=s9cMz8QFA@mail.gmail.com>
 <877d96xlbk.fsf@tynnyri.adurom.net> <023e90a9-01bf-4334-a69a-259705ffa55f@leemhuis.info>
In-Reply-To: <023e90a9-01bf-4334-a69a-259705ffa55f@leemhuis.info>
From:   Nico Sneck <snecknico@gmail.com>
Date:   Wed, 16 Mar 2022 19:50:13 +0200
Message-ID: <CAO_iuKG0gE=5fEKMF2A+iWUhsxtnPOQtTQTkBRo2vH5CmKu7iA@mail.gmail.com>
Subject: Re: rtw_8822ce wifi regression after kernel update from 5.15 to 5.16
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-wireless@vger.kernel.org
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

Hi all,

On Wed, Mar 16, 2022 at 12:14 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> FWIW, in the initial report Nico mentioned he tried to bisect the issue
> and there mentioned a few git commit id's which are from mainline, so it
> seems he tried mainline. But maybe there is some DKMS or akmod package
> that is interfering.

Indeed, I've reproduced this issue on mainline kernels, and also bisected
using the mainline kernel.
No DKMS or anything like that.

> Nico, it would help a lot if you could clarify the situation and maybe
> try another shot at a bisection.

Yeah, sorry for being slow to respond. These days I tend to run my personal
computer just on the weekends, thus this is a bit slow. Also, this issue is
hard to reproduce, usually it happens within a couple minutes after booting,
but I've actually now been running a vanilla 5.17-rc7 (commit: ea4424be1688)
for a day, and the issue just popped up.

So I can confirm, this issue is still present as of ea4424be1688
(soon-to-be 5.18).

This is how it appears when pinging my routers gateway address:
> 64 bytes from 192.168.10.1: icmp_seq=20846 ttl=64 time=29780 ms
> 64 bytes from 192.168.10.1: icmp_seq=20847 ttl=64 time=28771 ms
> 64 bytes from 192.168.10.1: icmp_seq=20848 ttl=64 time=27768 ms
> 64 bytes from 192.168.10.1: icmp_seq=20849 ttl=64 time=26763 ms
> 64 bytes from 192.168.10.1: icmp_seq=20850 ttl=64 time=25757 ms
> 64 bytes from 192.168.10.1: icmp_seq=20851 ttl=64 time=24752 ms
> 64 bytes from 192.168.10.1: icmp_seq=20852 ttl=64 time=23747 ms
> 64 bytes from 192.168.10.1: icmp_seq=20853 ttl=64 time=22742 ms
> 64 bytes from 192.168.10.1: icmp_seq=20854 ttl=64 time=21737 ms
> 64 bytes from 192.168.10.1: icmp_seq=20855 ttl=64 time=20734 ms
> 64 bytes from 192.168.10.1: icmp_seq=20874 ttl=64 time=1298 ms
> 64 bytes from 192.168.10.1: icmp_seq=20875 ttl=64 time=455 ms
> 64 bytes from 192.168.10.1: icmp_seq=20876 ttl=64 time=3128 ms
[...]
> From 192.168.10.107 icmp_seq=20925 Destination Host Unreachable
> From 192.168.10.107 icmp_seq=20926 Destination Host Unreachable
[...]
> ping: sendmsg: No buffer space available
> ping: sendmsg: No buffer space available
> ping: sendmsg: No buffer space available

At the same time dmesg is flooded with "timed out to flush queue"
and "failed to get tx report from firmware".

And just to reiterate; this does not happen on 5.15. Only 5.16 and up.

I'll kick off another round of bisecting now. Will probably take me at
least a week to follow up though. A lot depends on how fast this
issue pops up with each round of bisecting.
