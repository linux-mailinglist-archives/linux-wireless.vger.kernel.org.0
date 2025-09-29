Return-Path: <linux-wireless+bounces-27707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD4BA934F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85371892506
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DCB67E;
	Mon, 29 Sep 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAbI6utn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39426F443
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149021; cv=none; b=X4DbM9qqTccyGPggc9G6dMIj4dxFk9fPsgsIFaA9vvXAOJVbEZc44ZpiOKqB9iTxtvI3kJz+95ojOLdW6P+2xQ58bLIaBSyalRsm0OZHDwUYR5SjCltn7yVDhNxMMnTNtGA7WctMctTJyX9YXZnkQuGRZ4uL4bS4RwJWwjCbZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149021; c=relaxed/simple;
	bh=LteeNK/Qi4/3VUsKVPKkNMIk3NgIepRJeoPP3Qbt6+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiYF/ZQH/Fs0CL1qGzNo3AoRdbv/GAOcOwimjwu2Jj9P6PWoCj/lYoe4oK9NWi2fgqXOmG9Ti3aQSD+lgGOx4Gvbk3NNs5HutodBCH2jdfg8RRUIUQ8UV8RvWCAZ2udoJczKheQiK4x8SE9jojCiL/hUAz1uMrYb8KXT+BQav14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAbI6utn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0976C4CEF4;
	Mon, 29 Sep 2025 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759149021;
	bh=LteeNK/Qi4/3VUsKVPKkNMIk3NgIepRJeoPP3Qbt6+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAbI6utnxPmm0HELwX5QotVIMsRxaAOUty4dyzTYdClFUT/kfHqs+Y2v23dmnooHV
	 2k0En8p5XNHqUa+DN535tnuvseIot5Z3aLYFrcVURcRIcYNKpAfID9tMZKTqRrEMXq
	 Dzdc3OlB24XCSePyP/TBY5mFuM5CvdYx/UZMcTbiD7IpD/p8Ttlcnk4N/GTHLHT37i
	 fUnOe2kppYe1MtRUYpir5QeILe+MZKV6+J6PZxzqtMHiZVeJpKMSdbSqLSDYu8k033
	 UQApmrcUY36fX8UdqfP0LgVy+Sn4Kr6XbYU7Fnzw7Gce1VGjjC/m33obIewe+yIFFW
	 eGn68W/q8DV4g==
Date: Mon, 29 Sep 2025 14:30:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: fix null pointer deref in
 mt7996_conf_tx()
Message-ID: <aNp72sR-n2qF-g9v@lore-desk>
References: <20250929111723.52486-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Omv+lzBXjGAEfCFx"
Content-Disposition: inline
In-Reply-To: <20250929111723.52486-1-nbd@nbd.name>


--Omv+lzBXjGAEfCFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If a link does not have an assigned channel yet, mt7996_vif_link returns
> NULL. We still need to store the updated queue settings in that case, and
> apply them later.
> Move the location of the queue params to within struct mt7996_vif_link.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: c0df2f0caa8d ("wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for M=
LO support")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 6 +++---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 5 ++++-
>  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 7 ++++++-
>  3 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 581314368c5b..b53ca702591c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -665,8 +665,8 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80=
211_vif *vif,
>  	       unsigned int link_id, u16 queue,
>  	       const struct ieee80211_tx_queue_params *params)
>  {
> -	struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
> -	struct mt7996_vif_link *mlink =3D mt7996_vif_link(dev, vif, link_id);
> +	struct mt7996_vif *mvif =3D (struct mt7996_vif *)vif->drv_priv;
> +	struct mt7996_vif_link_info *link_info =3D &mvif->link_info[link_id];
>  	static const u8 mq_to_aci[] =3D {
>  		[IEEE80211_AC_VO] =3D 3,
>  		[IEEE80211_AC_VI] =3D 2,
> @@ -675,7 +675,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80=
211_vif *vif,
>  	};
> =20
>  	/* firmware uses access class index */
> -	mlink->queue_params[mq_to_aci[queue]] =3D *params;
> +	link_info->queue_params[mq_to_aci[queue]] =3D *params;
>  	/* no need to update right away, we'll get BSS_CHANGED_QOS */
> =20
>  	return 0;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 0347ee0c2dd7..afa6a43bd51e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -3414,6 +3414,9 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struc=
t ieee80211_vif *vif,
>  #define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
>  				 WMM_CW_MAX_SET | WMM_TXOP_SET)
>  	struct mt7996_vif_link *link =3D mt7996_vif_conf_link(dev, vif, link_co=
nf);
> +	struct mt7996_vif *mvif =3D (struct mt7996_vif *)vif->drv_priv;
> +	unsigned int link_id =3D link_conf->link_id;
> +	struct mt7996_vif_link_info *link_info =3D &mvif->link_info[link_id];
>  	struct {
>  		u8 bss_idx;
>  		u8 __rsv[3];
> @@ -3431,7 +3434,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struc=
t ieee80211_vif *vif,
>  	skb_put_data(skb, &hdr, sizeof(hdr));
> =20
>  	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> -		struct ieee80211_tx_queue_params *q =3D &link->queue_params[ac];
> +		struct ieee80211_tx_queue_params *q =3D &link_info->queue_params[ac];
>  		struct edca *e;
>  		struct tlv *tlv;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 8ec2acdb3319..718e4d4ad85f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -253,16 +253,21 @@ struct mt7996_vif_link {
>  	struct mt7996_sta_link msta_link;
>  	struct mt7996_phy *phy;
> =20
> -	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
>  	struct cfg80211_bitrate_mask bitrate_mask;
> =20
>  	u8 mld_idx;
>  };
> =20
> +struct mt7996_vif_link_info {
> +	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
> +};
> +
>  struct mt7996_vif {
>  	struct mt7996_vif_link deflink; /* must be first */
>  	struct mt76_vif_data mt76;
> =20
> +	struct mt7996_vif_link_info link_info[IEEE80211_MLD_MAX_NUM_LINKS];
> +
>  	u8 mld_group_idx;
>  	u8 mld_remap_idx;
>  };
> --=20
> 2.51.0
>=20
>=20

--Omv+lzBXjGAEfCFx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNp72gAKCRA6cBh0uS2t
rG6UAPwLjLD/WfO4E0F+HGJj6Jh/zdbxK26IEW8Znk1OckbGnQD8C9ZE7TQH2dc/
GjS60CqBrKhLmCbRJo5vljs+EWiEvQ4=
=QQHL
-----END PGP SIGNATURE-----

--Omv+lzBXjGAEfCFx--

