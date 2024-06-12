Return-Path: <linux-wireless+bounces-8880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92E9052FA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADF5B2269C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F9176244;
	Wed, 12 Jun 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tDdw4/vp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0604172BC1
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196758; cv=none; b=eoKkD7V3cX0+6UQ5+thc1DV93Rzx4hxGb0CP3jRabK4MvnKEtAPh39bdEONj/EHNiRQLuy6rKAsf1PiChRnx9FsvWmfw9j11gvYqmwhnK/eEkDELHjLWjr+DjdWB0A7drbqzppC81W/R+opRDQ5u/St6VnzoZyaCt1ZNlEKIBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196758; c=relaxed/simple;
	bh=w4GwlwGfBQlnNfyaS5mrHYpZ8wLq2fCIW70IywjAOXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZticyexBTlk9YFZeTUFka2WijtKi42lHhnT/B/X1TaflyINfyS8TatM9EmLTbaKJD9HIERETRd0RuBohyMo2R5y7itIFL5waYSph7S7YQX4K0e+oTQ88Pqatif7YTssatWCvHCli2eJP76PD+OwJr6QM8mWkr7a7trr9R/zxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tDdw4/vp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c82101407so7175294e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718196755; x=1718801555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4GwlwGfBQlnNfyaS5mrHYpZ8wLq2fCIW70IywjAOXI=;
        b=tDdw4/vp1SRAeRwaJB0KMMtJBkFnc1QT4SoqZaawikXwABGcORqfJNG1UVFJ/OYXLI
         r9mqhQPJDks1u78At8eR/tY63s4nyBhqtRne4/XxCg0cOiPUHtRE0J6UECzWS2lv7hrv
         ctF/Kt8s1PewSfoPMHUUFNzyozKHyLZ+vPzp+yX+3T8t/b16muAP73nRJPAFSHNXSBFQ
         aekWYiogJ1kujaHW4xAHt5TaMSaW2p7LGI4ykeMzTHhdPRGt7tpSuLkeo0ddPdYvENho
         tgp/Xim5lSf58ZKqJJC2ym+I2abV1X13PE0CavIkK6rEsSKRuK4grOcYiIP01npZIRU5
         f3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196755; x=1718801555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4GwlwGfBQlnNfyaS5mrHYpZ8wLq2fCIW70IywjAOXI=;
        b=qB7fyLfFs+m4Z7lCGqJiBhBPzOynCuQIQy30GzesMCULYZeYi1BEQO8cJzbLdJHZR+
         jzg3hKZgApa+rsDRPyZ+G7HuSj9s+hBVOuKG1ka6uXE7gXz5RKSrDOALFET9CyMpkrpE
         +06c9A2I+8SLIhBr3Z3fjjqOFE1BE17Ezg7IiBG3StRdRrpWK3jDH/KgEeECi1Idpn9G
         oSGf3wmp/E6C+12Y887HWLKTErEy8F76TvXtr6oUkzjCalsD5f3XJH695s02NuB1m6v7
         Rg6v1hEzfsY6tXZO48CmwEXgsVpplwUryGn6cUcw0sv9mJFWBO9CZ1tnlj3yAcV85rFk
         TS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHWlSWJ2jXQVZ/2sM0iTQIifIOsqTga4Rm9TttzI9ua+jaNJ8kIGH5c+dHuBx2x/8QRCIFuJGy5RGhLZyoOjNNLePBqlAQSvqVaBA1phw=
X-Gm-Message-State: AOJu0YzufPTyTvXQPFPV4AbuLcK0LCPp21ftMcHSlIguKvj299ewI++o
	HHWV1lTIhhQkfOx/cbQbey71+yUz44+C40bggolrlbrYsSA41nROvOlLOAGcg6vyeYInJoEX0DC
	d/8wMFykwr5ZgAyiYL/y8/2FQ8sy40WtPJvKMmQ==
X-Google-Smtp-Source: AGHT+IFe+r6yKhsmufEY9zI0E5nEG73VhIrL6yR6XIX0JzQBh8t8vS1gVMACOhRz3PdyyC7pIpNTDk6MWfIpHIDS9y8=
X-Received: by 2002:ac2:46d3:0:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-52c9a40b1e1mr1287628e87.59.1718196754793; Wed, 12 Jun 2024
 05:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org> <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
 <871q5aqiei.fsf@kernel.org> <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
 <87sexqoxm9.fsf@kernel.org> <CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
 <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org> <CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
 <87ikyenx5c.fsf@kernel.org>
In-Reply-To: <87ikyenx5c.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Jun 2024 14:52:23 +0200
Message-ID: <CAMRc=MdPQu-r4aaeag9apYP1-FoQ2-_GAk_qnHqDz-jWibRDFQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:49=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> >> >> Sure, I don't need DT but that's not my point. My point is why requ=
ire
> >> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA63=
90)
> >> >> then clearly there are such devices which don't need it? To me that=
's
> >> >> bad design and, if I'm understanding correctly, prevents use of
> >> >> qcom,ath11k-calibration-variant property. To me having the supplies
> >> >> optional in DT is more approriate.
> >> >>
> >> >
> >> > We require them because *they are physically there*.
> >>
> >> I understand that for all known DT QCA6390 hardware, the supplies shou=
ld
> >> be provided thus they should be required. If in the future we have
> >> different design or we represent some pluggable PCI card, then:
> >> 1. Probably that PCI card does not need power sequencing, thus no DT
> >> description,
> >> 2. If still needs power sequencing, you can always amend bindings and
> >> un-require the supplies.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > Kalle, does the above answer your questions? Are these bindings good to=
 go?
>
> To me most important is that we are on the same page that in some cases
> (eg. with M.2 boards) the supplies can be optional and we can update the
> bindings doc once such need arises (but we don't make any changes right
> now). Based on point 2 from Krzysztof I think we all agree, right?
>
> Just making sure: if we later change the supplies optional does that
> create any problems with backwards compatibility? It's important that
> updates go smoothly.

No, you can always relax the requirements alright. It's only when you
make them more strict that you'll run into backward compatibility
issues.

Bart

