Return-Path: <linux-wireless+bounces-30183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00342CEA82E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 19:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80F86300BD87
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1C2F069D;
	Tue, 30 Dec 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NQZbzfZe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D921B9C1
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767121025; cv=none; b=ezUfdfEKnfxc33l93I35ndIorz8K+9UO3LCF7EX+xyOBJ9FzhmlrKrxBNygqknwYD2b50rnLz+mNPM+emjY84dYch+TjGQ+vUEjhOqZAWo8NuW64pBNsGHmpIDha8rU0jKp7Mv0JAwZBDjXi0fqrBrfHtokxDcc1XEHfEwuIjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767121025; c=relaxed/simple;
	bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPHs6nyiFuWjaDr7zfySOkPsPV+6nvfsogM+DbbxwxybcMc4yEhI4QX71bLsUaq01LSqSkhSYcA1zQKHvfONiibsyH9Jsia1GqBVGh8btNQxsmjVQdNnCZu2gHEvLWLZpQssFnN4hRtWwSfrJVrgwTvuI7czAx2xZvX/+3ByGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NQZbzfZe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so17045845a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767121021; x=1767725821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
        b=NQZbzfZezIMvS6dzvJ9kebdxzRmzP+R191jJjRdviyOOaH1d1izXFFEGCx+0GAQx++
         k4pR42T4teujTIuGU/Apag3VA047251H+AHgaberz2IvCdcGXd9A7X9TI0vEGdmFgJkp
         /LVSB6cr6zcgS9QEd09cF/X1erMEwBPJi32EvGx9Q6r6eITFruU4y/Ujv9nKC7kdo88B
         X4T3psYhuCftLepfZHN3fRKG/kEl55m9ATjyLSAvqlHipi7fe98z9b4vEjWYTQbTNVcR
         e4pMfdF+X3vBCdTQlehsxIcmuLxLUPRnGQiFZdSd/Or9SgYqIgcoeajU/OBtVu912DsF
         f7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767121021; x=1767725821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ4S3Ous4NBoV4+K7EyEggznX/9iE0fhnu2KNtimeZ0=;
        b=WHrIShtpq8rd7cc/BnBuHhmtlcznS5eetTxZk5puosnH9X84nTQAe2l+d7FM8XV4t/
         x193xIPEKzDeDrslaeXpxUbIe6f+ahGpAy+AEGyYSEpIC5OyD1ma9MRomqreebTFYxH1
         wpB9OB/ogF/M7RMnnH98EYTG2A16Ee+xOdD9HabU7Hy3V/aNofO/atMhge6ym+ZnXk+s
         peQQHzONDxLKEmrwiNJ4PaP1QyM/Cu9xHGTbOmkaUyLM4SnE0P+lCCJM4hSVt4l/PZTY
         UEIsG/zkiu6TxXZyarroohvrapBKan/4W/SwhG2JFlIxFkL58dSYQJ3vDRg2B3dWAVqk
         QITQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUKQQ7bvn7kU4tSM1mUqrBHS96nakE7Rkqm8UOOCa2nOXvN1Fjlr8E6945arD217wavi3Y1UK0EA+spvdmAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12PDWh9DIZx5FngqXY19hqAUddzErA60n2hwbDvYw0odGWBhB
	Yn4b5NFzgQqwgL2l6f0Jqk+jpvkL5zqGnSH+l2zmfN0NfguuTsGOYMDKb3EpH44GkPs=
