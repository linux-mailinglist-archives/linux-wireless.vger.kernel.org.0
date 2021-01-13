Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF392F4C0D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 14:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhAMNJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 08:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbhAMNJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610543299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibT6pwlsUyapZ6dqNBnG2IIiRlRe0J3FzEu7eLv3IhU=;
        b=ch/KnhPvlkk6DSt+m5cTcAteA5eA4I74nKSFW8AfqBirJtTq7bRKaN0pz8yuIqdo0G/owj
        4zxDq1ylcQeP+THcMLCgyMJCcZi+ZDVFTFHiZPN5cvLyqyAue+44VFkVTvmLrxoBjldCGl
        hUJjEZ5MfcqCs6BzCRu4v1Db3fbP738=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-72bUHp5uOHetXCyFfxonyw-1; Wed, 13 Jan 2021 08:08:16 -0500
X-MC-Unique: 72bUHp5uOHetXCyFfxonyw-1
Received: by mail-wm1-f72.google.com with SMTP id 14so290544wmo.8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jan 2021 05:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibT6pwlsUyapZ6dqNBnG2IIiRlRe0J3FzEu7eLv3IhU=;
        b=sPW3pWdpXgS9O3DYLURIAI0hCnyf6qc4oMalXmPZ2kvdtNQXXDwv+g44NqsvXMqcd+
         QrpaSu0/TAnzjzSZJ2RY73BVzqYNH6lcj6AmvxkxBx3BxKGhyVjtguUuOxRyJgT+4dgp
         OL9rfqTMnaf8QrRGBrabTWkReQy0qe/z0bHDe1OSE31xUTZ5c5iQx9zv+ctbkucYUkQY
         229bqb/1mgy3lNNc3GmcNBgrtQvVtfB0rW+brLhUQFepyjjEVE/vp/jJB6zQ1Tk4EErO
         URFvKbIo9YOvGQ/N/D5WgYqbXahbvjNICuteV4CUPNne5479w5f4r4b6nS+rT8BCD6eO
         FBVA==
X-Gm-Message-State: AOAM531wietrO9Ya6dpSwXEvFDJL10eSeOGsfgAf+9NFFGf1ZDqBNZ31
        +o0orOW0nm6Ol8IsaBV/LfTEwG4Ld/i1wc9zltJ6Zz+pkL5anpBMKntdnZCC+AbU5F3GNnWlU1R
        NSfPtdpQnX2GrmHzBfJE1j/C8UXc=
X-Received: by 2002:a5d:5917:: with SMTP id v23mr2660462wrd.308.1610543294949;
        Wed, 13 Jan 2021 05:08:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcoyULwtxdbEK+dbA10k9oF8zoBvFpcFi32V+g8q8u4j/ybk7G0aerZXf4A82n1iOyaWozgQ==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr2660447wrd.308.1610543294765;
        Wed, 13 Jan 2021 05:08:14 -0800 (PST)
Received: from localhost ([151.66.42.92])
        by smtp.gmail.com with ESMTPSA id u83sm3009401wmu.12.2021.01.13.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:08:13 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:08:10 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7915: simplify peer's TxBF capability check
Message-ID: <20210113130810.GA5528@lore-desk>
References: <287bbdb0193bd74069219b97199ba4ec72127bd8.1610539467.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <287bbdb0193bd74069219b97199ba4ec72127bd8.1610539467.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is a preliminary patch for implicit beamforming support.
>=20

Hi Ryber,

just few nitpicks inline.

