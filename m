Return-Path: <linux-wireless+bounces-4590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85767878FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90604B210EF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3977653;
	Tue, 12 Mar 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="loRvjQAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18D76EEA;
	Tue, 12 Mar 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232987; cv=none; b=WXgoUcZxL9hdP6LV5tBUyQAxutE/fD+peYQgREQMw8PSAUZeQTIeAiCEWEAzIFKYjqHKmKJCwJE3KB7vzulGoGRLIbfdxgEyp+Nn5YkxfxHvI6V7Zf3zEardNsl14HZkSzlTitYTiwFzcAVXsCMs/zanXK2Na0uohzJ9KIxhKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232987; c=relaxed/simple;
	bh=8PTC3st//TZQtxJV2dNX9uPD5gJj55Zs3j0hF1eyaUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7hvP3s95CPX+zUiZtLkL2FeIJheLC+UVE/NbykN3N+a3WuFePjfK+w3hrinx9q6VGrPnfJvHU8XamsBk2e5Tlihhx5+TZZhTZW7C/ThmrcMqP4LlinLtOdmj1lfWT3M4C/j6l/2jSyAZ39MaWTotEskrLh4Oxq1Ab9947uByL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=loRvjQAW; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 890651C007F; Tue, 12 Mar 2024 09:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710232981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v91wZVSG1tHVmRuWN1qiVImveP0XzlTDO1nWD46gUJo=;
	b=loRvjQAWm3P3Jo8q7qb64psvBgHTz2l4iOi+wkuoMPvD5KHCVIvAYLTytKtc93Oflj04B6
	6GlIJztqjIjMFEQdY7u0TolPubSTIgPtYDWCgNgkuTowvNjqRLsxyYgAOiHBoUHG6/3aGJ
	JiJcjbHg2kqDYPQD4oPrVSR54LWq20o=
Date: Tue, 12 Mar 2024 09:43:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Message-ID: <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
 <e540243c657043f9a6d0a8d5314191d3@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJG9/PmtjpM3J0ZL"
Content-Disposition: inline
In-Reply-To: <e540243c657043f9a6d0a8d5314191d3@realtek.com>


--oJG9/PmtjpM3J0ZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > v4:
> >   * Move definition of GET_RX_DESC_BW from rtw8703b.c to rx.h (now in
> >     patch 3/9 "wifi: rtw88: Add definitions for 8703b chip")
>=20
> v4 looks good to me. Thanks for the great work!=20
>=20
> I also have run sparse/smatch with v4, no warning/error.

Does it mean you queued the patch, or is someone else expected to do
that?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oJG9/PmtjpM3J0ZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfAVlAAKCRAw5/Bqldv6
8spzAJwIiOlVNcksyRfJ9gr5uv+xyAzkZgCgj7iw0ScQtCNbuHqRwDrnwDyzo5E=
=Lmem
-----END PGP SIGNATURE-----

--oJG9/PmtjpM3J0ZL--

