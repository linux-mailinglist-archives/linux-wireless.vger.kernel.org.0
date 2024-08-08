Return-Path: <linux-wireless+bounces-11120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9694794B9A0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BA91F2178D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70B84047;
	Thu,  8 Aug 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUyzZmNv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F548C0B
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109119; cv=none; b=NHWBhjf9JhfRXmRE14Os7cfwwz8VULX7N2p6vAxw7Zk4z3VuWQOi+xgPyDC7e+ztI6/cHGyYPQve1gicA0DMCpYMyswAKyztlkW3ilqona0XPtMIqMcGoDyziMITSXmRepAh0h538VCOqSQT0nsdF29HildgistP5Z7aOwHMxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109119; c=relaxed/simple;
	bh=R+yhwvyq3X4Cjlnq5b8+cVCyhP0cgWC8HUd63SpH3vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3fqzH7N9yXrMYRKo/rRFSDNvyw9A8Gh6R4lahGeTv1mwb4gu68lMb3Dl/BwjflzFxYN1qTOo5dpx7sg72LDO7NoM2kRLimsA25eo31JjsacqMm9oT98ccn6jUuu5rdlvaLoM7squCZmgFN5bru5bDpADXNjewi4sQOBcsSJtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUyzZmNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2A4C32782;
	Thu,  8 Aug 2024 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723109119;
	bh=R+yhwvyq3X4Cjlnq5b8+cVCyhP0cgWC8HUd63SpH3vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SUyzZmNvIjN6co5gX7kBgOsi8A2nG4pjnWfxgJaPyUrVZ+S5QvHzJgl3sBccgXB3T
	 FpHW1e7aA8Y4oWIK/ZeXD5xTQD6O9nmJj9qW/euHVhrMeO2LqckDLlKOvthHd9wcFn
	 zY8MA+CH+IdSqqF/+L5j8rG04nRKCo7AxERyNZuXTnFdYD29y0hGOVWhllov/F+3sg
	 Rl/oLHtV8vhnIDwJ/1lR11Poc8kqs1KNu19xanR69i6I7Xvzqj1K4e/v0R0awEcTgt
	 OMPJ9XrXIPXeCGgEsaDJPiYpk3yfgFnWuzg60CcHjV7wgMJPqbJHgHM+kf/QaTe+Pi
	 h/bDFfVSycP/A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41A8D14AD64C; Thu, 08 Aug 2024 11:25:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Rosen Penev <rosenp@gmail.com>, Kalle Valo
 <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
In-Reply-To: <48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name>
References: <20240731210243.7467-1-rosenp@gmail.com>
 <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
 <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
 <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
 <CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
 <48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 11:25:15 +0200
Message-ID: <87plqjpds4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Felix Fietkau <nbd@nbd.name> writes:

> On 07.08.24 22:07, Rosen Penev wrote:
>> On Wed, Aug 7, 2024 at 1:05=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrot=
e:
>>>
>>> On 07.08.24 20:52, Rosen Penev wrote:
>>> > On Wed, Aug 7, 2024 at 10:47=E2=80=AFAM Felix Fietkau <nbd@nbd.name> =
wrote:
>>> >>
>>> >> On 31.07.24 23:02, Rosen Penev wrote:
>>> >> > Avoids having to manually call free_irq. Simplifies code slightly.
>>> >> >
>>> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> >> > ---
>>> >> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
>>> >> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
>>> >> >   2 files changed, 5 insertions(+), 11 deletions(-)
>>> >> >
>>> >> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wi=
reless/ath/ath9k/ahb.c
>>> >> > index 1a6697b6e3b4..29f67ded8fe2 100644
>>> >> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
>>> >> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
>>> >> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_devic=
e *pdev)
>>> >> >       sc->mem =3D mem;
>>> >> >       sc->irq =3D irq;
>>> >> >
>>> >> > -     ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
>>> >> > +     ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHAR=
ED, "ath9k", sc);
>>> >> Sorry for the late response, but I think this patch is wrong any may
>>> >> need to be reverted. If there is an error during probe, and the IRQ
>>> >> fires for some reason, there could be an use-after-free bug when the=
 IRQ
>>> >> handler accesses the data in sc.
>>> >> The explicit freq_irq calls were preventing that from happening.
>>> > How about keeping the devm variant and replacing free_irq with
>>> > devm_free_irq in probe?
>>>
>>> If you do that, then using the devm variant is completely pointless.
>>> I think a full revert is the best option.
>> OTOH it still allows removing free_irq from _remove, but I see your poin=
t.
>
> No, because you'd have the same use-after-free bug there as well.

Alright, let's revert. Kalle, can you just do the revert, or should I
send a patch for it?

-Toke

