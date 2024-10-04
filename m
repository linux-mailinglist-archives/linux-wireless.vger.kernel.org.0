Return-Path: <linux-wireless+bounces-13491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB698FEFC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D251E1C214C0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89E13D244;
	Fri,  4 Oct 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bj0NKFRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30C13BAC3;
	Fri,  4 Oct 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031419; cv=none; b=pjxYFB8Ha16PCnJ4ukxJRzdXHHs7/8bGnWclYbKx+8Y0obX/e3phBBFBNCJi+B7OkWpMF5SEq+1UXIjo6FtXqDgTltvUHnXvWL+9KjwD+Gdq9olr1W/xPRSwmjEa7K5gi6rv4LMRpX02055fV12JNXz7PQ8leJ2T17v2b/pReV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031419; c=relaxed/simple;
	bh=sXaOQ2gduuvmKeAH09z12Ez+oyRl78CiFuYQJvnKUCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn9lpQQzZvgfhyiGIGRCeduP9TEBvHfVUhS7YFhVUiGStezsQIWzDAE9tmTHgF4O2rF61rgsDYdUcv0SBlh+8TKgZMNCvdeNsoXHZQ3zHNdj9tuEwFxEIH+U98RZAusB+CVrf5FCWia0diZ+QsmLSvQe0l/Ay1vySNY0E7rqtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bj0NKFRJ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 08D29C2BB9;
	Fri,  4 Oct 2024 08:39:17 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BF7B240006;
	Fri,  4 Oct 2024 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728031150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9ShHODL4l8vNKvB1mI98uLGIwuas+YQTL5sBZad9as=;
	b=Bj0NKFRJ5SmNNg98U5JoNQUmwkommin2qylfQa2eIDFV3PWJmPTw6ZofDjkB92fZo5fX2h
	0ffKbKX5kqg85me3vZSjQh/oWdoa04d8aw/K8JAIH43Qk21Pjt+mZ1Ggbbr5EYje1vGv3n
	FtbMkzp85547zNjARp3p3LPr/c10NSFsYxTZq3QDSTig/cIALgM26+R4U36X74m/beTO7n
	wUeX2zTdYXNTO1vFuBx1uBgVOKdoo/gcW2xdhisrjTJZ3WGEEsbtd0AhAIBDWuVdZZsdF/
	ucRmnR9H5ycKKxYz6mBGdAIUXgnu9BJzVpAEmdBTzRi+4GWvO8PQhefAw2aqBg==
Message-ID: <4912f382-5228-44ee-bf87-201f0ad28bf6@bootlin.com>
Date: Fri, 4 Oct 2024 10:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] wifi: wilc1000: Register wiphy after reading out
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
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-6-marex@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20241003111529.41232-6-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 10/3/24 13:14, Marek Vasut wrote:
> Register wiphy after reading out chipid, so the chipid can be
> used to determine chip features and not advertise WPA3/SAE
> support to userspace on WILC3000. Note that wilc_netdev_cleanup()
> will deregister the wiphy in fail path.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> index 11e0f8a473467..30015c5920467 100644
> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> @@ -1761,7 +1761,6 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>  {
>  	struct wiphy *wiphy;
>  	struct wilc *wl;
> -	int ret;
>  
>  	wiphy = wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
>  	if (!wiphy)
> @@ -1804,14 +1803,8 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>  				BIT(NL80211_IFTYPE_P2P_GO) |
>  				BIT(NL80211_IFTYPE_P2P_CLIENT);
>  	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> -	wiphy->features |= NL80211_FEATURE_SAE;
>  	set_wiphy_dev(wiphy, dev);
>  	wl->wiphy = wiphy;
> -	ret = wiphy_register(wiphy);

I think you did not address one of my comment in v5 about this change: in
wilc_cfg80211_init (wilc_create_wiphy's caller), there is still a
wiphy_unregister in the failure path, which does not make sense anymore since
this function does not register wiphy anymore.

Once fixed: with this patch iw phy shows correctly on my platform that wilc3000
does not support SAE authenticate command while wilc1000 does. And wilc1000
still works correctly, even with wpa3.

Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2
Tested-on: WILC3000 A SDIO WILC_WIFI_FW_REL_16_1_1

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

