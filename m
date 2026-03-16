Return-Path: <linux-wireless+bounces-33288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH93B87Nt2mDVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:30:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BD297057
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B19F3033D18
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910C386C24;
	Mon, 16 Mar 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGNlWh6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF68182D0;
	Mon, 16 Mar 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653360; cv=none; b=EdJtQFsF25g0CL6ob/q1f6AT05VcoLG/EEO08vF64HESfAy6z50+3PFbW71gwRDe7L7BkS1XGFFQBVE2VXp+6yHYuouwYLXiZNvx0Dmnac2DftH3WipvChiXZ+5Z0+c8/x1l1oO6C4eGKq+AqEidYySEhzG0CYICw1OlbwIom0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653360; c=relaxed/simple;
	bh=PYSyaABDE9FCBpORP7Yb8TmbH+eE0gPZ7nOryR4YMVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhotQ1311GIbAKiU39I77PygY6WjKuPg4NjiuHyTXOzwr97cX6zw7WHWreEVNfm7GUP16TfceJU/uHOIsRq8OJhfMK0RmK3QnW6z5tj0bEsEVRo+g0d4mqiaDBw6PHjEPFSlCfeqrL0ivOxJlMqe0/y0rhsvU0CPefLnYAHGENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGNlWh6p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773653358; x=1805189358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PYSyaABDE9FCBpORP7Yb8TmbH+eE0gPZ7nOryR4YMVY=;
  b=QGNlWh6pvZoQkFny6Xxy70mkIulSasNk7ANyvqssFXxzC8UR6CptbjVR
   VzC0rat6g9ZaXsiJDR9fNirbcSecT41e40tvF97laeUjf8iHBfn55AK9r
   2DckkEXZSDdk8s2BN36CL2AZ3pUkVsSHCEwxzYY2OFL7HjJGZUIbJSEXV
   XyO7uamRf76RtOL13LDiCzYPL+11Ro4+LfRBxg8s32E7woQanWEh8j1tW
   1LSjsgggAb3oSGFinoq/rf8YRr/P4HwSdLl/SIBMII0czeZyeBcbLMCd6
   GGQV20rMUceOVdV3SLIuqsp0KANKXf702OKXslZRxfEE3f9xJtHA0TwhI
   w==;
X-CSE-ConnectionGUID: NgbPZq/TRYGYaAWBpNUeJw==
X-CSE-MsgGUID: iaVrFkK/S7acSvJnzS8UQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74581426"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74581426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:29:18 -0700
X-CSE-ConnectionGUID: a4g6kxQqT2aozanqYYNhWg==
X-CSE-MsgGUID: Kmm6JFaRQcS5k9gC9TyQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226522964"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:29:15 -0700
Date: Mon, 16 Mar 2026 11:29:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com, linux-gpio@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Alban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	=?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH v4] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <abfNaRH10hnXug4l@ashevche-desk.local>
References: <20260313-descriptors-wireless-v4-1-07ab47c89a98@kernel.org>
 <CAMRc=MdJXhXyid1a4ycmKv6nwOf3FYd=rFEaBqQ7k3SFq_j4FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdJXhXyid1a4ycmKv6nwOf3FYd=rFEaBqQ7k3SFq_j4FQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl];
	TAGGED_FROM(0.00)[bounces-33288-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,kempniu.pl:email]
X-Rspamd-Queue-Id: 796BD297057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:09:22AM -0400, Bartosz Golaszewski wrote:
> On Fri, 13 Mar 2026 22:53:43 +0100, Linus Walleij <linusw@kernel.org> said:
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
> > GPIO driver and associate with the NULL device (making them
> > widely available) if and only if we are probing ATH79K wifi
> > from the AHB bus (used for SoCs). We obtain these offsets from
> > the NULL device if necessary.
> >
> > These GPIOs should ideally be defined in the device tree
> > instead, but we have no control over that for the legacy
> > code path.
> >
> > Testcompiled with the ath79 defconfig.
> >
> > Reported-by: Michał Kępień <kernel@kempniu.pl>
> > Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> > This patch set is a long standing attempt to get rid of the global
> > GPIO numbers from the ath9k Wireless driver.
> >
> > Maybe Kalle can merge this to the Wireless tree if we agree on this
> > hack solution.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Changes in v4:
> > - Fix review comments from Andy.
> > - Collect ACKs.
> 
> I think this did not work. :)

It's just extra SoB where it's not needed, but the tags are collected in
the proper commit message.

-- 
With Best Regards,
Andy Shevchenko



