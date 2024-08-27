Return-Path: <linux-wireless+bounces-12066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B5960A34
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F85B233BA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B419FA7E;
	Tue, 27 Aug 2024 12:27:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDD19FA8A;
	Tue, 27 Aug 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761659; cv=none; b=Wj49M5+koEeBg4WGrT4VPdUhvREWii4q0wCMUMgYRYewDtpoT7V4vG9Sj/2scVd5zMf/2NPduvHyLtxqzKvJyqmaXivRKUvRDc0zI7DLszy1y1Z2kD4+A7KYXorBj/nycHLAP3SuPTZkzKTh3ve0Ihul3iF6RP78z9ocaQuus5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761659; c=relaxed/simple;
	bh=LeXt/vBqDdXsVT9es4rU6NCTbbEFAxFI3QplTGehT0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/t5VhnL4/Tzi2aEVYO1pTh9PfY0U1YemSxZUzFD5+nvANSYMmlX+4X8O3BPU9O6Fo36qs8KD+c5R+VyMneZUkakcPCsTuxtu7JY+mK33oK+cvMfWg+akvXDdB2qn5xELbie8i6u+oiyys5LpM2RmOEnQZcdSWVZ4caP0gLu5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 380821C009E; Tue, 27 Aug 2024 14:27:36 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:27:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>, kvalo@kernel.org,
	jjohnson@kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.1 21/61] wifi: ath11k: initialize 'ret' in
 ath11k_qmi_load_file_target_mem()
Message-ID: <Zs3GN2FH4uzzMEFY@duo.ucw.cz>
References: <20240801002803.3935985-1-sashal@kernel.org>
 <20240801002803.3935985-21-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HldkCQvBm5fG8i0J"
Content-Disposition: inline
In-Reply-To: <20240801002803.3935985-21-sashal@kernel.org>


--HldkCQvBm5fG8i0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 199f149e97dc7be80e5eed4b232529c1d1aa8055 ]
>=20
> smatch flagged the following issue:
>=20
> drivers/net/wireless/ath/ath11k/qmi.c:2401 ath11k_qmi_load_file_target_me=
m() error: uninitialized symbol 'ret'.
>=20
> The reality is that 'ret' is initialized in every path through
> ath11k_qmi_load_file_target_mem() except one, the case where the input
> 'len' is 0, and hence the "while (remaining)" loop is never entered.
> But to make sure this case is also handled, add an initializer to the
> declaration of 'ret'.
>=20
> No functional changes, compile tested only.

Just a cleanup. Does not match -stable rules.

Best regards,
							Pavel
						=09
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct a=
th11k_base *ab,
>  	struct qmi_txn txn;
>  	const u8 *temp =3D data;
>  	void __iomem *bdf_addr =3D NULL;
> -	int ret;
> +	int ret =3D 0;
>  	u32 remaining =3D len;
> =20
>  	req =3D kzalloc(sizeof(*req), GFP_KERNEL);

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HldkCQvBm5fG8i0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3GNwAKCRAw5/Bqldv6
8kiMAJ4gB7fc1FbbwRzBA4C9ElhfyH8CYwCeM0c4ux7PN2ixW6KMksB6oTRfXkw=
=T0fI
-----END PGP SIGNATURE-----

--HldkCQvBm5fG8i0J--

