Return-Path: <linux-wireless+bounces-11765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2395A652
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE21F21E67
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BA170A2A;
	Wed, 21 Aug 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP6njGY2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBD7405A;
	Wed, 21 Aug 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274411; cv=none; b=aLmteEqmGTykBWWR+9sEIT+5X2SlfF9tidnBQQ7uuh3rZbPVVPIPU0RGGjdYkWFaLVliM/cxB5kx9ekZrO7bmEvCBkNGpzkihp0MfnjNOLwic836kz7wYXxIqJB5v+/swVDEgQoo1seJJoq7BVwx5AhCf5lGGi6joOXPOnpRhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274411; c=relaxed/simple;
	bh=SOwHPJJRqFYK0tUXJ5zHDMl8r8w+xSOxczRgPHBQ+0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnso3HPseOKi2V9HFfb++mw1yQeNXNQvCKvbvCjLjFSa6xQMpWCZGP5pmCBqk8jQRpyLMX8EBmnPi05DyaU5VSFTi3mWPD5t1R+WhyEQIm/vjmmR287/Cz85c71LIPbGzYELSf5BfSVKkdg9cxkyxp3TK0ZVo9TRX7ZvclCz3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP6njGY2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724274410; x=1755810410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOwHPJJRqFYK0tUXJ5zHDMl8r8w+xSOxczRgPHBQ+0I=;
  b=BP6njGY2k8N9ZwujbgSsTKky49GZkWLHjkiouEpi4iknXDv9XrXAN2Mx
   j9G1IxSSyybcOvD1wGqkf7WJlRcfZKS72AkhrzWia+Om3/cy8LjRiTVUD
   1aDWh+KxFOWrdc5dLNzL9ojOPX3R5xB8evRPO66x4VwI9E2ABUx5329Ej
   THvZokW9N8aiFaPpQM4ppxMA6PbNvC3H49HZKctn34Og736KxFkDBsf2w
   9dJXJXzV91LE/a4ypGXwRum3EDR8k/mNKi8p49Gwk7LqBT7OLoBK9mkMs
   moyLA8HG9eoERTI1I7fhQHsVZ3d4uSX+3Zg4iBU6FwXnfKbKXzkw1MRqS
   Q==;
X-CSE-ConnectionGUID: M2FuLOhlQ3yMHUwJItRJ4Q==
X-CSE-MsgGUID: NI2jNDoKQS2cTo6jcasXyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13142368"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="13142368"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:06:49 -0700
X-CSE-ConnectionGUID: LvVA9yNYRPOpDxGkiG6EGg==
X-CSE-MsgGUID: m2M1DmySQaarIwYzAWexAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="66041794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:06:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgsX0-00000000Ejk-1GtH;
	Thu, 22 Aug 2024 00:06:14 +0300
Date: Thu, 22 Aug 2024 00:06:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Amitkumar Karwar <amitkarwar@gmail.com>,
	Ganapathi Bhat <ganapathi017@gmail.com>,
	Sharvari Harisangam <sharvari.harisangam@nxp.com>,
	Xinming Hu <huxinming820@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Replace one-element arrays with
 flexible-array members
Message-ID: <ZsZWxnfy21CpOLoR@smile.fi.intel.com>
References: <Y9xkECG3uTZ6T1dN@work>
 <ZsZNgfnEwOcPdCly@black.fi.intel.com>
 <93b3f91a-baa4-48e1-b3eb-01f738fa8fc1@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b3f91a-baa4-48e1-b3eb-01f738fa8fc1@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 02:59:34PM -0600, Gustavo A. R. Silva wrote:
> On 21/08/24 14:26, Andy Shevchenko wrote:
> > On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
> > > One-element arrays are deprecated, and we are replacing them with flexible
> > > array members instead. So, replace one-element arrays with flexible-array
> > > members in multiple structures.
> > > 
> > > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > > routines on memcpy() and help us make progress towards globally
> > > enabling -fstrict-flex-arrays=3 [1].
> > > 
> > > This results in no differences in binary output.
> > 
> > Sorry for blast from the past, but I have a question here.
> > 
> > This change seems converts many of the flexible arrays in this driver.
> > But what's behind this one?
> > 
> > struct host_cmd_ds_802_11_scan_ext {
> >          u32   reserved;
> >          u8    tlv_buffer[1];
> > } __packed;
> > 
> > 
> > AFAIU this needs also some care. On the real machine I have got this
> > 
> > elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> > elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> > elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
> > 
> > which leads to
> > 
> >          memcpy(ext_scan->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);
> > 
> > but the code allocates 2k or more for the command buffer, so this seems
> > quite enough for 243 bytes.
> > 
> 
> I think this would do it:

Thank you for the prompt respond! Can you send it as a formal patch?
Or do you want me to test it first? (If the second one, it might take
weeks as this is my home laptop that I don't reboot too often. I think
it's can be sent anyway.)

-- 
With Best Regards,
Andy Shevchenko



