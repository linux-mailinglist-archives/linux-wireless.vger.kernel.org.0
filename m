Return-Path: <linux-wireless+bounces-15902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7C9E4310
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C005164CDC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51F23918D;
	Wed,  4 Dec 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lV/9RFGW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B814287
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335920; cv=none; b=Pt6xkwt26O09ZWkTlApK+GNNq8/Jc02Y+m2dSNZCVkLIo+CHKoah8jZ0wFRZAhvgjiQycdnakIF78E+tBdurEjsaoGFhwYI8P6EDy1u3N2PjNfnm6ffJc33HkNcocjO+K+bL63uv7ujDb79Y0AHqLfFYC78QIAwh3ENL2CdkTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335920; c=relaxed/simple;
	bh=v+jzv8rPT2WHY9B4GsJV0qYrOODUfu3q72gGtG6Qe4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppPqYnL8DM6y1cxnCHv8Q9/Z1e3CZeIsj4//voNSRpsJKE1MvS1ib2s9NWBHxQ2dYvJdiAZLWm2LHcHja63zfJZfRJ3gna00buPibsVsegnblmrpPf6kZxUmtdclJwxA/FXYp/I5EePuis4BzHCy1RJ3J0AqS1vxPfkKbUUn/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lV/9RFGW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de79c2be4so80039e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2024 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733335916; x=1733940716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7xszK3WQnOZZ7Fj6nqT0zzAPzoP0+KMKEdCaulS0QI=;
        b=lV/9RFGWgh7jpbJVYAVyv+UWUdWzlHqz+eJ6yZNhI+OwgcSBceCb1SHv56Wj1AdsPX
         gCNgKC+IKQp0Omn3cJIAvUYgFL8ItclUmU6T9DGN2NNNzXqXIespROh8eKEaAn8R8bBf
         YCCZpB8B52/dloSx+zVX7KKVXixZ95LrnoS3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335916; x=1733940716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7xszK3WQnOZZ7Fj6nqT0zzAPzoP0+KMKEdCaulS0QI=;
        b=Dh9kBDW4aJEg3Y7Z6z9TnVE010qo/q1HcdEuB90VuNQo6lqgctETlS1G/vZcLNfYMK
         clksUvslPIEH50gMLinOQ7/ETUKy9i3UbXWFRL7Q9hMNl4bdVzrlNB+hz7Ms5ilGfPDK
         WdCAznmdoVHxXgXrOGr9TWc9ffKmDZXNWaxW9USOZRt9CNhR+V66vi3853yFDs6xNMcX
         57PHSTmppEcOoYxr3ZWALef7EShZuTW+GU5IlkKycjSBlkTFUevRn+V21kRJWkMqwjhD
         /vlAis7f3Hp/cJxudoMNXK6oiLvBcwWPu6CRwRHANqGdHu/TDpUC0YYCFs+hWz29OAGP
         EvNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIfF4KDIm5Kn+5w8psH06P2BqMKFO/4t5AseamhxXFJkWOpVpQOezzSvsCeOKzS8RxdsyplDbjR0Rq10sKfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6z6Fx2TRCjuE4xxLjziuhpCoxugE5H2/zpED/N09TwGIR7rdD
	Pkf9+gn79qV6Hi9BJMrYu0VdIHEUK/Pp50N0PH2XGnwGHdsd44Low7WK2skDpXdznfWUNOWP4J2
	qboXR
X-Gm-Gg: ASbGncuWU5h+J13VJ6n+mQcxXNChDQkXAgZWHBb88UbMMNI96pO10dA+c0xj1UJ1MeN
	+aq9+utJlIQA57GZjKg1qjoQzlMVRc0uSfum5Uvy8D30eCwaqDSzVxmHBcsDEKnloBNP0csuWX3
	9AMCn1vvMH96pj5MpBuuzRonGL4Ogi2R67WJRSI0mYSvp6QiagIpJ2Zrw+PUgu+nXz66RxqFLIx
	XOkil6bpBXLOTVWNgyloPB5z/ZMFOTdrPiCpcOFCOqySAz9v4YVEesNkkxyhh9e00PYTAXfa/RV
	PFkrHOLdZ5tfAg==
