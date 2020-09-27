Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45E279FC4
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgI0Irw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 04:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgI0Irw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 04:47:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A977C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 01:47:52 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv8so3854802qvb.12
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODwlzQWcOfaqDNZSpV1mqnAk6uRjiK8SnzSar44eRbw=;
        b=LvJAamSv+7BvcBWAMydenJG/DaSx+cw58grRAYkFa6ySCNBMKQrxTz+JLuz0iqeyL/
         0yVd0d2OBeWJMM2dgxk++Rm53k+7ywqv+XSV3W9TWZoa4MgFlvcVuquXlVgZKFVM5Pt9
         2PA/INI8zcKAA2Mtg0478T7Yqzd5aqF3goaGfmi49MvTZyeGk7BA9G/MSKSTqZlnFrX8
         cpod1pqaKLquWpBUjoGXfliynuDys33Lab42TIyh+BX8OPvBkWq4697LzFQYlBXeGXkO
         OA73oJeUNKNXQNQWWvvuMcCbsJSV5MUuyoA9DWVFYE4Kqip+lN4Oudcw9POrw1fbpzOU
         kUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODwlzQWcOfaqDNZSpV1mqnAk6uRjiK8SnzSar44eRbw=;
        b=nTp5hQasgvGCFT+D9eFfyziIPYjzg3+AKsvHcne4azpu+DicIGecn/KdG1vAxhyJZl
         xaUm0JHkOOZhgnBVjyTC8/dWKRE26eqD5Lzhx9tMhtB+iai+dnwP0eo7aUQDJvhL0D0r
         duyonKAmJ/33zagJxxpUlB2Rgbhuo5ZTNWRT/6z7BZOLNmNFXAOZqFc3FH5atr0uBlCc
         xloRoMFUpqsk1AU71sJKWhFBHC45857tKMOCV2wdPzaxPSQ7vY/6t4Or5004l89SrgT3
         HRZPw+tYdQUfpK79SVVsDsR4p5Loex7yIm3FlGDtoLHUDN1FtMlY1XOsMysz+Ywn5O35
         qOFA==
X-Gm-Message-State: AOAM533wgj377P2g7HGt1Ct48yWvrT9cE74j6DeQt0EHK2oSkqss9dFb
        y7zm0p4AWmPHiNtHwM2CFkCA/TM/oNn5KkI5CNl5mg==
X-Google-Smtp-Source: ABdhPJw188JTXwzSAN/+U/mG0jI4jTVdudWEMyvmSDGiYPDH8EF4khjhEXu/Ik4+q9lbQY7nWcOizKPwvcgDYFC/kqM=
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr6991968qvt.32.1601196470804;
 Sun, 27 Sep 2020 01:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bbdb3b05b0477890@google.com>
In-Reply-To: <000000000000bbdb3b05b0477890@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 27 Sep 2020 10:47:39 +0200
Message-ID: <CACT4Y+arc_qxVnb1+FZUzEM32eDBe7zYgZhcSCgyMUMwKkkeDw@mail.gmail.com>
Subject: Re: WARNING: CPU: 1
To:     syzbot <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 27, 2020 at 10:38 AM syzbot
<syzbot+3640e696903873858f7e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    748d1c8a Merge branch 'devlink-Use-nla_policy-to-validate-..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ac3ec3900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=51fb40e67d1e3dec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3640e696903873858f7e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599be03900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd44b900000

Based on the reproducer, this looks like some wireless bug.
+net/wireless maintainers.

> Bisection is inconclusive: the issue happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1474aaad900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1674aaad900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1274aaad900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3640e696903873858f7e@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000bbdb3b05b0477890%40google.com.
