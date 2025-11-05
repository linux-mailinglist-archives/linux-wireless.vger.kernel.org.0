Return-Path: <linux-wireless+bounces-28576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD64C35262
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536B74E286C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE8730595B;
	Wed,  5 Nov 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZtdEa+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5530594E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339378; cv=none; b=kaUpfMs4bU2Z1mzK3V5GFH3aZbuqcgOZNleLRcCGtpAEoqeQKYZW/43vEBHsppytSv/8EgjuWMHM02PmuHu9svnEbn0UpNZFBU2xg4OQbIDfteZx3Ioc2H44KEZ+c14wxz5gEJ0hNI7/oj/zLDAfU9Vt7/Mf1ndvRnfQ3Z1UjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339378; c=relaxed/simple;
	bh=JXurM6SDJdEv/wPwhWBHc6NA1gAmG2skecrvqKrQZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIxLaUSP2UVvsORbDCplNrxjfqd/tY5xx/pACfqMIpQVO6gKyFiMLkReRstIR/p6NKcabtRycvgXwM9LYVG8MeCA1V6ZATQtmwr3B0N2rQdfvcWlWmhhX/r01f2U7MB9Rc7ypwaP3S0UnBxI7NkHIY7XU4CDgNuDUlWNPIYH4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZtdEa+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450B1C4CEF8;
	Wed,  5 Nov 2025 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762339377;
	bh=JXurM6SDJdEv/wPwhWBHc6NA1gAmG2skecrvqKrQZmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZtdEa+/iQnoXiizRdGF7MCcmkoGNHZQWk0f4vZFN4iXvwR1a8hxneIaWjZFxRKis
	 8nKUYiqPJ0xmP6QmfZBoF8KO+8XX9D/SCepwx11IcGW5VC5+/w0as7SWYiNzYNtd30
	 u+W/NiHxPEL3ngMWbm4ISvBLLSnLM/a2Pf1YmH+YTwBTnTjC9iBaMcqrwQT0PzgJvz
	 n5HqMXsN2+NVSbUyLudfdODhnSSakz6bHovEBMAyS3mNKU13UJCVN74d+tLpWwfCjB
	 lJKZEjyn929WmBtezC0a+WdVZrjyENfZhaMR4FW1463w1HO94d5HrG3mn3X2MCyHdS
	 34NU5nKhEGZtQ==
Date: Wed, 5 Nov 2025 11:42:55 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 09/12] wifi: mt76: mt7996: fix MLD group index
 assignment
Message-ID: <aQsqLyDjGonv2aip@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-9-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="re+MA/B0pGfjMY3U"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-9-shayne.chen@mediatek.com>


