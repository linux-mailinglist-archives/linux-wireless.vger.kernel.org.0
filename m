Return-Path: <linux-wireless+bounces-231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A57FE7EB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 05:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF6B1C20A13
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0D13FF6;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPDmkcZr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA5F51F;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182E3C433C8;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701316827;
	bh=bvpuE3NylRU5DTplcz7FHvwcMLarXAsCcqNQtCJ5uZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iPDmkcZrSWUoua9JKLxxIdx5enCXSOe6yyPRLktWHkZ6BgeYA31/5yLVbJF6wPkfZ
	 Kow9MgVa5OGLKqIz9E57lPuoI5I0asz29U83AZcfH89LIBdRlcv0WTOdleiZa4fscp
	 jgBKpbgB2P78//8l7uWm3mMD07eX2HeCbFQM7IDqxsFeO3f3Os3K1O+Z0Ok5quwcGc
	 bwSw5+vTMqWFzlhAsVkTOPJFiIejToCGJX2wTfrKE8HwWvTqWk8kEdb46Nt9aBn2PR
	 Jutyn6B6Qaf3NZQ6Vfvi7VQBoMVNxjgMDUvg/ib3F/SWijxm9s5NHm4Zm56vOVHoj2
	 OQ6phD6SQn9OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE4EFE00090;
	Thu, 30 Nov 2023 04:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-11-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131682697.19383.11559365661597137352.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:00:26 +0000
References: <20231129150809.31083-3-johannes@sipsolutions.net>
In-Reply-To: <20231129150809.31083-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 16:04:24 +0100 you wrote:
> Hi,
> 
> Here's the first wireless pull request, see below.
> 
> Now that I'm actually preparing this, I'm having second
> thoughts on the debugfs lockdep change, since that's a
> new 'feature' of sorts, pointing out the deadlocks. I had
> that in to actually sort of prove the fix worked, though
> I also tested that another way, Greg ACK'ed it, and then
> I didn't think about it again. I guess I could revert it
> back out, but it doesn't revert cleanly. Lockdep only.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-11-29
    https://git.kernel.org/netdev/net/c/300fbb247eb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



