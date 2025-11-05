Return-Path: <linux-wireless+bounces-28575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5DC351C3
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F471921BC8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A572DC357;
	Wed,  5 Nov 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC8KeN5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD421CC58
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338873; cv=none; b=NBbJSoyWPzTK9EibOqVotIgxOUVIWx+Erp3/nl9JG1pNPD4fJYEEqVA7oZxqPrgULChsHnTwBnVE0B4O+KUi1dO+rulR7ixLFDEA7a/BWM/sUibzW4r6EO2qum/svrwwFY0oqGgT5A69/MZBHHB1zyrsM5AMLFHh6jEGGK+PzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338873; c=relaxed/simple;
	bh=7M6VcrEqiYPtG2L5zPKT6mpfPr0tZ/1taK7lowEDtEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHxhJQcDS6yBVvhNqxsYALGi0matcTcISd5ACNGq/TL+h7bPO6ju5w/SiDIFn+0NizNMilGv+0mrBP9akxP4r5HxMCUrO91B25LuSfVWZ0sIdqQoi1fx4IR5gtVzCkrjindrzzkWsKG2/yC/Ig6zj+VR5Mq4cNBZB2dDZkQWU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC8KeN5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CCAC4CEF8;
	Wed,  5 Nov 2025 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338873;
	bh=7M6VcrEqiYPtG2L5zPKT6mpfPr0tZ/1taK7lowEDtEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gC8KeN5hDazoYpznjOthchMpRshLm33GI+zmO4TntJth3YRRAv1y2Dw+H3Mk6hDRA
	 vfl0Q1arZY85HveBOdzyznAogg+9EkJPenS2BrvUznJsRisH7RpNMUYr9HHMO3O7Lq
	 56w75Nu8vOY9NweEmuqMoESe4p8FN1xwSrKdiuDCRsVFCz1tZ1Q03EZP4Ea/F1QTkg
	 paHkiqmME9MdAdecdVcrdFzAQgB0TuwlQa04Cj8HzfujCvO++9UvvCjI3fUnybMD9q
	 AaD7u1zjBJXi/mmfW8Mud6yGtYoMSoPUvVaonyTUBbFrFblfk0rBi1j377+W2QoarL
	 CI3j6EsctYpVA==
Date: Wed, 5 Nov 2025 11:34:30 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 08/12] wifi: mt76: mt7996: use correct link_id when
 filling TXD and TXP
Message-ID: <aQsoNrzQuUAusnn0@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-8-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xsnqatjje22dZK4d"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-8-shayne.chen@mediatek.com>


--Xsnqatjje22dZK4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Obtain the correct link ID and, if needed, switch to the corresponding
> wcid before populating the TX descriptor and TX payload.
>=20
> Rules for link id:
> - For QoS data from MLD peers (excluding EAPOL), select the primary or
>   secondary wcid based on whether the TID is odd or even to meet FW/HW
>   requirements
> - For other packets, use IEEE80211_TX_CTRL_MLO_LINK if specified
>   (such as multicast and broadcast packets)

Hi Shayne,

thx for the fix. I guess it is mostly fine, just few comments inline. Fixing
them:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 34 ++++++++++++++++---
>  .../net/wireless/mediatek/mt76/mt7996/main.c  |  6 ++++
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  4 +--
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
>  4 files changed, 39 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 7d5f9d9b3b62..579084cbb30f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1035,15 +1035,20 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, =
void *txwi_ptr,
>  			  struct ieee80211_sta *sta,
>  			  struct mt76_tx_info *tx_info)
>  {

[...]

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index c26f8f49ce44..3958688d622b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -963,6 +963,7 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
> =20
>  		msta_link =3D &msta->deflink;
>  		msta->deflink_id =3D link_id;
> +		msta->seclink_id =3D msta->deflink_id;
> =20
>  		for (i =3D 0; i < ARRAY_SIZE(sta->txq); i++) {
>  			struct mt76_txq *mtxq;
> @@ -977,6 +978,11 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
>  		msta_link =3D kzalloc(sizeof(*msta_link), GFP_KERNEL);
>  		if (!msta_link)
>  			return -ENOMEM;
> +
> +		if (msta->seclink_id =3D=3D msta->deflink_id &&
> +		    (sta->valid_links & ~(BIT(msta->deflink_id))))
> +			msta->seclink_id =3D __ffs(sta->valid_links &
> +						 ~(BIT(msta->deflink_id)));
nit: you do need brackets around BIT().

I think we are missing seclink_id management when the corresponding link is
removed, right?

>  	}
> =20
>  	INIT_LIST_HEAD(&msta_link->rc_list);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index f1892aaf6a91..2bb98df317a6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -2394,8 +2394,8 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev=
, struct sk_buff *skb,
>  	mld_setup->primary_id =3D cpu_to_le16(msta_link->wcid.idx);
> =20
>  	if (nlinks > 1) {
> -		link_id =3D __ffs(sta->valid_links & ~BIT(msta->deflink_id));
> -		msta_link =3D mt76_dereference(msta->link[link_id], &dev->mt76);
> +		msta_link =3D mt76_dereference(msta->link[msta->seclink_id],
> +					     &dev->mt76);
>  		if (!msta_link)
>  			return;
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 65eeb37ab8c7..c47820699ec8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -243,6 +243,7 @@ struct mt7996_sta {
>  	struct mt7996_sta_link deflink; /* must be first */
>  	struct mt7996_sta_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
>  	u8 deflink_id;
> +	u8 seclink_id;
> =20
>  	struct mt7996_vif *vif;
>  };
> --=20
> 2.51.0
>=20

--Xsnqatjje22dZK4d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsoNgAKCRA6cBh0uS2t
rGmqAP9hT1ZDbyMLdtgldzY4u5+1U6ruTWkWGxXZCBFbH5kMhwD9G9mjNORiXKzt
fs9pc2dVo5hESQFz2NOFgcj1khsxWwI=
=4v+c
-----END PGP SIGNATURE-----

--Xsnqatjje22dZK4d--

