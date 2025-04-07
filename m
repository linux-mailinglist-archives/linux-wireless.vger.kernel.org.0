Return-Path: <linux-wireless+bounces-21210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ABFA7EC4B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF15E3AC245
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D9261363;
	Mon,  7 Apr 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arFXIKZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801225FA38;
	Mon,  7 Apr 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051178; cv=none; b=b27A9NGD6S0RLkOdAKD0p+mZ076mkW6XxOt3mX8FREzxm88yfv/Thwqa8YEle8R9DkPwoSGQe2BoLCtQM7YQlVkoP9ipxGP0L85f0aoEtTYyocpBK5ecxhA8R7Yb2YaSotUSqAIoJRiSVCYB2nqjyNaMdVjCXee3GJYs12PMgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051178; c=relaxed/simple;
	bh=FqBbfujZorWgG3rPeHe3EJNi1KkKcFDOQUHyCf5TY6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTQvybjxeS3dt2onYcW9G2e0O2kv0apOsVDhSRUo8VJJ+bJ4PEx8kJHAXm6ByVYtdZPf8gt+xREJrPrxNaRw8rSV0rEZYpOBKNxDQPO3ZKj1wL4eQo7iQxbhi+d8lZveLLGpLgFF2OOZe53ZSNatM/lx0PmamCFW5w2as7v2ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arFXIKZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41D1C4CEDD;
	Mon,  7 Apr 2025 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051177;
	bh=FqBbfujZorWgG3rPeHe3EJNi1KkKcFDOQUHyCf5TY6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arFXIKZA9VCS2brkxZJUTn7YyPSvWytivwyTvyMlTXOiZdn1DfXL2T9jkGH6fztBi
	 hnKcsF0bAr+tBA7v8TPaWzcS+u6xzN/sa8pFk8/UPVwgaaybDk0KQ0l0o0FAU7QsBq
	 fghq56XwRgZ6rVbW22jGMQgoDSotfSSekHQV2WGuiaz7JQa/UAzdkcfsZPvslMIEB9
	 bV0rRCi0WuO7t9sLFrSkm8RX9JBF7ohec66F7cgx3I6D3a9JWfgMGkQBnd8CgtQiSB
	 /cFy7ueImq3lKm/NRlh2J5uu4Brzes+mNmB/eru8AVV/ndag+iMGui8oyuPiUC01IJ
	 as1yGmblcd4ag==
Date: Mon, 7 Apr 2025 11:39:34 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: ath12k: core.h: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071138.98D5B6E@keescook>
References: <Z8-Snz86Xfwdlyd7@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8-Snz86Xfwdlyd7@kspp>

On Tue, Mar 11, 2025 at 12:02:15PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ieee80211_chanctx_conf` is a flexible structure --a
> structure that contains a flexible-array member.
> 
> Fix 30 of the following warnings:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Hi, just checking in on this patch. Is some adjustment needed for this
to land?

Thanks!

-Kees

> ---
>  drivers/net/wireless/ath/ath12k/core.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 3fac4f00d383..d6b4c4d2c400 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -295,7 +295,6 @@ struct ath12k_link_vif {
>  	int txpower;
>  	bool rsnie_present;
>  	bool wpaie_present;
> -	struct ieee80211_chanctx_conf chanctx;
>  	u8 vdev_stats_id;
>  	u32 punct_bitmap;
>  	u8 link_id;
> @@ -303,6 +302,13 @@ struct ath12k_link_vif {
>  	struct ath12k_rekey_data rekey_data;
>  
>  	u8 current_cntdown_counter;
> +
> +	/* Must be last - ends in a flexible-array member.
> +	 *
> +	 * FIXME: Driver should not copy struct ieee80211_chanctx_conf,
> +	 * especially because it has a flexible array. Find a better way.
> +	 */
> +	struct ieee80211_chanctx_conf chanctx;
>  };
>  
>  struct ath12k_vif {
> -- 
> 2.43.0
> 

-- 
Kees Cook

