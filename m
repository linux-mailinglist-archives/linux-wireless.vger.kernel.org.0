Return-Path: <linux-wireless+bounces-12083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D45961469
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7665B28328D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104F1CDFCE;
	Tue, 27 Aug 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="H+a47Emi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7561803D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776965; cv=none; b=LS977o8ABZJ9jW9Vkm8HeC2g+iNKLrO1tLuoZe1E6/LXrSrxGkGEdyR1tENWYiw/SorbjZzSmq6kbsF04v3W9OxTuDj2XK52CBuv1f/K84m7/IoJfG9JokYTWLCJ8N3TN5hclCFVG5e+IhvoK1zEXs3jWikAhyJj7UyMrY6FoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776965; c=relaxed/simple;
	bh=aWwuJTJ/hM30qHYLASs4Mn9NPQ2ERBhrpF/JuxNkxzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQM3xTqFS3l4hoC1xzCzmqp3B3evEaXHIlUg8FO+yKPaw34Vl68bMxjuS4Rq0R8udbRC6KqXw531qsshHB6S/1Ke/ZmQk5YhFOer+UirHnTVI3te1grkadgNenccM9bzYvYwOfWs7uR6u6UAn6TAOCJVULMpQ1wPd3a6mamstvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=H+a47Emi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D03BE886E5;
	Tue, 27 Aug 2024 18:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776962;
	bh=CVBcbsjk1/R0CtCN8+IqERc4hhAdmez/fkFa/Ow6mCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+a47Emi6xhfe1kaPZq7QdidxN6wwHNJr+lNpbigET3lVOh9PhQ9gyexIYAorEFJ0
	 xtjrRxzyvefZrjCZZWnozgCeShzF9S2+T5hz75GL8MvG+Q2xm8cZAMNNTYV5brVwVm
	 TgieM6Debfp+a/xi7is61eKzIZxOT3VQBPgM8wSwk7UdnOn3ksyeviR85+GhgSTjH/
	 bJlH3wjcpJXih8+3dzY1Jy8yHOoEQpPB03YWa3XVZsJeS5p4vpdU+AJugVJ+rXkDrZ
	 bA30zgskUdNlzT0x6X7GpsZFOq1RJNtiNzBny8hJUy4Vj/hUi1+BWesjMPKu5cpPFs
	 E6YQld2ughHeg==
Message-ID: <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
Date: Tue, 27 Aug 2024 17:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/27/24 11:53 AM, Alexis Lothoré wrote:

Hi,

>> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> index 683a35c682a8f..41122199d51eb 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> @@ -973,7 +973,6 @@ static int wilc_sdio_suspend(struct device *dev)
>>   {
>>   	struct sdio_func *func = dev_to_sdio_func(dev);
>>   	struct wilc *wilc = sdio_get_drvdata(func);
>> -	int ret;
>>   
>>   	dev_info(dev, "sdio suspend\n");
>>   
>> @@ -987,13 +986,7 @@ static int wilc_sdio_suspend(struct device *dev)
>>   
>>   	wilc_sdio_disable_interrupt(wilc);
>>   
>> -	ret = wilc_sdio_reset(wilc);
>> -	if (ret) {
>> -		dev_err(&func->dev, "Fail reset sdio\n");
>> -		return ret;
>> -	}
>> -
>> -	return 0;
>> +	return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
>>   }
> 
> This change breaks suspend/resume on my wilc1000 setup (sama5d2 wlsom evk +
> wilc1000 sd):
> 
> # echo mem > /sys/power/state
> PM: suspend entry (deep)
> Filesystems sync: 0.055 seconds
> Freezing user space processes
> Freezing user space processes completed (elapsed 0.018 seconds)
> OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.006 seconds)
> wilc1000_sdio mmc0:0001:1: sdio suspend
> wilc1000_sdio mmc0:0001:1: PM: dpm_run_callback(): pm_generic_suspend returns -22
> wilc1000_sdio mmc0:0001:1: PM: failed to suspend async: error -22
> PM: Some devices failed to suspend, or early wake event detected
> OOM killer enabled.
> Restarting tasks ... done.
> random: crng reseeded on system resumption
> PM: suspend exit
> sh: write error: Invalid argument
> 
> But I have to dig more to really understand the root cause.

Does your MMC controller struct mmc_host set .pm_caps |= 
MMC_PM_KEEP_POWER ? Maybe that's the problem, that the controller does 
not set these PM caps ?

