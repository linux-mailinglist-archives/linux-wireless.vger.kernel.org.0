Return-Path: <linux-wireless+bounces-27874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82841BC3741
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A1594E7910
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFF29B8E8;
	Wed,  8 Oct 2025 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kny+SNSn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8436190685
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904290; cv=none; b=aJPjE1wMaZDq2pWwj3ZiFZgj4H0zxYhDZIcnhiHDdBWnWjXdD8vIPsG86XJsamSKTMvXQfEZKEBjsFFbyRyUc5sOyPh7TfZfwuTWg9Ykz4atEfVXV9o7bEdKoDJf0CeGm3ojWi6Vqwb070upwTy0pv+84crkttDPZn9SBf6N1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904290; c=relaxed/simple;
	bh=VpxJvNEXAIJUZR56IbuEtAdE7J7v/jZDD7kCu1VcXlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6N3w8YG4YG4wYPYw3tI5XiFq42R3CqimdCdbSZSQEF4j92LXrPSU2hULB5D3R6p3/LZcPFih5V1e6PtBYqd6VY3NP2nKdo6PYJu60IExXqh7CSoqcoJefYsAOQ1IHkxRZYTPMBC7fcKTsGz0/Q4MXGFGDChgkrhkRTUZKGmLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kny+SNSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32077C4CEF4
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 06:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759904285;
	bh=VpxJvNEXAIJUZR56IbuEtAdE7J7v/jZDD7kCu1VcXlU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Kny+SNSn66MTcnzM//NjHgJjO8NCXk5Gp+VTFR/3EELxRk48eRcSLcvISHM6nqbDS
	 Bzi1e++SOcA6OG7TSWkyuspWhfO5r4kiYFij5gtLBpgdAy4/hgsxfAbkS8xNdBPTiZ
	 8N5Ad82UEa2Q761yIg3wuw+PHgnZ5avyNz4PnIfOEkVNUBnMDInnAuxCS54P/XoccY
	 1JSt6MqbRGUQzncDSdQbky6vhNfLHiFs/2hd9LLpudqnp8fysU6gNj9otdSn2xdi59
	 H3d6o501Fb95MxQzAROtaZO2MaRLayqXCF9fNYtCCz9N5J9JUb5jIvEgqbmW49owfG
	 UYYmI04FgCtIw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3635bd94dadso60075841fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 23:18:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy267+yu+sDzFJpzhpo+W+sl953PLZxLKGWGXEDLpnYgDP+8hlH
	w9yJxYzKe31exdJoj+Ajg5icK42i8sIY/3lNx9dAxt5PH0gc1tBcVonMLK6KSnLJ5oezbauUdps
	sVxmJGzuPJjI4K3N/zQRRPMxPcz32pjE=
X-Google-Smtp-Source: AGHT+IHWoV1EL1a3MyNfTxnDmyfw51006/Hx2jWigCyYdVv3rAluhUp9NvSqxmTBy5MpbbzswZ2ZtK0hBoc//2ObT0A=
X-Received: by 2002:a2e:bd02:0:b0:372:9780:a2b2 with SMTP id
 38308e7fff4ca-37609edacdfmr5500821fa.39.1759904283523; Tue, 07 Oct 2025
 23:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924022156.8435-1-pkshih@gmail.com> <CAGb2v66MZpd8QWYptLrh5O5qf-DWAnqxf3d692JWZoF3jCRj0g@mail.gmail.com>
 <CAHrRpuknX-Ptz990dqKpPAN71k_fNdJT5aX3CcmckyeOgC9MJA@mail.gmail.com>
In-Reply-To: <CAHrRpuknX-Ptz990dqKpPAN71k_fNdJT5aX3CcmckyeOgC9MJA@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 8 Oct 2025 14:17:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Q1OAKhE3FWHJm1OeEoJuo=tXet7kgRDdgb=nLqbNVCw@mail.gmail.com>
X-Gm-Features: AS18NWAYLUU3akcGMebifjz7VDuLQ7hxdn3PR3eWHkhcytROfay7ZG3smiYCxdk
Message-ID: <CAGb2v64Q1OAKhE3FWHJm1OeEoJuo=tXet7kgRDdgb=nLqbNVCw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info including
 bandwidth for Trinidad and Tobago (TT) for 2025
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:32=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 24, 2025 at 10:22=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com=
> wrote:
> > >
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > The Telecommunications Authority of Trinidad and Tobago [1] provides
> > > Schedule of Devices Eligible for Use under a Class Licence [2]. The
> > > type 1 (End-user devices or customer premise equipment) with Schedule=
 B.1
