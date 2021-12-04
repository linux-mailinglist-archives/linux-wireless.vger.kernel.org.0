Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1104683FB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 11:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348766AbhLDKXC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 05:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbhLDKXB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 05:23:01 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98EC061354
        for <linux-wireless@vger.kernel.org>; Sat,  4 Dec 2021 02:19:36 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so2863966oov.4
        for <linux-wireless@vger.kernel.org>; Sat, 04 Dec 2021 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUBxI6UjSH7mOTHyHCii08lOt35WlhuPwpHtCxGOpIM=;
        b=JcFz0uAn6z1BVaVAU+OkeYsIDQPsQqJqoJoFKp3g6uAVA/A84+FkF9SetrQkp4mJYM
         B1Hy54zZGMuCX6D6Z17g+EuUIzbeBsvdLOACzNtyEkIIXRGJYZ527kBWHdjBqZx5o4+g
         fMbe+xNpft4zrX6/5uMreZ0JiMg50omlcPQqDoLKusegh/7Z+inEo33l4LYT482FWdNb
         /j5ZA4xkYy1FPhVKRoBMrMN5gSclBnmtmtDkL5VMI9YmcOol/maEJN39ZonFYQ/EJD2x
         KawFs8/p6gzVTndoXsak5CfyU96l6d3RvaUqlFO4Cj2yDF+Yvqrs0hMWYCH6RWe52dJq
         Botw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUBxI6UjSH7mOTHyHCii08lOt35WlhuPwpHtCxGOpIM=;
        b=t8MjBczKlWIFIMousWNrg8yBySfYoXnQ8mRv1ZcTqG0LesZtjoUutGj/zyVqH0FCfy
         NcHDOBbrCyOC0yz+T2uCHSkFeYmmSiYqXooG2Z7L6Sf5AN6Su8ZdtHrEsuiu08b4YXgH
         dBiSpk9w3YDJik33yhJO/8P7e8y72ZvFL6vXwzuOcs/ksxwtYTIlEGQkMIRJWKUqcsWE
         J82QP6zDHXCSO0V4NLr4EcFP5tqWEjUMcccaxyJK3C5pxasFVtI/Km7UjeOXOEbNNVra
         RV06h+YL1DptwNCEws13RRDp2/JYXsAXxke50WFSCqhdBslW+qMKpB0Eje6bu0wPCiFN
         e/5A==
X-Gm-Message-State: AOAM5308M7QWhXbrN3m9MHOvHVL4MhMFTSDYeT0OzinQssLYUTSHod8I
        +5hfpReFx1pyI4g24m9EfrhWyDFKGRtGgRLQep33VA==
X-Google-Smtp-Source: ABdhPJybkWfJfZCDkFBH5uXogkxvqt3rVv+MgfzBTH16slbKtn5ifaxol5h7rXJ+pKqtqLGkaKeFUZQJZW0KPHV7pSU=
X-Received: by 2002:a4a:d319:: with SMTP id g25mr16246239oos.21.1638613175445;
 Sat, 04 Dec 2021 02:19:35 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bd9ee505b01f60e2@google.com> <00000000000002e72b05cfdeee4d@google.com>
In-Reply-To: <00000000000002e72b05cfdeee4d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 4 Dec 2021 11:19:24 +0100
Message-ID: <CACT4Y+YbOGFpwtMXSifaiCUroB8ZGsyVJecRTB1OSjLH682+Ag@mail.gmail.com>
Subject: Re: [syzbot] WARNING in hrtimer_forward
To:     syzbot <syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, hchunhui@mail.ustc.edu.cn, hdanton@sina.com,
        ja@ssi.bg, jmorris@namei.org, johannes.berg@intel.com,
        johannes@sipsolutions.net, kaber@trash.net, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 3 Nov 2021 at 10:21, syzbot
<syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 313bbd1990b6ddfdaa7da098d0c56b098a833572
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Sep 15 09:29:37 2021 +0000
>
>     mac80211-hwsim: fix late beacon hrtimer handling
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108b5712b00000
> start commit:   ba5f4cfeac77 bpf: Add comment to document BTF type PTR_TO_..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d44e1360b76d34dc
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca740b95a16399ceb9a5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1148fe4b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f5218d900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: mac80211-hwsim: fix late beacon hrtimer handling
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks legit:

#syz fix: mac80211-hwsim: fix late beacon hrtimer handling
