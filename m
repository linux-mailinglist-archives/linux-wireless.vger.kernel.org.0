Return-Path: <linux-wireless+bounces-16384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FF9F1356
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 18:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A0F2817E3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507F1E4113;
	Fri, 13 Dec 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkxOFPVD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815871E32CD;
	Fri, 13 Dec 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109875; cv=none; b=URay70AJCrr6q4jxJdNyhktfeDwL8Zl9KEjY/tu0A1H2S+JXuzQRe98uI96MssK/AUTr8/Y+j/tkJaDHCTbjOwZ3k0NqqLvMkcG74au9zvO5X9YmY0DqsL63r4uLPwzdqWp1m2hbf2C44ArDduQfAsvlGj0QW2BTf2Z4XJjNhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109875; c=relaxed/simple;
	bh=43lcs1+73oMcgYgVNa8OI3qmg7j0TEA5KYxken4+b0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0qiJ8wfOspulZJGs3tmg5Iu7zmORBEYowYLTDXemme51xTII58YqUlKnnHkSszUNj2+kJG+aKHMBPseXolWed268D7WjA399pkOkp8bF039VMH+dLr5Ousw3FpsbyPooSmPGRd/LSSGXVwPyL+TmWo0pyJE/rES64Q2a7kymF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkxOFPVD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734109874; x=1765645874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43lcs1+73oMcgYgVNa8OI3qmg7j0TEA5KYxken4+b0I=;
  b=GkxOFPVDo+0aPYwy7ad6SkQ2luH3OYIZy/eD47jBuGp6E3yBJToWjZPt
   FlFH2mgqhYHJLu9E/9yfVjbajw/0plskprwaPHPy4FC0V/2vei3P2WBrt
   8PXkj3e4gAWgY0wAwmua0/Rkc13v60rc5Cni30gpnhj57omPVeMl6h8hk
   TUqUMuyKmscjpPNsUU0LZlrOexktcPGxVnXrhhA5jterdoW7n4iU/n6vp
   FrpArLw7QIATo+2qIci7MpUqBxjeGjIpkAPC2cpNT9y6KBBZR+ICpSRxM
   uhbJatHwZFtbbrKIY8XesjcAdbHegXbho2BhuReAk1L1yIOnBO9cffynV
   g==;
X-CSE-ConnectionGUID: OtA/TBWnTR2HHsmIPcO2oQ==
X-CSE-MsgGUID: cf7oPZRnQqOXIme1j91wuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45576431"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45576431"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:11:14 -0800
X-CSE-ConnectionGUID: THz8Mw9lT1KULhWa98pHdg==
X-CSE-MsgGUID: 088O5EVCSju/YnpNX2zO4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101560852"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:11:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tM9Bx-00000007Q2C-0sOT;
	Fri, 13 Dec 2024 19:11:05 +0200
Date: Fri, 13 Dec 2024 19:11:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Kalle Valo <kvalo@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, x86@kernel.org,
	linux-snps-arc@lists.infradead.org, linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
Message-ID: <Z1xqqENp6n6HZ_gM@smile.fi.intel.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-2-laoar.shao@gmail.com>
 <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
 <87r06crnew.fsf@kernel.org>
 <20241213132709.GAZ1w2LW4LgHi-6XfZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213132709.GAZ1w2LW4LgHi-6XfZ@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 13, 2024 at 02:27:09PM +0100, Borislav Petkov wrote:
> On Fri, Dec 13, 2024 at 10:35:03AM +0200, Kalle Valo wrote:
> > I agree, it makes the code harder to read for someone who is not
> > familiar with all the %p magic we have (like me).

> +1

And me too. In case one thinks of unprintable characters, %pE is for that.


-- 
With Best Regards,
Andy Shevchenko



