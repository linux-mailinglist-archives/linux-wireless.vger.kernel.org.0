Return-Path: <linux-wireless+bounces-3802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB185BA26
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9737B1F228E4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D93A664CA;
	Tue, 20 Feb 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iDGtm6aD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5C664B3
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427785; cv=none; b=GgvCLyyYDx5HXVQakOxSu1b140L9Ol+0g+apQHHFaHKaVBfa3vS9VcQXZOEEUtcoV6AN+KCEg0lpfuD0hzGsbXK3YWv059cGMlNHUDL4ocxRoo27D3XlTqn+X8fCE61f4LG7/0Bn9oI6D7LAXTdShdgYHEtR1og5g1p57hLo0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427785; c=relaxed/simple;
	bh=0XEVX7reUloJJ0HXCmKNanytjESGdOW7twiOSY0z6jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOLkw6HtGMebscwzl+/1lDWqTrfcV+el+eHy/er/MeqaKW7qb8Eff318YHVyOoO4TxFxtYF6tVOvVoiihIa7ltDlHiwl7FDvBT8ivg8mNAFQYYf+HtUvR4ICMjQGdr8LaZRt3HhzYOPx6Q8JWIwuchlg4uBHOhYUGJM4M8eTsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iDGtm6aD; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso2611875241.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 03:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708427782; x=1709032582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TGQQf9QVaNxe+P/ET43bTj+OwzYLCPf9zjW80RckT8=;
        b=iDGtm6aDQFMcDmVljb+fXB1UkYRGIUzBmDrTWX9JQOVFyeXsgoLl4wS9utqR9RV71f
         T+8WHTK/iwqEgTvdFhQudDhLfT4UzAX9vI/v8NGmdEsUnUPLq2PxHkN3IvBa2OGOPVGy
         LLNkNuWZEubob9k5MyrOgCf2GRn6NzxhmvgqGcfhyV5jQlXdpXjJroxrzwveUbhdM2Ay
         otnH9ivwaAR4c8tL84tYyfYHWLmNTDYIFluzKDDitHIJ8viijOpjl5JUOLopdC4YTshI
         RfL7ZXx7mldMdMT3nwydmjVrhK0J1aVXrd/e25JWwSUdFclB4zHERRvw/ru6KwedJ/Ig
         scfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708427782; x=1709032582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TGQQf9QVaNxe+P/ET43bTj+OwzYLCPf9zjW80RckT8=;
        b=bpYayQtlnBvDqmCxj2NS6gKxi7VD+y2/TA8U5bTnAG6RJBCmu/jcNFc8vUe1pUavOH
         EPdq+FazfcsHC10rS6+LCzDJN+PigcymrD/05YpmaM16CPeEIpo1OBFF1qAOl71ilJmo
         lAr27ECGr8AZGr6yVm9VqpKPc6jxwRlMIPmWqk5h/lO5ap1r49HwfUQ81pEIs/eacDrJ
         /qfKsF5i/MrGUW2PUTIvgyr2oFDwrriI6XgD8+YUoPKse6YMT/b5FyEThT3NiUD2QqZd
         xO3afVfTFZ3qKHt+bQGRmmpk7lY6VU/Dmyz2RKBgexaCq+59LJYzYLAycwvJS0Dv1+DD
         b9lA==
X-Forwarded-Encrypted: i=1; AJvYcCXAPX1O/9eoSUO7WkOnSZcRIAPA9jl1cfJgEvFgJYWNYy9YIRgTLMl/7nJiVeFSYQ+f2WaZM9XraqikI51F0yfZvmJ45caaKgZg9vESslU=
X-Gm-Message-State: AOJu0Yz206ebkWvx0N/T84pqPO9Fbl05PtNLaWnK5/v83Je7YZqvdp52
	pIdmkMOYRvfE+5cEvJA4WtY/lu9LvlqxwnnDPLXQNHL6B9qhsUE18goiiBjrKlDYtqQ7Y/xm4zU
	azbYI3dCsLbVUJHDNysQwe584TbiuXaosB9tZdA==
X-Google-Smtp-Source: AGHT+IF0CN7Ryol7qmamq7DrWXyYZkwvZgbPRNHrR3nczqiDKiEYYS7aZK8HtFSbIhrDgqTa7oMs3VHOgqV6taESy9U=
X-Received: by 2002:a05:6102:1610:b0:470:51ab:3e46 with SMTP id
 cu16-20020a056102161000b0047051ab3e46mr5334654vsb.30.1708427781847; Tue, 20
 Feb 2024 03:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
In-Reply-To: <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 12:16:10 +0100
Message-ID: <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:
>
> > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > +                             regulator-name =3D "vreg_pmu_aon_0p59=
";
> > > > +                             regulator-min-microvolt =3D <540000>;
> > > > +                             regulator-max-microvolt =3D <840000>;
> > > > +                     };
>
> > > That's a *very* wide voltage range for a supply that's got a name end=
ing

Because it's an error, it should have been 640000. Thanks for spotting it.

> > > in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> > > Similarly for a bunch of the other supplies, and I'm not seeing any
> > > evidence that the consumers do any voltage changes here?  There doesn=
't
> > > appear to be any logic here, I'm not convinced these are validated or
> > > safe constraints.
>
> > No, the users don't request any regulators (or rather: software
> > representations thereof) because - as per the cover letter - no
> > regulators are created by the PMU driver. This is what is physically
> > on the board - as the schematics and the datasheet define it. I took
>
> The above makes no sense.  How can constraints be "what is physically on
> the board", particularly variable constrants when there isn't even a
> consumer?  What values are you taking from which documentation?
>

The operating conditions for PMU outputs. I took them from a
confidential datasheet. There's a table for input constraints and
possible output values.

And what do you mean by there not being any consumers? The WLAN and BT
*are* the consumers.

> The cover letter and binding both claimed (buried after large amounts of
> changelog) that these PMUs were exposing regulators to consumers and the
> DTS puports to do exactly that...
>

Yes, but I'm not sure what the question is.

> > the values from the docs verbatim. In C, we create a power sequencing
> > provider which doesn't use the regulator framework at all.
>
> For something that doesn't use the regulator framework at all what
> appears to be a provider in patch 16 ("power: pwrseq: add a driver for
> the QCA6390 PMU module") seems to have a lot of regualtor API calls?

This driver is a power sequencing *provider* but also a regulator
*consumer*. It gets regulators from the host and exposes a power
sequencer to *its* consumers (WLAN and BT). On DT it exposes
regulators (LDO outputs of the PMU) but we don't instantiate them in
C.

Bart

