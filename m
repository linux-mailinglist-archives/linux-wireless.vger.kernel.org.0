Return-Path: <linux-wireless+bounces-37089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOCVJH8mGWq9rAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:39:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490605FD6A7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9352230C929C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193453A0E85;
	Fri, 29 May 2026 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGrftDdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B639F184
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033029; cv=none; b=BFTNm/3F9H+Y3ry36t3lFV8UEdbLXoytak9ClRPQ8axaTOPYRtInWaVH8vyymA1W4u0OBupJFZW3eSPpB3SHDY92ws1D91uC62T35GAJRitlL9OLKq24BYeWDdMMYf3f2f/1dwFN5/m4QZfV7F3uBs8LQYuaXajQiZhS6QVyOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033029; c=relaxed/simple;
	bh=U/u+I7Fjs+lyPrjV5mTGiCw54swil5vB5IqkaePU3UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKx9UuKwUgzNKwemiWbQpeC5SlgXz/WRIC1Qmv15cLjZmSTMmdB4sEorOFhLcPfH02EZKqx5Mctk3IZPLvlm3u/9u/xWcg4+zPis1NliHyk+slopXANDUe2dn7MPypTvmAeP4qhPhS6FM/YTl3uMHiXcKF1V0wNpCGZRO+DI9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGrftDdx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1363e78746eso9885032c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033026; x=1780637826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=gGrftDdxpBqeEcytuF5cMQivW8TLP4X3skIaFHpeJvM0bkgwWiUxNyfbJQ6N0n9Nnv
         23NhooJzbJjpL3HS//soTiF2H1Jz1hokAV61p6wLnyy7muOB5dVjifRy6Q/vJhGGRQsP
         9od7sc2lJz1LE7pvzI4Cv5Ymik3J5VXURow1bXTxx1meU8D/tMLumKW2voUjQIc58P6B
         xcn00iQe+BNYjmW7eNBTCIqwcBptl1MSod/KdGsU92p1KzWHrmEy/1se9JrHn9cO7F+O
         XVzU0QckkcIitEwwHaQdY1TIGeeEBHjW80XpoGehapMt7ZYnXgQACsnmFxuYbTievMKK
         tNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033026; x=1780637826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=jE4+EYJt1iofl0c4Lbc+fC0NpdO6x1rJGjFWz0aygG/PXpvRXTU2cjuVR5Whyj5wAI
         Kkb10dfmVotEWvWUpQmdvApYiWviI916K6Qz2RE3QeNtSVJA6wLE+txNBWd4eOhGghwk
         jZ0ziUZZ4DbL2WDcLAC3nhq/haqiiI11A4i7u9MCgDWc6gAoZqPqbK3tvC5GHgo+bS27
         tSew/GTSDOC1+9YamXcKlPlCllaLR38+2wm4gLGa1zix+z+ZfBTSJ9MiLX+rLSWH2bBL
         j8Vs2wXGmcvKu5GU8VAFIVhoJDMwy72iJt7LDZwoyVwqGqWPMaVQgbHxwv3uQw3glfKV
         xKuA==
X-Forwarded-Encrypted: i=1; AFNElJ/a1hgXFp2Jl7k986s0V0w+QoKejKb7qLudgh13TBo1ldPsoxxjj3i52XUT7g5fmD13tkiLXDzS/Kawx17GLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMetm8VpulxLhg2Iwpm/qcqYcy5S+3O3sVhD30PPUfNRIFgBr
	6yOR/rniuRfzlXF0irk2iO5nWjTclINX7sptsca7Sbk1lGa4SFF1nfCE
X-Gm-Gg: Acq92OGhgnNvfz56B0GgmZIehDsjXVmuiKm0qDxXzuXpoirrTMJ4kfMwEYoO0+LBocq
	9kYHMgsRRSLEwudphYgaD8qVcAuhdLXiOAt3tM7dae2LdWKMbLs1uFx9BwvR719Ta9phtfm21v9
	2RvKXhodtIjoVgjMO3c6wYuMvkCYTKrxsiJW6jUlkitJMDNZMHHFaX/1f5oecEn3zKgBkL2BacV
	8qHJoXYDG53oR7xrA00i5Bgg1vDmuAgHZ7JkyQFhGMaAWC8y0HDVt5reIanK79EgUqctEjxPJKL
	jlult683UsixXKIeiLEoS1gQaF+5zoYPyRiqIX//vfQ/JuV+mhywIempjJMsT+N5VTNLJCb6fVZ
	fXmeGyjeQkcwqh5gnzIegShIAMksCidebKJxkYm/tf/6h8REnklmSdj5m1CQQUIm4EL7xJExkkJ
	u5qR2VfjPoyyI4QW7SlJMkzzSKTllL694miamwDhZaHiMpMCsS1totg67t4TqbF3c4CVHveU/cf
	A0=
X-Received: by 2002:a05:7022:2223:b0:135:d76a:aedc with SMTP id a92af1059eb24-137aeee5faemr536827c88.33.1780033026219;
        Thu, 28 May 2026 22:37:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e169:a62b:d3ca:e8c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm832719c88.0.2026.05.28.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:37:05 -0700 (PDT)
Date: Thu, 28 May 2026 22:37:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Lamparter <chunkeey@googlemail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <ahklyAUMaOxy3Z9X@google.com>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37089-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 490605FD6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:57:44AM +0200, Linus Walleij wrote:
> On Wed, May 20, 2026 at 8:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> > interfaces, but there are still number of ancient sh, arm32 and x86
> > machines that have never been converted.
> >
> > Add an #ifdef block for the parts of the driver that are only used on
> > those legacy machines.
> >
> > The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> > passing an IRQ number instead. In order to keep this working both with
> > and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> > the gpio number if an IRQ is passed.
> >
> > Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> > Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>

OK, if Lee Acks MFD changes I can pick this up.

Thanks.

-- 
Dmitry

