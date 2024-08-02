Return-Path: <linux-wireless+bounces-10857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874029457F0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0065D1F26392
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E29249EB;
	Fri,  2 Aug 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buB77uHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526D1757D
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578894; cv=none; b=bdNaw6bqVMO5YpKJdziJBhxFHm6Lg0MlePelL2AtKqKDtsD/cNXGzUg2Uwu2I/zHHt/guqh/QSfvEMLJTeq9dTwbbbyfyz/77D+WXBx0tUb18DOaDRombc+zqnh4Tv+rnz8BCd+8CZZxCYBH944Pl2h6yC9MJPnGI707kITAorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578894; c=relaxed/simple;
	bh=c4e8teUD0jAB7JlTPOFgNNZ8swqdDVwaKz5zU5WmRpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDHypHFdtWoDJjaYZScjqTcXqwEt2+ExibwVAv0ardN9N7TJNRbcKeiGeFGUHHqANpRx/G6vErgJOVwtGR0B/Gmor3aVFmBTb2F+BrtHxwq2TIm529esV5bv55j7z1bC1BcZIUOlZChlmD1dxzPnWp8bWV/LM3qxfy0S38Ahtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buB77uHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD582C32782
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 06:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578893;
	bh=c4e8teUD0jAB7JlTPOFgNNZ8swqdDVwaKz5zU5WmRpI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=buB77uHh0G/7OyqwRtmjmdREklMxf6Zjgh/SDzaRUaTs075CfRqL16DWWXihubAZy
	 RS4SQ55HgOxW+ZNcvC7qvRnJXGOOxxPKKF2bTU2zvYWlRnJjggG3MUaR/Va24eUUWz
	 znP4nJf3XhKeYvZAWLF7TK86JNiS6X1KtfS74uJOQMOB71b9N8FLaLFS8IVLWkaRvd
	 7k+lwdHb5280xTaaCV/jgBnmScXDuBf3lzRD2xp3LbovB0mVllNmlEk3TACd1ezbwb
	 5BK0C5kzvNl+XygetNB5ukZnSRDdrl+jdCyeO2uOOWqfTw55PJ0CIEklZ0Fl52FyiC
	 eYE2O45lmGSdQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so98247141fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 23:08:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzzr00JpVopUOuTJ+t4/lGAySmBvlFvIdFXbBnNyQ/SAAvzZnlV
	9++cYJOrlWOmrkrtSRCvAiTMFQ8H+Nos53uCMAXCo0L2FMR+qisR3sZGDhcZ9TOliCyGTC7Qimw
	b7jEreG5L+JL3z3fcLqex9Znf6yc=
X-Google-Smtp-Source: AGHT+IF5SJPdYDaAX1xP/pbzE6Osf9Wk3WDnHayn2ZBg4XgphATxh8p0nneLQ4xTTX1IHe7gGd+DBC6Gf97kaJvEra4=
X-Received: by 2002:a2e:9e48:0:b0:2f0:33e:d286 with SMTP id
 38308e7fff4ca-2f15aa9a109mr18574601fa.20.1722578892143; Thu, 01 Aug 2024
 23:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719032326.7353-1-pkshih@gmail.com> <20240719032326.7353-4-pkshih@gmail.com>
In-Reply-To: <20240719032326.7353-4-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 2 Aug 2024 14:07:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v66QO-F6r6Ay5yLiYwFXxob6JGnv_4k-oZiZJWfboGt0pQ@mail.gmail.com>
Message-ID: <CAGb2v66QO-F6r6Ay5yLiYwFXxob6JGnv_4k-oZiZJWfboGt0pQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] wireless-regdb: Update regulatory info for Togo
 (TG) for 2022
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:24=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
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
>      (Reference [1] suggest this as -10 dBm/MHz, but this would be an err=
or,
>       becase PSD of LPI should not be lower than VLP.)
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
> v2:
>   - in commit message, describe typo that 5925-6425 LPI should be EIRP
>     density 10 dBm/MHz. Otherwise, PSD for LPI is lower than VLP.

I applied this patch for now. But could you reach out to the ARCEP to
notify them of this, and ask for clarification?


Thanks
ChenYu

>   - add DFS for all bands
>   - not split 5150 - 5350 band, and set bandwidth to 80 MHz
>   - set bandwidth 160 MHz for 5470 - 5850
> ---
>  db.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 31a051f242e5..b5e40e038d77 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1763,11 +1763,14 @@ country TD: DFS-ETSI
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
> +       (2400 - 2483.5 @ 40), (100 mW), DFS
> +       (5150 - 5350 @ 80), (20), DFS
> +       (5470 - 5850 @ 160), (27), DFS
> +       (5925 - 6425 @ 320), (23), DFS, NO-OUTDOOR
> +       (57000 - 66000 @2160), (40), DFS
>
>  # Source:
>  # https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> --
> 2.25.1
>

