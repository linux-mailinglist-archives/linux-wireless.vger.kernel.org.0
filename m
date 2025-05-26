Return-Path: <linux-wireless+bounces-23410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C99AC38D8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 07:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9893B357B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA319066B;
	Mon, 26 May 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNQ8MDbu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B56320F;
	Mon, 26 May 2025 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748235611; cv=none; b=SAFE24uGQbeA1S9mviah2g2ENw/NuNKOmTxJN6ghrzNqHil8gAYo5hQHBFqWnTBrponxJY7IbOlctgTSnqraTr3RWLvhD3hPR8ksrK5H/JiPaGVa1HQzgaTogwxoQlU3o6s2S4t/vtN2gdI99pXqcH3/xOY9sN5PxQqrMPIUfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748235611; c=relaxed/simple;
	bh=TUKyt9XJYz0b6csbOMnw0vK6f+GZpOF14dgjWH8YtyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEdRY0zI8pXIMw0kB+fql5f+5+lFwksxkB14iVyXjF9rbkLe/px5tLcHpPbzVuFb/VvTNlEEBFn4VpLj+4qrPWbljFssuIy9jkQh80Vf3ACkjix5ONPPS/fqrQbEx7iRakbIZfquDqIDW4vXe7T1jxjWBLvvpIYDrLzLlCbL3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNQ8MDbu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e4bd65106so4929517b3.0;
        Sun, 25 May 2025 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748235609; x=1748840409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRSUWyQE5xiMSG++6sHk9W6b8lp6uFUVrUttwD9vSKs=;
        b=iNQ8MDbudv7sQfsvhwV3+9J1uMcfRUQsBA1tk5+IGyjBlAp0wrjE0Cbe3EaZ+Cu1Pw
         OdbHtOZXDepEd8ojA0jp3CSNjQ2em5h3Bw/Nj8+luinarypASYeFDUOlyBcJQq7c33AS
         LOpmRMys8Qpw+2FWMakveeHZ67mOyEjcXSgZQqSZxEoWCQCJnycX1H9Aa/bw7UZOnYUA
         At1h6uZWR5sIdwyA6+/UeBZnAdLNa1G67ILfs9j/2PxA5rhg84ShNAjDKqWFj15r91Ti
         lYbWJPZW4Aco7d+RVd6TdbmdkpaspjPDbIHhIWoHyVzf7Kek+2CVFyznkBwdDuB0Lda2
         /kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748235609; x=1748840409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRSUWyQE5xiMSG++6sHk9W6b8lp6uFUVrUttwD9vSKs=;
        b=V5tzXN8wpenvO4mD/SbOdZmD59R+vfG4JZdoMgi2w9vphnNTSM3DMhet0Vhl0rgSSh
         SWHCVZjw/J6JAGNilOQW4TQtgmvB4XSQuBFBEGDnH/RexZ6dYnF8OkKwMo3A80PmbBC8
         mtaQKPQGDYy8NdNs3m/PQb9eQ2mAdBsdlGUrsngXjPwfeK2O0i0Q7K2su6FtCUC4xDvM
         RbWIZZB9atCGPPDou2807ngMCpa12JFNWALlEAjCwYByh6HQ3aLqnFKr55Sxp8+TolKR
         BJyepiasNfxT8+a0pdiDiRlwvZiEXan91jDjj1BWsjw1o+GD5fUqM5uNH1pmmAdIi9nX
         2HlA==
X-Forwarded-Encrypted: i=1; AJvYcCUg6KN4uEnFRQxiOjojheupf3YwGTQgKBWSBX2OlqT7N+uMKiMZgSa6iKjNVR6o8PJQ4vpuWkMaBNiebRm5@vger.kernel.org, AJvYcCVYOwR1LpmKePpvpDFjal3G48M3ZvaEG55QB1hwaWgwhpdAH25EHRg+R+/dMIusQ0X8/SUhzyv9qJ2x+Q==@vger.kernel.org, AJvYcCWA9VHWLNhu08loA9xkBZJZh0puJkXlvd0SZ3h0GG2u/ibN89Y0PvU44QBiSPZRJqoaZYPcwnA0VtWd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy985F6dAYKN8iM7XHd/ZWHbLooVckQaDoBaeWlw6Dw9Efij1mG
	juheAnSMsC3bAYlgg17G+8qRG9qVJajN7HmLUVP/0KwtUpBQ03071d+6Z/RJpJ04LQXqLELmbC9
	OpQUn6j0omv2UTVz8+WYTOQaBug5ag5yAunZp
