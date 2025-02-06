Return-Path: <linux-wireless+bounces-18591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC6A2A511
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1077F7A2083
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A0226539;
	Thu,  6 Feb 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV7KPuI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CD226169;
	Thu,  6 Feb 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835293; cv=none; b=YYmxqWiKNzjQJoGpez2cUFYGKeCPcax08nXK6CXwlRmDFe7Y6Sx9OEKpA0fHBMAb4CLPIk7g62MgHfVBSgfWZpv9QPbzCaUYzDc1pTXTTBcv6hJpO5IHgOGQSBokXeR69qSik0nSbAvS1NYji+6yLUT55NzqiXw2ZHNNq43UToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835293; c=relaxed/simple;
	bh=Zcs5Snf4g8flz7TYouYgDp3W2DHK3PiGIpAbCvqR+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckUfV97tuMhuYChCE+yZ7X9qq9vHk82MMkusYTWH+WkjEH5KVJ3AT2EYAWjDP9ps1Fn2EpWRRcXutkh1cnQKUH8gKrgkWCPLUuadiAa9b1HwOpCX1mM9U/p5mGkGiQ1xcAZR17xL2UUGDQzuR3HdUN+PFdZITWc6oMHrm+JFBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV7KPuI3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738835292; x=1770371292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zcs5Snf4g8flz7TYouYgDp3W2DHK3PiGIpAbCvqR+HM=;
  b=hV7KPuI3JymAskwy1Gtbw2ZQ9bu2OLPmq7erGJeHDgLQAsA/XttsPsKd
   iIiAF/DYA2j5r8FjU4o65Mwrug5dnqWsc4TfXeWsRHc7pNnco43l7+YvW
   3TkQVJR0rFDciT3KGQUFQ98tcVAhW9i1tyvf8p40yZ6d8vatI1+TliL7A
   mm5KSnRbStSymtUQOUl1sV8XS5xpAlsXU1SMz8P4LDKB2DhxLCTgO4NCP
   Ulria1jUSjfj7CvP+EtS3ke3b33oa5Pi3HJOB9nI0ipHLviUCM4gApl1n
   9/py0N/8ZFaiinPToQNN4xUVnIF58+Ia8+08RpQeLwMVUkSxat77LXBta
   A==;
X-CSE-ConnectionGUID: bsCNwcH5TpGXsdilmzNB4w==
X-CSE-MsgGUID: om8mz04ORu67LojgRpyOUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43092133"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43092133"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 01:48:11 -0800
X-CSE-ConnectionGUID: moeHN7m+QPajiFGHxiYh3Q==
X-CSE-MsgGUID: mmIcINAIRZ+fvr1HFc8qig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111127724"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 01:48:07 -0800
Date: Thu, 6 Feb 2025 10:44:34 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net, treewide: define and use MAC_ADDR_STR_LEN
Message-ID: <Z6SEeO0QFx9Y52LJ@mev-dev.igk.intel.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
 <20250205-netconsole-v3-1-132a31f17199@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-netconsole-v3-1-132a31f17199@purestorage.com>

On Wed, Feb 05, 2025 at 10:21:30PM -0700, Uday Shankar wrote:
> There are a few places in the tree which compute the length of the
> string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
> constant for this and use it where relevant. No functionality changes
> are expected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/net/netconsole.c           | 2 +-
>  drivers/nvmem/brcm_nvram.c         | 2 +-
>  drivers/nvmem/layouts/u-boot-env.c | 2 +-
>  include/linux/if_ether.h           | 3 +++
>  lib/net_utils.c                    | 4 +---
>  net/mac80211/debugfs_sta.c         | 5 +++--
>  6 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..6db5af2d8d059fa5c072194545d4408eec19b4a9 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -675,7 +675,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
>  
[...]

What about ieee80211_sta_debugfs_add()? (net/mac80211/debugfs_sta.c)

In gerneal looks fine, thanks:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> -- 
> 2.34.1

