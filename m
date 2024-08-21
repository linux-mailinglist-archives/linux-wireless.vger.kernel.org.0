Return-Path: <linux-wireless+bounces-11763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A995A5CE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 22:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B291C21768
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9416FF5F;
	Wed, 21 Aug 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjT/tSGA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362F16FF2A;
	Wed, 21 Aug 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272008; cv=none; b=ihtWxdNXEdQpoQWxfnTHNi7WUtNzROIm8SLZPWW7oaHjbV9UVvSvrWGhtuL1sH/S/jn6BFg9+I/nP0sfOX0zi6ghIsnb3wf+qgyyK+QscOEjtdplLGoD3nqY5Hka32zHXv+JEnEJp66AWkrGJHZmRhmfML/A/+JEOqECHiLviRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272008; c=relaxed/simple;
	bh=hC7MVxEnpBSlpjnRjxHCdY9iSHf7+aorJoyKXmBQUak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A//KWPa/SOV8geSNsr0jXTleQ+Q7oc0FUqCIu1CY9cOArPTZRhYgWCY+Lwwq6/iBO5gOwyNIUVRHIOb/lkIMWiqTN9IDtwVBeHBWbSvT1YKHZbHjiRCET8bXL7wZoyuQ4VK+oY9dp0rrewaztLyE/3icPN+44z5jDrhWBOXL+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjT/tSGA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724272007; x=1755808007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hC7MVxEnpBSlpjnRjxHCdY9iSHf7+aorJoyKXmBQUak=;
  b=gjT/tSGAPoZ74cj+ONfoIrLTCfzvPAXqkfPQIFlRpJtBSDXN0wh1ahFN
   At/BvGYgYRg0ixSMjGI7jfWXp/g5rEpJxvpSSFA4HUMdNp30TRNgQn+Bw
   vcf5IFEuP3bnb9zLiECc19TBKynjIxBlnmEBL3GgPP1FKu+VlN9SWKQLO
   WJopRVDZRudfZb2Yrx3QZmHv+KzAmJjcDPTPnwQMUa/9jHQaAqMd+gV92
   tw3sDM2ky8tv1Y72Cc6hM+RPLaCmjmS63jddOA+NnFFfe/b9g4dN9CAGT
   r7pLBfIjUQuy2snntcO23xm50e3R6OQir5s3i2Khm+/Y69MREuexSKBzx
   g==;
X-CSE-ConnectionGUID: +EmeEAOEStCXXWQZa+emmA==
X-CSE-MsgGUID: O0HDUySHROuTH8lSdG5piw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33808684"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33808684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 13:26:46 -0700
X-CSE-ConnectionGUID: WXVrbJFzRtaMfynGWH7Fjw==
X-CSE-MsgGUID: t0RvxcXrS1m+eWCAQ8CTtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84379320"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 13:26:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 97766268; Wed, 21 Aug 2024 23:26:41 +0300 (EEST)
Date: Wed, 21 Aug 2024 23:26:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>,
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
Message-ID: <ZsZNgfnEwOcPdCly@black.fi.intel.com>
References: <Y9xkECG3uTZ6T1dN@work>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xkECG3uTZ6T1dN@work>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.

Sorry for blast from the past, but I have a question here.

This change seems converts many of the flexible arrays in this driver.
But what's behind this one?

struct host_cmd_ds_802_11_scan_ext {
        u32   reserved;
        u8    tlv_buffer[1];
} __packed;


AFAIU this needs also some care. On the real machine I have got this

elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]

which leads to

        memcpy(ext_scan->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);

but the code allocates 2k or more for the command buffer, so this seems
quite enough for 243 bytes.

-- 
With Best Regards,
Andy Shevchenko



