Return-Path: <linux-wireless+bounces-3268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FC84C441
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 06:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47231C25568
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69121CD19;
	Wed,  7 Feb 2024 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="TogU+6Yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A91CD1F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281998; cv=none; b=pWiwQCmb0c0SatpzoDHsyreBFNMvxVrRE75rF4FyjWX3SKXcPUn7HhaRqU3Q3PWI3kEzQXzUKWg8eYRU/Qs6i8jBotd0BXBcZpMte+gTrusiqsWuITvQQ67k3OXDiwf6I/BgC6rz50zKrVAT0lGWmJ3E0GB1t21eks5bgWY6k9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281998; c=relaxed/simple;
	bh=fF1XrFVEhMyD+k3GYMNnjvNQOnQz8MRSGXawhTk/hR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wrw9XbWJ+ODzUpbWSi6kaT1Ex1oSmROFlHyXp80E5jqxqa0je4NkMFA0l4BnH5gglL+OfNg04/NMxbnc9iQqpVG+A8md7I24ELmSMSWxpsuJyrXAfDLcU4DXBtthoOM5AsUJwVhdEdDhGKktocsLoYdeE0T+Jh7ABMp030/A/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=TogU+6Yx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egauge.net
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso9979239f.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 20:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1707281996; x=1707886796; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8oDoF0RtiYuawM9qKNCm5v3ts9j6hSGWKbVhHFndIE=;
        b=TogU+6Yx3jXr13VywVDnwyKimiX3ChPY0UBc51FQ0jxnGKyAkj+d+COzlKOmcvoE9q
         Yh0uWD+2B39clxK6BEQSpznIhz1ijo/sqIsiDbxGGjzni+NvcO2xrUCK8Kef/twjY7i0
         FO/xPRLA+mcV6UsLt4XX8WRSvQZ6ZdIxemdHmm1DrxKq3dkpJssBpHgFS7GYf83atENn
         cDxK3qvwGmykxCcSA/q6jN3Nbev5Y9WnX157/sy2YVQJk6IlwAOp+x4dJjd1IfBubbp5
         xzIJMsPrQ+ejDovQPpcbLkYWuDf1fGPD15RLcFg9qb/X20/Sx0kkN1w3hOu7MsjbgVgx
         6ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281996; x=1707886796;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8oDoF0RtiYuawM9qKNCm5v3ts9j6hSGWKbVhHFndIE=;
        b=N4UvPhibJviKJa9wO1g6u3Cnvxa3ta1xljpcCNRmIKqLCKbSJM4JxyflrM6e4hlQHk
         0zuZgbLY9684XlOQEI07rmPiz6k09rZu6+UO8B/0N0LjqZCwMlnHeV9j+n6J2Sw0Nv5E
         34+OR442SgeV3kTrr/QqvCwnNz7RUqYQFcy+mN4JjgpbSdT5nMXltQLqybM6jar2FBu0
         KxgJGU0D/4cWHgxWfnaTNqFjrpEa9yEA2ZEQ5ZRaA6RG89qJivKDVfHzqfNuHNzpMnnr
         IAY5C1g4yYnRGlonYx99T9GL9rh7fFvimiNaf+GcPNB2HOx0XW6RGGlGmN5ivE2Sy0FV
         Wctw==
X-Gm-Message-State: AOJu0Yx4VxExGVahIEzc5sfCNyy9smx1qrav8EJHS5QEE6qzgG3KemvS
	8jKrBs6hTTxbUNkvfG2H0sivDSgBV2X9v2KXxxLLnmF9gDAuPCCdNTAX9IfE4lbmWXrx8P2HwTw
	=
X-Google-Smtp-Source: AGHT+IGkF0lQfYkskdLJcJR/kvd/YiUjapbsNHWBrl8wgz5XV70xi0qvUo+++i3n6Z7iD50rp8kx6w==
X-Received: by 2002:a05:6602:256d:b0:7c3:e8ea:cb2b with SMTP id dj13-20020a056602256d00b007c3e8eacb2bmr5258973iob.8.1707281996140;
        Tue, 06 Feb 2024 20:59:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6x9tJznwjNO2uO3YELHeuU+zDJREwtceEm/oL4zDx+tMU73Psw38lfYjlKqrpkW7M6yiEnkNXLztoxPblVyuC7gX0m0g3KCc0AqDKZbdmdFCQmNvowrlwtNly4086dEAgIKp9fQ==
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id f22-20020a6b5116000000b007c0126a5a38sm92975iob.46.2024.02.06.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:59:55 -0800 (PST)
Message-ID: <e8aa38252c0700df16c0023b0cde81594259a5b5.camel@egauge.net>
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
To: Kalle Valo <kvalo@kernel.org>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
	 <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay.Kathat@microchip.com
Date: Tue, 06 Feb 2024 21:59:55 -0700
In-Reply-To: <87cytgv6nt.fsf@kernel.org>
References: <20240127004331.1334804-1-davidm@egauge.net>
	 <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
	 <87cytgv6nt.fsf@kernel.org>
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

On Thu, 2024-02-01 at 12:08 +0200, Kalle Valo wrote:
> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:
>=20
> > On 1/27/24 01:43, David Mosberger-Tang wrote:
> > > Previously, the driver created a net device (typically wlan0) as soon
> > > as the module was loaded.  This commit changes the driver to follow
> > > normal Linux convention of creating the net device only when bus
> > > probing detects a supported chip.
> >=20
> > As already mentioned multiple times, I am skeptical about the validity =
of
> > keeping netdev registration before chip presence check, but I am not th=
e
> > maintainer, so I let Ajay and Kalle decide for this.
>=20
> I haven't checked the code but as a general comment I agree with Alexis,
> registering netdev before the hardware is ready sounds odd to me.

I agree, but it's orthogonal to what my patch does.

I did a quick scan and it looks like the cleanest thing to do would be
to change all the code below "Spi Internal Read/Write Function"  and
"Spi interfaces" to take a spi_device pointer instead of the wilc
pointer.  The probe code could then safely call these lower-level
functions without having to worry that they might inadvertently access
a part of the wilc structure that hasn't been initialized yet.

From the looks of it, that would probably also shorten the code, since
many calls to to_spi_device(wilc->dev) would go away.

However, it'd be a major rewrite of spi.c so it better had the buy in
of the maintainer(s).

  --david


