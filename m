Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA592F4C10
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 14:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAMNLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 08:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbhAMNLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 08:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610543427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgKl9nCaXs5mu0WD1FNtbmTmmv7VZTSRgUqyEAJfU9g=;
        b=SQfjkccUBvUjLJVQ4h62XAIHuajkmUyiwoO0hpoCesidbqCC9yvGRLw0RoQXAr62P/pnTI
        1qO1HOjgZnJBhzQZuvDo5/KOWVW1KURgzhK0WXeM9Dts8sRZaJDi3lx52V6EMmD3an1vmO
        mBV/bd+Msb2h3nXIQHT71x4SGnXq1QQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-emQY_3CbPwuEwQDPrhb3jA-1; Wed, 13 Jan 2021 08:10:23 -0500
X-MC-Unique: emQY_3CbPwuEwQDPrhb3jA-1
Received: by mail-wr1-f70.google.com with SMTP id j5so940217wro.12
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jan 2021 05:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgKl9nCaXs5mu0WD1FNtbmTmmv7VZTSRgUqyEAJfU9g=;
        b=EHTP/1185EvJJ/csFNU7utLTuqTubMCsUAKNu4Tqlzqbm/CfddJ5EM9ibKz/f+V7cK
         KekPDiqb/45sdkZMkWJapesH74ZiKiuHkqZqYrpYcm+HMM5ZnG5T0UwKBLoC3AYdoM66
         vCd8nbLx18ODxpArbNU9XjQXsMzE2mkmh3npwWLv01r0mTae+qNmXEwhIwsWWdo9jPjV
         18lgBbb0hT5xVY5L/rwBZvR5MhNVFf9IOj4HHtKlTvAI2D2TjENzwjpIc5Kr0EQHHBXv
         DuzQEz8FEI05nYwNL7ZK+M5iWztBEn1tcjnplcF0LnMbJh08q9E40v0gj1hyx8pFjotC
         dWyw==
X-Gm-Message-State: AOAM530ipyrXvHEnKi7miM62gOr+5zQn7pwybKVjp78bfKHpiIXrudt9
        nSMDI6tLbcraNjfR3X02ocX2uKstpJtk/QU3bwfxyPY6tW49ex/deVqThiA0/7GMYdTv2XimTNI
        zdWbe7EqDxyTcbs9W4mrnpet4jk8=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr2625447wrv.92.1610543421843;
        Wed, 13 Jan 2021 05:10:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2QRuut/D/nE4xQvkKPe5sq8qbrjcCeoqEDVcubkyJ4eCuuVXqLpd+RJwZnmRsVRWi+JUGww==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr2625433wrv.92.1610543421674;
        Wed, 13 Jan 2021 05:10:21 -0800 (PST)
Received: from localhost ([151.66.42.92])
        by smtp.gmail.com with ESMTPSA id b132sm3071303wmh.21.2021.01.13.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:10:21 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:10:18 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7915: add implicit Tx beamforming support
Message-ID: <20210113131018.GB5528@lore-desk>
References: <287bbdb0193bd74069219b97199ba4ec72127bd8.1610539467.git.ryder.lee@mediatek.com>
 <8663392490d6b0552aaf0b5b7a8eb36ff38c8bba.1610539467.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <8663392490d6b0552aaf0b5b7a8eb36ff38c8bba.1610539467.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add ht/vht implicit Tx beamforming support and enable it via debugfs.
