Return-Path: <linux-wireless+bounces-17100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E3A01F68
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 07:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B825E188398C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 06:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF63C47B;
	Mon,  6 Jan 2025 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="WI5eGfgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender-op-o11.zoho.eu (sender-op-o11.zoho.eu [136.143.169.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D117C
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736146492; cv=pass; b=I+WM+U3n7e25hvOM2MuxAlk1vldILGStAREcfv+M7JOe9/GMY6WxvTd89Y67MeWlxDuyu0rnJlWZ7zrYkXH2O0UXJMVB0bBh2TKOQbC0Q8EJTSVDJ0tSSoT4V8coSuCbuYVUdTrmAxGwsmC42Uo4VTJi4ANUuZSFoGZaeaNLebE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736146492; c=relaxed/simple;
	bh=L7GLmwygcEJeKpuwtLXat/1wvfMBgCE+5N0v2GZ9QN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+AaMOC9lIO0Dagqd/R72StqRVSAaX4cYaYdgNT3dNLlpJ6TGPEKjF8DN8QKBe0mA+C/2BSwu37JJK3NLuQSgigTLJVoNIVElBlus5t9nipwrkbOzceHidLmz+zOtur/I3gak2jh84j6BjMnRxA2HZ94kPz3OyN6JZvmmtOkOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=WI5eGfgw; arc=pass smtp.client-ip=136.143.169.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
ARC-Seal: i=1; a=rsa-sha256; t=1736145528; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Bs/W7ScE0hMa+c1ids2HiEEMNXoBUNpl+cZDPfVlvDoN/LjQGbmqeBj8R8CuFyXO7v47Bm45ScWOqgKG9VTe3ZZU5hBxoufYhNFzitMRlBmItnAuN5DGarCSSOKjH+nFU5Q5Fj4VYckYeLJFjfVXV81mdBUKZYmL7RJPEQabrzM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1736145528; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LV5pMFf/JUB62o97t1fb8NbfRnUSaIY5yrC+NOWH5Ag=; 
	b=VJ+Uc10VTe8+++GwIW1xha6/VU9gJLOK1GfNbYh4aLXM5saRS8W/oc16OBmSWmG6KET0AVqEUIllmyVy6x+B5cVxOuVxmc4k2l+zTyl5BrhgErteT4/eq6hjl8tDZ1Qnj/T7POYYNEEANA/LKnXbv3vDSW+XHlD6Why94vrcMkc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736145528;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=LV5pMFf/JUB62o97t1fb8NbfRnUSaIY5yrC+NOWH5Ag=;
	b=WI5eGfgw3sXxuDDaSRxaGLlfpjITa9hQrZKYwyr66imI3eqFTMVcleLEHpN32th4
	krsDDX9K5dYxdjDiSBzhjlQzYzoHlNvwDbruspnbzIf0irE4w9+pyCgtrBemOZhYKNE
	10Ejy9DyKvdMHpu78cFvKz4jVe/p/KpoezB21ehk=
Received: by mx.zoho.eu with SMTPS id 1736145524364162.27989875496212;
	Mon, 6 Jan 2025 07:38:44 +0100 (CET)
Date: Mon, 6 Jan 2025 07:38:42 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <Z3t6coHFgd9PBCeb@larwa.hq.kempniu.pl>
References: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
X-ZM-MESSAGEID: 1736143631011003900
X-ZohoMail-Sender: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
X-ZM-MESSAGEID: 1736144744012003600
X-ZohoMailClient: External

Hi Linus,

> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
> 
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
> 
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
> 
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
> 
> Register all 32 GPIOs at index 0..31 directly in the ATH79K
> GPIO driver and associate with WIFI if and only if we are probing
> ATH79K wifi from the AHB bus (used for SoCs).

