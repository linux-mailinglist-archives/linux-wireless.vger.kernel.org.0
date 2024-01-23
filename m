Return-Path: <linux-wireless+bounces-2370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052C838B93
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EB22850DF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE45C602;
	Tue, 23 Jan 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QxiXuqr7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F55C606
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005123; cv=none; b=ILQ1sp22G1ybCcdAL1FpT6uDjv70/Q1LS8GRCDNxQiedPb4ZpxR2at8iQIlBTYe4QEaU5k7QWm6OqSmg2/HGQbFMRwPeKEy0SomhqXgmkAXoArch5l2qtTen0m+5sTkL+WHU+6/X4Hodm2S16HevNGNUW4z0k2rCnQOM7n/iMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005123; c=relaxed/simple;
	bh=NV98lc7eSV19eSSAQb3ODStrwRnCdX6s3rgDEUnj+M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBxR83/v9FQ+BrS8fiWmk8FmFGJwy1Tp34aqYvNgbZ16V2UjjKja0YkW/VuT0B6Z77W9deA8RV7v32zxLw1bFowOrThEV9snLuymXtlOUsiYxZnikc0Sz+h1j6TV6fQdLrck3knDPjTkoc6AUryLxI7w2MWAHoVHa2dY0p+EAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QxiXuqr7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CE5BC0005;
	Tue, 23 Jan 2024 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706005118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j+25rjUPZ0lcBxepLLK7HSCfrTHFZ2VJyA3r+fA81s=;
	b=QxiXuqr7R3HI5fEnOGPOR0uzlQp4gq6YYVrFDaILopDlhHjP3Aw9SJ+wxdQxEhLE0Nxeyo
	fmuQ6B5BkK7oTWpR3qqgv0CyxJwMpIr4OvjiJp2+1cGWMBVtDdYT+CadlYDizRprIxXB0b
	RcOIWN5cd81NKR7NtwSLyQFcUrBamA6tQG8p5DmVweILQJfraOtDJFisHp7Loh+QybAbXh
	9tCjEwxDAB/H+VZJAxXYqiO9XhFHcPCICFBvkQaGYlxQJytKggTExRnVPzxsXOFo2h10pc
	NQG4vNr6r5F2QNVpz63Sv2YrYiEzDeCN+PLW9uOtN3UsFbgPspT9pEYkaWFXlA==
Message-ID: <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
Date: Tue, 23 Jan 2024 11:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
Content-Language: en-US
To: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240122220350.1449413-1-davidm@egauge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/22/24 23:03, David Mosberger-Tang wrote:
> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.

I would gladly help review/test the patch, but please give us some time between
versions to take a look (even if you can mention if you found issues yourself).
Also, each version should be a separate thread, bearing the new version in the
"Subject" line.
Additionally (to answer your cover letter), the patches must target the wireless
branches (likely wireless-testing), not linux-next
(https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)

> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
> V2 -> V3: Add missing forward declarations, actually :-(
> 
>  drivers/net/wireless/microchip/wilc1000/spi.c | 133 ++++++++++++------
>  .../net/wireless/microchip/wilc1000/wlan.h    |   1 +
>  2 files changed, 90 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
> index 77b4cdff73c3..dd6935dc1bc9 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -42,7 +42,7 @@ MODULE_PARM_DESC(enable_crc16,
>  #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
>  
>  struct wilc_spi {
> -	bool isinit;		/* true if SPI protocol has been configured */
> +	bool isinit;		/* true if wilc_spi_init was successful */
>  	bool probing_crc;	/* true if we're probing chip's CRC config */
>  	bool crc7_enabled;	/* true if crc7 is currently enabled */
>  	bool crc16_enabled;	/* true if crc16 is currently enabled */
> @@ -55,6 +55,8 @@ struct wilc_spi {
>  static const struct wilc_hif_func wilc_hif_spi;
>  
>  static int wilc_spi_reset(struct wilc *wilc);
> +static int wilc_spi_configure_bus_protocol(struct wilc *wilc);
> +static int wilc_validate_chipid(struct wilc *wilc);
>  
>  /********************************************
>   *
> @@ -232,6 +234,22 @@ static int wilc_bus_probe(struct spi_device *spi)
>  	}
>  	clk_prepare_enable(wilc->rtc_clk);
>  
> +	/* we need power to configure the bus protocol and to read the chip id: */
> +
> +	wilc_wlan_power(wilc, true);
> +
> +	ret = wilc_spi_configure_bus_protocol(wilc);
> +
> +	if (ret == 0)
> +		ret = wilc_validate_chipid(wilc);
> +
> +	wilc_wlan_power(wilc, false);
> +
> +	if (ret) {
> +		ret = -ENODEV;
> +		goto netdev_cleanup;

I have a working wilc-over-spi setup with which I can easily unplug the module,
so I gave a try to your series, and while the lack of chip detect indeed makes
the netdevice registration not executed, I've got a nasty kasan warning:

 driver_probe_device from __driver_attach+0x1a0/0x29c



                                                 [141/1863]
 __driver_attach from bus_for_each_dev+0xf0/0x14c
 bus_for_each_dev from bus_add_driver+0x130/0x288
 bus_add_driver from driver_register+0xd4/0x1c0
 driver_register from do_one_initcall+0xfc/0x204
 do_one_initcall from kernel_init_freeable+0x240/0x2a0
 kernel_init_freeable from kernel_init+0x20/0x144
 kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xc3163fb0 to 0xc3163ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Allocated by task 1:
 kasan_set_track+0x3c/0x5c
 __kasan_kmalloc+0x8c/0x94
 __kmalloc_node+0x64/0x184
 kvmalloc_node+0x48/0x114
 alloc_netdev_mqs+0x68/0x664
 alloc_etherdev_mqs+0x28/0x34
 wilc_netdev_ifc_init+0x34/0x37c
 wilc_cfg80211_init+0x278/0x330
 wilc_bus_probe+0xb4/0x398
 spi_probe+0xb8/0xdc
 really_probe+0x134/0x588
 __driver_probe_device+0xe0/0x288
 driver_probe_device+0x60/0x118
 __driver_attach+0x1a0/0x29c
 bus_for_each_dev+0xf0/0x14c
 bus_add_driver+0x130/0x288
 driver_register+0xd4/0x1c0
 do_one_initcall+0xfc/0x204
 kernel_init_freeable+0x240/0x2a0
 kernel_init+0x20/0x144
 ret_from_fork+0x14/0x28

Freed by task 1:
 kasan_set_track+0x3c/0x5c
 kasan_save_free_info+0x30/0x3c
 __kasan_slab_free+0xe4/0x12c
 __kmem_cache_free+0x94/0x1cc
 device_release+0x54/0xf8
 kobject_put+0xf4/0x238
 netdev_run_todo+0x414/0x7dc
 wilc_netdev_cleanup+0xe4/0x244
 wilc_bus_probe+0x2b8/0x398
 spi_probe+0xb8/0xdc
 really_probe+0x134/0x588
 __driver_probe_device+0xe0/0x288
 driver_probe_device+0x60/0x118
 __driver_attach+0x1a0/0x29c
 bus_for_each_dev+0xf0/0x14c
 bus_add_driver+0x130/0x288
 driver_register+0xd4/0x1c0
 do_one_initcall+0xfc/0x204
 kernel_init_freeable+0x240/0x2a0
 kernel_init+0x20/0x144
 ret_from_fork+0x14/0x28

It looks like an already existing/dormant issue in the error-managing path of
spi probe of the driver (looks like we are trying to unregister a netdevice
which has never been registered ?), but since your series triggers it, it should
be handled too.

> +	}
> +
>  	return 0;
>  
>  netdev_cleanup:
> @@ -1074,58 +1092,43 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
>   *
>   ********************************************/
>  
> -static int wilc_spi_reset(struct wilc *wilc)
> +static const char *
> +strbool(bool val)

I am not convinced we need a dedicated helper just to print boolean values (and
why the super short line break ?)
Also, such change should likely be in a separate patch since it generate quite
some lines of diff but none of those being about the initial topic

>  {
> -	struct spi_device *spi = to_spi_device(wilc->dev);
> -	struct wilc_spi *spi_priv = wilc->bus_data;
> -	int result;
> -
> -	result = wilc_spi_special_cmd(wilc, CMD_RESET);
> -	if (result && !spi_priv->probing_crc)
> -		dev_err(&spi->dev, "Failed cmd reset\n");
> -
> -	return result;
> -}
> -
> -static bool wilc_spi_is_init(struct wilc *wilc)
> -{
> -	struct wilc_spi *spi_priv = wilc->bus_data;
> -
> -	return spi_priv->isinit;
> +	return val ? "on" : "off";
>  }
>  
> -static int wilc_spi_deinit(struct wilc *wilc)
> +static int wilc_validate_chipid(struct wilc *wilc)
>  {
> -	struct wilc_spi *spi_priv = wilc->bus_data;
> +	struct spi_device *spi = to_spi_device(wilc->dev);
> +	u32 chipid, base_id;
> +	int ret;
>  
> -	spi_priv->isinit = false;
> -	wilc_wlan_power(wilc, false);
> +	/*
> +	 * make sure can read chip id without protocol error
> +	 */
> +	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> +	if (ret) {
> +		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> +		return ret;
> +	}
> +	base_id = chipid & ~WILC_CHIP_REV_FIELD;
> +	if (base_id != WILC_1000_BASE_ID && base_id != WILC_3000_BASE_ID) {

- WILC3000 is currently not supported (yet) by the upstream driver, so there is
no reason to validate its presence if we can not handle it later. Any mention of
it should then be removed from this series
- I see that there is already a helper to handle masking and check chip id in
wlan.c (is_wilc1000). You should likely reuse this/avoid the duplication

> +		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
> +		return ret;
> +	}
> +	dev_info(&spi->dev, "Detected chip id 0x%x (crc7=%s, crc16=%s)\n",
> +		 chipid, strbool(enable_crc7), strbool(enable_crc16));
>  	return 0;
>  }
>  
> -static int wilc_spi_init(struct wilc *wilc, bool resume)
> +static int wilc_spi_configure_bus_protocol(struct wilc *wilc)
>  {
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	struct wilc_spi *spi_priv = wilc->bus_data;
>  	u32 reg;
> -	u32 chipid;
>  	int ret, i;
>  
> -	if (spi_priv->isinit) {
> -		/* Confirm we can read chipid register without error: */
> -		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> -		if (ret == 0)
> -			return 0;
> -
> -		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> -	}
> -
> -	wilc_wlan_power(wilc, true);
> -
> -	/*
> -	 * configure protocol
> -	 */
> -
>  	/*
>  	 * Infer the CRC settings that are currently in effect.  This
>  	 * is necessary because we can't be sure that the chip has
> @@ -1176,12 +1179,54 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
>  
>  	spi_priv->probing_crc = false;
>  
> -	/*
> -	 * make sure can read chip id without protocol error
> -	 */
> -	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> +	return 0;
> +}
> +
> +static int wilc_spi_reset(struct wilc *wilc)
> +{
> +	struct spi_device *spi = to_spi_device(wilc->dev);
> +	struct wilc_spi *spi_priv = wilc->bus_data;
> +	int result;
> +
> +	result = wilc_spi_special_cmd(wilc, CMD_RESET);
> +	if (result && !spi_priv->probing_crc)
> +		dev_err(&spi->dev, "Failed cmd reset\n");
> +
> +	return result;
> +}
> +
> +static bool wilc_spi_is_init(struct wilc *wilc)
> +{
> +	struct wilc_spi *spi_priv = wilc->bus_data;
> +
> +	return spi_priv->isinit;
> +}
> +
> +static int wilc_spi_deinit(struct wilc *wilc)
> +{
> +	struct wilc_spi *spi_priv = wilc->bus_data;
> +
> +	spi_priv->isinit = false;
> +	wilc_wlan_power(wilc, false);
> +	return 0;
> +}
> +
> +static int wilc_spi_init(struct wilc *wilc, bool resume)
> +{
> +	struct wilc_spi *spi_priv = wilc->bus_data;
> +	int ret;
> +
> +	if (spi_priv->isinit) {

Ok, so indeed in this new version of the patch, the flag still makes sense for
upper layers.

> +		/* Confirm we can read chipid register without error: */
> +		if (wilc_validate_chipid(wilc) == 0)
> +			return 0;
> +	}
> +
> +	wilc_wlan_power(wilc, true);
> +
> +	ret = wilc_spi_configure_bus_protocol(wilc);
>  	if (ret) {
> -		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> +		wilc_wlan_power(wilc, false);
>  		return ret;
>  	}
>  
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
> index a72cd5cac81d..43dda9f0d9ca 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> @@ -182,6 +182,7 @@
>  #define WILC_CORTUS_BOOT_FROM_IRAM	0x71
>  
>  #define WILC_1000_BASE_ID		0x100000
> +#define WILC_3000_BASE_ID		0x300000

See comment above for WILC3000

>  
>  #define WILC_1000_BASE_ID_2A		0x1002A0
>  #define WILC_1000_BASE_ID_2A_REV1	(WILC_1000_BASE_ID_2A + 1)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


