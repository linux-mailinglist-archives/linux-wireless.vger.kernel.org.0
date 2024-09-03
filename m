Return-Path: <linux-wireless+bounces-12390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6096A101
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C631F22B0D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E617C7C3;
	Tue,  3 Sep 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGM6Irez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EC154BE9;
	Tue,  3 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374760; cv=none; b=Z+C3qAaz5IJOj0rvIKPBEoXsaUTS74w+6IBRIm+R3U0KdCPe6PFm95StL6OgDXm9nu2+LQSGwGFkIi3WpC5Kj/JlbBmiev4ieWganQuvVNhIVsXlFEDgCDzVSo2SEF++NxX/bsDUJwusc5CrobLMGOV/RirbdpGm18B95cisIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374760; c=relaxed/simple;
	bh=BZuHabAACmsYxt89i5XvHNz9DSVj9Q7ZinvmM+9Vt/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7pBwT51P5/yEF40OruTkeEU5BVt1c1K6KE1Z0701sTGEw7vwONdF99ZRspcaDy8Q1tlH6VnV+9Lc9zOVFMJYlG0yr1LafE+Hyva9Uxd9StQCkoVnfM9oR9YcPWln8ky6HKd6v0H8ydDdAyjE0pUCATcrGJvMzfV/JVfk8f1GqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGM6Irez; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374759; x=1756910759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZuHabAACmsYxt89i5XvHNz9DSVj9Q7ZinvmM+9Vt/0=;
  b=AGM6Irez6GGVhorV++bKHP3tF2UR0gqC0q7CrXzny8sbpD/OFVfFw1PR
   OKbD/ZisQRM+42zf2YyJO95TA70mchgANCaqrbL3oeJ7+jJl0AEGpUHoH
   dLJNdcvYDvH9EoQgsLm2V7+o+sPRxJFOXfSrBMk7YvnJsVOMXuWMvbJZt
   m2migBEcQTdLMv7cyChKEheuwmjoqQmAECvFqs3nOKbSPEsVhhBfpxG6E
   lAcjubJJ5u2a2CgOatD9d9u9j9W3qrXQiUT/+aGqzf3DrUQBgxvoMeSJS
   +2mtzJkymy0rt9tyUm5wJwTTTL09aCFBgmeyYnYGB2vE1PbOPILkvfI7F
   Q==;
X-CSE-ConnectionGUID: ePRdC55VSCScJtzfcM1W7w==
X-CSE-MsgGUID: r5nGTs2TSkq6PllSmJNZkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23930419"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23930419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:59 -0700
X-CSE-ConnectionGUID: FNNr8um7T3S8euuHkyqm3w==
X-CSE-MsgGUID: Kl5ExL7NTpqw/PMnis6Ikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65143739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUmz-00000004jxX-0IwS;
	Tue, 03 Sep 2024 17:45:49 +0300
Date: Tue, 3 Sep 2024 17:45:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, nico@fluxnic.net, arend.vanspriel@broadcom.com,
	kvalo@kernel.org, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 6/7] wifi: wlcore: sdio: Make use of
 irq_get_trigger_type()
Message-ID: <ZtchHGEBtn-BVB-l@smile.fi.intel.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902225534.130383-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 12:55:33AM +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).

...

>  	memset(res, 0x00, sizeof(res));
>  
>  	res[0].start = irq;
> -	res[0].flags = IORESOURCE_IRQ |
> -		       irqd_get_trigger_type(irq_get_irq_data(irq));
> +	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
>  	res[0].name = "irq";


>  	if (wakeirq > 0) {
>  		res[1].start = wakeirq;
> -		res[1].flags = IORESOURCE_IRQ |
> -			       irqd_get_trigger_type(irq_get_irq_data(wakeirq));
> +		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
>  		res[1].name = "wakeirq";
>  		num_irqs = 2;

Since you are touching a lot here, consider also using macros from ioport.h,
i.e. DEFINE_RES_IRQ_NAMED().

This will become something like

	res[0] = DEFINE_RES_IRQ_NAMED(irq, "irq");
	res[0].flags |= irq_get_trigger_type(irq);

	if (wakeirq > 0) {
		res[1] = DEFINE_RES_IRQ_NAMED(wakeirq, "wakeirq");
		res[1].flags |= irq_get_trigger_type(wakeirq);

-- 
With Best Regards,
Andy Shevchenko



