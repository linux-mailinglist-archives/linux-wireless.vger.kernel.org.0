Return-Path: <linux-wireless+bounces-24493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC9AE8B9F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA636164D71
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BA2D23B7;
	Wed, 25 Jun 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhhumEUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D53074AC;
	Wed, 25 Jun 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873181; cv=none; b=BCkAbvwAwdKqD5AfO+ku6j2VrTK8SIUxQaZMxdhzcNMtR/audxIMji8VapQU1Iwyc3aE6ZEnnwP3wSZKAQh4uvHccm/mu1xk50ZVhyK81RfG5ILyG1/MnsLtmjO9q9nBpntS4DAzc+Mi8FwqtCycKIIBeRDspMUIVHxY7qwNcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873181; c=relaxed/simple;
	bh=JNMbXga8Rrb5Rr/mYT4SQYXU4zQShgwN/u3Z3gunw4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MH/V7loIF9v4kBoBWhk1LVpPBCfcQpEIagQLBpKqDkh1lK5iYK91WxxTLUBBIJlhiGgKduhI7FBcuZ5ivkicit3XiZyXZCA1g+0O9MVnmfQTkOj2JTF9Y1INpSGVY7vLHp752h/jbpCZALluo6m42KWF69X9AALakx1CduiKt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhhumEUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA18FC4CEEA;
	Wed, 25 Jun 2025 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873180;
	bh=JNMbXga8Rrb5Rr/mYT4SQYXU4zQShgwN/u3Z3gunw4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZhhumEUBSWnR6OLAYjoYSr4kYaw4X0DWE5t24z01lqeS7A6hOHM3wc3h6agQuQ0V1
	 Y8Y+D1sf7qSWqsTTrDC6/2x7GXRoPhuVowAOaEaU6H3v+Nz4QNy3qg9W0f8Y3Lt9NM
	 wKXGRXEnxhi0FZn1xhuTmieWvH396MpodwkgagJ7hgWxCA5gH31O0Kq8ysZm5yBZqm
	 QqKw8WDwT1QvFGuxYeTAcH0JHMwwWvsJiPoRO1JuXNeK8FToIR0+I0i+7QSYCza4lG
	 ZGkOI48C/R8C5jOFA5/wyuhzvrgGNDol8vNRTolTBc02VYJCVljNvXqNQzCq+a1eOT
	 ArMWZryImDflw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F183A40FCB;
	Wed, 25 Jun 2025 17:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-06-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175087320725.562505.11169085385489787142.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 17:40:07 +0000
References: <20250625115433.41381-3-johannes@sipsolutions.net>
In-Reply-To: <20250625115433.41381-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 13:54:08 +0200 you wrote:
> Hi,
> 
> Just a handful of new fixes, nothing stands out. No known
> conflicts either.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-06-25
    https://git.kernel.org/netdev/net/c/010c40c1f50e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



