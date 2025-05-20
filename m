Return-Path: <linux-wireless+bounces-23187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD6ABE1C5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595191BC030D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7227D782;
	Tue, 20 May 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHqxceZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2ED35893;
	Tue, 20 May 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761830; cv=none; b=sJyMFXQUTpFrk3X/nMd2TIw/sFl4evy2imy0vMbnQGcgPOD0rEFnZGwo5cx6u5uXyGYgoPW9hHCs4pS97Ia+XaQAt3NFDjlx4jBqduiv58DMLxOaKndbAHozZjL//xzQvcJUKqoiufqThFMIXh3VDFta8RGqmI/gT5exubtLkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761830; c=relaxed/simple;
	bh=REkgX6AMTfbAAEpXD/CF7amF5JogpdJTqNLBYpeJ7vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRmch6x0mmEcvD9eHeDF8m8pZ2PWw+4/2Pd4K/S7kO2HK2V2gTy2ggqXggLbAGhb2eOTnzOsajTWH1eNc0yN+aPMky5bQ6Gd3ODf7Z9XZdr+S0GjN/1jBkBYoiWfV87IlWGodqC0avy8XNBz3TOocMusm5/FsOyaF5nePwvcfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHqxceZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0309C4CEEF;
	Tue, 20 May 2025 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747761829;
	bh=REkgX6AMTfbAAEpXD/CF7amF5JogpdJTqNLBYpeJ7vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHqxceZXmsrIqOtiXeno96rJBh6Nx1bGurv78HEB7qXvXCN4vuGQiKB49wN+Nwes9
	 tDin58bpVIjNBaPGvwESdf3Te7XGVEraKMGaLyiBdp7xwYAq14AMggM9dyhIr22FTK
	 twCGmnxiiQny3Z1Z6oRQlfyfICjrGtnh+gH1SxnrJVfcU5hEfcSLiak4zXCv/XlvXO
	 XY1Db1Ymp0nTYZ8pk7ziEmFm4BN4QaWyWkva3Qr2COOiC9NGwN2RNd0KXqONCzOQA7
	 +1BAiNA2yqIepG0y71BLt7xrkyhUdktRfSgIGyhQBxpEZvn6xyWjZP535F0GeATxSr
	 uY61wIFiRTErQ==
Date: Tue, 20 May 2025 10:23:46 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	linux-wireless@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: mld: Work around Clang loop unrolling
 bug
Message-ID: <202505201023.FC6D334C5F@keescook>
References: <20250425184418.it.308-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425184418.it.308-kees@kernel.org>

On Fri, Apr 25, 2025 at 11:44:22AM -0700, Kees Cook wrote:
> The nested loop in iwl_mld_send_proto_offload() confuses Clang into
> thinking there could be final loop iteration past the end of the "nsc"
> array (which is only 4 entries). The FORTIFY checking in memcmp()
> (via ipv6_addr_cmp()) notices this (due to the available bytes in the
> out-of-bounds position of &nsc[4] being 0), and errors out, failing
> the build. For some reason (likely due to architectural loop unrolling
> configurations), this is only exposed on ARM builds currently. Due to
> Clang's lack of inline tracking[1], the warning is not very helpful:
> 
> include/linux/fortify-string.h:719:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
>   719 |                         __read_overflow();
>       |                         ^
> 1 error generated.
> 
> But this was tracked down to iwl_mld_send_proto_offload()'s
> ipv6_addr_cmp() call.
> 
> An upstream Clang bug has been filed[2] to track this, but for now.
> Fix the build by explicitly bounding the inner loop by "n_nsc", which is
> what "c" is already limited to. Additionally do not repeat the ns_config
> and targ_addrs array sizes with their open-coded names since they can
> be determined at compile-time with ARRAY_SIZE().
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2076
> Link: https://github.com/llvm/llvm-project/pull/73552 [1]
> Link: https://github.com/llvm/llvm-project/issues/136603 [2]
> Signed-off-by: Kees Cook <kees@kernel.org>

Ping on this -- can someone pick this up? I can carry it if needed?

-Kees

> ---
>  v2:
>   - move "j < n_nsc" forward to stabilize loop bounds (Nathan)
>   - use ARRAY_SIZE() for robustness
>  v1: https://lore.kernel.org/all/20250421204153.work.935-kees@kernel.org/
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Avraham Stern <avraham.stern@intel.com>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>  drivers/net/wireless/intel/iwlwifi/mld/d3.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> index dc736fdc176d..c51a6596617d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> @@ -1728,17 +1728,13 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
>  	struct iwl_mld_wowlan_data *wowlan_data = &mld_vif->wowlan_data;
> -	struct iwl_ns_config *nsc;
> -	struct iwl_targ_addr *addrs;
> -	int n_nsc, n_addrs;
> +	const int n_addrs = ARRAY_SIZE(cmd->targ_addrs);
> +	struct iwl_targ_addr *addrs = cmd->targ_addrs;
> +	const int n_nsc = ARRAY_SIZE(cmd->ns_config);
> +	struct iwl_ns_config *nsc = cmd->ns_config;
>  	int i, c;
>  	int num_skipped = 0;
>  
> -	nsc = cmd->ns_config;
> -	n_nsc = IWL_PROTO_OFFLOAD_NUM_NS_CONFIG_V3L;
> -	addrs = cmd->targ_addrs;
> -	n_addrs = IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_V3L;
> -
>  	/* For each address we have (and that will fit) fill a target
>  	 * address struct and combine for NS offload structs with the
>  	 * solicited node addresses.
> @@ -1759,7 +1755,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
>  
>  		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
>  					  &solicited_addr);
> -		for (j = 0; j < c; j++)
> +		for (j = 0; j < n_nsc && j < c; j++)
>  			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
>  					  &solicited_addr) == 0)
>  				break;
> -- 
> 2.34.1
> 

-- 
Kees Cook

