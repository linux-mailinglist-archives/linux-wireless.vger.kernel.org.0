Return-Path: <linux-wireless+bounces-13309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABAD989BBE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D68B21024
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DBF15C13A;
	Mon, 30 Sep 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF4raLw3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C301547DB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682098; cv=none; b=uzpiVUMstnr40vcrjFrov6xg0sE2UCU6XvlNlLXJXRACkvSxIGGVaVIozXiK/tgyxIM7AOf+IhNraUOLz2/4P6chh32G1ZLpm9cIS8U2KMWGo3h57cswEkgxWSPw3KqsSUZfoEsxDDE9FREXOsM6TgajkQtj0FapWGkowydehYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682098; c=relaxed/simple;
	bh=/ItUKa7wXs6970KPiCDNNpw0rMdnwOPYYth69xFUMKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRBtyYxBhdGRjXAbMB3akFnAm9UgW0uEZjil79wSdf/jcEGd8cKAcAmDrOPOBXukQWcC7q/gIdCVMyoZDBVnQSLWjO/ex7Uw1FKsHHihQXuMEcsrslEJtn6yeOhZV1feXcKoDcg6mWYi5I8XzxEnTf2q5RN6CME0pCReVXOFQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF4raLw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B467AC4CECD
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727682097;
	bh=/ItUKa7wXs6970KPiCDNNpw0rMdnwOPYYth69xFUMKg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=gF4raLw3DEn4T8dn1IpNLa07JExYZHTrZRLvpewLsnxtbfrv/9cB7bZQ1GLYQHNVP
	 QfViJTSA10CdmW/LxJX2bSpuWVdB2m50Bvb9MuOgbojBOMUcx4a58v9X2AG+qLtitf
	 kM90dblHzMUwEbNhCbbL+BbB5mBX6G+4Zi1TWhrJtJhl5SvMtVqwmfKcqIVf+SaF86
	 yP6E/kLTFu6hRc13nblVbNNgl7YQo+7Mc79ABhBkjyvNemDQZ9M1GWVkRfHYAzdsam
	 Jj6+4Je0fcYCh4DhkYmfM0Cc1wz4sAuNfOOEe95r/9cBzWljrUT9uWVqWvWwgCzEYh
	 StdEneuZ5mC/A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fa10e64805so28513711fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 00:41:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywu7cgQeiYOUXUYfiLGJZWCOAYzNgqrnuV2a9iEehjWkWRmytHR
	bws9U3g5x1Hffqtw5t1JiGfT9srTKIWM/s43mwwefiP1s8+tOD2PX9Auoykj8GoiuqHydpX7tPd
	HoemW6DcyinA26ARDFSwDmOQW/60=
X-Google-Smtp-Source: AGHT+IGvBa2RV59K1aOUc591u0qgleoAZBcTiRo63ipi/AbR9v6SMQLzcJFc0I9+h8PdFNqARUJmhhYPS2XHO2IgcOQ=
X-Received: by 2002:a05:651c:2222:b0:2fa:c2c4:f9f5 with SMTP id
 38308e7fff4ca-2fac2c4fe91mr24297781fa.38.1727682096036; Mon, 30 Sep 2024
 00:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920011901.5038-1-pkshih@gmail.com>
In-Reply-To: <20240920011901.5038-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 30 Sep 2024 15:41:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65J1FV-POEh+QciWUxE-OZyRuh+Wfad9TuimJrrDHcjkQ@mail.gmail.com>
Message-ID: <CAGb2v65J1FV-POEh+QciWUxE-OZyRuh+Wfad9TuimJrrDHcjkQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Tanzania (TZ)
 for 2024
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 9:19=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> United Republic of Tanzania, Tanzania Communications Regulatory Authority
> released Minimum Technical Specifications for Short Range Devices (SRDs)
> on 2024 [1].
>
>  * 2400-2483.5 MHz
>    - 100 mW e.i.r.p.
>  * 5150-5350 MHz
>    - 200 mW mean e.i.r.p.
>      * The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
>        in any 1 MHz band.
>    - EN 301 893

This also restricts 5250-5350 to 100 mW due to lack of TPC.

ChenYu

>      * DFS: 5250-5350 MHz
>    - Restricted to indoor use.
>  * 5470-5725 MHz
>    - 250 mW e.i.r.p
>      * The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
>        in any 1 MHz band
>    - EN 301 893
>      * DFS: 5470-5725 MHz
>    - Indoor as well as outdoor use allowed.
>  * 5725-5850 MHz
>    - 1W
>    - EN 302 502
>      * DFS: 5850 - 5875 MHz
>      * FWA device shall have the capability to reduce the operating
>        mean EIRP level to a level not exceeding 24 dBm for ChS =3D 20 MHz
>        (24 dBm is adopted)
>  * 5945-6425 MHz
>    - 23 dBm for LPI usage
>      (should be indoor naturally)
>    - 14 dBm for VLP usage
>
> [1] https://www.tcra.go.tz/download/sw-1719952895-Minimum%20Technical%20S=
pecifications%20for%20Short%20Range%20Devices%20(SRD),%20June%202024.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 9a55f6b8cc98..5ef3236d26ae 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1860,9 +1860,15 @@ country TW: DFS-FCC
>         # 60g band, LP0002 section 4.13.1.1 (1)(A), EIRP=3D40dBm(43dBm pe=
ak)
>         (57000 - 66000 @ 2160), (40)
>
> -country TZ:
> -       (2402 - 2482 @ 40), (20)
> -       (5735 - 5835 @ 80), (30)
> +# Source:
> +# https://www.tcra.go.tz/download/sw-1719952895-Minimum%20Technical%20Sp=
ecifications%20for%20Short%20Range%20Devices%20(SRD),%20June%202024.pdf
> +country TZ: DFS-ETSI
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), AUTO-BW, NO-OUTDOOR
> +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
> +       (5470 - 5725 @ 160), (250 mW), DFS, NO-OUTDOOR
> +       (5725 - 5850 @ 80), (24), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source: https://zakon.rada.gov.ua/laws/show/z0201-15#n48
>  # Although it is allowed to use up to 250 mW for some 5 GHz frequency ra=
nges,
> --
> 2.25.1
>

