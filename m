Return-Path: <linux-wireless+bounces-21457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59320A8697D
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D319C005A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102B2BD5A8;
	Fri, 11 Apr 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCfpS8zC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF11401C;
	Fri, 11 Apr 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415397; cv=none; b=ACSv+pTOmPTb/X+7F+p+y4WpQSulRIlCNS/DqLXqESgQ+Ox7yGlETGujbfpRjSAZY3szHBJ4++JKigFRLDx5y/4xNvk/98gpySyxC/6pPINTI3hvA046h/XiCRgzq5XlZmI213Oj6JgQrdL1b/GmTgIQKnpc192PrqGx1EN28QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415397; c=relaxed/simple;
	bh=5ESxyS3afAZd5sdDf4I2P5LvxytKC1jPwHqBHjnDjnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OORURCsDNcOKk19ix/77MTzd9o5J2gXv2gqLFNweX9yRYuEndfzWY0mWCwK3UhhzmyLmhzHcUXGRG0TGTuq1V7YYuTYcUBhRTIjNBsKwo+I1YtYgXH7Ls+merMQyx4BPBQduWnoE76ey0XfGPs1ZvjSkZKJ9fEddNeXkoIYNUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCfpS8zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC44DC4CEE2;
	Fri, 11 Apr 2025 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744415396;
	bh=5ESxyS3afAZd5sdDf4I2P5LvxytKC1jPwHqBHjnDjnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CCfpS8zC0xzS+ArjXky1MVganc9YELgY9XQnVHLVy91w99cAJnvj3EsWwvZLSEYPW
	 FwQTT6ZEDfFU9bKAV/mYeBjA2wG9E8mTg1edv/+vxb6lfzbU9/gb1xSqVRwqfRVNFX
	 nOe1FBU1fitnH4zK4q2zCQxVXnbajAWqe4372UROfqVpFzSfWLFI44fKFyPDrgHeIO
	 /7HvFFerzBK9+qOeu2+Z8Uo4NlhEcD0nQKI8Kf2O9z56Lge8GAwmXJT0j45KVTV8Zr
	 6Ok40elDibTESEssrOHp28sdhOAu232JXZV9qsoVx4bCIkMXKmt7Ap0qc6sPWYuARP
	 unInJvSilJvzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA738111E2;
	Fri, 11 Apr 2025 23:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: wireless-2025-04-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174441543429.522873.5561569705586007081.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 23:50:34 +0000
References: <20250411142354.24419-3-johannes@sipsolutions.net>
In-Reply-To: <20250411142354.24419-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 16:22:42 +0200 you wrote:
> Hi,
> 
> So I meant to send this a couple of days ago for -rc2
> to get the build fixes in, but on the flip side I had
> to revert a fix that caused some other issues, which
> was only reported yesterday.
> 
> [...]

Here is the summary with links:
  - pull request: wireless-2025-04-11
    https://git.kernel.org/netdev/net/c/e861041e976b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



