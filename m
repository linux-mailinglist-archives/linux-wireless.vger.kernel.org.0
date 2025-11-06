Return-Path: <linux-wireless+bounces-28643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84219C38A22
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 02:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C36D3BAC44
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EC233D85;
	Thu,  6 Nov 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SYeTmXSO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E9217F2E;
	Thu,  6 Nov 2025 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390603; cv=none; b=HGuITjYNTaVwb5warMJjpNKB+7yBDdffWzqpZovj1VX4hJIMgci5bUgA1bubVpqIX4DTWvqds8aeZvLJiixSe+nAQNInVHHJbxOh83xNk+Grs6NfcLFveYgUg5DCw3FH+c8Odxn6eJe35upHvBOzk5oiBkdj3iIi65LlKllurQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390603; c=relaxed/simple;
	bh=VTdaiQ10La+yHV2hAr6XnpnjrSzQmsBxUAirtnL2j0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmFs08FX2Tp5bPlaOcglOUR6cHzBTrMdnjPZXxFPyR7VymWA+xJ3fWuxKl7qsjTgSm+dmD7CQ1rD9Yog7kNAOgX9PQs2yPwPaRXi+MySZbGSzGdjCtmvWtJjGCdsD2NnAHywNpofOBBw9RO3abmEQhF9HbTV++FbICUFEMvpDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SYeTmXSO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762390597;
	bh=Vmvg9PQucrM9XxyCcYL1ru8Zcq3bHljcwVp773OjC68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SYeTmXSO4Jihd8mmRX6XpxoQiMhI+p60/y9ve/mTwdmT6Au/J/3v/bqr46TPio/FZ
	 WUYXmPGM27qcGMHdLMGHnVOzLp4VdQQwcEcOtXmF6LO7/ebkPxc56tVpAn1juy2rbD
	 bPnroJbfyDppcVAvqyqikjFUmlcZWY9PDA6R+XUbth/iL57jdZpmCMMbeoOnIYtuBF
	 A5oIDS39GDRzxeIIU1caOg25n8BQkei3+cYGIJYUf8lXOX9AxdLv6WKhzA+XdLoI0E
	 eDTRbUEAii78SNY1X1yyJdRv+efofmgs6TMCKsOaXj12yvOtPh19O+1NEiVZ/J9oHG
	 ckwYRpe25ZluQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d23fr4Y9zz4w9q;
	Thu, 06 Nov 2025 11:56:36 +1100 (AEDT)
Date: Thu, 6 Nov 2025 11:56:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ath10k List <ath10k@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Maharaja Kennadyrajan
 <maharaja.kennadyrajan@oss.qualcomm.com>, Miaoqing Pan
 <miaoqing.pan@oss.qualcomm.com>, Wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ath-next tree with the ath tree
Message-ID: <20251106115636.7ab861b3@canb.auug.org.au>
In-Reply-To: <20251030113037.1932c6d2@canb.auug.org.au>
References: <20251030113037.1932c6d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2l67aILM2GZVGRsolWjDVnl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2l67aILM2GZVGRsolWjDVnl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 Oct 2025 11:30:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the ath-next tree got a conflict in:
>=20
>   drivers/net/wireless/ath/ath12k/mac.c
>=20
> between commit:
>=20
>   9222582ec524 ("Revert "wifi: ath12k: Fix missing station power save con=
figuration"")
>=20
> from the ath tree and commit:
>=20
>   6917e268c433 ("wifi: ath12k: Defer vdev bring-up until CSA finalize to =
avoid stale beacon")
>=20
> from the ath-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/net/wireless/ath/ath12k/mac.c
> index db351c922018,e79d457e3c03..000000000000
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@@ -4209,7 -4286,7 +4267,8 @@@ static void ath12k_mac_bss_info_changed
>   {
>   	struct ath12k_vif *ahvif =3D arvif->ahvif;
>   	struct ieee80211_vif *vif =3D ath12k_ahvif_to_vif(ahvif);
>  +	struct ieee80211_vif_cfg *vif_cfg =3D &vif->cfg;
> + 	struct ath12k_link_vif *tx_arvif;
>   	struct cfg80211_chan_def def;
>   	u32 param_id, param_value;
>   	enum nl80211_band band;

This is now a conflict between the wireless-next tree and the wireless
tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2l67aILM2GZVGRsolWjDVnl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkL8kQACgkQAVBC80lX
0GyvVQf+NOSIdJpJoqqqMOPrC3ImZTPukpFKJir+EkjlJ03KVa5kXIFB3E+05KI+
vr9VI65YX+MVbxmnAjDljyiEp1RY02rn2DOJCOOR4bp4ImP0nent3QbazODcguea
/EKTLPqMh2NX4fjwcptG2Xyf7iga8Or1WnJWHSDoCWWqlyo4YLNTpQm/OaM35Evg
eJ2vCXWkP+1QaLa8O7w7ogGQ6O9bizTYXN7CSHwl3IBK1Tn6XcM/T7Iftlz0oiZ9
Taj82PcPsUNbDjp58ZX9SL7WPNjvaxeE7aWOS4TisVhh3vwrkVEx2TW+DJrrnEdL
gEDzD9FN4FJAEm7kd/HEYK/dPPQCOg==
=d+pj
-----END PGP SIGNATURE-----

--Sig_/2l67aILM2GZVGRsolWjDVnl--

