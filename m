Return-Path: <linux-wireless+bounces-20804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAEDA704ED
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0317A1885B51
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997125C6E0;
	Tue, 25 Mar 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZKDPHiI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B925BAAB;
	Tue, 25 Mar 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916038; cv=none; b=mGWaIBb7cydA0MSCJgYd4XrSEhJAruLW12kEp6bxL7pEb6pZA2Cv7OJLMM9PNlUYzxyz/uGGCXa9lFXd9ew+uKVz40JyKc4pTXniZkh3+N/WkgQnHoS2+TaHVb7ebq8Uyfbsxas5spV4S2IGewzzdgzNUp11KHIPPtfSSy+fZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916038; c=relaxed/simple;
	bh=OJ901v1Zl6w+ZmNx9DfZfxUG7OmSS70uPsKHoNWUPTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/QrPJii2msaJLOuyYCVNw5eLJkvqFCwl7QDFPXCbX7n4u5xT1bIo3fzm4px8XwXj0LklRERbLAsoivvZuVjKmUoqq3UTKtMu0lQUZWN38o8n8aKq0kRK3Jp/owRjZYU7gHA1yQ9bTnN3be/hLLbOG64oxzEhxndE6AEuqH8M4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZKDPHiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389EFC4CEEA;
	Tue, 25 Mar 2025 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916038;
	bh=OJ901v1Zl6w+ZmNx9DfZfxUG7OmSS70uPsKHoNWUPTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZKDPHiIhYzKiG8LlcpgLLqBfQpSyeYoVbLqtFmxSruJ4Dkyy5peJ15xe7+gFSUgx
	 1QWN9GEuxg2N5PQemHtFMgihBLWIKxX3sKEqd7w/z0w0d1gR36a2lX+KNbHzr88ULC
	 LJuhbu1BXmflNbeyG4fhYRlK6RoTmHn5Q8skZzwtYTUey5csn8Eo4UdIvxMP2BGkPx
	 Q0cZLcATcf+s4ADtdzrsLo3c64na17ZzjoTso9ap4ZnQTWO4RCfapVU3w5A4wwbeN0
	 nidp8CqDVwQu85SDp9DzTzcnKTKCf5eqpUxMvkjVfD3mlCXD/3RcfJMC/6ODtiaNXI
	 zACopP3BruTyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE10380CFE7;
	Tue, 25 Mar 2025 15:21:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2025-03-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291607451.613159.4085141288279158538.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:21:14 +0000
References: <20250320131106.33266-3-johannes@sipsolutions.net>
In-Reply-To: <20250320131106.33266-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 14:09:50 +0100 you wrote:
> Hi,
> 
> This is obviously going to be the last pull request before
> the merge window. Nothing really stands out except for the
> new iwlmld sub-driver for iwlwifi.
> 
> Note I pulled net-next back after wireless/net went in, to
> fix the reported conflicts.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2025-03-20
    https://git.kernel.org/netdev/net-next/c/1952e19c02ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



