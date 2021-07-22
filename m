Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491183D2DF1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhGVUML (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 16:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhGVUML (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1284560EB1;
        Thu, 22 Jul 2021 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626987165;
        bh=Xgi3EjAzgRjuoFRi56emVCF6+5/PTgb+8lBSVCjEgEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0SJ4t/ZL0ASDGIB0WBDgZ32WYlATZkk0AYYkhQHXqDV9d3fCLxFhJyrQVE81Jn4e
         ZxgY9rMJtXmdVN1X80lJ0ABLgicmKXdI40WYkO1i0Rg6Ik21/hpn4uJoJyp9kDVA4I
         pFLGqXpRDvuakIlwAPq8Eyz2X8fz7yRRpfnAOBMVimNGFaSlkpgnZ6HA4MKsoTShMT
         DXzNZbC4obAzg+fxKphshLiMiy5dlHcqRxpv/E4gVzsJWNTA1jdBKzYhN8inhl4FDZ
         Nu89yui1Img4R1Gjj30YqfYwSJdwfF5Q5YkwA5TYUIAEzFIivFOgc/2qq0wisGM+xm
         Vh/lslaR2gNPw==
Date:   Thu, 22 Jul 2021 22:52:40 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/8] mt76 - mt7915: Add ethtool stats support.
Message-ID: <YPnamPriMNJUV13Z@lore-desk>
References: <20210722202504.6180-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oR3Bo+9M+9Pvosjx"
Content-Disposition: inline
In-Reply-To: <20210722202504.6180-1-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--oR3Bo+9M+9Pvosjx
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
> v3:  Clean up checkpatch warnings.
>=20
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 135 ++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  12 ++
>  3 files changed, 150 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 1a48b09d0cb7..469028d641c7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -382,4 +382,139 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw=
, struct ieee80211_vif *vif,
>  {
>  	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
>  }
> +

please remove the new line here

>  #endif
> +
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
> +void mt7915_debug_get_et_strings(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 u32 sset, u8 *data)
> +{
> +	if (sset =3D=3D ETH_SS_STATS)
> +		memcpy(data, *mt7915_gstrings_stats,
> +		       sizeof(mt7915_gstrings_stats));
> +}
> +
> +int mt7915_debug_get_et_sset_count(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif, int sset)
> +{
> +	if (sset =3D=3D ETH_SS_STATS)
> +		return MT7915_SSTATS_LEN;
> +
> +	return 0;
> +}

are these routine just used in main.c? if so I guess to move them there and
make them static

> +
> +void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
> +			       struct ieee80211_vif *vif,
> +			       struct ethtool_stats *stats, u64 *data)
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
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 48b5e2051bad..ed94e3c3c51d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1052,6 +1052,9 @@ const struct ieee80211_ops mt7915_ops =3D {
>  	.get_txpower =3D mt76_get_txpower,
>  	.channel_switch_beacon =3D mt7915_channel_switch_beacon,
>  	.get_stats =3D mt7915_get_stats,
> +	.get_et_sset_count =3D mt7915_debug_get_et_sset_count,
> +	.get_et_stats =3D mt7915_debug_get_et_stats,
> +	.get_et_strings =3D mt7915_debug_get_et_strings,
>  	.get_tsf =3D mt7915_get_tsf,
>  	.set_tsf =3D mt7915_set_tsf,
>  	.offset_tsf =3D mt7915_offset_tsf,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 33be449309e0..a3c78365db23 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -419,4 +419,16 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw,=
 struct ieee80211_vif *vif,
>  			    struct ieee80211_sta *sta, struct dentry *dir);
>  #endif
> =20
> +/* Ethtool API, implementation found in debugfs.c */
> +void mt7915_debug_get_et_strings(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 u32 sset, u8 *data);
> +
> +int mt7915_debug_get_et_sset_count(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif, int sset);
> +
> +void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
> +			       struct ieee80211_vif *vif,
> +			       struct ethtool_stats *stats, u64 *data);
> +
>  #endif
> --=20
> 2.20.1
>=20

--oR3Bo+9M+9Pvosjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPnalQAKCRA6cBh0uS2t
rLYMAP9dBFY7ZdftStwkC0jO/k4c+mbmfpkqArZqft6Ub8RMcwEAloL2D3XXNW0h
qDzu0fjEj8rMFxgOTXew0VhGJeeYEAM=
=KxQB
-----END PGP SIGNATURE-----

--oR3Bo+9M+9Pvosjx--
