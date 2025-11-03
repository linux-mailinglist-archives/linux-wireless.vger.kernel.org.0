Return-Path: <linux-wireless+bounces-28509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22003C2CF1B
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88286563599
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD483168E3;
	Mon,  3 Nov 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcA9Phwe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660E314A90
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183227; cv=none; b=iq16bNCOWeOdv3jKD4bVUoXOjvL7dUKBmBvcbe1QKR1XC9A0S4ZD2Nt++YZf1KoRi/UzS6jTK1Qw2Kbslqe239Hidw/0SYNjkVIu2X4EgKlZHoP4VawVE40wzY0Wa4y5PpJOo76R32zt2IrS0cc/0TFPAsYA0UySX91b1g0mkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183227; c=relaxed/simple;
	bh=z06Fe1dDgZ79bzqqI4jcMbkz4cfWhPYgAA7c+FRNAUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VShsjqiN62u/jfu5T58XT1TKsuCgq/aUCFSnCjPI1mpjGtfReuzoq8yJnO/H/ngqP2hwqZ6+FcLNXJBxN+l4xczjiq0h2CSvAB0JLfKDIi/O+89KcGw+2Xx/kUBhejg4rtjWP9bsU9OMxkWo/+1QvneUKk5WpMTeiicG3X6EbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcA9Phwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44881C19421
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183227;
	bh=z06Fe1dDgZ79bzqqI4jcMbkz4cfWhPYgAA7c+FRNAUE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=hcA9Phwe7xlLSA3Ug3ru8+tFMysHQUkPrBzFObU7EovXDDkE3wJfEoFoLoTiCj+2V
	 rEF2h2mQhMEMiItGAhSlSi0jKhTopPpKFFRcynGs2XuACVrl7Rkb+YlW9I2xX1p9Hh
	 mv2Ui4bOBdvscsWGJE3b3Hfpd+Wq7EBa2v2XWz/LT6aO7NndnrGOen8nFiWmzY1qIU
	 CA9L+Y6Lq2/kSIm0eKeZMrizJx1odgwAjoy47NjjPvkPlV2n+C78YFFKAaghcW9VOO
	 fQV+W+2wQ7B/L0e76EIMj6O20qCuam8eiGC9Qs2BGXgyGNORREDfaZ6BCgze/UBALL
	 hWJAJbqEPajEA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36bf096b092so41016031fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 07:20:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwIwIxosW1hFvELAM/MxflNMjly0E50ZSY4MfduKPQ4ACvm7jG4
	PauK6iwZqSo31KVYsyXRsdhz6ovO/+n/eW6EhrgzTQTV7sadYjKocA6L0EL7wkcgsPwkTvqOdbB
	ohVhGb1EDEuk0hW7gMhndq4815fqunRw=
X-Google-Smtp-Source: AGHT+IGrKRKQ1z2u/DzDWGtq6JFAin7JWjUb8jT5U3Z8Op0kyN+UW2XIfIl1DsnrvHv07jhv/yxPUphx2GdIzPgpTbU=
X-Received: by 2002:a2e:b88b:0:b0:37a:2d23:9e89 with SMTP id
 38308e7fff4ca-37a2d23a783mr19888061fa.49.1762183225585; Mon, 03 Nov 2025
 07:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029012429.68658-1-me@ndoo.sg> <CAGb2v64omSs0uVL00n7vGRF_-=qb8xLCjdnyWRq_Caukf2ntXA@mail.gmail.com>
 <CA+yTfBB57CA5c=bKdOjPWYR7F9Nq38Bao3+Q3LKYjOYJJ8WfxQ@mail.gmail.com>
In-Reply-To: <CA+yTfBB57CA5c=bKdOjPWYR7F9Nq38Bao3+Q3LKYjOYJJ8WfxQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Nov 2025 23:20:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66TY3Xq_Znsv-SO5czROvw6T1f_eU8W8YYU_QVziaQA6g@mail.gmail.com>
X-Gm-Features: AWmQ_bkeWtoIf-I8ZkPLazC07RjnzwEm9ZoZ_DuM1pmsJIOCAyuYaU-YuLMUheo
Message-ID: <CAGb2v66TY3Xq_Znsv-SO5czROvw6T1f_eU8W8YYU_QVziaQA6g@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY)
 for 2025
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It's fine. I just didn't want to force push unless absolutely necessary.


ChenYu

On Wed, Oct 29, 2025 at 6:47=E2=80=AFPM Andrew Yong <me@ndoo.sg> wrote:
>
> Good day ChenYu,
>
> Indeed, the commit message is also largely the same, there was
> actually no differences relating to Wi-Fi class assignments, just some
> moving around of the table rows because of changes to other unrelated
> class assignments.
>
> I just wanted to at least get the reference updated so that the next
> person who comes along doesn't have to check against issue 2 of 2025.
>
> I should have mentioned that on the new patch thread to save you the
> extra comparison, sorry!
>
> Andrew
>
> On Wed, Oct 29, 2025 at 2:22=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wr=
ote:
> >
> > On Wed, Oct 29, 2025 at 9:24=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
> > >
> > > Malaysia Communications and Multimedia Commission announced CLASS ASS=
IGNMENT NO. 2 OF 2025[1].
> > >
> > > With reference to class assignments on pages 9 and 10, and Power Spec=
tral Density (PSD) limits on page 20, update the following rules:
> > >
> > > 2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
> > > 5150-5250 MHz:
> > >   1. Align previous 5170-5250 MHz rule to class assignment
> > >   2. Mark as NO-OUTDOOR
> > > 5250-5350 MHz:
> > >   1. Align previous 5250-5330 MHz rule to class assignment
> > >   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, cal=
culated at 20 MHz channel width
> > >   3. Mark as NO-OUTDOOR
> > > 5470-5650 MHz:
> > >   1. Align previous 5490-5650 MHz rule to class assignment
> > >   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, cal=
culated at 20 MHz channel width
> > > 5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
> > > 5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PS=
D limit of 12.5 mW/MHz)
> > >
> > > [1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assign=
ment-No-2-of-2025.pdf
> > >
> > > Signed-off-by: Andrew Yong <me@ndoo.sg>
> >
> > I applied it on top of your previous patch. Conflict resolution shrunk
> > the patch down to just the URL change.
> >
> > ChenYu
> >
> > > ---
> > >  db.txt | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index 1d17271..dc72989 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1450,14 +1450,16 @@ country MX: DFS-FCC
> > >         (5925 - 6425 @ 320), (12), NO-OUTDOOR
> > >
> > >  # Source:
> > > -# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-s=
igned_19012022.pdf
> > > +# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignm=
ent-No-2-of-2025.pdf
> > >  country MY: DFS-FCC
> > > -       (2402 - 2482 @ 40), (500 mW)
> > > -       (5170 - 5250 @ 80), (1000 mW), AUTO-BW
> > > -       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
> > > -       (5490 - 5650 @ 160), (1000 mW), DFS
> > > -       (5735 - 5835 @ 80), (1000 mW)
> > > -       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> > > +       (2400 - 2500 @ 40), (500 mW)
> > > +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
> > > +       # 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW rea=
ches the PSD limit of 10 mW / MHz at 20 MHz channel width
> > > +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
> > > +       # 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW rea=
ches the PSD limit of 10 mW / MHz at 20 MHz channel width
> > > +       (5470 - 5650 @ 160), (200 mW), DFS
> > > +       (5725 - 5875 @ 80), (1000 mW)
> > > +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
> > >
> > >  # Source:
> > >  # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pd=
f
> > > --
> > > 2.50.1 (Apple Git-155)
> > >
> > >

