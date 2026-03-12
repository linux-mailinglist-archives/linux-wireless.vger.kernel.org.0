Return-Path: <linux-wireless+bounces-33119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBIPD3XpsmljQwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:27:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B21D275920
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0153301AD0E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C463CF024;
	Thu, 12 Mar 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MduaQtc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355523C5558;
	Thu, 12 Mar 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332641; cv=none; b=MnVlcFQcpnjvChLIGayurG2Wpl7b6S85jLe+OIVrKkVgDtaD2st1rAq/Fyo9GGN5pRlklVLBuFy4O24XEiJnJbX4BUBE4ioYOoNo49XWW3SAfO0f8CNym44zI4IrqQcZzPUopXx0hP73aTLD549A4VkcIlnL3eUSbI3bKphugsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332641; c=relaxed/simple;
	bh=NueBKospao1bmgRu3qKRBKRQHxUvyI5EfK3gCcxpKFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEaKGueM7XH/GDg6CyALFVMv5iI+0LiKU4ioPrm0Pcab/Cxq5pLf86RjtxBfhj/LWyJF/O4fkTHTvglIyjd3J2Kbk2H8Jr3tarHhGGl/r+axquiUW+PkeIGVtEG5hbRghuecfoUJ5H47cZ19a2f/5xD/6lJl/6fHMO5dvXDo7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MduaQtc2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773332640; x=1804868640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NueBKospao1bmgRu3qKRBKRQHxUvyI5EfK3gCcxpKFs=;
  b=MduaQtc2hM83kEHTXsoppKZloR+DjP56qOVV5KMrZ1M+6+3qelsbgySJ
   kALXUpL95TAvwXlLMSILgfVtywB++wXExnICaPJDjeFtZA9eB3s94vw3q
   X2QeHbUzqMvUTdYCiarViJxGkNl6NLPK8L0rt/+XEkdtBwr0znxd9MKYj
   ttrI28sTz7GHNs3nZ24Udkr/XEL06AITE5IrWk3sTBnmA7G2g+wDNOVw6
   WBLx/obtXKpo0Qw1qlKfehrtJYXnW7tukY4tHQpZRLYtMtXPprpeUp0RA
   JYcym3EkcYqNzKUvvZw6R/fRZ1mIJKbChtBJQZhvzo0fqkTZXm8Cz0Ihc
   w==;
X-CSE-ConnectionGUID: VlsdIXAzQiGtYc6+QrgcVQ==
X-CSE-MsgGUID: zdhGg2fISLOtKG/0nnbzGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="97043220"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="97043220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:24:00 -0700
X-CSE-ConnectionGUID: J602kz0/T56nMEhymZBn0w==
X-CSE-MsgGUID: /sPaDQvvQxyqWy/JOINTTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251375152"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:23:57 -0700
Date: Thu, 12 Mar 2026 18:23:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Alban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	=?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <abLomhQ4faipjIQu@ashevche-desk.local>
References: <20260312-descriptors-wireless-v3-1-5230e0870c31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-descriptors-wireless-v3-1-5230e0870c31@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl,vger.kernel.org,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-33119-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9B21D275920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:09:53PM +0100, Linus Walleij wrote:
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
> GPIO driver and associate with the NULL device (making them
> widely available) if and only if we are probing ATH79K wifi
> from the AHB bus (used for SoCs). We obtain these offsets from
> the NULL device if necessary.
> 
> These GPIOs should ideally be defined in the device tree
> instead, but we have no control over that for the legacy
> code path.
> 
> Testcompiled with the ath79 defconfig.

...

> +#define ATH79K_WIFI_DESCS 32
> +static int ath79_gpio_register_wifi_descriptors(struct device *dev,
> +						const char *label)
> +{
> +	struct gpiod_lookup_table *lookup;
> +	int i;
> +
> +	/* Create a gpiod lookup using gpiochip-local offsets + 1 for NULL */
> +	lookup = devm_kzalloc(dev,
> +			      struct_size(lookup, table, ATH79K_WIFI_DESCS + 1),
> +			      GFP_KERNEL);

> +

Redundant blank line.

> +	if (!lookup)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Ugly system-wide lookup for the NULL device: we know this
> +	 * is already NULL but explicitly assign it here for people to
> +	 * know what is going on. (Yes this is an ugly legacy hack, live
> +	 * with it.)
> +	 */
> +	lookup->dev_id = NULL;
> +
> +	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
> +		lookup->table[i] = (struct gpiod_lookup)

The macro below is already compound literal, the '(struct gpiod_lookup)'
is redundant.

> +			/*
> +			 * Set the HW offset on the chip and the lookup
> +			 * index to the same value, so looking up index 0
> +			 * will get HW offset 0, index 1 HW offset 1 etc.
> +			 */
> +			GPIO_LOOKUP_IDX(label, i, "ath9k", i, GPIO_ACTIVE_HIGH);
> +	}
> +
> +	gpiod_add_lookup_table(lookup);
> +
> +	return 0;
> +}

...

> +	/*
> +	 * Obtains a system specific GPIO descriptor from another GPIO controller.
> +	 * Ideally this should come from the device tree, this is a legacy code
> +	 * path.
> +	 */
> +	gpiod = gpiod_get_index(NULL, "ath9k", gpio, flags);

> +

Redundant blank line.

> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);

What about

	err = PTR_ERR_OR_ZERO(...);
	if (err) {
		...

?

>  		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
>  			gpio, err);
>  		return;
>  	}

...

Have you considered using software nodes instead?

-- 
With Best Regards,
Andy Shevchenko



