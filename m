Return-Path: <linux-wireless+bounces-9358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4C911C5E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5A1C2097C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3514038F;
	Fri, 21 Jun 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAsaszaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D983A14
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953356; cv=none; b=hVEmiECTfCXRqG5AHkyWTWct/kjXJW7C1eQesUw9QenCN9L4bUGPVQS7NSbsa9nSPc5LEk0SfWqI8SD0WdWy9rP4htoceZMbkTpnGo4bR18oJaxPAXVHVIztVo3FT473j9iKjfY0hDlT7ySgmOk7z+U38u7PG6sHXJYEFB3FrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953356; c=relaxed/simple;
	bh=cjFoquWs0UAC1TkIyDENxGPXx6eXdKMts+RAwAKA4xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3XOxZERF72qMjMPRSv4dqQ6B3RlEa2wbc2n52wiRLqh0pBeiehhuaYPXovXrTdar6P6nP7JhRVhtkDeDZXLvqoJdjRaNh+/7409BBm53QzA4WGwuJlC+08tj2qyZKxOEoSDfJ+7ov/vBT60Ok9BcRvjrGjTFeSQeuWw9NYBImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAsaszaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DD6C4AF08
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718953355;
	bh=cjFoquWs0UAC1TkIyDENxGPXx6eXdKMts+RAwAKA4xE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=CAsaszaj5YV+w9/IgSzmW8a7cAvR5Z3/AljC3KbC2tw83bjKGZ6VE+cZq/ba8a9RV
	 PJ1Rqr8nQb4EKj9T0rBC6szKKThBfc7UHMRBo1rklhcd/PBunQs/Z5fCCvrvJ3PTmQ
	 OI+m+376idtSLIAc01Ne9VNJAr2B935sp9cdmQAu5fk2lNi4i0VgRn0S68MRyM3LmK
	 OHsPb1ZW08DTCSlUVNrfi/gDQMmF3D0/6n8Nc714xqpraizrPcH0pqEwIZdFA9w5Kh
	 PET6CCvPDMeCBPIKHo5Itzp4oLTJIgDSoE6EtA7QlJpSqhJZLz6dpXZ1xRJSLGpLUK
	 GmqFxbcoTQjWw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e724bc466fso18346241fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 00:02:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YyG66vI9XT9Z4h1FWpDhUjkZ9nz6K2J+2FF1KgrBR9AoSvPpMQr
	xb/Di+Gk4NiKBdRIgUbmi581iGmTXTQQTlR9RFzN0f8LVbeOeX5tNA15FrNjSjIluBssFUksTfN
	7yBmKSsyI2mwE+ymaJIlVcC/nOQI=
X-Google-Smtp-Source: AGHT+IFijSbgDFV7HHH2CHmlkvJWQ66KSmEaZMxvggnZgVgJuWdh8jhckSYvxXVry7wlhqTZ4XrAPlFO4U4X8X8se38=
X-Received: by 2002:a2e:a26c:0:b0:2ec:3daa:f0b4 with SMTP id
 38308e7fff4ca-2ec3daaf51bmr51477631fa.12.1718953354046; Fri, 21 Jun 2024
 00:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621052205.28925-1-pkshih@realtek.com> <20240621052205.28925-4-pkshih@realtek.com>
In-Reply-To: <20240621052205.28925-4-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Jun 2024 15:02:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v65D3Ywj6RXbPZSo=Owc6=HAuGjOYmTX9E=ndXLqTy3R5Q@mail.gmail.com>
Message-ID: <CAGb2v65D3Ywj6RXbPZSo=Owc6=HAuGjOYmTX9E=ndXLqTy3R5Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] wireless-regdb: Update regulatory info for Kenya (KE)
 for 2022
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:22=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Communications of Authority of Kenya issued GUIDELINES ON THE USE OF
> RADIOFREQUENCY SPECTRUM BY SHORT RANGE DEVICES on JUNE 2022 [1].
> The section 5.8. covers frequency bands and technical parameters for
> non-specific short range applications and wireless access systems.
>
>  - 2400-2483.5 MHz: 2W e.i.r.p.
>  - 5150-5350 MHz: 200mW; max e.i.r.p. density of 10mW/MHz
>  - 5470-5725 MHz: 250mW; Max mean e.i.r.p. of 1W &
>                   Max mean e.i.r.p. density of 50mW /MHz
>  - 5725-5875 MHz: 23 dBm/MHz; Mean e.i.r.p. of 2W in any 10 MHz band
>  - 5925-6425 MHz:
>    * LPI: 23 dBm (200 mW)
>           Mean e.i.r.p. density for in-band emissions 10 dBm/MHz
>           Indoor only
>    * VLP: 14 dBm (25 mW)
>           Mean e.i.r.p. density for in-band emissions 1 dBm/MHz
>           Indoor and outdoor use
>
> [1] https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Us=
e-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index a742498c1116..5603933e3563 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -982,11 +982,14 @@ country JP: DFS-JP
>         # ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v=
1_1.pdf
>         (57000 - 66000 @ 2160), (10 mW)
>
> +# Source:
> +# https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use=
-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
>  country KE: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (23)
> -       (5490 - 5570 @ 80), (30), DFS
> -       (5735 - 5775 @ 40), (23)
> +       (2400 - 2483.5 @ 40), (33)
> +       (5150 - 5350 @ 80), (23), DFS
> +       (5490 - 5570 @ 80), (24), DFS

This does not align with the range given in the reference.

> +       (5735 - 5775 @ 40), (23), DFS

This does not align with the range given in the reference.

Also, for the 5 GHz and 5.8 GHz ranges, TPC is required. If we reference
ETSI EN 301 893, TPC requires being able to reduce TX power by up to 6 dB.

Not sure if it makes sense to just lower the power limit by 6 dB to
conform though. If not then these bands are not usable.

> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR

Please use values and units as given in the reference.


Thanks
ChenYu

>
>  country KH: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

