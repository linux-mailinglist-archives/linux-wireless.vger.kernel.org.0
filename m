Return-Path: <linux-wireless+bounces-30977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B1D3B47B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 18:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E2EC304D0A0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFA329373;
	Mon, 19 Jan 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxp8bKGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427943033E4;
	Mon, 19 Jan 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843752; cv=none; b=dvxiV/7LYfbCk/2MHkN9bvZ/I0Qx0Bgvltlm3pEKtRZv4Tkee2fq7GstD/JK6B5qL8p4S7v22FuPbJRHI9ET+6j2qu+RQC3hqTbWQj6bFrOsioeercVB+mDrJnSY1YKl3Q+U31NY71bA8BSwc8qO04bErNjA7HopvxqWhhIL9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843752; c=relaxed/simple;
	bh=ubEIagtdtoo0yEiArJTE7L2QRrt+LUrcsn80+nIiLMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdKydINGGIODv9sBKa7ARWiv496Ghv/eShuRNBkFxvIz3DPQ+UMqZgGX3FCE+qLAlInlISuTMItnxkKr8H0skz8PpuciGKA54nM2iuXs5Ycnt8zYVJ9qKoCS3fSoRKISv76sZ0bPGirpHs64xpsJgngvMf/zixBapFN+eFYxjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxp8bKGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA0C19425;
	Mon, 19 Jan 2026 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843751;
	bh=ubEIagtdtoo0yEiArJTE7L2QRrt+LUrcsn80+nIiLMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxp8bKGCbFu5X3E746KzGYRuLVaCSeVZ/JBChu10a5Ufv2nVq/pKcwJCyQ+pj3f1O
	 1E+k1aZFjRezL8jwUof8dMXRaMx3Ke8+OpYy73jsc0wwHcXvQVA2yrChQ6X6btEcQd
	 lNLjuRvB4nLW32wQlF4Zaymx+LNnd8JyKeEVrpl7vxdUkInXvLhBy4XmCJaZSmd0T9
	 JGynFC3M0qZhNKqZq+4QgVzMikwKTglJ1MGdaAibPWjMKx5T8GBdVCEubWqgjdxiyH
	 6lFUrGP7UDfi2IqK43LfZL+QmiDsbIhdHF+HkY35cwmqib8bvWMw1iiQoHko+F4EfI
	 aLM3XQo0H9ZjA==
Date: Mon, 19 Jan 2026 17:29:06 +0000
From: Simon Horman <horms@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	stable@vger.kernel.org, Yao Zi <ziyao@disroot.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP
 removal
Message-ID: <aW5p4jVhcz70ZFl4@horms.kernel.org>
References: <20260115161529.85720-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115161529.85720-1-junjie.cao@intel.com>

+ Yao Zi and Benjamin Berg

On Fri, Jan 16, 2026 at 12:15:29AM +0800, Junjie Cao wrote:
> iwl_mvm_ptp_remove() and iwl_mld_ptp_remove() call
> cancel_delayed_work_sync() only after ptp_clock_unregister() and after
> partially clearing ptp_data state.
> 
> This creates a race where the delayed work (iwl_mvm_ptp_work /
> iwl_mld_ptp_work) can run while teardown is in progress and observe a
> partially modified PTP state. In addition, the work may re-arm itself,
> extending the teardown window and risking execution after driver
> resources have been released.
> 
> Move cancel_delayed_work_sync() before ptp_clock_unregister() to ensure
> the delayed work is fully stopped before any PTP cleanup begins. This
> follows the standard pattern used by other Intel PTP drivers such as
> e1000e, igb, ixgbe, and ice.
> 
> Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
> Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Thinking out loud: The two cited commits were introduced in
the same upstream release - v6.4 - so from a backporting PoV
it seems reasonable to address these issues in one patch.
Though I do think it would be best to think of these
as two things and thus warranting two patches.

That notwithstanding, the changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

Context left intact below for the benefit of Yao Zi and Benjamin Berg.

> ---
>  drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> index 231920425c06..b40182320801 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> @@ -319,10 +319,10 @@ void iwl_mld_ptp_remove(struct iwl_mld *mld)
>  			       mld->ptp_data.ptp_clock_info.name,
>  			       ptp_clock_index(mld->ptp_data.ptp_clock));
>  
> +		cancel_delayed_work_sync(&mld->ptp_data.dwork);
>  		ptp_clock_unregister(mld->ptp_data.ptp_clock);
>  		mld->ptp_data.ptp_clock = NULL;
>  		mld->ptp_data.last_gp2 = 0;
>  		mld->ptp_data.wrap_counter = 0;
> -		cancel_delayed_work_sync(&mld->ptp_data.dwork);
>  	}
>  }
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> index 1da6260e238c..2b01ca36a1b5 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> @@ -325,11 +325,11 @@ void iwl_mvm_ptp_remove(struct iwl_mvm *mvm)
>  			       mvm->ptp_data.ptp_clock_info.name,
>  			       ptp_clock_index(mvm->ptp_data.ptp_clock));
>  
> +		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
>  		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
>  		mvm->ptp_data.ptp_clock = NULL;
>  		memset(&mvm->ptp_data.ptp_clock_info, 0,
>  		       sizeof(mvm->ptp_data.ptp_clock_info));
>  		mvm->ptp_data.last_gp2 = 0;
> -		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
>  	}
>  }
> -- 
> 2.43.0
> 

