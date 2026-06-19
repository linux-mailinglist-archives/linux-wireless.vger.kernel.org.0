Return-Path: <linux-wireless+bounces-37916-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id POivDYrlNGo+jgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37916-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:45:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BC6A429D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=W0v5m8Ek;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37916-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37916-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24BD5300B9ED
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FB2C21D0;
	Fri, 19 Jun 2026 06:45:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2973221D89;
	Fri, 19 Jun 2026 06:45:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851524; cv=none; b=sqRIQpcFr6hxFSyGBNyWUXFcEOJHmbp0hzjU3PVj/Nlkd/n4K+9MMSqNq4KI98THlSgd0TZJVrwrrTv/eoDZwdtL4x0M9OQq3cfWf5bmqukCWQG9LK0FFrMBen5TSBy76ZfIX8KHSzQmnQFaKe3GSqjtri696K/4q/etOKIgy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851524; c=relaxed/simple;
	bh=rjND/zGWp0LLnJATX34dwuqJ3Oq3gBJmx1u8BII+22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKjOVK3XWazsME+RXK5RhivhLZB/haa3tclcDdR80+PVw4pIT6jVIrN/0lgeZFAwm8uhK6qD1A3u1ImgZ9d4TsmfUI7K9dX2kHaF2Q8pRJDqEsugjOw8WNVEFA3QDHDGBl/jsLkfbUFh/xyv4prih076wo9AEQeVTcHk8nZtK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0v5m8Ek; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781851523; x=1813387523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjND/zGWp0LLnJATX34dwuqJ3Oq3gBJmx1u8BII+22M=;
  b=W0v5m8EkHE+Hf7fIPWYFiRvNtRhNdFYWm526dwrg0Qjnea/AIISWOxFo
   I3wu/SRHgeJ2qH/wzRLKJveRj3Dt62TgoCprFY6ZTDt9K/7skWXsK2Hr4
   WMCgT0pca70WkfBt46Bv3Cf2nIGdEfrcYmADauJej2IFi9eCzbi+u0u0t
   4uZfV26EFPcANOXZYHWbyKIUuG6dbpH/Z4/EuDe4sUCrZGVZ8N7lO0Vol
   y1JCPsvof81iQXT7ljUSWmtbqVbJaIMaucLSqCGnWr06CHse/q4ZmagIC
   ZCNhihpjZAxkUJJV0JNZjJiwT35m7aNFWs+oVcIWTNYK0/ceM+7lcIk5U
   A==;
X-CSE-ConnectionGUID: LC3W3tFvSHS8wMrwTvfY3Q==
X-CSE-MsgGUID: jtvIf186S16jLr3EBUi9Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="93297400"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="93297400"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 23:45:22 -0700
X-CSE-ConnectionGUID: 3boogGn/QbSibZTv2VvxwQ==
X-CSE-MsgGUID: Ktv6iYDNRUWFy3+4ujdeEg==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 23:45:20 -0700
Date: Fri, 19 Jun 2026 09:45:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <ajTlfuOFHXlA7xdu@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <202606182046.AE5F6A241@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606182046.AE5F6A241@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37916-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C8BC6A429D

On Thu, Jun 18, 2026 at 08:47:34PM -0700, Kees Cook wrote:
> On Wed, Jun 17, 2026 at 01:12:36PM +0200, Andy Shevchenko wrote:
> > Convert size_add() to take variadic argument, so we can simplify users
> > with using a macro only once.
> 
> Oh, this is fun. I like it. :)

He-he :-)

...

> > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)
> 
> Is 4 the max seen in practice?

In patch 2 there are 5! In cover letter I also mentioned a new user
(there are actually three). And I remember seeing 3 somewhere else.

-- 
With Best Regards,
Andy Shevchenko



