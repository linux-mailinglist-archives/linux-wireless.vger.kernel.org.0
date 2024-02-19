Return-Path: <linux-wireless+bounces-3778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1B85A3E5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400892848C7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671531A94;
	Mon, 19 Feb 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="udQ3cv9J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7831A81
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347251; cv=none; b=eYAyyYMdzoAgCvp5pFeOwHu3FGt3wQRMrEBrfHSXMAJO1RLSO6uW1FJ8SWiJD5/Xtg3si340EnejNyaS2JxpUy1Jj2qy0eOrMJ7nF5z2zIHCDCjIcgSV6sarxUL6Y4ScWaUpUGQt5sk2cuNGZq5CZIroju7Q07op6vDnELh/BUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347251; c=relaxed/simple;
	bh=sVsdNaxDrQaT+5xLkuNNBvQ4+mZpUehI+ER8LAoDUdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTWo7w6r01pF9wJUMHymwOwYByzKqgOTFdVBIMxPZVbNgA+/6ggl0BvL2YvmTCkfi5Fi6vzlxR12Buk8veZKD/SzcgbAzArId+d/PcDoIHA7itV30pZC8Pzhg1Lej1k7AICQRusqkUbwLkSlEbHDnJ99aoBUtFZmWr63xlWj+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=udQ3cv9J; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso1395352241.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708347249; x=1708952049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVsdNaxDrQaT+5xLkuNNBvQ4+mZpUehI+ER8LAoDUdY=;
        b=udQ3cv9JtqKeraoYuLqdfWfwCCI8IqdYdtHNz3famgOyfzEASJbnUbi9Ip4iBFsEfQ
         Kl8HsjfC+7SkcF9V5ISgTbGDqgyoHJRrjgR0/PfVtTCIysmhpDAH+oe378A755J6JlXM
         1r94W6myxOuaOuRiIVphSmifjG0c6dN6Ppy0iQ1WbUj5I9pPZilN2tTRygjbg9MKHk3d
         pnM2uYsVw244oGzm9Y/8g4n35ljis+R+dRxgOYJIEg4XNhXjTDndDIcQhpEsUBMx+Bzb
         /xqB9GlsDT2n1v4h5B+LoZr03fuAttuy4C4vf+rBZrpUOCRTZoFDTdRI05jcpekZ90R1
         U54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708347249; x=1708952049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVsdNaxDrQaT+5xLkuNNBvQ4+mZpUehI+ER8LAoDUdY=;
        b=IgJiRK/EvBDge6d9wDK5AJxRVRca3/rbJFa6v2A76lC3EF/sMGZYNWHKnayg+6qmzN
         yWtN26fanv9bn4S+I+CtzM97W0cdV6wc6PgL3lMD956kspgaXyh+hSLKVabt0fROt3CP
         WKzR3lT+9yrPDVp6IeWreG8hzgTgbYeobyCIi4Ah9l3FMRmnnMIFYyVfD/bbkVCsfiec
         0MEG3xQgE8SLAbSziFZeCGRQ3j3yWIkQeXDSpkzsjm5dnjEYdnwCVSPt+BZsgOJIL52P
         9jxqx7sMpVw2/U+0JGqTL117FP3QfH6qCPa60V2dw8fXMhfCGYBuk3ERs2mPYHzaWMAH
         eeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNv4s1JgYt+ayEBelYBG8NY1FIvdX2W8V25mRePyVvj/373308W9Q8os8MUg/jS5lQOjsVwHjJIDFRh2Q04WGN1Y70giVyClzeKl7Tu9Q=
X-Gm-Message-State: AOJu0YxeTxnrp65jV+qeNO8Q7v51fAzI9M+0sKPj/06yVsjoJn+8kvgy
	xMoOz+II7tUCvNBZCEghMrnGZJ16UhBXkPpLoG+Yv51ZGV5e2cDnhla31JXQkCT5oVOLfDv24fr
	/neSPzycGlvYAEkZ6DVQ82ucPHOBu1O6Mr6GXZg==
X-Google-Smtp-Source: AGHT+IHxyvxbs8UNV+RvesaBK90xtZZfu2Xu6HFPB14T7Tm6G1AVsPn3zgxyvNAFZBNi1d1T6kkfRUxMA6fnOOW6aBY=
X-Received: by 2002:a67:c902:0:b0:46d:2b65:aa16 with SMTP id
 w2-20020a67c902000000b0046d2b65aa16mr6787860vsk.34.1708347248824; Mon, 19 Feb
 2024 04:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-4-brgl@bgdev.pl>
 <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk> <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
 <7c1327c0-d0ea-4797-a5fa-5844ba46bf53@linaro.org>
In-Reply-To: <7c1327c0-d0ea-4797-a5fa-5844ba46bf53@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 13:53:57 +0100
Message-ID: <CAMRc=Me=3HhGc_yZuaEo1TsLbF2R=g+072185_PAh5GmAQ-M7w@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module
 of the QCA6390 package
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:32=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/02/2024 19:32, Bartosz Golaszewski wrote:
> > On Sat, Feb 17, 2024 at 4:48=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> >>
> >> On Fri, Feb 16, 2024 at 09:32:00PM +0100, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> The QCA6390 package contains discreet modules for WLAN and Bluetooth.=
 They
> >>> are powered by the Power Management Unit (PMU) that takes inputs from=
 the
> >>> host and provides LDO outputs. This document describes this module.
> >>
> >> Please submit patches using subject lines reflecting the style for the
> >> subsystem, this makes it easier for people to identify relevant patche=
s.
> >> Look at what existing commits in the area you're changing are doing an=
d
> >> make sure your subject lines visually resemble what they're doing.
> >> There's no need to resubmit to fix this alone.
> >
> > Mark,
> >
> > This is quite vague, could you elaborate? I have no idea what is wrong
> > with this patch.
>
> Use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> Best regards,
> Krzysztof
>

Yes, I always do. And for Documentation/devicetree/bindings/regulator/
the subjects are split 50:50 between "dt-bindings: regulator: ..." and
"regulator: dt-bindings: ...". For Documentation/devicetree/bindings/
it's overwhelmingly "dt-bindings: <subsystem>: ...". It's the first
time someone wants me to send a DT bindings patch without
"dt-bindings" coming first in the subject.

I mean: I can do it alright but it's not stated anywhere explicitly.

Bartosz

