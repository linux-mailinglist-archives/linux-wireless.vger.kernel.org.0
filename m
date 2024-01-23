Return-Path: <linux-wireless+bounces-2417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AB839B29
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44780B286A3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 21:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223641218;
	Tue, 23 Jan 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bIlwqCIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EF3FB32
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045257; cv=none; b=Rv911NT7auCJoGqTGULMVMnzo6sgvPEAIzxXZUppKyfP+pt7a2ywTmobWcaETX7oUSDsDxIfdlJ1rAllYcLNL1PLMDjSyhmEfqzYLHbkuZmxjDR9f2mRYT0VnqMCu8IMI2JJA0Wayb+sL99UrLMWnsSei+G+e1iyhSaqfb5fIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045257; c=relaxed/simple;
	bh=WHRRlVrbMsNr2m9iIM74o09O1vVBEF14r0pYhM5zcZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3sHf5403hlh/nrZkwPCwFKqqeZvkM/xTh6BS+xCQqqhdsEqxRohrtNssZXS47cOosvhgfiKqfFHmb5RNi0cZEbX705fHgntvyP6Yy9n+6gjpeBk+NUmhKkT3uZjfpSIBsVa+gnoWri85v2MFQPoCpCsOh0yO7pRaDKOxjXFR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bIlwqCIQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf1c8cc870so4385711fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706045253; x=1706650053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi3ZlLFRaWl3llLgoUVJtdy7ycenerFoJUoH/tVxvBI=;
        b=bIlwqCIQFSvwMGs/XNTwCxNe8mFGEAuQrC+tmmDKsCuzDhfJ/jqmBMTP5UiQmvI+DI
         KolpBtjmzE8HIMvuOtbX7DjIYfWvLW3Fg4SgUjdoZb9SfTMzWGv62ju1auvagO5gbWg0
         ltqLYZt4tpwjA2WfdSLaS6+/jXNclnfFgPzmXxyiD1rKzYRkTLU4ZnlGAf2vfAaX1erf
         HpwpJDNoVBXqdcng5MSW02C1RLaPSTG2Cf6n1pdE4iiaCrDuxIIoh3SzRrbyj6EfrFs4
         sOOpGIbcfmMVU89guUP1RoIMmPW/8daT5/tClUt1d6PgHwPBicGzLb52bc/mmac6Y+R0
         dkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045253; x=1706650053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi3ZlLFRaWl3llLgoUVJtdy7ycenerFoJUoH/tVxvBI=;
        b=e05EiKu8c1uZw8w6hXqdeZX+C0mqLnWEmE4nGkcWmLluTq9kstc8p0IWX27mj4GISr
         G1wYvEu1vOXmDm8zbmFBn5/4uXVevTCHrktmkHjpY8vu5Pkpbu9rGBmonH4D7+tXjzX+
         IPqxFwJpHqewberPmJ1vVQqTbtXwrCXnj7ckogAgxvzIu/N0JOlEQEkJsoktAELwKiPO
         kNsf+2R9m4NROagFE0uAeq+GnSkkCjf6rPXCkbIrofz72Lr6wUTvcz9xX+ICKHPYZIHM
         oxCEnBzRdGU7DT7R00Fe5TKNAWlJs9GhamZK2sWuk0eHYBFGHmu17VydBvZFjCNveYve
         EtfA==
X-Gm-Message-State: AOJu0Yxh4tZwd7rXVZrrPvaOwccfQhGYLwGdVR0YMWE9FCtyMbqJ53wB
	IzmQ9mI4ven0ILjH2W31br4+cvQqA/2KiaWn7GlDWyUO3E+oWiGiXKis0Hbb9RUFIbv0cS0AxWC
	cYKL/ZlqlUAFcCYFxbdkU7Sc8wv98rp2qSBhZOg==
X-Google-Smtp-Source: AGHT+IFBfB/j4H6bp50/Z6pRmYsnFbGBGPv4q2zl8w01+auMt/332faChZc969Zd420+r0FwAMn+gIZ0MAa1JjhTsEE=
X-Received: by 2002:a2e:b8cb:0:b0:2ce:211:31b9 with SMTP id
 s11-20020a2eb8cb000000b002ce021131b9mr334667ljp.1.1706045252958; Tue, 23 Jan
 2024 13:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123212135.2607178-1-dlechner@baylibre.com>
In-Reply-To: <20240123212135.2607178-1-dlechner@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Jan 2024 15:27:21 -0600
Message-ID: <CAMknhBHtcPSVHikL4AWscFcLNKWO33rT77Ed7mkRYqpaBfBvsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wilc1000: remove setting msg.spi
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:22=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>

Not sure what happened with git send-email, but most of the commit
message seems to have disappeared. This should have included the
following:

```
Calling spi_sync() unconditionally sets the spi field of struct
spi_message. Therefore setting msg.spi =3D spi before calling spi_sync()
has no effect and can be removed.
```

I can resend if there are no further comments.

> (spi_message_add_tail() does not access this field.)
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/spi.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/=
wireless/microchip/wilc1000/spi.c
> index 77b4cdff73c3..7eb0f8a421a3 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -300,7 +300,6 @@ static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 =
len)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
>                 spi_message_add_tail(&tr, &msg);
>
>                 ret =3D spi_sync(spi, &msg);
> @@ -343,7 +342,6 @@ static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32=
 rlen)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
>                 spi_message_add_tail(&tr, &msg);
>
>                 ret =3D spi_sync(spi, &msg);
> @@ -381,8 +379,6 @@ static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, =
u8 *rb, u32 rlen)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
> -
>                 spi_message_add_tail(&tr, &msg);
>                 ret =3D spi_sync(spi, &msg);
>                 if (ret < 0)
> --
> 2.43.0
>

