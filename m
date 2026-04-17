Return-Path: <linux-wireless+bounces-34953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIl0CMl64mnh6AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:24:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A043041DF42
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830DC300F9CA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC635F195;
	Fri, 17 Apr 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeubjtwS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC834EF03;
	Fri, 17 Apr 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450199; cv=none; b=cSQ+uSSgfrMkuLQXXhRGEkOYGztxcvvJRpcgprgH7/Rseo+eso7ZwIHEoQl8U80bfH45Jttr8v+5bmsbcTqpDx/mfabaEWkyCJMCgfAPewWu4UGWBuf9OfY95h0h/tEN1gkKAvETi2oZ2XMxRr4bDBpYjMSRAQ2una9Jg1KAo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450199; c=relaxed/simple;
	bh=MVZDuYa3KkkMxVmkRpVZdc6FtKg37CpLVbjbacBMFao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1MJ3HhuTvdkAbNv7ZI/kipTT1FfplIVv4RzauNyN6iw5uYH4lhgGVLtuy032NM26xvLbdGajRFmNdhn6RjWu4E5XYmdJmoP0po3NlY5FgMo12kzrH0BTSz1m5sqf6eC7Zqx2R2M7Nw/DC6AnXKnWiD/h+px4w1fS7O0wgJ5ayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeubjtwS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776450195; x=1807986195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MVZDuYa3KkkMxVmkRpVZdc6FtKg37CpLVbjbacBMFao=;
  b=NeubjtwSfX5NFzM5S0VuP+IB+WtqYINGGpUeBI5jq86vUYqzUDLIOAkl
   bzXnk2TjtSm4zLUdbqly+BbrfVj3fknpKDVA/vMY+WT8ijaEHTLb/G4zD
   HKfwID/Q38f5mnEDj9J40Q4hTfsepd18yRBoKNyXR+QO2E4dyFRaouYDM
   cHViCaTRT56ZzzGuhBukF2htuUghTwsb0YlrbkSR51JNth0j+ZjAXvwtw
   /rrUA3gpTAhukFXTHtG/ZBCAeJ021C3tiOu1mZt70/urJS1lZ8ES0/vyM
   0+Fx+QMnpb6lmLxLSVzfVgBhOPo5TYG6HucntFByp3lzmCwLCPs1+00hs
   A==;
X-CSE-ConnectionGUID: s7pY2z+iQyOkqaS6oiknvg==
X-CSE-MsgGUID: N+H6dAjNRyK6N7NKNmpODA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="102931943"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="102931943"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:23:13 -0700
X-CSE-ConnectionGUID: 0seW7lPKRH6LPo/atTzGbg==
X-CSE-MsgGUID: kWw5IYGsRSyZql6XwHmZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="231376986"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:23:03 -0700
Date: Fri, 17 Apr 2026 21:23:02 +0300
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
Subject: Re: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeJ6hnZSbo2DrLpi@ashevche-desk.local>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34953-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: A043041DF42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 01:36:11PM -0400, Yury Norov wrote:
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
> index of the most significant bit.
> 
> This series adds a signed version of FIELD_GET(), which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.
> 
> Patch #1 adds FIELD_GET_SIGNED(), and the rest of the series applies it
> tree-wide.

Here the example is missing.

Nevertheless, I looked at the implementation a bit and wondering how would it
work for 64-bit mask of say GENMASK_ULL(63, 60)? Wouldn't it give an overflow?

-- 
With Best Regards,
Andy Shevchenko



