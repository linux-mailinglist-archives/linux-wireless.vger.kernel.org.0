Return-Path: <linux-wireless+bounces-28424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED81C22D5E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE074E1237
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AB72634;
	Fri, 31 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLBFXBVZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA37163;
	Fri, 31 Oct 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872437; cv=none; b=FMyBG2OtbSsRKtVbXpm5D3fHuIr7ybvlgXda4OtwvEJT5EmeIOFdVBNosGkY8Lt0lVWaanz5wyL1BOei+ccRvsAECTlsj8cZpebkajLQU/TFqPH3fKARu/04op3df/I0BhSUR1dUH2lN2IWZ73dkYyc8TXVU0wAs1d15YgJNWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872437; c=relaxed/simple;
	bh=JuTwcYslJbuCM6wBfnxm+jY1iYx4l6qb0nWnN3H+WlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GFWPf3r+6YSbOHd1uCaxrO2kVOzlS2qJV1wTpdPupKo0+yqYPhjYFP/FChAd2OaZo1OUzZspF0yUD1R90B5IZ/vH9sGI4ZOwmJFZZVGZ1KBJPIBt+cEPNjntMHhFDyTHfs4oNITZosIM3QJmuQcy5Am8oDfTY1ydAeUeT8419Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLBFXBVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5446C4CEFD;
	Fri, 31 Oct 2025 01:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761872436;
	bh=JuTwcYslJbuCM6wBfnxm+jY1iYx4l6qb0nWnN3H+WlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oLBFXBVZT+vU1z0Cpvl/kAYSAP12sXJOMcB8/t95QlDbI2LMK7P+MJK/R0+gv5HQW
	 fOYlz1ZKhX6qv4yRuk1tIkaNVKlUcSRCDJ8KAE/d1MUagW5kUzSDRTdtYU0IEm7xoR
	 b2Ec653BYK8EGU+GQDDLBIiaW52ElCX7UZWY/6qUI5n5VbP72aUOER7SLSRla/29h9
	 VKDYSgpR/2Ax9SMhqZeoAjwxZApQX6vGNDbX8YU3Gmx2/mjc7IlDcrM8CXmgXZef79
	 xxAIrUxXTU/S+2efc1E7Id3g/L0mdfjHTEMwHqr6nFYks71VkUXTNFeZmyBoZzd2+h
	 C1JCD/WVhiDIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D443A78A6F;
	Fri, 31 Oct 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-10-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176187241326.4094238.16220995772661247164.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 01:00:13 +0000
References: <20251030105355.13216-3-johannes@sipsolutions.net>
In-Reply-To: <20251030105355.13216-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 11:53:26 +0100 you wrote:
> Hi,
> 
> And for -next, nothing really interesting right now,
> I expect I'll get a lot more content from the drivers
> still in the future.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-10-30
    https://git.kernel.org/netdev/net-next/c/1659b441b6db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



