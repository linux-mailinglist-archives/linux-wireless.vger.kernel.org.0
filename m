Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842B260700
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 00:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIGWlS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgIGWlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 18:41:16 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5CC061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 15:41:16 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h126so10116551ybg.4
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aETqfCJrKaXv1F00DmfNA8Zy8/3hFriV3kwMbDL6huc=;
        b=uwIvcKE/wQKW8tToeonFp4Ak0/rB+vT58qfKY4KbVdLHBbde05HJS9t+x0LLyRbFam
         cCvB7DjcHdjvibwPgcnKbk79Or9zupyiublqYYr0gAD5B9ZmVVvQ+Ymq7f0mjZxVsmEE
         tNMtaa/QmW34hTjdfV8tDbZPhnBkIMkTgvY48Cud5eYhB3FdvOgaRQX41JusUpIMdhXQ
         56BNJU1ZdNB0OOxsbRyPY9SGrXN/NitjOQVueDyxMzi9iRC5x41SNU+foFQ6Wc5d2UEh
         GcSYaLba7eXnjxuGvgYhuSjnFfUhTT3lHSLy120StNT9pEw9Euhc1Vtv30jQsnAHaVdZ
         Brew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aETqfCJrKaXv1F00DmfNA8Zy8/3hFriV3kwMbDL6huc=;
        b=EC/U1FLki2gMX0Kcj7BTyio4h2UP1xxtgcYalfODSbfQXqRVvaP3MEIUa/k7eAux7x
         D63g8GZHabkC2q/nqZ2TwvwNAhJYbwRt74m/4mW8QIBWIjMjyFFSQj8UYjgfb7VWhKIw
         TulcaeD4B9eNx0EZ8kCY3e/qTRSD6co0HwggfGOctGjD4DT+v+bsD2N4c30JGOr+Yaka
         u2qGPtEUXb/7AZqB08jOZVV9myp3KMtBhIIOTDdo7CAGUe8GCNsOPe599i3fD+B+LEl6
         AnnAD4MwgoTkJoiNI6qU2MesAoxNimv3ysScZtK0Ts0iZ5Zbt8Jge75NiOVYlIbKnU77
         sOEg==
X-Gm-Message-State: AOAM532raP7Jt5atKrENp1y6WB4igE7qMovXf1pcfDPeVlaxQN4exWXK
        r5v2dyiXPMjHmImmRdXspiKBu/3KuWw2mjYJLSvCKq1xYs4=
X-Google-Smtp-Source: ABdhPJyTvp67qWaBSw6Y30DvxfAMI3C0Wd+nwDbOSDiy0mELwcVOBVmrEJkwDRT80LOfPZyN17HynPBUnkyi56CTmAU=
X-Received: by 2002:a25:2fcc:: with SMTP id v195mr27769393ybv.145.1599518475654;
 Mon, 07 Sep 2020 15:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net> <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
 <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com>
 <b7aaab23072e4c06c3cb245a3ea83f11e9ca9e7f.camel@sipsolutions.net>
 <CABPxzYKKayOzCt8VwOuV4uysoMVCZ9Ka01yqJnVZ=nyFHhYjqA@mail.gmail.com> <c14f8dcbff531588afba09d775491dcbf0d88097.camel@sipsolutions.net>
In-Reply-To: <c14f8dcbff531588afba09d775491dcbf0d88097.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 8 Sep 2020 04:11:04 +0530
Message-ID: <CABPxzY+0ve6GFNr-HQMXb5NTjTQK1UZBwH0=Jxeup4zuxQ3J4g@mail.gmail.com>
Subject: Re: alternatives to screenscraping iw?
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 8, 2020 at 2:58 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-09-07 at 22:55 +0530, Krishna Chaitanya wrote:
> >
> > > I wonder if the netlink policy export I wrote for the kernel could be
> > > used to generate attribute descriptions? Even if it means just running a
> > > tool in a latest kernel VM to do it.
> > Can you please point me to it? But yes, auto-generating those should be handy.
> > Probably can pick up the header file from sources in kernel.org
> > instead of booting
> > into a VM (depending on how your tools work)?
>
> No no, I meant at runtime from the *policy* export, not the header file.
>
> See net/netlink/policy.c and this patch in the userland code:
>
> https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cc889b82412450dec762551ac867bd2896656ddc
Ah okay, got it, thanks.
