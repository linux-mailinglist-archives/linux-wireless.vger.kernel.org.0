Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4933D2F55
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhGVVGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 17:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVGK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 17:06:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8664E60EB4;
        Thu, 22 Jul 2021 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990405;
        bh=S7ql75eU3IvY20k2XWUiZ5k0Z+LBFzpLfCrC2gCeiaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OF0JGgyLEkEpR0juqqC6ZJcZj+VDy1kJMdtENIo8jBNaNQcTkNw/QOZ3EfUsxxxCF
         /s2kfHSuGu/iaYXgShdIm0eQFaiKc0mg4R5d5gNAOS08he6QEsEIDNTrT0VMFLPHQh
         pMz3YY6axx5r+WDoKXGhSfXPTe/v2kQmFOVV1mmNkyCyVkc8DMEKhAVo9vsj7JQmOF
         kw0hAfWG52z5BRp9XfLrOIoXLIFo2Cib4t3JYVfhmI3U0MUbNycXAyIEFZ1zxyGbjD
         R2AF+zZQyhNfUrrcAZszLQWEGqSF8kgp4ERSxB2kkwdxAPEPNpJMVNtgHOPxwahzK/
         FARhffZxWBijA==
Date:   Thu, 22 Jul 2021 23:46:40 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 3/8] mt76 - mt7915: Add some per-station tx stats to
 ethtool.
Message-ID: <YPnnQLjRC1fHq8Ka@lore-desk>
References: <20210722202504.6180-1-greearb@candelatech.com>
 <20210722202504.6180-3-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ac8JjPRZVDyo03jU"
Content-Disposition: inline
In-Reply-To: <20210722202504.6180-3-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ac8JjPRZVDyo03jU
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
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 116 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 469028d641c7..ad400ddf36c3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -425,6 +425,35 @@ static const char mt7915_gstrings_stats[][ETH_GSTRIN=
G_LEN] =3D {
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
> @@ -454,14 +483,15 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw =
*hw,
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
> @@ -515,6 +545,80 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *=
hw,
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

can we use ieee80211_iterate_stations_atomic() here?

Regards,
Lorenzo

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
> --=20
> 2.20.1
>=20

--ac8JjPRZVDyo03jU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPnnPQAKCRA6cBh0uS2t
rIRvAP9tib3qdUYhrtdjicf22VWT+1qPeFa+eoQb+jebjzc8aAEA3QkmhuTzJQP3
yd4UHesc+IwWJFOcV6E1secFGuP9gw4=
=kcCk
-----END PGP SIGNATURE-----

--ac8JjPRZVDyo03jU--
