Return-Path: <linux-wireless+bounces-8271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584408D3B8F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6011F28E5B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECD181D02;
	Wed, 29 May 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fypTA+JW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0D181CF7;
	Wed, 29 May 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998320; cv=none; b=WsQ/FwUJWRKfLkle5hI4hCuX73+MTNeA2CajvJc7QG2KUIrkfZRunlUTHsYT4QV28NKQ4f9dpM7cznV3svUZ8qR7SVSKnx2PDRMpHDkF8CvgtP8ZtFxhxm1rsSsEZ2m8/9+o74Pc5A2mSVUTHCGzt+Yte42qSBwFpJsM6z0K5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998320; c=relaxed/simple;
	bh=ufyQbqT93SwSt4s4JqmoiAB/zHJa/FMuOgckZ/BR4TU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MhjhyaykSajl2weD08GXzNLCxiOdA8RKpPQp+u8ovxDM41x2IUGxk95raVEsjVqF+Ya9mxi+ThT3+4gq4ykOfT0yBtSSlVeOl0VcKbhnlF4GIgXdXl8CtdR8kqBWTsZJZUJQgVcfwCB+DwRz9PD3bt2BC75933uwlDVNbni/kF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fypTA+JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491BCC113CC;
	Wed, 29 May 2024 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716998319;
	bh=ufyQbqT93SwSt4s4JqmoiAB/zHJa/FMuOgckZ/BR4TU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fypTA+JW2IV7pVP1qSfV1ol4Ja9TfGeBVVJx8MRhuBAJGIEN1e8OFOne5tbK7RN2a
	 D0LvLXsB5H5+Gy+2++biOK246LPXm1vkQzR9dwUErgCpKivRZRfiAf8HPNiTGKX9pU
	 oWErLgw+ObFGOiZhKOKrIKTl3UdfBp0zLwwvyhBPfMijoZcJ4GqJGbGRVpxLiXLuK3
	 rlD365rHM/V9afV0i+oKhcXyHY2VXEmAZKWOS9YOv4s3qcmAjzDtAySsurpBtSy2FR
	 KYwVbp/sbn1MbK0yr5b9F++Zx1/dfnPzTxAlo4T5Gd8s0DbfhjRb+ud079yR5zNYSX
	 CxazeMz/4IGdw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
