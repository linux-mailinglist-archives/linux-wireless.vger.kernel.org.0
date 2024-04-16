Return-Path: <linux-wireless+bounces-6395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBC8A6ACC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ACD281E2B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52E12AAE3;
	Tue, 16 Apr 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bd2Wnhbw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51743127B57
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270143; cv=none; b=IIhzx4ogsqBgKBoKO+jRltieBIfUqnIa2RvFYCltvtkMxSfW1LAlmP07iT1a9OV+9CcskzIXqdr1FyBsE9nvDV3pKJ+yKz/j7luqvZM1ub7lfodj2kIkSZB/fx7W3Km8dZONH+gZ9DAIfpZojMBeiyQErCeybkhJb+djwl+YrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270143; c=relaxed/simple;
	bh=DKrIFSDvPyPsC6ZdQ2dqkpMRmXsqmzOPCzV+pvng9tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvk17/DKLKGrhLwALB84sbZxhoJOoVE3oMcSLaUDWZsZJhMbHjuBEYph/U3+YhrGJhUr74jl6e6jcrXiSyV2yp+qSMKysVKuCTKQim3No9v8PmLoz34Ou3sFluDf2ooYegXKPBi7OAqKt1l8vLN4jFzLzyXDq1YMOq4MmtnZ8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bd2Wnhbw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4578403276.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713270141; x=1713874941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKrIFSDvPyPsC6ZdQ2dqkpMRmXsqmzOPCzV+pvng9tk=;
        b=Bd2WnhbwBZKJHegchjwgDiRJVVpJeJ2ZWWuWskzQQ2rK3v/h3FE0Rk6ayC0gC+9GCJ
         ZkELgngLgtWOpRMBFNrVFJRcz3pl3BtMKa8PXCtysA7IMD3Xhy7MUSTUvwe5yfCHaeS1
         CyjyVoBn3Kros4JNMGUkyEd48F4SlOdgr97pXTj/LFr/epWiBc6O0MD5RBlGLqMZWlVl
         N4/SOHPaymkkorLQS02tcLW+UHk8VW1ZqRdbeej6k/Kv/FdOxC7cn4b5QOh7UWsG5uWJ
         PYlX2t5mYTETTHUIAUm9GwY/ym4ZCaef9FozhP9wW09z5JXmo9czYp8AsIcat4250fOK
         GgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270141; x=1713874941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKrIFSDvPyPsC6ZdQ2dqkpMRmXsqmzOPCzV+pvng9tk=;
        b=q3Fp5BZXj9mWOHVoT8WhQ8NUHgePJ+Gv50jhofXwZUuMiUv73QrMs7VAK857X53JVv
         lA/REwEyF07RiQSt8v68j1P+xtlZzW2DwJ0NpnS3g+9KMOF9zx8URx9nOXQmsCYhKLLZ
         18yOGjaO0sSYlTVGBZsB1P41btkSx0BPPGXOb1DNqVHnW5CnviENV48vbJzeDj3cguY2
         PUrN00JftYTxsKWkChTfUfipX9AYFacMmIv1DytjHNMFyZVwX97phLiOwf7cN960oWeu
         TTMvIrZLegzw6Xn+7BG8+QF1GDZet0o60N8mu6juULACq4gGcBHXMSXgg35aZuCPKX57
         uPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZVTPeGWRbVeUD7InlEzyZgtflvHn5zdlrBTb6KTbyyW1v1a7uBM5HPpO+5RgTWN9znAAlvQEV3idEOVXUfSmIXIWUw2JQU8jqUT0LOPU=
X-Gm-Message-State: AOJu0Yw7Y1+O0JxV5srMgNaTFPi2LgiD9dK7pD63Y7hdj9dCdOCrUtEv
	iecVvQgeEcUv58mU188YvDWwltd1M4vo6enJ+DM3lKkS7Nk3QS9v1KMxRSoMki6YVkL3L8C9VKX
	uVGVjrS2Sn6zFi3xzDhfttoHhUSgWI/j0hIIpfg==
X-Google-Smtp-Source: AGHT+IH6I+79BV6weCSjyg+xHM274VtjfV8MzR1S0lXUMhI5Av+adu1GyzQ9NMJZOKWXpjT31ISM3wou5BWCwEtVdK4=
X-Received: by 2002:a25:8211:0:b0:de1:1af9:c7ea with SMTP id
 q17-20020a258211000000b00de11af9c7eamr10234568ybk.1.1713270141306; Tue, 16
 Apr 2024 05:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
In-Reply-To: <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Apr 2024 14:22:09 +0200
Message-ID: <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:44=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> IIUC include/dt-bindings/ headers should only be used by DT sources
> and code that parses the OF properties.

That's what I have come to understand as well.

I wonder if there is something that can be done to enforce it?

Ideally the code that parses OF properties should have to
opt in to get access to the <dt-bindings/*> namespace.

Yours,
Linus Walleij

