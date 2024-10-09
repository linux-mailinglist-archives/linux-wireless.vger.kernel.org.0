Return-Path: <linux-wireless+bounces-13739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B99995C53
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9871C22022
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51F6FB6;
	Wed,  9 Oct 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c8TnBXKt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09723C24;
	Wed,  9 Oct 2024 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434153; cv=none; b=e59TROi0KWb5oxon8+IjkFmYml8qknKiUN23V573AHTV9DStgxrTBSCi5RTfYLTB9M4wrmyTE6ZblcCk1OImlfX7TN51mCGjb+ZEbaH0shdvLw3PQmUlSUj4CmnxCiKr5wmMmG2BJMLmnuZcNZGGacW7xCiW1jvo3LFK79V8jBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434153; c=relaxed/simple;
	bh=rKQjvdbpyeunpt6XCbMmyGs87AfcrgaMMoUiyaGYC6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Klw1LnHrmi5E/hAmXXZb8YtdwnGmwC/jXkWbIEirEE6hrqVmkIr02Xn+bWms0yD4fIg1v2aJHymhlr9eRfm9DTXrtObb6IOkNXbQ3gPqslTczk8TT8npm513/V1KcTyaQt7IXzVy86RuJzJ8PnzTc+wWxRqvSSOiDknJNBVvMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=c8TnBXKt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728434140;
	bh=3nr0S2WZmd+H0ZX1iN4+J+Y17/he9bKRURG+4Pyq2KA=;
	h=Date:From:To:Cc:Subject:From;
	b=c8TnBXKtdZg/kBs0Mg6eta/Pie7JtcWLOfwutGu2A2HSaclwas3fk35EngFrxSmem
	 mAdYhgkI38BXWMsUsjLdtk/sRgCZ2VSc1eQdpue/MKpoxkjkAViCE/c5OhPRG1J0su
	 kE4sGPO/gFeP2nBpE1JObfFPQbBvtEjv7SMZDILWv0qPpoaVgealJZf1rIcFXpbmzm
	 RR5WH2YQVbTGVzatZLgzHqXrGmH1Wb9Zhyx2oTFgq9CgSWeUDHPMwS+JL4gZecWwnk
	 iipgVH9fNA1Zf1/1+VHFqbXx0VKdNQfOOulpe2qlwliHV7n+aKVGXvZ1x2R9+skMVl
	 Ixniu0ksGUaNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNYp32mLpz4wc1;
	Wed,  9 Oct 2024 11:35:38 +1100 (AEDT)
Date: Wed, 9 Oct 2024 11:35:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johannes Berg
 <johannes.berg@intel.com>, Wireless <linux-wireless@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the origin
 tree
Message-ID: <20241009113537.4676291f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bRwV=ZrCg/mL_1X=HbkeSyD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bRwV=ZrCg/mL_1X=HbkeSyD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c

between commit:

  1842442007cd ("wifi: lib80211: Constify struct lib80211_crypto_ops")

from the origin tree and commit:

  02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 into libip=
w")

from the wireless-next tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bRwV=ZrCg/mL_1X=HbkeSyD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcFz9kACgkQAVBC80lX
0GxlVwgAneo+fBuDm0gWv0takeoLYmJpex/Jvh4YrIunZ+R4ASum8v3qHGd0PMJh
+FlDXRWue5lKag7mabxrbGLktqVwghvcXv4xE56OLrzvuKgE/WoGJDXrK9gr1Z1x
Mzec34Bo+4oM6HbLYq+dAj4liBgWLLBrNgP8d3SAscwGD6NiC6xuSO0K7rxt5yJ1
sXq0V1gGfzOxsmffvnX4QpOvCRurH1kll3LWA17uJy+DB8ovEn/at61vLsXNjUdz
GEhhRjxQHY7MhTbmGM662BdGmMbXHpJRNPyX4As7i9plSGl+gOIaqVkf3YJMvMER
dsgGWd35hj9TmjCc/F4S0Vp4eqNZ6A==
=8N1t
-----END PGP SIGNATURE-----

--Sig_/bRwV=ZrCg/mL_1X=HbkeSyD--

