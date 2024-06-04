Return-Path: <linux-wireless+bounces-8495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6308FBBA8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 20:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E2A1F2602C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69814A633;
	Tue,  4 Jun 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UfKRuEKu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55A14A4EB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525681; cv=none; b=qB4SI8r6YI6+DkPHZB8Oe5dw+VIMb8Tu85MGbnwgWLDDItZ48PrgooPahxA16Ogr5jOzIqRUyXv3PBjaPx+JhbXQlsKquY8RTLJoRpdYxy0GvgjNzHZ++XZvNM0JNIdxY/MbC4/YxYiRxeIYiVUT1yutxcbAz31BixTM5c8tOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525681; c=relaxed/simple;
	bh=tgO7W51+bHcDvjyP/YA64C67mrFqdBGIc+5LxIoRFGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meqAbzTTjOQSThVQYx1ehkL4iyXNedhFHnCXZLsW4Q63Ra0jx4f7MVtFm2dGVkFQsLJbRlNbExQCMqN+OZ4AzaatKHmRF/XAJNmIrp6r9pJptIinPb+i0fZiKTsCP9v/ElQ4m8RS8tXpKEVFKE/DuQ/dx0rfkh7yGQTMLA+2fIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UfKRuEKu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so4427311e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717525678; x=1718130478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtWwyHQ/s1Mo+jSgQ3jPju5LLIQLxY5LIc0kGaj+Rp0=;
        b=UfKRuEKulQPRJ1eQ1jv5CPwj5N48I2Hd/0RecNZvR1umL2CaLMmHTBGRewMLx8xPVy
         G8ohgactJFSAKbfIQPzAjtKfd0Sxw9ZtghZ+gPnY03Zy3F/AuVdbxqpIYaBWAInoXrKp
         gIaaWDULocIxS0mx9djiuvA+RM3Ihq3jAZBVqt9hPjKydR8f38k2Ee3Uek4sOlzndqk/
         dD4Azb1LLUXGqSiMu5p5k1byuGyaulNDQJDToit2cIh1xnjFr2Vmb2+SP6i40KeANUvt
         HughqwuP0jI2ouIrSLA5Pi2guWDS3j1FF1vd4CKJq38kHz60Q3jIWz1rgtycCn6OtAv+
         yGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717525678; x=1718130478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtWwyHQ/s1Mo+jSgQ3jPju5LLIQLxY5LIc0kGaj+Rp0=;
        b=RpXctc6uuBzWsvdPcaqknDVS3/3e+lovUvFEhZ0opyFsV/8g4AxZ/ax4yes5kR+L0Z
         tfaCX24eRK54AgSLuHqIFGn1A/8HrWVhB/j0ejtC6dfqC/CSvYDzfO2MapfUIJn61QTY
         oeqceAbZqTRA8yS5KFxdJ0OEzDPoWGZ64n6aSKWdYS4VQp25WOgI9pnPw6GBlTd49/Wu
         pgOx/VNI2ladpqIJ2DtezqHPkg3gLCNfIrAwpc5mAGaxkVtH67a7qbiHa+rTc1BqFKXd
         ESFVEAg+gQZDjKuYMZAV7PVkIqvGmxmjLRcmvW4DOxHGNIi3WucHxUrRXt2JnYwmqh9j
         etiw==
X-Forwarded-Encrypted: i=1; AJvYcCXvNNSJ5YYZDB+3zoxLD0AKZtnbCkY/y1OXtUTZLnx/0tKXp+BQiKsVTC+/D80ZMMWVeyn+tOgnD0uOiXrniSaCjbWhVf6xSjpoNliw3kw=
X-Gm-Message-State: AOJu0YwZ9tUAg8VHXMM5mD5U23TPiurXvNY4+1fy8J11b8zRbFdID6Wh
	nBr8XYITexPbU5Jkyfl8SrWGFE2Zh55NJL1ZPhpiZvj9Owh8Va6+/7OPUKSgL2sCQEHntNVLhHy
	wABqVmsqAhWHgvRduszR4MxdDstzhf/hXKByLSA==
X-Google-Smtp-Source: AGHT+IEIBmN6Pbw21C48aFo92GeQIhF5kiBTsuKNdmIGqw2sOD28tsikvtBG3m69ha2Gd5/MsgbO+7NQyJOTbJOSXRc=
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id
 2adb3069b0e04-52bab4ca5e9mr311493e87.14.1717525678190; Tue, 04 Jun 2024
 11:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-10-d354d52b763c@linaro.org> <20240604174326.GA733165@bhelgaas>
In-Reply-To: <20240604174326.GA733165@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Jun 2024 20:27:47 +0200
Message-ID: <CAMRc=Mf_n9xcFHofq5Q_X3xs=2jDeor1zfFAd=bM0FywyhFUJA@mail.gmail.com>
Subject: Re: [PATCH v8 10/17] power: sequencing: implement the pwrseq core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:43=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:18PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Implement the power sequencing subsystem allowing devices to share
> > complex powering-up and down procedures. It's split into the consumer
> > and provider parts but does not implement any new DT bindings so that
> > the actual power sequencing is never revealed in the DT representation.
>
> > +++ b/drivers/power/sequencing/core.c
>
> > + * Unit - a unit is a discreet chunk of a power sequence. For instance=
 one unit
>
> s/discreet/discrete/
>
> > +static struct pwrseq_unit *pwrseq_unit_incref(struct pwrseq_unit *unit=
)
> > +{
> > +     kref_get(&unit->ref);
> > +
> > +     return unit;
> > +}
> > +
> > +static void pwrseq_unit_release(struct kref *ref);
> > +
> > +static void pwrseq_unit_decref(struct pwrseq_unit *unit)
> > +{
> > +     kref_put(&unit->ref, pwrseq_unit_release);
> > +}
>
> No existing callers of kref_get() and kref_put() use names that
> include "incref" or "decref".  Many include "get" and "put", so maybe
> there would be some value in using that pattern?

These symbols are not exported and I personally dislike the get/put
pattern. Best I can do is _ref/_unref like what kref does.

Bart

