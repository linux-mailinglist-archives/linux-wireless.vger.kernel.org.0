Return-Path: <linux-wireless+bounces-29551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC954CA97D2
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9713A300C6ED
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F3272801;
	Fri,  5 Dec 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIC7kgTU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A92264CD;
	Fri,  5 Dec 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973580; cv=none; b=fw6sf1WxS7XieHVhhm4+lT0MzIoB1etXmE12L/xfLbO/cYW6VoNWidVPvBUUVRy56kHNJetwwCTHAW8xeKtt0+QUXf29IW08+BREeiO7Z+LEVT2Yh93lhLetopMRsJaO+GFB1nt/cIgsorJvnUGMHhyui3xKHSKuPIAUdltiTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973580; c=relaxed/simple;
	bh=rCTYHSMm90mTJ3vZMsmmAyRtbfxR3k0G09lklrdDD+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOoMqA80gbD+4+IB2Yn+fwfoRsskIRQiHhiBx7jG437GxHU3h8E+QjdI0w+tgdvbWA1AItk9oN0ClyuB8B0LdrDQXqkymrTejqZMGMt1ctOtXWzK4kG3c2oNenOBgn64qMhNQl3YpKjWTFdeQHOCDckMWauNlmF1X3zvkgTmUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIC7kgTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFDC4CEF1;
	Fri,  5 Dec 2025 22:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764973580;
	bh=rCTYHSMm90mTJ3vZMsmmAyRtbfxR3k0G09lklrdDD+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIC7kgTUbVl2nrHi1jhu4KGtKVD+F2J57b1oo0HemRRp3es5S6z8oIS4tUZeqqBIt
	 rPkvrx0DU3XECM/RKXN0GzMLBeRKygJ36GKhabwVveWgR+RSRjo+cpzqDp65Qa5ud4
	 9K80/15lNWX+opUK69/oiQaMPQOUFPACi6s9CDeICktemtxA8ZHT8SXcGxlh/Biq2E
	 A+s2oqbFF9a44ONYBwZExwMiO+pATCHVCT1dVR83mkbRKkusU7D6uJMcdu3Np7YNN9
	 BToQfezYWEr0CK9YL0OCb2ul0LkMRCdZtw92x9QZ7GlfHXzJqTix2aam5XS1XEplAb
	 mXzak2OKik1ew==
Date: Fri, 5 Dec 2025 15:26:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Message-ID: <20251205222615.GA3738427@ax162>
References: <20251204123204.9316-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>

On Thu, Dec 04, 2025 at 12:32:04PM +0000, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Thanks, I can confirm this clears up the warning.

Tested-by: Nathan Chancellor <nathan@kernel.org>

>  drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 7 +++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> index ffeb37a7f830..231920425c06 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> @@ -121,6 +121,12 @@ static int iwl_mld_ptp_gettime(struct ptp_clock_info *ptp,
>  	return 0;
>  }
>  
> +static int iwl_mld_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static int iwl_mld_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  {
>  	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
> @@ -279,6 +285,7 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
>  
>  	mld->ptp_data.ptp_clock_info.owner = THIS_MODULE;
>  	mld->ptp_data.ptp_clock_info.gettime64 = iwl_mld_ptp_gettime;
> +	mld->ptp_data.ptp_clock_info.settime64 = iwl_mld_ptp_settime;
>  	mld->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
>  	mld->ptp_data.ptp_clock_info.adjtime = iwl_mld_ptp_adjtime;
>  	mld->ptp_data.ptp_clock_info.adjfine = iwl_mld_ptp_adjfine;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> index 06a4c9f74797..ad156b82eaa9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> @@ -220,6 +220,12 @@ static int iwl_mvm_ptp_gettime(struct ptp_clock_info *ptp,
>  	return 0;
>  }
>  
> +static int iwl_mvm_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static int iwl_mvm_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  {
>  	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
> @@ -281,6 +287,7 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
>  	mvm->ptp_data.ptp_clock_info.adjfine = iwl_mvm_ptp_adjfine;
>  	mvm->ptp_data.ptp_clock_info.adjtime = iwl_mvm_ptp_adjtime;
>  	mvm->ptp_data.ptp_clock_info.gettime64 = iwl_mvm_ptp_gettime;
> +	mvm->ptp_data.ptp_clock_info.settime64 = iwl_mvm_ptp_settime;
>  	mvm->ptp_data.scaled_freq = SCALE_FACTOR;
>  
>  	/* Give a short 'friendly name' to identify the PHC clock */
> -- 
> 2.51.2
> 

