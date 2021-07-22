Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726B83D2F59
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhGVVHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 17:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVHn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 17:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E0360EB4;
        Thu, 22 Jul 2021 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990498;
        bh=KExz7Aqrl42Dc7vTF7gDStieypjEF1ImKqIj0Fzr5AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmJOs9auvWOmLriPArRpRUbOTMeUHd4DVMwTav0WIYlGvFD7hsbRuu8F+EjaVoshP
         rufvpPMlPBwPEgu/W2GLRm3B7H4w1OR47edvHkdkc7Bw91OpqZOgzcjk2tQ4qNns4N
         doNmPHzf2NCqDAKvsY6n+Rs3t6NUqw93v5k4XwesdOUhNhRaZOs5jzFwSrpzbAuAt9
         gVUOiwPjrLNegGezL0guKM3hY3S5v4nTwLfHR+mZVkFFWddQouMVAeTBCQpNRo4SFT
         /qPbwfXH/H2uPKD45Q9K1PXLwmBaYaqHd1Hm73CmkKdu9KZDXdqTzcTMmLq8zo8zaa
         6zvTsM9QZTWUg==
Date:   Thu, 22 Jul 2021 23:48:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 4/8] mt76 - mt7915: Add tx mu/su counters to mib
Message-ID: <YPnnnYKHG19St0yK@lore-desk>
References: <20210722202504.6180-1-greearb@candelatech.com>
 <20210722202504.6180-4-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MypwgkCErZPm6EVd"
Content-Disposition: inline
In-Reply-To: <20210722202504.6180-4-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MypwgkCErZPm6EVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 22, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> These counters are clear-on-read, so we need to accumulate
> them in the update_stats poll logic, and read the accumulated
> values instead of directly doing register reads when reporting
> to debugfs and ethtool stats.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 33 ++++++++-----------
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 13 +++++++-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +++
>  3 files changed, 29 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index ad400ddf36c3..759899c44583 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -152,6 +152,7 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, str=
uct seq_file *s)
>  		"BW20", "BW40", "BW80", "BW160"
>  	};
>  	int cnt;
> +	struct mib_stats *mib =3D &phy->mib;
> =20
>  	if (!phy)
>  		return;
> @@ -187,15 +188,13 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, s=
truct seq_file *s)
>  		   FIELD_GET(MT_ETBF_TX_FB_TRI, cnt));
> =20
>  	/* Tx SU & MU counters */
> -	cnt =3D mt76_rr(dev, MT_MIB_SDR34(ext_phy));
> -	seq_printf(s, "Tx multi-user Beamforming counts: %ld\n",
> -		   FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt));
> -	cnt =3D mt76_rr(dev, MT_MIB_DR8(ext_phy));
> -	seq_printf(s, "Tx multi-user MPDU counts: %d\n", cnt);
> -	cnt =3D mt76_rr(dev, MT_MIB_DR9(ext_phy));
> -	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n", cnt);
> -	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
> -	seq_printf(s, "Tx single-user successful MPDU counts: %d\n", cnt);
> +	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
> +		   mib->tx_bf_cnt);
> +	seq_printf(s, "Tx multi-user MPDU counts: %d\n", mib->tx_mu_mpdu_cnt);
> +	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n",
> +		   mib->tx_mu_successful_mpdu_cnt);
> +	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
> +		   mib->tx_su_successful_mpdu_cnt);
> =20
>  	seq_puts(s, "\n");
>  }
> @@ -488,6 +487,7 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *h=
w,
>  	struct mt7915_sta *msta;
>  	struct mt7915_sta_stats *mstats;
>  	bool found_sta =3D false;
> +	struct mib_stats *mib =3D &phy->mib;
> =20
>  	/* See mt7915_ampdu_stat_read_phy, etc */
>  	bool ext_phy =3D phy !=3D &dev->phy;
> @@ -527,17 +527,10 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw =
*hw,
>  	data[ei++] =3D FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
> =20
>  	/* Tx SU & MU counters */
> -	cnt =3D mt76_rr(dev, MT_MIB_SDR34(ext_phy));
> -	data[ei++] =3D FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
> -
> -	cnt =3D mt76_rr(dev, MT_MIB_DR8(ext_phy));
> -	data[ei++] =3D cnt;
> -
> -	cnt =3D mt76_rr(dev, MT_MIB_DR9(ext_phy));
> -	data[ei++] =3D cnt; /* MU MPDU SUccessful */
> -
> -	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
> -	data[ei++] =3D cnt; /* SU MPDU successful */
> +	data[ei++] =3D mib->tx_bf_cnt;
> +	data[ei++] =3D mib->tx_mu_mpdu_cnt;
> +	data[ei++] =3D mib->tx_mu_successful_mpdu_cnt;
> +	data[ei++] =3D mib->tx_su_successful_mpdu_cnt;
> =20
>  	/* TODO:  External phy too?? */
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 3a10e14fbd50..23540ba5da97 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1880,10 +1880,21 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
>  	struct mt7915_dev *dev =3D phy->dev;
>  	struct mib_stats *mib =3D &phy->mib;
>  	bool ext_phy =3D phy !=3D &dev->phy;
> -	int i, aggr0, aggr1;
> +	int i, aggr0, aggr1, cnt;
> =20
>  	mib->fcs_err_cnt +=3D mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
>  					   MT_MIB_SDR3_FCS_ERR_MASK);
> +	cnt =3D mt76_rr(dev, MT_MIB_SDR34(ext_phy));
> +	mib->tx_bf_cnt +=3D FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR8(ext_phy));
> +	mib->tx_mu_mpdu_cnt +=3D cnt;
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR9(ext_phy));
> +	mib->tx_mu_successful_mpdu_cnt +=3D cnt;
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
> +	mib->tx_su_successful_mpdu_cnt +=3D cnt;
> =20
>  	aggr0 =3D ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
>  	for (i =3D 0, aggr1 =3D aggr0 + 4; i < 4; i++) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index ff944d1cf527..c5d0f2331b6f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -116,6 +116,10 @@ struct mib_stats {
>  	u32 rts_cnt;
>  	u32 rts_retries_cnt;
>  	u32 ba_miss_cnt;
> +	u32 tx_bf_cnt;
> +	u32 tx_mu_mpdu_cnt;
> +	u32 tx_mu_successful_mpdu_cnt;
> +	u32 tx_su_successful_mpdu_cnt;

nit:
s/tx_mu_successful*/tx_mu_acked*/

>  	/* Add more stats here, updated from mac_update_stats */
>  };
> =20
> --=20
> 2.20.1
>=20

--MypwgkCErZPm6EVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPnnmwAKCRA6cBh0uS2t
rHa8AQCBz5b7Ruauel3En8opB2zwi8gOA0LcXB9gffb1lvyOMAD8Cc2fwy5PbHi4
aibrAv4HyxLpaYgqdp0qGO5glVJvwQM=
=YKlr
-----END PGP SIGNATURE-----

--MypwgkCErZPm6EVd--
