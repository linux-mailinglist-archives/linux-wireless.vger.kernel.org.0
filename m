Return-Path: <linux-wireless+bounces-6873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B688B28F4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370B91C21CB9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADF15099C;
	Thu, 25 Apr 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBa3YIn8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1D2135A;
	Thu, 25 Apr 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072835; cv=none; b=BB7riYaiQQ3luVkYa3yIttQf9THFaIkoAIiCcY2XtpcOR6kJX+4oZ1HR46hQQhISfgMJJ1f86E2oElizA0r/f6GiIyzaubohvUKRFGFoWLYn4Mr/y/KdmYbm6WWvdrK8sjoSuGP78Y3uQibRYLXm+s/UbXyTWcnG5wT9uLzoBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072835; c=relaxed/simple;
	bh=2q5pTz4kFYErglpJfVGh6PCItSi0g4nfm3Sbz1wusfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=migrlQzFWj+QesQ+SbRasYsFSccw4ktwZd+TV8Gvsr2Ajcg5KHV3hhcSP0DWQO00dLAswVfQzTW++5LdeimtpwWg30vPN3+LvOKHbQdot5hRx2gMTyYB32qGHFwOx8SLocMvrd5YYcrcX8ovVzo/1RNIKeQ0zW+mk1ntKN8dMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBa3YIn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6284FC113CE;
	Thu, 25 Apr 2024 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072834;
	bh=2q5pTz4kFYErglpJfVGh6PCItSi0g4nfm3Sbz1wusfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBa3YIn89E5adWGMHsgwF/kCI3GEAFA3G5QEaXU2w4yLfuHcmRTKTNlrjn2H1SnEs
	 e4GT52g2P+w7YsF4CZr8ouaislXeMFi8tD5GUspNOFHh71vpzqOhkD7NnBmOF34K4l
	 FYSujpv98eWpy/Zkmwv9w7G6EUKGylPPOQ5WSM7bXSNpOSKtrYmRtq2WRIObRMqEDF
	 lwdZyUbyJjcJ75kSh2nY6W8kcDGJZhajXKclAucE68hfMbDL75p8Ytj87dxDr93spt
	 7ymoF3ZW6RgErTML9t1u74roXUFvVOfcFkgkxJUXrlX4ZsM8BFkAHi3+yY+TUosTRK
	 vlIwkLZ7G2U2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AB55C43614;
	Thu, 25 Apr 2024 19:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-04-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171407283430.11019.15272419004126265111.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 19:20:34 +0000
References: <20240424100122.217AEC113CE@smtp.kernel.org>
In-Reply-To: <20240424100122.217AEC113CE@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 10:01:21 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-04-24
    https://git.kernel.org/netdev/net-next/c/e6be197f23c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