Regards,
Lorenzo

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 50 +++++++------------
>  1 file changed, 17 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 0baef70fc522..f38bc421ea8e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -66,9 +66,6 @@ struct mt7915_fw_region {
> =20
>  #define MCU_PATCH_ADDRESS		0x200000
> =20
> -#define MT_STA_BFER			BIT(0)
> -#define MT_STA_BFEE			BIT(1)
> -
>  #define FW_FEATURE_SET_ENCRYPT		BIT(0)
>  #define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
>  #define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
> @@ -1948,16 +1945,23 @@ mt7915_mcu_sta_bfee_tlv(struct sk_buff *skb, stru=
ct ieee80211_sta *sta,
>  		bfee->fb_identity_matrix =3D true;
>  }
> =20
> -static u8
> -mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, struct ieee80211_vif *v=
if,
> -			 struct ieee80211_sta *sta)
> +static int
> +mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
> +		    struct ieee80211_sta *sta, bool enable)
>  {
> -	u8 type =3D 0;
> +	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
> +	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +	struct mt7915_phy *phy;
> +	struct sk_buff *skb;
> +	int r, len;
> +	bool ebfee =3D 0, ebf =3D 0;
> =20
>  	if (vif->type !=3D NL80211_IFTYPE_STATION &&
>  	    vif->type !=3D NL80211_IFTYPE_AP)
>  		return 0;
> =20
> +	phy =3D mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
> +
>  	if (sta->he_cap.has_he) {
>  		struct ieee80211_he_cap_elem *pe;
>  		const struct ieee80211_he_cap_elem *ve;
> @@ -1970,12 +1974,12 @@ mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, =
struct ieee80211_vif *vif,
>  		if ((HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]) ||
>  		     HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4])) &&
>  		    HE_PHY(CAP4_SU_BEAMFORMEE, ve->phy_cap_info[4]))
> -			type |=3D MT_STA_BFEE;
> +			ebfee =3D true;
> =20
>  		if ((HE_PHY(CAP3_SU_BEAMFORMER, ve->phy_cap_info[3]) ||
>  		     HE_PHY(CAP4_MU_BEAMFORMER, ve->phy_cap_info[4])) &&
>  		    HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]))
> -			type |=3D MT_STA_BFER;
> +			ebf =3D true;
>  	} else if (sta->vht_cap.vht_supported) {
>  		struct ieee80211_sta_vht_cap *pc;
>  		struct ieee80211_sta_vht_cap *vc;
> @@ -1989,36 +1993,16 @@ mt7915_mcu_sta_txbf_type(struct mt7915_phy *phy, =
struct ieee80211_vif *vif,
>  		     IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
> =20
>  		if ((pc->cap & cr) && (vc->cap & ce))
> -			type |=3D MT_STA_BFEE;
> +			ebfee =3D true;

what about:
		ebfee =3D !!((pc->cap & cr) && (vc->cap & ce))

> =20
>  		if ((vc->cap & cr) && (pc->cap & ce))
> -			type |=3D MT_STA_BFER;
> -	} else if (sta->ht_cap.ht_supported) {
> -		/* TODO: iBF */
> +			ebf =3D true;

		ebfee =3D !!((vc->cap & cr) && (pc->cap & ce))
>  	}
> =20
> -	return type;
> -}
> -
> -static int
> -mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
> -		    struct ieee80211_sta *sta, bool enable)
> -{
> -	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
> -	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> -	struct mt7915_phy *phy;
> -	struct sk_buff *skb;
> -	int r, len;
> -	u8 type;
> -
> -	phy =3D mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
> -
> -	type =3D mt7915_mcu_sta_txbf_type(phy, vif, sta);
> -
>  	/* must keep each tag independent */
> =20
>  	/* starec bf */
> -	if (type & MT_STA_BFER) {
> +	if (ebf) {
>  		len =3D sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
> =20
>  		skb =3D mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
> @@ -2034,7 +2018,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct =
ieee80211_vif *vif,
>  	}
> =20
>  	/* starec bfee */
> -	if (type & MT_STA_BFEE) {
> +	if (ebfee) {
>  		len =3D sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bfee);
> =20
>  		skb =3D mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
> --=20
> 2.18.0
>=20

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX/7wuAAKCRA6cBh0uS2t
rG5UAQDzdZn08mrPnGeKlMsexdSLFqvhSnaygitAkF+1mW5jiQD9HKymQFg0JQK2
qx8DbwSzKMbQoZ3T3bqT1ZjBJzrL/AU=
=BaKt
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

