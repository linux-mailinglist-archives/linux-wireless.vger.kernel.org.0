Return-Path: <linux-wireless+bounces-17606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4117A13C86
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0917A188C289
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44EF22ACEB;
	Thu, 16 Jan 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnboD+aY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4224A7C9;
	Thu, 16 Jan 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038557; cv=none; b=Xvk9iCz3aX4epSAQGbSJOZF1Pojdk1oB4inDsKlvohng9I7lbXF3aqIQIttJx/m9FqJXDISi1pc3txOiXjAad4kyxH90nbwPaUn/w7mjDuxGA5HE+jvyac+T9lio6kyeMfZ04H1aHkMFYXz0P90JwWJbS32t1JFrXMCIAJsWKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038557; c=relaxed/simple;
	bh=IytHOeD0st2WzVI40fez+8lx6PY/Y6ty7+lqugmUpA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxrp1QsHDvWaSCZAbC2K3yfxU7pidGoIqsXEKZu4GaRfZPFRCNVGc0cb9JPAA3p0DnA0sir3WngZlv+8jpZtZ9Nps4zF666q58qqHldU4G21dlTXUp9vxZtzRN/z8zoU9gT1crHcTTqomkhdfOCq5r+256xii9mdYB0kSxF28jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnboD+aY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737038557; x=1768574557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IytHOeD0st2WzVI40fez+8lx6PY/Y6ty7+lqugmUpA0=;
  b=bnboD+aYf79UqYDVIv69HX2BRCQvP2fuKThmz/frOSSWqpKE3ZD6AjMB
   T+xW0Ii7NahVWowh3qAHAxBc9L6Zzb9yaoSXyNbiBeGEfs8kPxiVZI1Oa
   kl3wyXSh9M3/hiGqoyJmz/JPgD8IFzyd3VeYcKKyYADDXcT0Qm/2fnaap
   lkJG1RX9w0MKev3ojTo2gDtB6lr0IbM/4dSjnZQQmIJozcJVINeXz/zT/
   xqh3EsV7I8fqYaQ9Acc+l85+DSFc7XoX1/V2hbWkTO1PvZ7okWQtMvXpr
   WblQo4sPhumenO9MjLP6/epGI7UwxiCpW9YhY+KWlNcJivXqkHEH9KaoP
   g==;
X-CSE-ConnectionGUID: +SHPae5+SBGrPKP6PynzJA==
X-CSE-MsgGUID: YNTpTlU0R/COH1BWlZsj2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="47916826"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47916826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:42:36 -0800
X-CSE-ConnectionGUID: jdpP7OWyQSKuAYbmo4TG7Q==
X-CSE-MsgGUID: h8mvhtAuQTOZ/SXnLFmmrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110620389"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:42:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYR4o-00000001hb8-0ynU;
	Thu, 16 Jan 2025 16:42:30 +0200
Date: Thu, 16 Jan 2025 16:42:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <Z4ka1eBBPkhLKNKM@smile.fi.intel.com>
References: <20240423-descriptors-wireless-v2-1-6d1d03b30bfa@linaro.org>
 <Z3t6coHFgd9PBCeb@larwa.hq.kempniu.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3t6coHFgd9PBCeb@larwa.hq.kempniu.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 06, 2025 at 07:38:42AM +0100, Michał Kępień wrote:
> Hi Linus,
> 
> > The ath9k has an odd use of system-wide GPIOs: if the chip
> > does not have internal GPIO capability, it will try to obtain a
> > GPIO line from the system GPIO controller:
> > 
> >   if (BIT(gpio) & ah->caps.gpio_mask)
> >         ath9k_hw_gpio_cfg_wmac(...);
> >   else if (AR_SREV_SOC(ah))
> >         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
> > 
> > Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> > gpio_request_one() passing the local GPIO number of the controller
> > (0..31) to gpio_request_one().
> > 
> > This is somewhat peculiar and possibly even dangerous: there is
> > nowadays no guarantee of the numbering of these system-wide
> > GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> > correspond to GPIOs 0..31 on the system as a whole seems a bit
> > wild.
> > 
> > Register all 32 GPIOs at index 0..31 directly in the ATH79K
> > GPIO driver and associate with WIFI if and only if we are probing
> > ATH79K wifi from the AHB bus (used for SoCs).
> 
> I don't know how likely it is today that this patch will get merged,

I believe the idea is to have this (okay, something that moves to GPIO descriptors)
merged at some point, better sooner than later.

> but it turned out to be useful for fixing an OpenWRT issue [1][2].  However,
> the patch required some tweaking in order to make it work, so I assumed
> it cannot hurt to provide some feedback on it.

Feedback is much appreciated, esp. from the real users on real HW!

...

> > +	lookup->dev_id = "ath9k";
> 
> Since the devm_gpiod_get_index() call in ath9k_hw_gpio_cfg_soc() passes
> ah->dev as the first argument, "ath9k" is not the string that
> gpiod_find_lookup_table() will use for matching the lookup table;
> instead, it will be the wireless device's name, e.g. "18100000.wmac" on
> my router (which is built on Atheros 9344).  This causes
> devm_gpiod_get_index() to return -ENOENT [3].

Yeah, there is a fundamental issue with this patch. The part that adds a GPIO
table has to be part either of:
1) Device Tree (or other firmware description);
2) board file;
3) quirk in the wireless driver.

The GPIO driver won't ever know the all of the details of the zillion of
possible platforms on this chip and the resource configurations.

...

> > +	for (i = 0; i < ATH79K_WIFI_DESCS; i++) {
> > +		lookup->table[i] = (struct gpiod_lookup)
> > +			GPIO_LOOKUP_IDX(label, 0, NULL, i,
> 
> This sets the chip_hwnum member of every registered lookup table entry
> to 0 (second GPIO_LOOKUP_IDX() argument), which causes all 32 GPIOs
> registered here to be erroneously mapped to the GPIO chip's first line.
> I believe the second argument for GPIO_LOOKUP_IDX() should also be 'i'
> here - or at least that is what made the patch work for me (after fixing
> the lookup table matching issue).

Good catch! (Also note my comments to the patch which I done previously).

...

> > +	/* Obtains a system specific GPIO descriptor from another GPIO controller */
> > +	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);
> 
> Since using the resource-managed version of gpiod_get_index() requires
> providing a valid pointer to a struct device as the first argument and
> the name of that device is not going to be "ath9k", some other means of
> matching this call with the lookup table registered in
> ath79_gpio_register_wifi_descriptors() needs to be devised.
> 
> I resorted to the NULL-matching fallback in gpiod_find_lookup_table(),
> which enables a lookup table with dev_id set to NULL to be matched for a
> gpiod_get_index() call with dev also set to NULL, coupled with setting
> con_id in all the lookup table entries and in the gpiod_get_index() call
> to a matching string.

Yeah, but this way it's even worse hack :-(.
So, the only driver that knows about the device name is the Wi-Fi driver.
Otherwise this should come by other means as I listed above.

-- 
With Best Regards,
Andy Shevchenko



