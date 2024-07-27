Return-Path: <linux-wireless+bounces-10553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C572993DCED
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 03:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493D2B2316F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13235A21;
	Sat, 27 Jul 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPvXvUKU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42417E9;
	Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043834; cv=none; b=GfJKtLVBememsrCuvlzHFkUYY7YSQZN2zVypTzPLk91iC1ikfJJWvyj9MuRmyrzMLaEAOydouQgckEfnCSimW4GJDV3CSyNi2gCdalfaeUDxAyEM0LvoHYhak+zXfku4jKoacwYbzi5l4u7ekpTka+SpxOxpzbf8DUH/2Qywmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043834; c=relaxed/simple;
	bh=z50IqyaxepmWaGfG4giFOgMsvXCwiojLTUqIfJ3SBDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6bzas54k7TukL4R+I2H+CQKb7MiRmHjZCnXdw0Y3kOG52RrCqIvtjsIuFTHkQUchO7+JygFGccBDF7imAaO8ixIM1bVA+FLJb+yv7oN0PddDuh0Ak+uAZ2JPq0wC7BhZbD2aBQAUdfkApYokmlq2lKGStMIcyqRElm3OlzHvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPvXvUKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D66C32786;
	Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722043833;
	bh=z50IqyaxepmWaGfG4giFOgMsvXCwiojLTUqIfJ3SBDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fPvXvUKUBPdhChD83uifdEEvrAlDwB5hy+O1R7zIRtEuVDWuu3OpdW6s1RMx+fqtG
	 Zqelyolmod1J3R3jGAKjsBuWPA48U/HfBWu5vHojoFOHcVjQdjqaSwehapQ+pnC/dR
	 nnhRsudDvV+7vaTq1N/EtEdvFrQvWBvPBfyAWjXPoN1Vw/8IHo8pkj+TnFYomicAqZ
	 0h1rfM1ngxsyLK3Il8oVFMzgFGPBDJNGgDG620P+H1NHO2QZbZQO3Ab/OY7yleGcA6
	 tZ8OBM2YLzdidvgHcAfFO8XRFgiC/HSM3lReLPzvNS8vU77dkoydhZpAJ4Xlyw0P5Q
	 obNdul5iW0gaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74DBBC4333B;
	Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-07-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172204383347.20059.8375450317517385004.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jul 2024 01:30:33 +0000
References: <20240726122638.942420-3-johannes@sipsolutions.net>
In-Reply-To: <20240726122638.942420-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jul 2024 14:24:39 +0200 you wrote:
> Hi,
> 
> So, given netdevconf last week, and vacations etc., I'm sending
> now a couple of more urgent/obvious fixes. Next week Kalle will
> be around again I think, so he'll probably have more fixes for
> drivers then, but I figured I'd get a few obvious ones out.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-07-26
    https://git.kernel.org/netdev/net/c/f99d93de93c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



