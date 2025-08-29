Return-Path: <linux-wireless+bounces-26874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE2B3C3EC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D2A18914FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94A31A06E;
	Fri, 29 Aug 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbGR2JOR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049C4A11;
	Fri, 29 Aug 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500616; cv=none; b=jBedt5uipKJDFDbYuXBRjWO33XeNFf6A6+/HRiwkeDReToFe11GiSuQGQjDhn4usiPYb5dmXxt28qrjwjxS4KVb4pmtLUUwNp86YSuwjg62ECAPxksjWyqJvhnpoqRKJlkIJhsIGC+TXFwmK8MntZ0AmOOn/EGjmEek54L4CGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500616; c=relaxed/simple;
	bh=vtju5XP2d/uI1hNDwF8myIQlNe7OA5QCmtgFKNT6r8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHxcJKu+Ww2Koo27CgC5iKXDQfryB6PV5HRDEXlfYZ1oOlprODrZvXVR67f5bSQ7z7SU9C3MaH6k/fhlpL2DBeeTmO45cXoeiz/bys3c+9ohF1GARLcu/eZOUb8oDqCrJViboZpvDZipq0MbMN+v6RGK7uiaA1NaoMgD7imVHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbGR2JOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9CC4CEF0;
	Fri, 29 Aug 2025 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756500616;
	bh=vtju5XP2d/uI1hNDwF8myIQlNe7OA5QCmtgFKNT6r8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbGR2JORu5AcpvngKZmXexUQFnIbXkjIDbjV5br/DO/t+qCk7TKZKfE+WhEDcUISx
	 WBubRBStNaGk/fc8k3uLFywsTAG4c04hz9GJ5BBEEnpXVIi1QIpMSx4kpAuaY18peA
	 Soc7jcpqFZt0U9MIPuyufphJpEoTcplB1JdvLugG/zAnDzGL+k5YPSTC1Ick0WygJG
	 ojR8/v7hI8faQe1fMhhR35ui+uoV6UotqWSFqTq41g8kbR7wHaxfdQUTObM3FbxskY
	 AsBP/PJEAOoX5fHWZ9zpx5fJ9vVs8lQshc1mgm4hb/TFBTWY8EYHSjri7ngrUQx74s
	 jgcGKW8OeQq8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE63383BF75;
	Fri, 29 Aug 2025 20:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-08-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175650062275.2336923.4617126776537381012.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 20:50:22 +0000
References: <20250828122654.1167754-8-johannes@sipsolutions.net>
In-Reply-To: <20250828122654.1167754-8-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 14:25:58 +0200 you wrote:
> Hi,
> 
> Back from vacation, and a bunch of things accumulated
> for everyone. Nothing really stands out much though,
> except perhaps the various iwlwifi regressions for old
> devices, which were all my fault...
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-08-28
    https://git.kernel.org/netdev/net/c/629840e208bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