>=20
> Tested-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   |  28 +++++
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |   8 +-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 104 ++++++++++--------
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 +
>  4 files changed, 89 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 7d810fbf2862..340d489993bb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -6,6 +6,32 @@
> =20
>  /** global debugfs **/
> =20
> +static int
> +mt7915_implicit_txbf_set(void *data, u64 val)
> +{
> +	struct mt7915_dev *dev =3D data;
> +
> +	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
> +		return 0;

Maybe return -EBUSY here?

> +
> +	dev->ibf =3D !!val;
> +
> +	return mt7915_mcu_set_txbf_type(dev);
> +}
> +
> +static int
> +mt7915_implicit_txbf_get(void *data, u64 *val)
> +{
> +	struct mt7915_dev *dev =3D data;
> +
> +	*val =3D dev->ibf;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
> +			 mt7915_implicit_txbf_set, "%lld\n");
> +
>  /* test knob of system layer 1/2 error recovery */
>  static int mt7915_ser_trigger_set(void *data, u64 val)
>  {
> @@ -355,6 +381,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
>  				    mt7915_queues_acq);
>  	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
>  	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
> +	debugfs_create_file("implicit_txbf", 0600, dir, dev,
> +			    &fops_implicit_txbf);
>  	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
>  	/* test knobs */
>  	debugfs_create_file("radar_trigger", 0200, dir, dev,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index 255ccd7e3d27..cb501c5dc1cc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -169,18 +169,12 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
>  {
>  	int ret;
> =20
> -	/*
> -	 * TODO: DBDC & check whether iBF phase calibration data has
> -	 * been stored in eeprom offset 0x651~0x7b8, then write down
> -	 * 0x1111 into 0x651 and 0x651 to trigger iBF.
> -	 */
> -
>  	/* trigger sounding packets */
>  	ret =3D mt7915_mcu_set_txbf_sounding(dev);
>  	if (ret)
>  		return ret;
> =20
> -	/* enable iBF & eBF */
> +	/* enable eBF */
>  	return mt7915_mcu_set_txbf_type(dev);
>  }
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index f38bc421ea8e..2ac780bc2696 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -1736,13 +1736,14 @@ mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *b=
f)
>  }
> =20
>  static void
> -mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct sta_rec_bf *bf)
> +mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
> +		       struct sta_rec_bf *bf)
>  {
>  	struct ieee80211_mcs_info *mcs =3D &sta->ht_cap.mcs;
>  	u8 n =3D 0;
> =20
>  	bf->tx_mode =3D MT_PHY_TYPE_HT;
> -	bf->bf_cap |=3D MT_IBF;
> +	bf->bf_cap =3D MT_IBF;
> =20
>  	if (mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF &&
>  	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
> @@ -1755,8 +1756,9 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, s=
truct sta_rec_bf *bf)
>  	else if (mcs->rx_mask[1])
>  		n =3D 1;
> =20
> +	bf->nr =3D hweight8(phy->chainmask) - 1;
>  	bf->nc =3D min_t(u8, bf->nr, n);
> -	bf->ibf_ncol =3D bf->nc;
> +	bf->ibf_ncol =3D n;
> =20
>  	if (sta->bandwidth <=3D IEEE80211_STA_RX_BW_40 && !bf->nc)
>  		bf->ibf_timeout =3D 0x48;
> @@ -1764,34 +1766,46 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta,=
 struct sta_rec_bf *bf)
> =20
>  static void
>  mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *ph=
y,
> -			struct sta_rec_bf *bf)
> +			struct sta_rec_bf *bf, bool explicit)
>  {
>  	struct ieee80211_sta_vht_cap *pc =3D &sta->vht_cap;
>  	struct ieee80211_sta_vht_cap *vc =3D &phy->mt76->sband_5g.sband.vht_cap;
> -	u8 bfee_nr, bfer_nr, n, tx_ant =3D hweight8(phy->chainmask) - 1;
> -	u16 mcs_map;
> +	u16 mcs_map =3D le16_to_cpu(pc->vht_mcs.rx_mcs_map);
> +	u8 nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
> +	u8 tx_ant =3D hweight8(phy->chainmask) - 1;
> =20
>  	bf->tx_mode =3D MT_PHY_TYPE_VHT;
> -	bf->bf_cap |=3D MT_EBF;
> =20
> -	mt7915_mcu_sta_sounding_rate(bf);
> +	if (explicit) {
> +		u8 n, bfee_nr, bfer_nr;
> =20
> -	bfee_nr =3D FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
> -			    pc->cap);
> -	bfer_nr =3D FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
> -			    vc->cap);
> -	mcs_map =3D le16_to_cpu(pc->vht_mcs.rx_mcs_map);
> +		bf->bf_cap =3D MT_EBF;
> =20
> -	n =3D min_t(u8, bfer_nr, bfee_nr);
> -	bf->nr =3D min_t(u8, n, tx_ant);
> -	n =3D mt7915_mcu_get_sta_nss(mcs_map);
> +		mt7915_mcu_sta_sounding_rate(bf);
> =20
> -	bf->nc =3D min_t(u8, n, bf->nr);
> -	bf->ibf_ncol =3D bf->nc;
> +		bfee_nr =3D FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
> +				    pc->cap);
> +		bfer_nr =3D FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
> +				    vc->cap);
> +		n =3D min_t(u8, bfer_nr, bfee_nr);
> +		bf->nr =3D min_t(u8, n, tx_ant);
> +		bf->nc =3D min_t(u8, nss_mcs, bf->nr);
> +		bf->ibf_ncol =3D bf->nc;
> +
> +		if (sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160)
> +			bf->nr =3D 1;
> +	} else {
> +		bf->bf_cap =3D MT_IBF;
> +		bf->nr =3D tx_ant;
> +		bf->nc =3D min_t(u8, nss_mcs, bf->nr);
> +		bf->ibf_ncol =3D nss_mcs;
> +
> +		if (sta->bandwidth <=3D IEEE80211_STA_RX_BW_40 && !bf->nc)
> +			bf->ibf_timeout =3D 0x48;
> =20
> -	/* force nr from 4 to 2 */
> -	if (sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160)
> -		bf->nr =3D 1;
> +		if (sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160)
> +			bf->ibf_nrow =3D 1;
> +	}
>  }
> =20
>  static void
> @@ -1800,16 +1814,14 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta,=
 struct ieee80211_vif *vif,
