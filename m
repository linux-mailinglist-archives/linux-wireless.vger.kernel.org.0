Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1ED3D47AD
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhGXMAA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 08:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhGXMAA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 08:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02CBE60EBA;
        Sat, 24 Jul 2021 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627130432;
        bh=5hRwIZpztCJRN9huNkLdhHNglV3uLA2azYh9eNBddLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8WQLAmNeXQdeuSMV473LLE0zJ+5Mpy8wmbmaOyzMnYb3dXg5TJEtp6t4wW32edFr
         3VqrlexZMRndwNapHMAkczG1QWRaK0e8vxXEEM7z7r5DQOaNivaRMGBuXXKQ1t2wvu
         WHsHoiCIzMFdW6gi5P7pfC2M8ej7r9yX5yYFrtr/jfDNiVkGGW/vJOpkqR/ielpqXC
         T7uqT9huXjM3di3Ud4QdmqhWJTWNT59L3PRWPoLWMYZOoTthOvxttRyGiIBGTXR/XF
         3FwAw0vzaQxJkHxTNvW1mIzvWSjeUo8ETtl9u2Fs5BaYqEnXMHzzPPLUCoEG5zgCXn
         j9KaIT2UzncjQ==
Date:   Sat, 24 Jul 2021 14:40:28 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 5/8] mt76 - mt7915: Move more tx-bf stats to mib.
Message-ID: <YPwKPIqi6lBoXXE6@lore-desk>
References: <20210723154627.10078-1-greearb@candelatech.com>
 <20210723154627.10078-5-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vGbDacECVhjv4wkR"
