Return-Path: <linux-wireless+bounces-14683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834519B5106
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083B81F2252E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E97200C85;
	Tue, 29 Oct 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fskBfInQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F71D5CD6;
	Tue, 29 Oct 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223265; cv=none; b=bHA31+W1Xfjr5HmgVqr9IHx4Xn3IEGf2yxP5887zS/Xd8H0LBa1TI/9LQRQjSaORozc/0KUulsbURpzhoUqZ45A6QvKdv5pZUO+jEbiQDKV0doV9dQdYF+YzHa80rzvNud9MIElOFmuKuJ+Q4bUJWaBAbnOfRjZ4vBGv27g4rY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223265; c=relaxed/simple;
	bh=3g0p2tDhh+R0D+c6XvvKGkeoeP0gW3rm59HIK5YxF5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8SWCoC98D1XsQlWglVLfFRpigK16PZWOnYLQJPLnbqyy+PcsY8OWGnLSb/OWs6R+jjHTiKIRe/UDPJP5M27XwfmhgM8hZZHAV3u3oiYkeobQu/CABoPzdb2+jMcqoKaxFolRlyuFGcNM5KRzOtaBgrmVZrLaANcuy1OxV2C7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fskBfInQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFCDC4CEE4;
	Tue, 29 Oct 2024 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730223264;
	bh=3g0p2tDhh+R0D+c6XvvKGkeoeP0gW3rm59HIK5YxF5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fskBfInQPb9slhqLvkZEC0UaitcPPXnryTO0C5+mk7a6L0yUbkzhi2qUHoY31L9xl
	 DONXv/2KnJAxTYYW8r597tybHkC93ESd8EXZeOUTSUDKtBWVwApKkLFqhRAJ3Ogrfz
	 /1LRFz36cfv7w3Ya8y5rvWcKhH5HH0lZ0Hzk2dZOCvWkGXhfrH7ujvnwmnmzrH4/Hf
	 C69smfNkXJAa6FNUEiWtezB2hmKI2rK2BO803+pVToMLNOvEsaMo8QeI9nSHbDT8cp
	 5IChbCb3vbOhgkEwo4EgxfUupkWIAlmpZOv8BG/V4Q16vwNa0wLMLXl/VvCoWIH3gR
	 w0V/m90No7aKA==
Message-ID: <9aff2bed-bca4-482b-83ea-4cd945812817@kernel.org>
Date: Tue, 29 Oct 2024 18:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] wifi: cc33xx: Add sdio.c, io.c, io.h
To: Michael Nemanov <michael.nemanov@ti.com>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-5-michael.nemanov@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241029172354.4027886-5-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 18:23, Michael Nemanov wrote:
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
> ---
>  drivers/net/wireless/ti/cc33xx/io.c   | 129 +++++++
>  drivers/net/wireless/ti/cc33xx/io.h   |  26 ++
>  drivers/net/wireless/ti/cc33xx/sdio.c | 530 ++++++++++++++++++++++++++
>  3 files changed, 685 insertions(+)
>  create mode 100644 drivers/net/wireless/ti/cc33xx/io.c
>  create mode 100644 drivers/net/wireless/ti/cc33xx/io.h
>  create mode 100644 drivers/net/wireless/ti/cc33xx/sdio.c
> 
> diff --git a/drivers/net/wireless/ti/cc33xx/io.c b/drivers/net/wireless/ti/cc33xx/io.c
> new file mode 100644
> index 000000000000..59696004efe9
> --- /dev/null
> +++ b/drivers/net/wireless/ti/cc33xx/io.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "cc33xx.h"
> +#include "debug.h"
> +#include "io.h"
> +#include "tx.h"
> +
> +bool cc33xx_set_block_size(struct cc33xx *cc)
> +{
> +	if (cc->if_ops->set_block_size) {
> +		cc->if_ops->set_block_size(cc->dev, CC33XX_BUS_BLOCK_SIZE);
> +		cc33xx_debug(DEBUG_CC33xx,
> +			     "Set BLKsize to %d", CC33XX_BUS_BLOCK_SIZE);
> +		return true;
> +	}
> +
> +	cc33xx_debug(DEBUG_CC33xx, "Could not set BLKsize");
> +	return false;
> +}
> +
> +void cc33xx_disable_interrupts_nosync(struct cc33xx *cc)
> +{
> +	cc->if_ops->disable_irq(cc->dev);
> +}
> +
> +void cc33xx_irq(void *cookie);

Why do you need forward declaration of non-static function? If you need
it, it means you had W=1 warning which you fixed incorrect way.

Regardless, be sure this code has 0 warnings on clang with W=1.


> +void cc33xx_enable_interrupts(struct cc33xx *cc)
> +{
> +	cc->if_ops->enable_irq(cc->dev);
> +
> +	cc33xx_irq(cc);
> +}

...


> +static const struct cc33xx_if_operations sdio_ops_inband_irq = {
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
> +	{ .compatible = "ti,cc33xx", .data = &cc33xx_data },

This is supposed to be your base variant.

> +	{ }
> +};

Missing MODULE_DEVICE_TABLE... or you do not autoload this based on OF
matching? That's a bit surprising, I don't remember how SDIO bus handles
it. But for other buses this is unexpected and usually not correct.

> +

...

> +
> +static struct sdio_driver cc33xx_sdio_driver = {
> +	.name		= "cc33xx_sdio",
> +	.id_table	= cc33xx_devices,
> +	.probe		= sdio_cc33xx_probe,
> +	.remove		= sdio_cc33xx_remove,
> +#ifdef CONFIG_PM
> +	.drv = {
> +		.pm = &cc33xx_sdio_pm_ops,
> +	},
> +#endif /* CONFIG_PM */
> +};
> +
> +MODULE_DEVICE_TABLE(sdio, cc33xx_devices);

This is always next to the table.

> +
> +module_sdio_driver(cc33xx_sdio_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("SDIO transport for Texas Instruments CC33xx WLAN driver");
> +MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
> +MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");

Best regards,
Krzysztof


