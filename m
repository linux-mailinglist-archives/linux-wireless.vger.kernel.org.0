Return-Path: <linux-wireless+bounces-19636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC02A4AAEA
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB1B16F521
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF51DED6B;
	Sat,  1 Mar 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="zaxc8Sea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645ABA3D
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832128; cv=none; b=RK86K6e+iXoxcHy4+WSYPuq4Xt1FFX1jOrmt6t9xdpzHforvHY4d34HgdnvQ/A05ytw56ZvInaGeNKpr8nSfDVD686QunCKwZ9Fohd/5Ugoo+4g9U31nBGRjeNbS0V5oNFYJd2bak5BIZ4ZO8UklWi4deNT7y7CoeJuqgfwWTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832128; c=relaxed/simple;
	bh=NqrbvWy4FjnXM7il11X7GEnPis/8CASWT3OsbTC9DsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JamLD4YiCvBkYr0UNg2ZqZD4iCwfZGqUtg2TWdrq3v1e4eRALQck4Am7o1+soDOi53Keurcqv558QclljWSWhHU9ZTKumC272tOStir4rBrx7xmD2zjkdy0Xx30OZ2Rwe/okM0DuRpFO6nHhsep+fQi4Kr85GMHehC1FsfH58iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=zaxc8Sea; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36133 invoked from network); 1 Mar 2025 13:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1740832115; bh=3hL3gu4+phjo6I/CspOjLAoXyyGic55LKqTv9Puz30w=;
          h=From:To:Cc:Subject;
          b=zaxc8SeaUciiZUKVbZnqy47FCT1BHrj84ds+FBPeBI09vDaB8KbgbVH4m+cTUhCB4
           +CQug0EJ3oEa4T+AYLwL/ZECP2RN/XheLfmfphVQ7cJ/0EKSlSkjC4aFDMW2T3lhfI
           XzmZnEnLGqtMxCUteejldUTJVQqesxl6qcPMEHZs6gqzust+SInUAFiI55WKge9jyy
           uSlN4gcUf5Ax7gEXqf9JdhqKnBRuqfXHVI40CvpxqIxIwVjOFDV8/0GnHZzA6bqpuU
           UZz2puN11B5Tmn1VPnR2eb+zhAPV4Ba/X76GVxPjWvKClZ0RDO1nbU9Bzuk1e45LkL
           6okDkiqz3y5eg==
Received: from 89-64-0-97.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.97])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@kernel.org>; 1 Mar 2025 13:28:35 +0100
Date: Sat, 1 Mar 2025 13:28:34 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iwlegacy: don't warn for unused variables with
 DEBUG_FS=n
Message-ID: <20250301122834.GA55739@wp.pl>
References: <20250225145359.1126786-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225145359.1126786-1-arnd@kernel.org>
X-WP-MailID: 42cec4a7e71b348584fd2301367d5215
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [geIR]                               

On Tue, Feb 25, 2025 at 03:53:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The reference to il_rate_mcs is inside of an #ifdef, causing a W=1 warning:
> 
> drivers/net/wireless/intel/iwlegacy/4965-rs.c:189:38: error: unused variable 'il_rate_mcs' [-Werror,-Wunused-const-variable]
> static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT] = {
> 
> Replace the #ifdef with a PTR_IF() for better compile time analysis.
> The dead code will still get eliminated, but the warning goes away.

But then the code will be compiled for !CONFIG_MAC80211_DEBUGFS
case, it does compile for me:

-  22475	   1160	      0	  23635	   5c53	drivers/net/wireless/intel/iwlegacy/4965-rs.o
+  23008	   1168	      0	  24176	   5e70	drivers/net/wireless/intel/iwlegacy/4965-rs.o

How about moving  
static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT]
under CONFIG_MAC80211_DEBUGFS ? Maybe inside the function that use it ? 

Regards
Stanislaw

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use correct config symbol consistently
> ---
>  drivers/net/wireless/intel/iwlegacy/4965-rs.c | 15 ++-------------
>  drivers/net/wireless/intel/iwlegacy/common.h  |  2 --
>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> index 718efb1aa1b0..f754fb979546 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> @@ -132,15 +132,8 @@ static void il4965_rs_fill_link_cmd(struct il_priv *il,
>  static void il4965_rs_stay_in_table(struct il_lq_sta *lq_sta,
>  				    bool force_search);
>  
> -#ifdef CONFIG_MAC80211_DEBUGFS
>  static void il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta,
>  				    u32 *rate_n_flags, int idx);
> -#else
> -static void
> -il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
> -{
> -}
> -#endif
>  
>  /*
>   * The following tables contain the expected throughput metrics for all rates
> @@ -2495,8 +2488,6 @@ il4965_rs_free_sta(void *il_r, struct ieee80211_sta *sta, void *il_sta)
>  	D_RATE("leave\n");
>  }
>  
> -#ifdef CONFIG_MAC80211_DEBUGFS
> -
>  static void
>  il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
>  {
> @@ -2758,7 +2749,6 @@ il4965_rs_add_debugfs(void *il, void *il_sta, struct dentry *dir)
>  	debugfs_create_u8("tx_agg_tid_enable", 0600, dir,
>  			  &lq_sta->tx_agg_tid_en);
>  }
> -#endif
>  
>  /*
>   * Initialization of rate scaling information is done by driver after
> @@ -2781,9 +2771,8 @@ static const struct rate_control_ops rs_4965_ops = {
>  	.free = il4965_rs_free,
>  	.alloc_sta = il4965_rs_alloc_sta,
>  	.free_sta = il4965_rs_free_sta,
> -#ifdef CONFIG_MAC80211_DEBUGFS
> -	.add_sta_debugfs = il4965_rs_add_debugfs,
> -#endif
> +	.add_sta_debugfs = PTR_IF(IS_ENABLED(CONFIG_MAC80211_DEBUGFS),
> +				  il4965_rs_add_debugfs),
>  };
>  
>  int
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 92285412ab10..52610f5e57a3 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -2815,9 +2815,7 @@ struct il_lq_sta {
>  	struct il_scale_tbl_info lq_info[LQ_SIZE];	/* "active", "search" */
>  	struct il_traffic_load load[TID_MAX_LOAD_COUNT];
>  	u8 tx_agg_tid_en;
> -#ifdef CONFIG_MAC80211_DEBUGFS
>  	u32 dbg_fixed_rate;
> -#endif
>  	struct il_priv *drv;
>  
>  	/* used to be in sta_info */
> -- 
> 2.39.5
> 

