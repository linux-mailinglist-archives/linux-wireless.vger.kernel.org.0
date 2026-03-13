Return-Path: <linux-wireless+bounces-33196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKDTDWbJs2kqawAAu9opvQ
	(envelope-from <linux-wireless+bounces-33196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:23:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B969027F891
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D01593005EA1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7237B3E9;
	Fri, 13 Mar 2026 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9jGkyZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC26282F02;
	Fri, 13 Mar 2026 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389970; cv=none; b=ckBBxZf+gRtozfUVDHFo3oiK90vtG878ZIwzqo1qOvakLMBpOOeM6wVTEGhroRxmZJ5Swn72uaaRq1ldNVng06OeF8JM/m5FbC8k/Tu5W3uwV5oro+RJ/VpfpPWDViFxN69ubJ22dA+viE6Em/D+rN51roI8pZ69AO0LvH0PpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389970; c=relaxed/simple;
	bh=m7edpa5kTYRBXIFOsTax/1exoALFKjRIP/hfMMmsYZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1V0hTVmqFFH0K6qc6md3eheN55yRzOfOexibZsw1BUT0gt7WS8R4HbTeeBOI4ZxXz22eseh+Z4pBbbijAgppDfIHGtsjeRuWnlNBVCDPyKCrYI+CNmJthsZ64O5NUGHed6lp9Eypu0JBcveonwnJDZCCWa9GRecP3I4QUla6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9jGkyZP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773389969; x=1804925969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m7edpa5kTYRBXIFOsTax/1exoALFKjRIP/hfMMmsYZA=;
  b=j9jGkyZPNDcGe6D+bDErikAzGl24hlxBz0uW9DbkPV7R3d71PhuFzxxy
   OCCz7Fdpj1Wo6jlg0eEtJFMMwvSt7sy6prnTjRWRJ2PhP/Fs+AuUossgl
   jDczxu/61+GJSBoHDDioZVG1IfBmBdpMmltSMTt2I04KkOimvrmuIiJx3
   /p9vDNaKEH7rBHp71LB9wzSTCgQ9dKBqgw6eOOyv1vT5EasL+E2xHPYxT
   lrlUDpfCk/+VT4sybs7OzLlGmN0V8YkWOXLIAsyYJHdLmde6st7CrbIg2
   tIMsUcuhE7F39334tiF1d1cq6sqIZkxkLmOrbr8s1Kpuc3iBB206G+fNB
   A==;
X-CSE-ConnectionGUID: Ti6bS03ITEyz34rhUBFGZw==
X-CSE-MsgGUID: D23qxDYoRfGlCPEOxCH8qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="92070385"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="92070385"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:19:29 -0700
X-CSE-ConnectionGUID: d8JBjj9MTgu+j70Fsd85vg==
X-CSE-MsgGUID: DjysSfnfRDmtuJ+YAalEzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="217543473"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:19:26 -0700
Date: Fri, 13 Mar 2026 10:19:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Alban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	=?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <abPIi0qsJDDSdfLp@ashevche-desk.local>
References: <20260312-descriptors-wireless-v3-1-5230e0870c31@kernel.org>
 <abLomhQ4faipjIQu@ashevche-desk.local>
 <CAD++jLmerNFyjGXAH9n9MKNAkcTSy3swg53=PARMqsXKjT7R3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLmerNFyjGXAH9n9MKNAkcTSy3swg53=PARMqsXKjT7R3w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl,vger.kernel.org,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33196-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B969027F891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:26:06PM +0100, Linus Walleij wrote:
> Hi Andy,
> 
> (I'll obviously fix all the syntax issues for v4)
> 
> On Thu, Mar 12, 2026 at 5:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Have you considered using software nodes instead?
> 
> That's the big question. And also: have I considered adding device
> tree bindings to map to those look-ups, that would provide a way for
> new users of these devices to actually do the right thing. I thought of both!
> 
> The big problem is that we don't have a handle on the device
> and it's name, because it comes from the device tree and
> could be named anything. Same thing with the GPIO controller.
> 
> If we register lookups or software nodes in the GPIO driver we
> don't have a reference to the ath9k device or its name, and if we
> register it in the ath9k device, we don't have a handle on the
> GPIO controller or its name.
> 
> All of these GPIOs "should have" had bindings and "should have"
> been in the device tree, but they are not, and I think some of those
> device trees are even outside of the Linux kernel so we can't really
> fix them either :( it's a mess, I'm just stirring the mud to try and
> make it a bit better by removing the global GPIO numbers.

Thanks for this elaboration! Since Bart is the person who wants to move
the lookup tables to software nodes, I leave that part to him. For time
being your patch looks good (after addressing style and minor issues I
pointed out), feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to the next version.

-- 
With Best Regards,
Andy Shevchenko



