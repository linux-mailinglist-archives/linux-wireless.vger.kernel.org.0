Return-Path: <linux-wireless+bounces-26229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A6B1F1FC
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 05:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D58758620B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4D19E7F9;
	Sat,  9 Aug 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skMpzBXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E81D432D
	for <linux-wireless@vger.kernel.org>; Sat,  9 Aug 2025 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754709285; cv=none; b=jOSqcZzVt8fTzeMto+B1Ezapkvw4Fsmhq5AEPqhQmYonjjg8s95S12kjbUM5klB/M8QYp55gEM3DZKqwtBQzoC+iFBFwTyhFkJGlw8rR+IlnkiVza9LlxKq3e/NTQOCGfdOTCNdX8EXo40eDE1D8oUalwqbte4QyDNa95u1qsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754709285; c=relaxed/simple;
	bh=AJbLhOWXgNRDDIWHKPqqp01JZJ0f7/n0RkXmffcqdwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIlHqum/n+fa850O5J0Jd+9WjmIMC4d/v6JzM4g1RJHFtrwxOrMPVWkUwySHDczeOXyVpX6FFQP6R+u56Aah0lDgm7xDdRA/Y1S3fCf+0ybfCWjfMmnFhR74xc3GZzyioiGYF0zl4t3iw4uiALJKp+6xhsGOtYpDmlKf4dU2H+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skMpzBXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8EAC4CEED;
	Sat,  9 Aug 2025 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754709284;
	bh=AJbLhOWXgNRDDIWHKPqqp01JZJ0f7/n0RkXmffcqdwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skMpzBXU3jVaXXs5+TZe3Q9kitY3iEuc39vxU+AG8ZVoH6B2CkicN3MrmrERDpUhk
	 y4xA4j0Yv3hT0RIugYZFfl0Yz0YBoOaOcV3p6J/QambMTBZFIGzHopWhQ02vw+Dvxz
	 R9YtPo+FklXqYvkBHhcYE6GW80nBGIKmMDpq0Q5SlgNUNm9RwaGBf6bzx0YYkdvvTo
	 TyQDhV08l/BqiRFGo6/4FLxkS7IP7XmH84VJ7Rt2GZQgnifdyFi9s/u9G1plxbOQYs
	 811bfor+uTWkFo8e9ldVc+nAJUkULeH5ObzjSlYWwk0G/T5KPQGXYlO9vlkv45tOCX
	 KgRlkkzO+AsMQ==
Date: Sat, 9 Aug 2025 05:14:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chad Monroe <chad@monroe.io>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: use the correct vif link for
 scanning/roc
Message-ID: <aJa9H3XkImgFlDvb@lore-rh-laptop>
References: <180fffd409aa57f535a3d2c1951e41ae398ce09e.1754659732.git.chad@monroe.io>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7HUEbVQxErEPcAp"
Content-Disposition: inline
In-Reply-To: <180fffd409aa57f535a3d2c1951e41ae398ce09e.1754659732.git.chad@monroe.io>


--Y7HUEbVQxErEPcAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> restore fix which was dropped during MLO rework
>=20
> Fixes: f0b0b239b8f3 ("wifi: mt76: mt7996: rework mt7996_mac_write_txwi() =
for MLO support")
> Signed-off-by: Chad Monroe <chad@monroe.io>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 226534490792..6333a064c4f7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -903,8 +903,12 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, _=
_le32 *txwi,
>  				       IEEE80211_TX_CTRL_MLO_LINK);
> =20
>  	mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
> -	if (mvif)
> -		mlink =3D rcu_dereference(mvif->mt76.link[link_id]);
> +	if (mvif) {
> +		if (wcid->offchannel)
> +			mlink =3D rcu_dereference(mvif->mt76.offchannel_link);
> +		if (!mlink)
> +			mlink =3D rcu_dereference(mvif->mt76.link[link_id]);
> +	}
> =20
>  	if (mlink) {
>  		omac_idx =3D mlink->omac_idx;
> --=20
> 2.47.2
>=20
>=20
>=20

--Y7HUEbVQxErEPcAp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaJa9HAAKCRA6cBh0uS2t
rE9dAQCqsDnEFH56sDgxZbMfZbOJkzcBPKRS2FRjiH+VcB9eJQD8Cv/kh+QvXdK1
p/4z1zyFU1PLfwNm7yhNbCBpa2wh9gI=
=9CB9
-----END PGP SIGNATURE-----

--Y7HUEbVQxErEPcAp--

