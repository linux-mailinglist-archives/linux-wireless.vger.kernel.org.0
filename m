Return-Path: <linux-wireless+bounces-28648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429CC38D99
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 03:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52DC54E47EF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF86224234;
	Thu,  6 Nov 2025 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuJYDjvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781061DE8BF;
	Thu,  6 Nov 2025 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395679; cv=none; b=aepecTZ3o+Ftxx9aOVoL3QJyjJ5fx7TtYnrJ0VKtzEu3nSMjHBsHfkER80Hf9zT6g3TVHnP/WSjw6qa6mmuoqgxO+mkIsONdrvmWcJ9LCpFlIkn+OoGD9K9NwcVMbHbQ4Ddm2v6pkVrryemPbNfjnmf+ImAZbjL3Mu0GNPBIWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395679; c=relaxed/simple;
	bh=4uaLy9RCWxllw4thiPZjA0It3BNE0h5qniqxb3hpyXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L25NqoZz9Fz+136T2eHAWb333kiE6+4sReMM7tiI5X4XuZjFhNTQ5gFqtHB7aK9GIGKkscefUx+NcS2HD2ADQNQm9q6qaK7CrJCHnlyi1QUYW/KTUT1M5cFvqFLhzLg++bVCCvvRrg4iHU6rk1LwHPP421GA6PinlGb+uuW2sSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuJYDjvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C98C4CEF5;
	Thu,  6 Nov 2025 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395679;
	bh=4uaLy9RCWxllw4thiPZjA0It3BNE0h5qniqxb3hpyXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UuJYDjvPM89N92LD9MsVMJH3WTndKbqxpGg79YlMwrt1DcdJIJ/097Ou9jSjR9Uxl
	 xp88jF+klbp+7deXP3Avavb+rKJAEvPtT1W7DtqSisHth7EjQ1tvRbyty58LEKEA/V
	 XNw3217OVhPC71h4TC/70+hrmwbSEt/HW88ZwrSDvtCF0uHbbnfrh/AwdPgRQ396jt
	 XpAvscD5opKW0MydJq/o/PgKXwxEM+CQk9jt1Dq5/lUqnSJI8d4/skIHq9N+pcGdcJ
	 F4HkLrkeXqBfUPxkKh8tI/Vl91Y3WSvRNzpZSTs32xFSR/E8n1v/Ix5irW/GvN/YbT
	 HSYszilIA1gvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B3C380AAF9;
	Thu,  6 Nov 2025 02:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-11-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239565225.3838891.6822561815529214615.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:20:52 +0000
References: <20251105153537.54096-38-johannes@sipsolutions.net>
In-Reply-To: <20251105153537.54096-38-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 16:34:33 +0100 you wrote:
> Hi,
> 
> So more driver updates are trickling in now, with Intel
> and Atheros this time. I have a whole new NXP driver that
> isn't in here yet, but is quite likely good enough for
> next week. We'll see. :)
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-11-05
    https://git.kernel.org/netdev/net-next/c/9b73cdad5889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



