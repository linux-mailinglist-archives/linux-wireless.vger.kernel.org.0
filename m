Return-Path: <linux-wireless+bounces-12748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD450973191
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B42C1C255CE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB119580F;
	Tue, 10 Sep 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pRJ/yPSw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959719004B;
	Tue, 10 Sep 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962915; cv=none; b=MP5CgEtbr0hP9e3yuQbrpFIVoc2bE1HP+Xt0AJKm/4u0VNSmtNL5lNfNpZWXpLyUudkH2ypbSes9m4Bj5m5POlzSoFrLbNuOYLgUu/GZQDutfU9THsbeP4S2+s+/nFWJq0yE3WhJz1Ayy0+nshWu9dOpTukO6Oabkg+SbEuw+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962915; c=relaxed/simple;
	bh=MsadThRw8OXCzOuitomaL4tJiz9fo5k0uXDvNjCJyKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBWDXtLkFHf0sBTrUqwqawq65mUFj8D3cU02b2yAWD5l+fjCSrva+1Atix7IJNE87MnlPSTI/o7jY5i4YbWYk5XXQhlKYG1bdG57vDBPx0ipc8r5cz0StqQSrZvvv6KGVK4MvL2aXKl32wlLEhYvv144t4CsPcG1Tq9Pi0S/pWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pRJ/yPSw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F566FF80C;
	Tue, 10 Sep 2024 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725962906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4PgUjTOWwPVIX4EB9xYj1NObgUhDRb+IK1VTWtcj08=;
	b=pRJ/yPSw6CaewFWDpJPP/Oqf0BN4WrwCcaHuyaereJUCVodYE5M3Pt86Nrxg/ugeZU7LsM
	jgaIKZbAQuaGzDeledQ2y1FLYi8SAG5u+VBd2lAmva3obxcy0vL8oohMSYPh9POEgLxdn6
	IK0pJRrtgcK1es0zaMFhUXQvdbAnzhrxRgDXLedCIlsEd5rcwwy9pJ9InrnKG3zG1xld04
	hFlAPXVvNitrz9GhW1KL05gfSJMLJ/j/ivAdh8KSBvuX8WUcIRgrociBVqTUcjBFKrZM63
	lIMa8Ut3QF6MPpv/wNF0yz0TuufEq/WE+0z8g0bTfGQI7uOkAyZQW6OusubBRg==
Message-ID: <769f1405-62fc-4457-a958-b644c706140f@bootlin.com>
Date: Tue, 10 Sep 2024 12:08:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] wifi: wilc1000: Register wiphy after reading out
 chipid
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-8-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-8-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/9/24 21:29, Marek Vasut wrote:
> Register wiphy after reading out chipid, so the chipid can be
> used to determine chip features and not advertise WPA3/SAE
> support to userspace on WILC3000. Note that wilc_netdev_cleanup()
> will deregister the wiphy in fail path.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

> @@ -1804,14 +1803,8 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>  				BIT(NL80211_IFTYPE_P2P_GO) |
>  				BIT(NL80211_IFTYPE_P2P_CLIENT);
>  	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> -	wiphy->features |= NL80211_FEATURE_SAE;
>  	set_wiphy_dev(wiphy, dev);
>  	wl->wiphy = wiphy;
> -	ret = wiphy_register(wiphy);
> -	if (ret) {
> -		wiphy_free(wiphy);
> -		return NULL;
> -	}

If I am reading the patch correctly, there are still some failure paths in
wilc_cfg80211_init which try to call wiphy_unregister on the (not registered
anymore in there) wphy.
>  	return wl;
>  }
>  
> @@ -1861,6 +1854,14 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
>  }
>  EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
>  
> +int wilc_cfg80211_register(struct wilc *wilc)
> +{
> +	wilc->wiphy->features |= NL80211_FEATURE_SAE;

Even if I get the general need, it feels weird to have parts of the wphy init
performed in wilc_create_wiphy, and some parts (the features field) here.
Wouldn't it work to just move wilc_create_wiphy content here, since wphy will
not be usable anyway before eventually registering it ?

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


