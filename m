Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81A577EA1F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbjHPT46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 15:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346029AbjHPT4x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 15:56:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63E52D55
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 12:56:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so2485e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692215781; x=1692820581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC/mCsgx1KktJYnIYDdRx411YrKdiaNWExWNAqcy75A=;
        b=AqeK6Olr/XCvD7VqTtLHWLLZlustDbrtT0nUeiLkNS2+hQ8x/fo1E7iOpXe+movIqc
         dRCjewore/6mUGie1lmGYWmFwI7/9+/H9qiBmYiCj6DjVQWy2fddTMKTNghG3xfT2vkx
         BVray7nVy+FKOY7YLZq1yCtNOgGCZzC+G5BK/GaK5djUjcume8XSUUT24OQdz54r7IRj
         P0naslHa/2PiyZ/TxqLb99hTG5sjCXcy6rfkg414bfRsu18VkufddvUBCxkYJXjx6NqF
         cohYOF+fP42wcA7Gp1LKl9eoS+CnObJ8tiye4qZy6XTmZtOdo6MOuepdRL7Lph/G9ZUy
         HGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692215781; x=1692820581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC/mCsgx1KktJYnIYDdRx411YrKdiaNWExWNAqcy75A=;
        b=L+3i2zdjRnh0D1Bqke9oS2Umlxbkijwjl6QtQU+6CWaF6fGJH4TOtCPveVkjx8qsj/
         c8bhELA2w02OORxpoSPhUzfFAxHtQbcApRR8ZAKGeym21qCEoNQIZiaIUxSzvaKgyeSY
         0PkhxNt+5S/m8OdHDAZSEtTVldA/+A9IpkQfIgLe6icwd8xX0oN9kG6gX7YQe2o/f83B
         sr2Q+Z8ACij73M63DGcKjq9MexmLn4pzAodpJ5BNQycm1A+yjGQq8DoI6RBp/kQYg4dJ
         F2oGiGMPvUMTVctCceWtMZonJmdqwCSkJiMRlLI1FiAcmDImnCIk+D2FCAQL8MaW8lkO
         2Lnw==
X-Gm-Message-State: AOJu0Yyg3CjfFznCb5advoQEdjpoOvdA0tqrCK9b2Sr2kmrorfegCnnj
        8FNwFHcCbE736Yr9/6HYi2peawJB3VvwJwwruFQwDpupM7dNrtRUkGzkEzfB
X-Google-Smtp-Source: AGHT+IHJYciqUfrkQlahE30+UJVKAichQq/U22+CXnCT5/gI/dcHTZmqLLTTfclzQo3mWWMneSs4lBdA/4ANFvRBl4c=
X-Received: by 2002:a05:600c:2804:b0:3fd:e47:39c7 with SMTP id
 m4-20020a05600c280400b003fd0e4739c7mr26517wmb.4.1692215781039; Wed, 16 Aug
 2023 12:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bf21d705b0e8674c@google.com> <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
 <CANp29Y7MS5q=HVRuz-eXx4=9FxpuFJr3GkikG6MrKegxH6cO2A@mail.gmail.com> <bd2427a1c4ea30682c45c22c5f452e3dd8e674fb.camel@sipsolutions.net>
In-Reply-To: <bd2427a1c4ea30682c45c22c5f452e3dd8e674fb.camel@sipsolutions.net>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 16 Aug 2023 21:56:09 +0200
Message-ID: <CANp29Y7TVNRFpcN1qSSurwWAtbBn90z_eUet3UdOcdDdUZ7zrg@mail.gmail.com>
Subject: Re: WARNING in __ieee80211_beacon_get
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     syzbot <syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, ramonreisfontes@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 16, 2023 at 4:01=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Wed, 2023-08-16 at 15:39 +0200, Aleksandr Nogikh wrote:
> > On Wed, Aug 16, 2023 at 10:09=E2=80=AFAM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > >
> > > Hi,
> > >
> > > Yeah, I know this is old ... still happening though, so I've been
> > > looking at it a bit.
> > >
> > > > The issue was bisected to:
> > > >
> > > > commit 7dfd8ac327301f302b03072066c66eb32578e940
> > > > Author: Ramon Fontes <ramonreisfontes@gmail.com>
> > > > Date:   Thu Oct 10 18:13:07 2019 +0000
> > > >
> > > >     mac80211_hwsim: add support for OCB
> > >
> > > I'm not sure that make sense, FWIW. There isn't even any OCB? The syz
> > > script just contains a channel switch command.
> > >
> > > > WARNING: CPU: 1 PID: 6900 at net/mac80211/tx.c:4875 __ieee80211_bea=
con_get+0xb59/0x1aa0 net/mac80211/tx.c:4875
> > >
> > > I also can't reproduce this though.
> >
> > Did you try to run the kernel attached in the assets?
> > https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#r=
un-a-c-reproducer
> >
> > I've just followed the instructions from there and the C repro did
> > crash the kernel in ~20 seconds:
> >
> > [   56.809692][    C1] ------------[ cut here ]------------
> > [   56.810656][    C1] WARNING: CPU: 1 PID: 5358 at
> > net/mac80211/tx.c:5011 __ieee80211_beacon_get+0x1495/0x16e0
> >
>
> To be fair, I didn't, I figured the reproducer was simple enough to just
> have a go at it with my own test infra.
>
> Is there an easy way to rebuild the kernel for it?

How does an easy way differ from a difficult one in this case? :)

I've just built the v6.5-rc6 kernel with the
https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D3e670757e16affb
config and run the C repro mentioned above from root. It crashed the
kernel:

[   78.057333][    C0] ------------[ cut here ]------------
[   78.058289][    C0] WARNING: CPU: 0 PID: 5377 at
net/mac80211/tx.c:5011 __ieee80211_beacon_get+0x1495/0x16e0

--=20
Aleksandr

>
> johannes
