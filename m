Return-Path: <linux-wireless+bounces-22081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB578A9D05E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 20:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E683B189DF2D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B622201017;
	Fri, 25 Apr 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Losezt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782B188733;
	Fri, 25 Apr 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605117; cv=none; b=fmk4eeOEM39EYCt9ZDsoFDCiFCg5+CH/ahpt22Wkt1wWTtIq82mRuUS5zEdLdv5/jNqKEwtGYxBNq20dgZplOIOBzQDIZtec02Z422O79n4z5ikg+VB/gpLj30KNm0EOc3qZdg2F8Q+SaYD6Ka+QxAEYyM07YEMRoDcsUJPC3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605117; c=relaxed/simple;
	bh=8wlZDXVNIHW3czsSgvXmuXzKYPkYZ78cFqTc5/rODz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDhqLFdC5zBSIxtddAmiHck4ofCiY+BVoeh/MTXj019fq8P4MVqZCdX+cy26w1VWj9eRUhAiWP/ak4GOZxxPzA+HV74idBVLtJN7XA9GXmDdx13jkK9jLxCREzt/E9zyvNiNoSfZkzHU+Jt+cJmpRemwpp0Z3SMCRVTCmi+LOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Losezt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB559C4CEE4;
	Fri, 25 Apr 2025 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745605116;
	bh=8wlZDXVNIHW3czsSgvXmuXzKYPkYZ78cFqTc5/rODz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9LoseztUEbdU/aPHnCdE/XhzWpLTMxus0yk+uCcEQdgRXGaKybQTO/g7cczUv5+I
	 M46vHnbp50utmnlFybFzdOTODAgLi0P8Php5EZ2CAY943xYurl5Rx8FAAwM51FgqhC
	 mLHHIObrFifmccWy3SO7QkRzqZ7BvG7OSt++2O2G4AIiV9Fg1E+lwgDXjxVYuhlsPa
	 qFcl6T/2K7Y4IYbc6RoZQJT2blDE8CHZIY4agbIp+VfwUAlt22KyxG1HPLzWAisp+t
	 fnZ5EYW0CKsUvVhwZ7tHgdtwCzoTIXDKzMuSbZcHszbVlXxHo2S+qiljt0epINgO2x
	 OioL5OZ87H2Lw==
Date: Fri, 25 Apr 2025 11:18:33 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <202504251032.51B2CB6233@keescook>
References: <20250421204153.work.935-kees@kernel.org>
 <20250422195903.GA3475704@ax162>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422195903.GA3475704@ax162>

On Tue, Apr 22, 2025 at 12:59:03PM -0700, Nathan Chancellor wrote:
> On Mon, Apr 21, 2025 at 01:41:57PM -0700, Kees Cook wrote:
> > The nested loop in iwl_mld_send_proto_offload() confuses Clang into
> > thinking there could be final loop iteration past the end of the "nsc"
> > array (which is only 4 entries). The FORTIFY checking in memcmp()
> > (via ipv6_addr_cmp()) notices this (due to the available bytes in the
> > out-of-bounds position of &nsc[4] being 0), and errors out, failing
> > the build. For some reason (likely due to architectural loop unrolling
> > configurations), this is only exposed on ARM builds currently. Due to
> > Clang's lack of inline tracking[1], the warning is not very helpful:
> > 
> > include/linux/fortify-string.h:719:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
> >   719 |                         __read_overflow();
> >       |                         ^
> > 1 error generated.
> > 
> > But this was tracked down to iwl_mld_send_proto_offload()'s
> > ipv6_addr_cmp() call.
> > 
> > An upstream Clang bug has been filed[2] to track this, but for now.
> > Fix the build by explicitly bounding the inner loop by "n_nsc", which
> > is what "c" is already limited to.
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2076
> > Link: https://github.com/llvm/llvm-project/pull/73552 [1]
> > Link: https://github.com/llvm/llvm-project/issues/136603 [2]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
> > Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Cc: Avraham Stern <avraham.stern@intel.com>
> > Cc: Daniel Gabay <daniel.gabay@intel.com>
> > Cc: <linux-wireless@vger.kernel.org>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > index 2c6e8ecd93b7..1daca1ef02b2 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > @@ -1754,7 +1754,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
> >  
> >  		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
> >  					  &solicited_addr);
> > -		for (j = 0; j < c; j++)
> > +		for (j = 0; j < c && j < n_nsc; j++)
> >  			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
> >  					  &solicited_addr) == 0)
> >  				break;
> > -- 
> > 2.34.1
> > 
> 
> I might be going crazy but this does not appear to actually resolve the
> warning for me, at least with allmodconfig:
> 
>   $ git cite
>   a33b5a08cbbd ("Merge tag 'sched_ext-for-6.15-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

Make me look. :) "cite" is a local alias, yes? Looks like my own alias
for "short", but basically "short HEAD". From my ~/.gitconfig:

[alias]
        short = "!f() { for i in \"$@\"; do git log -1 --pretty='%h (\"%s\")' \"$i\"; done; }; f"

> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> index fba6a7b1bb5c..7ce01ad3608e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> @@ -1757,7 +1757,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
>  
>  		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
>  					  &solicited_addr);
> -		for (j = 0; j < c && j < n_nsc; j++)
> +		for (j = 0; j < n_nsc && j < c; j++)
>  			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
>  					  &solicited_addr) == 0)
>  				break;

Oof, an unstable solution. Well, I guess we work with what we've got.
Your change also solves it for me, so I'll send a v2 with it that way.
On the "getting it fixed correctly" front, we need someone who can tweak
SCEV: https://github.com/llvm/llvm-project/issues/136603

-Kees

-- 
Kees Cook

