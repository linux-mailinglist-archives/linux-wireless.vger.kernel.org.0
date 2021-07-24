Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4030D3D47AC
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhGXL7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 07:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhGXL7W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 07:59:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF87660EBA;
        Sat, 24 Jul 2021 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627130394;
        bh=QKc7S/2Gi9Eq/6wGQPrDUaABACoz+UZMA4wdz1aJcxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mC6vlS8A2VrlbQbK3e44QI7JC/H4v1bbpTVmHE6f+Owf4oCTgqWyxwzzO0iI602Jq
         e+BGZOx30VrC9hJhcY46TuE6sS97T6HV/vH+xRR1MApHVSZjyOKRWLPUB4XEamJML2
         GXvJwkhzWfIOox0lZDihHSfdZ9Hv65EwszYHFsX/Kj1FaXB1OSRx5h2JFBEIa77cgE
         XkmjfJIqV6FSnNGuPyHBUjQXhvVGdXZ1TfffqjS5WqBfJOMgkmswJzZg+vZJnfNOGV
         zLReQNSBll+fpGHz05imhu887/5Jb1+pqnFDFo1VVVYQD9UtuXt1XDMRUHyVeXC+xk
         BrqGzgtkCLZtA==
Date:   Sat, 24 Jul 2021 14:39:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 4/8] mt76 - mt7915: Add tx mu/su counters to mib
Message-ID: <YPwKFRDvETI3wyr0@lore-desk>
References: <20210723154627.10078-1-greearb@candelatech.com>
 <20210723154627.10078-4-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttugQ82qeFFboFDl"
Content-Disposition: inline
In-Reply-To: <20210723154627.10078-4-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ttugQ82qeFFboFDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> These counters are clear-on-read, so we need to accumulate
> them in the update_stats poll logic, and read the accumulated
> values instead of directly doing register reads when reporting
> to debugfs and ethtool stats.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/debugfs.c | 17 ++++++++---------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 13 ++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/main.c    | 16 +++++-----------
>  .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |  4 ++++
>  4 files changed, 29 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 1a48b09d0cb7..35248d182728 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -152,6 +152,7 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, str=
uct seq_file *s)
>  		"BW20", "BW40", "BW80", "BW160"
>  	};
>  	int cnt;
> +	struct mib_stats *mib =3D &phy->mib;

according to the check below this can be a NULL pointer dereference

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
> +		   mib->tx_mu_acked_mpdu_cnt);
> +	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
> +		   mib->tx_su_acked_mpdu_cnt);
> =20
>  	seq_puts(s, "\n");
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 6f445999e516..064d754e0565 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1890,10 +1890,21 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
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
> +	mib->tx_mu_acked_mpdu_cnt +=3D cnt;
> +
> +	cnt =3D mt76_rr(dev, MT_MIB_DR11(ext_phy));
> +	mib->tx_su_acked_mpdu_cnt +=3D cnt;
> =20
>  	aggr0 =3D ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
>  	for (i =3D 0, aggr1 =3D aggr0 + 4; i < 4; i++) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index de083008663e..be6444650afe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1131,6 +1131,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
>  	struct mt7915_sta *msta;
>  	struct mt7915_sta_stats *mstats;
>  	bool found_sta =3D false;
> +	struct mib_stats *mib =3D &phy->mib;
> =20
>  	/* See mt7915_ampdu_stat_read_phy, etc */
>  	bool ext_phy =3D phy !=3D &dev->phy;
> @@ -1170,17 +1171,10 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
> +	data[ei++] =3D mib->tx_mu_acked_mpdu_cnt;
> +	data[ei++] =3D mib->tx_su_acked_mpdu_cnt;
> =20
>  	/* TODO:  External phy too?? */
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index a8617ba69a21..26f2befc46dd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -116,6 +116,10 @@ struct mib_stats {
>  	u32 rts_cnt;
>  	u32 rts_retries_cnt;
>  	u32 ba_miss_cnt;
> +	u32 tx_bf_cnt;
> +	u32 tx_mu_mpdu_cnt;
> +	u32 tx_mu_acked_mpdu_cnt;
> +	u32 tx_su_acked_mpdu_cnt;
>  	/* Add more stats here, updated from mac_update_stats */
>  };
> =20
> --=20
> 2.20.1
>=20

--ttugQ82qeFFboFDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYPwKEwAKCRA6cBh0uS2t
rCh7AP9vrerqY29Q+u2FM61nXQvSVe1mANLhX4OltUNXEbQ3vwEA+EZxqJwNi0oU
pnx4pHsEGFhjjPXBvW794Bg5F8z46Q0=
=uTBl
-----END PGP SIGNATURE-----

--ttugQ82qeFFboFDl--
