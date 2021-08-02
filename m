Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1613DDCF7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhHBP6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhHBP6R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:58:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF3361102;
        Mon,  2 Aug 2021 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627919888;
        bh=ezjSXOa8rkXEer10Na/t0VlqYJk4ORYl/15FrFHZIv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ4/PweTZED2cfx20aIf+TsvZx49FLqLKsPQqKvMubdG0o3c2kthoyuDN3hIuC8DQ
         esugT4SUyhBvNSPlGNXFEzpKMZ3SY8X43Kd0RXSJmecKbg/uRgoaWhjmGcVskVJnua
         QZoxqgX7oYtYBgEnru7PfadfZRM/jOv9bhy8Ai5b1PC12D4yoSbReZy43ppSViheL1
         PGUQO74FDffaAvsuA+iT/9HJ6JSH3RKf8si2xJ6GRLhPwvAFrv5zro72m5tncWNyPr
         rt0OHf2Pa5c4MWswiXGWyb8ZiRtmOlaS8/+IH2M3Dr5xcP4+Ori6y+6IPl2sG8KWTf
         TX7iQNk8AaSXg==
Date:   Mon, 2 Aug 2021 17:58:03 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/7] mt76: mt7915: add some per-station tx stats to
 ethtool
Message-ID: <YQgWCxrCbKAZq6U3@lore-desk>
References: <20210802150808.30113-1-greearb@candelatech.com>
 <20210802150808.30113-3-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owrvu04ZxqawYk6m"
Content-Disposition: inline
In-Reply-To: <20210802150808.30113-3-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--owrvu04ZxqawYk6m
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
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 98 ++++++++++++++++++-
>  1 file changed, 93 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 994f84e9d7aa..88a8547e2e7f 100644
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
> @@ -1093,6 +1122,50 @@ int mt7915_get_et_sset_count(struct ieee80211_hw *=
hw,
>  	return 0;
>  }
> =20
> +struct mt7915_ethtool_worker_info {
> +	u64 *data;
> +	struct mt7915_vif *mvif;
> +	int initial_stat_idx;
> +	int worker_stat_count;
> +	int sta_count;
> +};
> +
> +static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *s=
ta)
> +{
> +	struct mt7915_ethtool_worker_info *wi =3D wi_data;
> +	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +	int ei =3D wi->initial_stat_idx;
> +	int q;
> +	u64 *data =3D wi->data;
> +	struct mt7915_sta_stats *mstats =3D &msta->stats;
> +
> +	if (msta->vif !=3D wi->mvif)
> +		return;
> +
> +	wi->sta_count++;
> +
> +	data[ei++] +=3D mstats->tx_mpdu_attempts;
> +	data[ei++] +=3D mstats->tx_mpdu_fail;
> +	data[ei++] +=3D mstats->tx_mpdu_retry;
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_CCK];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_OFDM];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HT];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HT_GF];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_VHT];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_SU];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_TB];
> +	data[ei++] +=3D mstats->tx_mode[MT_PHY_TYPE_HE_MU];
> +
> +	for (q =3D 0; q < ARRAY_SIZE(mstats->tx_bw); q++)
> +		data[ei++] +=3D mstats->tx_bw[q];
> +
> +	for (q =3D 0; q < 12; q++)
> +		data[ei++] +=3D mstats->tx_mcs[q];
> +
> +	wi->worker_stat_count =3D ei - wi->initial_stat_idx;
> +}
> +
>  static
>  void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  			 struct ieee80211_vif *vif,
> @@ -1100,10 +1173,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  {
>  	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
>  	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> -
> -	/* TODO:  These are mostly dev-wide stats at this point.
> -	 *  Get some per-vif stats?
> -	 */
> +	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
> +	struct mt7915_ethtool_worker_info wi;
> =20
>  	/* See mt7915_ampdu_stat_read_phy, etc */
>  	bool ext_phy =3D phy !=3D &dev->phy;
> @@ -1161,7 +1232,24 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  	for (i =3D 0; i < 8; i++)
>  		data[ei++] =3D mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
> =20
> -	WARN_ON(ei !=3D MT7915_SSTATS_LEN);
> +	/* Add values for all stations owned by this vif */
> +	wi.data =3D data;
> +	wi.mvif =3D mvif;
> +	wi.initial_stat_idx =3D ei;
> +	wi.worker_stat_count =3D 0;
> +	wi.sta_count =3D 0;
> +
> +	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
> +
> +	if (wi.sta_count =3D=3D 0)
> +		return;
> +
> +	ei +=3D wi.worker_stat_count;
> +	if (ei !=3D MT7915_SSTATS_LEN) {
> +		dev_err(dev->mt76.dev, "ei: %d  MT7915_SSTATS_LEN: %d",
> +			ei, (int)(MT7915_SSTATS_LEN));

you can drop () here

> +		WARN_ON_ONCE(ei !=3D MT7915_SSTATS_LEN);

I think you can drop WARN_ON_ONCE here since we already have dev_err()

Regards,
Lorenzo

> +	}
>  }
> =20
>  const struct ieee80211_ops mt7915_ops =3D {
> --=20
> 2.20.1
>=20

--owrvu04ZxqawYk6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYQgWCQAKCRA6cBh0uS2t
rKIrAQDQGgAEGWwRBzudv1uHLIxim1TLLDmLtCj+4UTxdwN3IQD/cFFxSmrO6SBR
cdc0pzRDQckTNhtDlAzcZRDNeOcswQY=
=iAX8
-----END PGP SIGNATURE-----

--owrvu04ZxqawYk6m--
