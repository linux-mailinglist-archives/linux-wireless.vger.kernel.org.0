Return-Path: <linux-wireless+bounces-4871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896D87F355
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 23:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388271C2177F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A935B5AA;
	Mon, 18 Mar 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcfGwS+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442E5B1FD
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802129; cv=none; b=cTPXeYOv0PYKde8x/42qoiO7ngVBXrQeOaH5E/rXm6MokoCEu94N0fqcM76wNqiw5Hb5524zqSYF8/Rux1jbmOILN4x5sUZolvPbNRF6RTS9Tj8gLFxJZC49MwG9dk6qTYa7wHv38eIubsa56MFLVjenExkcjf1RSneU1GXdQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802129; c=relaxed/simple;
	bh=czOjETTCN6rAAgi+EwUrHhNOfxCw3aoNaA9Lc3LtDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnMJypkNAddl9S2S6e+Nk7k/PAiJNVh9wN4ugPEXgM+AdYakPNqg2TtXkdJ3JSvfVlMe6sUPRWqlWroNPzpMi9QRtuFQ0F2sQAz/FTTYXXBmzuyQy4QYY9NIlHX39mW24rUB0/dH2JrsEShvdD9cFW6yFpcRpIb1qdN2ksBYqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcfGwS+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FFC433F1;
	Mon, 18 Mar 2024 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802128;
	bh=czOjETTCN6rAAgi+EwUrHhNOfxCw3aoNaA9Lc3LtDO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcfGwS+mFOdStIqK0iXppLbHnM+igTZEnFp6TOFLX9ycwQoNmyZDPPhnxGJPYqJpW
	 DHS6NQGPLcKItM3UJpbe61Z2FVlQ/c2FGFt1iGfyJT8LqM40Q+uAdt8MeyE7agVJMu
	 bM9+5i1PIaoAp4hPhQu6EKpAPlQ/0LPUD5/MuOvW5NPY9mtVdf2GjQQJ7RBqMtRHD4
	 qnVmkJueTlZCiRPExKi1oxX0CPhYfEbc3qtnkjc20L11ErtZdVEoXI0Fb50OUqVU8D
	 UcLLpF8wW1XCZqWwYeJNuf4P3qm402Cn2uEv2hiLXskMgpjUB/v7xOMRkTYkoxJ0Rm
	 U2CccgIH1Z0Ew==
Date: Mon, 18 Mar 2024 23:48:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: greearb@candelatech.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211:  Improve bss-color configuration.
Message-ID: <ZfjEzYQbWDZeae8Z@lore-desk>
References: <20240307181039.3219840-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qcoec7Ums99D/eSa"
Content-Disposition: inline
In-Reply-To: <20240307181039.3219840-1-greearb@candelatech.com>


--Qcoec7Ums99D/eSa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> Always tell driver to apply bss color settings if beacon indicates
> the bss coloring has been set.
>=20
> And only enable bss coloring if beacon indicates bss color setting
> is valid and also enabled.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 327682995c92..aaa62c05428c 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1314,7 +1314,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, =
struct net_device *dev,
>  			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>  		changed |=3D BSS_CHANGED_HE_OBSS_PD;
> =20
> -		if (params->beacon.he_bss_color.enabled)
> +		if (params->beacon.he_bss_color_valid)
>  			changed |=3D BSS_CHANGED_HE_BSS_COLOR;

This change seems correct to me since he_bss_color_valid is set to true whe=
n userspace
(e.g. hostapd) provides the bss color info.

>  	}
> =20
> @@ -1494,6 +1494,7 @@ static int ieee80211_change_beacon(struct wiphy *wi=
phy, struct net_device *dev,
>  	int err;
>  	struct ieee80211_bss_conf *link_conf;
>  	u64 changed =3D 0;
> +	bool color_en;
> =20
>  	lockdep_assert_wiphy(wiphy);
> =20
> @@ -1530,9 +1531,9 @@ static int ieee80211_change_beacon(struct wiphy *wi=
phy, struct net_device *dev,
>  	if (err < 0)
>  		return err;
> =20
> -	if (beacon->he_bss_color_valid &&
> -	    beacon->he_bss_color.enabled !=3D link_conf->he_bss_color.enabled) {
> -		link_conf->he_bss_color.enabled =3D beacon->he_bss_color.enabled;
> +	color_en =3D beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
> +	if (color_en !=3D link_conf->he_bss_color.enabled) {
> +		link_conf->he_bss_color.enabled =3D color_en;
>  		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
>  	}

Here both approaches seem fine to me (but I do not have a strong opinion).
The one proposed by Ben disables by default bss coloring if color is not
valid.

Regards,
Lorenzo

> =20
> --=20
> 2.42.0
>=20
>=20

--Qcoec7Ums99D/eSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZfjEzQAKCRA6cBh0uS2t
rN9+AP9dJNW9bQ1LADzanMadesuDvJbUOJD6Fc7g5zY593YwkQEA5AaTmtTQN6y6
KPmHnP1Nj+7JcuEPKo19OVt6IBbV4gc=
=lW/f
-----END PGP SIGNATURE-----

--Qcoec7Ums99D/eSa--

