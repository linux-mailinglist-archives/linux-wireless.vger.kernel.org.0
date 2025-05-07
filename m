Return-Path: <linux-wireless+bounces-22701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BCAAD331
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B749819B4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44327170826;
	Wed,  7 May 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx4SKUgY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAB4B1E73;
	Wed,  7 May 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584389; cv=none; b=PzK1Kqgg85lzORjTWGQJFzOTfm2Bs9eFpRlV3e7JHHpr2C9AAUWNBkxrDO154UeFcZdUa2kXxZTPLfAHyysKsEK9oAeVD0ENonRDMaympVwPdwam7VZuEeCmlL1XSHIUHRgCOAY+0PMOcckR+1WzgiXGaDvl/Q1MeGyiH+EgTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584389; c=relaxed/simple;
	bh=OfEw1/EsPzPwNsoFsNlfk4AeH5+dQG7GDR220KfqNNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcen+lY83E6oKCS0zOr3hYzvlaLd5NUp2654smdhZceORjuw/fxXs+rmjqLwvpToWwNY9/miEXIBcAmF9wWquRLUq0+kqb0u9YriqWqOMya+VI7kWGvnJk9MO4l8b6B5WP2DjPjdq3GCZAdZMK43xetqf8OmwTTquIoV7vDkTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx4SKUgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72431C4CEED;
	Wed,  7 May 2025 02:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746584388;
	bh=OfEw1/EsPzPwNsoFsNlfk4AeH5+dQG7GDR220KfqNNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vx4SKUgY/qcr5yJPDOyHiRACQ51NtGe3SkGhRY6KMmBKX/O8tM/aoeshjwSsVQw6F
	 05WOD7YDpGhZsKHzBWnHczBj29nJnPUTmcucu5cnla98n2kfQP572guRkLVciQpqJC
	 VyyC9Qrl9SYwUc1dHEm7DUW6cpOrydo1i8dHqoXigmy4MI80NTmmOLyIfnpW3Q4z1S
	 mIjVLWsKvvSR2+uzoLFwKV+BdMRu0G1cW1UQP9ru95V4BzKYaj43LpCws0J/yqNAbV
	 JS/PyvbO8DY2kGpsDGYDjJKNIg2ZE76tVLRkNmgNmdl6z6G6IjOyeIS9hN45rLQY5Z
	 69v7Om0cJ40hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBCF380664B;
	Wed,  7 May 2025 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-05-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658442750.1712382.814345020148233594.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:20:27 +0000
References: <20250506203506.158818-3-johannes@sipsolutions.net>
In-Reply-To: <20250506203506.158818-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 22:33:39 +0200 you wrote:
> Hi,
> 
> Couple more fixes, that's probably all for 6.15, I don't
> really see anything more coming. Never say never though,
> I guess.
> 
> The whole device ID management in iwlwifi is in a bit of
> a rework right now for -next, so there will be conflicts.
> I'm trying to get as much of that resolved in my tree,
> but with this new commit we'll have to see where it'll
> need to be resolved.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-05-06
    https://git.kernel.org/netdev/net/c/9540984da649

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



