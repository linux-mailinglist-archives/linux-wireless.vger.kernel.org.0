Return-Path: <linux-wireless+bounces-28877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FABC540BF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CF3482D0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB417208994;
	Wed, 12 Nov 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCZ+CwpY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5026290;
	Wed, 12 Nov 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974053; cv=none; b=gicnIO/kOzfSc35t/UGuDav+uyap5IhHVm4O65iIib6MmgGm5mQzhhs021KSJpPRuIH9xKLdCBV1P+vXSqnnnkrUwki3kKHxXLbEcoYmmIqh1brMoQceZe7jyA/WFbYRBshO5pheqjAg5jgk9EkU2JXwuqSQSKxmy6A8IjqDhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974053; c=relaxed/simple;
	bh=YG0xHY2mJI826MxExp7n3Aifu87nbcUkOM/OGc3eEsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SnaErs8yeKSRN2qVoQhcNgKyaSSWuFvPBMxfchCoYATeVlCDMEiUVU8Mrcdw+x10+IWRR3gpwMtMXlwGkg8sBn96nYbTYxSkDiSrU9L+tMgqd2BElORdCy7y1eAMN8rb/CcaLuERTpbKoYKRSgKks8qvUVUXGGPm8AQqUoscaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCZ+CwpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF99C4CEF5;
	Wed, 12 Nov 2025 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974053;
	bh=YG0xHY2mJI826MxExp7n3Aifu87nbcUkOM/OGc3eEsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CCZ+CwpYynlfnqBwAdpo8jor0a4ftdMnsYFE5vnXzRFsJ7hsLvGxbhLnA9eSHfqrq
	 JkTWW9FVVCnHTOEtn5ZPSuOzyv7m/AnpbCzWpPK354/wOVaWOO9klFGjYVi0VkvUWP
	 wMWi1Cop7aG0kDgHAAuOOeFR53ZVSGFUCFeid9riBbHIjU/0ulyAJK7NuUbIvxTUeA
	 FzoaUgimhIQhBw4LvXZvNBPFKMTZdlsSlxltWgD6ByxgB4YwoDwwDfk6Npkl/KOpUE
	 yIH+nARGXCDRzgCOgzArfhJn2KGLjew0p0lh//S45Is3eY4dO/GRyRIryA48qSWUQn
	 4sNM7kLIo7+3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5939EFA67;
	Wed, 12 Nov 2025 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-11-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176297402276.118315.14407056712148068336.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 19:00:22 +0000
References: <20251112115126.16223-4-johannes@sipsolutions.net>
In-Reply-To: <20251112115126.16223-4-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 12:50:29 +0100 you wrote:
> Hi,
> 
> And a little bit more stuff for -next as well, but
> Jeff informs me that Qualcomm has a lot pending from
> their refactor side-branch that reworks the ath12k
> driver architecture towards their WiFi8 chipsets,
> which will come soon.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-11-12
    https://git.kernel.org/netdev/net-next/c/e949824730da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



