Return-Path: <linux-wireless+bounces-13308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB538989B70
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5651C21048
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77115666D;
	Mon, 30 Sep 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poGF7n5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6E156653
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681285; cv=none; b=jYYriPwBktgpdRcXSyvuIedeBH+wYMMKgEwHIUsLMJ8DM4M5qgRButJaZ5uYo1zybZlhBBhO0tP/SDsgSrQ9oa7ZdS6r0wTNSJWMnXEvDSvd7Pk4Vl4eBcM9cvCrIbt+ncHcot0v0Esc/OXQjCvYLTPgRqjP4HgNIK+kY0zHoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681285; c=relaxed/simple;
	bh=bp9KCKXii67v3/vDEihavE3KCdD3KTTpeEisYQUdC4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRhIifsTRmMQdwNCT2F0e6D7tBGk80l4rHxdsPFh02++flk82Csy8PZFODAgQgE/OzGlNgAvGDCAgYtIFhssErH4Js1Y3/wjC03VI2Y8+8jtmJCfYVUZY4GmxPWz1l3+JtAwLS1DRBkpz5PliGm6DOzsHbvlyC6TiIRckFgeA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poGF7n5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA1C4CECD
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727681285;
	bh=bp9KCKXii67v3/vDEihavE3KCdD3KTTpeEisYQUdC4I=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=poGF7n5ZU+bxkk3h8I0CaXL9I8GAH0m+QrE7TVk25D/Am/w/MhoUFDyN7Z7na0Imv
	 nG0vsvu3gvem2YFMctQ96+g+i/aB6IaXdAZAWMReamrr4ohPIl1ApNCuyaNvHBe2Bj
	 ihRzFRCkBNg6t4AcrR+Jl8m6qKaYnj/ieGSTu88yPOq3qvqw270pH620s1ECZPHwAE
	 Uw1aX7WfuNmz7DhAk+qoG5JAt08tg+YLLj2Zxab9K+ASGH34qNBWdVB5Vl5IQvOa+3
	 tLKVwNdSw2DaxD+Idv7NUgqw/t7AZPFaQwY/1ogfOl62cX9dcv05zhgJmCphDE+Dsk
	 tqNWJvN9B48OA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2facf48166bso5947511fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 00:28:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZkAR5usjfEbsATsPGkW9GIsWp6i6DDCQc3dK5/ecAbJFS9zpE
	qmM8eJD2F2uzkuTOimOC0chYWxHXE4j8S2a8HKCrHAIPgMBuhdb5COEYiG6rj23UXwSiLSMx700
	hMz8PGuECnj+3GLqGscxuG4FI/A8=
X-Google-Smtp-Source: AGHT+IH//so7C5w0elx54PI9QPgLWCTlklPjTP19OEr8uRzdp3U2Bd/vMYHtvDy4QoLOLSDorTEEHtSPv++OYs4pqDU=
X-Received: by 2002:a2e:6111:0:b0:2f7:5890:b15a with SMTP id
 38308e7fff4ca-2f9d41afef6mr41251751fa.38.1727681283517; Mon, 30 Sep 2024
 00:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902082304.52326-1-pkshih@gmail.com>
In-Reply-To: <20240902082304.52326-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 30 Sep 2024 15:27:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v64R7FVjEWxXzSercJfnU8bASUAM1chkoMdY8-0WOKvJGg@mail.gmail.com>
Message-ID: <CAGb2v64R7FVjEWxXzSercJfnU8bASUAM1chkoMdY8-0WOKvJGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] wireless-regdb: Update regulatory info for Serbia
 (SR) for 2024
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:23=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Serbia government released radio frequency range on February 5, 2024 [1].
> Based on Article 100, paragraph 5 of the Law on Electronic Communications
> and Article 17, paragraph 1 and Article 42, paragraph 1 of the Law on
> Government.
>
>  * 2400 - 2483.5 MHz
>    - reference [1] page 114-115, section 2400 MHz - 2450 MHz, 8th row
>      * EN 302 328

          ^ Should be EN 300 328

I can fix this when applying.

Thanks

>        - 20 dBm
>  * 5150 - 5350 MHz
>    - reference [1] page 120-121, section 5150 MHz - 5250 MHz, 8th row
>      reference [1] page 121,     section 5250 MHz - 5255 MHz, 8th row
>      reference [1] page 121,     section 5255 MHz - 5350 MHz, 8th row
>      * EN 301 893
>        - 23 dBM (Without TPC)
>        - 5250 - 5350 MHz, DFS
>  * 5470 - 5725 MHz
>    - reference [1] page 122,     section 5470 MHz - 5570 MHz, 8th row
>      reference [1] page 122,     section 5570 MHz - 5650 MHz, 6th row
>      reference [1] page 123,     section 5650 MHz - 5725 MHz, 8th row
>      * EN 301 893
>        - 27 dBm (Without TPC)
>        - 5470 - 5725 MHz, DFS
>  * 5925 - 6425 MHz
>    - reference [1] page 124,     section 5925 MHz - 6700 MHz, 6th row
>      * EN 303 687
>        - 23 dBm, LPI
>
> [1] https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utv=
rdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
> [2] EN 302 328 https://www.etsi.org/deliver/etsi_en/300300_300399/300328/=
02.02.02_60/en_300328v020202p.pdf
> [3] EN 302 066 https://www.etsi.org/deliver/etsi_en/302000_302099/302066/=
02.02.00_20/en_302066v020200a.pdf
> [4] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/=
02.01.01_60/en_301893v020101p.pdf
> [5] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/=
01.01.01_60/en_303687v010101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>   - update commit message: list page/section/row for reference
> ---
>  db.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 9a55f6b8cc98..ad8dddc9c800 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1758,11 +1758,14 @@ country SN: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvr=
djivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
>  country SR: DFS-ETSI
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5490 - 5710 @ 160), (27), DFS
> +       (2400 - 2483.5 @ 40), (20)
> +       (5150 - 5250 @ 80), (23), AUTO-BW
> +       (5250 - 5350 @ 80), (23), DFS, AUTO-BW
> +       (5470 - 5725 @ 160), (27), DFS
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source:
>  # https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucio=
n-de-frecuencias-t-0408-2023/
> --
> 2.25.1
>

