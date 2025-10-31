Return-Path: <linux-wireless+bounces-28451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C989C26CCB
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8395B4E78D7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00430E0EB;
	Fri, 31 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAv2RoCg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E2308F32;
	Fri, 31 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939633; cv=none; b=MFq2ex9hnjh9ydi3wOEu2g0mEPo+0jbIU8hNei987JSxiFxUnn0D1WZOz803fTgIkBFDc7c2cduRxkUxwi9jpD09/fss8457bu1WwNJYpim7X7Gui6z1/cYFeTuBJKHuZ4++w5tv+UCHMCSOB+OSyS1lFx3X3H4Zn8ACNdjYu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939633; c=relaxed/simple;
	bh=tSVBu/tO4oT6HC+tGqNpQRMbSh6rjrN7PRwJoGrayBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jIp8uUr4Zq8oNQv3Y4sPxl0ysp0SGv0SezpORePUx7oGfDHgI0TCCQHZUGc+bxCBlZpPgpuMdxb+TqD8Lh7me5kJR1pi+5vv+EI6dPxaZuuFvo0I2CwrGTb5fnGAWYQuXAOaY/LIOHXDk7W3ON6oY6s0TFCuavISI0S2ih63eSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAv2RoCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B9C4CEF1;
	Fri, 31 Oct 2025 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761939633;
	bh=tSVBu/tO4oT6HC+tGqNpQRMbSh6rjrN7PRwJoGrayBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FAv2RoCgZ9k7vMgYL3rTS0ZWd/y9jzBMoLojA1vWXRlohTbMgqKJXsKPkWgwXHhTC
	 gm+epWiZvf7wur2cYV8jslV8UPoxjbpQfDpJoAR33VIcycJAS1jk5omJPN7NT7o9oS
	 10zmr1jwGCQYfk6JAfbbcexqdnbhaqnhr/iAXvhJ579yzQF2EnH+3tZyCGtrTwCAmC
	 SB8Q7w7ENhAPFyXTOIaypwLH3n3rYvA3kzv5hbkZ7xMg+++xks63/FqoFgBUEXdyGn
	 HKLxEjqU2OybWnuTefB8IwFt8ZSnRGzer+bmzCnTtchAZwVE05om73c+VC2MqEc7fb
	 nDzkqieTLf68g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 84FF83809A00;
	Fri, 31 Oct 2025 19:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-10-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176193960951.617624.5597489360212256261.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 19:40:09 +0000
References: <20251030104919.12871-3-johannes@sipsolutions.net>
In-Reply-To: <20251030104919.12871-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 11:48:05 +0100 you wrote:
> Hi,
> 
> This is the "not quite Halloween" edition, but there's
> nothing scary here ;-) The hrtimer work is maybe more
> than I'd strictly like, but all of the affected features
> turned out to be pretty broken due to long timer slack,
> and it doesn't fundamentally change the behaviour apart
> from using the more precise timers.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-10-30
    https://git.kernel.org/netdev/net/c/b7904323e76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



