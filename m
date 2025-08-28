Return-Path: <linux-wireless+bounces-26834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2814B3AC31
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2262A1882635
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F629A322;
	Thu, 28 Aug 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dC1uDxHL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF329ACD1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414797; cv=none; b=sM2AoeARGfxekVHQKTFcKheoBUtkqPEfwG6X8EtBmO/VB6ZtlO5bXkSSKgI4wtgO/UrqeR78mHOcuLQ0HhTZsPQ3wwfqE+60jE5Lq+5Wi9/eQDbuj8Pl6P4WJBBxgH0RfBW2Q6OmieWZME3M7KvXScxDToGF7OpJ6pfoNcUP5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414797; c=relaxed/simple;
	bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5JNA7FNWVXu/kfPvebAyCGbKXN1kGNKCwDXZqK8oDFszL1Td/+opPPbEjOdvS6RrbeF1YZGIO5WVSIdQ1s1njxlYeNgo7m47FgRXJfDQP9Winn4zbTndk1Ymxgws/o9Hn7xNG+JOUTpCuoF9br7KR5BZv1Uh25nFoRkgjvPAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dC1uDxHL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3366ce6889bso9965551fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414792; x=1757019592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=dC1uDxHLdzR89Uj56ebMGaoDeRvegTy02rmD4lDoUGNwIlNRsYa+MDnEwUwxYsuVya
         Y8brW/f7t8jPxSO+kvkkj5EpDjPec/e6TYHDcu5+BEGKhiYpSHNcgh4PjIPQTjSrFuGv
         29bmDkLl6eQ4isdMBsaJKvQxTXRA97n+Owzb0UaOKn2DK5J6NDKruHPhNyLdj28A6f1U
         xa7AB1eEBovGXqonRimswFIIH/UBqn7V2U2Bz07sKbRA7ciRp74+aSbBdni3PZz/n9wh
         ArMCqsNRws0dRWKWBV/F+8m8qKVhCtZunjvcaF8fk8oIzDZryq51BDa8XZkckv0/glo7
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414792; x=1757019592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=WNSgTlIsLPtZ3LtknwOCJYbnCL+3FwuWCgC6DfM8/7SvZSZGx7DQE5nw/rmtqiPGKe
         JaCJgT48Cafpz6GAn9eFdC7uguidtHiZR59jHKaf1nczDtbqQwseJ6vTVSm4NeIxxMVm
         9lMTie1TRzAcWRE1tDDBzzQyibBZkNfRKF69go0G/zqFcUBKdf5bl1DEUKT8hHqfsVHk
         c1uCE/z3fmRB7twHX5/P6a0k6bnVuk9LB/QXTFd7iNdcOcaOm0eP8+FhpVng4xOcbOmV
         qCedgHAdEXzaYQleLjkoBPLUP9hJEokngPYCnUr+YR3uQN1GbOODeWzHH+qm+lN1NEaC
         WeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKyFFAQ1466N0+jstGfr+S8eRhv99sMlZkqliyWbAamFx/z2MxRsY+2uU3pqbaDso89m54K3CgRCloGpe4Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwToXUAMtMDvuZaUNKA19I0aTBqEdt1XYUQ2CB+7jcLlUli4yR+
	rDwoNgFz43DVcdNz3YMlNmBBkAYgVaL3LUeVdpISmYl685geLDXf7L9SLKUwbUacZlZP9z6Pwju
	2DbziixBvA96P8zaQvir330OInygruWGD4t5kSnNsmw==
X-Gm-Gg: ASbGncuafrJgOOuLw2qcVH8dYUgy8t6GtMGyi9iJ09Ik+QX544tLkfZOxR68KJuwCLC
	PnVJp6MULSnrme0cn9NtQf9HjgrkgSIVimfXlb7rhW3GtrhhAQjPIcwz3oVEBsyEP0wDd43vv/v
	Y4j1gNzncKZnj/bYZ1ghTeBGx/XZWwKNQhHbsAYCWgP1zVsQD08GnpEAt9+Gp1YqVCoUmsMjZRQ
	RNBu7I=
X-Google-Smtp-Source: AGHT+IEvCK27Dx3T+NwB4QTV9UIlsAab63smCZ6D7uUks2NtQZowbM82iFbh3N6kvr8t1WPK8CdOU0xtB51L+4ds/dQ=
X-Received: by 2002:a05:651c:3256:10b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-33650ba8612mr48592831fa.0.1756414792241; Thu, 28 Aug 2025
 13:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:41 +0200
X-Gm-Features: Ac12FXyoYnYKNXDomZzl4EdS0dXvIhCV2tkZJGb1B6Y1kaQgUA-l_NpqH411N_c
Message-ID: <CACRpkdbg8KYcDpqDKn9fqs+rL9hLK9mGCj0PTXPBGDW7A_AZbw@mail.gmail.com>
Subject: Re: [PATCH 09/37] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6020-pinctrl compatible
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:02=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC the driver
> and bindings were written for.
>
> The M2 Pro/Max/Ultra SoCs use the same pinctrl hardware, so just add its
> per-SoC compatible using the new base as fallback.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

