Return-Path: <linux-wireless+bounces-3285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B484C9C2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6FE1C25D9F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA01DA52;
	Wed,  7 Feb 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXElr00N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099C1DA4F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306065; cv=none; b=XJzFKfdKG7KkCm4XeaBTpeGcvK7tCQ9HtXo2Mdw3PBuOf+VWAB/gbieZysP2c8MuKOesxSg0W7/yVOva7IXMSnhQPpxhUGB0hN72zb6Krm0W9q3qZM2B3PSkyLkMQt1tG5YyqqD3xKNq7re54g2juJGL/EhCfgcw49/aTRScLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306065; c=relaxed/simple;
	bh=xYeCdgZeKyL4Gxp96ZmynfABHTZ9se0hNpcVF5+NoN4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kvh9QG35gvNGCcGPJPsNgUa7bYJ9lAQ05r0CUy3ehKemelX0IBKnijXteIX6HCEtPIT5+yiNTdrg/xN9gMkQ3IaEZc3Lxp1QMGCiK9sU/jXdHCuslHxHUZuUb59RB2wM6V/I5oIolLqSCKiPNJ4VVXNFsYKXTJjvDYu+TDkcqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXElr00N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE0C433F1;
	Wed,  7 Feb 2024 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306065;
	bh=xYeCdgZeKyL4Gxp96ZmynfABHTZ9se0hNpcVF5+NoN4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WXElr00NT3daGCg0tPC217herM/ZwxlhJr/ltBUV2vc/sKyesDEoD1SUNmH+fGdxT
	 NA2bwjX57XRfw8HCOiISoKSzfceNwram/ukXvgkWrF3CtEsXFy3Y/RGPjAVFiLdurE
	 3MwzXd8DdvBr7tBowwQLwBPYeZ9+pbjuY7Lq/RrLJLruplfC4Zv+aUPz72fbvZ7pMg
	 lt5jUKPI6KFJwp9xTQG3b2K3dd6HCidSWqMUMOzmy1c4BZ3Mb6cYnXg+mkXZYQSBLX
	 zNd7c0LDzQCS04IkG18m8+2lqemVhOTOwO1soUhECU8za2NdlfTAhtMFnOqXadn8tu
	 IuLvghzSympBg==
From: Kalle Valo <kvalo@kernel.org>
To: David Mosberger-Tang <davidm@egauge.net>
Cc: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
  linux-wireless@vger.kernel.org,  Ajay.Kathat@microchip.com
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
References: <20240127004331.1334804-1-davidm@egauge.net>
	<415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
	<706d5fde96f90078f80c7fb4fc88503d1791426f.camel@egauge.net>
Date: Wed, 07 Feb 2024 13:41:01 +0200
In-Reply-To: <706d5fde96f90078f80c7fb4fc88503d1791426f.camel@egauge.net>
	(David Mosberger-Tang's message of "Tue, 06 Feb 2024 21:52:42 -0700")
Message-ID: <871q9oqz76.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Mosberger-Tang <davidm@egauge.net> writes:

> On Tue, 2024-01-30 at 10:06 +0100, Alexis Lothor=C3=A9 wrote:
>> On 1/27/24 01:43, David Mosberger-Tang wrote:
>>=20
>>=20
>> > @@ -1142,7 +1170,7 @@ static int wilc_spi_init(struct wilc *wilc, bool=
 resume)
>> >  	}
>> >  	if (ret) {
>> >  		dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
>> > -		return ret;
>> > +		return -ENODEV;
>>=20
>> You are still rewriting error codes here. At a lower level, sure, but st=
ill...
>> When I suggested setting -ENODEV at lower level, I was thinking about pl=
aces
>> where no explicit error code was already in use, but
>> spi_internal_read/spi_internal_write already generate proper error codes=
. Or am
>> I missing a constraint, like the probe chain really needing -ENODEV ?
>
> Lower-level errors are often not meaningful at the higher level.  For
> example, attempting to read a register over SPI may cause a CRC error
> if the device doesn't exist.  That would result in -EINVAL, even though
> there was nothing invalid about the read, it's just that the device
> wasn't there.

Changing the error values makes debugging harder so please avoid doing
it unless absolutely necessary (and then explain the reason in a code
comment).

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

