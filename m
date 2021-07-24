Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005E93D47A9
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhGXL4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 07:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbhGXL4E (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 07:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 737D360F35;
        Sat, 24 Jul 2021 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627130196;
        bh=WvfTI2sW3aYwC2FcnnHA7MuHajJ00PtTzaRjFqCvN3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmPyr77NdMgn8fwFy7BGUmItq3JcSi0Fz2ttVhgaYwdabZrSu2fdG0Q2xzyaUNuZu
         NEklIyM7T/NxoIzNqjo0mml6rFOD28/mlGkDVo2gKps4lsLfdxrGVyAGDOwoRTUlsP
         fwG9r6uFhZtJ1BsOPpEKTHOKhycs/lbmKGJCb/3qj0+rURMqlzsHc3m7HkQ9+nHz20
         1cAxuDMxVshebiqLXeQVbBY+UlvFE+KhWYGeAPSKyfb2ixPiI/sZLl+r8tSPoBoY4o
         llst+bXHfCYMype/iloWP7/mwpBu1t3J9oEGCFfO8zInw8jXSviKxTY6VgS2ssSi75
         jdOaQEwyN9I8Q==
Date:   Sat, 24 Jul 2021 14:36:32 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/8] mt76 - mt7915: Add ethtool stats support.
Message-ID: <YPwJUGtBZxNi4RxM@lore-desk>
References: <20210723154627.10078-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+ELMjiBTrzO+Raky"
Content-Disposition: inline
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+ELMjiBTrzO+Raky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> This exposes some tx-path stats to the ethtool API, so that
> ethtool -S wlanX provides some more useful info.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> =20
> v4: move ethtool code to main.c
>   Re-work the 2/8 patch per review.
>   Did not try to refactor the station walk per comments on 3/8, I saw
>   no clean way to do that.
>=20
> .../net/wireless/mediatek/mt76/mt7915/main.c  | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 48b5e2051bad..d0288fe2abdf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1028,6 +1028,139 @@ static void mt7915_sta_set_decap_offload(struct i=
eee80211_hw *hw,
>  	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
>  }
> =20
> +static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] =3D {
> +	"tx_ampdu_len:0-1",
> +	"tx_ampdu_len:2-10",
> +	"tx_ampdu_len:11-19",
> +	"tx_ampdu_len:20-28",
> +	"tx_ampdu_len:29-37",
> +	"tx_ampdu_len:38-46",
> +	"tx_ampdu_len:47-55",
> +	"tx_ampdu_len:56-79",
> +	"tx_ampdu_len:80-103",
> +	"tx_ampdu_len:104-127",
> +	"tx_ampdu_len:128-151",
> +	"tx_ampdu_len:152-175",
> +	"tx_ampdu_len:176-199",
> +	"tx_ampdu_len:200-223",
> +	"tx_ampdu_len:224-247",
> +	"ba_miss_count",
> +	"tx_beamformer_ppdu_iBF",
> +	"tx_beamformer_ppdu_eBF",
> +	"tx_beamformer_rx_feedback_all",
> +	"tx_beamformer_rx_feedback_he",
> +	"tx_beamformer_rx_feedback_vht",
> +	"tx_beamformer_rx_feedback_ht",
> +	"tx_beamformer_rx_feedback_bw", /* zero based idx: 20, 40, 80, 160 */
> +	"tx_beamformer_rx_feedback_nc",
> +	"tx_beamformer_rx_feedback_nr",
> +	"tx_beamformee_ok_feedback_pkts",
> +	"tx_beamformee_feedback_trig",
> +	"tx_mu_beamforming",
> +	"tx_mu_mpdu",
> +	"tx_mu_successful_mpdu",
> +	"tx_su_successful_mpdu",
> +	"tx_msdu_pack_1",
> +	"tx_msdu_pack_2",
> +	"tx_msdu_pack_3",
> +	"tx_msdu_pack_4",
> +	"tx_msdu_pack_5",
> +	"tx_msdu_pack_6",
> +	"tx_msdu_pack_7",
> +	"tx_msdu_pack_8",
> +};
> +
> +#define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
> +
> +/* Ethtool related API */
> +void mt7915_get_et_strings(struct ieee80211_hw *hw,
> +			   struct ieee80211_vif *vif,
> +			   u32 sset, u8 *data)

