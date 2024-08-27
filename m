Return-Path: <linux-wireless+bounces-12018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B7960297
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDE71C224FC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0558B15383F;
	Tue, 27 Aug 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQN2FAjV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637F14A4F5;
	Tue, 27 Aug 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741846; cv=none; b=QmERAenLelPDJYLZ3rtFBEYnrgUi9pGIVg3tiT7hdag/UACE3bvkuXjfBMdnlI5od3bqcnDLURTUY5ecx2N170K6HsIw151cqS5h7VN6NcypSkmXwbIhCmemECA8xc5WhWns/8qhsx6DMcvph1vDRomI6svD9JVauqqCZV58IBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741846; c=relaxed/simple;
	bh=ejaaGyUZt9TQMNogW9ifZ2hr4r8r75F/LuFBrZERRF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLkBJjKMABN1fdUn59TtMfWGkGom8SDmBli5wSvMTVKSGEiR31L0D5StRfdS/1rBT2H8DYrx1I26oyAn6kkxFAXqrYGff+XPjp0cP4GWpZdKz5cbsIHKRwmVKqfbk8Tl4ZpaycOdNcXoD4pPliqaugiyYCX6Mwd/DoioRFPHa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQN2FAjV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724741845; x=1756277845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ejaaGyUZt9TQMNogW9ifZ2hr4r8r75F/LuFBrZERRF4=;
  b=KQN2FAjV2a6FI1zQhS3bGryHQZkJ5X3K81dMOYtbJbeAjIbFzrmy2nvh
   8gf9CtVPRN+j5b89Ggvh64QDigUFZMv7mju9WEhAJq2ZHRBkfT0gLwfjf
   FEjpEjv5RhIlJm3X3toDVWeNxocshV4hX+2dwldk+duJbIzZZ5r2l4S8I
   6ded9QFfkKeBYaKFCtSzR0GSJrfyMCnbgCzkWElFS63BZpwHAHIPVzujC
   6AZvf8vtNEgWSzla1osTcZJCIncFUMO6dhpBWC+5c4sxv/61YM3CizlNh
   Hj64ZP/PQhnPZ9iqJqXjdrgnpCZYT7nYaSDtQ7nbZANHhmmt/vFgi/E8B
   w==;
X-CSE-ConnectionGUID: 2ZscmJ8/T4iWI2bt5LQVfw==
X-CSE-MsgGUID: sVwwPiZaTeWkyF9NgvNq7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33765527"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33765527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:57:07 -0700
X-CSE-ConnectionGUID: AEJLZ/4FRk2B9S0w+vcuIg==
X-CSE-MsgGUID: dKi0tfu7Ti+I5CC9H1Vuag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="93505651"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:57:05 -0700
Date: Tue, 27 Aug 2024 08:55:08 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] wifi: mac80211: use kmemdup_array instead of kmemdup
 for multiple allocation
Message-ID: <Zs14TDFqER2Sub4W@mev-dev.igk.intel.com>
References: <20240827035652.33558-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827035652.33558-1-shenlichuan@vivo.com>

On Tue, Aug 27, 2024 at 11:56:52AM +0800, Shen Lichuan wrote:
> Let the kmemdup_array() take care about multiplication
> and possible overflows.
> 
> Using kmemdup_array() is more appropriate and makes the code
> easier to audit.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  net/mac80211/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index a3104b6ea6f0..f16ebad36a83 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1051,9 +1051,9 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
>  			return 0;
>  
>  		/* Driver provides cipher suites, but we need to exclude WEP */
> -		suites = kmemdup(local->hw.wiphy->cipher_suites,
> -				 sizeof(u32) * local->hw.wiphy->n_cipher_suites,
> -				 GFP_KERNEL);
> +		suites = kmemdup_array(local->hw.wiphy->cipher_suites,
> +				       local->hw.wiphy->n_cipher_suites, sizeof(u32),
You can move sizeof(u32) to the next line to not exceed 80 lines.

> +				       GFP_KERNEL);
>  		if (!suites)
>  			return -ENOMEM;
>  

Otherwise:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal

> -- 
> 2.17.1
> 

