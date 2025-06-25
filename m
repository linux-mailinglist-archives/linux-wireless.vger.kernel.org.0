Return-Path: <linux-wireless+bounces-24496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE2AE8BAC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869B71664ED
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7D283FE5;
	Wed, 25 Jun 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipn4r7cY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E393074AC;
	Wed, 25 Jun 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873288; cv=none; b=J82ZK4HOXDTBmDODpV8S20XanlDy2dgI9F+nGjQKNP8hh5Qq778VUMvjpV7VITiL7o15Jzklv7TfUytDBQ8Zgu/n7uQatDH59WqEoDENYz4n94Uyur7A53e9rMQu3hlhDUC7HHcRkDE4BcolRB+hvHruLkXGPliReDW3kO7sHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873288; c=relaxed/simple;
	bh=GJ4WYQLS3cQ9RCxD/lktKcXdHa+wH52/hSbjRvGKM+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVVTwZu10BMlzXgzvFC0fX5Gdi58hSnH0Jy6mcy3z0dWF31BXUjsYL6cujjj2itEoRM6rZyQoJkv8MjdWcnvICOSvuZ+dsi6WFT+l7fKABI4F9x6/o78BGEnVde0vDaFl2GcUgyk5K8zrB4u/1Gdja8vYipATMVOoCZ/0hVWfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipn4r7cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666B5C4CEEA;
	Wed, 25 Jun 2025 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873288;
	bh=GJ4WYQLS3cQ9RCxD/lktKcXdHa+wH52/hSbjRvGKM+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ipn4r7cYHtehklno2LiNCZcurIWLrkZWQNlAfomb069oURoaCQ1CySyspX3+FEr4t
	 /11jBbPC6Fy0Af1TfexSJQOJ7PP3gb5FseQ0UHCCONBnSKurS1fazzIe9z39Hiwiip
	 WqlAqCn3eHqN5UGGPKBaPKrwysmOxc2UoPCSUAFPCqwoWtQ3guKsgEwWmQlXz4wvOx
	 RDT8OC2WN9ZNpzjMVxNlXJCYnn2Yd6CehXTNII9vJJcfTAr5jP8qQQ74F99dteNcDU
	 cIb/qcxN5NyTe5Vs5QybksxuUN/+SrwQUmI+gkLC4g1kQeuDHYzvtPhwvhfShdY3+n
	 9PJttmtKrYlIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B663A40FCB;
	Wed, 25 Jun 2025 17:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-06-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175087331502.562505.15156151326646946291.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 17:41:55 +0000
References: <20250625120135.41933-55-johannes@sipsolutions.net>
In-Reply-To: <20250625120135.41933-55-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 14:00:22 +0200 you wrote:
> Hi,
> 
> And for -next quite a bit more, but not all that much
> that really stands out either. iwlwifi picked up a bunch
> of really old cleanups from patchwork "spring" cleaning,
> and the rest just move along with regularly scheduled
> feature additions. No known merge conflicts here either.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-06-25
    https://git.kernel.org/netdev/net-next/c/ab4eb6a25de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



