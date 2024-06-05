Return-Path: <linux-wireless+bounces-8509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE038FC293
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 06:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A9428309D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9016A33D;
	Wed,  5 Jun 2024 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlyiLByq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7C25777
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560696; cv=none; b=pxdoFZHE550SVhXkosq/04YvBoMPGhZw1o0Kf24/qsNSKqEg5if9fnfYkWDV7jJkfw/hvQObdeMVpPRQdyjQcdaLMSUhGv3462MoMsuAszjsrXWrxBU6+4evsVDcIVYbArc589LwvFuFY1G0Ni3Ms1ZJlUQhZe6I/dKfnmHWwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560696; c=relaxed/simple;
	bh=etF19prCyPnFhMAS/6DWy44pO56niXLPQhsefaibP0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/KLC1EiW2pjSUHYHnxJojap0QV7oZb8ISP8m459XaQvcLO7kNAwW55bHDDNwCaDnMtt0SjPHYcGLi7MmyVWTif8PeMfgAEH7yVnD+nRo2SiCAxCZvtp/eQmHEedVdl9kQboU9942s4UDj3tdixd8w/IaKJFBivt/4tce8k2JXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlyiLByq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7EDC4AF08
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 04:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560695;
	bh=etF19prCyPnFhMAS/6DWy44pO56niXLPQhsefaibP0s=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nlyiLByqMD3ygcEpUaHUNOZBO0AM7BK9po9eE/SwyvWm9w5+Ib3Bs6B6U0vR78njr
	 Nt2krToDOC//r1Nwd/pdiXI2kPS4yLLPKG90Miw4kRKyV3FzwgnyW5Z/YnjJ+YxIhj
	 VttUfLZiPdU2QoIkmJN6jZDNXj/uEnLsT+AlOTfxAFpYyIxptErXOLe6waFiSUPUyr
	 2q/Bl/Jqp7HjzTK7/iCWUl0QpJuulFRGsjzd8QADJb+vM6IqpOENjnVb1DGvP6b9Wy
	 GRwmLiZSs2noS9v3uQ8WbJVk++7crdISWy6oeFM5k8eYkYZO6UdeZSiW0aqRBHlfwM
	 dy9gQBYJWo3Yw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso47977651fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 21:11:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YzB+12zsrVBHVP6LFNPmIaPPbTmwl/9Lqwskf8xIAN6TOe3+uvF
	C6CVoL48+4NlSnP0NfvbnY+eIRd+ymu7/+5sXuESth4V8DXxgT1ygInzQO2y2cofpRreGlEaeBs
	90tax9qaxxrJ8mGufepmO5zcScgk=
X-Google-Smtp-Source: AGHT+IEfdJZokykQeRkAQZq9+7/S2636sl+IO6YQ6A77tKEPLEmfhKE9mpxxTNZTe7RuXGJ6wpeVDsoiCa60dGJlncs=
X-Received: by 2002:a2e:99ce:0:b0:2ea:91c1:f3d5 with SMTP id
 38308e7fff4ca-2eac7990e3bmr6670621fa.15.1717560694178; Tue, 04 Jun 2024
 21:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com> <20240603060948.99147-1-pkshih@realtek.com>
 <CAGb2v65j604KUiVDiXSAbpJQQetGagFj53E8zuk6JqwaDdBk3w@mail.gmail.com> <a97fcc8d9dfd4f9784dace38d0c01351@realtek.com>
In-Reply-To: <a97fcc8d9dfd4f9784dace38d0c01351@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Jun 2024 12:11:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Crwo-qiS0hFrUdrjD4NK42_-s6_RhmusfpDd0SDZj2A@mail.gmail.com>
Message-ID: <CAGb2v67Crwo-qiS0hFrUdrjD4NK42_-s6_RhmusfpDd0SDZj2A@mail.gmail.com>
Subject: Re: [PATCH 4/4] wireless-regdb: Update regulatory info for Mexico
 (MX) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> > On Mon, Jun 3, 2024 at 2:10=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> > >
> > > The Plenary Session of the Federal Telecommunications Institute (IFT)
> > > determined, in its IV ordinary session of 2023, to classify the
> > > 5925 - 6425 MHz frequency segment as free spectrum and issued the
> > > technical operating conditions that allow coexistence with the existi=
ng
> > > services in the country [2].
> > >
> > > Within the operating conditions of this band as free spectrum, its us=
e was
> > > determined for low power indoor and very low power indoor and outdoor
> > > systems.
> > >
> > > According to WBA Response to the Mexico IFT 6 GHz Consultation [3]. T=
he
> > > Low Power Indoor is
> > >         33 dBm Max Tx Power (EIRP) & 8dBm/MHz PSD (EIRP) for Access P=
oints
> > > and
> > >         27 dBm Max Tx Power (EIRP) & 2dBm/MHz PSD (EIRP) for Clients
> > >
> > > The Very Low Power is 4 dBm Max Tx Power (EIRP)
> > >
> > > [1]
> > https://www.ift.org.mx/comunicacion-y-medios/comunicados-ift/es/el-plen=
o-del-ift-clasifica-la-banda-de
> > -5925-6425-mhz-como-espectro-libre-comunicado-132023-16-de
> >
> > Not sure what this reference is for?
>
> This is entry page of [2]. I will remove it or add description about it.
>
> >
> > > [2]
> > https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comuni=
cados-ift/comunicado13ift_1.pdf
> > > [3]
> > https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/co=
nsultaspublicas/documentos/2021
> > 0119-cpi6ghz2020-162.pdf
> >
> > [2] does not say what limits were adopted, nor that the WBA's
> > recommendations [3] were adopted in its entirety. Without such
> > wording, [3] is just a recommendation, not the final rule. This
> > needs some more information.
>
> I will try to search for the adopted power limits. If I can't get that sh=
ortly,
> I will only submit 3 patches by v2.
>
> A question about TX power value. Is a special value existing to indicate =
the
> value is uncertain?

No such value exists. If the value is uncertain, then we simply can't
add it to the database.


ChenYu

