Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D5280E39
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJBHsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgJBHsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 03:48:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6853C0613E2
        for <linux-wireless@vger.kernel.org>; Fri,  2 Oct 2020 00:48:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so454599qke.13
        for <linux-wireless@vger.kernel.org>; Fri, 02 Oct 2020 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIoT0KYRho8EGp0xd1RVifhf89KYf/eZdNSMQw9Fl2c=;
        b=KF8vocwJVAwDHRnCkO791we5Tsz3XslsuI+o4XKhiY4TQFeyoFGgSgxnmr41CzTwjs
         6LkF6vM4VyVU+oHrAUzhZEke8sfS8j3KwohCegEY8/ECZEV9U2nGr72nFL5WwISJmy/3
         xzGwe25YNwuOQ8kiMUgiTpyLpViUWBt1a0otWkBd1kVhKSlyRxNLPCuZg2nM9hxuVIV0
         jAveXobAF6itQHLcMB7RQnSlCJNK1gnlN/yPA77ZrSUoSuSV7iget4eg8SFH816kE2MG
         TXHYj7Wc1riU/gVRS4JJUPRctEyf63jK23cpsxwwYExWDJOXOH0gcfw/67vnEKLEB4SL
         RZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIoT0KYRho8EGp0xd1RVifhf89KYf/eZdNSMQw9Fl2c=;
        b=uHTK9kittgNhX5Yo2+HYy2Eda6fKBsNT4ZNsqfYs696rv2BLU8Y8WbDiahXRJRWKim
         BNwnmpSy9GNjj7apKkrdpNXklf1rxChCOEagVvT8zrma5AlO8B/Kg+3tYVMwAVouvIMS
         hXS/WCnx87OkM9zSOwNbF60WwJeQTb8uR4taj59LLFXMA8aaQ0YzVYHW26GrZjIkGTyS
         7AAWPiglGB1mt8gmOk6D2RiGldoAmSSOYp8jc9k9Zh8SmHeKfNiKC9dm6O1MpzYXzZIB
         MHzckoJgG0llpHd8czdq4Pfr9lQflrO60ykijsUChUjInKlUBuMHyHG5saVzDLEKE8Y2
         717g==
X-Gm-Message-State: AOAM531us6+oNJrAEie2VB/7mr/RtlBQOtQIhBftzrFItfpkpz3DPPsC
        EQA7IAkW5O1wTDS1Ik43zzVTt5q8cTvDfr6yEmHLyA==
X-Google-Smtp-Source: ABdhPJyiEMQMpBHdT5fw2pCxev3Pe74VR5qJAG/39e/Fq2IoWw28zUsrF0YvE1A+U4HWKAGdc2ooXJw8AspXu1x7CI8=
X-Received: by 2002:a37:54a:: with SMTP id 71mr789273qkf.407.1601624933696;
 Fri, 02 Oct 2020 00:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000a954d05b0a89a86@google.com> <7bf217ced62816b1bd3404bcfe279082347fb265.camel@sipsolutions.net>
In-Reply-To: <7bf217ced62816b1bd3404bcfe279082347fb265.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Oct 2020 09:48:42 +0200
Message-ID: <CACT4Y+aRSVEJqZ_aCN6avc4Z66-Kt0C-QNS1vyNg4wnbUrWW9w@mail.gmail.com>
Subject: Re: WARNING in cfg80211_connect
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     syzbot <syzbot+5f9392825de654244975@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>,
        Dave Chinner <david@fromorbit.com>, dchinner@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>,
        sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 2, 2020 at 8:27 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-10-01 at 21:31 -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 16d4d43595b4780daac8fcea6d042689124cb094
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Jul 20 01:38:55 2016 +0000
> >
> >     xfs: split direct I/O and DAX path
> >
>
> LOL!
>
> Unlike in many other cases, here I don't even see why it went down that
> path. You'd think that Christoph's commit should have no effect
> whatsoever, but here we are with syzbot claiming a difference?
>
> I mean, often enough it says something is "caused" by a patch because
> that caused e.g. generic netlink family renumbering, or because it
> emitted some other ioctl() calls or whatnot that are invalid before and
> valid after some other (feature) patch (or vice versa sometimes), but
> you'd think that this patch would have _zero_ userspace observable
> effect?
>
> Which I guess means that the reproduction of this bug is random, perhaps
> timing related.

Hi Johannes,

syzbot provides bisection log which usually answers the why question.
In this case bisection was diverged by an unrelated kernel bug. That's
the most common reason for wrong bisection results. If you are
interested in more reasons for wrong bisection results, some time ago
I did a large analysis of bisection results:
https://groups.google.com/g/syzkaller/c/sR8aAXaWEF4/m/tTWYRgvmAwAJ
