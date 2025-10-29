Return-Path: <linux-wireless+bounces-28352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E2C1877F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 07:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CD564932
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10632304BC3;
	Wed, 29 Oct 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7HiuQdZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D82F9D88
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718931; cv=none; b=UI0ljBf3xGiOp/fzWyHCmUXI0z04SmhFmsmNrhxsSP7QzYT1wRf3kUeaUTdjlbcorYv1FVbqmAaq3rhVatYJbxHCEzVOAXCHWWmwlXlDzz2GQiwdyju4iXlXGYWLYsoJlhsUSNPjVGm8jN0GLyLvdzys6jVnCH/ZRCgY/8DtZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718931; c=relaxed/simple;
	bh=WuDi709DAU2mN/xMZ5/FScYJ4OESH8QLsWWVBqG0faA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiertvnsxAAG9PbJd4qfw0b4qckiQGdWUOLQmI5+Iz/G4oIf4crrHAc6AqgJm6sB6lBjCuKVaPbpSea4d5PDLjJc1rQ0Ir7CiHbmGKL2UZi2ANCk6RQcULB1gbkbaLh9aWTVYmxAtX2i03+2iFT381adrGNYfzJIoiqr9OZzQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7HiuQdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61044C113D0
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718928;
	bh=WuDi709DAU2mN/xMZ5/FScYJ4OESH8QLsWWVBqG0faA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=s7HiuQdZ1OIVcvifgPBecEM402sNjWRw3BqxYyrwmF/nVLgSmbxdtL6yAgb5QEm/a
	 J2jeIq7Jc+XWJTFiy2r8qp0eQNph4cgcRUrqwGRW7TKextfaG6R6bHfFDtnMOUlJXI
	 dj6ae09lea0sIDTKijQaflQq5qPnFlJzGDoIDgYA4nkwpIBEylIf2oW0v/+45XCDLl
	 zzSzCC3MGdD7OmXemWuI5UcHYnRt2supkIrPX5fiRCCSwDOYf78VInwEWhWB541PKZ
	 KksFTRfeRafa45lnRzD1tqE+RMAVoqn97oDONNl09Fd5gc6e/EslhfGO9cHJ9f+xm0
	 0sx6U1/XhCMiA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3696f1d5102so60231481fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 23:22:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YyK/urh0aVs4ptAUmpd8x3FljtihT8F9SN07uykVTE83UX6wHav
	qiheT2z1+Q6vVeSYfviGL0pm+zcrhQTh0Mr2ag04eojOEJvnykLtcOQplzqbeH1omQH+r14iIE3
	4oi9VetDX4QOmS5jp2tIhvc5wK26VGPQ=
X-Google-Smtp-Source: AGHT+IFHCCGvwM5ocGuIIQOSNFb+hpCGUi4ju3lirL7hSCfq/20s0IGYf4W9x5S75wdzG2BEohks3CAzwjNgZEsHgzg=
X-Received: by 2002:a05:651c:3617:b0:36d:54b3:9f81 with SMTP id
 38308e7fff4ca-37a05348c18mr6769971fa.41.1761718926730; Tue, 28 Oct 2025
 23:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029012429.68658-1-me@ndoo.sg>
In-Reply-To: <20251029012429.68658-1-me@ndoo.sg>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 29 Oct 2025 14:21:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64omSs0uVL00n7vGRF_-=qb8xLCjdnyWRq_Caukf2ntXA@mail.gmail.com>
X-Gm-Features: AWmQ_bknpj47qEd79LRPpA6POhAidQbwqDEshKGkhSzjkaVtJEwRyifGvfFXrn8
Message-ID: <CAGb2v64omSs0uVL00n7vGRF_-=qb8xLCjdnyWRq_Caukf2ntXA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY)
 for 2025
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:24=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
>
> Malaysia Communications and Multimedia Commission announced CLASS ASSIGNM=
ENT NO. 2 OF 2025[1].
>
> With reference to class assignments on pages 9 and 10, and Power Spectral=
 Density (PSD) limits on page 20, update the following rules:
>
> 2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
> 5150-5250 MHz:
>   1. Align previous 5170-5250 MHz rule to class assignment
>   2. Mark as NO-OUTDOOR
> 5250-5350 MHz:
>   1. Align previous 5250-5330 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcula=
ted at 20 MHz channel width
>   3. Mark as NO-OUTDOOR
> 5470-5650 MHz:
>   1. Align previous 5490-5650 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcula=
ted at 20 MHz channel width
> 5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
> 5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD li=
mit of 12.5 mW/MHz)
>
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment=
-No-2-of-2025.pdf
>
> Signed-off-by: Andrew Yong <me@ndoo.sg>

I applied it on top of your previous patch. Conflict resolution shrunk
the patch down to just the URL change.

ChenYu

> ---
>  db.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 1d17271..dc72989 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1450,14 +1450,16 @@ country MX: DFS-FCC
>         (5925 - 6425 @ 320), (12), NO-OUTDOOR
>
>  # Source:
> -# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf
> +# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-=
No-2-of-2025.pdf
>  country MY: DFS-FCC
> -       (2402 - 2482 @ 40), (500 mW)
> -       (5170 - 5250 @ 80), (1000 mW), AUTO-BW
> -       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
> -       (5490 - 5650 @ 160), (1000 mW), DFS
> -       (5735 - 5835 @ 80), (1000 mW)
> -       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> +       (2400 - 2500 @ 40), (500 mW)
> +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
> +       # 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW reaches=
 the PSD limit of 10 mW / MHz at 20 MHz channel width
> +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
> +       # 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW reaches=
 the PSD limit of 10 mW / MHz at 20 MHz channel width
> +       (5470 - 5650 @ 160), (200 mW), DFS
> +       (5725 - 5875 @ 80), (1000 mW)
> +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
>
>  # Source:
>  # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> --
> 2.50.1 (Apple Git-155)
>
>

