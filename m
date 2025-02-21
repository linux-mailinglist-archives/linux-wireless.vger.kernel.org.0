Return-Path: <linux-wireless+bounces-19278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75731A3F57A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 14:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D282189D1E8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A920E02D;
	Fri, 21 Feb 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ocs8BcLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30A20D4EB
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143199; cv=none; b=anIRptZIW0OlYSedWTlAenHDWcw/zm0owRgGSBMVJ/K9hqdnQPnpy2MpX/CD3FuvAjJenXHQeyVdC9f9MNgoUJumGmkoMZys3KN57vREiOpjM+CekOUjRb3RiI4Euv/QoOyb1xgLyX7qEJfMNhYw+vlcafrzSNPjqEWN+0QtXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143199; c=relaxed/simple;
	bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfWIUuEdK9Ey051eXLnM1iYHmlZ4wFwKvm5PYkn6IHnneBUyhLEOLZKeSsKzOCh2CPed/6Iu7Wznu4doXVkdjb1gYueCZQ0TUTN0Uxc4MhjG7mLkRXe8vBr5ugy2OxGQlZH9jLplTq9HpG6qlG3Gp1kHsMLroQWTQoClYPInWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ocs8BcLD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so2135360e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740143195; x=1740747995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=ocs8BcLDVX0cFE4GS7mdtoyTmdq7ov0aDknHxHtvq9pyWd+CzzxiSTj0LDGbCb+O2y
         IjEppM3n5enmNQpEeHa2spfrTWNe6L51o8MBwFqRm2r5bp6uWo7nIwTSxWFeEZVKb06j
         qBZWHdVKsdcaIx5WmsjZknBd+np0SH4ChBYDnpyBg9iRPhRhLgTs1mrUMTVrlzJ3HaWQ
         qlOaX5DLH3FRuWJpD9RL+PkuyZrD+QMVkTrFaJxVMC365ur2kVbzf11ksEdOkjVm10Hd
         zdx8/zMhfRIvLwT74dGk5Szikj2e9IoTiLl9yVtNpAq9mkf0Kn1BZLOF2OjzqzG1D3z8
         3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143195; x=1740747995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY4Bqjj3jHuhIZ/yUC1V1L2T+Ec/puqWZDF72o9O3bU=;
        b=U6ow9MOMmQZ34XrH0f3wuGyYwC3CGl8rojCGocJu23xWBzVxIvfAwrnnL4ANW2BNel
         s+quhPrAiSOWftRGnbg/ITW2AY0/JPYzrK54A1QFyF2NJq+i/2lmTGU6omDl1DUOhni1
         SqUkdXx16voFpea/SFhp9V2fRnJAQd6ZZ3Vs6nUIXjLKhzq5aCJJ6y4ShKo3kEWRk75E
         a+bLn7dfw0RPdu6L0XyowqnuqfTgkJo6tOTPVhJDC+hOkXv/ZgDRIAdGQWZUIaRtjAw/
         uTu9Os6ldu98fFxesQQspiPG1D7n6t/9PK6BzqKzSYB3JOEEJUBmpPun1/4A9Z4cA+J/
         Jc2w==
X-Forwarded-Encrypted: i=1; AJvYcCVRvLMcQ/bM7ALd5QhDDYteYEJaZamkQ0CpkTvoyuKOGvm/9ld3yoFZM+mdox8vz9OsQyODveF4MaI799iBFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZVPGGsqxMKZ4shZoWOSjiVjywj21Nv2Tqi1tZZpoaiPy1vZV
	pcs476/+rtIGUPL5rbxe3CD2PMZRYcdLo1rVE1JWZ/5pTma9wZlIldp4xAXKpbhZqUfIka+BFHS
	BSxcfX21jwAOAMb5SySvMtm+EHHpQwtZNygMYaQ==
X-Gm-Gg: ASbGncsLxiBQS+/sTck9WDOTu9sO+rzTEKKIDfUO0lNq4HXMXhh0ytewF2BP+jZh4B6
	QTBSpI287mDjHM+JZYpNdHZBWroqe1VkWPqWYjYGJt1JIhhhwL2yUp4lwdp8oP5ycJfZ5tpqE4H
	ouTffko2Odm5fKj3im5PedBkPZk/qJe45xUrG+bRk=
X-Google-Smtp-Source: AGHT+IGvF+qVoZb/YNG1V1s6uhLH0tipo14kcVPCZjvopoT6AHOJ53n961FIS1cHHYi7UkY/30eVAcyuJ5RU22yTz1g=
X-Received: by 2002:a05:6512:230a:b0:545:17b:3cf9 with SMTP id
 2adb3069b0e04-54838f5c910mr1152614e87.48.1740143195091; Fri, 21 Feb 2025
 05:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Feb 2025 14:06:23 +0100
X-Gm-Features: AWEUYZkXE5OFXjjPS11KVvHprrUdePtYS343T04IUIfa13H27L0Aw2Tb2OnslNQ
Message-ID: <CAMRc=McG2xLUcE_yHq4MiFnm665riHHuHjk0GJE4cFV_gGU90Q@mail.gmail.com>
Subject: Re: [PATCH *-next 13/18] gpiolib: Remove needless return in two void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:02=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Remove needless 'return' in the following void APIs:
>
> gpio_set_value_cansleep()
> gpio_set_value()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

That would normally make sense but we're getting that reworked[1] in
this very cycle so please drop this patch from your series.

Bart

[1] https://lore.kernel.org/linux-gpio/20250220-gpio-set-retval-v2-0-bc4cfd=
38dae3@linaro.org/

