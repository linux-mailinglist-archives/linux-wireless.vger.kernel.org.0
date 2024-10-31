Return-Path: <linux-wireless+bounces-14761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038979B727A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD45281E4B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62384E11;
	Thu, 31 Oct 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c4ZVLWI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B03C463;
	Thu, 31 Oct 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341449; cv=none; b=k0WEY4OuQ+fbuS/iA8zWI4EiMLN1BQuIPupSngOFuhGUHW8AW/Cz7o55x5fZXSGR0Q1Wf66/R6StiMFFkQNY5QlDlK7OSmFAWMVZnR0I/DrOzIJvB27MtywpUlzjeAVHIHZ5lm8CpSm6krJK7jaSF8wk+VGDg2Hkjt29BbkrWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341449; c=relaxed/simple;
	bh=CpfpjeoHFq7UMSel8L39BpXOdU5xFOL1/GfnADwFstQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZHTcJtyxknBnFP3c+P2iOMjEu6iIIBRsqfnRuUodpzUna+V5YfJL4rC5T+ZfwQ+KwpTdNclo99DqddoQQ1CVbKPjNi7M9mEwPelxJU8ry4eupm0bm+n6e+ebv7jRcnK8pLP6MVx/Jfr2hzPAXZ8lkNxV3KPH2jgRNF+Fr4Qoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=c4ZVLWI9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1730341442;
	bh=/P2CzaVMCo0NXrWGQ9eXia4Ee/PM59wr7D5hNHndo0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4ZVLWI9hNTAHDI9jbEmkeirZQHQJzAhnoU5JsHOLOIeWjwuIToLh9V7RlZ3E5Emy
	 Y9MFb8E19ZsBhRM39rjiA7D3nnAuWo5gAUNkhmzpti8H88dCziryJUtA/4Ok5K/lKs
	 WjHLm80wrvu/6Bs5curLM11djyjZTo3S1sFn+5jwv+wM1s1xZMU6N2UY71Ff/aK5jm
	 faMIq/7AhZyWmZdDldP4LwarHU1Lw75oUTaGiJBUYmPMy/qv920AqwchAYnkEFZUAu
	 Ti1EY3fHARBZbmSpxFGhenI0OfTYh9nZpy8EbW8AW5gibIa+GXhdpem1IirONk5JY2
	 ReoF4r6ma13KQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xf78y4FKsz4xN2;
	Thu, 31 Oct 2024 13:24:02 +1100 (AEDT)
Date: Thu, 31 Oct 2024 13:24:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Ben Greear <greearb@candelatech.com>, Emmanuel
 Grumbach <emmanuel.grumbach@intel.com>, Johannes Berg
 <johannes.berg@intel.com>, Wireless <linux-wireless@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Networking <netdev@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20241031132403.7b5a0ca5@canb.auug.org.au>
In-Reply-To: <20241024115523.4cd35dde@canb.auug.org.au>
References: <20241024115523.4cd35dde@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CWEjHZMyWAED2ywnE75p_z=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CWEjHZMyWAED2ywnE75p_z=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 24 Oct 2024 11:55:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   net/mac80211/cfg.c
>=20
> between commit:
>=20
>   8dd0498983ee ("wifi: mac80211: Fix setting txpower with emulate_chanctx=
")
>=20
> from the wireless tree and commit:
>=20
>   c4382d5ca1af ("wifi: mac80211: update the right link for tx power")
>=20
> from the wireless-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc net/mac80211/cfg.c
> index 6dfc61a9acd4,6c0b228523cb..000000000000
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@@ -3046,7 -3070,7 +3070,8 @@@ static int ieee80211_set_tx_power(struc
>   	enum nl80211_tx_power_setting txp_type =3D type;
>   	bool update_txp_type =3D false;
>   	bool has_monitor =3D false;
>  +	int old_power =3D local->user_power_level;
> + 	int user_power_level;
>  =20
>   	lockdep_assert_wiphy(local->hw.wiphy);

This is now a conflict between the net and net-next trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/CWEjHZMyWAED2ywnE75p_z=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmci6kMACgkQAVBC80lX
0GyTsAf+PD2CF5n4o66iImXT68HZ9M5r/oFJa7DJvUBLuOH4IX0norUf3kqq63iP
IpGFhd1ZOOqIKpYldQ3Gqo0tmfXPQpHoGIR36udXFcdBaWgeU/y5hjObttpN+mRL
PHqLH2kNP7/FPFyZfGoZmZvsDSKa+aIXFUf9ha3/y+wmuXTaKhIHp+ejeS49DL0e
Aog5tIeoB6vEG+vmX2vfgdSCVtk3zC2stmMg2Z9S57y0mqnsvwVlFoGNDbl2bXqX
29X9p05vpMMrW0UivCuqXndcVPfdk3Xo32/u72U2/JZBGVC0gsjutlJI1BBZdGle
nC16b97kWxP3EU7QYwH5j4IFb8oopg==
=IDYd
-----END PGP SIGNATURE-----

--Sig_/CWEjHZMyWAED2ywnE75p_z=--

