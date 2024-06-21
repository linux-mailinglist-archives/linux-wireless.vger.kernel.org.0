Return-Path: <linux-wireless+bounces-9355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C5911B92
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFCD1F21461
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E7143C58;
	Fri, 21 Jun 2024 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX9lQolt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611312D742
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950916; cv=none; b=TDDS+g1RA3BBw+B4LkMO7NSSJh0D7V79xKzudn4/f9Y9gV8aloiVa1Ti/1KBK3XEizRXaG9tN71gop3y0YwOppep3BUvgY7O6O8+YW7hH/kSgzVsP4JqeCjeqvRhU/GLEYKnZ+e8gjEDRbXXW5N7CZoIZm0v/ShpiwRxZ8JKJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950916; c=relaxed/simple;
	bh=hMkpu0krNr2g93eZ8IM3B57N+hVlxXfT21ilDYvWVq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsetJjp61mEWgnWVjj27GeuAHnSAWz8npvS1E5wkw+ceicB1PplOvwUXPHFUfynhlKQfLGoDqwtnp233o7Ql10x7a/bhARIGjgIiSSO9jLy/QGZEq7zbSDPzstTxHfE0weRGxrGwDRfaRspKskzH0pgaKFoKhe3MoeGp6dUWYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX9lQolt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B38C4AF07
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 06:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718950916;
	bh=hMkpu0krNr2g93eZ8IM3B57N+hVlxXfT21ilDYvWVq8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=EX9lQoltpiFc3q7j93ULJKsmcCLkMw97KPsdkc79sXOn67DqN8tp/SEio66pj4o6K
	 a4KHHhkAHY7av+6Ot0ulcV1M7wsnKZlwYXsMcqkZgrHTRHbshHh5uJDTmq1Sqt5IDR
	 P7kOpza35cV/NMwoktwJ62TM2Feya/a3B7C1pI6v1LCxbUj+RhbjjC/67v/SudRbs8
	 FYGa12CaFVXUaSyz9eM5sYi0yL47cEpIfRHr0fZdhqnFaetlpsgCnP19F9O+diwklL
	 hpPdKb+LwVMaEqvFzRRpf77ZkblnibDOs0GWCicqIt5EaOawbJ0Lre/8Swz2yfQZIq
	 3a7FF0x+0QFXQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e72224c395so17507361fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 23:21:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFXPoi3JnZFkhrYZ+UWir1xZlpLdDc1T4h+EZyYp3c0rHByRkp
	PHzZWgI/LN9zRO39JhKqYn4/s8gxSAFKGQKxUyNwqJfsmQj+RhHiBdITXLXVwvJKWRiLj6JZ1KD
	OqtEw8It0Z8yaYXqnLGAjVOl4LXA=
X-Google-Smtp-Source: AGHT+IGw5UYx81r3K2ucby3YFlI+wqgzxWeOa5Pevemh0b0s2VLqCckk46850zC6AS/PpwpRA8YwMxo1ssl2bdwY2H0=
X-Received: by 2002:a2e:83d0:0:b0:2ea:e763:7124 with SMTP id
 38308e7fff4ca-2ec3ceb867bmr51106431fa.18.1718950914635; Thu, 20 Jun 2024
 23:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607023058.34002-1-pkshih@realtek.com> <20240607023058.34002-4-pkshih@realtek.com>
In-Reply-To: <20240607023058.34002-4-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Jun 2024 14:21:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65k7M0=fiJoVaNUFxKCsRQXcv7mmXjDEJ0-OnV2uTUE1w@mail.gmail.com>
Message-ID: <CAGb2v65k7M0=fiJoVaNUFxKCsRQXcv7mmXjDEJ0-OnV2uTUE1w@mail.gmail.com>
Subject: Re: [PATCH 4/5] wireless-regdb: Update regulatory info for Costa Rica
 (CR) for 2021
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 10:31=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> DECENTRALIZED INSTITUTIONS, REGULATORY AUTHORITY OF PUBLIC SERVICES,
> announced ALCANCE NO 87 A LA GACETA NO 83 (in Spanish) on April 30, 2021.
>
> For 6GHz band (frequency 5925-7125), allowed only the following usage
> applications free in this segment:
>  - Applications of low power in interiors (LPI), according to the limits =
of
>    power 24 dBm.
>  - Applications of very low power (VLP), indoors and exteriors, with an
>    EIRP maximum of 14 dBm.
>
> Also update and add limits of 2 and 5 GHz bands accordingly.
>
> [1] https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PN=
AF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index c98749442873..cdec93783b20 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -434,12 +434,16 @@ country CO: DFS-FCC
>         (5735 - 5835 @ 80), (30)
>         (5925 - 7125 @ 320), (12), NO-OUTDOOR
>
> +# Source:
> +# https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNA=
F%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf
>  country CR: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 20), (17)
> +       (2402 - 2482 @ 40), (30)
> +       (5170 - 5250 @ 20), (24)
>         (5250 - 5330 @ 20), (24), DFS
>         (5490 - 5730 @ 20), (24), DFS
>         (5735 - 5835 @ 20), (30)
> +       (5875 - 5925 @ 20), (24)
> +       (5925 - 7125 @ 320), (24), NO-OUTDOOR

I believe the kernel uses EIRP values. That means using the values in the
third column of the table in the reference.

ChenYu


>
>  # Source:
>  # https://www.mincom.gob.cu/es/marco-legal
> --
> 2.25.1
>

