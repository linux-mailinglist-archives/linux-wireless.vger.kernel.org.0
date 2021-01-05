Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DC42EA871
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbhAEKSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 05:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbhAEKSy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 05:18:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30CC061794
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jan 2021 02:18:13 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id y15so20479297qtv.5
        for <linux-wireless@vger.kernel.org>; Tue, 05 Jan 2021 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMYQCAQWDtb84xfdYjobTQDbgkruCJE1yZlI8ZVFvYI=;
        b=GgLBoJE6REBZZeN9jf4/mUkTuE1eSkNE7rK+Kq/plkgbiSOyIwRF0N76kstEsJfhqR
         GAX40plhePPiQaTjQKedi+rFi+HHdNeMMuZeWw2vf0IQRfAF5d4UsjPjMIMUDJFbMYOP
         TA5BOo82lOF9qn+td2DolkcwRPOyjrYSKwWMBSJTJEy5sgvJxM9qEot3L9nTxfU1gwrL
         4QbA6Rr0oKKGB+aUwhz0fs+L+zYx+KW9y9vGxfzYaF3JVSyU0x/9NjIJ2ax+C2tAfnLg
         3IarKaC2f2gB317AkMSnwc+tubukPoTvC2/ReVE8Sx3Ip5VdLnbSzVaSTvQ+RTtlS3PN
         LOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMYQCAQWDtb84xfdYjobTQDbgkruCJE1yZlI8ZVFvYI=;
        b=ManChBH+eI3xemjOKToyi+ZJQ5lGd2Iaa1NwquZ1IJNq+5TqGYJSLi760MOZ2FgCbg
         dGM7YLeofWh69eCyJWdCNrkwSRjQFGX8dYPWH7GHuaaLAhL/yAUdZ+WRW7t8iX6mHXXu
         0V15bQNMuJ/xriIp2TJ2sj6ZeSCAnI+anIkUkk+iIk89sDn8DToE98Tlj/AOe2qO+HIq
         wvx4559RCHi2OClyaCq4D4v9Hia3LMe8imoTURFKnEBM1/583H8VJ8v9I/OIabzY2PPi
         NZwWE9tIy8tU8azfKxXWnOwM/DperOF7mB58gnyyIsLpWQ4w2bSnUJBei+VmSNQRw/4B
         cQXw==
X-Gm-Message-State: AOAM532vc+ezr12wfS/D1zwYLNxOSisP4k0lC4qM/mOG+rsfIw58Bnra
        I7pKzJVgHXd47IjOcPs9/aX2uKVK4OknJHAH6gUwJw==
X-Google-Smtp-Source: ABdhPJyPOGOYfXQAa5Uf3wjzOjx+ej22GkgAYLJNUJnd0ZZNaODQnPz1v4Ic02fufK7i6DwgVTGtnQHq0ScCPPJTFvY=
X-Received: by 2002:ac8:4986:: with SMTP id f6mr74754126qtq.43.1609841892486;
 Tue, 05 Jan 2021 02:18:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bbdb3b05b0477890@google.com> <CACT4Y+arc_qxVnb1+FZUzEM32eDBe7zYgZhcSCgyMUMwKkkeDw@mail.gmail.com>
 <a63808e2-3e76-596c-c0be-64922620820a@broadcom.com> <CACT4Y+ZkwMZ3Bu77WGtmOGihNbgspdicEq5d_LA1hDVL=KkZyA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZkwMZ3Bu77WGtmOGihNbgspdicEq5d_LA1hDVL=KkZyA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Jan 2021 11:18:01 +0100
Message-ID: <CACT4Y+aMM0HkZbQ6dkmG8jmLaj1cH0oLJGzRskFM3Q3k+ywJ5Q@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 12:04 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Sep 28, 2020 at 11:31 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On 9/27/2020 10:47 AM, Dmitry Vyukov wrote:
> > > On Sun, Sep 27, 2020 at 10:38 AM syzbot
> > > <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> syzbot found the following issue on:
> > >>
> > >> HEAD commit:    748d1c8a Merge branch 'devlink-Use-nla_policy-to-validate-..
> > >> git tree:       net-next
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=13ac3ec3900000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=51fb40e67d1e3dec
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=3640e696903873858f7e
> > >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599be03900000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd44b900000
> > >
> > > Based on the reproducer, this looks like some wireless bug.
> > > +net/wireless maintainers.
> >
> > I don't think so looking at this part of the stacktrace:
> >
> > [   51.814941]  [<ffffffff8465cc95>] macvlan_common_newlink+0xa15/0x1720
> > [   51.833542]  [<ffffffff84662548>] macvtap_newlink+0x128/0x230
> > [   51.858008]  [<ffffffff85b68bfe>] rtnl_newlink+0xe5e/0x1780
> > [   51.925885]  [<ffffffff85b5d32b>] rtnetlink_rcv_msg+0x22b/0xc20
> >
> > Regards,
> > Arend
>
> That's the trace on the oldest release and the bisection was diverged
> somewhere midway.
> You may see this in the bisection log:
> https://syzkaller.appspot.com/text?tag=Log&x=1474aaad900000
>
> Initially it crashed with this warning:
> all runs: crashed: WARNING in sta_info_insert_rcu
>
> This function is in net/mac80211/sta_info.c.

#syz dup: WARNING in sta_info_insert_rcu
