Return-Path: <linux-wireless+bounces-23013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A73AB8975
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9174C3E64
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4591DE3B5;
	Thu, 15 May 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZYImO9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628211DDE9;
	Thu, 15 May 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319397; cv=none; b=oOJO4AF3rRwVbPvle05QasBos6gcbOaKvfb5UIiTwnBxrxuCMST2PuuqV00hA2koP1HOxZXWZxlwfYVOAwo85FEAxD4btra9XvplPtrcwwCWbgOqOq/JalOYqDxz9hyBGl8iLDI+Vq+A2Pr4Oa7AdUIfCHh+tJD0TWest5UdV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319397; c=relaxed/simple;
	bh=NYs0E4uGPUt8sEpti27h2TpE1otAsTP3t2HwMSSR7eI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F+YdpEYGefuVQ2px5ABnqTmkhlMtpnGfItafJ2x5YyLCKR/iRuQ9MrxIFemSo/X2z+krK7dLG/KikNnQSP8uFXCc0LLWfb5qo+Jx0OwywH4v0J51Jnh97snN+YI+Fzp21xlewNIHv2dJ5jMCjB929sRTyJhewOXN1aGlTkFQlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZYImO9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDBAC4CEE7;
	Thu, 15 May 2025 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319396;
	bh=NYs0E4uGPUt8sEpti27h2TpE1otAsTP3t2HwMSSR7eI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uZYImO9sz3d1w1V1DXgLstvxS/LoE9vY2ZBf9PhoE5bxgai9fdxFEQJeg27WlIqez
	 d6QA0Ru+XPfU+nAPhT2eYf8a5Ex6UhhPKwbN4Z+tDRXOX8G8LJ09NFJg3PjiuTbvHb
	 6oj/zLzctd2QrCSgxAd0qDjvoS4CFkBxwJ1kYuIVwWwcplLF0mcQCWw80Gtx7qoGQW
	 cPNpSSzsouHLiyBrg4l78j/u5eP7S+baTHtip8bgp3Cm9Hv8wa4vyA43/5J+8xkh02
	 rOp0pZhFvSYcHlR8Y7tv9ZpzgLsURur06sKIU/jdPvbT2COenoXveDbtTY/IFHZW6I
	 FM1316dwB2AGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3D3806659;
	Thu, 15 May 2025 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-05-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174731943400.3129203.11323251065440610018.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 14:30:34 +0000
References: <20250515121749.61912-4-johannes@sipsolutions.net>
In-Reply-To: <20250515121749.61912-4-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 14:16:56 +0200 you wrote:
> Hi,
> 
> So originally I thought last week was the end of it, but
> mt76 fixes just got in now, and I threw in a counted_by
> fix as well.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-05-15
    https://git.kernel.org/netdev/net/c/3933536c877e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



