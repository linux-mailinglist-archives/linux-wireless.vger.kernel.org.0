Return-Path: <linux-wireless+bounces-25624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF04B098BA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAD61895AD7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939E29B0;
	Fri, 18 Jul 2025 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxALx1Ze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AE20E6
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797150; cv=none; b=AQBiT0XS17YWBWlgiMY7gEcl+5pdPP9FYjHNQKOR56MtA4ii2IXIUPjysVMQ2zFlqBi5VqOxBXExBobP8y2KZBEYWGPWbTHcyqXtpxEbwZr/SCItwDcII71XHJaTd/tiKuPbRsSH+58QnwO8G1VE1TzQa20Kyqv+YV/jx18mHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797150; c=relaxed/simple;
	bh=yCw7IpmH0rgNcz07JxWMJ7jAeiHi3+CslcvWHjywjRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn+ukXcjZah3fYZKjPkzT9QH3yphn/eU/qj0jLbmWVbNU+e2aMujF2QT/UTschShhb+KT3ygCYqKpRdlnqAvKCaP0/m/PLsLN6BBjRRKTvMu5ZNiD7xjJ8V4hfF1m8mGyazcGlAbV9dE5QRGKrooSo3gyXbo2QUylHLmvvsqmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxALx1Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150E0C4CEE3;
	Fri, 18 Jul 2025 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752797150;
	bh=yCw7IpmH0rgNcz07JxWMJ7jAeiHi3+CslcvWHjywjRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxALx1Zef4/WSOWZejUEPAIFd8ovrNredReiPXVqQxvo9HtHV09TgICAqWSTMWGns
	 vCFv6jr4u8P2/l1roUDmBYNXkA8QdJN63WDgpzM7cnSkYAQOA/clquMOr61HGNjxGy
	 A9ngwyc/cYb8QlOAY909bERFCWPxNJ4c0nGRSPeVlTQ9/T3qbCZKG/XlkoFeBrRVT6
	 NniPB9z+zblrg8WuIyCYkJ+UX47GZsfSojRukMzumBWCNGoAQZyNz987YtTafM+k+T
	 kuQTo76JBXvUPxVVeys1UXhppKJ+lRNAGMUnUiAUg336Mw+83OB6qGkamzx8t8rJWr
	 VcDq6y5JgqZ7A==
Date: Thu, 17 Jul 2025 17:05:49 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Haoyu Li <lihaoyu499@gmail.com>,
	syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com
Subject: Re: [PATCH wireless] wifi: cfg80211: remove scan request n_channels
 counted_by
Message-ID: <202507171651.8E89C32F4@keescook>
References: <20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
 <202507142200.D315742C@keescook>
 <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>

On Tue, Jul 15, 2025 at 10:24:16AM +0200, Johannes Berg wrote:
> I'd expect in most cases it's really the same - you allocate, fill, and
> never touch it again before throwing it away at the end. I'd argue
> though that in those cases the whole thing is quite pointless, although
> it still allows finding out-of-bounds reads.

Adding counted_by has filled a large gap in the compiler's ability to
provide the bounds checking. Back in 2022 I had mostly written it off as
"unsolvable" with dynamic sizes being over 60% of the uninstrumentable
memcpy() destinations: https://outflux.net/slides/2022/lss-na/#/6

But thanks to counted_by, we can actually chip away at that percentage
and it's fallen under 50% now, which is nice. :)

> So for now: no, I'm not going to apply any new counted_by() annotations.
> It's cost me far too much time for having absolutely nothing to show for
> the investment. Ask me again again next year maybe.

Yup, totally understood. My desire to get them applied was mainly due to
there being so many (fixed size) array bounds problems in various wifi
drivers that it felt like a good place to focus: dynamic sizes in the
core wifi code. From the same slides above, you can arrow-down through
all of the then-recent array bounds flaws and excepting one in BT,
they're all in wifi: https://outflux.net/slides/2022/lss-na/#/1/6

> If you feel motivated you could help review and perhaps annotate the
> still existing ones I guess, I'm thinking we should have comments there
> like this perhaps:
> 
> --- a/net/mac80211/parse.c
> +++ b/net/mac80211/parse.c
> @@ -54,8 +54,9 @@ struct ieee80211_elems_parse {
>          * scratch buffer that can be used for various element parsing related
>          * tasks, e.g., element de-fragmentation etc.
>          */
> -       size_t scratch_len;
>         u8 *scratch_pos;
> +       /* __counted_by: scratch_len tracks the allocation and doesn't change */
> +       size_t scratch_len;
>         u8 scratch[] __counted_by(scratch_len);
>  };

Sure, I can add this to the TODO list.

> But I'm also not completely sure I've convinced myself that all the
> above discussion about allocated vs. used is really the _entire_
> explanation for it being such a spectacular failure here.

I think it's a big part of it -- having the counted member change after
initial assignment is even frowned upon by the compiler folks, but is
technically supported.

Anyway, sorry again for the wasting of time of yours (and others) that I
caused with this -- I really wasn't expecting it to go that way, and it
hasn't been anywhere near as troublesome in other areas of the kernel,
so it took me by surprise. I have tried to chase down and fix the glitches
when I became aware of them, FWIW.

I'll see if I can write up some patches for comments like you suggest
above with good "proof" attached to them. :)

-Kees

-- 
Kees Cook

