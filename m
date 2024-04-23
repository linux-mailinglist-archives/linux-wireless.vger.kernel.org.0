Return-Path: <linux-wireless+bounces-6722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A08AE739
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A8B1F263BF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6D12F36B;
	Tue, 23 Apr 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+DisPx4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027D12D1FE;
	Tue, 23 Apr 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877190; cv=none; b=pIxKwBLjP2078MMLICU5auTnRM4v6NWut4B+aganhxgw2PEFF5wJ/RPFFAeyq823o5+lw165NCcgkIX/zlUPRKmBN9+4nMK3fM667r7Nlsa/I7RJlYX0NnaBEnCFpin4u4pcy66XKQv7dxC04ks3F+hLP/GXOMX3Op68YYBJuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877190; c=relaxed/simple;
	bh=7GaZ6z1KKQVx9no+OijvvNIpBImultry935P5y+8rrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR6W4s0mIqKZosfFZ2b4X0IvA4iCWf0F6cGdeBYjVnk8On62WrTLMD1UkWSD0qorBsr+2xrARVbKSCaaR6KnUf9cVFGPovT8AIrV3z9pjV/mgv2CoiEhg9bIy1tpzrPOhnPrzuJ7eouDEG4GgIsnb1b3SUlBQNokz18dzdim7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+DisPx4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713877189; x=1745413189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7GaZ6z1KKQVx9no+OijvvNIpBImultry935P5y+8rrg=;
  b=c+DisPx4rsM/mrtJ91h88DS7/feoN8Fkdza5gaOzAD0utGm9Le6Zijik
   C5PHlvTT1Zihv0oCyPjs8CdqOUPyGQ2NpbCvRLPUkHd8UbMgra9Ksk1dh
   N2Hq2znjpFqjBNsyIThD1siisG0Q3rxIWJtsjtXQWgiSI+WkYoKZRsdIp
   bT9ztrZR4EQq2BSoiSfzwRaD2RdEG6H1rOSQKwFi1bHGjUI+fXX5xjxqy
   WBJkhVZPI1hwzohAuEZ92+G4E7PTPS/L6Lb0TZiqL7bRedlniI5LDX6Yl
   kVfLF8cHaQZ3TzX/0OlUhNxMsi+PdrBXW6iGmf4Wn/LUnd9s1mo1/6Zbf
   g==;
X-CSE-ConnectionGUID: dyKndjrwQxq+kcTUAXbWOw==
X-CSE-MsgGUID: roOEnrO3SL6bNWMGgqL1pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9328019"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9328019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 05:59:48 -0700
X-CSE-ConnectionGUID: 01aWmH+7Q+CCrRKT+QYgSg==
X-CSE-MsgGUID: rztc+s70S7aCZwMDAP6Htg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24963915"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 05:59:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzFkM-00000000L2U-23F1;
	Tue, 23 Apr 2024 15:59:42 +0300
Date: Tue, 23 Apr 2024 15:59:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Alban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <Ziewvkh_Hd2j5hHF@smile.fi.intel.com>
References: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 02:12:33PM +0200, Linus Walleij wrote:
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

...

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

unsigned ?

> +	/* Create a gpiod lookup using gpiochip-local offsets + 1 for NULL */
> +        lookup = devm_kzalloc(dev,
> +			      struct_size(lookup, table, ATH79K_WIFI_DESCS + 1),
> +			      GFP_KERNEL);

> +

Besides unneeded blank line the above has a broken indentation.

> +	if (!lookup)
> +		return -ENOMEM;
> +
> +	lookup->dev_id = "ath9k";
> +
> +	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {

> +		lookup->table[i] = (struct gpiod_lookup)

This is not needed as GPIO_LOOKUP_IDX() is a compound literal.

> +			GPIO_LOOKUP_IDX(label, 0, NULL, i,
> +					GPIO_ACTIVE_HIGH);

Hence:

		lookup->table[i] =
			GPIO_LOOKUP_IDX(label, 0, NULL, i, GPIO_ACTIVE_HIGH);

> +	}
> +
> +	gpiod_add_lookup_table(lookup);
> +
> +	return 0;
> +}

...

> +	/* Obtains a system specific GPIO descriptor from another GPIO controller */
> +	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);

> +

Unneeded blank line.

> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
>  		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
>  			gpio, err);
>  		return;
>  	}

-- 
With Best Regards,
Andy Shevchenko



