Return-Path: <linux-wireless+bounces-27734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76740BABFB6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05821925EDB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847B02BE037;
	Tue, 30 Sep 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoXF/Hsb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B259CBB
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220289; cv=none; b=OSngrvyY8QOe4H3mZXiNPGJ9hu4+i4KusA3OgC1Pl5nkaWFUXGPTgs165gvugVYx4FI1CxmNqcAvVI/JGezeeE4GE1/X/lmEBnzCbl7OhnfEYlo4PRCGE1lS3tkev9erDfPu0yhqqAKZwGCv9BWujWUGe4c0Yx7vIE6gVLtkjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220289; c=relaxed/simple;
	bh=sro3kF+GZN6CtuGOXqjDppP9TCw0ZwvpxxnzMN83Bg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXESBJbnc4aaOmNMIO2vRK+/ng2WozIjWaRC3I3TiTKBVn0FuRM/cOKr3UVBJl0huXCV4rGBAhz5OV3kEkQzRhWAcvWaRBnw+znee0Je8VaxCgfmoSHG5+CULUUSDskpjJ3g8eruFJ1Xt/oNp8CjYW8dyigci+5SriCZMOHvFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoXF/Hsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4AEC116C6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759220289;
	bh=sro3kF+GZN6CtuGOXqjDppP9TCw0ZwvpxxnzMN83Bg4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ZoXF/HsbzElu7zZuFiI9BZzAeU9hwhx7cT02b/TZm2/3PFGef9tkxr2ljBMNvhBfg
	 dhaRoMzpXwxzaaqwDrsN7vgWXczNvWbemrABKj6iHBzOO8UoNeq4scenH/CmfQn8GA
	 pMu06BXyNeSt0iWGAdJiUZnfgu73GA7zQwkLzpeyfniYsfiTubf6q9qjsagexi2/Ig
	 7OnF+IaTyR9p/1EUv8TX7sI2ppCLcUViO5cgQT/99LrFzXHYlyC5pqAJuLiJSuoiji
	 a2zMm8zyZ3MrRu3cHYzKt2zEeY0bpYMXFKe0d5BVZ6Y9kzijY+Lafy0+nwcb+s86GF
	 jElbylet62LDQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so63838851fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 01:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1aPwQQ4ja/va4q/h114VIa09hxVXIMpqb3Y/G1JaZgs+5XL0qft8s7bc2ihFs6Eu/QM1pdE6m1bWJ2Q8T2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4Coy9j1gFfCaVZVULuVybbVcXVu0Qqbi8Y0VG9rrDWDVTXvv
	jTDwyheH97AvcMg5t3PxCAMDhwjquqTvbFSe3Q+qUvlrzIETc3nU66PQSP1T1IhSwKYpudTy+53
	ucTjRiqhju01DzkPph6RvpG/3T/Zf9TE=
X-Google-Smtp-Source: AGHT+IFLMGL/k7x2u5Jd3xHIUsPZdLkAQWtCh8aVbbq69AEUs407rWWCopb1AhtOQ1i8kB50jgf9DZRkmEOEQBIt4nI=
X-Received: by 2002:a2e:b8d1:0:b0:36b:b0eb:9d64 with SMTP id
 38308e7fff4ca-36f7ee605famr46461161fa.30.1759220287259; Tue, 30 Sep 2025
 01:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930042948.427154-1-wens@kernel.org> <CAHrRpunr+hbWiO1jY=jGZOiqGWcXFGYBSJi17+r-AgOMwssaXg@mail.gmail.com>
In-Reply-To: <CAHrRpunr+hbWiO1jY=jGZOiqGWcXFGYBSJi17+r-AgOMwssaXg@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 30 Sep 2025 16:17:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65wSPCeW=qgrjX1cBUfbYj55U9HUOdPw3n0zHm0PJpNNA@mail.gmail.com>
X-Gm-Features: AS18NWBIy9S10wBIP1mf2VN3iJtHtPEptndTSbTJR0hMjKM-e18Fg3ifdQ6eP3E
Message-ID: <CAGb2v65wSPCeW=qgrjX1cBUfbYj55U9HUOdPw3n0zHm0PJpNNA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Pavel Starosek <starosekpd@gmail.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:25=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > By Order of the Minister of Digital Development No. 564/NK dated
> > September 19, 2024 [1], an amendment was made to the assignment of
> > frequency bands, opening up the lower part of the 6 GHz band (5,945 MHz
> > to 6,425 MHz) was opened up to "SRD (wideband data transmission systems=
)
> > WAS/RLAN Data transmission systems/radio local area networks".
> >
> > The power is limited to 200 mW e.i.r.p. with a spectral density of 10
> > mW/MHz. Only indoor use is permitted.
> >
> > While at it, also change the power limits to use mW units to match the
> > official documents.
> >
> > Initial information was provided by the Wi-Fi Alliance website, which
> > has a map [2] showing all countries that have enabled 6 GHz WiFi, and
> > links to official documents. This document was not sufficient as it did
> > not include power limits or other restrictions.
> >
> > A subsequent search found a blog post [3] providing details and titles
> > of the official documents in English. An AI agent was used to search
> > for the original text of said order [1] after rummaging through
> > government websites in Russian and Kazakh failed to find anything.
> >
> > [1] https://adilet.zan.kz/rus/docs/V2400035100
> > [2] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> > [3] https://www.onewindow.pro/blog-posts/6-ghz-band-regulation-in-the-r=
epublic-of-kazakhstan
> >
> > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> > ---
> > If you received this patch, please help review it. The changes are
> > based on translations of the original text / tables, so a second set
> > of eyes would be appreciated.
> >
> >  db.txt | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 6e1ad30..16bcb32 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1136,11 +1136,12 @@ country KY: DFS-FCC
> >  # http://adilet.zan.kz/rus/docs/V1500010730
> >  # http://adilet.zan.kz/rus/docs/V1500010375
> >  country KZ: DFS-ETSI
> > -       (2400 - 2483.5 @ 40), (20)
> > -       (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> > +       (2400 - 2483.5 @ 40), (100 mW)
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> >         (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
>
> The power limit of 5150-5350 MHz is 200 mW, maximum spectral density
> e.i.r.p. 10 mW/MHz.
>
> So, 5250 - 5350 should be 23 dBm or 200 mW.

I had this question as well. Looking at the original submission history,
it seems that the limit for 5250-5350 MHz was halved to cover TPC
requirements. See [1]. I'd like to follow the existing values unless
someone can point to documents stating otherwise.

Thanks
ChenYu

[1] https://lore.kernel.org/wireless-regdb/20191029144815.GR30813@ubuntu-xp=
s13/

> > -       (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
> > -       (5725 - 5850 @ 80), (20), NO-OUTDOOR
> > +       (5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
> > +       (5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
> > +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> >         (57000 - 66000 @ 2160), (40)
> >
> >  country LB: DFS-FCC
> > --
> > 2.47.3
> >
> >

