Return-Path: <linux-wireless+bounces-11123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC194BB71
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 12:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819F7281A81
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088C18C33A;
	Thu,  8 Aug 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ+I+bYo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6C18A6DF
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113469; cv=none; b=D5orXmYx0n6qACIebq1HBvTmXmRMg0j8z6CtHGEA417gM4uSuEQChAo61myCLJBsyE0rdPSrwIclFKJuwLkUwytMKZrzHQ9VcTnYZVRwWuFWmqFbpfPBmn+FoOGT7PivgK5VZYqp3patJIOETrP06xcepkA21qOnHYgSi92x5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113469; c=relaxed/simple;
	bh=WNXP3tQQxBNa7t0MW1seuHlBc+T6fGt0hzNTwSLbqWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KcSw8+wmR9/9GxeypNUOIICNeRmDpZ8NNYsLeIGiK5CKon4M+YxSD8QH5iXePVysL+Un4FaCSMZeNN4odi24j4Y8eGUsCaTOs96hO1CJFTxA+f176X+LeT9R9pEaVtUDWWqexl/XKppkPffmQGmlwY0oUYZR0IC4f8e+UiC9/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ+I+bYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAA3C32782;
	Thu,  8 Aug 2024 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113469;
	bh=WNXP3tQQxBNa7t0MW1seuHlBc+T6fGt0hzNTwSLbqWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cZ+I+bYoOm0rMRKKwHV/cIonMNbWm0h+SS+uNh1KtRsAKGegusE+qbZus9rmgzwoG
	 NzyX1wQgrRHRSkCHw6k3ppvQPbUEh4H33LxyGjrW1QKtdAJ0CpFdF9xYS2u9LpoNNX
	 wCVD8jRGBYTgC5qFORsRkyJnxzZJlO+BIm0fgGysBpVPqVukkOZa3kQA1BxCXlaslz
	 ubD3BNJjvlCxVcTN6FlnbT+C6jd4seecqmV4+BB6+ZqiZQTSi5v5cOlxKnsFyqzY0s
	 MsQcC5X5r2vt+bM/K2/AsLs0rYkJALIj6hBE6bWRXJKKO/yKuzMjEpz0OYnTDP+hbB
	 310V+rOL0lptQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AEEBA14AD67F; Thu, 08 Aug 2024 12:37:46 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Rosen Penev <rosenp@gmail.com>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
In-Reply-To: <87zfpn2ua8.fsf@kernel.org>
References: <20240731210243.7467-1-rosenp@gmail.com>
 <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
 <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
 <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
 <CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
 <48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name> <87plqjpds4.fsf@toke.dk>
 <87zfpn2ua8.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 12:37:46 +0200
Message-ID: <87jzgrpaf9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:
>
>> Felix Fietkau <nbd@nbd.name> writes:
>>
>>> On 07.08.24 22:07, Rosen Penev wrote:
>>>> On Wed, Aug 7, 2024 at 1:05=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wr=
ote:
>>>>>
>>>>> On 07.08.24 20:52, Rosen Penev wrote:
>>>>> > On Wed, Aug 7, 2024 at 10:47=E2=80=AFAM Felix Fietkau <nbd@nbd.name=
> wrote:
>>>>> >>
>>>>> >> On 31.07.24 23:02, Rosen Penev wrote:
>>>>> >> > Avoids having to manually call free_irq. Simplifies code slightl=
y.
>>>>> >> >
>>>>> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>> >> > ---
>>>>> >> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
>>>>> >> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
>>>>> >> >   2 files changed, 5 insertions(+), 11 deletions(-)
>>>>> >> >
>>>>> >> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/=
wireless/ath/ath9k/ahb.c
>>>>> >> > index 1a6697b6e3b4..29f67ded8fe2 100644
>>>>> >> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
>>>>> >> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
>>>>> >> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_dev=
ice *pdev)
>>>>> >> >       sc->mem =3D mem;
>>>>> >> >       sc->irq =3D irq;
>>>>> >> >
>>>>> >> > -     ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc=
);
>>>>> >> > +     ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SH=
ARED, "ath9k", sc);
>>>>> >> Sorry for the late response, but I think this patch is wrong any m=
ay
>>>>> >> need to be reverted. If there is an error during probe, and the IRQ
>>>>> >> fires for some reason, there could be an use-after-free bug when t=
he IRQ
>>>>> >> handler accesses the data in sc.
>>>>> >> The explicit freq_irq calls were preventing that from happening.
>>>>> > How about keeping the devm variant and replacing free_irq with
>>>>> > devm_free_irq in probe?
>>>>>
>>>>> If you do that, then using the devm variant is completely pointless.
>>>>> I think a full revert is the best option.
>>>> OTOH it still allows removing free_irq from _remove, but I see your po=
int.
>>>
>>> No, because you'd have the same use-after-free bug there as well.
>>
>> Alright, let's revert. Kalle, can you just do the revert, or should I
>> send a patch for it?
>
> Thanks, the best is to send a patch.

Alright, will do.

> But honestly more and more I'm starting to think that we should just
> reject all these "drive-by cleanups". We have better things to do than
> fixing unnecessary their bugs. Thoughts?

Hmm, yeah, maybe. I do kinda like the fact that people send patches to
improve small things, though. We all started out as new to the kernel,
and I appreciate the fact that people try to improve our "commons" in
this way even if it's small things.

I do try to be critical of things that can break stuff before ack'ing
these fixes, but I'll admit that it seems like I don't have that great
of a track record for judging "correct" in this context (cf this one,
and that debugfs regression). So I guess you're right that I should at
least raise the bar somewhat; will try to recalibrate and say no more :)

-Toke

