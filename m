Return-Path: <linux-wireless+bounces-11062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39E94A16C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01971C2256E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA21C4615;
	Wed,  7 Aug 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFGPHx0j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C521C4601;
	Wed,  7 Aug 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014777; cv=none; b=llnMXyEAWgJS1xSKVHfMizzFidbQakpM5ON10KVFhuCmwnazv1tv1VBitdnOSGRE0HczkvFcfAdUqepVLZrmI9Y3kPscmsF7hjgfJRJ66Rn/sRcpozaDBjkc3z3uJYJ6HlNtyP+EmPLBSg6iXv+0HCcGtTYNxGwKMCJKhaaeY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014777; c=relaxed/simple;
	bh=lCiE5ym/oCHFgZrrUzyDhcsP7DhZ6ALw+YqZgLBCark=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBvy/UwuW6tpCHuvAh9bnSmJ5nj2fq3b/W28mG3JjAtdA8D2KJnNl4nz9PyvCKkE9dSCNsOyP50RBKv8uK7lEGswZBdUPL8MjtRqDLU3v+zrWwKR7nBbj1r8rz0GHsMxo4HV/b/C7x1hcKy3Ha2F1nIx9G42aVxxQ2Qyr1Ek2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFGPHx0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBBEC32782;
	Wed,  7 Aug 2024 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723014776;
	bh=lCiE5ym/oCHFgZrrUzyDhcsP7DhZ6ALw+YqZgLBCark=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hFGPHx0jLVGEUFj47JkFUsCVaOXmPDPXsk5BclQOV4bXqukUlv4es6cEIHAIjosE5
	 3bhlPka42+xGq/6WyF6b9qY4dhwhU7PBLpVrIjtnOyMXjHcmaqjPuqWuU6Ql6bCXfB
	 FYUHgb0zsbFayB+bbg0ubQp07tufp/8aqSmEKYbcPUjixqgs+nWAe/q67wRqqBgU7U
	 fl34CzsMhONWHh01sU/hJPQfOHsMsuEhsishqNHqiUH2t8oJBadF837KPwpRl0zuGR
	 JdOd/eIagXfLqVCE/A9p45ajMb6G2uEwwtMbMOHev7ETnaqxzU2eZTuPs8EKv+wBBn
	 O4ywvTp5kKRiA==
Message-ID: <5020193f-64f5-48ff-8597-8e6a5ca0fb36@kernel.org>
Date: Wed, 7 Aug 2024 09:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] wifi: cc33xx: Add sdio.c, io.c, io.h
To: Michael Nemanov <michael.nemanov@ti.com>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-4-michael.nemanov@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240806170018.638585-4-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 19:00, Michael Nemanov wrote:
> sdio.c implements SDIO transport functions. These are bound into
> struct cc33xx_if_operations and accessed via io.h in order to abstract
> multiple transport interfaces such as SPI in the future.
> The CC33xx driver supports the SDIO in-band IRQ option so the IRQ from
> the device received here as well.
> Unlike wl1xxx products, there is no longer mapping between
> HW and SDIO / SPI address space of any kind.
> There are only 3 valid addresses for control, data and status
> transactions each with a predefined structure.
> 
> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>


...

> +
> +#include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/host.h>
> +#include <linux/gpio.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of_irq.h>
> +
> +#include "cc33xx.h"
> +#include "io.h"
> +
> +#ifndef SDIO_VENDOR_ID_TI
> +#define SDIO_VENDOR_ID_TI		0x0097
> +#endif
> +
> +#define SDIO_DEVICE_ID_CC33XX_NO_EFUSE	0x4076
> +#define SDIO_DEVICE_ID_TI_CC33XX	0x4077
> +
> +static bool dump;

Drop.

> +
> +struct cc33xx_sdio_glue {
> +	struct device *dev;
> +	struct platform_device *core;
> +};
> +
> +static const struct sdio_device_id cc33xx_devices[] = {
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_CC33XX) },
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_CC33XX_NO_EFUSE) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(sdio, cc33xx_devices);

Keep all tables next to each other - bottom of the driver. Spreading
same type of structures over the file does not help in review.

> +


