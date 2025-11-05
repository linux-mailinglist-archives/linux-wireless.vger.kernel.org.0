Return-Path: <linux-wireless+bounces-28572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4DC3506C
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A08E034DD41
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2022BF3E2;
	Wed,  5 Nov 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAU1MxdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8E2BE7C3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337083; cv=none; b=a1U56KRldn3XqPisYMvFfp6xuL1GgX3nRIp5OIV6sZKLCQzbpR+xMf5A6l7VSu/XN4bVDwppA5u3tkJhbJEgHy62EZel3uZ5Lp5umFZrLiTKzX22D/nZT17QSbXMscjt4Xh130NHKN7ZBmKTrJmtR71vo5v+OW9X557LJ60Wk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337083; c=relaxed/simple;
	bh=Ka8z3Hv/2rtt+qWKWxn11yRa+1TDqPq3B0nEETFhsVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK3MG/hVqtPlig6wcFAVDFUVo/AWF2u5ADza+A5vSMCPytiiMIC1j1oaZKzRzfbj8zyaCRsmoZXxRGSIfZilaPKWy1rJ0zw4i6CkK00SCi7UcWky7MG7K3GBn6SHf7ZFTwe32cZ5NkQxyOxMc3WVRTZp4OXZPcQy8KWqeS4oQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAU1MxdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693CBC4CEFB;
	Wed,  5 Nov 2025 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337082;
	bh=Ka8z3Hv/2rtt+qWKWxn11yRa+1TDqPq3B0nEETFhsVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAU1MxdUVi00nZHBno4TzKdnVU6X0EE4ExkUMqDUj6p+UEx7YPPAM7kd3tAA6/Fyy
	 0s3LWdVLi7mjf2X4FlISyVkAg+OzPB2YdEvSE5zqyR6LCxLHsLam9b3+bmisZSOzDo
	 WQCIMiJUlSaPsr6WwGsnomYwd6GJ2RaY7h1AxBMM9wPHOxZw4cMROTt3RkWff8uKwB
	 3/2YnUw1ozjbd0Gk0MCmxfLCJ9gHfsWXHpNoYFBamiEyPrOuFMW+ak+jBczTPgItnE
	 lGyk3ONkXcQepmzCUJRWOUoWQnG9opaJ4xcBXCdWAjD+DfsdBlWaJRNxPgujYt2zZM
	 OYzQoMmpRuVtw==
Date: Wed, 5 Nov 2025 11:04:40 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 05/12] wifi: mt76: mt7996: fix several fields in
 mt7996_mcu_bss_basic_tlv()
Message-ID: <aQshODZaMJSUoWPd@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-5-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BZxWA+vEG1kVrO84"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-5-shayne.chen@mediatek.com>


--BZxWA+vEG1kVrO84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix several fields in mt7996_mcu_bss_basic_tlv() that were not obtained
> from the correct link. Without this patch, the MLD station interface
> does not function properly.
>=20
> Fixes: 34a41bfbcb71 ("wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_=
info for MLO support")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 82dd34a8780f..f1892aaf6a91 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -1037,7 +1037,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
>  	struct mt76_connac_bss_basic_tlv *bss;
>  	u32 type =3D CONNECTION_INFRA_AP;
>  	u16 sta_wlan_idx =3D wlan_idx;
> -	struct ieee80211_sta *sta;
>  	struct tlv *tlv;
>  	int idx;
> =20
> @@ -1048,14 +1047,18 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
>  		break;
>  	case NL80211_IFTYPE_STATION:
>  		if (enable) {
> +			struct ieee80211_sta *sta;
> +
>  			rcu_read_lock();
> -			sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> -			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
> +			sta =3D ieee80211_find_sta(vif, link_conf->bssid);
>  			if (sta) {
> -				struct mt76_wcid *wcid;
> +				struct mt7996_sta *msta =3D (void *)sta->drv_priv;
> +				struct mt7996_sta_link *msta_link;
> +				int link_id =3D link_conf->link_id;
> =20
> -				wcid =3D (struct mt76_wcid *)sta->drv_priv;
> -				sta_wlan_idx =3D wcid->idx;
> +				msta_link =3D rcu_dereference(msta->link[link_id]);
> +				if (msta_link)
> +					sta_wlan_idx =3D msta_link->wcid.idx;
>  			}
>  			rcu_read_unlock();
>  		}
> @@ -1072,8 +1075,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
>  	tlv =3D mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*bss));
> =20
>  	bss =3D (struct mt76_connac_bss_basic_tlv *)tlv;
> -	bss->bcn_interval =3D cpu_to_le16(link_conf->beacon_int);
> -	bss->dtim_period =3D link_conf->dtim_period;
>  	bss->bmc_tx_wlan_idx =3D cpu_to_le16(wlan_idx);
>  	bss->sta_idx =3D cpu_to_le16(sta_wlan_idx);
>  	bss->conn_type =3D cpu_to_le32(type);
> @@ -1093,10 +1094,10 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
> =20
>  	memcpy(bss->bssid, link_conf->bssid, ETH_ALEN);
>  	bss->bcn_interval =3D cpu_to_le16(link_conf->beacon_int);
> -	bss->dtim_period =3D vif->bss_conf.dtim_period;
> +	bss->dtim_period =3D link_conf->dtim_period;
>  	bss->phymode =3D mt76_connac_get_phy_mode(phy, vif,
>  						chandef->chan->band, NULL);
> -	bss->phymode_ext =3D mt76_connac_get_phy_mode_ext(phy, &vif->bss_conf,
> +	bss->phymode_ext =3D mt76_connac_get_phy_mode_ext(phy, link_conf,
>  							chandef->chan->band);
> =20
>  	return 0;
> --=20
> 2.51.0
>=20

--BZxWA+vEG1kVrO84
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQshOAAKCRA6cBh0uS2t
rM0dAQDXpwmIF/R2OQWLsGxTyuO0LQdf0mqBlkF8/8nFgog6WwEA3JI0fxX+dabP
sFyqJrhqUzOZjcPS9mZuEVqJri+F4AM=
=YTxf
-----END PGP SIGNATURE-----

--BZxWA+vEG1kVrO84--

