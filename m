Return-Path: <linux-wireless+bounces-8479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478AA8FAF37
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E561C211D1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179F14386E;
	Tue,  4 Jun 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVtSci9c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2E143759
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494441; cv=none; b=OVpKVUiMYZc+q/yDKPSaC9qz/t+uUxWhO7lAqOPmlljaX8fKRGJoJKbGu5WC5XXBX5yXswLwUGHqhDGY6XLCRJAzHkdT4Q1oBgsCw+NHA1AMw2056T7YNB+ycV8dCwOdp8G28teZ3kksSU/cYtpsiVTX+mi7rLOMFDIDz5QY7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494441; c=relaxed/simple;
	bh=gV/s0gTHzfrAqjPHGzD+HluRoVjakFEe5wjs/8B7mOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THraPmcbF9WUPUfHTuImsuYVuwLX8y6HQcERwTrT9A+AwkYefW0zszBeAMTu2mmM84EVP4GbO6vqBx/lnLEQmIsdXPt1DF/4RG9Hrc8jZh8P/NGDU1lOp/LUcVcZN/vExqszmaCzMJKRtrHvdCILfUOiP6jqEXFjcTMydlCqhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVtSci9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23127C2BBFC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717494441;
	bh=gV/s0gTHzfrAqjPHGzD+HluRoVjakFEe5wjs/8B7mOE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=RVtSci9ckfBFt27p6qn+ZfXa6x5u5hbApNj+bffcsTnLYYDqt47tkRgZ9zwMUKWsC
	 fZbaOoS/lgByqOVG7OPsIcjmuZDVWOnc2LxKX7/r5RUCyIWd1iZaCbe5nVD8xgyL4f
	 nGlHPm3GhJFbXefl4fuxBqK01zj7QIPlgL9j9Tr8Q1ZkcdYe5A32FYGoHV9jIa/ZKj
	 HlxZKRq6LDWk5vjbmBPu5Ez4mT2UisPval5x4t1GTKAt9holVL3Fy2Gdg1eu91d1qO
	 opbcwhXzWpkDlxGK5eVH5X3VF236TGLsOJLEW2+c2h5JRnZR/f2w87I9I2JMNohPRm
	 yLkOKnaH51qQg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso74064201fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 02:47:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4O06UQN/LvIbJj54/OrIypbYuIfJ7P5jtNw58heKprPfGeg9D
	xRVTtlmqbSNGxsm3u/+RvPzm7hF0h1o88BAWVdshek+wpK8JkpbvuXFW4cGoHjO8N+2W4urIKLy
	1OgDXKusfl0J5FwVUjnF11ik9Zsg=
X-Google-Smtp-Source: AGHT+IEJUzjVtKnXfAvlrJA7Ti0ZbA+DMweV3NWxNJZ+e8ablHroJuHc4uxh+VerEFIm5nTfKwinDS4a2iRIOLQLD68=
X-Received: by 2002:a2e:8e6f:0:b0:2dd:cb34:ddbc with SMTP id
 38308e7fff4ca-2ea95202c06mr80818131fa.48.1717494439507; Tue, 04 Jun 2024
 02:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com>
In-Reply-To: <20240603060558.98791-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Jun 2024 17:47:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Q_MRBUEU=M5M_74dr0JOKnRgGECZrR6uSecTdHaN1WQ@mail.gmail.com>
Message-ID: <CAGb2v65Q_MRBUEU=M5M_74dr0JOKnRgGECZrR6uSecTdHaN1WQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia
 (MY) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Malaysia Communications and Multimedia Commission announced CLASS
> ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
> 5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdo=
or
> use and 200 mW EIRP for indoor use only.
>
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-sign=
ed_19012022.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

For the changes in this patch,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index f27dd5214630..adfcce15e3a7 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1294,12 +1294,15 @@ country MX: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf
>  country MY: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (24), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5650 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (24)
> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
>  country NG: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

