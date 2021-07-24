Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8B3D47AB
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhGXL4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 07:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhGXL4y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 07:56:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A23960ED7;
        Sat, 24 Jul 2021 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627130246;
        bh=tPcZUEuuLUXyCaRiPbZzFytNuI96/etv5qcLqN+1iPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Io+2gUk5A2rR9EdOjIrDvs6UAq0AUA1Q5P/i+bLQAH3bA8AOC73/WSBVnvWNDfsa7
         ji/gDOF0Z8INhXQN2FbA3BJ1fwHVRzk0Ucc4wRXfnTh/V5JEO7fCqd1bNSUjrqBoe6
         1YYWa9eAGoCkawZWTAaMdCfCnlDKOOQAsh1LUNan/MYnXOPeger8nBEHXDf0vgijUR
         BayZh3N1fGUAr/bXhIY3emD7OHH8QnjSemFVh4D2r6e7ixxU/FFsGfR/3R1E5MzRNy
         fpAw9I77+U6OToIZHQ2N6QL2OV2jRtUw6EmjZHSP/pHqKA0G01EgYTHGOIz4WSFHZE
         8QddhD5amr0Aw==
Date:   Sat, 24 Jul 2021 14:37:21 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 3/8] mt76 - mt7915: Add some per-station tx stats to
 ethtool.
Message-ID: <YPwJgX/Po9/+RUWA@lore-desk>
References: <20210723154627.10078-1-greearb@candelatech.com>
 <20210723154627.10078-3-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdDvLNad3YLrm0Gl"
Content-Disposition: inline
In-Reply-To: <20210723154627.10078-3-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qdDvLNad3YLrm0Gl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> The tx status callback is not called for every frame, so
> those specific counters under-count, but at least they give
> some idea of what is going on.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 116 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index d0288fe2abdf..de083008663e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1068,6 +1068,35 @@ static const char mt7915_gstrings_stats[][ETH_GSTR=
ING_LEN] =3D {
>  	"tx_msdu_pack_6",
>  	"tx_msdu_pack_7",
>  	"tx_msdu_pack_8",
> +	/* per vif counters */
> +	"v_tx_mpdu_attempts",
> +	"v_tx_mpdu_fail",
> +	"v_tx_mpdu_retry",
> +	"v_tx_mode_cck",
> +	"v_tx_mode_ofdm",
> +	"v_tx_mode_ht",
> +	"v_tx_mode_ht_gf",
> +	"v_tx_mode_vht",
> +	"v_tx_mode_he_su",
> +	"v_tx_mode_he_ext_su",
> +	"v_tx_mode_he_tb",
> +	"v_tx_mode_he_mu",
> +	"v_tx_bw_20",
> +	"v_tx_bw_40",
> +	"v_tx_bw_80",
> +	"v_tx_bw_160",
> +	"v_tx_mcs_0",
> +	"v_tx_mcs_1",
> +	"v_tx_mcs_2",
> +	"v_tx_mcs_3",
> +	"v_tx_mcs_4",
> +	"v_tx_mcs_5",
> +	"v_tx_mcs_6",
> +	"v_tx_mcs_7",
> +	"v_tx_mcs_8",
> +	"v_tx_mcs_9",
> +	"v_tx_mcs_10",
> +	"v_tx_mcs_11",
>  };
> =20
>  #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
> @@ -1097,14 +1126,15 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  {
>  	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
>  	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> -
> -	/* TODO:  These are mostly dev-wide stats at this point.
> -	 *  Get some per-vif stats?
> -	 */
> +	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
> +	struct mt76_wcid *wcid;
> +	struct mt7915_sta *msta;
> +	struct mt7915_sta_stats *mstats;
> +	bool found_sta =3D false;
> =20
>  	/* See mt7915_ampdu_stat_read_phy, etc */
>  	bool ext_phy =3D phy !=3D &dev->phy;
> -	int i, n, cnt;
> +	int i, j, n, cnt, next_ei;
>  	int ei =3D 0;
> =20
>  	if (!phy)
> @@ -1158,7 +1188,81 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  	for (i =3D 0; i < 8; i++)
>  		data[ei++] =3D mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
> =20
> -	WARN_ON(ei !=3D MT7915_SSTATS_LEN);
> +	/* Add values for all stations owned by this vif */
> +
> +	/* See mt76_get_min_avr_rssi for example of how to find all sta
> +	 * for a vif
> +	 */
> +	local_bh_disable();
> +	rcu_read_lock();
> +
> +	next_ei =3D ei;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dev->mt76.wcid_mask); i++) {
> +		u32 mask =3D dev->mt76.wcid_mask[i];
> +		u32 phy_mask =3D dev->mt76.wcid_phy_mask[i];
> +		int q;
> +
> +		if (!mask)
> +			continue;
> +
> +		for (j =3D i * 32; mask; j++, mask >>=3D 1, phy_mask >>=3D 1) {
> +			if (!(mask & 1))
> +				continue;
> +
> +			if (!!(phy_mask & 1) !=3D ext_phy)
> +				continue;
> +
> +			wcid =3D rcu_dereference(dev->mt76.wcid[j]);
> +			if (!wcid)
> +				continue;

I think you can use ieee80211_iterate_stations_atomic() here

Regards,
Lorenzo

> +
> +			msta =3D container_of(wcid, struct mt7915_sta, wcid);
> +
> +			if (msta->vif !=3D mvif)
> +				continue;
> +
> +			ei =3D next_ei;
> +			mstats =3D &msta->stats;
> +			data[ei++] +=3D mstats->tx_mpdu_attempts;
> +			data[ei++] +=3D mstats->tx_mpdu_fail;
> +			data[ei++] +=3D mstats->tx_mpdu_retry;
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_CCK];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_OFDM];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HT];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HT_GF];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_VHT];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_SU];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_TB];
> +			data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_MU];
> +
> +			for (q =3D 0; q < ARRAY_SIZE(mstats->tx_bw); q++)
> +				data[ei++] +=3D mstats->tx_bw[q];
> +
> +			for (q =3D 0; q < 12; q++)
> +				data[ei++] +=3D mstats->tx_mcs[q];
> +			found_sta =3D true;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +	local_bh_enable();
> +
> +	/* If we have no stations above, then we will not have filled out
> +	 * the STA stats.  Zero those stats.
> +	 */
> +	if (!found_sta) {
> +		int q;
> +
> +		for (q =3D 0; q < 28; q++)
> +			data[ei++] =3D 0;
> +	}
> +
> +	if (ei !=3D MT7915_SSTATS_LEN) {
> +		pr_err("ei: %d  MT7915_SSTATS_LEN: %d", ei, (int)(MT7915_SSTATS_LEN));
> +		WARN_ON_ONCE(ei !=3D MT7915_SSTATS_LEN);
> +	}
>  }
> =20
>  const struct ieee80211_ops mt7915_ops =3D {
> --=20
> 2.20.1
>=20

--qdDvLNad3YLrm0Gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPwJfwAKCRA6cBh0uS2t
rLZcAP9nGJBLHPDUWw7Dl+/TIKy4wBVwgX8YEXhVNtTOgzvsfQEAhKkulXDk+BPq
MWvGwcGeCEY8I4Ez5NFvd7CYBFpeKAQ=
=PvAP
-----END PGP SIGNATURE-----

--qdDvLNad3YLrm0Gl--
