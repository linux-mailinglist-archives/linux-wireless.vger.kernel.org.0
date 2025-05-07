Return-Path: <linux-wireless+bounces-22722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E508AAED26
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8FF3BBFB7
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB428EA73;
	Wed,  7 May 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="McEtf+uZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34121ABA3;
	Wed,  7 May 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650285; cv=none; b=Ng2Ci6/IzhPZOAvT3Mhg2Tf0QTrCyZVAF3pagKBUwGw3dxrnqqC7UnzgNQz8F3Nzryw6TobInY5YA3ydgdtrCtu4nDknMBBgrLSGS7y0DjH/PGPkS/WOwB3zbK1NxAhCXjmCXzLXpjUyCfzumSIixbqDgjt+vh3stfA+CKwLUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650285; c=relaxed/simple;
	bh=kVJrkFZYQas0eLQHfTZn3wdb01QVFn0reQ6ulBTJfO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5f0I1Oyh558ef+X6xVnUvlE6m2hY7NsEwDKFVzmg3+vbBOx+3x8qsBspLYXqnjmlbEaHX/dABFfpxT2o8lp7rdaiRHI2Fd/1Hx/7sEU4Ob2BrKIp7fAMWZ09PlZVAvd4dsI6fIgi7L7OuSSw6joAEPGLIz7CiSpNmt/IykJcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=McEtf+uZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1746650274;
	bh=kP6YhJ15/QlR6Pf0BUZzy69D9wTWXLuw6WqK6Uhy47I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=McEtf+uZBpHF9h2q9yxB9ttser81zJlIAMB/bbmxz9GSB5h5CYoXaRBnLgK6VXsdb
	 OWHkTJpEG8aoOjReXfXS9VSHd3n30t5I1G7CEQGYEbmA0xerZ6tMfckGWQMFrFScYI
	 /mIvy+mTElKFAzHC2Pwv1t1fMZ70+9fyuOMcpVwcVfsVyhxWFL2SI0h2NoOoKe9rIC
	 i2zN1+PzpiAzvlXeUtlOw+m1fZVOUxxyEQGO7aFV++qFVS1UDakhwdBegN580d9SWc
	 j18Ail8a+sr2mI464sIQEvcGHKnXbVFoiBvq5E1VYbsAXNu2BLqLI6o8D/VxyytphG
	 44iDDVUjUU4UQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Zt6XL1B0nz4xQN;
	Thu,  8 May 2025 06:37:54 +1000 (AEST)
Date: Thu, 8 May 2025 06:37:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Wireless
  <linux-wireless@vger.kernel.org>, linux-next@vger.kernel.org
Subject: Re: Introducing iwlwifi-next Tree
Message-ID: <20250508063752.1055c06f@canb.auug.org.au>
In-Reply-To: <1e1912191137ce827484a4f1b25d6c9a261df68c.camel@sipsolutions.net>
References: <MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
	<2d3c5c2946e4356ba99edb4cca4fa205149c0356.camel@sipsolutions.net>
	<20250501084545.2c9de121@canb.auug.org.au>
	<1e1912191137ce827484a4f1b25d6c9a261df68c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yfl.F3xQrbqOfGtDXy/C_nw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yfl.F3xQrbqOfGtDXy/C_nw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Mon, 05 May 2025 09:56:47 +0200 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> > Added from today.  Currently only you, Johannes, are listed as a
> > contact for these trees - if you want more added, please let me know. =
=20
>=20
> Thanks. Please list Miri (in the CC list) as well, since she's going to
> be maintaining the tree, at least most of the time.

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/yfl.F3xQrbqOfGtDXy/C_nw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgbxKAACgkQAVBC80lX
0Gwjawf8CsmQOyftwn3hqmlKZ8PHwZtlPiBAvW7R2qGHdUIQRwZjumfNEtzZY0W4
pF1I0r/YqDz7UceNbolnRPn3pt/n4+WNra9cRNSMBDoOGt+mslru5+QjklmLFf53
+REqBc4pgMzzg4Iavub+tvGt3dUx810fKUY+VFD/Mmm8d4aGfiq3+z6xOvsX2eJr
DZftfcZIWZBsmRKRXK2oX3XMHRBqKALlzOYxs0ExZOv6Y6jBqhCleqr2Kx9tvwzl
w/hFKetmHm3fg2gEfgZpGzdx+3G3Q2KCHF2F0foq/cA71U7nMnuHKPOC8DTuxBO/
6yt+X5ydeKlXvPHl7AD13btpTQmolw==
=PKff
-----END PGP SIGNATURE-----

--Sig_/yfl.F3xQrbqOfGtDXy/C_nw--

