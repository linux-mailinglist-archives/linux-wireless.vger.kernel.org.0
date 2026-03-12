Return-Path: <linux-wireless+bounces-33099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMUHLcWbsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:56:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC1270881
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE0713025726
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13338E106;
	Thu, 12 Mar 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7TmRCkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E138D009
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312962; cv=none; b=Hv4usoswgr5EiMsA80LFEm0+Qm+c5vZpcc7jhEKfmABtbGSMYSIBy6HBJYQo+Q1XuHMsAf9W3kusVR4HiVRmJU+iR2/gKrctQfxvQVnH+kkWIrBhQQXTxrePf+j5VIK/gNB9UpejFz9oe46zRSWOTNi63KkcEXXCvDQVp8qTU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312962; c=relaxed/simple;
	bh=PE2oXMT0MgH0+Y1J0/akG+DThOQW/ZAHT5MvozIoPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfpdJ2A3JcGo+aKLH7PmMdAFpsKBu74thbatLZvXsHW82h1gfu8IjINILTnpHOhCjV6vEfO1G8o4nPJQZs3fwGx9dAIsGvXGINnIgz5rHOM3MrOq3wzJEDRBheT8IDbZ9p/w6tsMBs6yxhR5SL6okH9i0/EG1BuQNr8M/H6EN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7TmRCkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315EBC4CEF7;
	Thu, 12 Mar 2026 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773312962;
	bh=PE2oXMT0MgH0+Y1J0/akG+DThOQW/ZAHT5MvozIoPpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7TmRCkcZ1mouWhOJMK2LcQIxHkYTroNtnSszOwda6rdXXq7lCsQk8fsIFKRrzwRn
	 h2bYAXuiK7eFJ45wpVNEib2cdjzHbYRWKojNQa0TEbuJ89qth8W3wdXdnTEax5Wh02
	 UdSgG5B3EcahVm/tO/d5PcNmmR3bu9Hg3QQLD3POpyk4tvPXOY1XX/yupmywKG7kz3
	 Pc1PO+JFnTc0V6Xd/53ic91mXn0/9cSV68idPQBckEAIz7Emh9GCXMfhXvr7VnTVAS
	 AnJvmsfpbai8i1RZlgrR954qGpKR0kaIef3oWxWHsVjJfnYEjW8ic4fhiGY07fJCDG
	 iJ5/tSDFKNE1Q==
Date: Thu, 12 Mar 2026 11:56:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH mt76 6/6] wifi: mt76: mt7996: fix issues with manually
 triggered radar detection
Message-ID: <abKbwL6jgtKtLFdD@lore-desk>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
 <20260312095724.2117448-6-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JvqYH7pQCmJRC4yZ"
Content-Disposition: inline
In-Reply-To: <20260312095724.2117448-6-shayne.chen@mediatek.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33099-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 25BC1270881
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--JvqYH7pQCmJRC4yZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>=20
> Disallow triggering radar detection on non-DFS channels to prevent paused
> TX queues from failing to resume, as a channel switch is not performed in
> this case.

I guess we are missing a Fixes tag here.

>=20
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7996/debugfs.c   | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7996/debugfs.c
> index 76d623b2cafb..e26bed6b97e7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
> @@ -226,14 +226,23 @@ mt7996_radar_trigger(void *data, u64 val)
>  #define RADAR_BACKGROUND	2
>  	struct mt7996_dev *dev =3D data;
>  	struct mt7996_phy *phy =3D mt7996_band_phy(dev, NL80211_BAND_5GHZ);
> -	int rdd_idx;
> +	struct cfg80211_chan_def *chandef;
> +	int rdd_idx, ret;
> =20
>  	if (!phy || !val || val > RADAR_BACKGROUND)
>  		return -EINVAL;
> =20
> -	if (val =3D=3D RADAR_BACKGROUND && !dev->rdd2_phy) {
> -		dev_err(dev->mt76.dev, "Background radar is not enabled\n");
> -		return -EINVAL;
> +	if (test_bit(MT76_SCANNING, &phy->mt76->state))
> +		return -EBUSY;
> +
> +	if (val =3D=3D RADAR_BACKGROUND) {
> +		if (!dev->rdd2_phy || !cfg80211_chandef_valid(&dev->rdd2_chandef)) {
> +			dev_err(dev->mt76.dev, "Background radar is not enabled\n");

nit: I guess it is better to specify a different error message if rdd2_chan=
def
is  invalid.

Regards,
Lorenzo

> +			return -EINVAL;
> +		}
> +		chandef =3D &dev->rdd2_chandef;
> +	} else {
> +		chandef =3D &phy->mt76->chandef;
>  	}
> =20
>  	rdd_idx =3D mt7996_get_rdd_idx(phy, val =3D=3D RADAR_BACKGROUND);
> @@ -242,6 +251,11 @@ mt7996_radar_trigger(void *data, u64 val)
>  		return -EINVAL;
>  	}
> =20
> +	ret =3D cfg80211_chandef_dfs_required(dev->mt76.hw->wiphy, chandef,
> +					    NL80211_IFTYPE_AP);
> +	if (ret <=3D 0)
> +		return ret;
> +
>  	return mt7996_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, rdd_idx, 0);
>  }
> =20
> --=20
> 2.51.0
>=20

--JvqYH7pQCmJRC4yZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabKbwAAKCRA6cBh0uS2t
rJOrAP4rmPP1xy2RrdZD846t4P/TbP9rH9yYKlIDBIOLhqFgBgEAmfK6w7IZqCe5
Hzom0sNpM8koVba5F3l9DCKKial9/Q8=
=GRDW
-----END PGP SIGNATURE-----

--JvqYH7pQCmJRC4yZ--

