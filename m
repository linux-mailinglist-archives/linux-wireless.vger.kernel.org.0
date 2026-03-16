Return-Path: <linux-wireless+bounces-33314-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCCbKGZ1uGn5dgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33314-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 22:25:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0562A0E3C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 22:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83A3530958C1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38251364EA1;
	Mon, 16 Mar 2026 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhASWapF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632A3644A4;
	Mon, 16 Mar 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695781; cv=none; b=ahLHJJzeX0WuT52/QNdBqfi3IObtON5Hr3te6Ylp9+YkZxCqyoBgdBcRVJu+h8oxJeQ2y87xe8yRkN78iswap99QcAVddxoX3IPofv7ufa2GHWlQUhTHmtg/MENbUKcRqY7qO+0f6tVN4O/umFAAtpRyvrS3fHngks/eIiL/Lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695781; c=relaxed/simple;
	bh=uz/WuIarVuPLlQG0seITAkjd/xrGWUpddk+RDcfcv9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taKs9pznB99vGYM79i3xLTRxqtdXuirw5tahEJfOpBfREMtjXz+MewUPEFhSpDBYysiB+9FWyt3rmk4neHmawbZsF87jSlYQDsZd29FZF83KU1pBG6uiuCizdIaXbiQAeUu3bm/O3cL+nhYBLQaQ4t9b7uFUgNIFWLbHsxHtorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhASWapF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773695780; x=1805231780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uz/WuIarVuPLlQG0seITAkjd/xrGWUpddk+RDcfcv9w=;
  b=AhASWapFGLOQXYMInDiKOOwAlaBkrj3NX+8b5Hso3N0EFyiWlWWNgrqA
   9sCSQtQC/KPZYrxwcfggRaXopwYX8/kQXyjVQoJ4TGPpV003UyTAIU0vy
   flMr/UQuqdHgcHe0dU3Awxx58pOE9N7cKYUkxPqGJPKnIBiCXQfBlD3gy
   sCnoA/Zx6sX+2V4axh4NiPWmx4Y15Pm5hw76aEwFrS8/W5sLEgiTin8+j
   JsOsSr9NOTpRYGol6d9GinCfH/z3Q5DMyBv+JI3bKB11jOXfAj46qT68y
   oHrTi5ArXpEF7wvO0443SLxoUdsQi8da5L6FWWBzX2Bf2h+TEeWw6WaKh
   Q==;
X-CSE-ConnectionGUID: oj2UrdCuQwyNJCKjAbzq7A==
X-CSE-MsgGUID: QMCjmT7HTY2lOcUDvxAi6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74612565"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74612565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:16:19 -0700
X-CSE-ConnectionGUID: pWzisw66TbOA05pHK7LkNA==
X-CSE-MsgGUID: Ef7sjWTYRiOx707LIDZsIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221077803"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:16:16 -0700
Date: Mon, 16 Mar 2026 23:16:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	=?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <abhzHdy5hByLnPFu@ashevche-desk.local>
References: <20260316-descriptors-wireless-v5-1-3f791c6b0cba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-descriptors-wireless-v5-1-3f791c6b0cba@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl,vger.kernel.org,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-33314-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AB0562A0E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 09:56:58PM +0100, Linus Walleij wrote:
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

> Changes in v5:
> - Collect Bartosz ACK
> - Switch Kalle->Jeff as maintainer.
> - Link to v4: https://lore.kernel.org/r/20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org

Seems you forgot to address the LKP report.

> +static int ath79_gpio_register_wifi_descriptors(struct device *dev,
> +						const char *label)
> +{

Should be return SOMETHING; here.

> +}
> +#endif


-- 
With Best Regards,
Andy Shevchenko



