Return-Path: <linux-wireless+bounces-27251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3D3B53FE8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50C35A6DB1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446CE17A2FC;
	Fri, 12 Sep 2025 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTeaXVH7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845417A2E6;
	Fri, 12 Sep 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640839; cv=none; b=skXoOOjTkVN2OU+kNOYOr7qaSdWP36E8EkOeTyOVN2/Shvqk7/cDHBajDM0NgummviG0rjPPbNgsVntXMubLnHVtgAcPlZV/NppkKAC8U4BBulzUmq1hnsnPCgvVOWCf2CjBZQTCgGo/Nclu/9PE9ww0v58pO6ACN6ozuj9Pogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640839; c=relaxed/simple;
	bh=7/CUff/Ud4M09uUqqjZTOkjLKuUTqEhs9KE4Rs6jvPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nUJx3nJfc/4GivI7HUdJ7sgwi9DZcsqgKAwQdaduqK7YyjsEOSmQ5bRnDCZaEOShg6yQw8gn7V5A69VZfY9rXYlDKixAA26a8T9YNEkElltdNWVgKWHeormpPpq/2UyHpryDyT51NxchTvxlAEA0pBPnnOv35WbO05JBctF8PCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTeaXVH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A789FC4CEF0;
	Fri, 12 Sep 2025 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757640838;
	bh=7/CUff/Ud4M09uUqqjZTOkjLKuUTqEhs9KE4Rs6jvPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pTeaXVH7Fr7pr/NwWsG2owWonbXoP+uZdbLK4bSxaT5V3f0xAlov2d3z7muvPc4eH
	 UTsT6xhI1j0YsdJ6VLvrIxv53g36NuPJyWAjy6XcqxUjZcglKnmeK3MZ7OkF6weHzu
	 u9JwPg2T8hxirjk8YDGZGnxorOM3+wRU4rGTkxN89/G+xvcj4j9VfN3xpi6hnUD2Dd
	 ac7I/zNOGtQxGHD2+rQxuxfExxflDaGyrXmjoKZwnvQGFsSHKaTLyxpDcU8Oq8oT/U
	 WXhVv8KtOVvfyZ34UYY5mmfPf3IlAARuaRjmQRVcDPV7gTJ6mUXnu7TfZE/hmpjyHF
	 5hZWxY+F0Z9EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE9383BF69;
	Fri, 12 Sep 2025 01:34:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-09-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764084099.2367774.7528913497762386236.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 01:34:00 +0000
References: <20250911100854.20445-3-johannes@sipsolutions.net>
In-Reply-To: <20250911100854.20445-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 12:08:28 +0200 you wrote:
> Hi,
> 
> And a bunch of changes for -next, though that doesn't look
> like it'll be quieting down just yet.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-09-11
    https://git.kernel.org/netdev/net-next/c/d103f26a5c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



