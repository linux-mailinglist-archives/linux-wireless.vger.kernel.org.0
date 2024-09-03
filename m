Return-Path: <linux-wireless+bounces-12392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B396A11D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F415328BD10
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C31547F9;
	Tue,  3 Sep 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjeUp7VR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BE13D8BF;
	Tue,  3 Sep 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374932; cv=none; b=gPlIizwnUhdsRoKpuJA6NsxpIdpiuiS0vsQoSebeulHnudMYCa3/FQJ/vt/X8luI+Y1LDjkBCnRZCk9n/apwtgqyBQT4kWehj778SobEKLswLwNecVvZtYC56vqerWtMidYfcqhAAjd06BqDVYkELyf1skgwFRYt2uno/srRSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374932; c=relaxed/simple;
	bh=Je2vmDY5FCSKlkQhUOJpUDBKbPavcaXLxF8qTKqwiI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/FSRipmZljW+8h7L55WaJ1Ubyu+zrFdhOPMvQ670m2c9JndxA6pGuhDbu7svvLMFWAvs0lGKN4B4quCNnMKe8bzAz2ARDySrrjYOVso8sh0v0z2FPxoorutvKLv4VAtrPYb5YcxoXxBZl74fC9moPz21rQDRuSLdPM0FCYA5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjeUp7VR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374931; x=1756910931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Je2vmDY5FCSKlkQhUOJpUDBKbPavcaXLxF8qTKqwiI8=;
  b=LjeUp7VRrd86nHlE6NwyYdhqckEmHI6A+1S9K6wmCJHRDHQh5giT4OWE
   mXXfr+90gsKiXvEg5pgMz4eUaxC6cVPpMWVRWQFLF8X7eVYpy5tII/Maz
   tzqim/1psQ9DYAge/2sCXJOlwoJAX5e4WWxtCtESaHde3NQBaNuXQBkgZ
   hnQh8Mssn6pRucj9pNA3ehtshnFXfW9uPj6ICtV3ThOlcynsEKrgpEdUb
   6DqH0PwJjG1UZO4k3nm4s2xt8rgQg93V0dDyAjwBWgO6br8hg0qp6bP3O
   awgqdT3O2gRkdAmYLyv5DBI4BHqKevcMrb/zTvOcpJj80QrlSitTFQ4JA
   Q==;
X-CSE-ConnectionGUID: M64T8/GYRdeYsEB9FmIIvw==
X-CSE-MsgGUID: wZlWUrbAThW8AEo7DuWZdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23844849"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23844849"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:48:49 -0700
X-CSE-ConnectionGUID: 50vhjylPRlSYoSZBfZ1nBQ==
X-CSE-MsgGUID: bJ4GT7Y9Qw2+1ddljY2c4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65293586"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:48:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUpj-00000004k23-3JOV;
	Tue, 03 Sep 2024 17:48:39 +0300
Date: Tue, 3 Sep 2024 17:48:39 +0300
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
Subject: Re: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
Message-ID: <Ztchx4c2v78eGkYy@smile.fi.intel.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902225534.130383-8-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 12:55:34AM +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).

...

>  		r->start = r->end = irq;
> -		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
> +		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
>  		r->name = name ? name : of_node_full_name(dev);

As per previous patch this can be utilised to

		*r = DEFINE_RES_IRQ_NAMED(irq, name ?: of_node_full_name(dev));
		r->flags |= irq_get_trigger_type(irq);

-- 
With Best Regards,
Andy Shevchenko



