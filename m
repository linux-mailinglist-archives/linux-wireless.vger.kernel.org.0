Return-Path: <linux-wireless+bounces-29987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C85CD1DC5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32A1930C542E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792F338595;
	Fri, 19 Dec 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHv6XO5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365534104C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177412; cv=none; b=Pd/3GnE8ceB8NfDf8StlFo6eGbiiexdx5nV6MsNUGD6AozrWfeih7JV3c/sJeLz1BCURrSfknTKlpHF12X/K4cYdo/I++8MhBrD9PCdaORdVNdAFtZFPcB/adid/U12eRKrVCxqPg1wpjatKnUPnG2VAWbsvSrqY6LshtTLkZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177412; c=relaxed/simple;
	bh=qK0aX9ex4MVXzE2y/hhCxHObw7qjjH4KOguPRtU7gc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDsBQwAKi0JXSrFKKAQpXUwFyehuM0ygWM3HxU019MU14hNUqiOjY9YKHdYVEZTvKtrQj0CY/dCMdobQQ9jq/7rDuErqyZwVdolE6QK4do53RbnMhP9U8jzVHw2ShKfQ7ZtAQsBuUNLg82l2pMgl1uBNc/TC+XSoR8IcIz+gICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHv6XO5f; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f1b212ba25so18388381cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766177409; x=1766782209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/s7YcuiJpwKoMYsi7MmSYzjmyYOegw0fzBHdgiPFOM=;
        b=dHv6XO5ftk4Lmf+KDT8Wsgo4ETQTW8Jw1U4XqyoNEDh3SzQ00yYsLysNn1rTQm08fK
         8FSwgQZEUWj3Navyv9tE8HYJHu2rSA3gZWGeB829zll/eLZYm1R1OUDwwe+agtSXoivr
         xuqqdiiVxyUNyFE0AAJKv39y3Q5Jqd+dJgqPd8z1cHH2Ghjq5A+TofkOU8TMvw2ii4ZU
         vnlFsOfG6Dz7jdoNX4iu5ylP4wYhha641M9g3F2DQ3HSpjSz2LwelfFZaycPQ8qvYUQ5
         kHwfdg2sPlTy8t+eOPcr4GOWjKAvdBSga3Yro4Q7DrglK75MQCuu0Mo/93zmfBpWceYT
         aZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766177409; x=1766782209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/s7YcuiJpwKoMYsi7MmSYzjmyYOegw0fzBHdgiPFOM=;
        b=AGkrDu9uy2+2LAWBUXhbEtEIKVIh4Bi3hFIbssdGIHj8l1Aox9RvObCC8JG3Sh9aSA
         80PQzkrPbFbGYUbY0FuYqO4sDKkMO7ExN5/UiPo6NEnYx7glFGT4XACcQNjSMBDsXxEQ
         oqnN8csO8Tl9STtNZbEAUgQOG2RMUKRblw7CJ4cP5b4QY/ozk9Ysspd2TEcYCTR6orTn
         GRq50C+y+KV5Jk/M+WNP7d/XSKsd5694CaOC1zLoowDeXhbgouI07aCa46xZtxpRyicE
         k11Xbqrk2LzTpOELg0k9uBImaHr1MgrqfCMFBUR4NTAGsCXPiGPIkM8mGbtrRC42MIvR
         F0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXE/G8UULFWCWCp6T+qQCjORr/LIto9V/Ba2t5t0i39gdXYYGDv4l8tThfouvKVTx4NZXK8Uq8WTznpNKWQDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4XzIdQFSalXl6+WbxzSy+PzzSggN3KzPAPtfJw7s3VJKMVYw
	OXP+oeU2NHLo/ruA6uMUEDLZQsCU+xGa0m++w0r+pexPJ/u+kw29JUZvpGjPI4dIoIOpd2Qwqj4
	0+yE2o1EZWC9ejwKKxAapMI5frs5uAw==
