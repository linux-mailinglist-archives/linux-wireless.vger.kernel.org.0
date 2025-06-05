Return-Path: <linux-wireless+bounces-23771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C279ACF0B6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F41189232F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856923E34D;
	Thu,  5 Jun 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUzCwkTR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DD23E33A;
	Thu,  5 Jun 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130202; cv=none; b=iavSP8zoNuOYf319muHWw4IzFRaOczNIQSzoN/Go1WK/d7XPaOIZKkCXtPv2MFqEA4ISX6KMCkN1OufF2bW+bWCiGopdE70VOIshZVkyUkZyJ0hakZNwPstc8hiRkq9q88Em4Ro0b9DrEScAhZ9e8MrLNjFZNelo2sQd2uVUJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130202; c=relaxed/simple;
	bh=OkILp9BuTsHd06bZtUreHvf2I3UvQkCWNgtxRf30ug4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KMU6lcFEXzL89j4uRGQifSpU+nrs2T1pfM/PgP1UOGBeTI4Kzuf0M1BZbQvhWZBz5YvKK1xrWVC2wLOEKhxdcnkhCfOekNGU96AhZQag7v/sH/eIpcqv8u9G0VbAkFxeoaUDXvwIWGbED7zDnffhUNmLdQvRk6mo/pR7pg5NrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUzCwkTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3962C4CEE7;
	Thu,  5 Jun 2025 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130201;
	bh=OkILp9BuTsHd06bZtUreHvf2I3UvQkCWNgtxRf30ug4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dUzCwkTRBc+P4NwqJdt/XARCi/DWs6vk8/eIdwLD02IZqkx48OZsAplyfEHhX3mAg
	 qwauzhlpfEG+jHfRPptsFEXMQDUfVf9TtSKZjoL4pLWJwvelr0/ZMrTAUScGHU80RH
	 jY9my2gcP/lkEsa+7dOOkIbKyKQUXMERz++nB2eT+XJF8s0K3FGC+cpiA8koUFvdfi
	 q8KrZOTM7ebdJ6KIligxAk/TKo1bwcL6iMvvcY6dJ+17nvP0AcaM24PMpO9fl/LdGz
	 Jrm6jamYtNS0x2Blg0Ls9UoMcqQ1VotwaurSRbz1J81/YZMqCUPa5zrlR2rLQ6EXKt
	 PcBZ5/5jAbMWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADEB38111D8;
	Thu,  5 Jun 2025 13:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-06-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913023376.3074298.5223495875579398519.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 13:30:33 +0000
References: <20250605095443.17874-6-johannes@sipsolutions.net>
In-Reply-To: <20250605095443.17874-6-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Jun 2025 11:53:56 +0200 you wrote:
> Hi,
> 
> So normally I wouldn't send fixes right now, but there
> have already been reports about those iwlwifi issues,
> so here we are.
> 
> If this somehow doesn't work out I can defer to after
> -rc1 too though.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-06-05
    https://git.kernel.org/netdev/net/c/4d401c5534ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



