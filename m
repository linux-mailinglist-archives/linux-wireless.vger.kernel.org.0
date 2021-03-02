Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D199832AFC6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhCCA2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835354AbhCBTDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 14:03:13 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0861C061226
        for <linux-wireless@vger.kernel.org>; Tue,  2 Mar 2021 11:01:46 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id q85so21377284qke.8
        for <linux-wireless@vger.kernel.org>; Tue, 02 Mar 2021 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnXfU68ZzIsZlihNWZUn2t6cVsioWSUQ6rdGiL1Upjg=;
        b=mlOhvvb/rH8DvWuDKTYklm5YoqVcXjyzDw0EukcQ7YrYl2Kj8083Uxq1Nrl0Q+znzC
         3SKv9bgz/Uj0MxPwaYaGLVxX8AELrMekBfA158dO8QjBoixnATIjNqkYNxp/q9kpILtg
         ZPwdVfu4wEJmM7aDzH/FZOtGvIs9VtrSZqKFDcO+dmny0c49xjXyKQcBf6AlsXPiMp2N
         +xi/O40oXHCemWGtyqgadLVjvwQN3eAwY3KWZryLXYphrWNmkQJ05MwjRHr5PRsAI+gX
         aw/qm2P0/Wv8gp2L4MRQ7a+WHAXO7AGSNpnlrYtJWfV5YRiBurSdGWYbJZuM+2SJzOT2
         f4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnXfU68ZzIsZlihNWZUn2t6cVsioWSUQ6rdGiL1Upjg=;
        b=j58FC3d8EMpkW8CwbE2PZhuAaLxmSdwu4yv5nAm94f8HRCIPL61NaZu1v9wYGWx4DU
         +E/Syk6ltLjdtUsme0y8jVflazKIuEIY6OdJnHw6PJE9bf9Rej6WvllX4EJmuKGdNXnE
         y3X6s7RmBeAbvX3U6m4ql54EDhhleeqeIxRobUfkYydyb1JYZLUcISINiggyCOIStdO6
         23CP9OXf3EqqP5OIZMLgS4uOR/6SixvvMxp7xixe/yVmFCWmlECtoZXf0O+LK3s5Libs
         nUoX3czGVACpvWhAx6y8r2UeLsO5isKXa+8BRNSbz8Hj0FjYOUmyY44bFLO0HwplN3zR
         /qAw==
X-Gm-Message-State: AOAM532Vgf+boryw2jFCMag1NtD8eSqr8YEtOSv+d0QWYmG0XsrF5qoa
        EWVfb/folsINoAxhfSNmfH5yuCV9HdB8Sqdkme+KTQ==
X-Google-Smtp-Source: ABdhPJwJiEYqApj6rgOYrCmW9HdrmS3ZOfM6+JirjcgL6eujZSZ4Dx4XpAiAtLAAnjnsL+7Jx9aKw0PSbF5M5001DTs=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr20414567qkx.501.1614711705876;
 Tue, 02 Mar 2021 11:01:45 -0800 (PST)
MIME-Version: 1.0
References: <00000000000039404305bc049fa5@google.com> <20210224023026.3001-1-hdanton@sina.com>
 <0a0573f07a7e1468f83d52afcf8f5ba356725740.camel@sipsolutions.net>
In-Reply-To: <0a0573f07a7e1468f83d52afcf8f5ba356725740.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Mar 2021 20:01:34 +0100
Message-ID: <CACT4Y+ahrV-L8vV8Jm8XP=KwjWivFj445GULY1fbRN9t7buMGw@mail.gmail.com>
Subject: Re: BUG: soft lockup in ieee80211_tasklet_handler
To:     Johannes Berg <johannes@sipsolutions.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+27df43cf7ae73de7d8ee@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 2, 2021 at 3:18 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2021-02-24 at 10:30 +0800, Hillf Danton wrote:
> >
> > Add budget for the 80211 softint handler - it's feasible not to try to
> > build the giant pyramid in a week.
> >
> > --- x/net/mac80211/main.c
> > +++ y/net/mac80211/main.c
> > @@ -224,9 +224,15 @@ static void ieee80211_tasklet_handler(un
> >  {
> >       struct ieee80211_local *local = (struct ieee80211_local *) data;
> >       struct sk_buff *skb;
> > +     int i = 0;
> > +
> > +     while (i++ < 64) {
> > +             skb = skb_dequeue(&local->skb_queue);
> > +             if (!skb)
> > +                     skb = skb_dequeue(&local->skb_queue_unreliable);
> > +             if (!skb)
> > +                     return;
>
> I guess that's not such a bad idea, but I do wonder how we get here,
> userspace can submit packets faster than we can process?
>
> It feels like a simulation-only case, tbh, since over the air you have
> limits how much bandwidth you can get ... unless you have a very slow
> CPU?
>
> In any case, if you want anything merged you're going to have to submit
> a proper patch with a real commit message and Signed-off-by, etc.

Looking at the reproducer that mostly contains just perf_event_open,
It may be the old known issue of perf_event_open with some extreme
parameters bringing down kernel.
+perf maintainers
And as far as I remember +Peter had some patch to restrict
perf_event_open parameters.

r0 = perf_event_open(&(0x7f000001d000)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0,
0x0, 0x3ff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xfffffffe, 0x0, @perf_config_ext}, 0x0,
0x0, 0xffffffffffffffff, 0x0)
