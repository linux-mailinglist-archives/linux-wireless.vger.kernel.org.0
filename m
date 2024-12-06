Return-Path: <linux-wireless+bounces-15967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D169E6D38
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3A828357F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A81D2F74;
	Fri,  6 Dec 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+TDjUMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B861DA61E
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484114; cv=none; b=UXE8qiATIjGcrhdOXhNzSmqGF5gGX0PG1Q9NGHF+SB6++EcvidxJTbw1iHijwJdGmAcm+B9ZSZdCKW6J76q8KGyGBSFWFtH0dcE//6BWA/yPNMKd8elsbFs/Zya45QTyeHebV7SHUu9gBrHZuXM3kc2mM4te2xPtQYIvGQh1+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484114; c=relaxed/simple;
	bh=JOVrPFDobmDS4Will9BL7O2tswVQbUHxNJGI9/i5TU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdG8Ge16krAC5pXeP0SfBQAO7pMfpoeZCSQTksxX1VtUHMKRlNt7vuSZdyRDtmj30DXdj0AKoKg3yJFZTy6TkFO9+uXPtN+geUSIvuLpmB+evZpQtf2+yMwgB0pIpyy5CNZaowTwd57tD01Y/FfuYpDgc/GCufs2C/dFhNGx+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G+TDjUMI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d4c462ab1so451591a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733484111; x=1734088911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzC1e4teCdFBLzoPu7P0P5xRQQZ7w73jOzXQqSGBZMg=;
        b=G+TDjUMI688dWgSRe7oMca9AL8N0CDXNNV9PIsA7SA4Q2Dh5PTki8lPye+S1uvshIF
         /c+zy6ChGJ24JrpkKGygifGnDIvjaEmHGhIl1tAS41A3x49u8glgc2F7p95xVfDQx1be
         libYqXpuZddg9KknKZQT9fjd+GdT3mPTNqazM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733484111; x=1734088911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzC1e4teCdFBLzoPu7P0P5xRQQZ7w73jOzXQqSGBZMg=;
        b=kuYNuVa4cwgbUWOxcao2QekUEIpME4gQyx1i5AcJ5VUEH3U4+ZQ4v/VPSrMNJumr0J
         MfyKCkWthaVKUFspZ8DxD3RDoIrbvg59wHbMZedpmoabHuuybjw+FvUDFtoZuYIaOx23
         +cY4VqVRH63fd52fmB9nt58/roGYLaF3AAo1MHI/VkmMzdCGhn2c/RwjBUfiT+9MIRh/
         6Vf47dLyoVL6XZySFDE0kHlz3cctEusgo3jL+BWU5ixuPutgUIdrufXmC7/4X5scaCT7
         AlR3hLXjBTo2tD4SlYO4CzqvXkXUqtYaiZFB2W/OM8XZ7nNjfffBif5L3mzYOCLR4qHu
         VRBA==
X-Forwarded-Encrypted: i=1; AJvYcCXYO58DWMTVxhvXSOtNH/sy6E7u0pBb50EZXkNiYD5qdYapurj0Oa8iitXvQqWX/U/4qvI3fuUBYb3aDioFXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnovGoNWWLbQw1NyC/1tM59J+QRD+H/IkNiYWj5SfWKn8tT4C
	CkTFuxee34cG8hYpxf2hs/Fj1sdWYqT6LqV/81SfWAylyzq20DVxRqtIVKn/spa00wnAnkSz7fr
	8REK6WM7jZZc/VutLfF+jpSpD9EaQWvKkDW8S
X-Gm-Gg: ASbGncsy3rf+tAJmb0No5nuvHvxVvwmBxIOijhgQiH1vCnGJ3pYNimE4aK6zN8ZkV/7
	ajODrahL3g739A0ZHY/Dr0X4NjwjZQ9gdtK9e5j+cMSpK+GizYgVNjCghwr2IvA39sA==
X-Google-Smtp-Source: AGHT+IEqM064ODaYIcbwkEvw943cAB8MaZqynHzMcodkpkM4ZpwbUg3AM6ND6qICmW1S7dG2Lbi6/ezcGS38bLFNrRg=
X-Received: by 2002:a05:6830:9c7:b0:71d:4d3b:bdb9 with SMTP id
 46e09a7af769-71dcf565bbemr1167225a34.30.1733484111452; Fri, 06 Dec 2024
 03:21:51 -0800 (PST)
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
 <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com> <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
