Return-Path: <linux-wireless+bounces-9446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B579D912E15
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 21:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677CE1F25251
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501F13CAA5;
	Fri, 21 Jun 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyAlmWdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088A13B59F
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999181; cv=none; b=onYEBNKB816ylaUW+axrXPVfrhaMjky9KrLzxcFN68JKu0RWt6E+/zTBC/spY6/IvM0iUeOJO4u1oEzVIGbM9mlBky3F+1cSmXu4FOjQTjoaF3+hA68PnRRWHsmiRafnq+YtQPk/fu5P0lWnU7b/B7gDWGUA1YyQNYPK7SXfRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999181; c=relaxed/simple;
	bh=C3SIMqwONzYK1bUW0NsLIvelgHUVmx8PUbQFb9azWgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7kwS75lpf9LmgmzCXBpJYEaYms9/2k1Sh4nV635yWKiGYbcLlw+ozXz5edSreTPums+aaKakJ49sJ49+OmFYYk/AUUTfAPM+oA3zhPmhjdGfllbv4pEOMHDp1zzhr1Agxv9NnjioFMkU/pjxOeEEZOItGhS0qvIuzB6G+ZheQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyAlmWdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB6AC2BBFC;
	Fri, 21 Jun 2024 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718999181;
	bh=C3SIMqwONzYK1bUW0NsLIvelgHUVmx8PUbQFb9azWgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyAlmWdiwSlArMQwwj6AgWEljbMzqR1tszAeD7cfwBwAuc+fWbEXH7xU60Gzs1UyR
	 6K/Bd3JK5x9HnYWf+ohbbehb1lBkONGYBDDtIjSRLcmoUruD9lymRlYXDUckkYEFKo
	 2ymx4GKeiJT1TqyDfj26AmWmapnAlrP1mt/+OKvWIzELOELNaLpN5OL+HFooo0z7E0
	 XOo6PxK7lIv5oSmyYDzeL545k9+is43kXXbPuiSL6VZaOAThGnCCPuD9/9bxZs85sU
	 EuCd0CvNBxHbYerh9/y7DRJLzKjHrG1zrFbj/ixPmQ/PUIjbeMXFUnmGPn7cxSA7XR
	 CU3sdI+0yJyew==
Date: Fri, 21 Jun 2024 12:46:20 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	ath10k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: ieee80211.h virtual_map splat
Message-ID: <202406211241.3E23349@keescook>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
 <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com>
 <83fcb33e3fadb457466126255297899fbc4186f8.camel@sipsolutions.net>
 <CAPh3n80PF4NULjKJVVMEiGuuJZhLQszYSTCv+f6e9LfVJbKesw@mail.gmail.com>
 <d834ff59-f331-4eb4-91c6-e76eb48780d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d834ff59-f331-4eb4-91c6-e76eb48780d8@quicinc.com>

On Fri, Jun 21, 2024 at 07:25:08AM -0700, Jeff Johnson wrote:
> On 6/21/2024 3:31 AM, Koen Vandeputte wrote:
> > On Fri, Jun 21, 2024 at 11:30 AM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> >>
> >>
> >>> will this one get backported also?
> >>
> >> Why? It's not even a bug.
> >>
> >> johannes
> > 
> > Because without this patch, it produces a splat on kernel 6.6 (which
> > is an LTS) at least ? :-)
> 
> @Kees, have you been backporting all your flexible array changes?

I haven't done anything explicit for them. This is especially true for
netdev where maintainers have asked that contributors not include "Cc:
stable" tags, as they want to evaluate for themselves whether patches
should go to stable or not.

> Or are you suggesting folks disable FORTIFY_SOURCE (is that the controlling
> config?)

I do not want people turning off FORTIFY_SOURCE. By design, this is
a warning only -- the memcpy() still works like it did before. The
goal was to catch any of these stragglers going forward, not to break
existing code. I expect that in a few more years it can be flipped to
warn-and-block for these kinds of detected memcpy()s, but for now there
should not be any behavioral changes seen besides the WARN appearing.

-Kees

-- 
Kees Cook

