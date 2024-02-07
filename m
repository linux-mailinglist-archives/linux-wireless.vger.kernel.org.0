Return-Path: <linux-wireless+bounces-3267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B020984C433
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D331F274B7
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434BD1CF83;
	Wed,  7 Feb 2024 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="W2FZGhzI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145F1CF8A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281636; cv=none; b=J4594IGcXGFroRG1p/zT9aFiv1LseaLCV7UKwSHWAMyKMlUszbuF4amlvvBzxhVrwncK7v6oEkWU5Gl6MePmvAAA1N6YxILZsmpT5e/zQjNX5LXAGjybi003pPBQe6U1jNxgMcbRPvtmHy5hr0HxsRTYtGYikylSwVXAJ5Xiwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281636; c=relaxed/simple;
	bh=mR3bASqsk3wOCJm3bvW3W5qEn4YqW5eN8NhG0Sxpw8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNEjC0GOJg34oHL9Uy5dZbLqDte/ptJxdX7JmBrdNOyv87Wys/DyTKl64Q5Jr4srvrmJNtDzu5F6OiXTCApD2j5NTEszT4FPM8KvXU7SgVfVPgn0vnFc9K6D7ZY8J+wBYzZ3OVLaP3m9KRkIQTHNKSBsEUSilwb2LHpxGzcGKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=W2FZGhzI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egauge.net
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bee8858a8aso10272139f.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 20:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1707281633; x=1707886433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6h4+v262V8ihef7Up08xN0yVYCn5dc/xxNyPP5+lTM=;
        b=W2FZGhzIBHwqDrZN/m8/Q5J5JjSG/WUCZZe5enpSUXQTuwaaiYUqELjNSn0Hp2QX1n
         4ER41GlA/O7xMxBQ9jggharMFvrVUt3rodUrHkHEd1kCfprYNadHfYcaKN5MOGWcJi1+
         qEeKzsSJ+Mvbyu0RstX6x2/zQh4fzadbT/ckHOaYHsXstXpKP3DCU/9DlzH2sj/lT3In
         RAQME0C+t8SVzeBLunnxwzYLsprlFVQyJXgSM3V8H/JSUu7NwPATNjJNb9qZrD4Wwt1f
         5qHPa1CCmSYT66vKf/akLaqSQf4afMZuoTDp/R16EFnJFTdCYIVWSz1Wj6qkPNoSDq5r
         D/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281633; x=1707886433;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6h4+v262V8ihef7Up08xN0yVYCn5dc/xxNyPP5+lTM=;
        b=sEKQMiZlJ/C6G9p2zuIx0RHZkCUtk1J1ktHXW1hEoSzWM6F9nWfIvny//fpSjrXtgW
         P2RXXIEZ6HpZE2tiN7ONTNojmllkE2zDI2LBCvy3i8PQKfTinI41LhVYtmc26QQhw/IU
         M7ywahLaYu/dyWXYRCXEL2gH87AlOyNwcjkjKcoibaULnRfrPHAgC8UKKB3s1IK3JZaY
         8Am/5es2F5vvQSxaobP8++pi6MKVtDkC0HySK6nNV1NCvvwe57W7J0ounne+rKEcs5Fi
         1b+ETuIyUQSUI0E5hPEbHOz/m9LDl0MxgCSifW/Wm+ezS6K1NPyOLTV0ebjOG1H+AG0L
         0Igg==
X-Forwarded-Encrypted: i=1; AJvYcCXQzFSGKTPquj3tJ4O0PiNZtFJQ2ocP99xbeIUbvA0dEj5cIXADYAMWTz5SC8NI2MmVeZbBim9fxUqKU7hRb2nWt9qL/guaLAi4VDPSei0=
X-Gm-Message-State: AOJu0YwtKsRikTqvI+K7BeNRKgxGOuUopNWg28zPA8TP1W+l1lN79sap
	McmlYNHZS7b87xtGJHd2obBbtMW4yLOtCn+linDYxxsoYGWnYfP3mDwxcnpc3Q==
X-Google-Smtp-Source: AGHT+IHduJnWdWEw/B6KoAl8OsD5I8AM8beJ4nu1vPGbA/QYw57gBZJ3UWmYjZODSzoefNqylcBZnQ==
X-Received: by 2002:a05:6e02:f43:b0:363:c288:f8d1 with SMTP id y3-20020a056e020f4300b00363c288f8d1mr3546378ilj.2.1707281633672;
        Tue, 06 Feb 2024 20:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFQDGGg6U689Jz/ocg90IVJLjrEeUbkYv+YuCTsK47yofgsMA+FOb/+zTxDKGtdSp2E88FXJV8I/g9HDtKon57quApmLvJgpbBL17b8mLshIoiRaeWUyIj0q+C6Qxwdzu/Ev+8GLJa7r6z
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id e14-20020a056e020b2e00b00363d8ee8cf7sm121937ilu.48.2024.02.06.20.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:53:53 -0800 (PST)
Message-ID: <3a11bcc8deabbf06cf344cd8709f11b114cb801d.camel@egauge.net>
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
To: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com, 
	linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org
Date: Tue, 06 Feb 2024 21:53:52 -0700
In-Reply-To: <e33b2e57-729e-45ac-b14b-bde58313bfb0@microchip.com>
References: <20240127004331.1334804-1-davidm@egauge.net>
	 <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
	 <e33b2e57-729e-45ac-b14b-bde58313bfb0@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 02:55 +0000, Ajay.Kathat@microchip.com wrote:
>=20
> However, in the patch, please take care of disabling 'wilc->rtc_clk' in
> wilc_bus_probe() for the failure condition.
>=20
> static int wilc_bus_probe(struct spi_device *spi) {
> ...
> +power_down:
> +       clk_disable_unprepare(wilc->rtc_clk);
> +       wilc_wlan_power(wilc, false);
>  netdev_cleanup:
>         wilc_netdev_cleanup(wilc);

Good catch - I fixed that in v5.

> I hope this patch is tested for failure scenario(when WILC1000 SPI
> device is not connected) as well.

Yep.

  --david


