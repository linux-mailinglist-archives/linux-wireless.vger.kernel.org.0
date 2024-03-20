Return-Path: <linux-wireless+bounces-5067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED29881A0C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 00:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5432B2111D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DB985C48;
	Wed, 20 Mar 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOpgzlzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5826BFDB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975799; cv=none; b=KuJKvKHShLzYRlEVFsgGLytqVY80TejbwLTSncX645KGCIAzhiBV00HnEXTc+OGgPY8w/qrwROCr4AfqUeCulfRJF/siVgD00jMojR3CEv/LExmIlcL490u6Hs19Jff5OAbD9258SK7xLqCRX1YgB7UCtYbjBqFq/OsQEDRdhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975799; c=relaxed/simple;
	bh=0Rf+Hh7SShCG8kBWJqP43ugRyZowgCj4JHqJAWKZjHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4NB+GzsZAiUPQDoHBjJssADQvkuzG6k67gbQTx15iv142ymlFLGM0IJdWZIu2Z7wHM/3LoHOKKST9iru9LFNC6xZDoQ0LK8RzaPnbJkeGJXmYNQQURTv9QbplEhvKQsPCPjOa2TbCtapS7JLjIfWshlqx1Uq+BvHr/Ib8BN1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOpgzlzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA2FC433C7;
	Wed, 20 Mar 2024 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710975798;
	bh=0Rf+Hh7SShCG8kBWJqP43ugRyZowgCj4JHqJAWKZjHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOpgzlzVCClQdsSO6EuFk47jWYU0MvwAzAvOtpkbeIEGw2VSxoT1AP0pvqtaHyK6E
	 9WtCF/LlfciV8PZKD48d8tdyjRqTjG7pDVHznBzasJGk9fQUYVhCI+UH+bpSlbcfFS
	 lS8ejBEUVOWCh0HpPkhwHyDuB2HvFsFHfLbVxvzs3jYGAu00uef7W4nNcvRWwI0ZyK
	 UbM+a40ZgvzMG2lcvpn4dCOVyaEPeIc8foD8vScm62owngcRCz6nRQxezpJxb1DGMs
	 VRpbvphI5A1WVEaZmq6cRkKT6+mA2TxHC2wvrYqIBrzxynraS6zurRK8bY0JuGlU3I
	 hu7wUttr1aFHQ==
Date: Thu, 21 Mar 2024 00:03:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: greearb@candelatech.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7925:  Fix invalid chandef access.
Message-ID: <ZftrMyXvN7JcWhHH@lore-desk>
References: <20240320192723.3440938-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mbHqCuuY8mc3q/sM"
Content-Disposition: inline
In-Reply-To: <20240320192723.3440938-1-greearb@candelatech.com>


--mbHqCuuY8mc3q/sM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> mt76.ctx can be null, and that causes chandef to be null.
> Use logic found in similar code paths to use chandef
> from the phy object in case ctx is NULL.
>=20
> With this, my system no longer crashes, but STA will still not
> associate.

Hi Ben,

can you please add 'Fixes' tag to help people backporting the fix?
I think it is:
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt=
7925 chips")

Regards,
Lorenzo

>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.c
> index bd37cb8d734b..feb818411a25 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -1502,7 +1502,8 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
>  		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
>  {
>  	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -	struct cfg80211_chan_def *chandef =3D &mvif->mt76.ctx->def;
> +	struct mt76_phy *mphy =3D mvif->phy->mt76;
> +	struct cfg80211_chan_def *chandef =3D mvif->mt76.ctx ? &mvif->mt76.ctx-=
>def : &mphy->chandef;
>  	struct sta_rec_phy *phy;
>  	struct tlv *tlv;
>  	u8 af =3D 0, mm =3D 0;
> @@ -1569,7 +1570,8 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
>  			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
>  {
>  	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -	struct cfg80211_chan_def *chandef =3D &mvif->mt76.ctx->def;
> +	struct mt76_phy *mphy =3D mvif->phy->mt76;
> +	struct cfg80211_chan_def *chandef =3D mvif->mt76.ctx ? &mvif->mt76.ctx-=
>def : &mphy->chandef;
>  	enum nl80211_band band =3D chandef->chan->band;
>  	struct sta_rec_ra_info *ra_info;
>  	struct tlv *tlv;
> --=20
> 2.42.0
>=20
>=20

--mbHqCuuY8mc3q/sM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZftrMgAKCRA6cBh0uS2t
rLiDAQDoZpbIV/FIHpGoUexm+PmkWYdLVchp3HVD0SqS1wa7XQEAl6ykqMhQLh5F
qsRKbGp02RozE05CV2pNK9iJ8O2x9w4=
=zzTF
-----END PGP SIGNATURE-----

--mbHqCuuY8mc3q/sM--