X-Gm-Gg: AY/fxX6ttQnIwkX8kP41XyF/2WzJkNNetu14uA1bbpIhAw2+IQPUv0Pt1iKUznjeX23
	BS0L+qkwzBxIN87LVRSy/562okuOxadkoV2Yl9Apue4sSX28f5e/j9roq+HkKiBeE1dtbkgUjNU
	WxzzEMenNL3ThF9U+c2OPQs8Aqt8EdFdg5xTik2iMxphgVmM5xpIw4Re0iyqvbf8HYlb1SAlInU
	hgmJ3n1Yx85R/KirA605eZn5Yvaxz8xUX70fsNtp6NqTATMTowa07xy8iDqs7kbhcDCmECCbevy
	t0im09Cef3YKXAucpJphd6nZeXE=
X-Google-Smtp-Source: AGHT+IE42yv7FIsrWMR9yjYwFTyqReRn26jbbdEMiBw0u/y/uO6l059x2jBMuDoxTGPi0k5VPly4SKVeRcBZYLHomSo=
X-Received: by 2002:a05:622a:400e:b0:4ee:d6:7a51 with SMTP id
 d75a77b69052e-4f4abcceef9mr71345351cf.12.1766177408683; Fri, 19 Dec 2025
 12:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
 <20251218-surface-sp11-for-next-v4-5-7bcf83c1504a@gmail.com> <de00f21e-7fc7-4caa-93ec-afbcc5d9e12d@kernel.org>
In-Reply-To: <de00f21e-7fc7-4caa-93ec-afbcc5d9e12d@kernel.org>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Fri, 19 Dec 2025 21:49:32 +0100
X-Gm-Features: AQt7F2pcZUitjZSQNg2PzbbA2oie2fjwh-55TuTLVMXOnU3tEdVckxLHObxjFK0
Message-ID: <CA+kEDGHL0A=KYhp79_08sx=dUyvpDOuHXEuvgsOU+61PshtN3w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add support for Surface Pro 11
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 19 d=C3=A9c. 2025 =C3=A0 18:47, Krzysztof Kozlowski <krzk@kernel.or=
g> a =C3=A9crit :
>
> On 18/12/2025 23:22, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:
> > From: Dale Whinham <daleyo@gmail.com>
> >
> > Add device trees for the Qualcomm X1E and X1P-based Microsoft Surface
> > Pro 11 machines (codenamed 'Denali').
> >
> > This device is very similar to the Surface Laptop 7 ('Romulus').
> >
> > Use a similar strategy to x1-asus-zenbook-a14.dtsi so that we can creat=
e
> > x1e and x1p-specific flavors of the device tree without too much code
> > duplication.
> >
> > Hardware support is similar to other X1 machines. The most notable
> > missing features are:
> >
> > - Touchscreen and pen
> > - Cameras (and status LEDs)
> >
> > Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> Drop, authorship implies this. Otherwise this suggest none of other
> authors test their code before sending.

Sure, I will remove this line in v5.

> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile                  |    4 +
> >  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  | 1324 ++++++++++++=
++++++++
> >  .../dts/qcom/x1e80100-microsoft-denali-oled.dts    |   20 +
> >  .../boot/dts/qcom/x1p64100-microsoft-denali.dts    |   16 +
> >  4 files changed, 1364 insertions(+)
> >
>
> This DTS fails dtbs_check.

Indeed, this has regressed when moving disable-rfkill into
ieee80211.yaml, we need to reference the moved property
from qcom,ath12k.yaml also now, I will fix this in v5.

> > diff --git a/arch/arm64/boot/dts/qcom/x1p64100-microsoft-denali.dts b/a=
rch/arm64/boot/dts/qcom/x1p64100-microsoft-denali.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..93f1620ad8c71c6cf36ba3e=
c34b9eebc47bf3f18
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/x1p64100-microsoft-denali.dts
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights rese=
rved.
>
> How exactly is this copyrighted by Qualcomm? I don't think Qualcomm ever
> prepared DTS for this, so can you point us to the original work?
> > + * Copyright (c) 2025 Dale Whinham <daleyo@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "hamoa.dtsi"
> > +#include "x1-microsoft-denali.dtsi"
> > +
> > +/ {
> > +     model =3D "Microsoft Surface Pro 11th Edition (LCD)";
> > +     compatible =3D "microsoft,denali-lcd", "microsoft,denali",
> > +                  "qcom,x1p64100", "qcom,x1e80100";
> > +};
> >
>
>
> Best regards,
> Krzysztof

Thank you for the review,
J=C3=A9r=C3=B4me

