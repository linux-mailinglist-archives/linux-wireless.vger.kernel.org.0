Return-Path: <linux-wireless+bounces-23331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351FAC15DD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3008F1C01B4F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A502550BE;
	Thu, 22 May 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvqmsq7h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7C1E9B34;
	Thu, 22 May 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949020; cv=none; b=RTKOWNM453e4/4bT4mgx+fzBz4r0zGb67okcpyivxV3B3I895DCkrqDQELIDCFtfv4RpB1jdIu3PN20JZhlVlFxnUElOFNfmLHxdB3n1Bqv2WhGMOtsoWu5YUBrThWj+4gChpTyTlGrz8c200tOOpYsmieUPsjvlGp9FhTSZKLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949020; c=relaxed/simple;
	bh=Q911GI7e2I/hCrWAtN0VscaUqHPKdFrh62TunIJEvaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fq3cyvL6LK+lVvM592hupn+oYkhMnbsJP5pr3oswhA5MZVM8AuAujz9kh0p6a7YgCW0JUyP4k7U0f7+xtErDok/uaJcEWdeSFPXNL1YCPnSDfufOZlXQOWePjIOIowBCOczA4/Pv4nicj2YikDCmGKYAabLK3t15TEOJGlJawy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvqmsq7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD673C4CEEB;
	Thu, 22 May 2025 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747949019;
	bh=Q911GI7e2I/hCrWAtN0VscaUqHPKdFrh62TunIJEvaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qvqmsq7hB9xolyAKQiq8Kw6k0kMPEEK7LPuZ7Dn4k7tDpJS0ETzOoA1/UqckUfBVV
	 ZrUaAcpFP6ylileseLBgGIVg7ZPOQjMu2vKNNf4X3rYD91DuZwLLDLEpIb/PQrnwPS
	 XXQPB150B1ofXzd6orXtWpjbhI6E0y14fOSukxe/gwGtTRLYvxfzcdNjES05gaOGm0
	 MDNYFN3y1ZTspKO4EFxt7KPC5DWVDF/yDb77BBDjW5aGiwGVVdK7mYNEnInkTAAPkj
	 H4hLMFvizXjduZMkKapA/yI20K4yyv+yKH98Qe8HlMX7h00HiyziOrIpm3rRgg5DzG
	 h3jiacp4f84BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7117F3805D89;
	Thu, 22 May 2025 21:24:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-05-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174794905526.3022126.3894753331387625970.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 21:24:15 +0000
References: <20250522165501.189958-50-johannes@sipsolutions.net>
In-Reply-To: <20250522165501.189958-50-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 May 2025 18:54:35 +0200 you wrote:
> Hi,
> 
> Final, but also big, pull request for 6.16 (we hope :-) ).
> Somehow I got thinking we'd still have into next week ...
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-05-22
    https://git.kernel.org/netdev/net-next/c/ea15e046263b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



