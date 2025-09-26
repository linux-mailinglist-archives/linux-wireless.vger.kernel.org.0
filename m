Return-Path: <linux-wireless+bounces-27680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0970BA544B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366873AAA19
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60E296BAB;
	Fri, 26 Sep 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtH/yjwX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE5291C3F;
	Fri, 26 Sep 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923520; cv=none; b=lPGf5AzbLos6Z6CIFA/VTzVslHhRISaVP6gA9SsPkqib0ch1qHL3q0xuYQVwisOSIhKmsq46xb29sfLAUZjsD/HnTcQ8Ncm9imd30NHa0Ascs7+NascpHVCYDHSPMVxUWDiuPiXQcn2SHbNlE9GmzwgCdDvzrz2mXCer06rPu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923520; c=relaxed/simple;
	bh=Dj/xsT3JL/oTr7mgjVYFZU+QhCfxW87iCA9RsiRqm2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tkSp1Swcq696dLPCDkJ+y9flzK3n06lEJ38q5qtPLdaJoqInad9klrPGCqxAhz+85FIkoYN1HxThxoUsrHe5uq1TAw6oszG+JsAqugBddYBWjyyJs+YbRXFs3vX6tZeMTSPqCQq+7PUlbGhBJMB27SjKMiS9NhNrYQuHCTf9BEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtH/yjwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF00C4CEF4;
	Fri, 26 Sep 2025 21:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923519;
	bh=Dj/xsT3JL/oTr7mgjVYFZU+QhCfxW87iCA9RsiRqm2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DtH/yjwX2HZbjm4a6g6n7Ca4nwuxw9Tq3PwmTolaEal1rl8D7fQqcLz5CmhvVTCwe
	 XzdY0ba5gCzb/qusCUqzfPCOpFlsiaizTAZcobnzG7ftFz9r7a1ZBNeYCjrjeTRu5E
	 WAUnEo9E2dzhaiyu+y38/U4kWc5g03DOdhwj3zSoHHK0XSVppkoMXAEONBGYvTdWdc
	 UbCvpC8LEhi3DMoBN/O1LSI5tAskiqL+xjs7+1OW6igibJSl0yTKIBjnvKyQG+crJ9
	 qZX7HlARpknzg1PJ3tBegedw9coq40mXq9wvwsGNyK52rYGpwZ0/5M7ms0+e01adh6
	 oQxJl25ZluPPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5939D0C3F;
	Fri, 26 Sep 2025 21:51:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-09-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892351474.70549.8235124920709808256.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:51:54 +0000
References: <20250925232341.4544-3-johannes@sipsolutions.net>
In-Reply-To: <20250925232341.4544-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Sep 2025 01:22:19 +0200 you wrote:
> Hi,
> 
> Sorry, I was sure I sent this yesterday - Jeff just reminded me
> and indeed it didn't make it out ... Not a whole lot still going
> on, but that's obviously expected at this point.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-09-25
    https://git.kernel.org/netdev/net-next/c/94aced6ed9e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



