Return-Path: <linux-wireless+bounces-11102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BB94B0E7
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB91F2437E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913814263B;
	Wed,  7 Aug 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJhyBLGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB23364BC
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061262; cv=none; b=Aili2Tj7B+tD4iprZX8/REQCLPh2XMiGaigI49QwwBqVfHdIoZjDaMjZIsBR2/IA+AF4JuzweNOnN5i+fFzcsTDwuq/wRCidYgrKVknRG2AnrD5i1HaS5+BtkuPv/gXJUMM3k/oPdJO1KhgTnh6JFdWezHK5kyUrp5yMpuUVBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061262; c=relaxed/simple;
	bh=CXNYnMOvTngcjKhCxk3U23uLs3ajC3GspqRY0lDBINk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwkQXJXAQ6rYM7t0bAyxCSfCddHImGOg7gQwPHr1FAgxnxEoYCpdnJ3BuaaKWtymCvcfdhL9Jiw5vx17ec2W8pSH8I1p5qAeJSEcaqmaBtcfymp+dyFdCwx43xWa7SK5G9zKq+3Z84RMhTsjUgKmoDGDrAnlwD8DeW4nIPjrl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJhyBLGk; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943713472so104670a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723061260; x=1723666060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQoryzgEQdmWu97fZ0il4tX9n46IYJbR/bXv36XZePg=;
        b=RJhyBLGk8FFGKsBslNFr5lNbBrmORlXJzUWWurn7sdaDMiGOFITZ0KSqnzIR4AcMkM
         GsxMh3c2hEiKFfBkNuwF2yJTFwR5lMx9hZyVMVy3ZPBZw8I1XOWSpnViujtcCZ0fjHZf
         A6bX3topcTd9LOoJjcnzBNYRUVyDEFNrkkcDg5ziDEi7bbffnF948ZI/iM/35HaC3OnD
         Yj+QpV3Snm9L1OFHDQbUnkYEMEv7MvWDkgOxKgXfzA/SIZRL+KUIxkt9/LIoMuowNUV4
         UMeZA5Ge5ls73fn37/eW51P5Y9sy6RHyfjy8kYuXyVU3yO7HDKbZCWMlP0cvYMXCLpSD
         342g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061260; x=1723666060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQoryzgEQdmWu97fZ0il4tX9n46IYJbR/bXv36XZePg=;
        b=I8Fqzvimr3aGSaOmkzlQNsGoQaaP3fTYQzXcWWpw/Dec1CGDdcCr52l6gw9qgMyonp
         APC1MUEV/Z4N0Qh+F/atVP8GgRSXx5g0PYtj35rQR8c2M3q36rfAfQf3cmHEDzpQKttR
         84KJBJ8bhYInD/d4mbeM8FrPpTFMkWDWX+QH84x2UiBH+VVZetnnGQuNFnopDqEIA3Xm
         LvdjwtM13t4hfBSoya75AmD+h5qW0IMDfho8SXM3Eoi3Bao8+afZsiKljZ+yW4yCsEBL
         le+qYxZkUZm7h35jdD/6gmqYhGmhj4X6kgf6z7unnNcIxUnWruWyXk+TsMk2HUPb+sjG
         P2Tg==
X-Gm-Message-State: AOJu0YzDKHLfWYro+OAVty004j4uAfuDK6S8N5HnvjPvRGlY2sLcOTGz
	kzA8ItDGqvDHpTI1fZrGtfCzsTEusZ4MSnS88z1UhHr5SuHJgFZn37ws5KAHlJA6ONn9AJxPQ/G
	E0wkM5ZdT5obDR84T3eKHrZkARV7bPA==
X-Google-Smtp-Source: AGHT+IHqIY6BYsgMR9L2Gmro8SiC5YgoWHyLjKG0AKtsmdS8khW0fg5v7v+1EwkHMQ9ZAifzk4/kWMDDRalKisTiRh0=
X-Received: by 2002:a05:6830:630a:b0:709:2fa3:1337 with SMTP id
 46e09a7af769-709b321e02bmr26551138a34.14.1723061260432; Wed, 07 Aug 2024
 13:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731210243.7467-1-rosenp@gmail.com> <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
 <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com> <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
In-Reply-To: <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 7 Aug 2024 13:07:29 -0700
Message-ID: <CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:05=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 07.08.24 20:52, Rosen Penev wrote:
> > On Wed, Aug 7, 2024 at 10:47=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wr=
ote:
> >>
> >> On 31.07.24 23:02, Rosen Penev wrote:
> >> > Avoids having to manually call free_irq. Simplifies code slightly.
> >> >
> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> > ---
> >> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
> >> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
> >> >   2 files changed, 5 insertions(+), 11 deletions(-)
> >> >
> >> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wire=
less/ath/ath9k/ahb.c
> >> > index 1a6697b6e3b4..29f67ded8fe2 100644
> >> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
> >> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
> >> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_device =
*pdev)
> >> >       sc->mem =3D mem;
> >> >       sc->irq =3D irq;
> >> >
> >> > -     ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> >> > +     ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED=
, "ath9k", sc);
> >> Sorry for the late response, but I think this patch is wrong any may
> >> need to be reverted. If there is an error during probe, and the IRQ
> >> fires for some reason, there could be an use-after-free bug when the I=
RQ
> >> handler accesses the data in sc.
> >> The explicit freq_irq calls were preventing that from happening.
> > How about keeping the devm variant and replacing free_irq with
> > devm_free_irq in probe?
>
> If you do that, then using the devm variant is completely pointless.
> I think a full revert is the best option.
OTOH it still allows removing free_irq from _remove, but I see your point.
>
> - Felix