>  {
>  	struct ieee80211_sta_he_cap *pc =3D &sta->he_cap;
>  	struct ieee80211_he_cap_elem *pe =3D &pc->he_cap_elem;
> -	const struct ieee80211_he_cap_elem *ve;
> -	const struct ieee80211_sta_he_cap *vc;
> -	u8 bfee_nr, bfer_nr, nss_mcs;
> -	u16 mcs_map;
> -
> -	vc =3D mt7915_get_he_phy_cap(phy, vif);
> -	ve =3D &vc->he_cap_elem;
> +	const struct ieee80211_sta_he_cap *vc =3D mt7915_get_he_phy_cap(phy, vi=
f);
> +	const struct ieee80211_he_cap_elem *ve =3D &vc->he_cap_elem;
> +	u16 mcs_map =3D le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
> +	u8 nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
> +	u8 bfee_nr, bfer_nr;
> =20
>  	bf->tx_mode =3D MT_PHY_TYPE_HE_SU;
> -	bf->bf_cap |=3D MT_EBF;
> +	bf->bf_cap =3D MT_EBF;
> =20
>  	mt7915_mcu_sta_sounding_rate(bf);
> =20
> @@ -1821,10 +1833,6 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, =
struct ieee80211_vif *vif,
>  			 ve->phy_cap_info[5]);
>  	bfee_nr =3D HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
>  			 pe->phy_cap_info[4]);
> -
> -	mcs_map =3D le16_to_cpu(pc->he_mcs_nss_supp.tx_mcs_80);
> -	nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
> -
>  	bf->nr =3D min_t(u8, bfer_nr, bfee_nr);
>  	bf->nc =3D min_t(u8, nss_mcs, bf->nr);
>  	bf->ibf_ncol =3D bf->nc;
> @@ -1863,7 +1871,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, s=
truct ieee80211_vif *vif,
>  static void
>  mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
>  			struct ieee80211_vif *vif, struct mt7915_phy *phy,
> -			bool enable)
> +			bool enable, bool explicit)
>  {
>  	struct sta_rec_bf *bf;
>  	struct tlv *tlv;
> @@ -1885,19 +1893,25 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, stru=
ct ieee80211_sta *sta,
>  		return;
>  	}
> =20
> -	bf->bw =3D sta->bandwidth;
> -	bf->ibf_dbw =3D sta->bandwidth;
> -	bf->ibf_nrow =3D tx_ant;
> -	bf->ibf_timeout =3D 0x18;
> -
> +	/* he: eBF only, in accordance with spec
> +	 * vht: support eBF and iBF
> +	 * ht: iBF only, since mac80211 lacks of eBF support
> +	 */
>  	if (sta->he_cap.has_he)
>  		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
>  	else if (sta->vht_cap.vht_supported)
> -		mt7915_mcu_sta_bfer_vht(sta, phy, bf);
> +		mt7915_mcu_sta_bfer_vht(sta, phy, bf, explicit);
>  	else if (sta->ht_cap.ht_supported)
> -		mt7915_mcu_sta_bfer_ht(sta, bf);
> +		mt7915_mcu_sta_bfer_ht(sta, phy, bf);
> +	else
> +		return;
> +
> +	bf->bw =3D sta->bandwidth;
> +	bf->ibf_dbw =3D sta->bandwidth;
> +	bf->ibf_nrow =3D tx_ant;
> +	bf->ibf_timeout =3D 0x18;
> =20
> -	if (bf->bf_cap & MT_EBF && bf->nr !=3D tx_ant)
> +	if (explicit && bf->nr !=3D tx_ant)
>  		bf->mem_20m =3D matrix[tx_ant][bf->nc];
>  	else
>  		bf->mem_20m =3D matrix[bf->nr][bf->nc];
> @@ -2002,14 +2016,14 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struc=
t ieee80211_vif *vif,
>  	/* must keep each tag independent */
> =20
>  	/* starec bf */
> -	if (ebf) {
> +	if (ebf || dev->ibf) {
>  		len =3D sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
> =20
>  		skb =3D mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
>  		if (IS_ERR(skb))
>  			return PTR_ERR(skb);
> =20
> -		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable);
> +		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebf);
> =20
>  		r =3D mt76_mcu_skb_send_msg(&dev->mt76, skb,
>  					  MCU_EXT_CMD_STA_REC_UPDATE, true);
> @@ -3442,7 +3456,7 @@ int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
>  	} __packed req =3D {
>  		.action =3D MT_BF_TYPE_UPDATE,
>  		.ebf =3D true,
> -		.ibf =3D false,
> +		.ibf =3D dev->ibf,
>  	};
> =20
>  	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index df7ac2cf052f..63ad1f8199f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -191,6 +191,7 @@ struct mt7915_dev {
>  	bool dbdc_support;
>  	bool flash_mode;
>  	bool fw_debug;
> +	bool ibf;
>  };
> =20
>  enum {
> --=20
> 2.18.0
>=20

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX/7xNwAKCRA6cBh0uS2t
rA/uAQD+SjXzj8iT92THsyBpqkiTAzPIr4A3emVeWZWk2UGz2wD/R3C+j400jXhg
gNeJGNdbeXych02kczZ1zC3O7NIm5As=
=23n3
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

