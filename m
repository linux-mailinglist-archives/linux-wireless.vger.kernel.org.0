Return-Path: <linux-wireless+bounces-3819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CE85C309
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12771F24AF7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33678660;
	Tue, 20 Feb 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dqDmFqmf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A177643
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451641; cv=none; b=tFmncJ3Quw5pnPTKzwVADue/NWiKDe3DcfyBGfe13FFkccgI9TgpT6oigeF7wXJKfLcRe80zG+A6U8TAF9w9z1uDtEbwV2/LVt/iAtBamehmhS2zut+s6UD52dvSgFuM940VDbIGVD05H/UJDkmDO8enG1OtOvTMIKeyN0tGjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451641; c=relaxed/simple;
	bh=d38oaY+K+spNFRP/qOIWiTuNObZ5xOckG4uBJUP/Mnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL10BaAffLdRyZDrBqV0uZYVxWx+91Puw3rAhRPFE+pM+BkKHDzhiS3sAWkHyn+AQTV9L5SrsABjSgaGOknGF9cx6AMaqkXSer7c6XhC+lkSNbCh7HybuMdH2sUYWCpyp6xkghV1CDj0lNWc3wExQD+mfR7lO9mlLl+WNvPnkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dqDmFqmf; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4706beefb70so685275137.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708451638; x=1709056438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DriMqP4qiEsOx9DUXcwZZJ3R+6NkNBQrlsXuZW2fRw=;
        b=dqDmFqmf/boXSO3XLftzEpiYyOHCamaX0F53wcY4GQpiuQW/2vzcNdtROqhIDlmaNi
         41o8Nq1nyOrvoLTIL/A3cIMQYXmTq2Cjxsvyk3NK7hnVBlMFTjhSAGVAurwdgztdwqeW
         jVt2HdNK35jY7M80Pawdx8zCXwTpkxi3BoUuVDYfpb+UCAn6zAOXbk1Rfe/IksHmfhmQ
         oXt/2Ch2k7erVEf5RIDIoaIW8yY1cCjQYXfObTdvxtwV8chIeWUY5YmCQak9EDtS7KxH
         haS60yiEvpExLTaT/E7j/g0EV7s1tdqQxtTdRgSV6FL8RIUCHzQTPmYA/1Xdy57iHOop
         P2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451638; x=1709056438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DriMqP4qiEsOx9DUXcwZZJ3R+6NkNBQrlsXuZW2fRw=;
        b=lpW+ElL4sog65LOR5qL9pWHBitAkgcuboxAd4MmjlKV1eb60iVPzw7D1WG8Bv7Rjda
         YI4n6DtYM/IDbR75qg1EHY5jO9SYblpXtXX7UIjJ6ZimTbEoOaVm5SaD3WPWjb1wyyLk
         UJZPXxWpDJfg2RU9fhcdgWI4K5BHppKRL9kLY2N0EnHuN/3ldFsBBtTo8MwSta7bx0I5
         KCRvgmOIiif1ia/XWU50RIKJvIxSDgK27kgIeEooaPXC+EaaPj4ke/C113hAbxDc5ILS
         HZFrpbpBpVxWtPUb9hDnDf+daT2KINnNjt/82+EQZJ8ry/cQGgUnX/S5S13+e0eqBiyO
         6pgw==
X-Forwarded-Encrypted: i=1; AJvYcCW4tcD8UVnmXml1+kfs4P4rylT0NP2RvT8NSEi8O4SqwEez96PBWUnGpm+tNwYgmzD4vDblWI8DSr7NRxTqkXzWPIS5WzywAtOFFhOzx44=
X-Gm-Message-State: AOJu0Ywnx3cSRch7IRCcyjGUdAYexWrGr3OI25Vv2CTtTvXJsrIfI22r
	Mr+UYPe9BH3ZTm3fePOBtaQAnGQRwQ7eKd1MIHYpGZnGnGoSOryak48mYquTL/RC9rdamSJuuCS
	hWzrvTcT17+dbzKhQa4sFh5il4lzUcY826VgrFA==
X-Google-Smtp-Source: AGHT+IEAXD4s0vfCLOf3dGv178kSWMvcITercQToZ5Xpgu/ylirbyvBE31sO5fq4v2ZZE2g252F6KNSh/laLzVqmd+s=
X-Received: by 2002:a05:6102:2436:b0:470:51da:3adc with SMTP id
 l22-20020a056102243600b0047051da3adcmr4445513vsi.10.1708451638124; Tue, 20
 Feb 2024 09:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk> <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <CAA8EJppzkuH=YTAHuJ3Og2RLHB93PSas004UDvpqepYbGepVPg@mail.gmail.com>
In-Reply-To: <CAA8EJppzkuH=YTAHuJ3Og2RLHB93PSas004UDvpqepYbGepVPg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 18:53:46 +0100
Message-ID: <CAMRc=MfXkG1bqGrtFWpoZo3fTY49TvU3sHOnX-zc2kjUiRfp3w@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:30=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 20 Feb 2024 at 13:16, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > >
> > > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
> > > > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.=
org> wrote:
> > > > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wro=
te:
> > >
> > > > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > > > +                             regulator-name =3D "vreg_pmu_aon_=
0p59";
> > > > > > +                             regulator-min-microvolt =3D <5400=
00>;
> > > > > > +                             regulator-max-microvolt =3D <8400=
00>;
> > > > > > +                     };
> > >
> > > > > That's a *very* wide voltage range for a supply that's got a name=
 ending
> >
> > Because it's an error, it should have been 640000. Thanks for spotting =
it.
>
> According to the datasheet, VDD08_PMU_AON_O goes up to 0.85V then down
> to 0.59V, which is the working voltage.
>

Hmm indeed this is what figure 3.4 says but table 3-2 says the maximum is 0=
.64V.

> VDD08_PMU_RFA_CMN is normally at 0.8V, but goes to 0.4V during sleep.
>

Again figure 3.4 and table 3-2 disagree unless I'm missing something.

Bart

[snip]

