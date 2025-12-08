Return-Path: <linux-wireless+bounces-29595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F5CAD81C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7CB9300765F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769B32936B;
	Mon,  8 Dec 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgBoVz7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D00329369
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203579; cv=none; b=RlKGwmp45Ghnz0Pu+/G06Ucxx2X+NWdCXldkmlnJPiFaHUO6LMOapZpcnkYrxB2DFYPRyPGEZr0VkY2m7/FJ/nB67ySX7d1ZWnmbg/RCiSGSf0aVNCMOi3h/tA8Oxpb/EsVkQhtYgCp3NCwBWF3Xyt5jKDkAdP7Pqpsfgs5f0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203579; c=relaxed/simple;
	bh=vC4ZLDTOkG6dsh62qPT9eyeu/t9BABENkfkivMFbs88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzENITPKTLQoclr+E1shtPJcBM9dk2PrGAX2nh93wswr3yPGeMLntNkALLpEwvr54rU5y5NpTA07prKT4kws33vPY0aqfBYPdJThSQFKzuuB0/vc+rf7sqg1wPhIFj+zchcDB7u6DKsgGX8sbUS9ne9gOR3J37uu6TFkvstfXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgBoVz7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF226C4CEF1;
	Mon,  8 Dec 2025 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765203578;
	bh=vC4ZLDTOkG6dsh62qPT9eyeu/t9BABENkfkivMFbs88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgBoVz7FwY3umYMF1PV4DvUgxrFkznPJynYuzD9CLq/lJmTvCWdYdAB+WSJPoMFBf
	 tj60zu7fkalhoeIGv/H6QRsuBkVHLV9+/jX/s2yPRUBUETtVHXAhgtnMpb/QYTJpPJ
	 WzeEwRQHhMt7EfNjpXdIBAqomIrxUB64uMPJL5gOUnc281U2TycXr6o4U59pPv0TOi
	 rNH6NxU/FOBFa82Qwh1iMhf70CA+4XJV9d9Ijxw7/92kyq+8iiCUEUEAgPI72ahrVf
	 3gToh4Aj4FRKeIqnAMDVyv0ZPERsc/j175JYMcRr735PHQpKYACrxR/5UhBBoZh5Ql
	 7bzmDmJ9PMYaQ==
Date: Mon, 8 Dec 2025 15:19:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chad Monroe <chad@monroe.io>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: fix deadlock in remain-on-channel
Message-ID: <aTbed-BC8vEmwpzD@lore-desk>
References: <3fceebb12dcb672cfae11f993a373b457a35e228.1765198130.git.chad@monroe.io>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7le5LWZSIXz4geqy"
Content-Disposition: inline
In-Reply-To: <3fceebb12dcb672cfae11f993a373b457a35e228.1765198130.git.chad@monroe.io>


--7le5LWZSIXz4geqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76_remain_on_channel() and mt76_roc_complete() call mt76_set_channel()
> while already holding dev->mutex. Since mt76_set_channel() also acquires
> dev->mutex, this results in a deadlock.
>=20
> Use __mt76_set_channel() instead of mt76_set_channel().
> Add cancel_delayed_work_sync() for mac_work before acquiring the mutex
> in mt76_remain_on_channel() to prevent a secondary deadlock with the
> mac_work workqueue.

I think we need a Fixes tag here.

Regards,
Lorenzo

>=20
> Signed-off-by: Chad Monroe <chad@monroe.io>
> ---
>  drivers/net/wireless/mediatek/mt76/channel.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/w=
ireless/mediatek/mt76/channel.c
> index 2b705bdb7993..d9f8529db7ed 100644
> --- a/drivers/net/wireless/mediatek/mt76/channel.c
> +++ b/drivers/net/wireless/mediatek/mt76/channel.c
> @@ -326,7 +326,7 @@ void mt76_roc_complete(struct mt76_phy *phy)
>  		mlink->mvif->roc_phy =3D NULL;
>  	if (phy->main_chandef.chan &&
>  	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
> -		mt76_set_channel(phy, &phy->main_chandef, false);
> +		__mt76_set_channel(phy, &phy->main_chandef, false);
>  	mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
>  	phy->roc_vif =3D NULL;
>  	phy->roc_link =3D NULL;
> @@ -370,6 +370,8 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, s=
truct ieee80211_vif *vif,
>  	if (!phy)
>  		return -EINVAL;
> =20
> +	cancel_delayed_work_sync(&phy->mac_work);
> +
>  	mutex_lock(&dev->mutex);
> =20
>  	if (phy->roc_vif || dev->scan.phy =3D=3D phy ||
> @@ -388,7 +390,14 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>  	phy->roc_vif =3D vif;
>  	phy->roc_link =3D mlink;
>  	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
> -	mt76_set_channel(phy, &chandef, true);
> +	ret =3D __mt76_set_channel(phy, &chandef, true);
> +	if (ret) {
> +		mlink->mvif->roc_phy =3D NULL;
> +		phy->roc_vif =3D NULL;
> +		phy->roc_link =3D NULL;
> +		mt76_put_vif_phy_link(phy, vif, mlink);
> +		goto out;
> +	}
>  	ieee80211_ready_on_channel(hw);
>  	ieee80211_queue_delayed_work(phy->hw, &phy->roc_work,
>  				     msecs_to_jiffies(duration));
> --=20
> 2.47.3
>=20
>=20
>=20

--7le5LWZSIXz4geqy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaTbedwAKCRA6cBh0uS2t
rPnbAQCQLkt1ogkYrYOvbFfy7fnwAMGuqg8FvgG+qKg9LpuSMgD/dIWDKL8FZ3tI
ishi71jr9T+1xXEqsLCGivoIsl/zowc=
=x/pD
-----END PGP SIGNATURE-----

--7le5LWZSIXz4geqy--

