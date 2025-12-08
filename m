Return-Path: <linux-wireless+bounces-29590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA344CACFBB
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7109C30480BF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621E31062D;
	Mon,  8 Dec 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="tIcOA9St";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CSAXktCx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from b224-17.smtp-out.eu-central-1.amazonses.com (b224-17.smtp-out.eu-central-1.amazonses.com [69.169.224.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3291F75A6;
	Mon,  8 Dec 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193008; cv=none; b=V67qu97Zzfc+gPbnMkWZ6AP3gteSwjzTeeVNO40M/S1o0deLnsbP0vgSmf9Pd8XSaTEKZhEBRdXdaAYDnBSG3YZZEVzvkspRIVPxIwgX2reyS7hfudNhiMFJKuE5T112OhlQwOHs9OMY2paZmKnVRNuLNML0v+BTG0Zc+G/Gnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193008; c=relaxed/simple;
	bh=F5wfrZANXxGmJc/i+SvOOxZPxzGKSsElzv4HXsCxneE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ0JtjQwnauWKwPJc3fZuMw1UEYWbnEB/Q0S3/Ff+yqCpDB5iaBlzJBm9XXJHPvZm3i0BiwNSMF28r8H2e/97s+WONcE9YwgFPeMz3FgPithQCwhN4tvzG/lD43eu4PuCjOZMnRKJgtp2lndqxI0yJorb4Z7BOPZQwAQqv3wQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=tIcOA9St; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=CSAXktCx; arc=none smtp.client-ip=69.169.224.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=fauymlwecxgqgzkqidylh22coownfvju; d=riscv-rocks.de; t=1765193004;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:In-Reply-To;
	bh=F5wfrZANXxGmJc/i+SvOOxZPxzGKSsElzv4HXsCxneE=;
	b=tIcOA9StOoj6wVYFOuRYeJ+o/DzoSeeng6mb7NAzpIjOuWl8d962LCYjRrYSfmMM
	CUgjzmfadDZcqRKZGbnnXXszFfBLUhZdHGrYcmN/FHUi4gulTbDSTXDTXQK+61oe1rw
	U7yc97wCDrYY3gm15Ovdhxu08RwjmmMEGjGKQ45pihqu/lWgqZMt8xrbqH/EQGAq9T/
	nxP0Lzf+M1pBhS80qzKVOxfNz851ILicZFU2U5/VS6LykD3Oey0dP/kco99T11dGK/k
	YgKo/m1a4CXz9hD83NixGFEs/j4izbx4ZfVbvDeMKiqLtqtSfOpIecFWAxpenlZxvS/
	RR4fRIr0nQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1765193004;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=F5wfrZANXxGmJc/i+SvOOxZPxzGKSsElzv4HXsCxneE=;
	b=CSAXktCxYaJ4rpMZVD2snpmxPif2R1rInhOuGpPDafraDJVozoLjqUYmEYgscbuR
	ZLhyWjiSAggNb3lB7T3QB3Kilcp2uiUmUSjeE3tk/CwVvoAizcWL5cgx33ElsTB+IQC
	6EK5J1cITV6ROA9p0qoIYFGaTlU9VXwUwJBwhd4I=
Date: Mon, 8 Dec 2025 11:23:24 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: Yao Zi <ziyao@disroot.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
	Daniel Gabay <daniel.gabay@intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>, 
	Kexy Biscuit <kexybiscuit@aosc.io>, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Message-ID: <0107019afdb3b3ec-dcd55bb0-3d78-4cd3-8d82-d005dd945b67-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Yao Zi <ziyao@disroot.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nathan Chancellor <nathan@kernel.org>
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
User-Agent: Mutt
X-Operating-System: Linux Fedora release 43 (Forty Three) (Kernel 6.18.0)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.12.08-69.169.224.17

On Thu, 04. Dec 12:32, Yao Zi wrote:
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
Hi,

the patch solved my issue too. 

tested-by: damian Tometzki damian@riscv-rocks.de
-- 
VG
Damian Tometzki

