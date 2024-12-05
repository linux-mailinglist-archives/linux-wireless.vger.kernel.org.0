Return-Path: <linux-wireless+bounces-15930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE469E5CA0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0761281F10
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD4224B07;
	Thu,  5 Dec 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+aW88um"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826021C16C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418833; cv=none; b=AVcMmlr7Da6v7bNCXhe86jEHqBQ+jh3Kzu+Nx8Ne7YOGTvFdRM54HzDK+AShaGKzyUAQC5e3SqFf0hvAalfroB+f4/DOZBoA3KZq8+zorFHCJC29tt6RDnqELIcO9K15I9hLgnImbJ/UG4neikrKpEvw3Jv2Wu32LIjzwgC3rqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418833; c=relaxed/simple;
	bh=ibuxcH9X0KJd9ISnHUuuoisGxnAvgdnrSWtBco98quk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfnTxzBAw+Ze/BIMh730WdvuWFm7EKmzfW2gJkYwfGgc7OTT3bTk63U7nhxXgYi7j140lngh5k7bRMYqTaK1tnoDXxzj3GsG3Ir0L+yr9YOLzdlOd1qFXqEba1uo2B5hcW0bbVqC+Bwd6HXfK/glCX1NNA4OgPaFnWBKZ5TsFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+aW88um; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e152731d0so2000378e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733418828; x=1734023628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7/aYzJxX31d++q2E25pi18VA+QiD6xbJwhkvq0pjg=;
        b=i+aW88ume3k1pjm7MTasb6MvsXWJ5zIjseR0ad3xz1rJ85p2Rs8Q5XYYlKf+5f6Y78
         1EPzMScw+gNW1+A4N+0cAjS9jbVwmZMfH0pel2H+IZA408ti8+hS9tswWo9tPaaY/rig
         UpoOgfZe0MIEgqTTjV0rP0mjKnAyZ2iotah0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418828; x=1734023628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u7/aYzJxX31d++q2E25pi18VA+QiD6xbJwhkvq0pjg=;
        b=gXacvB2y4GmfpPmjrTBHh/WGhnqJvAdZL+RCHlhEmyzbaXQ7kV5Ujw441xx5V7ABf0
         F6xc7aETIQb9x4jefVKCs42LpbkHsJawYylTpQWfFFLsXaJuiXhXaXpYP5WAojaYYDkj
         XqjQK0sex+4heEQIDGPReXoTdhLWbA3/YkXdwiycU/J6/GZ3a0kAI99gLxhAnGtkzJZH
         5RVQ/ZW11KnSCXbMHMgkMzzOYLwq38Y73i0pLIIC4xlcGvVCJSWFj7OXYYlGErAQNmJ2
         sOeQskew1BQnSF1Eu/+3oqUX1zg8/mySowoizPk/SpWqLcdQLLq6eO8eD55e44SEjbTs
         0E4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOKe41lcFur4hyA32XK4rsg9FyKH2U9M5yowbx8gZaazmOC5YT8IR1/pznm4IDIyIwbf0YSbvAhE5qSp/Z8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8GI+A6uamFs4kxzukNHr4Ms2UawIZRqN40lncD0pMerbzvoA
	BjgYOrKaHWpkIcOLYfBTrXcY/oLZCLgl0XpEzcl45yHSAFgUYGHmr2B03OER6epqHeqZqixP4my
	t+JyW
X-Gm-Gg: ASbGncscRV2Mg3sGDIs2m9JPRWPN+1Wz9N1K2acOIDN824ZcUdSoE0Ht/GqeQ5DyW/3
	i1VDOxDGkvu/JqeLLtZ37IQovJroiWJupY1TrtchNiM2Gm7FwZrWZVLWM/+yeUnCjrVOJ2VAuYz
	EP9DNCNrEKQiFSfEA0hg+r9NfmoQzJq2+8/FktX+6tNmqsXieOCJOgoTdTJe1M0FVuOeSitwOLL
	ONnsbe31Voj8OGO0FppOew0wb11PLkc8kZE/KGrE2KOyTtEetl2BS92isNtdcIL+OnuRu4H/nxw
	pxxmmOkU1lcLRw==
