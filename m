Return-Path: <linux-wireless+bounces-8404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC68D7BC3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04257280F1F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CB77115;
	Mon,  3 Jun 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvoJjo+k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D576F17
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396780; cv=none; b=o3z22ZL3Ng16t7mFalNsCqxMVTm5iEvagQ/D/sVosKbs7xDYOV2BY/jytQYzi1kuvNZEKBEp2ORsMlUAceyl7Lr+fvrLYm1y2uh0aRf9QIjC0G8NwW6qLSS+SfuT1VZ9A90uUdUfTkKJt9g4dDqCf0CZPzOG2SNOdHauJcuFbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396780; c=relaxed/simple;
	bh=rrdptw6z41mfwM20VuVwakCzcCJ2lQqgNtsMJ3yMn/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEehHOsaKSwLSWqkdZ7URl8fNGnIN91GPX5DEW+59hdcPCGMu6Vf7MTpYJWnYGAfwZpKAEkvMHla8wmCnQul+UlSPRvHVuNOZvAuC1rk8kqp6l8/BNuBAUz7Tp65ZmWxHYYPpgIGt1vRxHWZ8fVs9+Vw+Fl/get5lx6EhCP2YY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvoJjo+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F0C4AF07
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717396780;
	bh=rrdptw6z41mfwM20VuVwakCzcCJ2lQqgNtsMJ3yMn/0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mvoJjo+kOmcUST3AStzPqFB+3Gueie4y2fPS8+D1wzsNHIwIYGwalNYYhmMB2OK2l
	 FFZAwEnWY5EIEPc/fGK9DgTDsoOb5D8o4WLN7HPOHvFCzTNhmhHvr5X1/FMj/cZ4Um
	 aWJCqY+ogZvwFY7cJM7bxkQI1meJf2Srvw03cIe+XsWBBDOXt1geHRMC/0vAzRZNGa
	 KU2aog4yVQVxUXt/xP04KRE6I0oAkjfEBNif68KxDnHGGnI0u/7TfKidmn7aJxYgrk
	 eFksyCFrWQU+oLfIbe3PSbYSTtLL8mlEeRuu2+nYVrVC+SzTZy4RYeLkTA7tExgKan
	 Gk0s5nZv0VJ0w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso48091451fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2024 23:39:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2mrSBuJNK2bORxdSghbBEWHNsO7zI3pytuBsyZ8NNcNA8CAa+AvNsGfFZ+qIjf6m7Nxw6hNL9pC9b8x3hJLHMGMfUOnNsEEw0qImdtSU=
X-Gm-Message-State: AOJu0YzO0jYd/s/ns7mb0k3W/V8r2NI170M0OkGtIU3M/Ic/uwsyTH8L
	2qAIW9j0kaQxzzTy8eJEUMTXgWsZkpUcPBCelUT5+a+Y5Hmm9rbV+cD/aewAqL83iaBQK6mI8sT
	A2t7cTvOOgD3l0dWEGl3jsmuDfgE=
X-Google-Smtp-Source: AGHT+IFLNukTRlXKaQ+GvVsm97eiGnOwk5fX/NrJvNDhvRo1ZBeP6KIhYGMOFf5t8OKTDoc9QiHT4SYMO3r0ogSiru4=
X-Received: by 2002:a05:651c:d:b0:2ea:81cc:b146 with SMTP id
 38308e7fff4ca-2ea9512b1a0mr54034521fa.18.1717396778471; Sun, 02 Jun 2024
 23:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfTr+pXU_=ORh2w3GE+YiU9igh61uWZS-zdG1GyKFb5Qs6fTg@mail.gmail.com>
 <CAGb2v67-9Gyxwpy8w9X=Gz7wXuVO0DncwXoRPV6_zrpF7MdEsg@mail.gmail.com>
In-Reply-To: <CAGb2v67-9Gyxwpy8w9X=Gz7wXuVO0DncwXoRPV6_zrpF7MdEsg@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Jun 2024 14:39:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v66xjwgcMZ2-N9CEg055Q+mLQKm20Nvo9mmHD3LY=C=Vjw@mail.gmail.com>
Message-ID: <CAGb2v66xjwgcMZ2-N9CEg055Q+mLQKm20Nvo9mmHD3LY=C=Vjw@mail.gmail.com>
Subject: Re: S1G and 6GHz channels in Estonia (and EU)
To: =?UTF-8?B?VGFhdmkgRW9tw6Rl?= <taavieomae@gmail.com>
Cc: wireless-regdb@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resend to Kalle's correct email address)

On Mon, Jun 3, 2024 at 2:36=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrote=
:
>
> (Adding linux-wireless ML, Kalle and Johannes)
>
> On Mon, Jun 3, 2024 at 1:13=E2=80=AFAM Taavi Eom=C3=A4e <taavieomae@gmail=
.com> wrote:
> >
> > Hi!
> >
> > I have a few questions about the current regdb values for Estonia/EE an=
d EU:
> >
> > 1) There are no allowed S1G/HaLow/802.11ah EE (or EU) bands:
> >
> > Based on resources online and Estonian law
> > (https://www.riigiteataja.ee/akt/117052024018?leiaKehtiv - Extra 6)
> > these two additions should be correct:
> >
> > + (863 - 868 @ 1), (25 mW)
> > + (915.8 - 919.4 @ 1), (25 mW)
> >
> > (Note: I don't see a way to define duty-cycle limitations, but that
> > should be okay?)
>
> I'm not sure if there are plans to support S1G in Linux. If not then
> the information would go unused and untested. If it is supported, then
> patches are more than welcome.
>
> > 2) There's seems to be a missing 160MHz channel (50):
> >
> > This combines the restrictions of the two existing defined bands it
> > overlaps with (https://ttja.ee/eraklient/side-ja-meediateenused/raadios=
ide/wifi-seadmete-kasutus):
> >
> > + (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=3DET=
SI
>
> The AUTO-BW flag lets the kernel know that it can combine neighboring
> rules for wider bandwidth at the lowest power limit within the rules.
>
> Thus merging the rules is not needed. Indeed we would prefer rules not
> be merged, as the database should convey information closest to the
> regulations.
>
> > 3) The 6GHz band should also have an outdoor limit and probably also
> > allow 320MHz channels (at least in EE):
> >
> > - (5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=3DETSI
> > + (5945 - 6425 @ 320), (25 mW), wmmrule=3DETSI
> > + (5945 - 6425 @ 320), (200 mW), NO-OUTDOOR, wmmrule=3DETSI
>
> The kernel currently can't deal with duplicate rules for the same
> channel. Thus we have to make a decision on whether to have a rule
> with higher power but indoor use only, or the opposite.
>
> Within our database, we have the former for some jurisdictions
> and the latter for others. It really depends on the submitter.
>
> > Would a patch for these be accepted? Should I update all EU countries
> > (considering it seems harmonized within the EU)?
>
> I would expect patches to be per country referencing local regulations,
> not just the EU one. IIUC the EU sets one harmonized regulation but then
> it's up to each member country to implement / incorporate them?
>
> Whether you would like to update other EU countries is up to you.
>
>
> Thanks
> ChenYu

