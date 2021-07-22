Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609413D2F51
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGVVEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 17:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVEx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 17:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6667060C41;
        Thu, 22 Jul 2021 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990327;
        bh=I3UQ6U4CPEVLAOTE3+qKSAalAek3GCxEGL279qLBIXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYJNsLcZykHNGpD+lNjIFej4lK/wmgJIjWvTKQgzfirnzk9DfowcWn/Mm+TemhbK6
         grS9ThudjKNpJj9/fSefoZTHMKqlXMYfkWJWYHWppaY0s7f3PJNlb2RhMTOyozuamZ
         4gtSfYYq3iPRz2PkssUhbkc6Lw9Vyo8cT4xRjidjwjs1cNuGw0ZzS8B++RSTEGOTh1
         VeSY2vN/7iDLyHxRSrWTJDWV+psx9P3i2uaxpja1rNcMU3gM2odmZDh/Ockkm5NpoU
         ot7NsQWofWh9COtXgT4d1rp0la3JVqX1DfJ5o1Ju+nzMy1fJr6bAl5n0oGevBUsdrP
         RQw0btdQJyGeg==
Date:   Thu, 22 Jul 2021 23:45:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/8] mt76 - mt7915: Add tx stats gathered from
 tx-status callbacks.
Message-ID: <YPnm8yRZt9anINhK@lore-desk>
References: <20210722202504.6180-1-greearb@candelatech.com>
 <20210722202504.6180-2-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QkKA+v4JQbsU/Unw"
Content-Disposition: inline
In-Reply-To: <20210722202504.6180-2-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QkKA+v4JQbsU/Unw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> Add tx-mode (ofdma, ht, vht, HE) histogram,
> tx-ru-idx histogram, and tx-bandwidth histogram.
> Also add tx attempts and tx success counters.
>=20
> All of this is per-station.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 32 +++++++++++++------
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    | 14 ++++++++
>  3 files changed, 37 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index b41faedee001..436bf2b8e2cd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -755,6 +755,7 @@ enum mt76_phy_type {
>  	MT_PHY_TYPE_HE_EXT_SU,
>  	MT_PHY_TYPE_HE_TB,
>  	MT_PHY_TYPE_HE_MU,
> +	MT_PHY_TYPE_HE_LAST, /* keep last */
>  };
> =20
>  #define CCK_RATE(_idx, _rate) {					\
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index f1574538315d..3a10e14fbd50 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1304,7 +1304,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct s=
k_buff *skb)
> =20
>  static bool
>  mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, i=
nt pid,
> -		       __le32 *txs_data)
> +		       __le32 *txs_data, struct mt7915_sta_stats *stats)
>  {
>  	struct ieee80211_supported_band *sband;
>  	struct mt76_dev *mdev =3D &dev->mt76;
> @@ -1314,7 +1314,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  	struct rate_info rate =3D {};
>  	struct sk_buff *skb;
>  	bool cck =3D false;
> -	u32 txrate, txs;
> +	u32 txrate, txs, txs5, txs6, txs7, mode;
> =20
>  	mt76_tx_status_lock(mdev, &list);
>  	skb =3D mt76_tx_status_skb_get(mdev, wcid, pid, &list);
> @@ -1322,6 +1322,9 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  		goto out;
> =20
>  	txs =3D le32_to_cpu(txs_data[0]);
> +	txs5 =3D le32_to_cpu(txs_data[5]);
> +	txs6 =3D le32_to_cpu(txs_data[6]);
> +	txs7 =3D le32_to_cpu(txs_data[7]);
> =20
>  	info =3D IEEE80211_SKB_CB(skb);
>  	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
> @@ -1333,15 +1336,20 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, st=
ruct mt76_wcid *wcid, int pid,
> =20
>  	info->status.rates[0].idx =3D -1;
> =20
> -	if (!wcid->sta)
> -		goto out;
> +	stats->tx_mpdu_attempts +=3D FIELD_GET(MT_TXS5_F1_MPDU_TX_COUNT, txs5);
> +	stats->tx_mpdu_fail +=3D FIELD_GET(MT_TXS6_F1_MPDU_FAIL_COUNT, txs6);
> +	stats->tx_mpdu_retry +=3D FIELD_GET(MT_TXS7_F1_MPDU_RETRY_COUNT, txs7);
> =20
>  	txrate =3D FIELD_GET(MT_TXS0_TX_RATE, txs);
> =20
>  	rate.mcs =3D FIELD_GET(MT_TX_RATE_IDX, txrate);
>  	rate.nss =3D FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
> =20
> -	switch (FIELD_GET(MT_TX_RATE_MODE, txrate)) {
> +	stats->tx_nss[rate.nss - 1]++;
> +	stats->tx_mcs[rate.mcs]++;

here, with the patch below, we can have a oob access in tx_mcs array

https://patchwork.kernel.org/project/linux-wireless/patch/20210720130014.23=
572-2-shayne.chen@mediatek.com/

> +
> +	mode =3D FIELD_GET(MT_TX_RATE_MODE, txrate);
> +	switch (mode) {
>  	case MT_PHY_TYPE_CCK:
>  		cck =3D true;
>  		fallthrough;
> @@ -1389,18 +1397,24 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, st=
ruct mt76_wcid *wcid, int pid,
>  		goto out;
>  	}
> =20
> +	stats->tx_mode[mode]++;
> +
>  	switch (FIELD_GET(MT_TXS0_BW, txs)) {
>  	case IEEE80211_STA_RX_BW_160:
>  		rate.bw =3D RATE_INFO_BW_160;
> +		stats->tx_bw[3]++;
>  		break;
>  	case IEEE80211_STA_RX_BW_80:
>  		rate.bw =3D RATE_INFO_BW_80;
> +		stats->tx_bw[2]++;
>  		break;
>  	case IEEE80211_STA_RX_BW_40:
>  		rate.bw =3D RATE_INFO_BW_40;
> +		stats->tx_bw[1]++;
>  		break;
>  	default:
>  		rate.bw =3D RATE_INFO_BW_20;
> +		stats->tx_bw[0]++;
>  		break;
>  	}
>  	wcid->rate =3D rate;
> @@ -1440,15 +1454,13 @@ static void mt7915_mac_add_txs(struct mt7915_dev =
*dev, void *data)
>  	rcu_read_lock();
> =20
>  	wcid =3D rcu_dereference(dev->mt76.wcid[wcidx]);
> -	if (!wcid)
> +	if (!wcid || !wcid->sta)
>  		goto out;
> =20
> -	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data);
> +	msta =3D container_of(wcid, struct mt7915_sta, wcid);
> =20
> -	if (!wcid->sta)
> -		goto out;
> +	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);

