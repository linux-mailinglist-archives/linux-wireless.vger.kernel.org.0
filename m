Return-Path: <linux-wireless+bounces-37884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /eTtIseSM2onDgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:40:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFF69DE22
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:40:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DAEmYcMo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37884-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37884-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AA9303F2A1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 06:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC7330324;
	Thu, 18 Jun 2026 06:39:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C033A702;
	Thu, 18 Jun 2026 06:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764783; cv=none; b=nPBwC06asrDZztA/znC0Qgb2CdNUCGAp8lgFydxF58ULCPbFk3VawtH2J8RoR2L0q4S2fL5dIdcOO9e41MRCpzewLtyMvPU6E3tbr3z1MhhOukZFxzpXpIYGGIhfwfxka189ZiNxmvTceCP5sfyji3y1qWZAwyN/1/a+h2mALrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764783; c=relaxed/simple;
	bh=WVKYPs6mwbbo0IIgXseFHrnvYSBlOvJSny2gfO4hewk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTv9YB0QQ6o7hmLCFiBeM5SlHmaADwyHFuE5csAqt3WH20qpSoCbh3XXLfNh5gJEnYHi0i01hZWcnr+MXSH+pDzGrr5+cxWg8gFCKl3GSMMEf23yAUQYlqojiTzLqlzcgF5zpZx4DbEHQKoR7dSpadJNXgp15omamXbDWi7PkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAEmYcMo; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781764782; x=1813300782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVKYPs6mwbbo0IIgXseFHrnvYSBlOvJSny2gfO4hewk=;
  b=DAEmYcMoDAERW+hdnlzPQUHDZEn+31PGwWcd6KrG50NR8gwnfAhD5kpt
   WBq7XUUmcVFYyv/tp7ZgCzqbXmTo6CB1+OJLj5zl7K+vzseZHxvJmyDsu
   S0GVTVbXQruHW/MZUP/nacZX8OW82Y6ddu+UPOydJh3I7aQ+Agu2ZQc2L
   N8v9sc2ZXHtU2qxE16AYf1TQVJdvt7NASPWw2zfg3gkyE5DSHV3m9cz15
   mqHWGwFts1xkCvcGIYzAUaOxmB1JJp33NmOqYfPcrBSn1vwNY5QTXMml+
   mu4QnX6xuJzGLW32ItQ+eLqxf8TTaF1Rl1nSaijpu5xz9joHD7eL9k66D
   g==;
X-CSE-ConnectionGUID: stJe1aY7RgepXJzN9Tgfwg==
X-CSE-MsgGUID: 59GatvCnQ1mSHXj26JQvWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93242643"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93242643"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:39:41 -0700
X-CSE-ConnectionGUID: YKG+zQSfS1uCRgDbLkOXtg==
X-CSE-MsgGUID: sWsJuKwiQ6iXuUUEtMgDGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="271975355"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:39:39 -0700
Date: Thu, 18 Jun 2026 09:39:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <ajOSqWpYUhFTVqP-@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
 <20260617223056.754bfcb8@pumpkin>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617223056.754bfcb8@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:johannes@sipsolutions.net,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37884-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5EFF69DE22

On Wed, Jun 17, 2026 at 10:30:56PM +0100, David Laight wrote:
> On Wed, 17 Jun 2026 14:56:09 +0200
> Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Wed, 2026-06-17 at 13:12 +0200, Andy Shevchenko wrote:
> > > Convert size_add() to take variadic argument, so we can simplify users
> > > with using a macro only once.  
> > 
> > > +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> > > +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> > > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)  
> > 
> > I guess it's not going to really matter, but it would generate fewer
> > calls to have something more like
> > 
> > #define __size_add3(a1, a2, a3, a4) \
> > 	size_add(size_add(a1, a2), size_add(a3, a4))
> > #define __size_add4(a1, a2, a3, a4, a5) \
> > 	size_add(size_add(a1, a2), size_add(a3, a4, a5))
> > 
> > as a binary tree, rather than only cutting one off every time. Not sure
> > that results in hugely different code though - maybe fewer overflow
> > checks?

Good question. I'm also thinking that one-by-one may expand in too much of
preprocessor code (haven't checked myself).

> The binary tree stands a chance of executing less slowly because the leaf
> adds can be executed in parallel.
> Excluding the saturation checks (wtf is it called size_add() not
> saturating_add() ?) (a + b) + (c + d) will usually execute faster than
> ((a + b) + c) + d because the (a + b) and (c + d) can execute at the
> same time; unfortunately gcc will always generate the latter.

I'm confused. "unfortunately... the latter"? You meant "the former"?

> > Although your version make it really completely equivalent to the
> > nl80211.c code, clearly it doesn't matter if all the values are "good",
> > and I believe the overflow behaviour means it doesn't matter for the
> > overflow case either?

Indeed. Whenever the value is saturated, the rest is just matter of sequential
unlikely branches taken.

-- 
With Best Regards,
Andy Shevchenko



