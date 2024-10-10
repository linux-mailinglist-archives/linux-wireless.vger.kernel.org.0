Return-Path: <linux-wireless+bounces-13861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBA998DA5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AEC1F24C99
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156219994D;
	Thu, 10 Oct 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPtWkw73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147427468;
	Thu, 10 Oct 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578424; cv=none; b=cb53519xbpPo/mtuxi9C6c0E9tc7qCL8U8o38pxt5HnuoeB3jEpF6aOsuRoGbB5ooUlLImWZfjJC1j66NNFwym/4uh1e+4C9Wy7vjszkLghVyfoCjOxgFWEdEIRGlnY+YLm5I8u8a+VS7J5nwKwqtKKSGiDHFOlqNR4NVyrYux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578424; c=relaxed/simple;
	bh=2tnUvN8WVDyeeze4eTyLGRFX9dex7o4pDaAp2PrX1Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UFyDqwMFfoE8y4y5bp/uLqb7gcgqJI1+hq4ugIhpknEg2Umb/kDFSa4qPhGoMsuC6WXECiBXwTzqqDuKPC1Oj1M25Xuom7/acDWXabOtx+xwI2cmWfhD7KhWd7sCZC7YuJOZWWyyFLGmNbTHQ2h5g7XUHDX561Q+nYaRTUkv02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPtWkw73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136DEC4CEC5;
	Thu, 10 Oct 2024 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728578424;
	bh=2tnUvN8WVDyeeze4eTyLGRFX9dex7o4pDaAp2PrX1Og=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RPtWkw73AptWbERtk3a4uzI9ksK5gusm2D0X6sJXrfqG05S7mz3/GgRPeY76PnCcA
	 6hRSfujYfsaRU/Y4fkicTfM/0KMZjRTOcRmvoybPo4RuUy9aLkXEBrubYby3jU6fFI
	 bOZyJMcYGsRnci7pBu/svwPpRjfWDnWiB8VVZbSY33ewVkzOqsOookiPoNARkppBbg
	 RPwIzyjOWZp9XehZ1ApxFWon2UtFmquYUFYM3AnLAUL67/IXNkBup3BCQxKb/rBPvi
	 Y3AcJnQYj+TiSBlZA9HNPhrYWpzoTrUIZjoyDEUh9bpcu5SKQ81WB+D/Syfr5+UOCJ
	 /3AFUxyCBELew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6E3803263;
	Thu, 10 Oct 2024 16:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] MAINTAINERS: Networking file coverage updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857842850.2091174.8907404119655762226.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:40:28 +0000
References: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
In-Reply-To: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, johannes@sipsolutions.net,
 willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Oct 2024 09:47:21 +0100 you wrote:
> Hi,
> 
> The aim of this proposal is to make the handling of some files,
> related to Networking and Wireless, more consistently. It does so by:
> 
> 1. Adding some more headers to the UDP section, making it consistent
>    with the TCP section.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] MAINTAINERS: consistently exclude wireless files from NETWORKING [GENERAL]
    https://git.kernel.org/netdev/net/c/9937aae39bc0
  - [net,v2,2/2] MAINTAINERS: Add headers and mailing list to UDP section
    https://git.kernel.org/netdev/net/c/5404b5a2fea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