X-Google-Smtp-Source: AGHT+IGbGkmsZ1TKXWwaEXr/gJaxj8C6fCesBW1MJDwy5JUx78VH+YObvb4ic8EvgBNS5WZW8A+Gaw==
X-Received: by 2002:a05:6512:12cd:b0:53d:d467:3aa1 with SMTP id 2adb3069b0e04-53e12a26357mr4341303e87.40.1733335916437;
        Wed, 04 Dec 2024 10:11:56 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e167a08e7sm607480e87.255.2024.12.04.10.11.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:11:55 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ded167ae3so99580e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2024 10:11:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Yh58U5QhtrW97mQfG3wia2+xUKpEQHTDkx0AOOhgHj7Gk70VKyRXFmpq8CCKe1x2bQynPI68Pq7I5BGMYw==@vger.kernel.org
X-Received: by 2002:a05:6512:2395:b0:53d:e6c3:368c with SMTP id
 2adb3069b0e04-53e12a0595emr4365550e87.32.1733335915171; Wed, 04 Dec 2024
 10:11:55 -0800 (PST)
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
In-Reply-To: <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 10:11:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
Message-ID: <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> > > >  Can you try testing (and gather timing numbers) when
> > > > suspending soon after initiating scans? It's hard to judge what the
> > > > lower limit of this timeout should really be without any numbers, j=
ust
> > > > like it's hard to judge whether your 10 second watchdog is reasonab=
le.
> > >
> > > Pin-yen: is this something you could gather?
>
> I tried entering suspend right after wifi scans, and the time spent in
> mwifiex_enable_hs() is always around 100ms. It seems initiating
> suspend does not increase the execution time for mwifiex_enable_hs(),
> so I think the driver is capable of interrupting a scan.
> > >
> > >
> > > > Also, for the record, since we might have to field regression repor=
ts
> > > > for other systems: what hardware (chip variant, FW version) are you
> > > > seeing problems on?
> > >
> > > Pin-yen: I'm assuming you'll provide this.
>
> From the debugfs entry:
>
> driver_name =3D "mwifiex"
> driver_version =3D mwifiex 1.0 (15.68.19.p54)
> verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
>
> The compatible string of the DT is "marvell,sd8897".
> >
> > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to provid=
e
> > the above to provide a little more confidence, or if you want to
> > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
>
> It looks okay to me to decrease the timeout here given that scanning
> doesn't seem to affect the suspend time. What's your thought, Doug?

I think Brian is right and that we should change how we're using the
DPM watchdog, but IMO that doesn't mean that we couldn't also change
this timeout.

If nothing else, you'd want to post a v2 of your patch containing a
summary of the info you've gathered so it's recorded with the patch.

Maybe what makes the most sense, though, is to put our money where our
mouth is and land some sort of patch in the ChromeOS tree and then
report back to upstream in a month when we have data about it. If
things look good in the field then presumably that would give some
confidence for upstream to be willing to land the patch?

Probably about the best data we could gather would be to break the
existing timeout into two halves. You could wait half the time, then
print a warning, and then wait the other half the time. We could even
land that change _without_ changing the timeout to 5 seconds. Then if
we ever see the warning print but then the suspend succeeds we know
that there are cases where waiting longer would have helped. If we
made that a WARN_ON() our existing infrastructure would help us gather
that info...

...so I guess summarizing my rambling, a good plan would be:

1. Change the ChromeOS DPM watchdog timeout to 15 seconds to avoid the
problem for now.

2. Land a patch to do a WARN_ON() in mwifiex if we take 5 seconds.
Actually, you could (probably) send this upstream and land it
FROMLIST?

3. Wait ~1-2 months and see if we ever see the WARN_ON() trigger but
then things succeed after 10 seconds. If this never happens then send
a v2 patch changing the timeout to 5 seconds with details in the
commit message.

4. In the background, see if we can convince folks to make the DPM
Watchdog less panicky.


-Doug

