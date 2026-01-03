Return-Path: <linux-wireless+bounces-30309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396ACEFBF5
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 08:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C30300484C
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E523741;
	Sat,  3 Jan 2026 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I726se6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F471E531
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767424221; cv=none; b=M8CNS/M6Q+/oebCq8svvx5zDSNlJ/BNxHUZ78TgL86Dk4t631FZktoVKRyOcJg70hD3k2fBAfTW0SMjMv7SvQEZQvfhdIv8BD0CQAiS7Kg9yZS5EwLeBiqNj/COohpFdeNjj3bHnDo/BIyn3X3oNVV8204cyj3HHwdN+jg6NQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767424221; c=relaxed/simple;
	bh=cqQ3Cp1O3S78fDBVt2ieQB0dIcnwI/x9ci0fd5b2ZIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANWa+TprOplM9RSw2iT9zP+iTnHNxnJR0nQnd2wz0C4Ls3tDnLglflprTTFcnOwXxhjCb6IO6WyImRYIC6ARboYlBsZz2A4JxndLBRylyEHRKKNDQtqjhfx2adoarD9W4GOiw58KjONxpnt+piUCzUnCK3226hlQ2cnk1aiRhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I726se6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BDC116C6
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767424221;
	bh=cqQ3Cp1O3S78fDBVt2ieQB0dIcnwI/x9ci0fd5b2ZIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I726se6gb9jAe0Dk55FyYohwJuGhFs503/+HR8sPxUF0UEJXdh4Jda7gLfobEMqRe
	 FtajRwO6MDtgzj9NVW9Du+keQjdJbGmEuV3SzAAtki1Yl0R9cMWOiTU4hcT9ob/9th
	 Fvlqb44ucZAcpq3ANgvdYuhatbRAAWu8vvurv4lIU3UPpCScR36aMlV6EBQggMuoUJ
	 QI4a/tC2MHNWxhn6aLhEWqLx9eVAdbZx65H1V39OdJoGojNzYJH0EW/Zas44SQ/kJw
	 kMSUnjoeMhj9BHCZq1sKJspjdwwZoksjR7PFAeHzA94c6iRLA2n/v0hZ8pjzpZaqwk
	 KhrnrJYXjvjNA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38107fadda2so95269891fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 23:10:21 -0800 (PST)
X-Gm-Message-State: AOJu0Ywk1fY6J+3+8bQo7JXZ4LFwUwH+8rpngG+I+aq4e/IXlJPo8dkP
	62UkCsu0Uj2cuKGqh3YxNavzUQYPNE8X0D8EDwLkKy0dTOL/weWZA5OpNCMIEK8om9Em6oi041K
	2mEEp15uTVaxxla7uZO68d3iisefmKro=
X-Google-Smtp-Source: AGHT+IE0nGGSLOvtWi3wYMudd4eQi2SCOp37ehar+JWrgj4Bh8xrmqdXDfKKZoIc+upGr9gbToaLzXHY+TkEKQw3i7E=
X-Received: by 2002:a2e:a54b:0:b0:36b:9ecc:cb36 with SMTP id
 38308e7fff4ca-381216350d6mr154785091fa.23.1767424219578; Fri, 02 Jan 2026
 23:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4870974.vXUDI8C0e8@fedora.fritz.box>
In-Reply-To: <4870974.vXUDI8C0e8@fedora.fritz.box>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 3 Jan 2026 01:10:08 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
X-Gm-Features: AQt7F2pG8y8xzlHaDwCnenEXUCXo0F5MNVqMpSOh_g6zCO_j7HeTk1xd1I8nsRs
Message-ID: <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
Subject: Re: mt7921e: repeated driver own failures cause hanging
To: moosager90 <moosager90@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi moosager90,

Could you please share more details on how this issue can be
reproduced? For example, does it occur after suspend/resume, under
heavy traffic, or during normal runtime? Also, please confirm which
firmware version you are using.

It would be helpful to test with the latest linux-firmware version:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/mediatek?id=3D5cf85776762a544ad27c4447b61eaabb0d4716e7

As a debugging step, could you also try disabling PCIe ASPM and check
whether the issue still occurs?

               Sean

On Fri, Jan 2, 2026 at 4:35=E2=80=AFAM moosager90 <moosager90@gmail.com> wr=
ote:
>
> Hello,
>
> There is an issue with mt7921e which causes repeated failures in chip res=
ets,
> bringing the network down and causing hanging on every command or action =
on the
> system; the only workaround is to reboot. This is what the kernel output =
looks
> like at those times:
>
> mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: chip reset failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: Console: switching to colour frame buffer device 360x112
> kernel: fbcon: Taking over console
> kernel: mt7921e 0000:62:00.0: Message 00020001 (seq 1) timeout
>
> I have observed the issue on many untainted kernels, and I have had it ha=
ppen on
> vanilla kernels not provided by my distro as well.
>
> Mine and some other people's reports are available at [1]. More logs of t=
he
> issue on my system are in the attachments of my original report on the Re=
d Hat
> Bugzilla [2].
>
> In the past, the issue was reported at [3], which resulted in a patch [4]=
 that
> only keeps the system running instead of panicking. This means the driver=
 still
> causes system hangs.
>
> I still don't know the root cause of the issue and I would like to get to=
 the
> bottom of this; any help or guidance is appreciated. Crucially, I have no=
t found
> a way to reproduce the issue at will.
>
> Best regards.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220353
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2411854
> [3] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4=
A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/#u
> [4] https://patchwork.kernel.org/project/linux-wireless/patch/727eb5ffd3c=
7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/
>
>
>
>

