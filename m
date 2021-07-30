Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338733DBC61
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhG3PcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 11:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhG3PcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 11:32:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8BC061765
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 08:32:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l17so12942914ljn.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuMBivazXPSSSnLg5TVHL25KvD4e4AyXmAdQoyFf5fI=;
        b=V0takgq4CkvNar1Q60JxHbTt1cqvFsAT2Ql1xCcWDlliF/9fK1Tk6u2NKjLJFi2NsP
         OtAUbjW/Hk6YTr3ZTfouOa43d0DCv4/nxXOIFvMh2o9s/LUtXhmtgHgxqNBlfkoO+0Ox
         d1GAjEOyAM0plTITbZ2w6WFa49Z5MRcmaq85CbQLNYZrVs9T1wQ8UUGFYid/G6OviM1d
         OMFu6dCu79GrtbGkEZtfmLAS5L0sYxR0jmS86rEcpL2kD9pJaHk0tbVbZ7ZyxkbmW+U+
         QcVQ4cI0n7yRxCSYVdO9PPaLX284Bky+u6/vpPnImSqzkgKcHLw7rJHQ0RyOSVMQVUfP
         ZxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuMBivazXPSSSnLg5TVHL25KvD4e4AyXmAdQoyFf5fI=;
        b=mm+S5azCganGHhct/YeAwILZH29nmmFruFJCvKHUK+8oEkxPevkQZje5Y/4Ya9D8KF
         fhp7JFgzdWPGosJsmZpHfOFrzMpodLt4Tjoz2yvRt9ij0fWb00aFAap5KKot4X/XLCsd
         sNEGUefRYIVD4RsGlGB6ntSO5EkrR1ivw685laFnkCskyNdi2FONJnVubr6lvPTFZjfL
         NtuVOBnPO5AiI1na42iBYxrAVNAIY9oHfHkRdf97MLCHM6mi27pVHmTHgFbo7JUimH6U
         6GDzEdCDZfkkyayhKTwYzJySgTk+Hx4OAOgIQ0DeeUOlWdwqIJZL+jcxf9xJA7Zarvoa
         wBXA==
X-Gm-Message-State: AOAM532UkZIEG1poVyPQND4jfcDqbACxHbzMK5lYcUS+RmU9Y+v3EuRQ
        MtlIP/NE3avGlrthzdv+Ah2YAldf/NJ5YmY3xe9o7g==
X-Google-Smtp-Source: ABdhPJzhoAUM4a6+aRW2w5iC66nC+BulVEtoEK+XmW3hkTpBTQktpdSzzUsKFLM2RILR3UqcvgdkDUL260mhYjHoyJw=
X-Received: by 2002:a2e:a911:: with SMTP id j17mr2005145ljq.341.1627659134322;
 Fri, 30 Jul 2021 08:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-49-keescook@chromium.org> <1cc74e5e-8d28-6da4-244e-861eac075ca2@acm.org>
 <202107291845.1E1528D@keescook>
In-Reply-To: <202107291845.1E1528D@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Jul 2021 08:32:03 -0700
Message-ID: <CAKwvOdn+G6y3_=YZgp51cL64XW=VGgt7C0Vt0ARZOkezPTn5WQ@mail.gmail.com>
Subject: Re: [PATCH 48/64] drbd: Use struct_group() to zero algs
To:     Kees Cook <keescook@chromium.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 29, 2021 at 7:31 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 28, 2021 at 02:45:55PM -0700, Bart Van Assche wrote:
> > On 7/27/21 1:58 PM, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memset(), avoid intentionally writing across
> > > neighboring fields.
> > >
> > > Add a struct_group() for the algs so that memset() can correctly reason
> > > about the size.
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >   drivers/block/drbd/drbd_main.c     | 3 ++-
> > >   drivers/block/drbd/drbd_protocol.h | 6 ++++--
> > >   drivers/block/drbd/drbd_receiver.c | 3 ++-
> > >   3 files changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> > > index 55234a558e98..b824679cfcb2 100644
> > > --- a/drivers/block/drbd/drbd_main.c
> > > +++ b/drivers/block/drbd/drbd_main.c
> > > @@ -729,7 +729,8 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
> > >     cmd = apv >= 89 ? P_SYNC_PARAM89 : P_SYNC_PARAM;
> > >     /* initialize verify_alg and csums_alg */
> > > -   memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> > > +   BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> > > +   memset(&p->algs, 0, sizeof(p->algs));
> > >     if (get_ldev(peer_device->device)) {
> > >             dc = rcu_dereference(peer_device->device->ldev->disk_conf);
> > > diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
> > > index dea59c92ecc1..a882b65ab5d2 100644
> > > --- a/drivers/block/drbd/drbd_protocol.h
> > > +++ b/drivers/block/drbd/drbd_protocol.h
> > > @@ -283,8 +283,10 @@ struct p_rs_param_89 {
> > >   struct p_rs_param_95 {
> > >     u32 resync_rate;
> > > -   char verify_alg[SHARED_SECRET_MAX];
> > > -   char csums_alg[SHARED_SECRET_MAX];
> > > +   struct_group(algs,
> > > +           char verify_alg[SHARED_SECRET_MAX];
> > > +           char csums_alg[SHARED_SECRET_MAX];
> > > +   );
> > >     u32 c_plan_ahead;
> > >     u32 c_delay_target;
> > >     u32 c_fill_target;
> > > diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> > > index 1f740e42e457..6df2539e215b 100644
> > > --- a/drivers/block/drbd/drbd_receiver.c
> > > +++ b/drivers/block/drbd/drbd_receiver.c
> > > @@ -3921,7 +3921,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
> > >     /* initialize verify_alg and csums_alg */
> > >     p = pi->data;
> > > -   memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> > > +   BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> > > +   memset(&p->algs, 0, sizeof(p->algs));
> >
> > Using struct_group() introduces complexity. Has it been considered not to
> > modify struct p_rs_param_95 and instead to use two memset() calls instead of
> > one (one memset() call per member)?
>
> I went this direction because using two memset()s (or memcpy()s in other
> patches) changes the machine code. It's not much of a change, but it
> seems easier to justify "no binary changes" via the use of struct_group().
>
> If splitting the memset() is preferred, I can totally do that instead.
> :)

I'm not sure that compilers can fold memsets of adjacent members. It
might not matter, but you could wrap these members in a _named_ struct
then simply use assignment for optimal codegen.


-- 
Thanks,
~Nick Desaulniers