> +
> +static struct cc33xx_if_operations sdio_ops_gpio_irq = {

Why this is not const?

> +	.interface_claim	= cc33xx_sdio_claim,
> +	.interface_release	= cc33xx_sdio_release,
> +	.read			= cc33xx_sdio_raw_read,
> +	.write			= cc33xx_sdio_raw_write,
> +	.power			= cc33xx_sdio_set_power,
> +	.set_block_size	= cc33xx_sdio_set_block_size,
> +	.set_irq_handler	= cc33xx_set_irq_handler,
> +	.disable_irq		= cc33xx_disable_line_irq,
> +	.enable_irq		= cc33xx_enable_line_irq,
> +};
> +
> +static struct cc33xx_if_operations sdio_ops_inband_irq = {
> +	.interface_claim	= cc33xx_sdio_claim,
> +	.interface_release	= cc33xx_sdio_release,
> +	.read			= cc33xx_sdio_raw_read,
> +	.write			= cc33xx_sdio_raw_write,
> +	.power			= cc33xx_sdio_set_power,
> +	.set_block_size	= cc33xx_sdio_set_block_size,
> +	.set_irq_handler	= cc33xx_set_irq_handler,
> +	.disable_irq		= cc33xx_sdio_disable_irq,
> +	.enable_irq		= cc33xx_sdio_enable_irq,
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct cc33xx_family_data cc33xx_data = {
> +	.name = "cc33xx",
> +	.cfg_name = "ti-connectivity/cc33xx-conf.bin",
> +	.nvs_name = "ti-connectivity/cc33xx-nvs.bin",
> +};
> +
> +static const struct of_device_id cc33xx_sdio_of_match_table[] = {
> +	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
> +	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
> +	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
> +	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
> +	{ }
> +};


Eh? What happened here? So devices are compatibles thus make them
compatible in the bindings.

> +
> +static int sdio_cc33xx_probe(struct sdio_func *func,
> +			     const struct sdio_device_id *id)
> +{
> +	struct cc33xx_platdev_data *pdev_data;
> +	struct cc33xx_sdio_glue *glue;
> +	struct resource res[1];
> +	mmc_pm_flag_t mmcflags;
> +	int ret = -ENOMEM;
> +	int gpio_irq, wakeirq, irq_flags;
> +	const char *chip_family;
> +
> +	/* We are only able to handle the wlan function */
> +	if (func->num != 0x02)
> +		return -ENODEV;
> +
> +	pdev_data = devm_kzalloc(&func->dev, sizeof(*pdev_data), GFP_KERNEL);
> +	if (!pdev_data)
> +		return -ENOMEM;
> +
> +	glue = devm_kzalloc(&func->dev, sizeof(*glue), GFP_KERNEL);
> +	if (!glue)
> +		return -ENOMEM;
> +
> +	glue->dev = &func->dev;
> +
> +	/* Grab access to FN0 for ELP reg. */
> +	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
> +
> +	/* Use block mode for transferring over one block size of data */
> +	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> +
> +	ret = cc33xx_probe_of(&func->dev, &gpio_irq, &wakeirq, pdev_data);
> +	if (ret)
> +		goto out;
> +
> +	/* if sdio can keep power while host is suspended, enable wow */
> +	mmcflags = sdio_get_host_pm_caps(func);
> +	dev_dbg(glue->dev, "sdio PM caps = 0x%x\n", mmcflags);
> +
> +	sdio_set_drvdata(func, glue);
> +
> +	/* Tell PM core that we don't need the card to be powered now */
> +	pm_runtime_put_noidle(&func->dev);
> +
> +	chip_family = "cc33xx";

That's usless assignment.
> +
> +	glue->core = platform_device_alloc(chip_family, PLATFORM_DEVID_AUTO);
> +	if (!glue->core) {
> +		dev_err(glue->dev, "can't allocate platform_device");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	glue->core->dev.parent = &func->dev;
> +
> +	if (gpio_irq) {
> +		dev_info(glue->dev, "Using GPIO as IRQ\n");

Drop. Driver should be silent.

> +
> +		irq_flags = irqd_get_trigger_type(irq_get_irq_data(gpio_irq));
> +
> +		irq_set_status_flags(gpio_irq, IRQ_NOAUTOEN);
> +
> +		if (irq_flags & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +			irq_flags |= IRQF_ONESHOT;
> +
> +		ret = request_threaded_irq(gpio_irq, gpio_irq_hard_handler,
> +					   gpio_irq_thread_handler,
> +					   irq_flags, glue->core->name, func);
> +		if (ret) {
> +			dev_err(glue->dev, "can't register GPIO IRQ handler\n");
> +			goto out_dev_put;
> +		}
> +
> +		pdev_data->gpio_irq_num = gpio_irq;
> +
> +		if ((mmcflags & MMC_PM_KEEP_POWER) &&
> +		    (enable_irq_wake(gpio_irq) == 0))
> +			pdev_data->pwr_in_suspend = true;
> +
> +		pdev_data->if_ops = &sdio_ops_gpio_irq;
> +	} else {
> +		dev_info(glue->dev, "Using SDIO in-band IRQ\n");
> +
> +		pdev_data->if_ops = &sdio_ops_inband_irq;
> +	}
> +
> +	if (wakeirq > 0) {
> +		res[0].start = wakeirq;
> +		res[0].flags = IORESOURCE_IRQ |
> +			irqd_get_trigger_type(irq_get_irq_data(wakeirq));
> +		res[0].name = "wakeirq";
> +
> +		ret = platform_device_add_resources(glue->core, res, 1);
> +		if (ret) {
> +			dev_err(glue->dev, "can't add resources\n");
> +			goto out_dev_put;
> +		}
> +	}
> +
> +	ret = platform_device_add_data(glue->core, pdev_data,
> +				       sizeof(*pdev_data));
> +	if (ret) {
> +		dev_err(glue->dev, "can't add platform data\n");
> +		goto out_dev_put;
> +	}
> +
> +	ret = platform_device_add(glue->core);
> +	if (ret) {
> +		dev_err(glue->dev, "can't add platform device\n");
> +		goto out_dev_put;
> +	}
> +	return 0;
> +
> +out_dev_put:
> +	platform_device_put(glue->core);
> +
> +	if (pdev_data->gpio_irq_num)
> +		free_irq(pdev_data->gpio_irq_num, func);
> +
> +out:
> +	return ret;
> +}
> +
> +static void sdio_cc33xx_remove(struct sdio_func *func)
> +{
> +	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
> +	struct platform_device *pdev = glue->core;
> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
> +
> +	/* Undo decrement done above in sdio_cc33xx_probe */
> +	pm_runtime_get_noresume(&func->dev);
> +
> +	platform_device_unregister(glue->core);
> +
> +	if (pdev_data->gpio_irq_num) {
> +		free_irq(pdev_data->gpio_irq_num, func);
> +		if (pdev_data->pwr_in_suspend)
> +			disable_irq_wake(pdev_data->gpio_irq_num);
> +	} else {
> +		sdio_claim_host(func);
> +		sdio_release_irq(func);
> +		sdio_release_host(func);
> +	}
> +}
> +
> +#ifdef CONFIG_PM
> +static int cc33xx_suspend(struct device *dev)
> +{
> +	/* Tell MMC/SDIO core it's OK to power down the card
> +	 * (if it isn't already), but not to remove it completely
> +	 */
> +	struct sdio_func *func = dev_to_sdio_func(dev);
> +	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
> +	struct cc33xx *cc = platform_get_drvdata(glue->core);
> +	mmc_pm_flag_t sdio_flags;
> +	int ret = 0;
> +
> +	if (!cc) {
> +		dev_err(dev, "no wilink module was probed\n");
> +		goto out;
> +	}
> +
> +	dev_dbg(dev, "cc33xx suspend. keep_device_power: %d\n",
> +		cc->keep_device_power);
> +
> +	if (cc->keep_device_power) {
> +		sdio_flags = sdio_get_host_pm_caps(func);
> +
> +		if (!(sdio_flags & MMC_PM_KEEP_POWER)) {
> +			dev_err(dev, "can't keep power while host is suspended\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		/* keep power while host suspended */
> +		ret = sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
> +		if (ret) {
> +			dev_err(dev, "error while trying to keep power\n");
> +			goto out;
> +		}
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int cc33xx_resume(struct device *dev)
> +{
> +	dev_dbg(dev, "cc33xx resume\n");

I asked to drop such silly confirmation messages. Kernel has already
infrastructure for this.

> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cc33xx_sdio_pm_ops = {
> +	.suspend	= cc33xx_suspend,
> +	.resume		= cc33xx_resume,
> +};
> +
> +static struct sdio_driver cc33xx_sdio_driver = {
> +	.name		= "cc33xx_sdio",
> +	.id_table	= cc33xx_devices,
> +	.probe		= sdio_cc33xx_probe,
> +	.remove		= sdio_cc33xx_remove,
> +	.drv = {
> +		.pm = &cc33xx_sdio_pm_ops,
> +	},
> +};
> +#else

No, that's terrible, you cannot have two drivers! Look how drivers are
doing - there is a wrapper or just use maybe_unused.

> +static struct sdio_driver cc33xx_sdio_driver = {
> +	.name		= "cc33xx_sdio",
> +	.id_table	= cc33xx_devices,
> +	.probe		= sdio_cc33xx_probe,
> +	.remove		= sdio_cc33xx_remove,
> +};
> +#endif /* CONFIG_PM */
> +
> +static int __init sdio_cc33xx_init(void)
> +{
> +	return sdio_register_driver(&cc33xx_sdio_driver);
> +}
> +
> +static void __exit sdio_cc33xx_exit(void)
> +{
> +	sdio_unregister_driver(&cc33xx_sdio_driver);
> +}
> +
> +module_init(sdio_cc33xx_init);
> +module_exit(sdio_cc33xx_exit);

Look at other drivers how they do it - there is a wrapper.

> +
> +module_param(dump, bool, 0600);
> +MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");

This should be rather debug interface, not module param.

> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("SDIO transport for Texas Instruments CC33xx WLAN driver");
> +MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
> +MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");

Best regards,
Krzysztof


