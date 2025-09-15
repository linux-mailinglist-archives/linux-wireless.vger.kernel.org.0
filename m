Return-Path: <linux-wireless+bounces-27328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89003B57ACE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5363A1EB4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB92D595F;
	Mon, 15 Sep 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGlGorY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D02FB962;
	Mon, 15 Sep 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939058; cv=none; b=qtpSvdEUB69oezre4WTWCMnT2gUzjX6Ggi5M9WHiDkOJMtdsUG3BZn0LxXmdtjC3fjgODNV5HBbhT999LIdoiHqpJBWl5+m3ZMmr0KF9I6uQ9pbjoGEdtFhWZc3ciDdl7l8oRGvB8alpP3TyyoxIWLbgbr0Fh7yoBNfgaDv2Cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939058; c=relaxed/simple;
	bh=7P1TH/iXUySVg0i/AUOTjLXI0gPuddCzRAcSmSb5R4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxGk9TsBi6zZ+Km+8ZbBFA3kJl2YZVTkOVfvsFkvDgRbzPkw6QC9D0i0a5fBJ303BzEYL6Boa0jfd1byUdiN+MCGY/TvMmvmhwJMIv5oQ614DUc5PeXQIl+w2a1/6xvPENUZWm2SORV1wrJLOh6dfSgqKFxIrFmnHLM0O+8waJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGlGorY5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757939056; x=1789475056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7P1TH/iXUySVg0i/AUOTjLXI0gPuddCzRAcSmSb5R4w=;
  b=HGlGorY5u4O6qVMz6bRyfyylVveO7XBK+tCOx2gImVVfftYiS9C7HnxO
   wJZce1TYStwCIbpdN6/LHA9fXXFM/P44vJWLcCmyLrgi8HLMoQsdIucXr
   GUCOHVuU1mHpi51ruZMVkMPZISQtEIpXNksJaByCICGF97TNkHqfXXmey
   vT7jVuracm2K1TlQv9WC/+0kzdbbjlB52DNqR3GStZ5H025Pebz3KHdpt
   fEz+A59meQdoIvvF3ixWvAocfg9cOy1C6vvJtqWv56BpsU9SYSTyl3z4V
   1tNOaUhQzqbte3V0GeRVtugbbEvhpI3Ujtr0c4W/lVFVpDebFEBgpvGoZ
   A==;
X-CSE-ConnectionGUID: 2CxM061aQb2/xftyHhLUSA==
X-CSE-MsgGUID: fx2PL+chRj6tNYhutlfOXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70807161"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="70807161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:24:15 -0700
X-CSE-ConnectionGUID: lBHa8urVQ0C6GbcF5fU5aw==
X-CSE-MsgGUID: UPGdaX0TSLSniCBvTRZPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179783356"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 15 Sep 2025 05:24:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Sep 2025 15:24:11 +0300
Date: Mon, 15 Sep 2025 15:24:11 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: rfkill: gpio: Fix crash due to dereferencering
 uninitialized pointer
Message-ID: <aMgFa9LLJBhjcgJr@kuha.fi.intel.com>
References: <20250913113515.21698-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913113515.21698-1-hansg@kernel.org>

On Sat, Sep 13, 2025 at 01:35:15PM +0200, Hans de Goede wrote:
> Since commit 7d5e9737efda ("net: rfkill: gpio: get the name and type from
> device property") rfkill_find_type() gets called with the possibly
> uninitialized "const char *type_name;" local variable.
> 
> On x86 systems when rfkill-gpio binds to a "BCM4752" or "LNV4752"
> acpi_device, the rfkill->type is set based on the ACPI acpi_device_id:
> 
>         rfkill->type = (unsigned)id->driver_data;
> 
> and there is no "type" property so device_property_read_string() will fail
> and leave type_name uninitialized, leading to a potential crash.
> 
> rfkill_find_type() does accept a NULL pointer, fix the potential crash
> by initializing type_name to NULL.
> 
> Note likely sofar this has not been caught because:
> 
> 1. Not many x86 machines actually have a "BCM4752"/"LNV4752" acpi_device
> 2. The stack happened to contain NULL where type_name is stored
> 
> Fixes: 7d5e9737efda ("net: rfkill: gpio: get the name and type from device property")
> Cc: stable@vger.kernel.org
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - Fix typo in stable email address
> ---
>  net/rfkill/rfkill-gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> index 41e657e97761..cf2dcec6ce5a 100644
> --- a/net/rfkill/rfkill-gpio.c
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -94,10 +94,10 @@ static const struct dmi_system_id rfkill_gpio_deny_table[] = {
>  static int rfkill_gpio_probe(struct platform_device *pdev)
>  {
>  	struct rfkill_gpio_data *rfkill;
> -	struct gpio_desc *gpio;
> +	const char *type_name = NULL;
>  	const char *name_property;
>  	const char *type_property;
> -	const char *type_name;
> +	struct gpio_desc *gpio;
>  	int ret;
>  
>  	if (dmi_check_system(rfkill_gpio_deny_table))
> -- 
> 2.51.0

-- 
heikki

