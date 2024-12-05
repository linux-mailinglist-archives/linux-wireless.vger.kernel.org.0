Return-Path: <linux-wireless+bounces-15927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A179E57C7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A02D1883692
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71231D52B;
	Thu,  5 Dec 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PX91DB/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F631219A6A
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406393; cv=none; b=MWYBcfLKDZKVpqQOsiWYVIl8X9Btu3E1cem7RYhnwWZoxFs76MWo6W3X0EyJZ8/QePWznYqyJcNztlEPXW7g0261RBbpM1j6PaxJ7/6sTz4B8pvFePBfp0jXmgATovkgkPBHATur8j3ho+SHVZpd2+1rS98wK3MMRx5Q6AYWnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406393; c=relaxed/simple;
	bh=JF3MqJZziorqpBOYbWa97I4GmjXX7snHvfvD6fsYzCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKK1v8Ddww1cUERhw9cFwGLFA5GtXN3ssNpGhpMXF2qUESPWFTbYBD15NaAySugF7/9B4krpGplcBRL+KaXIDoAay0NOO8CURfREz1tine7/xPHOzkd6hVynHOnBpriwgPdTshnl3rinWjiSYfyu0OfZ/4M2igl/9KKxceMDgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PX91DB/e; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f1dc7c6c67so246765eaf.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733406391; x=1734011191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDXqwdvsRrw3EZaw3V5kPaSP4x/qw64uE3sG+rSHwXg=;
        b=PX91DB/eg9/OwXaTxNj01Q0Fb2yd3GeV6RLl5oYW27ee4NNfPWH27aVm1uHZDJO4qz
         pa+mWPtsAGEFCSwT4NafleAu/HSsk9kdTf0yjzTOy46+1OiVxMua69RQtmfaTJUKim8G
         Tuw8da6QnjjO+tZmoc02IqvNja9nPDQ+2eats=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406391; x=1734011191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDXqwdvsRrw3EZaw3V5kPaSP4x/qw64uE3sG+rSHwXg=;
        b=cOjaUQcAGY2moZ1K518nr/NFDltSz499eGkPIyqVJx1Vb0vA1c7Tvp1VKtjYbIw+r0
         2KfpYHMUIscE9nEtj1jnyVz8wMJW/7F0R3yZtK76ByAUU3BqooUxQD0Qfpu5khH1PPjt
         E8+XKUO5GSNl/r3DBD5iPGKybMZzM71e6MP52JwHSe88U7huGbzaMqISyDQViNnSo88q
         hkYXBWp1RDRqGo8l6mAfAmUjReZJK3PJoViu9iZsQc9k8+WoLKxqqQ/SMpe1SxDmrULa
         vOwNC/Sr1NayRuFAnEQd8/k0fRYz0VESCg5Rjc5uEEn5q3pAZqWFY2GkWoN2kzZYo/7T
         neuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsI8ti8OmZssOnt2isWegRfOSVdjA66yat4JrVP74xaj9hHPyBnFByWDqi485dlugjcNFcySOrzO5z70gAKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoV+mVZqRRowt+M1P+RkW8CBQESzfBGvmOX1wgAEArC+gUDofy
	ICOQ7Wk9Jy3mpfVh7Lb0Eh5QkfpjYAZdAuBBpiV+s9dFn1Q2RgABoPsxpWIWNFnEJ9kNoglD0Yo
	F7iCe23MQbbIly8oBx2/ZVoOR31sT7z64607s
X-Gm-Gg: ASbGnct8ngXX0QCgTz+Q5IWD6XilNFpTsMFq2LhUeVBvcG8IRrbHxbGGW5JdzYXYRDo
	yICKsdkS7hS+UIHAsXgkDElfbDD8t1FTXUsQpSxfx6BqJ1CW3DqNRWYDrEKs=