I don't know how likely it is today that this patch will get merged, but
it turned out to be useful for fixing an OpenWRT issue [1][2].  However,
the patch required some tweaking in order to make it work, so I assumed
it cannot hurt to provide some feedback on it.

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Define all the descriptors directly in the ATH79K
>   GPIO driver in case the driver want to request them directly.
> - Link to v1: https://lore.kernel.org/r/20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org
> ---
>  drivers/gpio/gpio-ath79.c           | 47 ++++++++++++++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath9k/hw.c | 29 ++++++++++++-----------
>  drivers/net/wireless/ath/ath9k/hw.h |  3 ++-
>  3 files changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
> index f0c0c0f77eb0..f83ce0595ea8 100644
> --- a/drivers/gpio/gpio-ath79.c
> +++ b/drivers/gpio/gpio-ath79.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/gpio/driver.h>
> +#include <linux/gpio/machine.h> /* For WLAN GPIOs */
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/gpio-ath79.h>
>  #include <linux/of.h>
> @@ -222,6 +223,46 @@ static const struct of_device_id ath79_gpio_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ath79_gpio_of_match);
>  
> +#if IS_ENABLED(CONFIG_ATH9K_AHB)
> +/*
> + * This registers all of the ath79k GPIOs as descriptors to be picked
> + * directly from the ATH79K wifi driver if the two are jitted together
> + * in the same SoC.
> + */
> +#define ATH79K_WIFI_DESCS 32
> +static int ath79_gpio_register_wifi_descriptors(struct device *dev,
> +						const char *label)
> +{
> +	struct gpiod_lookup_table *lookup;
> +	int i;
> +
> +	/* Create a gpiod lookup using gpiochip-local offsets + 1 for NULL */
> +        lookup = devm_kzalloc(dev,
> +			      struct_size(lookup, table, ATH79K_WIFI_DESCS + 1),
> +			      GFP_KERNEL);
> +
> +	if (!lookup)
> +		return -ENOMEM;
> +
> +	lookup->dev_id = "ath9k";

Since the devm_gpiod_get_index() call in ath9k_hw_gpio_cfg_soc() passes
ah->dev as the first argument, "ath9k" is not the string that
gpiod_find_lookup_table() will use for matching the lookup table;
instead, it will be the wireless device's name, e.g. "18100000.wmac" on
my router (which is built on Atheros 9344).  This causes
devm_gpiod_get_index() to return -ENOENT [3].

> +
> +	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
> +		lookup->table[i] = (struct gpiod_lookup)
> +			GPIO_LOOKUP_IDX(label, 0, NULL, i,

This sets the chip_hwnum member of every registered lookup table entry
to 0 (second GPIO_LOOKUP_IDX() argument), which causes all 32 GPIOs
registered here to be erroneously mapped to the GPIO chip's first line.
I believe the second argument for GPIO_LOOKUP_IDX() should also be 'i'
here - or at least that is what made the patch work for me (after fixing
the lookup table matching issue).

> +					GPIO_ACTIVE_HIGH);
> +	}
> +
> +	gpiod_add_lookup_table(lookup);
> +
> +	return 0;
> +}
> +#else
> +static int ath79_gpio_register_wifi_descriptors(struct device *dev,
> +						const char *label)
> +{
> +}
> +#endif
> +
>  static int ath79_gpio_probe(struct platform_device *pdev)
>  {
>  	struct ath79_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
> @@ -291,7 +332,11 @@ static int ath79_gpio_probe(struct platform_device *pdev)
>  		girq->handler = handle_simple_irq;
>  	}
>  
> -	return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
> +	err = devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
> +	if (err)
> +		return err;
> +
> +	return ath79_gpio_register_wifi_descriptors(dev, ctrl->gc.label);
>  }
>  
>  static struct platform_driver ath79_gpio_driver = {
> diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
> index 5982e0db45f9..ee6705836746 100644
> --- a/drivers/net/wireless/ath/ath9k/hw.c
> +++ b/drivers/net/wireless/ath/ath9k/hw.c
> @@ -20,7 +20,7 @@
>  #include <linux/time.h>
>  #include <linux/bitops.h>
>  #include <linux/etherdevice.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <asm/unaligned.h>
>  
>  #include "hw.h"
> @@ -2727,19 +2727,25 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
>  static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
>  				  const char *label)
>  {
> +	enum gpiod_flags flags = out ? GPIOD_OUT_LOW : GPIOD_IN;
> +	struct gpio_desc *gpiod;
>  	int err;
>  
> -	if (ah->caps.gpio_requested & BIT(gpio))
> +	if (ah->gpiods[gpio])
>  		return;
>  
> -	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
> -	if (err) {
> +	/* Obtains a system specific GPIO descriptor from another GPIO controller */
> +	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);

Since using the resource-managed version of gpiod_get_index() requires
providing a valid pointer to a struct device as the first argument and
the name of that device is not going to be "ath9k", some other means of
matching this call with the lookup table registered in
ath79_gpio_register_wifi_descriptors() needs to be devised.

I resorted to the NULL-matching fallback in gpiod_find_lookup_table(),
which enables a lookup table with dev_id set to NULL to be matched for a
gpiod_get_index() call with dev also set to NULL, coupled with setting
con_id in all the lookup table entries and in the gpiod_get_index() call
to a matching string, e.g.:

	// in ath79_gpio_register_wifi_descriptors()

	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
		lookup->table[i] = (struct gpiod_lookup)
			GPIO_LOOKUP_IDX(label, i, "ath9k", i,
					GPIO_ACTIVE_HIGH);

	// in ath9k_hw_gpio_cfg_soc()

	gpiod = gpiod_get_index(NULL, "ath9k", gpio, flags);

This requires manually releasing the GPIO descriptor when the wireless
driver is done with it (because we're losing the benefits of using
resource-managed functions), so...

> +
> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
>  		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
>  			gpio, err);
>  		return;
>  	}
>  
> -	ah->caps.gpio_requested |= BIT(gpio);
> +	gpiod_set_consumer_name(gpiod, label);
> +	ah->gpiods[gpio] = gpiod;
>  }
>  
>  static void ath9k_hw_gpio_cfg_wmac(struct ath_hw *ah, u32 gpio, bool out,
> @@ -2800,11 +2806,6 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
>  		return;
>  
>  	WARN_ON(gpio >= ah->caps.num_gpio_pins);
> -
> -	if (ah->caps.gpio_requested & BIT(gpio)) {
> -		gpio_free(gpio);
> -		ah->caps.gpio_requested &= ~BIT(gpio);
> -	}

...ath9k_hw_gpio_free() would still need a bit like this:

	if (ah->gpiods[gpio]) {
		gpiod_put(ah->gpiods[gpio]);
		ah->gpiods[gpio] = NULL;
	}

I don't know if such an approach is appropriate, but it did at least
make the patch work for me.

Hope this helps,

[1] https://github.com/openwrt/openwrt/pull/17402#issuecomment-2566157016
[2] https://github.com/openwrt/openwrt/pull/17402#issuecomment-2566763575
[3] https://github.com/openwrt/openwrt/pull/17445#issuecomment-2569439459

-- 
Best regards,
Michał Kępień

