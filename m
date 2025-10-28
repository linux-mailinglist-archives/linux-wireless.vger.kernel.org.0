Return-Path: <linux-wireless+bounces-28331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C4C12ED3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E175B1AA4481
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 05:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17E1FA859;
	Tue, 28 Oct 2025 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LspUgPhr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544EE1EDA02
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628775; cv=none; b=BmviVX5CcPe6UCeV76n/ZmLpSU1S/tQMQBb4KLdS1t62AnWQn9tSKBYQFTuVfnJRriqdqtxBw0+sHygCWsgZaN8P9tkkUAVf+HHWlvdWuTb5HxTZ073e2UtsL6KGA8CtVAkPjdNaNksgzjzij8Y54d/NID1hdGl81h1rgHP0fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628775; c=relaxed/simple;
	bh=e846JwhJGQnPRCxnOQ3YEesDevoWZto01oO8ElGrLJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebEoSWr+vn5ObHK561+fRX07UHJaJM20Uj2T7C6DzCtzDiMRAYDTDSjX7KCljPBkjgr2R5lyWvaf8l8Cr/ZvY2eXy6NLiOF9uTkuDQkXw7xQLCZnfHNrXSNU5NQ/WIzDdwzSUZklka+KIigGLhX2Fy4SminZp7K9vvZhNEjqnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LspUgPhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3546C4CEE7
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 05:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761628774;
	bh=e846JwhJGQnPRCxnOQ3YEesDevoWZto01oO8ElGrLJQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LspUgPhrrepZy2gxTu0Uldd9Z0vNFVduq7SNirdFmT8Q5EdSBc8JJTZGlAYvoHdzS
	 eFgfpWtAony39UirE0UHxXXfWXyDl9EP0alWperzzVPqhwUCRYexKAzn03y1+hD1ci
	 hEQsecl867iJTxVnfzTUMKWMHpiIqi2gIgkHpoXKTQdTudxuFsCyFkQWGZR7hx5n0N
	 DAC6MKJi4yWJmNIhxVfXmouobvHzBJX5x6UqxCMz4AbHgV/L6bixoXMl7r+KpZE8y7
	 3XbOnpLtZ+ptjGXkjFC5V9Fvab1l6k7I4M3ib7UCyZnTb+OH5eYdIUzuuFrdbaPslK
	 kKPTrj6xhM0JQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d50e1c82so55317661fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 22:19:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzAXVCuwogNtS8N9ALAd5E2b7z1sYivxk6TLjOQUGIToCdd77vo
	YcRGJL2GazD71wPbwfXNuI4jH9taTzIsf74EUI5X6yUr3AwzaX8tT/vokKA+eozRTe18xGHnJSQ
	UIdCtGTP3dxQbr2r4g2traxFIqXabC7I=
X-Google-Smtp-Source: AGHT+IEIm1k8rbh6K/Q+N1se02uR5tEMyyKNUh5mPGwoZSaVNZu228ng9HkSFP8vwf2JU4vBsf6No0gjwOfOhuEbeIE=
X-Received: by 2002:a05:651c:440d:20b0:375:d985:7009 with SMTP id
 38308e7fff4ca-37907780dcbmr5921791fa.44.1761628773212; Mon, 27 Oct 2025
 22:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028020901.44906-1-me@ndoo.sg>
In-Reply-To: <20251028020901.44906-1-me@ndoo.sg>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 13:19:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v64yJ_UDdAL3n2CbbOoEbZFxRLQ07QnmF-WgtLiW=VxMOQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmaVfeN6x_eRRZFde7mHcCOqB1disY77tTO64RDr6F7cD1VGejmCyMsVrg
Message-ID: <CAGb2v64yJ_UDdAL3n2CbbOoEbZFxRLQ07QnmF-WgtLiW=VxMOQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY)
 for 2024
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 28, 2025 at 10:09=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
>
> Malaysia Communications and Multimedia Commission announced CLASS ASSIGNM=
ENT NO. 1 OF 2024[1], with the following changes to wireless SRD frequency =
class assignment(s):
>
> 5925-6425 MHz EIRP has increased from 2022 assignment[2] of 200 mW, to 25=
0 mW; refer to page 10.
> 5150-5250 MHz EIRP of 1 W has changed from 2022 assignment[2] of indoor &=
 outdoor, to indoor-only at 1 W; refer to page 20.
> 5250-5350 MHz EIRP of 1 W has changed from 2022 assignment[2] of indoor &=
 outdoor, to indoor-only at 1 W; refer to page 20.

Based on page 20 in schedule two of 2022 assignment, this should have
already been limited to indoor only.

> Update limits of existing entries accordingly.
>
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment=
-No-1-of-2024.pdf
> [2] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-sign=
ed_19012022.pdf
>
> Signed-off-by: Andrew Yong <me@ndoo.sg>
> ---
>  db.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 1d17271..a65910a 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1450,14 +1450,14 @@ country MX: DFS-FCC
>         (5925 - 6425 @ 320), (12), NO-OUTDOOR
>
>  # Source:
> -# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf
> +# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-=
No-1-of-2024.pdf
>  country MY: DFS-FCC
>         (2402 - 2482 @ 40), (500 mW)

Please also align the rule boundary with the official rules. This should
now show 2400 - 2500.

> -       (5170 - 5250 @ 80), (1000 mW), AUTO-BW
> -       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
> +       (5170 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR

This should show 5150 - 5250.

> +       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW, NO-OUTDOOR

This should show 5250 - 5350.

>         (5490 - 5650 @ 160), (1000 mW), DFS

This should show 5470 - 5650.

Also, for bands 5250 - 5350 and 5470 - 5650, the PSD limit is 10 mW / MHz,
effectively limiting the EIRP to 200 mW for a 20 MHz channel. There is
no way to describe PSD in the database, so we can only go with the smallest
channel width for PSD calculation.

>         (5735 - 5835 @ 80), (1000 mW)

This should show 5725 - 5875.

> -       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR

This bit is correct.


Thanks
ChenYu

>
>  # Source:
>  # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> --
> 2.50.1 (Apple Git-155)
>
>

