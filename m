Return-Path: <linux-wireless+bounces-12030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BB960420
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F67A1F23980
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82AB189917;
	Tue, 27 Aug 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TZhC9m4J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33418859D;
	Tue, 27 Aug 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746475; cv=none; b=HFoA9CBuXVt/cNZ23XffHhNQHNASCgAQDDhToFIJwufuFoLL4sLf848pCuwsTv+kk1Bf+c/cKEmZbrGILZUQK0y5D1VVPrrqZ8LuLdkOWCA/EH90882gqbuZgakUp5QJ7iIiuRuuZwb5+hOBNX9mvaE+9KRXuxSO1yNpFBbranw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746475; c=relaxed/simple;
	bh=x6G+5+IJ7a72Cq5SOq6HjDFgUyiWiy0Jha7aSlSvAkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDNKz3g+KGkFf2arTBwzvHOU9RYkx1gCSpUts+ASrE5t4VegTiP2PA9l3qq9/DwJnBwWo1znchegIpEd2mhl1fHUNQN+BP47X1cyxcMLKuROWNTkfa6V477g5ndIE16YEWOkhtz1f0f6PssB3FRD93Uhoum8Z+0nFun6f7ukIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TZhC9m4J; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFB3260003;
	Tue, 27 Aug 2024 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724746471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeCSHZ34Mwia/PNi9Y8v1uhIR9u/g7fFvQSmjPs83E=;
	b=TZhC9m4JfAtaAvP4/EVLb8PP+yuqfze5JokhB09Nxiu6sqYKKkldBWKYrlT/JwDY7ahRfd
	VRfS1a7lQIq0R1Fd9/qm6TPJaGXQj8sk4B2avgYDFf06qMG7UxG7dALJ77OfVIcqOBXLsK
	WLhEGBxv2eDHjf9PwrTqcmeq7PEccEZ/aLYKiUAwX3GCDUpc50ZwlJQP0HSD/3SvNBRC+S
	4rWaN07xV1if/05fU2j63YTVPzh3hjafdFBJTF7IFBlrGO5r3oSk3ye/VQrU56xMEFq4xA
	TaJJvBc8Tfl+BIrH4h0ORlx5pqV5FaePKnpZHDdeZPXVQl8fofdWCyO1mrRHiw==
Message-ID: <9bc68261-9d5a-463c-82e8-c7a630dda79e@bootlin.com>
Date: Tue, 27 Aug 2024 10:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: wilc1000: Fold
 chip_allow_sleep()/chip_wakeup() into wlan.c
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
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-3-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240823161131.94305-3-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/23/24 18:08, Marek Vasut wrote:
> Neither chip_allow_sleep()/chip_wakeup() is used outside of wlan.c .
> Make both functions static and remove both the exported symbol and
> entries from wlan.h .
> 
> Make chip_allow_sleep() return error code in preparation for the
> follow up patches.
> 
> Move acquire_bus() and release_bus() to avoid forward declaration
> of chip_allow_sleep()/chip_wakeup().
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: New patch
> ---
>  .../net/wireless/microchip/wilc1000/wlan.c    | 47 +++++++++----------
>  .../net/wireless/microchip/wilc1000/wlan.h    |  2 -
>  2 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 1aab2f2dc159f..5fbba6876bd07 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -12,20 +12,6 @@
>  
>  #define WAKE_UP_TRIAL_RETRY		10000
>  
> -static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
> -{
> -	mutex_lock(&wilc->hif_cs);
> -	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
> -		chip_wakeup(wilc);
> -}
> -
> -static inline void release_bus(struct wilc *wilc, enum bus_release release)
> -{
> -	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
> -		chip_allow_sleep(wilc);
> -	mutex_unlock(&wilc->hif_cs);
> -}
> -
>  static void wilc_wlan_txq_remove(struct wilc *wilc, u8 q_num,
>  				 struct txq_entry_t *tqe)
>  {
> @@ -555,7 +541,7 @@ static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
>  	return rqe;
>  }
>  
> -void chip_allow_sleep(struct wilc *wilc)
> +static int chip_allow_sleep(struct wilc *wilc)
>  {
>  	u32 reg = 0;
>  	const struct wilc_hif_func *hif_func = wilc->hif_func;
> @@ -584,7 +570,7 @@ void chip_allow_sleep(struct wilc *wilc)
>  	while (--trials) {
>  		ret = hif_func->hif_read_reg(wilc, to_host_from_fw_reg, &reg);
>  		if (ret)
> -			return;
> +			return ret;

Forwarding error codes sounds like a good idea, but neither this patch nor the
next one is reading the return value from any chip_allow_sleep[XXX] function, so
it does not bring much value.

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


