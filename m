Return-Path: <linux-wireless+bounces-24076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9144AD7659
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D065B165C41
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F92D540B;
	Thu, 12 Jun 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAVy6CtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DA2D5406;
	Thu, 12 Jun 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742212; cv=none; b=Vve7tgn0DshqP1SPgaESwQZnryUruMc7DNjF1xdRuG9q+lfYkIhbtXOcliLMqrIRNaQcIqxwpPjPprJ/cRgHEvHZIL5eugz0ZmmEpFwz9/SbbJ5KmWep6kC2N+PLORd3PYPSXpuYLB+mkmuYjVTljU262PghNtp+7yeLpI+LjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742212; c=relaxed/simple;
	bh=A5C1n3ly2JnwFvS6G4jWLeEfz/NL0PIAv7S/hqVufOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lFt8u0+QQhG6xZsyrExoAhP/O/r8SpC3L79tkEZZtFSWcWAD9VPA7HIcbZBWqJOy6EziZ/jxFNwRMNTuefx1tYKmk3qnM/u/uIqdgnFUabPS7N0Np2k6xs16qMBY4EtdotjoSebf8jzaOooBglNaEq0KJfrhfmBbUP5R8fgDf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAVy6CtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E58C4CEEA;
	Thu, 12 Jun 2025 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749742212;
	bh=A5C1n3ly2JnwFvS6G4jWLeEfz/NL0PIAv7S/hqVufOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAVy6CtZ2Jh30+6V9EM5pz4lfUgRE0aon8IVwmLBlMfg+KfD/bi1K6qssuwJ8FFh1
	 RovGGOjSILONFQ5wDhMuZ9Fnt10mYwt6xFToehhon9WGutsavlhyNMMKpwKTRlRDom
	 uI/dHFKgQcJDtvKUh2pOHBsKoVTE3Oa9XzpZ7EG+Rj3tFcd1ezCwTP0q3A1fvAQ+S1
	 /MMhn1lADW8JS1NFNmKxWGFtQHbmIovxdNHOwLNB4nNgRlhvxOu7mAamBA3LqTRcEd
	 TMXt1tEyZhpbsnqB1sWeYr5lDDOxpmMf6OAfWpXpYZZuu6KSJoXrY1amtm73gWMfAz
	 dz5BXK8XeK9sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1F39EFFCF;
	Thu, 12 Jun 2025 15:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-06-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974224223.4184138.14336932581689328706.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:30:42 +0000
References: <20250612082519.11447-3-johannes@sipsolutions.net>
In-Reply-To: <20250612082519.11447-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 10:24:19 +0200 you wrote:
> Hi,
> 
> Just a quick couple of fixes as described below. Part of
> the reason to send them now is that Jeff wants to have
> them in -next to avoid conflicts later.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-06-12
    https://git.kernel.org/netdev/net/c/d5705afbaca2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



