Return-Path: <linux-wireless+bounces-37933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jBXWHa8INmof7AYAu9opvQ
	(envelope-from <linux-wireless+bounces-37933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 05:27:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB846A8433
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 05:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hrklvlxj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37933-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37933-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 370823007A4B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 03:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE441F1537;
	Sat, 20 Jun 2026 03:27:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54074134CF;
	Sat, 20 Jun 2026 03:27:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781926055; cv=none; b=qHVxESfjCZTG8j5k3DEPnMTn6j7B/wM/SFy6gvFzdzATccFb9EJ0HRSUORbbytvrZNTnq1eFsBK95YXWgPTQbzK6bNIIz7TA12N61uji5S7EGbfKhDsP6i5Tjl3IuSJv9h63KTBBSeDJybzfzcjecosc+NWov9h5rAoEV2cJU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781926055; c=relaxed/simple;
	bh=E/5kuHeAYlfdj2TZPAiaTlgOOgVKilt3ryiOSyDwS9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isqJJWVf+8UUaiPb4MI291VslEjLNllH43chfWuF31U6sNQ8bYQsUdLxiL4uhIGV8rV6P3Tf12friR2vsZwao32d5sye77mpl13A/uOfUIocmD4DTO+14ugd0YKmeeuoJld9+hc6ZII35pKdmhCTEJetd2vOSF+e8+KiZBv9cU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrklvlxj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4DC1F000E9;
	Sat, 20 Jun 2026 03:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781926054;
	bh=rW/RwYcFdOwQjj9zGaADk3mUcpZcjdLAWoDhbrPe84Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HrklvlxjFZsY6i4qnuOfJjCIa2Z6wUU3qYVd+KraOjvx1KuIDfQVgM9fQAAqwjI3R
	 JOOy9rfDqEkIbKSsmCUQ4aRFQvxjS4wZ63QFbNWSRQUSnzOGSqqFcD6asupf6TUKW6
	 SJPRNDOYWN/CEEWUNl8Xqi/M7HZQMO6WshMVC7SZwhHLykoQlcRulzCPVKpRXlIkiU
	 QrxN918GwPNyqfCS2ETlAlBW4XKMCWZAYH+ID72ikNqMyMaZOoH7veR11Wb1MrnPk5
	 cqy0LSiiAsXmlE4Clly7zE1zjMb+KDivz79dtIOzEyWXfUv3gKxBmkt+TbYz4kbmeY
	 1v3mVZBQFRGwQ==
Date: Fri, 19 Jun 2026 20:27:33 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <202606192025.CF68F2E@keescook>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <202606182046.AE5F6A241@keescook>
 <ajTlfuOFHXlA7xdu@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajTlfuOFHXlA7xdu@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37933-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CB846A8433

On Fri, Jun 19, 2026 at 09:45:18AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 08:47:34PM -0700, Kees Cook wrote:
> > On Wed, Jun 17, 2026 at 01:12:36PM +0200, Andy Shevchenko wrote:
> > > Convert size_add() to take variadic argument, so we can simplify users
> > > with using a macro only once.
> > 
> > Oh, this is fun. I like it. :)
> 
> He-he :-)
> 
> ...
> 
> > > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)
> > 
> > Is 4 the max seen in practice?
> 
> In patch 2 there are 5! In cover letter I also mentioned a new user
> (there are actually three). And I remember seeing 3 somewhere else.

I feel like we should allow size_mul() to work this way too, though I
don't find any users that would need it, so I guess just size_add()?

I'm fine for this to go via whatever tree is first to use it:

Acked-by: Kees Cook <kees@kernel.org>


-- 
Kees Cook

