Return-Path: <linux-wireless+bounces-38024-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GAmZMZ7mOmquKggAu9opvQ
	(envelope-from <linux-wireless+bounces-38024-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 22:03:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E76B9D4B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 22:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hdfumXSE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38024-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38024-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C01E308C10B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2243921CD;
	Tue, 23 Jun 2026 20:03:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B431A570;
	Tue, 23 Jun 2026 20:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245016; cv=none; b=WI3hH5iocllqSmH5hM/YiG1CH4l/xgbupL5jgO01irSdhfU4C/VK4inegV4iHuqAm6zkOl7lXXb60vyShsqBwbuJ+iXB5mFVsVLxoSe7ZiAXN3LVPkYCCVCmlQi0qIB7JDOnLhDCgLHkUaPdIJP2Jkx14daq5OpTdmOQTHM+D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245016; c=relaxed/simple;
	bh=raejfHvRtyuaWsDY/iLf61uT42BKgvn0NbXLzzZ5cZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfB542I2ymKcWFUoKiUpkbTGr+KyAJtTB0RFVKk9ygCq5+KylDAUcoZ49eZ05xRNEx4IQzrebYIfsndRJbv4awBYR45nkl4rgxs68RX4N27u7atdu2hEz1Dvi4vDNqRdof7kd6CrKMtSJ1Gxx08Jh92lOG+dCTnRO+WJ1rNYpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdfumXSE; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245016; x=1813781016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=raejfHvRtyuaWsDY/iLf61uT42BKgvn0NbXLzzZ5cZs=;
  b=hdfumXSEi88P98fAk+RWTeAVmuqkyhbeQKqO/e8/GNfGE8bpdCT0Jetx
   96UKQqr7mxIxzAZ5pmSu9Mt227/dalqrkKk6B0zT4q6ClLZ2NiPknmpdy
   16W+yDaNn5MIuH4ctqGRcQc0Wkuh2OeKMV8I+dtFKj5duTsxE7fc4YTw8
   PJ3UXLSqck/CRsrg9Xlco9vhjo/R/4alJ1jl+gy7b1Xf73DLfbsY3bbmd
   5QTgwSxv/V9hd7uSLglHFs4s9RyqXFDlEUGKhaNPURkuQ2DZVqVaThryc
   oBuNTbo2TTIdGdevc2WpSQzmuklgAgGvlSn5dlb0B5p3KzZAH1p71rN8N
   Q==;
X-CSE-ConnectionGUID: wq7hu0X4RNigeApJm8OtrQ==
X-CSE-MsgGUID: cLBuiSkcSA2bMxlirVXKtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83000062"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="83000062"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:03:35 -0700
X-CSE-ConnectionGUID: QF0AOM7TSKiWZXfLnuLo0g==
X-CSE-MsgGUID: U+AHMSvfQiCI8evS/Le8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273305905"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:03:32 -0700
Date: Tue, 23 Jun 2026 23:03:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <ajrmkvkytdQZe83U@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <202606182046.AE5F6A241@keescook>
 <ajTlfuOFHXlA7xdu@ashevche-desk.local>
 <202606192025.CF68F2E@keescook>
 <ajY5hg0f34C-iV3R@ashevche-desk.local>
 <54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
 <ajqTpJAMFFV3H5Im@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqTpJAMFFV3H5Im@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-38024-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A8E76B9D4B

On Tue, Jun 23, 2026 at 05:09:44PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 22, 2026 at 01:16:29PM +0200, Johannes Berg wrote:
> > On Sat, 2026-06-20 at 09:56 +0300, Andy Shevchenko wrote:
> > > Johannes, are you okay to take a new version (I assume the wish is to have
> > > the balanced additions)? If so, I will prepare one.
> > 
> > Sure, I can take the patches, sounds good to me.
> 
> Will send soon, for the record the *.i file is 61 character less with the patch.

After looking closer at the potential users, I see less benefit of this change
than before. The other case in one of wireless driver can actually benefit from
separate size_add() calls and temporary variables which will be reused later in
the code. The similar approach even can be used for nl80211.c case. So for
now I abandon this until more users come. (Of course it might be that I'm missing
something and if somebody knows what, I would like to learn.)

-- 
With Best Regards,
Andy Shevchenko



