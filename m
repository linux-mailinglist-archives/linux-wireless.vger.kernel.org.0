Return-Path: <linux-wireless+bounces-19475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D2A459C5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E97B18919CD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84947258CFB;
	Wed, 26 Feb 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLx95Yb/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58131258CED
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561393; cv=none; b=N2xb6VA9gW+++V26cZuxatV8cL+0arf4ZQz2k3PzufrVz95NRLf1rpxMGM3Ejjb7m03wjm80ps58P3XZ5hEdDkUURWYiFor8wuJg2dh160MSIW5tRHIzkQPLR9W8tXTmMfyo4KUr2m5UkGT3ylmG2nqKkUOUu6HYWYXMczJ80YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561393; c=relaxed/simple;
	bh=05gVVOY3WLxtaEL/Nx5rm3Z6HUycaGH6TDcEb/e4chw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZFXTdoni345ZpjD614yY3T4dmxhfS1orrdgHK4OVSMYlcYjtL049YwnhCrpMSZrLXc9SZq4v6RIHMKKups4Rav9BOBMNw2jVXWmJ+24ILtlqUaGT43QMVuejMMhUy/kMnlM83Knd/PwFzTcX1nJu2G5v3v2a27Mf/CtGWPiKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLx95Yb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA24C4CEE2
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740561392;
	bh=05gVVOY3WLxtaEL/Nx5rm3Z6HUycaGH6TDcEb/e4chw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=pLx95Yb/l4KRgp65KUMom/C5x4jeSr+dOWP66Vfi0D4VxL4k2j8mu0ODYQSFEEosU
	 RlrpYgg28TxjzYirF/y7s8npiiZij+r3qepDbyvdvF5/Ah5WPmR+PG+87eLCtG0cLL
	 4Rx0UuqvDVvWRDjQ7sth2QC60dVV7DwjujcnFSicFkebykdDPJ8h6yBhdMM9x3zGwO
	 T6lRdI+54KYFMVXMsQ0BEMjyjsIAhF8AvZVeZCGLsr83VyEDqMKtpyaul+0vW4sZa6
	 NuwHtjepnUaZkOxoqq7piFZBB2mejCmYweONYVZnN8km30PPIk5QVnfIainqWKjVVH
	 dJyZQyLdUtPFg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so51548771fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 01:16:32 -0800 (PST)
X-Gm-Message-State: AOJu0YzxogIWIRJhrXlkoSHP7f3dIDdG355f9w3F6tTJEr6z4xaw4HCH
	Pcs2CQp6+su5XYx9faqJOH+l1NIMs5o5PMjlcWcSryjmey7dWTayNyVBaDMI6w0By5sza2OmG7K
	XOtd26iZvPzADBp3UXDAeGAcUkDw=
X-Google-Smtp-Source: AGHT+IELdfE1gzu3uq1AHnOX1jEt+TzMJax3znzX0UKdhlSW/Wajol/9Y1Yt6LMcBib8zwd4F5j0WL1TCmGElXbMjBc=
X-Received: by 2002:a2e:87da:0:b0:308:e8ae:1817 with SMTP id
 38308e7fff4ca-30a5b20d801mr94896661fa.26.1740561391131; Wed, 26 Feb 2025
 01:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
 <000901db882d$8cb13090$a61391b0$@gmail.com>
In-Reply-To: <000901db882d$8cb13090$a61391b0$@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 26 Feb 2025 17:16:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v642utRqjhKth9he-jicA_E5RfYoXTPRyZaVykLNXQCXvg@mail.gmail.com>
X-Gm-Features: AQ5f1JpeYc1HB0IPuwQodh1N6wqFZkIckv_HojOyWcAIuXVPcZ-WvOKve-Rrjyg
Message-ID: <CAGb2v642utRqjhKth9he-jicA_E5RfYoXTPRyZaVykLNXQCXvg@mail.gmail.com>
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: rmandrad@gmail.com
Cc: linux-wireless <linux-wireless@vger.kernel.org>, 
	wireless-regdb <wireless-regdb@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(When replying, please reply to all)

On Wed, Feb 26, 2025 at 5:05=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> Thank you. Apologies this is the first time submitting a kernel patch. Th=
e original submission set NO-IR where clearly the document notes it is allo=
wed as section 59 states hence the patch - with increase usage of 6Ghz we h=
ave now Openwrt users complaining they can't the band in the US due to NO-I=
R
>
> Shall I update the patch to only remove NO-IR and increase power to 30 dB=
m ?

As explained, the limit is lowered from 30 dBm to 12 dBm to comply with
the PSD requirements when using a 20 MHz channel. I suspect no one would
use such a narrow band, but the requirements exist and the database rule
should not be written in a way that allows the user to exceed the limit,
i.e. using 30 dBm on a 20 MHz channel.

So please update the patch to only remove NO-IR. You can look at previous
commits to see how we put URLs in the commit message.

Thanks
ChenYu

> Thank you again
>
> -----Original Message-----
> From: Chen-Yu Tsai <wens@kernel.org>
> Sent: 26 February 2025 08:58
> To: rmandrad@gmail.com
> Cc: linux-wireless@vger.kernel.org; wireless-regdb@lists.infradead.org; D=
ennis Bland <dennis@dbperformance.com>; Ping-Ke Shih <pkshih@realtek.com>
> Subject: Re: wireless-regdb: Allow 6ghz in the US
>
> CC-ing Dennis, the original submitter, and also Ping-Ke, who has done a l=
ot of 6 GHz updates, for more information.
>
> On Wed, Feb 26, 2025 at 4:03=E2=80=AFPM <rmandrad@gmail.com> wrote:
> >
> > Allow 6ghz in the US
> >
> > https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlice
> > nsed-u se-of-the-6-ghz-band allows the use of 6ghz in the US namely
> > section
> > 59 https://www.federalregister.gov/d/2020-11236/p-66 with absolute
> > radiated power of 30 dBm for the 320 megahertz channel
>
> Please don't wrap URLs.
>
> Please see the original submission [1], which explains why the power limi=
t is so low. Basically, neither the database nor the kernel supports specif=
ying power spectral density limits, so we can only take the narrowest bandw=
idth to calculate the applicable power limit.
>
> [1] https://lore.kernel.org/wireless-regdb/CAPRryQp6j4UKvLZCkMAuQdaxepMBE=
TQUJ1eNULJSh3ZWXC0f5Q@mail.gmail.com/
>
> > based on this remove NO-IR flag and allow 30 dBm max power
>
> The original submission mentioned NO-IR requirements, though I did not fi=
nd such wording. Dennis, do you have any ideas?
>
> > Signed-off-by: Rudy Andram <rmandrad@gmail.com>
> >
> > diff --git a/db.txt b/db.txt
> > index 803f1bc..bc2b4fe 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1953,7 +1953,8 @@ country US: DFS-FCC
> >         (5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
> >         # 6g band
> >         #
> > https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlice
> > nsed-u
> > se-of-the-6ghz-band
> > -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> > +       (5925 - 6425 @ 320), (30), NO-OUTDOOR
> > +       (6525 - 6875 @ 320), (30), NO-OUTDOOR
>
> The database entry targets LPI usage instead of standard usage, which req=
uires the presence of AFC, which is also a requirement that the database is=
 unable to represent. And under LPI usage, the full 6GHz band (U-NII-5, 6, =
7) is available.
>
>
> Thanks
> ChenYu
>
> >         # 60g band
> >         # reference: section IV-D
> > https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
> >         # channels 1-6 EIRP=3D40dBm(43dBm peak)
> >
> >
> >
>

