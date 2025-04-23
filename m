Return-Path: <linux-wireless+bounces-21929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF21A993E2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEFF9A3DEF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120828152B;
	Wed, 23 Apr 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H6etdCfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84528280A35
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422899; cv=none; b=dz56zU0G2L5PIH/JqjNKh8xxCqQ1EX1W+krxC8HDHIma0/v6ocNw1+9aYiA+FazznAebqRihlze+kK8vigePZIZaX81vM+VewCYmFJXNJjfqmnqGNMu7xj+iggrsNNN0B8otww1gULTwDm/aWzbcWWiJNy1Z+hh5R52FjDaLqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422899; c=relaxed/simple;
	bh=ykcnUvgX7Ym90xmVhMd9nhIVHQBhRVa8XWH145R/3qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mI2ob6vFz+zk+2xO6LxteAtOVhiLuJpYTtQVQqxyD7cvbH+RFlt6wa3xDO4LTmXuoS6gNmcD/ijvIBnxbB02TBBaMuWAD5lwvQb30jDQDgwfrFWV8K/a3OI7jHSyV0x3H2TUK++Af7pXLDFtSx5LOrlknDkM5z32QrEWkaG4GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=H6etdCfM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/nV0DrXRtTuN9FBq69BXijYcMW4rDYfFANTEan4EkQw=;
	t=1745422897; x=1746632497; b=H6etdCfM1OwJhcTAV2GwS23WpQwMEpos8uMzntxaLAuFNOb
	AT1y0knJbuoIuh5doAXNxyvvTZG77u65FxWuVx7AovkqEYVvP/XgQVfa1HBrpuzVnwf5kQoS5Ijvn
	IaQpTI2jID4DTlMPmB6kURuBgbsxfQo/5/oiUqXXUn5vy/Gfm6j5++T1m3ngJ/0wi3PZAu6Eqq60l
	HfG0Z5/kIbzNAYjWe8pLB6QqoeT/SVFOri7Zv5qhjobPNZ0RE3VpuYzs8rt6IOP4ATBIghsKejBeY
	P4vAtcTo1VTvHhErLGv5r1TQsLOPpvN5GYLoCbHPgbmtyxmuX2KDUVhYGmvtuhzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7cEA-0000000Enks-1JqU;
	Wed, 23 Apr 2025 17:41:34 +0200
Message-ID: <3719131760bb5070378e397d716edde394256933.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 5/5] wifi: mac80211: set tx power per
 radio in a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Wed, 23 Apr 2025 17:41:33 +0200
In-Reply-To: <20250328122519.1946729-6-quic_rdevanat@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
	 <20250328122519.1946729-6-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> +++ b/net/mac80211/cfg.c
> @@ -3080,6 +3080,7 @@ static int ieee80211_set_tx_power(struct wiphy *wip=
hy,
>  	struct ieee80211_local *local =3D wiphy_priv(wiphy);
>  	struct ieee80211_sub_if_data *sdata;
>  	enum nl80211_tx_power_setting txp_type =3D type;
> +	struct ieee80211_chanctx_conf *conf;
>  	bool update_txp_type =3D false;
>  	bool has_monitor =3D false;
>  	int user_power_level;
> @@ -3155,6 +3156,12 @@ static int ieee80211_set_tx_power(struct wiphy *wi=
phy,
>  			if (!link)
>  				continue;
> =20
> +			if (radio_id >=3D 0 && radio_id < wiphy->n_radio) {
> +				conf =3D wiphy_dereference(wiphy, link->conf->chanctx_conf);
> +				if (!conf || conf->radio_idx !=3D radio_id)
> +					continue;
> +			}
> +
>  			link->user_power_level =3D local->user_power_level;
>  			if (txp_type !=3D link->conf->txpower_type)
>  				update_txp_type =3D true;
> @@ -3175,6 +3182,12 @@ static int ieee80211_set_tx_power(struct wiphy *wi=
phy,
>  			if (!link)
>  				continue;
> =20
> +			if (radio_id >=3D 0 && radio_id < wiphy->n_radio) {
> +				conf =3D wiphy_dereference(wiphy, link->conf->chanctx_conf);
> +				if (!conf || conf->radio_idx !=3D radio_id)
> +					continue;
> +			}
> +
>=20


Hmm. Is this really enough? What if the link gets disabled and re-
enabled on a whole different chanctx on a different radio? Or other
things like that?

Seems like we may need to change how the TX power is stored in mac80211,
rather than just paper over it like this?

johannes

