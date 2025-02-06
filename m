Return-Path: <linux-wireless+bounces-18593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F29A2A5CA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3913168DF3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC28227564;
	Thu,  6 Feb 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaQytxVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3E227560;
	Thu,  6 Feb 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837665; cv=none; b=gVPXYDlbF+al0cPy0QVnek6ARV58PlO472OWouGXf7wTmbcESMNX1kVBEJs09hL21mUROix8ARpkI3e6XJEd4zM3b6EFxXZsSCEDXx7ZHW57BA9wW7dpG6uuPpIcdO2R9RLPI7yPxkX9r3SbSWKMhwEYJu0xtXcpA2Dsp7NFs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837665; c=relaxed/simple;
	bh=B0aenSas7uI6VgQrWrZ3K7h+bbJCK1O9BDNE8yjWiV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9PEg/i3wZAHqfPQk/mgewHJA8B10Ta3HObhA36eTJuUteFGjQ5NciFutywNCVIvbd5xUy5LEJ8cb7Yhv8tj9cZlBjQSqY4V0Pd8CsXPgk8sCP+sNd8/XfQaf7ienJM+hAM+1aw7G/q9VBQZ99SGtOD3r4KHJ4z7Abfn9CfoX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaQytxVJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738837664; x=1770373664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0aenSas7uI6VgQrWrZ3K7h+bbJCK1O9BDNE8yjWiV4=;
  b=GaQytxVJEIHD9Dv4muk7bIQGI7QgHZpf4APR+Y2CVU31AtvvER/nDrfP
   x+ouXde/m9QWxtPg+Kt7RTuEZetx0TA8VU8MsJIvJbi1EfklgEeXFtfzv
   iZQQXSCrTZVa21SbK8ErYJ7NxRde+5ntOJA/C9uZpFiZy1F/3Hj8Fegzc
   dJfF5/QmpE2UFsHImYTH0OlNADzvKFcIrwF988ZcY84Aw7/BGz22Y5jhL
   3RH+/PGEbaaIeNQYeEyPbPUBz/D+quVDja7NZM/THhLgEFGR+Ami6Y5BW
   U63QTQ9M0UJYhsqoLqYY5VU1GWNGXQHiEdLk4JgjGNFSxirZ8DSYy2tDa
   w==;
X-CSE-ConnectionGUID: VGB4zUVaSJOyOO2XYhanKg==
X-CSE-MsgGUID: n3SOVOx9Rg+EDnqX3qNzkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64787105"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="64787105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 02:27:42 -0800
X-CSE-ConnectionGUID: XqbzmsnuTg+1aaXPoCj2Iw==
X-CSE-MsgGUID: ETqe/vM9SHWZhA2ViQnQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="110998246"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 02:27:38 -0800
Date: Thu, 6 Feb 2025 11:24:06 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net, treewide: define and use MAC_ADDR_STR_LEN
Message-ID: <Z6SNxrEteMx0/0sb@mev-dev.igk.intel.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
 <20250205-netconsole-v3-1-132a31f17199@purestorage.com>
 <Z6SEeO0QFx9Y52LJ@mev-dev.igk.intel.com>
 <a2a26c7eaf20bb972289a804ecfe0e532f0f85ae.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a26c7eaf20bb972289a804ecfe0e532f0f85ae.camel@sipsolutions.net>

On Thu, Feb 06, 2025 at 10:50:36AM +0100, Johannes Berg wrote:
> On Thu, 2025-02-06 at 10:44 +0100, Michal Swiatkowski wrote:
> > 
> > >  net/mac80211/debugfs_sta.c         | 5 +++--
> > 
> > What about ieee80211_sta_debugfs_add()? (net/mac80211/debugfs_sta.c)
> 
> What about it? It's modified accordingly, just needs a bit more +/-1
> now.

I meant that it can be done in this patch too. 

> 
> For that:
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thanks for the rename, per the robot report that just came in it looks
> like that also saved you from some hassle in drivers that have their own
> MAC_ADDR_LEN for some reason :)
> 
> johannes

