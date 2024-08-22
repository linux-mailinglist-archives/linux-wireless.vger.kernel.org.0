Return-Path: <linux-wireless+bounces-11805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EF95B685
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D721C23714
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143171CB31C;
	Thu, 22 Aug 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhqxQj7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BB1C9ED7;
	Thu, 22 Aug 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333090; cv=none; b=aumW4aLxK6dr6kBqBaCmUOLSECV8yijkWSW8/OqhLekKU7rZJBLVjDhr0AR9jHFvxQsojxYEDLvIgs1W4K3AobEXXCtNyv5WtmmxNMhcoa3RDzv/8Oz0wVqY6j4pS1JwUcA68r33PRpXnny3QD8QWTWeHQHyWYMuA39Bid+7quM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333090; c=relaxed/simple;
	bh=hMKTAFPMmnp5ENGpfIiTVO92Kxs1Ls8UZuBvyv6u6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChTkaJWqjl44FZj5Rcf0a/FKG/HVu+2r/RzGxxH9qcTbBJLzwItYnUUhWiKFjSpdaRDYgO0whlLYYmKAhJaNmTxa3j/8kwD4/+oW2pxdAuHKvq0YeakFGzYaLrpf4h8++/74Fq0kZ+JWoUT9/z1rVkjvXogmf8nQtk/aSo+KKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhqxQj7r; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724333088; x=1755869088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMKTAFPMmnp5ENGpfIiTVO92Kxs1Ls8UZuBvyv6u6KA=;
  b=HhqxQj7rwDahoVuVpjlvWkcrpk39tb+03h9Dn4PR7MmbOlMwXMqjcZwu
   lJwLXnAunPNBa6yihlADvCXSaC7oHOVh58j01Sb7AC9CNDJqILw9hmjf7
   SU4OeytI1DW6Y78DfiCFEd1EUBz1TsUiba2PHtmgfx2NlhLcJ603JgAlo
   Yf3KrAoGnmf/J0TfoDGDtY4gmcv5uY7SftkJLhI5Ifbczic6pmFNccmhl
   j2GaT+1ur/lojDPJjZPM/KGJNwoHMqI3wiX3hlt8H8cpYOFVtvw/6Cw5h
   cL1X4CPeSZTNvfrlI77VrVG7daqukkJQCj51PWOdiR6aj4umVEGHLRW4t
   A==;
X-CSE-ConnectionGUID: q5gDb6TsRBuEveF95PECFw==
X-CSE-MsgGUID: okOYYW7DSNiDyNTyHuphdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22614292"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22614292"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:24:47 -0700
X-CSE-ConnectionGUID: NjfhMLZNRSWmH0Sokx28yQ==
X-CSE-MsgGUID: NR8tqyPZTBOZ7ScQOTO1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61596395"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:24:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sh7nv-00000000SjU-2eDK;
	Thu, 22 Aug 2024 16:24:43 +0300
Date: Thu, 22 Aug 2024 16:24:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_cmd_802_11_scan_ext()
Message-ID: <Zsc8G-c6xW982XLU@smile.fi.intel.com>
References: <ZsZa5xRcsLq9D+RX@elsanto>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZa5xRcsLq9D+RX@elsanto>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 03:23:51PM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with a flexible-array member in
> `struct host_cmd_ds_802_11_scan_ext`.
> 
> With this, fix the following warning:
> 
> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



