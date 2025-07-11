Return-Path: <linux-wireless+bounces-25298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE5B02615
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BEA4A3B78
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F461DE3CB;
	Fri, 11 Jul 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXbgJLWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490251B414E;
	Fri, 11 Jul 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267805; cv=none; b=hWquk1jZ3TkmlxIszg/PGfV/kY7kRm9m5h5Zvg2X2RY2L7Z2I1WoAEUZhRyEf2jaTsSukmOy/b42KWEHXXC00fbd5TSqkKcviq0+5Q6v0lGhQj3gvX0nZHIXmaV4Fy2Sn1PvSWiZWVeROo8YcUqy17eijTmAEIdG/oUFEHuMBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267805; c=relaxed/simple;
	bh=hss40vdmqE4mYcg0sdwPVEcVkg0ntAjmK+txmQ0qyI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a55GWpH7WxvfJeJpMLz4aanX8vC6tnmFjk7/nLmy310OTjQb9zGkEqB6ke5PRrRvbDrs7u9PV4dhjkzfxtiQ7T1KfxhCMOoAg7IMrEzOsr7wLSjh2GAH8F8grcdGlvUHywdcPzi7OfM7O3vu7Ys7VHJoUglSGSB/aTehEf4E4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXbgJLWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E1C4CEF0;
	Fri, 11 Jul 2025 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752267804;
	bh=hss40vdmqE4mYcg0sdwPVEcVkg0ntAjmK+txmQ0qyI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXbgJLWkdV6MK/tNldMrpBMWn6RFakORTVvdWIkCuVO8IJTD7wOefIEuESd/xJvBa
	 KCt007VQYJH2atlFmxJWvUBa9dZ+PkhueHJHCcqg/LcR+wWdDRKkZk4R9jBh6W2iYs
	 CPRqQCKxR2hNsCCOvmly/HeZci66cFuETAisQm5Fqqte3SjTItxWiWTdexvbRU7HAd
	 gX61qZ8cXoYP5OamMBFv0le0oUcySO6AtUrJFMOCaf+uKkQ7VAjStm1qgLT1wdiDFb
	 Krd1afoxuI8qG8VUzt+7n0OINNLTk0onC6kt8vKl1p/V7FBw7qX/SSk14+WKvy/dP1
	 nwZYXCB8cbY4w==
Date: Fri, 11 Jul 2025 14:03:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-07-10
Message-ID: <20250711140324.65386022@kernel.org>
In-Reply-To: <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
References: <20250710122212.24272-3-johannes@sipsolutions.net>
	<20250710172352.3ccd34ec@kernel.org>
	<934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 08:41:28 +0200 Johannes Berg wrote:
> > Some good news and some bad news. Bad news is that this missed today's
> > PR. Good news is that we shipped a bug to Linus which is likely to
> > break nl80211 users:
> > https://lore.kernel.org/all/20250711001121.3649033-1-kuba@kernel.org/
> > so I'm gonna send a second PR tomorrow, with the netlink fix and I'll
> > include your fixes in it. I suppose you may want to wait with the fast
> > forward until then. 
> > Now that I typed this I guess it may be two pieces of bad news..  
> 
> No worries, and thanks for the heads-up, I can wait. I actually really
> hope this was the last pull request for the current -rc cycle anyway,
> but of course now that I said it someone's going to come out of the
> woodwork with a fix ;)
> 
> Re the size problem, nl80211 can indeed create and fill really big SKBs
> if userspace gives a big buffer, which it often does. Looking at it now,
> I'm not sure why we set the rcvbuf to 8KiB in iw? That seems ... odd. It
> looks like I originally did that to _increase_ it, but that seems
> completely off, and my first fix didn't even do anything. Then we fixed
> the call but ...
> 
> Looks like the problem is entirely self-made there, but I guess we still
> have to live with stupid userspace, sorry about that. I can take a
> closer look at it all and try to fix things there, if you think it's
> worth it?

Probably not, unless it's hurting in another way. The well maintained
userspace is usually not what we have to worry about the most with
netlink.

I was holding off replying until the dust has fully settled but it
sounds like Linus is still hitting some hard to pin down regression. 
I don't _think_ it's us any more, so I reckon you're safe to fast
forward.

