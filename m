Return-Path: <linux-wireless+bounces-34952-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IzqOjV44mnh6AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34952-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:13:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC841DDC0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1E3B3002504
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5734F24A;
	Fri, 17 Apr 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEGgjt09"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943A34EF03;
	Fri, 17 Apr 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449581; cv=none; b=hGUPbbn2jRC65/WhoX8WTmhRJ6rvpqgAqgKEIEH9R7hFHhMSDe4On5LQjhi2c4Dnr5dq/N4yi4uH65HHBscFM3y/S6ZoZysxsnJuW3R4E5BBbCzzUGJzIr1jrKeGfzzN/mJ7zeAv+MWth+6cD7GYd43Xp1KjxHFj3z5TQvXLz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449581; c=relaxed/simple;
	bh=CddpyCtlyuj5f3NsZSk8oHQUml9Tggv7gYSrOfGEKoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhqatMc5ux1Pm/OLKg1mkKZP6Ggp+lmB8xacWpmy0dDjHZIDI+n79T9LvjAdfwYQgHoNYoGM0zIfKQX5jNcXmJjWDPBi+hCXbEBLNgNFaP0Zo7VfXl5E4px0Hy1IJcy8k/m8mgAX9jDkZQiwVakIx2vnODj67Hvyk/8LotBTLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEGgjt09; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776449566; x=1807985566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CddpyCtlyuj5f3NsZSk8oHQUml9Tggv7gYSrOfGEKoY=;
  b=TEGgjt097O+rjqDKuSQ1N1DbyegAb+m3xI3P9Piz4e2gGFmJheG4My82
   IwIK2VK1SxiHkeWQqX25wG6UGuKU7PnP44j53ajxekgpthqRXkyNBgby7
   MNmIYYbJ/pg02296xKHFqoNkY42bhUMnB20BdqChzXykIyDDMOmeSUERv
   UuN4QPZoOLouSAgECeQLi77bPpK8xkHphRkxRI224rCAw2yqN/Ts38ENZ
   6OvUUQhSGMvyM6hYDec9foN+YRn86SrKynRfpv+Zuvd3Kbr2BIq8B+XMG
   eTEI+Oyy0jO/EPpS9mf0wpPw8HWig381eIpkkHutu18/EYke1a3C09bli
   A==;
X-CSE-ConnectionGUID: oHGIpSGoRWy8fv2Pjv004g==
X-CSE-MsgGUID: iWfMJy+ETGuA1y2PRf//TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88167918"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="88167918"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:12:39 -0700
X-CSE-ConnectionGUID: OFYd4/ZAT1SFu3IFjjdGtg==
X-CSE-MsgGUID: 26Wz3oNFS6iMK1xPjFlxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="227968271"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:12:32 -0700
Date: Fri, 17 Apr 2026 21:12:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeJ4DmKB6p6klrqB@ashevche-desk.local>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417173621.368914-2-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34952-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: E6FC841DDC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 01:36:12PM -0400, Yury Norov wrote:
> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
> 
> Some drivers need to sign-extend their fields, and currently do it like:
> 
> 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> It's error-prone because it relies on user to provide the correct
> index of the most significant bit and proper 32 vs 64 function flavor.
> 
> Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.

...

> +#define FIELD_GET_SIGNED(mask, reg)					\
> +	({								\
> +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\

> +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> +						__builtin_ctzll(mask))));\

I would re-indent these lines as
		 ((__signed_scalar_typeof(mask))
		  ((long long)(reg) << __builtin_clzll(mask) >>		\
		   (__builtin_clzll(mask) + __builtin_ctzll(mask))));	\
> +	})

-- 
With Best Regards,
Andy Shevchenko



