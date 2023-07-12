Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36A750597
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGLLIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGLLIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 07:08:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E4173A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 04:08:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so4397207a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1689160113; x=1691752113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYbkaTHL0AVDHrq4F5UzM8O5/ZedTs7J/tvsChbMyqI=;
        b=YZd+WO2vqcn3FDaFSId6HXRL6X8u3D4MmYihBMJ63Bm814qN7gLeEwHFgQ9/ZPw8iT
         xfxND2FR2NK6zUv6eLDcNzf1WoaG30A7Q9T3lA7ynmlnCkHpg7VqeinvwjKqA7KvseDg
         cGJ2bTGZu5JQeBMq93Ed8YhajcqHPs7kcYQ+bdxe85cSeAwt0znQlenVjCGZ/q7+T7QE
         Hoz1ZoNIiIYxcpAuPCpcYwLB6Ydjn/s2LC7pEl/BXxDAgK9sMEn180B99GJFyCCklJtS
         68xgNftYPCRv/YCRYDPttEka3hYJCXIYYWv5xse+KQXoltRqehuB2DeRtse6r8grpno8
         i4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689160113; x=1691752113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYbkaTHL0AVDHrq4F5UzM8O5/ZedTs7J/tvsChbMyqI=;
        b=C4g1IAmFGc3OrgDvGDleIFsIjo2ypyoFTerIwlbG6T4zF5zz2lAB5azCr+xP8ghfxT
         90hfhD6cFCDTFbfMEL1+Bd9X5NuprF/7idzDORtrMA7CpaH1uOi4mwGbuezngh4p1sFj
         l2zzd6+XEdoIta1w0cg2Uc/3UWZ2ecXpCkRd6AUh555yRJfoSd8jcryyaPpwvBbJHq+B
         mnC4+NwKEGfT/0kSOU2nEcg9my9+YU0PLrwqBFrH4FxeIltj9S2YBRfViRX9g2Fi2zsi
         cYm5/LeGh5Xs59r57FHe4IMHGmNLkq+2Z5CddKD4vmxmpQifTFZwkAtzaR2ptxkrWryQ
         naSA==
X-Gm-Message-State: ABy/qLZYMkObvrB3wa8ttyb0sro+CSorZFPxWdpIch+kGWQnMTJV4jzI
        aDu+5tdf7CvO3CQ/35Lem57f/dEvWNQJifBTetL9yA==
X-Google-Smtp-Source: APBJJlEJOiq68sxxfU5J7oFmwLARPITYcdmFCjS0hmsuzxOaJEzxlo1GWuwhXC0wCReFa/GX1IhP0G+Sul+vgFB5Mik=
X-Received: by 2002:a50:ec99:0:b0:51e:ceb:7d71 with SMTP id
 e25-20020a50ec99000000b0051e0ceb7d71mr15990239edr.39.1689160113196; Wed, 12
 Jul 2023 04:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083841.222607-1-koen.vandeputte@citymesh.com>
 <9936de52da43347ba0ccfb8737440a9698fb4585.camel@sipsolutions.net>
 <CAPh3n82BY0bFkHs6DKKf6+ZUZw+DJmTy7=JEG8REFHyHFMqoVQ@mail.gmail.com> <82b75a5e344b23a388a8f078de730272e91f99d2.camel@sipsolutions.net>
In-Reply-To: <82b75a5e344b23a388a8f078de730272e91f99d2.camel@sipsolutions.net>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Date:   Wed, 12 Jul 2023 13:08:21 +0200
Message-ID: <CAPh3n82NPvU4AXgQ3y21kSkMWW18UNrOc1StKHuYeGRN4xNt5Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: fix mbssid nesting
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 12, 2023 at 12:34=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-07-12 at 11:05 +0200, Koen Vandeputte wrote:
> > On Wed, Jul 12, 2023 at 10:44=E2=80=AFAM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > >
> > > On Wed, 2023-07-12 at 10:38 +0200, Koen Vandeputte wrote:
> > > > Executing command NL80211_CMD_GET_WIPHY and parsing it's output
> > > > natively without libnl shows following attributes as part of
> > > > the nl80211 generated netlink message (part 16):
> > > >
> > > > GetWiphy: Type: 1
> > > > GetWiphy: Type: 2
> > > > GetWiphy: Type: 46
> > > > GetWiphy: Type: 33074 <-- wrong enum value, above MAX also ..
> > >
> > > That's not wrong, that's just NLA_F_NESTED | NL80211_ATTR_MBSSID_CONF=
IG,
> > > since it *is* in fact a nested attribute.
> >
> > ahha! so one should check on each received attribute if this flag is se=
t?
>
> Yeah, that indicates that it's nested, without having the out-of-band
> information that it should be nested.
>
>
> There's also NLA_F_NET_BYTEORDER, so we really only have 14 bits for the
> type, so you should probably use NLA_TYPE_MASK.
>
> > I guess all the ones with the noflag so far are using it to avoid
> > breaking legacy stuff?
>
> Right. When we realized that nla_put_nested() didn't actually put the
> nested flag it was kind of too late - although a lot of userspace
> probably would have handled it correctly (if it uses libnl, etc.) But
> still, we converted it all to nla_put_nested_noflag(), but we really
> shouldn't be adding new code that calls nla_put_nested_noflag() since by
> definition new code is new attributes, and then userspace can be
> updated.
>
> Unless you're saying this somehow breaks old userspace that doesn't even
> understand NL80211_ATTR_MBSSID_CONFIG yet? But that seems unlikely, you
> have to be prepared to see attributes bigger than what you expected and
> skip them?
>
Yeah, I've already updated our internal code to filter netlink type
using NLA_TYPE_MASK.
Works like a charm now.
Our codebase was initially made during kernel 3.x time when that
filtering was not needed.. and within OpenWRT, the wireless stack got
updated to 6.1.x
bringing in mbssid netlink from 5.16.
So this popped up suddenly :-)

Thanks for the patience and sorry for the noise!

> johannes
