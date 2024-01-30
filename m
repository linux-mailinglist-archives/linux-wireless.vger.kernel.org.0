Return-Path: <linux-wireless+bounces-2787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A2841ECA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D2C1F2C486
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF455823F;
	Tue, 30 Jan 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XEUBELhB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4C5820C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605609; cv=none; b=GFuOaZav92x2aXbmWJ+ir7j6APJpSROq6cqQKIlD562r8h3DIhlL2MnFaUH6387jDF2tQxl7a7Xs7xTYMvtp8p3suA6ktum1UoIIlDU+43o7co1aNs+dgf/0zZgrgvbKewZQBvMexVH0rziNWdA5TCHW9B4B3HivKzExCM9GArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605609; c=relaxed/simple;
	bh=oiHeglD96XnI8YyGxD3iQfNOk+R1owt0Ba2TjHCjnr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj9HXUkj49SEXNy3bRPyrEV31NCxyjhjVCM8egOg8sQXb3Vw3mUvZ0FKa7tqrVnKcyFxO7tU2YoisR716CWFouGY5KKtg5F3GYFwM4YofqwF8FsWYngFz+qhLgvwC5vE2ZnBrNv3blILygELPTT4mW9AWZJrRMY1B3H3ViL2uWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XEUBELhB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D501FF806;
	Tue, 30 Jan 2024 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706605604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Md/QRckFQ8XEEzr6TWNIE9oaitb92qEoNgYzbqlzsU=;
	b=XEUBELhBf/qcCEJdZ7GGkMoeKE83LkGN/tqsC9MuPwv8HL232n48djsEnLrVmRxk+PqmIE
	KSelQZXotX/vTbPH6GSK9op86oLppKPdDZXPdBnbWVQ1d8LhPZWz0yPboKq8mdR1ci2DKR
	vou9E1plRADJG851EAilVmIsTRCQ7Ao6u0qWwIbS/PP+wN6zTYbE9kTMIzqAsnfxolXTS4
	FhxPBqTZx46sPYaFuYGK4Jc8b4OKoa4ez+jslfedaKH//bEWNXkMlqkk0F0M6J6SzBHn/b
	mycX81uDHUJFYsm//BZ0ymJV2aAj9cqt+6rZtRs0g2XMxIyl4iyJzZmxvbE6bg==
Message-ID: <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
Date: Tue, 30 Jan 2024 10:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
References: <20240127004331.1334804-1-davidm@egauge.net>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240127004331.1334804-1-davidm@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/27/24 01:43, David Mosberger-Tang wrote:
> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.

As already mentioned multiple times, I am skeptical about the validity of
keeping netdev registration before chip presence check, but I am not the
maintainer, so I let Ajay and Kalle decide for this. Aside from that, and from
the kasan warning which is not especially related to the series (and not
observed in nominal case), I still have a few minor comments below

> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
> changelog:
> V1: original version
> V2: Add missing forward declarations
> V3: Add missing forward declarations, actually :-(
> V4: - rearranged function order to improve readability
>     - now relative to wireless-next repository
>     - avoid change error return value and have lower-level functions
>       directly return -ENODEV instead
>     - removed any mention of WILC3000
>     - export and use existing is_wilc1000() for chipid validation
>     - replaced strbool() function with open code
> 
>  drivers/net/wireless/microchip/wilc1000/spi.c | 74 ++++++++++++++-----
>  .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
>  .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
>  3 files changed, 59 insertions(+), 19 deletions(-)

[...]

> @@ -1142,7 +1170,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
>  	}
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
> -		return ret;
> +		return -ENODEV;

You are still rewriting error codes here. At a lower level, sure, but still...
When I suggested setting -ENODEV at lower level, I was thinking about places
where no explicit error code was already in use, but
spi_internal_read/spi_internal_write already generate proper error codes. Or am
I missing a constraint, like the probe chain really needing -ENODEV ?

>  	}
>  
>  	/* set up the desired CRC configuration: */
> @@ -1165,7 +1193,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
>  		dev_err(&spi->dev,
>  			"[wilc spi %d]: Failed internal write reg\n",
>  			__LINE__);
> -		return ret;
> +		return -ENODEV;
>  	}
>  	/* update our state to match new protocol settings: */
>  	spi_priv->crc7_enabled = enable_crc7;
> @@ -1176,17 +1204,27 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
>  
>  	spi_priv->probing_crc = false;
>  
> +	return 0;
> +}
> +
> +static int wilc_validate_chipid(struct wilc *wilc)
> +{
> +	struct spi_device *spi = to_spi_device(wilc->dev);
> +	u32 chipid;
> +	int ret;
> +
>  	/*
>  	 * make sure can read chip id without protocol error
>  	 */
>  	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
>  	if (ret) {
>  		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> -		return ret;
> +		return -ENODEV;
> +	}
> +	if (!is_wilc1000(chipid)) {
> +		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
> +		return -ENODEV;
>  	}
> -
> -	spi_priv->isinit = true;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 6b2f2269ddf8..3130a3ea8d71 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -12,10 +12,11 @@
>  
>  #define WAKE_UP_TRIAL_RETRY		10000
>  
> -static inline bool is_wilc1000(u32 id)
> +bool is_wilc1000(u32 id)
>  {
>  	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
>  }
> +EXPORT_SYMBOL_GPL(is_wilc1000);

nit: Since the function is not static anymore, it would have been nice to move
it with the other exported functions to maintain the existing functions ordering

>  static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
>  {
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
> index f02775f7e41f..ebdfb0afaf71 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> @@ -409,6 +409,7 @@ struct wilc_cfg_rsp {
>  
>  struct wilc_vif;
>  
> +bool is_wilc1000(u32 id);
>  int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
>  				u32 buffer_size);
>  int wilc_wlan_start(struct wilc *wilc);

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


