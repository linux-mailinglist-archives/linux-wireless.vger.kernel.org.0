Return-Path: <linux-wireless+bounces-30837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA1D2205C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 02:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5549530060ED
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFD1C5D72;
	Thu, 15 Jan 2026 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UAvm1yuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7A25776;
	Thu, 15 Jan 2026 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768440393; cv=none; b=IHrKYh/DNx9teRk9G0wYvgOD15VcGfQRq6CmZCY2VacCHPmROTtW9giPDLwsjmfgHAUJarFWPTluW2+pG7Sgu/4T7ossM/pYh7d0spbZknvBq9MzbAzOjKfaWBH5U7QE5PlfI22oOFU/20OFMLmNv+RP4VOpUJo85tmtzQZ+S8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768440393; c=relaxed/simple;
	bh=0k1QAMOCPQDEZ2u+NacYp9o5b2kS5rhRMjyWVXLRlts=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pd80WLEIR8xI+BCwmHMhWjrMeQZWgZnuSYWWyZbdla9a+VUkmCr9T0JtbtNIVkd1qSNzZzhAQJC/bwi4YvE4v9y9xnQQanbTSEqlTG1LcGkSHLYXKKjRkpEWYcdMPSYQU6p+HWzKdVnAOs8eVwGGUCbMtgJoVHqZDlSOLqwT/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UAvm1yuV; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30b1e7c8c;
	Thu, 15 Jan 2026 09:26:21 +0800 (GMT+08:00)
Message-ID: <ee62632a-34cb-494a-ad87-bd18a58d6a7c@rock-chips.com>
Date: Thu, 15 Jan 2026 09:26:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-wireless@vger.kernel.org,
 linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bbf42c1d009cckunm8959bb2750dd53
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlMTFYYSk1PHU4fSxgdGEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UAvm1yuVGKjyJmIC1fDsjq3Y3166Haf7JD4mXTzCy902SuYYc3GsDsLqnThTI8xjKJw/DB5mVcGpM45ZUg5uNf5M3ogfpZXWeAV7cLG4LfUpdJLbdMLcYmdXtfEOFnnMdwiynQ+2Wz4y5h6Za7qixm5Tus6LnBWwBuxgMYnCo0A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=EyqykLUI/0mpJaTZt1HtmZTxG8qK5R8vFWQbXShUaHE=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/12 星期一 23:46, Uwe Kleine-König 写道:
> To prepare sdio drivers to migrate away from struct device_driver::shutdown
> (and then eventually remove that callback) create a serdev driver shutdown

/s/serdev driver/sdio driver ?

> callback and migration code to keep the existing behaviour. Note this
> introduces a warning for each driver that isn't converted yet to that
> callback at register time.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>   drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
>   include/linux/mmc/sdio_func.h |  1 +
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 10799772494a..6e5bdc2f0cc8 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
>   		pm_runtime_put_sync(dev);
>   }
>   
> +static void sdio_bus_shutdown(struct device *dev)
> +{
> +	struct sdio_driver *drv = to_sdio_driver(dev->driver);
> +	struct sdio_func *func = dev_to_sdio_func(dev);
> +
> +	if (dev->driver && drv->shutdown)
> +		drv->shutdown(func);
> +}

Seem bogus check as a few line ahead, you used dev->driver to get
sdio_driver already. Otherwise the reset looks good.

> +
>   static const struct dev_pm_ops sdio_bus_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
>   	SET_RUNTIME_PM_OPS(
> @@ -248,6 +257,7 @@ static const struct bus_type sdio_bus_type = {
>   	.uevent		= sdio_bus_uevent,
>   	.probe		= sdio_bus_probe,
>   	.remove		= sdio_bus_remove,
> +	.shutdown	= sdio_bus_shutdown,
>   	.pm		= &sdio_bus_pm_ops,
>   };
>   
> @@ -261,6 +271,14 @@ void sdio_unregister_bus(void)
>   	bus_unregister(&sdio_bus_type);
>   }
>   
> +static void sdio_legacy_shutdown(struct sdio_func *func)
> +{
> +	struct device *dev = &func->dev;
> +	struct device_driver *driver = dev->driver;
> +
> +	driver->shutdown(dev);
> +}
> +
>   /**
>    *	__sdio_register_driver - register a function driver
>    *	@drv: SDIO function driver
> @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv, struct module *owner)
>   	drv->drv.bus = &sdio_bus_type;
>   	drv->drv.owner = owner;
>   
> +	/*
> +	 * This driver needs updating. Note that driver_register() warns about
> +	 * this, so we're not adding another warning here.
> +	 */
> +	if (!drv->shutdown && drv->drv.shutdown)
> +		drv->shutdown = sdio_legacy_shutdown;
> +
>   	return driver_register(&drv->drv);
>   }
>   EXPORT_SYMBOL_GPL(__sdio_register_driver);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index fed1f5f4a8d3..4534bf462aac 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -78,6 +78,7 @@ struct sdio_driver {
>   
>   	int (*probe)(struct sdio_func *, const struct sdio_device_id *);
>   	void (*remove)(struct sdio_func *);
> +	void (*shutdown)(struct sdio_func *);
>   
>   	struct device_driver drv;
>   };


