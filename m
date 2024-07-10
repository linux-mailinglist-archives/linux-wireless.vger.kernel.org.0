Return-Path: <linux-wireless+bounces-10143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7D92CEC7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B78B21411
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380C18FA2A;
	Wed, 10 Jul 2024 10:04:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276B1B86F3;
	Wed, 10 Jul 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605859; cv=none; b=g0wljpS7wDu+px9rDRpd7ajZ4zGat+tQaZuAH6rfvvVHfAKG6uY8jq3cotzfM6PvgBDFKsK0ELavHOub54eHYj8JSHTJgODXNTnkDPhSLgY+VggvAF/+QNKVxDZ71644//Hu6CVUnXfZ2rU9gYvHPSjEvdU4AhZrVwbR1Dq+gEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605859; c=relaxed/simple;
	bh=LC9cKEaoasbcHZ5Zm1sctd8Ajuk0xRF4jmcsHg+/i2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDXaQyYRRKpbM7gdQiuJ4HNZMF4kXIwg39G32f6SFz6JDXerzU9ZqfqvQ3xgtTvyCyccw8k9Q1e3JmYoUdUaRLjxD8ArBvTJOanwBgHoC9yARlvLehWnH/zYKVtjvhNVdrNlNLSwEPqLuom2/QaxME5l7Z7er9bkhFai4Q0FBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 824711C009E; Wed, 10 Jul 2024 12:04:15 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:04:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19] wifi: cfg80211: wext: add extra SIOCSIWSCAN
 data check
Message-ID: <Zo5cn37w8NjVyZdj@duo.ucw.cz>
References: <20240701001526.2921645-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APtJU7AeUS/BDcBA"
Content-Disposition: inline
In-Reply-To: <20240701001526.2921645-1-sashal@kernel.org>


--APtJU7AeUS/BDcBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 6ef09cdc5ba0f93826c09d810c141a8d103a80fc ]
>=20
> In 'cfg80211_wext_siwscan()', add extra check whether number of
> channels passed via 'ioctl(sock, SIOCSIWSCAN, ...)' doesn't exceed
> IW_MAX_FREQUENCIES and reject invalid request with -EINVAL otherwise.

This results in very confusing code in 4.19 at least. It should goto
out for consistency, exploting kfree(NULL) to be nop. Ok, not sure we
care...

Best regards,
								Pavel
							=09
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index dacb9ceee3efd..0dc27703443c8 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1405,10 +1405,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
>  	wiphy =3D &rdev->wiphy;
> =20
>  	/* Determine number of channels, needed to allocate creq */
> -	if (wreq && wreq->num_channels)
> +	if (wreq && wreq->num_channels) {
> +		/* Passed from userspace so should be checked */
> +		if (unlikely(wreq->num_channels > IW_MAX_FREQUENCIES))
> +			return -EINVAL;
>  		n_channels =3D wreq->num_channels;
> -	else
> +	} else {
>  		n_channels =3D ieee80211_get_num_supported_channels(wiphy);
> +	}
> =20
>  	creq =3D kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
>  		       n_channels * sizeof(void *),

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--APtJU7AeUS/BDcBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo5cnwAKCRAw5/Bqldv6
8oUrAJ9jTuyEhJu2i4VvC4LtpiREZ1G5SgCgwRT67JjrBQ576cUBOiBoBryoMOY=
=e6To
-----END PGP SIGNATURE-----

--APtJU7AeUS/BDcBA--

