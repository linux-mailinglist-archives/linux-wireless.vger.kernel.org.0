Return-Path: <linux-wireless+bounces-24273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE776AE0ADF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1567A3641
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480F2673A9;
	Thu, 19 Jun 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6tLKeRE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4A22AE71;
	Thu, 19 Jun 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348192; cv=none; b=Xqmddzkv6BdLrGQkLyHJihBek2X4jI22FmuVvqcN4NXc5e+X/DlYyLl2m1OCXIhO6Kunzj0UgxFzWiaIBSIwTk2nDgIcfscN4AbF9tpI7JT5NrueqPalZ7ltYsdRZPPfpN+SWNWXSKKvwXtAB2D7WfRWsmu7NSr0qOSnblivMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348192; c=relaxed/simple;
	bh=kWwGXHYkA1vdX0KEfIN+OBhrO45cdCHvAB7CFtk9Dp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QikWUsG1MFe16dLAuxe4KMdFcPOVGG1C2TdZgD3wumkqvII+y10catqJFkGHabu8KT9d3WvAoR7pCKwifDx7BZYDyx20TxJn4JI5q8L4Zqe3vHSg4w/sp1mVM7EkT6SYw1Y1hLQIu7HLvUgVb+CQfHVUsOVlGGFQSuQyFQhIpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6tLKeRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3B1C4CEEA;
	Thu, 19 Jun 2025 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750348192;
	bh=kWwGXHYkA1vdX0KEfIN+OBhrO45cdCHvAB7CFtk9Dp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6tLKeRENGtehmQwGqvFPWvB8/h2+ro33sU5JQGyoIN3cDYXKycPz/vXCedrLVkfk
	 2+w+zhvjzOjruLDtO2nm88tXOl+rMdusEZqwNdqQEvfn5ONvb01dzCwBRI2/3ZYHiU
	 BBXz+M63U2scgfL61SaOsYs+t90P/kYMWlXXqKHUNqJpacvb5zWqqexnVU+R1kmU3D
	 bn5RiOk3VkI62ZsQjPtv8e4lslyxk+DxYKZHdvPf/Nc8JHUjq6jvgG6Pr+o8XE4Gzs
	 EEgDszCU/2qJ4k0jDtNuJBfwOejpvCMksFN6uHTy/hwdg3BVftAp2C+ShCQpppY6na
	 BCzYgi4Ki3McQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8438111DD;
	Thu, 19 Jun 2025 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-06-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034822025.909907.17676918796049155430.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:50:20 +0000
References: <20250618210642.35805-6-johannes@sipsolutions.net>
In-Reply-To: <20250618210642.35805-6-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 23:05:56 +0200 you wrote:
> Hi,
> 
> Another set of fixes, pretty regularly scheduled now it seems.
> Mostly ath*k and iwlwifi fallout, but we also have a bunch of
> syzbot fixes - seems a few people independently got inspired
> to take a look.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-06-18
    https://git.kernel.org/netdev/net/c/dccf87ea49b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



