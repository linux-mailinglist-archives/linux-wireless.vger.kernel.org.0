Return-Path: <linux-wireless+bounces-10334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026A934756
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 07:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAEE283867
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 05:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60182746F;
	Thu, 18 Jul 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW5ng+ez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF720B0F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278957; cv=none; b=DM9oqvjB/sc4ZWftzhaS23dIiWen+vl0lBZ73GDvw6N9tc/DO0VgnMLuAlgJdLBQOjv/KDdt17bdjXbbQVGIf08n6MqrL60iEP/QKkoOPUrPHhU1zjNQAO9PJvWtZov8Fa5t9KVR2zBCX3v1yZl7y9UkMj9uSAo3yuxCgnWe0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278957; c=relaxed/simple;
	bh=H/xhkjImepp9eQ4QaNaAvZuSCOzoI/rYpru+Gkfw8Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED0SokIBJZY8zshlQ0ba3nJ9DAYvdYpt16R1D3FzAYB2J5IHgskUABB3YclFPpk2wGJIJdQJklISLf9UkRzyw+xMwGrNSzpMXI83iLJhmOVgFAp9vFqCHTqxd9m6w7fW5JXTLqPyFO10/MX6FUDpnZ+VVZIEztF7KwD33TTX34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW5ng+ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5726CC116B1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 05:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721278957;
	bh=H/xhkjImepp9eQ4QaNaAvZuSCOzoI/rYpru+Gkfw8Gg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=uW5ng+eztnJCKC3/IUrVQELT7Tccuj7ILbbpFmDsoiygh/7LvOBcFuZ225V2lIMZ/
	 eZFOQsewE3rmFvBlDOJYrSuStoRF6EllIAeovMX9KCwWREoPgQ7IbgCAiUu9adwKdz
	 jV6nWw072r3Fv3lzDYsGXUl4QshFXkiXj/1u6NZAmg+6ytaw572a0yUr4bt3duwG/d
	 8KfG03zyJ0Zjec7BSFzm3+4Hefg5hy8sKSkbgaIonMNkQey/deqmx+XyAPt9nLqaw5
	 NfnK0Ko5sUM5G7xiAjjeEiISuJyoNLINoAByfaAsXtzgRLGQcXXzmXMvof3mshfwV0
	 zyFk//wePGL+Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so5723571fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 22:02:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9nuutjExECBRTGFE6Ry9SqnIUIv++hcGJzBsC45owob4ESIgA
	/pdZteqP8e+gskCnU/FHeu/DNR1yuryIA32SvAt8zikU7pFhWSyfmJMjKGSNVZlY24mSXL5i1Ne
	KwnKI2QXlAqbCdgfeOigk85H6cPY=
X-Google-Smtp-Source: AGHT+IF06HpEc155FLiSxUZ+J06LOGtqm6QAHI8uEcJk9ONagbYgKoOsy7cD1xq0Lx2rrF3nwpNTA7Xxm47NLNL7sv8=
X-Received: by 2002:a05:651c:1a0d:b0:2ee:594d:f54b with SMTP id
 38308e7fff4ca-2ef05d47ed0mr11792061fa.47.1721278955010; Wed, 17 Jul 2024
 22:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060613.28909-1-pkshih@gmail.com> <20240705060613.28909-5-pkshih@gmail.com>
In-Reply-To: <20240705060613.28909-5-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jul 2024 13:02:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v64mLd+jhwL2EXZ=zTJZ2VuMXTa==NvAqib=xQrNg-ufkQ@mail.gmail.com>
Message-ID: <CAGb2v64mLd+jhwL2EXZ=zTJZ2VuMXTa==NvAqib=xQrNg-ufkQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] wireless-regdb: Update regulatory info for Togo (TG)
 for 2022
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Republic ToGolaise released Decision N 226/ARCEP/DG/22.
>
> 2400-2483.5 MHz
>   - EIRP 100 mW and 10 mW/MHz density
> 5150-5350 MHz
>   - EIRP 200 mW
>   - If TPC is not used, must be reduced by 3 dB
> 5470-5850 MHz
>   - EIRP 1W
>   - If TPC is not used, must be reduced by 3 dB
> 5925-6425 MHz
>   - LPI
>     * EIRP 23 dBm (200 mW)
>     * EIRP density 10 dBm/MHz

The document you linked to suggests it is actually -10 dBm/MHz,
which kind of makes it useless as the total e.i.r.p for a 20 MHz
channel would be 2 mW or 3 dBm...

And the PSD for LP being lower than VLP seems like an error.

>     * Use limited to indoor
>   - VLP
>     * EIRP 14 dBm (25 mW)
>     * EIRP density -1 dBm/MHz
> 57-66 GHz
>   - EIRP 40 dBm and 13 dBm/MHz density
>
> [1] https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determina=
nt-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-f=
aible-puissance-et-de-faible-portee.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 2a4f1ed524c1..6192dafe9715 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1763,11 +1763,15 @@ country TD: DFS-ETSI
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5490 - 5710 @ 160), (27), DFS
>
> +# Source:
> +# https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determinan=
t-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-fa=
ible-puissance-et-de-faible-portee.pdf
>  country TG: DFS-ETSI
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 40), (20)
> -       (5250 - 5330 @ 40), (20), DFS
> -       (5490 - 5710 @ 40), (27), DFS
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 40), (200 mW)
> +       (5250 - 5350 @ 40), (20), DFS

The regulation doesn't say this can be split. It's one rule for 5150 - 5350=
.

> +       (5470 - 5850 @ 40), (27), DFS

Why only 40 MHz channels?

> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
> +       (57000 - 66000 @2160), (40)

Regulation requires DFS on all bands.


ChenYu


>  # Source:
>  # https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> --
> 2.25.1
>

