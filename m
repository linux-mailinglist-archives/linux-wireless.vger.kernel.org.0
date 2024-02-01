Return-Path: <linux-wireless+bounces-2968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D892A845E39
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F42F289308
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568BC15F313;
	Thu,  1 Feb 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhDjTc1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B15D5C6
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807596; cv=none; b=ABdaZb8KpZj5EL2Zen2ScdvvavnV6mzvhz1bjjPs9GTSj7R3bCBdJRjhAu3G+2Kd7q4BRskoKyEXKVOMvWSFHpMU+2Jx1yDKRmSkHa+8n6SreLa8KUC4LToAJ0kwwUR7wvAgTZT0y05nydbFPrRl0bXK6uAT+LIKyoptHgI3cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807596; c=relaxed/simple;
	bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/GyJvbPkVXkkwrxTicQOGjpWCZjo/Odr22j8gqJ0eX0oxZXdV/pfWTwmQ8q1u4UjszXR/ya/yRF7gCipqpZjIKJ8VWMXMjHX0X/FTrq736foS1wByVBzb8DWzBgjlASmZgA3qjTlVbMq5zHtzmeI6hAUNecfAg7xMC8hwPC5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhDjTc1K; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60412f65124so11822487b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 01 Feb 2024 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706807593; x=1707412393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
        b=LhDjTc1KJcWaR4PLsilu7ZtEfElbUGhqoDk13LqKyyO3n4iuvKZ0ItnZhxIEiKZK7+
         9X+U/GFmeMj4kkXAVoBkgqGO5aZriCn8Ar4CKOi//mf3GsnJIB9r/bof+IMVSzdld/kL
         HXUqzWLYJmrr9bUvV+wF/V9oGrbEpytFBsojjGcSi3FVhwswFBK1uACDO+K5fy7OVd86
         xuuNokPiZNJ006PyAmZrhUz672/pqoCLS+cm7svA2aCTJLtqv5faxmj0/J8p1gpkkUO2
         cq+DKsyei2u5qyKsddeC9SYhqH3HRcGrWae1GCDy4ILN/5P3wrXaKY1C+gcJiZZjIgjD
         NtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807593; x=1707412393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
        b=eTwLlt+5hu3n/PUa0EYRngTaTPhAtscMBlU6ca4u/jeo6SQxnOy+l3s9T35x6HRQsr
         MGYLlPPNjxNTS41CRkS6GzibcbxcztpU7gZqQFaxwx48+yJnia04LwnS7QkBcGaoIlQJ
         d5OQ7EMYVgBsGa0zLhsmsL0RW0BSJetbp0v9ULrrBRk5DCUW56etL7fdlfANglwv3fjb
         /1KzFFwETTooYSNYHjE332b1jhUrGc0swPCvP1qRHaXme8A9xz+ozUoUek/T3UYx//21
         QSfLMt46jnvpzjLEpoWDw2OOns/uhQmP4jd3/geE+Tv2meJr6mExnYz34+FToFbFmTTm
         puLQ==
X-Gm-Message-State: AOJu0Yxqej22nDQYj07niB6TmfOernL++qYalZrmVw/JaaPGnCuTAPZJ
	e7q9EpUQ8/t8nJ92y5T8uc7y/fOKkxBJsxykQKnslWHtlJ/1xNsp44tNske8knqDGduk/UVhpoh
	0IcbmH4wRU7T3nrl09ESA26llevjoLK6eTwDRJA==
X-Google-Smtp-Source: AGHT+IF3bijKL7kgDRK4R8txTgQdk15F+QD9DyIXZVD+JcVabqZGqse1p5DidrBs6catCWCCGQ7OCKK8ujCS3Y9k1dM=
X-Received: by 2002:a81:4318:0:b0:5f7:992:b018 with SMTP id
 q24-20020a814318000000b005f70992b018mr5491584ywa.5.1706807593730; Thu, 01 Feb
 2024 09:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <ZbuDqwDUaSIaOI2w@smile.fi.intel.com> <874jesuz0h.fsf@kernel.org>
In-Reply-To: <874jesuz0h.fsf@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 18:13:02 +0100
Message-ID: <CACRpkdb2nMMxnurAavG9RFzBBz-+H=CkX6XhwOwftMJwFfKu2w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
To: Kalle Valo <kvalo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Srinivasan Raju <srini.raju@purelifi.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:53=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:

> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> > On Wed, Jan 31, 2024 at 11:37:19PM +0100, Linus Walleij wrote:
> >> This converts some Wireless network drivers to use GPIO descriptors,
> >> and some just have unused header inclusions.
> >>
> >> The Intersil PL54 driver is intentionally untouched because Arnd
> >> is cleaning it up fully.
> >
> > Thanks for doing this! We pretty much want to get rid of gpio.h along w=
ith
> > of_gpio.h ASAP, that's why I expect this series to be applied in a fast=
est
> > possible manner.
>
> This is for -next, right?

Yes. The urgency is "in the next few kernel cycles" not "tomorrow".

Yours,
Linus Walleij

