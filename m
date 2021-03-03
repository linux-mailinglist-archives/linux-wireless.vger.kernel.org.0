Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248A32C112
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhCCVQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843002AbhCCKXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:35 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B1C0698C6
        for <linux-wireless@vger.kernel.org>; Wed,  3 Mar 2021 01:07:03 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so16971026qtw.4
        for <linux-wireless@vger.kernel.org>; Wed, 03 Mar 2021 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKpRIV0nBsirWLUBi5T/YqLwJUbvRGd0l5J76HxqqQY=;
        b=i93FVC4prisYD3tUaa4qTULSzppFJdnwqaI0axKLqk4E1KHLGl0ajxMpSx/Tbcz5gz
         cB+p+QCfBLFfjgNlV1gpaGUgstlS9F/9xajs3I7SB+BpptWiAPSxxY5Bf/9oiNmWwWx5
         iImSH5q2b+x5PftlRI6vcph/A+eUGLveFSsOVWgp6xIAet72Oo3bSy6BHl1JZiHZjGi9
         uvz9PBafoUuLvJ9kZdOPmWYbpzXTTt39rbO+031348ZQbxY6CD3J/+YmoQT3dJ1awTCf
         8S3Tyc99ojTXxhyesNABrGX29I/Qyj0IqyrgPWjyPtXROEULfbOANHQPoiJ3gh8xbsWJ
         VO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKpRIV0nBsirWLUBi5T/YqLwJUbvRGd0l5J76HxqqQY=;
        b=fLBXGEmOfSuLzQCcAwpcMZkz1twTtjKQnTb5fa0TKMpX4fPRC++SVkdYyrdUDRAOtm
         xz2mpMOYBSODHr/XzgtVrS8rpS89VL2tZ3HTpS+jVWrV80pHzyMHzVxYaTBFsijdhZ5d
         fzHvKGGSbRgD2WrvhxUHPucERB7JZHM1K36U0goX9bwBkuga6CSS426TibSaKpEHnveF
         TZbO1NK0dZ85liqfBVGP51ukPTva0N2PtlbrjfxTrNKxsoBVFINCyBzzFLxIwNeuQYwX
         Cd8q6zzPG10HFY09rALmwhPIJu04nw1+Uqf7Tow5ApIp9za1cIonkaE4P3D3mXLnzXdU
         VJ0A==
X-Gm-Message-State: AOAM532xgwOntcVVBJ/CaNkfYnl3v/WcIEGWFNFa2D8kI8ylFhURsQ7f
        ZL25qPMlt9jDtThK692FLaddndo7EeXlc5ruaQL5hA==
X-Google-Smtp-Source: ABdhPJx8+N6LxjQ2TqesKmjDhe9IP8WsEr+KW8d/OM0/MKlgrV9PLrRVbVZT/kcWCKVmkhK0QwJAnR1Edcir13+sqW8=
X-Received: by 2002:ac8:6f3b:: with SMTP id i27mr10377291qtv.67.1614762422440;
 Wed, 03 Mar 2021 01:07:02 -0800 (PST)
MIME-Version: 1.0
References: <00000000000039404305bc049fa5@google.com> <20210224023026.3001-1-hdanton@sina.com>
 <0a0573f07a7e1468f83d52afcf8f5ba356725740.camel@sipsolutions.net> <20210303085912.1647-1-hdanton@sina.com>
In-Reply-To: <20210303085912.1647-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 Mar 2021 10:06:51 +0100
Message-ID: <CACT4Y+ZEdh6WJB8b5dg+jgv7thnrt=pVW6BzPngOyT3KKMaMtw@mail.gmail.com>
Subject: Re: BUG: soft lockup in ieee80211_tasklet_handler
To:     Hillf Danton <hdanton@sina.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        syzbot <syzbot+27df43cf7ae73de7d8ee@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 3, 2021 at 9:59 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 02 Mar 2021 15:18:16 +0100  Johannes Berg wrote:
> > On Wed, 2021-02-24 at 10:30 +0800, Hillf Danton wrote:
> > >
> > > Add budget for the 80211 softint handler - it's feasible not to try to
> > > build the giant pyramid in a week.
> > >
> > > --- x/net/mac80211/main.c
> > > +++ y/net/mac80211/main.c
> > > @@ -224,9 +224,15 @@ static void ieee80211_tasklet_handler(un
> > >  {
> > >     struct ieee80211_local *local = (struct ieee80211_local *) data;
> > >     struct sk_buff *skb;
> > > +   int i = 0;
> > > +
> > > +   while (i++ < 64) {
> > > +           skb = skb_dequeue(&local->skb_queue);
> > > +           if (!skb)
> > > +                   skb = skb_dequeue(&local->skb_queue_unreliable);
> > > +           if (!skb)
> > > +                   return;
> >
> > I guess that's not such a bad idea, but I do wonder how we get here,
> > userspace can submit packets faster than we can process?
>
> I wonder why syzbot did not make other handlers stand out than
> ieee80211_tasklet_handler.

syzbot has no relation to this whatsoever. It's just a proxy between
the kernel and you. Ask the kernel ;)

> > It feels like a simulation-only case, tbh, since over the air you have
> > limits how much bandwidth you can get ... unless you have a very slow
> > CPU?
>
> Even with a slower CPU I want to run a FIFO task every tick - it can bear
> latencies like two seconds.
> >
> > In any case, if you want anything merged you're going to have to submit
> > a proper patch with a real commit message and Signed-off-by, etc.
> >
> > johannes
