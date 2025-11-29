Return-Path: <linux-wireless+bounces-29424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0FC9379C
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 04:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D684E1BFB
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 03:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDED224B1B;
	Sat, 29 Nov 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX6+hAph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05433223DDF;
	Sat, 29 Nov 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388486; cv=none; b=WMJrl9El6w3UsEuJn/RQE1uibDzidBPXxUdOMaMMJgok8qq6lfI/CJWHnE6sUM1BcJHQHc8Y2URQeTtjlChM+qhuQqjvQUcsRJkwnk8Nlb+DPoJoO47wanRRv/Oa5ueEF7Zfk8ZguoxngwagZTLXCqD2F+BeTxHclXivheccwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388486; c=relaxed/simple;
	bh=77HRNdF8D4LKvIclapdeM8Vo9pj/eFMsHHNtPWDBX5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhEuktNfQksFJEKiQhKEJ7CmnEZ3JWXSs7NXsIgotZ9IYZX+1lTCwwqEwSmaNveTSbTgXLdqogAVMA0JAC95xF1t1+oxxkaiTahK/6p4l+aPFldPUC/PT2SjBzYsc2IjAo11xC0h2XMAuTqoMd7S+qyjwAHW4PTGt60MmSfiEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX6+hAph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8473C116D0;
	Sat, 29 Nov 2025 03:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764388485;
	bh=77HRNdF8D4LKvIclapdeM8Vo9pj/eFMsHHNtPWDBX5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WX6+hAphbtAcMKDh01tRwKbTVGNPCnl6J/nd40Z/Nz+kVgY8wd4Lb2XeVMBHAOZ0/
	 Jcyem9hGdcnePbBEZO9scWhanWCViI6qwixgSqadgpQRjQmpQccDvHdCHShbTnR1LD
	 nA3YCjSBdlqFFuHk8welPBUB/UhxobYXb+TNf3OGSWNGEEd0fha6Coq2b6Yny2GMIJ
	 DbeSX4Zl4A3msL5PmpmRlMMJLs3FVJGgtB6e8MsFPe/ugqM2PSNiRXVGqsIXms10dS
	 7jIGFJx7o3UOAROMnNQIyYtgTYphUQmFulHYllvoYP15dAk8cKrP8GbRPxJwdWd779
	 bYwHSSGNE3cvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5923380692B;
	Sat, 29 Nov 2025 03:51:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-11-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176438830728.886304.14636673300598102002.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 03:51:47 +0000
References: <20251127103806.17776-3-johannes@sipsolutions.net>
In-Reply-To: <20251127103806.17776-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 11:37:09 +0100 you wrote:
> Hi,
> 
> So Qualcomm said they're still validating their architecture
> changes and prefer pushing that to a later release, so for
> the last changes we have it's mostly Mediatek and Realtek
> drivers.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-11-27
    https://git.kernel.org/netdev/net-next/c/2c80116b5032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