> > > and B.2 shows
> > >
> > >  - 2400 - 2483.5 MHz
> > >    * 30 dBm
> > >  - 5150 - 5250 MHz
> > >    * 24 dBm
> > >  - 5250 - 5350 MHz
> > >    * 24 dBm
> > >  - 5470 - 5725 MHz
> > >    * 24 dBm
> >
> > For these bands, the rules specify ERP, or effective radiated power.
> > However it states "Maximum Effective Radiated Power ERP (from RF
> > transmitter)", so I think it is meant to "maximum conducted output
> > power" as seen in FCC rules?
> >
> > This is not the same as EIRP, or effective isotropic radiated power.
> > AFAIK the latter is what is supposed to be used in the database. This
> > discrepancy is found in many rules originating from the FCC rules. The
> > FCC rules specify maximum conducted power (TX power) plus max antenna
> > gain in dBi.
> >
> > So there is some conversion involved. I think the values should be
> > "max conducted power" + "max gain in dBi". This assumes no cable loss.
> >
> > I think we would also need to revisit the US rules.
>
> Thanks for the detail, but I still not clear if I should use ERP +
> antenna gain as
> EIRP, or should I apply FCC requirements as hard power limit?

This old slide deck [1'] from the FCC (?) suggests that EIRP is max
conducted power + 6 dBi antenna gain.

> By [1], it also mentioned limits of maximum power spectral density, if we=
 also
> apply the limits, the values will be almost what I wrote, which are also =
almost
> the same as US country in db.txt.

The PSD requirements also translate to the wording for some of the bands:

For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conducted
output power over the frequency bands of operation shall not exceed the
lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB emission
bandwidth in megahertz. In addition, the maximum power spectral density
shall not exceed 11 dBm in any 1 megahertz band.

"11 dBm + 10 log B" is basically describing the PSD limit.

If in doubt, maybe you could ask how certification labs interpret the
text? I think that doubly applies to the Trinidad and Tobago case, where
the text is somewhat mixing the terms ERP and max conducted power.


Thanks
ChenYu

P.S. The FCC website seems to be more or less unavailable due to the gov't
shutdown, so it's hard to dig up more information at this time.

[1'] https://transition.fcc.gov/bureaus/oet/ea/presentations/files/oct14/51=
-New-Rules-for-UNII-Bands,-Oct-2014-TN.pdf



> [1] https://www.law.cornell.edu/cfr/text/47/15.407
>
> >
> > >    * extend 5 MHz to 5730 MHz for channel 144
> > >  - 5725 - 5850 MHz
> > >    * 30 dBm
> > >  - 5925 - 6425 MHz
> > >    * 24 dBm
> >
> > These two bands have 0 dBi for max antenna gain, so max TX power =3D=3D
> > max EIRP.
> >
> >
> > ChenYu
> >
> > > [1] https://tatt.org.tt/licensing/class-license/
> > > [2] https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedul=
e-of-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
> > >
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > > ---
> > > Hints to find these entries: by searching "Wi-Fi" with type 1 in [2].
> > > ---
> > >  db.txt | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index 6e1ad30222a4..90ffa4e0d5d7 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1946,12 +1946,15 @@ country TR: DFS-ETSI
> > >         # 60 GHz band channels 1-4, ref: Etsi En 302 567
> > >         (57000 - 66000 @ 2160), (40)
> > >
> > > +# Source:
> > > +# https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule=
-of-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
> > >  country TT: DFS-FCC
> > > -       (2402 - 2482 @ 40), (20)
> > > -       (5170 - 5250 @ 80), (17), AUTO-BW
> > > -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> > > -       (5490 - 5730 @ 160), (24), DFS
> > > -       (5735 - 5835 @ 80), (30)
> > > +       (2400 - 2483.5 @ 40), (30)
> > > +       (5150 - 5250 @ 80), (24), AUTO-BW
> > > +       (5250 - 5350 @ 80), (24), DFS, AUTO-BW
> > > +       (5470 - 5730 @ 160), (24), DFS
> > > +       (5730 - 5850 @ 80), (30)
> > > +       (5925 - 6425 @ 320), (24)
> > >
> > >  # Source:
> > >  # Table of Frequency Allocations of Republic of China (Taiwan) / Feb=
 2017:
> > > --
> > > 2.25.1
> > >

