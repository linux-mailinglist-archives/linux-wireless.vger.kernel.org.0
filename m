Return-Path: <linux-wireless+bounces-9619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D264F918E02
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF0288C1D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58828190473;
	Wed, 26 Jun 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3hWBRzu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F200190465;
	Wed, 26 Jun 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425504; cv=none; b=jUTfB6anunbZEjWMobbyEy7lCtGcTrQeRmFpturcTEWY+wi196ZMztS37TmcslmxW5bMMtOreeRO+b4XLDWzY07suLtFT8CkN2hbl5ZQf+SQfNs/G4fFyVyLai3U2IAmcqssyK5RAxiXn9fn70TUITc4Y0Zvl2BLutVI6UhBgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425504; c=relaxed/simple;
	bh=V7B++SJTszDbRNn3G1xfashn5MADZfh7Xs25Pyj+9SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGuTC/7AM232cWeBWw3QuEDSOGCn6maigRjwJr/5w5L9l18DapGmMu8cKi20hOiEopUuVyztU48VPA0oqkClkr2C3b+SO1c0rD9YMe7H+3ibwHosQwJie0BmUr0Jzmpo+NoUzNebelEsakCXOwP+6qViXIr0ZVjlqRdE6P0P2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3hWBRzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F81C116B1;
	Wed, 26 Jun 2024 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719425503;
	bh=V7B++SJTszDbRNn3G1xfashn5MADZfh7Xs25Pyj+9SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3hWBRzu57EVn5yNfPCrNA+FB/8psQr9gsgMuEAWq4Dp7czjE4E4kDcuRvBTjajDE
	 XC12iG3k0bdxF47I24Yn9AoBm5WqwyPWn5dTKCSqPWymCGZ+ASL6ltaHwNGHCPfpcC
	 URe7qvfCKRAInrvOPM7glooh4y1gMFkC6c47ICcrXHUyVjB3n4/byDMM1zos8WhhJm
	 MOKzVJYwABlQejZZFBNkJ4D6u/pVCh6Xa671IXIxQNe494ov3Aoc0cqmoNA8wjQat0
	 +vkcrpSVKpYbY84/IcLP54W9JUU1fIwSSguofMOsl3riOAQ5lKEIXxx8hbpWOJsV4c
	 AIzq7MOur2QfA==
Date: Wed, 26 Jun 2024 11:11:43 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	Koen Vandeputte <koen.vandeputte@citymesh.com>,
	ath10k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ieee80211.h virtual_map splat
Message-ID: <202406261111.2D3237A731@keescook>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
 <87o77pik7w.fsf@kernel.org>
 <20240625080248.32c3e03d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625080248.32c3e03d@kernel.org>

On Tue, Jun 25, 2024 at 08:02:48AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 09:56:35 +0300 Kalle Valo wrote:
> > > Adding netdev to the initial message in the thread.
> > > https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
> > >
> > > There was some discussion in the thread, with the observation that the splat 
> > > is fixed by:
> > > 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")
> > >
> > > Followed by discussion if this should be backported.
> > >
> > > Kees said that "netdev [...] maintainers have asked that contributors not 
> > > include "Cc: stable" tags, as they want to evaluate for themselves whether 
> > > patches should go to stable or not"  
> > 
> > BTW this rule doesn't apply to wireless subsystem. For wireless patches
> > it's ok to "Cc: stable" in patches or anyone can send a request to
> > stable maintainers to pick a patch.
> 
> It's an old rule. Quoting documentation:
> 
>   Stable tree
>   ~~~~~~~~~~~
>   
>   While it used to be the case that netdev submissions were not supposed
>   to carry explicit ``CC: stable@vger.kernel.org`` tags that is no longer
>   the case today. Please follow the standard stable rules in
>   :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
>   and make sure you include appropriate Fixes tags!
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

Ah-ha! Thanks. I will fix my brain. :)

-- 
Kees Cook

