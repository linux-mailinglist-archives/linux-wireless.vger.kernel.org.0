Return-Path: <linux-wireless+bounces-35099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBcxGymN5mmryAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 22:31:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12F433BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F463300A610
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3C38229E;
	Mon, 20 Apr 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jnamGJXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F373275B1A
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717094; cv=none; b=MyR9DYQBcbcBlAEKVVvUVAwCJ+tkBT7bT7tJLzJ0CpfrEK4ShNiKHpnB5Gx9fqbjL6SguvcNhWwJ0TyQKHlRM8wm+m+FKsUhsFz9YokgdLgmqZV8z6WyEpFg+bFm2+FitFV4By0PECXFWxH4wfRuDB+kEiUzVYlKu4+oKBwZBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717094; c=relaxed/simple;
	bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx10JAJKcJ1abcFAcS1ImOn6tIXw6+8i4lRMBjw2/Ah6/J0BFdvtFL7JEGOfJYOUdBKDHhJ9P0ZhE46MJ5G8n6m5TJITWarJUuMV0UmC3qTxInQ2YpHC+1Lf9uTe4IXsesnuEDm5LpqRn5TPyaQABadV6e9v5Xr+OIc6dc4DXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=jnamGJXH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso39727725e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776717091; x=1777321891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
        b=jnamGJXHPA0SAWEBfg0siKGV5Ng7WOhyw+r3fxwxIz1Ikg2PiDiUTgFzBdoq/5zDUx
         6nA5EGH/ueeznt9Z4IkFNKaFunFr3zFV4bYQJN15yLHVI8OU8M/T3a8GOtmroPku0GSl
         cRW2SyDFbDwMc7zwPytjL04UwJohpXLzNrAf/XlIoJBwsIsObw1WdWR0dHle0e4txf+n
         xUb06a3vxXiJBsZC6U2nY5fYe+gmsOGfFk3bbHNIrbiQty6BbwLT6hVhA7NagAl7PO2+
         UZd/vVG8B3Xp4v3TtAuEVKJ3/fvn3nX26OUVyXzFyyDpalofacSPz0OPByfXXzYAPy7Y
         tgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717091; x=1777321891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fmttW43m02UXdVQMFbm1+Fjb9kM23jey1UIcB3meSs=;
        b=qRTy4uByxgEzlWsDxymxf7x7yK32KZvfDguHBZE2d7zb/gEfMJAvV/UZoenIrgmt/W
         2mnuzOza5uF3rJWhDww696MVNZya8YfvuhIqymSyc5D0vcyJkLb7hn+iMuWrdhObis9J
         ihAtyhAiYMI0k3KybMgwk2LBsxg/uTrPigeR+kCTGdBA1HDE6V56Zv8cL6Scd0+jzdA/
         c6gkNGqemOl5tRQLmrXctOn9trSf9JCnRtCgr81ZYENfRgAnd+c/9EOyRElq7DUormRb
         tgdYpVylxmhqNhd7w6EePh5XjLszq7/9Tor1EvZXWZ8ELKcTNY2K70Rm1ZpqAwrfOWV3
         D0Ug==
X-Forwarded-Encrypted: i=1; AFNElJ+4qIDed5slfp275woy3xqmy/AMtpY2qo04sjYMm1QMD/EYMkyYYObf+JClw3DqkY2ea/J2XS1y+5/ArpAn9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfjn1gk4bzydKPmj/KPKGZPzL7bYt+liLpSQ7lGKmmSd+9Qc1
	a4Hy73hoP+MiNwibL5s3T1f2Xg4yyZUw/HNJ7Ek3vY688pfAE2vjJDzrWhAAC8H0qBs=
X-Gm-Gg: AeBDieuaV6cxamvHR0iK/j31zyHwUNTXBiNHWPmVNJVjCPVcWkqQ05GSoLAiMiWRFP+
	Cg2OMuZI+KLTUDcD88oTBMthUsP9SG2z77CChgXbV+UNFL4Y4GRk+TtrEmhpbOkaa/50/ym2x2I
	WZlmYiw35Vw6f1WTDbv9n8WlIbClOqju+d6MUmMRNw9kuDjfDMrUjBRbGJMLuu8ExuATb1XPSLs
	hN3zVf8pY4oTN05UNwbDzfVgKfoSX9m5cYjuz+1BSvJ9mC8rUIoutkJJWcHkdJG0DyxkR0DBHDv
	8/pEZdzCrlRtLrYxcuBBMQ4F689/vQULXtOjw2GH8r0wUVnPOd5dFDo4DWfc0pkJqjQBEew/7bX
	WBkwua5tY57iGU02rAuNsWKCVnQksaZBlFAaVs9HUp56gd28X7ypfAp5jL6ifcH+tInuvVvxm2A
	p7g9m2dA4TaITqVfZlAJd7k8f4TO8xrQZvkVMEV2Q=
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-4891ff176bamr64290705e9.1.1776717090675;
        Mon, 20 Apr 2026 13:31:30 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0745sm126204805e9.9.2026.04.20.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:31:29 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:31:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aeaMkfk_1t98e7SU@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u46iqxpjoedhizpi"
Content-Disposition: inline
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35099-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,kernel.org,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB12F433BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--u46iqxpjoedhizpi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

Hello,

On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) and
> this is used a lot through the kernel. For example it enables the usual
> practice to store pointers in sdio_driver_id's .driver_data member.
>=20
> This works fine, but involves casting and thus isn't type-safe.
> Additionally with the CHERI architecture extension there are machines
> with sizeof(void *) > sizeof(long) for with the traditional approach of
> storing a pointer in .driver_data doesn't work.
>=20
> By replacing the plain unsigned long .driver_data by an anonymous union,
> most of the casting can be dropped and it yields a working solution for
> CHERI.
>=20
> All users of struct sdio_driver_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.

sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
log and once in the short log. If you consider applying this patch
please adapt the commit message accordingly.

Many thanks to those who created sashiko.dev!

Best regards
Uwe

--u46iqxpjoedhizpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnmjQwACgkQj4D7WH0S
/k7lawf+IBy1b5wfuwWZiVYsobJ5/VQtS1uab/j//LDVdxK0lHUoqurrxgHf8aFa
2/h7V1KF+nbxyYPjLmWI8a37uIwuSKZ5vijoBeDnFRFwWdEokon2xNz+IK0hTkf4
Ill7bkiF7fk+epa8am5nZ9gUbmy1nlQbFZHlXizQA4YeFOlLyfOdPTsXw8p/P7Tq
RIGbTgcE13Qkiokn+iCwGUzLfb1sjBm+Nx3M/g1/C2r4tw+M1ypwCAizKjjvFyTz
8a7d4lCX5G140aKhxhTCdN3nE5iwtvZ4w9BT2RXRY03pv4w0FW5Xyc/PqymZ2Kp/
qcp9T3xPsnUPVlIgTg1SnhlhnrS5Qg==
=RSgT
-----END PGP SIGNATURE-----

--u46iqxpjoedhizpi--

