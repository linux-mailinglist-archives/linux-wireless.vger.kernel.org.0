Return-Path: <linux-wireless+bounces-20173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A15A5C314
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA7D164F78
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41881D5ADC;
	Tue, 11 Mar 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6QqbX5S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6161D5CDD
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701326; cv=none; b=ZiOIopjUGIjOi/MXVuPlAlow4qdCSjWgHKN/IPpveptsGzKXnJyQGVyt/6B4qSOF9OHvOp9oiLHFcoBJElXIkXAIJNtHsF9NJd7KT5GS4fz0r0KKGsrz0U8Xc8BDHbA0L6qNRkCd4WjZU/d00NWMkb5SWSKns9AVZ0zjH0DWVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701326; c=relaxed/simple;
	bh=eSQHXUB+R63mZ02s4Vjzhbf99w8IG8VqIuz85ePDvK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgpB5bKLoVTXJJkw1eTjoi88iHTvGTobi8Drjo7wahYeFk4tTS4xjwnqVSlOysHTaV0cgB19OwJSVYVIu2DKzOJsAnYOsQZ+ka/7M/peJIKnztbY+uc9K3uhwvecJWy962ENB0FJp5UDFL/fk+L+fB2iH9T8eNpFWMU4302YxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6QqbX5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9071BC4CEE9;
	Tue, 11 Mar 2025 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741701326;
	bh=eSQHXUB+R63mZ02s4Vjzhbf99w8IG8VqIuz85ePDvK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6QqbX5S33DP3N3mXDjd+ICQtpOEQU8iFf6t+uxEztYWQ/OpiaoqCPxml918i4n7b
	 JZElU5Nx0asV4+lafh2iUZgFrvkV0IgF8t16IV4usbgwF5BS7+vLMrz6aPNBOfR8/T
	 IHr3IX33BVoYdb3RJS6XajPvfdJ2iJXoNkgF+M9fgfItgZ87i/6D8CHEL8+wzxjF54
	 xdIBaK5vLWzh1+SUaF1tMKscQf4QK9NALYrQ/VX0N9uUtNp5DCCImuWSarSVbKxP0b
	 I5QmZyLLyWFiMADclAcohNwfJ7vCrLthG99RfScqqwvUZVFTWjyky4u7gloI0LYmdR
	 B+4w5ktvQWtrw==
Date: Tue, 11 Mar 2025 14:55:22 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 7/8] wifi: mt76: mt7996: implement driver specific
 get_txpower function
Message-ID: <Z9BAyuc6SLkS25NY@lore-desk>
References: <20250311103646.43346-1-nbd@nbd.name>
 <20250311103646.43346-7-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWV7mmZAOxJT3LX3"
Content-Disposition: inline
In-Reply-To: <20250311103646.43346-7-nbd@nbd.name>


--SWV7mmZAOxJT3LX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 11, Felix Fietkau wrote:
> Fixes reporting tx power for vifs that don't have a channel context
> assigned. Report the tx power of a phy that is covered by the vif's
> radio mask.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/main.c  | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 886b6ef3462b..89fc3f102555 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -602,6 +602,31 @@ static void mt7996_configure_filter(struct ieee80211=
_hw *hw,
>  	mutex_unlock(&dev->mt76.mutex);
>  }
> =20
> +static int
> +mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif, i=
nt *dbm)

I guess the signature here should be:

static int
mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,=20
		   unsigned int link_id, int *dbm)
{
}

Regards,
Lorenzo

> +{
> +	struct mt7996_vif *mvif =3D (struct mt7996_vif *)vif->drv_priv;
> +	struct mt7996_phy *phy =3D mt7996_vif_link_phy(&mvif->deflink);
> +	struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
> +	struct wireless_dev *wdev;
> +	int n_chains, delta, i;
> +
> +	if (!phy) {
> +		wdev =3D ieee80211_vif_to_wdev(vif);
> +		for (i =3D 0; i < hw->wiphy->n_radio; i++)
> +			if (wdev->radio_mask & BIT(i))
> +				phy =3D dev->radio_phy[i];
> +
> +		if (!phy)
> +			return -EINVAL;
> +	}
> +
> +	n_chains =3D hweight16(phy->mt76->chainmask);
> +	delta =3D mt76_tx_power_nss_delta(n_chains);
> +	*dbm =3D DIV_ROUND_UP(phy->mt76->txpower_cur + delta, 2);
> +
> +	return 0;
> +}
>  static u8
>  mt7996_get_rates_table(struct mt7996_phy *phy, struct ieee80211_bss_conf=
 *conf,
>  		       bool beacon, bool mcast)
> @@ -1651,7 +1676,7 @@ const struct ieee80211_ops mt7996_ops =3D {
>  	.remain_on_channel =3D mt76_remain_on_channel,
>  	.cancel_remain_on_channel =3D mt76_cancel_remain_on_channel,
>  	.release_buffered_frames =3D mt76_release_buffered_frames,
> -	.get_txpower =3D mt76_get_txpower,
> +	.get_txpower =3D mt7996_get_txpower,
>  	.channel_switch_beacon =3D mt7996_channel_switch_beacon,
>  	.get_stats =3D mt7996_get_stats,
>  	.get_et_sset_count =3D mt7996_get_et_sset_count,
> --=20
> 2.47.1
>=20
>=20

--SWV7mmZAOxJT3LX3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9BAygAKCRA6cBh0uS2t
rF12AP464BBoSVRUVq16OaLgBbJE5IDjlPeXtyxBO/XFKXWl0AD8DOp7TCiQfF64
4wSWs8AH9Oy2suIp9VGxoo9TVZH6Nws=
=Dg58
-----END PGP SIGNATURE-----

--SWV7mmZAOxJT3LX3--