please make them static

Regards,
Lorenzo

> +{
> +	if (sset =3D=3D ETH_SS_STATS)
> +		memcpy(data, *mt7915_gstrings_stats,
> +		       sizeof(mt7915_gstrings_stats));
> +}
> +
> +int mt7915_get_et_sset_count(struct ieee80211_hw *hw,
> +			     struct ieee80211_vif *vif, int sset)
> +{
> +	if (sset =3D=3D ETH_SS_STATS)
> +		return MT7915_SSTATS_LEN;
> +
> +	return 0;
> +}
> +
> +void mt7915_get_et_stats(struct ieee80211_hw *hw,
> +			 struct ieee80211_vif *vif,
> +			 struct ethtool_stats *stats, u64 *data)
> +{
> +	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
> +	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> +
> +	/* TODO:  These are mostly dev-wide stats at this point.
> +	 *  Get some per-vif stats?
> +	 */
> +
> +	/* See mt7915_ampdu_stat_read_phy, etc */
> +	bool ext_phy =3D phy !=3D &dev->phy;
> +	int i, n, cnt;
> +	int ei =3D 0;
> +
> +	if (!phy)
> +		return;
> +
> +	/* Tx ampdu stat */
> +	n =3D ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
> +	for (i =3D 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
> +		data[ei++] =3D dev->mt76.aggr_stats[i + n];
> +
> +	data[ei++] =3D phy->mib.ba_miss_cnt;
> +
> +	/* Tx Beamformer monitor */
> +	cnt =3D mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
> +	data[ei++] =3D FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
> +
> +	/* Tx Beamformer Rx feedback monitor */
> +	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
> +
> +	/* Tx Beamformee Rx NDPA & Tx feedback report */
> +	cnt =3D mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
> +	data[ei++] =3D FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
> +	data[ei++] =3D FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
> +
> +	/* Tx SU & MU counters */
> +	cnt =3D mt76_rr(dev, MT_MIB_SDR34(ext_phy));
> +	data[ei++] =3D FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR8(ext_phy));
> +	data[ei++] =3D cnt;
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR9(ext_phy));
> +	data[ei++] =3D cnt; /* MU MPDU SUccessful */
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
> +	data[ei++] =3D cnt; /* SU MPDU successful */
> +
> +	/* TODO:  External phy too?? */
> +
> +	/* Tx amsdu info (pack-count histogram) */
> +	for (i =3D 0; i < 8; i++)
> +		data[ei++] =3D mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
> +
> +	WARN_ON(ei !=3D MT7915_SSTATS_LEN);
> +}
> +
>  const struct ieee80211_ops mt7915_ops =3D {
>  	.tx =3D mt7915_tx,
>  	.start =3D mt7915_start,
> @@ -1052,6 +1185,9 @@ const struct ieee80211_ops mt7915_ops =3D {
>  	.get_txpower =3D mt76_get_txpower,
>  	.channel_switch_beacon =3D mt7915_channel_switch_beacon,
>  	.get_stats =3D mt7915_get_stats,
> +	.get_et_sset_count =3D mt7915_get_et_sset_count,
> +	.get_et_stats =3D mt7915_get_et_stats,
> +	.get_et_strings =3D mt7915_get_et_strings,
>  	.get_tsf =3D mt7915_get_tsf,
>  	.set_tsf =3D mt7915_set_tsf,
>  	.offset_tsf =3D mt7915_offset_tsf,
> --=20
> 2.20.1
>=20

--+ELMjiBTrzO+Raky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPwJTQAKCRA6cBh0uS2t
rC3KAPoDeOOYi6nuCmqI+PHawRVuvy5pYEed6Jw2yHjzl99QvgD7B6KQPu9BGoW+
jcwCKyKMl/PGAFrRRbttCDzEr1AKgQQ=
=o98a
-----END PGP SIGNATURE-----

--+ELMjiBTrzO+Raky--
