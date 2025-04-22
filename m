Return-Path: <linux-wireless+bounces-21854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2BA9765C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185A9165827
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 19:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E6298CA7;
	Tue, 22 Apr 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWKXe9qR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917C10A1F;
	Tue, 22 Apr 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351951; cv=none; b=SLt7afrEG5uEqiaHhAmgauhuvKuZ6ad7bFmT1UIt6mnUR2wgiwjXKd9SiThNQK+lJqK2SHdqY6dfRR4zfzACp3UhTRF9Y4xYDbW5dQFjVAflP75p0iaI+2762QdusYpKHrxlEgXF8dmOeKrd611ORyQdNw+pPDitmG37uh3OSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351951; c=relaxed/simple;
	bh=BbMG5QXX3A39cVhl247co58pwl2VChmfMATYNdjNRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSwnm5FTpUcTlWJmsGqGSgdAAVlxyrCEgNGhwwadrik4A+VM8NFrg8CbEJgPBYEHM3q/HnC+SvXU+mP2ZMn96/fi4kzFAvH1H7phDXaMGQauuJfyqNu6uAaPU97Cj4s0dAuwoyGMSTd4IIy4ZDC6iMo4ATPhYwUZOSGE6qVeFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWKXe9qR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7116AC4CEE9;
	Tue, 22 Apr 2025 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351949;
	bh=BbMG5QXX3A39cVhl247co58pwl2VChmfMATYNdjNRIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWKXe9qRtol8AS5MA4WPNlI8aPoaa+MaA/RSvtwzglvNHD9Bbw+YySrGY68U4iOy9
	 RLeTGpwnFwVF8RKpWjzrTsTv8UyUX1ww8mER9J4hDSiNj3gs4s4lUdvBDQzHzSacJ/
	 lbPoPvqh15D3QknKr+peUAbO0sCC5HMxF/bQt/B5Q2qHfQF0d/7CNPpSVlTlqBjhOH
	 Z/mCfV/Q0uq0774ec/Nq0OLQ70XfLwWViz00Egg6lbOk8B2AVypSNJPfKVlVvPh/aN
	 NRtV3t5iJd7tTzPw9MS395ks0ZGM2Q/ffC+2iKv8PuHAD60A7r+74zxabdXRqaYhNN
	 8IJUYakMo6gxg==
Date: Tue, 22 Apr 2025 12:59:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: mld: Work around Clang loop unrolling bug
Message-ID: <20250422195903.GA3475704@ax162>
References: <20250421204153.work.935-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421204153.work.935-kees@kernel.org>

On Mon, Apr 21, 2025 at 01:41:57PM -0700, Kees Cook wrote:
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
> Fix the build by explicitly bounding the inner loop by "n_nsc", which
> is what "c" is already limited to.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2076
> Link: https://github.com/llvm/llvm-project/pull/73552 [1]
> Link: https://github.com/llvm/llvm-project/issues/136603 [2]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Avraham Stern <avraham.stern@intel.com>
> Cc: Daniel Gabay <daniel.gabay@intel.com>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>  drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> index 2c6e8ecd93b7..1daca1ef02b2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> @@ -1754,7 +1754,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
>  
>  		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
>  					  &solicited_addr);
> -		for (j = 0; j < c; j++)
> +		for (j = 0; j < c && j < n_nsc; j++)
>  			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
>  					  &solicited_addr) == 0)
>  				break;
> -- 
> 2.34.1
> 

I might be going crazy but this does not appear to actually resolve the
warning for me, at least with allmodconfig:

  $ git cite
  a33b5a08cbbd ("Merge tag 'sched_ext-for-6.15-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean allmodconfig drivers/net/wireless/intel/iwlwifi/mld/d3.o
  In file included from drivers/net/wireless/intel/iwlwifi/mld/d3.c:5:
  ...
  In file included from include/linux/string.h:392:
  include/linux/fortify-string.h:719:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
    719 |                         __read_overflow();
        |                         ^
  1 error generated.

  $ b4 -q shazam 20250421204153.work.935-kees@kernel.org
  ...

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean allmodconfig drivers/net/wireless/intel/iwlwifi/mld/d3.o
  In file included from drivers/net/wireless/intel/iwlwifi/mld/d3.c:5:
  ...
  In file included from include/linux/string.h:392:
  include/linux/fortify-string.h:719:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
    719 |                         __read_overflow();
        |                         ^
  1 error generated.

However, if I apply the diff at the bottom of the message, it does...

  $ git stash pop

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean allmodconfig drivers/net/wireless/intel/iwlwifi/mld/d3.o

It is possible there is something else going on with allmodconfig like
KASAN or GCOV that causes this but I did not look too closely yet

Cheers,
Nathan

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index fba6a7b1bb5c..7ce01ad3608e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1757,7 +1757,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 
 		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
 					  &solicited_addr);
-		for (j = 0; j < c && j < n_nsc; j++)
+		for (j = 0; j < n_nsc && j < c; j++)
 			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
 					  &solicited_addr) == 0)
 				break;