--re+MA/B0pGfjMY3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix extender mode and MBSS issues caused by incorrect assignment of the
> MLD group and remap indices.
>=20
> Fixes: ed01c310eca9 ("wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv rout=
ine")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  .../net/wireless/mediatek/mt76/mt7996/main.c  | 58 +++++++++++++------
>  1 file changed, 40 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 3958688d622b..346d650107d4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -90,9 +90,11 @@ static void mt7996_stop(struct ieee80211_hw *hw, bool =
suspend)
>  {
>  }
> =20
> -static inline int get_free_idx(u32 mask, u8 start, u8 end)
> +static inline int get_free_idx(u64 mask, u8 start, u8 end)
>  {
> -	return ffs(~mask & GENMASK(end, start));
> +	if (~mask & GENMASK_ULL(end, start))
> +		return __ffs64(~mask & GENMASK_ULL(end, start)) + 1;
> +	return 0;
>  }
> =20
>  static int get_omac_idx(enum nl80211_iftype type, u64 mask)
> @@ -308,12 +310,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struc=
t ieee80211_vif *vif,
>  	if (idx < 0)
>  		return -ENOSPC;
> =20
> -	if (!dev->mld_idx_mask) { /* first link in the group */
> -		mvif->mld_group_idx =3D get_own_mld_idx(dev->mld_idx_mask, true);
> -		mvif->mld_remap_idx =3D get_free_idx(dev->mld_remap_idx_mask,
> -						   0, 15);
> -	}
> -
>  	mld_idx =3D get_own_mld_idx(dev->mld_idx_mask, false);
>  	if (mld_idx < 0)
>  		return -ENOSPC;
> @@ -331,10 +327,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struc=
t ieee80211_vif *vif,
>  		return ret;
> =20
>  	dev->mt76.vif_mask |=3D BIT_ULL(mlink->idx);
> -	if (!dev->mld_idx_mask) {
> -		dev->mld_idx_mask |=3D BIT_ULL(mvif->mld_group_idx);
> -		dev->mld_remap_idx_mask |=3D BIT_ULL(mvif->mld_remap_idx);
> -	}
>  	dev->mld_idx_mask |=3D BIT_ULL(link->mld_idx);
>  	phy->omac_mask |=3D BIT_ULL(mlink->omac_idx);
> =20
> @@ -424,11 +416,6 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, s=
truct ieee80211_vif *vif,
>  	dev->mt76.vif_mask &=3D ~BIT_ULL(mlink->idx);
>  	dev->mld_idx_mask &=3D ~BIT_ULL(link->mld_idx);
>  	phy->omac_mask &=3D ~BIT_ULL(mlink->omac_idx);
> -	if (!(dev->mld_idx_mask & ~BIT_ULL(mvif->mld_group_idx))) {
> -		/* last link */
> -		dev->mld_idx_mask &=3D ~BIT_ULL(mvif->mld_group_idx);
> -		dev->mld_remap_idx_mask &=3D ~BIT_ULL(mvif->mld_remap_idx);
> -	}
> =20
>  	spin_lock_bh(&dev->mt76.sta_poll_lock);
>  	if (!list_empty(&msta_link->wcid.poll_list))
> @@ -2225,7 +2212,42 @@ mt7996_change_vif_links(struct ieee80211_hw *hw, s=
truct ieee80211_vif *vif,
>  			u16 old_links, u16 new_links,
>  			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
>  {
> -	return 0;
> +	struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
> +	struct mt7996_vif *mvif =3D (struct mt7996_vif *)vif->drv_priv;
> +	int ret =3D 0;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	if (!old_links) {
> +		int idx;
> +
> +		idx =3D get_own_mld_idx(dev->mld_idx_mask, true);
> +		if (idx < 0) {
> +			ret =3D -ENOSPC;
> +			goto out;
> +		}
> +		mvif->mld_group_idx =3D idx;
> +		dev->mld_idx_mask |=3D BIT_ULL(mvif->mld_group_idx);
> +
> +		idx =3D get_free_idx(dev->mld_remap_idx_mask, 0, 15) - 1;
> +		if (idx < 0) {
> +			ret =3D -ENOSPC;
> +			goto out;
> +		}
> +		mvif->mld_remap_idx =3D idx;
> +		dev->mld_remap_idx_mask |=3D BIT_ULL(mvif->mld_remap_idx);
> +	}
> +
> +	if (new_links)
> +		goto out;
> +
> +	dev->mld_idx_mask &=3D ~BIT_ULL(mvif->mld_group_idx);
> +	dev->mld_remap_idx_mask &=3D ~BIT_ULL(mvif->mld_remap_idx);
> +
> +out:
> +	mutex_unlock(&dev->mt76.mutex);
> +
> +	return ret;
>  }
> =20
>  static void
> --=20
> 2.51.0
>=20

--re+MA/B0pGfjMY3U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsqLwAKCRA6cBh0uS2t
rKV1AQC0vdxNS0/i4MTo8xpLmyoxumPX9nxOpLLgZs1jhwUpIwEA+w65971ZRrHX
dNUIDottR8sThdv7XNqHILFqLNwCWQo=
=qxUJ
-----END PGP SIGNATURE-----

--re+MA/B0pGfjMY3U--

