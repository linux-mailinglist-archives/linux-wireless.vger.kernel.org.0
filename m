Return-Path: <linux-wireless+bounces-3820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01E85C369
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4821C210B4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD0762EC;
	Tue, 20 Feb 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0AbwjYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C277A05
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452727; cv=none; b=frzYnMtdIS2ODVklIXj+DHG/Onvu4EVFjhK6rNLUfhHxpIb93Rj50spO4AzkJMhM5lWJYymeLIkEeC0rRpEripul7ZMSKf4TTIo0J0ajefAMrPvtOLHk8/GaxJgunYZiYeJWxrTt4T5cOBNx6bIm3Pvvuo5vNP30aFbe1TZskfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452727; c=relaxed/simple;
	bh=rjveohCfD9DoiAvzq+saEkgFPozVXBVhdv/x0A4BBfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czrHrUMg2EezDRI9JFqUuX9Nq1/9/yuGfNIYFGn42wWnYl4iTLjQArjmXBUU+M/+RBT4Qw8rE1fB7kyOvUhqmrVBqNSi043B7+ze1iUhKDkf18wOSdevbvKDHTs2GpglxnVknLqsYovjKKPya7axAjXO4oxEAmdGg2VkS3Cii8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0AbwjYf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60866ce76dfso8936487b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708452725; x=1709057525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMSzyoiSjnYCnePo8ENrWusi8lV7YAbt8CP9L8ksezU=;
        b=I0AbwjYfcDTA541kvjowtyYwZzKJQGneLQsdx0crP9BdJ9irNzap9srVvFZHe+n7HZ
         gmLo46SeHTsl71FvGUeDhZsF8efx6nZRdJGlQjS48j3CYJMfDiVB7dN+RS0JIVRtzcmA
         CtFXaBEnDOs3r9BSISgAfRznbROR9iVGpSYX1KVlylyQ11xazWhx+eu5rt5v5pfumih8
         aLZbqmzySBHXVBm2TARjnDLk1tFWHsMNe2/PSFFl+wM64xRxR6tYbHccpYKYg0+b+JYv
         2fF4MMhEh496x6E6WfpxrGx5KOBTZ6iPdYu+uelOfi7+qAzY5L3wXaFXYOl5q0qbNsr5
         82Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452725; x=1709057525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMSzyoiSjnYCnePo8ENrWusi8lV7YAbt8CP9L8ksezU=;
        b=MbCyhs2pNRKgjHaAC0FGguNaB4/ZNIdnnzr+POIU8T52m07YajWwIcXLefp2r5W0xN
         ZlfOrp3WYTSMJTjgykhBeoamYgG6IJfoYdYFDUwjGNdD2VermyOTHMN6TvVZoe83fIoK
         EZCpcuemjbuuNyhTFG0/IBXdkPCkgFmkGmaIn09Oc5xFPZhdlAtgo4gNHwyosk8tvSuE
         wZcXjUlSKgvRhc8N0lD3X5JFiPNEHeBDoF9FGM2wTu+NKBhPeYnSsOw3mqHHZP0gcHlT
         ENXulxw3SAOvzi+WlZSNXh9hndVP3a7MIgFVKWeeYSNwxvkW5QW/smPbjpg7TxQJrSoN
         4QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVuDdeKx5mnZaU+gJ3z5dCdDFYII2eg+j3IP+RNs7Oj8Wk4YUUi98axuNW6PvogqaJYti2Vm+c3mZWlzyt3RjqCP6D+OnGQBTWogiaMdE=
X-Gm-Message-State: AOJu0Yxh+KizNFvcu5R/ek8R9LjiWrHVlkCpBcTuXFVTkiTiZ+Qagf9T
	my1FR6TG8lkMyWqVujjDLryebHkl5BadAX+KiDKCg2I52Kp7FTSd9cHTIZWN6BPK8MMkwKtQbHM
	mbZ+YFkKQraUdA5g2ndKzBZfgUTP7nWV3hya3QQ==
X-Google-Smtp-Source: AGHT+IFsAA0lKvQyArywji1QvO8GzVrKQIsgi7vwTu+7xayCOaldYPKMZ3USNT1VRYNim9WqHs2PSU1hSI0+O4KEIvA=
X-Received: by 2002:a25:c7d0:0:b0:dc3:7041:b81b with SMTP id
 w199-20020a25c7d0000000b00dc37041b81bmr16520405ybe.36.1708452724211; Tue, 20
 Feb 2024 10:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk> <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <CAA8EJppzkuH=YTAHuJ3Og2RLHB93PSas004UDvpqepYbGepVPg@mail.gmail.com> <CAMRc=MfXkG1bqGrtFWpoZo3fTY49TvU3sHOnX-zc2kjUiRfp3w@mail.gmail.com>
In-Reply-To: <CAMRc=MfXkG1bqGrtFWpoZo3fTY49TvU3sHOnX-zc2kjUiRfp3w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 20:11:53 +0200
Message-ID: <CAA8EJpoY_2uNLXtC+xB9cOV5Tc5Bn5mEtJTf+sniWrN9HoEx4Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Bartosz Golaszewski <brgl@bgdev.pl>
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

On Tue, 20 Feb 2024 at 19:53, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Feb 20, 2024 at 5:30=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 20 Feb 2024 at 13:16, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kerne=
l.org> wrote:
> > > > > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski w=
rote:
> > > >
> > > > > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > > > > +                             regulator-name =3D "vreg_pmu_ao=
n_0p59";
> > > > > > > +                             regulator-min-microvolt =3D <54=
0000>;
> > > > > > > +                             regulator-max-microvolt =3D <84=
0000>;
> > > > > > > +                     };
> > > >
> > > > > > That's a *very* wide voltage range for a supply that's got a na=
me ending
> > >
> > > Because it's an error, it should have been 640000. Thanks for spottin=
g it.
> >
> > According to the datasheet, VDD08_PMU_AON_O goes up to 0.85V then down
> > to 0.59V, which is the working voltage.
> >
>
> Hmm indeed this is what figure 3.4 says but table 3-2 says the maximum is=
 0.64V.
>
> > VDD08_PMU_RFA_CMN is normally at 0.8V, but goes to 0.4V during sleep.
> >
>
> Again figure 3.4 and table 3-2 disagree unless I'm missing something.

I suspect that the table you have mentioned provides normal working
conditions for the PMU, while power-up and sleep might be outside of
'normal' conditions.

I suppose that these outputs are underspecified in the datasheet. I
think we can omit the values here.

--=20
With best wishes
Dmitry

