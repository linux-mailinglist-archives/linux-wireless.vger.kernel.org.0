Return-Path: <linux-wireless+bounces-24521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A402AE97C3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62E67B3B89
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17125BF08;
	Thu, 26 Jun 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drouf1u+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA323B613
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925573; cv=none; b=MEhT+yXb4X1hgk42t7b4ufFwgInq4u3x2tg47dL/rrKjYDUu5A6PLrlQTDpo9pV3nVMccD6H/iDmIF+eSTkBBl5JG2Zqe1FaJXUBuGKGCtzQwoSoem1dA45acDcen/zlRsGP/3CGduHFMdEiDZUqVK9dKHiIjSMUFcYT/3RWSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925573; c=relaxed/simple;
	bh=uuC7OKC7WbXE8NI5ndYMrEWI5VDF8oKgrFaUtqIxPNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpvQWAGHf4GtEt6NEffEIUQmTznRSV8q+Q8oF0eWH2ixsOjEkOSZTfZpKy4tFRZ8emP7mVHVYZQjAad95boIVDQJu3oodYt+XsqtaSKFm06IDFh1YI3ihF+NtxK2rQ1t4WRjtD2jJWNQkD89h4gquv6iK9zWJLF8NAXAWVDnf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drouf1u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF0AC4AF0B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925573;
	bh=uuC7OKC7WbXE8NI5ndYMrEWI5VDF8oKgrFaUtqIxPNY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Drouf1u+iM4/oPmPsABgGIVN1pS1Z9g7yHzP33apWU9gZs59RZQounHtB+Od2XlJ2
	 TGyiCXEFEhIV6MZrof2D7pJbgbBxF7/bOyw4T+51fNkMXVVrR6gcyuMJeNEvwAVA6z
	 wo9V7kMR0AGz0QvYcjw2cs+225Rg5/2tm+eqSllxu6L9tcrGkqR7wPnNZ2MpNlGOrp
	 iephBcZWW5DN9gunLaZAd+lhi8+DtXg+vH+CFbnfhFe2Rkk8/xyWIxLW7zJfIJ+/Re
	 LRIs2Ci/FUetZOiJckuT4ziGjf5mu1XMsLe7LzpC4j83gBh6OuucEumBaEO/8jI8vE
	 Ozj8+UmfL40EA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso6366171fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:12:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfWZdNA6UbdwVIQWF3UpUCYkDcKjXNsaoq3mdz4vbCmRJza1fH
	iqHu1W1sjN27mNUe/HPd6npld/cvYemDAwKI66f0dou9FyRRE/O42aNqmMVK8yDqWdhkIZrFSsL
	y7tIaP2gogUPwRH+rb2++LKAfrQVkteA=
X-Google-Smtp-Source: AGHT+IFKqCJasa3guH/8QHvFBgvK5sFT6r4++A7PfL2nfiyG1gXbdhQzxNdr72k7QKq8ebeNQ7V9wDjZhx8b9FP+peU=
X-Received: by 2002:a2e:808f:0:b0:32a:de85:4613 with SMTP id
 38308e7fff4ca-32ccfa6f679mr8105611fa.23.1750925571628; Thu, 26 Jun 2025
 01:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602121434.3011282-1-marcoshalano@gmail.com>
In-Reply-To: <20250602121434.3011282-1-marcoshalano@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 26 Jun 2025 16:12:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
X-Gm-Features: Ac12FXzunCqzK9LfzGH2E5bvbX6mYXEOLaBgYjRiRPJQkjrMHhDj-O0J2VndEeg
Message-ID: <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
 on 6GHz
To: Marcos Alano <marcoshalano@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:15=E2=80=AFPM Marcos Alano <marcoshalano@gmail.com=
> wrote:
>
> Change rules for 6GHz on Brazil removing `NO-IR` and adding
> `AUTO-BW` so the 6GHz band can be used.

AUTO-BW is not needed since there are no adjacent bands that can be
combined.

> Add the relevant normatives in comments.
>
> Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
> ---
>  db.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e331d4f..3b0adbb 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -321,8 +321,8 @@ country BO: DFS-JP
>
>  # Source:
>  # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-rest=
rita
> -# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resol=
ucao-680
> -# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-p=
rodutos/2017/1139-ato-14448
> +# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-reso=
lucao-772
> +# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnic=
os-de-gestao-do-espectro/2024/1920-ato-915
>  country BR: DFS-FCC
>         (2400 - 2483.5 @ 40), (30)
>         # The next three ranges have been reduced by 3dB, could be increa=
sed
> @@ -331,7 +331,7 @@ country BR: DFS-FCC
>         (5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
>         (5470 - 5725 @ 160), (27), DFS, AUTO-BW
>         (5725 - 5850 @ 80), (30), AUTO-BW
> -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> +       (5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
>         # EIRP=3D40dBm (43dBm peak)
>         (57000 - 71000 @ 2160), (40)
>
> --
> 2.49.0
>
>

