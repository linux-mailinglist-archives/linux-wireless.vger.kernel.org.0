Return-Path: <linux-wireless+bounces-32294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBGzMad7oWkUtgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:10:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C21B660B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67323028B08
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBED3ED128;
	Fri, 27 Feb 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi3S0UF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9691885A5;
	Fri, 27 Feb 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190629; cv=none; b=etay+uluNqxtZ+BhIeJX9oZHuR/O13qyznnahE29n4e9X568ys5sj6PPS9pfbqbD0tbFgHVqDl77/4wQtr/th67qSFoVR9stjFuMn9Zz25LM0zdO/bc8tGw2N4HX0C0NRpdGmFEN72CI3kisDoNzHjUTeGNHEBk4sYcP7V3ecBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190629; c=relaxed/simple;
	bh=e6j87ILGD/xlq3NeCGKtuPmuWF4dMneuzNt8FM/oTks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J432NKD/azaRuW0RJjZgMywK59IdGVTTKBOgwYNl2voxUScnWDP7AVzEeK0WEQ6aus+JMY6NmSHZPxdwltolKhelAuuzbeor1XNQJ3akKCLrhYUDwIEgc4GzeRLa5EVbdrq8zZVDt9XG2x8dEV1jV7QcrXB04usEWTInJiw8cXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi3S0UF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487EDC116C6;
	Fri, 27 Feb 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772190628;
	bh=e6j87ILGD/xlq3NeCGKtuPmuWF4dMneuzNt8FM/oTks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi3S0UF0WGBRIgImzkQ9vQ+apAgtmzRsIPCZUL+cdO1WIi1DjUF54QtZAbW0HY40q
	 MSpkkq+NxP/7qN3urbw5KHT9xUtRdm02InrTcRHO4ZzvNb8DMr8xA5/RUGK2HK6GCp
	 p2QhUiPNISW8LRCQpt68vQIW2JLowVk2hDNtawdSNN8nOMKN6IGaOK/aEtQ6318zZj
	 sHbrY4d6FF4FVV+sB9TQTekWZwr0ZYCMTQaIqahBuMx+GkLxhndAYjs+BmjcfrSMy6
	 sbBAv7O745deR4oTCwSCl1ih5sup5Cp+vYj1r9HBsl0JkeZVXYQ9AjtMIgXWAt4RqU
	 azBiLOCdJfUmg==
Date: Fri, 27 Feb 2026 12:10:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, 
	Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 23/35] wifi: mm81x: add sdio.c
Message-ID: <20260227-spotted-rugged-moth-3fdcbe@quoll>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-24-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227041108.66508-24-lachlan.hodges@morsemicro.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32294-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 286C21B660B
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:10:33PM +1100, Lachlan Hodges wrote:
> (Patches split per file for review, see cover letter for more
> information)
> 

So we should not commit this? Or you imagine such commit in kernel
history?

...


