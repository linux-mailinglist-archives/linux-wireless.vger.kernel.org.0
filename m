Return-Path: <linux-wireless+bounces-5220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737E88B2AD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 22:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A6CB2BF49
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508612FB35;
	Mon, 25 Mar 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bNg693gY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42A839F6
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383830; cv=none; b=V8ELMU+MqD3TGRv7vifgxdch6eww+O186u1Ko6dNIiTh+F+r0ikvJPM/+ct5oj+gOs1u8EPwPSJ0P2CaubEPXJrd4TLVTkX0uhGT3JNi1bjUgz/sZBOZllpRSQtB56Hwj0bKwGojUIKk9VERrRW6fhHcAirJpK7/LqjUwISxBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383830; c=relaxed/simple;
	bh=YFrRYJmE2c0Njd/WjfccaQYzVP23csJig+MqZX6xV88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMRFEG959RM1gzg/8vh46iBG9s5NU4y7lNr0WVxfL5JzQX8JY+dHn0nKMP6EVIJz6TU/Mt5e6IWGn374IjjXWp5Bjajy4uk8f6GVJhNKpfzzXfG9WRHYbFg3vmNr2u3iOLsCIW3l4Qt+JPc8O54HdiY7B6cqjuRme5wE/ZXgi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bNg693gY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e25afabaso5402711e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711383826; x=1711988626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFcfwD2v6qpH4vAhBOADFCJxvrI715+cznBhJwreFCA=;
        b=bNg693gYe+XqMbXPLwytAj1DW4TWOdFgIkYynhGZ5jLpywIn73CoqucTs3oAz8BXmi
         k/Ivm6vwfw2fk13UUlQTvpD+XOJqmL2smuv253/e4EYqGUVC/F5E55gbZGVSFIV6c4T+
         IVRcHRt10DBkqxd5bu307cFUdzzSJqs/CYXplnrB6BT3w61HjpmbKzV8QK9aDcLsxUpA
         tSUOE5VIYP4vR+gbt0xhK1NDwyiYNMC2LIPd8ySb9bAaD2IfUqEJAYyc9Nmbc5bbHsfZ
         nR/Q3Rp3A50GLOyCF5d4juoXyxED0bdEXlmhBJf0CX1jnARlkRekA2F/tTDZ8zCtahKJ
         urXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383826; x=1711988626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFcfwD2v6qpH4vAhBOADFCJxvrI715+cznBhJwreFCA=;
        b=hx5eSbGYrRwRyd9K85oeCiGigSBjATQrlctgo26ZLdXT2PRY/yHIFvG8Vsgt2sIDjH
         eW8vXdIw7gmqrKotWjm9tCmfyX2rwFXIUiGMsIf5NofUEQ0iMM1/LPS6PtQOdkeEdMWD
         639DbmFb/7DEfrmZuLs9gvFBPGn04GGbRHsfW3p0lVGB7fw8XYkdgp1X87C1Jsxujs/T
         N2FCQ90JOKaivliuH3D+ccuXz9srjeYVmLHDgC8TboxhhtNinDHl2z2ru93bLORNbn2S
         whS7sv4RTm4eiJLmBea3VYAIaDYKEPSxzO4wo99Ujt3FzFjmpp8uZTn02KYUNVDgluoL
         XhBw==
X-Forwarded-Encrypted: i=1; AJvYcCV6UY+RMkbDV5Oou9lT5di0h9J+qN15NFu8N7ucI+fDxYE2kFChu8/mxxJ33u5oBuJ+pGLYcO8ZV8TIOB0NjK9xPaMx6vpW07n5KqaWMZM=
X-Gm-Message-State: AOJu0Yy73dgEYGj057tEQbDg/pwyVbC1ggBkMNr8dYbK+ede+IjpHLj+
	eZVnVstW9QpIZDKx4pP9WO591yB57UnfRBl1GniZbYsXao/557ItNq22zJO3BPDC9Lo7bSTk/Bn
	Dq4Ud2n4DdTjUuiV+13U4ZhWA1LcVx0Vf9yBmKA==
X-Google-Smtp-Source: AGHT+IH4j5PPquST9xGKo8St/ikKbO6tk+Yedi+DAtFkCTZT5UC4mlTlEQkIXAn9mq4Oivrt7Ob9WJnK0Bj5SKvyufE=
X-Received: by 2002:a2e:8085:0:b0:2d4:ffe:c55e with SMTP id
 i5-20020a2e8085000000b002d40ffec55emr4716403ljg.25.1711383826136; Mon, 25 Mar
 2024 09:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-5-brgl@bgdev.pl>
 <87r0fy8lde.fsf@kernel.org> <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
 <87frwe8jiu.fsf@kernel.org>
In-Reply-To: <87frwe8jiu.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 17:23:35 +0100
Message-ID: <CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, ath11k@lists.infradead.org, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:37=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
> >
> >>
> >> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >>
> >> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> >
> >> > Add a PCI compatible for the ATH11K module on QCA6390 and describe t=
he
> >> > power inputs from the PMU that it consumes.
> >> >
> >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> [...]
> >>
> >> > +allOf:
> >> > +  - if:
> >> > +      properties:
> >> > +        compatible:
> >> > +          contains:
> >> > +            const: pci17cb,1101
> >> > +    then:
> >> > +      required:
> >> > +        - vddrfacmn-supply
> >> > +        - vddaon-supply
> >> > +        - vddwlcx-supply
> >> > +        - vddwlmx-supply
> >> > +        - vddrfa0p8-supply
> >> > +        - vddrfa1p2-supply
> >> > +        - vddrfa1p7-supply
> >> > +        - vddpcie0p9-supply
> >> > +        - vddpcie1p8-supply
> >>
> >> I don't know DT well enough to know what the "required:" above means,
> >> but does this take into account that there are normal "plug&play" type
> >> of QCA6390 boards as well which don't need any DT settings?
> >
> > Do they require a DT node though for some reason?
>
> You can attach the device to any PCI slot, connect the WLAN antenna and
> it just works without DT nodes. I'm trying to make sure here that basic
> setup still works.
>

Sure, definitely. I there's no DT node, then the binding doesn't apply
and the driver (the platform part of it) will not probe.

> Adding also Johan and ath11k list. For example, I don't know what's the
> plan with Lenovo X13s, will it use this framework? I guess in theory we
> could have devices which use qcom,ath11k-calibration-variant from DT but
> not any of these supply properties?
>

Good point. I will receive the X13s in a month from now. I do plan on
upstreaming correct support for WLAN and BT for it as well.

I guess we can always relax the requirements once a valid use-case appears?

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