it seems to me here we are changing the behaviour since
mt7915_mac_add_txs_skb() is run even with wcid->sta =3D false

Regards,
Lorenzo

> =20
> -	msta =3D container_of(wcid, struct mt7915_sta, wcid);
>  	spin_lock_bh(&dev->sta_poll_lock);
>  	if (list_empty(&msta->poll_list))
>  		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index a3c78365db23..ff944d1cf527 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -64,6 +64,16 @@ enum mt7915_rxq_id {
>  	MT7915_RXQ_MCU_WA_EXT,
>  };
> =20
> +struct mt7915_sta_stats {
> +	unsigned long tx_mpdu_attempts;
> +	unsigned long tx_mpdu_fail;
> +	unsigned long tx_mpdu_retry;
> +	unsigned long tx_mode[MT_PHY_TYPE_HE_LAST]; /* See mt76_phy_type */
> +	unsigned long tx_bw[4]; /* 20, 40, 80, 160 */
> +	unsigned long tx_nss[4]; /* 1, 2, 3, 4 */
> +	unsigned long tx_mcs[16]; /* mcs idx */
> +};
> +
>  struct mt7915_sta_key_conf {
>  	s8 keyidx;
>  	u8 key[16];
> @@ -82,8 +92,11 @@ struct mt7915_sta {
>  	unsigned long jiffies;
>  	unsigned long ampdu_state;
> =20
> +	struct mt7915_sta_stats stats;
> +
>  	struct mt7915_sta_key_conf bip;
>  };
> +
>  struct mt7915_vif {
>  	u16 idx;
>  	u8 omac_idx;
> @@ -103,6 +116,7 @@ struct mib_stats {
>  	u32 rts_cnt;
>  	u32 rts_retries_cnt;
>  	u32 ba_miss_cnt;
> +	/* Add more stats here, updated from mac_update_stats */
>  };
> =20
>  struct mt7915_hif {
> --=20
> 2.20.1
>=20

--QkKA+v4JQbsU/Unw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPnm8AAKCRA6cBh0uS2t
rPFjAQD1tfEC9j7Y4yyGSgDlM578FHPvQ54LWEgHxDcVVqK9vAEAlmUa+vtE88gW
J/JOVaNvokP9x2Ae8aw0Ast7yX8VJgI=
=vqzp
-----END PGP SIGNATURE-----

--QkKA+v4JQbsU/Unw--
