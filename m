Return-Path: <linux-wireless+bounces-3725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6E8591C2
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FDC1F22B7E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08397E11E;
	Sat, 17 Feb 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z+fPtnzm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991541A91
	for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194749; cv=none; b=O6q0HH9TDJ548Dyu7B2EZ1wXF9hQkOkW5cCmvK+Q608GtQppo+jWZ5URv4IKxM/crLWCKaWAZp1T7f7xcyC3Mk1ipYQBXuVJ2vDUZoUAl59r1iHf1+FqEQfmc8EQ/cUN3rV57MUkeuPRXO53WMnTn/UkB4k8Q+72i0v/CfnT4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194749; c=relaxed/simple;
	bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St7ZJ7IrvEV5vRwl5JztC6kfADQtG9zEi9u/gcpeO86W4FQRVAwFwwUwmpclYKd8VweyltOMaCc7kUXGEmDtUcH6XB/5gkwnORD2F7qNMpmlr9v4UOZoiqfJkHlhlwsvhnl3aRJ/hS64jnt5ttc6r03JhGyJYavdpIy2eHpeJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z+fPtnzm; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so1931042241.1
        for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708194747; x=1708799547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
        b=Z+fPtnzm85GoxFE32FQBUME5ZUSR/B4P1OWO4L1t7E3sqVZetWZ/72KdOfwtipiWk5
         L7IL5WriHIXVFjpLzRkqwRnr40KE9nz1pDYPt1iMp/DMN6tnPBuDAqv4ErOeszP2Haae
         vrQg61iaJjQt0OjTt7jUde5bvzeLZy8aQI3AbLDJEj+vYEGq7F06elox3Fa38mDRPCDP
         nogoVaSVwWsZcHH72Yh39cJKO4z4MXz3KyKH9pS4ssR/wQHwuSrcDfMDzWqbUALgJmf7
         UoQ4FCIDcP1Ox0OViAJzl+ZEQZT8MyVEUJGyPSz1CkYipW/7FOPhmsrcHz6yq9IH7F/i
         OZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194747; x=1708799547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
        b=Q71rx/JbqZagPBmaJ9hcneeUuZzpIgIuvjO+Qfop2yZh5heYGwzY2kGfBvCZuXO5W1
         VKIAsMBxHVsSunhORmrv8fddheeVUXT8YWjFbIwFOIhUVLecFxcvG5xdorhXtvjShpK1
         r2YoOIiXgXdsuAJSbiKW00VOKQ+REaXjmF3AGdi5dCZRnPYxvPv1c5uwsszAMFqTtQwM
         4c8My04dKnaPWcBDkY1WCkTywcwlJiNa+HF2J1h51xRFkb8nP5qdDC3/OoJvsO6nbd+Z
         LNdczbFrMCxbHmT9W0dIQCV+LYmB4/WLNXK47O7A4KkhntLlWnghuq6Moq2RzmG7mWa4
         NX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq9byxddj8nU7EKOsGGjmpB0ph7m0fgXcKJkxa2QVBnFskevVqvMm6UhiRB0zl0yWDuxBo2dJYjlOofhyFk5SIqpKlaWArZvZsrFxc7Tg=
X-Gm-Message-State: AOJu0YzQqBgaS1lUbbE7Uvmgi4xaOITnhP0cH0Kknu/yeZlH8T3FqjPD
	CSrVpUCrnS7E1PBesqlN750UxexAJE5unHKAMDWMoHCu+u5HtPXdH9UsCWQc6ElGB1bq8o9xNXi
	Cpd6cctpH1kcqZ9LAVFmcImRJTkgxkZ34K/cyrA==
X-Google-Smtp-Source: AGHT+IFEjgGW7fKzH9O8aPqylmVeeWs1rMw3O59IYiYOUkypD1mxg7ZgMbhhHM34XumhsF+9CITrBlLVb+C2zYLhdF0=
X-Received: by 2002:a67:fdc9:0:b0:470:419f:d42e with SMTP id
 l9-20020a67fdc9000000b00470419fd42emr1433176vsq.10.1708194747045; Sat, 17 Feb
 2024 10:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-4-brgl@bgdev.pl>
 <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
In-Reply-To: <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 19:32:16 +0100
Message-ID: <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module
 of the QCA6390 package
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

On Sat, Feb 17, 2024 at 4:48=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 16, 2024 at 09:32:00PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The QCA6390 package contains discreet modules for WLAN and Bluetooth. T=
hey
> > are powered by the Power Management Unit (PMU) that takes inputs from t=
he
> > host and provides LDO outputs. This document describes this module.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Mark,

This is quite vague, could you elaborate? I have no idea what is wrong
with this patch.

Bartosz

