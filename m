Return-Path: <linux-wireless+bounces-24532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC2AE99DE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304D41C24555
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ECF298270;
	Thu, 26 Jun 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edzd8NL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A6295D87
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929809; cv=none; b=a1hOblqejs1JtQEooe9EC/zMCFBKL3jAMioShpFN0rd/qku+II+U6loTM74TLkI5zE4lXwrfTku3NvkwWifVThQP5aNu/NWHaBEjJfjhhj96LXysTIPAreHOXjOAvsW96rkIjiv9a1HsfORe1ct8Lox1wiVQfECmZHorTUqV7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929809; c=relaxed/simple;
	bh=pysd/T9fziTMab2iG+o5tFge+/dW8jeAnLY6p8PlBUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz4I5FlxsHt/9lAl786H0Sa2a0jJ8IhjMz5+YRjKU+sZ/2/j4RcYiLFhbYh+tVq6cn1AaacHd4j8XdLoAS+VHuBrJzZDfM7Tv2fNR2oKkszS6/9vUDWkKw+BfS3jEAQZflPB+nE6S8ASKQ6jyXMnbt6pVUQ7E4FF53kDwZk7xO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edzd8NL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE9EC4CEEF
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750929808;
	bh=pysd/T9fziTMab2iG+o5tFge+/dW8jeAnLY6p8PlBUw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=edzd8NL+UX8pZGIesqteYPPPZSrMyJE0YxuHxTmu1BDOS4ywOeIx1xa1Ri0t1V+37
	 7D9p24Ek1Li/DeQwj9CeWm2L9SHx5E/EkGt+B9VQJ9Zkz1ttj9G74jjmUNjyNkpdIP
	 1KCTEEsk1fDzLSpIjNjTEgsU6tNv4Gjsj3n6BVCnEWhnVfZqODwqNE7EEYCBXyloTO
	 a6coGMaKvoMAsk9VpgjJkKYsdqAx/5Ha+4neTmg/u/l7O5tOzN7kjawIKn69hqltPa
	 QlLPGz6JRq0bfpA6srSgw88sdDh+lJ3sPOI5eKQzfgWB+9y02XCYjK5GcxpZ+Wgsgi
	 RaQpxujxJoH6A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b7fd20f99so8573421fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:23:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YwXEOu/3/O+Uswz8iVbb9scbkozmXNz7f0AU4SXfcWE7gW2E4Oj
	pBF49IJ3zvZdq/XN43N9C+YOk3mzruHrhLZY9RQZNy1wHtgj/RFVjIfCUafwDIJq1ZhYGpPwXcR
	k7BOsOs55jpNuPuPbNbwBBcY3ah9Uank=
X-Google-Smtp-Source: AGHT+IHpaH6S5K5Sm7sY0IzfQe1z9xUrcYE3c+rYHcAU+jRqbqvbdjzDEu7Zef4jAqqPK/zPxjJi/a+mkTImitDTSbI=
X-Received: by 2002:a05:651c:40d0:b0:32b:952f:3e0 with SMTP id
 38308e7fff4ca-32cd01bf1b4mr8276841fa.7.1750929807125; Thu, 26 Jun 2025
 02:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
 <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com> <ee7a2587-3e4c-4bb2-8eeb-961dbbb9ca97@gmail.com>
In-Reply-To: <ee7a2587-3e4c-4bb2-8eeb-961dbbb9ca97@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 26 Jun 2025 17:23:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v640p2zfD9T6PnmfOwJY8nMeSyY5CJNhtdW9B-+ZPNSW4Q@mail.gmail.com>
X-Gm-Features: Ac12FXyWFHzmzDicv9sLBptQqhPyUWjf2ntK8izzEnbXTTPiX83IXzjCPxKN924
Message-ID: <CAGb2v640p2zfD9T6PnmfOwJY8nMeSyY5CJNhtdW9B-+ZPNSW4Q@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
To: Marcos Alano <marcoshalano@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 26, 2025 at 4:37=E2=80=AFPM Marcos Alano <marcoshalano@gmail.co=
m> wrote:
>
> On 26/06/2025 05:15, Chen-Yu Tsai wrote:
> > On Mon, Jun 2, 2025 at 9:23=E2=80=AFAM Marcos Alano <marcoshalano@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> The rules for Brazil were based on this normative
> >> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resol=
ucao-680,
> >> as mentioned in the comments of the entry.
> >>
> >> This January came out a newer normative
> >> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-reso=
lucao-772,
> >>
> >> It allows 6GHz frequencies, so the line:
> >> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> >> Should change for, at least:
> >> (5925 - 7125 @ 320), (12), NO-OUTDOOR
> >> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't
> >> work because of this outdated rule based on an outdated normative.
> >
> > Those are very large documents. Could you help point out which sections
> > or comments apply to your argument?
>
> https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-=
de-gestao-do-espectro/2024/1920-ato-915:
> in the items IX.4 and IX.5 mentions the 6GHz frequency.

This only covers point-to-point usage. You would need to modify the rules
and add the PTP flag. Likely not what you actually want.

> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resoluc=
ao-772:
> You can search for "5925-6700" to check how the allocation is done.
> It mentions satellites, so that's why I set indoors, but maybe you
> understand that is not necessary.

This only gives the band allocation, not the requirements for each use.
Also, satellite communication is a different use category. We should look
for WiFi or RLAN, or perhaps "comunica=C3=A7=C3=A3o multim=C3=ADdia".

The requirements I were able to find are:

https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produt=
os/2021/1510-ato-1306

ChenYu

> Marcos.
>
>
> >
> > Thanks
> > ChenYu
> >
> >> I'm no lawyer, so please if you see something different, like more
> >> granular control in the allowed frequencies, please let us know.
> >>
> >> Thanks,
> >> --
> >> Marcos Alano
> >>
> >>
>
> --
> Marcos Alano
>