> +/*
> + * Value to indicate that the base address for bulk/register
> + * read/writes has yet to be set
> + */
> +#define MM81X_SDIO_BASE_ADDR_UNSET 0xFFFFFFFF
> +
> +#define MM81X_SDIO_ALIGNMENT (8)
> +
> +#define MM81X_SDIO_REG_ADDRESS_BASE 0x10000
> +#define MM81X_SDIO_REG_ADDRESS_WINDOW_0 MM81X_SDIO_REG_ADDRESS_BASE
> +#define MM81X_SDIO_REG_ADDRESS_WINDOW_1 (MM81X_SDIO_REG_ADDRESS_BASE + 1)
> +#define MM81X_SDIO_REG_ADDRESS_CONFIG (MM81X_SDIO_REG_ADDRESS_BASE + 2)
> +
> +struct mm81x_sdio {
> +	bool enabled;
> +	u32 bulk_addr_base;
> +	u32 register_addr_base;
> +	struct sdio_func *func;
> +	const struct sdio_device_id *id;
> +};
> +
> +static void mm81x_sdio_of_probe(struct device *dev, struct mm81x_ps *ps,
> +				const struct of_device_id *match_table)
> +{
> +	struct device_node *np = dev->of_node;
> +	const struct of_device_id *of_id;
> +
> +	if (!np) {
> +		dev_warn(dev, "Device node not found\n");

??? Why? How it can be not found? And if this is expected, then why this
is a warning?

> +		return;
> +	}
> +
> +	of_id = of_match_node(match_table, np);
> +	if (!of_id) {
> +		dev_warn(dev, "Couldn't match device table\n");

Huh? How is this possible? Yet you continue the probe, so not an error?


> +		return;
> +	}
> +
> +	ps->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_HIGH);
> +	ps->busy_gpio = devm_gpiod_get_optional(dev, "busy", GPIOD_IN);
> +
> +	ps->gpios_supported = (!IS_ERR_OR_NULL(ps->wake_gpio) &&
> +			       !IS_ERR_OR_NULL(ps->busy_gpio));
> +	if (!ps->gpios_supported) {
> +		dev_warn(
> +			dev,

Wrong wrapping. Please use Linux coding style.

> +			"wake-gpios and busy-gpios not defined, powersave disabled\n");

Not a warn, these are completely optional. Drop the message completely,
this is not even worth debug. Either your hardware HAS or HAS NOT GPIOs
connected. If hardware has not, then why warning the user all the time?
What the user can do? Re-wire device?

Think how your driver will be used by actual users.


> +	}
> +}
> +
> +static void mm81x_sdio_remove(struct sdio_func *func);
> +
> +static void sdio_log_err(struct mm81x_sdio *sdio, const char *operation,
> +			 unsigned int fn, unsigned int address,
> +			 unsigned int len, int ret)
> +{
> +	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
> +
> +	if (!mm)
> +		return;
> +
> +	mm81x_err(mm, "sdio: %s fn=%d 0x%08x:%d r=0x%08x b=0x%08x (ret:%d)",
> +		  operation, fn, address, len, sdio->register_addr_base,
> +		  sdio->bulk_addr_base, ret);


Even more wrappers over dev_err. NAK. More comments further.

> +}
> +
> +static void irq_handler(struct sdio_func *func1)
> +{
> +	int handled;
> +	struct sdio_func *func = func1->card->sdio_func[1];
> +	struct mm81x *mm = sdio_get_drvdata(func);
> +	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
> +
> +	WARN_ON_ONCE(!mm);

NAK, you cannot panic kernels (and this does) on such case. Either your
code is buggy if this can happen, or this is not correct. Instead write
code which is correct, so this cannot happen.

> +
> +	(void)sdio;

???

> +
> +	handled = mm81x_hw_irq_handle(mm);
> +	if (!handled)
> +		mm81x_dbg(mm, MM81X_DBG_SDIO, "%s: nothing was handled\n",
> +			  __func__);

No, interrupt handles don't print anything. Maybe with "once" the do,
but you again do not use standard API but own custom abstraction layer.
This is poor design.

> +}
> +
> +static int mm81x_sdio_enable_irq(struct mm81x_sdio *sdio)
> +{
> +	int ret;
> +	struct sdio_func *func = sdio->func;
> +	struct sdio_func *func1 = func->card->sdio_func[0];
> +	struct mm81x *mm = sdio_get_drvdata(func);
> +
> +	sdio_claim_host(func);
> +	ret = sdio_claim_irq(func1, irq_handler);
> +	if (ret)
> +		mm81x_err(mm, "Failed to enable sdio irq: %d\n", ret);
> +
> +	sdio_release_host(func);
> +	return ret;
> +}
> +
> +static void mm81x_sdio_disable_irq(struct mm81x_sdio *sdio)
> +{
> +	struct sdio_func *func = sdio->func;
> +	struct sdio_func *func1 = func->card->sdio_func[0];
> +
> +	sdio_claim_host(func);
> +	sdio_release_irq(func1);
> +	sdio_release_host(func);
> +}
> +
> +static void mm81x_sdio_set_irq(struct mm81x *mm, bool enable)
> +{
> +	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
> +
> +	if (enable)
> +		mm81x_sdio_enable_irq(sdio);
> +	else
> +		mm81x_sdio_disable_irq(sdio);
> +}
> +
> +static u32 mm81x_sdio_calculate_base_address(u32 address, u8 access)
> +{
> +	return (address & MM81X_SDIO_RW_ADDR_BOUNDARY_MASK) | (access & 0x3);
> +}
> +
> +static void mm81x_sdio_reset_base_address(struct mm81x_sdio *sdio)
> +{
> +	sdio->bulk_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
> +	sdio->register_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
> +}
> +
> +static int mm81x_sdio_set_func_address_base(struct mm81x_sdio *sdio,
> +					    u32 address, u8 access, bool bulk)
> +{
> +	int ret = 0;
> +	u8 base[4];
> +	const char *operation = "set_address_base";
> +	u32 calculated_addr_base =
> +		mm81x_sdio_calculate_base_address(address, access);
> +	u32 *current_addr_base = bulk ? &sdio->bulk_addr_base :
> +					&sdio->register_addr_base;
> +	bool base_addr_is_unset =
> +		(*current_addr_base == MM81X_SDIO_BASE_ADDR_UNSET);
> +	struct sdio_func *func2 = sdio->func;
> +	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
> +	struct sdio_func *func_to_use = bulk ? func2 : func1;
> +	struct mm81x *mm = sdio_get_drvdata(sdio->func);


This is completely unreadable code.

Ternary operators are heavily discouraged and are signs of
sloppy/unreadable coding.


> +	return ret;
> +err:
> +	retries++;
> +	if (ret == -ETIMEDOUT && retries <= max_retries) {
> +		mm81x_dbg(mm, MM81X_DBG_SDIO,
> +			  "%s failed (%d), retrying (%d/%d)\n", __func__, ret,
> +			  retries, max_retries);
> +		goto retry;
> +	}
> +
> +	*current_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
> +	return ret;
> +}
> +
> +static struct sdio_func *mm81x_sdio_get_func(struct mm81x_sdio *sdio,
> +					     u32 address, ssize_t size,
> +					     u8 access)
> +{
> +	int ret = 0;
> +	u32 calculated_base_address =
> +		mm81x_sdio_calculate_base_address(address, access);
> +	struct sdio_func *func2 = sdio->func;
> +	struct sdio_func *func1 = sdio->func ? sdio->func->card->sdio_func[0] :
> +					       NULL;
> +	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;

All of these look wrong. Either you have func or not?

> +	struct sdio_func *func_to_use;
> +
> +	WARN_ON(!mm);
> +

NAK. Write correct code, not something which randomly is being executed
- sometimes with NULL, sometimes not. Coding is not random, unless you
wrote it with microslop copilot, but then I would simply NAK it.


> +
> +static int mm81x_sdio_probe(struct sdio_func *func,
> +			    const struct sdio_device_id *id)
> +{
> +	int ret = 0;
> +	u32 chip_id;
> +	struct mm81x *mm = NULL;
> +	struct mm81x_sdio *sdio;
> +	struct device *dev = &func->dev;
> +
> +	if (func->num == 1)
> +		return 0;
> +
> +	if (func->num != 2)
> +		return -ENODEV;
> +
> +	mm = mm81x_mac_create(sizeof(*sdio), dev);
> +	if (!mm) {
> +		dev_err(dev, "mm81x_mac_create failed\n");

No, you must not print here anything. Do you see code like that
anywhere?

> +		return -ENOMEM;
> +	}
> +
> +	mm->bus_ops = &mm81x_sdio_ops;
> +	mm->bus_type = MM81X_BUS_TYPE_SDIO;
> +
> +	sdio = (struct mm81x_sdio *)mm->drv_priv;
> +	sdio->func = func;
> +	sdio->id = id;
> +	sdio->enabled = true;
> +	mm81x_sdio_reset_base_address(sdio);
> +
> +	sdio_set_drvdata(func, mm);
> +
> +	ret = mm81x_sdio_enable(sdio);
> +	if (ret) {
> +		mm81x_err(mm, "mm81x_sdio_enable failed: %d\n", ret);
> +		goto err_destroy_mac;
> +	}
> +
> +	ret = mm81x_core_attach_regs(mm);
> +	if (ret) {
> +		mm81x_err(mm, "mm81x_core_attach_regs failed: %d\n", ret);
> +		goto err_destroy_sdio;

All these are just poor coding style. Why are you not using standard
dev_err_probe?

> +	}
> +
> +	mm81x_claim_bus(mm);
> +	ret = mm81x_reg32_read(mm, MM81X_REG_CHIP_ID(mm), &chip_id);
> +	mm81x_release_bus(mm);
> +	if (ret || chip_id != mm->chip_id) {
> +		mm81x_err(mm, "Chip ID read failed: %d\n", ret);
> +		goto err_destroy_sdio;
> +	}
> +
> +	mm81x_dbg(mm, MM81X_DBG_SDIO,
> +		  "Morse Micro SDIO device found, chip ID=0x%04x\n",
> +		  mm->chip_id);
> +
> +	mm81x_sdio_of_probe(dev, &mm->ps, mm81x_of_match_table);
> +	mm81x_sdio_config_burst_mode(mm, true);
> +
> +	mm81x_core_init_mac_addr(mm);
> +
> +	ret = mm81x_core_create(mm);
> +	if (ret)
> +		goto err_destroy_sdio;
> +
> +	ret = mm81x_sdio_enable_irq(sdio);
> +	if (ret) {
> +		mm81x_err(mm, "mm81x_sdio_enable_irq failed: %d\n", ret);

No, use standard printing constructs. dev_err_probe, dev_err, not your
own API. Abstraction layers are in kernel heavily discouraged.

> +		goto err_destroy_core;
> +	}
> +
> +	ret = mm81x_mac_register(mm);
> +	if (ret) {
> +		mm81x_err(mm, "mm81x_mac_register failed: %d\n", ret);
> +		goto err_disable_irq;
> +	}
> +
> +	return 0;
> +
> +err_disable_irq:
> +	mm81x_sdio_disable_irq(sdio);
> +err_destroy_core:
> +	mm81x_core_destroy(mm);
> +err_destroy_sdio:
> +	mm81x_sdio_release(sdio);
> +err_destroy_mac:
> +	mm81x_mac_destroy(mm);
> +	return ret;
> +}
> +
> +static void mm81x_sdio_remove(struct sdio_func *func)
> +{
> +	struct mm81x *mm = sdio_get_drvdata(func);
> +	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
> +
> +	dev_info(&func->dev, "sdio removed func %d vendor 0x%x device 0x%x\n",
> +		 func->num, func->vendor, func->device);

Drop, drivers should be silent.

> +
> +	if (!mm)
> +		return;
> +
> +	mm81x_mac_unregister(mm);
> +	mm81x_sdio_disable_irq(sdio);
> +	mm81x_core_destroy(mm);
> +	mm81x_sdio_release(sdio);
> +	mm81x_sdio_reset(func);
> +	mm81x_mac_destroy(mm);
> +	sdio_set_drvdata(func, NULL);
> +}
> +
> +static const struct sdio_device_id mm81x_sdio_devices[] = {
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_MORSEMICRO,
> +		      SDIO_VENDOR_ID_MORSEMICRO_MM81XB1) },
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_MORSEMICRO,
> +		      SDIO_VENDOR_ID_MORSEMICRO_MM81XB2) },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(sdio, mm81x_sdio_devices);
> +
> +static struct sdio_driver mm81x_sdio_driver = {
> +	.name = "mm81x_sdio",
> +	.id_table = mm81x_sdio_devices,
> +	.probe = mm81x_sdio_probe,
> +	.remove = mm81x_sdio_remove,
> +};
> +
> +int __init mm81x_sdio_init(void)

Why aren't you using module sdio driver wrapper?

> +{
> +	int ret;
> +
> +	ret = sdio_register_driver(&mm81x_sdio_driver);
> +	if (ret)
> +		pr_err("sdio_register_driver() failed: %d\n", ret);
> +
> +	return ret;

And you miss here module description. This patch organized per files,
not per logical pieces, makes it very difficult to review. I have
absolutely no clue whether this is module or not, whether this is built
or not, whether it is complete or not.

Best regards,
Krzysztof


