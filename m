Return-Path: <linux-wireless+bounces-27447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F5B8240E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25CE2A74AC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61813126BD;
	Wed, 17 Sep 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHL1GaOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE423311C3F;
	Wed, 17 Sep 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151218; cv=none; b=kdn+Lj1G2h+Y+6KSVRAC2x13E9JRYYur/2eGIvSx4D2p3yz9NF/Z9UOeUtR4G5Iq4VjeoJgXQpNwa8jYwyn7rQgAUN10reDBA+Xu7yrXAXEhYa9RjP6iQ8z8MDor8kmo5x2pAMrSutE3/BqfcDKOsPcWH4PNFfbFqKcJUY0atvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151218; c=relaxed/simple;
	bh=kTPX/Qit8A+yHPzAeCP7/dSvgGXt6RhfncIwKmJTJOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7bQz0hm1Rr14XB5b7m6lAEzbM4hnLef3HDeT7xmg9rLANTvjlZrzq++bDHqMYPbjFOn0JitjCzjEL7w2yhdsSu3NpqwIs7wfmzHfaeLBqbe95+E7apRGUacF+ycGDBL3SBv9T5XXvEBdg2643rn75L3LezhKunqRJRAB0LdnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHL1GaOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D63C4CEF9;
	Wed, 17 Sep 2025 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758151218;
	bh=kTPX/Qit8A+yHPzAeCP7/dSvgGXt6RhfncIwKmJTJOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uHL1GaOa3+9fpOT3tebzMEMWury6tEgQr0OjXE+703N1fCK0e02dN9xAD9mCJDo12
	 VwtGvRUTO30x/f4rfo+UbUoR5okV/FxnILYIwo2rDKXYF/TxrBpelEA8wd6Hcl49A9
	 njsZsN5ip3JXYYzDY2b/68yI7+dMenTGIKAeop91OTwJ/fNqEqvpgeitfqwRQi7cTK
	 eqDLgT4tGbMM1LJQeRq3ocwHV/6ubLStZHISBD13nOJ+s6k+STvBSY+WYhIDvh+D3L
	 iOfdtm80BBG5tPnMkZ5hpxM3dnGFKNXS34xS7ScqXpqn75KHo7juAMijJ4xSIINuv6
	 BV2Ot/9NI9yTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06039D0C28;
	Wed, 17 Sep 2025 23:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-09-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815121874.2184180.8748956295385324183.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 23:20:18 +0000
References: <20250917105159.161583-3-johannes@sipsolutions.net>
In-Reply-To: <20250917105159.161583-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 12:49:50 +0200 you wrote:
> Hi,
> 
> Two more fixes, but I think things have quieted down to say
> we probably won't have more. The iwlwifi aggregation thing
> is myself having messed up some recent changes, while rfkill
> has a potential crash that doesn't really seem to happen in
> practice, or only on some select machines.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-09-17
    https://git.kernel.org/netdev/net/c/934da21f99c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