References: <87v82y6wvi.fsf@kernel.org>
Date: Wed, 29 May 2024 18:58:36 +0300
In-Reply-To: <87v82y6wvi.fsf@kernel.org> (Kalle Valo's message of "Tue, 28 May
	2024 13:42:25 +0300")
Message-ID: <87wmncwqxf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Yesterday I run our ath11k regression tests with v6.10-rc1 and our
> simple ath11k module reload stress started failing reliably with various
> KASAN errors. The test removes and inserts ath11k and other wireless
> modules in a loop. Usually I run it at least 100 times, some times even
> more, and no issues until yesterday.
>
> I have verified that the last wireless-next pull request (tag
> wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
> always, usually within 50 module reload loops. From this I'm _guessing_
> that we have a regression outside wireless, most probably introduced
> between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
> yet.
>
> I see different KASAN warnings and lockdep seems to be always visible in
> the stack traces. I think I can reproduce the issue within 15 minutes or
> so. Before I start bisecting has anyone else seen anything similar? Or
> any suggestions how to debug this further?
>
> I have included some crash logs below, they are retrieved using
> netconsole. Here's a summary of the errors:
>
> [ 159.970765] KASAN: maybe wild-memory-access in range
> [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
> [  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
> [  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
> [  259.666542] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x755/0x8f0

I did a bisect and got this:

cf29111d3e4a9ebe1cbe2b431274718506d69f10 is the first bad commit
commit cf29111d3e4a9ebe1cbe2b431274718506d69f10
Merge: ed11a28cb709 e6f7d27df5d2
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu May 16 18:14:11 2024 -0500

    Merge branch 'pci/of'
    
    - Check for kcalloc() failure and handle it gracefully (Duoming Zhou)
    
    * pci/of:
      PCI: of_property: Return error for int_map allocation failure

 drivers/pci/of_property.c | 2 ++
 1 file changed, 2 insertions(+)

But that doesn't make any sense to me, I don't even have
CONFIG_PCI_DYNAMIC_OF_NODES enabled in my .config. I guess I did a
mistake during bisect, I'm now testing the parents (e6f7d27df5d2 and
ed11a28cb709) and trying to pinpoint where I did it wrong.

Adding Bjorn in case he has any ideas. This might be something PCI
related based on my bisect log (but just guessing at this point):

git bisect start
# status: waiting for both good and bad commits
# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# status: waiting for bad commit, 1 good commit known
# good: [1d60eabb82694e58543e2b6366dae3e7465892a5] wifi: mwl8k: initialize cmd->addr[] properly
git bisect good 1d60eabb82694e58543e2b6366dae3e7465892a5
# status: waiting for bad commit, 2 good commits known
# bad: [1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0] Linux 6.10-rc1
git bisect bad 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
# good: [d34672777da3ea919e8adb0670ab91ddadf7dea0] Merge tag 'fbdev-for-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
git bisect good d34672777da3ea919e8adb0670ab91ddadf7dea0
# good: [a90f1cd105c6c5c246f07ca371d873d35b78c7d9] Merge tag 'turbostat-for-Linux-6.10-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
git bisect good a90f1cd105c6c5c246f07ca371d873d35b78c7d9
# bad: [29c73fc794c83505066ee6db893b2a83ac5fac63] Merge tag 'perf-tools-for-v6.10-1-2024-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
git bisect bad 29c73fc794c83505066ee6db893b2a83ac5fac63
# good: [30aec6e1bb617e1349d7fa5498898d7d4351d71e] Merge tag 'vfio-v6.10-rc1' of https://github.com/awilliam/linux-vfio
git bisect good 30aec6e1bb617e1349d7fa5498898d7d4351d71e
# bad: [8053d2ffc4502bbb50a78c805d964e65a6de1803] Merge tag 'phy-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
git bisect bad 8053d2ffc4502bbb50a78c805d964e65a6de1803
# bad: [f0bae243b2bcf2b160ae547463bf542762beef8f] Merge tag 'pci-v6.10-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad f0bae243b2bcf2b160ae547463bf542762beef8f
# good: [38da32ee70b876f5b8bea7c4135eff46339c18f2] Merge tag 'pull-bd_inode-1' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 38da32ee70b876f5b8bea7c4135eff46339c18f2
# good: [ed11a28cb709a9ab69c4cd4e0669079a455f9a8d] Merge branch 'pci/msi'
git bisect good ed11a28cb709a9ab69c4cd4e0669079a455f9a8d
# bad: [102c69699b5b5d4aebfe8d15d5f91bde68dababd] Merge branch 'pci/controller/mt7621'
git bisect bad 102c69699b5b5d4aebfe8d15d5f91bde68dababd
# bad: [14680b252788675e2007fffde371e76a3a7a9b21] Merge branch 'pci/dt-bindings'
git bisect bad 14680b252788675e2007fffde371e76a3a7a9b21
# bad: [12ff1ef539c23cb7563bc3d894de9edd9469ea98] Merge branch 'pci/pm'
git bisect bad 12ff1ef539c23cb7563bc3d894de9edd9469ea98
# bad: [cf29111d3e4a9ebe1cbe2b431274718506d69f10] Merge branch 'pci/of'
git bisect bad cf29111d3e4a9ebe1cbe2b431274718506d69f10
# good: [e6f7d27df5d208b50cae817a91d128fb434bb12c] PCI: of_property: Return error for int_map allocation failure
git bisect good e6f7d27df5d208b50cae817a91d128fb434bb12c
# first bad commit: [cf29111d3e4a9ebe1cbe2b431274718506d69f10] Merge branch 'pci/of'

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

