Return-Path: <linux-wireless+bounces-12032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3500960467
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1081F2368F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DA1946B5;
	Tue, 27 Aug 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qvfxo0e5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BA15535A;
	Tue, 27 Aug 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747314; cv=none; b=b7WNlVZXFTXhIBUyffG9vOHe6Ih9/pNKxQOUSpvQbrG5XHJ0Ne98w75/vsktxuv2+gpxuZWSfSXBis46+Yr66MwjiwP/7A4g7W94XkjlxNsQ0jcr37llrfeP6K8XJ1/uc/FmnSampN9Ez1UD9EVYsbEQ3m+RvihvP6MQWk/k1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747314; c=relaxed/simple;
	bh=E4J+tSUQ0LpFSOfWy9MLmUhC6fHoR4jRGdehmayKk2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvV6ZFTiuCyaAyuvUDnIc/2MkrcOtv4eGAnOkAFHJvex1yxi9/RZGF569qWUWI7sQQQXsm5a1HDOjxDp4DcT5fI4I479UnltITv/Ckb2wbW0IqBZp7NUUB+S/rocKui9Q57m2tPFWxh4ey5F0B/lAbRq8yOEcGmWk8U5TiuX+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qvfxo0e5; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 135201C0009;
	Tue, 27 Aug 2024 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724747309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gIRH6WgVW8J1vdjAi/I+YpdYIK+0EWHY4W1vNLafEg=;
	b=Qvfxo0e5MUkoNmttVF4nVDLBzYPI60WpY38fSDyrPr5AUYXCKC3gGqMw1wWefqsNyGOAq2
	hLLHxHAnV0CnM/neiJuRMiHrmh674x+fkL94TO+lVtxEzSuEvTyoXoiMPASg4iLqnC7cbY
	yws+G4rzbAMTigYBAbilAGhN0PzLyRuvBwstl8mq9Uw+zwKv8SrGZ4REGFp31+H6uPVKfC
	zb7wwN7vJy8FcvQdjOdEv2KlYP2suySuuG5+8uAiYkfr9bwlHPMJdn9XaUX+4ztbuSWqXq
	1Y8Q8+HVRb8c2ovkvYsw7PWFrV9r4zMdm6WK9CkR8dZkYI5rcEwnJ4XF0vgUQQ==
Message-ID: <9217902b-7d1b-4d67-a148-a28484e8946e@bootlin.com>
Date: Tue, 27 Aug 2024 10:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: wilc1000: Add WILC3000 support
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-4-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240823161131.94305-4-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/23/24 18:08, Marek Vasut wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Add support for the WILC3000 chip. The chip is similar to WILC1000,
> except that the register layout is slightly different and it does
> not support WPA3/SAE.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Note: Squashed and updated from the following downstream patches:
> wifi: wilc1000: wilc3000 support added
> wifi: wilc1000: wilc3000 interrupt handling
> wifi: wilc1000: wilc3000 added chip wake and sleep support
> wifi: wilc1000: wilc3000 FW file sepecific changes
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
> V2: - Return -EINVAL in wilc_sdio_init() if chip ID is not supported
>     - Dispose of wilc_chip_type, replace with is_wilc1000()/is_wilc3000()
>     - Remove wilc3000 DT compatible string handling, match on wilc1000 only,
>       the device type can be auto-detected based on chipID
> ---
>  .../wireless/microchip/wilc1000/cfg80211.c    |   7 +
>  .../net/wireless/microchip/wilc1000/netdev.c  |  29 ++-
>  .../net/wireless/microchip/wilc1000/sdio.c    |  62 ++++-
>  drivers/net/wireless/microchip/wilc1000/spi.c |   2 +-
>  .../net/wireless/microchip/wilc1000/wlan.c    | 217 +++++++++++++++---
>  .../net/wireless/microchip/wilc1000/wlan.h    |  43 +++-
>  6 files changed, 298 insertions(+), 62 deletions(-)
> 

[...]

> @@ -1467,6 +1604,20 @@ static int init_chip(struct net_device *dev)
>  		}
>  	}
>  
> +	if (is_wilc3000(wilc->chipid)) {
> +		ret = wilc->hif_func->hif_read_reg(wilc, 0x207ac, &reg);

Some defines would be nice here instead of hardcoded addresses. I have asked
Ajay about those while working on wilc3000, the meaning is roughly the following:
- 0x000207ac: WILC_3000_BOOTROM_STATUS_REGISTER
- 0x004f0000: WILC_3000_CORTUS_BOOT_REGISTER_2
- 0x71: WILC_CORTUS_BOOT_FROM_IRAM

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


