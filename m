Return-Path: <linux-wireless+bounces-25237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A991B0102F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7322B5A7B54
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8B1798F;
	Fri, 11 Jul 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgJorz3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5824D38B;
	Fri, 11 Jul 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193799; cv=none; b=r9jumlGieSddL8hz2aDfcdGyRHfXXoErDrMcoBn1QoxXxJ3//6wQ49FV9l91gc7DWs0Vhg6cPCQ5jzYyfXzCNJXZWj1cDiQ9QMILEUZZ8FcWilT9BYeIQas8K0K0IlAIPE56Vp6r8MWs+enCVTfLoLHhY/GtQAzL875kdkSqo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193799; c=relaxed/simple;
	bh=AlVgBpWJ8JPmmDOEbAT1bu+FMyG/5fyU5Tu5MVASOmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jjDVNyPs3dQZPQrHBCJg7ZSBxSU2pjEkBs1ePITQl4t4lKeM3tZCKCMbQooZG1rYYSGFJ09LR0ghkqt6AaRy7cPHzzlVUCcJi6ZW2HeQzsnp8Xaw2mxiwKBBdGgZCGFVd3aFmK0U2BkctXoBdJu1vMqfdcbP30lQWyowE6tf6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgJorz3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9BC4CEF4;
	Fri, 11 Jul 2025 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752193798;
	bh=AlVgBpWJ8JPmmDOEbAT1bu+FMyG/5fyU5Tu5MVASOmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgJorz3Sl4d9BleZ+ZHtplR38wxybXxOHMvBs2+bwyeSTTckFlGxhkex7FoDaixWM
	 1nnNPXPBWvCsurwrjT5qRB8FvTwp0lk8JRjh2L85ScSL+wqC+Q/b1OOX5HY9yKLBoL
	 pdKU4pHrsvxT0/4zPpPkrGRyZls+MRyO5bZLVHsvP7MLzEi2upMI6XzMAgfc+Qg04K
	 EvVHJNU1w0VKQxIU1L4UfArcO6kdB0NXYDm2R6dkqYjhsmt58TPaAluLBGtx8IhJEZ
	 kaAPm+kK1TtljCy4o5/Dfm9j5PeY5LKaPQtjAeVcnSYtRTbi60tKUd93oq+fqbyYHT
	 +xexLe3zHMwPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A73383B266;
	Fri, 11 Jul 2025 00:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-07-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219382101.1715084.11048048789594676187.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 00:30:21 +0000
References: <20250710122212.24272-3-johannes@sipsolutions.net>
In-Reply-To: <20250710122212.24272-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 14:21:06 +0200 you wrote:
> Hi,
> 
> So I have more fixes than I'd like at this point, but a few
> were under discussion for a while, mt76 fixes were just not
> forthcoming until now, and all of them really don't seem
> wrong to put into the tree at this point...
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-07-10
    https://git.kernel.org/netdev/net/c/7ac5cc261625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