X-Gm-Gg: ASbGncsjWTKf6zS1DRpKln+hh3lll1vZpJrgJ+ZtzVCj1ii9TyPnJxuAe5pHz6/1fI8
	UNTfwxWHgl1sX7AcQareHlI3OmFAqZWCL5cl0BdLYBRNdrnRYGXJU2bieSJlIR74ckObF/MvUD9
	94ikyBme3810T3oS7+w7rEDQPMx6rqt5ZxS4DTUucSKbJkOw==
X-Google-Smtp-Source: AGHT+IGVpEA01fzRROi+LfJOdS1QQHbGe4ixACn2u3q7PnSuRe0qebkJlfK0nwrwhK66plIySyLZezRL2z/GCBhsIsM=
X-Received: by 2002:a05:690c:640d:b0:70d:ff2a:d670 with SMTP id
 00721157ae682-70e2d9ddd59mr81320107b3.14.1748235608721; Sun, 25 May 2025
 22:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525214256.8637-1-rosenp@gmail.com> <20250525214256.8637-5-rosenp@gmail.com>
 <297d936b-7ce2-4d9a-baff-e4b0503e6000@kernel.org>
In-Reply-To: <297d936b-7ce2-4d9a-baff-e4b0503e6000@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 25 May 2025 21:59:57 -0700
X-Gm-Features: AX0GCFspzaYrXHt_wzYE8ssQRfIyEdKmRw-oKVr49Z42QmrewyyQMw-Xz_DjatI
Message-ID: <CAKxU2N-b-qJNqdF94Q_cjFv9NU3r0KDNXtdzOTPenJYRyKqaGA@mail.gmail.com>
Subject: Re: [PATCHv4 4/5] wifi: ath9k: ahb: replace id_table with of
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	nbd@nbd.name, Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 9:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 25/05/2025 23:42, Rosen Penev wrote:
> > @@ -72,20 +55,15 @@ static const struct ath_bus_ops ath_ahb_bus_ops  =
=3D {
> >
> >  static int ath_ahb_probe(struct platform_device *pdev)
> >  {
> > -     const struct platform_device_id *id =3D platform_get_device_id(pd=
ev);
> >       struct ieee80211_hw *hw;
> >       struct ath_softc *sc;
> >       struct ath_hw *ah;
> >       void __iomem *mem;
> >       char hw_name[64];
> > +     u16 dev_id;
>
> I don't think these are u16 in the headers, but unsigned int.
Sure. I can change to int or kernel_ulong_t. It doesn't matter much.
The function that uses this has an int parameter, so might make sense
to use that.
>
> >       int irq;
> >       int ret;
> >
> > -     if (!dev_get_platdata(&pdev->dev)) {
> > -             dev_err(&pdev->dev, "no platform data specified\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       mem =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(mem)) {
> >               dev_err(&pdev->dev, "ioremap failed\n");
> > @@ -118,7 +96,8 @@ static int ath_ahb_probe(struct platform_device *pde=
v)
> >               goto err_free_hw;
> >       }
> >
> > -     ret =3D ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
> > +     dev_id =3D (u16)(kernel_ulong_t)of_device_get_match_data(&pdev->d=
ev);
>
> u16 cast looks not needed.
Correct. It's placed for extra clarity, although probably not needed.
>
>
> > +     ret =3D ath9k_init_device(dev_id, sc, &ath_ahb_bus_ops);
> >       if (ret) {
> >               dev_err(&pdev->dev, "failed to initialize device\n");
> >               goto err_irq;
> Best regards,
> Krzysztof

