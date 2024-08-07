Return-Path: <linux-wireless+bounces-11100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550894B001
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 20:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA736282E5D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0513B7A3;
	Wed,  7 Aug 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdarkrQj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E162770E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056762; cv=none; b=te/B5FvBRJBF/060KL9UMK3icVbZo90tt3wD/HpATm1MccbJSGF45JETcwpuSQwr4srazhUheyjC2sQzSIgeOw7sXWFPgJgeuR2w8Qq9f8an1hDgpfiCSdU4A0hBsB1thDD+GhhN4RrPOTNOzGMuscqZeXFDWs//qiI6Mp5QBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056762; c=relaxed/simple;
	bh=/RE+qo4nF+RqJW8EqxK+J/6JRHIJ4SMx/cl2oR0mILQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbVeZwcOweWsfNzKwjCRzk9nL8IT5AiAAj0fjq3Wiq0pqU/xlIh6pMX1wLKWpTg6wuGH8UK2eQZ4GvT1PS1ZCnx4hRLSABmW1PnjUPqpi65etYm/fgvEUEyTL3Ab8seYPD6+v6z27waaZsAmYjAdVsJBEKF679mHDfuxYt+t5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdarkrQj; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66108213e88so1708707b3.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723056759; x=1723661559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWgMkhYZh1+KfFpr10mKvEePbUNIXpWsaWUZwsjLLrc=;
        b=mdarkrQjXWSQmzbcB4svIeLezNAtMB2qHioAWmSHv3b+XurF7IVoFb897B4QsbyO5k
         D831LnXYDVR+/2ZA4JvoGGxGgt3o6JkJKoz4ZV9TOD7RILynv47bCBr0kU6fmgPilKw7
         5VapeDsQDxbYHuQjfmko1qXLhnQq0/++O94cHdWJpACbFc8s4KQHADv9Gt4JqW2KdM/a
         56vKkHqe3muYyF4N8iUsyEascKbq2CRSaEhd1Id+QRTc76ZFgtTGMj55ymHN0d9+XLpV
         DFrNEs5thxZSxFommEGn4XThEw7t0wK17o//u1VymIwfRf6GuSx4A4pKxmk81oTCVw01
         X3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056759; x=1723661559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWgMkhYZh1+KfFpr10mKvEePbUNIXpWsaWUZwsjLLrc=;
        b=COpJxAYSXx0wnEnu7pkXFUeQKPBAPsjh+9I0llEiSTzJ6EJBwt7/u1epjSTYG3qJCh
         LrhngqaW8wQ7v+rxKqQAZF5OSb7UWRuWRrSPbrZVtitqoDhlD6YSGNqrjZn3+Xl8Yj00
         DEgkNfGr6yYqoULevVqHgv1wlYvyI+D0xho0sB6V9QgsBN4p+XDdlo26Gby0ugZFyBph
         +1Qrgu8ua8BkugRFoBtD8F5esyJlSqQ6qWrJwzaVRqHfJ4ExeBC1mPweXLZ5JSnz+hYw
         +E6/rDOrc2eHU+I2AbOPOnlLwsd3tMnN+obNj39qhiI/vUTqetjpZXiYiNF2RpylHlgr
         FUOw==
X-Gm-Message-State: AOJu0Yy8km5XKd0UPu/2l1n2oMIE8g34XEdRUiZq0MBIkK0ycEAOk5Ss
	r7e9gZzJRS+ARQv2AKdweZe47qucOd1AtAFsPrUrOm0R68wPGVrrn+w4gyAxTROGSGR2wCrFy9v
	GkS2+KODQl7KnkIsCdzVl6A5vL4o=
X-Google-Smtp-Source: AGHT+IFvWguNAi1f4Oc4m9JEyBqa9UyF1mT1MQEvK9UtB+5xnQnvJAJVVg1Z2cIoH0gojc8Kmp4JkP04op32xRf7xfA=
X-Received: by 2002:a0d:de87:0:b0:64b:44b4:e13 with SMTP id
 00721157ae682-689630489ccmr217933987b3.28.1723056759435; Wed, 07 Aug 2024
 11:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731210243.7467-1-rosenp@gmail.com> <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
In-Reply-To: <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 7 Aug 2024 11:52:28 -0700
Message-ID: <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:47=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 31.07.24 23:02, Rosen Penev wrote:
> > Avoids having to manually call free_irq. Simplifies code slightly.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
> >   2 files changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireles=
s/ath/ath9k/ahb.c
> > index 1a6697b6e3b4..29f67ded8fe2 100644
> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_device *pd=
ev)
> >       sc->mem =3D mem;
> >       sc->irq =3D irq;
> >
> > -     ret =3D request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> > +     ret =3D devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "=
ath9k", sc);
> Sorry for the late response, but I think this patch is wrong any may
> need to be reverted. If there is an error during probe, and the IRQ
> fires for some reason, there could be an use-after-free bug when the IRQ
> handler accesses the data in sc.
> The explicit freq_irq calls were preventing that from happening.
How about keeping the devm variant and replacing free_irq with
devm_free_irq in probe?
>
> - Felix
>

