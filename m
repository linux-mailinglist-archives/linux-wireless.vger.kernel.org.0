Return-Path: <linux-wireless+bounces-15981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A909E752E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2172B168369
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13C20E012;
	Fri,  6 Dec 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7c5bbwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9AB20C499
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501410; cv=none; b=RoU+3zZAJpZzcETaIky5jFNcRjEqa1RRE+JAIKNO52VWwaChzHhgyUW7tOXEkqB6bLu/P7/edGMNCg/UYaOD64EbDgnuWvTH4pd4vFwdMjU4YmO4t3rA0I6nVL8PWIIZqQMOKdo4Ry14YJC4W6hAGNd73/Xd1lJspRuRAPBNrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501410; c=relaxed/simple;
	bh=qP4Qp4bh1qTT1DSw+QNkGJJNNeSk5RrKVW7zhsAqXGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyYh4YyAAXsOzhpzqdOZeU4TavUMoKQ9kOWZEiVbTZpS7rT9qx85TlFlRT1qYkfjaKD1eKBlFov4FNnbn3AlvYDeXj06Pe8/CgFfPUda5PHLZkODsMvCJqbRkJL/1Xf1VMTRQTTtxahA9rysipr6N6UMuawl894R6aUMGlAP8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7c5bbwl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30024c73101so18442761fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501404; x=1734106204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evhoGFFNxGHGM5vTtdZWp63JejZrYFIpqAu47USQhSs=;
        b=l7c5bbwl285agEgolx/u7Oq5UR6ZAArU0REQAJuCMaOxqYnKkeYVv+yEroaYsaPgNG
         JqcnoUL7fveYDLgbNaCUOdZgGfBjv5Zm+wsvIwmEy8Cu61HLIOcoNkQo8bLCrbrvIpCB
         a1CM2lXC2NZQGFE3kyITR2NP4F1Fk1g0Vo1Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501404; x=1734106204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evhoGFFNxGHGM5vTtdZWp63JejZrYFIpqAu47USQhSs=;
        b=JVbcYxBcf0/jiNLPfe6Csd6gBzmHV4Z7IEVboa8Ik7DIkWObs63664IFUYYnPFYUcz
         YtmQwybsiG9gUXt63DZfOgO5ousL3sdDt9GTWQPF7P8b9xir1Waxw3nW9Py6WjKKpiZl
         GZvOj6Qanw9hOvNyLmJn9zoBVVaoI6nT7B865Gzevv0pBvWNxrR0zdO90E++hgc7Nlm9
         swvE0AA9B4T26f7+Q5FduXI1eWjOHZxVychqt/f+wiqnTCoS9fGnS0hLasbWW1V2Biy8
         IEZSRTYpH2x0+PLbUz0tRljs1vQqBUJ7Y+j5M6WCzklHzbeMnvmB1+ScNuq7qcbt3cW5
         GpHw==
X-Forwarded-Encrypted: i=1; AJvYcCXBVB5cU81fNv2l7/hNonRf7RnmlP+6M2etmoqKXgsTEP2L4Tdg+15TOxuVIPuBiqHtcu6DcgRHLqJWomqSoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+c1DtItr1MngT4R2a3REIu46rJBPgKtLwO/cTgcUK453fdit
	j4VHZeGsPosOgnfJnr8ignM/tLkQ9lrcRKqcqQq75V1FD9tye5DyPfDmx9p1ZC+yPsadnActWMM
	t7g==
X-Gm-Gg: ASbGncvb/otBFIVYwpBHzUDP3sMwrSbJnYb326zy77PUPqAAd33Hpglo0P4WM8sbY64
	+/2Yz4tZkfxuOFLx+c9z7XraMq1DzllajcBTbBILGf/wg7Gj8zqwWDpMMGs92SpZMZd6IZUhbbh
	qfXaJ1Nh8438LgGAOxltbIhLNNAkOnxpWgR5uiCzKBuM/UYdRdS6Ptjg7kAQPVELDmUHU1ckM/7
	yv0S3AyvitbchwO//AJcPeNg+Nettr5CzyLemtyGmmRe4yPE3R9xn3DAzY4cKbzWLf2h0A3ZtNf
	BCL82DIEE57v0fTiaQ==
