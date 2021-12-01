Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C34651EE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350892AbhLAPqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 10:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbhLAPqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 10:46:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1759C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 07:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AB73CE1F9B
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 15:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD23C53FAD;
        Wed,  1 Dec 2021 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638373395;
        bh=NAMP2HxFAsdZULRAdB5/dDV+rG4r51+lPU/6v3OIhoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLesWZDIk4RmQ1B+QGjqXMTi7z4kMnRqDInK+x8oTli8UsAKsuYd5gFBY1cpB8nAN
         UOJ0SxkIxbSzsTPwzMj9jpB9p1HHTD4VifZco8N1IOMoW0fmuF0yiKBX3t2nmV1cge
         w20W6AJTUDSCPOf7vpNWC8r24ImmFRwEIr9F+wci0Rlnl1lo2SoaaanIqyZXPBb8c4
         RJzYJmqzeEhFgbID5Klfsp/sUr2dTKhpfOt7g/n+jCuRsqqLje8Sxz3ZoyRY6M/8IG
         /DDRGroKMtzuXL7F/nDKyBJijTrpI+tOff0SjIPEUGISHT7LNUEy5zx1ogpJ0nikoK
         y9b9LibfN5eWQ==
Date:   Wed, 1 Dec 2021 08:43:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Finn Behrens <me@kloenk.de>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: remove reload flag from regulatory_request
Message-ID: <YaeYDmN8DhADXOSg@archlinux-ax161>
References: <YadvTolO8rQcNCd/@gimli.kloenk.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YadvTolO8rQcNCd/@gimli.kloenk.dev>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 01, 2021 at 01:49:18PM +0100, Finn Behrens wrote:
> This removes the previously unused reload flag, which was introduced in
> 1eda919126b4.
> The request is handled as NL80211_REGDOM_SET_BY_CORE, which is parsed
> unconditionally.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 1eda919126b4 ("nl80211: reset regdom when reloading regdb")
> Link: https://lore.kernel.org/all/YaZuKYM5bfWe2Urn@archlinux-ax161/
> Signed-off-by: Finn Behrens <me@kloenk.de>

Thank you for the quick patch, it seems to make sense to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Hi,
> 
> I removed the reload flag, and set it to NL80211_REGDOM_SET_BY_CORE, as
> it already was by accident.
> 
> Thanks,
> Finn
> 
>  include/net/regulatory.h | 1 -
>  net/wireless/reg.c       | 6 ++----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/regulatory.h b/include/net/regulatory.h
> index 0cf9335431e0..47f06f6f5a67 100644
> --- a/include/net/regulatory.h
> +++ b/include/net/regulatory.h
> @@ -83,7 +83,6 @@ struct regulatory_request {
>  	enum nl80211_dfs_regions dfs_region;
>  	bool intersect;
>  	bool processed;
> -	bool reload;
>  	enum environment_cap country_ie_env;
>  	struct list_head list;
>  };
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index 61f1bf1bc4a7..8148a3b5f607 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -1134,9 +1134,8 @@ int reg_reload_regdb(void)
>  	request->wiphy_idx = WIPHY_IDX_INVALID;
>  	request->alpha2[0] = current_regdomain->alpha2[0];
>  	request->alpha2[1] = current_regdomain->alpha2[1];
> -	request->initiator = NL80211_USER_REG_HINT_USER;
> +	request->initiator = NL80211_REGDOM_SET_BY_CORE;
>  	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
> -	request->reload = true;
>  
>  	reg_process_hint(request);
>  
> @@ -2712,8 +2711,7 @@ reg_process_hint_user(struct regulatory_request *user_request)
>  
>  	treatment = __reg_process_hint_user(user_request);
>  	if (treatment == REG_REQ_IGNORE ||
> -	    (treatment == REG_REQ_ALREADY_SET &&
> -	     !user_request->reload))
> +	    treatment == REG_REQ_ALREADY_SET)
>  		return REG_REQ_IGNORE;
>  
>  	user_request->intersect = treatment == REG_REQ_INTERSECT;
> -- 
> 2.31.1
> 
