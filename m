Return-Path: <linux-wireless+bounces-24751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D535AF09B6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8624481AD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49EB1E261F;
	Wed,  2 Jul 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSPRER3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DA1E130F
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751430746; cv=none; b=ABPYyvVUHMoy4Wa9FKB4oeM2vtSz4cdsv/tIDzMYHH4nUIv+YQuB45TCK/bA/OlAA+yQ/u9M+243YAHl65GILyK1V/6UJqEet/yyaUVZnLQHmBl8na9/KnFz5tkuL0PJYF1M84xwjtroU6uNhqkFTyhG+o9F/qNy34Ww1qlcBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751430746; c=relaxed/simple;
	bh=pW5M7RB7yP26nn3ovt54nB0lYFengwwwgfq3Wa0Ayl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDwrZnJPsUxW00MFS8F0wBlzSauRgJ3kcJRfwisX+oTNMo116MfM/gf2li8vpsRaRje6rAB753ZZSLQBJWZNrCX7OP3GM6qBa+6Nf5U72LGEl4Y0nqJDcpRnsOpn4xkSvJcC2uYslcUMr9bQ53mki6FR/75x5whHQjdDWmC6xgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSPRER3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF4C4CEF0
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751430746;
	bh=pW5M7RB7yP26nn3ovt54nB0lYFengwwwgfq3Wa0Ayl0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mSPRER3t9wxVdYqgO8AAh3iHY6z7CUxh9wtpoe4eUGfpO7uEvJyZmOdHPUY4gy9Yt
	 KUlZduzQbglKuKHlytsseEYjUknGX2hHT3JKmT22SJSspajBtMxoNA25HX+itnmuv9
	 N1wODY/eRMQlbRkLOiLNB2R5kI28uKAunr1Y/jYnMGTIPzQOlvLWf1lUv23X9tYaDa
	 Z7/uo7KFHBRQ5FjRPVI0K5tj43oxMFC/2S2cKTWrcfI0n3bzznT9OIbY1xju+tufcF
	 NJvt04AuDxwdDjJzcAUIrDitvn67E8jQBqT+6Z77wN9ztzAMcGTT1+vkL77DTVJ9gO
	 JiGkdRfCA0b+A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so35770201fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 21:32:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4b0krcdOXLhjR2OA9A/OCpeUt5H5cJ4fPPnmz7+MLP4Dx84k4
	ZN+yT+bTlJXJ5kYDnbeoliZou21Q5v2FUVn6CMtoLvG3M3aa3aHvlEpqn1vnUbax1vosm3jdXta
	aas0Rlfl7JZR7CNnwGWQSayg/M4PXR4M=
X-Google-Smtp-Source: AGHT+IFlGO4sNolgF2KA1RatvPB6wV1AHaPeP1a3aJaT5obEfpzFYbBkapw3+tRs6mBRepvGR1gc3MT6642g+4tPabg=
X-Received: by 2002:a05:651c:2204:b0:32b:3c11:5177 with SMTP id
 38308e7fff4ca-32e00044a77mr4933951fa.21.1751430744564; Tue, 01 Jul 2025
 21:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618054904.9107-1-pkshih@gmail.com>
In-Reply-To: <20250618054904.9107-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 2 Jul 2025 12:32:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65E7K0yRz==OTyBd_LCWwU+0MYWSivgJG4x70gS1Cp93w@mail.gmail.com>
X-Gm-Features: Ac12FXylc4Od60Knly9PgbYZ86cMiQLma7woh9tu6U68rpRSCN2PyCv_VqoWow8
Message-ID: <CAGb2v65E7K0yRz==OTyBd_LCWwU+0MYWSivgJG4x70gS1Cp93w@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Egypt (EG) for 2024
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:49=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> National Telecommunications Regulatory Authority (NTRA) released Radio
> Spectrum Guidelines for Short-range Devices (SRD) on November 2024.
>
> As Table 4 Mandatary requirements for Wideband Data Transmission Systems:
> Including Wireless LAN (Wi-Fi and Multiple GIGABIT wireless systems for
> Indoor applications only)
>
> * Wi-Fi for indoor applications only, so add NO-OUTDOOR for all entries.
>
> * 2400 - 2483.5 MHz
>   - 100 mW e.i.r.p.
>   - EN 300 328
> * 5150 - 5350 MHz
>   - 200 mW e.i.r.p.
>   - DFS and TPC in 5250 - 5350 MHz
>     * for devices without TPC, the limit is lowered 3 dBm
>   - EN 301 893
> * 5925 - 6425 MHz
>   - 250 mW e.i.r.p.
>   - EN 303 687
> * 57 - 66 GHz
>   - 40 dBm e.i.r.p.
>   - EN 302 567
>
> [1] https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November-2=
024-SRD_English-1.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e331d4f763e3..4a05bdca781e 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -632,11 +632,13 @@ country EE: DFS-ETSI
>         (57000 - 66000 @ 2160), (40)
>
>  # https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-=
SRD_English_Final.pdf
> +# https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November-20=
24-SRD_English-1.pdf
>  country EG: DFS-ETSI
> -       (2402 - 2483.5 @ 40), (20)
> -       (5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=3DETSI
> -       (5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=3DETSI
> -       (57000 - 66000 @ 2160), (40)
> +       (2402 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
> +       (5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=3DETSI, NO-OUTDOOR
> +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW, wmmrule=3DETSI, NO-OU=
TDOOR

The database parser requires the wmmrule flag be the last flag for some
reason. I fixed it up locally and will force push it out.

ChenYu

> +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
> +       (57000 - 66000 @ 2160), (40), NO-OUTDOOR
>
>  # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 30=
1 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 4=
40)
> --
> 2.25.1
>

