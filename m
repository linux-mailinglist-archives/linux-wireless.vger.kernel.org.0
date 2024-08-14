Return-Path: <linux-wireless+bounces-11387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2695114D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 03:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCE71F23B73
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE339457;
	Wed, 14 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P1aWuNG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069362FB6;
	Wed, 14 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597235; cv=none; b=K3bq8RVonj7OP6zkVz3QJMSx4gbj2DHFyM+MJA7XtOMlM/db0a0uPiJ6Y8OmmYi+SDCG1szFS68RIF4ga5BYKJ3bd5SgtNAiH6VU9k4TCin22bTdyASRpT9wQDOy8mZnCgDtMY6/mEXBUEnDoDvDeqHmhKbxGovFE1vlqQuKmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597235; c=relaxed/simple;
	bh=Q4313Nae4Lqc0GNiN7hBuMoANe/tm2lHVmYGLX7lV60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF1gskB7CScQ5oUORewCf030wWY3AUEeqg1W/lkT6JaiLG3xnVK5rY01tj6cTNl5P0bviNuq2N4VzXSvb2P0NfQ9WyKyMi/lb/iIV6M2LZd543rBA8ERSzuxyAPqW/ZYRnJL3NBrgNpafSWvBBefpZwggvy375M5M3EFJtOcTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P1aWuNG/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723597231;
	bh=hxBR2JKtbxevnnw9USR6AjGTYuarhQrbk0EjhnncH00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1aWuNG/WVcKA6KguPTWjJoM4DHtqO4fa9ZBUKUBhGGk9WbLnL3MIEAh2KFTtDGnS
	 a9yGCewD3nEqvZYHNh6PBvKuij6LTaRz8H1nbAnoaA1X9av0Pnayu3g7b8ej+m4Ehd
	 LxfRMmL9X8X/G3rOa10xIYhcabf06uPSpHRfyPCn2cHqCmwI32MmHZfNOMOhkxaV9p
	 zxDVRHw43FKe9p5dStvaFHWxGdDXWQADbr529hGP1YfPabK0FhMAoVowbYJmDZS6d+
	 la/I33a/W3AphcMe51DuLEFTcXdi3mm0MvKQuozWZFtTGVDORK0pdk5nDLuK1L2o8f
	 HeCeZbs9Ug4Ug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wk90N03WYz4x2J;
	Wed, 14 Aug 2024 11:00:19 +1000 (AEST)
Date: Wed, 14 Aug 2024 11:00:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Ath10k List <ath10k@lists.infradead.org>, Aditya Kumar Singh
 <quic_adisi@quicinc.com>, Baochen Qiang <quic_bqiang@quicinc.com>, Kalle
 Valo <quic_kvalo@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ath-next tree with the ath tree
Message-ID: <20240814110019.6be39d14@canb.auug.org.au>
In-Reply-To: <20240808104348.6846e064@canb.auug.org.au>
References: <20240808104348.6846e064@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c825WGxscMug2D7jB7kHQCF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/c825WGxscMug2D7jB7kHQCF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 8 Aug 2024 10:43:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the ath-next tree got a conflict in:
>=20
>   drivers/net/wireless/ath/ath12k/hw.c
>=20
> between commit:
>=20
>   38055789d151 ("wifi: ath12k: use 128 bytes aligned iova in transmit pat=
h for WCN7850")
>=20
> from the ath tree and commit:
>=20
>   8be12629b428 ("wifi: ath12k: restore ASPM for supported hardwares only")
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
> diff --cc drivers/net/wireless/ath/ath12k/hw.c
> index 7b0b6a7f4701,76c0e07a88de..000000000000
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@@ -925,7 -925,7 +925,9 @@@ static const struct ath12k_hw_params at
>   		.acpi_guid =3D NULL,
>   		.supports_dynamic_smps_6ghz =3D true,
>  =20
>  +		.iova_mask =3D 0,
> ++
> + 		.supports_aspm =3D false,
>   	},
>   	{
>   		.name =3D "wcn7850 hw2.0",
> @@@ -1003,7 -1003,7 +1005,9 @@@
>   		.acpi_guid =3D &wcn7850_uuid,
>   		.supports_dynamic_smps_6ghz =3D false,
>  =20
>  +		.iova_mask =3D ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
> ++
> + 		.supports_aspm =3D true,
>   	},
>   	{
>   		.name =3D "qcn9274 hw2.0",
> @@@ -1077,7 -1077,7 +1081,9 @@@
>   		.acpi_guid =3D NULL,
>   		.supports_dynamic_smps_6ghz =3D true,
>  =20
>  +		.iova_mask =3D 0,
> ++
> + 		.supports_aspm =3D false,
>   	},
>   };
>  =20

This is now a conflict between the wireless-next tree and the ath tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/c825WGxscMug2D7jB7kHQCF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAma8AaMACgkQAVBC80lX
0GzgsQf8CVhJeXJ3Fb5qihfwfTMiMiPTEAec9mao3QEzcMpSj2k4Cx80BPSR4xzc
9NffwOXVpbfK5lQOlKO5DAL4SHXwjLHJIX2gc4pOy0WmjAygFCY3fpC6i3ivCDv/
Joy5V1yPBEUXxNKJioQOpK4T1vJsTck7YaYGEdCCOxESEwDo15ebeQBm/155Te+p
c8llPlZhi9I03Vpc+jE8rpmJRpEzH+sIq4dOUNyhmUga0WV7B/p+CV5Yg+8liKB4
wRqepGWe2JEWx5SkJqESxGmbTyjdc0TwdTeddtXQcf50fyEV/ODNheI2mJmYQx3w
hQL2b4cEirIu8JR/TWC1aTVSes6NUA==
=VV+7
-----END PGP SIGNATURE-----

--Sig_/c825WGxscMug2D7jB7kHQCF--

