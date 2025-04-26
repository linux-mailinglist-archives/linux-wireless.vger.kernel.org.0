Return-Path: <linux-wireless+bounces-22093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211ECA9D681
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 02:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301E41BC5A39
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4810E5;
	Sat, 26 Apr 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+a1WqRe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CE360;
	Sat, 26 Apr 2025 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625848; cv=none; b=WkM0uFGeivOEYE5ytEjaYdEQIuk1zh/MlZpLrKNezxtV17WZbLDQfyEJGYumrm/TkHduSSEAp7RzfY0eZZXX/VIqgL5kfCo+Wj0hMgpSm65SoqxetGeJyOOMrkln3B1RB9K0hgvGEKGSZ3txg+TQ5e4IxXs1Js9nKl4Bm+2gI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625848; c=relaxed/simple;
	bh=rAnrPpzUOTKLQUbr+pLdW81qjbjnGHinJQrnqS/DX9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMpDcs8rCItR3aT2wTGRNWHbG7zo+vFnOYOI9cf3kv2chFi2bF1i5/1Kgr9ZwTQxxwUxKvYaQIEEAirm3U/cpum+YhHSbKoUoV11fJ2szAQnmkZ8kBrorMBdK6rRTnn0WJXpfq38jTDPVwUVoqI9ukbhnbFj0yj5HF3MYFiYAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+a1WqRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57CFC4CEE4;
	Sat, 26 Apr 2025 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745625847;
	bh=rAnrPpzUOTKLQUbr+pLdW81qjbjnGHinJQrnqS/DX9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+a1WqReSMdJks1s2lioODuUEivnYvrabCQYOY8A4nyQer9w7JsFbwDYezW1foXNN
	 fzfVKDmKDx7DhUWmkGoFIIzx/C3JAeSsc7ixMp0PBJL6znpzzg/f0JNyyrjHL5Mq8Y
	 NDI18hY40Tc2/llsQKp5g2jKv6B3VleXQkF9Ehzlxm2dCDDPsdX+d1fkQScSgTWozM
	 e4sQgiOSi4xq8hSZIqUgZUON34dZiXodgg673SNNZISN0X8LbFV8pLWcSe4EVtEcRX
	 e2Fltf+RtqxuAIXYLAvY+J5qcaXrgQAlPBPh2MqRcpn1M9P9i3BrEj7Q9vL7tCsskt
	 59cdVFvNc5s5w==
Date: Fri, 25 Apr 2025 20:04:01 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
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
Message-ID: <20250426000401.GB3584546@ax162>
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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

