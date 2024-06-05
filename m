Return-Path: <linux-wireless+bounces-8572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CA8FD560
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DA71F29C83
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084ADDD2;
	Wed,  5 Jun 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MlehV81c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C617555
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610670; cv=none; b=LAPLD6T+/JGZLA8e2m8+Ia6LuEgGv8Z7pg86YiSUoc0lbgOls+hQ3jaihqf3O02NhP1nioq/1qAkc4CQXZqJu4ywHDDX8pbrETxOFeIxX07F3nB3iU1N7lLaIJm5S+KCbT3xARvllWvLB8TN+wirm9aXlxJnxH4BsKbdUMXOF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610670; c=relaxed/simple;
	bh=s8KVP578g4tIAvF7jUKxEjt/8ys8vUdXttVcAIBlKWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq1q+h5vx2HtboYksCY6Lwa/iq1tTVMdgUsBeOuIkvbd9Eo9hYuv0Mib1Mr0H/HUfopNWuecYkhAyzd7XBSnKflCWs83ejrpqzKGjzqD7jQNnkfm3jQ17dX0KXzVluB3s3oxdfRyD0fhgezJUH5OvxBzJ1hvb5R/lqZoh8FZAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MlehV81c; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so1539781fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Jun 2024 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717610667; x=1718215467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox0cTDoj9EAdvqJSQWodBv8pPoGx05u+NIZ/qY+c1Hw=;
        b=MlehV81c+11vhzUjBsl7/PQu+rxcZy6u+ypfU2se7cXJWojH1uKKOsllA5AFp6Gt4Y
         sMlf0tNoqFB374baOdRT6/Q8mb1nH8A9QDIsd9f4LPfMTttMR2MviXjLQhF+llWPtB1D
         L4SmR4X+KRLqAWuBfrRnEnFhDn/QH6uH4ZZ+5Iipi5RObbqsWrPkZoagZysf50bQh29s
         NJD1k4FMNIRVKMSSThaLRyWhIEwEZU8rTjTj05xtSN9H/LjOAEQn5OrIZnsxhTWZl1Ic
         +U1R2dO5EV0KnDqDLrH7FgVOI8wP8VgwFhmGkXLFEBj+VE5AFDlTPhqev7Z0bnSMox0J
         NAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610667; x=1718215467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox0cTDoj9EAdvqJSQWodBv8pPoGx05u+NIZ/qY+c1Hw=;
        b=jzJYRr4fmR/hSoY53hnEZDyKfjrNqbc7HUMTiwuQNaTjpGLt5E5S27lYCFA6/t0/zL
         3EhqZVjvODok1lqFTpVTNe4zoXPYBkpIJ7u7IKP6Vs0GN5Pg2EW4vvBwXmnJB0uFTXxU
         rUozoItJc55d5zgoDOZPtdu3XY7YougYxsNuumReHkJGSccAftPKNFad/LFjJef/QoPT
         U5QTdQ1g5QEvvZVaBhg23Ssdmelr4wakOPwKlb/kaEVkKda4PPxiKlbTiWBRDl14cSBG
         yvghcanmjy5B4JPeCoyybcz5BW5D+2zPpS+r753Yibc5nECdFSMBcnI84o0kdksih2mj
         A9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX099ml2lLohtWO3sXPJ4j17su0/jL+XZtrhnO8qH/XZvzbL942CeX2muwSJM7+OOShP8c+WDZdqEW9dR1kt2wcthMLXah8+U/0xMJrvkg=
X-Gm-Message-State: AOJu0Yy0w4Zrmq1ws5fFzGf0KfC64VScQg8zXuE10dDBD9mzJ/LT/89u
	DFHYIoNmpzLq9THL7zkPMw4g9kgaOgS858F90etSqYRS0P6QtrQ//PZewVrOx5GrWIDZ7WQuico
	Est61rntGmx9gnkzIz6SpYvgIEAXMu79GGtW7OA==
X-Google-Smtp-Source: AGHT+IHXq8dGpJoU2dr2zBFCKOEvbFdkmlsdgV/Jz6JlWy3+wkJEsY7up5jQ+fPM273H+nj67WDMFnp7tdG9g6BvQ40=
X-Received: by 2002:a2e:b00a:0:b0:2ea:7726:4a77 with SMTP id
 38308e7fff4ca-2eac7a72b8emr19843541fa.35.1717610666844; Wed, 05 Jun 2024
 11:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=Mckab1QYoBuE3iSv0x+GEjFNBQS5Hw_Mry=r7h5XGHZEQ@mail.gmail.com>
 <20240605174713.GA767261@bhelgaas>
In-Reply-To: <20240605174713.GA767261@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Jun 2024 20:04:15 +0200
Message-ID: <CAMRc=MehAkEGJmCXi1uad1f7jZAT60OQ2N0jX7AMka4rS9OjDg@mail.gmail.com>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> > >
> > >   wifi@0 {
> > >     compatible =3D "pci17cb,1101", "wlan-pwrseq";
> >
> > What even is "pwrseq" in the context of the hardware description? DT
> > maintainers would like to have a word with you. :)
>
> There are "compatible" strings like "simple-bus", "simple-mfd", and
> "syscon" that allow drivers to bind and provide generic functionality
> when they don't need to know the exact hardware.
>

There's a difference however: a "simple bus" is a thing. A "simple
multifunction device" is also an actual thing. A "pwrseq" or
"power-sequencer" is not a thing, it's a functionality. And we don't
describe it in device-tree. Rob has said before that he regrets having
merged the mmc pwrseq bindings back in the day and that he wouldn't do
it again now because it describes what HW does and not what it is. In
this case the PMU is simply a PMIC and the bindings I'm proposing
describe it as such. But what you're proposing is even worse: this is
the ath1x module of the larger chipset (power sequencee rather than
sequencer) so naming it "wlan-pwrseq" makes absolutely no sense at
all. It's a PCI device whose ID is 0x17cb1101 and the device tree
describes it as such.

> > > and pci_pwrctl_pwrseq_of_match[] had this:
> > >
> > >   { .compatible =3D "wlan-pwrseq", .data =3D "wlan", }
> > >
> > > Wouldn't this pci-pwrctl-pwrseq driver work the same?  I'm not a DT
> > > whiz, so likely I'm missing something, but it would be nice if we
> > > didn't have to update this very generic-looking driver to add every
> > > device that needs it.
>
> Do you have any other ideas to reduce the churn in this file?  It just
> seems weird to have to add an ID to this file without adding any
> actual code or data related to it.
>

Is it really that much churn though? You'd save 4 lines of code? I
think this is premature optimization, we'll see about unifying it when
we have several models supported, right now with two, I'd just leave
it as is and not seek perfection.

> We should probably also add a pattern to MAINTAINERS so
> get_maintainers.pl on this file will show you as a maintainer.
>

Makes sense.

Bartosz

> Bjorn

