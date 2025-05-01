Return-Path: <linux-wireless+bounces-22309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1BCAA5D5E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C67F3AEFB6
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA71F22129D;
	Thu,  1 May 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="Ylwan6+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB621C17B
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746096080; cv=none; b=YwvaHnN0UaQrJO9i36OshT1KItcHGrV5zzqrRkn6i1Y6XhKC9Lbhk9nkM5473Xcf3YHL+Feu5oDUYq5KNBRa3QX9UBxYN/QpGxBrUzCuUUbmuhXodsvEQxcqL8E0oBBglQMxWNIQBLpoa3NuIj6IdgoDy8dOu8VgAWgbXC50eLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746096080; c=relaxed/simple;
	bh=guDgzrvATTnuBPGno8wSyuQm5nSp7dwLTCDRM24PzWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw5xtxaj6iJO5MLUkKoUz8MSlJ0RF+CsfPAy8KGpeTdTGdjYmZcfnON25LM15nU5luKgkpSdXwhSoK07efPBNgOgehJm6GOk4uZZcw7aRAE9NL6KGpuIjaDI189C10eFgd2dFIVXCvgw8nspT1Sx5MB8O8w+SPIlkgwqfuCNTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=Ylwan6+i; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso1605023a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 01 May 2025 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1746096077; x=1746700877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJz9yiHiw7REWSnm+Swb+D86bMMthEGgurrvkqKtAeo=;
        b=Ylwan6+ijO3zz6Es+E/mhc1Y7seVMykoU29m01whQjH+/xQ0tkEnXPeYNVOP7vHVeT
         ARNQIUo35FJ7KoiDv+wixfcX4ddFp0kTBk+Fp5z4q8XeLuBlztXInn2gxIVlU1p1iHlG
         lOm6VHEkU9L9BN7h7zKsapdeSMybTLMjUpYw6OkQtbTuPZtqeYLSUjMkMYYBrbONfiqP
         b03/QqdIzAATXvykuUbldAHRHJTFWgnq1b5RrxgG0m738r20884ObagbzIAtQQMMJSWY
         UEo5WQ5BdbHenpyF4hEmMArw6N0HthAc3hzsOVVAELZVj+DylDWj1aW1ksgIMUY8h4B/
         9VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746096077; x=1746700877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJz9yiHiw7REWSnm+Swb+D86bMMthEGgurrvkqKtAeo=;
        b=cu1o939V/f3V+WoMOSHcYtoLq6Ala9uQ0+gYzCvSgLNzMziMI79pLxrBTh95L2T7we
         xv9yi8LwFGGKr9lJAAIh+4ytDUKitdZalGZs3GHo3oY5BP8/Eth5oUPwlSbAOSrojWyL
         RkHD1LVK8lf24YHDtpBVX794aLx4qObVJrkc6eLnd7XZRMmy7k+sU/oAVHCmPt3qwXgm
         yihc2WFuEt6noQ+8blU9XRo77NNoiBovtQKPwwcoHCcsD7o4xI0G0HE53cele+E65wF+
         KHqaQjAxSm9RXtbKVKdXGl9aPBHAOYrsYrFIniU757GNW6tITF6uRWoQ7FiBK0zpq3YF
         pebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFUvpZqvRQC+audjSBd0D3Ui9FDSA3/X+3aRIx/5I9wophkSgfZbS6v2p3G35gqpyL/EX5wKi7XiPxdtzftA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqPOQ9Day1Y+d/3gBEg/5ZXsJmJRUv3M346r4OQlFNKGQcg0D
	dptvkC2aD5/bmNbRB+pLqN3jvIqXQIadfNS9UF5gKtTImaVlNu2vrpDJAW0bOv6Szd860S6TYtm
	wdpmEOETjg97HIo4OQJXn53BdJKHNBOWLgb16XA==
X-Gm-Gg: ASbGncs4k/0FJrd4OBH2nBeV/4MiNFlWS4612ur+5il07buoXQutiVhUHLY9u2Ica/w
	CDeNoFj02V3V7HpeNb04qunGdZOyoybdvCDhiRu28cWGMR/aK69IIjtAT9Mul5UmYP/k9MT27cA
	CcDFUbD0A5n840altnxWwtbyo=
X-Google-Smtp-Source: AGHT+IGx25LvFDRh/ZMGWFHrmbZBzIyRaI3U2V4RtLZ4/3afgYCegzxqK1kmMptaLWL0NMqDToqAMVEC9NpFsbTEKvw=
X-Received: by 2002:a05:6402:3585:b0:5e5:334e:86d9 with SMTP id
 4fb4d7f45d1cf-5f9199ee090mr1527625a12.13.1746096077247; Thu, 01 May 2025
 03:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422175918.585022-1-artur@conclusive.pl> <20250422175918.585022-3-artur@conclusive.pl>
 <3cfd718f-e96a-44d0-b42f-d759ae698810@wanadoo.fr>
In-Reply-To: <3cfd718f-e96a-44d0-b42f-d759ae698810@wanadoo.fr>
From: Artur Rojek <artur@conclusive.pl>
Date: Thu, 1 May 2025 12:41:05 +0200
X-Gm-Features: ATxdqUGBQcvZOsSH-_79fRnlSc92wQEtms2DvZrR5e2Ikd3Qv6LHMq3PV3knItM
Message-ID: <CAGhaMFNhq-O3O0TCj6cvzvTqzPQKE_id67U0hZjV0V2uKV91Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	jakub@conclusive.pl, johannes@sipsolutions.net, krzk+dt@kernel.org, 
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de, 
	ulf.axelsson@nordicsemi.no, wojciech@conclusive.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

thanks for the review!
Reply inline.

On Fri, Apr 25, 2025 at 9:31=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 22/04/2025 =C3=A0 19:59, Artur Rojek a =C3=A9crit :
> > Introduce support for Nordic Semiconductor nRF70 series wireless
> > companion IC.
> >
>
> Hi,
> ...
>
> > +     /* vpwr is mandatory, but we want to catch the -ENODEV error. */
> > +     priv->vpwr =3D devm_regulator_get_optional(dev, "vpwr");
> > +     if (IS_ERR(priv->vpwr))
> > +             return dev_err_probe(dev, PTR_ERR(priv->vpwr),
> > +                                  "Unable to find vpwr-supply property=
");
> > +
> > +     priv->vio =3D devm_regulator_get_optional(dev, "vio");
> > +     if (IS_ERR(priv->vio) && PTR_ERR(priv->vio) !=3D -ENODEV) {
> > +             return dev_err_probe(dev, PTR_ERR(priv->vio),
> > +                                  "Invalid vio-supply property");
> > +     }
>
> Unneeded extra { }
>
> > +
> > +     irq =3D of_irq_get_byname(dev->of_node, "host-irq");
> > +     if (irq <=3D 0)
> > +             return dev_err_probe(dev, irq, "Unable to find host-irq\n=
");
>
> If irq is 0, is it expected to return sucess here?

No, return value of 0 is considered IRQ mapping failure, as per
of_irq_get_byname() documentation. Perhaps it warrants a different error
message, though.

Cheers,
Artur

>
> > +
> > +     mutex_init(&priv->write_lock);
> > +     mutex_init(&priv->read_lock);
> ...
>
> CJ

