Return-Path: <linux-wireless+bounces-14759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECB9B7272
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA93E286650
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF305A79B;
	Thu, 31 Oct 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nfc2Q/E0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF445026;
	Thu, 31 Oct 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341230; cv=none; b=f9yTm6n+U003NOJkMFlYpFITvGwkclODKQuyU//yodKmoIlR9P3v3wB38ULvfPX8eMaTwgfUhVPhU+yNvGS1Hb2bHMeggnOpQaYGu76Ap4bmw060TIc4AHZK7b1fR/OLkQ74/IqVargl6bRvwsapiYt+/fsJhgvOvVdtxkfwBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341230; c=relaxed/simple;
	bh=drU3KW7IEWpok2cJ6SbKWoKUJDEAts5QmVDexHgPN7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkP5WxYzszpwoO8TOcP4k8BdynRG31BJSMCtn0CtgIUQ4MxiesuygrLoRkmSPNLtIbPoqjxEhnzUoF9D0fstKBvIDZLA7oSMBKE/OeZ5ZkW21kqgqIfl6q7upHF2xh5sIdSyu5d+51ijfP5EaYbFN3FVTsl0nm1uzoomCclIKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nfc2Q/E0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1730341222;
	bh=xqQt8+HgzhSe91OSWjrnVK5r+keJ18ApvAwnw2ZwvF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfc2Q/E0GC5j/opUbRiHRLrThE3HEGjNimf56MjinQUgzobOwED6Q9HwHx86pNH/w
	 zK2+3eo5l0NY1/ve0/ZBL20JD0ggi2Bd5UFN474+iXTbIl24ysml7Q+6hCYNXqRpCb
	 DI5q4fuNkSi0nMfxYm+4iqmLO6O7sZjyFYT9Dshec1K14E7Mv3NxyKX8c89MVp9vsX
	 gKktFje9JchEFCGtv1hruSUeTNY7XRRyz+WzN9PQITxGJwtIfSbgbGDPwOvML2HYYW
	 G5mKT4BtlDAQw/pjbSgEKTpRStsMY9W8I7oGHwQtSnZUG8pfjO5TEYBSvr4wCbDmEY
	 h6DO7zyL6Dqmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xf74j2jjmz4xPF;
	Thu, 31 Oct 2024 13:20:21 +1100 (AEDT)
Date: Thu, 31 Oct 2024 13:20:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Wireless <linux-wireless@vger.kernel.org>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>, Johannes Berg
 <johannes.berg@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Networking <netdev@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20241031132021.6c7eedb2@canb.auug.org.au>
In-Reply-To: <20241028123621.7bbb131b@canb.auug.org.au>
References: <20241028123621.7bbb131b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tnRE6..8MI65nh6OXU0jFZM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tnRE6..8MI65nh6OXU0jFZM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 28 Oct 2024 12:36:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>=20
> between commit:
>=20
>   cbe84e9ad5e2 ("wifi: iwlwifi: mvm: really send iwl_txpower_constraints_=
cmd")
>=20
> from the wireless tree and commit:
>=20
>   188a1bf89432 ("wifi: mac80211: re-order assigning channel in activate l=
inks")
>=20
> from the wireless-next tree.
>=20
> I fixed it up (the latter removed some code that the former moved some
> other cde around - so I effectively just used the latter) and can carry
> the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between the net tree and the net-next tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/tnRE6..8MI65nh6OXU0jFZM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmci6WUACgkQAVBC80lX
0GxPxQf9FqLkRiEWj82juUiZPr9wMOiyF4uQDIPt0jxdY0Ipv33sN98/byCOjcLs
U4tUVDB8ok7Wd6WAsoS9okoLovZCv8xYvMFk6ngV3iWmrR4y5clA1B2Stp7DKCtH
1wOJPy+IGleTTdc8+BMDAZ/T9iXjEhkDdKkQH0qSKAc7vsYJB/WgplzC/T4kyMK5
/44spSzjoDZG0t7Myvg1EU4S/KFPeo+CmkbzB8c7EK/YwMzXlTBUNLqb0wvN4HJg
GJdtQxWy/dvjxXzzygeTPBaLjjmplLXQFHHFeOqdI7wz68CJ50mOtVfxi+aJ815H
EmaBK70IitkmNeO4SSNPQHL3TNSauA==
=trsc
-----END PGP SIGNATURE-----

--Sig_/tnRE6..8MI65nh6OXU0jFZM--

