Return-Path: <linux-wireless+bounces-30718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D3D16477
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E66E43008DF4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020F1E8342;
	Tue, 13 Jan 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brp+jZhM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54715624B;
	Tue, 13 Jan 2026 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271436; cv=none; b=GFwSU6tE+I7acBS2CY+fEpRzRnJQo3mbD5qLbBLvVVr4JMIdfAZyh57zCl55vQvJlKuVk+eXLOlxiHHJ540HsmxKR0XphJVQfTR5TV1e6/m7B0UZkVfgcwkI1Ag/uz9MgdIEZZWIVTp0d9CzkgkLpB3QF0sSUj2sTK3DkOCZZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271436; c=relaxed/simple;
	bh=F7Kv1KzG1KV3pPGwjnT7kKwfkj6wfHV/RLQrIxPUHec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mvTYg3YDOuxLHTQC8s9bzVQ8Orz58YBy7BrcmLUrTDqDfECI3YlhBrz3VZs+NghyGMzB4oiJOBQJ87DSmybm4V4Uoa4uge25Jwy+XIIWQ5dGt4rwyVZVGNTA69sK/GuuG1FyHSQ7eBVyOOENEC3PaArjpLJRvwpxAi+IWB2ss3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brp+jZhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C21C19421;
	Tue, 13 Jan 2026 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768271435;
	bh=F7Kv1KzG1KV3pPGwjnT7kKwfkj6wfHV/RLQrIxPUHec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=brp+jZhMuWhO/P7ho8BFNop0Igcn+K6aqV93/2M56UL8AlsspH+FoV9fvv7m3i052
	 DxSYzpWpmsyiz3NdJe+qNK0kbuM8drK11H7VUrSonGO56NjMFAm4VIEazGfDP30e1Q
	 JbtCfA5iORES64ZbxMkMxwEVHaPVEwc0tC1AQz6APTb3G+amfpDXTvJafh5OeyrtX2
	 PwY066znsxviIgOsDlBLKMkXeq/qewyI2Nl+KAF8X5ivpPV5r9+ve4KoRVM32E5iJ3
	 pHcA6eNvJIpQoQ2ZlTZ1/bRetwYZoSbmqjSwrUnuUOekJduQYJckqzYvj6RIJ3eBWX
	 dLjZFQxTNki2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5918380CFDE;
	Tue, 13 Jan 2026 02:27:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-01-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827122927.1606835.2413134483085368827.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 02:27:09 +0000
References: <20260112185836.378736-3-johannes@sipsolutions.net>
In-Reply-To: <20260112185836.378736-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 19:57:07 +0100 you wrote:
> Hi,
> 
> Couple of things first. We have a lot of NAN (WiFi Aware)
> stuff pending, but it needs a bit more review (time) and
> also a merge from wireless via net via net-next first
> (which you already have, but I don't want to pull back
> net-next into wireless-next w/o a pull request).
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-01-12
    https://git.kernel.org/netdev/net-next/c/669aa3e3faa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