X-Google-Smtp-Source: AGHT+IG7DiJZZUe5yFxF/1MeBrB3vIyzwnrWA9zW/R7O4l6BYtW1nBh5G+VMDBM1zgMvORsekCDXFg==
X-Received: by 2002:a2e:ab09:0:b0:2ff:c080:e4a with SMTP id 38308e7fff4ca-3002dee598dmr14381621fa.18.1733501403877;
        Fri, 06 Dec 2024 08:10:03 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3003e2c2f35sm110861fa.15.2024.12.06.08.10.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:10:02 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30020d33d05so19068461fa.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 08:10:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhzHDA15Vr0+8A9716E3q+vtwDy6VdpA1W7q+RZlcWl3Z/AkL0sDNS0UIy0poqMOGRWktbO5nAvvN+S0b5xQ==@vger.kernel.org
X-Received: by 2002:a05:651c:1989:b0:2ff:de64:c44f with SMTP id
 38308e7fff4ca-3001ea99114mr28307711fa.1.1733501401123; Fri, 06 Dec 2024
 08:10:01 -0800 (PST)
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
 <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
 <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com> <CAEXTbpe6D_pwLP6+0Kv-n7KMRoOn-_CWdZygMz0yK1fFuC-2Bg@mail.gmail.com>
In-Reply-To: <CAEXTbpe6D_pwLP6+0Kv-n7KMRoOn-_CWdZygMz0yK1fFuC-2Bg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Dec 2024 08:09:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0TVVJxPL3sy=xBKc72UaH0iGy5+v+oyQ0b36BXnZXDg@mail.gmail.com>
X-Gm-Features: AZHOrDnI3cm66ZbE3sqwU13dD4W7vLG00hftJO3dJkhsNpY7o59HJ2o11-rUdJc
Message-ID: <CAD=FV=U0TVVJxPL3sy=xBKc72UaH0iGy5+v+oyQ0b36BXnZXDg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 6, 2024 at 3:21=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Hi Doug,
>
> On Fri, Dec 6, 2024 at 1:13=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 5, 2024 at 5:46=E2=80=AFAM Pin-yen Lin <treapking@chromium.=
org> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromi=
um.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chrom=
ium.org> wrote:
> > > > >
> > > > > > > >  Can you try testing (and gather timing numbers) when
> > > > > > > > suspending soon after initiating scans? It's hard to judge =
what the
> > > > > > > > lower limit of this timeout should really be without any nu=
mbers, just
> > > > > > > > like it's hard to judge whether your 10 second watchdog is =
reasonable.
> > > > > > >
> > > > > > > Pin-yen: is this something you could gather?
> > > > >
> > > > > I tried entering suspend right after wifi scans, and the time spe=
nt in
> > > > > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > > > > suspend does not increase the execution time for mwifiex_enable_h=
s(),
> > > > > so I think the driver is capable of interrupting a scan.
> > > > > > >
> > > > > > >
> > > > > > > > Also, for the record, since we might have to field regressi=
on reports
> > > > > > > > for other systems: what hardware (chip variant, FW version)=
 are you
