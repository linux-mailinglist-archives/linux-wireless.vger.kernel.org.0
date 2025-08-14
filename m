Return-Path: <linux-wireless+bounces-26380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B2B25827
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 02:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29671627994
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 00:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1362FF677;
	Thu, 14 Aug 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5HAAYov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4E10942;
	Thu, 14 Aug 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130798; cv=none; b=FabGPrsvJVVZRNtQ1z2xJlPXzCgWSZK0n++7T+kXws3Xpyxtyj63FZoaF4yL539Si+pGr8ukj1R9HkR2w1ePmW7qwvoy8R7zv/jDPV0JftHr2NE3xD9nMe2YMUTgGqB1dwGanuhiH6HmHOjuawpFD/pAGF0dC2g91rgdRVSx7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130798; c=relaxed/simple;
	bh=XlgbVwqe2+GOBt7YjOqXv6d9ctUJHhlZNtOmAaTwDmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fzsYaEzYvdR6Ct4hEZkAz5VML30kYn/ZBwzt/iFw/30ctCcDedk/WOXx/vF650BtHh+FMAgMcnRTM3d6TfOR2d/CgPEDMwrj81LZYKlCDL6DloBVarl8eU6hFaXgw0a7dUNxvq2C+Na7ERNJ8C3BXga1bUu20lv8r6ZY+iZ2r5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5HAAYov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA00C4CEEB;
	Thu, 14 Aug 2025 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130797;
	bh=XlgbVwqe2+GOBt7YjOqXv6d9ctUJHhlZNtOmAaTwDmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5HAAYovUWusXo1hOgiCsBQeqGsUFfV6hPix2r1mzHJAwfnm9n88zACZAPkcBGZwD
	 Mu0rC5NUWBbAMq5Hs/j/ZS33pcphkIOFxOUPGTBS4UOcWkkYXRsvhUMgAeAMdljYjx
	 vdf1xwWBJHT7/QKKK/xJVpMfGxH7n5CBGC7rxFNmlsRFIilM4CLliG4MNLOvY782RV
	 1IqiW1rCQ7319rurJzCbloxfBoPTrW+x0PMSY2Kvb9rV9HL2XGs/spYE2MZVPZ6Fvv
	 gnxdoJ08sLzu4y/SGdnqb95avIi3YKJ/fWnwGfe3A6to4benhBTDpOSuvAieovq+Xh
	 3E4ZwuKmz9TXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC039D0C37;
	Thu, 14 Aug 2025 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: mediatek: wed: Introduce MT7992 WED
 support to MT7988 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513080934.3827563.118467177001717184.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:20:09 +0000
References: <20250812-mt7992-wed-support-v3-1-9ada78a819a4@kernel.org>
In-Reply-To: <20250812-mt7992-wed-support-v3-1-9ada78a819a4@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-wireless@vger.kernel.org, rex.lu@mediatek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 06:57:23 +0200 you wrote:
> Introduce the second WDMA RX ring in WED driver for MT7988 SoC since the
> Mediatek MT7992 WiFi chipset supports two separated WDMA rings.
> Add missing MT7988 configurations to properly support WED for MT7992 in
> MT76 driver.
> 
> Co-developed-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: mediatek: wed: Introduce MT7992 WED support to MT7988 SoC
    https://git.kernel.org/netdev/net-next/c/96326447d466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



