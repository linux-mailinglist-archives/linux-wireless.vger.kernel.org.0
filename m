Return-Path: <linux-wireless+bounces-37937-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g5XgHJE5Nmrh8gYAu9opvQ
	(envelope-from <linux-wireless+bounces-37937-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:56:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D206A8778
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:56:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RclVktE3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37937-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37937-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA40302EEF7
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097E374E79;
	Sat, 20 Jun 2026 06:56:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7E1FF7C8;
	Sat, 20 Jun 2026 06:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938573; cv=none; b=tI9lOx4XMGpW5BT/ILoJTbqtiAPV4b3iCNGtCvUvEq68tr4Vx6UslIbl96L1SbCy0Nlf/ZNRl8W0LMdbJpcFhmReYQhaoY/q2XUOhxp1bBoqfEfP3hwjjlpu7FBER+FxJcOJJ1xM0BKFJhIjdhEOv0S0RzOWLPOaDK8N66TUo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938573; c=relaxed/simple;
	bh=I0g8DG5LApiabPB1bpcrHSa3Tizh/Pl3lI63mk5LL0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpMFrpa6bfIsI1CyxOPgcHK/VROiaDRb789fkrqeoxUziPowlB/JzWupJ/MMXbHGEPONHRJlBVLJujtVWyzEUGS3qvx+fNpm0lMQ7G7tCdpMTT9w7huMWBnVdHHBruKb8QbLBSv5M+3t7ozaaF6+xn7v0Dx+k30hEHkoVEpm/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RclVktE3; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781938572; x=1813474572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0g8DG5LApiabPB1bpcrHSa3Tizh/Pl3lI63mk5LL0I=;
  b=RclVktE3Z7NT7tHhAVg/cupPEzjVR1zy36mFc6IRCZvAADCmHwx0XsKZ
   ILveYQYv7/DrODh48HYeRk6SCchTKuLOSBr//c9GU3Up+qzbwhp/VfM0b
   gNu6kXFJEeVikK1mvifBqiLawydnR+GTAYAzLIYvLNw+imaZRmjynW9qm
   jV+nnf/xzdjEcoLFuP5CZ6NFp+O3VI29z1qPOMf6KQ/8DQu8bCETAKHY+
   emawRSvkRjUE4eISeJrZJyS9m8sWBgpYM1Je6urJ0itP1zJtoe1kg2K6+
   /2xn/LRKaFv+wTXUV531zluch71ZsD3RrXovsk+0Qm9WsS2b/3frNDdyh
   g==;
X-CSE-ConnectionGUID: gYfC/+fOTAGmAry0G7QLFQ==
X-CSE-MsgGUID: MMlcnvSsTuy8YdKEtX4e3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="94260297"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="94260297"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 23:56:11 -0700
X-CSE-ConnectionGUID: jUFjyjp8SHWqMBY+01kGFw==
X-CSE-MsgGUID: +CLgWOGPSaOSUMaauzxsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="272476596"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.0])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 23:56:08 -0700
Date: Sat, 20 Jun 2026 09:56:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <ajY5hg0f34C-iV3R@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <202606182046.AE5F6A241@keescook>
 <ajTlfuOFHXlA7xdu@ashevche-desk.local>
 <202606192025.CF68F2E@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606192025.CF68F2E@keescook>
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
	TAGGED_FROM(0.00)[bounces-37937-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:johannes.berg@intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ashevche-desk.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9D206A8778

On Fri, Jun 19, 2026 at 08:27:33PM -0700, Kees Cook wrote:
> On Fri, Jun 19, 2026 at 09:45:18AM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 18, 2026 at 08:47:34PM -0700, Kees Cook wrote:
> > > On Wed, Jun 17, 2026 at 01:12:36PM +0200, Andy Shevchenko wrote:

...

> > > > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > > > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)
> > > 
> > > Is 4 the max seen in practice?
> > 
> > In patch 2 there are 5! In cover letter I also mentioned a new user
> > (there are actually three). And I remember seeing 3 somewhere else.
> 
> I feel like we should allow size_mul() to work this way too, though I
> don't find any users that would need it, so I guess just size_add()?

For now, yes. The array_size() can be modified as we have already two of them,
but I don't remember seeing more than 3, so it might look like an unneeded
churn.

> I'm fine for this to go via whatever tree is first to use it:
> 
> Acked-by: Kees Cook <kees@kernel.org>

Thanks!

Johannes, are you okay to take a new version (I assume the wish is to have
the balanced additions)? If so, I will prepare one.

-- 
With Best Regards,
Andy Shevchenko