In-Reply-To: <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 6 Dec 2024 19:21:40 +0800
Message-ID: <CAEXTbpe6D_pwLP6+0Kv-n7KMRoOn-_CWdZygMz0yK1fFuC-2Bg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Doug Anderson <dianders@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Fri, Dec 6, 2024 at 1:13=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Dec 5, 2024 at 5:46=E2=80=AFAM Pin-yen Lin <treapking@chromium.or=
g> wrote:
> >
> > Hi Doug,
> >
> > On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromiu=
m.org> wrote:
> > > >
> > > > > > >  Can you try testing (and gather timing numbers) when
> > > > > > > suspending soon after initiating scans? It's hard to judge wh=
at the
> > > > > > > lower limit of this timeout should really be without any numb=
ers, just
> > > > > > > like it's hard to judge whether your 10 second watchdog is re=
asonable.
> > > > > >
> > > > > > Pin-yen: is this something you could gather?
> > > >
> > > > I tried entering suspend right after wifi scans, and the time spent=
 in
> > > > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > > > suspend does not increase the execution time for mwifiex_enable_hs(=
),
> > > > so I think the driver is capable of interrupting a scan.
> > > > > >
> > > > > >
> > > > > > > Also, for the record, since we might have to field regression=
 reports
> > > > > > > for other systems: what hardware (chip variant, FW version) a=
re you
> > > > > > > seeing problems on?
> > > > > >
> > > > > > Pin-yen: I'm assuming you'll provide this.
> > > >
> > > > From the debugfs entry:
> > > >
> > > > driver_name =3D "mwifiex"
> > > > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > > > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> > > >
> > > > The compatible string of the DT is "marvell,sd8897".
> > > > >
> > > > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to =
provide
> > > > > the above to provide a little more confidence, or if you want to
> > > > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> > > >
> > > > It looks okay to me to decrease the timeout here given that scannin=
g
> > > > doesn't seem to affect the suspend time. What's your thought, Doug?
> > >
> > > I think Brian is right and that we should change how we're using the
> > > DPM watchdog, but IMO that doesn't mean that we couldn't also change
> > > this timeout.
> > >
> > > If nothing else, you'd want to post a v2 of your patch containing a
> > > summary of the info you've gathered so it's recorded with the patch.
> > >
> > > Maybe what makes the most sense, though, is to put our money where ou=
r
> > > mouth is and land some sort of patch in the ChromeOS tree and then
> > > report back to upstream in a month when we have data about it. If
> > > things look good in the field then presumably that would give some
> > > confidence for upstream to be willing to land the patch?
> > >
> > > Probably about the best data we could gather would be to break the
> > > existing timeout into two halves. You could wait half the time, then
> > > print a warning, and then wait the other half the time. We could even
> > > land that change _without_ changing the timeout to 5 seconds. Then if
> > > we ever see the warning print but then the suspend succeeds we know
> > > that there are cases where waiting longer would have helped. If we
> > > made that a WARN_ON() our existing infrastructure would help us gathe=
r
> > > that info...
> >
> > I just realized that mwifiex_wait_queue_complete() has another 12s
> > timeout[1], though they are not directly involved in suspend/resume.
> >
> > Should we also add a warning to that and see if we can make it half?
> > This starts to make me think how many timeouts we want to consider.
> > Does it make sense to only focus on the one in mwifiex_enable_hs()? Or
> > should we check other timeouts in mwifiex or even other drivers?
> >
> > [1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wirele=
ss/marvell/mwifiex/sta_ioctl.c#L51
>
> IMO any of these "arbitrary and really long timeout to make sure we
> don't hang forever" type things probably should have a warning so we
> know if we're getting close to the timeout. It wouldn't be very hard
> to make a wrapper around wait_event_interruptible_timeout() to handle
> this. I suppose that wrapper could just be local to mwifiex, though if
> other drivers found it useful it would make sense to put it somewhere
> more common.
>
> That being said, if we aren't actually hitting these other timeouts I
> don't know that we need to do an extensive audit right now to find
> every one of them.
>
> Of course, Brian also said he'd be OK with just setting the timeout to
> 5 seconds based on the research you've already done. In that case I
> don't know if we'd want a WARNing after 2.5 seconds. Maybe? 2.5
> seconds is still pretty long, but I don't know if it's WARN-worthy. It
> could at least be dev_warn() worthy...
>

Sounds like we will start to binary search the timeout...

Then, I would like to just send out a v2 for this with an updated
commit message. It sounds like it will be endless binary searches on
all those timeouts in the kernel if we really want to create a wrapper
around wait_event_interruptible_timeout(), and all the efforts only
make us a few more seconds faster on the system.
>
>
> -Doug

Regards,
Pin-yen

