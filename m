Return-Path: <linux-wireless+bounces-12394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3796A171
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E80B25430
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C891684A5;
	Tue,  3 Sep 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0fEm3h/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4013DBBE;
	Tue,  3 Sep 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375565; cv=none; b=aAIgB2vU6QVqvYUBuDv3as5gevBhR+KrydiP2idEhEj5l/2kO91ud96O8Ry5gYU5u3xK5/L88b+lCASn7jEsHwQZkQctpwLWK5JBvOdGjQ6o1r+BoCK/Dsz3n5JbDaVJaE0hbBMznXkOiYgCRbiLSUR8XKL8THLuDDb1ehqXn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375565; c=relaxed/simple;
	bh=Uj/bj+aMeseWyuoqf9Z4Fj1Khz5w5nI0phGG8JGDfxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8NJiIygt1cn1TiVmbYdNYJBQDjHUzJZRs8o0cTjnLZipMOyuCoYN5YI4mTO2TWw+8Zstv63wSfokRSRODQVL9R/R2fpmEjt6oRkwTMtG2ZqXzE/+cf6tVkyyNT57qO/aZLoHOSnK10o+oG4/nN1JgflI64oqL1KSOsrw0NE3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0fEm3h/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725375564; x=1756911564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uj/bj+aMeseWyuoqf9Z4Fj1Khz5w5nI0phGG8JGDfxY=;
  b=e0fEm3h/HvDm9vDCw1Zto3iOpOZl9F/wahfhGV9Wh4+TT2jIXV4NAxAQ
   I6q062+Buo1G3IFsrTLJ2HFyZ8WyLnwOx3JYF1rB/O+6tAF3W2F9EgIDH
   KneyCVoJt0Fwm0Qi+AggrF9e6roUXtjIXf/K5I3jT3HdgpEeHxMXyuJnb
   2IDI87d8td4ytq8cXWoZF9P5Jf11jAeDYEKEsM3BsTcSVfTwp8fGX/dgr
   GdTx/GmIdtAeOld81oaB3V15OTU5DwV7VvvvUmnb9hXhJMCOmSMPnrBig
   2bfXMGsdJgh+OL5snRZcL0+TL6Xz/fxiWsCVjg85QVuLr3ZwTu6DVXwNH
   g==;
X-CSE-ConnectionGUID: ypgA+7NMT0iL6j+s7zzRVQ==
X-CSE-MsgGUID: 3pvgxQVzSredmghNlJsirQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41474853"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41474853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:59:24 -0700
X-CSE-ConnectionGUID: 6HGTB+h+TEu2438Hwul7dw==
X-CSE-MsgGUID: qZhtsFsVR06mrzCAQHoN3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69567174"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:59:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUzj-00000004kDE-1Vwy;
	Tue, 03 Sep 2024 17:58:59 +0300
Date: Tue, 3 Sep 2024 17:58:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, nico@fluxnic.net,
	pabeni@redhat.com, daniel@ffwll.ch, davem@davemloft.net,
	kuba@kernel.org, olteanv@gmail.com, saravanak@google.com,
	linux-kernel@vger.kernel.org, mripard@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com, f.fainelli@gmail.com,
	linux-wireless@vger.kernel.org, airlied@gmail.com,
	linus.walleij@linaro.org, brcm80211@lists.linux.dev, andrew@lunn.ch,
	devicetree@vger.kernel.org, linux@armlinux.org.uk,
	alsi@bang-olufsen.dk, tzimmermann@suse.de, kvalo@kernel.org,
	arend.vanspriel@broadcom.com, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
Message-ID: <ZtckM-uRzxAnS15o@smile.fi.intel.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-8-vassilisamir@gmail.com>
 <172537438003.978249.2559307502514402788.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172537438003.978249.2559307502514402788.robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 09:39:43AM -0500, Rob Herring (Arm) wrote:
> On Tue, 03 Sep 2024 00:55:34 +0200, Vasileios Amoiridis wrote:

...

> Applied, thanks!

It was fast :-)

Vasileios, consider my previous comment as a material for followup,
if Rob likes the idea.

-- 
With Best Regards,
Andy Shevchenko



