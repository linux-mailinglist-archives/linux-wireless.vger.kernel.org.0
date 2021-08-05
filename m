Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598F3E0E8B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhHEGpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 02:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhHEGpf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 02:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 732A560462;
        Thu,  5 Aug 2021 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628145921;
        bh=M/GfuYHTix3waNbmYdkOqyUu+CmAGKSMK3fHOxTlX/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSk8kwFfPxB3/4i5tTCbGii6wWBfTkP/zDyKlOPfYNNEaNXKImhldAFc7aaAJ8Hua
         v5G6O9EtCixcmjPRNtirLNWEs8dEqgs8GvI6mOrnSPxlUgpGztMrFhdyo3kgIZRI8a
         373t0ofmaS8EPXv7PQ8zJUYhXtWjykcOcC+ItdJnIKIfvETw1CpSoGEQpI/QhiNBeT
         /W1DwWKRzY3FcS56uOhcAbtzTklWV5qSAoSNQ4v8vCuaFeC2XcAC7TwIA87k629EFA
         adU1Nka68PYgElq2/vS48RRjzXPefFdCt3uWuRGkf+BCEz0z2oxmnvA5j5J2fZKWBL
         3gn1KGJveR3og==
Date:   Thu, 5 Aug 2021 08:45:17 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] mt76: connac: add support maximum regulatory Tx power
Message-ID: <YQuI/Zf8vYjKx9LR@lore-desk>
References: <e05024275119c517a4eb7e39bf249640db68d07d.1628115504.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxDLajrAgiBDpkcF"
Content-Disposition: inline
In-Reply-To: <e05024275119c517a4eb7e39bf249640db68d07d.1628115504.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--hxDLajrAgiBDpkcF
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
> v2: consider the power limit that can be allowed on mt7663
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 43 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index d71393b1c5e6..80987af03efe 100644
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
> +				if (is_mt7663(dev) && (power > 63 || power < -64))
> +					power =3D 63;

I guess now you are missing the value for mt7921. What I mean is something
similar to mt76_connac_mcu_build_sku()

int max_power =3D is_mt7921(dev) ? 127 : 63;

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

--hxDLajrAgiBDpkcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYQuI+gAKCRA6cBh0uS2t
rPB9AQDCnVhsbNJDEIyRTl1ack1ChpXMCi7BwkMYperDcFN2VQEAiyEnXDp5pw9d
1qugK0mBeoZ1WsgtJNNJNvVbMZGsXQI=
=AOvU
-----END PGP SIGNATURE-----

--hxDLajrAgiBDpkcF--