> > > > > > > > seeing problems on?
> > > > > > >
> > > > > > > Pin-yen: I'm assuming you'll provide this.
> > > > >
> > > > > From the debugfs entry:
> > > > >
> > > > > driver_name =3D "mwifiex"
> > > > > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > > > > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> > > > >
> > > > > The compatible string of the DT is "marvell,sd8897".
> > > > > >
> > > > > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want t=
o provide
> > > > > > the above to provide a little more confidence, or if you want t=
o
> > > > > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> > > > >
> > > > > It looks okay to me to decrease the timeout here given that scann=
ing
> > > > > doesn't seem to affect the suspend time. What's your thought, Dou=
g?
> > > >
> > > > I think Brian is right and that we should change how we're using th=
e
> > > > DPM watchdog, but IMO that doesn't mean that we couldn't also chang=
e
> > > > this timeout.
> > > >
> > > > If nothing else, you'd want to post a v2 of your patch containing a
> > > > summary of the info you've gathered so it's recorded with the patch=
.
> > > >
> > > > Maybe what makes the most sense, though, is to put our money where =
our
> > > > mouth is and land some sort of patch in the ChromeOS tree and then
> > > > report back to upstream in a month when we have data about it. If
> > > > things look good in the field then presumably that would give some
> > > > confidence for upstream to be willing to land the patch?
> > > >
> > > > Probably about the best data we could gather would be to break the
> > > > existing timeout into two halves. You could wait half the time, the=
n
> > > > print a warning, and then wait the other half the time. We could ev=
en
> > > > land that change _without_ changing the timeout to 5 seconds. Then =
if
> > > > we ever see the warning print but then the suspend succeeds we know
> > > > that there are cases where waiting longer would have helped. If we
> > > > made that a WARN_ON() our existing infrastructure would help us gat=
her
> > > > that info...
> > >
> > > I just realized that mwifiex_wait_queue_complete() has another 12s
> > > timeout[1], though they are not directly involved in suspend/resume.
> > >
> > > Should we also add a warning to that and see if we can make it half?
> > > This starts to make me think how many timeouts we want to consider.
> > > Does it make sense to only focus on the one in mwifiex_enable_hs()? O=
r
> > > should we check other timeouts in mwifiex or even other drivers?
> > >
> > > [1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wire=
less/marvell/mwifiex/sta_ioctl.c#L51
> >
> > IMO any of these "arbitrary and really long timeout to make sure we
> > don't hang forever" type things probably should have a warning so we
> > know if we're getting close to the timeout. It wouldn't be very hard
> > to make a wrapper around wait_event_interruptible_timeout() to handle
> > this. I suppose that wrapper could just be local to mwifiex, though if
> > other drivers found it useful it would make sense to put it somewhere
> > more common.
> >
> > That being said, if we aren't actually hitting these other timeouts I
> > don't know that we need to do an extensive audit right now to find
> > every one of them.
> >
> > Of course, Brian also said he'd be OK with just setting the timeout to
> > 5 seconds based on the research you've already done. In that case I
> > don't know if we'd want a WARNing after 2.5 seconds. Maybe? 2.5
> > seconds is still pretty long, but I don't know if it's WARN-worthy. It
> > could at least be dev_warn() worthy...
> >
>
> Sounds like we will start to binary search the timeout...

I wouldn't bother binary searching the timeout and in general I
wouldn't try to tune these timeouts unless we think there's a real
benefit to it. Mostly, though, I like the idea of having a warning
_before_ a failure occurs. Like if I have a retry loop that will retry
10 times, I like to warn after I need 5 retries so that it's obvious
we're getting close. If I expect a timeout to never be needed, I'd
also like some warning that says we got close to the maximum timeout.
All of this makes it much easier to debug problems if/when we actually
hit the failure case. It also has the benefit that if we need to tune
a timeout / number of retries then we have more confidence that we
were nowhere near the max, but IMO that wouldn't be the primary
benefit.


> Then, I would like to just send out a v2 for this with an updated
> commit message.

Sure, though maybe it's not urgent? We've changed the DPM watchdog in
ChromeOS to 15 seconds so at least we won't be hitting it there. While
I agree that the 10 second timeout is still likely overkill and that 5
should be fine, gathering more data wouldn't hurt.

I'd be really curious how the system behaves after the timeout hits,
too. Does the next suspend actually succeed? Does WiFi recover or is
it busted until the next reboot?


> It sounds like it will be endless binary searches on
> all those timeouts in the kernel if we really want to create a wrapper
> around wait_event_interruptible_timeout(), and all the efforts only
> make us a few more seconds faster on the system.

My goal in general isn't to optimize the system but to know when we're
close to failure so it's easier to debug when the timeout occurs.

