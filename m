Return-Path: <linux-wireless+bounces-9356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79B911BDD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760F01F20F0B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944F13C802;
	Fri, 21 Jun 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL9xa3Ev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E639FD0
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951760; cv=none; b=nm21U65Bah3kpwyMYO5fRlnZbdx74qPwdsJYlWtCy7iwnv2q7yeQfefik1uzPvYDrwpAsP3IJu8xBv8hGD0RdvbEE+7OdKe+nQdixlXACkY0F6pldQu1i642GIeDOxF4TgO8jPMUTuLBKePG2/Tqjl0vVat7nwDFQsyVYyC+ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951760; c=relaxed/simple;
	bh=CpxIUIKVNJ7xjoieIHwYd3Q2dxYqbJt/GmPcYfMhMzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqe27PMsbeUcGCsMeiY+5bHVvoMlB5cAEnAXNo74kB4qou1B52WJMkKeWSvupq6gZDGobaah+basnKYCDIaHYwTa8Z3Goal9QYdFwCQ0CQ47dv3/JYjGmAHOLxcqWRSk7ZPjvE3v+JgT4zlccWBHbxRB1PEA7k5sJWUvEdVGbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL9xa3Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A563C2BBFC
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718951759;
	bh=CpxIUIKVNJ7xjoieIHwYd3Q2dxYqbJt/GmPcYfMhMzA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=OL9xa3Ev644q9/s7vi5yOyyP4OSy8pFN72VxQ9bARJi6BNzd0god1SxhziTvad0up
	 WjaOSLaU8gYe3Pc3KzQYQldfcwmSj6hPw+YNPZcxxunBNsfvrdfXHy8aUKCydqcHif
	 JYsT75/1KefDupFITjUlxmnfUXbufUzSLzi2Z5+rWCHX4BPxBgvOC0PJJ3hrn6H8iU
	 ddNpVuZ7fAwGXjMxBfG5D9eVFNVQoD1IOpYFkJllQaU/uK2nNhUeGKWvuJdlLGQAwa
	 quop09NsXIDp2mrJ06SAt01wKywxbU0lteDVdLlCbylzq/aVpQCYEzlJ1s7n1xScDN
	 pmj3u5//lT4Xw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso15871191fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 23:35:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMfIC/WM+vDUIKY46pQD2EZWfvDKCoJQc7kYn+w3I6G2RI4+9s
	mb9Q5K/KwmwXbDKkwfuTjnP20rDkMmyHMRY0F5bRB66gHAmxHmRxPLW/DDvXBldpQmOrR0iaP9J
	OVBIgVhvW2E2Xq01YuykYdgbs0PE=
X-Google-Smtp-Source: AGHT+IGsmatlzmU52ckrEaR/VMP+CqQ9uYuaaJn+BOGKI0KcjwEB3ljWwTDEcmTJhMKHaKdbAozxtWoGh26FWdjnEqg=
X-Received: by 2002:a2e:7317:0:b0:2ec:1890:5e6 with SMTP id
 38308e7fff4ca-2ec3cfe8a38mr44537831fa.39.1718951757946; Thu, 20 Jun 2024
 23:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621052205.28925-1-pkshih@realtek.com> <20240621052205.28925-5-pkshih@realtek.com>
In-Reply-To: <20240621052205.28925-5-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Jun 2024 14:35:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Ww8T61e--YXaFRZhxHH-_d70P=2CArVv5FeQe=Vv8dA@mail.gmail.com>
Message-ID: <CAGb2v67Ww8T61e--YXaFRZhxHH-_d70P=2CArVv5FeQe=Vv8dA@mail.gmail.com>
Subject: Re: [PATCH 5/6] wireless-regdb: Update regulatory info for Macao (MO)
 for 2024
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:22=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> MACAU SPECIAL ADMINISTRATIVE REGION OFFICE OF THE CHIEF EXECUTIVE release=
d
> Order from the Chief Executive No. 64/2024, which wireless data
> communications equipment defined as
>
>  - 2400-2483.5MHz 200mW
>  - 5150-5350MHz   200mW
>  - 5470-5725MHz   1W
>  - 5725-5850MHz   1W
>  - 5925-6425MHz   250 mW (for indoor use)
>                   25 mW (for use in outdoor spaces)
>
> [1] https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 5603933e3563..c7371e568b4d 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1252,12 +1252,14 @@ country MN: DFS-FCC
>         (5735 - 5835 @ 80), (30)
>         (5925 - 6425 @ 320), (100mW)
>
> +# Source:
> +# https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
>  country MO: DFS-FCC
> -       (2402 - 2482 @ 40), (23)
> -       (5170 - 5250 @ 80), (23), AUTO-BW
> -       (5250 - 5330 @ 80), (23), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (30), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (23)
> +       (5150 - 5350 @ 80), (23)
> +       (5470 - 5725 @ 160), (30), DFS

You removed DFS for 5250 - 5350, but kept it for this band. Any
references for either way?

Please extend this range to 5730, so that 160 MHz operation is actually
possible. See TW region for reference.

> +       (5725 - 5850 @ 80), (30)
> +       (5925 - 6425 @ 320), (250mW), NO-OUTDOOR

Please use values and units as given in the reference.


Thanks
ChenYu

>
>  country MP: DFS-FCC
>         (2402 - 2472 @ 40), (30)
> --
> 2.25.1
>

