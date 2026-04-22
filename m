Return-Path: <linux-wireless+bounces-35215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TJ/nE6DE6Gl+QAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 14:52:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C7446346
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A82305BDC4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA13DF012;
	Wed, 22 Apr 2026 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSwTJsTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534D3DEAD5;
	Wed, 22 Apr 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861906; cv=none; b=AtVeieqE643n9l/GOvWZGkUk8RmmVTzq7gM2WghXKhaSXkhhFsHd+33XjMZ5r6dJ2ucRofAv2o2q+phsX0EotCE4deF85ln1xD/AQbIfobyovnAjYTFD1NSyiJTKm+yM/b20j52vYwcN9x1IcFQOq17FeJ7z7133oao3d8iPsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861906; c=relaxed/simple;
	bh=Uj+LL1Po7hnPnTKAi6dksaa1sxESLP9XwcWHu/2yDM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSeMzRbfIg3IOpDfJCbmY9n4j4ufNNLJPUKLEF1zb9Y2m9WBTYJ8FcjkBV/mnS4uHCQ7yTmzHArF20ESuWnsVaUDVmFdrHYHvtnA3bYtUnkcqe7JJ21RGOim8AQUEoeZUtW5BwGOgRqxpPhpzD9TZNcKlGm48sWIxYoX1VG+quU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSwTJsTi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776861905; x=1808397905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uj+LL1Po7hnPnTKAi6dksaa1sxESLP9XwcWHu/2yDM0=;
  b=GSwTJsTiAcEpU0my7sBRBLhoPlkKQuiDSmSkVWOMNSBxgPnKx8jPHtAx
   IKvywZOLd2/wbKgz4enVvMMdbeF6jpBV9ir8BsRpyPrj4BiIatwyZj5oN
   voREvYVpFx6fcy2OSfsHA6R+fcyA5UFpnCFM/hpSeauhWiXaR7BbjCOL3
   U7BLVaSFTF9smU7Nx4Juivvd1IPxJpo3zDkVWv6TTWE01LYv8Bi0oHI4D
   X7jqehcDS9geKE559XMcDeoM2XRaRyuQUfTOoJ0f7U9sZkL7tW+6NL6cp
   zStNMl9j6x7oMNU96RB/FSQ0jsCWosmz3SFojy8E2AQNVIhfYm0aUNBIL
   g==;
X-CSE-ConnectionGUID: p8w3s/UfSMm130dYx29J7g==
X-CSE-MsgGUID: h8NcAkJTTySyOlWNlExGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81422483"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81422483"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:45:05 -0700
X-CSE-ConnectionGUID: 4uy75dGYTMuQYqV/z6ZZ3w==
X-CSE-MsgGUID: fpclPLiPSDO72NzcK6mJsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231449355"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:44:59 -0700
Date: Wed, 22 Apr 2026 15:44:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aejCyTzwVAeNt5YK@ashevche-desk.local>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
 <aehwG2Egt93-sPVB@ashevche-desk.local>
 <aeipQfCYKjl006uM@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeipQfCYKjl006uM@cae.in-ulm.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,gmail.com,kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it];
	TAGGED_FROM(0.00)[bounces-35215-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 973C7446346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:56:01PM +0200, Christian A. Ehrhardt wrote:
> On Wed, Apr 22, 2026 at 09:52:11AM +0300, Andy Shevchenko wrote:
> > > To be honest, with the involved void* this isn't really type-safe
> > > either, but at least the data keeps being a pointer which is really
> > > helpful on CHERI. FTR: The alternative would be to use uintptr_t instead
> > > of unsigned long, which also has proponents in the CHERI community and
> > > which is used in the current vendor patch stack.
> > 
> > FWIW, Linus categorically told that it has to be no uintptr_t in the
> > Linux kernel.
> 
> This is probably not the correct context to discuss this but
> I will point out that if/when CHERI support is added to the
> kernel we will need a way to distinguish between
> * A (fat) pointer converted to an integer type (in order to do
>   integer arithmetic on the address) that might be converted back
>   to a pointer in the future and
> * A plain address "extracted" from a fat pointer.
> Using `uintptr_t` for the former and `unsigned long` for the
> latter seems like a reasonable choice but there are certainly
> other options.
> 
> Sorting out the difference between the two is a very large
> part of the diff required to port Linux (or in fact any piece
> of low-level software) to a CHERI system.

Right, whatever CHERI needs is has to be discussed with the project leader(s)
first. But thanks for giving more information on this.

-- 
With Best Regards,
Andy Shevchenko