X-Google-Smtp-Source: AGHT+IEU/vSrXQLJMwq/TZNGRiUUfbogR0Z369WeuoB9u3l7jxky29AhV7QjlN9ryLP740h4Ku97xA==
X-Received: by 2002:a05:6512:31c9:b0:53d:f786:c364 with SMTP id 2adb3069b0e04-53e2b73259cmr39768e87.19.1733418828301;
        Thu, 05 Dec 2024 09:13:48 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947254sm294266e87.34.2024.12.05.09.13.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:13:47 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e203d77a9so1066073e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 09:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBaFsEQKDjMZS5LhNCrhqraoAs3e+tPSdmaYEmi8s5llsk3EBM5DmiesRm01Yr24fjKAmOS7xCcM3+z1Ntpw==@vger.kernel.org
X-Received: by 2002:a05:6512:23a7:b0:53e:1c46:e01d with SMTP id
 2adb3069b0e04-53e219159cdmr1448759e87.19.1733418826029; Thu, 05 Dec 2024
 09:13:46 -0800 (PST)
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
 <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com> <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
In-Reply-To: <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 5 Dec 2024 09:13:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
Message-ID: <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 5, 2024 at 5:46=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Hi Doug,
>
> On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromium.=
org> wrote:
> > >
> > > > > >  Can you try testing (and gather timing numbers) when
> > > > > > suspending soon after initiating scans? It's hard to judge what=
 the
> > > > > > lower limit of this timeout should really be without any number=
s, just
> > > > > > like it's hard to judge whether your 10 second watchdog is reas=
onable.
> > > > >
> > > > > Pin-yen: is this something you could gather?
> > >
> > > I tried entering suspend right after wifi scans, and the time spent i=
n
> > > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > > suspend does not increase the execution time for mwifiex_enable_hs(),
> > > so I think the driver is capable of interrupting a scan.
> > > > >
> > > > >
> > > > > > Also, for the record, since we might have to field regression r=
eports
> > > > > > for other systems: what hardware (chip variant, FW version) are=
 you
> > > > > > seeing problems on?
> > > > >
> > > > > Pin-yen: I'm assuming you'll provide this.
> > >
> > > From the debugfs entry:
> > >
> > > driver_name =3D "mwifiex"
> > > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> > >
> > > The compatible string of the DT is "marvell,sd8897".
> > > >
> > > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to pr=
ovide
> > > > the above to provide a little more confidence, or if you want to
> > > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> > >
> > > It looks okay to me to decrease the timeout here given that scanning
> > > doesn't seem to affect the suspend time. What's your thought, Doug?
> >
> > I think Brian is right and that we should change how we're using the
> > DPM watchdog, but IMO that doesn't mean that we couldn't also change
> > this timeout.
> >
> > If nothing else, you'd want to post a v2 of your patch containing a
> > summary of the info you've gathered so it's recorded with the patch.
> >
> > Maybe what makes the most sense, though, is to put our money where our
> > mouth is and land some sort of patch in the ChromeOS tree and then
> > report back to upstream in a month when we have data about it. If
> > things look good in the field then presumably that would give some
> > confidence for upstream to be willing to land the patch?
> >
> > Probably about the best data we could gather would be to break the
> > existing timeout into two halves. You could wait half the time, then
> > print a warning, and then wait the other half the time. We could even
> > land that change _without_ changing the timeout to 5 seconds. Then if
> > we ever see the warning print but then the suspend succeeds we know
> > that there are cases where waiting longer would have helped. If we
> > made that a WARN_ON() our existing infrastructure would help us gather
> > that info...
>
> I just realized that mwifiex_wait_queue_complete() has another 12s
> timeout[1], though they are not directly involved in suspend/resume.
>
> Should we also add a warning to that and see if we can make it half?
> This starts to make me think how many timeouts we want to consider.
> Does it make sense to only focus on the one in mwifiex_enable_hs()? Or
> should we check other timeouts in mwifiex or even other drivers?
>
> [1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wireless=
/marvell/mwifiex/sta_ioctl.c#L51

IMO any of these "arbitrary and really long timeout to make sure we
don't hang forever" type things probably should have a warning so we
know if we're getting close to the timeout. It wouldn't be very hard
to make a wrapper around wait_event_interruptible_timeout() to handle
this. I suppose that wrapper could just be local to mwifiex, though if
other drivers found it useful it would make sense to put it somewhere
more common.

That being said, if we aren't actually hitting these other timeouts I
don't know that we need to do an extensive audit right now to find
every one of them.

Of course, Brian also said he'd be OK with just setting the timeout to
5 seconds based on the research you've already done. In that case I
don't know if we'd want a WARNing after 2.5 seconds. Maybe? 2.5
seconds is still pretty long, but I don't know if it's WARN-worthy. It
could at least be dev_warn() worthy...



-Doug