Content-Disposition: inline
In-Reply-To: <20210723154627.10078-5-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--vGbDacECVhjv4wkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 23, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> These are clear-on-read, so accumulate them in the update_stats
> polling method, then access them via the mib structure
> when reading them from debugfs/ethtool.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 44 +++++++++----------
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 19 ++++++++
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 28 +++++-------
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    | 15 +++++++
>  4 files changed, 66 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 35248d182728..91664ac63a8d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -146,46 +146,42 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
>  static void
>  mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
>  {
> -	struct mt7915_dev *dev =3D s->private;
> -	bool ext_phy =3D phy !=3D &dev->phy;
>  	static const char * const bw[] =3D {
>  		"BW20", "BW40", "BW80", "BW160"
>  	};
> -	int cnt;
> -	struct mib_stats *mib =3D &phy->mib;
> +	struct mib_stats *mib;
> =20
>  	if (!phy)
>  		return;
> =20
> +	mib =3D &phy->mib;

please merge it in the previous patch

> +
>  	/* Tx Beamformer monitor */
>  	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
> =20
> -	cnt =3D mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
> -	seq_printf(s, "iBF: %ld, eBF: %ld\n",
> -		   FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt),
> -		   FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt));
> +	seq_printf(s, "iBF: %d, eBF: %d\n",
> +		   mib->tx_bf_ibf_ppdu_cnt,
> +		   mib->tx_bf_ebf_ppdu_cnt);
> =20
>  	/* Tx Beamformer Rx feedback monitor */
>  	seq_puts(s, "Tx Beamformer Rx feedback statistics: ");
> =20
> -	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
> -	seq_printf(s, "All: %ld, HE: %ld, VHT: %ld, HT: %ld, ",
> -		   FIELD_GET(MT_ETBF_RX_FB_ALL, cnt),
> -		   FIELD_GET(MT_ETBF_RX_FB_HE, cnt),
> -		   FIELD_GET(MT_ETBF_RX_FB_VHT, cnt),
> -		   FIELD_GET(MT_ETBF_RX_FB_HT, cnt));
> -	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
> -	seq_printf(s, "%s, NC: %ld, NR: %ld\n",
> -		   bw[FIELD_GET(MT_ETBF_RX_FB_BW, cnt)],
> -		   FIELD_GET(MT_ETBF_RX_FB_NC, cnt),
> -		   FIELD_GET(MT_ETBF_RX_FB_NR, cnt));
> +	seq_printf(s, "All: %d, HE: %d, VHT: %d, HT: %d, ",
> +		   mib->tx_bf_rx_fb_all_cnt,
> +		   mib->tx_bf_rx_fb_he_cnt,
> +		   mib->tx_bf_rx_fb_vht_cnt,
> +		   mib->tx_bf_rx_fb_ht_cnt);
> +
> +	seq_printf(s, "%s, NC: %d, NR: %d\n",
> +		   bw[mib->tx_bf_rx_fb_bw],
> +		   mib->tx_bf_rx_fb_nc_cnt,
> +		   mib->tx_bf_rx_fb_nr_cnt);
> =20
>  	/* Tx Beamformee Rx NDPA & Tx feedback report */
> -	cnt =3D mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
> -	seq_printf(s, "Tx Beamformee successful feedback frames: %ld\n",
> -		   FIELD_GET(MT_ETBF_TX_FB_CPL, cnt));
> -	seq_printf(s, "Tx Beamformee feedback triggered counts: %ld\n",
> -		   FIELD_GET(MT_ETBF_TX_FB_TRI, cnt));
> +	seq_printf(s, "Tx Beamformee successful feedback frames: %d\n",
> +		   mib->tx_bf_fb_cpl_cnt);
> +	seq_printf(s, "Tx Beamformee feedback triggered counts: %d\n",
> +		   mib->tx_bf_fb_trig_cnt);
> =20
>  	/* Tx SU & MU counters */
>  	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 064d754e0565..c395600b378a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1906,6 +1906,25 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
>  	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
>  	mib->tx_su_acked_mpdu_cnt +=3D cnt;
> =20
> +	cnt =3D mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
> +	mib->tx_bf_ibf_ppdu_cnt +=3D FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
> +	mib->tx_bf_ebf_ppdu_cnt +=3D FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
> +	mib->tx_bf_rx_fb_all_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
> +	mib->tx_bf_rx_fb_he_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
> +	mib->tx_bf_rx_fb_vht_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
> +	mib->tx_bf_rx_fb_ht_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
> +	mib->tx_bf_rx_fb_bw =3D FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
> +	mib->tx_bf_rx_fb_nc_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
> +	mib->tx_bf_rx_fb_nr_cnt +=3D FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
> +
> +	cnt =3D mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
> +	mib->tx_bf_fb_cpl_cnt +=3D FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
> +	mib->tx_bf_fb_trig_cnt +=3D FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
> +
>  	aggr0 =3D ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
>  	for (i =3D 0, aggr1 =3D aggr0 + 4; i < 4; i++) {
>  		u32 val;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index be6444650afe..885e35bf0fe8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1135,7 +1135,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
> =20
>  	/* See mt7915_ampdu_stat_read_phy, etc */
>  	bool ext_phy =3D phy !=3D &dev->phy;
> -	int i, j, n, cnt, next_ei;
> +	int i, j, n, next_ei;
>  	int ei =3D 0;
> =20
>  	if (!phy)
> @@ -1149,26 +1149,22 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  	data[ei++] =3D phy->mib.ba_miss_cnt;
> =20
>  	/* Tx Beamformer monitor */
> -	cnt =3D mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
> -	data[ei++] =3D FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
> +	data[ei++] =3D mib->tx_bf_ibf_ppdu_cnt;
> +	data[ei++] =3D mib->tx_bf_ebf_ppdu_cnt;
> =20
>  	/* Tx Beamformer Rx feedback monitor */
> -	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
> +	data[ei++] =3D mib->tx_bf_rx_fb_all_cnt;
> +	data[ei++] =3D mib->tx_bf_rx_fb_he_cnt;
> +	data[ei++] =3D mib->tx_bf_rx_fb_vht_cnt;
> +	data[ei++] =3D mib->tx_bf_rx_fb_ht_cnt;
> =20
> -	cnt =3D mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
> +	data[ei++] =3D mib->tx_bf_rx_fb_bw;
> +	data[ei++] =3D mib->tx_bf_rx_fb_nc_cnt;
> +	data[ei++] =3D mib->tx_bf_rx_fb_nr_cnt;
> =20
>  	/* Tx Beamformee Rx NDPA & Tx feedback report */
> -	cnt =3D mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
> -	data[ei++] =3D FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
> -	data[ei++] =3D FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
> +	data[ei++] =3D mib->tx_bf_fb_cpl_cnt;
> +	data[ei++] =3D mib->tx_bf_fb_trig_cnt;
> =20
>  	/* Tx SU & MU counters */
>  	data[ei++] =3D mib->tx_bf_cnt;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 26f2befc46dd..565766debb5e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -110,6 +110,7 @@ struct mt7915_vif {
>  	struct cfg80211_bitrate_mask bitrate_mask;
>  };
> =20
> +/* per-phy stats.  */
>  struct mib_stats {
>  	u32 ack_fail_cnt;
>  	u32 fcs_err_cnt;
> @@ -120,6 +121,20 @@ struct mib_stats {
>  	u32 tx_mu_mpdu_cnt;
>  	u32 tx_mu_acked_mpdu_cnt;
>  	u32 tx_su_acked_mpdu_cnt;
> +	u32 tx_bf_ibf_ppdu_cnt;
> +	u32 tx_bf_ebf_ppdu_cnt;
> +
> +	u32 tx_bf_rx_fb_all_cnt;
> +	u32 tx_bf_rx_fb_he_cnt;
> +	u32 tx_bf_rx_fb_vht_cnt;
> +	u32 tx_bf_rx_fb_ht_cnt;
> +
> +	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
> +	u32 tx_bf_rx_fb_nc_cnt;
> +	u32 tx_bf_rx_fb_nr_cnt;
> +	u32 tx_bf_fb_cpl_cnt;
> +	u32 tx_bf_fb_trig_cnt;
> +
>  	/* Add more stats here, updated from mac_update_stats */
>  };
> =20
> --=20
> 2.20.1
>=20

--vGbDacECVhjv4wkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPwKOQAKCRA6cBh0uS2t
rA5IAPsEY4QiSvwLHQFUVufZT3HzSMxQJ9uzZ3yXy/ygK1kcfQD+MR2JQDv/WthG
PvZB6dywdUZfNF4poGkz0UdlL7zxZgM=
=IXm+
-----END PGP SIGNATURE-----

--vGbDacECVhjv4wkR--
