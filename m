Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69F527AB7B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 12:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgI1KE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1KE0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 06:04:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F0C061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 03:04:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b2so258192qtp.8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6NjSA1gIEDmxIgCpUkqguL9Uf/5tWF3Zhr4Hk7uEPo=;
        b=tRdJJuwiw6Gw+ME8Aq2hzmLKpVwEnzFZhVLD/Ez2G6wmKf8fe4ZNve7eIR35CeN/rR
         qG2A+EQXrOc2y8hhkmDgjhV2495Ppn4QM4Zr8352ze8JeUXhHEia8PXLFKCUW1TBMr+F
         JMmAfsZgy9ZL0mhp7KUdeBzcN0qZ0MbwC3Sv5leX1twwTn3TyRQPEDpahMERpqy4yMBV
         jxZMMExQHCdWdOyXAvutcwEWDJCfIz0PaG32f6B4dyJCJnxrND9h9rfaFyIkxUq7PUX3
         ppfTDrQBSZdDqBKk7gFgN3dAiTvPKeiPVPQ0+I9rD2gk4wOdFFICdun8IMgbPHAS91sc
         ajEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6NjSA1gIEDmxIgCpUkqguL9Uf/5tWF3Zhr4Hk7uEPo=;
        b=ljskr+b5mgR4htVzWDxd0zQy30KTY57QfiAqU07WVscMmaaaf12rIOE0/2jOIkHLpx
         RHUgrW5P3liVBMtvykVdgUuRhVcNJCGqC9lbOfzeiqR4msc9w/jxSJN5v3vo/o2r6K/k
         t2qWyopueHC8tpFgaC2w/stZpA8n2TWaEU/l+QFMg2kmeZh4/bhXiqlItXEZ3hWzK+e5
         kTTb95aY68k2CV7sqnBJgFHBaaC1h0OUyjSEwnCOxsGnP0et7jq9cQ4VMiRbiAR/NhO9
         qy+VvGIoR4ryqq9vKT4jfeVosKUZYV+JtkVrwBp+lpoByHYSIY+R8cs9YU8RdApaGuRj
         Fd9g==
X-Gm-Message-State: AOAM530EaI/aJSxCFC8b7rxPc+89yEzhJWT4Ee0NDhYtlau68Pq5G/7W
        hihMqfmbxNQqxFqpC63TObPOlpwvnCPlESZJ98bQzQ==
X-Google-Smtp-Source: ABdhPJxiOHUfuQzBoKpc2ts209SMUYzXw42K2v2Kc21FGaCAQrUgIXWU8SsGArPdO6xFBUPFtDMUzWmwmOmG8Pkqiws=
X-Received: by 2002:ac8:bc9:: with SMTP id p9mr723270qti.50.1601287465489;
 Mon, 28 Sep 2020 03:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bbdb3b05b0477890@google.com> <CACT4Y+arc_qxVnb1+FZUzEM32eDBe7zYgZhcSCgyMUMwKkkeDw@mail.gmail.com>
 <a63808e2-3e76-596c-c0be-64922620820a@broadcom.com>
In-Reply-To: <a63808e2-3e76-596c-c0be-64922620820a@broadcom.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 12:04:14 +0200
Message-ID: <CACT4Y+ZkwMZ3Bu77WGtmOGihNbgspdicEq5d_LA1hDVL=KkZyA@mail.gmail.com>
Subject: Re: WARNING: CPU: 1
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     syzbot <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 28, 2020 at 11:31 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 9/27/2020 10:47 AM, Dmitry Vyukov wrote:
> > On Sun, Sep 27, 2020 at 10:38 AM syzbot
> > <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    748d1c8a Merge branch 'devlink-Use-nla_policy-to-validate-..
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13ac3ec3900000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=51fb40e67d1e3dec
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3640e696903873858f7e
> >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599be03900000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd44b900000
> >
> > Based on the reproducer, this looks like some wireless bug.
> > +net/wireless maintainers.
>
> I don't think so looking at this part of the stacktrace:
>
> [   51.814941]  [<ffffffff8465cc95>] macvlan_common_newlink+0xa15/0x1720
> [   51.833542]  [<ffffffff84662548>] macvtap_newlink+0x128/0x230
> [   51.858008]  [<ffffffff85b68bfe>] rtnl_newlink+0xe5e/0x1780
> [   51.925885]  [<ffffffff85b5d32b>] rtnetlink_rcv_msg+0x22b/0xc20
>
> Regards,
> Arend

That's the trace on the oldest release and the bisection was diverged
somewhere midway.
You may see this in the bisection log:
https://syzkaller.appspot.com/text?tag=Log&x=1474aaad900000

Initially it crashed with this warning:
all runs: crashed: WARNING in sta_info_insert_rcu

This function is in net/mac80211/sta_info.c.
