Return-Path: <linux-wireless+bounces-30578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145ADD052CB
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9562F31BD647
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3262DFA40;
	Thu,  8 Jan 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC2ZuIzD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECD2DE715;
	Thu,  8 Jan 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891221; cv=none; b=bH/fLz30oESprmtRWkDwHGh6hT+geGa4njomE0FZS9uYCaP2xFhogMGcR49MJBIXyaK95TkPVg3E8czcOB5O3E0loQh6uyN2Vp8witAdE1dpp6cxGDr+fUQoIU8JXt8/7ZPckhNmm66CeFv59NhXW7UaL8TI96Ki3kRigHMoIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891221; c=relaxed/simple;
	bh=Ts1muOavFyR+CMHHmy7O619iAFPJ2dNHocafgCAzdyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UtCdWqSfmNIBRsYZvAB7gvGDj4531y21nUuagwERl+YqdYeeU9X3ett0VS7Y7Gi+wlLNtTdqnvB+prGkyB3YyFUHy7mKabQdAE4EGrBlA+geGkqj2DmJlCavzWNBVirGkIE9GE+sTopR9XLnNb2JKDefwmOT7bJB0r9JH3RHkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC2ZuIzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F73C16AAE;
	Thu,  8 Jan 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891220;
	bh=Ts1muOavFyR+CMHHmy7O619iAFPJ2dNHocafgCAzdyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oC2ZuIzDea1axb/98d94uctnpbSOk115fA3s62Gr60yxUBsc7Idz6oQnTsO1/VTZB
	 CstsA7v8ty5ZZ0g1AC9/+SADz5llHU03y1AGhAlxIB5V0PFnZbi35aSubydsn5YnS7
	 tPq+bIl3d42XtoYM3UOXlwitEFvgShONOrmOZcciwWh02K2CmVJGUjfB9dAMZdC4/m
	 DoM7jq6Hqx+57hOIt7VhNKujpKmCGqVcXsyJ5fSyHNYub1upHsOBZlFKMvzC5l1JKX
	 VMuA4iuEG96Q27faxEb+9vzw4MVVnqv/zC/aGy2gDs33RlkibulocFcbPPILuF12vm
	 cPmSwaDIYJP+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78C783A54A3D;
	Thu,  8 Jan 2026 16:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-01-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789101729.3716059.6759131308217908715.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:17 +0000
References: <20260108140141.139687-3-johannes@sipsolutions.net>
In-Reply-To: <20260108140141.139687-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 15:01:23 +0100 you wrote:
> Hi,
> 
> After the holidays and all we don't seem to have that
> much yet, but I've collected what we have for now.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-01-08
    https://git.kernel.org/netdev/net/c/804809ae4085

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



