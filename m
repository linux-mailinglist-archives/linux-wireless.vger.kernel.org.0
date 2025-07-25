Return-Path: <linux-wireless+bounces-26009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA96B11558
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 02:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16F53B4C77
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65249155A25;
	Fri, 25 Jul 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHZVc38F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA81155326;
	Fri, 25 Jul 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404125; cv=none; b=BJITYYw549FtthCs68TRf1+z7FbGTvyYEh+ku/KwlD9/1QZ5SBjnr4KQTUwlqVq0cK3OpgSaa9mf2ZG6KCWKCZo4nw1/NRG5VMdM9DJspeIc9/n1tMWpMLLAmG8womKDe7F+8qlnVpKpD/5wVXZ/OOpLrYwvZF6zOoBCLKYevIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404125; c=relaxed/simple;
	bh=sJ8hnCiiUdWopVOOLpVAgCie3JFoMZmRlydRMt+TwQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L531cPcwgxf7Ct5w7mnVwcs0lTFRtSpq+9FC4rge55mwCMRK1IspmLNqBMCbAArp/AiirM+FxcVA/vYDNxXz1AjsTpkCMcKg6kZfXq7cGAbVFB+PRipQdhLbrS5mGAgsDo7ZqgTJrNF5yyghTbQE33dBSjBju3OE9R1oKw/tlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHZVc38F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D5DC4CEED;
	Fri, 25 Jul 2025 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753404124;
	bh=sJ8hnCiiUdWopVOOLpVAgCie3JFoMZmRlydRMt+TwQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHZVc38FEkr/0HsQ/j1GGTbO5f1LDewdiuyeGXqWcrVeYIjVr3Bm7D/hhQnb4Elfg
	 El9Z+ENsJ2nI14ClseFLB/TBg1Dj2fWJvEvn+bxfaah2v48e4h+QwK96i1txcVnPnF
	 /Ut3KH9MgePohmSD49zShQr3P3C3B2k4R6EJ0kMFY8X7uEnASPSRXIqc/ZFp19hCI4
	 4J5Z9VZKFNW6W6arc5sLpuxOxlGuxy0AUJQJ5CPnvbu9P+jq9iDHodsyBsShh1QyyF
	 RUBrSwqOinz8AjICHNSPOlX36ctm6ZkeQfSG6L7L35OtuRFRZ21P3oPxy4w0r7CY6r
	 dgjDlfph6Nxhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC59383BF4E;
	Fri, 25 Jul 2025 00:42:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL net-next] wireless-next-2025-07-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340414225.2585720.6034128085891620870.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 00:42:22 +0000
References: <20250724100349.21564-3-johannes@sipsolutions.net>
In-Reply-To: <20250724100349.21564-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 12:02:42 +0200 you wrote:
> Hi,
> 
> Here's another, almost certainly final, set of changes
> for -next. If we (unexpectedly) get -rc8 _and_ there's
> something important to fix immediately I might send more,
> but at this point that seem unlikely.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,net-next] wireless-next-2025-07-24
    https://git.kernel.org/netdev/net-next/c/126d85fb0405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