X-Google-Smtp-Source: AGHT+IHnSL2+Mv5305oRNs68OmnNwoGk9Pcl4Kh3qFrISCF6EurpTgK8aDuSZWA88krip9K21KldOi+jmx4v+GTTxbM=
X-Received: by 2002:a05:6830:6f8e:b0:71d:5336:df80 with SMTP id
 46e09a7af769-71dad6cc7b4mr8558823a34.20.1733406391316; Thu, 05 Dec 2024
 05:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
 <Z0-4umP9TnNAbJXO@google.com> <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
 <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
In-Reply-To: <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 5 Dec 2024 21:46:20 +0800
Message-ID: <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Doug Anderson <dianders@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromium.or=
g> wrote:
> >
> > > > >  Can you try testing (and gather timing numbers) when
> > > > > suspending soon after initiating scans? It's hard to judge what t=
he
> > > > > lower limit of this timeout should really be without any numbers,=
 just
> > > > > like it's hard to judge whether your 10 second watchdog is reason=
able.
> > > >
> > > > Pin-yen: is this something you could gather?
> >
> > I tried entering suspend right after wifi scans, and the time spent in
> > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > suspend does not increase the execution time for mwifiex_enable_hs(),
> > so I think the driver is capable of interrupting a scan.
> > > >
> > > >
> > > > > Also, for the record, since we might have to field regression rep=
orts
> > > > > for other systems: what hardware (chip variant, FW version) are y=
ou
> > > > > seeing problems on?
> > > >
> > > > Pin-yen: I'm assuming you'll provide this.
> >
> > From the debugfs entry:
> >
> > driver_name =3D "mwifiex"
> > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> >
> > The compatible string of the DT is "marvell,sd8897".
> > >
> > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to prov=
ide
> > > the above to provide a little more confidence, or if you want to
> > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> >
> > It looks okay to me to decrease the timeout here given that scanning
> > doesn't seem to affect the suspend time. What's your thought, Doug?
>
> I think Brian is right and that we should change how we're using the
> DPM watchdog, but IMO that doesn't mean that we couldn't also change
> this timeout.
>
> If nothing else, you'd want to post a v2 of your patch containing a
> summary of the info you've gathered so it's recorded with the patch.
>
> Maybe what makes the most sense, though, is to put our money where our
> mouth is and land some sort of patch in the ChromeOS tree and then
> report back to upstream in a month when we have data about it. If
> things look good in the field then presumably that would give some
> confidence for upstream to be willing to land the patch?
>
> Probably about the best data we could gather would be to break the
> existing timeout into two halves. You could wait half the time, then
> print a warning, and then wait the other half the time. We could even
> land that change _without_ changing the timeout to 5 seconds. Then if
> we ever see the warning print but then the suspend succeeds we know
> that there are cases where waiting longer would have helped. If we
> made that a WARN_ON() our existing infrastructure would help us gather
> that info...

I just realized that mwifiex_wait_queue_complete() has another 12s
timeout[1], though they are not directly involved in suspend/resume.

Should we also add a warning to that and see if we can make it half?
This starts to make me think how many timeouts we want to consider.
Does it make sense to only focus on the one in mwifiex_enable_hs()? Or
should we check other timeouts in mwifiex or even other drivers?

[1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wireless/m=
arvell/mwifiex/sta_ioctl.c#L51

>
> ...so I guess summarizing my rambling, a good plan would be:
>
> 1. Change the ChromeOS DPM watchdog timeout to 15 seconds to avoid the
> problem for now.
>
> 2. Land a patch to do a WARN_ON() in mwifiex if we take 5 seconds.
> Actually, you could (probably) send this upstream and land it
> FROMLIST?
>
> 3. Wait ~1-2 months and see if we ever see the WARN_ON() trigger but
> then things succeed after 10 seconds. If this never happens then send
> a v2 patch changing the timeout to 5 seconds with details in the
> commit message.
>
> 4. In the background, see if we can convince folks to make the DPM
> Watchdog less panicky.
>
>
> -Doug

Regards,
Pin-yen

