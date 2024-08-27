Return-Path: <linux-wireless+bounces-12048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACAD960648
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038A7283CBB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1F149E0E;
	Tue, 27 Aug 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P9zCBjKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AA19DF59
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752409; cv=none; b=GFHPgZoLhwvf+Po4DgLQlWXz4f2Ol2a2aQ6IRqkAwpLYN61wzVW25PNyItNj45n4eIBBuklFAmlTxuKESCJaZ/hTcnWR2dmIcGoMZam7tlw+Wjda+Nghks7SIkwBwodrDnbwALq44Z0ZZrPe4oSdNB6SYSMkLGuJSGKJYsMFm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752409; c=relaxed/simple;
	bh=UOdt3ZcbGkDZ1SwFjxgBBFABMkdt+sCTJtJNXOm2tAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqJkqlCNbsimEefJIiikmEpyQJDCFA1qA0w7sZWpUcKVWccXw+GuvApeOSklLddMC2YRVHP240ISH5VsnI9iZJS8qPTgrHCrahSgvdX+DuRP8BqyGDDBRiR5+ofhYD+oRiMnmXc1l6oWgPYUaVoTaWDGGYMpFt5S7JU72qmFviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P9zCBjKJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 353FD240006;
	Tue, 27 Aug 2024 09:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724752398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2UWgNbznlgDwOQIBrAHEbDApGWxpuKWx9dAxpz1gjM=;
	b=P9zCBjKJWl582JJD3/HjXyZpuUO+JItFYBT63PkLORyX8FpJ0pXxxLPdlzymWT6i8x0DdI
	vy5CD9rK+hMUpEjsq3mtOw8Om6KvF5/+3SLSaunzXl2nXhp1Pa96rCBKFfGfdJRaptCKsa
	cMaw1la5QTTp7VSxlYp9Az1r4QnQwlUIZVDHsLa2IiGT1zJB5cT8NdA/799TNycT3LckfG
	odEnbaz+jHflQXrWVnR3AZ1lA6bPEBaoqz5WvJ13ie2AciwKBf0b9Hz6zFey3i4RiJ+Q7A
	kxFVHaGD98Vwu9hceHgs7ZvlZPPRoCB/aGMD8pTczgZzv7vjdZKtgUpt9GrcGQ==
Message-ID: <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
Date: Tue, 27 Aug 2024 11:53:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240821183823.163268-1-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240821183823.163268-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/21/24 20:37, Marek Vasut wrote:
> The WILC3000 can suspend and enter low power state. According to local
> measurements, the WILC3000 consumes the same amount of power if the slot
> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
> off. Use the former option, keep the WILC3000 powered up as that allows
> for things like WoWlan to work.
> 
> Note that this is tested on WILC3000 only, not on WILC1000 .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-wireless@vger.kernel.org
> ---
>  drivers/net/wireless/microchip/wilc1000/sdio.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
> index 683a35c682a8f..41122199d51eb 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -973,7 +973,6 @@ static int wilc_sdio_suspend(struct device *dev)
>  {
>  	struct sdio_func *func = dev_to_sdio_func(dev);
>  	struct wilc *wilc = sdio_get_drvdata(func);
> -	int ret;
>  
>  	dev_info(dev, "sdio suspend\n");
>  
> @@ -987,13 +986,7 @@ static int wilc_sdio_suspend(struct device *dev)
>  
>  	wilc_sdio_disable_interrupt(wilc);
>  
> -	ret = wilc_sdio_reset(wilc);
> -	if (ret) {
> -		dev_err(&func->dev, "Fail reset sdio\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
>  }

This change breaks suspend/resume on my wilc1000 setup (sama5d2 wlsom evk +
wilc1000 sd):

# echo mem > /sys/power/state
PM: suspend entry (deep)
Filesystems sync: 0.055 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.018 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.006 seconds)
wilc1000_sdio mmc0:0001:1: sdio suspend
wilc1000_sdio mmc0:0001:1: PM: dpm_run_callback(): pm_generic_suspend returns -22
wilc1000_sdio mmc0:0001:1: PM: failed to suspend async: error -22
PM: Some devices failed to suspend, or early wake event detected
OOM killer enabled.
Restarting tasks ... done.
random: crng reseeded on system resumption
PM: suspend exit
sh: write error: Invalid argument

But I have to dig more to really understand the root cause.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


