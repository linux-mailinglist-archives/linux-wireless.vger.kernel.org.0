Return-Path: <linux-wireless+bounces-26701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A6B38322
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0612C462533
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81593352FDB;
	Wed, 27 Aug 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzdDOWvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EC350829
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299526; cv=none; b=eTccZculNtyfZ5ZztND3cu/uH936KtO7+06pVNXy+8acCd87jPzwFwIECO54e+q4aFUK0GJZBM2T8y02+tUzGRj9EhTaj4b1QvzxzPt0QWoHQN0CK4u8qGDFSn8R6gAELTlGp0UZbSMfX6HfXp248hqi1BWphfOJM8vWa8Px7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299526; c=relaxed/simple;
	bh=/cjaaiIWLvfvcJ0GMr8YuzWdQos/LUeCqVzzMaY+IW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seEBSEgY3S1wPnv27MAEaBJcUCcTRwU1Vs+wo/rYrBZt4qFL9dgKDvvWn65CVTjqwkbD/NaHyQCQ+9TRcHLFEAhTHsT96102WtMWL4AsJkRX2uZ15apieqECuG6ol2XqvkkWaf/Xn5E+F8JZLC8A7WM1Yd/HRsB2Wm/+PCMUI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzdDOWvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB3C4CEEB;
	Wed, 27 Aug 2025 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756299526;
	bh=/cjaaiIWLvfvcJ0GMr8YuzWdQos/LUeCqVzzMaY+IW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzdDOWvwRLzd9CxeozZxRm1nEWsf38ryYjD7/xqR9v/pJfBw+0IUJdTa1uV6+tIiz
	 AYOGjOf+aYOT8EI+DZVZgEcCRRafgpnQ6h6F9tykXPsdwwihyoYOLyoopLG/ILxvpu
	 K+nQJulZ1HhstYKj1Xyl2J2qEXlvqfmG1j7DnfnKBHtu8BFIDHtumrTdHJwfaazkN/
	 n+ISXSrtcdoK7mw3CWOSF7semv+T+hoDFLLBX+XOLvtMllkPtJU2WiMLzSGapHBqF7
	 1PPmnLWeNWhLap8d18P9N/9dZVYRLNpU0H4IcsNv9nodVm+oqBcDTXTzAhvPfby4kX
	 6ABB1Ho2/5F7w==
Date: Wed, 27 Aug 2025 14:58:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: mt76: mt7996: fix crash on some tx status
 reports
Message-ID: <aK8BAS3aYZSl_NJL@lore-rh-laptop>
References: <20250827085352.51636-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DVjOZ1zvDKwuX01d"
Content-Disposition: inline
In-Reply-To: <20250827085352.51636-1-nbd@nbd.name>


--DVjOZ1zvDKwuX01d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When a wcid can't be found, link_sta can be stale from a previous batch.
> The code currently assumes that if link_sta is set, wcid is also non-zero.
> Fix wcid NULL pointer dereference by resetting link_sta when a wcid entry
> can't be found.
>=20
> Fixes: 62da647a2b20 ("wifi: mt76: mt7996: Add MLO support to mt7996_tx_ch=
eck_aggr()")

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index d6531b74be1f..837deb41ae13 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1247,8 +1247,10 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *d=
ata, int len)
>  			idx =3D FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
>  			wcid =3D mt76_wcid_ptr(dev, idx);
>  			sta =3D wcid_to_sta(wcid);
> -			if (!sta)
> +			if (!sta) {
> +				link_sta =3D NULL;
>  				goto next;
> +			}
> =20
>  			link_sta =3D rcu_dereference(sta->link[wcid->link_id]);
>  			if (!link_sta)
> --=20
> 2.51.0
>=20
>=20

--DVjOZ1zvDKwuX01d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaK8A/wAKCRA6cBh0uS2t
rEuRAP9/xA7YEpS3MJyU6P6kNnXw9/Bm/0GI19xVSjUU2xe21wD6Asyy2wp/60cx
rW377UR/hg/iV/4OpfKs/PcWJcYZaww=
=SNWd
-----END PGP SIGNATURE-----

--DVjOZ1zvDKwuX01d--

