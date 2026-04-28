Return-Path: <linux-wireless+bounces-35443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOxgOG1e8GnDSQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:14:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57647E967
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D25130C1AE4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101D3AC0EE;
	Tue, 28 Apr 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4xJxPnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DB39A049;
	Tue, 28 Apr 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360236; cv=none; b=av71NH/u8wHneighhMhkmfjrhPh+jWgzw53jUE2lA56ky8QrV/+ALpDdHDhOaggPYi5MwpCBmdiygAUbSYCnpysyJyVK1mEQ3NCkRxPTnQjpUoGcUYiazU5l4dXH6tvTE/Ocwj+A/YMRAtVTlgu2WWfV6n9VOKBmqRWBADGE2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360236; c=relaxed/simple;
	bh=X/LMtGLsAI98KpSAX0nwBX/szOSGt8ghowDeNGWHy9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJKtP4OST241h86/gE2YVnioYpPTXfTgLt9EpEhdRINlAI9JwD1QY+0SKy+zJmjFQgSzno29aoEQnosOM1bGV5ZfKYdarnV08iKIKq8uvM0xF41z1vI5Zf89o9I1mNJ/8px8kbETxcrEjG1KQaPhAZbW0P0+9b+XCby5hXgG9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4xJxPnq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360234; x=1808896234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/LMtGLsAI98KpSAX0nwBX/szOSGt8ghowDeNGWHy9w=;
  b=f4xJxPnqOOjTKIvaiPGB6pHrYvEWO4yXkcteqRVtUluMDxppSp5tOLnw
   2KgsWY6UoBmYCQ19SSw98sw4t2du3B3KengqB71mRjM3HkdSQzjETJORk
   rOD6OYHl/elnjkgVwFeIg+9kO829Hx4l7O54aII3DLOWuPueIB4yaO0CW
   OcyA42McGjN9ma56K43zghu4ROXZ8MTRxnnuOxkbA4vZOxpmokMdkBdNF
   9WjyeR4KpdorfbVgedEbJK4xE9gUzntvMbJqjodIG25ybtEXMgE5LhP1b
   H6n4W1wjghtluxi0TMKHZb04bfyk6IqXX9JpTK5EmUE/bN5e2pPaJzAGi
   g==;
X-CSE-ConnectionGUID: CSbc6oE4T3KR5bp7jStLDQ==
X-CSE-MsgGUID: WHDjQXjcTWaFMQZovvK4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95674680"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="95674680"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:10:33 -0700
X-CSE-ConnectionGUID: lVSkmhXlQ/mFlOhxzX6tFQ==
X-CSE-MsgGUID: tuF8HfU7RNWOHPfANBcGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234150595"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:10:25 -0700
Date: Tue, 28 Apr 2026 10:10:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
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
	Ben Collins <bcollins@watter.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Message-ID: <afBdXj_9r25Ssnz6@ashevche-desk.local>
References: <20260427214127.406067-1-ynorov@nvidia.com>
 <20260427214127.406067-8-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427214127.406067-8-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 7C57647E967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35443-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 05:41:24PM -0400, Yury Norov wrote:
> Switch from sign_extend32(FIELD_GET()) to the dedicated
> FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

...

>  	for (i = 0; i < ADDC_T_AVG; i++) {
>  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);

In the same driver the GENMASK() is being used, why not  doing it here while at it?

>  	}

...

>  	for (i = 0; i < ADDC_T_AVG; i++) {
>  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
>  	}

Ditto, and it even looks like the same piece repeating twice in different
compilation units of the same driver...

-- 
With Best Regards,
Andy Shevchenko



