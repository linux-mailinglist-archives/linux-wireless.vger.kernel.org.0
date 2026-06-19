Return-Path: <linux-wireless+bounces-37912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8fWRLdu7NGpJfwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 05:47:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8036A3B22
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 05:47:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YF88M5K+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37912-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37912-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2493031AC3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1635306743;
	Fri, 19 Jun 2026 03:47:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066740D582;
	Fri, 19 Jun 2026 03:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840855; cv=none; b=aEdz8mZZi7a7zqNqaHzFo078gBW92xsSG6H6+Z61VRi0aCBFN4h3mD86Seb9+YHZ/sT/ect9HvwHotc+6TmlNcsI+e6bsE9NeK64iiVQDu6epAQ+9onO6JVaSuCrhW1RJK4n5t2068/pZak9sfzAg6k8lpFDPEdKQrdP7vKg2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840855; c=relaxed/simple;
	bh=hY/2SvBcZ1vs8jx0Msph3zmlY2len1DrpJsHuxQsAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIgfeQAaRVMNSfv4TxN6I9sZDVq0Kr6DjvbZHcEtORwaJ+QrebL7LMBUtOZcJyhz7BUDu/GiDZiK1XPuXR0A8kOrTbKU8juQdmoTMNKSdoEAjlSlQO5z44MynTmxH+9ezXpJYbiUS8pCaWs8ccHX0q5ZRCNQNZAt+BtrYKokLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF88M5K+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6211F000E9;
	Fri, 19 Jun 2026 03:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781840854;
	bh=R3DrRhoR8Ti+ERqtRZvXOI1bFkrS1/hJ7ok7Od4tPRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YF88M5K+XyXQOPl8sybnvffgxm9/PEIjB2SzrSfp6II/R1M6Ul+nY9qrr1Ds2dnvB
	 6hUMeIraVY7irbs11TeAg0wfr+i7nmUDZalPZlDfbFCK1rySjyFSEoflLQhPWOj+XK
	 pozrDAITVVJBWKsAZUFAYCUzmYEOu1NonZPxXW5JYn6+PJbvHEL4fcbKxCfMc1dpfZ
	 Gh52EnwKO6a9BKnVcjzMuiqZf3nUYvI0xadJducAaQQbNJRcFJXPEo/U8OKZdBEHPr
	 cqdXtgWEUrtLL3+gqXl0e6e1C2z6DyzfYVe8TA5HlRreQjcC8kkt//CkQhgV8u2DTG
	 3iVyrOJuXXYtA==
Date: Thu, 18 Jun 2026 20:47:34 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <202606182046.AE5F6A241@keescook>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37912-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A8036A3B22

On Wed, Jun 17, 2026 at 01:12:36PM +0200, Andy Shevchenko wrote:
> Convert size_add() to take variadic argument, so we can simplify users
> with using a macro only once.

Oh, this is fun. I like it. :)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/overflow.h | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index a8cb6319b4fb..a8b0325e73f3 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -2,9 +2,10 @@
>  #ifndef __LINUX_OVERFLOW_H
>  #define __LINUX_OVERFLOW_H
>  
> +#include <linux/args.h>
>  #include <linux/compiler.h>
> -#include <linux/limits.h>
>  #include <linux/const.h>
> +#include <linux/limits.h>
>  
>  /*
>   * We need to compute the minimum and maximum values representable in a given
> @@ -337,16 +338,7 @@ static __always_inline size_t __must_check size_mul(size_t factor1, size_t facto
>  	return bytes;
>  }
>  
> -/**
> - * size_add() - Calculate size_t addition with saturation at SIZE_MAX
> - * @addend1: first addend
> - * @addend2: second addend
> - *
> - * Returns: calculate @addend1 + @addend2, both promoted to size_t,
> - * with any overflow causing the return value to be SIZE_MAX. The
> - * lvalue must be size_t to avoid implicit type conversion.
> - */
> -static __always_inline size_t __must_check size_add(size_t addend1, size_t addend2)
> +static __always_inline size_t __must_check __size_add(size_t addend1, size_t addend2)
>  {
>  	size_t bytes;
>  
> @@ -356,6 +348,29 @@ static __always_inline size_t __must_check size_add(size_t addend1, size_t adden
>  	return bytes;
>  }
>  
> +#define __size_add0(addend1, ...)						\
> +	__size_add(addend1, 0)
> +#define __size_add1(addend1, addend2, ...)					\
> +	__size_add(addend1,  addend2)
> +#define __size_add2(addend1, addend2, addend3, ...)				\
> +	__size_add(__size_add(addend1,  addend2), addend3)
> +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)

Is 4 the max seen in practice?


-- 
Kees Cook

