Return-Path: <linux-wireless+bounces-5460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02F8900A6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596A92835CF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87D364;
	Thu, 28 Mar 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EniIon46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E37E788
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633408; cv=none; b=BfTdxgK88TDXrV+PlB0V48HJ1Ly0d7pQ2ZM1gSQCjX80yZJ6YkY0piRJjMjfwZfXKOFYHhfTC5/zj2oyU2BvPByBSaLly7XFUlptaoojAaryyhu9+mnkhpgsIHleA5twppiYRb0Lm23prBQHsM3o2+r//qp1ufMq8+Ez91/P7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633408; c=relaxed/simple;
	bh=yEbdDCg9XT0bbMdbAgf++MK7yQSAePsnMdQQyr2NnLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIFc53KffZ0cQqtueJyTw2xaHPQu8U7bFQKCXKDU+AW2c+qo/OFA6M2AKGA6hCvUbO0v5ptAPORbWxk3SwqXYXEcRIJW7ik5skBHWEmc6LcgW0K88h5qWUSy4E2cZhZgcB+A+3HwghDP2nkyzS8F7K1zCzmmEftIJt5mjOcVw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EniIon46; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y3mavgIZ6BDGJNBJObXPLTocvV0qaxQy/Cey5bC67Sw=;
	t=1711633406; x=1712843006; b=EniIon4673oG2dql2l/wDgQzyZ5vFP81X5T/CNi5tDxecdQ
	+OfAyPOhImwRAtmyCEoFiUGwozq8/9Dk7ZHwHVKw2gdpKUuoi4HR7fLfOglnckUeAa4L7sQyM5esn
	i8lSyoLNVmaWj1m755NwtSbPSngOpJTltKrkXBrUljQ+WRYvCvgW4TIyY6xQ4yyY48e0PaUZfzlHG
	do71LehsOYmCG89kJraMzIlYctS1RrfmlHp3cKVx7+cSrX8TMmh6k4IGex2bn/gVi9WtwkbwWqBnx
	uoq3MrAeWMlA5jbshyr/MsWAJV6h8S9fh8NwTotnnq/qEZpuHcXr/6dYnpmLfh0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpq2M-000000010wi-3fTE;
	Thu, 28 Mar 2024 14:43:23 +0100
Message-ID: <e2c5f81882f86b26be4d9bcf3c9d4b1fd6001b22.camel@sipsolutions.net>
Subject: Re: [PATCH 08/13] wifi: cfg80211: Refactor the iface combination
 iteration helper function
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 14:43:21 +0100
In-Reply-To: <20240328072916.1164195-9-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-9-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>=20
> +static int
> +cfg80211_validate_iface_comb_limits(struct wiphy *wiphy,
> +				    struct iface_combination_params *params,
> +				    const struct ieee80211_iface_combination *c,
> +				    u16 num_interfaces, u32 *all_iftypes)
> +{
> +	struct ieee80211_iface_limit *limits;
> +	int ret =3D 0;

That initialization is useless.

> +
> +	if (num_interfaces > c->max_interfaces)
> +		return -EINVAL;
> +
> +	if (params->num_different_channels > c->num_different_channels)
> +		return -EINVAL;
> +
> +	limits =3D kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
> +			 GFP_KERNEL);
> +	if (!limits)
> +		return -ENOMEM;
> +
> +	ret =3D cfg80211_validate_iface_limits(wiphy,
> +					     params->iftype_num,
> +					     limits,
> +					     c->n_limits,
> +					     all_iftypes);
> +
> +	kfree(limits);
> +
> +	return ret;
> +}
> +
> +static u16 cfg80211_get_iftype_info(struct wiphy *wiphy,
> +				    const int iftype_num[NUM_NL80211_IFTYPES],
> +				    u32 *used_iftypes)
> +{
> +	enum nl80211_iftype iftype;
> +	u16 num_interfaces =3D 0;
> +

This should probably set *used_iftypes =3D 0.

> +	for (iftype =3D 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
> +		num_interfaces +=3D iftype_num[iftype];
> +		if (iftype_num[iftype] > 0 &&
> +		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
> +			*used_iftypes |=3D BIT(iftype);

and that could really use a rewrite like

		if (!iftype_num[iftype])
			continue;

		num_interfaces +=3D ...

		if (!allowed...)
			*used_iftypes |=3D ...;

I'd say.

>  	for (i =3D 0; i < wiphy->n_iface_combinations; i++) {
>  		const struct ieee80211_iface_combination *c;
> -		struct ieee80211_iface_limit *limits;
>  		u32 all_iftypes =3D 0;
> =20
>  		c =3D &wiphy->iface_combinations[i];
> =20
> -		if (num_interfaces > c->max_interfaces)
> -			continue;
> -		if (params->num_different_channels > c->num_different_channels)
> +		ret =3D cfg80211_validate_iface_comb_limits(wiphy, params,
> +							  c, num_interfaces,
> +							  &all_iftypes);
> +		if (ret =3D=3D -ENOMEM) {
> +			break;
> +		} else if (ret) {
> +			ret =3D 0;
>  			continue;

Seems that 'break' is equivalent to just 'return ret'? And that setting
ret =3D 0 seems ... strange.

> -	return 0;
> +	return ret;
>  }

And then you don't need that either which is much nicer anyway...

johannes

