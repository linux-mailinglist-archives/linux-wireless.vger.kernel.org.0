Return-Path: <linux-wireless+bounces-27877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C1EBC3E58
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B50894E3849
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B02F2601;
	Wed,  8 Oct 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD1Dkx+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949262BF3CF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912978; cv=none; b=mAwLKK63f/H35yQVHdVQG10GeAblMRbFbf4rs3mPFiMZG0L3939Ndftg4/nORxyGip3iyjWtgI9X4kZ9app31m7yTu2CmubgOvTFx8rGD0YJlQ+LFI1re9Pb7IFuEQ3OfnON4KcSDVLYP2j0wHTxauRaNLzcf/6y20THRhdNP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912978; c=relaxed/simple;
	bh=UIgsUpN5YdDuyMCIl4jXxCOKtkYDG4OevKPLrkE9Yk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D36rIcSmD1VedkF1h5RBG0q576QQPdtlBATzD5ecH2KzB6cbOIO/Y6pgskKQa9d5ynt6iALuF5Jhdj393ckO+LmxJ9fdy50VqaKq0Eni7GrQfsNIMD8Dvo1+FNgo5cpMPyi3AENRgvmyG4FGQ2R/w+te8X7sp9Epklocx6MJ6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD1Dkx+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C8EC4CEFF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 08:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759912978;
	bh=UIgsUpN5YdDuyMCIl4jXxCOKtkYDG4OevKPLrkE9Yk4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JD1Dkx+le+J2GHQuV9fiXuD98aiMJIIYRsyXkBU+AdYlQjmuIW2fWBZIHhmWpajWm
	 u1GZQC0DnMGXaqPo4uYHaY826Q1dCxDSzp9RHLh3pd3Ct80W/vvqRvdd5hyp8RHtZc
	 kklbha/GKQ52rc5QTDljQTXxnyMr3PeycYFsC+FvaPx87u9Jv/bB2UIBAiYLVulpjs
	 oqofMJK4yH7HiZOy2sZpePQqYOf+8vwHx9V8CEYcV66GnldR9UCuNYwXqz+DSyAY8j
	 frMl+FqpLglEM2iM3ukMqoOExcw/qXM8yh8hDaq5ZJ4K/o1NtZyqLCd+2A0EZKNdln
	 n0T3VLkfXsdQg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b35e176dbso9124260e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 01:42:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+VTzGXoeFdUQLZDok6Jag/AbImK/2ErdTmLKRhewkbqNhL+h9
	vNl7Bl0+y8HkX4OKgRyzw1UIo1aa4Kdblbx1Ee1N+3DqEoEiawq6VER2f4wdjzr4JHp/uwN6Q+T
	L3AbFZIE4cDG70nl8mdidoRuFQJOcH+c=
X-Google-Smtp-Source: AGHT+IEvo2NBNKV35/bcr2BNhM9r87SWUB/okrT6C3bpUw4barzJxr+KSldobDqMfHgEfxfgSCS8CZ3d6R17tZ6wHG8=
X-Received: by 2002:a05:6512:31c2:b0:55f:4ab0:79a7 with SMTP id
 2adb3069b0e04-5906d75f8c2mr807240e87.7.1759912976518; Wed, 08 Oct 2025
 01:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007230450.69998-1-voxlympha@gmail.com>
In-Reply-To: <20251007230450.69998-1-voxlympha@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 8 Oct 2025 16:42:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67RvP5ykKJR1yOpZ9y2b=dAA3mkXFUn8a7U_pNmudS37A@mail.gmail.com>
X-Gm-Features: AS18NWBA6ODxW6KnEXBQr-5weUDJaZWCA9F1cLS3zxZxZ_Fs4IyvxdJsWDdhQOg
Message-ID: <CAGb2v67RvP5ykKJR1yOpZ9y2b=dAA3mkXFUn8a7U_pNmudS37A@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Australia (AU)
 for 2025
To: Richard Huynh <voxlympha@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:05=E2=80=AFAM Richard Huynh <voxlympha@gmail.com> =
wrote:
>
> As of October 1 2025, a new class licence is in effect[1]
> Update the link and references in the comments to it
>
> Additionally for the lower part of 6Ghz spectrum:
> - Allow for EHT-320 as it complies with PSD limits
> - Expand the upper range up to 6585 as permitted in new licence
>
> [1] https://www.legislation.gov.au/Details/F2025L01047
>
> Signed-off-by: Richard Huynh <voxlympha@gmail.com>
> ---
>  db.txt | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 16bcb32..93d709e 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -145,43 +145,44 @@ country AT: DFS-ETSI
>
>  # Source:
>  # 'Item' in the comments below refers to each numbered rule found at:
> -# https://www.legislation.gov.au/Details/F2023C00524
> +# https://www.legislation.gov.au/Details/F2025L01047 within Table 8
> +# except for 5850-5875 which is found in Table 1.
>  # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
>  # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
>  # In order to allow 80MHz operation between 5650-5730MHz the upper bound=
ary
>  # of this more restrictive band has been shifted up by 5MHz from 5725MHz=
.
>  country AU: DFS-ETSI
> -       # Item 58
> +       # Item 1
>         (915 - 920 @ 4), (1000 mW)
>         (920 - 928 @ 8), (1000 mW)

Side note, I think this should be just one band. We don't artificially
split bands on channel boundaries. If you could, please send another
patch to merge them.

> -       # Item 59
> +       # Item 3

Items 3 and 7? I can fix this when applying the patch.

>         (2400 - 2483.5 @ 40), (4000 mW)
>
> -       # Item 61
> +       # Item 10
>         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
>
> -       # Item 62 (200 mW allowed if TPC is used)
> +       # Item 11 (200 mW allowed if TPC is used)
>         (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
>
> -       # Item 63(a) (1000 mW with TPC)
> +       # Item 12(a) (1000 mW with TPC)
>         (5470 - 5600 @ 80), (500 mW), DFS
>
> -       # Item 63(b) (1000 mW with TPC)
> +       # Item 12(b) (1000 mW with TPC)
>         # The end is 5725 but we borrow 5 MHz from the following less res=
trictive band
>         # so we can get an 80 MHz channel.
>         (5650 - 5730 @ 80), (500 mW), DFS
>
> -       # Item 60
> +       # Item 9
>         (5730 - 5850 @ 80), (4000 mW), AUTO-BW
>
> -       # Item 22
> +       # Item 22 of Table 1
>         (5850 - 5875 @ 20), (25 mW), AUTO-BW
>
> -       # Item 63AA (25 mW if outdoors)
> -       (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
> +       # Item 13 (25 mW if outdoors)
> +       (5925 - 6585 @ 320), (250 mW), NO-OUTDOOR
>
> -       # Item 65
> +       # Item 18
>         (57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR

The rest look correct.

Thanks
ChenYu

>  country AW: DFS-ETSI
> --
> 2.51.0
>
>

