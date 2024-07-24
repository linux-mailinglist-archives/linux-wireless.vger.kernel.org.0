Return-Path: <linux-wireless+bounces-10485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C67693B285
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9991C235D3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A86134DE;
	Wed, 24 Jul 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUDazdN0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B868F48
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830705; cv=none; b=fBvzDCH4QCCSFdBkWv/+ZSjQ+iQztqFv6aVOI0tMDEjatAfmNY+a6oRTUXVMDbehmRsJyV4DrYYE9k+jmbAdTAzHyxnp7gVQDzJgt+M/QgVdX4ytn4V8YYT43IoHJEfKdxMmADY5fpB4TW2DorYKL+/kw2kwElKx7YaUz63gM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830705; c=relaxed/simple;
	bh=k78JBNn83i73ZFrgS5dx8qgPpj3v3zS8nJydy/7HoBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL1RKVqRN0m4FbevD99xyfeh2OQip6LslKZ7W6WRMaOqUavE+w636jS6rN7gjJad6B/jAFPawuDdnVblhOUVZnF4ugAomifEiCdudxpIvMSDwO0f0PPEA5ZxqQeUpGBS7AMApRsn0Fpt/AaRRFzZJVqYUXpbIFXX7B4TPih/Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUDazdN0; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so101265941fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721830702; x=1722435502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k78JBNn83i73ZFrgS5dx8qgPpj3v3zS8nJydy/7HoBU=;
        b=NUDazdN05e+T8Zd5guhy3y4KoUDcAbIktLXguH7lPckAVAFJm3nhNmLPp0EAA5m43V
         6YPxBBNJGHgNbl1Tm4ArqtBXTv+Rk93q+43x9w+B2mZUQDjC2UO+VQoT7YXWA+RSMa8L
         9jLNudlIDgLYCF5YxZADzp9h6PPh/e1rTtJ/o5iLTNaT8Mg4rITh6WCRuUh1vlr/LvMP
         t0OJFJ8x7xbUAUlBYPf+LZlh8jbKygOW4Lrei4KSuXi8DCX/aHqumS7atLAwuX2CbAnK
         bNf7S7m526hNs4iyu2p4n7r3TOKhIqCSErpHiYycuF4Gf69FmHEBBt/2M5KnF9uuw5xB
         Octg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830702; x=1722435502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k78JBNn83i73ZFrgS5dx8qgPpj3v3zS8nJydy/7HoBU=;
        b=EbxWf//njrfTJMBUtEedGplcKsrKTInzca3Grd3FWkqT1tRHVtzvnpr3YoikSyxgFi
         YHzY2DoBBFasv5V2CbpcdKcYtdaU+vli8GkGSntcXZWH5iLiV1NhdQuVhbSQghsw4Oeq
         T9CGlDKlB7XRFBwUjuBJL4eTVXva7foDg4nny1cunFZCfgI09Uav/lx1/ZWpebmjhbSy
         bf7pH7GYkuJJ4jEGcFc7LQR9q914GB4aJ3zHD0i4m6ADSKSfFO5iT8U0zpA4ib8NuUV0
         FSK0p+3epXyG2cgEY3cSQLBFOfTf9bQ7C+rH/MunOwwyPcN4+vBphGdIxLz/82mM6CTz
         X4yQ==
X-Gm-Message-State: AOJu0Yxb+lH1DcShVMGLMAiORGjnbXaPYcYr1oK7FaOJ+DmLbWM0/J4P
	2uKsn52rnJOuDnDeSmL8U0RFH3a2KFELzXAZgx/X8+rlz6STdXtOHeToUNjS73Ej+O6DDHgBkHc
	fttQ8tJkLofnPL0rrFHe2pTdrhbo=
X-Google-Smtp-Source: AGHT+IFnixPGqsy137Q2dfu4cbTn10ekPOB5J/5PYBnCcIdyoDuRQOBCZJB2bxCInWFFXbZIcrmeEhpFAHjU+c1jXQY=
X-Received: by 2002:a2e:a54f:0:b0:2ef:21b3:cdef with SMTP id
 38308e7fff4ca-2f039c09c85mr144461fa.25.1721830701548; Wed, 24 Jul 2024
 07:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d115c07d-4e3e-4e9d-9704-f0cbe159b986@gmail.com> <7c728fdc-6984-49b7-9361-cc1008616e15@gmail.com>
In-Reply-To: <7c728fdc-6984-49b7-9361-cc1008616e15@gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 24 Jul 2024 16:17:44 +0200
Message-ID: <CA+icZUXSgprFb_h4SrbuOBRYuddUKQOuokbwpTfVmG=F5NWAtg@mail.gmail.com>
Subject: Re: iwlwifi ring buffer log spam on kernel 6.10
To: Adam Macdonald <adampoke111@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 3:23=E2=80=AFPM Adam Macdonald <adampoke111@gmail.c=
om> wrote:
>
> As an update, this appears to be exactly related to https://bugzilla.kern=
el.org/show_bug.cgi?id=3D201761
>
> In comment 75 Rafael Wysocki links another thread on the mailing list in =
which there is a supposedly working patch.
> Hopefully this can be accepted mainline soon after testing.
>

The patch is in mainline =3D Linus Git tree with CC 6.10.y stable:

"thermal: core: Allow thermal zones to tell the core to ignore them"
https://git.kernel.org/linus/e528be3c87be953b73e7826a2d7e4b837cbad39d

That commit is NOW in Linux v6.10.1 integrated (22 mins ago released).

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=3Dv=
6.10.1
https://kernel.org/

-Sedat-

> Adam
>
> On 24/07/2024 12:15, Adam Macdonald wrote:
> > Greetings,
> >
> > I have just upgraded to the Linux kernel 6.10 on Arch Linux last night =
and am having issues with the thermal driver (iwlwifi) for my Intel AX210 (=
8086:2725) being unable to read out one of the thermal zones (the only ther=
mal zone?).
> >
> > The following log message is repeated about 3-4 times a second in the k=
ernel ring buffer log.
> >
> > [...]
> > thermal thermal_zone3: failed to read out thermal zone (-61)
> > [...]
> >
> > The offending driver:
> > $ cat /sys/class/thermal/thermal_zone3/type
> > iwlwifi_1
> >
> > I am currently running 6.10.0-arch1-2, but was previously running 6.9.1=
0-arch1 without this log spam occurring.
> > It is important to note, however, that on 6.9.10 it would previously fa=
il to read out the thermal zone _once_, but not continue to retry forever &=
 fill the log:
> >
> > Jul 23 14:26:09 milky kernel: thermal thermal_zone3: failed to read out=
 thermal zone (-61)
> >
> > Thank you for taking the time to read this email
> > Cheers,
> > Adam
> >
>

