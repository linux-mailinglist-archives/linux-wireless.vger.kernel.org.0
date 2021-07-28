Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081B73D88E7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhG1HfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 03:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233216AbhG1HfU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 03:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61FCF60F91;
        Wed, 28 Jul 2021 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627457719;
        bh=G0rWKfDaNY22lUY/PXw1Ue16UDla1YpF0to/w+YJYmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2X0/92gKczgOgV7pr5CmsjZMi1pWRCH+2iEAXHzB5YcT/OxKjWy8EgiDdyhVpXcQ
         jYCa2fBHumQM0TdDUWtF7VO07J9QfBT7jZWKO1S2sBC8F5hnlHcQxaZdV1QmroSj0c
         wrDFpAOtbrZLtOVi3Yw+sxYvc8bacaEVFvOfbJivpkjjQTJewgaTgF+wWDhNiUhOkx
         WMHbflBIV+x5jGazWuFktjoTmvHq5jGMikf2lPNaMnrULd5hdI+rJOyhTb1TLQBG9y
         zYgnnFnY8kuHcyHStsnS2yGhlCdUjvC8YEYntQ6FDIBsLSoyhTWH7S6L1rW+IoNv5e
         VRwSojRIAne1w==
Date:   Wed, 28 Jul 2021 09:35:15 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: connac: add support maximum regulatory Tx power
Message-ID: <YQEIs876ksTVjIl0@lore-desk>
References: <1627426757-14811-1-git-send-email-sean.wang@mediatek.com>
 <1627426757-14811-2-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HD5cfJbB7Qv0wneP"
Content-Disposition: inline
In-Reply-To: <1627426757-14811-2-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--HD5cfJbB7Qv0wneP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: YN Chen <YN.Chen@mediatek.com>
>=20
> Consider .max_reg_power in struct ieee80211_channel to limit the
> maximum power the wireless device allowed to transmit on the
> corresponding channel according to the regulatory domain.
>=20
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 43 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index d71393b1c5e6..84f42ce12626 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1773,6 +1773,43 @@ static s8 mt76_connac_get_sar_power(struct mt76_ph=
y *phy,
>  	return target_power;
>  }
> =20
> +static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
> +				   struct ieee80211_channel *chan,
> +				   s8 target_power)
> +{
> +	struct mt76_dev *dev =3D phy->dev;

is it used?

> +	struct ieee80211_supported_band *sband;
> +	int i;
> +
> +	switch (chan->band) {
> +	case NL80211_BAND_2GHZ:
> +		sband =3D &phy->sband_2g.sband;
> +		break;
> +	case NL80211_BAND_5GHZ:
> +		sband =3D &phy->sband_5g.sband;
> +		break;
> +	default:
> +		return target_power;
> +	}
> +
> +	for (i =3D 0; i < sband->n_channels; i++) {
> +		struct ieee80211_channel *ch =3D &sband->channels[i];
> +
> +		if (ch->hw_value =3D=3D chan->hw_value) {
> +			if (!(ch->flags & IEEE80211_CHAN_DISABLED)) {
> +				int power =3D 2 * ch->max_reg_power;
> +
> +				if (power > 127 || power < -127)
> +					power =3D 127;

please correct me if I am wrong, but I guess the limit for mt7663 should be=
 63,
isn't it?

Regards,
Lorenzo

> +				target_power =3D min_t(s8, power, target_power);
> +			}
> +			break;
> +		}
> +	}
> +
> +	return target_power;
> +}
> +
>  static int
>  mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>  				  enum nl80211_band band)
> @@ -1840,10 +1877,12 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy=
 *phy,
>  				.hw_value =3D ch_list[idx],
>  				.band =3D band,
>  			};
> -			s8 sar_power;
> +			s8 reg_power, sar_power;
> =20
> +			reg_power =3D mt76_connac_get_ch_power(phy, &chan,
> +							     tx_power);
>  			sar_power =3D mt76_connac_get_sar_power(phy, &chan,
> -							      tx_power);
> +							      reg_power);
> =20
>  			mt76_get_rate_power_limits(phy, &chan, &limits,
>  						   sar_power);
> --=20
> 2.25.1
>=20

--HD5cfJbB7Qv0wneP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYQEIsAAKCRA6cBh0uS2t
rOt8AP95ov/z4ReB4ZY7fTytbfpDFkXdZwnkFTj4ewwteOrG/gD9GGC/FkHM7ZVY
kUBejtiUfKraUVcityNQO/PMzF83Qwo=
=cRqC
-----END PGP SIGNATURE-----

--HD5cfJbB7Qv0wneP--
