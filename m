Return-Path: <linux-wireless+bounces-30856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61388D29689
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A34C13010BD7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D332F691D;
	Fri, 16 Jan 2026 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCWQX/h5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6222A41;
	Fri, 16 Jan 2026 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768523275; cv=none; b=Fip/87iGhMUDHaV96t+1eD960N6GyEwXtmSgYz4cZge/mSsvs3HAv+HHsNs1HkKTi1Q6YgH65o5Uh4pMSGsBiGSxt7OixgXK+RZKlN5qt5fe+Djnt3wFpN4Xaynb9l/9lpaTqiBB21SOmO5Wd56HCfGY9BygF/QbYBVWtxFrPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768523275; c=relaxed/simple;
	bh=GQqQa1BA3FsYTwmNjMFHMnRFUdbPu9ZzF5yHNk2DtKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXlalnOCs2a9OzP3tF9f2aWWRHnu+W/K58bHP+jLXKW6xGVfl1iOVyY7VnCM0egboHrxsBNg6F+ca8XE0/VEUL+0EyqVfbSQHuFf82AmvaRI4z2pjRq9LzWjS/sUXWD1CyMIps3UD0NeQjUA9C9bRjzQKnHffIjRKSLz1npLXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCWQX/h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFCFC116D0;
	Fri, 16 Jan 2026 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768523274;
	bh=GQqQa1BA3FsYTwmNjMFHMnRFUdbPu9ZzF5yHNk2DtKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCWQX/h5Il6pOvoGcJMhQd+rjmDmeMT8WgIbfw8fEAHY5906GowZr2aitm3f/m+u1
	 T2bRA8GsI0bVJjgdc7bkAWlenI4i5r8CZxw5z72lHpCdi0fJ4VGHtkpjtJ5xQ1RbcJ
	 dr0oKsTT0/bXmdWKFesimrAy9KQZEOXUTJLGB2jTzg6IB9XpuyiwtbRPV61r5qkRQN
	 Ex5BYbrr9UdOHg1WOVjjR9BZMmKL1U868HxvR7G9RijYdrXyrrcI/bI6melmvwRMTw
	 XurazmWvapAc61YAdWSghWVtEeXhLGv3ziVrMfVzwMJIzsssWC5QpDxV2ZN5udV3QT
	 yZAtAegpk/OQw==
Date: Thu, 15 Jan 2026 16:27:54 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath6kl: wmi: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202601151627.99DFE54@keescook>
References: <aR153k4ExCD-QTMq@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR153k4ExCD-QTMq@kspp>

On Wed, Nov 19, 2025 at 05:03:42PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration (which happens to be in a union, so
> we're moving the entire union) to the end of the corresponding
> structure. Notice that `struct bss_bias_info` is a flexible structure,
> this is a structure that contains a flexible-array member.
> 
> With these changes fix the following warning:
> 
> drivers/net/wireless/ath/ath6kl/wmi.h:1658:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/ath/ath6kl/wmi.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
> index 3080d82e25cc..0e7810b9372f 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.h
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.h
> @@ -1649,6 +1649,9 @@ struct low_rssi_scan_params {
>  } __packed;
>  
>  struct roam_ctrl_cmd {
> +	u8 roam_ctrl;
> +
> +	/* Must be last as it ends in a flexible-array member. */
>  	union {
>  		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>  		u8 roam_mode; /* WMI_SET_ROAM_MODE */
> @@ -1656,7 +1659,6 @@ struct roam_ctrl_cmd {
>  		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>  						     */
>  	} __packed info;
> -	u8 roam_ctrl;
>  } __packed;

It looks like this is a hardware interface, so I don't think roam_ctrl
can be moved like that. See ath6kl_wmi_set_roam_lrssi_cmd().

-Kees

-- 
Kees Cook