X-Gm-Gg: AY/fxX4v1MKYRPdnAFmlcehbm68MaIi1KSM/enSlUkF2YEVmegyx9BwGSYHmTXlR6G5
	/yCnvSgEhJuzg8bp6qRMEbG8h8RCVYMAwSP3hsB2VRliX0AGeO2EVBMMLpL5986yS6o2f59HSI6
	ZBBBA9Flq4UtFpT1nISXXeaQq7JjUZoTzduAomc0Q8bugcrxzHbF2Fy7/cnsUEgHP4QI36SnHbo
	SDrUn8glykSv+HkCaoPt+6IMq+KPYqGp37SiMAsj+7WO4ZJ1c+E9Cl1hrVnYuVRM4KeYm/7/P1o
	yWsxUsPBjHOXAp8ofdZdgB8XIiUlK6wnJXzv/bGqQJQ05Wpx3a8PbAobfMt32zO2kfKMuJzmpVL
	FkzS1XInL9EAhgf8YaCu5Rk/tQ0ycc1wln4HLpVJRU27d/zJ5uDVnD7C4g4J2MnG8uXcjX7Hrwz
	Xdq5U4iplqiPbeCiUI
X-Google-Smtp-Source: AGHT+IHX59JbGHOKLai3o+izBsjfxrJQN6eH+wJdD9Jv4Vjwu2ACPDyrp7bHX1O9h4VNAtugM0iy+w==
X-Received: by 2002:a05:6402:2706:b0:64d:f39:3fdb with SMTP id 4fb4d7f45d1cf-64d0f3941a6mr28589514a12.13.1767121021539;
        Tue, 30 Dec 2025 10:57:01 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b910601c7sm35301468a12.14.2025.12.30.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:57:00 -0800 (PST)
Date: Tue, 30 Dec 2025 19:56:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
Message-ID: <7ngbudwaq4rdb6u4r3gn6ub7hqctq3qgienciuylgqsglougnk@ckdj3wrhzyqy>
References: <cover.1765968841.git.ukleinek@kernel.org>
 <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
 <21f1759416ae907b8504605cd8a814dc85a99a0c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enyljlgs5qxi4kp7"
Content-Disposition: inline
In-Reply-To: <21f1759416ae907b8504605cd8a814dc85a99a0c.camel@sipsolutions.net>


--enyljlgs5qxi4kp7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
MIME-Version: 1.0

On Mon, Dec 29, 2025 at 11:36:02AM +0100, Johannes Berg wrote:
> On Wed, 2025-12-17 at 12:09 +0100, Uwe Kleine-K=F6nig wrote:
> > This drops two #ifdefs (which is good because they are ugly) without
> > changing semantics. This also improves compile coverage because all the
> > code in the first #ifdef block is now compiled even for configurations
> > without CONFIG_PM (and then thrown away).
>=20
> This didn't build, and given that we never got 1/4 I'm going to assume
> it wasn't destined to the wireless tree.

Yes, this depends on patch #1, I expected the series to go in via
whatever tree sdio usually goes in and didn't notice that all users are
in the wireless subsystem.

The kernel robot also found an issue[1] that needs addressing (probably
by dropping patch #2 from the series). Will look into that next year.

Best regards
Uwe

[1] https://lore.kernel.org/all/202512210032.6Skz9prt-lkp@intel.com/

--enyljlgs5qxi4kp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlUIHcACgkQj4D7WH0S
/k7Yvwf/VqVh/xAAdXcu+Daixp3XFFt++ZZUJQnoHxOoVrw0Sn8emGqZ/RvEYROc
dYGec7UrjwBQE2UhIfWFthRv182lSY21ZVk2XHgndhgnZS/wqX19od032Mj47WoO
TlusjIApE1C+HUDxAVFbKlAI1lclkMT509B57gGI+OYC1I8pHPjEUumPCvpnz0uy
CwkQnH5KVqDls5cSG/4NXs4qFas0di/BezeCthbBVv3i3PovRt6m+/mQK0S23qZ9
AcMugtV+zX6S1QbaY7wuP04V0PtK+iuzmKWmYqEME+9KHnZKDtMVrEjOVR3jaTm+
Q/WNsLJrU1PD+g6qr49ztJHhINRV0Q==
=HqsC
-----END PGP SIGNATURE-----

--enyljlgs5qxi4kp7--

