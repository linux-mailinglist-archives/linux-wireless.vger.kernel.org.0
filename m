Return-Path: <linux-wireless+bounces-3601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D968558DE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE570287C48
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482B17FE;
	Thu, 15 Feb 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a868M2Im"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70A1C02;
	Thu, 15 Feb 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962428; cv=none; b=fb8qjKcE9Zwdz7X2GmqMBthYr1tCfdRIxjyJ6g5LOGabb6SAqlaZ8uZInrs5TpfABa3son1ROOAzoCqTsbwkDZ6A5aZJL0WhTDnKBpAFAsO83byk+LD/h49HQAP+3kEc6wS0T0iYcZSlbuKk0/ZJHTl1nV1PCNeOxOw6AKQDjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962428; c=relaxed/simple;
	bh=RMJnR8ZenPKenrnWDBa25lav899D0NZrP4NcKIeHokg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiLaagOgiVpfqwY3irleflE4gKxI6rSH6ddcVt9g9DgpWwJgml0PyGq8sfHPce/CFZElHtmllNVAEVxk1hyvQI02Ff7pmL16AURrONvGSR2pEMcyvhTL00QPevS9QpslpoQpduvcZ8HEgJ1bAdf/MhP/9iNvqSDv3ex9OIoLZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a868M2Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 222D4C43390;
	Thu, 15 Feb 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707962428;
	bh=RMJnR8ZenPKenrnWDBa25lav899D0NZrP4NcKIeHokg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a868M2ImT98AdRcudWLAJNRnjNFM/5ZVnZaRaq575PhZIhLsxhH6aP06ICFffBUVY
	 W9KDPa769cknWLecYGEFkBU5hUkzXnjLV4pOj9mlzhbWoIi5fY91+1X1BCzOQYZ9Mo
	 hb6xcP0lXBA0tzBfxE5FfnB79/TWEPM6HMQj9Ro+PmcW0+9iVht90QP7pzWfor+wJT
	 q/qXzDAB0frtdyEKPes3uKK83nqY8D7l8gTz+y4rwf+hAwIR53oRhI9qHIeMJI/RXz
	 cqFMU7W0fJF4AzrGoKY5L78pYkyiYaZup8hBNjchx4UaF2njLRexde/PUnnkzJEWym
	 Bkp7KditAULZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08565D84BCE;
	Thu, 15 Feb 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-02-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170796242803.31402.14492891620721293.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 02:00:28 +0000
References: <20240214184326.132813-3-johannes@sipsolutions.net>
In-Reply-To: <20240214184326.132813-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 19:41:42 +0100 you wrote:
> Hi,
> 
> So this came later than I wanted, I simply forgot earlier.
> Not much to say about it, just a handful of fixes, mostly
> in iwlwifi.
> 
> As reported by Stephen earlier, this has a conflict against
> -next material, but once pulled into net I plan on pulling
> it into wireless-next to resolve that.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-02-14
    https://git.kernel.org/netdev/net/c/63a3dd6e62c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



