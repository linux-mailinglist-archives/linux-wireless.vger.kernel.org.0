Return-Path: <linux-wireless+bounces-22087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A10A9D616
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231C04A3DC0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD21296D3A;
	Fri, 25 Apr 2025 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwDLP1LP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD921296D37;
	Fri, 25 Apr 2025 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622861; cv=none; b=rvT24ea6qkG247+loGtX5ceYKh7t+YFcRyOlwA0XjCZ087P5bBIx0xABoJQ5KIH3zCEjtl8/RUrCObPim1TsNpjGFrsFi92dzdloaAyW5XoQIdpBxI+szTWOhOA1V8vOODFcihF8lqIPYDlr4VMEk7Hnm50ZyHLt/ZaP6jZwVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622861; c=relaxed/simple;
	bh=/3+EpY5kAKYfUTr3MB2kwKL0Bo2vCJ3MPx+r89JsXWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovsOKBIVR05URk5FYN8pzbyYwDTa85ZNcQ6cXRKxZqZx6mBlDjtx6PghfaLIKiAnah2+GmJWUXrviVadhQKEXptwxTQ6y7wVT6GS7XMf219kE1Tsr7ZW5Jw4LDFIK/FH4dff/p0AdjlsmNWNvVmrg517OYNiyZmse3xj/jxdhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwDLP1LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75084C4CEE4;
	Fri, 25 Apr 2025 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622861;
	bh=/3+EpY5kAKYfUTr3MB2kwKL0Bo2vCJ3MPx+r89JsXWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwDLP1LPFqDQzFvH2p/24nfWsndGZDv1qaWEVnvV8Cts7dVW9nxlho0UGTdVkGCM3
	 xR6JvcrGLS6jrrMR1Xt0YutHI2zoASO0hjiXmXtptzftbHw+EkjHy5zqDhMjJqBrua
	 DG0CZKaIk2kt/sRrSynLLzI/oVDkQKLxgxOd3LfZcUaG7PNqbN2cu7wt64w4dUJ24o
	 Y0yCrDuX2OCl2GnwM+89vKY1X5C/fYP/GLlaDwx/zKflH7Xo5Fd4SpL9/d9nYSPkBK
	 jBszw1+fbSz7tCbwazfyR7xBTiyvJpptopTvQvgS463Dz/yfaRm4wCbtPPrEtvD4X3
	 YtKYgm6BVSmGg==
Date: Fri, 25 Apr 2025 19:14:15 -0400
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
Message-ID: <20250425231415.GA3584546@ax162>
References: <20250421204153.work.935-kees@kernel.org>
 <20250422195903.GA3475704@ax162>
 <202504251032.51B2CB6233@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504251032.51B2CB6233@keescook>

On Fri, Apr 25, 2025 at 11:18:33AM -0700, Kees Cook wrote:
> On Tue, Apr 22, 2025 at 12:59:03PM -0700, Nathan Chancellor wrote:
> >   $ git cite
> >   a33b5a08cbbd ("Merge tag 'sched_ext-for-6.15-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")
> 
> Make me look. :) "cite" is a local alias, yes? Looks like my own alias
> for "short", but basically "short HEAD". From my ~/.gitconfig:
> 
> [alias]
>         short = "!f() { for i in \"$@\"; do git log -1 --pretty='%h (\"%s\")' \"$i\"; done; }; f"

Heh, yes, that was me being lazy :) 'cite' ultimately expands to

  show --format='%h ("%s")' --no-patch

to basically do what yours does.

  $ git cite HEAD~2 HEAD^ HEAD
  e72e9e693307 ("Merge tag 'net-6.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
  30e268185e59 ("Merge tag 'landlock-6.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux")
  02ddfb981de8 ("Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

> > diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > index fba6a7b1bb5c..7ce01ad3608e 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> > @@ -1757,7 +1757,7 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
> >  
> >  		addrconf_addr_solict_mult(&wowlan_data->target_ipv6_addrs[i],
> >  					  &solicited_addr);
> > -		for (j = 0; j < c && j < n_nsc; j++)
> > +		for (j = 0; j < n_nsc && j < c; j++)
> >  			if (ipv6_addr_cmp(&nsc[j].dest_ipv6_addr,
> >  					  &solicited_addr) == 0)
> >  				break;
> 
> Oof, an unstable solution. Well, I guess we work with what we've got.
> Your change also solves it for me, so I'll send a v2 with it that way.

Indeed... I will review v2 shortly but another option would be stick a

  #include <linux/unroll.h>

  #ifdef CONFIG_CC_IS_CLANG
  unrolled_none
  #endif

above the loop to just avoid tripping the optimizer up altogether but I
understand that is just as unstable as this one (even if it is one of
the few ways that the compiler gives us to turn off optimizations).

Cheers,
Nathan

