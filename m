Return-Path: <linux-wireless+bounces-28573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152BC350B7
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6199D46510E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF702D3A71;
	Wed,  5 Nov 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJxOynmb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82F2EA171
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337352; cv=none; b=UwhHhOkjngkNEyDCVcikz96lyvk03XxbV3I3U4w82HouzrPuJeiDZeDD4II9M8H5greV4niEOH2yGhG7xzLx20hgypGjRO/wSu1C0N0jHvXIs+lWH/IaZ7UMCuPVM1z2BHZQlgXTrANByB3wb2OT36ppvyFRGLJHiIujT1zo+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337352; c=relaxed/simple;
	bh=q9vl6CFKNRq+RTkadcNLgRaGu8yY+YtEFDn5kcjX11E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNgWLdeXWNhzhyDMAUuPHbc6VbQIEooiZlFS2sswL6RJGgfkD7Cj7Evk/hWxOq/IJCLbyqQOAHUvHMkbWrYdoZhKV5H9aZoEAx/++J5xUdZxFgAaiOtnCE73FJbgMsUG2nMwTpYFMQfmOxN/xgRsUEiocYsmHVPvJDpinEqMFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJxOynmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8470AC116D0;
	Wed,  5 Nov 2025 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337351;
	bh=q9vl6CFKNRq+RTkadcNLgRaGu8yY+YtEFDn5kcjX11E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJxOynmbksttRhm6CoepJhonLfasEBZlgUi0IWinsT9CBzcsr4YA/MV7crPa571Sg
	 ujhoUpJnX+jEdWUECpUzoiCI/VHzSbOV5X6Z8y3I621y3jM21yOqxSEaHuhuWplc7s
	 Nnxz9YbsYvOxoUBbHD4ZYX8ZAQ26wzXq1kd8pQaplIninofHhp8H0wp7U8wAmLWh9G
	 jwTmjbW698Zjc0mjiLYiAPmZOhK1Ih8O+mjlF91vjiEUAStEcHU84FYVAdBmnkdGeE
	 rOvMa5D0SPTb5r6iI0eDvQail5WDa0wBJwp9G56OpMHjpbSwQmlIfx9q1bDJqFTPGI
	 6zOe/eAOtFnsg==
Date: Wed, 5 Nov 2025 11:09:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 06/12] wifi: mt76: mt7996: fix teardown command for
 an MLD peer
Message-ID: <aQsiRRlc-d86tuHb@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-6-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gWOG1LyuzKOKSpQo"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-6-shayne.chen@mediatek.com>


--gWOG1LyuzKOKSpQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For an MLD peer, we only need to call the teardown command when removing
> the last link, and there's no need to call mt7996_mcu_add_sta() for the
> earlier links.
>=20
> Fixes: c1d6dd5d03eb ("wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta=
 rouine")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 5e0b57657e7e..685be98b9f27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -1206,13 +1206,13 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, stru=
ct ieee80211_vif *vif,
>  				mt7996_mac_twt_teardown_flow(dev, link,
>  							     msta_link, i);
> =20
> -			if (sta->mlo && links =3D=3D BIT(link_id)) /* last link */
> -				mt7996_mcu_teardown_mld_sta(dev, link,
> -							    msta_link);
> -			else
> +			if (!sta->mlo)
>  				mt7996_mcu_add_sta(dev, link_conf, link_sta,
>  						   link, msta_link,
>  						   CONN_STATE_DISCONNECT, false);
> +			else if (sta->mlo && links =3D=3D BIT(link_id)) /* last link */
> +				mt7996_mcu_teardown_mld_sta(dev, link,
> +							    msta_link);
>  			msta_link->wcid.sta_disabled =3D 1;
>  			msta_link->wcid.sta =3D 0;
>  			links =3D links & ~BIT(link_id);
> --=20
> 2.51.0
>=20

--gWOG1LyuzKOKSpQo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsiRQAKCRA6cBh0uS2t
rPYxAPwN6UABmG4cWh1w5AMD909RUy2CkfSxh1vzuY9uCDsErQEA+FEvZetibhlH
WOLWyymP5iNrpj0FC2ymsPEwhU8GTAE=
=Gd8Y
-----END PGP SIGNATURE-----

--gWOG1LyuzKOKSpQo--

