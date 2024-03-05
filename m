Return-Path: <linux-wireless+bounces-4372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90166871B4A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F401C21C59
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398825821B;
	Tue,  5 Mar 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7cgmCkZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E55915E
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633878; cv=none; b=aMl1eU4a9Df1nSmcLKwNs9DfPHPkYPYcQV1AXysvGQxiLU3U4m+ZqPOIwaacYPJf4PInVERdqN41hFwP5nG+XeMpiG/Hsw2/3dTxgwNjNLhQNNKD7pSJHX6Zq8AHbyvnZzQuZ23N4AwBrQty5+HKah813EayIlEZfRs5DNOEry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633878; c=relaxed/simple;
	bh=02rRBdah8Kw4nKA3CoZ1lCcThz/0YViRNufTr1WnnYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=iD0ushEWLgBDJYMH5ICigeqlqYuha5vfGH5WBVYRiJb9HMIMY9LsxC26M+v3bU3UKY7XYAXD1amHqIgn/keZADBw48NgrN9h2zq99bFRgeJoNQkqoOD4dDN5SHc+gq0yiuSsiBPWyHNAU3ngic/4SOZBQgc7Es269/7PxNX+ezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7cgmCkZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513181719easo3682825e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709633874; x=1710238674; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZB2cq1jcWM3wFmeEYfToHWZ81P+7MKTxEgQqW6pzeo=;
        b=h7cgmCkZ+gbXQj5Dwq/1BSDJ8Y1i2MoLlls/esq7EreYkGiW3+uwsJqKlYuM0dAVBs
         AfKhBAGmFvzZQylvWUaGwJxOe79+M+yvmVQFYMqDi3Iva6MsPRC4rK0TXMuchXA6LIaZ
         Tt+YBTisd81swytv+aGFJ0meUSe89LB+KEUxSKlvfnefrxv+8TF580yACV9OJLedghk4
         ykCgnMfleKa73TXBQSHtuea+PPeRaFotMVu9Xy1xYHdrBq0PR7hKPYSeTg1IqWG9EKAM
         YZNCs/66EhxssoLBinw9P/SutppjVDSv10SrLZB2NHhXx2CHi1gZxdsUWoGrlM/yGSeH
         PZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633874; x=1710238674;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZB2cq1jcWM3wFmeEYfToHWZ81P+7MKTxEgQqW6pzeo=;
        b=hJtFRx+CWiZMlhx0ryd7nCFXvf0DoY888jDIOnnPGRlOblsGe275kiXYebIPE/w7tY
         b/RH7uqnEmgqgnt+irC7DQdbdf1JS1LUcu8wvINT3NB9sjgVqgkENkxk0vPK7K/hjOcr
         xJMNOym1jPaFKZRZcYewDO57bG8WzpPyO5HKOiW9+kRkWpKW/GHvuDUs3e7cNIQiBsdo
         U0R8LDdPQ4wfR7VC/6Qgh40QJI1zhfJIO1XpnDEBog3i0MIM2+RN9rpYrITx0F6XS+am
         cVbFQCkSOwgWThWpCCSP0ayREccucovJrh7KRB6r62DzghY2LdyaHZEWmP1K//AZkM1P
         Qf5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1t8CdGIuNLBQVGzsymC0skF89XFcxf4F7JtPXI22rvGpzhruLqw16d/3OyKJiJvu7PL7glA/VqBAhkFuqebw3q9MgV7qe4r93lFqYJ68=
X-Gm-Message-State: AOJu0Yx6+iHgQV5n9a83HlYggFuoercf7U+KyHPAvIxzfDy3fAB5FQY7
	np9B1uUgfj8Ifv8fALKtYQywhaYCeSjYwG+av7U2jca3rLV3L+qJNmmUTVlg
X-Google-Smtp-Source: AGHT+IFkRxSe3wb8bPWhhkE9EuM0VKNH6ziPhWKB6Bz7oBl/U+5HLE8zd9uH03EkFiFqSXaghA2R3w==
X-Received: by 2002:a05:6512:3054:b0:513:1e8a:f1a5 with SMTP id b20-20020a056512305400b005131e8af1a5mr1417345lfb.5.1709633874098;
        Tue, 05 Mar 2024 02:17:54 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id c17-20020a05600c0a5100b00412ef14a8ecsm674903wmq.41.2024.03.05.02.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 02:17:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 11:17:53 +0100
Message-Id: <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Isaev Ruslan"
 <legale.legale@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
In-Reply-To: <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>

On Tue Mar 5, 2024 at 10:41 AM CET, Johannes Berg wrote:
[...]
>
> I'm generally not going to look into these files for now, but including
> them internally means we have to maintain them. I'd almost prefer a
> library that can be used.

For what it's worth jansson has been very good to me. It has printf() like
object creation which usually integrates well with c programs.

>
> However, with that said,
>
> > +/*
> > + * json_print.c		"print regular or json output, based on json_writer".
> > + *
> > + *             This program is free software; you can redistribute it =
and/or
> > + *             modify it under the terms of the GNU General Public Lic=
ense
> > + *             as published by the Free Software Foundation; either ve=
rsion
> > + *             2 of the License, or (at your option) any later version=
.
>
>
> This doesn't work well with the ISC license of iw. Which is another
> reason to prefer an existing library, I suppose.

With MIT license https://github.com/akheron/jansson/blob/master/LICENSE

[...]

>
> So ... Like I wrote above, generally I'm not against doing this. But
> like I also tried to explain above, I think it needs to be less
> "duplicative". I'm happy to change the code in major ways to make JSON
> output easier, I'm also happy to let that change the output in some ways
> (maybe the default should be YAML-compatible ;-) ).

>
> But I'd really want to see this done in a way that doesn't end up with
> having to duplicate everything all the time.
>

For me, having a "good" json representation means, as you pointed out, usin=
g the
right json underlying type and most of the time I'm afraid that means a com=
plete
different code path because of the underlying type/container. It's always a
blurry line obviously but duplicating in a complete seperate function that =
only
does the right thing for json output may end up being cleaner codewise.

> We'll also need to figure out the licensing situation, and perhaps
> ideally find a way to not add ~1.5k LOC to support it, but link against
> something that exists already.

+1 for not reimplementing the wheel.

>
> johannes


