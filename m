Return-Path: <linux-wireless+bounces-4959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF52880E60
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA17B1C20F9E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA839850;
	Wed, 20 Mar 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlPRWHWY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1538DE9
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926037; cv=none; b=hXpmvSzOUC/gyCcAfliDfOColB8aawTqHCKbe/pbdOQ8ig7ax5rRzPgyvFATAsY+peDduWicMGFunwqK6HMlpr67MOPEhv0eEwqfXNpAkhYPiX21nyjH0/ZEGSSS5ZE7nmfNcc+AE/ojNd56+itNPS4KuMNjC+Kzb2YerUReAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926037; c=relaxed/simple;
	bh=jZopQfLO3q4xn/Ns5qoV0P8uJO7asNlzM2FleoxZSh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSrDg0TkWX/2Wf3WlWImJXDbhrMHoql+TiTKoKVS+Sk1Ljh3UxXyPhs6ivxtC4z5I4x41bd6AS9TcG7Q8F6EQ8fHgIYbTlcK7x0RND1A/B6AdfO29C+5iz+iBqtrxYxXMEYl2MaL3wWYkb5hbl9Lvv+4l+rkzJlapQz7tbSN2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlPRWHWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F63DC43390;
	Wed, 20 Mar 2024 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710926036;
	bh=jZopQfLO3q4xn/Ns5qoV0P8uJO7asNlzM2FleoxZSh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlPRWHWYOLPOz9FMnM7L1XBbFQCr7FhicmfXnt76RURczem6VE79Wgv60/wjH3qzp
	 FnbBjhJRbMhe72HD73Mh9uwa5zX2Kx6euQ6fB8dDdP1Mn1QsU5wQw5BYgd9a8h2CDp
	 WvCFLgyEpCGIHI7ZojdVS2Z4VK1Q4emo44G9sm0XFvnq0jGeIS48zY/EYKwa6yOriC
	 b2dIfj08DKK/E/YzPhZCfR7zCEA6xzRrBCr93jJmcY1n07l3YDaD5hA6gAwzloRyV0
	 aZq77EuBkbpdDD7N8gTYFx46G6hiMxMeplTsgGygFXCVB87y6GSa0f1LnvncJWftx8
	 s+xM5L/H/OiYg==
Date: Wed, 20 Mar 2024 10:13:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: nbd@nbd.name, linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com, shayne.chen@mediatek.com,
	ryder.lee@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion sparse
 warnings
Message-ID: <Zfqo0I3CpWE6tHTh@lore-desk>
References: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
 <87h6h12rrg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KX85imdxv7uO/N0/"
Content-Disposition: inline
In-Reply-To: <87h6h12rrg.fsf@kernel.org>


--KX85imdxv7uO/N0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix the following sparse warnings:
> >
> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too=
 long token expansion
> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too=
 long token expansion
> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too=
 long token expansion
> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too=
 long token expansion
> >
> > No functional changes, compile tested only.
> >
> > Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power li=
mit support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Thanks Lorenzo! Could I take this directly to wireless-next? We are very
> close of being sparse clean in the wireless subsystem, there are just
> few warnings left ath drivers.

sure, I am fine with it.
@Felix?

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--KX85imdxv7uO/N0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZfqo0AAKCRA6cBh0uS2t
rHuYAQDUQzhdsa7iCgpSNcjtgR3Aa+kffgB2KRPjQWj4D1UJIgEAo0y34eLbn1Do
a9cDVOC6mA8dDMsUdS1BGJEks/YSmgA=
=DCY8
-----END PGP SIGNATURE-----

--KX85imdxv7uO/N0/--

