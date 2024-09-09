Return-Path: <linux-wireless+bounces-12651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557A9713ED
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5561C2029F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B21B2EF3;
	Mon,  9 Sep 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKUEkF6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4B1AE860;
	Mon,  9 Sep 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874520; cv=none; b=sc47RMXTpGS+olgRH63FNmFcrGbZqYFDibghU9vmYmcLjdrMLrqpa3rUbmzmrISF4D3Qx5TBM2wWlr6VGgdNeOKz9OnkIipUXw4ngsTmNFIfiMV8e62IRvU6PoJBkFuiW4wdmsXJeTfrsqzj4X1Fa8dY50yygod38ha+485t4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874520; c=relaxed/simple;
	bh=iIyFNvwIG1Fw7RLDG38tcwNwZ7jG3tyy1/sydkiK+WA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kWFyCmL81Z2lpHbZTt+L7eP4SXdW61KrftSvVXJCS0S7ZJZ2dEAy07yahapaMN9uguqNqmzPB7bB6w+jR9D8/OYrQog6TJ3Itcw7doXKiIMFjJshBXC/B7UAeWN2NjhPCqDOHFC/iVagNQaHRX0wnXrZ8aqyiyBTAK6hIunK2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKUEkF6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD25C4CEC5;
	Mon,  9 Sep 2024 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725874519;
	bh=iIyFNvwIG1Fw7RLDG38tcwNwZ7jG3tyy1/sydkiK+WA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XKUEkF6n6kVkzicmCdmhKOwsRez695tp1Pa+jluYyL6jZMw4TKP8RVR/XimidPvPL
	 2XBw4ZDmcM8nXwbF/3eG8cMzlLCB/QUO/Z8zDdUl1/G4ZvXQ9KhQY6HbM+xqS6o+Z9
	 /MHFJjRVf3RS3HE62uUM29pssK8XBkWbz6pb5O6OinRH/trj5uprwEyG2dzk/QNxpa
	 gSM0x+bgcbngaB+8H5J70Fi6WTD90Tij/7KOjHFE3168R7Rcde3vZQcrPiLoMYO4qn
	 KBmX8S4zPavEjCjbRPTnCfOyoy39MC+VnQY0rcfPrfHIWSL6Krif89VetMzYSNlEm7
	 MwUkjgO+29UHw==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  Ajay Singh <ajay.kathat@microchip.com>,
  "David S. Miller" <davem@davemloft.net>,  Adham Abozaeid
 <adham.abozaeid@microchip.com>,  Alexis =?utf-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Conor Dooley <conor+dt@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  devicetree@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
References: <20240829004510.178016-1-marex@denx.de>
	<20240829004510.178016-5-marex@denx.de>
Date: Mon, 09 Sep 2024 12:35:14 +0300
In-Reply-To: <20240829004510.178016-5-marex@denx.de> (Marek Vasut's message of
	"Thu, 29 Aug 2024 02:45:03 +0200")
Message-ID: <87ed5tgofh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Add support for the WILC3000 chip. The chip is similar to WILC1000,
> except that the register layout is slightly different and it does
> not support WPA3/SAE.
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> @@ -313,6 +313,13 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>  
>  	vif->connecting = true;
>  
> +	if (sme->auth_type == NL80211_AUTHTYPE_SAE &&
> +	    is_wilc3000(vif->wilc->chipid)) {
> +		netdev_err(dev, "WILC3000: WPA3 not supported\n");
> +		ret = -EOPNOTSUPP;
> +		goto out_error;
> +	}

This looks wrong. If wilc3000 doesn't support SAE you shouldn't
advertise NL80211_FEATURE_SAE to user space. I think the check for
wilc3000 should be in wilc_create_wiphy():

if (!is_wilc3000(vif->wilc->chipid))
	wiphy->features |= NL80211_FEATURE_SAE;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

