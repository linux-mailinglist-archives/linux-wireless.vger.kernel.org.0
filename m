Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869D24046C4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhIIILa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 04:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhIIILa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 04:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13DB61167;
        Thu,  9 Sep 2021 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631175021;
        bh=X5pjz3HoJJpGJUfkusiSml7h57PTiGqR3UE1xQ7X6ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUtKT1LgPQoKPnSnAWdpu4sVDjhxpjCZO4NdJGSuH8PKLlSoO0r4PCxRAm2i3WlOQ
         xhl8skAS9mpgqx6oluMoKhaeUFo9yefP/qKaKCHH53CV+0yX2GUaOQ2jh31XNuJ4ds
         kTUcq3doT+x/nmq/CdXoVNoMYul//GxoO1z8KhLYzVGPXEOfZaIAjDnXrBXfjkeHaK
         7ykedJYZQFlPRnO5oSF6hRLE4Lsq2p9u5duENYOcaC0WPKkyF7mCFKUbuDA9B5F7m9
         jqLg68R6ezeUheRPw6WBaKz3zAcg+PUMbLE8aa9y3yxRraUhUbtDE5cmFoOMQ7RTKi
         P4Fp4VjvimeDQ==
Date:   Thu, 9 Sep 2021 10:10:16 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7915: fix WMM index on DBDC cards
Message-ID: <YTnBaNe0jA+rFUV+@lore-desk>
References: <20210908155841.72052-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvK8rWg3jjBJdNxY"
Content-Disposition: inline
In-Reply-To: <20210908155841.72052-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--fvK8rWg3jjBJdNxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> WMM index range needs to be split between both PHYs if a second PHY exist=
s.
> The condition for that was accidentally written as checking if the vif PHY
> is the secondary one

We need to add the following Fixes tag here:

Fixes: e57b7901469fc ("mt76: add mac80211 driver for MT7915 PCIe-based chip=
sets")

Regards,
Lorenzo

>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 748ea70ea12e..a19e68668c65 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -215,7 +215,7 @@ static int mt7915_add_interface(struct ieee80211_hw *=
hw,
>  	mvif->phy =3D phy;
>  	mvif->band_idx =3D ext_phy;
> =20
> -	if (ext_phy)
> +	if (dev->mt76.phy2)
>  		mvif->wmm_idx =3D ext_phy * (MT7915_MAX_WMM_SETS / 2) +
>  				mvif->idx % (MT7915_MAX_WMM_SETS / 2);
>  	else
> --=20
> 2.30.1
>=20

--fvK8rWg3jjBJdNxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYTnBZQAKCRA6cBh0uS2t
rIXtAQC9R+bE7bb8rxTT8GHQb9luGsyYm0fDvBsHqe/73+Y+mwEAvbDZZsUuou1c
E4rRIH5tw1M792VZCaHdQGxkYL7sygU=
=Vv4k
-----END PGP SIGNATURE-----

--fvK8rWg3jjBJdNxY--
