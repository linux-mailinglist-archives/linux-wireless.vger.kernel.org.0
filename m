Return-Path: <linux-wireless+bounces-11122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C594BAB2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7411F22392
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBF18A93E;
	Thu,  8 Aug 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBBnjwVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDE18A93C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112242; cv=none; b=asqjAgaGcD3nuPVM/7d+ZpexZVP54LBNHOjHvCfXz7f09M7vdhaFJhaAgTp4eqVI/IyMhnjhGBY1Rkhag2xd97nnYp2fhlo2VorC1dUj+Tq7pBhTyvMdmYJhlo3HtqNbBGfLrg9VBg4wE3KP4Q9vmflNFpirDxDoZzy0v8UaQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112242; c=relaxed/simple;
	bh=Lc8ieDMbU/0n+kHQ9ZgoB5DBhRoVU6SSE2JtOeR7BXI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iRUi53HbVJFN8K+DMkOU8UCdMCj9N0mbacWKUH7AKUiVNENzF7wfQjNef38o7bE3e5FXdb4ha5pZSFjsNI1septCkUzKK8Da99jYZkWCgGfgOU3J2z4/JWj/WAkqY7pgRFRapwszgee61fE6ZPQtelR/8UU9Bqb3w5fwE5tdCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBBnjwVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70522C32782;
	Thu,  8 Aug 2024 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112242;
	bh=Lc8ieDMbU/0n+kHQ9ZgoB5DBhRoVU6SSE2JtOeR7BXI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bBBnjwVTbRyDG5OqNEr+d9JkaajCDojZqYrH0nrxx5lReDyi+njH1Je3h6XK9Am6s
	 cx7wQam3neBELR7tHKEYYbyldjqGulinzkRSjWIxeHUby+GELfs9BibPZdLi+85LzC
	 pKHies3RpKCpSSBB5PODJqqOZOSOTYW5sJufrB4rE+BYQ4bqWPL1eQlZmZt88VZzZg
	 OlP6bLuL4ZVpU84CackJWG244UJIPFd3f7fweKLGsOtrVeFQfd5Wdzr6YMwSvvO+38
	 s97iHk5bKYgo7vMlnnhlH/Ugm5ZjS1YEO6c/VHZb7uLj6VDv2EpmcVATUXHBDBRdtR
	 c2bvnYPI7wZaw==
From: Kalle Valo <kvalo@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,  Rosen Penev <rosenp@gmail.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
References: <20240731210243.7467-1-rosenp@gmail.com>
	<201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
	<CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
	<5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
	<CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
	<48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name>
	<87plqjpds4.fsf@toke.dk>
Date: Thu, 08 Aug 2024 13:17:19 +0300
In-Reply-To: <87plqjpds4.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Thu, 08 Aug 2024 11:25:15 +0200")
Message-ID: <87zfpn2ua8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:

> Felix Fietkau <nbd@nbd.name> writes:
>
>> On 07.08.24 22:07, Rosen Penev wrote:
>>> On Wed, Aug 7, 2024 at 1:05=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wro=
te:
>>>>
>>>> On 07.08.24 20:52, Rosen Penev wrote:
>>>> > On Wed, Aug 7, 2024 at 10:47=E2=80=AFAM Felix Fietkau <nbd@nbd.name>=
 wrote:
>>>> >>
>>>> >> On 31.07.24 23:02, Rosen Penev wrote:
>>>> >> > Avoids having to manually call free_irq. Simplifies code slightly.
>>>> >> >
>>>> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>> >> > ---
>>>> >> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
>>>> >> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
>>>> >> >   2 files changed, 5 insertions(+), 11 deletions(-)
>>>> >> >
>>>> >> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/w=
ireless/ath/ath9k/ahb.c
>>>> >> > index 1a6697b6e3b4..29f67ded8fe2 100644
>>>> >> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
>>>> >> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
>>>> >> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_devi=
ce *pdev)
>>>> >> >       sc->mem =3D mem;
>>>> >> >       sc->irq =3D irq;
>>>> >> >
>>>> >> > -     ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
>>>> >> > +     ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHA=
RED, "ath9k", sc);
>>>> >> Sorry for the late response, but I think this patch is wrong any may
>>>> >> need to be reverted. If there is an error during probe, and the IRQ
>>>> >> fires for some reason, there could be an use-after-free bug when th=
e IRQ
>>>> >> handler accesses the data in sc.
>>>> >> The explicit freq_irq calls were preventing that from happening.
>>>> > How about keeping the devm variant and replacing free_irq with
>>>> > devm_free_irq in probe?
>>>>
>>>> If you do that, then using the devm variant is completely pointless.
>>>> I think a full revert is the best option.
>>> OTOH it still allows removing free_irq from _remove, but I see your poi=
nt.
>>
>> No, because you'd have the same use-after-free bug there as well.
>
> Alright, let's revert. Kalle, can you just do the revert, or should I
> send a patch for it?

Thanks, the best is to send a patch.

But honestly more and more I'm starting to think that we should just
reject all these "drive-by cleanups". We have better things to do than
fixing unnecessary their bugs. Thoughts?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

